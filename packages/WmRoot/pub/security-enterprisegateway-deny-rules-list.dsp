 <table width="100%" class="tableView">
               <tr>
                      <td colspan="7" class="heading">
                           Denial Rules
                      </td>
               </tr>
               <tr>
                     <th scope="col" CLASS="oddcol-l" width="12%">
                         Rule Name
                     </th>
                     <th scope="col" CLASS="oddcol" width="20%">
                         Filters
                     </th>
                     <th scope="col" CLASS="oddcol" width="12%">
                         Enabled
                     </th>
					 <th scope="col" CLASS="oddcol" width="12%">
                         Alert Options
                     </th>
                     <th scope="col" CLASS="oddcol" width="12%">
                         Copy
                     </th>
                     <th scope="col" CLASS="oddcol" width="12%">
                         Delete
                     </th>
                     <th scope="col" CLASS="oddcol" width="14%">
                         Priority
                     </th>
               </tr>
               %ifvar -notempty denyRuleList%
                %loop denyRuleList%
                          <tr>
                                <script>writeTD("rowdata-l");</script>
								<script>
									if(is_csrf_guard_enabled && needToInsertToken) {
										document.write('<a href="javascript:document.htmlform_security_enterprisegateway_1.submit();" onClick="return populateForm(document.htmlform_security_enterprisegateway_1 ,\'operation=editRule;ruleType=DENY;rule=%value ruleName%;index=%value $index%\')">%value ruleName encode(html)%</a>');
									} else {
										%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
										var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
										if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
											document.write('<a href="security-enterprisegateway-create-rule.dsp?operation=editRule&ruleType=DENY&rule=%value ruleName encode(url)%&index=%value $index encode(url)%&webMethods-wM-AdminUI=true">%value ruleName encode(html)%</a>');
										}
										else {
											document.write('<a href="security-enterprisegateway-create-rule.dsp?operation=editRule&ruleType=DENY&rule=%value ruleName encode(url)%&index=%value $index encode(url)%">%value ruleName encode(html)%</a>');
										}
									}
								</script>
                                
                                </td>
                                <script>writeTD("rowdata");</script>
                                <script>
                                 var sep="";
                                 var filterStr = "";
                                 %loop Filters%
                                    %ifvar filterName equals('DoSFilter')%  
                                       %ifvar isDOSEnabled equals('true')%    
                                          filterStr = filterStr+sep+"Denial of Service Protection";
                                          sep=", ";
                                        %endif%
                                    %endif%
                                    %ifvar filterName equals('OAuthFilter')%
                                      %ifvar isOAuthEnabled equals('true')%
                                          filterStr = filterStr+sep+"OAuth Credentials";
                                          sep=", ";
                                      %endif%
                                    %endif%
                                    %ifvar filterName equals('MsgSizeLimitFilter')%      
                                      %ifvar isMessageSizeEnabled equals('true')%
                                          filterStr = filterStr+sep+"Message Size Limit";
                                          sep=", ";   
                                      %endif%  
                                    %endif%   
                                    %ifvar filterName equals('mobileAppProtectionFilter')%      
                                      %ifvar isMobileAppProtectionEnabled equals('true')%
                                          filterStr = filterStr+sep+"Mobile Application Protection";
                                          sep=", ";   
                                      %endif%  
                                    %endif%
                                    %ifvar filterName equals('sqlInjectionFilter')%      
                                      %ifvar isSQLInjectionFilterEnabled equals('true')%
                                          filterStr = filterStr+sep+"SQL Injection Protection";
                                          sep=", ";   
                                      %endif%  
                                    %endif% 
                                    %ifvar filterName equals('antiVirusFilter')%      
                                      %ifvar isAntiVirusScanEnabled equals('true')%
                                          filterStr = filterStr+sep+"Antivirus Scan";
                                          sep=", ";   
                                      %endif%  
                                    %endif%     
                                    %ifvar filterName equals('customFilter')%      
                                      %ifvar isCustomFilterEnabled equals('true')%
                                          filterStr = filterStr+sep+"Custom";
                                          sep=", ";   
                                      %endif%  
                                    %endif%                                             
                                  %endloop%
                                  if("" == filterStr ){
                                    filterStr="None";
                                  }
                                  document.write(filterStr);
                                 </script>
                                </td>
                                <script>writeTD("rowdata");</script>
                                  %ifvar isRuleEnabled equals('true')%
                                         <img src="images/green_check.png" border="no">
										 <script>
											if(is_csrf_guard_enabled && needToInsertToken) {
												document.write('<a href="javascript:document.htmlform_security_enterprisegateway_3.submit();" onclick="return confirmEnableDisableForm(\'%value ruleName encode(javascript)%\',\'disable\', document.htmlform_security_enterprisegateway_3, \'action=enableDisable;index=%value $index%;ruleType=DENY;rule=%value ruleName%\')">Yes</a>');
											} else {
												%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
												var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
												if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
													document.write('<a href="security-enterprisegateway-rules.dsp?action=enableDisable&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%&webMethods-wM-AdminUI=true" onclick="return confirmEnableDisable(\'%value ruleName encode(javascript)%\',\'disable\')">Yes</a>');
												}
												else {
													document.write('<a href="security-enterprisegateway-rules.dsp?action=enableDisable&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%" onclick="return confirmEnableDisable(\'%value ruleName encode(javascript)%\',\'disable\')">Yes</a>');
												}
											}
										</script>
                                         
                                  %else%
										<script>
											if(is_csrf_guard_enabled && needToInsertToken) {
												document.write('<a href="javascript:document.htmlform_security_enterprisegateway_3.submit();" onclick="return confirmEnableDisableForm(\'%value ruleName encode(javascript)%\',\'enable\', document.htmlform_security_enterprisegateway_3, \'action=enableDisable;index=%value $index%;ruleType=DENY;rule=%value ruleName%\')">No</a>');
											} else {
												%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
												var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
												if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
													document.write('<a href="security-enterprisegateway-rules.dsp?action=enableDisable&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%&webMethods-wM-AdminUI=true" onclick="return confirmEnableDisable(\'%value ruleName encode(javascript)%\',\'enable\')">No<a>');
												}
												else {
													document.write('<a href="security-enterprisegateway-rules.dsp?action=enableDisable&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%" onclick="return confirmEnableDisable(\'%value ruleName encode(javascript)%\',\'enable\')">No<a>');
												}
											}
										</script>
                                         
                                  %endif%
                               </td>
                               <script>writeTD("rowdata");</script>
                                    %ifvar alertOption%
										<script>
											if(is_csrf_guard_enabled && needToInsertToken) {
												document.write('<a href="javascript:document.htmlform_security_enterprisegateway_2.submit();" onClick="return populateForm(document.htmlform_security_enterprisegateway_2 ,\'ruleType=DENY;rule=%value ruleName%;global=false;alertSettings=false\')">Custom</a>');
											} else {
												%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
												var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
												if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
													document.write('<a href="security-enterprisegateway-alert-options.dsp?ruleType=DENY&rule=%value ruleName encode(url)%&global=false&alertSettings=false&webMethods-wM-AdminUI=true">Custom</a>');
												}
												else {
													document.write('<a href="security-enterprisegateway-alert-options.dsp?ruleType=DENY&rule=%value ruleName encode(url)%&global=false&alertSettings=false">Custom</a>');
												}
											}
										</script>
									   
                                    %else%
										<script>
											if(is_csrf_guard_enabled && needToInsertToken) {
												document.write('<a href="javascript:document.htmlform_security_enterprisegateway_2.submit();"  onClick="return populateForm(document.htmlform_security_enterprisegateway_2 ,\'ruleType=DENY;rule=%value ruleName%;global=false;alertSettings=true\')">Default</a>');
											} else {
												%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
												var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
												if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
													document.write('<a href="security-enterprisegateway-alert-options.dsp?ruleType=DENY&rule=%value ruleName encode(url)%&global=false&alertSettings=true&webMethods-wM-AdminUI=true">Default</a>');
												}
												else {
													document.write('<a href="security-enterprisegateway-alert-options.dsp?ruleType=DENY&rule=%value ruleName encode(url)%&global=false&alertSettings=true">Default</a>');
												}
											}
										</script>
										
                                    %endif%
                                 </td>
                               <script>writeTD("rowdata");</script>
							   <script>
									if(is_csrf_guard_enabled && needToInsertToken) {
										document.write('<a href="javascript:document.htmlform_security_enterprisegateway_1.submit();" onClick="return populateForm(document.htmlform_security_enterprisegateway_1,\'ruleType=DENY;rule=%value ruleName%;operation=copyRule;index=%value $index%\')"><img src="icons/copy.gif" border="no"></a>');
									} else {
										%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
										var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
										if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
											document.write('<a href="security-enterprisegateway-create-rule.dsp?operation=copyRule&ruleType=DENY&rule=%value ruleName encode(url)%&index=%value $index encode(url)%&webMethods-wM-AdminUI=true"><img src="icons/copy.gif"  alt="Copy Rule %value ruleName% " border="no"></a>');
										}
										else {
											document.write('<a href="security-enterprisegateway-create-rule.dsp?operation=copyRule&ruleType=DENY&rule=%value ruleName encode(url)%&index=%value $index encode(url)%"><img src="icons/copy.gif"  alt="Copy Rule %value ruleName% " border="no"></a>');
										}
									}
								</script>
							   </td>
                               <script>writeTD("rowdata");</script>
                                  
								  <script>
										if(is_csrf_guard_enabled && needToInsertToken) {
											document.write('<a class="imagelink" href="javascript:document.htmlform_security_enterprisegateway_3.submit();" onclick="return confirmDeleteForm(\'%value ruleName encode(javascript)%\', document.htmlform_security_enterprisegateway_3, \'action=delete;ruleType=DENY;rule=%value ruleName%;index=%value $index%\')"><img src="icons/delete.png" border="none"></a>');
										} else {
											%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a class="imagelink" href="security-enterprisegateway-rules.dsp?action=delete&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%&webMethods-wM-AdminUI=true" onclick="return confirmDelete(\'%value ruleName encode(javascript)%\')"> <img src="icons/delete.png"  alt="Delete Rule %value ruleName% " border="none"></a>');
											}
											else {
												document.write('<a class="imagelink" href="security-enterprisegateway-rules.dsp?action=delete&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%" onclick="return confirmDelete(\'%value ruleName encode(javascript)%\')"> <img src="icons/delete.png"  alt="Delete Rule %value ruleName% " border="none"></a>');
											}
										}
									</script>
								  
                               </td>
                               <script>writeTD("rowdata");</script>
									<script>
										if(is_csrf_guard_enabled && needToInsertToken) {
											document.write('<a href="javascript:document.htmlform_security_enterprisegateway_3.submit();"  onclick="return populateForm(document.htmlform_security_enterprisegateway_3, \'action=moveUp;ruleType=DENY;rule=%value ruleName%;index=%value $index%\')"><img id = "link_up_deny_%value $index encode(htmlattr)%" src="icons/moveup_enabled.png" border="none"></a>');
										} else {
											%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a href="security-enterprisegateway-rules.dsp?action=moveUp&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%&webMethods-wM-AdminUI=true"><img id = "link_up_deny_%value $index encode(htmlattr)%" src="icons/moveup_enabled.png" alt="Increase rule priority %value ruleName%" border="none"></a>');
											}
											else {
												document.write('<a href="security-enterprisegateway-rules.dsp?action=moveUp&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%"><img id = "link_up_deny_%value $index encode(htmlattr)%" src="icons/moveup_enabled.png" alt="Increase rule priority %value ruleName%" border="none"></a>');
											}
										}
									</script>
									<script>
										if(is_csrf_guard_enabled && needToInsertToken) {
											document.write('<a href="javascript:document.htmlform_security_enterprisegateway_3.submit();" onclick="return populateForm(document.htmlform_security_enterprisegateway_3, \'action=moveDown;ruleType=DENY;rule=%value ruleName%;index=%value $index%\')"><img id = "link_down_deny_%value $index encode(htmlattr)%" src="icons/movedown_enabled.png" border="none"></a>');
										} else {
											%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a href="security-enterprisegateway-rules.dsp?action=moveDown&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%&webMethods-wM-AdminUI=true"><img id = "link_down_deny_%value $index encode(htmlattr)%" src="icons/movedown_enabled.png" alt="Decrease rule priority %value ruleName%" border="none"></a>');
											}
											else {
												document.write('<a href="security-enterprisegateway-rules.dsp?action=moveDown&index=%value $index encode(url)%&ruleType=DENY&rule=%value ruleName encode(url)%"><img id = "link_down_deny_%value $index encode(htmlattr)%" src="icons/movedown_enabled.png" alt="Decrease rule priority %value ruleName%" border="none"></a>');
											}
										}
									</script>
                                   
								    
                               </td>
                          </tr>
                          <script>swapRows();</script>
                          %ifvar $index equals('0')%
                                <script>
                                          var firstUp =   document.getElementById("link_up_deny_%value $index encode(javascript)%");
                                          var lastDown;
                                </script>
                          %endif%
                          <script>
                                   lastDown =  document.getElementById("link_down_deny_%value $index encode(javascript)%");
                          </script>                         
                      %endloop%
                   %else%
                  <tr>
                    <td colspan="7" class="evencol-l">
                         No rules are currently configured.
                    </td>
                  </tr>                                                                              
               %endif%                                                                          
              </table>
              <script>
              if(typeof lastDown != 'undefined'){
                    disableDirectionImage(lastDown,'DOWN');
              }
              
              if(typeof firstUp != 'undefined'){
                    disableDirectionImage(firstUp,'UP');
              }
              </script>