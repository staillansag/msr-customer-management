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
   <body onLoad="setNavigation('trigger-management-edit-state.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditTriggerStateScrn');">
%else%
   <body onLoad="setNavigation('trigger-management-edit-state.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditStateIndivTriggerScrn');">
%endif%

<table width="100%">
  <tbody>
    <tr>
      %ifvar triggerName equals('all')%
        <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management &gt; All Triggers &gt; Edit State<br>
      %else%
        <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management &gt; %value triggerName encode(html)% &gt; Edit State<br>
      %endif%
      </td>
    </tr>       
    
    <tr>
      <td colspan="2">
      <ul class="listitems">
          <li class="listitem">
	
  	<script>
		createForm("htmlform_trigger_management", "trigger-management.dsp", "POST", "BODY");
		</script>
		<script>getURL("trigger-management.dsp", "javascript:document.htmlform_trigger_management.submit();", "Return to webMethods Messaging Trigger Management");</script>
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
          
          <form name="editform" action="trigger-management.dsp" METHOD="POST">
          
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        
            <tr>
              <td class="heading" colspan="2">State</td>
            </tr>
            <tr>
              <td class="oddrow-l"><label for="retrievalSuspend">Retrieval State</label></td>
              <td class="oddrowdata-l">
              
                <SELECT SIZE ="1" ID="retrievalSuspend" NAME="retrievalSuspend">
                %ifvar setRetrievalStatus equals('active')%
                  <OPTION VALUE="ignore">---</OPTION>
                  <OPTION SELECTED VALUE="false">Active</OPTION>
                  <OPTION VALUE="true">Suspended</OPTION>
                %else%
                  %ifvar setRetrievalStatus equals('suspended')%
                    <OPTION VALUE="ignore">---</OPTION>
                    <OPTION VALUE="false">Active</OPTION>
                    <OPTION SELECTED VALUE="true">Suspended</OPTION>
                  %else%
                    <OPTION SELECTED VALUE="ignore">---</OPTION>
                    <OPTION VALUE="false">Active</OPTION>
                    <OPTION VALUE="true">Suspended</OPTION>
                  %endif%
                %endif%
           
                </select>
              </td>
            </tr>
            <tr>
              <td class="evenrow-l"><label for="processingSuspend">Processing State</label></td>
              <td class="evenrowdata-l">
                <SELECT SIZE ="1" ID="processingSuspend" NAME="processingSuspend">
                
                 %ifvar setProcessingStatus equals('active')%
                  <OPTION VALUE="ignore">---</OPTION>
                  <OPTION SELECTED VALUE="false">Active</OPTION>
                  <OPTION VALUE="true">Suspended</OPTION>
                %else%
                  %ifvar setProcessingStatus equals('suspended')%
                    <OPTION VALUE="ignore">---</OPTION>
                    <OPTION VALUE="false">Active</OPTION>
                    <OPTION SELECTED VALUE="true">Suspended</OPTION>
                  %else%
                    <OPTION SELECTED VALUE="ignore">---</OPTION>
                    <OPTION VALUE="false">Active</OPTION>
                    <OPTION VALUE="true">Suspended</OPTION>
                  %endif%
                %endif%
                
                </select>             
              </td>
            </tr>            
            <tr>
              <td class="heading" colspan="2">Change Mode</td>
            </tr>
            <tr>
              <td class="oddrow-l"><label for="persistChange">Apply change permanently</label></td>
              <td class="oddrowdata-l">
                <INPUT TYPE="CHECKBOX" ID="persistChange" NAME="persistChange" value="true">
              </td>
            </tr>
           
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
                <input name="editMode" type="hidden" value="changeStateAll">
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
