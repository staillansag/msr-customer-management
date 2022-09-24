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
  <script Language="JavaScript">
     
      function showCluster() {
        prop = "%sysvar property('watt.server.cluster.aliasList')%";
        if (prop == null || prop.length < 1)
          return false;
        else
          return true;
      }
  </script>
  
  
</head>

<body onLoad="setNavigation('trigger-management-edit-properties.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditTriggerPropertiesScrn');">

%invoke wm.server.triggers:getProperties%

<table width="100%">
  <tbody>
    <tr>
      <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management &gt; %value triggerName encode(html)% &gt; Edit Properties<br>
      </td>
    </tr>
        <tr>
      <td colspan="2">
      <ul class="listitems">
          <li class="listitem">
		<script>
		createForm("htmlform_trigger_management_details", "trigger-management-details.dsp", "POST", "BODY");
		setFormProperty("htmlform_trigger_management_details", "triggerName", "%value triggerName encode(html)%");
		</script>
		<script>getURL("trigger-management-details.dsp?triggerName=%value triggerName encode(html)%", "javascript:document.htmlform_trigger_management_details.submit();", "Return to webMethods Messaging Trigger");</script>
		</li>
      </ul>
      </td>
    </tr>
    <tr>
      
        <table class="tableView">
        <tbody>
          <form name="editform" action="trigger-management-details.dsp?triggerName=%value triggerName encode(url)%" METHOD="POST">
          
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            
            <tr>
              <td class="heading" colspan="2">Properties</td>
            </tr>
  
            <tr>
              <td class="evenrow-l"><label for="queueCapacity">Queue Capacity</label></td>
              <td class="evenrowdata-l">
                %ifvar typeDisplayValue equals('UM')%
                  <input type="text" id=queueCapacity"" name="na" value="N/A" disabled="true">
                %else%
                  <input type="text" id="queueCapacity" name="queueCapacity" value="%value queueCapacity encode(htmlattr)%">
                %endif%
              </td>   
            </tr>
            <tr>
              <td class="oddrow-l"><label for="queueRefillLevel">Queue Refill Level</label></td>
              <td class="oddrowdata-l">
              %ifvar typeDisplayValue equals('UM')%
                <input type="text" id="queueRefillLevel" name="na" value="N/A" disabled="true">
              %else%
                <input type="text" id="queueRefillLevel" name="queueRefillLevel" value="%value queueRefillLevel encode(htmlattr)%">
              %endif%
              </td>
            </tr>
     
            %ifvar isConcurrent equals('true')%
    
              <tr>
                <td class="evenrow-l"><label for="maxExecutionThreads">Max Execution Threads</label></td>
                <td class="evenrowdata-l">
                  <input type="text" id="maxExecutionThreads" name="maxExecutionThreads" value="%value maxExecutionThreads encode(htmlattr)%">
                </td>
              </tr>
   
            %else%
    
              <tr>
                <td class="evenrow-l"><label for="maxExecutionThreads">Max Execution Threads</label></td>
                <td class="evenrowdata-l">
                  <input type="text" id="maxExecutionThreads" name="maxExecutionThreads" value="N/A" disabled="true"> 
              </tr>
          
            %endif%        
  
            <script>
              if (showCluster()) {
                w("<tr>");
                w("<td class='heading' colspan='2'>Change Mode</td>");
                w("</tr>");
                w("<tr>");
                
                w("<td class='evenrow-l'>Apply change across cluster</td>");
                w("<td class='evenrowdata-l'><INPUT TYPE='CHECKBOX' NAME='applyChangeAcrossCluster' value='true'></td>");
                w("</tr>");
              }
            </script>
          
            <tr>
              <td class="action" colspan=2>
                <input name="triggerName" type="hidden" value="%value triggerName encode(htmlattr)%">
                <input name="editMode" type="hidden" value="changeProperties">
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

%onerror%
  %value errorMessage encode(html)%
%endinvoke%

</body>
</html>
