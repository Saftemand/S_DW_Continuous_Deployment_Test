<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
<xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<textarea>
			<xsl:copy-of select="/" />
		</textarea>
	</xsl:template>

</xsl:stylesheet>