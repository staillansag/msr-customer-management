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
    function populateForm(form , aliasNM ,oper)
    {
    	var actionElement = form.getAttribute("action");
    	
        if('edit' == oper) {
            form.operation.value = "edit";
            actionElement = setQueryParamDelim(actionElement) + "operation=edit";
        }
        if('test' == oper) {
            form.operation.value = "test";
            actionElement = setQueryParamDelim(actionElement) + "operation=test";
        }
        if('remove' == oper)
        {
            if (!confirm ("OK to delete '"+aliasNM+"'?")) {
                return false;
            }
            form.operation.value = 'remove';
            actionElement = setQueryParamDelim(actionElement) + "operation=remove";
        }
        form.alias.value = aliasNM;
        actionElement = setQueryParamDelim(actionElement) + "alias=" + aliasNM;
        
        form.setAttribute("action", actionElement);
        
        return true
    }
    
  </script>
  
  <body onLoad="setNavigation('settings-sftp-client-usersettings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SFTP_UserAliasSettings');">
   
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> Settings &gt; SFTP &gt; User Alias Settings</td>
        </tr>
        %ifvar operation equals('add')%
            %invoke wm.server.sftpclient:createUserAlias%
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
            %invoke wm.server.sftpclient:updateUserAlias%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        %ifvar operation equals('remove')%
            %invoke wm.server.sftpclient:removeUserAlias%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%     
        %ifvar operation equals('test')%
            %invoke wm.server.sftpclient:testConnection%
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
					createForm("htmlform_settings_sftp_client", "settings-sftp-client.dsp", "POST", "BODY");
					createForm("htmlform_settings_sftp_client_useralias_addedit", "settings-sftp-client-useralias-addedit.dsp", "POST", "BODY");
					setFormProperty("htmlform_settings_sftp_client_useralias_addedit", "operation", "add");
					</script>
                    <li class="listitem">
					<script>getURL("settings-sftp-client.dsp", "javascript:document.htmlform_settings_sftp_client.submit();", "Return to SFTP");</script>
					</li>
                    <li class="listitem">
					<script>getURL("settings-sftp-client-useralias-addedit.dsp?operation=add", "javascript:document.htmlform_settings_sftp_client_useralias_addedit.submit();", "Create&nbsp;User&nbsp;Alias");</script>
					
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
                                    <td class="heading" colspan="7">SFTP User List</td>
                                </tr>
                                <tr>
					<TH class="oddcol-l" scope="col">SFTP User Alias</TH>
					<TH class="oddcol" scope="col">SFTP Server Alias</TH>
					<TH class="oddcol" scope="col">User</TH>
					<TH class="oddcol" scope="col">Authentication Type</TH>					
					<TH class="oddcol" scope="col">Test</TH>
					<TH class="oddcol" scope="col">Delete</TH>
                                </tr>
                                %invoke wm.server.sftpclient:listUserAliases%
                                    %loop SFTPUserAliases%
                                        <tr>
                                            <script>writeTD("row-l");</script>
												<a href="javascript:document.htmlform_sftpUser_edit.submit();" onClick="return populateForm(document.htmlform_sftpUser_edit,'%value alias encode(javascript)%','edit');">
												   %value alias encode(html)%
                                                </a>   
                                            </td>
                                            <script>writeTD("rowdata");</script>
												 %value sftpServerAlias encode(html)%
                                            </td>
                                            <script>writeTD("rowdata");</script>
												 %value userName encode(html)%
                                            </td>                       
                                            <script>writeTD("rowdata");</script>
                                            %ifvar authenticationType equals('password')%
                                                Password
                                            %else%
                                                %ifvar authenticationType equals('publicKey')%
                                                    Public Key 
                                                %else%
													%value authenticationType encode(html)%
                                                %endif%
                                            %endif%
                                            </td>
                                            <script>writeTD("rowdata");</script>
												<a href="javascript:document.htmlform_sftpUser_delete.submit();" onClick="return populateForm(document.htmlform_sftpUser_delete,'%value alias encode(javascript)%','test');">
                                                    <img src="icons/checkdot.png" border="none" alt="SFTP User Alias %value alias%" width="14" height="14">
                                                </a>
                                            </td>
                                            <script>writeTD("rowdata");</script>
												<a href="javascript:document.htmlform_sftpUser_delete.submit();" onClick="return populateForm(document.htmlform_sftpUser_delete,'%value alias encode(javascript)%','remove');">
                                                    <img src="icons/delete.png" alt="SFTP User Alias %value alias%" border="no">
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
    <form name="htmlform_sftpUser_edit" action="settings-sftp-client-useralias-addedit.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="alias">
    </form>
    <form name="htmlform_sftpUser_delete" action="settings-sftp-client-usersettings.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="alias">
    </form>
  </body>   
</head>
