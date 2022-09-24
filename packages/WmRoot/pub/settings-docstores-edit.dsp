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
            if (needCheck == "true")
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

        function verifyNonnegativeIntegerField(v, name, needCheck)
        {
            if (needCheck == "true")
            {
                if (isblank(v.value)) {
                    alert(name + " is required.");
                    return false;
                }
                else if (!isNum(v.value) || parseInt(v.value) < 0) {
                    alert("Value must be a nonnegative integer: "+name);
                    return false;
                }
                else {
                    return true;
                }
            } else
                return true;
        }

        function verifyPercentageField(v, name)
        {
            if (isblank(v.value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(v.value) || parseInt(v.value) < 0 || parseInt(v.value) > 100) {
                alert("Value must be an integer between 0 and 100: "+name);
                return false;
            }
            else {
                return true;
            }
        }

        function verifyInitialSize(storeSize) {
            var stsz = parseInt(storeSize.value);
            if (stsz < 2 ) {
                alert("Initial Store size must be greater than 1 MB");
                return false;
            }
            else {
                return true;
            }
        }

        function confirmEdit(isBrokerConfigured) {
            var tsDBGroup                 = document.editform.tsDBGroup;
            var tsDBSize                  = document.editform.tsDBSize;
            var tsNumMsgs                 = document.editform.tsNumMsgs;
            var triggerDBGroup            = document.editform.triggerDBGroup;
            var triggerDBSize             = document.editform.triggerDBSize;
            var maxDocsDefStore           = document.editform.maxDocsDefStore;
            var minDocsDefStore           = document.editform.minDocsDefStore;
            var maxDocsSentPerTransaction = document.editform.maxDocsSentPerTransaction;
            var maxLifeOfMessageHistory   = document.editform.maxLifeOfMessageHistory;

            if (verifyNonblankField(tsDBGroup,                         "Default Document Store Location")  &&
                verifyPositiveIntegerField(tsDBSize,                   "Initial Store Size", true)              &&
                verifyNonnegativeIntegerField(maxDocsDefStore,         "Capacity", isBrokerConfigured)     &&
                verifyNonnegativeIntegerField(minDocsDefStore,         "Refill Level", isBrokerConfigured) &&
                verifyNonblankField(triggerDBGroup,                    "Trigger Document Store Location")  &&
                verifyPositiveIntegerField(triggerDBSize,              "Initial Store Size", true)                  &&
                verifyNonnegativeIntegerField(maxLifeOfMessageHistory, "Duration", true)                            &&
                verifyInitialSize(tsDBSize)                                                     &&
                verifyInitialSize(triggerDBSize)                                           &&
                verifyPositiveIntegerField(maxDocsSentPerTransaction,  "Maximum Documents to Send per Transaction", isBrokerConfigured))
            {
                if (parseInt(minDocsDefStore.value) > parseInt(maxDocsDefStore.value)
                    && parseInt(maxDocsDefStore.value) != 0 ) {
                    alert("The Refill Level (" + minDocsDefStore.value + ") " +
                          "cannot exceed the Capacity (" + maxDocsDefStore.value + ").");
                    return false;
                }
                else {
                    return true;
                }
            }
            else {
                return false;
            }
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

    <BODY onLoad="setNavigation('settings-docstores-edit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditDocStoresScrn');">
        <TABLE width="90%">
            <TR>
                <TD class="breadcrumb" colspan="2">
                    Settings &gt; Resources &gt; Store Settings &gt; Edit Document Store Settings<br>
                </TD>
            </TR>

            <TR>
                <TD colspan="2">
                    <ul class="listitems">
						<script>
						createForm("htmlform_settings_docstores", "settings-docstores.dsp", "POST", "BODY");
						</script>
                        <li class="listitem">
						<script>getURL("settings-docstores.dsp", "javascript:document.htmlform_settings_docstores.submit();", "Return to Store Settings");</script>
						
						</li>
                    </UL>
                </TD>
            </TR>

            %invoke wm.server.dispatcher.adminui:getDocStoreSettings%
             %ifvar isPubSubLicensed equals('true')%
            <TR>
                <TD width="100%">
                    <TABLE class="tableView">
                        <FORM NAME="editform" ACTION="settings-docstores.dsp" METHOD="POST" onsubmit="return confirmEdit('%value isBrokerConfigured encode(javascript)%')">
                            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                            <input type="hidden" name="action" value="edit" />

                                <TR>
                                    <TD class="heading" colspan=3>Default Document Store</TD>
                                </TR>

                                <TR>
                                    <TD class="oddrow"><label for="tsDBGroup">Store Location</label></TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT NAME="tsDBGroup" ID="tsDBGroup" VALUE="%value tsDBGroup encode(htmlattr)%" />
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </TR>

                                <TR>
                                    <TD class="evenrow"><label for="tsDBSize">Initial Store Size (MB)</label></TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT NAME="tsDBSize" ID="tsDBSize" VALUE="%value tsDBSize encode(htmlattr)%" />
                                    </TD>
                                    <TD class="evenrowdata-l">*</TD>
                                </TR>


                            %ifvar isBrokerConfigured equals('true')%
                                <TR>
                                    <TD class="oddrow"><label for="maxDocsDefStore">Capacity (documents)</label></TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT NAME="maxDocsDefStore" ID="maxDocsDefStore" VALUE="%value maxDocsDefStore encode(htmlattr)%" />
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp;</TD>
                                </TR>

                                <TR>
                                    <TD class="evenrow"><label for="minDocsDefStore">Refill Level (documents)</label></TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT NAME="minDocsDefStore" ID="minDocsDefStore" VALUE="%value minDocsDefStore encode(htmlattr)%" />
                                    </TD>
                                    <TD class="evenrowdata-l">&nbsp;</TD>
                                </TR>
                            %else%
                                <TR>
                                    <TD class="oddrow"><label for="maxDocsDefStore">Capacity (documents)</label></TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT TYPE="hidden" NAME="maxDocsDefStore" ID="maxDocsDefStore" VALUE="(Broker Not Configured)" />
                                        (Broker Not Configured)
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp;</TD>
                                </TR>

                                <TR>
                                    <TD class="evenrow"><label for="minDocsDefStore">Refill Level (documents)</label></TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT TYPE="hidden" NAME="minDocsDefStore" ID="minDocsDefStore" VALUE="(Broker Not Configured)" />
                                        (Broker Not Configured)
                                    </TD>
                                    <TD class="evenrowdata-l">&nbsp;</TD>
                                </TR>
                            %endif%

        %comment%
                                <TR>
                                    <TD class="oddrow"><label for="tsNumMsgs">Number of Documents Retrieved per Transaction</label></TD>
                                    <TD class="oddnrowdata-l">
                                        <INPUT NAME="tsNumMsgs" ID="tsNumMsgs" VALUE="%value tsNumMsgs encode(htmlattr)%" />
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp;</TD>
                                </TR>
        %endcomment%

                                <TR>
                                    <TR><TD class="space" colspan=3>&nbsp;</TD></TR>
                                </TR>

                                <TR>
                                    <TD class="heading" colspan=3>Trigger Document Store</TD>
                                </TR>

                                <TR>
                                    <TD class="oddrow"><label for="triggerDBGroup">Store Location</label></TD>
                                    <TD class="oddrowdata-l">
                                        <INPUT NAME="triggerDBGroup" ID="triggerDBGroup" VALUE="%value triggerDBGroup encode(htmlattr)%">
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </TR>

                                <TR>
                                    <TD class="evenrow"><label for="triggerDBSize">Initial Store Size (MB)</label></TD>
                                    <TD class="evenrowdata-l">
                                        <INPUT NAME="triggerDBSize" ID="triggerDBSize" VALUE="%value triggerDBSize encode(htmlattr)%">
                                    </TD>
                                    <TD class="evenrowdata-l">*</TD>
                                </TR>

                             
                                <TR>
                                    <TD class="oddrow"><label for="maxLifeOfMessageHistory">Inbound Document History (minutes)</label></TD>
                                    %ifvar isBrokerConfigured equals('false')%
                                    <TD class="oddrowdata-l">Not Available
                                        <INPUT NAME="maxLifeOfMessageHistory" ID="maxLifeOfMessageHistory" VALUE="0" TYPE="hidden">
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp</TD>
                                    %else%
                                        %ifvar exactlyOnceSupported equals('true')%
                                        <TD class="oddrowdata-l">Not Available
                                            <INPUT NAME="maxLifeOfMessageHistory" ID="maxLifeOfMessageHistory" VALUE="0" TYPE="hidden">
                                        </TD>
                                        <TD class="oddrowdata-l">&nbsp</TD>
                                        %else%
                                        <TD class="oddrowdata-l">
	                                        <INPUT NAME="maxLifeOfMessageHistory" ID="maxLifeOfMessageHistory" VALUE="%value maxLifeOfMessageHistory encode(htmlattr)%">
                                        </TD>
                                        <TD class="oddrowdata-l">*</TD>
                                        %endif%
                                    %endif%
                                </TR>

                                <TR>
                                    <TD class="evenrow">Inbound Client Side Queuing</TD>
                                    %ifvar isBrokerConfigured equals('false')%
                                        <TD CLASS="evenrowdata-l">Not Available</TD>
                                        <TD class="evenrowdata-l">&nbsp</TD>
                                    %else%
                                        %ifvar exactlyOnceSupported equals('true')%
                                            <TD CLASS="evenrowdata-l">Not Available</TD>
                                            <TD class="evenrowdata-l">&nbsp</TD>
                                        %else%
                                            %ifvar clusterEnabled equals('false')%
                                            <TD CLASS="evenrowdata-l">
                                                %ifvar INBOUNDQUEUING equals('on')%
                                                    <INPUT TYPE="radio" NAME="INBOUNDQUEUING" ID="INBOUNDQUEUING1" VALUE="on" checked><label for="INBOUNDQUEUING1">On</label></INPUT>
                                                    <INPUT TYPE="radio" NAME="INBOUNDQUEUING" ID="INBOUNDQUEUING2" VALUE="off"><label for="INBOUNDQUEUING2">Off</label></INPUT>
                                                %else%
                                                    <INPUT TYPE="radio" NAME="INBOUNDQUEUING" ID="INBOUNDQUEUING1" VALUE="on"><label for="INBOUNDQUEUING1">On</label></INPUT>
                                                    <INPUT TYPE="radio" NAME="INBOUNDQUEUING" ID="INBOUNDQUEUING2" VALUE="off" checked><label for="INBOUNDQUEUING2">Off</label></INPUT>
                                                %endif%
                                            </TD>
                                            %else%
                                            <TD CLASS="evenrowdata-l">Off&nbsp;&nbsp;&nbsp;(Server is Cluster Enabled)
                                                <INPUT TYPE="hidden" ID="INBOUNDQUEUING" NAME="INBOUNDQUEUING" VALUE="off" />
                                            </TD>
                                            %endif%
                                            <TD class="evenrowdata-l">*</TD>
                                        %endif%
                                    %endif%
                                </TR>
                                
                                <TR>
                                    <script type="text/javascript">
                                        var runas = "%value TRIGGERUSER encode(javascript)%";

                                        // define function to scroll through selections on
                                        // document.editform.TRIGGERUSER
                                        function updateSelector () {
                                            var sel = document.editform.TRIGGERUSER;
                                            for (var i=0; i<sel.options.length; i++) {
                                                if (sel.options[i].value == runas) {
                                                    sel.selectedIndex = i;
                                                }
                                            }
                                        }
                                    </script>
                                    
                                    <!--  RUN AS USER SUB CHANGES-->
                                    
                    <SCRIPT>
                        function callback(val){             
                            document.editform.TRIGGERUSER.value=val;
                    }
                    </SCRIPT>

                                    <TD class="oddrow"><label for="TRIGGERUSER">User</label></TD>
                                    <TD class="oddrowdata-l">
                                    <!--
                                        %invoke wm.server.access:userList%
                                            <SELECT NAME="TRIGGERUSER">
                                                %loop users%
                                                    <OPTION value="%value name encode(htmlattr)%"
                                                            %ifvar name equals('')% selected %endif%>
                                                        %value name encode(html)%
                                                    </OPTION>
                                                %endloop%
                                            </SELECT>
                                        %endinvoke%
                                    
                                    <SCRIPT LANGUAGE="JavaScript">updateSelector();</SCRIPT>
                                    -->
                                    <!--  RUN AS USER SUB CHANGES START-->
				    <input name="TRIGGERUSER" ID="TRIGGERUSER" size=12 value="%value TRIGGERUSER encode(htmlattr)%"></input>
                    <link rel="stylesheet" type="text/css" href="subUserLookup.css" />
                    <script type="text/javascript" src="subUserLookup.js"></script>
					
					<a class="submodal" href="subUserLookup"><img border=0 align="bottom" alt="User lookup" src="icons/magnifyglass.png"/></a>
                   
                       <!--  RUN AS USER SUB END-->
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </tr>
                                
                                
                                

                                <TR>
                                    <TD class="space" colspan=3>&nbsp;</TD>
                                </TR>

                                <TR>
                                    <TD class="heading" colspan=3>Outbound Document Store</TD>
                                </TR>

                                <TR>
                                    <TD class="oddrow"><label for="maxDocsSentPerTransaction">Maximum Documents to Send per Transaction</label></TD>
                                    <TD class="oddrowdata-l">
                                        %ifvar isBrokerConfigured equals('true')%
                                            <INPUT NAME="maxDocsSentPerTransaction" ID="maxDocsSentPerTransaction" VALUE="%value maxDocsSentPerTransaction encode(htmlattr)%" />
                                        %else%
                                            <INPUT TYPE="hidden" ID="maxDocsSentPerTransaction" NAME="maxDocsSentPerTransaction" VALUE="Broker Not Configured">
                                            (Broker Not Configured)
                                        %endif%
                                    </TD>
                                    <TD class="oddrowdata-l">&nbsp;</TD>
                                </TR>
                                
                                 <TR>
                                    <TD class="space" colspan=3>&nbsp;</TD>
                                </TR>
                                   
<!--
                                <TR>
                                    <TD class="heading" colspan=3>Run Trigger Service As User</TD>
                                </tr>
                                
                                <TR>
                                    <script type="text/javascript">
                                        var runas = "%value TRIGGERUSER encode(javascript)%";

                                        // define function to scroll through selections on
                                        // document.editform.TRIGGERUSER
                                        function updateSelector () {
                                            var sel = document.editform.TRIGGERUSER;
                                            for (var i=0; i<sel.options.length; i++) {
                                                if (sel.options[i].value == runas) {
                                                    sel.selectedIndex = i;
                                                }
                                            }
                                        }
                                    </script>

                                    <TD class="oddrow">User</TD>
                                    <TD class="oddrowdata-l">
                                        %invoke wm.server.access:userList%
                                            <SELECT NAME="TRIGGERUSER">
                                                %loop users%
                                                    <OPTION value="%value name encode(htmlattr)%"
                                                            %ifvar name vequals(../TRIGGERUSER)% SELECTED %endif%>
                                                        %value name encode(html)%
                                                    </OPTION>
                                                %endloop%
                                            </SELECT>
                                        %endinvoke%
                                        <SCRIPT LANGUAGE="JavaScript">updateSelector();</SCRIPT>
                                    </TD>
                                    <TD class="oddrowdata-l">*</TD>
                                </TR>


                                <tr>
                                    <td class="space" colspan=3>&nbsp;</td>
                                </tr>
-->
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
             %else%
             	<TR><TD colspan="4">&nbsp;</TD></TR>
				<TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
             %endif%
           %endinvoke%
        </TABLE>
    </BODY>
</HTML>
