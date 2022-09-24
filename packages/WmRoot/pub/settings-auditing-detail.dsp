<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js">
  </script>
  
</head>

%switch loggerName%
    %case 'Document Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_DocumentLoggerScrn');">
    %case 'Error Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ErrorLoggerScrn');">
    %case 'Guaranteed Delivery Inbound Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GDInboundLoggerScrn');">
    %case 'Guaranteed Delivery Outbound Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GDOutboundLoggerScrn');">
    %case 'Messaging Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_MessagingLoggerScrn');">
    %case 'Security Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SecurityLoggerScrn');">
    %case 'Service Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ServiceLoggerScrn');">
    %case 'Session Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SessionsLoggerScrn');">
    %case 'Mediator Transaction Logger'%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_MediatorTransactionLoggerScrn');">
    %case%
                <body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LoggingScrn');">
%endswitch%

<table name="pagetable" align='left' width="100%">

    <tr>
      <td class="breadcrumb" colspan="4">Settings &gt; Logging &gt; View %value loggerNameDisplay encode(html)% Details</td>
    </tr>

    %ifvar action equals('saveAuditData')%

        %ifvar sec-audit-conf-saved -notempty%
            %ifvar status -notempty%
                  %rename status status -copy%
            %endif%

            %ifvar result -notempty%
              %rename result result -copy%
            %endif%

            %ifvar selAreas -notempty%
               %rename selAreas categories -copy%
            %endif%

            %ifvar startup -notempty%
              %rename startup startup -copy%
            %endif%

        %endif%

        %invoke wm.server.auditing:setAuditLoggerDetails%

            %ifvar message%
                <tr>
                  <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
				  <td class="message" colspan=2>%value message encode(html)%</td>
                </tr>
            %endif%
        %onerror%
            <tr>
			  <td class="message" colspan=2>%value errorMessage encode(html)%</td>
            </tr>
        %endinvoke%
    %endif%


%invoke wm.server.auditing:getAuditLoggerDetails%

  <script>
      var catlist = new Array();
      var j=0;
      %loop categories%
  		catlist[j]="%value encode(javascript)%";
          j++;
      %endloop%
          function writeImageForEnabled(val) {
              for(i = 0; i < catlist.length; i++) {
                  if(val==catlist[i]) {
                      document.write("<div align='center'><img src='images/green_check.png' border='0' alt='Selected' height='13' width='13'></div>");
                      return true;
                  }
              }
          }
 </script>

    <tr>
      <td colspan="2">
        <ul>
		
		%scope%
		%rename ../loggerNameDisplay inString -copy%				
		%invoke wm.server.csrfguard:replaceSpecialCharacters%
		
		<script>
		createForm("%value replacedString encode(url)%_return", "settings-auditing.dsp", "POST", "BODY");
		createForm("%value replacedString encode(url)%_edit", "settings-auditing-edit.dsp", "POST", "BODY");
		setFormProperty("%value replacedString encode(url)%_edit", "loggerName", "%value loggerName%");
		
		</script>
          
		  <li>
		  <script>getURL("settings-auditing.dsp","javascript:document.%value replacedString encode(url)%_return.submit();","Return to Logger List")</script></li>
		  
          <li>
		  <script>getURL("settings-auditing-edit.dsp?loggerName=%value loggerName encode(url)%","javascript:document.%value replacedString encode(url)%_edit.submit();","Edit %value loggerNameDisplay encode(html)%")</script></li>
		  
		%endinvoke%
		%endscope%
		  <!--
          <li><a href="settings-auditing-edit.dsp?loggerName=%value loggerName encode(url)%">Edit %value loggerNameDisplay encode(html)%</a></li>
		  -->
        </ul>
      </td>
    </tr>

         <TR>
                <TD>
                    <table width="100%" class="tableView">
                    <TR>
                             <TD colspan="2" class="heading">Audit Logger Configuration</TD>
                        </TR>

                      <tr>
                        <td class="evenrow-l" style="width: 50%">Name</td>
                        <td class="evenrowdata-l" style="width: 50%">%value loggerNameDisplay encode(html)%</td>
                      </tr>

                      <tr>
                        <td class="evenrow-l">Enabled</td>
                        %ifvar isEnabled equals('true')%
                        <td class="evenrowdata-l">Yes</td>
                        %else%
                        <td class="evenrowdata-l">No</td>
                        %endif%

                      </tr>

                      %ifvar hasLevel equals('true')%
                          <tr>
                            <td class="evenrow-l">Level</td>
                            <td class="evenrowdata-l">%value level encode(html)%</td>
                          </tr>
                      %endif%

                      <tr>
                        <td class="evenrow-l">Mode</td>
                        %ifvar isAsynchronous equals('true')%
                        <td class="evenrowdata-l">Asynchronous</td>
                        %else%
                        <td class="evenrowdata-l">Synchronous</td>
                        %endif%
                      </tr>

                      <tr>
                        <td class="evenrow-l">Guaranteed</td>
                        %ifvar isGuaranteed equals('true')%
                        <td class="evenrowdata-l">Yes</td>
                        %else%
                        <td class="evenrowdata-l">No</td>
                        %endif%
                      </tr>

                      <tr>
                        <td class="evenrow-l">Destination</td>

                        %ifvar isDatabase equals('true')%
                        <td class="evenrowdata-l">Database</td>
                        %else%
                        <td class="evenrowdata-l">File</td>
                        %endif%

                      </tr>

                      <tr>
                        <td class="evenrow-l">Maximum Queue Size</td>
                        <td class="evenrowdata-l">%value maxQueueSize% log entries</td>
                      </tr>

                      <tr>
                        <td class="evenrow-l">Queue Provider</td>

                        %ifvar queueType equals('lwq')%
                            <td class="evenrowdata-l">Internal</td>
                        %else%
                            <td class="evenrowdata-l">Univeral Messaging</td>
                        %endif%
                      </tr>

                      <tr>
                        <td class="evenrow-l">Connection Alias</td>
                        %ifvar queueType equals('lwq')%
                            <td class="evenrowdata-l"></td>
                        %else%
                            <td class="evenrowdata-l">%value connectionAlias%</td>
                        %endif%
                      </tr>

                      <tr>
                         <td class="evenrow-l">Maximum Retries</td>
                         <td class="evenrowdata-l">%value maxRetries encode(html)%</td>
                      </tr>
					
                      <tr>
                         <td class="evenrow-l">Wait Between Retries</td>
                         <td class="evenrowdata-l">%value retryWait encode(html)% seconds</td>
                      </tr>


                       %ifvar hasSecurity equals('true')%

                          <tr>
                              <td class="evenrow-l">Generate Auditing Data on Startup</td>
                              <td class="evenrowdata-l">
                                 %ifvar startup equals('true')%
                                   Yes
                                 %else%
                                   No
                                 %endif%
                              </td>
                          </tr>

                        <tr>
                            <td class="evenrow-l">Generate Auditing Data on </td>
                            <td class="evenrowdata-l">

                            %ifvar result equals('Success')%
                               Success
                            %endif%

                            %ifvar result equals('Failure')%
                               Failure
                            %endif%

                            %ifvar result equals('Success or Failure')%
                               Success or Failure
                            %endif%
                            </td>
                        </tr>

                       %endif%                       
                    </table>
                </td>
            </tr>

            <tr>
            <TD valign="top">
                    <table width="100%" class="tableView">
                    <TR>
                             <TD colspan="2" class="heading">Audit Logger Reader Configuration</TD>
                        </TR>

                      <tr>
                        <td class="evenrow-l" style="width: 50%">Number of Readers</td>
                        <td class="evenrowdata-l" style="width: 50%">%value readerThreads%</td>
                      </tr>
                      </table>
            </td>


            </TR>

            %ifvar hasSecurity equals('true')%
            <TR>
                <TD>
                    <table width="100%" class="tableView">
                    <TR>
                             <TD colspan="2" class="heading">Security Areas to Audit</TD>
                        </TR>

                     %ifvar status equals('true')%
                        %loop defaultAreas%
                            <tr class="evenrow-l">
                                    <td width="2em">
                                        <script>
										writeImageForEnabled("%value encode(javascript)%");
                                    </script>
                                </td>
							<td>%value encode(html)%</td>
                            </tr>
                            %endloop%
                    %else%
                            %loop defaultAreas%
                            <tr class="evenrow-l">
                                <td width="2em">
                                </td>
							<td>%value encode(html)%</td>
                            </tr>
                            %endloop%
                    %endif%

                    </table>
                </TD>
            </TR>
            %endif%
            
            %ifvar hasMessaging equals('true')%
            <TR>
                <TD>
                    <table width="100%" class="tableView">
                    <TR>
                             <TD colspan="2" class="heading">Messaging Audit Log Level</TD>
                        </TR>

                     <tr>
                              <td class="evenrow-l" style="width: 50%">Logging Level</td>
                              <td class="evenrowdata-l" style="width: 50%">
                                 %ifvar logLevel equals('0')%
                                   Info
                                 %endif%
                                 %ifvar logLevel equals('1')%
                                   Debug
                                 %endif%  
                                 %ifvar logLevel equals('2')%
                                   Trace
                                 %endif%
                              </td>
                          </tr>

                    </table>
                </TD>
            </TR>
            %endif%
            
    </table>
  </body>
</html>
