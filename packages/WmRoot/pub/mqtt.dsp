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
      var aliasAry = [];
      function confirmDeleteBcTrigger(index) {
	      var msg = 'The Connection alias '+aliasAry[index]+' is associated with one or more MQTT Triggers. Are you sure you want to delete this connection alias?';
  	    return confirm(msg);  
      }
  
      function confirmDelete(index) {
	      var msg = 'Are you sure you want to delete connection alias '+ aliasAry[index] +'?';
	      return confirm(msg);  
      }
    </script>
  </head>

  <body onLoad="setNavigation('mqtt.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_MQTTSettingsScrn');">
    <table width="100%">
      <tr>
        <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; MQTT Settings</td>
      </tr>
      
      %switch action%   
       
     <!-- Enable/Disable Logic -->  
      
      %case 'changeState'%
        %ifvar setEnabled equals('true')%
          %invoke wm.server.mqtt:enableConnectionAlias%
            <TR>
              <TD colspan="2">&nbsp;</td>
            </TR>
            <TR>
              <TD class="message" colspan=2>%value message encode(html)%</TD>
            </TR>
          %endinvoke%
        %else%
          %invoke wm.server.mqtt:disableConnectionAlias%
            <TR>
              <TD colspan="2">&nbsp;</td>
            </TR>
            <TR>
              <TD class="message" colspan=2>%value message encode(html)%</TD>
            </TR>
          %endinvoke%
        %endif%
        %rename name editedAliasName%

      <!-- Delete Logic -->
   
      %case 'delete'%
        %invoke wm.server.mqtt:deleteConnectionAlias%
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td class="message" colspan=2>%value message encode(html)%</td>
          </tr>
        %endinvoke%
        %rename name editedAliasName%
   
      <!-- Create Logic -->
    
      %case 'create'%
        %invoke wm.server.mqtt:createConnectionAlias%
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td class="message" colspan=2>%value message encode(html)%</td>
          </tr>
        %endinvoke%  
        %rename name editedAliasName%
    
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
          <td class="message" colspan=2>%value errorMessage encode(html)%</td>
        %endinvoke%  
        %rename name editedTriggerName%
    
      <!-- Enable Trigger -->
       
      %case 'enableTrigger'%
        %invoke wm.server.mqtt:enableTriggers%
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td class="message" colspan=2>%value message encode(html)%</td>
          </tr>
        %onerror%
          <td class="message" colspan=2>%value errorMessage encode(html)%</td>
        %endinvoke%
        %rename name editedTriggerName%
      
      <!-- Disable Trigger -->
      
      %case 'disableTrigger'%
        %invoke wm.server.mqtt:disableTriggers%
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td class="message" colspan=2>%value message encode(html)%</td>
          </tr>
        %onerror%
         <td class="message" colspan=2>%value errorMessage encode(html)%</td>
        %endinvoke%
        %rename name editedTriggerName%
      %end%

      %invoke wm.server.mqtt:getConnectionAliasReport%
    
        <!-- Navigation Menu -->
    
        <tr>
          <td colspan="2">
            <ul class="listitems">
		          <script>
		            createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
		            createForm("htmlform_settings_mqtt_create", "mqtt-create.dsp", "POST", "BODY");
		            createForm("htmlform_settings_mqtt_trigger", "mqtt-trigger-management.dsp", "POST", "BODY");
		            createForm("htmlform_settings_mqtt", "mqtt.dsp", "POST", "BODY");
		          </script>
              %ifvar webMethods-wM-AdminUI% 
              %else%
              <li class="listitem"><script>getURL("settings-messaging.dsp", "javascript:document.htmlform_settings_messaging.submit();", "Return to Messaging");</script></li>
              <li class="listitem"><script>getURL("mqtt-trigger-management.dsp", "javascript:document.htmlform_settings_mqtt_trigger.submit();", "View MQTT Trigger Management");</script></li>
              %endif%
              <li class="listitem"><script>getURL("mqtt-create.dsp", "javascript:document.htmlform_settings_mqtt_create.submit();", "Create MQTT Connection Alias");</script></li>
              <li class="listitem"><script>getURL("mqtt.dsp", "javascript:document.htmlform_settings_mqtt.submit();", "Refresh Page");</script></li>
            </ul>
          </td>
        </tr>
    
        <tr>
          <td>
            <table class="tableView" width="100%">   

              <!-- Headers -->
          
              <tr>
                <td class="heading" colspan=6>MQTT Connection Alias Definitions</td>
              </tr>

              <tr>
                <th class="subheading2-l" width="20%" scope="col" nowrap>Connection Alias Name</th>
                <th class="subheading2-l" width="20%" scope="col" >Description</th>
             <!--   <th class="subheading2-l" width="10%" scope="col" >CSQ Count</th>    -->
                <th class="subheading2" width="10%" scope="col" >Enabled</th>             
                <th class="subheading2-l" width="10%" scope="col" >Status</th>               
                <th class="subheading2" width="10%" scope="col" >Delete</th>
              </tr> 
          
              %loop aliasDataList%
              
                <script> aliasAry['%value $index%'] = '%value name encode(javascript)%'; </script>
            
                <tr>
                  <!-- Alias Name -->
                  <script>
	  		            createForm("htmlform_settings_mqtt_detail_%value $index%", "mqtt-detail.dsp", "POST", "BODY");
  		      	      setFormProperty("htmlform_settings_mqtt_detail_%value $index%", "name", "%value name encode(url)%");
  	      		    </script> 
                  <td>
                    <script>
		                  if(is_csrf_guard_enabled && needToInsertToken) {
		  	                document.write('<a href="javascript:document.htmlform_settings_mqtt_detail_%value $index%.submit();"  >%value name encode(html)%</a>');
		                  } else {
		                  	%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		                    var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || 'webMethods_wM_AdminUI' == 'true') {
								document.write('<a href="mqtt-detail.dsp?name=%value name encode(url)%&webMethods-wM-AdminUI=true">%value name encode(html)%</a>');
							}
							else {
								document.write('<a href="mqtt-detail.dsp?name=%value name encode(url)%">%value name encode(html)%</a>');
							}
		                  }
                    </script>
                  </td>
                  
                  <!-- Description -->
                  <td>
                    %value description encode(html)%
                  </td>
                 
                  <!-- CSQ Count 
                  <td>
                    %value csqMessageCount encode(html)%
                  </td>
                  -->
                  
                  <!-- Enabled -->
                  <script>writeTD("rowdata");</script>
			              <script>
			                createForm("htmlform_settings_mqtt_change_state_disable_%value $index%", "mqtt.dsp", "POST", "BODY");
			                setFormProperty("htmlform_settings_mqtt_change_state_disable_%value $index%", "action", "changeState");
			                setFormProperty("htmlform_settings_mqtt_change_state_disable_%value $index%", "name", "%value name encode(url)%");
			                setFormProperty("htmlform_settings_mqtt_change_state_disable_%value $index%", "enabled", "false");
                      createForm("htmlform_settings_mqtt_change_state_%value $index%", "mqtt.dsp", "POST", "BODY");
	  	    		        setFormProperty("htmlform_settings_mqtt_change_state_%value $index%", "action", "changeState");
	  	    		        setFormProperty("htmlform_settings_mqtt_change_state_%value $index%", "name", "%value name encode(url)%");
		      		        setFormProperty("htmlform_settings_mqtt_change_state_%value $index%", "enabled", "true");
		    	          </script> 

                    %ifvar enabled equals('false')%                           
                      <script>                                                
				                if(is_csrf_guard_enabled && needToInsertToken) {
				                  document.write('<a href="javascript:document.htmlform_settings_mqtt_change_state_%value $index%.submit();">No</a>');
				                } else {
				                  %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				                  var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
									document.write('<a href="mqtt.dsp?action=changeState&name=%value name encode(url)%&setEnabled=true&webMethods-wM-AdminUI=true">No</a>');
								  }
								  else {
									document.write('<a href="mqtt.dsp?action=changeState&name=%value name encode(url)%&setEnabled=true">No</a>');
								  }
				                }
				              </script>
                    %else%
                      <script>
                        if(is_csrf_guard_enabled && needToInsertToken) {
			    			          document.write('<a href="javascript:document.htmlform_settings_mqtt_change_state_disable_%value $index%.submit();"> %ifvar connected equals('true')% <img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png"> %endif%Yes</a>');
		    			          } else {
		    			            %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				                    var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								    if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
									  document.write('<a href="mqtt.dsp?action=changeState&name=%value name encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="enabled" border="0" %ifvar connected equals('true')% src="images/green_check.png">%else% src="images/yellow_check.png">%endif%Yes</a>');
								    }
								    else {
									  document.write('<a href="mqtt.dsp?action=changeState&name=%value name encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="enabled" border="0" %ifvar connected equals('true')% src="images/green_check.png">%else% src="images/yellow_check.png">%endif%Yes</a>');
								    }
                        		  }
                      </script>
                    %endif%
                  </td>
                  
                  <!-- Status -->
                  <td>
                    %value status_display encode(html)%
                  </td>
                    
                  <!-- Delete --> 
                  <script>writeTD("rowdata");</script>
                    %ifvar enabled equals('true')%
                      <img style="width: 13px; height: 13px;" border="0" src="icons/delete_disabled.png">
                    %else%
  			              <script>
	  			              createForm("htmlform_settings_mqtt_delete_alias_%value $index%", "mqtt.dsp", "POST", "BODY");
	  			              setFormProperty("htmlform_settings_mqtt_delete_alias_%value $index%", "action", "delete");
		      		          setFormProperty("htmlform_settings_mqtt_delete_alias_%value $index%", "name", "%value name encode(url)%");
		  		            </script>
                    
                      %ifvar hasTriggers equals('true')%
                        <script>
		      			    	    if(is_csrf_guard_enabled && needToInsertToken) {
			      	    		      document.write('<a href="javascript:document.htmlform_settings_mqtt_delete_alias_%value $index%.submit();" onClick="return confirmDeleteBcTrigger(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="MQTT Connection Alias %value name encode(html)%" border="0" src="icons/delete.png"></a>');
			  	        	      }else {
			  	        	        %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
			  	        	        var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								    if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
									  document.write('<a href="mqtt.dsp?action=delete&name=%value name encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDeleteBcTrigger(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="MQTT Connection Alias %value name encode(html)%" border="0" src="icons/delete.png"></a>');
								    }
								    else {
									  document.write('<a href="mqtt.dsp?action=delete&name=%value name encode(url)%" onClick="return confirmDeleteBcTrigger(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="MQTT Connection Alias %value name encode(html)%" border="0" src="icons/delete.png"></a>');
								    }
		  		        	      }	     
			  	        	    </script>
                      %else%
                        <script>
		        			  	    if(is_csrf_guard_enabled && needToInsertToken) {
		  	  	      		      document.write('<a href="javascript:document.htmlform_settings_mqtt_delete_alias_%value $index%.submit();" onClick="return confirmDelete(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="MQTT Connection Alias %value name encode(html)%" border="0" src="icons/delete.png"></a>');
	  			  	            } else {
	  			  	            	%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
	  			  	            	var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								    if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
									  document.write('<a href="mqtt.dsp?action=delete&name=%value name encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDelete(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="MQTT Connection Alias %value name encode(html)%" border="0" src="icons/delete.png"></a>');
								    }
								    else {
									  document.write('<a href="mqtt.dsp?action=delete&name=%value name encode(url)%" onClick="return confirmDelete(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="MQTT Connection Alias %value name encode(html)%" border="0" src="icons/delete.png"></a>');
								    }
  			        		    }
  			        	      </script>
                      %endif%
                    %endif%
                  </td>
                </tr>
                
                <!-- Error Message -->        
                %ifvar lastError_display%
                  <tr>
                    <script>writeTDspan("row-l", 6);</script>
                      <font color="red">%value lastError_display encode(html)%</font>   
                    </td>
                  </tr>
                %endif%
       
              %endloop%
        
            </table>
          </td>
        </tr>
                     
      %onerror%
        <tr>
          <td class="message" colspan=2>%value errorService encode(html)%<br>%value error encode(html)%<br>%value errorMessage encode(html)%<br></td>
        </tr>                  
      %endinvoke%
    </table>
  </body>
</html>