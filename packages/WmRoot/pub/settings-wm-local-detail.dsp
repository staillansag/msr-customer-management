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
      <TD class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Local Connection Alias</TD>
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
    %else% %ifvar action equals('create')%
      
        %invoke wm.server.messaging:createConnectionAlias%
        <TR>
          <TD colspan="2">&nbsp;</td>
        </TR>
        <TR>
          <TD class="message" colspan=2>%value message encode(html)%</TD>
        </TR>
        %endinvoke%
    %endif%
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
            <td width="40%" class="oddrow-l" nowrap="true" scope="row">Connection Alias Name</td>
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
            <td class="evenrow-l" scope="row">Description</td>
            <td class="evenrowdata-l">%value description encode(html)%</td>
          </tr>
          
        </TABLE>
      </td>
    </TR>
  </TABLE>
  %endinvoke%
</BODY>
</HTML>
