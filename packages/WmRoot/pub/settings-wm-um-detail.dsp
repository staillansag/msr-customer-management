<HTML>
<HEAD>


<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<SCRIPT SRC="webMethods.js"></SCRIPT>

<style>

.disabledLink
{
   color:#0D109B;
}

</style>  


</HEAD>

<BODY onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_UMDetailScrn');">
  
  
  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Universal Messaging Connection Alias</TD>
    </TR>
    
    %ifvar action equals('edit')%
      
        %invoke wm.server.messaging:updateConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
        </TR>
        <TR>
          <TD class="message" colspan=2>%value message encode(html)%</TD>
        </TR>
		
        %endinvoke%
    %endif%
    
    %invoke wm.server.messaging:getConnectionAliasReport%
    <TR>
      <TD colspan="2">
        <ul class="listitems">
          <li class="listitem">
		  <script>
		  createForm("htmlform_settings_wm_messaging", "settings-wm-messaging.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("settings-wm-messaging.dsp", "javascript:document.htmlform_settings_wm_messaging.submit();", "Return to webMethods Messaging Settings");</script>
		  
		  </li>
          
          %ifvar enabled equals('true')%
            <li class="listitem"><div class="disabledLink">Edit Universal Messaging Connection Alias</div></li>
          %else%
			<script>
			createForm("htmlform_settings_wm_um_edit", "settings-wm-um-edit.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_wm_um_edit", "aliasName", "%value aliasName encode(url)%");
			</script>
            <li class="listitem">
			<script>getURL("settings-wm-um-edit.dsp?aliasName=%value aliasName encode(url)%", "javascript:document.htmlform_settings_wm_um_edit.submit();", "Edit Universal Messaging Connection Alias");</script>
			
			</li>
          %endif%
        
        </UL>
      </TD>
    </TR>
    
    <tr>
      <td>
        <table class="tableView" width="85%">

          <form>
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                    
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>

          <!-- Connection Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" nowrap="true">Connection Alias Name</td>
            <td class="oddrowdata-l">%value aliasName encode(html)%</td>
          </tr>

          <!-- Enabled 
          <tr>
            <td class="evenrow-l">Enabled</td>
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">
                Yes%ifvar isConnected equals('false')%&nbsp;(Not Connected)%endif%
              </td>
          </tr>
          -->

          <!-- Description -->
          <tr>
            <td class="evenrow-l">Description</td>
            <td class="evenrowdata-l">%value description encode(html)%</td>
          </tr>
          
          <!-- Client Prefix -->
          <TR>
            <TD class="oddrow-l">Client Prefix</TD>
            <TD class="oddrowdata-l">%value CLIENTPREFIX encode(html)%</TD>
          </TR>
          
          <!-- Share Client Prefix -->
          <TR>
            <TD class="evenrow-l">Client Prefix Is Shared (prevents removal of shared messaging provider objects)</TD>
            <TD class="evenrowdata-l"> %ifvar isClientPrefixShared equals('true')% Yes %else% %ifvar isClientPrefixShared equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>
	  </table>
          
          <!--                     -->
          <!-- Connection Settings -->
          <!--                     -->
          
          <table class="tableView" width="85%">	  
          
          <tr>
            <td class="heading" colspan=2>Connection Settings</td>
          </tr>
	  <table class="tableView" width="85%">	  
          
    
          <!-- Realm URL -->
          <TR>
            <TD width="40%" class="oddrow-l">Realm URL</TD>
            <TD class="oddrowdata-l">%value um_rname encode(html)%</TD>
          </TR>

          <TR>
            <TD class="evenrow-l">Maximum Reconnection Attempts</TD>
            <TD class="evenrowdata-l">%value um_tryAgainMaxAttempts encode(html)%</TD>
          </TR>

	  </table>

          <!--                     -->
          <!-- Producer Settings   -->
          <!--                     -->
          
          <table class="tableView" width="85%">	  
          
          <tr>
            <td class="heading" colspan=2>Producer Settings</td>
          </tr>
          
    
          <!-- Enable CSQ -->
          <TR>
            <TD width="40%" class="oddrow-l">Enable CSQ</TD>
            <TD class="oddrowdata-l">
            %ifvar useCSQ equals('true')%
              Yes
            %else% %ifvar useCSQ equals('on')%
              Yes
            %else%
              No
            %endif%
            %endif%
            </TD>
          </TR>
          
          <!-- Maximum CSQ Size -->
          <TR>
            <TD class="evenrow-l">Maximum CSQ Size (messages)</TD>   
            <TD class="evenrowdata-l">%ifvar csqSize equals('-1')%[UNLIMITED]%else%%value csqSize encode(html)%%endif%</TD>
          </TR>
          
          <!-- Drain CSQ in Order -->
          <TR>
            <TD class="oddrow-l">Drain CSQ in Order</TD>
            <TD class="oddrowdata-l">
			%ifvar csqDrainInOrder equals('true')%
              Yes
            %else% %ifvar csqDrainInOrder equals('on')%
              Yes
            %else%
              No
            %endif%
            %endif%
			</TD>
          </TR>      
          
          <!-- Publish Wait Time (while reconnection) -->
          <TR>
            <TD class="evenrow-l">Publish Wait Time while Reconnecting (milliseconds)</TD>
            <TD class="evenrowdata-l">%value um_publishWaitTime encode(html)%</TD>
          </TR>
          
          <!-- Include All Envelope Data 
          <TR>
            <TD class="oddrow-l">Include All Envelope Fields</TD>
            <TD class="oddrowdata-l">%ifvar includeFullEnvelope equals('true')% Yes %else% %ifvar includeFullEnvelope equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>  -->
          
          <!-- Follow the Master -->
          <TR>
            <TD class="oddrow-l">Enable Follow the Master for Producers</TD>
            <TD class="oddrowdata-l">%ifvar um_followTheMasterForPublish equals('true')%Yes %else% %ifvar um_followTheMasterForPublish equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>
          
          </table>
	    
          <!--                     -->
          <!-- Consumer Settings   -->                         
          <!--                     -->
                          
	  <table class="tableView" width="85%">	  
          
          <tr>
            <td class="heading" colspan=2>Consumer Settings</td>
          </tr>         
        
          <!-- Request-Reply -->            
          <TR>
            <TD width="40%" class="oddrow-l">Enable Request-Reply Channel and Listener</TD>
            <TD class="oddrowdata-l">%ifvar enableRequestReply equals('true')% Yes %else% %ifvar enableRequestReply equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR> 
          
          <TR>
            <TD class="oddrow-l">Enable Follow the Master for Consumers</TD>
            <TD class="oddrowdata-l">%ifvar um_followTheMasterForSubscribe equals('true')%Yes %else% %ifvar um_followTheMasterForSubscribe equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>
          
	  </table>
          
	  <table class="tableView" width="85%">	  
          
          <!--                       -->  
          <!-- Client Authentication -->            
          <!--                       -->  
          
          <TR>
            <TD class="heading" colspan=2>Client Authentication Settings</TD>
          </TR> 

          <TR>
            <TD width="40%" class="evenrow-l">Client Authentication</TD>
            
            %ifvar clientAuthType equals('none')%
                  <TD class="evenrowdata-l">NONE</TD>
              %endif%
            %ifvar clientAuthType equals('ssl')%
                  <TD class="evenrowdata-l">CERTIFICATE BASED</TD>
              %endif%
            %ifvar clientAuthType equals('basic')%
                  <TD class="evenrowdata-l">USERNAME/PASSWORD</TD>
              %endif%
          </TR>        
          
        </TABLE>
        
        <table class="tableView" width="85%">	  
          
          <tr>
            <td class="heading" colspan=2>Enhanced Logging</td>     
          </tr>         
                                                                                        
          <TR>
            <TD width="40%" class="oddrow-l">Logging Type</TD>
            <TD class="oddrowdata-l">                                               
              %ifvar um_loggingOutput equals('0')%SERVER LOG%else%MESSAGING AUDIT LOG%endif%   
            </TD>
          </TR>          
          <TR>
            <TD width="40%" class="oddrow-l">Enable Producer Message ID Tracking</TD>
            <TD class="oddrowdata-l">%ifvar um_producerMessageTracking equals('true')% Yes %else% %ifvar um_producerMessageTracking equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR> 
          <TR>
            <TD class="oddrow-l">Producer Message ID Tracking: Include Channels (semicolon delimited)</TD>     
            <TD class="oddrowdata-l">
              %ifvar um_producerIncludedStrings -notempty%
                %value um_producerIncludedStrings encode(html)%
              %else%
                [ALL]
              %endif%
            </TD>      
          </TR> 
          
          <TR>
            <TD class="oddrow-l">Enable Consumer Message ID Tracking</TD>
            <TD class="oddrowdata-l">%ifvar um_consumerMessageTracking equals('true')%Yes %else% %ifvar um_consumerMessageTracking equals('on')% Yes %else% No %endif% %endif% </TD>
          </TR>
          <TR>
            <TD class="oddrow-l">Consumer Message ID Tracking: Include Triggers (semicolon delimited)</TD>
            <TD class="oddrowdata-l">
              %ifvar um_consumerIncludedStrings -notempty%
                %value um_consumerIncludedStrings encode(html)%
              %else%
                [ALL]
              %endif%
            </TD>
          </TR>
          
	      </table>
        
        
      </td>
    </TR>
  </TABLE>
  %endinvoke%
</BODY>
</HTML>
