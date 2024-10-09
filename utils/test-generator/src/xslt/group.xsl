<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:fn="http://xylarium.org/ns/xslt/functions" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xs fn"
	expand-text="true"
	version="3.0">
	
	<xsl:output indent="true" />
	
	
	<xsl:template match="/c:directory">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), c:directory" />
			<xsl:for-each-group select="c:file" group-by="fn:remove-numeric-suffix(fn:remove-file-extensions(@name))">
				<xsl:choose>
					<xsl:when test="not(current-group()[ends-with(@name, '.ixml')])">
						<xsl:apply-templates select="current-group()" />
					</xsl:when>
					<xsl:when test="count(current-group()[ends-with(@name, '.ixml')]) > 1">
						<scenario label="{current-grouping-key()}">
							<xsl:for-each-group select="current-group()" group-by="fn:remove-file-extensions(@name)">
								<scenario label="{current-grouping-key()}">
									<xsl:apply-templates select="current-group()" />
								</scenario>
							</xsl:for-each-group>
						</scenario>
					</xsl:when>
					<xsl:otherwise>
						<scenario label="{current-grouping-key()}">
							<xsl:apply-templates select="current-group()" />
						</scenario>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each-group>
		</xsl:copy>
	</xsl:template>
	

	
	<xsl:template match="c:file">
		<xsl:variable name="role" as="xs:string?">
			<xsl:choose>
				<xsl:when test="ends-with(@name, '.ixml')">grammar</xsl:when>
				<xsl:when test="ends-with(@name, '.output.xml')">expect</xsl:when>
				<xsl:when test="ends-with(@name, '.inp')">context</xsl:when>
				<xsl:otherwise>unknown</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:element name="{$role}">
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template match="attribute() | node()">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
	
	<xsl:function name="fn:remove-file-extensions" as="xs:string?">
		<xsl:param name="filename" as="xs:string?" />
		
		<xsl:value-of select="tokenize($filename, '\.')[1]" />
	</xsl:function>
	
	<xsl:function name="fn:remove-numeric-suffix" as="xs:string?">
		<xsl:param name="filename" as="xs:string?" />
		
		<xsl:value-of select="replace($filename, '([0-9]+)$', '')" />
	</xsl:function>
	
</xsl:stylesheet>