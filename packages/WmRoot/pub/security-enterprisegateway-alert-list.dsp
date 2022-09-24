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
        <style>
          .cellBound{
                border:solid black 1px;
          }
        </style>
        <script>
            function confirmDelete(ruleName) {
                 return confirm("Are you sure you want to delete the rule " + ruleName + " ?");
            }

            function confirmEnableDisable(ruleName,operation) {
                return confirm("Are you sure you want to " + operation + " the rule " + ruleName + " ?");
            }

            function disableLink(link) {
                 link.disabled=true;
                 link.style.color='gray';
                 link.style.cursor='default';
                 link.onclick=function (){return false;}
            }

            function disableAllLinks() {
                var links=document.getElementsByTagName("a");
                for(i=0;i<links.length;i++) {
                    disableLink(links[i]);
                }
            }

            function disableDirectionImage(link,direction) {
                 disableLink(link)
                 if ('UP' == direction) {
                    link.src='icons/moveup_disabled.png';
                 } else{
                    link.src='icons/movedown_disabled.png';
                 }
            }
        </script>
    </head>

    <body onLoad="setNavigation('security-enterprisegateway-alert-list.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_DefaultAlertOptionsScrn');">
        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Default Alert Options</td>
            </tr>
            %ifvar operation equals('editAlertOptions')%
                %invoke wm.server.enterprisegateway:saveAlertOptions%
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
							createForm("htmlform_security_enterprisegateway_rules", "security-enterprisegateway-rules.dsp", "POST", "BODY");
							createForm("htmlform_security_enterprisegateway_alert_options", "security-enterprisegateway-alert-options.dsp", "POST", "BODY");
							setFormProperty("htmlform_security_enterprisegateway_alert_options", "global", "true");
							</script>
                            <li>
							<script>getURL("security-enterprisegateway-rules.dsp","javascript:document.htmlform_security_enterprisegateway_rules.submit();","Return&nbsp;to&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules");</script></li>
                            <li>
							<script>getURL("security-enterprisegateway-alert-options.dsp?global=true","javascript:document.htmlform_security_enterprisegateway_alert_options.submit();","Edit&nbsp;Default&nbsp;Alert&nbsp;Options");</script></li>

                    </ul>
                </td>
            </tr>
        </table>
        %scope param(rule='')%
            %invoke wm.server.enterprisegateway:getEnterpriseGatewayAlertOptions%
                <table  width="50%" class="tableView">
                    <tr>
                        <td colspan="2" class="heading">
                            Default Alert Options
                        </td>
                    </tr>
                    <tr>
                        <th width="10%" class="oddrow" scope="row" nowrap>
                            Alert Type
                        </th>
                        <td class="oddrowdata-l">
                            %ifvar alertType equals('flowService')%
                                Flow Service
                            %else%
                                %ifvar alertType equals('Email')%
                                    Email
                                %else%
                                    None
                                %endif%
                            %endif%
                        </td>
                    </tr>
                    %ifvar alertType equals('None')%
                    %else%
                        <tr>
                            <td class="evenrow" scope="row" nowrap>
                                Send Alert
                             </td>
                             <td class="evenrowdata-l">
                                %ifvar alertOnEvery equals('false')%
                                    Every %value alertInterval encode(html)% minutes
                                %else%
                                    On rule violation
                                %endif%
                             </td>
                         </tr>
                    %endif%
                    %ifvar alertType equals('None')%
                    %else%
                        <tr>
                            <td class="oddrow"  nowrap>
                                %ifvar alertType equals('Email')%Email Addresses%else%folder.subfolder:service%endif%
                            </td>
                            <td class="oddrowdata-l">
                                %ifvar alertType equals('Email')%
                                    %value emailTo encode(html)%
                                %else%
                                    %value flowServiceName encode(html)%
                                %endif%
                            </td>
                        </tr>
                        %ifvar alertType equals('flowService')%
                            <tr id="runAs" name="runAs">
                                <td class="oddrow"  nowrap>Run As User</td>
                                <td class="oddrowdata-l">%value runAsUser encode(html)%</td>
                            </tr>
                        %endif%
                    %endif%
                </table>
            %endinvoke%
        %endscope%
    </body>
</html>