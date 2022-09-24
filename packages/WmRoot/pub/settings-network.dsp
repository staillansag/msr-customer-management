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
<SCRIPT LANGUAGE="JavaScript">
  
  function confirmDelete (alias) {
    var msg = "OK to delete the proxy alias '"+alias+"'?";
    if (confirm (msg)) {
        document.settingsNetwork.proxyAlias.value = alias;
        document.settingsNetwork.action.value = "delete";
        document.settingsNetwork.submit();
        return false;
    } 
    else 
        return false;
  }

  function confirmStatusChange(alias, action)
  {
    var msg = "";
    if ( action == "enable") {
        msg = "Are you sure you want to enable the proxy alias '"+alias+"'?";
    }
    else if ( action == "disable") {
        msg = "Are you sure you want to disable the proxy alias '"+alias+"'?";
    }

    if (confirm (msg)) {
        document.settingsNetwork.proxyAlias.value = alias;
        document.settingsNetwork.action.value = action;
        document.settingsNetwork.submit();
        return false;
    } 
    else 
        return false;
  }
  
</SCRIPT>
<base target="_self">
    <style>
      .listbox  { width: 50%; }
    </style>
</HEAD>
<BODY onLoad="setNavigation('settings-network.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ProxyServersScrn');">
<FORM name="settingsNetwork" action="settings-network.dsp" method="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <INPUT type="hidden" name="action" value="">
  <INPUT type="hidden" name="proxyAlias">
  <TABLE width="100%">
    <TR>
        <TD class="breadcrumb" colspan="2">
        Settings &gt;
        Proxy Servers </TD>
    </TR>

    %ifvar action%
        %switch action%
        %case 'add'%
            %invoke wm.server.proxy:createProxyServerAlias%
                %ifvar message%
                  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                %endif%
                %onerror%
                    %ifvar errorMessage%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                    %endif%
            %endinvoke%
        %case 'edit'%
            %invoke wm.server.proxy:createProxyServerAlias%
                %ifvar message%
                  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                %endif%
                %onerror%
                    %ifvar errorMessage%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                    %endif%
            %endinvoke%
        %case 'editBypass'%
            %invoke wm.server.admin:setSettings%
                %ifvar message%
                  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                %endif%
                %onerror%
                    %ifvar errorMessage%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                    %endif%
            %endinvoke%
        %case 'delete'%
            %invoke wm.server.proxy:deleteProxyServerAlias%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                %endif%
                %onerror%
                    %ifvar errorMessage%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                    %endif%
            %endinvoke%
        %case 'disable'%
            %invoke wm.server.proxy:disableProxyServerAlias%
                %ifvar message%
                  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                %endif%
                %onerror%
                    %ifvar errorMessage%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                    %endif%
            %endinvoke%   
        %case 'enable'%
            %invoke wm.server.proxy:enableProxyServerAlias%
                %ifvar message%
                  <tr><td colspan="2">&nbsp;</td></tr>
				  <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                %endif%
                %onerror%
                    %ifvar errorMessage%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                    %endif%
            %endinvoke%   
        %endswitch%
    %endif%
        
    <tr>
        <td colspan="2">
            <ul class="listitems">
				<script>
				createForm("htmlform_settings_proxy_addedit_add", "settings-proxy-addedit.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_proxy_addedit_add", "action", "add");
				createForm("htmlform_settings_proxy_addedit_edit_bypass", "settings-proxy-addedit.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_proxy_addedit_edit_bypass", "action", "editBypass");
				</script>
                <li class="listitem">
				<script>getURL("settings-proxy-addedit.dsp?action=add", "javascript:document.htmlform_settings_proxy_addedit_add.submit();", "Create Proxy Server Alias");</script>
				</li>
                <li class="listitem">
				<script>getURL("settings-proxy-addedit.dsp?action=editBypass", "javascript:document.htmlform_settings_proxy_addedit_edit_bypass.submit();", "Edit Proxy Bypass");</script>
				</li>
            </ul>
        </td>
    </tr>
    %invoke wm.server.proxy:getProxyServerList%
    <TR>
        <TD>
        <TABLE class="tableView" width=100%>
            <TR>
                <TD class="heading" colspan=8>Proxy Servers List</TD>
            </TR>
            <TR>
			   <TH class="oddcol" scope="col">Default</TH>	
			   <TH class="oddcol-l" scope="col">Alias</TH>
			   <TH class="oddcol" scope="col">Protocol</TH>			   
			   <TH class="oddcol" scope="col">Host</TH>
			   <TH class="oddcol" scope="col">Port</TH>
			   <TH class="oddcol" scope="col">User</TH>   
   			   <TH class="oddcol" scope="col">Enabled</TH>   
			   <TH class="oddcol" scope="col">Delete</TH>
            </TR>
            %loop -struct proxyServerList%
            %scope #$key%
            <TR>
                    <script>writeTD("rowdata");</script>
                        %ifvar isDefault equals('Y')%
                            <IMG SRC="images/green_check.png">
                        %endif%
                    </TD>               
                    <script>writeTD("rowdata-l");</script>
						<script>
						createForm("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "settings-proxy-addedit.dsp", "POST", "BODY");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "action", "edit");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "isDefault", "%value isDefault  %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "protocol", "%value protocol %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "socksVersion", "%value socksVersion %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "ftpType", "%value ftpType %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "proxyAlias", "%value proxyAlias %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "status", "%value status %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "host", "%value host %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "port", "%value port %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "username", "%value username %");
						setFormProperty("htmlform_settings_proxy_addedit_props_%value proxyAlias%", "password", "%value password %");
						</script>
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<a href="javascript:document.htmlform_settings_proxy_addedit_props_%value proxyAlias %.submit();">%value proxyAlias encode(html)%</a>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<a href="settings-proxy-addedit.dsp?action=edit&isDefault=%value isDefault encode(url) %&protocol=%value protocol encode(url)%&socksVersion=%value socksVersion encode(url)%&ftpType=%value ftpType encode(url)%&proxyAlias=%value proxyAlias encode(url)%&status=%value status encode(url)%&host=%value host encode(url)%&port=%value port encode(url)%&username=%value username encode(url)%&password=%value password encode(url)%&webMethods-wM-AdminUI=true">%value proxyAlias encode(html)%</a>');
								}
								else {
									document.write('<a href="settings-proxy-addedit.dsp?action=edit&isDefault=%value isDefault encode(url) %&protocol=%value protocol encode(url)%&socksVersion=%value socksVersion encode(url)%&ftpType=%value ftpType encode(url)%&proxyAlias=%value proxyAlias encode(url)%&status=%value status encode(url)%&host=%value host encode(url)%&port=%value port encode(url)%&username=%value username encode(url)%&password=%value password encode(url)%">%value proxyAlias encode(html)%</a>');
								}
							}
					   </script>
					    
                    </TD>
				    <script>writeTD("rowdata");</script>%value protocol encode(html)%</TD>					    
				    <script>writeTD("rowdata");</script>%value host encode(html)%</TD>
				    <script>writeTD("rowdata");</script>%value port encode(html)%</TD>
				    <script>writeTD("rowdata");</script>%value username encode(html)%</TD>
                    <script>writeTD("rowdata");</script>
						<script>
						createForm("htmlform_settings_network_%value port%", "settings-network.dsp", "POST", "BODY");
						</script>
                        %ifvar status equals('Disabled')%
							<script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<a href="javascript:document.htmlform_settings_network_%value port%.submit();" onClick="return confirmStatusChange(\'%value proxyAlias encode(javascript)%\', \'enable\');">No</a>');
								} else {
									%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<a href="settings-network.dsp?webMethods-wM-AdminUI=true" onClick="return confirmStatusChange(\'%value proxyAlias encode(javascript)%\', \'enable\');">No</a>');
									}
									else {
										document.write('<a href="settings-network.dsp" onClick="return confirmStatusChange(\'%value proxyAlias encode(javascript)%\', \'enable\');">No</a>');
									}
								}
							</script>
						   	
                        %else%
							<script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<a href="javascript:document.htmlform_settings_network_%value port%.submit();" onClick="return confirmStatusChange(\'%value proxyAlias encode(javascript)%\', \'disable\');">Yes</a>');
								} else {
									%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<a href="settings-network.dsp?webMethods-wM-AdminUI=true" onClick="return confirmStatusChange(\'%value proxyAlias encode(javascript)%\', \'disable\');">Yes</a>');
									}
									else {
										document.write('<a href="settings-network.dsp" onClick="return confirmStatusChange(\'%value proxyAlias encode(javascript)%\', \'disable\');">Yes</a>');
									}
								}
							</script>
						    
                        %endif%
                    <script>writeTD("rowdata");</script>
                        <a href="javascript:document.settingsNetwork.submit();" onClick="return confirmDelete('%value proxyAlias encode(javascript)%');">
                            <img src="icons/delete.png" alt="Proxy Server Alias : %value proxyAlias encode(htmlattr)%" border=0>
                        </a>
                    </TD>
            %endscope%
            </TR>
            <script>swapRows();</script>
            %endloop%
        %endinvoke%   
        </TABLE>
        </TD>
    </TR>
    
    %invoke wm.server.query:getSettings%    
        <TABLE class="tableView" width=100%>

    <TR><TD class="heading">Proxy Bypass</TD></TR>
    <tr>
        <td class="oddrowdata-l"><script>
            writeEdit("%value ../doc encode(javascript)%", "watt.net.proxySkipList",
                "%value watt.net.proxySkipList encode(html_javascript)%");
        </script></td>
    </tr>
</table>
    %endinvoke%
</table>
</form>
</body>
</html>
