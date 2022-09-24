<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT SRC="webMethods.js"></SCRIPT>
  
  <script LANGUAGE="JavaScript">
    function valueAltered()
    {
        document.editform.isChanged.value = "true";
    }
    
    function confirmEdit ()
    {   
        var authCodeLifetime = document.editform.authCodeLifetime.value; 
        if(!isInteger(authCodeLifetime) || authCodeLifetime <0)
        {
            alert("You must specify a valid positive Integer for Authorization code expiration interval.");
            document.editform.authCodeLifetime.focus();
            return false;
        }

        var accessTokenLifetime = document.editform.accessTokenLifetime.value; 
        var validateAccessTokenLifetime=true;
            for (var j=0; j <document.editform.lifeTime.length; j++){
                if (document.editform.lifeTime[j].checked){
                    if(document.editform.lifeTime[j].value!='0'){
                        validateAccessTokenLifetime=false;
                    }
                }
            }
            
                    
        if(validateAccessTokenLifetime && (!isInteger(accessTokenLifetime) || accessTokenLifetime<0))
        {
            
            alert("You must specify a valid positive Integer for Access token expiration interval.");
            document.editform.accessTokenLifetime.focus();
            return false;
            
        }
        
        if (document.editform.cbRequireHTTPS.checked) {
           document.editform.requireHTTPS.value = "true";
        }
        else {
           document.editform.requireHTTPS.value = "false";
        }
        
        if (document.editform.cbRequirePKCE.checked) {
           document.editform.requirePKCE.value = "true";
        }
        else {
           document.editform.requirePKCE.value = "false";
        }

         if(!validateAccessTokenLifetime){
            document.editform.accessTokenLifetime.disabled=false;
            document.editform.accessTokenLifetime.value=-1;
         }
                
        document.editform.submit();
        return true;
    }
    
    function enabledisableAccessTokenField(lifetimeaction){
        if (lifetimeaction.value != 0){
            document.forms['editform'].accessTokenLifetime.value="";
            document.forms['editform'].accessTokenLifetime.disabled = true;
        }else{
            document.forms['editform'].accessTokenLifetime.disabled = false;
        }
    }
	
  </script>
  
  <body onLoad="setNavigation('security-oauth-settings-edit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthEditScrn');">

    <table width="100%">
    <tr>

        <td class="breadcrumb" colspan="2"> Security &gt; OAuth &gt; Edit OAuth Global Settings</td>
    </tr>

      <tr>
        <td colspan="2">
          <ul class="listitems">
		    <script>
			createForm("htmlform_security_oauth_settings", "security-oauth-settings.dsp", "POST", "BODY");
			</script>
            <li>
			<script>getURL("security-oauth-settings.dsp","javascript:document.htmlform_security_oauth_settings.submit();","Return to OAuth");</script></li>
          </ul>
        </td>
      </tr>     

    <TR>
        <TD>
        <FORM NAME="editform" ACTION="security-oauth-settings.dsp" METHOD="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
         <TABLE class="tableView" width="50%">
                <script>swapRows();</script>
                <TR>
                    <TD class="heading" colspan=3>Authorization Server Settings</TD>
                </TR>
        
         
                    %invoke wm.server.oauth:getOAuthSettings%
                    <script>swapRows();</script>
                <TR>
                    <script>writeTDWidth("row", "45%");</script>
	 	    			<label for="cbRequireHTTPS">Require HTTPS</label>
                    </TD>
                    <script>writeTD("row-l");</script>
                        <input type="checkbox" name="cbRequireHTTPS" id="cbRequireHTTPS" %ifvar requireHTTPS equals('true')%checked%endif% onChange="valueAltered()">
						<input type="hidden" name="requireHTTPS" value="%value requireHTTPS encode(htmlattr)%">
                    </TD>
                </TR>

                <TR>
                    <script>writeTDWidth("row", "45%");</script>
	 	    			<label for="cbRequirePKCE">Require PKCE</label>
                    </TD>
                    <script>writeTD("row-l");</script>
                        <input type="checkbox" name="cbRequirePKCE" id="cbRequirePKCE" %ifvar requirePKCE equals('true')%checked%endif% onChange="valueAltered()">
						<input type="hidden" name="requirePKCE" value="%value requirePKCE encode(htmlattr)%">
                    </TD>
                </TR>

                <script>swapRows();</script>
                            
            <TR>
				<script>writeTDWidth("row", "40%");</script><label for="authlifetime">Authorization code expiration interval</label></TD>
                <script>writeTD("row-l");</script>
                    <input TYPE="hidden" NAME="isChanged" VALUE="false">
					<input id="authlifetime" NAME="authCodeLifetime" VALUE="%value authCodeLifetime encode(htmlattr)%" onChange="valueAltered()"> seconds
                </TD>
            </TR>

            <script>swapRows();</script>
            <TR>
                <script>writeTDWidth("row", "40%");</script>Access token expiration interval</TD>
                <script>writeTD("row-l");</script>
                    
					<INPUT type="radio" name="lifeTime" id="lifeTime" value="-1" %ifvar accessTokenLifetime equals('-1')% checked %endif% onclick="enabledisableAccessTokenField(this)" onChange="valueAltered()"><label for="lifeTime">Never Expires </label><BR/>
                    
					<INPUT type="radio" name="lifeTime" id="lifeTime1" value="0" %ifvar accessTokenLifetime equals('-1')% %else% checked %endif% onclick="enabledisableAccessTokenField(this)" onChange="valueAltered()"><label for="lifeTime1">Expires in</label>
                    %ifvar accessTokenLifetime equals('-1')%
					<input NAME="accessTokenLifetime" id="sec" VALUE="" onChange="valueAltered()" disabled=true><label for="sec"> seconds</label>
                    %else%
					<input NAME="accessTokenLifetime" id="sec" VALUE="%value accessTokenLifetime encode(htmlattr)%" onChange="valueAltered()" ><label for="sec"> seconds</label>
                    %endif%
                </TD>
            </TR>

            <script>swapRows();</script>
            <TR>
                <script>writeTDWidth("row", "40%");</script>Token endpoint authentication</TD>
                <script>writeTD("row-l");</script>
					<INPUT type="radio" name="tokenEndpointAuth" id="tokenEndpointAuth" value="session" %ifvar tokenEndpointAuth equals('session')% checked%endif% onChange="valueAltered()"/><label for="tokenEndpointAuth">Accept existing session </label><BR/>
					<INPUT type="radio" name="tokenEndpointAuth" id="tokenEndpointAuth" value="credentials" %ifvar tokenEndpointAuth equals('credentials')% checked%endif% onChange="valueAltered()"/>Require credentials
                </TD>
            </TR>

            <script>swapRows();</script>

            <TR>
                <TD class="heading" colspan=3>Resource Server Settings</TD>
            </TR>
            
            <tr>
				<script>
				createForm("htmlform_settings_remote", "settings-remote.dsp", "POST", "BODY");
				</script>
                <script>writeTDWidth("row", "25%");</script>
				<script>getURL("settings-remote.dsp","javascript:document.htmlform_settings_remote.submit();","Authorization server");</script></TD>
                
                <script>writeTD("row-l");</script>
                  <select name="authServerAlias" onchange="valueAltered()">

                %invoke wm.server.remote:serverList%
			    %invoke wm.server.oauth:listExternalAuthorizationServers%

                %loop -struct servers%
					<option value="%value $key encode(htmlattr)%" %ifvar $key vequals(../authServerAlias)% selected %endif%>
						%value $key encode(html)%
                    </option>
                %endloop%
				%loop authorizationServers%
					<option value="%value name encode(htmlattr)%" %ifvar name vequals(../authServerAlias)% selected %endif%>
						%value name encode(html)%
                    </option>
				%endloop%
                  
                  </select>
                </td>
            </tr>
            <script>swapRows();</script>        
        </TABLE>
        <TABLE class="tableView" width="50%">
        <TR>
                <TD class="action" class="row" width="50%">
                  <INPUT TYPE="hidden" NAME="action" VALUE="edit">
                  <INPUT type="button" value="Save Changes" onclick="return confirmEdit()">
                </TD>
            </TR>
        
        </TABLE>
        </FORM>
        
    </TR>
     </table>
  </body>   
</head>
</html>