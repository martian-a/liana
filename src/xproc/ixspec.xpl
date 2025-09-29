<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" 
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
				<m:p>Use XSpec to test an Invisible XML grammar.</m:p>
			</m:desc>
			<m:note>An unofficial extension of the <m:link href="https://github.com/xspec/xspec/blob/master/src/xproc3/harness-lib.xpl">official XProc library for XSpec</m:link></m:note>
			<m:contributors>
				<m:original-author>Sheila Thomson</m:original-author>
			</m:contributors>
			<m:history created="2025-08-11">
				<m:change date="2025-09-29">
					<m:desc>Updated to reflect changes to XProc 3 in XSpec project.</m:desc>
					<m:related href="https://github.com/xspec/xspec/pull/2163">Pull request to move/rename XProc 3 harnesses</m:related>
				</m:change>
			</m:history>
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
		<m:component>The iXSpec test file after it's been converted to XSpec but before it's been through the XSpec compile process.</m:component>
	</p:documentation>	
	<p:output port="xspec" sequence="true" pipe="@convert-to-xspec" />
	
	
	<!-- p:documentation>
		<m:component>
			<m:desc>The XSpec results as XML, before they've been converted to an HTML report.</m:desc>
			<m:note date="2025-08-13">Not yet supported by the official XProc 3.0 library for XSpec.</m:note>
		</m:component>
	</p:documentation>	
	<p:output port="result-xml" sequence="true" pipe="result-xml@run-xspec-for-xslt" /-->
	
	
	<p:documentation>
		<m:component>
			<m:desc>
				<m:ul>
					<m:ingress>A map of supported parameter options and their values:</m:ingress>
					<m:li>xspec-home - a path to the XSpec framework root directory(required)</m:li>
					<m:li>compiler-uri - a path to the XSLT stylesheet to be used for compiling the XSpec test file.  Defaults to http://www.jenitennison.com/xslt/xspec/compile-xslt-tests.xsl (optional)</m:li>
					<m:li>
						<m:ul>
							<m:ingress>Debugging options:</m:ingress>
							<m:li>log-intermediate - a path to where the result of the iXSPec-to-XSpec conversion should be logged/stored (optional)</m:li>
							<m:li>log-compilation - a path to where the compiled XSpec file should be logged/stored (optional)</m:li>
							<m:li>log-xml-report - a path to where the compiled XSpec file should be logged/stored (optional)</m:li>
							<m:li>log-report - a path to where the HTML report file should be logged/stored (optional)</m:li>
							<m:li>log-indent - a path to where the indented source file should be logged/stored (optional); happens when the HTML report is generated</m:li>
						</m:ul>
					</m:li>
				</m:ul>				
			</m:desc>
			<m:note>If parameters isn't set to an empty map by default then an error is thrown by x:compile-xslt in harness-lib.xpl when map:get() is used (because map:get() requires a map).</m:note>
		</m:component>
	</p:documentation>	
	
	<p:documentation>
		<m:desc>A path to the root of the XSpec project (optional).</m:desc>
	</p:documentation>
	<p:option name="xspec-home" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<m:desc>A path to the XSLT stylesheet to use to compile the test file (optional).</m:desc>
	</p:documentation>
	<p:option name="compiler-uri" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<m:desc>Configuration options to pass through to the compiler stylesheet (optional).</m:desc>
	</p:documentation>
	<p:option name="compiler-options" as="map(xs:QName, item()*)?" static="true" />
	
	<p:documentation>
		<m:desc>A path to the XSLT stylesheet to use to format the test results (optional).</m:desc>
	</p:documentation>
	<p:option name="formatter-uri" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<m:desc>Configuration options to pass through to the formatter stylesheet (optional).</m:desc>
	</p:documentation>
	<p:option name="formatter-options" as="map(xs:QName, item()*)?" static="true" />
	
	<p:documentation>
		<m:desc>Serialization options for the formatted report (optional).</m:desc>
	</p:documentation>
	<p:option name="serialization-options" select="map{ 
			xs:QName('indent') : true(), 
			xs:QName('method') : 'xhtml', 
			xs:QName('encoding') : 'UTF-8', 
			xs:QName('include-content-type') : true(), 
			xs:QName('omit-xml-declaration') : false()
		}" as="map(xs:QName, item()*)?" static="true" />
	
	<p:documentation>
		<m:desc>If you want to store a copy of the compiled XSpec, for example to aid with 
			debugging, then you can use this option to specify where to save it (optional).</m:desc>
		<m:note>If this option is empty then this step will NOT save a copy of the compiled 
			XSpec result to the file-system.</m:note>
		<m:note>If the process completes, the compiled XSpec will always be output via the result port.</m:note>
	</p:documentation>
	<p:option name="log-compiled" as="xs:anyURI?" static="true" />
	
	
	<p:option name="log-indented" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<m:desc>If you want to store a copy of the XML report (before the formatted report
			is generated), then you can use this option to specify where to save it (optional).</m:desc>
		<m:note>If this option is empty then this step will NOT save a copy of the unformatted 
			XSpec results to the file-system.</m:note>
		<m:note>The unformatted XML report will always be output via the xml-report port.</m:note>
	</p:documentation>
	<p:option name="log-xml-report" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<m:desc>If you want to store a copy of the formatted report, for example to aid with 
			debugging, then you can use this option to specify where to save it (optional).</m:desc>
		<m:note>If this option is empty then this step will NOT save a copy of the formatted report
			to the file-system.</m:note>
		<m:note>If the process completes, the formatted report will always be output via the result port.</m:note>
	</p:documentation>
	<p:option name="log-report" as="xs:anyURI?" static="true" />
	
	
	<p:documentation>
		<m:component>Convert the iXSpec test file to a standard XSpec test file for XSLT.</m:component>
	</p:documentation>
	<ixp:ixspec2xspec name="convert-to-xspec" />
		
	
	<p:documentation>
		<m:component>Run the XSpec file using the standard/official XSLT process.</m:component>
	</p:documentation>
	<x:run-xslt name="run-xspec-for-xslt" />
		
</p:declare-step>