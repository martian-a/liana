<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"      
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:x="http://www.jenitennison.com/xslt/xspec"
    xmlns:ix="http://xylarium.org/ns/ixml/xspec"
    xmlns:xym="http://xylarium.org/ns/xproc/steps"    
    xmlns:u="http://xylarium.org/ns/xproc/steps/utils"   
    name="ixspec2xspec"
    type="xym:ixspec2xspec"
    version="3.0">
    
    <p:documentation>
        <p>Converts an iXSpec file into an XSpec file.</p>
    </p:documentation>
    
    
	<p:import href="save_debug_snapshot.xpl" />
    
    <p:input port="source" sequence="false" primary="true" content-types="xml" />
		
    <p:output port="result" sequence="true">
    	<p:pipe port="result" step="update-expect-href" />
    </p:output>
	
	<p:option name="tmp-dir" select="'../tmp/'" as="xs:anyURI" />
	<p:option name="debug-dir" select="'../tmp/debug/'" as="xs:anyURI?" />
	<p:option name="debug" select="'false'" />
	
     	
	<p:variable name="debug-base-path" select="string-join(($debug-dir, 'ixspec2xspec'), '/')" />
	<p:variable name="tmp-base-path" select="string-join(($tmp-dir, 'ixspec2xspec'), '/')" />
	
	<p:variable name="test-file-base-uri" select="document-uri(/)" />
	<p:variable name="test-file-name" select="tokenize($test-file-base-uri, '/')[last()] ! string-join(tokenize(., '\.')[position() != last()], '.')" />
	
	<u:save-debug-snapshot debug="{$debug}" href="{concat($debug-base-path, '/input.xml')}" />
	
	<p:namespace-rename from="http://xylarium.org/ns/ixml/xspec" to="http://www.jenitennison.com/xslt/xspec" />
	<p:add-attribute match="/*" attribute-name="stylesheet" attribute-value="http://xylarium.org/ns/xml/util/identity.xsl" />
	
	<u:save-debug-snapshot debug="{$debug}" href="{concat($debug-base-path, '/', $test-file-name, '.old_scenarios.xspec')}" />


	<p:viewport name="update-context-href"
		match="/x:description/descendant-or-self::x:scenario[x:context/@href]">
		
		<p:output port="result" sequence="true">
			<p:pipe step="updated-context" port="result" />
		</p:output>
		
		<p:identity name="current-scenario" />
		
		<p:variable name="original-context-href" select="resolve-uri(/x:scenario/x:context/@href, $test-file-base-uri)" />
		<p:variable name="scenario-tmp-base-path" select="string-join(($tmp-base-path, $test-file-name, 'update-context-href', p:iteration-position()), '/')" />
		<p:variable name="scenario-debug-base-path" select="string-join(($debug-base-path, $test-file-name, 'update-context-href', p:iteration-position()), '/')" />
		<p:variable name="new-context-href" select="/*/text()">
			<p:pipe step="new-context" port="result-uri" />
		</p:variable>	
		
		<p:sink />
		
		
		<p:ixml>
			<p:with-input port="source">
				<p:document href="{$original-context-href}" />
			</p:with-input>
			<p:with-input port="grammar" pipe="result@grammar" />
		</p:ixml>
		
		<p:store name="new-context">
			<p:with-option name="href" select="concat($scenario-tmp-base-path, '.ixml-output.xml')" />
			<p:with-option name="serialization" select="map { 'method' : 'xml', 'indent' : false() }" />
		</p:store>
		
		<p:sink />
		
		
		<p:xslt name="updated-context">		
			<p:with-input port="source" pipe="result@current-scenario" />
			<p:with-input port="stylesheet">
				<p:document href="../xslt/update_context_href.xsl" />
			</p:with-input>
			<p:with-option name="parameters" select="map { 'new-context-href': $new-context-href }" />
		</p:xslt>
		
	</p:viewport>
	
	<u:save-debug-snapshot debug="{$debug}" href="{concat($debug-base-path, '/', $test-file-name, '.new_contexts.xspec')}" />
	
	
	<p:viewport name="update-expect-href"
		match="/x:description/descendant-or-self::x:scenario[x:expect/@href]">
		
		<p:output port="result" sequence="true" />
		
		<p:variable name="resolved-expect-href" select="resolve-uri(/x:scenario/x:expect/@href, $test-file-base-uri)" />
		<p:variable name="scenario-tmp-base-path" select="string-join(($tmp-base-path, $test-file-name, 'update-expect-href', p:iteration-position()), '/')" />
		<p:variable name="scenario-debug-base-path" select="string-join(($debug-base-path, $test-file-name, 'update-expect-href', p:iteration-position()), '/')" />
	
		<p:xslt name="updated-expect">
			<p:with-input port="stylesheet">
				<p:document href="../xslt/update_expect_href.xsl" />
			</p:with-input>
			<p:with-option name="parameters" select="map { 'new-expect-href': $resolved-expect-href }" />
		</p:xslt>
		
	</p:viewport>
                   
    <p:sink />   
	
	
	<p:identity>
		<p:with-input port="source" pipe="source@ixspec2xspec" />
	</p:identity>
	
	<p:variable name="grammar-href" select="xs:anyURI(/ix:description/@grammar)" as="xs:anyURI" />
	
	<p:load name="grammar">
		<p:with-option name="href" select="$grammar-href" />
	</p:load>
	
	<p:sink />
	
</p:declare-step>