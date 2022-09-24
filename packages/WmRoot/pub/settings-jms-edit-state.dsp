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
  <script>
  
    function showCluster() {
      prop = "%sysvar property('watt.server.cluster.aliasList')%";
      if (prop == null || prop.length < 1)
        return false;
      else
        return true;
    }

  </script>
</head>

%ifvar triggerName equals('all')%
   <body onLoad="setNavigation('trigger-management-edit-state.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerEditStateAll');">
%else%
   <body onLoad="setNavigation('trigger-management-edit-state.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerEditStateIndiv');">
%endif%
                                 
<table width="100%">
  <tbody>
    <tr>
      %ifvar triggerName equals('all')%
        <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Edit State<br>
      %else%
        %ifvar groupHeader equals('true')%
          <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Edit State - JMS Trigger Group: %value triggerName encode(html)%<br>
        %else%
          <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Edit State: %value triggerName encode(html)%<br>
        %endif%
      %endif%
      </td>
    </tr>
    <tr>
     <td colspan="2">
      <ul class="listitems">
	    
        <script>    
		      createForm("htmlform_settings_jms_trigger_management", "settings-jms-trigger-management.dsp", "POST", "BODY");
		    </script>
		    <li class="listitem">
          <script>getURL("settings-jms-trigger-management.dsp?triggerFilterValue=%value triggerFilterValue encode(url)%&aliasFilterValue=%value aliasFilterValue encode(url)%&destinationFilterValue=%value destinationFilterValue encode(url)%", "javascript:document.htmlform_settings_jms_trigger_management.submit();", "Return to JMS Trigger Management");</script>
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
          
          <form name="editform" action="settings-jms-trigger-management.dsp" METHOD="POST">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        
            
            %ifvar triggerName equals('all')%
              <tr>
                <td class="heading" colspan="2">Edit Triggers State</td>
              </tr>
              <tr>
                <td class="oddrow-l"><label for="action">New State</label></td>
                <td class="oddrowdata-l">
                  <SELECT SIZE ="1" NAME="action" ID="action">
                  <OPTION VALUE="enableTrigger">Enabled</OPTION>
                  <OPTION VALUE="disableTrigger">Disabled</OPTION>
                  <OPTION VALUE="suspendTrigger">Suspended</OPTION>
                </td>
              </tr>
              <tr>
                <td class="evenrow-l"><label for="jmsTriggerType">JMS Trigger Type</label></td>
                <td class="evenrowdata-l">
                  <SELECT SIZE ="1" NAME="jmsTriggerType" ID="jmsTriggerType">
                 
                  %switch jmsTriggerTypeReq%
                    %case '1'%
                      <OPTION VALUE="-1">All</OPTION>
                      <OPTION VALUE="0">Standard</OPTION>
                      <OPTION VALUE="1" selected>SOAP</OPTION>
                    %case '0'%
                      <OPTION VALUE="-1">All</OPTION>
                      <OPTION VALUE="0" selected>Standard</OPTION>
                      <OPTION VALUE="1">SOAP</OPTION>
                  %end%
                </td>
              </tr>
            %else%
              <tr>
                <td class="heading" colspan="2">Edit Trigger State</td>
              </tr>
              
              <tr>
                <td class="oddrow-l"><label for="action">New State</label></td>
                <td class="oddrowdata-l">
                  <SELECT SIZE ="1" NAME="action" ID="action">
                 
                  %switch setState%
                    %case 'Enabled'%
                      <OPTION VALUE="disableTrigger">Disabled</OPTION>
                      <OPTION VALUE="suspendTrigger" selected>Suspended</OPTION>
                    %case 'EnabledButNotConnected'%
                      <OPTION VALUE="disableTrigger">Disabled</OPTION>
                    %case 'Disabled'%
                      <OPTION VALUE="enableTrigger">Enabled</OPTION>
                    %case 'Suspended'%
                      <OPTION VALUE="enableTrigger" selected>Enabled</OPTION>
                      <OPTION VALUE="disableTrigger">Disabled</OPTION>
                  %end%
                </td>
              </tr>
            %endif%
           
            <script>
              if (showCluster()) {
                w("<tr>");
                w("<td class='evenrow-l'>Apply change across cluster</td>");
                w("<td class='evenrowdata-l'><INPUT TYPE='CHECKBOX' NAME='applyChangeAcrossCluster' value='true'></td>");
                w("</tr>");
              }
            </script>
            
            <tr>
              <td class="action" colspan=2>
                <input name="triggerName" type="hidden" value="%value triggerName encode(htmlattr)%">

                %ifvar setState equals('Suspend')%
                  <input name="action" type="hidden" value="suspendTrigger">
                %else%
                  %ifvar setState equals('Enable')%
                    <input name="action" type="hidden" value="enableTrigger">
                  %endif%
                %endif%            
                <input name="type" type="hidden" value="%value type encode(htmlattr)%">
                <input name="triggerFilterValue" type="hidden" value="%value triggerFilterValue encode(htmlattr)%"> 
                <input name="aliasFilterValue" type="hidden" value="%value aliasFilterValue encode(htmlattr)%">   
                <input name="destinationFilterValue" type="hidden" value="%value destinationFilterValue encode(htmlattr)%"> 
                <input name="groupHeader" type="hidden" value="%value groupHeader encode(htmlattr)%">
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
