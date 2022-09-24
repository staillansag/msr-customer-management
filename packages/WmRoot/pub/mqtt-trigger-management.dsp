<html>

  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%  
    <script src="webMethods.js"></script>
  
    <script language ="javascript">
  
      /**
       *
       */
      function loadDocument() {
      
        setNavigation('settings-mqtt.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_MQTTTriggerMgmtScrn');
      }
     
      /**
       *
       */     
      function refreshDSP() { 
  
        if(is_csrf_guard_enabled && needToInsertToken) {
          var appendStrAmp = '';
          var appendStrQue = '';
          if(is_csrf_guard_enabled && needToInsertToken) {
            appendStrAmp = "&"+_csrfTokenNm_+"="+_csrfTokenVal_ 
            appendStrQue = "?"+_csrfTokenNm_+"="+_csrfTokenVal_ 
          }
          createForm("htmlform_settings_mqtt_trigger_management", "mqtt-trigger-management.dsp", "POST", "BODY");
  	      setFormProperty("htmlform_settings_mqtt_trigger_management", _csrfTokenNm_, _csrfTokenVal_);
          window.location = "javascript:document.htmlform_settings_mqtt_trigger_management.submit();";
        }else {
          var appendStrAmp = '';
          var appendStrQue = '';
          if(is_csrf_guard_enabled && needToInsertToken) {
            appendStrAmp = "&"+_csrfTokenNm_+"="+_csrfTokenVal_ 
            appendStrQue = "?"+_csrfTokenNm_+"="+_csrfTokenVal_ 
          }
          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
          var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
		    window.location = "mqtt-trigger-management.dsp?webMethods-wM-AdminUI=true";
		  }
		  else {
		    window.location = "mqtt-trigger-management.dsp";
		  }
        }
      } 
    </script>
  </head>
  
  <body onLoad="loadDocument();">
    <table width="100%">
      <tr>
        <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; MQTT Trigger Management</td>
      </tr>
  
      <!-- Enable/Disable Logic -->
                   
      %switch action%
        <!-- Stop/Suspend/Enable Trigger Logic -->     
        %case 'suspendTrigger'%
          %invoke wm.server.mqtt:suspendTriggers%
            <tr>
              <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
              <td class="message" colspan=2>%value message encode(html)%</td>
            </tr>
          %onerror%
            <tr>
              <td class="message" colspan=2>%value errorMessage encode(html)%</td>
            </tr>
          %endinvoke%  
          %rename triggerName editedTriggerName%
      
        %case 'enableTrigger'%
          %invoke wm.server.mqtt:enableTriggers%
            <tr>
              <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
              <td class="message" colspan=2>%value message encode(html)%</td>
            </tr>
          %onerror%
            <tr>
              <td class="message" colspan=2>%value errorMessage encode(html)%</td>
            </tr>
          %endinvoke%
          %rename triggerName editedTriggerName%
        
        %case 'disableTrigger'%  
          %invoke wm.server.mqtt:disableTriggers%
            <tr>
              <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
              <td class="message" colspan=2>%value message encode(html)%</td>
            </tr>
          %onerror%
            <tr>
              <td class="message" colspan=2>%value errorMessage encode(html)%</td>
            </tr>
          %endinvoke%
          %rename triggerName editedTriggerName%
        %case 'filter'%
      %end%
      
      %invoke wm.server.mqtt:getTriggerReport%  

        <!-- Navigation Menu -->
        <tr>
          <td colspan="2">
            <ul class="listitems">
    		      <script>
    		        createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
    		        createForm("htmlform_settings_mqtt", "mqtt.dsp", "POST", "BODY");
    		      </script>
              %ifvar webMethods-wM-AdminUI% 
              %else%
              <li class="listitem"><script>getURL("settings-messaging.dsp", "javascript:document.htmlform_settings_messaging.submit();", "Return to Messaging");</script>
    		      </li>
              <li class="listitem"><script>getURL("mqtt.dsp", "javascript:document.htmlform_settings_mqtt.submit();", "View MQTT Settings");</script>
    		      </li>
              %endif%
              <li class="listitem"><a href="javascript:refreshDSP(); void 0">Refresh Page</a>
              </li>
            </ul>
            
          </td>
        </tr>
        
        <tr>
          <td>
    
            <!-- MQTT Trigger Controls  -->
            <table width="100%" class="tableView">  
            
              <tr>
                <td class="heading" colspan=9>
                  &nbsp;MQTT Trigger Controls
                </td>
              </tr>
     
              <tr>
                <td class="subheading2">Trigger Name</td>
                <td class="subheading2" nowrap>
                  State&nbsp;&nbsp;
                  %ifvar webMethods-wM-AdminUI%
                    <a href="mqtt-edit-state.dsp?triggerName=all&webMethods-wM-AdminUI=true" >
                      edit&nbsp;all
                    </a>
                  %else%
                    <a href="mqtt-edit-state.dsp?triggerName=all" >
                      edit&nbsp;all
                    </a>
                  %endif%
                </td>
                <td class="subheading2" scope="col" >Status</td>
                <td class="subheading2" scope="col" >Connection Alias Name</td>
                <td class="subheading2" scope="col" nowrap>Topic</td>
                <td class="subheading2" scope="col" >Queue Capacity</td>
                <td class="subHeading2" scope="col" >Current Queue Count</td> 
                <td class="subheading2" scope="col" >Maximum Threads</td>
                <td class="subHeading2" scope="col" >Current Threads</td>
              </tr> 

              %loop triggerDataList%
                
                <tr>
                  <!-- trigger name -->
                  <td>   
                    %value node_nsName encode(html) encode(html)%      
                  </td>
                      
                  <!-- State -->
                                         
                  <td>
                    %ifvar trigger/triggerRuntimeData/connected equals('true')%
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">
                    %else%
                      <img style="width: 13px; height: 13px;" alt="inactive" border="0" src="images/yellow_check.png">
                    %endif%
                    
                    %switch trigger/triggerRuntimeData/state%      
                      %case 'ENABLED'%
                        
                        <script>
                          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						  var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							  document.write('<a href="mqtt-edit-state.dsp?triggerName=%value node_nsName encode(url)%&startingState=%value trigger/triggerRuntimeData/state encode(url)%%ifvar trigger/triggerRuntimeData/connected equals('false')%*%endif%&webMethods-wM-AdminUI=true"> ');
						  }
						  else {
							  document.write('<a href="mqtt-edit-state.dsp?triggerName=%value node_nsName encode(url)%&startingState=%value trigger/triggerRuntimeData/state encode(url)%%ifvar trigger/triggerRuntimeData/connected equals('false')%*%endif%"> ');
						  }
                          document.write('%value trigger/triggerRuntimeData/state_display encode(html)%');
                          document.write('</a>');    
                        </script>
                         
                      %case 'SUSPENDED'%
                        <script>
                          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
                          var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							  document.write('<a href="mqtt-edit-state.dsp?triggerName=%value node_nsName encode(url)%&startingState=%value trigger/triggerRuntimeData/state encode(url)%&webMethods-wM-AdminUI=true"> ');
						  }
						  else {
							  document.write('<a href="mqtt-edit-state.dsp?triggerName=%value node_nsName encode(url)%&startingState=%value trigger/triggerRuntimeData/state encode(url)%"> ');
						  }
                          document.write('%value trigger/triggerRuntimeData/state_display encode(html)%');
                          document.write('</a>');
                        </script>

                      %case%                      
                        <script>
                          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
                          var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							  document.write('<a href="mqtt-edit-state.dsp?triggerName=%value node_nsName encode(url)%&startingState=%value trigger/triggerRuntimeData/state encode(url)%&webMethods-wM-AdminUI=true"> ');
						  }
						  else {
							  document.write('<a href="mqtt-edit-state.dsp?triggerName=%value node_nsName encode(url)%&startingState=%value trigger/triggerRuntimeData/state encode(url)%"> ');
						  }
                          document.write('%value trigger/triggerRuntimeData/state_display encode(html)%');
                          document.write('</a>');
                        </script>
                    %end%
                  </td>
                    
                  <!-- Status -->
                 
                  %ifvar trigger/triggerRuntimeData/lastError_display%  
                    <td>
                      <font color=red>%value trigger/triggerRuntimeData/combinedStatus%</font>
                    </td> 
                  %else%
                    <td nowrap="true">
                      %value trigger/triggerRuntimeData/combinedStatus%
                    </td>
                  %endif%     
       
                  <!-- Alias, Dest, Mode, Max, Current, Error --> 
                    
                  <script>writeTD("row-l");</script>%value trigger/aliasName encode(html)%</td>
                  <script>writeTD("row-l");</script>%value trigger/topic encode(html)%</td>   
                  <script>writeTD("row-l");</script>%value trigger/queueCapacity encode(html)%</td>  
                  <script>writeTD("row-l");</script>%value trigger/triggerRuntimeData/queueSize encode(html)%</td> 
                  <script>writeTD("row-l");</script>%value trigger/maxConcurrentThreads encode(html)%</td> 
                  <script>writeTD("row-l");</script>%value trigger/triggerRuntimeData/threadCount encode(html)%</td>                
                </tr>  
                %ifvar trigger/triggerRuntimeData/lastError_display%   
                  <tr>
                    <td colspan="9"><font color=red>%value trigger/triggerRuntimeData/lastError_display%</font></td>
                  </tr>
                %endif%       
              %endloop%                            
            </table>
          </td>
        </tr>    
      %endinvoke%   
    </table>
  </body>
</html>
                                