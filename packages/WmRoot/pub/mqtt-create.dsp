<HTML>
  <HEAD>

    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods.css">
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
        setNavigation('settings-mqtt.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_MQTTCreateAliasScrn');
		toggleSSL();
      }

      /**
       * Validation logic
       */
       function validateForm(obj) {

              if (isEmpty(obj.name.value)) {
                alert("Connection Alias Name must be specified.");
                return false;
              }

              if (isEmpty(obj.description.value)) {
                alert("Description must be specified.");
                return false;
              }

              if (isEmpty(obj.package.value)) {
                alert("Package must be specified.");
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

      		if (((obj.user.value!="")&& (obj.password.value=="")) || ((obj.user.value=="")&& (obj.password.value!="")) ) {

              alert("Both username and password must be specified.");
              return false;
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

              return true;
            }

			// To show and hide rows depending on useSSL radio button
			function toggleSSL() {
				var ssl = document.getElementsByName('useSSL');
				for(var i=0, length=ssl.length; i<length; i++){
					if(ssl[i].checked){
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

			//certificate based
			var hiddenOptions = new Array();
			var hiddenOptionsTs = new Array();

			function loadKeyStoresOptions()
			{
			    var ks = document.createform.keystoreAlias.options
				var ts = document.createform.truststoreAlias.options
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

			    var keyOpts = document.createform.keystoreAlias.options;
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

				var aliasOpts = document.createform.keystoreKeyAlias.options;
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
				var ks = document.createform.keystoreAlias.options;
				var selectedKS = document.createform.keystoreAlias.value;

				for(var i=0; i<ks.length; i++) {
					if(selectedKS == ks[i].value) {
						var aliases = hiddenOptions[i];
						document.createform.keystoreKeyAlias.options.length = aliases.length;
						for(var j=0;j<aliases.length;j++) {
							var opt = aliases[j];
							document.createform.keystoreKeyAlias.options[j] = new Option(opt.text, opt.value);
						}
					}
				}
			}

    </script>
  </head>

  <body onLoad="loadDocument(); loadKeyStoresOptions();">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; MQTT Settings &gt; MQTT Connection Alias &gt; Create</td>
    </tr>
    <tr>
      <td colspan="2">
        <ul class="listitems">
		      <script>createForm("htmlform_settings_mqtt", "mqtt.dsp", "POST", "BODY");</script>
          <li class="listitem"><script>getURL("mqtt.dsp","javascript:document.htmlform_settings_mqtt.submit();","Return to MQTT Settings")</script></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><form name='createform' action="mqtt.dsp" method="post">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <table class="tableView" width="100%">

          <!--                  -->
          <!-- General Settings -->
          <!--                  -->

          <script>swapRows();</script>
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>

          <!-- Connection Alias Name -->
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="name">Connection Alias Name</label></td>
            <td class="oddrow-l"><INPUT NAME="name" ID="name" size="50"></td>
          </tr>

          <!-- Description -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="description">Description</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="description" ID="description"size="50"></td>
          </tr>

          <!-- Package -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="package">Package</label></td>
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

          <!--                              -->
          <!-- Connection Protocol Settings -->
          <!--                              -->

          <tr>
            <td class="heading" colspan=2>Connection Protocol Settings</td>
          </tr>

          <!-- Host -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="host">Host</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="host" ID="host"size="50" value="tcp://localhost:1883"></td>
          </tr>

          <!-- Connection Client ID -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="clientId">Connection Client ID</label></td>
            %invoke wm.server.mqtt:generateClientId%
              <script>writeTD("row-l");</script><INPUT NAME="clientId" ID="clientId"size="50" value="%value generatedClientId%"></td>
            %endinvoke%
          </tr>

          <!-- Clean Session -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="cleanSessionEnabled">Use Clean Session for Subscriptions</label></td>
            <script>writeTD("row-l");</script><INPUT TYPE="checkbox" NAME="cleanSessionEnabled" id="cleanSessionEnabled" size="50" checked></td>
          </tr>

          <!-- Timeout -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="timeout">Connection Timeout (seconds)</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="timeout" ID="timeout"size="50" value="30"></td>
          </tr>

          <!-- Keep Alive -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="keepAlive">Keep Alive (seconds)</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="keepAlive" ID="keepAlive"size="50" value="60"></td>
          </tr>

          <!--                        -->
          <!-- Last-Will Settings          -->
          <!--                        -->

          <tr>
            <td class="heading" colspan=2>Last-Will Settings</td>
          </tr>

          <!-- Last-Will Enable -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_enabled">Enable Last-Will</label></td>
            <script>writeTD("row-l");</script><INPUT TYPE="checkbox" NAME="will_enabled" id="will_enabled" size="50"></td>
          </tr>

          <!-- Last-Will Qos -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_qos">Last-Will QoS</label></td>
            <script>writeTD("row-l");</script>
              <select name="will_qos" ID="will_qos">
                <option value="-1" length="50"></option>
                <option value="0">At most once (0)</option>
                <option value="1">At least once (1)</option>
                <option value="2">Exactly once (2)</option>
              </select>
            </td>
          </tr>

          <!-- Last-Will Retained -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_retain">Last-Will Retained</label></td>
            <script>writeTD("row-l");</script><INPUT TYPE="checkbox" NAME="will_retain" id="will_retain" size="50"></td>
          </tr>

          <!-- Last-Will Topic -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_topic">Last-Will Topic</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="will_topic" ID="will_topic"size="50"></td>
          </tr>

          <!-- Last-Will Message Payload -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_payload">Last-Will Message Payload</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="will_payload" ID="will_payload"size="50"></td>
          </tr>

          <!-- On Connect Message Payload -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_onConnectPayload">On Connect Message Payload</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="will_onConnectPayload" ID="will_onConnectPayload"size="50"></td>
          </tr>

          <!-- On Disconnect Message Payload -->
		  <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="will_onDisconnectPayload">On Disconnect Message Payload</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="will_onDisconnectPayload" ID="will_onDisconnectPayload"size="50"></td>
          </tr>

         <!--                        -->
         <!-- Security Settings      -->
         <!--                        -->

         <tr>
           <td class="heading" colspan=2>Security Settings</td>
         </tr>

         <!-- User Name -->
		 <script>swapRows();</script>
         <tr>
           <script>writeTD("row-l");</script><label for="user">User Name</label></td>
           <script>writeTD("row-l");</script><INPUT NAME="user" ID="user"size="50"></td>
         </tr>

         <!-- Password -->
         <script>swapRows();</script>
         <tr>
           <script>writeTD("row-l");</script><label for="password">Password</label></td>
           <script>writeTD("row-l");</script><input type="password" name="password" ID="password" autocomplete="off" size="50" /></td>
         </tr>

		 <!-- useSSL radio button -->
		 <script>swapRows();</script>
		 <tr>
            <script>writeTD("row-l");</script><label for="useSSL">Use SSL</label></td>
            <script>writeTD("row-l");</script><label><INPUT TYPE="radio" name="useSSL" value="No" onChange="toggleSSL()" checked/>No</label><label><INPUT TYPE="radio" name="useSSL" value="Yes" onChange="toggleSSL()" />Yes</label></td>
         </tr>

		 <!-- Truststore Alias -->
		<script>swapRows();</script>
		<tr id="sslTSRow">
				<script>writeTD("row-l");</script><label for="truststoreAlias" id="truststoreAliasLabel">Truststore Alias</label></td>
				 <script>writeTD("row-l");</script><SELECT  name="truststoreAlias" id="truststoreAlias" style="width: 270px;"></SELECT></td>
		</tr>

		<!-- Keystore Alias -->
		<script>swapRows();</script>
		<tr id="sslKSRow">
				<script>writeTD("row-l");</script><label for="keystoreAlias" id="keystoreAliasLabel">Keystore Alias</label></td>
				<script>writeTD("row-l");</script><SELECT name="keystoreAlias" id="keystoreAlias"  onchange="changeval()" style="width: 270px;"></SELECT></td>
		</tr>

		<!-- Key Alias : will be populated when Keystore Alias is selected -->
		<script>swapRows();</script>
		<tr id="sslKeyRow">
			   	<script>writeTD("row-l");</script><label for="keystoreKeyAlias" id="keystoreKeyAliasLabel">Key Alias</label></td>
			    <script>writeTD("row-l");</script><select name="keystoreKeyAlias" id="keystoreKeyAlias" style="width: 270px;"></select></td>
		</tr>

        </table>
               
        <table class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>

                <input name="action" type="hidden" value="create">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">
              </td>
            </tr>
        </table>

       </form>

      </td>
    </tr>
  </table>
</body>
</html>
