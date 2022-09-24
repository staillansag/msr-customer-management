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
        <script>
        function validate(form) {
            return true;
        }
        </script>
    </head>
    <body onLoad="setNavigation('enterprisegateway-mobile-applications-edit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_MobileApplicationProtectionOptionsEditMobileApplicationsScrn');">
        <form name="html_comm" id="html_comm" action="enterprisegateway-mobile-app-protection.dsp" method="post">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            <input type="hidden" name="operation" id="operation" value="operation_edit_mobileApps">
            <table width="100%">
                <tr>
                    <td class="breadcrumb" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Mobile&nbsp;Application&nbsp;Protection&nbsp;Options&nbsp;&gt;&nbsp;Mobile&nbsp;Applications&nbsp;&gt;&nbsp;Edit</td>
                </tr>
                %invoke wm.server.enterprisegateway:getMobileApplications%
                    %ifvar message%
                        <tr><td colspan="2">&nbsp;</td></tr>
                        <tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                    %endif%
                    %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
                        <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                %endinvoke%
                <tr>
                    <td colspan="2">
                        <ul>
						
						<script>
						             createForm("htmlform_http_enterprisegateway_mobile_app_protection", "enterprisegateway-mobile-app-protection.dsp", "POST", "BODY");
					    </script>
						
                            <li>
							<script>getURL("enterprisegateway-mobile-app-protection.dsp","javascript:document.htmlform_http_enterprisegateway_mobile_app_protection.submit();","Return&nbsp;to&nbsp;Mobile&nbsp;Application&nbsp;Protection&nbsp;Options");</script></li>
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
										<td class="heading" colspan="2"><label for="mobileApplications">Mobile Applications</label></td>
                                        </tr>
                                        <tr>
                                            <td class="oddrow" width="20%">
                                                Mobile Applications
                                            </td>
                                            <td class="oddrow-l">
                                                <textarea name="mobileApplications" wrap="off" id="mobileApplications"  rows="4" cols="50" style="width:100%">%value mobileApplications encode(html)%</textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                           <td class="oddrow"/>
                                           <td class="oddrow-l" colspan=2>Enter one application per line</TD>
                                        </tr>

                                        <tr class="action">
                                            <td  colspan="2" width="100%">
                                                <input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);">
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
