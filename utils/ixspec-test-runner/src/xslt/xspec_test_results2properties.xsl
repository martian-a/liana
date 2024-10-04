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
	    <xspec>
	        <xsl:apply-templates select="@passed, @pending, @failed, @total, @status" />
	    </xspec>
	</xsl:template>       
    
   
    
    <xsl:template match="attribute()">
        <xsl:element name="{local-name()}">
        	<xsl:value-of select="." />
        </xsl:element>
    </xsl:template>
    
    
</xsl:stylesheet>