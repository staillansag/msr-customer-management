<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js">
  </script>
</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JNDIaliasDetailsScrn');">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JNDI Settings &gt; JNDI Provider Alias</td>
    </tr>

    %ifvar action equals('edit')%
    
      %invoke wm.server.jndi:setJNDIAliasData%    
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %onerror%
        <tr>
          <td class="message" colspan=2>%value errorMessage encode(html)%</td>
        </tr>
      %endinvoke%
    %endif%

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jndi", "settings-jndi.dsp", "POST", "BODY");
		  createForm("htmlform_settings_jndi_edit", "settings-jndi-edit.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_jndi_edit", "jndiAliasName", "%value jndiAliasName%");
		  </script>
          <li class="listitem"><script>getURL("settings-jndi.dsp", "javascript:document.htmlform_settings_jndi.submit();", "Return to JNDI Settings");</script>
		  </li>
          <li class="listitem"><script>getURL("settings-jndi-edit.dsp?jndiAliasName=%value jndiAliasName encode(url)%", "javascript:document.htmlform_settings_jndi_edit.submit();", "Edit JNDI Provider Alias");</script>
		  </li>
        </ul>
      </td>
    </tr>

    <tr>
      <td>
        <table class="tableView" width="85%">
        
        %invoke wm.server.jndi:getJNDIAliasData%

          <tr>
            <td class="heading" colspan=2>JNDI Provider Alias</td>
          </tr>
          <tr>
            <td class="oddrow-l" scope="row" width="25%">JNDI Alias Name</td>
            <td class="oddrowdata-l">%value aliasName encode(html)%</td>
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Description</td>
            <td class="evenrowdata-l">%value description encode(html)%</td>
          </tr>
          <tr>
            <td class="oddrow-l" nowrap scope="row">Initial Context Factory</td>
            <td class="oddrowdata-l">%value initialContextFactory encode(html)%</td>
          </tr> 
          <tr>
            <td class="evenrow-l" scope="row">Provider URL</td>
            <td class="evenrowdata-l">%value providerURL encode(html)%</td>
          </tr> 
          <tr>
            <td class="oddrow-l" scope="row">Provider URL Failover List</td>
            <td class="oddrowdata-l">
              <textarea name="otherProps" cols=70 rows=3 readonly class="evenrow-l" wrap=off>%value providerURLFailoverList encode(html)%</textarea>
            </td>
          </tr>  
          <tr>
            <td class="evenrow-l" scope="row">Security Principal</td>
            <td class="evenrowdata-l">%value securityPrincipal encode(html)%</td>
          </tr>
          <tr>
            <td class="oddrow-l" scope="row">Security Credentials</td>
            <td class="oddrowdata-l">%ifvar securityCredentials -notempty%******%endif%</td>
          </tr> 
          <tr>
            <td class="evenrow-l" scope="row">Other Properties</td>
            <td class="evenrowdata-l">
              <textarea name="otherProps" cols=70 rows=3 readonly class="evenrow-l" wrap=off>%value otherProps encode(html)%</textarea>
            </td>
          </tr>
		  <tr>
            <td class="oddrow-l" scope="row">Use SSL</td>
            <td class="oddrowdata-l">
				%ifvar trustStoreAlias -notempty%
					Yes
					  <script>
						document.getElementById('ssl').style.display = '';
					  </script>
				%else%
					%ifvar keyStoreAlias -notempty%
					  <script>
						document.getElementById('ssl').style.display = '';
					  </script>	
						Yes
					%else%	
					  <script>
						document.getElementById('ssl').style.display = 'none';
					  </script>
						No
					%endif%
				%endif%
			</td>
          </tr>		  
          
        </table>   
		<table class="tableView" width="85%" id="ssl">	  
          
           <TR>
             <TD class="heading" colspan=2>SSL Settings</TD>
           </TR> 
	         		
		<TR ID="sslRowForTs">
				<TD  class="evenrow-l" width="25%"><label for="trustStoreAlias">Truststore Alias</label></TD>
				<TD class="evenrowdata-l">%value trustStoreAlias encode(html)%</TD>
		</TD>
		</TR>
		
		<TR ID="sslRowForKs">
				<TD class="oddrow-l"><label for="keyStoreAlias">Keystore Alias</label></TD>
				<TD class="oddrowdata-l">%value keyStoreAlias encode(html)%</TD>
			    </TR>
			    <TR>
			   	<TD class="evenrow-l"><label for="keyAlias">Key Alias</label></TD>
			    <TD class="evenrowdata-l">%value keyAlias encode(html)%</TD>
			   </TR>			   
		
		<!-- JNDI properties for SSSL -->
		<tr>
            <td class="heading" colspan=2>JNDI Property Names (JNDI Provider Specific)</td>
          </tr>
		  		  <tr>
            <td class="oddrow-l"><label for="trustStoreProp">Truststore Property Name</label></td>
            <td class="oddrowdata-l">%value trustStoreProp encode(html)%</td>
          </tr>
          <tr>
            <td class="evenrow-l"><label for="trustStorePwdProp">Truststore Password Property Name</label></td>
            <td class="evenrowdata-l">%value trustStorePwdProp encode(html)%</td>
          </tr>
		<tr>
            <td class="oddrow-l"><label for="keyStoreProp">Keystore Property Name</label></td>
            <td class="oddrowdata-l">%value keyStoreProp encode(html)%</td>
          </tr>
          <tr>
            <td class="evenrow-l"><label for="keyStorePwdProp">Keystore Password Property Name</label></td>
            <td class="evenrowdata-l">%value keyStorePwdProp encode(html)%</td>
          </tr>
		  		  <tr>
            <td class="oddrow-l"><label for="keyStoreFormatProp">Keystore Format Property Name</label></td>
            <td class="oddrowdata-l">%value keyStoreFormatProp encode(html)%</td>
          </tr>

		  <tr>
            <td class="evenrow-l"><label for="privateKeyProp">Private Key Property Name</label></td>
            <td class="evenrowdata-l">%value privateKeyProp encode(html)%</td>
          </tr>
			%ifvar trustStoreAlias -notempty%
				<script>
				document.getElementById('ssl').style.display = '';
				</script>
			%else%
				%ifvar keyStoreAlias -notempty%
					<script>
					document.getElementById('ssl').style.display = '';
					</script>	
				%else%	
					<script>
					document.getElementById('ssl').style.display = 'none';
					</script>
				%endif%
			%endif%
          %onerror%
          <tr>
            <td class="message" colspan=2>%value errorMessage encode(html)%<br>%value error encode(html)% at %value errorService encode(html)%<br></td>
          </tr>
        %endinvoke%

		</table>
      </td>
    </tr>
    
  </table>

</body>
</html>
