<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"      
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:x="http://xylarium.org/ns/ixml/test"
    xmlns:xym="http://xylarium.org/ns/xproc/steps"    
    xmlns:u="http://xylarium.org/ns/xproc/steps/utils"   
    name="ixspec-test-runner"
    type="xym:ixspec-test-runner"
    version="3.0">
    
    <p:documentation>
        <p>Processes an *.ixspec file.</p>
    </p:documentation>
    
	<!-- p:import href="http://xylarium.org/ns/xproc/steps/utils/save-debug-snapshot.xpl" /-->
	<p:import href="save_debug_snapshot.xpl" />
    
    <p:input port="source" sequence="false" primary="true" content-types="xml" />
		
    <p:output port="result" sequence="true">
    	<p:pipe port="result" step="per-scenario" />
    </p:output>
	
	<p:option name="tmp-dir" select="'../tmp/'" as="xs:anyURI" />
	<p:option name="debug-dir" select="'../tmp/debug/'" as="xs:anyURI?" />
	<p:option name="debug" select="'false'" />
	
     	
	<p:variable name="debug-base-path" select="string-join(($debug-dir, 'ixspec-test-runner'), '/')" />
	<p:variable name="tmp-base-path" select="string-join(($tmp-dir, 'ixspec-test-runner'), '/')" />
	
	<p:variable name="test-file-base-uri" select="document-uri(/)" />
	<p:variable name="test-file-name" select="tokenize($test-file-base-uri, '/')[last()] ! string-join(tokenize(., '\.')[position() != last()], '.')" />
	
	<u:save-debug-snapshot debug="{$debug}" href="{concat($debug-base-path, '.input.xml')}" />
	
	
	<p:for-each name="per-scenario">
		<p:with-input select="/x:description/descendant-or-self::x:scenario[x:context]" />
		<p:output port="result" sequence="true" />

		<p:variable name="context-href" select="resolve-uri(/x:scenario/x:context/@href, $test-file-base-uri)" />
		<p:variable name="expect-href" select="resolve-uri(/x:scenario/x:expect/@href, $test-file-base-uri)" />
		<p:variable name="scenario-tmp-base-path" select="string-join(($tmp-base-path, $test-file-name, p:iteration-position()), '/')" />
		<p:variable name="scenario-debug-base-path" select="string-join(($debug-base-path, $test-file-name, p:iteration-position()), '/')" />		
		
		<p:ixml>
			<p:with-input port="source">
				<p:document href="{$context-href}" />
			</p:with-input>
			<p:with-input port="grammar" pipe="result@grammar" />
		</p:ixml>
	
		<u:save-debug-snapshot debug="{$debug}" href="{concat($scenario-debug-base-path, '.ixml-output.xml')}" />
		

		<p:compare name="compare" fail-if-not-equal="true">
			<p:with-input port="alternate">
				<p:document href="{$expect-href}" />
			</p:with-input>
		</p:compare>
		
	</p:for-each>
                   
    <p:sink />   
	
	
	<p:identity>
		<p:with-input port="source" pipe="source@ixspec-test-runner" />
	</p:identity>
	
	<p:load name="grammar" href="{/x:description/@grammar}" />
	
	<p:sink />
	
</p:declare-step>