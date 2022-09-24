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
    
    function isValidURL(url){
        return url.match(/^(ht)tps?:\/\/[a-zA-Z0-9]/);
    } 
    
    function pageInit(helpTopic){
		setNavigation('security-oauth-client-registration-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic='+helpTopic);
		var clientType = document.forms['oAuthClientRegForm'].type;
		enabledisableRequirePKCE(clientType);
    } 
    
    function validateRedirectUris(regForm){
        var uriArray = regForm.dsp_redirect_uris.value.split("\n");
        var illegalChars = '^#%"';
        
        for(var i = 0;i<uriArray.length;i++){
            
            if (!isblank(uriArray[i]) && !isValidURL(uriArray[i])){
                alert(uriArray[i]+" is not valid, must enter valid Redirect URIs");
                return false;
            }
            
            for (var j=0; j<illegalChars.length; j++)
            {
              if (uriArray[i].indexOf(illegalChars.charAt(j)) >= 0)
              {
                alert (uriArray[i] + " contains illegal character: '" + illegalChars.charAt(j) + "'.\n Must enter valid Redirect URIs");
                return false;
              }
            }
            
        }
        return true;
    }

    function validateData() {
        var regForm=document.forms['oAuthClientRegForm'];
        
        if(isblank(regForm.name.value)){
            alert("Must provide a value for Name");
            regForm.name.focus();
            return false;
        }
        if(isSpclChar(regForm.name.value)){
            alert("The client name contains illegal characters, provide a valid value.");
            regForm.name.focus();
            return false;
        }
        if(isblank(regForm.version.value)){
            alert("Must provide a value for Version");
            regForm.version.focus();
            return false;
        }
        if(isSpclChar(regForm.version.value)){
            alert("The client version contains illegal characters, provide a valid value.");
            regForm.version.focus();
            return false;
        }
		if (regForm.type.value != 'confidential' && regForm.client_credentials_allowed.checked) {
            alert("Only confidentials clients can use the client credentials grant.");
            regForm.type.focus();
            return false;
		}
        if(isblank(regForm.dsp_redirect_uris.value) && 
		   (regForm.authorization_code_allowed.checked || regForm.implicit_allowed.checked)) {
            alert("Must provide a value for Redirect URIs when the authorization code grant or the implicit code grant is allowed.");
            regForm.dsp_redirect_uris.focus();
            return false;
        }
        if(!validateRedirectUris(regForm)){
            return false;
        }
        if(!validateIntValue(regForm.token_lifetime.value,'Expiration Interval')){
            return false;
        }
        if(!validateIntValue(regForm.token_refresh_limit.value,'Refresh Count')){
            return false;
        }
        %ifvar edit -notempty%
            regForm.operation.value="update-client";
        %else%
            regForm.operation.value="register-client";
        %endif%
                 
        var validateRefreshLimit=true;
		for (var j=0; j <regForm.refreshLimit.length; j++){
			if (regForm.refreshLimit[j].checked){
				if(regForm.refreshLimit[j].value!='0'){
					validateRefreshLimit=false;
				}
			}
		}
            
                    
        if(validateRefreshLimit && (!isInteger(regForm.token_refresh_limit.value) || regForm.token_refresh_limit.value<0))
        {
            
            alert("You must specify a valid positive Integer for Refresh Count limit.");
            regForm.token_refresh_limit.focus();
            return false;
            
        }
        
        for (var i=0; i < regForm.refreshLimit.length; i++){
           if (regForm.refreshLimit[i].checked){
                if(regForm.refreshLimit[i].value!='0'){
                    regForm.token_refresh_limit.disabled=false;
                    regForm.token_refresh_limit.value=regForm.refreshLimit[i].value;
                }
            }
        }
        
        for (var i=0; i < regForm.lifeTime.length; i++){
           if (regForm.lifeTime[i].checked){
                if(regForm.lifeTime[i].value!=0){
                    regForm.token_lifetime.disabled=false;
                    regForm.token_lifetime.value=regForm.lifeTime[i].value;
                }
            }
        }
        
        return true;
    }
    
    function enabledisableRequirePKCE(clientType) {
        if (clientType.value == 'confidential') {
            document.forms['oAuthClientRegForm'].pkceInherited.disabled = true;
            document.forms['oAuthClientRegForm'].pkceRequired.disabled = true;
            document.forms['oAuthClientRegForm'].pkceNotRequired.disabled = true;
        } else {
            document.forms['oAuthClientRegForm'].pkceInherited.disabled = false;
            document.forms['oAuthClientRegForm'].pkceRequired.disabled = false;
            document.forms['oAuthClientRegForm'].pkceNotRequired.disabled = false;
        }
    }

     function enabledisableLifeTimeField(lifetimeaction){
     
        if (lifetimeaction.value != 0){
            document.forms['oAuthClientRegForm'].token_lifetime.value="";
            document.forms['oAuthClientRegForm'].token_lifetime.disabled = true;
        }else{
            document.forms['oAuthClientRegForm'].token_lifetime.disabled = false;
        }
    }
    
    function enabledisableRefreshLimitField(refershaction){
        if (refershaction.value != 0){
            document.forms['oAuthClientRegForm'].token_refresh_limit.value="";
            document.forms['oAuthClientRegForm'].token_refresh_limit.disabled = true;
        }else{
            document.forms['oAuthClientRegForm'].token_refresh_limit.disabled = false;
        }
    }
    
    function validateIntValue(fieldVal,fieldName){
        if(!isblank(fieldVal) && (!isInteger(fieldVal) || fieldVal<0) ){
            alert("You must specify a valid positive Integer value for the field "+fieldName+".");
            return false;
        }
        return true;
    }

    function revealSecret() {
         var btnVal = document.forms['oAuthClientRegForm'].secret_btn.value;

         if (btnVal=='Reveal Secret') {
             var secret = document.forms['oAuthClientRegForm'].client_secret.value;
             document.forms['oAuthClientRegForm'].client_secretDisplay.value = secret;
             document.forms['oAuthClientRegForm'].secret_btn.value = 'Hide Secret';
         } else if (btnVal=='Hide Secret') {
             document.forms['oAuthClientRegForm'].client_secretDisplay.value = "******";
             document.forms['oAuthClientRegForm'].secret_btn.value = 'Reveal Secret';
         }
    }

</SCRIPT>
</HEAD>

%ifvar edit -notempty%
<BODY onLoad="pageInit('IS_Security_OAuthRegisterClientScrn');">
%else%
<BODY onLoad="pageInit('IS_Security_OAuthEditClientScrn');">
%endif%

<FORM NAME="oAuthClientRegForm" action="security-oauth-client-registration.dsp" method="POST">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="operation">

  <TABLE WIDTH="100%">

            <TR>
                <TD class="breadcrumb" colspan="3">
                   Security &gt; OAuth &gt; Client Registration &gt;
                    %ifvar edit -notempty%
                        Edit
                    %else%
                        Register Client
                    %endif%

                </TD>
            </TR>

            <TR>
                <TD colspan="3">
                    <ul class="listitems">
						<script>
						createForm("htmlform_security_oauth_client_registration", "security-oauth-client-registration.dsp", "POST", "BODY");
						</script>
                        <LI>
						<script>getURL("security-oauth-client-registration.dsp","javascript:document.htmlform_security_oauth_client_registration.submit();","Return to Client Registration");</script></LI>
                    </UL>
                </TD>
            </TR>
            <TR>
            <TD width="70%">
                %ifvar client_id -notempty%
                    %invoke wm.server.oauth:getClientRegistration%
                    %endinvoke%
                %else%
                    %ifvar name -notempty%
                        %invoke wm.server.oauth:getClientRegistrationUsingName%
                        %endinvoke%
                    %endif%
                 %endif%

                <TABLE WIDTH="100%" class="tableView">
                    <TR>
                        <TD class="heading" colspan="2">Client Configuration</TD>
                    </TR>
                    %ifvar edit -notempty%
                    <TR>
            			<TD class="oddrow" nowrap><label for="client_id">ID</label></TD>
                        <TD class="oddrow-l">
            			 	<INPUT NAME="client_id" id="client_id" TYPE="TEXT" VALUE="%value client_id encode(htmlattr)%" SIZE="50" readonly="true" style="color:#808080;">
                         </TD>
                    </TR>
                    <TR>
                        <TD class="evenrow" nowrap><label for="client_secret">Secret</label></TD>

                            %ifvar client_secret -notempty%
                               <TD class="evenrow-l">
                                   <INPUT NAME="client_secretDisplay" id="client_secretDisplay" TYPE="TEXT" VALUE="******" SIZE="50" readonly="true" style="color:#808080;" >
                                   <INPUT NAME="client_secret" id="client_secret" TYPE="HIDDEN" VALUE=%value client_secret% SIZE="50" readonly="true" style="color:#808080;" >
                                   <INPUT type="button" id="secret_btn" value="Reveal Secret" style="background-color: #D8D8D8; color: #black;" onclick="revealSecret();">
                                </TD>
                           %else%
                               <TD class="evenrow-l">
                                 <INPUT NAME="client_secret" id="client_secret" TYPE="TEXT" VALUE="" SIZE="50" readonly="true" style="color:#808080;" >
                              </TD>
                            %endif%
                    </TR>
                    %endif%
                    <TR>
            			<TD class="oddrow" nowrap><label for="name">Name</label></TD>
                        <TD class="oddrow-l">
                            %ifvar edit -notempty%
            			 		<INPUT NAME="name" id="name" TYPE="TEXT" VALUE="%value name encode(htmlattr)%" SIZE="50" >
                            %else%
                                <INPUT NAME="name" id="name" TYPE="TEXT" VALUE="" SIZE="50">
                            %endif%
                         </TD>
                    </TR>
                    <TR>
            			<TD class="evenrow" nowrap><label for="version">Version</label></TD>
                        <TD class="evenrow-l">
                            %ifvar edit -notempty%
            			 		<INPUT NAME="version" id="version" TYPE="TEXT" VALUE="%value version encode(htmlattr)%" SIZE="50">
                            %else%
                                <INPUT NAME="version" id="version"  TYPE="TEXT" VALUE="" SIZE="50">
                            %endif%
                         </TD>
                    </TR>
                
                    <TR>
            			<TD class="oddrow" nowrap><label for="type">Type</label></TD>
                         <TD class="oddrow-l">
                            %ifvar edit -notempty%
                            <SELECT name="type" id="type" onchange="enabledisableRequirePKCE(this)">
                                <OPTION value="confidential"  %ifvar type equals('confidential')% selected="true" %endif%>Confidential</OPTION>
                                <OPTION value="public"  %ifvar type equals('public')% selected="true" %endif%>Public</OPTION>
                            </SELECT>
                            %else%
                            <SELECT name="type" id="type" onchange="enabledisableRequirePKCE(this)">
                                <OPTION value="confidential">Confidential</OPTION>
                                <OPTION value="public">Public</OPTION>
                            </SELECT>
                            %endif%
                         </TD>
                    </TR>
                    <TR>
            			<TD class="evenrow" nowrap><label for="notes">Description</label></TD>
                        <TD class="evenrow-l">
                            %ifvar edit -notempty%
            			 		<INPUT NAME="notes" id="notes" TYPE="TEXT" VALUE="%value notes encode(htmlattr)%" SIZE="103">
                            %else%
                                <INPUT NAME="notes" id="notes" TYPE="TEXT" VALUE="" SIZE="103">
                            %endif%
                         </TD>
                    </TR>
                    <TR>
            			<TD class="oddrow" nowrap><label for="dsp_redirect_uris">Redirect URIs</label></TD>
                        <TD class="oddrow-l">
                            
                            %ifvar edit -notempty%
            			 	 <textarea name="dsp_redirect_uris" id="dsp_redirect_uris" wrap="off"  rows="5" cols="100" >%value dsp_redirect_uris encode(html)%</textarea> 
                             %else%
                             <textarea name="dsp_redirect_uris" id="dsp_redirect_uris" rows="5" cols="100"  wrap="off"></textarea> 
                             %endif% <BR/>
                             Enter one URI per line
                         </TD>
                    </TR>
                    <TR>
                        <TD class="oddrow" nowrap>Allowed Grants</TD>
                        <TD class="oddrow-l">
								%ifvar edit -notempty%
								<INPUT id="authorization_code_allowed" name="authorization_code_allowed" type="checkbox" value="true" %ifvar authorization_code_allowed equals('true')% checked %endif%> 
									<label for="authorization_code_allowed">Authorization Code Grant</label><BR/>
								%else%
								<INPUT id="authorization_code_allowed2" name="authorization_code_allowed" type="checkbox" value="true" checked> 
									<label for="authorization_code_allowed2">Authorization Code Grant</label><BR/>
								%endif%
								<INPUT id="implicit_allowed" name="implicit_allowed" type="checkbox" value="true" %ifvar implicit_allowed equals('true')% checked %endif%> 
									<label for="implicit_allowed">Implicit Grant</label><BR/>
								<INPUT id="client_credentials_allowed" name="client_credentials_allowed" type="checkbox" value="true" %ifvar client_credentials_allowed equals('true')% checked %endif%> 
									<label for="client_credentials_allowed">Client Credentials Grant</label></BR>
								<INPUT id="owner_credentials_allowed" name="owner_credentials_allowed" type="checkbox" value="true" %ifvar owner_credentials_allowed equals('true')% checked %endif%> 
									<label for="owner_credentials_allowed">Resource Owner Password Credentials Grant</label>
                         </TD>
                    </TR>
                    <TR>
                        <TD class="oddrow" nowrap>Require PKCE</TD>
                        <TD class="oddrow-l">
                            %ifvar edit -notempty%
                            %switch require_pkce%
                            %case '-1'%
                            <INPUT type="radio" name="require_pkce" id="pkceInherited"   value="-1" checked/><label for="pkceInherited">Use OAuth Global Setting &lt; %value globalRequirePKCE encode(htmlattr)% &gt;</label><BR/>
                            <INPUT type="radio" name="require_pkce" id="pkceNotRequired" value="0" /><label for="pkceNotRequired">No </label><BR/>
                            <INPUT type="radio" name="require_pkce" id="pkceRequired"    value="1" /><label for="pkceRequired">Yes </label>&nbsp;
                            %case '0'%
                            <INPUT type="radio" name="require_pkce" id="pkceInherited"   value="-1" /><label for="pkceInherited">Use OAuth Global Setting &lt; %value globalRequirePKCE encode(htmlattr)% &gt;</label><BR/>
                            <INPUT type="radio" name="require_pkce" id="pkceNotRequired" value="0" checked/><label for="pkceNotRequired">No </label><BR/>
                            <INPUT type="radio" name="require_pkce" id="pkceRequired"    value="1" /><label for="pkceRequired">Yes </label>&nbsp;
                            %case '1'%
                            <INPUT type="radio" name="require_pkce" id="pkceInherited"   value="-1" /><label for="pkceInherited">Use OAuth Global Setting &lt; %value globalRequirePKCE encode(htmlattr)% &gt;</label><BR/>
                            <INPUT type="radio" name="require_pkce" id="pkceNotRequired" value="0" /><label for="pkceNotRequired">No </label><BR/>
                            <INPUT type="radio" name="require_pkce" id="pkceRequired"    value="1" checked/><label for="pkceRequired">Yes </label>&nbsp;
                            %end%
                            %else%
                            %invoke wm.server.oauth:getOAuthSettings%
                            <INPUT type="radio" name="require_pkce" id="pkceInherited"   value="-1" checked/><label for="pkceInherited">Use OAuth Global Setting &lt; %value requirePKCE encode(htmlattr)% &gt;</label><BR/>
                            <INPUT type="radio" name="require_pkce" id="pkceNotRequired" value="0" /><label for="pkceNotRequired">No </label><BR/>
                            <INPUT type="radio" name="require_pkce" id="pkceRequired"    value="1" /><label for="pkceRequired">Yes </label>&nbsp;
                            %endinvoke%
                            %endif%
                        </TD>
                    </TR>

                    <TR><TD><BR/></TD></TR>
                    <TR>
                        <TD class="heading" colspan="2">Token</TD>
                    </TR>
                    <TR>
                        <TD class="oddrow" nowrap>Expiration Interval</TD>
                        <TD class="oddrow-l">
                            %ifvar edit -notempty%
                            %switch token_lifetime%                 
                            %case '-2'%     
            				<INPUT type="radio" name="lifeTime" id="lifeTime1" value="-2" checked onclick="enabledisableLifeTimeField(this)"/><label for="lifeTime1">Use OAuth Global Setting &lt; %value globalAccessTokenLiftime encode(html)% &gt; </label><BR/>
            				<INPUT type="radio" name="lifeTime" id="neverexpires" value="-1" onclick="enabledisableLifeTimeField(this)"/><label for="neverexpires">Never Expires </label> <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="0" onclick="enabledisableLifeTimeField(this)"/><label for="lifeTime">Expires in </label>&nbsp;
            				<INPUT NAME="token_lifetime" id="token_lifetime" TYPE="TEXT" SIZE="15" disabled="true">  seconds
            				%case '-1'%
            				<INPUT type="radio" name="lifeTime" id="lifeTime1" value="-2" onclick="enabledisableLifeTimeField(this)"/><label for="lifeTime1">Use OAuth Global Setting &lt; %value globalAccessTokenLiftime encode(html)% &gt; </label><BR/>
            				<INPUT type="radio" name="lifeTime" id="neverexpires" value="-1" checked onclick="enabledisableLifeTimeField(this)"/><label for="neverexpires">Never Expires </label> <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="0" onclick="enabledisableLifeTimeField(this)"/><label for="lifeTime">Expires in </label>&nbsp;
            				<INPUT NAME="token_lifetime" id="token_lifetime" TYPE="TEXT" SIZE="15" disabled="true">  seconds
            				%case%
            				<INPUT type="radio" name="lifeTime" id="lifeTime1" value="-2" onclick="enabledisableLifeTimeField(this)"/><label for="lifeTime1">Use OAuth Global Setting &lt; %value globalAccessTokenLiftime encode(html)% &gt; </label> <BR/>
            				<INPUT type="radio" name="lifeTime" id="neverexpires" value="-1" onclick="enabledisableLifeTimeField(this)"/><label for="neverexpires">Never Expires </label> <BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="0" checked onclick="enabledisableLifeTimeField(this)"/><label for="lifeTime">Expires in </label>&nbsp;
            				<INPUT NAME="token_lifetime" id="token_lifetime" TYPE="TEXT" VALUE="%value token_lifetime encode(htmlattr)%" SIZE="15">  seconds
            			 	%end%
            			 	%else%
            			 	%invoke wm.server.oauth:getOAuthSettings%
            			 	<INPUT type="radio" name="lifeTime" id="lifeTime1" value="-2" checked onclick="enabledisableLifeTimeField(this)"/><label for="lifeTime1">Use OAuth Global Setting %ifvar accessTokenLifetime equals('-1')% &lt; Never Expires &gt; %else% &lt; %value accessTokenLifetime encode(html)%  seconds &gt;  %endif% </label><BR/>
            			 	<INPUT type="radio" name="lifeTime" value="-1" id="neverexpires" onclick="enabledisableLifeTimeField(this)"/><label for="neverexpires">Never Expires </label><BR/>
            				<INPUT type="radio" name="lifeTime" id="lifeTime" value="0" onclick="enabledisableLifeTimeField(this)"/><label for="lifeTime">Expires in </label>&nbsp;
            			 	<INPUT NAME="token_lifetime" id="token_lifetime"  TYPE="TEXT" VALUE="" SIZE="15"  disabled="true">  seconds
                            %endinvoke%
                            %endif%
                         </TD>
                    </TR>
                    <TR>
                        <TD class="evenrow" nowrap>Refresh Count</TD>
                        <TD class="evenrow-l">
                            %ifvar edit -notempty%
                            %switch token_refresh_limit%
                             %case '-1'%
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="-1" checked onclick="enabledisableRefreshLimitField(this)"/><label for="refreshLimit">Unlimited </label><BR/>
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit1" value="0" onclick="enabledisableRefreshLimitField(this)"/><label for="refreshLimit1">Limit </label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            				<INPUT NAME="token_refresh_limit" id="token_refresh_limit" TYPE="TEXT" SIZE="15" disabled="true"> 
            				%case%
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="-1" onclick="enabledisableRefreshLimitField(this)"/><label for="refreshLimit">Unlimited </label><BR/>
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit1" value="0" checked onclick="enabledisableRefreshLimitField(this)"/><label for="refreshLimit1">Limit </label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            				<INPUT NAME="token_refresh_limit" id="token_refresh_limit" TYPE="TEXT" VALUE="%value token_refresh_limit encode(htmlattr)%" SIZE="15">
            				%end%
            			 	%else%
            			 	<INPUT type="radio" name="refreshLimit" id="refreshLimit" value="-1" onclick="enabledisableRefreshLimitField(this)"/><label for="refreshLimit">Unlimited </label><BR/>
            				<INPUT type="radio" name="refreshLimit" id="refreshLimit1" value="0" checked onclick="enabledisableRefreshLimitField(this)"/><label for="refreshLimit1">Limit </label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <INPUT NAME="token_refresh_limit" id="token_refresh_limit" TYPE="TEXT" VALUE="0" SIZE="15">
                            %endif%
                         </TD>
                    </TR>
                    
                </TABLE>
            </TD>
             <TD width="28%">
              &nbsp;
            </TD>
            </TR>
            <TR>
                <TD  class="action" >
                    <input type="submit" name="submit" value="Save" onclick="return validateData();">
                </TD>
                 <TD width="28%">
                &nbsp;
                </TD>
            </TR>
    </TABLE>
	<input type="hidden" name="dsp_scopes" value="%value dsp_scopes encode(htmlattr)%">
    %ifvar edit -notempty%
		<input type="hidden" name="enabled" value="%value enabled encode(htmlattr)%">
    %else%
        <input type="hidden" name="enabled" value="true">
    %endif%
</FORM>
</BODY>
</HTML>
