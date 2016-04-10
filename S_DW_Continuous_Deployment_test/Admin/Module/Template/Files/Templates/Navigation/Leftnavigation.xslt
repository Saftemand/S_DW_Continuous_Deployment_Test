<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"  encoding="utf-8" />
  <xsl:param name="html-content-type" />
  <xsl:template match="/NavigationTree">
    <style type="text/css">
      ul.M0, ul.M2, ul.M3 {
      margin-left:0px;
      }

      li.l2,li.l3,li.l4,li.l2_Active,li.l3_Active,li.l4_Active {
      list-style: none outside;
      margin-left:15px;
      }

      li.l1,li.l1_Active {
      list-style: none outside;
      margin-left:0px;
      display: block;
      }

      li.l1 a.l1, li.l1_Active a.l1_Active, ul.M1{
      margin-left:0px;
      }

      .nimg{
      display: block;
      }

    </style>
    <ul class="M0">
      <xsl:apply-templates select="Page">
        <xsl:with-param name="depth" select="1"/>
      </xsl:apply-templates>
    </ul>

  </xsl:template>

  <xsl:template match="Page">
    <xsl:param name="depth"/>
    <xsl:variable name="AbsoluteDepth" select="@AbsoluteLevel"/>
    <li class="{@class}">
      <xsl:variable name="NavigationImage" select="/NavigationTree/Settings/Setting[@Level=$AbsoluteDepth]/NavigationImage/@Value"/>
      <xsl:variable name="NavigationMouseoverImage" select="/NavigationTree/Settings/Setting[@Level=$AbsoluteDepth]/NavigationMouseoverImage/@Value"/>
      <xsl:variable name="NavigationActiveImage" select="/NavigationTree/Settings/Setting[@Level=$AbsoluteDepth]/NavigationActiveImage/@Value"/>

      <!--Needs implementing-->
      <!--<xsl:value-of select="@Image"/>-->
      <!--<xsl:value-of select="@ImageActive"/>-->
      <!--<xsl:value-of select="@ImageMouseOver"/>-->


<!--<a href="Default.aspx?ID={@ID}" class="{@class}">-->
      <a class="{@class}">
        <xsl:if test="@Allowclick='True'">
          <!--<xsl:attribute name="href">Default.aspx?ID=<xsl:value-of select="@ID"/></xsl:attribute>-->
          <!--<xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>-->
          <xsl:attribute name="href"><xsl:value-of select="@FriendlyHref" disable-output-escaping="yes"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="$NavigationImage!=''">
          <xsl:if test="$NavigationMouseoverImage!=''">
          <xsl:attribute name="onmouseover">CP(<xsl:value-of select="@ID"/>, <xsl:value-of select="@AbsoluteLevel"/>);</xsl:attribute>
          <xsl:attribute name="onmouseout">CP2(<xsl:value-of select="@ID"/>, <xsl:value-of select="@AbsoluteLevel"/>);</xsl:attribute>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="$NavigationActiveImage!='' and @InPath='True'"><img src="{$NavigationActiveImage}" name="img{@ID}" border="0" alt="" align="absmiddle" /></xsl:when>
            <xsl:when test="$NavigationImage!=''"><img src="{$NavigationImage}" name="img{@ID}" border="0" alt="" align="absmiddle" /></xsl:when>
          </xsl:choose>
        </xsl:if>
        <xsl:value-of select="@MenuText" disable-output-escaping="yes"/>
      </a>

      <xsl:if test="@InPath='True' and count(Page) > 0">
        <xsl:variable name="NavigationDividerImage" select="/NavigationTree/Settings/Setting[@Level=$AbsoluteDepth]/NavigationDividerImage/@Value"/>
        <xsl:if test="$NavigationDividerImage!=''">
          <img src="{$NavigationDividerImage}" alt="" class="nimg"/>
        </xsl:if>
        <xsl:variable name="NavigationSpace" select="/NavigationTree/Settings/Setting[@Level=$AbsoluteDepth]/NavigationSpace/@Value"/>
        <xsl:if test="$NavigationSpace!=''">
          <img src="x.gif" width="0" height="{$NavigationSpace}" alt="" class="nimg"/>
        </xsl:if>
      </xsl:if>

      <!--<xsl:if test="@ChildCount>0">-->
      <xsl:if test="@InPath='True'">
        <xsl:if test="count(Page)">
          <ul class="M{@AbsoluteLevel}">
          <xsl:apply-templates select="Page">
            <xsl:with-param name="depth" select="$depth+1"/>
          </xsl:apply-templates>
        </ul>
        </xsl:if>
      </xsl:if>

      <xsl:variable name="NavigationDividerImage" select="/NavigationTree/Settings/Setting[@Level=$AbsoluteDepth]/NavigationDividerImage/@Value"/>
      <xsl:if test="$NavigationDividerImage!=''">
        <img src="{$NavigationDividerImage}" alt="" class="nimg"/>
      </xsl:if>
      <xsl:variable name="NavigationSpace" select="/NavigationTree/Settings/Setting[@Level=$AbsoluteDepth]/NavigationSpace/@Value"/>
      <xsl:if test="$NavigationSpace!=''">
        <img src="x.gif" width="0" height="{$NavigationSpace}" alt="" class="nimg"/>
      </xsl:if>

    </li>
  </xsl:template>


</xsl:stylesheet>