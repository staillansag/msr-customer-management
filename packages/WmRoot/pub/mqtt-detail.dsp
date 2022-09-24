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

<body onLoad="setNavigation('mqtt-detail.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_MQTTAliasDetailsScrn');">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; MQTT Settings &gt; MQTT Connection Alias</TD>
    </tr>
    %ifvar action equals('edit')%  
    
      %invoke wm.server.mqtt:updateConnectionAlias%
        <tr>
          <td colspan="2">&nbsp;</td>
          </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</TD>
        </tr>
      %endinvoke%
    %endif%

    %invoke wm.server.mqtt:getConnectionAliasReport%

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_mqtt", "mqtt.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("mqtt.dsp","javascript:document.htmlform_settings_mqtt.submit();","Return to MQTT Settings")</script>
		  </li>

          %ifvar enabled equals('false')%
		    <script>
		    createForm("htmlform_settings_mqtt_edit", "mqtt-edit.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_mqtt_edit", "name", "%value name encode(url)%");
		    </script>
            <li class="listitem">
			<script>getURL("mqtt-edit.dsp?name=%value name encode(url)%","javascript:document.htmlform_settings_mqtt_edit.submit();","Edit MQTT Connection Alias")</script>
			</li>
          %else%
            <li class="listitem"><div class="disabledLink">Edit MQTT Connection Alias</div></li>
          %endif%
        </ul>
      </td>
    </tr>
    <tr>
      <td>
        <table class="tableView" width="100%">

          <form>
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          
          <!--                        -->
          <!-- General Settings       -->
          <!--                        -->

          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>
          <!-- Connection Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Connection Alias Name</td>
            <td class="oddrowdata-l">%value name encode(html)%</td>
          </tr>
          </tr>
          <!-- Description -->
          <tr>
            <td class="oddrow-l" scope="row">Description</td>
            <td class="oddrowdata-l">%value description encode(html)%</td>
          </tr>
          <!-- Package -->
          <tr>
            <td class="oddrow-l" scope="row">Package</td>
            <td class="oddrowdata-l">%value package encode(html)%</td>
          </tr>
          <!-- Enabled -->
          <tr>
            <td class="evenrow-l" scope="row">Enabled</td>
            %ifvar enabled equals('true')%
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</td>
            %else%
              <td class="evenrowdata-l">No</td>
            %endif%
	      </table>

        <!--                               -->
        <!-- Connection Protocol Settings  -->
        <!--                               -->
        <table class="tableView" width="100%">
          <tr>
            <td class="heading" colspan=2>Connection Protocol Settings</td>
          </tr>

          <!-- host -->
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Host</td>
            <td class="oddrowdata-l">%value host encode(html)%</td>
          </tr>

          <!-- Client ID -->
          <tr>
            <td class="oddrow-l" scope="row">Connection Client ID</td>
            <td class="oddrowdata-l"><i>%value clientIdPrefix%</i>%value clientId encode(html)%</td>
          </tr>

          <!-- Clean Session -->
          <tr>
            <td class="evenrow-l" scope="row">Use Clean Session for Subscriptions</td>
            %ifvar cleanSessionEnabled equals('true')%
              <td class="evenrowdata-l">Yes</td>
            %else%
              <td class="evenrowdata-l">No</td>
            %endif%
          </tr>

          <!-- Timeout -->
          <tr>
            <td class="oddrow-l" scope="row">Connection Timeout</td>
            <td class="oddrowdata-l">%value timeout encode(html)%</td>
          </tr>

          <!-- Keep Alive -->
          <tr>
            <td class="oddrow-l" scope="row">Keep Alive</td>
            <td class="oddrowdata-l">%value keepAlive encode(html)%</td>
          </tr>
	      </table>

        <!--                        -->
        <!-- Last-Will Settings          -->
        <!--                        -->

        <table class="tableView" width="100%">
          <tr>
            <td class="heading" colspan=2>Last-Will Settings</td>
          </tr>
          <!-- Last-Will Enabled -->
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Enable Last-Will</td>
            %ifvar will_enabled equals('true')%
              <td class="evenrowdata-l">Yes</td>
            %else%
              <td class="evenrowdata-l">No</td>
            %endif%
          </tr>
          <!-- Last-Will QoS -->
          <tr>
            <td class="evenrow-l" scope="row">Last-Will QoS</td>
            %switch will_qos%
              %case '0'%
                <td>At most once (0)</td>
              %case '1'%
                <td>At least once (1)</td>
              %case '2'%
                <td>Exactly once (2)</td>
              %case%
                <td>&nbsp;</td>
            %end%
          </tr>
          <!-- Last-Will Retained -->
          <tr>
            <td class="evenrow-l" scope="row">Last-Will Retained</td>
            %ifvar will_retain equals('true')%
              <td class="evenrowdata-l">Yes</td>
            %else%
             <td class="evenrowdata-l">No</td>
            %endif%
          </tr>
          <!-- Last-Will Topic -->
          <tr>
            <td class="evenrow-l" scope="row">Last-Will Topic</td>
            <td class="evenrowdata-l">%value will_topic encode(html)%</td>
          </tr>
          <!-- Last-Will Message Payload -->
          <tr>
            <td class="evenrow-l" scope="row">Last-Will Message Payload</td>
            <td class="evenrowdata-l">%value will_payload encode(html)%</td>
          </tr>
          <!-- On Connect Message Payload -->
          <tr>
            <td class="evenrow-l" scope="row">On Connect Message Payload</td>
            <td class="evenrowdata-l">%value will_onConnectPayload encode(html)%</td>
          </tr>
          <!-- On Disconnect Message Payload -->
          <tr>
            <td class="evenrow-l" scope="row">On Disconnect Message Payload</td>
            <td class="evenrowdata-l">%value will_onDisconnectPayload encode(html)%</td>
          </tr>
        </table>

        <!--                        -->
        <!-- Advanced Settings      -->
        <!--                        -->

        <!--
        <table class="tableView" width="100%">
          <tr>
            <td class="heading" colspan=2>Advanced Settings</td>
          </tr>
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Enable CSQ</td>
            %ifvar useCsq equals('true')%
              <td class="evenrowdata-l">Yes</td>
            %else%
              <td class="evenrowdata-l">No</td>
            %endif%
          </tr>
          <tr>
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
	      </table> -->

        <!--                        -->
        <!-- Security Settings      -->
        <!--                        -->

        <table class="tableView" width="100%">
          <tr>
            <td class="heading" colspan=2>Security Settings</td>
          </tr>
          <!-- User -->
          <tr>
            <td width="40%" class="evenrow-l" scope="row" nowrap="true">User</td>
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

		  <!-- Use SSL -->
          <tr>
            <td width="40%" class="evenrow-l" scope="row" nowrap="true">Use SSL</td>
            %ifvar useSSL equals('Yes')%
            	<td class="evenrowdata-l">%value useSSL encode(html)%</td>
            %else%
                <td class="evenrowdata-l">No</td>
            %endif%
          </tr>

		  %ifvar useSSL equals('Yes')%
		  <!-- Truststore alias -->
          <tr>
            <td class="oddrow-l" scope="row">Truststore Alias</td>
            <td class="oddrowdata-l">%value truststoreAlias encode(html)%</td>
          </tr>

		   <!-- Keystore alias -->
          <tr>
            <td class="evenrow-l" scope="row">Keystore Alias</td>
            <td class="evenrowdata-l">%value keystoreAlias encode(html)%</td>
          </tr>

		  <!-- Key alias -->
          <tr>
            <td class="oddrow-l" scope="row">Key Alias</td>
            <td class="oddrowdata-l">%value keystoreKeyAlias encode(html)%</td>
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
