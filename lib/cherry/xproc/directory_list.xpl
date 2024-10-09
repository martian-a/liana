<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"     
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:u="http://xylarium.org/ns/xproc/steps/utils"    
    name="directory-list"
    type="u:directory-list"
    version="3.0">
    
    <p:documentation>
        <p></p>
    </p:documentation>
	
	<p:output port="result" content-types="application/xml" />
	
	<p:option name="path" required="true" as="xs:anyURI" />        
	<p:option name="detailed" as="xs:boolean" select="false()" />  
	<p:option name="max-depth" as="xs:string?" select="'1'" />     
	<p:option name="include-filter" as="xs:string*" />             
	<p:option name="exclude-filter" as="xs:string*" />             
	<p:option name="override-content-types" as="array(array(xs:string))?" />
   				
	
	<p:directory-list>
		<p:with-option name="path" select="$path" as="xs:anyURI" />        
		<p:with-option name="detailed" select="$detailed" as="xs:boolean" />  
		<p:with-option name="max-depth" select="$max-depth" as="xs:string?" />     
		<p:with-option name="include-filter" select="$include-filter" as="xs:string*" />             
		<p:with-option name="exclude-filter" select="$exclude-filter" as="xs:string*" />             
		<p:with-option name="override-content-types" select="$override-content-types" as="array(array(xs:string))?" />
	</p:directory-list>
	
	<p:xslt>
		<p:with-input port="stylesheet" href="http://xylarium.org/ns/xslt/utils/directory-list.xsl" />
	</p:xslt>	

</p:declare-step>