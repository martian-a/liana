<?xml version="1.0" encoding="UTF-8"?>
<p:library
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:ix="http://xylarium.org/ns/xml/ixspec"
    xmlns:ixp="http://xylarium.org/ns/xproc/steps/ixspec"   
    xmlns:m="http://xylarium.org/ns/xml/documentation"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:p="http://www.w3.org/ns/xproc"      
    xmlns:pkg="http://expath.org/ns/pkg"
    xmlns:x="http://www.jenitennison.com/xslt/xspec"   
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"    
    pkg:import-uri="#none"
    exclude-inline-prefixes="#all"
    version="3.1">
    
    <p:documentation>
    	<m:document>
    		<m:title>iXSpec Library</m:title>
    		<m:desc>
    			<m:p>An unofficial extension of the <m:link href="https://github.com/xspec/xspec/blob/master/src/xproc3/harness-lib.xpl">official XProc library for XSpec</m:link></m:p>
    			<m:p>This extension makes it possible to use XSpec to test an Invisible XML grammar.</m:p>
    		</m:desc>
    		<m:contributors>
    			<m:original-author>Sheila Thomson</m:original-author>
    		</m:contributors>
    		<m:history created="2025-08-11" />
    	</m:document>
    </p:documentation>


	<p:documentation>
		<m:component>Import the official XProc 3 library for XSpec.</m:component>
	</p:documentation>
	<p:import href="http://www.jenitennison.com/xslt/xspec/xproc/lib" />
	
	
	<p:documentation>
		<m:component>Import the official XProc 3 step for running an XSpec test file for XSLT.</m:component>
	</p:documentation>
	<p:import href="http://www.jenitennison.com/xslt/xspec/xproc/steps/run-xslt" />
	
	
	<p:documentation>
		<m:component>Import the unofficial step for converting an iXSpec file to XSpec (for XSLT).</m:component>
	</p:documentation>
	<p:import href="ixspec2xspec.xpl" />
		
	
	
</p:library>