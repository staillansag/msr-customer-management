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
    
    var writetoWindow;
    function showFilter(source) {
      source=document.getElementById(source).value;
      source=source.replace(/\+/g," ");
	  var enc = encodeURI(source);
      source=decodeURI(enc);
      if (writetoWindow) {
        if (!(writetoWindow.closed)) { writetoWindow.close(); }
      }
      
      var left = 10, top = 10;
      var width = 400, height = 300;
    
      if (document.all || document.layers) {
        w = screen.availWidth - width;
        h = screen.availHeight - height;
      
        if (w <= 0)
          w = 1;
      
        if (h <= 0)
          h = 1;
        
        left = w/2;
        top = h/2;
      }    
      writetoWindow = window.open("","writetoWindow","screenX="+left+",screenY="+top+",top="+top+",left="+left+",width="+width+",height="+height+",scrollbars,resizable");
      writetoWindow.document.write(source);
      writetoWindow.focus(); // bring to front
    
    }
    
    var messageFlag = false;
    
    function getMessageFlag() {
      return messageFlag;
    }
    
    function setMessageFlag(value) {
      messageFlag = value;
    }
    
    function this_writeMessage(value) {
      if (!messageFlag) // this will avoid more than one error message at a time.
        writeMessage(value);
    }
    
  </script>
</head>

 <body onLoad="setNavigation('trigger-management-details.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_TriggerDetailScrn');">

  <table width="100%"><tbody>
  
  <!-- --------------------------------- -->
  <!-- Header Msg. (Invoke updates here) -->
  <!-- --------------------------------- -->
  
  <!-- Update the Trigger Properties -->
  
  %ifvar editMode equals('changeProperties')%
  
    %invoke wm.server.triggers:setProperties%
      <script>writeMessage('Settings changed successfully');</script>
    %onerror%
      <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
    %endinvoke% 
  %endif%
  
    <!-- ---------- -->
    <!-- Start Page -->
    <!-- ---------- -->
  
    %invoke wm.server.triggers:getTriggerReport%
  
    <tr>
      <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management &gt; %value triggerName encode(html)%<br>
      </td>
    </tr>
       <tr>
      <td colspan="2">
      <ul class="listitems">
         
	    <script>
		createForm("htmlform_trigger_management", "trigger-management.dsp", "POST", "BODY");
		createForm("htmlform_trigger_management_edit_properties", "trigger-management-edit-properties.dsp", "POST", "BODY");
		setFormProperty("htmlform_trigger_management_edit_properties", "triggerName", "%value triggerName encode(html_javascript)%");
		createForm("htmlform_trigger_management_details", "trigger-management-details.dsp", "POST", "BODY");
		setFormProperty("htmlform_trigger_management_details", "triggerName", "%value triggerName encode(html_javascript)%");
		</script>
        <li class="listitem"><script>getURL("trigger-management.dsp", "javascript:document.htmlform_trigger_management.submit();", "Return to webMethods Messaging Trigger Management");</script>
		</li>
        <li class="listitem"><script>getURL("trigger-management-edit-properties.dsp?triggerName=%value triggerName encode(url)%", "javascript:document.htmlform_trigger_management_edit_properties.submit();", "Edit Properties");</script>
		</li>
        <li class="listitem"><script>getURL("trigger-management-details.dsp?triggerName=%value triggerName encode(url)%", "javascript:document.htmlform_trigger_management_details.submit();", "Refresh Page");</script>
		</li>
      </ul>
      </td>
    </tr>
    <tr>
     
      <td>
      
      <!-- --------------------- -->
      <!-- Write Conditions Info -->
      <!-- --------------------- -->
      
      <table width="100%" class="tableView"><tbody>  
        <tr>
          <td class="heading" colspan="6">Conditions</td>
        </tr>
        <tr>
          <th class="oddcol-l" scope="col">Name</th>
          <th class="oddcol-l" scope="col">Service</th>
          <th class="oddcol-l" scope="col">Join</th>
          <th class="oddcol-l" scope="col">Document</th>
          <th class="oddcol-l" scope="col">Filter</th>
          <th class="oddcol-l" scope="col">Provider Filter (UM Only)</th>
        </tr>
          
        %loop triggers[0]/conditions%                  
          %loop documentTypeFilterPairs%
            <tr>
              %ifvar $index equals('0')%
                <script>writeTD("rowdata-l");</script>
                  %value ../name encode(html)%
                </td>
                <script>writeTD("rowdata-l");</script>
                  %value ../service encode(html)%
                </td>
                <script>writeTD("rowdata-l");</script>
                  %value ../joinType encode(html)%
                </td> 
              %else%
                <script>writeTD("rowdata");</script></td>
                <script>writeTD("rowdata");</script></td>
                <script>writeTD("rowdata");</script></td>
              %endif%            
            
              <script>writeTD("rowdata-l");</script>
                %value documentType encode(html)%
              </td>
              
              %ifvar filterSource -isnull%
                <script>writeTD("rowdata-l");</script>none</td> 
              %else%
                %ifvar filterSource equals('')%
                  <script>writeTD("rowdata-l");</script>none</td>
                %else%
                  <input type="hidden" id="filterSource%value $index encode(htmlattr)%" name="filterSource%value $index encode(htmlattr)%" value="%value filterSource encode(htmlattr)%"/>
                  <script>writeTD("rowdata-l");</script><a href="javascript:showFilter('filterSource%value $index encode(html_javascript)%');">view</a></td>
                %endif%
              %endif%
              
              %ifvar umFilter -isnull%
                <script>writeTD("rowdata-l");</script>none</td> 
              %else%
                %ifvar umFilter equals('')%
                  <script>writeTD("rowdata-l");</script>none</td>
                %else%
                  <input type="hidden" id="umFilter%value $index encode(htmlattr)%" name="umFilter%value $index encode(htmlattr)%" value="%value umFilter encode(htmlattr)%"/>
                  <script>writeTD("rowdata-l");</script><a href="javascript:showFilter('umFilter%value $index encode(html_javascript)%');">view</a></td>
                %endif%
              %endif%
              
            </tr>
          %endloop%        
          <script>swapRows();</script>
        %endloop%
      </tbody></table>
      
      <!-- ----------------------- -->
      <!-- Write State Information -->
      <!-- ----------------------- -->
      
      <table width="100%" class="tableView"><tbody>
        <tr>
          <td class="heading" colspan="2">State</td>
        </tr>
        %ifvar triggers[0]/processingStatus/state -notempty%
          <tr>
            <td class="oddrow-l" width="50%" scope="row">Retrieval State Active</td>
            
            %ifvar triggers[0]/retrievalStatus/state equals('active')%
              <td class="oddrowdata-l"><img style="width: 13px; height: 13px;" alt="" src="images/green_check.png">Yes</td>
              
            %else% %ifvar triggers[0]/retrievalStatus/state equals('active-temp')%  
              <td class="oddrowdata-l"><img style="width: 13px; height: 13px;" alt="" src="images/green_check.png">Yes*</td>
  
            %else% %ifvar triggers[0]/retrievalStatus/state equals('suspended')%  
              <td class="oddrowdata-l">No</td>
            
            %else% <!-- state = suspended-temp -->
              <td class="oddrowdata-l">No*</td>
            
            %endif%
            %endif%
            %endif%
            
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Processing State Active</td>
              
            %ifvar triggers[0]/processingStatus/state equals('active')%
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="" src="images/green_check.png">Yes</td>
           
            %else% %ifvar triggers[0]/processingStatus/state equals('active-temp')%
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="" src="images/green_check.png">Yes*</td> 
            
            %else% %ifvar triggers[0]/processingStatus/state equals('suspended')%
              <td class="evenrowdata-l">No</td>
              
            %else% <!-- state = suspended-temp -->
              <td class="evenrowdata-l">No*</td>
              
            %endif%
            %endif%
            %endif%
  
          </tr>
          <tr>
            <td class="oddrow-l" scope="row">Current Threads (Processing)</td>
            <td class="oddrowdata-l">%value triggers[0]/processingStatus/activeThreadCount encode(html)%</td>
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Volatile Queue</td>
            <td class="evenrowdata-l">%value triggers[0]/processingStatus/volatileQueueCount encode(html)%</td>
          </tr>
 
          <tr>
            <td class="oddrow-l" scope="row">Persisted Queue</td>
            %ifvar triggers[0]/properties/typeDisplayValue equals('UM')%
              <td class="oddrowdata-l">N/A</td>
            %else%
              <td class="oddrowdata-l">%value triggers[0]/processingStatus/persistedQueueCount encode(html)%</td>
            %endif%
          </tr>
                
        %else%
          <tr>
            <td class="oddrow-l" scope="row">Retrieval State</td>
            <td class="oddrowdata-l">N/A</td>
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Processing State</td>
            <td class="evenrowdata-l">N/A</td>
          </tr>
          <tr>
            <td class="oddrow-l" scope="row">Current Threads (Processing)</td>
            <td class="oddrowdata-l">N/A</td>
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Volatile Queue</td>
            <td class="evenrowdata-l">N/A</td>
          </tr>
          <tr>
            <td class="oddrow-l" scope="row">Persisted Queue</td>
            <td class="oddrowdata-l">N/A</td>
          </tr>
        %endif%
       
        <tr>
        </tr>
        
        <!-- -------------------------- -->
        <!-- Write Property Information -->
        <!-- -------------------------- -->
        
        <tr>
          <td class="heading" colspan="2">Properties</td>
        </tr>
        <tr>
          <td class="oddrow-l" scope="row">Enabled</td>
          %ifvar triggers[0]/properties/executeEnabled equals('true')%
            <td class="oddrowdata-l">True<br>
          %else%
            <td class="oddrowdata-l">False<br>
          %endif%
          </td>
        </tr>

        <tr>
          <td class="evenrow-l" scope="row">Join Expires After</td>
          <td class="evenrowdata-l">%value triggers[0]/properties/joinTimeOut encode(html)%</td>
        </tr>     
                   
        %ifvar triggers[0]/retrievalStatus/state equals('active')%
          %ifvar triggers[0]/properties/queueCapacity vequals(triggers[0]/properties/queueCapacityThrottle)%  
            <tr>
              <td class="oddrow-l" scope="row">Trigger Queue Capacity</td>
              <td class="oddrowdata-l">%value triggers[0]/properties/queueCapacity encode(html)%</td>
            </tr>
            <tr>
              <td class="evenrow-l" scope="row">Trigger Queue Refill Level<br>
              %ifvar triggers[0]/properties/typeDisplayValue equals('UM')%
                <td class="evenrowdata-l">N/A</td>
              %else%
                <td class="evenrowdata-l">%value triggers[0]/properties/queueRefillLevel encode(html)%</td>
              %endif%
            </tr>   
          %else%
            <tr>
              <td class="oddrow-l" scope="row">Trigger Queue Capacity</td>
              <td class="oddrowdata-l">%value triggers[0]/properties/queueCapacityThrottle encode(html)%&nbsp;(%value triggers[0]/properties/queueCapacity encode(html)%)</td>
            </tr>
            <tr>
              <td class="evenrow-l" scope="row">Trigger Queue Refill Level<br>
              %ifvar triggers[0]/properties/typeDisplayValue equals('UM')%
                <td class="evenrowdata-l">N/A</td>
              %else%
                <td class="evenrowdata-l">%value triggers[0]/properties/queueRefillLevelThrottle encode(html)%&nbsp;(%value triggers[0]/properties/queueRefillLevel encode(html)%)</td>
              %endif%
            </tr>      
          %endif%
        %else%
          <tr>
            <td class="oddrow-l" scope="row">Trigger Queue Capacity</td>
            <td class="oddrowdata-l">0&nbsp;(%value triggers[0]/properties/queueCapacity encode(html)%)</td>
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Trigger Queue Refill Level<br>
            <td class="evenrowdata-l">0&nbsp;(%value triggers[0]/properties/queueRefillLevel encode(html)%)</td>  
          </tr>
        %endif%
             
        <tr>
          <td class="oddrow-l" scope="row">Acknowledgment Queue Size</td>
          <td class="oddrowdata-l">%value triggers[0]/properties/ackQueueSize encode(html)%</td>
        </tr>
        
        <tr>
          <td class="evenrow-l" scope="row">Maximum Retry Attempts</td>
          <td class="evenrowdata-l">%value triggers[0]/properties/maxRetryAttempts encode(html)%</td>
        </tr>
        <tr>
          <td class="oddrow-l" scope="row">Retry Interval</td>
          <td class="oddrowdata-l">%value triggers[0]/properties/retryInterval encode(html)%</td>
        </tr>
        <!-- Retry Failure Handling -->
        %ifvar triggers[0]/properties/redeliveryAction equals('0')%
          <tr>
            <td class="evenrow-l" scope="row">Retry Failure Behavior</td>
            <td class="evenrowdata-l">Throw service exception</td>
          </tr> 
          <tr>
            <td class="oddrow-l" scope="row">Resource Monitoring Service</td>
            <td class="oddrowdata-l">N/A</td>
          </tr>
        %else%
          <tr>
            <td class="evenrow-l" scope="row">Retry Failure Behavior</td>
            <td class="evenrowdata-l">Suspend and retry later</td>
          </tr> 
          <tr>
            <td class="oddrow-l" scope="row">Resource Monitoring Service</td>
            <td class="oddrowdata-l">%value triggers[0]/properties/monitorServiceName encode(html)%</td>
          </tr>
        %endif%
        <!-- Trigger Processing info -->
        %ifvar triggers[0]/properties/isConcurrent equals('true')%
          <tr>
            <td class="evenrow-l" scope="row" nowrap>Processing Mode</td>
            <td class="evenrowdata-l">Concurrent</td>
          </tr>
          <tr>
            <td class="oddrow-l" scope="row">Maximum Execution Threads</td>
            %ifvar triggers[0]/processingStatus/state matches('active*')%
              %ifvar triggers[0]/properties/maxExecutionThreads vequals(triggers[0]/properties/maxExecutionThreadsThrottle)%
                <td class="oddrowdata-l">%value triggers[0]/properties/maxExecutionThreads encode(html)%</td>
              %else%
                <td class="oddrowdata-l">%value triggers[0]/properties/maxExecutionThreadsThrottle encode(html)%&nbsp;(%value triggers[0]/properties/maxExecutionThreads encode(html)%)</td>
            %endif%
          %else%
            <td class="oddrowdata-l">0&nbsp;(%value triggers[0]/properties/maxExecutionThreads encode(html)%)</td> 
          %endif%
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Suspend on Error</td>
            <td class="evenrowdata-l">N/A<br>
          </tr>
        %else%
          <tr>
            <td class="evenrow-l" scope="row">Processing Mode</td>
            <td class="evenrowdata-l">Serial</td>
          </tr>
          <tr>
            <td class="oddrow-l" scope="row">Max Execution Threads</td>
            %ifvar triggers[0]/processingStatus/state matches('active*')%
              <td class="oddrowdata-l">1</TD>
            %else%
              <td class="oddrowdata-l">0&nbsp;(1)</TD>
            %endif%
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Suspend on Error</td>
        %ifvar triggers[0]/properties/serialSuspendOnError equals('true')%
              <td class="evenrowdata-l">True</td>
            %else%
              <td class="evenrowdata-l">False</td>
            %endif%
          </tr>
        %endif%

        <!-- Dup Detection -->
        %ifvar triggers[0]/properties/dupDetection equals('false')%
          <tr>
            <td class="oddrow-l" scope="row">Exactly Once Detect Duplicates</td>
            <td class="oddrowdata-l">False</td>
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Exactly Once Use History</td>
            <td class="evenrowdata-l">N/A</td>
          </tr>
          <tr>
            <td class="oddrow-l" scope="row">Exactly Once History Time to Live</td>
            <td class="oddrowdata-l">N/A</td>
          </tr>
        %else%
          <tr>
            <td class="oddrow-l" scope="row">Detect Duplicates</td>
            <td class="oddrowdata-l">True</td>
          </tr>
          %ifvar triggers[0]/properties/dupHistory equals('false')%
          <tr>
              <td class="evenrow-l" scope="row">Use History</td>
              <td class="evenrowdata-l">False</td>
            </tr>
            <tr>
              <td class="oddrow-l" scope="row">History Time to Live</td>
              <td class="oddrowdata-l">N/A</td>
            </tr>
          %else%
            <tr>
              <td class="evenrow-l" scope="row">Use History</td>
              <td class="evenrowdata-l">True</td>
            </tr>
            <tr>
              <td class="oddrow-l" scope="row">History Time to Live</td>
              <td class="oddrowdata-l">%value triggers[0]/properties/dupHistoryTTL encode(html)%</td>
            </tr>
          %endif%
        %endif%
        
        <tr>
          <td class="evenrow-l" scope="row">Priority Enabled</td>
          %ifvar triggers[0]/properties/typeDisplayValue equals('UM')%
            <td class="evenrowdata-l">N/A</td>
          %else%
            %ifvar triggers[0]/properties/priorityEnabled equals('true')%
              <td class="evenrowdata-l">True</td>
            %else%
                <td class="evenrowdata-l">False</td>
              %endif%
          %endif%
        </tr>
        
        %ifvar triggers[0]/properties/principals -notempty%
        
        <tr>
          <td class="heading" colspan="2">Destination ID for Deliver</td>
        </tr>
        
        <tr>
          <td class="oddrow-l" scope="row">Trigger Client ID</td>
          <td class="oddrowdata-l">%value triggers[0]/properties/principals[1] encode(html)%</td>
        </tr>
        
        <tr>
          <td class="evenrow-l" scope="row">Default Client ID</td>
          <td class="evenrowdata-l">%value triggers[0]/properties/principals[3] encode(html)%</td>
        </tr>
       
        %endif%
        
    </tbody></table>
    </td>
    </tr>
  
  %onerror%
    <script>writeMessage("Error: %value errorMessage encode(html_javascript)%");</script>
  %endinvoke%
  </tbody></table>

</body></html>