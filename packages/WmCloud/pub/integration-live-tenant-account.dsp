<html>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">

    <title>Integration Server - webMethods Tenant Connection</title>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css">
    <link rel="stylesheet" type="text/css" href="metadata.css">

    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%

    <script src="jquery.js"></script>
    <script src="../WmRoot/webMethods.js"></script>
    <script src="jquery.js"></script>
    <script src="metadata.js"></script>

    <script language="JavaScript">

        function confirmDelete(alias) {
            if ('default' == alias) {
                alert( alias + " is the alias for the default tenant connection.  It may not be deleted.");
                return false;
            }
            var msg = "Delete tenant connection '" + alias + "'?";
            if (confirm(msg)) {
                document.tenantForm.alias.value = alias;
                document.tenantForm.theAction.value = 'delete';
                document.tenantForm.submit();
                return true;
            }
            else
                return false;
        }

        function validateFields() {
            if (!verifyRequiredField("tenantForm", "alias")) {
                alert("Tenant alias is required.");
                return false;
            }

            if (!verifyRequiredField("tenantForm", "username")) {
                alert("User Name is required.");
                return false;
            }
            if (!(verifyRequiredField("tenantForm", "iliveURL"))) {
                alert("webMethods Cloud URL is required.");
                return false;
            }

            return true;
        }

function submitForm(){
            document.getElementById("submitAppName").value=document.getElementById("applicationName").value;
            document.getElementById("submitDesc").value=document.getElementById("description").value;
}

function editTenant(alias){
    document.forms['tenantForm'].alias.value=alias;
    document.forms['tenantForm'].action='integration-live-tenant-account-addedit.dsp';

	var params = parseQueryString();
	if (params["webMethods-wM-AdminUI"]) {
		var element = document.createElement("input");
		element.setAttribute("type", "hidden");
		element.setAttribute("name", 'webMethods-wM-AdminUI');
		element.setAttribute("value", 'true');
		
		document.forms['tenantForm'].appendChild(element);
	}

    return true;
}


</script>
</head>

<body onLoad="setNavigation('integration-live-tenant-account.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_SettingsScrn');">

    <form name="tenantForm" action="integration-live-tenant-account.dsp" id="tenantForm" method="POST">
        <input type="hidden" name="alias" id="alias"/>
        <input type="hidden" name="theAction" id="theAction"/>

  <TABLE WIDTH="100%">

    <tr>
      <td class="breadcrumb" colspan="3">
        webMethods Cloud &gt; Tenant Connections
      </td>
     </tr>
        <!-- <div id="message" /> (If jQuery-UI tabs) -->
        <tr><td hidden="true" id="message" class="message" colspan="2"></td></tr>


        %ifvar theAction -notempty%

            %switch theAction%
                %case 'enable'%

                    %invoke wm.client.integrationlive.account:updateTenantEnabled%
                        %ifvar transferInfo%
                            <script LANGUAGE="JavaScript">
                                var tiData="%value transferInfo encode(javascript)%";
                                showTransferInfoMessages( tiData, 'message');

                            </script>

                        %endif%

                    %endinvoke%



                %case 'disable'%

                    %invoke wm.client.integrationlive.account:updateTenantEnabled%
                        %ifvar transferInfo%
                            <script LANGUAGE="JavaScript">
                                var tiData="%value transferInfo encode(javascript)%";
                                showTransferInfoMessages( tiData, 'message');
                            </script>
                        %endif%
                        %onerror%
                            <tr><td colspan="3">&nbsp;</td></tr>
                            <tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
                    %endinvoke%

                %case 'delete'%

                    %invoke wm.client.integrationlive.account:deleteAccountInfo%
                        %ifvar transferInfo%
                            <script LANGUAGE="JavaScript">
                                var tiData="%value transferInfo encode(javascript)%";
                                showTransferInfoMessages( tiData, 'message');
                            </script>
                        %endif%
                        %onerror%
                            <tr><td colspan="3">&nbsp;</td></tr>
                            <tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>

                    %endinvoke%


                %case 'test'%

                    %invoke wm.client.integrationlive.account:testTenantAccount%
                        %ifvar transferInfo%
                            <script LANGUAGE="JavaScript">
                                var tiData="%value transferInfo encode(javascript)%";
                                showTransferInfoMessages( tiData, 'message');
                            </script>
                        %endif%
                        %onerror%
                            <tr><td colspan="3">&nbsp;</td></tr>
                            <tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>

                    %endinvoke%

                %case 'save'%

                    %invoke wm.client.integrationlive.account:updateAccountInfo%
                        %ifvar transferInfo%
                            <script LANGUAGE="JavaScript">
                                var tiData="%value transferInfo encode(javascript)%";
                                showTransferInfoMessages( tiData, 'message');
                            </script>
                        %endif%
                        %onerror%
                            <tr><td colspan="3">&nbsp;</td></tr>
                            <tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
                    %endinvoke%

            %endswitch%
        %endif action%

        <TR>
            <TD colspan="2">
                <UL class="listitems">
                    <LI>

                        <script>
                                if (is_csrf_guard_enabled && needToInsertToken) {
                                    document.write('<A HREF="javascript:document.htmlform_integration_live_tenant_account_addedit.submit();" onClick="setNavigation(\'integration-live-tenant-account-addedit.dsp\', \'/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_CreateTenantScrn\');">Create Tenant Connection</A>');
                                } else {
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<A HREF="integration-live-tenant-account-addedit.dsp?action=add&isEnabled=true&webMethods-wM-AdminUI=true" onClick="setNavigation(\'integration-live-tenant-account-addedit.dsp\', \'/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_CreateTenantScrn\');">Create Tenant Connection</A>');
									}
									else {
	                                    document.write('<A HREF="integration-live-tenant-account-addedit.dsp?action=add&isEnabled=true" onClick="setNavigation(\'integration-live-tenant-account-addedit.dsp\', \'/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_CreateTenantScrn\');">Create Tenant Connection</A>');
	                                }
                                }

                        </script>
                    </LI>
                </UL>
            </TD>
        </TR>

        <TR>
            <TD width="98%">
                <TABLE width="75%" class="tableView">
                    <TR>
                        <TD class="heading" colspan="8">Tenant Connections</TD>
                    </TR>

                    %invoke wm.client.integrationlive.account:listTenantConnections%

                        %ifvar transferInfo%
                            <script LANGUAGE="JavaScript">
                                //TODO this gets duplicated if a prior function (e.g. test) contained transferInfo data
                                //var tiData="%value transferInfo encode(javascript)%";
                                //showTransferInfoMessages( tiData, 'message');

                            </script>

                        %endif%

                    %endinvoke%

                    <TR>
                        <TH scope="col" class="oddcol-l cloud-table-cell" width="20%">Alias</TH>
                        <TH scope="col" class="oddcol-l cloud-table-cell" width="20%">Username</TH>
                        <TH scope="col" class="oddcol-l cloud-table-cell" width="20%">Tenant URL</TH>
                        <TH scope="col" class="oddcol cloud-table-cell" width="5%">Test</TH>
                        <TH scope="col" class="oddcol cloud-table-cell" width="10%">Enabled</TH>
                        <TH scope="col" class="oddcol cloud-table-cell" width="5%">Delete</TH>
                    </TR>


                    %loop TenantConnections%

                    <TR>
                        <TD class="row-l cloud-table-cell">
                            <A href="javascript:document.forms['tenantForm'].submit()" onClick="return editTenant('%value alias%');">
                                %value alias encode(html)%
                                </A>

                        </TD>

                        <TD class="row-l cloud-table-cell">
                            %value username encode(html)%
                        </TD>

                        <TD class="rowdata cloud-table-cell">
                            %value iLiveURL encode(html)%
                        </TD>

                        <TD class="rowdata cloud-table-cell" style="text-align:center;vertical-align:middle">


                            <script>

                                if (is_csrf_guard_enabled && needToInsertToken) {
                                    document.write('<A href="javascript:document.tenantForm.submit();" onClick="return populateForm(document.tenantForm, \'theAction=test;alias=%value alias%;\')"><IMG src="../WmRoot/icons/checkdot.gif" alt="Test alias %value alias%" border="none"></A>');
                                } else {
                                    document.write('<A href="integration-live-tenant-account.dsp?theAction=test&alias=%value alias encode(url)%"><IMG src="../WmRoot/icons/checkdot.gif" alt="Test alias %value alias%" border="none"></A>');
                                }

                            </script>

                        </TD>

                        <!-- Enable -->

                        <TD class="rowdata cloud-table-cell" style="text-align:center;vertical-align:middle">

                            %switch isEnabled%
                            %case 'true'%

                            <script>
                                if (is_csrf_guard_enabled && needToInsertToken) {
                                    document.write('<a href="javascript:document.tenantform.submit();" onClick="return populateForm(document.tenantForm, \'theAction=disable;alias=%value alias%\')"><img style="width: 13px; height: 13px;" alt="enabled" border="0" alt="Disable alias %value alias%" src="../WmRoot/images/green_check.gif">Yes</a>');
                                } else {
                                    document.write('<a href="integration-live-tenant-account.dsp?theAction=disable&alias=%value alias encode(url)%"><img style="width: 13px; height: 13px;" alt="enabled" border="0" alt="Disable alias %value alias%" src="../WmRoot/images/green_check.gif">Yes</a>');
                                }
                            </script>

                            %case 'false'%

                            <script>
                                if (is_csrf_guard_enabled && needToInsertToken) {
                                    document.write('<a href="javascript:document.tenantform.submit();" onClick="return populateForm(document.tenantForm, \'theAction=enable;alias=%value alias%\')">No</a>');
                                } else {
                                    document.write('<a href="integration-live-tenant-account.dsp?theAction=enable&alias=%value alias encode(url)%">No</a>');
                                }
                            </script>

                            %endswitch%
                        </TD>

                        <!-- Delete -->

                        <TD class="rowdata cloud-table-cell" style="text-align:center;vertical-align:middle">

                                <script>
                                        if (is_csrf_guard_enabled && needToInsertToken) {
                                            document.write('<IMG src="../WmRoot/icons/delete.gif" alt="Delete alias %value alias%" border="none" onClick="confirmDelete(\'%value alias encode(javascript)%\');">');
                                        } else {
                                            document.write('<IMG src="../WmRoot/icons/delete.gif" alt="Delete alias %value alias%" border="none" onClick="confirmDelete(\'%value alias encode(javascript)%\');">');
                                        }
                                </script>

                        </TD>
                        <SCRIPT>swapRows();</SCRIPT>
                    </TR>

                    %endloop%
                </TABLE>
            </TD>
        </TR>
    </TABLE>

    </form>
    </body>
</html>
