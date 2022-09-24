<html>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">

    <title>Integration Server - webMethods Cloud Tenant Connections</title>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css">
    <link rel="stylesheet" type="text/css" href="metadata.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%

    <script src="../WmRoot/webMethods.js"></script>
    <script src="jquery.js"></script>
    <script src="metadata.js"></script>
    <script language="JavaScript">
function submitForm(){
  if (!verifyRequiredField("applicationForm", "username")) {
    alert("User Name is required.");
    return false;
  }
  if (!(verifyRequiredField("applicationForm", "iliveURL"))) {
    alert("webMethods Cloud URL is required.");
    return false;
  }

  return true;
}

	//Certificate Settings
	var hiddenOptions = new Array();
	var hiddenOptionsTs = new Array();
	var currentKSAlias = "";
	var currentTSAlias = "";
	var currentKEYAlias = "";

	      function loadKeyStoresOptions()
	      {
			    var ks = document.applicationForm.keyStoreAlias.options;
				var ts = document.applicationForm.trustStoreAlias.options;
	      		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
	      			   ks[ks.length] = new Option("","");
				       hiddenOptions[ks.length-1] = new Array();

			       	   %loop keyStoresAndConfiguredKeyAliases%
			       			ks.length=ks.length+1;
				       		ks[ks.length-1] = new Option("%value encode(javascript) keyStoreName%","%value encode(javascript) keyStoreName%");
			           		var aliases = new Array();
			    	   		%loop keyAliases%
			       				aliases[%value $index%] = new Option("%value%","%value%");
			       			%endloop%
			       			if (aliases.length == 0)
			       			{
								aliases[0] = new Option("","");
							}
				       		hiddenOptions[ks.length-1] = aliases;
		       	   %endloop%
			    %endinvoke%

				//list trust store aliases
				%invoke wm.server.security.keystore:listTrustStores%
	      			   ts[ts.length] = new Option("","");
				       hiddenOptionsTs[ts.length-1] = new Array();
			       	   %loop trustStores%
							%ifvar isLoaded equals('true')%
								ts.length=ts.length+1;
								ts[ts.length-1] = new Option("%value encode(javascript) keyStoreName%","%value encode(javascript) keyStoreName%");
								var aliases = new Array();
								hiddenOptionsTs[ts.length-1] = aliases;
							%endif%
		       	   %endloop%
			    %endinvoke%
	      }

	      function changeval() {
       		var ks = document.applicationForm.keyStoreAlias.options;
       		var selectedKS = document.applicationForm.keyStoreAlias.value;
       		for(var i=0; i<ks.length; i++) {
       			if(selectedKS == ks[i].value) {
		       		var aliases = hiddenOptions[i];
       				document.applicationForm.keyAlias.options.length = aliases.length;
       				for(var j=0;j<aliases.length;j++) {
       					var opt = aliases[j];
       					document.applicationForm.keyAlias.options[j] = new Option(opt.text, opt.value);
     				}
       			}
       		}
		}

		function populateCerts() {

					var keyStoreOptions = document.applicationForm.keyStoreAlias.options;
					if ( currentKSAlias != "")
					{
						for(var i=0; i<keyStoreOptions.length; i++)
						{
							if(currentKSAlias == keyStoreOptions[i].value) {
								keyStoreOptions[i].selected = true;
							}
						}
					}

					changeval();

					var aliasOpts = document.applicationForm.keyAlias.options;
					if ( currentKEYAlias != "")
					{
						for(var i=0; i<aliasOpts.length; i++)
						{
							if(currentKEYAlias == aliasOpts[i].value) {
								aliasOpts[i].selected = true;
							}
						}
					}


					var trustOpts = document.applicationForm.trustStoreAlias.options;
					if ( currentTSAlias != "")
					{
						for(var i=0; i<trustOpts.length; i++)
						{
							if(currentTSAlias == trustOpts[i].value) {
								trustOpts[i].selected = true;
							}
						}
					}

		}
    </script>
</head>

<body onLoad="deInputValidation(); setNavigation('integration-live-tenant-account.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_CreateTenantScrn');">

    <FORM id="applicationForm" NAME="applicationForm" action="integration-live-tenant-account.dsp" method="POST">
        <TABLE WIDTH="100%">

            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
<tr>
            <td class="breadcrumb" colspan="3">
                webMethods Cloud &gt; Tenant Aliases
            </td>
        </tr>

        <tr>
            <td width="70%">
                <table width="100%" class="tableView">
                    <tr>
                        <td class="heading" colspan="2">Settings</td>
                    </tr>
                    %invoke wm.client.integrationlive.account:getAccountInfo%

                    <tr>
                        <td class="evenrow">Enable</td>
                        <td class="evenrow-l">
                            <input type="radio" id="isEnabled1" name="isEnabled" value="true" %ifvar isEnabled equals('true')%
                            checked %endif%><label for="isEnabled1">Yes</label></input>
                            <input type="radio" id="isEnabled2" name="isEnabled" value="false" %ifvar isEnabled equals('false')%
                            checked %endif%><label for="isEnabled2">No</label></input>
                        </td>
                    </tr>

                    <tr>
                        <td class="oddrow" nowrap><label for="aliasName">Alias</label></TD>

                        %ifvar action equals('edit')%
                        <td class="oddrow-l">
                            <imput name="alias" id="alias" type="TEXT" value="%value alias encode(htmlattr)%" SIZE="50"
                                   readonly="true" style="color:#808080;">
                        </td>
                        %else%
                        <td class="oddrow-l">
                            <input name="alias" id="alias" type="TEXT" value="%value alias encode(htmlattr)%" SIZE="50">
                        </td>
                        %endif%
                    </tr>


                    <tr>
                        <TD class="evenrow" nowrap><label for="username">User Name</label></TD>
                        <td class="oddrow-l">
                            <INPUT name="username" id="username" TYPE="TEXT" VALUE="%value username%" SIZE="50">
                        </td>
                    </tr>
                    <tr>
                        <TD class="evenrow" nowrap><label for="password">Password</label></TD>
                        <td class="evenrow-l">
                            <input name="password" type="password" id="password" autocomplete="off"
                            VALUE="%value password%" size="50">
                        </td>
                    </tr>
                    <tr>
                        <TD class="oddrow" nowrap><label for="iliveURL">webMethods Cloud URL</label></TD>
                        <td class="oddrow-l">
                            <input name="iliveURL" id="iliveURL" type="text" value="%value iliveURL%" size="50">
                        </td>
                    </tr>

                    %endinvoke%

          <!-- Certificate Settings SUB -->
           <TR>
             <TD class="heading" colspan=2>Certificate Settings (optional)</TD>
           </TR>

			 		<TR ID="sslRowForKs">
						<TD class="evenrow"><label for="keyStoreAlias">Keystore Alias</label>
					</TD>
				<TD class="evenrowdata-l">
					<SELECT class="listbox" name="keyStoreAlias" id="keyStoreAlias"  onchange="changeval()" style="width: 330px;"></SELECT>
		        </TD>

		</TR>
		<TR ID="sslRowForKAlias">
		<TD class="oddrow"><label for="keyAlias">Key Alias</label></TD>
			    <TD class="oddrowdata-l">
		        	<select class="listbox" name="keyAlias" id="keyAlias" style="width: 330px;" ></select>
		       </TD>
		</TR>
		<TR ID="sslRowForTs">
<TD class="evenrow"><label for="trustStoreAlias">Truststore Alias</label></TD>
				<TD class="evenrowdata-l">
					<SELECT class="listbox" name="trustStoreAlias" id="trustStoreAlias" style="width: 330px;"></SELECT> </TD>
											<script>
							currentKSAlias = "%value keyStoreAlias%";
							currentTSAlias = "%value trustStoreAlias%";
							currentKEYAlias = "%value keyAlias%";
							loadKeyStoresOptions();
						</script>
		</TR>

		  <!-- END Certificate Settings-->

</table>
</td>

            <td width="28%">
                &nbsp;
            </td>
</tr>
</form>
<tr>
    <input type="hidden" name="theAction" value="save"/>
    <td class="action">
        <input type="submit" name="submit" value="Update Settings" onclick="return submitForm();"/>
    </td>
    <td width="28%">
        &nbsp;
    </td>
</tr>
</table>
</body>
			<script>
		populateCerts();
		</script>

</html>
