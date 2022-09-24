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
 <script language="JavaScript">
 function validate(currentForm)
 {
    if(currentForm.isGuardEnabled.checked) {
        currentForm.boolGuardEnabled.value = "true";
    } else {
        currentForm.boolGuardEnabled.value = "false";
    }
    
    return true;
 }
 </script>
  
</head>
  
    <body onLoad="setNavigation('settings-csrf-edit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_CSRFGuardEditScrn');">
  
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> 
                Security &gt; CSRF Guard &gt; Edit CSRF Guard Settings
            </td>
        </tr>
                        
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>
					createForm("htmlform_security_csrf", "security-csrf.dsp", "POST", "BODY");
					</script>
                    <li>
					<script>getURL("security-csrf.dsp","javascript:document.htmlform_security_csrf.submit();","Return to CSRF Guard Settings");</script></li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <SCRIPT>%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%</SCRIPT>
            <form name="htmlform_CSRFConfig" action="security-csrf.dsp" method="POST" id="htmlform_CSRFConfig">
                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                <input type="hidden" name="operation" value="edit">
				<input type="hidden" name="boolGuardEnabled" value="%value isEnabled encode(htmlattr)%">
                <table>
                <tr>
                    <td>    
                        <table class="tableView" width="100%">
                        %invoke wm.server.csrfguard:getCSRFGuardConfigDetails%
                            <tr>
                                <td class="heading" colspan="2">CSRF Guard Settings</td>
                            </tr>
                            
                            <tr>
								<td class="oddrow"><label for="isGuardEnabled">Enabled</label></td>	
                                <td class="oddrow-l">
									<input type="checkbox" name="isGuardEnabled" id="isGuardEnabled" value="%value isEnabled encode(htmlattr)%" %ifvar isEnabled equals('true')%checked%endif% >
                                </td>
                            </tr>
                            
                            <tr>
								<td class="evenrow" ><label for="excludedUserAgents">Excluded User Agents </label></td>
                                <td class="evenrow-l" >
									<textarea name="excludedUserAgents" wrap="off" id="excludedUserAgents"  rows="4" cols="50" style="width:100%">%value excludedUserAgents encode(html)%</textarea> 
                                </td>
                            </tr>
                            <tr>
                               <td class="evenrow"/>
                               <td class="evenrow-l" colspan=2>Enter one user agent per line</TD>
                            </tr>
                            
                            <tr>
								<td class="oddrow" ><label for="landingPages">Landing Pages </label></td>
                                <td class="oddrow-l" >
									<textarea name="landingPages" wrap="off" id="landingPages"  rows="4" cols="50" style="width:100%">%value landingPages encode(html)%</textarea> 
                                </td>
                            </tr>
                            <tr>
                               <td class="oddrow"/>
                               <td class="oddrow-l" colspan=2>Enter one landing page URL per line</TD>
                            </tr>
                            
                            <tr>
								<td class="evenrow" ><label for="unprotectedURLs">Unprotected URLs </label></td>
                                <td class="evenrow-l" >
									<textarea name="unprotectedURLs" wrap="off" id="unprotectedURLs"  rows="4" cols="50" style="width:100%">%value unprotectedURLs encode(html)%</textarea> 
                                </td>
                            </tr>
                            <tr>
                               <td class="evenrow"/>
                               <td class="evenrow-l" colspan=2>Enter one URL per line</TD>
                            </tr>
                            <tr>
								<td class="oddrow" ><label for="excludedUserAgents">Denial Action</label></td>
                                <td class="oddrow-l" >                                  
                                
									<input type="radio" name="denialAction" id="REDIRECT" checked value="REDIRECT" /><label for="REDIRECT"> Redirect</label>&nbsp;&nbsp;
									<input type="radio" name="denialAction" id="ERROR"  %ifvar denialAction equals('ERROR')% checked %endif% value="ERROR"/><label for="ERROR">  Error</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="action" colspan=3>
                                    <input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);">
                                </td>
                            </tr> 
                        %endinvoke% 
                        </table>
                    </td>
                
                </tr>
            </form>
            </table>
            </td>
        </tr>
        
    </table>
    
  </body>   

</html>