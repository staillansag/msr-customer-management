%comment%----- Lists Polling Notifications -----%endcomment%

<HTML>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <TITLE>Polling Notifications</title>
    <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css"></link>
	<link rel="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></link>
    <script src="connectionfilter.js"></script>
    <SCRIPT LANGUAGE="JavaScript">
      function doSelect(action,aliasName)
      {
      		var s1 = null;
      		if(action =='enableNotification')
      		{
		         s1 = "OK to enable the `"+aliasName+"' Notification?\n\n";
      		} 
      		else if(action =='disableNotification')
      		{
		         s1 = "OK to disable the `"+aliasName+"' Notification?\n\n";
      		} 
      		else if(action =='suspendNotification')
      		{
		         s1 = "OK to suspend operations for the `"+aliasName+"' Notification?\n\n";
      		} 
      		else if(action =='resumeNotification')
      		{
		         s1 = "OK to resume operations for the `"+aliasName+"' Notification?\n\n";
      		} 
      		else if(action =='forceDisable')
      		{
		         s1 = "OK to force the `"+aliasName+"' Notification to disabled status?\n\n";
      		} 
      		else if(action =='forceSuspend')
      		{
		         s1 = "OK to force the `"+aliasName+"' Notification to suspended status?\n\n";
      		} 
      		if(s1 == null)
      		{
      			alert("Script Error!");
      			return false;
      		}
      		else
      		{
	      		if(confirm (s1))
	      		{
	      			return(action);
	      		}
	      		else
	      		{
	      			return false;
	      		}
      		}
      }
	  function confirmEventDisable (aliasName)
      {
         var s1 = "OK to disable Publish Events for the `"+aliasName+"' Notification?\n\n";
         return confirm (s1);
      }
	  function confirmEventEnable (aliasName)
      {
         var s1 = "OK to enable Publish Events for the `"+aliasName+"' Notification?\n\n";
         return confirm (s1);
      }
	  
	  function submitFormOnSelect (formId, action, aliasName, url)
      {
         var confirmSelection = doSelect(action, aliasName);
         var formElem = document.getElementById(formId);
		 if(formElem)
		 {
			formElem['action'].setAttribute("value", confirmSelection);
			formElem.submit();
			return;
		 }
		 window.location.href= url + confirmSelection;
      }
    </SCRIPT>
    
    <SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
	<SCRIPT SRC="csrfGuard.js"></SCRIPT>
</head>
%invoke wm.art.admin:getAdapterTypeOnlineHelp%
%onerror%
%endinvoke%
%invoke wm.art.admin:retrieveAdapterTypeData%
%onerror%
%endinvoke%

%invoke wm.art.ns:saveUserForPollingNotification%
%onerror%
%endinvoke%

<BODY onLoad="setNavigation('ListPollingNotifications.dsp', '%value encode(javascript) helpsys%', 'foo');showHideFilterCriteria('searchNotificationName');">
<form name="form" id="myform" action="ListPollingNotifications.dsp" method="POST">
<table width="100%">  
<input type='hidden' name="adapterTypeName" value="%value -urlencode adapterTypeName%"> </input>
<input type='hidden' name="_nodeName" id="_nodeName" value=""> </input>   

    <tr>
       	<td class="breadcrumb" colspan=7>Adapters &gt; %value displayName% &gt; Polling Notifications</TD>
    </tr>
        
    %comment%
    -- If we arrive at this page because of an enable/disable request, or an edit save, the
    -- action field will be set, we perform the requested action before refreshing the page.
    %endcomment%
      
    %ifvar action%
        %switch action%
        %case 'enableNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
				<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
               
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </td></tr>
            %endinvoke%
        %case 'disableNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </td></tr>
            %endinvoke%
        %case 'edit'%
            %invoke wm.art.admin:setNotificationSchedule%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
            %invoke wm.art.admin:setNotificationClusterSettings%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
               
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%            
        %case 'forceDisable'%
            %invoke wm.art.admin:forceNotificationDisable%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
        %case 'forceSuspend'%
            %invoke wm.art.admin:forceNotificationSuspend%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </td></tr>
            %endinvoke%
        %case 'suspendNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
        %case 'resumeNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
               
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
        %case 'suspendAllEnabled'%
            %invoke wm.art.admin:suspendAllPollingNotifications%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
        %case 'enableAllSuspended'%
            %invoke wm.art.admin:resumeAllPollingNotifications%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </td></tr>
            %endinvoke%
        %endswitch%
    %endif%
	
	%ifvar eventaction%
        %switch eventaction%
        %case 'enablePublish'%
            %invoke wm.art.admin:setPublishEventStatus%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
        %case 'disablePublish'%
            %invoke wm.art.admin:setPublishEventStatus%
            %onerror%
			<tr><td colspan=8>&nbsp;</td></tr>
                <TR><TD class="message" colspan=5>
               
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
        %endswitch%
    %endif%

    %comment% When we arrive here, we start generating the tabvular list of notifications %endcomment%  
    <TR>
        <td>
            <ul>
    		    <li>
                    <a id="suspend_all_enabled_notifications" href="../WmART/ListPollingNotifications.dsp?&adapterTypeName=%value -urlencode adapterTypeName%&action=suspendAllEnabled">
		    	        Suspend all enabled</a>
					<script>updateURL("suspend_all_enabled_notifications", "Suspend all enabled");</script>
		    	</li>
                <li>
                    <a id="enable_all_suspended_notifications" href="../WmART/ListPollingNotifications.dsp?&adapterTypeName=%value -urlencode adapterTypeName%&action=enableAllSuspended">
                        Enable all suspended</a>
					<script>updateURL("enable_all_suspended_notifications", "Enable all suspended");</script>
                </li>
                <li id="showfew" name="showfew"><a href="javascript:showFilterPanel(true)">Filter Polling Notifications</a></li>
                <li style="display:none" id="showall" name="showall">
				<a id="show_all_polling_notifications" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTPOLLINGNOTIFICATIONS">Show All Polling Notifications</a>
				<script>updateURL("show_all_polling_notifications", "Show All Polling Notifications");</script>
				</li>
            	<DIV id="filterContainer" name="filterContainer" style="display:none;padding-top=2mm;">
	                     <br>
	                      <table>
	    			<tr valign="top">
	    			<td>
	                        	<span>Filter criteria</span><br>
	                        	<input id="searchNotificationName" name="searchNotificationName" value="%value -urldecode searchNotificationName%" onkeydown="return processKey(event)" />
	    			</td>
	    			<td>
	                         	<br>
                     		<input id="submitButton" name="Submit" type="submit" value="Submit" width="15" height="15" onClick="validateSearchCriteria('searchNotificationName');return false;"/>                                                             
	                         	</br>
	                        </td> 
	                      </tr>
	                   </table>
	              </br>  
                </DIV>
            </ul>    
	    </td>
    </TR>
        %comment% Get list of notifications that match our type %endcomment%
    %invoke wm.art.admin:retrievePollingNotifications%
    <tr>
        <td colspan=8 align="right">
        	<label class="evenrowdata-l">%value pageLabel%</label>
        </td>
    </tr>

        <tr>
            <td>
<table class="tableView" width="100%">

    <TR>
        <td class="heading" colspan=7>%value displayName% Polling Notifications</td>
    </tr>
    <tr class="subheading2">
        <td class="oddcol-l">Notification Name<a id="ascNN" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&sort=NN&dspName=.ListPollingNotifications"><img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15"></a>
		<script>updateURL("ascNN", '<img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15">');</script>
            <a id="desNN" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&sort=NN&DES=true&dspName=.LISTPOLLINGNOTIFICATIONS"><img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16"></a>
			<script>updateURL("desNN", '<img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16">');</script>
			</td>
        <td class="oddcol-l">Package Name<a id="ascPN" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&sort=PN&dspName=.LISTPOLLINGNOTIFICATIONS"><img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15"></a>
		<script>updateURL("ascPN", '<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">');</script>
            <a id="desPN" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&sort=PN&DES=true&dspName=.LISTPOLLINGNOTIFICATIONS"><img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="15"></a>
			<script>updateURL("desPN", '<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="15">');</script>
			</td>        
        <td class="oddcol">State<a id="ascState" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&sort=State&dspName=.LISTPOLLINGNOTIFICATIONS"><img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15"></a>
		<script>updateURL("ascState", '<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">');</script>
            <a id="desState" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&sort=State&DES=true&dspName=.LISTPOLLINGNOTIFICATIONS"><img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="15"></a>
			<script>updateURL("desState", '<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="15">');</script>
			</td>
        <td class="oddcol">Edit Schedule</td>
        <td class="oddcol">View Schedule</td>
		<td class="oddcol">Publish Events</td>
		<td class="oddcol">Run As User</td>
    </tr>

	
    %comment% if we have notifications, loop over response, constructing output table %end%
    %ifvar notificationDataList -notempty%
        %loop notificationDataList%
            <tr>
			<script>createFormAndSetProperties("notification_state_change_%value $index%", '../WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchNotificationName=%value -urlencode searchNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action=false', "POST", "BODY");</script>
            <script>writeTD('rowdata-l');</script>
            %value notificationNodeName% </td>
            <script>writeTD('rowdata-l');</script>
            %value packageName% </td>
            <script>writeTD('rowdata');</script>
            %switch notificationEnabled%
	            %case 'yes'%
	              <SELECT ONCHANGE="submitFormOnSelect('notification_state_change_%value $index%', this.value, '%value notificationNodeName%', '../WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchNotificationName=%value -urlencode searchNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action=');">
	              	<OPTION SELECTED VALUE=none><img src="../WmRoot/images/green_check.gif" height=13 width=13 border=0>Enabled</OPTION>
	              	<OPTION VALUE=disableNotification>Disabled</OPTION>
	              	<OPTION VALUE=suspendNotification>Suspended</OPTION>
	              </SELECT>
	            %case 'no'%
	              <SELECT ONCHANGE="submitFormOnSelect('notification_state_change_%value $index%', this.value, '%value notificationNodeName%', '../WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchNotificationName=%value -urlencode searchNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action=');">
	              	<OPTION SELECTED VALUE=none>Disabled</OPTION>
	              	<OPTION VALUE=enableNotification>Enabled</OPTION>
	              </SELECT>
	            %case 'unsched'%
	              <SELECT DISABLED>
	              	<option>Disabled</option>
	              </select>
	            %case 'pending'%         
	              <SELECT ONCHANGE="submitFormOnSelect('notification_state_change_%value $index%', this.value, '%value notificationNodeName%', '../WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchNotificationName=%value -urlencode searchNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action=');">
	              	<OPTION SELECTED VALUE=none>Pending Disable</OPTION>
	              	<OPTION VALUE=forceDisable>Disabled</OPTION>
	              </SELECT>
	            %case 'pendingSuspend'%         
	              <SELECT ONCHANGE="submitFormOnSelect('notification_state_change_%value $index%', this.value, '%value notificationNodeName%', '../WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchNotificationName=%value -urlencode searchNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action=');">
	              	<OPTION SELECTED VALUE=none>Pending Suspend</OPTION>
	              	<OPTION VALUE=forceSuspend>Suspend</OPTION>
	              </SELECT>
	            %case 'suspended'%         
	              <SELECT ONCHANGE="submitFormOnSelect('notification_state_change_%value $index%', this.value, '%value notificationNodeName%', '../WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchNotificationName=%value -urlencode searchNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action=');">
	              	<OPTION SELECTED VALUE=none>Suspended</OPTION>
	              	<OPTION VALUE=resumeNotification>Enabled</OPTION>
	              	<OPTION VALUE=disableNotification>Disabled</OPTION>
	              </SELECT>
	            %case 'pendingInitialization'%
                        Pending Initialization
            %endswitch%</TD>

            <script>writeTD('rowdata');</script>
            %ifvar notificationEnabled equals('yes')%
                <img src="../WmART/icons/disabled_edit.gif" alt="Edit" border=0>
            %else%
            	%ifvar notificationEnabled equals('pendingInitialization')%
                	<img src="../WmART/icons/disabled_edit.gif" alt="Edit" border=0>
                %else%	
	                %ifvar notificationEnabled equals('pending')%
	                    <img src="../WmART/icons/disabled_edit.gif" alt="Edit" border=0>
	                %else%                             
	                    <a id="notification_schedule_edit%value $index%" href="../WmART/PollingNotificationDetails.dsp?readOnly=false&adapterTypeName=%value -urlencode ../adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&notificationNodeName=%value -urlencode notificationNodeName%&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">
	                    <img src="../WmART/icons/config_edit.gif" alt="Edit" border=0>
	                %endif%
	           %endif%     
            %endif%
     
            </a><script>updateURL("notification_schedule_edit%value $index%", '<img src="../WmART/icons/config_edit.gif" alt="Edit" border=0>');</script></td>

            <script>writeTD('rowdata');</script>
            %ifvar notificationEnabled equals('unsched')%
                <img src="../WmART/icons/view-disabled.gif" alt="View" border=0>
            %else%
                <a id="notification_schedule_view%value $index%" href="../WmART/PollingNotificationDetails.dsp?readOnly=true&adapterTypeName=%value -urlencode ../adapterTypeName%&notificationNodeName=%value -urlencode notificationNodeName%&searchNotificationName=%value -urlencode searchNotificationName%&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">
                <img src="../WmRoot/icons/file.gif" alt="View" border=0></a>
				<script>updateURL("notification_schedule_view%value $index%", '<img src="../WmRoot/icons/file.gif" alt="View" border=0>');</script>         
            %endif%   
            </td>
			
			<script>writeTD('rowdata');</script>
            %ifvar notificationEvent equals('true')%
                <a id="notification_event%value $index%" href="../WmART/ListPollingNotifications.dsp?eventaction=disablePublish&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTPOLLINGNOTIFICATIONS"
                ONCLICK="return confirmEventDisable('%value notificationNodeName%');">
                <img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes</a>
				<script>updateURL("notification_event%value $index%", '<img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes');</script>
            %else%
                <a id="notification_event%value $index%" href="../WmART/ListPollingNotifications.dsp?eventaction=enablePublish&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTPOLLINGNOTIFICATIONS"
                 ONCLICK="return confirmEventEnable('%value notificationNodeName%');">       
                 <img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No</a>
				 <script>updateURL("notification_event%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No');</script>
            %endif%   
            </td>

			<script>writeTD('rowdata');</script>
				
				%switch runASUserEditable%
			%case 'false'%
					%value runASUser%
			%case 'true'%
			  <SCRIPT>
				function callback(val,nodeID){
					if(is_csrf_guard_enabled && needToInsertToken)
					{
						nodeID += ".dsp";
					}
					document.getElementById(nodeID).value=val;
					document.getElementById('_nodeName').value=nodeID;
					document.getElementById('myform').submit();
				}
				
				
			
    </SCRIPT>
			  </SCRIPT>             

					<!--  RUN AS USER SUB CHANGES START-->

						<input name='%value notificationNodeName%.dsp' id="%value notificationNodeName%.dsp" size=12 value="%value runASUser%"></input>
						<link rel="stylesheet" type="text/css" href="../WmRoot/subUserLookup.css" />
						<script type="text/javascript" src="../WmART/subUserLookup.js"></script>
						<a id="runASUser" class="submodal" href="../WmART/subUserLookup.dsp?notificationNodeName=%value notificationNodeName%">
						<img src="../WmRoot/icons/magnifyglass.png" align="bottom" border="0">
						</a> 
						<!-- <script>updateURL("runASUser", '<img src="../WmRoot/icons/magnifyglass.png" align="bottom" border="0">');</script> -->
						<!--  RUN AS USER SUB END-->            
				%endswitch%     </td>
 	                      			
            </tr>
        %endloop%
    %else%
        <TR><TD colspan=7>No Polling Notifications found</TD></TR>
    %endif%
    %onerror% 
            %ifvar localizedMessage%
                <tr><td class="message">Error encountered <pre class="wordwrap">%value localizedMessage%</pre></td></tr>
            %else%
                %ifvar error%
                    <tr><td class="message">Error encountered <pre class="wordwrap">%value errorMessage%</pre></td></tr>
                %endif%
            %endif%
    %endinvoke%
    
        </table>
            </td>
        </tr>
        </table>
	<div class="oddrowdata" id="goContainer" name="goContainer" style="display:none;padding-top=2mm;">
        	%ifvar pStart equals('1')%
			<label class="evenrowdata-l">
			Page (1-<script>writeTD('rowdata-l');</script>%value pageSize% )</td></label>
		%else%		
        		<a id="notification_page_previous" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&prev=true&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">&laquo; Previous</a>
				<script>updateURL("notification_page_previous", '&laquo; Previous');</script>
				&nbsp;<label class="evenrowdata-l">Page (1-
				<script>writeTD('rowdata-l');</script>%value pageSize% )</label></td>
		%endif%	
			<input type="text" name="pageNumber" value="%value pStart%" size="1" onkeypress="return isNumberKey(this.form,event);">&nbsp;<input type="submit" name="Go" value="Go" onClick="jumpToPage(this);return false;">
		%ifvar pStart vequals(pageSize)%			
				<!-- Next -->
		%else%
			<a id="notification_page_next" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&prev=false&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">Next &raquo;</a>
			<script>updateURL("notification_page_next", 'Next &raquo;');</script>
		%endif%		
	</div>
      
	<div class="oddrowdata" id="paginationContainer" name="paginationContainer" style="display:;padding-top=2mm;">
	%ifvar pStart equals('1')%
	%else%
		<a id="notification_page_no_previous" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&prev=true&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">&laquo; Previous</a> 
		<script>updateURL("notification_page_no_previous", '&laquo; Previous');</script>
	%endif%
	       %loop totalNosOfPages%
		%ifvar totalNosOfPages -notempty%         		
			<a id="notification_page_no_%value $index%" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&pageNumber=%value -urlencode totalNosOfPages%&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">
			%ifvar totalNosOfPages vequals(/pStart)% 
			</a >
			<script>updateURL("notification_page_no_%value $index%", "");</script>
			<label class="evenrowdata-l">%value totalNosOfPages%</label>
			%else%
			%ifvar totalNosOfPages equals('...')%
				</a>
				<script>updateURL("notification_page_no_%value $index%", "");</script>
				<a href="javascript:showHidePageCriteria()">%value totalNosOfPages%</a>
	         	%else%
			%value totalNosOfPages%</a><script>updateURL("notification_page_no_%value $index%", "%value totalNosOfPages%");</script>
			%endif%
		%endif%	
		%else%
		%value pStart%
	%endif%	
        %endloop%							
		%ifvar pStart vequals(pageSize)%			
						
		%else%
			<a id="notification_page_no_next" href="../WmART/ListPollingNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchNotificationName=%value -urlencode searchNotificationName%&prev=false&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">Next &raquo;</a>
			<script>updateURL("notification_page_no_next", "Next &raquo;");</script>
		%endif%	
	</div>
    	<input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
    	<input type="hidden" name="searchNotificationName" value="%value searchNotificationName%">     	
    	<input type="hidden" name="pStart" value="%value pStart%">
    	<input type="hidden" name="totalNosOfPages" value="%value totalNosOfPages%">
    	<input type="hidden" name="pageNumber" value="%value pageNumber%">
    	<input type="hidden" value="" name="sortCriteria">
    	<input type="hidden" name="pageSize" value="%value pageSize%">
    	<input type="hidden" value="%value pageLabel%" name="pageLabel">
     </form>	
</body>
</HTML>
