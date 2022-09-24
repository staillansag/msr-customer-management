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

%invoke wm.server.mqtt:getConnectionAliasReport%

<script language ="javascript">

/**
 * displaySettings
 */
function displaySettings(object) {

    if (object.options[object.selectedIndex].value == "0") {
        document.all.div1.style.display = 'block';
        document.all.div2.style.display = 'none';
    }else if (object.options[object.selectedIndex].value == "1") {
        document.all.div1.style.display = 'none';
        document.all.div2.style.display = 'block';
    }else {
        document.all.div1.style.display = 'none';
        document.all.div2.style.display = 'none';
    }
}

/**
 * loadDocument
 */
function loadDocument() {

    setNavigation('mqtt.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_MQTTAliasEditScrn');

  /*  for (i=0; i<document.editform.classLoader.options.length; i++) {
      if ("package: %value classLoader encode(javascript)%" == document.editform.classLoader.options[i].text) {
        document.editform.classLoader.selectedIndex=i;
      }
    }*/
}

/**
 * validateForm
 */
function validateForm(obj) {

    if (obj.description.value == null || isEmpty(obj.description.value)) {
        alert("Description must be specified.");
        return false;
    }

   if (isEmpty(obj.host.value)) {
          alert("Host must be specified.");
          return false;
        }

	if (!isNum(obj.timeout.value)) {
          alert("Connection Timeout must be a positive integer or 0.");
          return false;
        }

	if (!isNum(obj.keepAlive.value)) {
          alert("Connection Keep Alive must be a positive integer or 0.");
          return false;
        }

    if (isEmpty(obj.clientId.value)) {
        alert("Connection Client ID must be specified.");
        return false;
    }else {
        var str = obj.clientId.value;
        var result = /^([A-Za-z][_A-Za-z0-9$]*)$/.test(str);
        if (!result) {
            alert("Connection Client ID must contain only letters, digits, underscores and dollar characters; and it must start with a letter.");
            return false;
        }
    }

    if (obj.will_enabled.checked) {
          if (obj.will_qos.value == -1) {
            alert("Last-Will QoS must be specified.");
            return false;
          }

          if (isEmpty(obj.will_topic.value)) {
            alert("Last-Will Topic must be specified.");
            return false;
          }
        }

	if (((obj.user.value!="")&& (obj.password.value=="")) || ((obj.user.value=="")&& (obj.password.value!="")) ) {

        alert("Both username and password must be specified.");
        return false;
    }

    var ssl = obj.useSSL.value;
   	var host = obj.host.value.toLowerCase();

    if(host.startsWith('ssl://') && ssl == 'No'){
      	alert("Use SSL must be Yes if host uri starts with ssl://.");
      	return false;
     }

    if (ssl == 'Yes') {
    	if(!host.startsWith("ssl://")){
    		alert("Host URI must start with ssl:// if Use SSL is Yes");
    		return false;
    }

    var ks = obj.keystoreAlias.value;
    var ts = obj.truststoreAlias.value;
    if (ts == "") {
    	alert(" Truststore alias is mandatory if Use SSL is Yes.");
        return false;
    }
}
}

// To show and hide rows depending on useSSL radio button
function toggleSSL() {

				var ssl = document.getElementsByName('useSSL');

				for(var i=0, length=ssl.length; i<length; i++){
					if(ssl[i].checked ){
						if(ssl[i].value == 'No'){
							document.getElementById('sslTSRow').style.display = 'none';
							document.getElementById('sslKSRow').style.display = 'none'
							document.getElementById('sslKeyRow').style.display = 'none';
						}else{
							document.getElementById('sslTSRow').style.display = '';
							document.getElementById('sslKSRow').style.display = ''
							document.getElementById('sslKeyRow').style.display = '';
						}
					}
				}
			}

			// To show and hide rows depending on useSSL radio button
function onLoadSSL() {
                var selectedSSL = '%value useSSL encode(html)%';
				var ssl = document.getElementsByName('useSSL');


						if(selectedSSL == 'Yes'){
							ssl[1].checked=true;
							document.getElementById('sslTSRow').style.display = '';
							document.getElementById('sslKSRow').style.display = ''
							document.getElementById('sslKeyRow').style.display = '';
						}else{
						    ssl[0].checked = true;
							document.getElementById('sslTSRow').style.display = 'none';
							document.getElementById('sslKSRow').style.display = 'none'
							document.getElementById('sslKeyRow').style.display = 'none';
						}


			}

			//certificate based
			var hiddenOptions = new Array();
			var hiddenOptionsTs = new Array();

			function loadKeyStoresOptions()
			{
			    var ks = document.editform.keystoreAlias.options
				var ts = document.editform.truststoreAlias.options
	      		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
	      			   ks[ks.length] = new Option("","");
				       hiddenOptions[ks.length-1] = new Array();

			       	   %loop keyStoresAndConfiguredKeyAliases%
			       			ks.length=ks.length+1;
				       		ks[ks.length-1] = new Option("%value encode(javascript) keyStoreName%","%value encode(javascript) keyStoreName%");
			           		var aliases = new Array();
			    	   		%loop keyAliases%
			       				aliases[%value $index%] = new Option("%value%","%value%");
			       			%endloop%
			       			if (aliases.length == 0)
			       			{
								aliases[0] = new Option("","");
							}
				       		hiddenOptions[ks.length-1] = aliases;
		       	   %endloop%
			    %endinvoke%

				//list trust store aliases
				%invoke wm.server.security.keystore:listTrustStores%
	      			   ts[ts.length] = new Option("","");
				       hiddenOptionsTs[ts.length-1] = new Array();
			       	   %loop trustStores%
			       			ts.length=ts.length+1;
				       		ts[ts.length-1] = new Option("%value encode(javascript) keyStoreName%","%value encode(javascript) keyStoreName%");
			           		var aliases = new Array();
				       		hiddenOptionsTs[ts.length-1] = aliases;
		       	   %endloop%
			    %endinvoke%

				var keyOpts = document.editform.truststoreAlias.options;
    			var key = "%value encode(javascript) truststoreAlias%";
				if ( key != "")
				{
	       			for(var i=0; i<keyOpts.length; i++)
	       			{
				    	if(key == keyOpts[i].value) {
				    		keyOpts[i].selected = true;
		    			}
			      	}
				}

			    var keyOpts = document.editform.keystoreAlias.options;
    			var key = "%value encode(javascript) keystoreAlias%";
				if ( key != "")
				{
	       			for(var i=0; i<keyOpts.length; i++)
	       			{
				    	if(key == keyOpts[i].value) {
				    		keyOpts[i].selected = true;
		    			}
			      	}
				}

				changeval();

				var aliasOpts = document.editform.keystoreKeyAlias.options;
    			var alias = '%value encode(javascript) keystoreKeyAlias%';
				if ( alias != "")
				{
	       			for(var i=0; i<aliasOpts.length; i++)
	       			{
				    	if(alias == aliasOpts[i].value) {
				    		aliasOpts[i].selected = true;
		    			}
			      	}
				}
	      }

			function changeval() {
				var ks = document.editform.keystoreAlias.options;
				var selectedKS = document.editform.keystoreAlias.value;
				for(var i=0; i<ks.length; i++) {
					if(selectedKS == ks[i].value) {
						var aliases = hiddenOptions[i];
						document.editform.keystoreKeyAlias.options.length = aliases.length;
						for(var j=0;j<aliases.length;j++) {
							var opt = aliases[j];
							document.editform.keystoreKeyAlias.options[j] = new Option(opt.text, opt.value);
						}
					}
				}
			}

/**
 * isInt
 */
function isInt(value) {

    var strValidChars = "0123456789";
    var strChar;
    var blnResult = true;

    for (i = 0; i < value.length && blnResult == true; i++) {
        strChar = value.charAt(i);
        if (strValidChars.indexOf(strChar) == -1) {
            blnResult = false;
        }
    }
    return blnResult;
}

</script>

</head>

<body onLoad="loadDocument(); onLoadSSL(); loadKeyStoresOptions();">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; MQTT Settings &gt; MQTT Connection Alias &gt; Edit</TD>
    </tr>
    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jms_detail", "mqtt-detail.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_mqtt_detail", "name", "%value name encode(url)%");
		  </script>
          <li class="listitem">
		  <script>getURL("mqtt-detail.dsp?name=%value name encode(url)%","javascript:document.htmlform_settings_mqtt_detail.submit();","Return to MQTT Connection Alias Detail")</script>
		  </li>
        </ul>
      </td>
    </tr>
    <tr>

    <form name="editform" action="mqtt-detail.dsp" METHOD="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

      <td>
        <table class="tableView" width="100%">

          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>

          <!-- Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" nowrap="true"><label for="name">Connection Alias Name</label></td>
            <td class="oddrowdata-l"><INPUT name="name" id="name" size="50" value="%value name encode(htmlattr)%" DISABLED></td>
          </tr>

          <!-- Description -->
          <tr>
            <td class="evenrow-l"><label for="description">Description</label></td>
            <td class="evenrowdata-l"><INPUT name="description" id="description" size="50" value="%value description encode(htmlattr)%"></td>
          </tr>

          <!-- Package -->
          <tr>
            <td class="evenrow-l"><label for="package">Package</label></td>
            %invoke wm.server.packages:packageList%
            <script>writeTD("row-l");</script><select name="package" ID="package">
                %loop packages%
                  %ifvar enabled equals('true')%
                    %ifvar ../package -notempty%
                      <option %ifvar ../package vequals(name)%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %else%
                      <option %ifvar name equals('WmRoot')%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %endif%
                  %endif%
                %endloop%
                </select></td>
                %endinvoke%
          </tr>

	      </table>

        <table class="tableView" width="100%">

          <tr>
            <TD class="heading" colspan=2>Connection Protocol Settings</TD>
          </tr>

          <!-- Host -->
          <tr>
            <td width="40%" class="evenrow-l"><label for="host">Host</label></td>
            <td class="evenrowdata-l"><INPUT name="host" id="host" size="50" value="%value host encode(htmlattr)%"></td>
          </tr>

          <!-- Client ID -->
          <tr>
            <td class="evenrow-l"><label for="clientId">Connection Client ID</label></td>
            <td class="evenrowdata-l"><INPUT name="clientId" id="clientId" size="50" value="%value clientId encode(htmlattr)%" onchange="alert ('Warning! \n\nChanging the Connection Client ID may result in new subscriptions on the MQTT provider for triggers that use the alias. The subscriptions that use the old Client ID are not automatically removed from the MQTT provider. Old subscriptions might contain messages and continue to receive messages.');"></td>
          </tr>

          <!-- Use Clean Session for Subscriptions -->
          <tr>
            <script>writeTD("row-l");</script><label for="cleanSessionEnabled">Use Clean Session for Subscriptions</label></td>
            %ifvar cleanSessionEnabled equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="cleanSessionEnabled" id="cleanSessionEnabled" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="cleanSessionEnabled" id="cleanSessionEnabled"></td>
            %endif%


          </tr>

          <!-- Timeout -->
          <tr>
            <td class="evenrow-l"><label for="timeout">Connection Timeout (seconds)</label></td>
            <td class="evenrowdata-l"><INPUT name="timeout" id="timeout" size="50" value="%value timeout encode(htmlattr)%"></td>
          </tr>

          <!-- Keep Alive -->
          <tr>
            <td class="evenrow-l"><label for="keepAlive">Keep Alive (seconds)</label></td>
            <td class="evenrowdata-l"><INPUT name="keepAlive" id="keepAlive" size="50" value="%value keepAlive encode(htmlattr)%"></td>
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
            <td width="40%"><label for="will_enabled">Last-Will Enabled</label></td>
            %ifvar will_enabled equals('true')%
              <td><input type="checkbox" name="will_enabled" id="will_enabled" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="will_enabled" id="will_enabled" ></td>
            %endif%
          </tr>

          <!-- Last-Will QoS -->
          <tr>
            <script>writeTD("row-l");</script><label for="will_qos">Last-Will QoS</label></td>
            <script>writeTD("row-l");</script>
              <select name="will_qos" ID="will_qos">
                <option value="-1" length="50"></option>
                <option %ifvar will_qos equals('0')%selected="true"%endif% value="0">At most once (0)</option>
                <option %ifvar will_qos equals('1')%selected="true"%endif% value="1">At least once (1)</option>
                <option %ifvar will_qos equals('2')%selected="true"%endif% value="2">Exactly once (2)</option>
              </select>
            </td>
          </tr>

          <!-- Last-Will Retained -->
          <tr>
            <script>writeTD("row-l");</script><label for="will_retain">Last-Will Retained</label></td>
            %ifvar will_retain equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="will_retain" id="will_retain" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="will_retain" id="will_retain"></td>
            %endif%
          </tr>

          <!-- Last-Will Topic -->
          <tr>
            <td class="evenrow-l"><label for="will_topic">Last-Will Topic</label></td>
            <td class="evenrowdata-l"><INPUT name="will_topic" id="will_topic" size="50" value="%value will_topic encode(htmlattr)%"></td>
          </tr>

          <!-- Last-Will Message Payload -->
          <tr>
            <td class="evenrow-l"><label for="will_payload">Last-Will Message Payload</label></td>
            <td class="evenrowdata-l"><INPUT name="will_payload" id="will_payload" size="50" value="%value will_payload encode(htmlattr)%"></td>
          </tr>

          <!-- On Connect Message Payload -->
          <tr>
            <td class="evenrow-l"><label for="will_onConnectPayload">On Connect Message Payload</label></td>
            <td class="evenrowdata-l"><INPUT name="will_onConnectPayload" id="will_onConnectPayload" size="50" value="%value will_onConnectPayload encode(htmlattr)%"></td>
          </tr>

          <!-- On Disconnect Message Payload -->
          <tr>
            <td class="evenrow-l"><label for="will_onDisconnectPayload">On Disconnect Message Payload</label></td>
            <td class="evenrowdata-l"><INPUT name="will_onDisconnectPayload" id="will_onDisconnectPayload" size="50" value="%value will_onDisconnectPayload encode(htmlattr)%"></td>
          </tr>


          </table>

        <!--<table class="tableView" width="100%">
         <tr>
            <td class="heading" colspan=2>Advanced Settings</td>
          </tr>
          <tr>
            <td width="40%"><label for="useCsq">Enable CSQ</label></td>
            %ifvar useCsq equals('true')%
              <td><input type="checkbox" name="useCsq" id="useCsq" checked=true></td>
            %else%
              <td><input type="checkbox" name="useCsq" id="useCsq" ></td>
            %endif%
          </tr>
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="csqSize">Maximum CSQ Size (messages)</label></td>
            <script>writeTD("rowdata-l");</script><input name="csqSize" id="csqSize" size="50" value="%value csqSize encode(htmlattr)%"></td>
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
            <td width="40%" class="oddrow-l" scope="row" nowrap="true"><label for="user">User</label></td>
            <td class="evenrowdata-l"><input name="user" id="user" size="50" value="%value user encode(html)%"</td>
          </tr>

          <!-- Pass -->
          <tr>
            <td class="oddrow-l" scope="row" nowrap="true"><label for="password">Password</label></td>
            <td class="evenrowdata-l"><input type="password" name="password" id="password" size="50" value="%ifvar password -notempty%*****%endif%"</td>
          </tr>

		  <!-- useSSL radio button -->
		 <tr>
            <script>writeTD("row-l");</script><label for="useSSL">Use SSL</label></td>
            <script>writeTD("row-l");</script><label><INPUT TYPE="radio" name="useSSL"  id="useSSL" value="No" onChange="toggleSSL()" checked/>No</label><label><INPUT TYPE="radio" name="useSSL" value="Yes" onChange="toggleSSL()" />Yes</label></td>
         </tr>

		 <!-- Truststore Alias -->
		<tr id="sslTSRow">
				<script>writeTD("row-l");</script><label for="truststoreAlias" id="truststoreAliasLabel">Truststore Alias</label></td>
				 <script>writeTD("row-l");</script><SELECT  name="truststoreAlias" id="truststoreAlias" style="width: 270px;"></SELECT></td>
		</tr>

		<!-- Keystore Alias -->
		<tr id="sslKSRow">
				<script>writeTD("row-l");</script><label for="keystoreAlias" id="keystoreAliasLabel">Keystore Alias</label></td>
				<script>writeTD("row-l");</script><SELECT name="keystoreAlias" id="keystoreAlias"  onchange="changeval()" style="width: 270px;"></SELECT></td>
		</tr>

		<!-- Key Alias : will be populated when Keystore Alias is selected -->
		<tr id="sslKeyRow">
			   	<script>writeTD("row-l");</script><label for="keystoreKeyAlias" id="keystoreKeyAliasLabel">Key Alias</label></td>
			    <script>writeTD("row-l");</script><select name="keystoreKeyAlias" id="keystoreKeyAlias" style="width: 270px;"></select></td>
		</tr>

	      </table>





        <!-- Submit Button -->
        <table class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>

                <input name="name" type="hidden" value="%value name encode(htmlattr)%">
                <input name="action" type="hidden" value="edit">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">


              </td>
            </tr>

        </table>

      </td>
    </tr>


    </form>
  </table>

%onerror%
%value errorService encode(html)%<br>
%value error encode(html)%<br>
%value errorMessage encode(html)%<br>

</body>

%endinvoke%

</html>