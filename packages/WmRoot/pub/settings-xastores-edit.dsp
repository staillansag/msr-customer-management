<HTML>
    <script Language="JavaScript">
    
        function verifyNonblankField(v, name)
        {
            if (isblank(v.value)) {
                alert(name + " is required.");
                return false;
            }
            else {
                return true;
            }
        }

        function verifyPositiveIntegerField(v, name, needCheck)
        {
            if (needCheck)
            {
                if (isblank(v.value)) {
                    alert(name + " is required.");
                    return false;
                }
                else if (!isNum(v.value) || parseInt(v.value) <= 0) {
                    alert("Value must be a positive integer: "+name);
                    return false;
                }
                else {
                    return true;
                }
            } else
                return true;
        }

        function confirmEdit(isBrokerConfigured) {
            var defaultStoreDBGroup                 = document.editform.defaultStoreDBGroup;
            var defaultStoreDBSize                  = document.editform.defaultStoreDBSize;

            if (verifyNonblankField(defaultStoreDBGroup, "Store Location")  &&
                verifyPositiveIntegerField(defaultStoreDBSize, "Initial Store Size", true))
                       
                return true;
            else
                return false;
        }
        
    </script>

    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <SCRIPT SRC="webMethods.js"></SCRIPT>
    </HEAD>

    <BODY onLoad="setNavigation('settings-xastores-edit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditXARecoveryStoreScrn');">
        <TABLE width="90%">
            <TR>
                <TD class="breadcrumb" colspan="2">
                    Settings &gt; Resources &gt; Store Settings &gt; Edit XA Recovery Store Settings<br>
                </TD>
            </TR>

            <TR>
                <TD colspan="2">
                    <ul class="listitems">
                        <li class="listitem">
						<script>
						createForm("htmlform_settings_docstores", "settings-docstores.dsp", "POST", "BODY");
						</script>
						<script>getURL("settings-docstores.dsp", "javascript:document.htmlform_settings_docstores.submit();", "Return to Store Settings");</script>
						
						</li>
                    </UL>
                </TD>
            </TR>

            <TR>
                <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
                <TD width="100%">
                    <TABLE class="tableView">
                        <FORM NAME="editform" ACTION="settings-docstores.dsp" METHOD="POST" onsubmit="return confirmEdit()">
                            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                            <input type="hidden" name="action" value="editXA" />

                                %invoke wm.server.xarecovery:getXARecoveryStoreSettings%
                                
                                <TR>
                                    <TD class="heading" colspan=3>XA Recovery Store</TD>
                                </TR>

                                <TR>
                                    <TD class="oddrow"><label for="defaultStoreDBGroup">Store Location</label></TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT NAME="defaultStoreDBGroup" id="defaultStoreDBGroup" VALUE="%value defaultStoreDBGroup encode(htmlattr)%" />
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </TR>
                                <TR>
                                    <TD class="evenrow"><label for="defaultStoreDBSize">Initial Store Size (MB)</label></TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT NAME="defaultStoreDBSize" id="defaultStoreDBSize" VALUE="%value defaultStoreDBSize encode(htmlattr)%" />
                                    </TD>
                                    <TD class="evenrowdata-l">*</TD>
                                </TR>
                                
                                %onerror%
                                    <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
                                %endinvoke%
                                           
                                <TR>
                                    <TD class="space" colspan=3>&nbsp;</TD>
                                </TR>

                                <tr>
                                    <td class="space" colspan=3>* Server restart is required for settings to take effect.</td>
                                </tr>

                                <TR>
                                    <TD class="action" colspan=3>
                                        <input type="submit"
                                               name="submit"
                                               value="Save Changes"/>
                                    </TD>
                                </TR>

                        </FORM>
                    </TABLE>
                </TD>
            </TR>
        </TABLE>
    </BODY>
</HTML>
