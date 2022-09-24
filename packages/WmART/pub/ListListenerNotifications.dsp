%comment%----- Lists Polling Notifications -----%endcomment%

<HTML>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <TITLE>Polling Notifications</title>
    <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css"></link>
	<link rel="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></link>
    
    <SCRIPT LANGUAGE="JavaScript">
      function confirmDisable (aliasName)
      {
         var s1 = "OK to disable the `"+aliasName+"' Notification?\n\n";
         return confirm (s1);
      }
      function confirmEnable (aliasName)
      {
         var s1 = "OK to enable the `"+aliasName+"' Notification?\n\n";
         return confirm (s1);
      }      
      function confirmForce (aliasName)
      {
         var s1 = "OK to force the `"+aliasName+"' Notification to disabled status?\n\n";
         return confirm (s1);
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
    </SCRIPT>
            <script src="connectionfilter.js"></script>
    <SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
	<SCRIPT SRC="csrfGuard.js"></SCRIPT>
</head>
%invoke wm.art.admin:getAdapterTypeOnlineHelp%
%onerror%
%endinvoke%
%invoke wm.art.admin:retrieveAdapterTypeData%
%onerror%
%endinvoke%

%invoke wm.art.ns:saveUserForSynchronousNotification%
%onerror%
%endinvoke%
<BODY onLoad="setNavigation('ListListenerNotifications.dsp', '%value encode(javascript) helpsys%', 'foo');showHideFilterCriteria('searchListenerNotificationName');">
<form id="myform" name="form" action="ListListenerNotifications.dsp" method="POST">  
<input type='hidden' name="adapterTypeName" value="%value -urlencode adapterTypeName%"> </input>
<input type='hidden' name="_nodeName" id="_nodeName" value=""> </input>
<table width="100%">  
    <tr>
       	<td class="breadcrumb" colspan=5>Adapters &gt; %value displayName% &gt; Listener Notifications</TD>
    </tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    %comment%
    -- If we arrive at this page because of an enable/disable request, or an edit save, the
    -- action field will be set, we perform the requested action before refreshing the page.
    %endcomment%
      
    %ifvar action%
        %switch action%
        %case 'enableNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
                <TR><TD class="message" colspan="2">
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </td></tr>
            %endinvoke%
        %case 'disableNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
                <TR><TD class="message" colspan="2">
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
        %case 'forceNotification'%
    %comment%
            %invoke wm.art.admin:forceNotificationDisable%
            %onerror%
                <TR><TD class="message" colspan="2">
               
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </td></tr>
            %endinvoke%
    %endcomment%
        %endswitch%
    %endif%

	%ifvar eventaction%
        %switch eventaction%
        %case 'enablePublish'%
            %invoke wm.art.admin:setPublishEventStatus%
            %onerror%
                <TR><TD class="message" colspan="2">
                
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                 </td></tr>
            %endinvoke%
        %case 'disablePublish'%
            %invoke wm.art.admin:setPublishEventStatus%
            %onerror%
                <TR><TD class="message" colspan="2">
               
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </td></tr>
            %endinvoke%
        %endswitch%
    %endif%
	
    %comment% When we arrive here, we start generating the tabular list of notifications %endcomment%  
    <tr>
                <td colspan=2>
                    <ul>
                         <li id="showfew" name="showfew"><a href="javascript:showFilterPanel(true)">Filter Listener Notifications</a></li>
                	 <li style="display:none" id="showall" name="showall"><a id="show_all_listener_notifications" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS">Show All Listener Notifications</a>
					 <script>updateURL("show_all_listener_notifications", "Show All Listener Notifications");</script>
					 </li>
                	 <DIV id="filterContainer" name="filterContainer" style="display:none;padding-top=2mm;">
			 	<br>
			 		<table>
			 		<tr valign="top">
			 		<td>
						<span>Filter criteria</span><br>
						<input id="searchListenerNotificationName" name="searchListenerNotificationName" value="%value -urldecode searchListenerNotificationName%" onkeydown="return processKey(event)" />
			 		</td>
			 		<td>
			 			<br>
			 				<input id="submitButton" name="Submit" type="submit" value="Submit" width="15" height="15" onClick="validateSearchCriteria('searchListenerNotificationName');return false;"/>                                        
			 			</br>
			 		</td> 
			 		</tr>
			 		</table>
			 	</br>  
                	</DIV>
                    </ul>
                </td>
            </tr>


        <tr>
            <td>
<table class="tableView" width="100%">

    <TR>
        <td class="heading" colspan=4>%value displayName% Listener Notifications</td>
    </tr>
    <tr class="subheading2">
        <td class="oddcol-l">Notification Name<a id="ascLN" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=LN&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15"></a>
		<script>updateURL("ascLN", '<img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15">');</script>
            		<a id="desLN" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=LN&DES=true&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16"></a>
					<script>updateURL("desLN", '<img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16">');</script>
					</td>
        <td class="oddcol-l">Package Name<a id="ascPN" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=PN&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15"></a>
		<script>updateURL("ascPN", '<img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15">');</script>
            		<a id="desPN" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=PN&DES=true&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16"></a>
					<script>updateURL("desPN", '<img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16">');</script>
					</td>        
        %invoke wm.art.ns:adapterEnabledForListenerNotificationUser%
        	%ifvar adapterEnabledForLNUser equals('true')%
        		<td class="oddcol-l">Run As User<a id="ascRunAsUser" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=RunAsUser&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15"></a>
				<script>updateURL("ascRunAsUser", '<img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15">');</script>
            		<a id="desRunAsUser" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=RunAsUser&DES=true&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16"></a>
					<script>updateURL("desRunAsUser", '<img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16">');</script>
					</td> 
        	%endif%
        	%onerror%
		%endinvoke%    		
        <td class="oddcol">Enabled<a id="ascStatus" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=EN&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15"></a>
		<script>updateURL("ascStatus", '<img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15">');</script>
            		<a id="desStatus" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=EN&DES=true&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16"></a>
					<script>updateURL("desStatus", '<img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16">');</script>
					</td>
		<td class="oddcol">Publish Events</td>					
    </tr>
	%ifvar adapterEnabledForLNUser equals('true')%
    %comment% Get list of notifications that match our type %endcomment%
    %invoke wm.art.admin:retrieveListenerNotifications%
    %comment% if we have notifications, loop over response, constructing output table %end%
    %ifvar notificationDataList -notempty%
        %loop notificationDataList%
            <tr>
            <script>writeTD('rowdata-l');</script>
            %value notificationNodeName% </td>
            <script>writeTD('rowdata-l');</script>
            %value packageName% </td>
            
            
            	<script>writeTD('rowdata-l');</script>
		%switch synchronousNotification%
		%case 'yes'%
		
		    %switch notificationEnabled%
		    %case 'yes'%
			    %value serviceUser% </td>
			%case 'pendingInitialization'
				Pending Initialization </td>
		    %case 'no'%
		      <SCRIPT>
				function callback(val,nodeID){      	    
				document.getElementById(nodeID).value=val;
				if(nodeID.endsWith(".dsp"))
                {
                    document.getElementById('_nodeName').value=nodeID.replace(".dsp", "");
                }
                else 
                {
                    document.getElementById('_nodeName').value=nodeID;
                }
                //document.getElementById('_nodeName').value=nodeID;
                document.getElementById('myform').submit();
				}
		      </SCRIPT>		    

			    <!--  RUN AS USER SUB CHANGES START-->

				<input name='%value notificationNodeName%' id="%value notificationNodeName%.dsp" size=12 value="%value serviceUser%"></input>
				<link rel="stylesheet" type="text/css" href="../WmRoot/subUserLookup.css" />
				<script type="text/javascript" src="../WmART/subUserLookup.js"></script>
				<a class="submodal" href="../WmART/subUserLookup.dsp?notificationNodeName=%value notificationNodeName%"><img border=0 align="bottom" src="../WmRoot/icons/magnifyglass.gif"/></a> 
				<!--  RUN AS USER SUB END-->	    	
			</td>
		    %endswitch%	    
                %case 'no'%
		</td>
		%endswitch%
	                
            <script>writeTD('rowdata');</script>
            %switch notificationEnabled%
            %case 'yes'%
                <a id="listener_notification_status%value $index%" href="../WmART/ListListenerNotifications.dsp?action=disableNotification&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&notificationEnabled=yes&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                ONCLICK="return confirmDisable('%value notificationNodeName%');">
                <img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes</a>
				<script>updateURL("listener_notification_status%value $index%", '<img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes');</script>
				</td>
            %case 'no'%
                <a id="listener_notification_status%value $index%" href="../WmART/ListListenerNotifications.dsp?action=enableNotification&notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                 ONCLICK="return confirmEnable('%value notificationNodeName%');">       
                 <img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No</a>
				 <script>updateURL("listener_notification_status%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No');</script>
				 </td>
            
			%case 'pendingInitialization'%
                    Pending Initialization
                 </td>
				 
			%case 'pending'%         
                <a id="listener_notification_status%value $index%" href="../WmART/ListListenerNotifications.dsp?action=forceNotification&notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                 ONCLICK="return confirmForce('%value notificationNodeName%');">       
                 <img src="../WmRoot/images/blank.gif" border=0 alt="Pending disable">Pending disable</a>
				 <script>updateURL("listener_notification_status%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Pending disable">Pending disable');</script>
				 </td>
				 
			 	 
            %endswitch%</TD>
			
			<script>writeTD('rowdata');</script>
            %ifvar notificationEvent equals('true')%
                <a id="listener_notification_event%value $index%" href="../WmART/ListListenerNotifications.dsp?eventaction=disablePublish&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&notificationEnabled=yes&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                ONCLICK="return confirmEventDisable('%value notificationNodeName%');">
                <img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes</a>
				<script>updateURL("listener_notification_event%value $index%", '<img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes');</script>
            %else%
                <a id="listener_notification_event%value $index%" href="../WmART/ListListenerNotifications.dsp?eventaction=enablePublish&notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                 ONCLICK="return confirmEventEnable('%value notificationNodeName%');">       
                 <img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No</a>
				 <script>updateURL("listener_notification_event%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No');</script>
            %endif%   
            </td>
			
            </tr>
        %endloop%
    %else%
        <TR><TD>No Listener Notifications found</TD></TR>
    %endif%
    %onerror% 
            %ifvar localizedMessage%
                <tr><tds> Error encountered <pre>%value localizedMessage%</pre></td></tr>
            %else%
                %ifvar error%
                    <tr><td> Error encountered <pre>%value errorMessage%</pre></td></tr>
                %endif%
            %endif%
    %endinvoke%
     %else%
     %comment% Get list of notifications that match our type %endcomment%
    %invoke wm.art.admin:retrieveListenerNotifications%
    %comment% if we have notifications, loop over response, constructing output table %end%
    %ifvar notificationDataList -notempty%
        %loop notificationDataList%
            <tr>
            <script>writeTD('rowdata-l');</script>
            %value notificationNodeName% </td>
            <script>writeTD('rowdata-l');</script>
            %value packageName% </td>
            <script>writeTD('rowdata');</script>
            %switch notificationEnabled%
            %case 'yes'%
                <a id="listener_notification_enabled%value $index%" href="../WmART/ListListenerNotifications.dsp?action=disableNotification&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&notificationEnabled=yes&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                ONCLICK="return confirmDisable('%value notificationNodeName%');">
                <img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes</a>
				<script>updateURL("listener_notification_enabled%value $index%", '<img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes');</script>
				</td>
            %case 'no'%
                <a id="listener_notification_disabled%value $index%" href="../WmART/ListListenerNotifications.dsp?action=enableNotification&notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                 ONCLICK="return confirmEnable('%value notificationNodeName%');">       
                 <img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No</a>
				 <script>updateURL("listener_notification_disabled%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No');</script>
				 </td>
            
			%case 'pendingInitialization'%
                    Pending Initialization
                 </td>
				 
			%case 'pending'%         
                <a id="listener_notification_pending%value $index%" href="../WmART/ListListenerNotifications.dsp?action=forceNotification&notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                 ONCLICK="return confirmForce('%value notificationNodeName%');">       
                 <img src="../WmRoot/images/blank.gif" border=0 alt="Pending disable">Pending disable</a>
				 <script>updateURL("listener_notification_pending%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Pending disable">Pending disable');</script>
				 </td>
			 	 	 
            %endswitch%  </TD>       
				
			<script>writeTD('rowdata');</script>
            %ifvar notificationEvent equals('true')%
                <a id="listener_notification_evt_enabled%value $index%" href="../WmART/ListListenerNotifications.dsp?eventaction=disablePublish&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                ONCLICK="return confirmEventDisable('%value notificationNodeName%');">
                <img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes</a>
				<script>updateURL("listener_notification_evt_enabled%value $index%", '<img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes');</script>
            %else%
                <a id="listener_notification_evt_disabled%value $index%" href="../WmART/ListListenerNotifications.dsp?eventaction=enablePublish&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                 ONCLICK="return confirmEventEnable('%value notificationNodeName%');">       
                 <img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No</a>
				 <script>updateURL("listener_notification_evt_disabled%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No');</script>
            %endif%   
            </td>	
            </tr>
        %endloop%
    %else%
        <TR><TD  colspan=5>No Listener Notifications found</TD></TR>
    %endif%
    %onerror% 
            %ifvar localizedMessage%
                <tr><td colspan=4>Error encountered <pre>%value localizedMessage%</pre></td></tr>
            %else%
                %ifvar error%
                    <tr><td>Error encountered <pre>%value errorMessage%</pre></td></tr>
                %endif%
            %endif%
    %endinvoke%
     
    %endif%     

</table>
            </td>
        </tr>
</table>
	<div class="oddrowdata" id="goContainer" name="goContainer" style="display:none;padding-top=2mm;">
        	%ifvar pStart equals('1')%
			<label class="evenrowdata-l">
			Page (1-<script>writeTD('rowdata-l');</script>%value pageSize% )</td></label>
		%else%		
        		<a id="listener_notification_page_previous" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&prev=true&dspName=.LISTLISTENERNOTIFICATIONS">&laquo; Previous</a>
				<script>updateURL("listener_notification_page_previous", "&laquo; Previous");</script>
				&nbsp;<label class="evenrowdata-l">Page (1-
				<script>writeTD('rowdata-l');</script>%value pageSize% )</label></td>
		%endif%	
			<input type="text" name="pageNumber" value="%value pStart%" size="1" onkeypress="return isNumberKey(this.form,event);">&nbsp;<input type="submit" name="Go" value="Go" onClick="jumpToPage(this);return false;">
			%ifvar pStart vequals(pageSize)%			
				<!-- Next -->
		%else%
			<a id="listener_notification_page_next" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&prev=false&dspName=.LISTLISTENERNOTIFICATIONS">Next &raquo;</a>
			<script>updateURL("listener_notification_page_next", "Next &raquo;");</script>
		%endif%		
	</div>
      
	<div class="oddrowdata" id="paginationContainer" name="paginationContainer" style="display:;padding-top=2mm;">

	%ifvar pStart equals('1')%
	%else%
		<a id="listener_notification_page_no_previous" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&prev=true&dspName=.LISTLISTENERNOTIFICATIONS">&laquo; Previous</a>   
		<script>updateURL("listener_notification_page_no_previous", "&laquo; Previous");</script>
	%endif%
	%loop totalNosOfPages%
		%ifvar totalNosOfPages -notempty%           		
		<a id="listener_notification_page_no_%value $index%" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&pageNumber=%value -urlencode totalNosOfPages%&dspName=.LISTLISTENERNOTIFICATIONS">
		%ifvar totalNosOfPages vequals(/pStart)% 
		</a><script>updateURL("listener_notification_page_no_%value $index%", "");</script>
		<label class="evenrowdata-l">%value totalNosOfPages%</label>
	%else%
		%ifvar totalNosOfPages equals('...')%
			</a><script>updateURL("listener_notification_page_no_%value $index%", "");</script>
			<a href="javascript:showHidePageCriteria()">%value totalNosOfPages%</a>
	%else%
		%value totalNosOfPages%</a><script>updateURL("listener_notification_page_no_%value $index%", "%value totalNosOfPages%");</script>
		%endif%
		%endif%	
		%else%
		%value pStart%
	%endif%	
        %endloop%							
	%ifvar pStart vequals(pageSize)%			
		
	%else%
		<a id="listener_notification_page_no_next" href="../WmART/ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&prev=false&dspName=.LISTLISTENERNOTIFICATIONS">Next &raquo;</a>
		<script>updateURL("listener_notification_page_no_next", "Next &raquo;");</script>
	%endif%		
	</div>
	<input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
	<input type="hidden" name="searchListenerNotificationName" value="%value searchListenerNotificationName%">     	
	<input type="hidden" name="pStart" value="%value pStart%">
	<input type="hidden" name="totalNosOfPages" value="%value totalNosOfPages%">
    	<input type="hidden" name="pageNumber" value="%value pageNumber%">
    	<input type="hidden" value="" name="sortCriteria">
    	<input type="hidden" name="pageSize" value="%value pageSize%">
    	<input type="hidden" value="%value pageLabel%" name="pageLabel">
</form>
</body>
</HTML>