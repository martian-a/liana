<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:ix="http://xylarium.org/ns/xml/ixspec"
	xmlns:ixp="http://xylarium.org/ns/xproc/steps/ixspec"    
	xmlns:m="http://xylarium.org/ns/xml/documentation"
	xmlns:map="http://www.w3.org/2005/xpath-functions/map"
	xmlns:p="http://www.w3.org/ns/xproc"      
	xmlns:x="http://www.jenitennison.com/xslt/xspec"   
	xmlns:xs="http://www.w3.org/2001/XMLSchema"	
	exclude-inline-prefixes="#all"
	name="run-ixspec"
	type="ixp:saxon-ixspec-harness"
	version="3.1">
    
	<p:documentation>
		<m:document>
			<m:title>iXSpec Test Runner</m:title>
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
		<m:component>Import the XProc library for iXSpec.</m:component>
	</p:documentation>
	<p:import href="ixspec_lib.xpl" />
    
    
	<p:documentation>
		<m:component>An iXSpec test file.</m:component>
	</p:documentation>
    <p:input port="source" sequence="false" primary="true" content-types="xml" />
		
		
	<p:documentation>
		<m:component>An HTML report detailing the results of running the tests.</m:component>
	</p:documentation>	
    <p:output port="result" primary="true" sequence="true" />
	
	
	<p:documentation>
		<m:component>
			<m:desc>
				<m:ul>
					<m:ingress>A map of options and their values.</m:ingress>
					<m:li>xspec-home - a path to the XSpec framework root directory(required)</m:li>
					<m:li>compiler-uri - a path to the XSLT stylesheet to be used for compiling the XSpec test file.  Defaults to http://www.jenitennison.com/xslt/xspec/compile-xslt-tests.xsl (optional)</m:li>
					<m:li>if-set - a path to where debugging data should be logged/stored (optional)</m:li>
				</m:ul>				
			</m:desc>
			<m:note>If parameters isn't set to an empty map by default then an error is thrown by x:compile-xslt in harness-lib.xpl when map:get() is used (because map:get() requires a map).</m:note>
		</m:component>
	</p:documentation>	
	<p:option name="parameters" select="map{}" as="map(xs:QName,item()*)?" />
	
	
	<p:documentation>
		<m:component>Convert the iXSpec test file to a standard XSpec test file for XSLT.</m:component>
	</p:documentation>
	<ixp:ixspec2xspec />
	
	
	<p:documentation>
		<m:component>Run the XSpec file using the standard/official XSLT process.</m:component>
	</p:documentation>
	<x:saxon-xslt-harness>
		<p:with-option name="parameters" select="$parameters" />
	</x:saxon-xslt-harness>
		

</p:declare-step>