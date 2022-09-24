<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="no-cache" http-equiv="Pragma">
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  <meta content="-1" http-equiv="Expires">
  <title>Server &gt; Statistics</title>
  <link href="webMethods.css" type="text/css" rel="stylesheet">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js"></script>
  
  <script language="JavaScript">
  
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
    
    function showCluster() {
      prop = "%sysvar property('watt.server.cluster.aliasList')%";
      if (prop == null || prop.length < 1)
        return false;
      else
        return true;
    }
    
  </script>
</head>

<body onLoad="setNavigation('trigger-management.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_TriggerMgmtScrn');">

  <table width="100%"><tbody>
  
    <!-- ---------------- -->
    <!-- Edit State Logic -->
    <!-- ---------------- -->
  
  
    <!-- <script>alert("editMode = %value editMode encode(javascript)%, retrievalState = %value retrievalState encode(javascript)%, processingState = %value processingState encode(javascript)%");</script> -->
    
    
    %ifvar editMode equals('changeState')%
 
      %ifvar retrievalState equals('suspended')%
        %invoke pub.trigger:suspendRetrieval%
        %onerror%
          <script>this_writeMessage("%value errorMessage encode(html_javascript)%");</script>
          <script>setMessageFlag(true);</script>
        %endinvoke%
      %endif%
  
      %ifvar retrievalState equals('active')%
        %invoke pub.trigger:resumeRetrieval%
        %onerror%
          <script>this_writeMessage("%value errorMessage encode(html_javascript)%");</script>
          <script>setMessageFlag(true);</script>
        %endinvoke%
      %endif%
    
      %ifvar processingState equals('suspended')%
        %invoke pub.trigger:suspendProcessing%
        %onerror%
          <script>this_writeMessage("%value errorMessage encode(html_javascript)%");</script>
          <script>setMessageFlag(true);</script>
        %endinvoke%
      %endif%
  
      %ifvar processingState equals('active')%
        %invoke pub.trigger:resumeProcessing%
        %onerror%
          <script>this_writeMessage("%value errorMessage encode(html_javascript)%");</script>
          <script>setMessageFlag(true);</script>
        %endinvoke%
      %endif%
      
      <script>this_writeMessage('Settings changed successfully');</script>
  
    %endif%

    %ifvar editMode equals('changeStateAll')%

      %invoke wm.server.triggers:suspendTrigger%
        <script>writeMessage('Settings changed successfully');</script>
      %onerror%
        <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
      %endinvoke%
    %endif%
  
    <tr>
      <td class="breadcrumb" colspan="3">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management</td>
    </tr>
    
    <!-- -------------------- -->
    <!-- Edit Global Controls -->
    <!-- -------------------- -->
    
    <tr>
      %ifvar action equals('change')%
        %invoke wm.server.admin:setTriggerThrottleControlSettings%
          <tr><td colspan="2">&nbsp;</td></tr>
          %ifvar message -notempty%
            <tr><td class="message" colspan=2>%value message encode(html)%</td></tr>
          %else%
            <tr><td class="message" colspan=2>Settings changed successfully</td></tr>
          %endif%
        %onerror%
          <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
        %endinvoke%
      %endif%
    </tr>
  </tbody></table>

<!-- --------------- -->
<!-- Start Main Page -->
<!-- --------------- -->

  <table width="100%"><tbody>
  
    <tr>
      <td colspan="2">
      <ul class="listitems">
		<script>
		createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
		createForm("htmlform_trigger_management_throttle_controls_edit", "trigger-management-throttle-controls-edit.dsp", "POST", "BODY");
		createForm("htmlform_trigger_management", "trigger-management.dsp", "POST", "BODY");
		createForm("htmlform_wmmessaging", "settings-wm-messaging.dsp", "POST", "BODY");
		createForm("htmlform_trigger_management_cluster", "trigger-management-cluster.dsp", "POST", "BODY");
		</script>
    %ifvar webMethods-wM-AdminUI%
    %else%
        <li class="listitem"><script>getURL("settings-messaging.dsp", "javascript:document.htmlform_settings_messaging.submit();", "Return to Messaging");</script>
		    </li>
        <li class="listitem"><script>getURL("settings-wm-messaging.dsp", "javascript:document.htmlform_wmmessaging.submit();", "View webMethods Messaging Settings");</script>
		    </li>
    %endif%
        <li class="listitem"><script>getURL("trigger-management-throttle-controls-edit.dsp", "javascript:document.htmlform_trigger_management_throttle_controls_edit.submit();", "Edit Global webMethods Messaging Trigger Controls");</script>
		</li>
        <li class="listitem"><script>getURL("trigger-management.dsp", "javascript:document.htmlform_trigger_management.submit();", "Refresh Page");</script>
		</li>
        <script>
          if (showCluster())
            		
			if (is_csrf_guard_enabled && needToInsertToken) {
				w("<li class='listitem'><a href='javascript:document.htmlform_trigger_management_cluster.submit();'>Cluster View</a></li>");
			} else {
				%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					w("<li class='listitem'><a href='trigger-management-cluster.dsp?webMethods-wM-AdminUI=true'>Cluster View</a></li>");
				}
				else {
					w("<li class='listitem'><a href='trigger-management-cluster.dsp'>Cluster View</a></li>");
				}
			}
        </script>
      </ul> 
      </td>
    </tr>
    
    <tr>
    </tr>
    
    %rename triggerName none%
    %invoke wm.server.triggers:getTriggerReport%
    
    <tr>
      <td>
      <table width="100%" class="tableView">
        <tbody>
          <tr>
           <td class="heading" colspan="2">Global webMethods Messaging Trigger Controls</td>
          </tr>
        </tbody>
      </table>
      <table style="width: 100%;" class="tableView">
        <tbody>
          <tr>
            <td width="50%" colspan="2" class="subheading">Document Retrieval</td>
            <td width="50%" colspan="2" class="subheading">Document Processing</td>
          </tr>
          <tr>
            <td class="subheading2" nowrap>Current Threads</td>
            %ifvar globalSettings/maximumDocumentRetrievalThreadsPct -notempty%
              <td class="evenrow-l" nowrap>%value globalSettings/currentNumberDocumentRetrievalThreads encode(html)%</td>
            %else%
              <td class="evenrow-l">N/A</td>
            %endif%
            <td class="subheading2" nowrap>Current Threads</td>
            <td class="evenrow-l" nowrap>%value globalSettings/currentNumberTriggerExecutionThreads encode(html)%</td>
          </tr>
          <tr>
            <td class="subheading2" nowrap>Maximum Threads</td>
            %ifvar globalSettings/maximumDocumentRetrievalThreadsPct -notempty%
              <td class="oddrow-l" nowrap>%value globalSettings/maximumDocumentRetrievalThreadsCount encode(html)% (%value globalSettings/maximumDocumentRetrievalThreadsPct encode(html)%% of Server Thread Pool)</td>
            %else%
              <td class="oddrow-l" nowrap>(Broker Not Configured)</td>
            %endif%
            <td class="subheading2" nowrap>Maximum Threads</td>
            %ifvar globalSettings/maximumTriggerExecutionThreadsCount -notempty%
              <td class="oddrow-l" nowrap>%value globalSettings/maximumTriggerExecutionThreadsCount encode(html)% (%value globalSettings/maximumTriggerExecutionThreadsPct encode(html)%% of Server Thread Pool)</td>
            %else%
              <td class="oddrow-l" nowrap></td>
            %endif%
          </tr>
          <tr>
            <td class="subheading2" nowrap>Queue Capacity Throttle</td>
            <td class="evenrow-l">%value globalSettings/triggerDocumentStoreThrottle encode(html)%%</td>
            <td class="subheading2" nowrap>Execution Threads Throttle</td>
            <td class="evenrow-l">%value globalSettings/triggerExecutionThreadsThrottle encode(html)%%</td>
          </tr>

        </tbody>
      </table>
    </tr>

    <tr>
    </tr>
    
    <tr>
      <td>
      <table width="100%" class="tableView">
        <tbody>
          <tr>
            <td class="heading">Individual webMethods Messaging Trigger Controls</td>
          </tr>
        </tbody>
      </table>  
      <table style="width: 100%;" class="tableView">
        <tbody>
          <tr>
            <td colspan="3" class="subheading">&nbsp;</td>
            <td colspan="3" class="subheading">Document Retrieval</td>
            <td colspan="4" class="subheading">Document Processing</td>
          </tr>
          <tr>
            <th class="subheading2" scope="col">
              <!-- Trigger Name&nbsp;&#9660;&nbsp;&#9650; -->
              Trigger Name
            </th>
            
            <!-- <th class="oddcol-l">Connection Alias Name&nbsp;&#9660;&nbsp;&#9650;</th> -->
            <th class="subheading2" scope="col" >Connection Alias Name</th>
            <th class="subheading2" scope="col">Type</th>
			<script>
			createForm("htmlform_trigger_management_edit_state", "trigger-management-edit-state.dsp", "POST", "BODY");
			setFormProperty("htmlform_trigger_management_edit_state", "triggerName", "all");
			</script>
            <th class="subheading2" scope="col">Active<br><script>getURL("trigger-management-edit-state.dsp?triggerName=all", "javascript:document.htmlform_trigger_management_edit_state.submit();", "edit&nbsp;all");</script>
			</th>      
            <th class="subheading2" scope="col">Queue Capacity</th>
            <th class="subheading2" scope="col">Current Queue Count</th>          
            <th class="subheading2" scope="col">Active<br><script>getURL("trigger-management-edit-state.dsp?triggerName=all", "javascript:document.htmlform_trigger_management_edit_state.submit();", "edit&nbsp;all");</script>
			</th>            
            <th class="subheading2" scope="col">Processing Mode</th>         
            <th class="subheading2" scope="col">Maximum Threads</th>
            <th class="subheading2" scope="col">Current Thread Count</th>   
          </tr>
          
          
          %loop triggers%    
          <tr>
            <script>writeTD("row-l");</script>
			<script>
			createForm("htmlform_trigger_management_details_%value $index%", "trigger-management-details.dsp", "POST", "BODY");
			setFormProperty("htmlform_trigger_management_details_%value $index%", "triggerName", "%value name encode(html_javascript)%");
			</script>
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<a href="javascript:document.htmlform_trigger_management_details_%value $index%.submit();">%value name encode(html)%<br></a>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="trigger-management-details.dsp?triggerName=%value name encode(url)%&webMethods-wM-AdminUI=true">%value name encode(html)%<br></a>');
					}
					else {
						document.write('<a href="trigger-management-details.dsp?triggerName=%value name encode(url)%">%value name encode(html)%<br></a>');
					}
				}
			</script>
			</td>
            
            <script>writeTD("row-l");</script>%value properties/aliasDisplayValueDSP encode(html)%</td> 
            
            %ifvar properties/typeDisplayValueDSP equals('UM')%
              <script>writeTDnowrap("row-l");</script>Universal Messaging</td> 
            %else%
              %ifvar properties/typeDisplayValueDSP equals('DES')%
                <script>writeTDnowrap("row-l");</script>Digital Event Services</td> 
              %else%
                <script>writeTD("row-l");</script>%value properties/typeDisplayValueDSP encode(html)%</td>  
              %endif%
            %endif%

            <!-- ----------------------- -->
            <!-- Document Retrieval info -->  
            <!-- ----------------------- -->
            
            %ifvar properties/typeDisplayValueDSP equals('LOCAL')%
            
                <script>writeTD("rowdata");</script>
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes&nbsp;
                </td>

                <script>writeTD("row-l");</script>N/A</td>
                
                <script>writeTD("row-l");</script>
                  %value processingStatus/persistedQueueCount%  
                </td> 
            
            %else%
            <script>
			createForm("htmlform_trigger_management_edit_state_suspended_%value $index%", "trigger-management-edit-state.dsp", "POST", "BODY");
			setFormProperty("htmlform_trigger_management_edit_state_suspended_%value $index%", "triggerName", "%value name encode(html_javascript)%");
			setFormProperty("htmlform_trigger_management_edit_state_suspended_%value $index%", "setRetrievalStatus", "suspended");
			
			createForm("htmlform_trigger_management_edit_state_active_%value $index%", "trigger-management-edit-state.dsp", "POST", "BODY");
			setFormProperty("htmlform_trigger_management_edit_state_active_%value $index%", "triggerName", "%value name encode(html_javascript)%");
			setFormProperty("htmlform_trigger_management_edit_state_active_%value $index%", "setRetrievalStatus", "active");
			
			createForm("htmlform_trigger_management_edit_state_suspended_1_%value $index%", "trigger-management-edit-state.dsp", "POST", "BODY");
			setFormProperty("htmlform_trigger_management_edit_state_suspended_1_%value $index%", "triggerName", "%value name encode(html_javascript)%");
			setFormProperty("htmlform_trigger_management_edit_state_suspended_1_%value $index%", "setRetrievalStatus", "suspended");
			</script>
			%ifvar retrievalStatus/state -notempty%
                %ifvar retrievalStatus/state equals('active')%  
                 
                  %ifvar lastError -notempty%
                    <script>writeTD("rowdata");</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_suspended_%value $index%.submit();">Yes</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=suspended&webMethods-wM-AdminUI=true">Yes</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=suspended">Yes</a>');
							}
						}
					</script>
					&nbsp;</td>
                  %else%
                    <script>writeTD("rowdata");</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_suspended_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=suspended&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=suspended"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
							}
						}
					</script>
					&nbsp;</td>
                  %endif%
                  
                %else% %ifvar retrievalStatus/state equals('active-temp')%
                <script>writeTD("rowdata");</script>
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_suspended_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=suspended&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
						}else {
							document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=suspended"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
						}
					}
				</script>
				*</td>
                %else% %ifvar retrievalStatus/state equals('suspended')%
	                <script>writeTD("rowdata");</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_active_%value $index%.submit();">No</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=active&webMethods-wM-AdminUI=true">No</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=active">No</a>');
							}
						}
					</script>
					&nbsp;</td>
                %else% %ifvar retrievalStatus/state equals('suspended-disabled')%
	                <script>writeTDnowrap("rowdata");</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_active_%value $index%.submit();">No (not&nbsp;connected)</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=active&webMethods-wM-AdminUI=true">No (not&nbsp;connected)</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=active">No (not&nbsp;connected)</a>');
							}
						}
					</script>
					&nbsp;</td>
                %else% %ifvar retrievalStatus/state equals('active-disabled')%
	              
                  %ifvar runtimeState/state equals('stopped')%
                    <script>writeTDnowrap("rowdata");</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_suspended_1_%value $index%.submit();">Yes (not&nbsp;connected)</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended&webMethods-wM-AdminUI=true">Yes (not&nbsp;connected)</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended">Yes (not&nbsp;connected)</a>');
							}
						}
					</script>
					&nbsp;</td>
                  %else% 
                    %ifvar runtimeState/state equals('NA')%
                      <script>writeTDnowrap("rowdata");</script>
					  <script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_suspended_1_%value $index%.submit();">Yes (not&nbsp;connected)</a>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended&webMethods-wM-AdminUI=true">Yes (not&nbsp;connected)</a>');
								}
								else {
									document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended">Yes (not&nbsp;connected)</a>');
								}
							}
						</script>
					  &nbsp;</td>
                    %else%
                      <script>writeTD("rowdata");</script>
					  <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_suspended_1_%value $index%.submit();">Yes (%value runtimeState/state%)</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended&webMethods-wM-AdminUI=true">Yes (%value runtimeState/state%)</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended">Yes (%value runtimeState/state%)</a>');
							}
						}
					</script>
					  &nbsp;</td>
                    %endif%
                  %endif%
                
                %else% <!-- else suspended-temp -->
	              <script>writeTD("rowdata");</script>
				  <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_active_%value $index%.submit();">No</a>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=active&webMethods-wM-AdminUI=true">No</a>');
						}
						else {
							document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setRetrievalStatus=active">No</a>');
						}
					}
				</script>
				  *</td>
                %endif%
                %endif%
                %endif%    
              %endif%   
              %endif%          
              %else%
              <script>writeTD("rowdata-l");</script>N/A</td>
            %endif%  
            
            %ifvar retrievalStatus/state matches('active*')%
              %ifvar properties/queueCapacity vequals(properties/queueCapacityThrottle)%
                <script>writeTD("row-l");</script>%value properties/queueCapacity encode(html)%</td>
              %else%
                <script>writeTD("row-l");</script>%value properties/queueCapacityThrottle encode(html)%&nbsp;(%value properties/queueCapacity encode(html)%)</td>
              %endif%   
            %else%
              <script>writeTD("row-l");</script>0&nbsp;(%value properties/queueCapacity encode(html)%)</td> 
            %endif%
            
            <script>writeTD("row-l");</script>%value processingStatus/volatileQueueCount encode(html)%</td> 
            
            %endif%
 
            
            <!-- ------------------------ -->
            <!-- Document Processing info -->
            <!-- ------------------------ -->
            
			<script>
			createForm("htmlform_trigger_management_edit_state_process_state_suspended_%value $index%", "trigger-management-edit-state.dsp", "POST", "BODY");
			setFormProperty("htmlform_trigger_management_edit_state_process_state_suspended_%value $index%", "triggerName", "%value name encode(html_javascript)%");
			setFormProperty("htmlform_trigger_management_edit_state_process_state_suspended_%value $index%", "setProcessingStatus", "suspended");
			
			createForm("htmlform_trigger_management_edit_state_process_state_active_%value $index%", "trigger-management-edit-state.dsp", "POST", "BODY");
			setFormProperty("htmlform_trigger_management_edit_state_process_state_active_%value $index%", "triggerName", "%value name encode(html_javascript)%");
			setFormProperty("htmlform_trigger_management_edit_state_process_state_active_%value $index%", "setProcessingStatus", "active");
			
			
			</script>
            %ifvar processingStatus/state -notempty%
                %ifvar processingStatus/state equals('active')%
                
                  %ifvar lastError -notempty%
                    <script>writeTD("rowdata");</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_process_state_suspended_%value $index%.submit();">Yes</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=suspended&webMethods-wM-AdminUI=true">Yes</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=suspended">Yes</a>');
							}
						}
					</script>
					&nbsp;</td>
                  %else%
                    <script>writeTD("rowdata");</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_process_state_suspended_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=suspended&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=suspended"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
							}
						}
					</script>
					&nbsp;</td>
                  %endif%

                %else% %ifvar processingStatus/state equals('active-temp')%
                <script>writeTD("rowdata");</script>
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_process_state_suspended_%value $index%.submit();"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=suspended&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
						}
						else {
							document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=suspended"><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</a>');
						}
					}
				</script>
				*</td>
                %else% %ifvar processingStatus/state equals('suspended')%
	              <script>writeTD("rowdata");</script>
				  <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_process_state_active_%value $index%.submit();">No</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=active&webMethods-wM-AdminUI=true">No</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=active">No</a>');
							}
						}
					</script>
				  &nbsp;</td>
                  
              %else% %ifvar processingStatus/state equals('suspended-disabled')%
	              <script>writeTDnowrap("rowdata");</script>
				  <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_process_state_active_%value $index%.submit();">No (not&nbsp;connected)</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=active&webMethods-wM-AdminUI=true">No (not&nbsp;connected)</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=active">No (not&nbsp;connected)</a>');
							}
						}
					</script>
				  &nbsp;</td>
                %else% %ifvar processingStatus/state equals('active-disabled')%
	              <script>writeTDnowrap("rowdata");</script>
				  <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_process_state_suspended_%value $index%.submit();">Yes (not&nbsp;connected)</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=suspended&webMethods-wM-AdminUI=true">Yes (not&nbsp;connected)</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=suspended">Yes (not&nbsp;connected)</a>');
							}
						}
					</script>
				  &nbsp;</td>
                
              %else% <!-- else suspended-temp -->
	              <script>writeTD("rowdata");</script>
				  <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_edit_state_process_state_active_%value $index%.submit();">No</a>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=active&webMethods-wM-AdminUI=true">No</a>');
							}
							else {
								document.write('<a href="trigger-management-edit-state.dsp?triggerName=%value name encode(url)%&setProcessingStatus=active">No</a>');
							}
						}
					</script>
				  *</td>
                %endif%
                %endif%
                %endif%
                %endif%
                %endif%
              %else%
              <script>writeTD("rowdata-l");</script>N/A</TD>
            %endif%   
            
            %ifvar properties/isConcurrent equals('true')%
              <script>writeTD("row-l");</script>Concurrent</td>
              %ifvar processingStatus/state matches('active*')%
                %ifvar properties/maxExecutionThreads vequals(properties/maxExecutionThreadsThrottle)%
                  <script>writeTD("row-l");</script>%value properties/maxExecutionThreads encode(html)%</td>
                %else%
                  <script>writeTD("row-l");</script>%value properties/maxExecutionThreadsThrottle encode(html)%&nbsp;(%value properties/maxExecutionThreads encode(html)%)</td>
                %endif%
              %else%
                <script>writeTD("row-l");</script>0&nbsp;(%value properties/maxExecutionThreads encode(html)%)</td> 
              %endif%
            %else%
              <script>writeTD("row-l");</script>Serial</td>
              %ifvar processingStatus/state matches('active*')%
                <script>writeTD("row-l");</script>1</td>
              %else%
                <script>writeTD("row-l");</script>0 (1)</td>
              %endif%
            %endif%
           
            <script>writeTD("row-l");</script>%value processingStatus/activeThreadCount encode(html)%</td>
            
          </tr>
          
          
          %ifvar lastError -notempty%
            <script>writeTDspan("row-l", 10);</script>
              <font color="red">%value lastError encode(html)%</font><br> 
            </td>
          %endif%
          
          <script>swapRows();</script>
          %endloop%

        </tbody>
      </table>
    </tr>
    
    <tr>
    %onerror%
      <script>this_writeMessage("%value errorMessage encode(html_javascript)%");</script>
      <script>setMessageFlag(true);</script>
    %endinvoke%
    </td>  
    
  </tbody></table>
  <br><br>
</body>
</html>