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
	
	function populateSkewMapping(){
		document.getElementById("maxIssuerSkew").value= issuerSkewMap[document.getElementById("issuer").value];
	}

	function validate(thisform, oper)
    {
		thisform.operation.value= 'skew_mapping_add';
    	var l_issuer = document.getElementById('issuer');
		   
		if(0 == l_issuer.value.length)
		{
			alert("You must specify a valid value for the field : 'Issuer'")
			l_issuer.focus();
			return false;
		} else if (255 < l_issuer.value.length) {
			alert("'Issuer' field cannot exceed 255 characters.")
			l_issuer.focus();
			return false;
		}
		
		if (!verifyRequiredNonNegNumber("htmlform_jwt_skew_mapping_addedit","maxIssuerSkew"))
    	{
             alert("Skew must be a non-negative integer in the range 0 to 2147483647");
             return false;
        }
        return true;
    }
    
  </script>
     

    <body onLoad="setNavigation('security-jwt-issuer-skew-mapping-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_JWT_AddUpdateSkewmappingScrn');populateSkewMapping();">

    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> 
				Security &gt; JWT &gt; Issuer Skew Mappings &gt; Add/Update Mapping
            </td>
        </tr>
         

		%invoke wm.server.jwt:listIssuerSkewMappings%
  			<script>
            	var issuerSkewMap = new Object();
			</script>
            %loop issuerSkewMappings%
				<script>
					issuerSkewMap["%value issuer%"]= "%value maxIssuerSkew%";
				</script>                                      
            %endloop%
		%endinvoke% 
										
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>createForm("htmlform_jwt_cert_mapping_return", "security-jwt-issuer-cert-mappings.dsp", "POST", "BODY");</script>
                    <li class="listitem">
					<script>getURL("security-jwt-issuer-cert-mappings.dsp","javascript:document.htmlform_jwt_cert_mapping_return.submit();","Return to Issuer Configuration")</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <form name="htmlform_jwt_skew_mapping_addedit" id="htmlform_jwt_skew_mapping_addedit" action="security-jwt-issuer-cert-mappings.dsp" method="POST">
                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                <input type="hidden" name="operation">
                        <table class="tableView width25">
                            <tr>
                                <td class="heading" colspan="2">Issuer Skew Mapping</td>
                            </tr>

                            <tr>
                                <td class="evenrow" ><label for="issuer">Issuer</label></td>
                                <td class="evenrow-l" >
									<select name="issuer" id="issuer" onchange="populateSkewMapping()">
										%invoke wm.server.jwt:listIssuers%
											%loop trustedIssuers%
												<option value="%value issuer%">%value issuer%</option>
											%endloop%	
										%endinvoke%	
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td class="oddrow" nowrap><label for="maxIssuerSkew">Skew (seconds)</label></td>   
                                <td class="oddrow-l">
                                   <input type="number" name="maxIssuerSkew" id="maxIssuerSkew" min="0" max="2147483647"/>
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
