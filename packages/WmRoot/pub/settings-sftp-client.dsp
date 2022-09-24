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
  <script src="webMethods.js"></script>
  <script language="JavaScript">
    <!--add jscript here-->
    function populateForm(form , glNm , ver, oper)
    {
    	var actionElement = form.getAttribute("action");
    	
        if('edit' == oper) {
            form.operation.value = "edit";
            actionElement = setQueryParamDelim(actionElement) + "operation=edit";
        }
        if('delete' == oper)
        {
            if (!confirm ("OK to delete '"+glNm+"'?")) {
                return false;
            }
            form.operation.value = 'delete';
            actionElement = setQueryParamDelim(actionElement) + "operation=delete";
        }
        form.alias.value = glNm;
		form.version.value = ver;
		actionElement = setQueryParamDelim(actionElement) + "operation=" + glNm + "&version=" + ver;
		
		form.setAttribute("action", actionElement);
		
        return true
    }
    
  </script>
  
  <body onLoad="setNavigation('settings-sftp-client.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SFTP');">
   
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> Settings &gt; SFTP </td>
        </tr>
            %ifvar operation equals('add')%
            %invoke wm.server.sftpclient:createServerAlias%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%   
        %ifvar operation equals('edit')%
            %invoke wm.server.sftpclient:updateServerAlias%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        %ifvar operation equals('delete')%
            %invoke wm.server.sftpclient:deleteServerAlias%
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
					<script>
					createForm("htmlform_settings_sftp_client_serveralias_addedit", "settings-sftp-client-serveralias-addedit.dsp", "POST", "BODY");
					setFormProperty("htmlform_settings_sftp_client_serveralias_addedit", "operation", "add");
					setFormProperty("htmlform_settings_sftp_client_serveralias_addedit", "version", "v2");
					createForm("htmlform_settings_sftp_client_usersettings", "settings-sftp-client-usersettings.dsp", "POST", "BODY");
					</script>
                    <li class="listitem">
					<script>getURL("settings-sftp-client-serveralias-addedit.dsp?operation=add&version=v2", "javascript:document.htmlform_settings_sftp_client_serveralias_addedit.submit();", "Create&nbsp;Server&nbsp;Alias");</script>
					
					</li>
                    <li class="listitem">
						<script>getURL("settings-sftp-client-usersettings.dsp", "javascript:document.htmlform_settings_sftp_client_usersettings.submit();", "User Alias Settings")</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
                <table width="50%">
                    <tr>
                        <td>    
                            <table class="tableView" width="100%">
                                <tr>
                                    <td class="heading" colspan="6">SFTP Server List</td>
                                </tr>
                                <tr>
					<TH class="oddcol" scope="col">Alias</TH>
					<TH class="oddcol" scope="col">Host</TH>
					<TH class="oddcol" scope="col">Port</TH>
					<TH class="oddcol" scope="col">Proxy Alias</TH>
					<TH class="oddcol" scope="col">Host Key Fingerprint</TH>
					<TH class="oddcol" scope="col">Delete</TH>									
                                </tr>
                                %invoke wm.server.sftpclient:listServerAliases%
                                    %loop SFTPServerAliases%
                                        <tr>
                                            <script>writeTD("row-l");</script>
												<a href="javascript:document.htmlform_sa_edit.submit();" onClick="return populateForm(document.htmlform_sa_edit,'%value alias encode(javascript)%', '%value version encode(javascript)%', 'edit');">
												   %value alias encode(html)%
                                                </a>   
                                            </td>
                                            <script>writeTD("rowdata");</script>
												 %value hostName encode(html)%
                                            </td>                       
                                            <script>writeTD("rowdata");</script>
												 %value port encode(html)%
                                            </td>
											<script>writeTD("rowdata");</script>
												%ifvar proxyAlias%
													%value proxyAlias encode(html)%
												%else%
													&lt;None&gt;
												%endif%  
                                            </td>
                                            <script>writeTD("rowdata");</script>
                                                 %value fingerprint encode(html)%
                                            </td>
                                            <script>writeTD("rowdata");</script>
												<a href="javascript:document.htmlform_sa_delete.submit();" onClick="return populateForm(document.htmlform_sa_delete,'%value alias encode(javascript)%','%value version encode(javascript)%','delete');">
                                                    <img src="icons/delete.png" alt="SFTP Server alias %value alias %" border="no">
                                                </a>    
                                            </td>
                                        </tr>
                                        <script>swapRows();</script>
                                    %endloop%
                                %endinvoke% 
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <form name="htmlform_sa_edit" action="settings-sftp-client-serveralias-addedit.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="alias">
		<input type="hidden" name="version">
    </form>
    <form name="htmlform_sa_delete" action="settings-sftp-client.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="alias">
		<input type="hidden" name="version">
    </form>
  </body>   
</head>
