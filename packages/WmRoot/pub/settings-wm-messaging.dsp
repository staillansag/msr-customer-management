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
  function confirmDelete(index) {
	var msg = 'The connection alias '+aliasAry[index]+' is associated with one or more triggers. Are you sure you want to delete this connection alias?';
	return confirm(msg);  
  }
  
  function confirmDelete1(index) {
  
	var msg = 'Are you sure you want to delete Connection Alias '+ aliasAry[index] +'?';
	return confirm(msg);  
  }
  function changeTriggerState() {
  
    return confirm("Would you like to make this change across the entire cluster?");  
  
  }

  function popUp(URL) {
      day = new Date();
      id = day.getTime();
	  
      if(is_csrf_guard_enabled && needToInsertToken) {
			createForm("htmlform_URL", URL, "POST", "head");
			setFormProperty("htmlform_URL", _csrfTokenNm_, _csrfTokenVal_);
			URL = "javascript:document.htmlform_URL.submit();";
      } 
	  
      eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=200,height=200,left = 540,top = 412');");
  }

  function switchToQuiesceMode(form , mode) {
  
    delayTime = prompt("OK to enter quiesce mode?\nSpecify the maximum number of minutes to wait before disabling packages:",0);
    if(delayTime == null) { 
      return false;
    }else{
      return true;
    }
    }
  
  </script>
  
</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettingsScrn');">
  <table width="100%">
  
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings</td>
    </tr>
    
    <!--                 -->
    <!-- Handle 'action' -->
    <!--                 -->
    
    %switch action%
    
    %case 'error-broker-exists'%
      <script>alert("Cannot create new Broker alias. Only one Broker alias can exist at a time.")</script>
    %case 'changeState'%
      %ifvar setEnabled equals('true')%
        %invoke wm.server.messaging:enableConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>%value message encode(html)%</TD>
        </TR>
        %endinvoke%
      %else%
        %invoke wm.server.messaging:disableConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>%value message encode(html)%</TD>
        </TR>
        %endinvoke%
      %endif%
      %rename aliasName editedAliasName%
    
    %case 'delete'%
      %invoke wm.server.messaging:deleteConnectionAlias%
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message encode(html)%</td>
      </tr>
      %endinvoke%
      %rename aliasName editedAliasName%
    
    %case 'create'%
      %invoke wm.server.messaging:createConnectionAlias%
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message encode(html)%</td>
      </tr>
	   %onerror%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
    
    %case 'setSettings'%
      %invoke wm.server.messaging:setSettings%
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message encode(html)%</td>
      </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
      
    %case 'changeDefaultConnectionAlias'%
      %invoke wm.server.messaging:changeDefaultConnectionAlias%
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message encode(html)%</td>
      </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
      
    %end%
    
    <!--                                                  -->
    <!-- Get main connection alias report for all aliases -->
    <!--                                                  -->
    
    %invoke wm.server.messaging:getConnectionAliasReport%
    
    <!-- Navigation Menu -->
    
    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
		  createForm("htmlform_trigger_mgmt", "trigger-management.dsp", "POST", "BODY");
		  </script>
       %ifvar webMethods-wM-AdminUI%
       %else%
          <li class="listitem">
		        <script>getURL("settings-messaging.dsp","javascript:document.htmlform_settings_messaging.submit();","Return to Messaging");</script></li>
          <li class="listitem">
		        <script>getURL("trigger-management.dsp","javascript:document.htmlform_trigger_mgmt.submit();","View webMethods Messaging Trigger Management");</script></li>
        %endif%
          %ifvar isBrokerConfigured equals('true')%
		    <script>
		    createForm("htmlform_settings_wm_messaging", "settings-wm-messaging.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_wm_messaging", "action", "error-broker-exists");
		    </script>
            <li class="listitem">
			<script>getURL("settings-wm-messaging.dsp?action=error-broker-exists","javascript:document.htmlform_settings_wm_messaging.submit();","Create Broker Connection Alias");</script> (Deprecated)</li>
          %else%
			<script>
		    createForm("htmlform_settings_wm_broker_create", "settings-wm-broker-create.dsp", "POST", "BODY");
		    </script>
            <li class="listitem">
			<script>getURL("settings-wm-broker-create.dsp","javascript:document.htmlform_settings_wm_broker_create.submit();","Create Broker Connection Alias");</script> (Deprecated)</li>
          %endif%
		  <script>
		  createForm("htmlform_settings_wm_um_create", "settings-wm-um-create.dsp", "POST", "BODY");
		  createForm("htmlform_settings_wm_messaging_default", "settings-wm-messaging-default.dsp", "POST", "BODY");
		  
		  createForm("htmlform_settings_wm_messaging_refresh", "settings-wm-messaging.dsp", "POST", "BODY");
		  </script>
		      
          <li class="listitem">
		  <script>getURL("settings-wm-um-create.dsp","javascript:document.htmlform_settings_wm_um_create.submit();","Create Universal Messaging Connection Alias");</script></li>
          <li class="listitem">
		  <script>getURL("settings-wm-messaging-default.dsp","javascript:document.htmlform_settings_wm_messaging_default.submit();","Change Default Connection Alias");</script></li>
          
          <li class="listitem">
		  <script>getURL("settings-wm-messaging.dsp","javascript:document.htmlform_settings_wm_messaging_refresh.submit();","Refresh Page");</script></li>
          
        </ul>
      </td>                                                                                                                       
    </tr>
    
    <tr>
      <td>
        <!-- Connection Alias -->

        <table class="tableView" width="100%">

          <!-- Headers -->

          <tr>
            <td class="heading" colspan=7>webMethods Messaging Connection Alias Definitions</td>
          </tr>

          <tr>
            <th class="subheading2" scope="col" >Default</th>
            <th class="subheading2" scope="col" >Type</th>
            <th class="subheading2" nowrap scope="col" >Connection Alias Name</th>
            <th class="subheading2" scope="col" >Description</th>
            <th class="subheading2" scope="col" >CSQ Count</th>
            <th class="subheading2" scope="col" >Enabled</th>
            <th class="subheading2" scope="col" >Delete</th>
          </tr> 
          
          %loop aliasDataList%
               <script> aliasAry['%value $index%'] = '%value aliasName encode(javascript)%'; </script>
            <tr>
              <!-- Default flag -->
              <script>writeTD("rowdata");</script>
                %ifvar defaultAlias equals('false')%
                  &nbsp;
                %else%
                  <img style="width: 13px; height: 13px;" alt="WebMethods Messaging Connection Alias %value aliasName encode(javascript)% is Enabled" border="0" src="images/green_check.png"></a>              
                %endif%
              </td>
              
              <!-- Type -->            
              <script>writeTD("row-l");</script>
                %ifvar type equals('BROKER')%
                  Broker (Deprecated)
                %else%
                  %ifvar type equals('UM')%
                    Universal Messaging
                  %else%                                                                                        
                    %ifvar type equals('DES')%
                      Digital Event Services
                    %else%
                      Local
                    %endif%      
                  %endif%
                %endif%
              </td>
              
              <!-- Alias Name -->                           
              %ifvar type equals('BROKER')%
                <script>writeTD("row-l");</script>
				<script>
				createForm("htmlform_settings_wm_broker_detail_%value $index%", "settings-wm-broker-detail.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_wm_broker_detail_%value $index%", "aliasName", "%value aliasName%");
				</script>
				
				<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_broker_detail_%value $index%.submit();">');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-broker-detail.dsp?aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true">');
					}
					else {
						document.write('<a href="settings-wm-broker-detail.dsp?aliasName=%value aliasName encode(url)%">');
					}
		       }
           </script>
              %else%
                %ifvar type equals('DES')%
                  <script>writeTD("row-l");</script>
				  <script>
				  createForm("htmlform_settings_wm_des_detail_%value $index%", "settings-wm-des-detail.dsp", "POST", "BODY");
				  setFormProperty("htmlform_settings_wm_des_detail_%value $index%", "aliasName", "%value aliasName%");
				  </script>
				 
				 <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_des_detail_%value $index%.submit();">');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-des-detail.dsp?aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true">');
					}
					else {
						document.write('<a href="settings-wm-des-detail.dsp?aliasName=%value aliasName encode(url)%">');
					}
		       }
           </script>
                %else%
                  %ifvar type equals('UM')%
                    <script>writeTD("row-l");</script>
					<script>
					createForm("htmlform_settings_wm_um_detail_%value $index%", "settings-wm-um-detail.dsp", "POST", "BODY");
					setFormProperty("htmlform_settings_wm_um_detail_%value $index%", "aliasName", "%value aliasName%");
					</script>
					<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_um_detail_%value $index%.submit();">');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-um-detail.dsp?aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true">');
					}
					else {
						document.write('<a href="settings-wm-um-detail.dsp?aliasName=%value aliasName encode(url)%">');
					}
		       }
           </script>
                  %else%
                    <script>writeTD("row-l");</script>
					<script>
					createForm("htmlform_settings_wm_local_detail_%value $index%", "settings-wm-local-detail.dsp", "POST", "BODY");
					setFormProperty("htmlform_settings_wm_local_detail_%value $index%", "aliasName", "%value aliasName%");
					</script>
					<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_local_detail_%value $index%.submit();">');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-local-detail.dsp?aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true">');
					}
					else {
						document.write('<a href="settings-wm-local-detail.dsp?aliasName=%value aliasName encode(url)%">');
					}
		       }
           </script>
                  %endif%
                %endif%
              %endif%
                %value aliasName encode(html)%</a>
              </td>
                
              <!-- Description -->              
              <script>writeTD("row-l");</script>%value description encode(html)%</td>
              
              <!-- Transaction Mode - NOT SUPPORTED YET      
              <script>writeTD("row-l");</script>
                %switch transactionType%
                  %case '0'%NO TRANSACTION<br>
                  %case '1'%LOCAL TRANSACTION<br>
                  %case '2'%XA TRANSACTION<br>
                  %case%&nbsp;<br>
                %end%
              </td>
               -->   
                          
              <!-- CSQ Count -->
              <script>writeTD("row-l");</script>
                %ifvar type equals('DES')%
                  &nbsp;
                %else%
                  %value messageCount encode(html)%
                %endif%
              </td>

              <!-- Enabled -->
              <script>writeTD("rowdata");</script>
              
              %ifvar type equals('LOCAL')%
                      
              %else%
              
				<script>
				createForm("htmlform_settings_wm_messaging_enabled_%value $index%", "settings-wm-messaging.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_wm_messaging_enabled_%value $index%", "action", "changeState");
				setFormProperty("htmlform_settings_wm_messaging_enabled_%value $index%", "aliasName", "%value aliasName encode(url)%");
				setFormProperty("htmlform_settings_wm_messaging_enabled_%value $index%", "setEnabled", "true");
				
				createForm("htmlform_settings_wm_messaging_disabled_%value $index%", "settings-wm-messaging.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_wm_messaging_disabled_%value $index%", "action", "changeState");
				setFormProperty("htmlform_settings_wm_messaging_disabled_%value $index%", "aliasName", "%value aliasName encode(url)%");
				setFormProperty("htmlform_settings_wm_messaging_disabled_%value $index%", "setEnabled", "false");
				</script>
			  
              %ifvar isUpdated equals('true')%
                
                <!-- Broker specific logic (when Broker settings were changed) -->
				
                %ifvar updatedEnabledFlag equals('false')%
                  <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_enabled_%value $index%.submit();">No</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true&webMethods-wM-AdminUI=true">No</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true">No</a>');
					}
		       }
           </script>&nbsp;[Pending&nbsp;Restart]
                %else%
                  %ifvar updatedEnabledFlag equals('true')%
                    <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_disabled_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/yellow_check.png">Yes</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/yellow_check.png">Yes</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/yellow_check.png">Yes</a>');
					}
		       }
           </script>&nbsp;[Pending&nbsp;Restart]
                  
                  %else%
                  
                    %ifvar connected equals('false')%
                      %ifvar enabled equals('false')%
                        <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_enabled_%value $index%.submit();">No</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true&webMethods-wM-AdminUI=true">No</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true">No</a>');
					}
		       }
           </script>&nbsp;[Pending&nbsp;Restart]
                      %else%
                        <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_disabled_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/green_check.png">Yes</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/green_check.png">Yes</a>');
					}
		       }
           </script>&nbsp;[Pending&nbsp;Restart]
                      %endif%
                    %else%
                      <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_disabled_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/yellow_check.png">Yes</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/yellow_check.png">Yes</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/yellow_check.png">Yes</a>');
					}
		       }
           </script>&nbsp;[Pending&nbsp;Restart]           
                    %endif%
                  
                  %endif%
                %endif%                     
                
              %else%
                
                %ifvar connected equals('false')%
                  %ifvar enabled equals('false')%
                    <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_enabled_%value $index%.submit();">No</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true&webMethods-wM-AdminUI=true">No</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true">No</a>');
					}
		       }
           </script>
                  %else%
                    %ifvar state equals('STOPPED')%
                      <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_disabled_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/yellow_check.png">Yes</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="%value aliasName encode(url)%" border="0" src="images/yellow_check.gif">Yes</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="%value aliasName encode(url)%" border="0" src="images/yellow_check.gif">Yes</a>');
					}
		       }
           </script>&nbsp;(Not&nbsp;Connected)
                    %else%
                      <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_disabled_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/yellow_check.png">Yes</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/yellow_check.gif">Yes</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/yellow_check.gif">Yes</a>');
					}
		       }
           </script>
           
                 %ifvar state -notempty%
                   &nbsp;(%value state%)
                 %endif%
                                
                    %endif%
                  %endif%
                %else%
                  <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_disabled_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/green_check.png">Yes</a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="images/green_check.png">Yes</a>');
					}
		       }
           </script>
				  
				               
                %endif%
              %endif%
              
              %endif%

              <!-- Delete --> 
              <script>writeTD("rowdata");</script>
              
              %ifvar type equals('LOCAL')%
                 <img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete_disabled.png">
              %else%
              
               %ifvar type equals('DES')%
                 <img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete_disabled.png">
               %else%
              
                %ifvar enabled equals('true')%
                  <img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete_disabled.png">
                %else%
                  %ifvar defaultAlias equals('true')%
                    <img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete_disabled.png">
                  %else%
                    %ifvar updatedEnabledFlag equals('true')%
                      <img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete_disabled.png">
                    %else%
					<script>
					createForm("htmlform_settings_wm_messaging_delete_%value $index%", "settings-wm-messaging.dsp", "POST", "BODY");
					setFormProperty("htmlform_settings_wm_messaging_delete_%value $index%", "action", "delete");
					setFormProperty("htmlform_settings_wm_messaging_delete_%value $index%", "aliasName", "%value aliasName encode(url)%");
					</script>
                      %ifvar hasTriggers equals('true')%
                        <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_delete_%value $index%.submit();" onClick="return confirmDelete(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=delete&aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDelete(\'%value $index%\')%)"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="return confirmDelete(\'%value $index%\')%)"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
					}
		       }
           </script>
                      %else%
                        <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_settings_wm_messaging_delete_%value $index%.submit();" onClick="return confirmDelete1(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="settings-wm-messaging.dsp?action=delete&aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDelete1(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
					}
					else {
						document.write('<a href="settings-wm-messaging.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="return confirmDelete1(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="webMethods Messaging Connection Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
					}
		       }
           </script>
                      %endif%
                    %endif%
                  %endif%
                %endif%
               %endif%
              %endif%
              
              <!-- Error Message --> 
              %ifvar lastError%
                <tr>
                  <!-- <td class="subheading" colspan=6> -->
                  <script>writeTDspan("row-l", 7);</script>
                    <font color="red">%value lastError encode(html)%</font>
                  </td>
                </tr>
              %endif%
              
              <script>swapRows();</script>
          
          %endloop%
          
          <!-- 
          <tr>
            <td class="subHeading" colspan=6>
              * Connection Aliases that are enabled or Connection Aliases that have one or more Triggers associated with them can not be deleted.
            </td>
          </tr>
          -->

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