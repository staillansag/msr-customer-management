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
</HEAD>

<BODY onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_BrokerDetailScrn');">

  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Broker Connection Alias</TD>
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
    
    %ifvar action equals('create')%
      
        %invoke wm.server.messaging:createConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
        </TR>
        <TR>
          <TD class="message" colspan=2>%value message encode(html)%</TD>
        </TR>
        %endinvoke%
    %endif%

    <TR>
      <TD colspan="2">
        <ul class="listitems">
		<script>
		createForm("htmlform_settings_wm_messaging", "settings-wm-messaging.dsp", "POST", "BODY");
		createForm("htmlform_settings_wm_broker_edit", "settings-wm-broker-edit.dsp", "POST", "BODY");
		setFormProperty("htmlform_settings_wm_broker_edit", "aliasName", "%value aliasName%");
		</script>
          <li class="listitem">
		  <script>getURL("settings-wm-messaging.dsp","javascript:document.htmlform_settings_wm_messaging.submit();","Return to webMethods Messaging Settings")</script></li>
          <li class="listitem">
		  <script>getURL("settings-wm-broker-edit.dsp?aliasName=%value aliasName encode(url)%","javascript:document.htmlform_settings_wm_broker_edit.submit();","Edit Broker Connection Alias")</script></li>
        </UL>
      </TD>
    </TR>
    
    <tr>
      <td>
        <table class="tableView" width="85%">

          <form>
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          
          %invoke wm.server.messaging:getConnectionAliasReport%
                    
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>

          <!-- Connection Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" nowrap="true" scope="row">Connection Alias Name</td>
            <td class="oddrowdata-l">%value aliasName encode(html)%</td>
          </tr>

          <!-- Enabled 
          <tr>
            <td class="evenrow-l">Enabled</td>
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="Connection Alias %value aliasName encode(html)% is enabled" border="0" src="images/green_check.png">
                Yes%ifvar isConnected equals('false')%&nbsp;(Not Connected)%endif%
              </td>
          </tr>
          -->
          
          <!-- Description -->
          <tr>
            <td class="evenrow-l" scope="row">Description</td>
            <td class="evenrowdata-l">%value description encode(html)%</td>
          </tr>
          
          <!-- Client Prefix -->
          <TR>
            <TD class="oddrow-l" scope="row">Client Prefix</TD>
            <TD class="oddrowdata-l">%value CLIENTPREFIX encode(html)%</TD>
          </TR>
          
          <!-- Share Client Prefix -->
          <TR>
            <TD class="evenrow-l" scope="row">Client Prefix Is Shared (prevents removal of shared messaging provider objects)</TD>
            <TD class="evenrowdata-l"> %ifvar isISClustered equals('true')% Yes %else% %ifvar isClientPrefixShared equals('true')% Yes %else% No %endif% %endif% </TD>
          </TR>
          
          <!--                     -->
          <!-- Connection Settings -->
          <!--                     -->
          
          <tr>
            <td class="heading" colspan=2>Connection Settings</td>
          </tr>
    
          <!-- Broker Host -->
          <TR>
            <TD class="oddrow-l" scope="row">Broker Host</TD>
            <TD class="oddrowdata-l">%value brokerHost encode(html)%</TD>
          </TR>
          
          <!-- Broker Name -->
          <TR>
            <TD class="evenrow-l" scope="row">Broker Name</TD>
            <TD class="evenrowdata-l">%value brokerName encode(html)%</TD>
          </TR>
          
          <!-- Client Group -->
          <TR>
            <TD class="oddrow-l" scope="row">Client Group</TD>
            <TD class="oddrowdata-l">%value clientGroupName encode(html)%</TD>
          </TR>

          <!-- Client Authentication -->
          <TR>
            <TD class="evenrow-l" scope="row">Client Authentication</TD>
            
            %ifvar clientAuth equals('none')%
                  <TD class="evenrowdata-l">None</TD>
              %endif%
            %ifvar clientAuth equals('ssl')%
                  <TD class="evenrowdata-l">SSL</TD>
              %endif%
            %ifvar clientAuth equals('basic')%
                  <TD class="evenrowdata-l">Username/Password</TD>
              %endif%
          </TR>
         
          %endinvoke%

          %ifvar isUpdated equals('true')%
            <tr>
              <td class="subheading" colspan=4> 
                * Settings have been modified. Server restart is required.
              </td>
            </tr>
          %endif%       
           <tr>
                 <td class="subheading" colspan=2>* webMethods Broker is deprecated.</td>
           </tr>

        </TABLE>
      </td>
    </TR>
  </TABLE>
</BODY>
</HTML>