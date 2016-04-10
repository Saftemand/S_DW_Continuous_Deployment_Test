<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="//Group">

    <Groups>
      <Group>
        <GroupID>
          <xsl:value-of select="ProductGroupID"/>
        </GroupID>
        <GroupLanguageID />
        <GroupName>
          <xsl:value-of select="ProductGroupName"/>
        </GroupName>
        <GroupNumber>
          <xsl:value-of select="ProductGroupID"/>
        </GroupNumber>
        <GroupSmallImage />
        <GroupLargeImage />
        <GroupDescription />
        <GroupAssortment />
        <GroupIcon />
      </Group>
    </Groups>

  </xsl:template>
	
</xsl:stylesheet>
