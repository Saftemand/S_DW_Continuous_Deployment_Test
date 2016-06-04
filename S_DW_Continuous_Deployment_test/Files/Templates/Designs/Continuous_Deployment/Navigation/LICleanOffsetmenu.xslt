<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"  encoding="utf-8" />
	<xsl:param name="html-content-type" />
	<xsl:template match="/NavigationTree">

		<xsl:if test="count(//Page) > 0">
			<ul class="nav nav-pills nav-stacked">
				<xsl:if test="a[.!='']">
			  		<li class="nav-header">
					    <a>
					      	<xsl:attribute name="href">
							<xsl:value-of select="@FriendlyHref" disable-output-escaping="yes"/>
					     	</xsl:attribute>
					     	<xsl:value-of select="@MenuText" disable-output-escaping="yes"/>
					     </a>
					</li>
				</xsl:if>
				<li class="nav-line">
					<hr class="nav-line-hr"></hr>
				</li>

				<xsl:apply-templates select="Page">
					<xsl:with-param name="depth" select="1"/>
				</xsl:apply-templates>
			</ul>
		</xsl:if>

	</xsl:template>

	<xsl:template match="//Page">
		<xsl:param name="depth"/>
		<li>
			<xsl:attribute name="class">
				offcanvas-menubtn
			</xsl:attribute>
			<a>
				<xsl:attribute name="href">
				<xsl:value-of select="@FriendlyHref" disable-output-escaping="yes"/>
		      	</xsl:attribute>
		      	<xsl:value-of select="@MenuText" disable-output-escaping="yes"/>
			</a>
			<xsl:if test="count(Page) and /NavigationTree/Settings/LayoutNavigationSettings/@endlevel > @RelativeLevel">
				<ul class="nav nav-stacked M{@AbsoluteLevel}">
					<xsl:apply-templates select="Page">
						<xsl:with-param name="depth" select="$depth+1"/>
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</li>
	</xsl:template>

</xsl:stylesheet>