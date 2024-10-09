<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xs"
	expand-text="false"
	version="3.0">
	
	
	<xsl:template match="c:directory | c:file">
		<xsl:copy>
			<xsl:attribute name="path" select="string-join(ancestor-or-self::*/@xml:base, '')" />
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:include href="identity.xsl" />
	
</xsl:stylesheet>