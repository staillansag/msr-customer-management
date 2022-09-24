<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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

    <body onLoad="setNavigation('enterprisegateway-dos-options.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_DoSOptionsScrn');">
        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Denial&nbsp;of&nbsp;Service&nbsp;Options</td>
            </tr>
        
            <tr>
                <td colspan="2">
                    <table width="50%">
                        %ifvar limitBy%
                            %invoke wm.server.enterprisegateway:saveDOS%
                                %ifvar message%
                                    <tr><td colspan="2">&nbsp;</td></tr>
								    <tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                                %endif%
                                %onerror%
                                    <tr><td colspan="2">&nbsp;</td></tr>
								    <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                            %endinvoke%
                        %endif%
                        %ifvar action equals('delete')%
                            %invoke wm.server.enterprisegateway:deleteIPFromDeniedList%
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
						             createForm("htmlform_http_security_enterprisegateway_dos", "security-enterprisegateway-dos.dsp", "POST", "BODY");
									 setFormProperty("htmlform_http_security_enterprisegateway_dos", "limitBy", "GLOBALIP");
					            </script>
								
								<script>
						             createForm("htmlform_http_security_enterprisegateway_dos2", "security-enterprisegateway-dos.dsp", "POST", "BODY");
									 setFormProperty("htmlform_http_security_enterprisegateway_dos2", "limitBy", "IP");
					            </script>
								
								
                                    <li>
									<script>getURL("security-enterprisegateway-rules.dsp","javascript:document.htmlform_http_security_enterprisegateway_rules.submit();","Return to Enterprise Gateway Rules");</script></li>
                                    <li>
									<script>getURL("security-enterprisegateway-dos.dsp?limitBy=GLOBALIP","javascript:document.htmlform_http_security_enterprisegateway_dos.submit();","Configure Global Denial of Service");</script></li>
                                    <li>
									<script>getURL("security-enterprisegateway-dos.dsp?limitBy=IP","javascript:document.htmlform_http_security_enterprisegateway_dos2.submit();","Configure Denial of Service by IP Address");</script></li>
									
									
									
                                </ul>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table width="100%" class="tableView">
            %include security-enterprisegateway-dos-global.dsp%
            %include security-enterprisegateway-dos-IP.dsp%
            %include enterprisegateway-denied-ip-list.dsp%
        </table>
    </body>
</html>
