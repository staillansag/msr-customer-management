<HTML>
<HEAD>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>     
  <META HTTP-EQUIV="Expires" CONTENT="-1">

  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">  
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%                                                                                                     
  <SCRIPT SRC="webMethods.js"></SCRIPT>
  
  %invoke wm.server.messaging:getConnectionAliasReport%
    
  <SCRIPT LANGUAGE="JavaScript">
    
    /**
     *
     */  
     
    function ValueKeyPress() {
	 var id = document.getElementById("um_id").value;
	 var x = document.getElementById("clientAuthType");
	 var length=x.options.length;
	 if((id.toLowerCase().indexOf("nsps")!=-1||id.toLowerCase().indexOf("nhps")!=-1))
	 {
	  if(length!=3){
	  var option = document.createElement("option");
	  option.text ="Certificate Based";
	  option.value="ssl";
	  x.add(option);
	  }
	  toggleRows();
	  document.getElementById('trustStoreAlias').disabled = false;
	 }else
	 {
	  if(length==3){
	  x.options.remove(2);
	  }
	  toggleRows();
	 //document.getElementById('trustStoreAlias').disabled = true;
	  }
	  
	}
	
    function displaySettings(object) {
		toggleSSL(object.options[object.selectedIndex].value);
    }
    
	function toggleRows() {
		authSetting = document.all.clientAuthType.value;
		switch (authSetting) {
			case 'basic':
			   var id = document.getElementById("um_id").value;
			   if(id.toLowerCase().indexOf("nsps")!=-1 || id.toLowerCase().indexOf("nhps")!=-1)
			   {
			   document.all.basicRow.style.display = '';
			   document.all.sslRowForKs.style.display = 'none';
			   document.all.sslRowForTs.style.display = '';
			  }
			  else
			 {
			   document.all.basicRow.style.display = '';
			   document.all.sslRowForKs.style.display = 'none';
			   document.all.sslRowForTs.style.display = 'none';
			 }
				break;
			case 'ssl':
				document.all.basicRow.style.display = 'none';
				document.all.sslRowForKs.style.display = '';
		        document.all.sslRowForTs.style.display = '';
				break;
			case 'none':
			   var id = document.getElementById("um_id").value;
			   if(id.toLowerCase().indexOf("nsps")!=-1 || id.toLowerCase().indexOf("nhps")!=-1)
			   {
			   document.all.sslRowForTs.style.display = '';
			   document.all.sslRowForKs.style.display = 'none';
			   document.all.basicRow.style.display = 'none';
		       }else
		       {
		       document.all.sslRowForTs.style.display = 'none';
			   document.all.sslRowForKs.style.display = 'none';
			   document.all.basicRow.style.display = 'none';
			   }
				break;	
		}	
	}
   
     function toggleNewRows() 
    {
	 var id = document.getElementById("um_id").value;
	 var x = document.getElementById("clientAuthType");
	 if(id.toLowerCase().indexOf("nsps")==-1 && id.toLowerCase().indexOf("nhps")==-1)
	 {
	 x.options.remove(2);	 
	 }
   }
	
	function toggleSSL(authSetting) {
		toggleRows();
		switch (authSetting) {
			case 'basic':
				document.getElementById('umUser').disabled = false;
				document.getElementById('umPassword').disabled = false;
				document.getElementById('keyStoreAlias').disabled = true;
				document.getElementById('keyAlias').disabled = true;
				var id = document.getElementById("um_id").value;
			   if(id.toLowerCase().indexOf("nsps")!=-1 || id.toLowerCase().indexOf("nhps")!=-1)
			   {
				document.getElementById('trustStoreAlias').disabled = false;
			   }else
			   {
			   document.getElementById('trustStoreAlias').disabled = true;
			   }
			   break;
			break;
			case 'ssl':
				document.getElementById('umUser').disabled = true;
				document.getElementById('umPassword').disabled = true;
				document.getElementById('keyStoreAlias').disabled = false;
				document.getElementById('keyAlias').disabled = false;
				document.getElementById('trustStoreAlias').disabled = false;
			break;
			case 'none':
				document.getElementById('umUser').disabled = true;
				document.getElementById('umPassword').disabled = true;
				document.getElementById('keyStoreAlias').disabled = true;
				document.getElementById('keyAlias').disabled = true;
				if(id.toLowerCase().indexOf("nsps")!=-1 || id.toLowerCase().indexOf("nhps")!=-1)
				{
				    document.getElementById('trustStoreAlias').disabled = false;
				}else
				{
					document.getElementById('trustStoreAlias').disabled = true;
				}
			break;
		}
	}
    
    /**
     *
     */         
    function loadDocument() {
	    //alert("%value certfileType encode(javascript)%");
    
          setNavigation('settings-broker-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_EditUMScrn');
        
          %switch certfileType%

<!-- Trax 1-1RI0MD - 'JKS' is not supported for Keystore type  -->  
<!--    %case 'JKS'% -->
<!--      document.editform.certfileType.selectedIndex=1; -->
        %case 'PKCS12'%
          document.editform.certfileType.selectedIndex=1;
        %end%

        %switch truststoreType%
          %case 'JKS'%
          document.editform.truststoreType.selectedIndex=1;
        %end%
        //isSSLAltered();
      }
    
    /**
     *
     */
    function valueAltered() {
          document.editform.isChanged.value = "true";
      }
    
    /**
     *
       */       
    function isIllegalName(name) {
        // according to Enterprise Server Java Client API Reference Guide
        // '@', '\', '/' are restricted characters
      var illegalChars = "@/\\";

      for (var i=0; i<illegalChars.length; i++) {
        if (name.indexOf(illegalChars.charAt(i)) >= 0)
            return false;
        }
        return true;
    }
    
      /**
       *
       */              
    function confirmEdit() {
    
        if (isblank(document.editform.description.value)) {
              alert ("Description is required.");
              return false;
      }else if ( isblank(document.editform.CLIENTPREFIX.value) ) {
            alert("Client Prefix is required.");
            return false;      
            }else if ( isblank(document.editform.um_rname.value) ) {
              alert ("Realm URL is required.");
          return false;
        }else if ( !isInt(document.editform.um_tryAgainMaxAttempts.value) ) {
            alert ("Maximum Reconnection Attempts must be a positive integer or 0.");
            return false;   
      }else if ( !isInt(document.editform.um_publishWaitTime.value) ) {
            alert("Publish Wait must be a positive integer or 0.");
            return false;
        }else if ( !isIllegalName(document.editform.CLIENTPREFIX.value)) {
         alert("Invalid Client Prefix value.");
            return false;
        }else   if (document.editform.csqSize.value != "" && document.editform.csqSize.value != "-1" && !isInt(document.editform.csqSize.value)) {
        alert("Maximum CSQ Size must be a positive integer, 0, or -1. A value of -1 indicates that the CSQ Size is unlimited.");
        return false;
      }

        var clientAuthType = document.editform.clientAuthType.value;
		var realmUrl = document.editform.um_rname.value;
		//if (clientAuthType != "ssl" && (realmUrl.indexOf("nsps") != -1 || realmUrl.indexOf("nhps") != -1)) {
			//alert("Client Authentication must be set to SSL if Realm URL specifies includes nsps or nhps.");
                //return false;
		//}
        if ( clientAuthType == "basic") {
          if (document.editform.umUser.value.trim() == "" || document.editform.umPassword.value== "") {
              alert("Username and password are required for basic client authentication through Universal Messaging");
                return false;
            }
        }else if ( clientAuthType == "ssl") {
          if (document.editform.keyStoreAlias.value.trim() == "" && document.editform.trustStoreAlias.value.trim() == "") {
              alert("When Client Authentication is set to Certificate Based , Truststore Alias and/or Keystore Alias must be provided.");
                return false;
            }
        }
            //must be a positive integer, 0, or -1. A value of -1 indicates that the CSQ Size is unlimited.

        return true;
      }
      
      /**
     * isInt
     */ 
    function isInt(value) {
      var strValidChars = "0123456789";
      var strChar;
      var blnResult = true;
      for (i = 0; i < value.length && blnResult == true; i++) {
        strChar = value.charAt(i);
        if (strValidChars.indexOf(strChar) == -1) {
          blnResult = false;
        }
      }
      return blnResult;
    }

//certificate based	
	var hiddenOptions = new Array();
	var hiddenOptionsTs = new Array();
      
	      function loadKeyStoresOptions()
	      {
			    var ks = document.editform.keyStoreAlias.options
				var ts = document.editform.trustStoreAlias.options
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
				
			    var keyOpts = document.editform.keyStoreAlias.options;
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
				
				var aliasOpts = document.editform.keyAlias.options;
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
				
				var trustOpts = document.editform.trustStoreAlias.options;
    			var trustKey = "%value encode(javascript) trustStoreAlias%";
				if ( trustKey != "") 
				{
	       			for(var i=0; i<trustOpts.length; i++) 
	       			{
				    	if(trustKey == trustOpts[i].value) {
				    		trustOpts[i].selected = true;
		    			}
			      	}
				}
	      }
	      
	      function changeval() {
       		var ks = document.editform.keyStoreAlias.options;
       		var selectedKS = document.editform.keyStoreAlias.value;
       		for(var i=0; i<ks.length; i++) {
       			if(selectedKS == ks[i].value) {
		       		var aliases = hiddenOptions[i];
       				document.editform.keyAlias.options.length = aliases.length;
       				for(var j=0;j<aliases.length;j++) {
       					var opt = aliases[j];
       					document.editform.keyAlias.options[j] = new Option(opt.text, opt.value);
     				}
       			}
       		}
		}	
  </SCRIPT>
</HEAD>

<body onLoad="loadDocument();loadKeyStoresOptions();">

  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Universal Messaging Connection Alias &gt; Edit</TD>
    </TR>
    <TR>
      <TD colspan="2">
        <ul class="listitems">
          <li class="listitem">
		  <script>
		  createForm("htmlform_settings_wm_um_detail", "settings-wm-um-detail.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_wm_um_detail", "aliasName", "%value aliasName encode(url)%");
		  </script>
		  <script>getURL("settings-wm-um-detail.dsp?aliasName=%value aliasName encode(url)%", "javascript:document.htmlform_settings_wm_um_detail.submit();", "Return to Universal Messaging Connection Alias");</script>
		  
		  </li>
        </UL>
      </TD>
    </TR>
    <TR>
      <TD>
        <FORM name="editform" action="settings-wm-um-detail.dsp" METHOD="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        
         <!--                  -->
         <!-- General Settings -->
         <!--                  -->
         
         <TABLE class="tableView" width="85%">      
          <TR>
            <TD class="heading" colspan=2>General Settings</TD>
          </TR>

          <!-- Connection Alias Name -->
          <TR>
            <TD width="40%" class="oddrow-l" nowrap="true"><label for="aliasName">Connection Alias Name</label></TD>
            <TD class="oddrowdata-l"><INPUT id="aliasName" NAME="aliasName" size="50" value="%value aliasName encode(htmlattr)%" DISABLED></TD>
          </TR>

          <!-- Description -->
          <TR>
            <TD class="evenrow-l"><label for="description">Description</label></TD>
            <TD class="evenrowdata-l"><INPUT id="description" NAME="description" size="50" value="%value description encode(htmlattr)%"></TD>
          </TR>
          
          <!-- Client Prefix -->
          <TR>
            <TD class="oddrow-l"><label for="CLIENTPREFIX">Client Prefix</label></TD>
			<TD class="oddrowdata-l"><INPUT id="CLIENTPREFIX" NAME="CLIENTPREFIX" size="50" value="%value CLIENTPREFIX encode(htmlattr)%" onchange="alert ('Warning! \n\nChanging the Client Prefix results in new durable objects on Universal Messaging for triggers that use the alias. The durable objects that use the old Client Prefix are not automatically removed from Universal Messaging. Old durable objects might contain messages and continue to receive messages.');"></TD> 
          </TR>
          
          <!-- Share Client Prefix -->
          <TR>
            <TD class="evenrow-l"><label for="isClientPrefixShared">Client Prefix Is Shared (prevents removal of shared messaging provider objects)</label></TD>
            <TD class="evenrowdata-l">
              %ifvar isISClustered equals(true)%
                %ifvar isClientPrefixShared equals(true)%
                              <INPUT TYPE="checkbox" disabled="true" id="isClientPrefixShared" NAME="isClientPrefixShared" checked="true" />
                            %else%
                              <INPUT TYPE="checkbox" disabled="true" id="isClientPrefixShared" NAME="isClientPrefixShared" />
                          %endif%
                        %else%
                            %ifvar isClientPrefixShared equals(true)%
                              <INPUT TYPE="checkbox" id="isClientPrefixShared" NAME="isClientPrefixShared" checked="true" />
                            %else%
                              <INPUT TYPE="checkbox" id="isClientPrefixShared" NAME="isClientPrefixShared" />
                          %endif%
                        %endif%
                      </TD>
          </TR>

         </table>
          
          <!--                     -->
          <!-- Connection Settings -->
          <!--                     -->

	  <table class="tableView" width="85%">	  
          
          <TR>
            <TD class="heading" colspan=2>Connection Settings</TD>
          </TR>
          
          <!-- Realm URL -->
          <TR>
            <TD width="40%" class="oddrow-l"><label for="um_id">Realm URL</label></TD>
            <TD class="oddrowdata-l"><INPUT NAME="um_rname" id="um_id" size="50" onChange="ValueKeyPress()" value="%value um_rname encode(htmlattr)%"></TD>
          </TR>

          <TR>
            <TD class="evenrow-l"><label for="um_tryAgainMaxAttempts">Maximum Reconnection Attempts</label></TD>
            <TD class="evenrowdata-l"><INPUT id="um_tryAgainMaxAttempts" NAME="um_tryAgainMaxAttempts" size="50" value="%value um_tryAgainMaxAttempts encode(htmlattr)%"></TD>
          </TR>

	  </table>
          
          <!--                     -->
          <!-- Producer Settings   -->
          <!--                     -->

	  <table class="tableView" width="85%">
          
          <tr>
            <td class="heading" colspan=2>Producer Settings</td>
          </tr>
    
          <!-- Enable CSQ -->
          <TR>
            <TD width="40%" class="oddrow-l"><label for="useCSQ">Enable CSQ</label></TD>
            <TD class="oddrow-l">
              %ifvar useCSQ equals(true)%
                            <INPUT TYPE="checkbox" id="useCSQ" NAME="useCSQ" checked="true" />
                          %else%
                            <INPUT TYPE="checkbox" id="useCSQ" NAME="useCSQ" />
                        %endif%
                      </TD>
              </TR>

          <!-- Maximum CSQ Size -->
          <TR>
            <TD class="evenrow-l"><label for="csqSize">Maximum CSQ Size (messages)</label></TD>
            <TD class="evenrowdata-l"><INPUT id="csqSize" NAME="csqSize" size="50" value="%value csqSize encode(htmlattr)%"></TD>
          </TR>
          
          <!-- Drain CSQ in Order -->
          <TR>
            <TD class="oddrow-l"><label for="csqDrainInOrder">Drain CSQ in Order</label></TD>
            <TD class="oddrowdata-l">
                        %ifvar csqDrainInOrder equals(true)%
                            <INPUT TYPE="checkbox" id="csqDrainInOrder" NAME="csqDrainInOrder" checked="true" />
                          %else%
                            <INPUT TYPE="checkbox" id="csqDrainInOrder" NAME="csqDrainInOrder" />
                        %endif%
                      </TD>
              </TR>     
          
          <!-- Publish Wait Time (while reconnection) -->
          <TR>
            <TD class="evenrow-l"><label for="um_publishWaitTime">Publish Wait Time while Reconnecting (milliseconds)</label></TD>
            <TD class="evenrow-l"><INPUT NAME="um_publishWaitTime" id="um_publishWaitTime" size="50" value="%value um_publishWaitTime encode(htmlattr)%"></TD>
          </TR>
          
          <!-- Include All Envelope Data 
          <TR>
            <TD class="oddrow-l"><label for="includeFullEnvelope">Include All Envelope Fields</label></TD>
            <TD class="oddrowdata-l">
              %ifvar includeFullEnvelope equals(true)%
                <INPUT TYPE="checkbox" id="includeFullEnvelope" NAME="includeFullEnvelope" checked="true" />
              %else%
                <INPUT TYPE="checkbox" id="includeFullEnvelope" NAME="includeFullEnvelope" />
              %endif%
            </TD>
          </TR>   -->
          
          <!-- Follow the Master -->
          <TR>
            <TD class="oddrow-l"><label for="um_followTheMasterForPublish">Enable Follow the Master for Producers</label></TD>
            <TD class="oddrowdata-l">
              %ifvar um_followTheMasterForPublish equals(true)%
                <INPUT TYPE="checkbox" id="um_followTheMasterForPublish" NAME="um_followTheMasterForPublish" checked="true" />
              %else%
                <INPUT TYPE="checkbox" id="um_followTheMasterForPublish" NAME="um_followTheMasterForPublish" />
              %endif%
            </TD>
          </TR>
          
	</table>
          <!--                     -->
          <!-- Consumer Settings   -->
          <!--                     -->

	  <table class="tableView" width="85%">
          
          <tr>
            <td class="heading" colspan=2>Consumer Settings</td>
          </tr>
          
          <!-- Request-Reply -->   
          <TR>
            <TD width="40%" class="oddrow-l"><label for="enableRequestReply">Enable Request-Reply Channel and Listener</label></TD>
            <TD class="oddrowdata-l">
              %ifvar enableRequestReply equals(true)%
                <INPUT TYPE="checkbox" id="enableRequestReply" NAME="enableRequestReply" checked="true" />
              %else%
                <INPUT TYPE="checkbox" id="enableRequestReply" NAME="enableRequestReply" />
              %endif%
            </TD>
          </TR>  
          
          <!-- Follow the Master -->
          <TR>
            <TD class="oddrow-l"><label for="um_followTheMasterForSubscribe">Enable Follow the Master for Consumers</label></TD>
            <TD class="oddrowdata-l">
              %ifvar um_followTheMasterForSubscribe equals(true)%
                <INPUT TYPE="checkbox" id="um_followTheMasterForSubscribe" NAME="um_followTheMasterForSubscribe" checked="true" />
              %else%
                <INPUT TYPE="checkbox" id="um_followTheMasterForSubscribe" NAME="um_followTheMasterForSubscribe" />
              %endif%
            </TD>
          </TR>

	  </table>
          
          <!--                                -->
          <!-- Client Authentication Settings -->
          <!--                                -->

	  <table class="tableView" width="85%">
          
           <TR>
                    <TD class="heading" colspan=2>Client Authentication Settings</TD>
                </TR> 

          <!-- Client Authentication -->
          <TR>
            <TD width="40%" class="oddrow-l"><label for="clientAuthType">Client Authentication</label></TD>
            <TD class="oddrowdata-l">
              <select name="clientAuthType" ID="clientAuthType" onchange="displaySettings(this.form.clientAuthType);valueAltered()">
                        %ifvar clientAuthType equals('none')%
                            <option value="none" selected>NONE</option>
                        %else%
                            <option value="none">NONE</option>
                        %endif%
                        %ifvar clientAuthType equals('basic')%
                            <option value="basic" selected>USERNAME/PASSWORD</option>
                        %else%
                            <option value="basic">USERNAME/PASSWORD</option>
                        %endif%
                        %ifvar clientAuthType equals('ssl')%
                            <option value="ssl" selected>CERTIFICATE BASED</option>
                        %else%
                            <option value="ssl">CERTIFICATE BASED</option>
                        %endif%
                      </select>
            </TD>
          </TR>
        
        <TR ID="basicRow">
        <TD colspan=2 style="margin: 0px; padding: 0px; border-spacing: 0px;">
                <TABLE width="100%">
                  <TR>
                        <TD width="40%" class="evenrow-l"><label for="umUser">Username</label></TD>
					    <TD class="evenrowdata-l"><INPUT NAME="umUser" id="umUser" size=50 VALUE="%value umUser encode(htmlattr)%" onChange="valueAltered()"></TD>
                    </TR>
                    <TR>
                        <TD class="oddrow-l"><label for="umPassword">Password</label></TD>
					   <TD class="oddrowdata-l"><INPUT NAME="umPassword" id="umPassword" size=50 TYPE="password" autocomplete="off" VALUE="%value umPassword encode(htmlattr)%" onChange="valueAltered()"/></TD>
                    </TR>
                  </TABLE>
        </TD>
        </TR>          
		
        <TR ID="sslRowForTs">
		<TD colspan=2 style="margin: 0px; padding: 0px; border-spacing: 0px;">
			    <TABLE width="100%">
				<TR>
				<TD  width="40%"  class="evenrow-l"><label for="trustStoreAlias">Truststore Alias</label></TD>
				<TD class="evenrowdata-l">
					<SELECT class="listbox" name="trustStoreAlias" id="trustStoreAlias" style="width: 270px;"></SELECT>
		        </TD>
				</TR>			   
				</TABLE>
		</TD>
		</TR>
		
		<TR ID="sslRowForKs">
		<TD colspan=2 style="margin: 0px; padding: 0px; border-spacing: 0px;">
			    <TABLE width="100%">
				<TR>
				<TD width="40%" class="evenrow-l"><label for="keyStoreAlias">Keystore Alias</label></TD>
				<TD class="evenrowdata-l">
					<SELECT class="listbox" name="keyStoreAlias" id="keyStoreAlias" onchange="changeval()" style="width: 270px;"></SELECT>
		        </TD>
			    </TR>
			  <TR>
			   	<TD class="oddrow-l"><label for="keyAlias">Key Alias</label></TD>
			    <TD class="oddrowdata-l">
		        	<select class="listbox" name="keyAlias" id="keyAlias" style="width: 270px;" ></select>  		
		        </TD>
			   </TR>			   
			   </TABLE>
		</TD>
		</TR>
          
          
         </table>
         
         
         <table class="tableView" width="85%">
          
          <tr>
            <td class="heading" colspan=2>Enhanced Logging</td>
          </tr>

          <TR>
            <TD width="40%" class="oddrow-l"><label for="um_loggingOutput">Logging Type</label></TD>
            <TD class="oddrowdata-l">
              <select id="um_loggingOutput" name="um_loggingOutput">
                        %ifvar um_loggingOutput equals('0')%
                            <option value="0" selected>SERVER LOG</option>    
                        %else%
                            <option value="0">SERVER LOG</option>
                        %endif%
                        %ifvar um_loggingOutput equals('1')%
                            <option value="1" selected>MESSAGING AUDIT LOG</option>
                        %else%
                            <option value="1">MESSAGING AUDIT LOG</option>
                        %endif%
              </select>
            </TD>            
          </TR> 
  
          <TR>
            <TD width="40%" class="oddrow-l"><label for="um_producerMessageTracking">Enable Producer Message ID Tracking</label></TD>
            <TD class="oddrowdata-l">
              %ifvar um_producerMessageTracking equals(true)%
                <INPUT TYPE="checkbox" id="um_producerMessageTracking" NAME="um_producerMessageTracking" checked="true" />       
              %else%
                <INPUT TYPE="checkbox" id="um_producerMessageTracking" NAME="um_producerMessageTracking" />
              %endif%                                                                             
            </TD>
          </TR>  
          <TR>
            <TD class="oddrow-l"><label for="um_producerIncludedStrings">Producer Message ID Tracking: Include Channels (semicolon delimited)</label></TD>
            <TD class="oddrowdata-l">
              <INPUT id="um_producerIncludedStrings" NAME="um_producerIncludedStrings" size="50" value="%value um_producerIncludedStrings encode(htmlattr)%">
            </TD>
          </TR>
 
          <!-- -->
          <TR>
            <TD class="oddrow-l"><label for="um_consumerMessageTracking">Enable Consumer Message ID Tracking</label></TD>
            <TD class="oddrowdata-l"> 
              %ifvar um_consumerMessageTracking equals(true)%
                <INPUT TYPE="checkbox" id="um_consumerMessageTracking" NAME="um_consumerMessageTracking" checked="true" />        
              %else%
                <INPUT TYPE="checkbox" id="um_consumerMessageTracking" NAME="um_consumerMessageTracking" />
              %endif%
            </TD>
          </TR>
          <TR>
            <TD class="oddrow-l"><label for="um_consumerIncludedStrings">Consumer Message ID Tracking: Include Triggers (semicolon delimited)</label></TD>
            <TD class="oddrowdata-l">
              <INPUT id="um_consumerIncludedStrings" NAME="um_consumerIncludedStrings" size="50" value="%value um_consumerIncludedStrings encode(htmlattr)%">
            </TD>
          </TR>
	       </table>

         <TABLE class="tableView" width="85%">
               <TR>
               <TD class="action" class="row" width="40%">
                 <INPUT TYPE="hidden" NAME="action" VALUE="edit">
        	     <INPUT TYPE="hidden" NAME="aliasName" VALUE="%value aliasName encode(htmlattr)%">
                 <INPUT TYPE="hidden" NAME="type" VALUE="UM">
                 <INPUT type="submit" value="Save Changes" onClick="javascript:return confirmEdit()">
               </TD>
             </TR>
         </table>
         
        %endinvoke%
        <SCRIPT>
					toggleRows();
					toggleNewRows();
                    if(document.editform.clientAuthType.value == "none") {
                    document.getElementById('umUser').disabled = true;
                    document.getElementById('umPassword').disabled = true;					
        }

        </SCRIPT>
        </FORM>
      </TD>
    </TR>
  </TABLE>
</BODY>
</HTML>