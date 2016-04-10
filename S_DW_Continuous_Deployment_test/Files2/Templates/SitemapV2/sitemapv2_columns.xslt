<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"  encoding="utf-8" />

	<xsl:template match="/">
		<textarea>
			<xsl:copy-of select="/" />
		</textarea>		
	</xsl:template>

</xsl:stylesheet>