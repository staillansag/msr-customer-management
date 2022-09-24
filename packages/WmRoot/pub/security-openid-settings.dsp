<HTML>
  <HEAD>

       <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>

    <TITLE>Integration Server -- OpenID Management</TITLE>
    <SCRIPT LANGUAGE="JavaScript">
        function deleteProvider (name) {
            
            var msg = "OK to delete OpenID Provider '"+name+"'?";
            if (confirm (msg)) {
                    document.deleteform.name.value = name;
                    document.deleteform.submit();
                      return false;
            } else return false;
          }
    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('security-openid-settings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OpenID');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan="2"> Security &gt; OpenID </TD>
      </TR>
      
      %ifvar mode%
          %switch mode%
           %case 'delete'%
             %invoke wm.server.security.openid:deleteIdProvider%
                      %ifvar message%
                            <tr><td colspan="2">&nbsp;</td></tr>
                            <TR><TD class="message" colspan="2">%value message%</TD></TR>
                      %endif%
                %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
                        <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
               %endinvoke% 
            %case 'reload'%
             %invoke wm.server.security.openid:reloadProviders%
                      %ifvar message%
                            <tr><td colspan="2">&nbsp;</td></tr>
                            <TR><TD class="message" colspan="2">%value message%</TD></TR>
                      %endif%
                %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
                        <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
               %endinvoke% 
         %endswitch%
     %endif%

      <TR>
        <TD colspan="2">
          <ul class="listitems">
		    <script>
			createForm("htmlform_security_openid_settings_reload", "security-openid-settings.dsp", "POST", "BODY");					
			setFormProperty("htmlform_security_openid_settings_reload", "mode", "reload");
			</script>
            <LI class="listitem">
			<script>getURL("security-openid-settings.dsp?mode=reload","javascript:document.htmlform_security_openid_settings_reload.submit();","Reload OpenID Providers");</script></li>
          </UL>
        </TD>
      </TR>
      <TR>
        <td>
            <table width="100%">
                <tr>
                    <td>
                        <TABLE class="tableView" width="100%">
           
                <TR>
                  <TD class="heading" colspan="8">OpenID Provider List</TD>
                </TR>

                <TR class="subheading2">
                  <TH scope="col">Name</TH>
                  <TH scope="col">Issuer</TH>
                  <TH scope="col">Client ID</TH>
                  <TH scope="col">Delete Provider</TH>
                </TR>
                
                %invoke wm.server.security.openid:getIdProviders%
                %loop providers%
                    <TR>

                      <script>writeTD("rowdata");</script>%value name%</TD>
                      <script>writeTD("rowdata");</script>%value issuer%</TD>
                      <script>writeTD("rowdata");</script>%value client_id%</TD>
                      <script>writeTD("rowdata");</script>
						<script>
						createForm("htmlform_security_openid_settings_%value $index%", "security-openid-settings.dsp", "POST", "BODY");											
						</script>
                          <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a class="imagelink"  href="javascript:document.htmlform_security_openid_settings_%value $index%.submit();" onClick="return deleteProvider(\'%value name%\');"><img src="icons/delete.png" alt="Delete Provider %value name encode(javascript)%" border="none"></a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a class="imagelink"  href="security-openid-settings.dsp?webMethods-wM-AdminUI=true" onClick="return deleteProvider(\'%value name%\');"><img src="icons/delete.png" alt="Delete Provider %value name encode(javascript)%" border="none"></a>');
					}
					else {
						document.write('<a class="imagelink"  href="security-openid-settings.dsp" onClick="return deleteProvider(\'%value name%\');"><img src="icons/delete.png" alt="Delete Provider %value name encode(javascript)%" border="none"></a>');
					}
		       }
           </script>
                      </TD>

                    </TR>
                    <script>swapRows();</script>
                %endloop%
                %endinvoke%
                
          </TABLE>
                    </td>
                </tr>
            </table>
        </td>
      </TR>
    </TABLE>


    <form name="deleteform" action="security-openid-settings.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="name">
        <input type="hidden" name="mode" value="delete">
    </form>

  </BODY>
</HTML>

