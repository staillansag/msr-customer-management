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
	var truststoreCertificateMap = new Array();
	var trustStoreAliases = new Array();
	function loadTrustStores()
      {
	    var certArray;
		%invoke wm.server.security.keystore:listTrustStores%
		   var i = 0;
		   var j = 0;
           %loop trustStores%
		        trustStoreAliases[j] = '%value keyStoreName%';
				j = j+1;
		        certArray = new Array();
				i = 0;
				%loop certficateAliases%
					certArray[i]= "%value encode(javascript)%";
					i = i + 1;
				%endloop%
				truststoreCertificateMap['%value keyStoreName%'] = certArray;
		   %endloop%
		%endinvoke%
      }
      
	function validate(thisform, oper)
    {
		var l_issuer = document.getElementById('issuer');
		var l_truststoreAlias = document.getElementById('truststoreAlias');
		var l_certificateAlias = document.getElementById('certificateAlias');
		   
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
		
		if(0 == l_truststoreAlias.value.length)
		{
			alert("You must specify a valid value for the field : 'Truststore Alias'")
			l_truststoreAlias.focus();
			return false;
		} else if (255 < l_truststoreAlias.value.length) {
			alert("'Truststore Alias' field cannot exceed 255 characters.")
			l_truststoreAlias.focus();
			return false;
		}
		
		if(0 == l_certificateAlias.value.length)
		{
			alert("You must specify a valid value for the field : 'Certificate Alias'")
			l_certificateAlias.focus();
			return false;
		} else if (255 < l_certificateAlias.value.length) {
			alert("'Certificate Alias' field cannot exceed 255 characters.")
			l_certificateAlias.focus();
			return false;
		}
	
		thisform.operation.value= 'mapping_add';

        return true;
    }
    
    function trimStr(str) {
      return str.replace(/^\s+|\s+$/g, '');
    }

	function addTruststoreAliases() {
		var len = trustStoreAliases.length;
		for(var i=0;i<len;i++) {
			 var truststoreAliasSelect = document.getElementById('truststoreAlias');
			 truststoreAliasSelect.options[i] = new Option(trustStoreAliases[i], trustStoreAliases[i]);
		}
	}
	function addcertificateAliases() {
		document.getElementById('certificateAlias').options.length = 0;
		var truststoreAliasSelect = document.getElementById('truststoreAlias').value;
		//alert(truststoreAliasSelect);
		var certificateAliasesarray = truststoreCertificateMap[truststoreAliasSelect];
		var len = certificateAliasesarray.length;
		var certificateSelect = document.getElementById('certificateAlias');
		for(var i=0;i<len;i++) {
			certificateSelect.options[i] = new Option(certificateAliasesarray[i], certificateAliasesarray[i]);
		}
	}
  </script>
     

    <body onLoad="loadTrustStores(); addTruststoreAliases(); addcertificateAliases(); setNavigation('security-jwt-issuer-cert-mapping-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_JWT_AddIssuerCertificatemappingScrn');">

    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> 
				Security &gt; JWT &gt; Issuer Certificate Mappings &gt; Add Mapping
            </td>
        </tr>
         

        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>createForm("htmlform_jwt_cert_mapping_return", "security-jwt-issuer-cert-mappings.dsp", "POST", "BODY");</script>
                    <li class="listitem">
					<script>getURL("security-jwt-issuer-cert-mappings.dsp","javascript:document.htmlform_jwt_cert_mapping_return.submit();","Return to Issuer Certificate Mappings")</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <form name="htmlform_jwt_cert_mapping_addedit" id="htmlform_jwt_cert_mapping_addedit" action="security-jwt-issuer-cert-mappings.dsp" method="POST">
                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                <input type="hidden" name="operation">
                        <table class="tableView width25">
                            <tr>
                                <td class="heading" colspan="2">Issuer Certificate Mapping</td>
                            </tr>

                            <tr>
                                <td class="evenrow" ><label for="issuer">Issuer</label></td>
                                <td class="evenrow-l" >
									<select name="issuer" id="issuer">
										%invoke wm.server.jwt:listIssuers%
											%loop trustedIssuers%
												<option value="%value issuer%">%value issuer%</option>
											%endloop%	
										%endinvoke%	
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td class="oddrow" nowrap><label for="truststoreAlias">Truststore Alias</label></td>   
                                <td class="oddrow-l">
                                   <select name="truststoreAlias" id="truststoreAlias" onchange="addcertificateAliases()"></select>
                                </td>
                            </tr>
                            <tr>
                                <td class="oddrow" nowrap><label for="certificateAlias">Certificate Alias</label></td>   
                                <td class="oddrow-l">
                                  <select name="certificateAlias" id="certificateAlias"></select>
								  <script>addcertificateAliases();</script>
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
