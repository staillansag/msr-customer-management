<HTML>
<HEAD>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT SRC="webMethods.js"></SCRIPT>
  <SCRIPT>
    function deleteAuthServer(action, name) {
		if (name == (document.getElementById('authServerAlias').innerText)) {
			alert("Cannot delete " + name + ". It is the currently selected authorization server.");
			return false;
		} else {
			var msg = "OK to remove external authorization server " + name + "?";
			if (confirm(msg)) {
				document.forms['authServer'].action.value = 'removeAS';
				document.forms['authServer'].name.value = name;
				return true;
			} else
				return false;
		}
    }  
  </SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('security-oauth-settings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthScrn');">
   
    <table width="100%">
    <tr>
        <td class="breadcrumb" colspan="2"> Security &gt; OAuth </td>
    </tr>

	%ifvar operation equals('saveAuthServer')%
		%invoke wm.server.oauth:setExternalAuthorizationServer%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
		%endinvoke%
	%endif%
	
    %ifvar action equals('edit')%
      %ifvar isChanged equals('true')%
        %invoke wm.server.oauth:setOAuthSettings%    
			<TR><TD colspan="2">&nbsp;</td></TR>
			<TR><TD class="message" colspan=2>%value message encode(html)%</TD></TR>
        %endinvoke%
      %else%
        <TR><TD colspan="2">&nbsp;</td></TR>
        <TR><TD class="message" colspan=2>No changes made to OAuth Global Settings.</TD></TR>
      %endif%
    %endif%
    
    %ifvar action equals('removeAS')%
        %invoke wm.server.oauth:removeExternalAuthorizationServer%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
		%endinvoke%
	%endif%
	
      <tr>
        <td colspan="2">
          <ul class="listitems">
		    
			<script>createForm("htmlform_security_oauth_client_registration", "security-oauth-client-registration.dsp", "POST", "body");</script>
            <li class="listitem">
			<script>getURL("security-oauth-client-registration.dsp","javascript:document.htmlform_security_oauth_client_registration.submit();","Client Registration");</script></li>
			
			<script>createForm("htmlform_security_oauth_scope", "security-oauth-scope.dsp", "POST", "body");</script>
            <li class="listitem">
			<script>getURL("security-oauth-scope.dsp","javascript:document.htmlform_security_oauth_scope.submit();","Scope Management");</script></li>
			
			<script>createForm("htmlform_security_oauth_tokens", "security-oauth-tokens.dsp", "POST", "body");</script>
            <li class="listitem">
			<script>getURL("security-oauth-tokens.dsp","javascript:document.htmlform_security_oauth_tokens.submit();","Tokens");</script></li>
			
			<script>createForm("htmlform_security_oauth_settings_edit", "security-oauth-settings-edit.dsp", "POST", "body");</script>
			<li class="listitem">
			<script>getURL("security-oauth-settings-edit.dsp","javascript:document.htmlform_security_oauth_settings_edit.submit();","Edit OAuth Global Settings");</script></li>
			
			<script>createForm("htmlform_security_oauth_authserver", "security-oauth-authserver.dsp", "POST", "body");
					setFormProperty("htmlform_security_oauth_authserver", "action", "add");
			</script>
			<li class="listitem">
			<script>getURL("security-oauth-authserver.dsp","javascript:document.htmlform_security_oauth_authserver.submit();","Add External Authorization Server");</script>
			</li>
          </ul>
        </td>
      </tr>        

        <tr>
            <td>
                <table width="50%">
                    <tr>
                        <td>    
                            <table class="tableView" width="75%">
                                <tr>
                                    <td class="heading" colspan="2">Authorization Server Settings</td>
                                </tr>
                              %invoke wm.server.oauth:getOAuthSettings%
                              <TR>
                                 <TD nowrap class="oddrow">Require HTTPS</TD>
                                 %ifvar requireHTTPS equals('true')%
                                    <TD nowrap class="oddrowdata-l">yes</TD>
                                 %else%
                                    <TD nowrap class="oddrowdata-l">no</TD>
                                 %endif%
                              </TR>
                                
                              <TR>
                                 <TD nowrap class="oddrow">Require PKCE</TD>
                                 %ifvar requirePKCE equals('true')%
                                    <TD nowrap class="oddrowdata-l">yes</TD>
                                 %else%
                                    <TD nowrap class="oddrowdata-l">no</TD>
                                 %endif%
                              </TR>

                              <TR>
                                 <TD nowrap class="evenrow">Authorization code expiration interval</TD>
								 <TD nowrap class="evenrowdata-l">%value authCodeLifetime encode(html)% seconds</TD>
                              </TR>

                              <TR>
                                 <TD nowrap class="oddrow">Access token expiration interval</TD>
                                 <TD nowrap class="oddrowdata-l">
                                 %ifvar accessTokenLifetime equals('-1')%
                                     Never Expires
                                 %else%
								 	 %value accessTokenLifetime encode(html)% seconds
                                 %endif%
                                </TD>
                              </TR>
							  <TR> 
							  <TD class="evenrow" nowrap>Token endpoint authentication</TD>
							  <TD class="evenrow-l">
						  		  <INPUT type="radio" name="tokenEndpointAuth" id="tokenEndpointAuth" value="session" 
								      %ifvar tokenEndpointAuth equals('session')% checked%endif% disabled/>Accept existing session <BR/>
								  <INPUT type="radio" name="tokenEndpointAuth" id="tokenEndpointAuth" value="credentials" 
								      %ifvar tokenEndpointAuth equals('credentials')% checked%endif% disabled/>Require credentials
							  </TD>
							  </TR> 							  

                              <tr>
                                <td class="heading" colspan="2">Resource Server Settings</td>
                              </tr>

                              <TR>
                                 <TD nowrap class="oddrow">Authorization server</TD>
								 <TD nowrap name="authServerAlias" id="authServerAlias" class="oddrowdata-l">%value authServerAlias encode(html)%</TD>
                              </TR>
                            </table>
						</td>
					</tr>
                          
					<tr><td>&nbsp;<br>&nbsp;<br></td></tr>
					
					<tr>
						<td>
							 <table class="tableView" width="50%">
                              <tr>
                                <td nowrap class="heading" colspan="2">External Authorization Servers &nbsp;</td>
                              </tr>

							 %invoke wm.server.oauth:listExternalAuthorizationServers%
							 %loop authorizationServers%
								<TR>
								  <script>				  
									createForm("htmlform_security_oauth_authserver2_%value $index%", "security-oauth-authserver.dsp", "POST", "BODY");
									setFormProperty("htmlform_security_oauth_authserver2_%value $index%", "action", "edit");
									setFormProperty("htmlform_security_oauth_authserver2_%value $index%", "name", "%value name%");
									 writeTD("rowdata");
									if(is_csrf_guard_enabled && needToInsertToken) {
										getURL("security-oauth-authserver.dsp?action=edit&name=%value name encode(javascript)%","javascript:document.htmlform_security_oauth_authserver2_%value $index%.submit();","%value name encode(javascript)%");
									} else {
									 getURL("security-oauth-authserver.dsp?action=edit&name=%value name encode(javascript)%","javascript:document.htmlform_security_oauth_authserver.submit();","%value name encode(javascript)%");
									}
								 </script>
								
								 </TD>
								<SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
									<A href="javascript:document.forms['authServer'].submit()" onClick="return deleteAuthServer('removeAS', '%value name encode(javascript)%');">
									  <IMG src="icons/delete.png" alt="Delete External Authorization Server %value name encode(javascript)%" border="none">
									</A>
								 </TD>
								 </TR>
							 %endloop%
							 %endinvoke%
							  
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>      
     </table>
  <FORM name="authServer" action="security-oauth-settings.dsp" method="POST">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="action">
    <input type="hidden" name="name">
  </FORM>      
</BODY>
</HTML>
