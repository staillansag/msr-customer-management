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
    </head>

    <body onLoad="setNavigation('enterprisegateway-mobile-app-protection.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_MobileApplicationProtectionOptionsScrn');">
   
        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Mobile&nbsp;Application&nbsp;Protection&nbsp;Options</td>
            </tr>

            %ifvar operation equals('operation_edit_deviceTypes')%
                %invoke wm.server.enterprisegateway:updateMobileDeviceTypes%
                    %ifvar message%
                        <tr><td colspan="2">&nbsp;</td></tr>
                        <tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                    %endif%
                    %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
                        <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                %endinvoke%
            %endif%

            %ifvar operation equals('operation_edit_mobileApps')%
                %invoke wm.server.enterprisegateway:updateMobileApplications%
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
                    <ul>
					
					<script>
						             createForm("htmlform_http_security_enterprisegateway_rules", "security-enterprisegateway-rules.dsp", "POST", "BODY");
					            </script>
					<script>
						             createForm("htmlform_http_enterprisegateway_device_types_edit", "enterprisegateway-device-types-edit.dsp", "POST", "BODY");
					            </script>
					<script>
						             createForm("htmlform_http_enterprisegateway_mobile_applications_edit", "enterprisegateway-mobile-applications-edit.dsp", "POST", "BODY");
					            </script>
					
					
                        <li>
						<script>getURL("security-enterprisegateway-rules.dsp","javascript:document.htmlform_http_security_enterprisegateway_rules.submit();","Return&nbsp;to&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules");</script></li>
                        <li>
						<script>getURL("enterprisegateway-device-types-edit.dsp","javascript:document.htmlform_http_enterprisegateway_device_types_edit.submit();","Edit&nbsp;Device Types");</script></li>
                        <li>
						<script>getURL("enterprisegateway-mobile-applications-edit.dsp","javascript:document.htmlform_http_enterprisegateway_mobile_applications_edit.submit();","Edit&nbsp;Mobile&nbsp;Applications");</script></li>
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
                                        <td class="heading" colspan="4">Device Types</td>
                                    </tr>
                                    <tr>
                                        <td class="oddrow" width="20%">
                                            Device Types
                                        </td>
                                        <td class="oddrowdata-l">
                                            %invoke wm.server.enterprisegateway:getMobileDeviceTypes%
                                                %ifvar mobileAppDeviceTypes equals('')%
                                                    None
                                                %else%
                                                    <TABLE width=100%>
                                                        <TR>
                                                            <TD class="oddrowdata-l">
                                                                <PRE class="fixedwidth">%value mobileAppDeviceTypes encode(html)% </PRE>
                                                            </TD>
                                                        </TR>
                                                    </TABLE>
                                                %endif%
                                            %endinvoke%
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/blank.gif"  border="0" width="5px" height="2px">
                </td>
            </tr>
            <tr>
                <td>
                    <table width="50%">
                        <tr>
                            <td>
                                <table class="tableView" width="100%">
                                    <tr>
                                        <td class="heading" colspan="4">Mobile Applications</td>
                                    </tr>
                                    <tr>
                                        <td class="oddrow" width="20%">
                                            Mobile Applications
                                        </td>
                                        <td class="oddrowdata-l">
                                            %invoke wm.server.enterprisegateway:getMobileApplications%
                                                %ifvar mobileApplications equals('')%
                                                    None
                                                %else%
                                                    <TABLE width=100%>
                                                        <TR>
                                                            <TD class="oddrowdata-l">
															    <PRE class="fixedwidth">%value mobileApplications encode(html)% </PRE>
                                                            </TD>
                                                        </TR>
                                                    </TABLE>
                                                %endif%
                                            %endinvoke%
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
