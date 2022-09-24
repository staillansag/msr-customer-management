<html>
    <script Language="JavaScript">
        function verifyPositivePercentageField(value, name)
        {
            if (isblank(value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(value) || parseInt(value) <= 0 || parseInt(value) > 100) {
                alert(name + " must be a positive integer between 1 and 100");
                return false;
            }
            else {
                return true;
            }
        }

        function validateTriggerThrottleValues(isBrokerConfigured)
        {
            if (isBrokerConfigured == "true") {
                if (verifyPositivePercentageField(document.settings.maximumDocumentRetrievalThreadsPct.value, "Maximum Document Retrieval Threads") &&
                    verifyPositivePercentageField(document.settings.maximumTriggerExecutionThreadsPct.value,  "Maximum Trigger Execution Threads"))
                {
                    return true;
                }
                else
                    return false;
            }
            else {
                if(verifyPositivePercentageField(document.settings.maximumTriggerExecutionThreadsPct.value,  "Maximum Trigger Execution Threads"))
                    return true;
                else
                    return false;
            }
        }

        function retrievalChange() {
            var sel = document.forms[0].triggerDocumentStoreThrottle;
            var fld = document.forms[0].maximumDocumentRetrievalThreadsPct;
            // changeConnectedField(sel, fld);
        }

        function executionChange() {
            var sel = document.forms[0].triggerExecutionThreadsThrottle;
            var fld = document.forms[0].maximumTriggerExecutionThreadsPct;
            // changeConnectedField(sel, fld);
        }

        function changeConnectedField(selection, field) {
            if (selection.selectedIndex == 10) {
                field.disabled = true;
            }
            else {
                field.disabled = false;
            }
        }
        
        function showCluster() {
          prop = "%sysvar property('watt.server.cluster.aliasList')%";
          if (prop == null || prop.length < 1)
            return false;
          else
            return true;
        }
        
    </script>

    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Integration Server Settings</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <SCRIPT SRC="webMethods.js"></SCRIPT>
    </head>

    <body onLoad="setNavigation('trigger-management-throttle-controls-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditGlobalTriggerCntrlsScrn');">

        <table width="100%">

            <tr>
                <td class="breadcrumb" colspan="2">
                    Settings &gt; Messaging &gt; webMethods Messaging Trigger Management &gt; Global webMethods Messaging Trigger Controls &gt; Edit
                </td>
            </tr>

            <tr>
                <td valign="top" colspan="2"> 
                    <ul class="listitems">
                      <li class="listitem">
						            
                        <script>
						              createForm("htmlform_trigger_management", "trigger-management.dsp", "POST", "BODY");
						            </script>
						<script>getURL("trigger-management.dsp", "javascript:document.htmlform_trigger_management.submit();", "Return to webMethods Messaging Trigger Management");</script>
                        
                      </li>
                    </ul>
                </td>
            </tr>

            %invoke wm.server.query:getTriggerThrottleControlSettings%
                <script>%rename ../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%</script>
                <tr>
                    <td><img src="images/blank.gif" height=10 width=10 border=0></td>
                    <td width="100%">
                        <table class="tableView">

                            <form name="settings" action="trigger-management.dsp" method="POST" onsubmit="return validateTriggerThrottleValues('%value isBrokerConfigured encode(javascript)%');">
                                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                                <input type="hidden" name="action" value="change" />
                                
                                <tr>
                                    <td class="heading" colspan=3>Document Retrieval</td>
                                </tr>

                                <tr>
                                    <td class="oddrow-l" nowrap><label for="maxThreads1">Maximum Threads</label></td>
                                    <td class="oddrowdata-l">
                                        %ifvar isBrokerConfigured equals('true')%
                                            <script>
                                                writeEdit("edit",
                                                          "maximumDocumentRetrievalThreadsPct",
                                                          "%value maximumDocumentRetrievalThreadsPct encode(html_javascript)%",'maxThreads1');
                                            </script>
                                            %
                                        %else%
                                            <input type="hidden" id="maxThreads1" name="maximumDocumentRetrievalThreadsPct" value="Broker Not Configured">
                                            (Broker Not Configured)
                                        %endif%
                                    </td>
                                </tr>

                                <tr>
                                    <td class="evenrow-l" nowrap><label for="triggerDocumentStoreThrottle">Queue Capacity Throttle</label></td>
                                    <td class="evenrowdata-l">
                                        <select id="triggerDocumentStoreThrottle" name=triggerDocumentStoreThrottle size=1 onChange="retrievalChange();">
                                            <option %ifvar triggerDocumentStoreThrottle equals('100')% selected="selected" %endif% value="100" > 100% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('90')%  selected="selected" %endif% value="90"  >  90% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('80')%  selected="selected" %endif% value="80"  >  80% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('70')%  selected="selected" %endif% value="70"  >  70% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('60')%  selected="selected" %endif% value="60"  >  60% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('50')%  selected="selected" %endif% value="50"  >  50% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('40')%  selected="selected" %endif% value="40"  >  40% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('30')%  selected="selected" %endif% value="30"  >  30% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('20')%  selected="selected" %endif% value="20"  >  20% </option>
                                            <option %ifvar triggerDocumentStoreThrottle equals('10')%  selected="selected" %endif% value="10"  >  10% </option>
                                        </select>
                                        of maximum
                                    </td>
                                </tr>

                                <tr>
                                    <td class="heading" colspan=3>Document Processing</td>
                                </tr>

                                <tr>
                                    <td class="oddrow-l" nowrap><label for="maxthreads">Maximum Threads</label></td>
                                    <td class="oddrowdata-l">
                                        <script>
                                            writeEditWithID("edit",
                                                      "maximumTriggerExecutionThreadsPct",
                                                      "%value maximumTriggerExecutionThreadsPct encode(html_javascript)%",'maxthreads');
                                        </script>
                                        %
                                    </td>
                                </tr>

                                <tr>
                                    <td class="evenrow-l" nowrap><label for="triggerExecutionThreadsThrottle">Execution Threads Throttle</label></td>
                                    <td class="evenrowdata-l">
                                        <select id="triggerExecutionThreadsThrottle" name="triggerExecutionThreadsThrottle" size=1 onChange="executionChange();">
                                            <option %ifvar triggerExecutionThreadsThrottle equals('100')% selected="selected" %endif% value="100" > 100% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('90')%  selected="selected" %endif% value="90"  >  90% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('80')%  selected="selected" %endif% value="80"  >  80% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('70')%  selected="selected" %endif% value="70"  >  70% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('60')%  selected="selected" %endif% value="60"  >  60% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('50')%  selected="selected" %endif% value="50"  >  50% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('40')%  selected="selected" %endif% value="40"  >  40% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('30')%  selected="selected" %endif% value="30"  >  30% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('20')%  selected="selected" %endif% value="20"  >  20% </option>
                                            <option %ifvar triggerExecutionThreadsThrottle equals('10')%  selected="selected" %endif% value="10"  >  10% </option>
                                        </select>
                                        of maximum
                                    </td>
                                </tr>
                                
                                <script>
                                  if (showCluster()) {
                                    w("<tr>");
                                    w("<td class='heading' colspan='2'>Change Mode</td>");
                                    w("</tr>");
                                    w("<tr>");
                                    w("<td class='evenrow-l'>Apply change across cluster</td>");
                                    w("<td class='evenrowdata-l'><INPUT TYPE='CHECKBOX' NAME='applyChangeAcrossCluster' value='true'></td>");
                                    w("</tr>");
                                  }
                                </script>

                                <tr>
                                    <td colspan="4" class="action">
                                        <input type="submit" name="submit" value="Save Changes"/>
                                    </td>
                                </tr>
                            </form>
                        </table>
                    </td>
                </tr>
            %endinvoke%
        </table>
    </body>
</html>
