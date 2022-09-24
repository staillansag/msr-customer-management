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
  
  function changeTriggerState() {
  
    return confirm("Would you like to make this change across the entire cluster?");  
  
  }
  
  var aliasAry = [];
  function confirmDelete(index) {
	var msg = 'The Connection alias '+aliasAry[index]+' is associated with one or more JMS Triggers. Are you sure you want to delete this Connection alias?';
	return confirm(msg);  
  }
  
  function confirmDelete1(index) {
  
	var msg = 'Are you sure you want to delete Connection Alias '+ aliasAry[index] +'?';
	return confirm(msg);  
  }
  
  function popUp(URL) {
    day = new Date();
    id = day.getTime();
	
	
    if(is_csrf_guard_enabled && needToInsertToken) {
		createForm("htmlform_settings_jms_url", URL, "POST", "BODY");
        setFormProperty("htmlform_settings_jms_url", _csrfTokenNm_, _csrfTokenVal_);
		URL = "javascript:document.htmlform_settings_jms_url.submit();";
    } 
	
    eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=200,height=200,left = 540,top = 412');");
 }
  
  </script>
  
</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMSsetScrn');">
  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JMS Settings</td>
    </tr>

    <!-- Enable/Disable Logic -->

    %switch action%
    
    %case 'changeState'%
      %ifvar setEnabled equals('true')%
        %invoke wm.server.jms:enableConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>%value message encode(html)%</TD>
        </TR>
        %endinvoke%
      %else%
        %invoke wm.server.jms:disableConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>%value message encode(html)%</TD>
        </TR>
        %endinvoke%
      %endif%
      %rename aliasName editedAliasName%

    <!-- Delete Logic -->
   
    %case 'delete'%
      %invoke wm.server.jms:deleteConnectionAlias%
        <tr>
          <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %endinvoke%
      %rename aliasName editedAliasName%
   
    <!-- Create Logic -->
    
    %case 'create'%
      %invoke wm.server.jms:createConnectionAlias%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
    
    <!-- Stop/Suspend/Enable Trigger Logic -->
    
    %case 'suspendTrigger'%
      %invoke wm.server.jms:suspendJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage encode(html)%</td>
      %endinvoke%  
      %rename triggerName editedTriggerName%
    
    %case 'enableTrigger'%
      %invoke wm.server.jms:enableJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage encode(html)%</td>
      %endinvoke%
      %rename triggerName editedTriggerName%
      
    %case 'disableTrigger'%
      %invoke wm.server.jms:disableJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage encode(html)%</td>
      %endinvoke%
      %rename triggerName editedTriggerName%

    <!-- Clear CSQ Logic -->
    
    %case 'clearCSQ'%
      %invoke wm.server.jms:clearCSQ%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %endinvoke%  
      %rename aliasName editedAliasName%
      
    <!-- Set Global Trigger Settings -->
    
    %case 'setSettings'%
      %invoke wm.server.jms:setSettings%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %endinvoke%  
    %end%
    
    %invoke wm.server.jms:getConnectionAliasReport%
    
<!-- Navigation Menu -->
    
    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
		  createForm("htmlform_settings_jms_create", "settings-jms-create.dsp", "POST", "BODY");
		  createForm("htmlform_settings_jms_trigger", "settings-jms-trigger-management.dsp", "POST", "BODY");
		  createForm("htmlform_settings_jms", "settings-jms.dsp", "POST", "BODY");
		  </script>
      %ifvar webMethods-wM-AdminUI% 
      %else%
          <li class="listitem"><script>getURL("settings-messaging.dsp", "javascript:document.htmlform_settings_messaging.submit();", "Return to Messaging");</script>
		      </li>
          <li class="listitem"><script>getURL("settings-jms-trigger-management.dsp", "javascript:document.htmlform_settings_jms_trigger.submit();", "View JMS Trigger Management");</script>
		      </li>
      %endif%
          <li class="listitem"><script>getURL("settings-jms-create.dsp", "javascript:document.htmlform_settings_jms_create.submit();", "Create JMS Connection Alias");</script>
		  </li>
          <li class="listitem"><script>getURL("settings-jms.dsp", "javascript:document.htmlform_settings_jms.submit();", "Refresh Page");</script>
		  </li>
        </ul>
      </td>
    </tr>
    
    <tr>
      <td>

<!-- Connection Alias -->

        <table class="tableView" width="100%">

          <!-- Headers -->
          
          <tr>
            <td class="heading" colspan=6>JMS Connection Alias Definitions</td>
          </tr>

          <tr>
            <th class="subheading2-l" scope="col" nowrap>Connection Alias Name</th>
            <th class="subheading2-l" scope="col" >Description</th>
            <th class="subheading2-l" scope="col" >Transaction Type</th>
            <th class="subheading2-l" scope="col" >CSQ Count</th>
            <th class="subheading2" scope="col" >Enabled</th>
            <th class="subheading2" scope="col" >Delete</th>
          </tr> 
          
          %loop aliasDataList%
          <script> aliasAry['%value $index%'] = '%value aliasName encode(javascript)%'; </script>
            <tr>
            
              <!-- Alias Name -->
              <script>
			  createForm("htmlform_settings_jms_detail_%value $index%", "settings-jms-detail.dsp", "POST", "BODY");
			  setFormProperty("htmlform_settings_jms_detail_%value $index%", "aliasName", "%value aliasName encode(url)%");
			  </script>
              <script>writeTD("row-l");</script>
			  <script>
		      if(is_csrf_guard_enabled && needToInsertToken) {
			   document.write('<a href="javascript:document.htmlform_settings_jms_detail_%value $index%.submit();"  >%value aliasName encode(html)%</a>');
		      } else {
		      	%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					document.write('<a href="settings-jms-detail.dsp?aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true"  >%value aliasName encode(html)%</a>');
				}
				else {
					document.write('<a href="settings-jms-detail.dsp?aliasName=%value aliasName encode(url)%"  >%value aliasName encode(html)%</a>');
				}
		      }
                    </script>
			  
              </td>
                
              <!-- Description -->
              
              <script>writeTD("row-l");</script>%value description encode(html)%</td>
              
              <!-- Transaction Mode -->
              
              <script>writeTD("row-l");</script>
                %switch transactionType%
                  %case '0'%NO TRANSACTION<br>
                  %case '1'%LOCAL TRANSACTION<br>
                  %case '2'%XA TRANSACTION<br>
                  %case%&nbsp;<br>
                %end%
              </td>
              
              <!-- CSQ Count -->

              <script>writeTD("row-l");</script>
                %value messageCount encode(html)%
                
                <!--
                %ifvar messageCount equals('0')%
                  0<br>     
                %else%
                  %ifvar enabled equals('true')%
                    %value messageCount encode(html)%
                  %else%
					%ifvar webMethods-wM-AdminUI%
					  <a href="settings-jms.dsp?action=clearCSQ&aliasName=%value connectionAliasName encode(url)%&webMethods-wM-AdminUI=true" onClick="javascript:return confirm('Are you sure you want to clear the CSQ for Connection Alias %value connectionAliasName encode(javascript)%?')">%value messageCount encode(html)%</a>
					%else%
					  <a href="settings-jms.dsp?action=clearCSQ&aliasName=%value connectionAliasName encode(url)%" onClick="javascript:return confirm('Are you sure you want to clear the CSQ for Connection Alias %value connectionAliasName encode(javascript)%?')">%value messageCount encode(html)%</a>
					%endif%
                  %endif%
                %endif%
                -->
              </td>

              <!-- Enabled? -->
              <script>writeTD("rowdata");</script>
              
			  <script>
			  createForm("htmlform_settings_jms_change_state_disable_%value $index%", "settings-jms.dsp", "POST", "BODY");
			  setFormProperty("htmlform_settings_jms_change_state_disable_%value $index%", "action", "changeState");
			  setFormProperty("htmlform_settings_jms_change_state_disable_%value $index%", "aliasName", "%value aliasName encode(url)%");
			  setFormProperty("htmlform_settings_jms_change_state_disable_%value $index%", "setEnabled", "false");
			  </script>
              %ifvar connected equals('false')%
                %ifvar enabled equals('false')%
				  <script>
				  createForm("htmlform_settings_jms_change_state_%value $index%", "settings-jms.dsp", "POST", "BODY");
				  setFormProperty("htmlform_settings_jms_change_state_%value $index%", "action", "changeState");
				  setFormProperty("htmlform_settings_jms_change_state_%value $index%", "aliasName", "%value aliasName encode(url)%");
				  setFormProperty("htmlform_settings_jms_change_state_%value $index%", "setEnabled", "true");
				  </script>
				  <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_settings_jms_change_state_%value $index%.submit();">No</a>');
					   } else {
					   		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true&webMethods-wM-AdminUI=true" >No</a>');
							}
							else {
								document.write('<a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=true" >No</a>');
							}
					   }
				   </script>
                  
                %else%
                  %ifvar lastError%
				  <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_settings_jms_change_state_disable_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</a>');
					   } else {
					   		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true" ><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</a>');
							}
							else {
								document.write('<a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false" ><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</a>');
							}
					   }
				   </script>
                    
                  %else%
					<script>
				    createForm("htmlform_settings_2_%value $index%", "settings-jms.dsp", "POST", "BODY");
				    </script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_settings_2_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">In&nbsp;Progress</a>');
					   } else {
					   		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="settings-jms.dsp?webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">In&nbsp;Progress</a>');
							}
							else {
								document.write('<a href="settings-jms.dsp"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">In&nbsp;Progress</a>');
							}
					   }
				   </script>
                    
                  %endif%
                %endif%
              %else%
                <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_settings_jms_change_state_disable_%value $index%.submit();"  ><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</a>');
					   } else {
					   		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false&webMethods-wM-AdminUI=true" ><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</a>');
							}
							else {
								document.write('<a href="settings-jms.dsp?action=changeState&aliasName=%value aliasName encode(url)%&setEnabled=false" ><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</a>');
							}
					   }
				   </script>              
              %endif%

              <!-- Delete --> 
              <script>writeTD("rowdata");</script>
                %ifvar enabled equals('true')%
                  <img style="width: 13px; height: 13px;" border="0" src="icons/delete_disabled.png">
                %else%
				 <script>
				 createForm("htmlform_settings_jms_delete_alias_%value $index%", "settings-jms.dsp", "POST", "BODY");
				 setFormProperty("htmlform_settings_jms_delete_alias_%value $index%", "action", "delete");
				 setFormProperty("htmlform_settings_jms_delete_alias_%value $index%", "aliasName", "%value aliasName encode(url)%");
				 </script>
                 %ifvar hasTriggers equals('true')%
                    <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_settings_jms_delete_alias_%value $index%.submit();" onClick="return confirmDelete(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="JMS Connection Alias %value aliasName encode(html)%" border="0" src="icons/delete.png"></a>');
					   } else {
					   		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="settings-jms.dsp?action=delete&aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDelete(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="JMS Connection Alias %value aliasName encode(html)%" border="0" src="icons/delete.png"></a>');
							}
							else {
								document.write('<a href="settings-jms.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="return confirmDelete(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="JMS Connection Alias %value aliasName encode(html)%" border="0" src="icons/delete.png"></a>');
							}	
					   }	     
					</script>
                  %else%
                    <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_settings_jms_delete_alias_%value $index%.submit();" onClick="return confirmDelete1(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="JMS Connection Alias %value aliasName encode(html)%" border="0" src="icons/delete.png"></a>');
					   } else {
					   		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="settings-jms.dsp?action=delete&aliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDelete1(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="JMS Connection Alias %value aliasName encode(html)%" border="0" src="icons/delete.png"></a>');
							}
							else {
								document.write('<a href="settings-jms.dsp?action=delete&aliasName=%value aliasName encode(url)%" onClick="return confirmDelete1(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="JMS Connection Alias %value aliasName encode(html)%" border="0" src="icons/delete.png"></a>');
							}
					   }
				   </script>
                  %endif%
                %endif%
              </td>
              
              <!-- Error Message --> 
              
              %ifvar lastError%
                <tr>
                  <!-- <td class="subheading" colspan=6> -->
                  <script>writeTDspan("row-l", 6);</script>
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