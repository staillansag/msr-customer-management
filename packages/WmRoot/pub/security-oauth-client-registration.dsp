<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<SCRIPT SRC="webMethods.js"></SCRIPT>
<SCRIPT>
    String.prototype.trim = function () {
        return this.replace(/^\s*/, "").replace(/\s*$/, "");
    }
    function removeClient(operation,id,name,version) {
            var msg = "OK to remove Client "+name+", version "+version+"?";
            if ( confirm(msg)) {
            document.forms['clientRegistrations'].operation.value='remove';
            document.forms['clientRegistrations'].client_id.value=id;
                return true;
            } else
                return false;
    }
    
    function editClient(id){
         document.forms['clientRegistrations'].client_id.value=id;
         document.forms['clientRegistrations'].edit.value='yes';
         document.forms['clientRegistrations'].action='security-oauth-client-registration-addedit.dsp';
        return true;
    }
    
    function editClientUsingName(clientName,version){
        document.forms['clientRegistrations'].name.value=clientName;
        document.forms['clientRegistrations'].version.value=version;
        document.forms['clientRegistrations'].edit.value='yes';
        document.forms['clientRegistrations'].action='security-oauth-client-registration-addedit.dsp';
        return true;
        
    }
    
    function changeStatus(op, clientName,version,clientId) {
        var form=document.forms['clientRegistrations'];
        if(op == 'enable') {
                var msg = "OK to enable client "+clientName+", version "+version;
        } else {
                var msg = "OK to disable client "+clientName+", version "+version;
        }
        if ( confirm(msg) ) {
            form.client_id.value = clientId;
            form.operation.value='update-status';
            if(op == 'enable'){
                form.enabled.value='true';
            } else {
                form.enabled.value='false';
            }
            return true;
        } else {
            return false;
        }
    }
    
</SCRIPT>
</HEAD>
 
<BODY onLoad="setNavigation('security-oauth-client-registration.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthClientRegistrationScrn');">
  <TABLE width="100%">
   <TR>
      <TD class="breadcrumb" colspan="2">
          Security &gt;
          OAuth &gt;
          Client Registration 
      </TD>
    </TR>
    
     %ifvar operation equals('register-client')%
            %invoke wm.server.oauth:registerClient%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
    %endif%   
    
     %ifvar operation equals('update-client')%
            %invoke wm.server.oauth:updateClientRegistration%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
    %endif%
    %ifvar operation equals('remove')%
            %invoke wm.server.oauth:removeClientRegistration%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
    %endif%       
    
    %ifvar operation equals('update-status')%
            %invoke wm.server.oauth:updateClientStatus%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
    %endif%     

   <TR>
      <TD colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_security_oauth_settings", "security-oauth-settings.dsp", "POST", "BODY");
		  createForm("htmlform_security_oauth_client_registration_addedit", "security-oauth-client-registration-addedit.dsp", "POST", "BODY");
		  </script>
          <li>
		  <script>getURL("security-oauth-settings.dsp","javascript:document.htmlform_security_oauth_settings.submit();","Return to OAuth");</script></li>
          <li>
		  <script>getURL("security-oauth-client-registration-addedit.dsp","javascript:document.htmlform_security_oauth_client_registration_addedit.submit();","Register Client");</script></li>
        </UL>
      </TD>
    </TR>
   
    <TR> 
    <TD width="100%">
       <TABLE width="75%" class="tableView" >
       <TR> 
     
      <TD class="heading" colspan="5">Registered Clients</TD>
    </TR>
    
    %invoke wm.server.oauth:listClientRegistrations%
    <TR> 
    
      <TH scope="col" CLASS="oddcol-l" nowrap width="30%">Client Application</TH>
      <TH scope="col" CLASS="oddcol" nowrap width="25%">Client ID</TH>
      <TH scope="col" CLASS="oddcol" nowrap width="15%">Client Type</TH>
      <TH scope="col" CLASS="oddcol" nowrap width="8%">Active</TH>
      <TH scope="col" CLASS="oddcol" nowrap width="5%">Delete</TH>
    </TR>

    %loop clients%
    <TR>
     
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%ifvar name%
      <A href="javascript:document.forms['clientRegistrations'].submit()" onClick="return editClientUsingName('%value name encode(javascript)%','%value version encode(javascript)%');">
       %value name encode(html)% (%value version encode(html)%)
         </A>%else%&nbsp;%endif%
      </TD>
      
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
        <A href="javascript:document.forms['clientRegistrations'].submit()" onClick="return editClient('%value client_id encode(javascript)%');">
          %value client_id encode(html)% 
        </A>            
      </TD>
      <SCRIPT>writeTD("rowdata");</SCRIPT>  %ifvar type equals('confidential')% Confidential %else% Public %endif% </TD>
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
      %ifvar enabled equals('true')%
        <A href="javascript:document.forms['clientRegistrations'].submit()" onClick="return changeStatus('disable','%value name encode(javascript)%','%value version encode(javascript)%','%value client_id encode(javascript)%');">
         <img src="images/green_check.png" alt="Client Application %value name encode(html)%" border="no"> Yes
        </A>
       %else%
        &nbsp;
       <A href="javascript:document.forms['clientRegistrations'].submit()" onClick="return changeStatus('enable','%value name encode(javascript)%','%value version encode(javascript)%','%value client_id encode(javascript)%');">
        No
        </A>
       %endif%
      </TD>
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
        <A href="javascript:document.forms['clientRegistrations'].submit()" onClick="return removeClient('remove','%value client_id encode(javascript)%','%value name encode(javascript)%','%value version encode(javascript)%');">
          <IMG src="icons/delete.png" alt="Client Application %value name encode(html)%" border="none">
        </A>
      </TD>     
      <SCRIPT>swapRows();</SCRIPT>
    </TR>
    %endloop%
    
    </TABLE>
     </TD>
     </TR>
  </TABLE>
  <form name="clientRegistrations" action="security-oauth-client-registration.dsp" method="POST">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="client_id">
    <input type="hidden" name="operation">
    <input type="hidden" name="name">
    <input type="hidden" name="version">
    <input type="hidden" name="edit">
    <input type="hidden" name="enabled">
  </form>      
</BODY>
</HTML>
