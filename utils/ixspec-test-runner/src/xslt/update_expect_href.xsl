<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:x="http://www.jenitennison.com/xslt/xspec"
	xmlns:xym="http://xylarium.org/ns/ixml/xspec"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xs"
	expand-text="true"
	version="3.0">
	
	<xsl:param name="new-expect-href" required="true" />
	
	<xsl:template match="x:expect/@href">
		<xsl:attribute name="{name()}" select="$new-expect-href" />
	</xsl:template>
	
	
	<xsl:include href="identity.xsl" />
	
	
</xsl:stylesheet>