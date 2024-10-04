<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:x="http://www.jenitennison.com/xslt/xspec"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"    
    exclude-result-prefixes="#all"
    version="3.0"
    expand-text="true">
    
 
	<xsl:output
    	method="xml"
    	omit-xml-declaration="false"
    	indent="true" 
    />
	
	<xsl:template match="/*">
		<xsl:variable name="tests" select="descendant::x:test" as="element()*" />
		<xsl:variable name="total-tests" select="count($tests)" as="xs:integer" />
		<xsl:variable name="total-successful" select="count($tests[@successful = 'true'])" as="xs:integer" />
		<xsl:variable name="total-failed" select="count($tests[@successful = 'false'])" as="xs:integer" />
		<xsl:variable name="total-pending" select="count($tests[@pending])" as="xs:integer" />
		
	    <xsl:copy>
	        <xsl:apply-templates select="@*" />
	        <xsl:attribute name="passed" select="$total-successful" />
	    	<xsl:attribute name="pending" select="$total-pending" />
	    	<xsl:attribute name="failed" select="$total-failed" />
	    	<xsl:attribute name="total" select="$total-tests" />
	    	<xsl:attribute name="status">
	    		<xsl:choose>
	    			<xsl:when test="$total-failed > 0">failed</xsl:when>
	    			<xsl:when test="$total-pending = $total-tests">disabled</xsl:when>
	    			<xsl:otherwise>passed</xsl:otherwise>
	    		</xsl:choose>
	    	</xsl:attribute>
	        <xsl:apply-templates />	    	
	    </xsl:copy>
	</xsl:template>       
    
   
    
    <xsl:template match="document-node() | comment() | processing-instruction() | attribute()">
        <xsl:copy>
            <xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="element()">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>