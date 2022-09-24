<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">   
    <meta http-equiv="Expires" content="-1">
    <title>Integration Server Settings</title>
    <link rel="stylesheet" type="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%  
    <script src="webMethods.js"></script>
  </head>

  %ifvar triggerName equals('all')%
    <body onLoad="setNavigation('mqtt-edit-state.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_MQTTEditTriggerGlobalScrn');">
  %else%
    <body onLoad="setNavigation('mqtt-edit-state.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_MQTTEditTriggerIndvidualScrn');">
  %endif%
                                 
    <table width="100%">
      <tbody>
        <tr>
          %ifvar triggerName equals('all')%
            <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; MQTT Trigger Management &gt; Edit State<br>
          %else%
            <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; MQTT Trigger Management &gt; Edit State: %value triggerName encode(html)%<br>
          %endif%
          </td>
        </tr>
        <tr>
        <tr>
          <td colspan="2">
            <ul class="listitems">
              <script>    
  		          createForm("htmlform_mqtt_trigger_management", "mqtt-trigger-management.dsp", "POST", "BODY");
  		        </script>
  		        <li class="listitem">
                <script>getURL("mqtt-trigger-management.dsp?", "javascript:document.htmlform_mqtt_trigger_management.submit();", "Return to MQTT Trigger Management");</script>
              </li>
            </ul>
          </td>
        </tr>
        <tr>
          <td>
            <table class="tableView">
              <tbody>
          
                <!-- --------- -->
                <!-- Edit Form -->
                <!-- --------- -->
            
                <form name="editform" action="mqtt-trigger-management.dsp" METHOD="POST">
                  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                  %ifvar triggerName equals('all')%
                    <tr>
                      <td class="heading" colspan="2">Edit Triggers State</td>
                    </tr>
                    <tr>
                      <td class="oddrow-l"><label for="action">New State</label></td>
                      <td class="oddrowdata-l">
                        <select size ="1" name="action" ID="action">
                          <option value="enableTrigger">Enabled</option>
                          <option value="disableTrigger">Disabled</option>
                          <option value="suspendTrigger">Suspended</option>
                        </select>
                      </td>
                    </tr>
                  
                  %else%
                    <tr>
                      <td class="heading" colspan="2">Edit Trigger State</td>
                    </tr>
                    <tr>
                      <td class="oddrow-l"><label for="action">New State</label></td>
                      <td class="oddrowdata-l">
                        <select size ="1" name="action" ID="action">
                          %switch startingState%
                            %case 'ENABLED'%
                              <option value="disableTrigger">Disabled</option>
                              <option value="suspendTrigger" selected>Suspended</option>
                            %case 'ENABLED*'%
                              <option value="disableTrigger">Disabled</option>
                            %case 'SUSPENDED'%
                              <option value="enableTrigger" selected>Enabled</option>
                              <option value="disableTrigger">Disabled</option>
                            %case%
                              <option value="enableTrigger">Enabled</option>
                          %end%
                        </select>
                      </td>
                    </tr>
                  %endif%
                  
                  <tr>
                    <td class="action" colspan=2>
                      <input name="triggerName" type="hidden" value="%value triggerName encode(htmlattr)%">
                      %ifvar startingState equals('Suspend')%
                        <input name="action" type="hidden" value="suspendTrigger">
                      %else%
                        %ifvar setState equals('Enable')%
                          <input name="action" type="hidden" value="enableTrigger">
                        %endif%
                      %endif%            
                      <input type="submit" value="Save Changes">
                    </td>
                  </tr>
                </form>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
    </table>
  </body>
</html>
