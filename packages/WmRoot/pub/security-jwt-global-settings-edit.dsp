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
  <script src="webMethods.js"></script>
  <script language="JavaScript">
	function validate(thisform,oper)
    {
	    
		thisform.operation.value= 'global_settings_edit';
       
      	if (!verifyRequiredNonNegNumber("htmlform_jwt_global_settings_edit","maxGlobalSkew"))
          {
             alert("Max Global Skew must be a non-negative integer in the range 0 to 2147483647");
             return false;
          }
        return true;
    }
    
    function trimStr(str) {
      return str.replace(/^\s+|\s+$/g, '');
    }

  </script>
     
  
    <body onLoad="setNavigation('security-jwt-global-settings-edit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_JWT_EditGlobalClaimSettingsScrn');">
  
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> 
				Security &gt; JWT &gt; Global Claim Settings &gt; Edit
            </td>
        </tr>
         
        
            %invoke wm.server.jwt:getGlobalSettings%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
         
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>createForm("htmlform_settings_jwt_home", "security-jwt-settings.dsp", "POST", "BODY");</script>
                    <li class="listitem">
					<script>getURL("security-jwt-settings.dsp","javascript:document.htmlform_settings_jwt_home.submit();","Return to JWT")</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <form name="htmlform_jwt_global_settings_edit" id="htmlform_jwt_global_settings_edit" action="security-jwt-settings.dsp" method="POST">
                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                <input type="hidden" name="operation" value="global_edit">
				<table class="tableView width25">
					<tr>
						<td class="heading" colspan="2">Global Claim Settings</td>
					</tr>

					<tr>
						<td class="evenrow" ><label for="audience">Audience</label></td>
						<td class="evenrow-l" >
							<input type="text" size="40" name="audience" id="audience" value="%value audience encode(htmlattr)%">
						</td>
					</tr>
					
					<tr>
						<td class="evenrow" ><label for="maxGlobalSkew">Max Global Skew (Seconds)</label></td>
						<td class="evenrow-l" >
							<input type="number" size="40" name="maxGlobalSkew" id="maxGlobalSkew" min="0" max="2147483647" value="%value maxGlobalSkew encode(htmlattr)%">
						</td>
					</tr>
				   
					<tr>
						<td class="action" colspan=3>
							<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);">
						</td>
					</tr>	
				</table>
			</form>
            </td>
        </tr>
        
    </table>
    
  </body>   
</head>
