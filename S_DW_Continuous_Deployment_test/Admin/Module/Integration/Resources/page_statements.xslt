<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<xsl:apply-templates select="/ExportResponse/Page" />
	</xsl:template>

	<xsl:template match="Page">

		<xsl:variable name = "pageID">
			<xsl:value-of select="@PageID"/>
		</xsl:variable>

		<xsl:variable name = "parentPageID">
			<xsl:choose>
				<xsl:when test="../@PageID">
					<xsl:value-of select="../@PageID"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise> 
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name = "pageDescription">
			<xsl:call-template name="replace-string">
				<xsl:with-param name="text"><xsl:value-of select="MetaTags/Description"/></xsl:with-param>
					<xsl:with-param name="from">'</xsl:with-param>
				<xsl:with-param name="to">''</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name = "pageKeywords">
			<xsl:call-template name="replace-string">
				<xsl:with-param name="text"><xsl:value-of select="MetaTags/Keywords"/></xsl:with-param>
					<xsl:with-param name="from">'</xsl:with-param>
				<xsl:with-param name="to">''</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
				
		<xsl:variable name = "InsertStatement">
			INSERT INTO [Page]
			(
				PageParentPageID,
				PageMenuText,
				PageActiveFrom,
				PageActiveTo,
				PageDescription,
				PageKeywords,
				PageShowInLegend,
				PageCacheMode,
				PageCacheFrequence,
				PageAreaID,
				PageShowTopImage,
				PageActive
			)
			VALUES
			(
				<xsl:value-of select = "$parentPageID" />,
				'<xsl:value-of select="PageName"/>',
				'<xsl:value-of select="PublishDate"/>',
				'<xsl:value-of select="ExpiryDate"/>',
				'<xsl:value-of select = "$pageDescription" />',
				'<xsl:value-of select = "$pageKeywords" />',
				'<xsl:value-of select="ShowInNavigation"/>',
				'<xsl:value-of select="CacheSetting"/>',
				'<xsl:value-of select="CacheExpiry"/>',
				'<xsl:value-of select="@AreaID"/>',
				1,
				1
			);
			SET <xsl:value-of select="$pageID"/> = @@IDENTITY
		</xsl:variable>

		<xsl:variable name = "UpdateStatement">
			UPDATE [Page] SET
				PageActiveFrom = '<xsl:value-of select="PublishDate"/>',
				PageActiveTo = '<xsl:value-of select="ExpiryDate"/>',
				PageDescription = '<xsl:value-of select = "$pageDescription" />',
				PageKeywords = '<xsl:value-of select = "$pageKeywords" />',
				PageShowInLegend = '<xsl:value-of select="ShowInNavigation"/>',
				PageCacheMode = '<xsl:value-of select="CacheSetting"/>',
				PageCacheFrequence = '<xsl:value-of select="CacheExpiry"/>'
				WHERE PageID = <xsl:value-of select="$pageID"/>;
			DELETE FROM [MetaData] WHERE MetadataPageID = <xsl:value-of select="$pageID"/>;
			DELETE FROM [Paragraph] WHERE ParagraphPageID = <xsl:value-of select="$pageID"/>;
		</xsl:variable>

		DECLARE <xsl:value-of select="$pageID"/> INT

		<xsl:choose>
			<xsl:when test = "//@UpdateExistingPages = 'true'">
				SELECT <xsl:value-of select="$pageID"/> = PageID FROM [Page] WHERE 
					PageMenuText = '<xsl:value-of select="PageName"/>' AND PageParentPageID = <xsl:value-of select = "$parentPageID" />;
				IF <xsl:value-of select="$pageID"/> IS NULL
					BEGIN
						<xsl:value-of select = "$InsertStatement" />
					END
				ELSE
					BEGIN
						<xsl:value-of select = "$UpdateStatement" />
					END
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select = "$InsertStatement" />
			</xsl:otherwise>
		</xsl:choose>
    
		<xsl:for-each select = "MetaTags/AdditionalMetaTag">
      <xsl:variable name = "metaContent">
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text">
            <xsl:value-of select="Content"/>
          </xsl:with-param>
          <xsl:with-param name="from">'</xsl:with-param>
          <xsl:with-param name="to">''</xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
			IF NOT EXISTS(SELECT FieldName FROM MetadataField WHERE FieldName = '<xsl:value-of select="Value"/>')
				BEGIN
					INSERT [MetaDataField] (FieldTypeID, FieldName) VALUES (1, '<xsl:value-of select="Value"/>');
					INSERT [MetaData] (MetadataPageID, MetadataFieldID, MetadataOption) 
						VALUES(<xsl:value-of select="$pageID"/>, @@IDENTITY, '<xsl:value-of select="$metaContent"/>');
				END
			ELSE
				BEGIN
					INSERT [MetaData] (MetadataPageID, MetadataFieldID, MetadataOption)
						SELECT <xsl:value-of select="$pageID"/>, 
							FieldID,  
							'<xsl:value-of select="$metaContent"/>'
              FROM MetadataField WHERE FieldName = '<xsl:value-of select="Value"/>'
				END
		</xsl:for-each>

		<xsl:for-each select = "Paragraph">
			INSERT [Paragraph] 
			(
				ParagraphPageID,
				ParagraphHeader,
				ParagraphText,
				ParagraphTemplateID,
				ParagraphShowParagraph
			)
			VALUES
			(
				<xsl:value-of select="$pageID"/>,
				'<xsl:value-of select="ParagraphTitle"/>',
				'<xsl:call-template name="replace-string">
					<xsl:with-param name="text">
						<xsl:value-of select="Area/HTML/HTMLData"/>
					</xsl:with-param>
					<xsl:with-param name="from">'</xsl:with-param>
					<xsl:with-param name="to">''</xsl:with-param>
				</xsl:call-template>',
				'<xsl:value-of select="@TemplateID"/>',
				1
			);
		</xsl:for-each>
		
		<xsl:apply-templates select="Page" />

	</xsl:template>

	<xsl:template name="replace-string">
		<xsl:param name="text"/>
		<xsl:param name="from"/>
		<xsl:param name="to"/>
		<xsl:choose>
			<xsl:when test="contains($text, $from)">
				<xsl:variable name="before" select="substring-before($text, $from)"/>
				<xsl:variable name="after" select="substring-after($text, $from)"/>
				<xsl:variable name="prefix" select="concat($before, $to)"/>
				<xsl:value-of select="$before" disable-output-escaping="yes"/>
				<xsl:value-of select="$to" />
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text" select="$after"/>
					<xsl:with-param name="from" select="$from"/>
					<xsl:with-param name="to" select="$to"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text" disable-output-escaping="yes"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
  
</xsl:stylesheet>
