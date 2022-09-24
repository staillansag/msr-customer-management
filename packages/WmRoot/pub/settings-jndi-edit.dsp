<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js"></script>
  
  %invoke wm.server.jndi:getJNDIAliasData%
  
  <script language ="javascript">
  
    var jndiContext = '';
    var jndiUrl = '';
    var jndiPrincipal = '';
    var jndiCredentials = '';
    var jndiOther = '';

    function saveCurrent() {
      
      jndiContext = "%value initialContextFactory encode(javascript)%";
                            
      jndiUrl = "%value providerURL encode(javascript)%";
      jndiPrincipal = "%value securityPrincipal encode(javascript)%";
      jndiCredentials = "%value securityCredentials encode(javascript)%";
      jndiOther = "%value otherProps encode(javascript)%";
    }
    
    %invoke wm.server.jndi:getJNDIAliasTemplates%
    
    function setJNDIFields(selected) {
    
      %ifvar templates%
        %loop templates%
          if (selected.value == "%value name encode(javascript)%") {
            document.jndiForm.initialContextFactory.value = "%value context encode(javascript)%";
            document.jndiForm.providerURL.value = "%value url encode(javascript)%";
            document.jndiForm.securityPrincipal.value = '';
            document.jndiForm.securityCredentials.value = '';
            document.jndiForm.otherProps.value = "%value otherProps encode(javascript)%";
          }
        %endloop%
      %endif%
      
      if (selected.value == 'jndiFormCurrent') {
        document.jndiForm.initialContextFactory.value = jndiContext;
        document.jndiForm.providerURL.value = jndiUrl;
        document.jndiForm.securityPrincipal.value = jndiPrincipal;
        document.jndiForm.securityCredentials.value = jndiCredentials;
        document.jndiForm.otherProps.value = jndiOther;
      }
      
    }
    
    function validateForm(obj) {
      
      if (obj.description.value == "") {
        alert("Description must be specified");
        return false;
      }
      
      if (obj.initialContextFactory.value == "") {
        alert("Initial Context Factory must be specified");
        return false;
      }
      
      if (obj.providerURL.value == "") {
        alert("Provider URL must be specified");
        return false;
      }
	  var ssl = document.jndiForm.isSSL.value;
		if (ssl == 'Yes') {
			var ks = document.jndiForm.keyStoreAlias.value;
			var ts = document.jndiForm.trustStoreAlias.value;
			if (ks == "" && ts == "") {
				alert("SSL option is set to Yes, please select either a truststore alias or a keystore alias.");
				return false;
			}
			if (ts != "") {
				if (document.getElementById('trustStoreProp').value.trim() == "") {
					alert("You have selected the truststore alias, please specify the JNDI property name for the truststore location.");
					document.getElementById('trustStoreProp').focus();
					return false;
				}
				if (document.getElementById('trustStorePwdProp').value.trim() == "") {
					alert("You have selected the truststore alias, please specify the JNDI property name for the truststore password.");
					document.getElementById('trustStorePwdProp').focus();
					return false;
				}
			}
			if (ks != "") {
				if (document.getElementById('keyStoreProp').value.trim() == "") {
					alert("You have selected the keystore alias, please specify the JNDI property name for the keystore location.");
					document.getElementById('keyStoreProp').focus();
					return false;
				}
				if (document.getElementById('keyStorePwdProp').value.trim() == "") {
					alert("You have selected the keystore alias, please specify the JNDI property name for the keystore password.");
					document.getElementById('keyStorePwdProp').focus();
					return false;
				}
			}
		}

      return true;
    }
	
	//certificate based	
	var hiddenOptions = new Array();
	var hiddenOptionsTs = new Array();
      
	      function loadKeyStoresOptions()
	      {
			    var ks = document.jndiForm.keyStoreAlias.options
				var ts = document.jndiForm.trustStoreAlias.options
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
			       			ts.length=ts.length+1;
				       		ts[ts.length-1] = new Option("%value encode(javascript) keyStoreName%","%value encode(javascript) keyStoreName%");
			           		var aliases = new Array();
				       		hiddenOptionsTs[ts.length-1] = aliases;
		       	   %endloop%
			    %endinvoke%
				
				var keyOpts = document.jndiForm.trustStoreAlias.options;
    			var key = "%value encode(javascript) trustStoreAlias%";
				if ( key != "") 
				{
	       			for(var i=0; i<keyOpts.length; i++) 
	       			{
				    	if(key == keyOpts[i].value) {
				    		keyOpts[i].selected = true;
		    			}
			      	}
				}
				
			    var keyOpts = document.jndiForm.keyStoreAlias.options;
    			var key = "%value encode(javascript) keyStoreAlias%";
				if ( key != "") 
				{
	       			for(var i=0; i<keyOpts.length; i++) 
	       			{
				    	if(key == keyOpts[i].value) {
				    		keyOpts[i].selected = true;
		    			}
			      	}
				}
				
				changeval();
				
				var aliasOpts = document.jndiForm.keyAlias.options;
    			var alias = '%value encode(javascript) keyAlias%';
				if ( alias != "") 
				{
	       			for(var i=0; i<aliasOpts.length; i++) 
	       			{
				    	if(alias == aliasOpts[i].value) {
				    		aliasOpts[i].selected = true;
		    			}
			      	}
				}
	      }
	      
	      function changeval() {
       		var ks = document.jndiForm.keyStoreAlias.options;
       		var selectedKS = document.jndiForm.keyStoreAlias.value;
       		for(var i=0; i<ks.length; i++) {
       			if(selectedKS == ks[i].value) {
		       		var aliases = hiddenOptions[i];
       				document.jndiForm.keyAlias.options.length = aliases.length;
       				for(var j=0;j<aliases.length;j++) {
       					var opt = aliases[j];
       					document.jndiForm.keyAlias.options[j] = new Option(opt.text, opt.value);
     				}
       			}
       		}
		}
		
		function toggleSSL() {
			var ssl = document.jndiForm.isSSL.value;
			if (ssl == 'Yes') {
				document.getElementById('keyStoreAlias').disabled = false;
				document.getElementById('trustStoreAlias').disabled = false;
				document.getElementById('keyAlias').disabled = false;
				document.getElementById('keyStoreProp').disabled = false;
				document.getElementById('keyStorePwdProp').disabled = false;
				document.getElementById('keyStoreFormatProp').disabled = false;
				document.getElementById('privateKeyProp').disabled = false;
				document.getElementById('trustStoreProp').disabled = false;
				document.getElementById('trustStorePwdProp').disabled = false;
				document.getElementById('ssl').style.display = '';
			} else {				
				document.getElementById('keyStoreAlias').disabled = true;
				document.getElementById('trustStoreAlias').disabled = true;
				document.getElementById('keyAlias').disabled = true;
				document.getElementById('keyStoreProp').disabled = true;
				document.getElementById('keyStorePwdProp').disabled = true;
				document.getElementById('keyStoreFormatProp').disabled = true;
				document.getElementById('privateKeyProp').disabled = true;
				document.getElementById('trustStoreProp').disabled = true;
				document.getElementById('trustStorePwdProp').disabled = true;
				document.getElementById('ssl').style.display = 'none';
			}
		}
		
		function populateUMSSLProperties() {
			var initialContextFactory = document.jndiForm.initialContextFactory.value;
			if (initialContextFactory == "com.pcbsys.nirvana.nSpace.NirvanaContextFactory") {
			var ks = document.jndiForm.keyStoreAlias.value;
			var ts = document.jndiForm.trustStoreAlias.value;			
				if (ts != "") {
						document.getElementById('trustStoreProp').value = "nirvana.ssl.truststore.path";
						document.getElementById('trustStorePwdProp').value = "nirvana.ssl.truststore.pass";
				} else {
						document.getElementById('trustStoreProp').value = "";
						document.getElementById('trustStorePwdProp').value = "";
				}
				if (ks != "") {
					document.getElementById('keyStoreProp').value = "nirvana.ssl.keystore.path";
					document.getElementById('keyStorePwdProp').value = "nirvana.ssl.keystore.pass";
					document.getElementById('privateKeyProp').value = "nirvana.ssl.keystore.cert";
				} else {
					document.getElementById('keyStoreProp').value = "";
					document.getElementById('keyStorePwdProp').value = "";
					document.getElementById('privateKeyProp').value = "";
				}
			} else {
				document.getElementById('trustStoreProp').value = "";
				document.getElementById('trustStorePwdProp').value = "";
				document.getElementById('keyStoreProp').value = "";
				document.getElementById('keyStorePwdProp').value = "";
				document.getElementById('privateKeyProp').value = "";
			}
		}
        
  </script>
  
  
</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JNDIaliasEditScrn'); saveCurrent(); loadKeyStoresOptions();">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JNDI Settings &gt; JNDI Provider Alias &gt; Edit</td>
    </tr>

    %ifvar action equals('edit')%
      %invoke wm.server.dispatcher.adminui:setBrokerSettings%    
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td class="message" colspan=2>%value message encode(html)%</td>
      </tr>
      %endinvoke%
    %endif%

    <tr>
      <td colspan="2">
        <ul class="listitems">
          <li class="listitem">
		  <script>
		  createForm("htmlform_settings_jndi_detail", "settings-jndi-detail.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_jndi_detail", "jndiAliasName", "%value jndiAliasName%");
		  </script>
		  <script>getURL("settings-jndi-detail.dsp?jndiAliasName=%value jndiAliasName encode(url)%", "javascript:document.htmlform_settings_jndi_detail.submit();", "Return to JNDI Provider Alias Detail");</script>
		  </li>
        </ul>
      </td>
    </tr>
    
    <form name="jndiForm" action="settings-jndi-detail.dsp" METHOD="POST">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

    <tr>
      <td>
        <table class="tableView" width="100%"> 
          <tr>
            <td class="heading" colspan=2>JNDI Provider Alias</td>
          </tr>
 
          <tr>
            <td class="oddrow-l" width="25%"><label for="jndiAliasName">JNDI Alias Name</label></td>
            <td class="oddrowdata-l"><INPUT NAME="jndiAliasName" id="jndiAliasName" size="70" value="%value aliasName encode(htmlattr)%" DISABLED></td>
          </tr>
          <tr>
            <td class="evenrow-l"><label for="description">Description</label></td>
            <td class="evenrowdata-l"><INPUT NAME="description" id="description" size="70" value="%value description encode(htmlattr)%"></td>
          </tr>
          <tr>
            <td class="oddrow-l"><label for="useTemplate">Predefined JNDI Templates</label></td>
            <td class="oddrowdata-l">
          <select name="useTemplate" id="useTemplate" onChange="setJNDIFields(this.form.useTemplate);populateUMSSLProperties()">
            <option value="jndiFormCurrent">Current Settings</option>
            %ifvar templates%
              %loop templates%
	            <option value="%value name encode(htmlattr)%">%value name encode(html)%</option>
              %endloop%
            %endif%
          </select>
            </td>
          </tr>
          
          <tr>
            <td class="evenrow-l" nowrap><label for="initialContextFactory">Initial Context Factory</label></td>
            <td class="evenrowdata-l"><INPUT NAME="initialContextFactory" id="initialContextFactory" size="70" value="%value initialContextFactory encode(htmlattr)%" onblur="populateUMSSLProperties()"></td>
          </tr> 
          
          <tr>
            <td class="oddrow-l"><label for="providerURL">Provider URL</label></td>
            <td class="oddrowdata-l"><INPUT NAME="providerURL" id="providerURL" size="70" value="%value providerURL encode(htmlattr)%"></td>
          </tr> 
          
          <tr>
            <td class="evenrow-l"><label for="providerURLFailoverList">Provider URL Failover List</label></td>
            <td class="evenrowdata-l"><textarea name="providerURLFailoverList" id="providerURLFailoverList" rows="3" cols="70">%value providerURLFailoverList encode(html)%</textarea></td>
          </tr> 
          
          <tr>
            <td class="oddrow-l"><label for="securityPrincipal">Security Principal</label></td>
            <td class="oddrowdata-l"><INPUT NAME="securityPrincipal" id="securityPrincipal" size="70" value="%value securityPrincipal encode(htmlattr)%"></td>
          </tr> 
          
          <tr>
            <td class="evenrow-l"><label for="securityCredentials">Security Credentials</label></td>
            <td class="evenrowdata-l">
                  <INPUT NAME="securityCredentials" id="securityCredentials" type="password" autocomplete="off"  size="70"  value="%ifvar securityCredentials%******%endif%" onChange="javascript:document.jndiForm.passwordChanged.value=true;"/>
              </td>
          </tr> 
          
          <tr>
            <td class="oddrow-l"><label for="otherProps">Other Properties</label></td>
            <td class="oddrowdata-l"><textarea name="otherProps" id="otherProps" rows="3" cols="70">%value otherProps encode(html)%</textarea></td>
          </tr> 
		  <tr>
            <td class="oddrow-l"><label for="securityPrincipal">Use SSL</label></td>
            <td class="oddrowdata-l">
				<label><INPUT TYPE="radio" name="isSSL" value="No" onChange="toggleSSL()" checked />No</label>
				<label><INPUT TYPE="radio" name="isSSL" value="Yes" onChange="toggleSSL()" %ifvar trustStoreAlias -notempty%checked%else%%ifvar keyStoreAlias -notempty%checked%endif%%endif%/>Yes</label>				
			</td>
          </tr>		  
            
        </table>   
		
		<table class="tableView" width="100%" id="ssl">	  
          
           <TR>
             <TD class="heading" colspan=2>SSL Settings</TD>
           </TR> 
	         		
		<TR ID="sslRowForTs">
				<TD  class="evenrow-l" width="25%"><label for="trustStoreAlias">Truststore Alias</label></TD>
				<TD class="evenrowdata-l">
					<SELECT class="listbox" name="trustStoreAlias" id="trustStoreAlias" style="width: 270px;" disabled onchange="populateUMSSLProperties()"></SELECT>
		        </TD>
		</TD>
		</TR>
		
		<TR ID="sslRowForKs">
				<TD class="oddrow-l"><label for="keyStoreAlias">Keystore Alias</label></TD>
				<TD class="oddrowdata-l">
					<SELECT class="listbox" name="keyStoreAlias" id="keyStoreAlias"  onchange="changeval();populateUMSSLProperties()" style="width: 270px;" disabled></SELECT>
		        </TD>
			    </TR>
			    <TR>
			   	<TD class="evenrow-l"><label for="keyAlias">Key Alias</label></TD>
			    <TD class="evenrowdata-l">
		        	<select class="listbox" name="keyAlias" id="keyAlias" style="width: 270px;" disabled></select>  		
		</TD>
		</TR>
		
		<!-- JNDI properties for SSSL -->
		<tr>
            <td class="heading" colspan=2>JNDI Property Names (JNDI Provider Specific)</td>
          </tr>
		<tr>
            <td class="oddrow-l"><label for="trustStoreProp">Truststore Property Name</label></td>
            <td class="oddrowdata-l"><INPUT NAME="trustStoreProp" id="trustStoreProp" size="70" value="%value trustStoreProp encode(htmlattr)%" disabled><br/>
			<label style="color: #A9A9A9;">(For example, for Universal Messaging: nirvana.ssl.truststore.path)</label></td>
          </tr>
          <tr>
            <td class="evenrow-l"><label for="trustStorePwdProp">Truststore Password Property Name</label></td>
            <td class="evenrowdata-l"><INPUT NAME="trustStorePwdProp" id="trustStorePwdProp" size="70" value="%value trustStorePwdProp encode(htmlattr)%" disabled><br/>
			<label style="color: #A9A9A9;">(For example, for Universal Messaging: nirvana.ssl.truststore.pass)</label></td>
          </tr>  
		<tr>
            <td class="oddrow-l"><label for="keyStoreProp">Keystore Property Name</label></td>
            <td class="oddrowdata-l"><INPUT NAME="keyStoreProp" id="keyStoreProp" size="70" value="%value keyStoreProp encode(htmlattr)%" disabled><br/>
			<label style="color: #A9A9A9;">(For example, for Universal Messaging: nirvana.ssl.keystore.path)</label></td>
          </tr>
          <tr>
            <td class="evenrow-l"><label for="keyStorePwdProp">Keystore Password Property Name</label></td>
            <td class="evenrowdata-l"><INPUT NAME="keyStorePwdProp" id="keyStorePwdProp" size="70" value="%value keyStorePwdProp encode(htmlattr)%" disabled><br/>
			<label style="color: #A9A9A9;">(For example, for Universal Messaging: nirvana.ssl.keystore.pass)<label></td>
          </tr>
		  		  <tr>
            <td class="oddrow-l"><label for="keyStoreFormatProp">Keystore Format Property Name</label></td>
            <td class="oddrowdata-l"><INPUT NAME="keyStoreFormatProp" id="keyStoreFormatProp" size="70" value="%value keyStoreFormatProp encode(htmlattr)%" disabled></td>
          </tr>
		  <tr>
            <td class="evenrow-l"><label for="privateKeyProp">Private Key Property Name</label></td>
            <td class="evenrowdata-l"><INPUT NAME="privateKeyProp" id="privateKeyProp" size="70" value="%value privateKeyProp encode(htmlattr)%" disabled><br/>
			<label style="color: #A9A9A9;">(For example, for Universal Messaging: nirvana.ssl.keystore.cert)</label></td>
          </tr>
		  
		  %onerror%
            <tr>
              <td class="message" colspan=2>%value errorMessage encode(html)%<br>%value error encode(html)% at %value errorService encode(html)%<br></td>
            </tr>
          %endinvoke%
          
          %onerror%
            <tr>
              <td class="message" colspan=2>%value errorMessage encode(html)%<br>%value error encode(html)% at %value errorService encode(html)%<br></td>
            </tr>          
          		%endinvoke%


		</table>
        
        <!-- Submit Button -->
        
        <TABLE class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>
                
                <input name="action" type="hidden" value="edit">
        <input name="passwordChanged" type="hidden" value="false">
                <input name="jndiAliasName" type="hidden" value="%value jndiAliasName encode(htmlattr)%">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">
                
                <!-- <A HREF="settings-jms-detail.dsp?aliasName=%value aliasName encode(url)%"> -->
                
              </td>
            </tr>
        
        </table>
      </td>
    </tr>
    
    </form>
    <script>
	var ssl = document.jndiForm.isSSL.value;
	if (ssl == 'Yes') {
				document.getElementById('keyStoreAlias').disabled = false;
				document.getElementById('trustStoreAlias').disabled = false;
				document.getElementById('keyAlias').disabled = false;
				document.getElementById('keyStoreProp').disabled = false;
				document.getElementById('keyStorePwdProp').disabled = false;
				document.getElementById('keyStoreFormatProp').disabled = false;
				document.getElementById('privateKeyProp').disabled = false;
				document.getElementById('trustStoreProp').disabled = false;
				document.getElementById('trustStorePwdProp').disabled = false;
				document.getElementById('ssl').style.display = '';
			} else {				
				document.getElementById('keyStoreAlias').disabled = true;
				document.getElementById('trustStoreAlias').disabled = true;
				document.getElementById('keyAlias').disabled = true;
				document.getElementById('keyStoreProp').disabled = true;
				document.getElementById('keyStorePwdProp').disabled = true;
				document.getElementById('keyStoreFormatProp').disabled = true;
				document.getElementById('privateKeyProp').disabled = true;
				document.getElementById('trustStoreProp').disabled = true;
				document.getElementById('trustStorePwdProp').disabled = true;
				document.getElementById('ssl').style.display = 'none';
			}
	</script>
  </table>
</body>
</html>
