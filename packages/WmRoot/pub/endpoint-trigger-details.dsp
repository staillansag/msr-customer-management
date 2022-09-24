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
  <script language="JavaScript">
  </script>
</head>

 <body onLoad="setNavigation('settings-messaging.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerMgmt_WSEndpontTrigger', true);">

  <table width="100%"><tbody>
  
  <!-- --------------------------------- -->
  <!-- Header Msg. (Invoke updates here) -->
  <!-- --------------------------------- -->
  
  <!-- Update the Trigger Properties -->
  
  %ifvar action equals('update')%
    %scope rparam(properties={enabled='';isConcurrent='';maxExecutionThreads=''})%
    %scope properties%  
        %rename ../enabled enabled -copy%
        %rename ../concurrent isConcurrent -copy%
        %rename ../maxExecutionThreads maxExecutionThreads -copy%
        %rename ../connectionCount connectionCount -copy%
    %endscope%
        %invoke wm.server.jms:updateWSETrigger%
          <script>writeMessage('Settings changed successfully');</script>
        %onerror%
	      <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
        %endinvoke% 
    %endscope%
  %endif%
  
    <!-- ---------- -->
    <!-- Start Page -->
    <!-- ---------- -->
  
    %invoke wm.server.jms:getTriggerReport%
  
    <tr>
      <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Detail &gt; %value triggerName encode(html)%<br>
      </td>
    </tr>
    <tr>
      <td colspan="2">
      <ul class="listitems">
	  
	    <li>
			
			<script>
						    createForm("htmlform_http_settings_jms_trigger_management", "settings-jms-trigger-management.dsp", "POST", "BODY");
							setFormProperty("htmlform_http_settings_jms_trigger_management", "type", "soap");
							
           </script>			
			<script>getURL("settings-jms-trigger-management.dsp?type=soap", "javascript:document.htmlform_http_settings_jms_trigger_management.submit();", "Return to JMS Trigger Management");</script>
			
		  </li>
		  
		  <li>
			
			<script>
						    createForm("htmlform_http_endpoint_trigger_edit", "endpoint-trigger-edit.dsp", "POST", "BODY");
							setFormProperty("htmlform_http_endpoint_trigger_edit", "triggerName", "%value triggerName encode(javascript)%");
							
           </script>			
			<script>getURL("endpoint-trigger-edit.dsp?triggerName=%value triggerName encode(url)%", "javascript:document.htmlform_http_endpoint_trigger_edit.submit();", "Edit Trigger");</script>
			
		  </li>
	  
	    <li>
			
			<script>
						    createForm("htmlform_http_endpoint_trigger_details", "endpoint-trigger-details.dsp", "POST", "BODY");
							setFormProperty("htmlform_http_endpoint_trigger_details", "triggerName", "%value triggerName encode(javascript)%");
							
           </script>			
			<script>getURL("endpoint-trigger-details.dsp?triggerName=%value triggerName encode(url)%", "javascript:document.htmlform_http_endpoint_trigger_details.submit();", "Refresh Page");</script>
			
		  </li>
      </ul>
      </td>
    </tr>
    <tr>
      <td><img src="images/blank.gif" height="10" width="10" border="0"></td>
      <td>
      
      <!-- --------------------- -->
      <!-- JMS Destinations and Message Selectors Info -->
      <!-- --------------------- -->
      
      <table  width="100%" class="tableView"><tbody>  
        <tr>
          <td class="heading" colspan="5">JMS Destinations and Message Selectors</td>
        </tr>
        <tr>
          <th scope="col" class="oddcol-l">Destination Name</th>
          <th scope="col" class="oddcol-l">Destination Type</th>
          <th scope="col" class="oddcol-l">JMS Message Selector</th>
          <th scope="col" class="oddcol-l">Durable Subscriber Name</th>
          <th scope="col" class="oddcol-l">Ignore Local Published</th>
        </tr>
          
        %loop trigger/destinations%                  
            <tr>
                <script>writeTD("rowdata-l");</script>
                  %value destination encode(html)%
                </td>
                <script>writeTD("rowdata-l");</script>
           %switch destinationType%
            %case '0'% Queue
            %case '1'% XA Queue
            %case '2'% Topic
            %case '3'% XA Topic
           %end%
                </td>
                <script>writeTD("rowdata-l");</script>
                  %ifvar messageSelector% %value messageSelector encode(html)% %else% N/A %endif%
                </td>
        <script>writeTD("rowdata-l");</script>
                  %ifvar durableSubscriberName% %value durableSubscriberName encode(html)% %else% N/A %endif%
                </td>
        <script>writeTD("rowdata-l");</script>
                  %ifvar durableSubscriberNoLocal% %value durableSubscriberNoLocal encode(html)% %else% false %endif%
                </td>
            </tr>
          <script>swapRows();</script>
        %endloop%
   

      </tbody></table>
      
      <!-- ----------------------- -->
      <!-- Write State Information -->
      <!-- ----------------------- -->
      
      <table class="tableView" width="100%"><tbody>
        <tr>
          <td class="heading" colspan="2">State</td>
        </tr>

        <tr>
            <td class="oddrow-l">Enabled</td>
            <td class="oddrowdata-l">%value trigger/enabled encode(html)%</td>
        </tr>
        
        
            <!-- Error message -->
          %ifvar trigger/lastError%
          <tr>
               <script>writeTDspan("row-l", 2);</script>
                  <font color="red">%value trigger/lastError encode(html)%</font><br> 
               </td>
        </tr>
          %endif%
        
        <tr>
            <td class="evenrow-l">Current Threads</td>
            <td class="evenrowdata-l">%ifvar trigger/currentThreads equals('-1')% Not Connected %else% %value trigger/currentThreads encode(html)% %endif%</td>
        </tr>
        
        <tr>
        </tr>

        <!-- -------------------------- -->
        <!-- Write Settings Information -->
        <!-- -------------------------- -->  

        <tr>
          <td class="heading" colspan="2">Settings</td>
        </tr>
        <tr>
          <td class="oddrow-l">JMS Connection Alias</td>
          <td class="oddrowdata-l">%value trigger/aliasName encode(html)%</td>
        </tr>
        <tr>
          <td class="evenrow-l">JMS Trigger Type</td>
          <td class="evenrowdata-l">
         SOAP-JMS (WS Endpoint Trigger)
      </td>
        </tr>

        <!-- -------------------------- -->
        <!-- Write Property Information -->
        <!-- -------------------------- --> 

        <tr>
          <td class="heading" colspan="2">Properties</td>
        </tr>
        <tr>
          <td class="oddrow-l">Processing Mode</td>
          <td class="oddrowdata-l">%value trigger/processingModeLocalizedString encode(html)%</td>
        </tr>

        <tr>
          <td class="evenrow-l">Maximum Execution Threads</td>
          <td class="evenrowdata-l">%value trigger/maxThreadsString encode(html)%</td>
        </tr>     
        <tr>
          <td class="oddrow-l">Connection Count</td>
          <td class="oddrowdata-l">%value trigger/connectionCount encode(html)%</td>
        </tr>         
       
    </tbody></table>
    </td>
    </tr>
  
  %onerror%
    <script>writeMessage("Error: %value errorMessage encode(html_javascript)%");</script>
  %endinvoke%
  </tbody></table>

</body></html>