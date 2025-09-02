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
		<m:component>
			<m:desc>Import the official XProc 3 library for XSpec.</m:desc>
			<m:note>
				<m:ul>					
					<m:ingress>In addition to the options supported when working with XSpec for XSLT (see note above import statement for the official XProc 3 step for running an XSpec test file for XSLT), there's an additional option for XQuery:</m:ingress>
					<m:li>log-compiler - a path to where the temporary XQuery compiler file should be logged/stored (optional: XQuery)</m:li>							
				</m:ul>
			</m:note>
		</m:component>
	</p:documentation>
	<p:import href="http://www.jenitennison.com/xslt/xspec/xproc/lib" />
	
	
	<p:documentation>
		<m:component>
			<m:desc>Import the official XProc 3 step for running an XSpec test file for XSLT.</m:desc>
			<m:note>
				<m:ul>
					<m:ingress>A map of supported options and their value:</m:ingress>
					<m:li>xspec-home - a path to the XSpec framework root directory(required)</m:li>
					<m:li>compiler-uri - a path to the XSLT stylesheet to be used for compiling the XSpec test file.  Defaults to http://www.jenitennison.com/xslt/xspec/compile-xslt-tests.xsl (optional)</m:li>
					<m:li>
						<m:ul>
							<m:ingress>Debugging options:</m:ingress>
							<m:li>log-compilation - a path to where the compiled XSpec file should be logged/stored (optional)</m:li>
							<m:li>log-xml-report - a path to where the compiled XSpec file should be logged/stored (optional)</m:li>
							<m:li>log-report - a path to where the HTML report file should be logged/stored (optional)</m:li>
							<m:li>log-indent - a path to where the indented source file should be logged/stored (optional); happens when the HTML report is generated</m:li>
						</m:ul>
					</m:li>					
				</m:ul>	
				<m:p>The above options need to be set in a map that's passed into steps via the parameters port.</m:p>
			</m:note>
		</m:component>
	</p:documentation>
	<p:import href="http://www.jenitennison.com/xslt/xspec/xproc/steps/run-xslt" />
	
	
	<p:documentation>
		<m:component>Import the unofficial step for converting an iXSpec file to XSpec (for XSLT).</m:component>
	</p:documentation>
	<p:import href="ixspec2xspec.xpl" />
		
	
	
</p:library>