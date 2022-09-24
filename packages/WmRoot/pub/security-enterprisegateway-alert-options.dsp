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
        <script>

            function toggleEveryMinute(rulename)
            {
                var everyReq = document.getElementById("everyReq");
                var everyMinute = document.getElementById("alertInterval");
                if(everyReq.checked)
                {
                    everyMinute.readOnly=true;
                    everyMinute.value="";
                }
                else
                {
                    everyMinute.disabled=false;
                everyMinute.readOnly=false;
                }
            }

            function validateForm()
            {
                // Don't Validate If Default Option is selected
                var defaultAlertSettings = document.getElementById("defaultAlertSettings");
                if((null!=defaultAlertSettings) && (defaultAlertSettings.checked))
                {
                    return true;
                }

              var selObj = document.getElementById("alertType");
                var selIndex = selObj.selectedIndex;
              if(0 == selIndex){
                   return true;
              }

                // Validate if Default Option is not selected
                var numIntervalElem = document.getElementById("alertInterval");
                var numInterval = numIntervalElem.value;
                var everyReq = document.getElementById("everyReq");
                if(!everyReq.checked)
                {
                    if((isEmpty (numInterval) || isNaN(numInterval)) || parseInt(numInterval) < 1)
                    {
                        alert("Please enter valid number for minutes");
                        numIntervalElem.focus();
                        return false;
                    }
                }
                if(1==selIndex)
                {
                    var emailIDsElem = document.getElementById("emailTo");
                    var emailIDs = emailIDsElem.value;
                    if( isEmpty (emailIDs) || false == isValidEmail(emailIDs) )
                    {
                        alert("Please enter valid Email-IDs (Maximum limit per Email-ID is 255 characters)");
                        emailIDsElem.focus();
                        return false;
                    }
                }
                else if(2==selIndex)
                {   // Flow service name and run as User can't be empty
                    var FSName = document.getElementById("flowServiceName");
                    var flowServiceName = FSName.value;
                    var runAs = document.getElementById("runAsUser");
                    var runAsUserName = runAs.value;

                    var idx = flowServiceName.lastIndexOf(":");

                if( isEmpty(flowServiceName) )
                    {
                        alert("Please enter valid Flow service name");
                        FSName.focus();
                        return false;
                    }
                    else if (idx < 1 || idx >= flowServiceName.length-1) {
                  alert ("Specify service name as 'folder.subfolder:service'");
                  FSName.focus();
                  return false;
                }
                    else if( isEmpty(runAsUserName) )
                    {
                        alert("Please enter valid User");
                        runAs.focus();
                        return false;
                    }
                }
                return true;
            }

            function isValidEmail(emailId)
            {
                var separatedIds = emailId.split(';');
                for(var email in separatedIds)
                {
                    if(false == validateEmailId(separatedIds[email]))
                    {
                        return false;
                    }
                    else if (separatedIds[email].length > 255)
                    {
                        return false;
                    }
                }
                return true;
            }

            function validateEmailId(emailId)
            {
                var pattern=/^([_a-zA-Z0-9-]+)(\.[_a-zA-Z0-9-]+)*@([a-zA-Z0-9-]+\.)+([a-zA-Z]{2,3})$/;
                return  pattern.test(emailId);
            }

            function  trim (msg)
            {
                return msg.replace(/^\s+|\s+$/g, "");
            }

            function isEmpty (msg)
            {
                return  trim (msg).length == 0;
            }
            function changeOptions() {
                var selObj = document.getElementById("alertType");
                var selIndex = selObj.selectedIndex;
                if(0 == selIndex){
                document.getElementById("target_email").style.display = "none";
                document.getElementById("target_service").style.display = "none";
                document.getElementById("target_inputs").style.display = "none";
                    document.getElementById("flowServiceName").style.display='none';
                    document.getElementById("emailNote").style.display='none';
                    document.getElementById("runAs").style.display='none';
                    document.getElementById("emailTo").style.display='none';
                    document.getElementById("emailTo").value='';

                    document.getElementById("everyReq").checked=true;
                    document.getElementById("everyReq").disabled=true;
                    document.getElementById("everyMinutes").disabled=true;
                    document.getElementById("alertInterval").value='';
                    document.getElementById("alertInterval").disabled=true;
              }
              else if(1 == selIndex) {
                    document.getElementById("target_email").style.display = "";
                    document.getElementById("target_service").style.display = "none";
                    document.getElementById("target_inputs").style.display = "";
                    document.getElementById("flowServiceName").style.display='none';
                    document.getElementById("flowServiceName").value='';
                    document.getElementById("emailNote").style.display='';
                    document.getElementById("runAs").style.display='none';
                    document.getElementById("runAsUser").value='';
                    document.getElementById("emailTo").style.display='';

                    document.getElementById("everyReq").disabled=false;
                    document.getElementById("everyMinutes").disabled=false;
                } else {
                    document.getElementById("target_email").style.display = "none";
                    document.getElementById("target_service").style.display = "";
                    document.getElementById("target_inputs").style.display = "";
                    document.getElementById("flowServiceName").style.display='';
                    document.getElementById("runAs").style.display='';
                    document.getElementById("emailTo").style.display='none';
                    document.getElementById("emailTo").value='';
                    document.getElementById("emailNote").style.display='none';
                    document.getElementById("everyReq").disabled=false;
                    document.getElementById("everyMinutes").disabled=false;
                }

            }

            function toggleAlertConfigurationDisplay()
            {
                    var alertSettings = document.getElementById("defaultAlertSettings");
                    if(alertSettings)
                    {
                        var alertConfiguration = document.getElementById("alertConfiguration");
                        if(alertSettings.checked)
                        {

                            alertConfiguration.style.display = "none";
                        }
                        else
                        {
                            alertConfiguration.style.display = "";
                        }
                    }
            }
        </script>
    </head>

    %ifvar global equals('true')%
        <body onLoad="setNavigation('security-edit-alert-options.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_DefaultAlertOptionsEditAlertOptionsDefaultScrn');">
    %else%
        <body onLoad="setNavigation('security-edit-alert-options.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EnterpriseGatewayRules_EditAlertOptionsRuleScrn');">
    %endif%

%invoke wm.server.enterprisegateway:getEnterpriseGatewayAlertOptions%
    <table  width="100%">
        <tr>
            %ifvar global equals('true')%
                <td class="breadcrumb" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Default Alert Options&nbsp;&gt;&nbsp;Edit</td>
            %else%
                <td class="breadcrumb" colspan="2">Security&nbsp;&gt;&nbsp;Enterprise&nbsp;Gateway&nbsp;Rules&nbsp;&gt;&nbsp;Rules&nbsp;&gt;&nbsp;%value rule encode(html)%&nbsp;Alert&nbsp;Options&nbsp;&gt;&nbsp;Edit</td>
            %endif%
        </tr>

        <tr>
            <td colspan="2">
                <ul class="listitems">
                    <li>
                    %ifvar global equals('true')%
						<script>
						createForm("htmlform_security_enterprisegateway_alert_list", "security-enterprisegateway-alert-list.dsp", "POST", "BODY");
						</script>
                        <script>getURL("security-enterprisegateway-alert-list.dsp","javascript:document.htmlform_security_enterprisegateway_alert_list.submit();","Return to Default Alert Options");</script>
                    %else%
						<script>
						createForm("htmlform_security_enterprisegateway_rules", "security-enterprisegateway-rules.dsp", "POST", "BODY");
						</script>
                        <script>getURL("security-enterprisegateway-rules.dsp","javascript:document.htmlform_security_enterprisegateway_rules.submit();","Return to Rules");</script>
                    %endif%
                    </li>
                </ul>
            </td>
        </tr>

        <tr>
            <td>
                <form name="htmlform_alertConfig"
                    %ifvar global equals('true')%
                        action="security-enterprisegateway-alert-list.dsp"
                    %else%
                        action="security-enterprisegateway-rules.dsp"
                    %endif%
                    method="POST" id="htmlform_alertConfig">
                    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                    <input type="hidden" name="operation" value="editAlertOptions">
                    <input type="hidden" name="global" id="global" value="%value global encode(htmlattr)%">
                    <input type="hidden" name="ruleType" id="ruleType" value="%value ruleType encode(htmlattr)%">
                    <input type="hidden" name="rule" id="rule" value="%value rule encode(htmlattr)%">

                    <table class="tableView" width="50%">
                        <tr>
					<td>	
						<table class="tableView" width="100%">
							 <tr>
                            <td class="heading" colspan="2" >%ifvar global equals('true')%Default%else%%value rule encode(html)%%endif% Alert Properties</td>
                        </tr>
                        %ifvar global equals('false')%
                            <tr>
                                <td class="oddrow" width="30%"> Alert Settings</td>
                                <td class="oddrow-l" width="70%">
										<input type="radio" name="alertSettings" id="alertSettings1" value="true" onclick="toggleAlertConfigurationDisplay()" checked>&nbsp;<label for="alertSettings1">Default</label>
										<input type="radio" name="alertSettings" id="alertSettings2" value="false" onclick="toggleAlertConfigurationDisplay()" %ifvar alertSettings equals('false')%checked%endif%>&nbsp;<label for="alertSettings2">Custom</label>
                                </td>
                            </tr>
                        %endif%

							<table width="100%" id="alertConfiguration">
                        <tr>
								 <td class="evenrow" nowrap><label for="alertType">Alert Type</label></TD>
                            <td class="evenrow-l">
                                <select size="1" name="alertType" id="alertType" onchange="changeOptions();">
                                    <option value="None" %ifvar alertType equals('-none-')%selected%endif%>None</option>
                                    <option value="Email" %ifvar alertType equals('Email')%selected%endif%>Email</option>
                                    <option value="flowService" %ifvar alertType equals('flowService')%selected%endif%>Flow Service</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="oddrow" width="30%" nowrap>Send Alert </td>
                            <td class="oddrow-l" width="70%">
										<input type="radio" name="alertOnEvery" id="everyReq" value="true"  onclick="toggleEveryMinute()" checked ><label for="everyReq">On rule violation </label>
										<input type="radio" name="alertOnEvery" id="everyMinutes" value="false" onclick="toggleEveryMinute()" %ifvar alertOnEvery equals('false')%checked%endif%><label for="everyMinutes">Every</label>
										<input type="text" name="alertInterval" id="alertInterval" value="%value alertInterval encode(htmlattr)%" size="10" %ifvar alertOnEvery equals('true')%readonly%endif%/>&nbsp;<label for="alertInterval">minutes</label>
                                <script> toggleEveryMinute();</script>
                            </td>
                        </tr>

                        <tr>
								<td class="evenrow" id="target_email" nowrap><label for="emailTo">Email Id's</label></TD>
								<td class="evenrow" id="target_service" nowrap><label for="flowServiceName">folder.subfolder:service</label></TD>
                            <td class="evenrow-l" id="target_inputs">
                                <input type="text" name="emailTo" id="emailTo" value="%value emailTo encode(htmlattr)%" size="45" %ifvar alertType equals('flowService')%style="display:none"%else%style="display:block"%endif%/>
                                <input type="text" name="flowServiceName" id="flowServiceName" value="%value flowServiceName encode(htmlattr)%" size="45"  %ifvar alertType equals('flowService')%style="display:block"%else%style="display:none"%endif%/>
                            </td>
                        </tr>
                        <!--  RUN AS USER SUB -->
                        <SCRIPT>
                              //This function can be changed to do something with the user
                              function callback(val){
                                document.htmlform_alertConfig.runAsUser.value=val;
                              }
                        </SCRIPT>
                        <tr id="runAs" name="runAs" style="display:none;">
								  <td class="oddrow" nowrap><label for="runAsUser">Run As User</label></TD>
                              <td class="oddrow-l">
                                <input type="text" name="runAsUser" id="runAsUser" size="37" value="%value runAsUser encode(htmlattr)%" readonly></input>
                                <link rel="stylesheet" type="text/css" href="subUserLookup.css" />
                                <script type="text/javascript" src="subUserLookup.js"></script>
								<a class="submodal" href="subUserLookup"><img border=0 align="bottom" alt="Select User" src="icons/magnifyglass.png"/></a>
                              </td>
                        </tr>
                        <tr id="emailNote" name="emailNote" style="display:none;">
                              <td class="oddrow">
                              <td class="oddrow-l">Separate email addresses with semicolons (;).</td>
                        </tr>
                        <!-- END RUN AS USER SUB -->
                        <script> changeOptions();</script>
							</table>
                        <tr>
                            <td class="action" colspan="2">
                                <input type="submit" name="save" id="save" value="Save Changes" onclick= 'return validateForm();'/>
                            </td>
                        </tr>
                        <script>
                            toggleAlertConfigurationDisplay();
                        </script>
						</table>
%endinvoke%
					</td>
                </tr>
            </form>
    </table>
  </body>
</html>
