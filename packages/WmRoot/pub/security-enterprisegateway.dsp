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
        <SCRIPT SRC="webMethods.js"></SCRIPT>
    </head>
    <body onLoad="setNavigation('security-enterprisegateway.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRulesScrn');">
        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules</td>
            </tr>
            <tr>
                <td colspan="2">
                    <ul class="listitems">
						<script>
						createForm("htmlform_security_enterprisegateway_alert_list", "security-enterprisegateway-alert-list.dsp", "POST", "BODY");
						createForm("htmlform_enterprisegateway_dos_options", "enterprisegateway-dos-options.dsp", "POST", "BODY");
						createForm("htmlform_enterprisegateway_mobile_app_protection", "enterprisegateway-mobile-app-protection.dsp", "POST", "BODY");
						createForm("htmlform_security_enterprisegateway_rules", "security-enterprisegateway-rules.dsp", "POST", "BODY");
						</script>
                        <li>
						<script>getURL("security-enterprisegateway-alert-list.dsp","javascript:document.htmlform_security_enterprisegateway_alert_list.submit();","Default Alert Options");</script></li>
                        <li>
						<script>getURL("enterprisegateway-dos-options.dsp","javascript:document.htmlform_enterprisegateway_dos_options.submit();","Denial of Service Options");</script></li>
						<li>
						<script>getURL("enterprisegateway-mobile-app-protection.dsp","javascript:document.htmlform_enterprisegateway_mobile_app_protection.submit();","Mobile Application Protection Options");</script></li>
                        <li>
						<script>getURL("security-enterprisegateway-rules.dsp","javascript:document.htmlform_security_enterprisegateway_rules.submit();","Rules");</script></li>
                    </ul>
                </td>
            </tr>
        </table>
    </body>
</html>
