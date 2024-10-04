<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"     
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:u="http://xylarium.org/ns/xproc/steps/utils"    
    name="save-debug-snapshot"
    type="u:save-debug-snapshot"
    version="3.0">
    
    <p:documentation>
        <p>Convenience step for storing a snapshot of input or output to aid with debugging.</p>
    </p:documentation>
	
	<p:input port="source" sequence="false" primary="true" />
	
	<p:output port="result" sequence="true" primary="true">
		<p:pipe step="store-snapshot" port="result" />
	</p:output>
	<p:output port="result-uri" sequence="true">
		<p:pipe step="store-snapshot" port="result-uri" />
	</p:output>
    
	<p:option name="href" required="true" as="xs:anyURI" />
	<p:option name="debug" select="false()" as="xs:boolean" />
					
	
	<p:if test="$debug" name="store-snapshot">
		
		<p:output port="result" sequence="false" primary="true">
			<p:pipe step="save-file" port="result" />
		</p:output>
		
		<p:output port="result-uri" sequence="false">
			<p:pipe step="save-file" port="result-uri" />
		</p:output>
		
		<p:store name="save-file" message="&#10;DEBUG: Saving a snapshot: {$href}&#10;">
			<p:with-option name="href" select="$href" />
		</p:store>
		
	</p:if>	

</p:declare-step>