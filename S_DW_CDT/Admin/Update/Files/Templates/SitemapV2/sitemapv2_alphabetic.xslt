<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

  <!--
  Description: ul/li based navigation. No features from admin implemented.
  Recommended settings:
  Fold out: True or False
  Upper menu: Dynamic or Static
  First level: > 0
  Last level: >= First level
  -->
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"  encoding="utf-8" />
  <xsl:param name="html-content-type" />

    <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ†Ã˜Ã…'" />
    <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyzÃ¦Ã¸Ã¥'" />

  <xsl:key name="pages-by-initial" match="Page" use="substring(@MenuText, 1, 1)" />
  <xsl:template match="/NavigationTree">

    <xsl:apply-templates select="//Page[count(. | key('pages-by-initial', translate(substring(@MenuText, 1, 1), $lower, $upper))[1]) = 1]" mode="group">
        <xsl:sort select="@MenuText" data-type="text" />
      </xsl:apply-templates>

  </xsl:template>

  <xsl:template match="Page" mode="group">
    <xsl:variable name="startletter" select="translate(substring(@MenuText, 1, 1), $lower, $upper)" />
    <h2>
      <xsl:value-of select="$startletter" />
    </h2>
    <ul>
      <xsl:apply-templates select="key('pages-by-initial', translate($startletter, $upper, $lower)) | key('pages-by-initial', $startletter)" mode="item">
        <xsl:sort select="@MenuText" data-type="text" order="ascending" />
      </xsl:apply-templates>
    </ul>
  </xsl:template>

  <xsl:template match="Page" mode="item">
    <li>
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@FriendlyHref" disable-output-escaping="yes"/>
            </xsl:attribute>
            <xsl:value-of select="@MenuText" disable-output-escaping="yes"/>
        </a>
    </li>
  </xsl:template>
  
</xsl:stylesheet>