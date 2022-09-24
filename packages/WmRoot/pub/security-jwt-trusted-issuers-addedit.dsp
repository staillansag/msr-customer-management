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
	    if(oper == 'edit')
        {
            if(0 == thisform.issuer.value.length)
            {
                alert("You must specify a valid value for the field : 'Name'");
                thisform.issuer.focus();
                return false;
            } else if (255 < thisform.issuer.value.length) {
                alert("'Name' field cannot exceed 255 characters.")
                thisform.issuer.focus();
                return false;
            }
            thisform.operation.value= 'edit_issuer';
        }
        else
        {
            var issueName = trimStr(thisform.issuer.value);
            thisform.issuer.value = issueName;
            if(0 == issueName.length)
            {
				
                alert("You must specify a valid value for the field : 'Name'")
                thisform.issuer.focus();
                return false;
            } else if(255 < issueName.length) {
                alert("'Name' field cannot exceed 255 characters.")
                thisform.issuer.focus();
                return false;
            }
		
            thisform.operation.value= 'add_issuer';
        }
        return true;
    }
    
    function trimStr(str) {
      return str.replace(/^\s+|\s+$/g, '');
    }

  </script>
     
  %ifvar operation equals('edit')%
    <body onLoad="setNavigation('security-jwt-trusted-issuers-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_JWT_EditIssuersScrn');">
  %else%
    <body onLoad="setNavigation('security-jwt-trusted-issuers-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_JWT_AddIssuersScrn');">
  %endif%
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> 
				Security &gt; JWT &gt; Trusted Issuers &gt; %ifvar operation equals('edit')%%value issuer encode(html)%&nbsp;&gt;&nbsp;Edit%else%Add Issuer%endif%
            </td>
        </tr>
         
        %ifvar operation equals('edit')%
            %invoke wm.server.jwt:getIssuer%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>createForm("htmlform_settings_trusted_issuers_list", "security-jwt-trusted-issuers.dsp", "POST", "BODY");</script>
                    <li class="listitem">
					<script>getURL("security-jwt-trusted-issuers.dsp","javascript:document.htmlform_settings_trusted_issuers_list.submit();","Return to Trusted Issuers")</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <form name="htmlform_jwt_trusted_issuers_addedit" id="htmlform_jwt_trusted_issuers_addedit" action="security-jwt-trusted-issuers.dsp" method="POST">
                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                <input type="hidden" name="operation">
                        <table class="tableView width25">
                            <tr>
                                <td class="heading" colspan="2">Issuer</td>
                            </tr>

                            <tr>
                                <td class="evenrow" ><label for="issuer">Name</label></td>
                                <td class="evenrow-l" >
                                    %ifvar operation equals('add')%
                                        <input type="text" size="40" name="issuer" id="issuer">
                                    %endif% 
                                    %ifvar operation equals('edit')%
										<input type="text" size="40" name="issuer" id="issuer" value="%value issuer encode(htmlattr)%" readonly="true" style="color:#808080;">
                                    %endif%
                                </td>
                            </tr>
                            <tr>
                                <td class="oddrow"><label for="description">Description</label></td>   
                                <td class="oddrow-l">
                                    %ifvar operation equals('add')%
                                        <textarea rows="5" cols="40" name="description" id="description"></textarea>
                                    %endif% 
                                    %ifvar operation equals('edit')%
                                       	<textarea rows="5" cols="40" name="description" id="description">%value description encode(htmlattr)%</textarea>
                                    %endif%
                                </td>
                            </tr>
                            
                                    
                            <tr>
                                <td class="action" colspan=3>
									<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form,'%value operation encode(javascript)%');">
                                </td>
							</tr>	
            </form>
            </table>
            </td>
        </tr>
        
    </table>
    
  </body>   
</head>
