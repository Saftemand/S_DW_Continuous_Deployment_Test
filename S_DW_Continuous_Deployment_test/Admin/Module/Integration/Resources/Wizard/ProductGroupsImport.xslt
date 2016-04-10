<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="//Group">

    <Groups>
      <Group>
        <GroupID>
          <xsl:value-of select="GroupID"/>
        </GroupID>
        <GroupLanguageID>
          <xsl:value-of select="GroupLanguageID"/>
        </GroupLanguageID>
        <GroupName>
          <xsl:value-of select="GroupName"/>
        </GroupName>
        <GroupNumber>
          <xsl:value-of select="GroupNumber"/>
        </GroupNumber>
        <GroupSmallImage>
          <xsl:value-of select="GroupSmallImage"/>
        </GroupSmallImage>
        <GroupLargeImage>
          <xsl:value-of select="GroupLargeImage"/>
        </GroupLargeImage>
        <GroupDescription>
          <xsl:value-of select="GroupDescription"/>
        </GroupDescription>
        <GroupAssortment />
        <GroupIcon>
          <xsl:value-of select="GroupIcon"/>
        </GroupIcon>
        <xsl:if test="ParentGroupID != ''">
          <Groups>
            <GroupID>
              <xsl:value-of select="ParentGroupID"/>
            </GroupID>
          </Groups>
        </xsl:if>
      </Group>
    </Groups>

  </xsl:template>
	
</xsl:stylesheet>
