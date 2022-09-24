<HTML>
<HEAD>


<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<SCRIPT SRC="webMethods.js"></SCRIPT>

<style>

.disabledLink
{
   color:#0D109B;
}

</style>

</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMSaliasDetailsScrn');">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JMS Settings &gt; JMS Connection Alias</TD>
    </tr>

    %ifvar action equals('edit')%
      %invoke wm.server.jms:updateConnectionAlias%
        <tr>
          <td colspan="2">&nbsp;</td>
          </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</TD>
        </tr>
      %endinvoke%
    %endif%

    %invoke wm.server.jms:getConnectionAliasReport%

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jms", "settings-jms.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-jms.dsp","javascript:document.htmlform_settings_jms.submit();","Return to JMS Settings")</script>
		  </li>

          %ifvar enabled equals('false')%
		    <script>
		    createForm("htmlform_settings_jms_edit", "settings-jms-edit.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_jms_edit", "aliasName", "%value aliasName encode(url)%");
		    </script>
            <li class="listitem">
			<script>getURL("settings-jms-edit.dsp?aliasName=%value aliasName encode(url)%","javascript:document.htmlform_settings_jms_edit.submit();","Edit JMS Connection Alias")</script>
			</li>

        <!--    %ifvar hasTriggers equals('true')%
              <li><div class="disabledLink">Delete JMS Connection Alias</div></li>
            %else%
              <li class="listitem"><a href="settings-jms.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="javascript:return confirm('Are you sure you want to delete Connection Alias %value connectionAliasName%?')">
                  Delete JMS Connection Alias</a>&nbsp;
              </li>
            %endif%
        -->

          %else%
            <li class="listitem"><div class="disabledLink">Edit JMS Connection Alias</div></li>
           <!--  <li><div class="disabledLink">Delete JMS Connection Alias</div></li> -->
          %endif%
        </ul>
      </td>
    </tr>
    <tr>
      <td>
        <table class="tableView" width="100%">

          <form>
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>

          <!-- Connection Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Connection Alias Name</td>
            <td class="oddrowdata-l">%value aliasName encode(html)%</td>
          </tr>

          <!-- Enabled -->
          <tr>
            <td class="evenrow-l" scope="row">Enabled</td>
            %ifvar enabled equals('true')%
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</td>
            %else%
          <td class="evenrowdata-l">No</td>
        %endif%
          </tr>

          <!-- Active
          <tr>
            <td class="oddrow-l">Active</td>
            %ifvar active equals('true')%
              <td class="oddrowdata-l"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</td>
            %else%
          <td class="oddrowdata-l">No</td>
        %endif%
          </tr>
          -->

          <!-- Description -->
          <tr>
            <td class="oddrow-l" scope="row">Description</td>
            <td class="oddrowdata-l">%value description encode(html)%</td>
          </tr>

          <!-- Transaction Type -->
          <tr>
            <td class="evenrow-l" scope="row">Transaction Type</td>
            <td class="evenrowdata-l">
              %switch transactionType%
                %case '0'%NO_TRANSACTION<br>
                %case '1'%LOCAL_TRANSACTION<br>
                %case '2'%XA_TRANSACTION<br>
                %case%&nbsp;<br>
              %end%
            </td>
          </tr>

          <!-- Client ID -->
          <tr>
            <td class="oddrow-l" scope="row">Connection Client ID</td>
            <td class="oddrowdata-l">%value clientID encode(html)%</td>
          </tr>

          <!-- User -->
          <tr>
            <td class="evenrow-l" scope="row">User</td>
            <td class="evenrowdata-l">%value user encode(html)%</td>
          </tr>

          <!-- Pass -->
          <tr>
            <td class="oddrow-l" scope="row">Password</td>
            %ifvar password -notempty%
              <td class="oddrowdata-l">*****</td>
            %else%
              <td class="oddrowdata-l"></td>
            %endif%
          </tr>

	</table>
        <table class="tableView" width="100%">
	  
          <tr>
            <td class="heading" colspan=2>Connection Protocol Settings</td>
          </tr>

          <!-- Connect Using JNDI -->
          %ifvar associationType equals('0')%
            <tr>
              <td class="evenrow-l" width="40%" scope="row">Create Connection Using</td>
              <td class="evenrowdata-l">JNDI LOOKUP</td>
            </tr>
            <tr>
              <td class="oddrow-l" scope="row">JNDI Provider Alias</td>
              <td class="oddrowdata-l">%value jndi_jndiAliasName encode(html)%</td>
            </tr>
            <tr>
              <td class="evenrow-l" nowrap>Connection Factory Lookup Name</td>
              <td class="evenrowdata-l">%value jndi_connectionFactoryLookupName encode(html)%</td>
            </tr>
            
            <!-- Create New Connection per Trigger -->
            <tr>
            <td class="evenrow-l" scope="row">Create Administered Objects On Demand (Universal Messaging)</td>
              %switch jndi_automaticallyCreateUMAdminObjects%
              %case 'true'%
                <td class="evenrowdata-l">Yes</td>
              %case 'on'%
                <td class="evenrowdata-l">Yes</td>
              %case%
               <td class="evenrowdata-l">No</td>
             %end%
            </tr>
            
            <tr>
              <td class="evenrow-l" scope="row">Enable Follow the Master (Universal Messaging)</td>
              %switch jndi_enableFollowTheMaster%
               %case 'true'%
                <td class="evenrowdata-l">Yes</td>
               %case 'on'%
                <td class="evenrowdata-l">Yes</td>
               %case%
                <td class="evenrowdata-l">No</td>
              %end%
            </tr>
            
            <tr>
              <td class="oddrow-l" scope="row">Monitor webMethods Connection Factory</td>
              <td class="oddrowdata-l">
                %switch jndi_connectionFactoryUpdateType%
                  %case 'NONE'%No<br>
                  %case 'CLIENT_POLL'%Poll for changes (specify interval)<br>
                  %case 'JNDI_POLL'%Poll&nbsp;for&nbsp;changes (interval defined by webMethods Connection Factory)<br>
                  %case 'NOTIFICATION'%Register change listener<br>
                %end%
              </td>
            </tr>
            
            %ifvar jndi_connectionFactoryUpdateType equals('CLIENT_POLL')%
              <tr>
                <td class="evenrow-l" width="40%" scope="row">Polling Interval</td>

                %switch jndi_connectionFactoryPollingInterval%
                  %case '1'%<td class="evenrowdata-l">1 minute</td>
                  %case%<td class="evenrowdata-l">%value jndi_connectionFactoryPollingInterval encode(html)%&nbsp;minutes</td>
                %end%

              </tr>
            %endif%

          <!-- Connect Uisng WM -->
          %else%
            <tr>
              <td class="evenrow-l" width="40%" scope="row">Create Connection Using</td>
              <td class="evenrowdata-l">NATIVE WEBMETHODS API (Deprecated)</td>
            </tr>

         <!--
            <tr>
              <td class="oddrow-l">Connection Type</td>
              <td class="oddrowdata-l">
                %switch nwm_connectionType%
                  %case '0'%QUEUE<br>
                  %case '1'%TOPIC<br>
                  %case '2'%XA QUEUE<br>
                  %case '3'%XA TOPIC<br>
                  %case%<br>
                %end%
              </td>
            </tr>
          -->

            <tr>
              <td class="oddrow-l" scope="row">Broker Host</td>
              <td class="oddrowdata-l">%value nwm_brokerHost encode(html)%</td>
            </tr>

            <tr>
              <td class="evenrow-l" scope="row">Broker Name</td>
              <td class="evenrowdata-l">%value nwm_brokerName encode(html)%</td>
            </tr>

            <tr>
              <td class="oddrow-l" scope="row">Client Group</td>
              <td class="oddrowdata-l">%value nwm_clientGroup encode(html)%</td>
            </tr>

            <!--
            <tr>
              <td class="evenrow-l">Shared State</td>
              <td class="evenrowdata-l">
                %switch nwm_sharedState%
                  %case 'true'%
                    Yes<br>
                  %case 'on'%
                    Yes<br>
                  %case%
                    No<br>
                %end%
              </td>
            </tr>

            <tr>
              <td class="evenrow-l">Shared State Order</td>
              <td class="evenrowdata-l">
                %switch nwm_sharedStateOrder%
                  %case '0'%
                    NONE<br>
                  %case '1'%
                    ORDER BY PUBLISHER<br>
                %end%
              </td>
            </tr>

            <tr>
              <td class="oddrow-l">Dead Letter Only</td>
              <td class="oddrowdata-l">
                %switch nwm_deadLetterOnly%
                  %case 'true'%
                    Yes<br>
                  %case 'on'%
                    Yes<br>
                  %case%
                    No<br>
                %end%
              </td>
            </tr>

            -->

            <tr>
              <td class="evenrow-l" scope="row">Broker List</td>
              <td class="evenrowdata-l">%value nwm_brokerList encode(html)%</td>
            </tr>

            <tr>
              <td class="oddrow-l" scope="row">Keystore</td>
              <td class="oddrowdata-l">%value nwm_keystore encode(html)%</td>
            </tr>

            <tr>
              <td class="evenrow-l" scope="row">Keystore Type</td>
              <td class="evenrowdata-l">%value nwm_keystoreType encode(html)%</td>
            </tr>

            <tr>
              <td class="oddrow-l" scope="row">Truststore</td>
              <td class="oddrowdata-l">%value nwm_truststore encode(html)%</td>
            </tr>

            <tr>
              <td class="evenrow-l" scope="row">Truststore Type</td>
              <td class="evenrowdata-l">%value nwm_truststoreType encode(html)%</td>
            </tr>

            <tr>
              <td class="oddrow-l" scope="row">Encrypted</td>
               %switch nwm_encrypted%
                 %case 'true'%
                   <td class="oddrowdata-l">Yes</td>
                 %case 'on'%
                   <td class="oddrowdata-l">Yes</td>
                 %case%
                   <td class="oddrowdata-l">No</td>
               %end%
            </tr>

          %endif%

          <script>//uncomment if needed... if ("%value associationType encode(javascript)%" == 0)swapRows();</script>

	</table>
        <table class="tableView" width="100%">
	  
          <tr>
            <td class="heading" colspan=2>Advanced Settings</td>
          </tr>

          <!-- Class Loader -->
          <tr>
            <td class="row-l" width="40%" scope="row">Class Loader</td>
            <script>writeTD("rowdata-l");</script>%value classLoader encode(html)%</td>
          </tr>

          <tr>
            <script>swapRows();</script>

            <script>writeTD("row-l");</script>Maximum CSQ Size</td>

            %ifvar csqSize -notempty%

              %switch csqSize%
                %case '-1'%
                  <script>writeTD("rowdata-l");</script>[UNLIMITED]</td>
                %case '1'%
                  <script>writeTD("rowdata-l");</script>1 message</td>
                %case%
                  <script>writeTD("rowdata-l");</script>%value csqSize encode(html)% messages</td>
               %end%

            %else%
              <script>writeTD("rowdata-l");</script>[UNLIMITED]</td>
            %endif%

          </tr>

          <!-- Drain CSQ In Order --> 
          <tr>
            <script>swapRows();</script>
            <script>writeTD("row-l");</script>Drain CSQ in Order</td>
            %switch csqDrainInOrder%
              %case 'true'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case 'on'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case%
                <script>writeTD("rowdata-l");</script>No</td>
             %end%
          </tr>
          
          <!-- Create Temporary Queue -->  
          <tr>
            <script>swapRows();</script>
            <script>writeTD("row-l");</script>Create Temporary Queue</td>
            %switch optTempQueueCreate%
              %case 'true'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case 'on'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case%
                <script>writeTD("rowdata-l");</script>No</td>
             %end%
          </tr>
          
          <!-- Reply To Consumer -->  
          <tr>
            <script>swapRows();</script>
            <script>writeTD("row-l");</script>Enable Request-Reply Listener for Temporary Queue</td>
            %switch allowReplyToConsumer%
              %case 'true'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case 'on'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case%
                <script>writeTD("rowdata-l");</script>No</td>
             %end%
          </tr>

          <!-- Manage Destinations -->        
          <tr>  
            <script>swapRows();</script>
            <script>writeTD("row-l");</script>Enable Destination Management with Designer (Broker and Universal Messaging)</td>
              %switch manageDestinations%
              %case 'true'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case 'on'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case%
                <script>writeTD("rowdata-l");</script>No</td>
             %end%
          </tr>
          
          <!-- Create New Connection per Trigger -->
          <tr>
            <script>swapRows();</script>
            <script>writeTD("row-l");</script>Create New Connection per Trigger</td>
              %switch allowNewConnectionPerTrigger%
              %case 'true'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case 'on'%
                <script>writeTD("rowdata-l");</script>Yes</td>
              %case%
                <script>writeTD("rowdata-l");</script>No</td>
             %end%
          </tr>

	      </table>
        <table class="tableView" width="100%">

          <!-- Producer Pool Caching -->
          <tr>
            <td class="heading" colspan=2>Producer Caching</td>
          </tr>
        
          %ifvar producerCachingMode -notempty%
              %switch producerCachingMode%

              %case '0'%

                      <tr>
                         <td class="row-l" width="40%" scope="row">Caching Mode</td>
                      <script>writeTD("rowdata-l");</script>DISABLED</td>
                      </tr>

              %case '1'%
                      <tr>
                          <td class="row-l" width="40%" scope="row">Caching Mode</td>
                      <script>writeTD("rowdata-l");</script>ENABLED</td>
                      </tr>

                      <tr>
                          <td class="row-l" width="40%" scope="row">Minimum Pool Size</td>
                          <script>writeTD("rowdata-l");</script>%value producerSessionPoolMinSize encode(html)%</td>
                      </tr>
                     
                      <tr>
                          <td class="row-l" width="40%" scope="row">Maximum Pool Size</td>
                          <script>writeTD("rowdata-l");</script>%value producerSessionPoolSize encode(html)%</td>
                      </tr>

                      <tr>
                          <td class="row-l" width="40%" scope="row">Idle Timeout (milliseconds)</td>
                          %ifvar producerSessionPoolSize equals('0')%
                              <script>writeTD("rowdata-l");</script></td>
                          %else%
                          %ifvar poolTimeout -notempty%
                              %switch poolTimeout%
                                  %case '-1'%
                                  <script>writeTD("rowdata-l");</script>SYSTEM DEFAULT</td>
                              %case '0'%
                                  <script>writeTD("rowdata-l");</script>NEVER</td>
                              %case%
	                              <script>writeTD("rowdata-l");</script>%value poolTimeout encode(html)%</td>
                              %end%
                          %else%
                              <script>writeTD("rowdata-l");</script>SYSTEM DEFAULT</td>
                          %endif%
                          %endif%
                      </tr>

                  %case '2'%
              
                      <tr>
                          <td class="row-l" width="40%">Caching Mode</td>
                          <script>writeTD("rowdata-l");</script>ENABLED PER DESTINATION</td>
                      </tr>

                      <tr>
                          <td class="row-l" width="40%">Minimum Pool Size (unspecified destinations)</td>
                          <script>writeTD("rowdata-l");</script>%value producerSessionPoolMinSize encode(html)%</td>
                      </tr>
          
                      <tr>
                          <td class="row-l" width="40%">Maximum Pool Size (unspecified destinations)</td>
                          <script>writeTD("rowdata-l");</script>%value producerSessionPoolSize encode(html)%</td>
                      </tr>

                      <tr>
                          <td class="row-l" width="40%">Minimum Pool Size Per Destination</td>
                          <script>writeTD("rowdata-l");</script>%value cacheProducersPoolMinSize encode(html)%</td>
                      </tr>
          
                      <tr>
                          <td class="row-l" width="40%">Maximum Pool Size Per Destination</td>
                          <script>writeTD("rowdata-l");</script>%value cacheProducersPoolSize encode(html)%</td>
                      </tr>
                
                      %ifvar associationType equals('1')%
                          <!-- Using WM -->
                      <tr>
                              <td class="row-l" width="40%">Queue List (semicolon delimited)</td>
	                      <script>writeTD("rowdata-l");</script>%value cacheProducersQueueList encode(html)%</td>
                      </tr>
                      
                          <tr>
                              <td class="row-l" width="40%">Topic List (semicolon delimited)</td>
	                      <script>writeTD("rowdata-l");</script>%value cacheProducersTopicList encode(html)%</td>
                      </tr>
                      %else%
                          <!-- Using JNDI -->
                      <tr>
                              <td class="row-l" width="40%">Destination Lookup Names (semicolon delimited)</td>
                              %ifvar cacheProducersPoolSize equals('0')%
                              <script>writeTD("rowdata-l");</script>&nbsp;</td>
                              %else%
                                  <script>writeTD("rowdata-l");</script>%value cacheProducersQueueList encode(html)%</td>
                              %endif%
                      </tr>
                      %endif%

                      <tr>
                          <td class="row-l" width="40%">Idle Timeout (milliseconds)</td>
                          %ifvar producerSessionPoolSize equals('0')%
                              <script>writeTD("rowdata-l");</script></td>
                          %else%
                          %ifvar poolTimeout -notempty%
                              %switch poolTimeout%
                                  %case '-1'%
                                  <script>writeTD("rowdata-l");</script>SYSTEM DEFAULT</td>
                              %case '0'%
                                  <script>writeTD("rowdata-l");</script>NEVER</td>
                              %case%
	                              <script>writeTD("rowdata-l");</script>%value poolTimeout encode(html)%</td>
                              %end%
                          %else%
                              <script>writeTD("rowdata-l");</script>SYSTEM DEFAULT</td>
                          %endif%
                          %endif%
                      </tr>

                  %end%
          
              %else%
                  <tr>
                  <script>writeTD("rowdata-l");</script>DISABLED</td>
                  </tr>
          %endif%

          </form>

	</table>
        <table class="tableView" width="100%">

          <!-- --------------------- -->
          <!-- Producer Retry        -->
          <!-- --------------------- -->

            <tr>
                    <td class="heading" colspan=2>Producer Retry</td>
            </tr>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Max Retry Attempts</td>
                <script>writeTD("rowdata-l");</script>%value producerMaxRetryAttempts encode(html)%</td>
            </tr>
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Retry Interval (milliseconds)</td>
                <script>writeTD("rowdata-l");</script>%value producerRetryInterval encode(html)%</td>
            </tr>
            <script>swapRows();</script>
            
          </table>
          
          
          
          
          
          
          
          
       <table class="tableView" width="100%">	  
          
          <tr>
            <td class="heading" colspan=2>Enhanced Logging</td>     
          </tr>         
                                                                                        
          <TR>
            <TD width="40%" class="oddrow-l" scope="row">Logging Type</TD>
            <TD class="oddrowdata-l">                                               
              %ifvar um_loggingOutput equals('0')%SERVER LOG%else%MESSAGING AUDIT LOG%endif%   
            </TD>
          </TR>          
          <TR>
            <TD width="40%" class="oddrow-l" scope="row">Enable Producer Message ID Tracking</TD>
            <TD class="oddrowdata-l">%ifvar um_producerMessageTracking equals('true')% Yes %else% %ifvar um_producerMessageTracking equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR> 
          <TR>
            <TD class="oddrow-l" scope="row">Producer Message ID Tracking: Include Destinations (semicolon delimited)</TD>     
            <TD class="oddrowdata-l">
              %ifvar um_producerIncludedStrings -notempty%
                %value um_producerIncludedStrings encode(html)%
              %else%
                [ALL]
              %endif%
            </TD>      
          </TR> 
          
          <TR>
            <TD class="oddrow-l" scope="row">Enable Consumer Message ID Tracking</TD>
            <TD class="oddrowdata-l">%ifvar um_consumerMessageTracking equals('true')%Yes %else% %ifvar um_consumerMessageTracking equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>
          <TR>
            <TD class="oddrow-l" scope="row">Consumer Message ID Tracking: Include Triggers (semicolon delimited)</TD>
            <TD class="oddrowdata-l">
              %ifvar um_consumerIncludedStrings -notempty%
                %value um_consumerIncludedStrings encode(html)%
              %else%
                [ALL]
              %endif%
            </TD>
          </TR>

          %ifvar enabled equals('true')%
            <tr>
              <td class="subheading" colspan=2>* Enabled Connection Aliases can not be edited.</td>
            </tr>
          %endif%



        </table>
      </td>
    </tr>

    %onerror%
      %value errorService encode(html)%<br>
      %value error encode(html)%<br>
      %value errorMessage encode(html)%<br>
    %endinvoke%

  </table>
</body>
</html>
