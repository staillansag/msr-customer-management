<HTML>

%invoke wm.server.oauth:getExternalAuthorizationServer%
%endinvoke%

<HEAD>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT SRC="webMethods.js"></SCRIPT>
  
  <SCRIPT LANGUAGE="JavaScript">
  
    function validateData() {
        
        if (isblank(document.getElementById('name').value)) {
            alert("Must provide a value for Name");
            document.getElementById('name').focus();
            return false;
        }
		
        if (isblank(document.getElementById('introspection_endpoint').value)) {
            alert("Must provide a value for Introspection Endpoint");
            document.getElementById('introspection_endpoint').focus();
            return false;
        }
		
		if (!validURL(document.getElementById('introspection_endpoint').value)) {
            alert("Introspection Endpoint must be a URL.");
            document.getElementById('introspection_endpoint').focus();
            return false;
		}
		
        if (isblank(document.getElementById('client_id').value)) {
            alert("Must provide a value for Client Id");
            document.getElementById('client_id').focus();
            return false;
        }
		
        if (isblank(document.getElementById('client_secret').value)) {
            alert("Must provide a value for Client Secret");
            document.getElementById('client_secret').focus();
            return false;
        }
		
        if (isblank(document.getElementById('user').value)) {
            alert("Must select a User");
            document.getElementById('user').focus();
            return false;
        }
		
		document.getElementById('operation').value = "saveAuthServer";
		return true;
	}

	function validURL(str) {

		var a = document.createElement("a");
		a.href = str;

		return (a.protocol && 
				a.hostname && 
				a.pathname);
	}
	
	var hiddenOptions = new Array();
  
	function loadKeyStoresOptions() {
	  
		var ks = document.authserver.keystoreAlias.options

		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
			ks[ks.length] = new Option("","");
			hiddenOptions[ks.length-1] = new Array();
		   
			%loop keyStoresAndConfiguredKeyAliases%
				ks.length=ks.length+1;
				ks[ks.length-1] = new Option("%value keyStoreName encode(javascript)%","%value keyStoreName encode(javascript)%");
				var aliases = new Array();
				%loop keyAliases%
					aliases["%value $index encode(javascript)%"] = new Option("%value encode(javascript)%","%value encode(javascript)%");		
				%endloop%
				if (aliases.length == 0) {
					aliases[0] = new Option("","");     
				}
				hiddenOptions[ks.length-1] = aliases;
			%endloop%
		%endinvoke%
			
		var keyOpts = document.authserver.keystoreAlias.options;
		var key = "%value keystoreAlias encode(javascript)%";
		if (key != "") {
			for (var i=0; i<keyOpts.length; i++) {
				if(key == keyOpts[i].value) {
					keyOpts[i].selected = true;
				}
			}
		}
		
		updateKeyAlias();
		
		var aliasOpts = document.authserver.keyAlias.options;
		var alias = "%value keyAlias encode(javascript)%";
		if (alias != "") {
			for (var i=0; i<aliasOpts.length; i++) {
				if (alias == aliasOpts[i].value) {
					aliasOpts[i].selected = true;
				}
			}
		}
		
		loadTruststoreOptions();
	}
	  
	function updateKeyAlias() {
	  
		var ks = document.authserver.keystoreAlias.options;
		var selectedKS = document.authserver.keystoreAlias.value;
		for(var i=0; i<ks.length; i++) {
			if (selectedKS == ks[i].value) {
				var aliases = hiddenOptions[i];
				document.authserver.keyAlias.options.length = aliases.length;
				for (var j=0;j<aliases.length;j++) {
					var opt = aliases[j];
					document.authserver.keyAlias.options[j] = new Option(opt.text, opt.value);
				}
			}
		}
	}
	
	function loadTruststoreOptions() {
		var ts = document.authserver.truststoreAlias.options

		%invoke wm.server.security.keystore:listTrustStores%
			ts[ts.length] = new Option("","");
		   
			%loop trustStores%
				ts.length=ts.length+1;
				ts[ts.length-1] = new Option("%value keyStoreName encode(javascript)%","%value keyStoreName encode(javascript)%");
			%endloop%
		%endinvoke%
			
		var tsAliasOpts = document.authserver.truststoreAlias.options;
		var tsAlias = "%value truststoreAlias encode(javascript)%";
		if (tsAlias != "") {
			for (var i=0; i<tsAliasOpts.length; i++) {
				if (tsAlias == tsAliasOpts[i].value) {
					tsAliasOpts[i].selected = true;
				}
			}
		}	
	}
	
</SCRIPT>
</HEAD>

<BODY ONLOAD="loadKeyStoresOptions(); setNavigation('security-oauth-authserver.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthAuthServerScrn');">

<FORM NAME="authserver" ACTION="security-oauth-settings.dsp" METHOD="POST">

    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
	<input type="hidden" name="operation" id="operation"/>
	<input type="hidden" name="selectedKS" value="%value keyStore encode(htmlattr)%"/>
<TABLE width="100%">
	<TR>	
    %ifvar action equals('edit')%
        <td class="breadcrumb" colspan="2"> Security &gt; OAuth &gt; External Authorization Server &gt; %value name encode(htmlattr)% &gt; Edit</td>
    %else%
        <td class="breadcrumb" colspan="2"> Security &gt; OAuth &gt; External Authorization Server &gt; Add</td>
    %endif%
	 </TR>
	<TABLE width="50%">
      <TR>
        <TD colspan="2">
          <UL class="listitems">
		    <SCRIPT>createForm("htmlform_security_oauth_settings", "security-oauth-settings.dsp", "POST", "BODY");</SCRIPT>
            <LI>
			<SCRIPT>getURL("security-oauth-settings.dsp","javascript:document.htmlform_security_oauth_settings.submit();","Return to OAuth");</SCRIPT></LI>
          </UL>
        </TD>
      </TR>
	  
      <TR> 
        <TD width="100%">
        <TABLE width="70%" class="tableView">
            <TR> 
				<TD class="heading" colspan="2">External Authorization Server Settings</TD>
			</TR>
			<TR>
				<TD class="oddrow"><label for="name">Name</label></TD>
				<TD class="oddrow-l"><INPUT NAME="name" ID="name" %ifvar action equals('edit')%value="%value name encode(htmlattr)%" readonly%endif%> </TD>
			</TR>
			<TR>
				<TD class="oddrow"><label for="introspection_endpoint">Introspection Endpoint</label></TD>
				<TD class="oddrow-l"><INPUT NAME="introspection_endpoint" ID="introspection_endpoint" %ifvar action equals('edit')%value="%value introspection_endpoint encode(htmlattr)%"%endif%> </TD>
			</TR>
			<TR>
				<TD class="oddrow"><label for="client_id">Client Id</label></TD>
				<TD class="oddrow-l"><INPUT NAME="client_id" ID="client_id" %ifvar action equals('edit')%value="%value client_id encode(htmlattr)%"%endif%> </TD>
			</TR>
			<TR>
				<TD class="oddrow"><label for="client_secret">Client Secret</label></TD>
				<TD class="oddrow-l"><INPUT NAME="client_secret" ID="client_secret" TYPE="password" %ifvar action equals('edit')%value="%value client_secret encode(htmlattr)%"%endif%> </TD> 
			</TR>
			<!-- subUserLookup -->
			<TR>
				<SCRIPT>
					function callback(val){
						document.getElementById('user').value = val;
					}
				</SCRIPT>
				<TD class="oddrow"><label for="user">User</label></TD>
				<TD class="oddrow-l">
					<input name="user" id="user" size=12 value="%value user encode(htmlattr)%"></input>
					<link rel="stylesheet" type="text/css" href="subUserLookup.css" />
					<script type="text/javascript" src="subUserLookup.js"></script>
					<a class="submodal" href="subUserLookup"><img border=0 align="bottom" alt="Select User" src="icons/magnifyglass.png"/></a>
				</TD>
			</TR>
			<!-- End subUserLookup -->
            <TR>
                <TD class="evenrow"><label for="keystoreAlias">Keystore Alias (optional)</label></TD>
                <TD class="evenrowdata-l">
                    <SELECT class="listbox" id="keystoreAlias" name="keystoreAlias" onchange="updateKeyAlias()"></SELECT>
                </TD>
            </TR>
            <TR>
                <TD class="oddrow"><label for="keyAlias">Key Alias (optional)</label></TD>
                <TD class="oddrowdata-l">
                    <SELECT class="listbox" id="keyAlias" name="keyAlias"></SELECT>          
                </TD>
            </TR>
		    <TR>
				<TD class="evenrow"><label for="truststoreAlias">Truststore Alias (optional)</label></TD>
				<TD class="evenrowdata-l">
                    <SELECT class="listbox" id="truststoreAlias" name="truststoreAlias"></SELECT>
				</TD>
		    </TR>
            </TR>
		    <TR>
				<TD class="oddrow"><label for="defaultScope">Default Scope (optional)</label></TD>
				<TD class="oddrow-l">
					<INPUT NAME="defaultScope" ID="defaultScope" %ifvar action equals('edit')%value="%value defaultScope encode(htmlattr)%"%endif%> 
				</TD>
		    </TR>
            <TR>
                <TD colspan="2" class="action">
                    <input type="submit" name="submit" value="Save" onclick="return validateData();">
                </TD>
            </TR>
			
        </TABLE>
	  </TD>
	 </TR>
	 </TABLE>
    </TABLE>
</FORM>
</BODY>   
</HTML>
