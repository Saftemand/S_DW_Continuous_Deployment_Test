<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="//Group">

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
	      <ParentGroupID>
	        <xsl:value-of select="Groups/GroupID"/>
	      </ParentGroupID>
        <GroupSmallImage>
          <xsl:value-of select="GroupSmallImage"/>
        </GroupSmallImage>
        <GroupLargeImage>
          <xsl:value-of select="GroupLargeImage"/>
        </GroupLargeImage>
        <GroupDescription>
          <xsl:value-of select="GroupDescription"/>
        </GroupDescription>
        <GroupIcon>
          <xsl:value-of select="GroupIcon"/>
        </GroupIcon>
      </Group>

  </xsl:template>
	
</xsl:stylesheet>
