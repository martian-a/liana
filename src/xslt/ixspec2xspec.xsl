<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:x="http://www.jenitennison.com/xslt/xspec"
	xmlns:xym="http://xylarium.org/ns/ixml/xspec"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xs"
	expand-text="true"
	version="3.0">
	
	<xsl:namespace-alias stylesheet-prefix="xym" result-prefix="x"/>
	
	<xsl:template match="xym:*">
		<xsl:element name="{name()}" namespace="http://www.jenitennison.com/xslt/xspec">
			<xsl:apply-templates select="attribute()" />
			<xsl:apply-templates />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="/*/@grammar" priority="10">
		<xsl:attribute name="stylesheet" select="'http://xylarium.org/ns/xml/util/identity.xsl'" />
		<xsl:next-match />
	</xsl:template>
	
	<xsl:template match="document-node() | attribute() | comment() | processing-instruction() | text()">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	
	
</xsl:stylesheet>