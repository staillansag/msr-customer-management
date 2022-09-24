<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT SRC="webMethods.js"></SCRIPT>
  
  <SCRIPT LANGUAGE="JavaScript">
      function confirmDeleteScope(name) {
        var msg = "OK to Delete Scope '"+name+"' ?";
        if (confirm (msg)) {
          return true;
        } else return false;
      }
  </SCRIPT>

  <body onLoad="setNavigation('security-oauth-scopes.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthScopeManagementScrn');">
   
    <table width="100%">
    <tr>
        <td class="breadcrumb" colspan="2"> Security &gt; OAuth &gt; Scope Management</td>
    </tr>

      %ifvar action equals('delete')%
        %invoke wm.server.oauth:removeScope%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan=2>%value message encode(html)%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
        %onerror%
            <tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan=2>%value errorMessage encode(html)% Scope %value name encode(html)% not deleted.</td></tr>			
        %endinvoke%   
      %endif%

      %ifvar action equals('add')%
        %invoke wm.server.oauth:putScope%
            %ifvar message%
                <tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
            %endif%
            %onerror%
                <tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage encode(html)% Scope %value name encode(html)% not added.</td></tr>
        %endinvoke%
      %endif%     
      
      %ifvar action equals('edit')%
          %ifvar isChanged equals('true')%
            %invoke wm.server.oauth:putScope%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)% Scope %value name encode(html)% not updated.</td></tr>				
            %endinvoke%
          %else%
            <TR>
              <TD colspan="2">&nbsp;</td>
            </TR>
            <TR>
			  <TD class="message" colspan=2>No changes made to Scope %value name encode(html)%.</TD>
            </TR>
          %endif%
     %endif%      
      
      <tr>
        <td colspan="2">
          <ul class="listitems">
		    <script>
			createForm("htmlform_security_oauth_settings", "security-oauth-settings.dsp", "POST", "BODY");
			createForm("htmlform_security_oauth_scope_addedit", "security-oauth-scope-addedit.dsp", "POST", "BODY");
			setFormProperty("htmlform_security_oauth_scope_addedit", "action", "add");
			createForm("htmlform_security_oauth_scope_client_associations", "security-oauth-scope-client-associations.dsp", "POST", "BODY");
			</script>
            <li>
			<script>getURL("security-oauth-settings.dsp","javascript:document.htmlform_security_oauth_settings.submit();","Return to OAuth");</script></li>
            <li>
			<script>getURL("security-oauth-scope-addedit.dsp?action=add","javascript:document.htmlform_security_oauth_scope_addedit.submit();","Add Scope");</script></li>
            <li>
			<script>getURL("security-oauth-scope-client-associations.dsp","javascript:document.htmlform_security_oauth_scope_client_associations.submit();","Associate Scopes to Clients");</script></li>
          </ul>
        </td>
      </tr>     

      <TR> 
        <TD width="150%">
           <TABLE width="70%" class="tableView" 	>
           <TR> 
         
          <TD class="heading" colspan="4">Defined Scopes</TD>
        </TR>
       
        <TR>
		  <TH scope="col" CLASS="oddcol-l" nowrap>Name</TH>
		  <TH scope="col" CLASS="oddcol-l" nowrap>Folders and services</TH>
		  <TH scope="col" CLASS="oddcol">URL templates</TH>
		  <TH scope="col" CLASS="oddcol">Delete</TH>
        </TR>

    %invoke wm.server.oauth:listScopes%     
    %loop scopes%
              <TR>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
				  <script>				  
				  createForm("htmlform_security_oauth_scope_addedit_edit_%value $index%", "security-oauth-scope-addedit.dsp", "POST", "BODY");
				  setFormProperty("htmlform_security_oauth_scope_addedit_edit_%value $index%", "action", "edit");
				  setFormProperty("htmlform_security_oauth_scope_addedit_edit_%value $index%", "name", "%value name%");				  
				  </script>
				  <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A href="javascript:document.htmlform_security_oauth_scope_addedit_edit_%value $index%.submit();">%value name encode(html)%</A>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="security-oauth-scope-addedit.dsp?action=edit&name=%value name encode(url)%&webMethods-wM-AdminUI=true">%value name encode(html)%</A>');
					}
					else {
						document.write('<A href="security-oauth-scope-addedit.dsp?action=edit&name=%value name encode(url)%">%value name encode(html)%</A>');
					}
		       }
           </script>
                  </TD>

                  <SCRIPT>writeTD("row-l");</SCRIPT>
					 %loop values%%value encode(html)%%loopsep ';'% %endloop%
                  </TD>
				  
				  <SCRIPT>writeTD("row-l");</SCRIPT>
					 %loop urlTemplates%%value encode(html)%%loopsep ';'% %endloop%
                  </TD>
                  
                  <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
				  <script>				  
				  createForm("htmlform_security_oauth_scope_delete_%value $index%", "security-oauth-scope.dsp", "POST", "BODY");
				  setFormProperty("htmlform_security_oauth_scope_delete_%value $index%", "action", "delete");
				  setFormProperty("htmlform_security_oauth_scope_delete_%value $index%", "name", "%value name%");				  
				  </script>
					<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A href="javascript:document.htmlform_security_oauth_scope_delete_%value $index%.submit();" onClick="return confirmDeleteScope(\'%value name encode(url)%\');"><IMG src="icons/delete.png" alt="Delete Scope %value name%" border="none"></A>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="security-oauth-scope.dsp?action=delete&name=%value name encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDeleteScope(\'%value name encode(url)%\');"><IMG src="icons/delete.png" alt="Scope %value name%" border="none"></A>');
					}
					else {
						document.write('<A href="security-oauth-scope.dsp?action=delete&name=%value name encode(url)%" onClick="return confirmDeleteScope(\'%value name encode(url)%\');"><IMG src="icons/delete.png" alt="Scope %value name%" border="none"></A>');
					}
		       }
           </script>
                  </TD>     
                  <SCRIPT>swapRows();</SCRIPT>
              </TR>
    %endloop%
        
        
        </TABLE>
      
      
     </table>
  </body>   
</head>
