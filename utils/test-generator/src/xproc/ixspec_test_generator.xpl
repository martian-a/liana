<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"      
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:x="http://www.jenitennison.com/xslt/xspec"
    xmlns:ix="http://xylarium.org/ns/ixml/xspec"
    xmlns:xym="http://xylarium.org/ns/xproc/steps"    
    xmlns:u="http://xylarium.org/ns/xproc/steps/utils"   
    name="ixspec-test-generator"
    type="xym:ixspec-test-generator"
    version="3.0">
    
    <p:documentation>
        <p>Converts an iXSpec file into an XSpec file.</p>
    </p:documentation>
    
    
	<p:import href="http://xylarium.org/ns/xproc/steps/utils/save-debug-snapshot.xpl" />
	<p:import href="http://xylarium.org/ns/xproc/steps/utils/directory-list.xpl" />
	
		
    <p:output port="result" sequence="true">
    	<!-- p:pipe step="directory" port="result" /-->
    	<!-- p:pipe step="create-ixspec" port="result" /-->
    </p:output>
	
	<p:option name="tests-dir" as="xs:anyURI" />
	<p:option name="output-dir" as="xs:anyURI" />
	
	
	<p:option name="tmp-dir" select="'../tmp/'" as="xs:anyURI" />
	<p:option name="debug-dir" select="'../tmp/debug/'" as="xs:anyURI?" />
	<p:option name="debug" select="'false'" />
	
     	
	<p:variable name="debug-base-path" select="string-join(($debug-dir, 'ixspec-test-generator'), '/')" />
	<p:variable name="tmp-base-path" select="string-join(($tmp-dir, 'ixspec-test-generator'), '/')" />
	
	
	<u:directory-list name="directory-list">
		<p:with-option name="path" select="$tests-dir" />
		<p:with-option name="max-depth" select="'1'" />
	</u:directory-list>
	
	<p:xslt name="group">
		<p:with-input port="stylesheet" href="../xslt/group.xsl" />							
	</p:xslt>
	
	<p:variable name="relative-path" select="substring-after(/c:directory/@path, $tests-dir)" as="xs:anyURI?" />
	
	
	<p:xslt name="create-ixspec">
		<p:with-input port="stylesheet" href="../xslt/create_ixspec.xsl" />
		<p:with-option name="parameters" select="map { 
				'tests-dir' : $tests-dir,
				'output-dir' : $output-dir
			}" />
	</p:xslt>		
	
	
	<p:viewport match="//ixspec">

		<p:variable name="href" select="xs:anyURI(/ixspec/@href)" as="xs:anyURI" />
		
		<p:viewport match="/ixspec/*">

			<p:store name="store">					
				<p:with-option name="href" select="$href" />
			</p:store>	
			
			<p:sink />
			
		</p:viewport>
		
	</p:viewport>	


	<p:viewport match="/c:directory/c:directory">

		<xym:ixspec-test-generator>
			<p:with-option name="tests-dir" select="xs:anyURI(/c:directory/@path)" />
			<p:with-option name="output-dir" select="concat($output-dir, $relative-path) ! xs:anyURI(.)" />
			<p:with-option name="tmp-dir" select="concat($tmp-dir, $relative-path) ! xs:anyURI(.)" />
			<p:with-option name="debug-dir" select="concat($debug-dir, $relative-path) ! xs:anyURI(.)" />
			<p:with-option name="debug" select="$debug" />
		</xym:ixspec-test-generator>
		
	</p:viewport>

</p:declare-step>