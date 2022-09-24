<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <title>Integration Server Settings</title>
        <link rel="stylesheet" type="text/css" href="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <script src="webMethods.js"></script>
    </head>

    <body onLoad="setNavigation('settings-license.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LicensingScrn');">
        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan="2">Settings &gt; License</td>
            </tr>

            <tr>
                <td colspan="2">
                    <ul class="listitems">
						<script>
						createForm("htmlform_settings_license_edit", "settings-license-edit.dsp", "POST", "BODY");
						</script>
                        <li class="listitem">
						<script>getURL("settings-license-edit.dsp","javascript:document.htmlform_settings_license_edit.submit();","Licensing Details")</script>
						</li>
                    </ul>
                </td>
            </tr>

            <tr>
                <td>
                    <table class="tableView" width="25%">
                        <tr>
                            <td class="heading" colspan="11">License Information</td>
                        </tr>

                        <tr>
                            <th class="oddcol" scope="col">Feature Name</th>
                            <th class="oddcol" scope="col">Enabled</th>
                        </tr>

                        %invoke wm.server.query:getLicenseInfo%
                            %loop LicenseInfo%
                                %loop -struct%
                                    <tr>
                                        <td class="row">%value $key encode(html)%</td>
                                        %ifvar #$key equals('true')%
                                            <td class="rowdata"><img src="images/green_check.png" border="no">&nbsp;Yes</td>
                                        %else%
                                            <td class="rowdata"><img src="icons/delete.png" border="no">&nbsp;No</td>
                                        %endif%
                                    </tr>
                                %endloop%
                            %endloop%
                        %endinvoke%
                    </table>
                </td>
            </tr>

        </table>
    </body>
</html>
