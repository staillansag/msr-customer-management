<HTML>
<HEAD>
<TITLE>Quiesce Port Configuration</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<SCRIPT SRC="quiesce.js"></SCRIPT>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <SCRIPT SRC="webMethods.js"></SCRIPT>
</HEAD>

<body onLoad="setNavigation('settings-quiesce.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_QuiescePortConfigScrn');">
      <DIV class="position">
      <FORM NAME="setQuiescePortForm" METHOD="POST">
         %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
         <TABLE WIDTH="100%">
            <TR>
               <TD class="breadcrumb" colspan=2>Settings &gt; Quiesce </TD>
            </TR>
            %ifvar action equals('change')%
            %invoke wm.server.quiesce:setQuiesceConfig%
            <tr><td colspan="2">&nbsp;</td></tr>
  	        	<TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
            %onerror%
            <tr><td colspan="2">&nbsp;</td></tr>
		   	<TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error while saving settings. %value message encode(html)%</TD></TR>
            %endinvoke%
            %endif%
            <TR>
                <TD colspan="2">
                    <ul class="listitems">
						<script>
						createForm("htmlform_security_ports", "security-ports.dsp", "POST", "BODY");
						</script>
                        <li class="listitem">
						<script>getURL("security-ports.dsp", "javascript:document.htmlform_security_ports.submit();", "Go to Ports");</script>
						
						</li>
                    </UL>
                </TD>
            </TR>
           
           <TR>
            <TD>
              <TABLE class="tableView" cellpadding=5 >
                <TR>
                    <TD class="heading" colspan=2>
                        Select Quiesce Port
                    </TD>
                </TR>
                <TR>
                    <TH class="evencol-l">
                        <p> Current Quiesce Port &nbsp;</p>
                    </TH>
                    <TD class="evencol-l">
                        %invoke wm.server.quiesce:getQuiescePortDetails%
                        <p align="left">
                            %ifvar portAlias -isnull%
                                None
                            %endif% 
                            %ifvar portAlias -notempty%
							<script>
							createForm("htmlform_config_http", "configHTTP.dsp", "POST", "BODY");
							setFormProperty("htmlform_config_http", "listenerKey", "%value portKey %");
							setFormProperty("htmlform_config_http", "pkg", "%value portPackage %");
							setFormProperty("htmlform_config_http", "listening", "true");
							setFormProperty("htmlform_config_http", "mode", "view");
							</script>
							<script>getURL("configHTTP.dsp?listenerKey=%value portKey encode(url)%&pkg=%value portPackage encode(url)%&listening=true&mode=view", "javascript:document.htmlform_config_http.submit();", "%value portAlias encode(html)%");</script>
		      				
                            %else%
                                None
                            %endif%
                        
                        </p>
                        %endinvoke%
                    </TD>
                </TR>
                %invoke wm.server.ports:listListeners%
                <TR>
                    <TD class="oddrow-l">
                        <p><label for="key"> Select New Quiesce Port</label></p>
                    </TD>
                    
                    <TD class="oddrow-l" VALIGN="Center" width=60%>
			    		<SELECT id="key" NAME="key" ONCHANGE="setQuiescePort(setQuiescePortForm, this.form.key)">
                            <OPTION Selected VALUE=",">----None----</OPTION>
                             
                            <!-- List all the ports of HTTP/HTTPS only from WmRoot & WmPublic -->
                                %loop listeners%
                                        %ifvar protocol matches('HTTP')%
                                            %ifvar listenerType equals('Regular')%
                                                %ifvar pkg equals('WmRoot')%
                                                
														<OPTION VALUE="%value key encode(htmlattr)%,WmRoot,%value portAlias encode(htmlattr)%"> %value portAlias encode(html)% </OPTION>
                                                %else%
                                                    %ifvar pkg equals('WmPublic')%
															<OPTION VALUE="%value key encode(htmlattr)%,WmPublic,%value portAlias encode(htmlattr)%"> %value portAlias encode(html)%</OPTION>
                                                    %endif%
                                                %endif%                                         
                                            %endif%
                                         %else%
                                         %ifvar protocol matches('HTTPS')%
                                            %ifvar listenerType equals('Regular')%
                                                %ifvar pkg equals('WmRoot')%
														<OPTION VALUE="%value key encode(htmlattr)%,WmRoot,%value portAlias encode(htmlattr)%"> %value portAlias encode(html)% </OPTION>
                                            
                                                %else%
                                                    %ifvar pkg equals('WmPublic')%
															<OPTION VALUE="%value key encode(htmlattr)%,WmPublic,%value portAlias encode(htmlattr)%">  %value portAlias encode(html)% </OPTION>
                                                    %endif%
                                                %endif%                                         
                                            %endif%
                                            %endif%
                                        %endif%
                                %endloop%
                        </SELECT>
                    </TD>
                </TR>
                %onerror%
                   <TR><TD colspan="2">&nbsp;</TD></TR>
			       <TR><TD class="message" colspan="2">Error while saving settings. %value message encode(html)%</TD></TR>

%endinvoke%
				<TR style="height:10px"></TR>
				<TR >
                %invoke wm.server.quiesce:getQuiesceOptions%
                <TABLE class="tableView" width="50%">
                			%ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

                			<input type="hidden" name="isQuiesceMode"></input>

                			<input type="hidden" name="timeout"></input>
                            <TR>
                				<TD class="heading" colspan="2" width="100%">Additional Tasks to Perform while Entering Quiesce Mode</TD>
                			</TR>
                			<TR>
                                <TD class="oddrow-l" style="border-right: none">
                                    <label for="auditingDisabled">Disable Audit Logging</label>
                                </TD>
                				<TD>
                            %ifvar auditingDisabled equals('true')%
                                <INPUT type="checkbox"  name="auditingDisabled" id="auditingDisabled" value="auditingDisabled"
                                        onchange="toggleAuditingDisabledChecked()" checked=true/>
                               <script>
                                        document.setQuiescePortForm.auditingDisabled.value = true;
                                </script>
                            %else%
                                 <INPUT type="checkbox"  name="auditingDisabled" id="auditingDisabled" value="auditingDisabled"
                                        onchange="toggleAuditingDisabledChecked()"/>
                             %endif%
                				</TD>
                			</TR>
                			<TR>
                                <TD class="oddrow-l" style="border-right: none">
                                    <label for="systemTasksDisabled">Disable System Tasks Interacting with Database</label>
                                </TD>
                                <TD>
                                %ifvar systemTasksDisabled equals('true')%
                                    <INPUT type="checkbox"  name="systemTasksDisabled" id="systemTasksDisabled" value="systemTasksDisabled"
                                        onchange="toggleSystemTasksChecked()" checked=true/>
                                    <script>
                                        document.setQuiescePortForm.systemTasksDisabled.value = true;
                                    </script>
                                %else%
                                  <INPUT type="checkbox"  name="systemTasksDisabled" id="systemTasksDisabled" value="systemTasksDisabled"
                                        onchange="toggleSystemTasksChecked()"/>
                                %endif%
                                 </TD>
                			</TR>
                			<TR>
                				<TD class="oddrow-l" style="border-right: none">
                					<label for="alertingDisabled">Disable Alerts and Notifications</label>
                				</TD>
                				<TD>
                				%ifvar alertingDisabled equals('true')%
                                    <INPUT type="checkbox"  name="alertingDisabled" id="alertingDisabled" value="alertingDisabled"
                                        onchange="toggleAlertingDisabledChecked()" checked=true/>
                                    <script>
                                        document.setQuiescePortForm.alertingDisabled.value = true;
                                    </script>
                                    %else%
                                    <INPUT type="checkbox"  name="alertingDisabled" id="alertingDisabled" value="alertingDisabled"
                                        onchange="toggleAlertingDisabledChecked()"/>
                                     %endif%
                				</TD>
                			</TR>
                			<TR>
                				<TD class="oddrow-l" style="border-right: none">
                					<label for="statisticsDataCollectorDisabled">Disable Statistics Data Collector</label>
                				</TD>
                				<TD>
                				%ifvar statisticsDataCollectorDisabled equals('true')%
                					<INPUT type="checkbox"  name="statisticsDataCollectorDisabled" id="statisticsDataCollectorDisabled" value="statisticsDataCollectorDisabled"
                					 onchange="toggleStatisticsDataCollectorDisabledChecked()" checked=true/>
                				 <script>
                                    document.setQuiescePortForm.statisticsDataCollectorDisabled.value = true;
                                 </script>
                			    %else%
                			        <INPUT type="checkbox"  name="statisticsDataCollectorDisabled" id="statisticsDataCollectorDisabled" value="statisticsDataCollectorDisabled"
                                        onchange="toggleStatisticsDataCollectorDisabledChecked()"/>
                                 %endif%
                				</TD>
                			</TR>
                			</TABLE>
							</TR>
							<TR style="height:10px"></TR>
                    %endinvoke%
							<TR>
                <TD class="action" colspan=2>
                    <INPUT TYPE="hidden" NAME="action" VALUE="change"></INPUT>
                    <INPUT TYPE="hidden" NAME="port" ></INPUT>
                    <INPUT TYPE="hidden" NAME="package" ></INPUT>
                    <INPUT TYPE="hidden" NAME="portAlias" value=""></INPUT>
                    <INPUT TYPE="submit" VALUE="Save Changes"></INPUT>
                </TD>
				</TR>


              </table>
            </TD>
          </TR>
        </TABLE>
       </FORM>
      </DIV> 
    </BODY>
</HTML>
    