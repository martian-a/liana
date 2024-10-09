<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:x="http://www.jenitennison.com/xslt/xspec"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xym="http://xylarium.org/ns/ixml/xspec"
	exclude-result-prefixes="#all"
	expand-text="true"
	version="3.0">
	
	<xsl:param name="base-uri" select="static-base-uri()" />
	<xsl:param name="tests-dir" select="'../../../../lib/ixml/tests'" />
	<xsl:param name="output-dir" select="'../../../../test/ixml/generated'" />

	<xsl:variable name="test-dir" select="resolve-uri(/c:directory/@path, resolve-uri($tests-dir, $base-uri))" as="xs:anyURI?" />
	
	<xsl:output indent="true" />
	
	<xsl:template match="scenario">
		<xsl:choose>
			<xsl:when test="grammar and context and expect">	
				<xsl:variable name="href" select="replace(concat(resolve-uri($output-dir, $base-uri), '/', @label, '.ixspec'), '/+', '/') ! xs:anyURI(.)" as="xs:anyURI" />
				<ixspec href="{$href}">
					<xym:description grammar="{$test-dir}{grammar/@name}">
						<x:scenario>
							<xsl:apply-templates select="attribute(), context, expect" />
						</x:scenario>
					</xym:description>
				</ixspec>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="context">
		<x:context href="{$test-dir}{@name}" />
	</xsl:template>
	
	<xsl:template match="expect">
		<x:expect label="Same as {@name}" href="{$test-dir}{@name}" select="/*" />
	</xsl:template>
	
	
	<xsl:template match="attribute() | node()">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>