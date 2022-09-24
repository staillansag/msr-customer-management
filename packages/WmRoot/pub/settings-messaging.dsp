<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">

<link rel="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<script src="webMethods.js"></script>
</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingScrn');">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging</td>
    </tr>
    
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>
        <table class="tableView">
            <tr>
              <td class="heading" colspan=5 nowrap>webMethods Messaging Configuration</td>
            </tr>
            <tr>
              <td colspan="2" nowrap>
                <ul class="listitems">
				<script>
				createForm("htmlform_settings_wm_messaging", "settings-wm-messaging.dsp", "POST", "BODY");
				createForm("htmlform_trigger_management", "trigger-management.dsp", "POST", "BODY");
				</script>
                  <li class="listitem">
				  <script>getURL("settings-wm-messaging.dsp","javascript:document.htmlform_settings_wm_messaging.submit();","webMethods Messaging Settings")</script></li>
                  <li class="listitem">
				  <script>getURL("trigger-management.dsp","javascript:document.htmlform_trigger_management.submit();","webMethods Messaging Trigger Management")</script></li>
                </ul>
              </td>
            </tr>

        </table>
        <table class="tableView">
            
          <tr>
            <td class="heading" colspan=5 nowrap>JMS Configuration</td>
          </tr>
          <TR>
            <TD colspan="2" nowrap>
              <ul class="listitems">
			    <script>
				createForm("htmlform_settings_jms", "settings-jms.dsp", "POST", "BODY");
				createForm("htmlform_settings_jms_trigger_management", "settings-jms-trigger-management.dsp", "POST", "BODY");
				createForm("htmlform_settings_jndi", "settings-jndi.dsp", "POST", "BODY");
				</script>
                <li class="listitem">
				<script>getURL("settings-jms.dsp","javascript:document.htmlform_settings_jms.submit();","JMS Settings")</script></li>
                <li class="listitem">
				<script>getURL("settings-jms-trigger-management.dsp","javascript:document.htmlform_settings_jms_trigger_management.submit();","JMS Trigger Management")</script></li>
                <li class="listitem">
				<script>getURL("settings-jndi.dsp","javascript:document.htmlform_settings_jndi.submit();","JNDI Settings")</script></li>
              </ul>
            </td>
          </tr>
        </table>
        
        <table class="tableView">
            
          <tr>
            <td class="heading" colspan=5 nowrap>MQTT Configuration</td>
          </tr>
          <TR>
            <TD colspan="2" nowrap>
              <ul class="listitems">
			          <script>
				          createForm("htmlform_settings_mqtt", "mqtt.dsp", "POST", "BODY");
				          createForm("htmlform_settings_mqtt_trigger_management", "mqtt-trigger-management.dsp", "POST", "BODY");
				        </script>
                <li class="listitem">
				          <script>getURL("mqtt.dsp","javascript:document.htmlform_settings_mqtt.submit();","MQTT Settings")</script>
                </li>
                <li class="listitem">
				          <script>getURL("mqtt-trigger-management.dsp","javascript:document.htmlform_settings_mqtt_trigger_management.submit();","MQTT Trigger Management")</script>
                </li>
              </ul>
            </td>
          </tr>
        </table>
        
      </td>  
    </tr>
  </table>
</body>
</html>