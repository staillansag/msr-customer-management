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
  
  <SCRIPT LANGUAGE="JavaScript">
    /**
     *
     */         
    function displayTrustore(flag) {
      if ( flag == "true") {
            document.all.divtruststore.style.display = 'block';
        }else{
            document.all.divtruststore.style.display = 'none';
        }
    }
    
    /**
     *
     */  
    function displaySettings(object) {
      if (object.options[object.selectedIndex].value == "basic") {
        document.all.divbasic.style.display = 'block';
        document.all.divssl.style.display = 'none';   
        document.createform.isEncrypted[1].disabled = false;         
      }else if (object.options[object.selectedIndex].value == "ssl") {
        document.all.divbasic.style.display = 'none';
        document.all.divssl.style.display = 'block';
        document.createform.isEncrypted[0].checked = true;
        document.createform.isEncrypted[1].disabled = true;
        displayTrustore('true');
      }else {
        document.all.divbasic.style.display = 'none';
        document.all.divssl.style.display = 'none';
        document.createform.isEncrypted[1].disabled = false;
      }
    }
    
    /**
     *
     */         
    function loadDocument() {
          setNavigation('settings-broker-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_CreateBrokerScrn');
      }
    
    /**
     *
     */
    function valueAltered() {
          document.createform.isChanged.value = "true";
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
    function confirmCreate() {
        
      if (isblank(document.createform.aliasName.value)) {
              alert ("Connection Alias Name is required.");
              return false;
            }else if (isblank(document.createform.description.value)) {
              alert ("Description is required.");
              return false;
      }else if ( isblank(document.createform.CLIENTPREFIX.value) ) {
            alert("Client Prefix is required.");
            return false;      
      }else if (isblank(document.createform.brokerHost.value)) {
              alert ("Broker Host is required.");
              return false;
            }else if ( isblank(document.createform.brokerName.value) ) {
              alert ("Broker Name is required.");
          return false;
        }else if ( isblank(document.createform.clientGroupName.value) ) {
            alert ("Client Group is required.");
            return false;
        }else if ( !isblank(document.createform.CLIENTPREFIX.value) &&
         !isIllegalName(document.createform.CLIENTPREFIX.value)) {
         alert("Invalid Client Prefix value:\nRefer to Enterprise Server Java API Client Reference Guide for restricted characters.");
            return false;
        }
            
            //Client authentication Basic check
        if ( document.createform.clientAuth.value == "basic") {
          if (document.createform.brokerUser.value == "" || document.createform.brokerPassword.value == "") {
              alert("Broker username and password are required for Basic client authentication");
                return false;
            }
        }
            
        //Client authentication SSL check
          if ( document.createform.clientAuth.value == "ssl") {
          if (document.createform.certfile.value == "" || document.createform.certfileType.value == "" || document.createform.password.value == "") {
              alert("Keystore file, type and password are required for SSL client authentication");
                return false;
            }
        }
            
          if ( document.createform.isEncrypted[0].checked == true) {
            if (document.createform.truststore.value == "" || document.createform.truststoreType.value == "") {
                alert("Truststore file and type are required for encryption");
                return false;
            }
        }
          
      //document.createform.submit();
          //  return true;
            
        //}else {
        //  document.createform.submit();
        //  return true;
        //}
        
        return true;
      }
  
  </SCRIPT>
</HEAD>

<body onLoad="loadDocument();">

  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Broker Connection Alias &gt; Create</TD>
    </TR>
    <TR>
      <TD colspan="2">
        <ul class="listitems">
          <li class="listitem">
		  <script>
		  createForm("htmlform_settings_wm_messaging", "settings-wm-messaging.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("settings-wm-messaging.dsp","javascript:document.htmlform_settings_wm_messaging.submit();","Return to webMethods Messaging Settings")</script>
		  </li>
        </UL>
      </TD>
    </TR>
    <TR>
      <TD>
        <FORM name="createform" action="settings-wm-messaging.dsp" METHOD="POST">
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
            <TD class="oddrowdata-l"><INPUT NAME="aliasName" ID="aliasName" size="50"></TD>
          </TR>

          <!-- Description -->
          <TR>
            <TD class="evenrow-l"><label for="description">Description</label></TD>
            <TD class="evenrowdata-l"><INPUT NAME="description" ID="description" size="50"></TD>
          </TR>
          
          <!-- Client Prefix -->
          <TR>
            <TD class="oddrow-l"><label for="CLIENTPREFIX">Client Prefix</label></TD>
            <TD class="oddrowdata-l"><INPUT NAME="CLIENTPREFIX" ID="CLIENTPREFIX" size="50" value="%value CLIENTPREFIX encode(htmlattr)%"></TD>
          </TR>
          
          <!-- Share Client Prefix -->
          <TR>
            <TD class="evenrow-l">Client Prefix Is Shared (prevents removal of shared messaging provider objects)</TD>
            <TD class="evenrowdata-l">
              %ifvar isISClustered equals(true)%
                            <INPUT TYPE="radio" NAME="isISClustered" ID="isISClustered1" VALUE="true" checked disabled onChange="valueAltered()"><label for="isISClustered1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isISClustered" ID="isISClustered2" VALUE="false" disabled onChange="valueAltered()"><label for="isISClustered2">No</label></INPUT>
                        %else%
                            %ifvar isClientPrefixShared equals(true)%               
                                <INPUT TYPE="radio" NAME="isClientPrefixShared" ID="isISClustered1" VALUE="true" checked onChange="valueAltered()"><label for="isISClustered1">Yes</label></INPUT>
                                <INPUT TYPE="radio" NAME="isClientPrefixShared" ID="isISClustered2" VALUE="false" onChange="valueAltered()"><label for="isISClustered2">No</label></INPUT>
                            %else%
                                <INPUT TYPE="radio" NAME="isClientPrefixShared" ID="isISClustered1" VALUE="true" onChange="valueAltered()"><label for="isISClustered1">Yes</label></INPUT>
                                <INPUT TYPE="radio" NAME="isClientPrefixShared" ID="isISClustered2" VALUE="false" checked onChange="valueAltered()"><label for="isISClustered2">No</label></INPUT>
                            %endif% 
                        %endif%
                      </TD>
          </TR>

	  </table>
	  <table class="tableView" width="85%">
          <!--                     -->
          <!-- Connection Settings -->
          <!--                     -->
         
          <TR>
            <TD class="heading" colspan=2>Connection Settings</TD>
          </TR>

          <!-- Broker Host -->
          <TR>
            <TD width="40%" class="oddrow-l"><label for="brokerHost">Broker Host</label></TD>
            <TD class="oddrowdata-l"><INPUT NAME="brokerHost" ID="brokerHost" size="50" value="localhost:6849"></TD>
          </TR>
          
          <!-- Broker Name -->
          <TR>
            <TD class="evenrow-l"><label for="brokerName">Broker Name</label></TD>
            <TD class="evenrowdata-l"><INPUT NAME="brokerName" ID="brokerName" size="50" value="Broker #1"></TD>
          </TR>
          
          <!-- Client Group -->
          <TR>
            <TD class="oddrow-l"><label for="clientGroupName">Client Group</label></TD>
            <TD class="oddrowdata-l"><INPUT NAME="clientGroupName" ID="clientGroupName" size="50" value="IntegrationServer"></TD>
          </TR>

	  </table>
	  <table class="tableView" width="85%">
          
          <!--                                -->
          <!-- Client Authentication Settings -->
          <!--                                -->
            
           <TR>
                    <TD class="heading" colspan=3>Client Authentication Settings</TD>
                </TR> 

          <!-- Client Authentication -->
          <TR>
            <TD width="40%" class="oddrow-l"><label for="clientAuth">Client Authentication</label></TD>
            <TD class="oddrowdata-l">
              <select name="clientAuth" ID="clientAuth" onchange="displaySettings(this.form.clientAuth);valueAltered()">
                        %ifvar clientAuth equals('none')%
                            <option value="none" selected>None</option>
                        %else%
                            <option value="none">None</option>
                        %endif%
                        %ifvar clientAuth equals('basic')%
                            <option value="basic" selected>Username/Password</option>
                        %else%
                            <option value="basic">Username/Password</option>
                        %endif%
                        %ifvar clientAuth equals('ssl')%
                            <option value="ssl" selected>SSL</option>
                        %else%
                            <option value="ssl">SSL</option>
                        %endif%
                      </select>
            </TD>
          </TR>
         </table>
        
         <!-- (DIV) Basic Auth -->
         %ifvar clientAuth equals('basic')%
                 <DIV id="divbasic" STYLE="display: block">
               %else%
                 <DIV id="divbasic" STYLE="display: none">
               %endif%
                <TABLE class="tableView" width="85%">
                  <TR>
                        <TD width="40%" class="evenrow-l"><label for="brokerUser">Username</label></TD>
					    <TD class="evenrowdata-l"><INPUT NAME="brokerUser" ID="brokerUser" VALUE="%value brokerUser encode(htmlattr)%" onChange="valueAltered()"></TD>
                    </TR>
                    <TR>
                        <TD class="oddrow-l"><label for="brokerPassword">Password</label></TD>
					   <TD class="oddrowdata-l"><INPUT NAME="brokerPassword" ID="brokerPassword" TYPE="password" autocomplete="off" VALUE="%value brokerPassword encode(htmlattr)%" onChange="valueAltered()"/></TD>
                    </TR>
                  </table>
               </DIV>
              
               <!-- (DIV) SSL Auth -->
               %ifvar clientAuth equals('ssl')%
                 <DIV id="divssl" STYLE="display: block">
               %else%
                 <DIV id="divssl" STYLE="display: none">
               %endif%  
                   <TABLE class="tableView" width="85%">
                     <TR>
                        <TD width="40%" class="evenrow-l"><label for="certfile">Keystore</label></TD>
			 		    <TD class="evenrowdata-l"><INPUT NAME="certfile" ID="certfile" VALUE="%value certfile encode(htmlattr)%" onChange="valueAltered()"></TD>
                    </TR>
                    <TR>
                        <TD class="oddrow-l"><label for="certfileType">Keystore Type</label></TD>
                        <TD class="oddrowdata-l">
                            <select name="certfileType" ID="certfileType" onChange="valueAltered()">
                              <option value=""></option>
                   <option value="PKCS12" >PKCS12</option>
                 </select>
                        </TD>
                    </TR>
                    <TR>
                        <TD class="evenrow-l"><label for="password">Keystore Password</label></TD>
		     			<TD class="evenrowdata-l"><INPUT NAME="password" ID="password" TYPE="password" autocomplete="off" value="%value password encode(htmlattr)%" onChange="valueAltered()"/></TD>
                    </TR>
                 </table>
               </DIV>
               
               <!--                     -->
               <!-- Encryption Settings -->
               <!--                     -->
               
               <TABLE class="tableView" width="85%">
                 <TR>
                    <TD class="heading" colspan=2>Encryption Settings</TD>
                </TR>
                <script>swapRows();</script>
                
                <!-- Encryption -->
                <TR>
                      <script>writeTDWidth("row-l", "40%");</script>Encryption</TD>
                      <script>writeTD("row-l");</script>
                        %ifvar isEncrypted equals(true)%
                            <INPUT TYPE="radio" NAME="isEncrypted" ID="isEncrypted1" VALUE="true" checked onClick="displayTrustore('true');valueAltered()"><label for="isEncrypted1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isEncrypted" ID="isEncrypted2" VALUE="false" onClick="displayTrustore('false');valueAltered()"><label for="isEncrypted2">No</label></INPUT>
                        %else%
                            <INPUT TYPE="radio" NAME="isEncrypted" ID="isEncrypted1" VALUE="true" onClick="displayTrustore('true');valueAltered()"><label for="isEncrypted1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isEncrypted" ID="isEncrypted2" VALUE="false" checked onClick="displayTrustore('false');valueAltered()"><label for="isEncrypted2">No</label></INPUT>
                        %endif%
                      </TD>
              </TR>
               </table>

         <!-- (DIV divtruststore -->  
         %ifvar isEncrypted equals('true')%
                 <DIV id="divtruststore" STYLE="display: block">
               %else%
                 <DIV id="divtruststore" STYLE="display: none">
               %endif%
            
          <TABLE class="tableView" width="85%">
                      <script>swapRows();</script>
            
            <!-- Truststore -->                 
                    <TR>
                        <script>writeTDWidth("row-l", "40%");</script><label for="truststore">Truststore</label></TD>
					    <script>writeTD("row-l");</script><INPUT NAME="truststore" ID="truststore" VALUE="%value truststore encode(htmlattr)%" onChange="valueAltered()" onChange="valueAltered()"></TD>
                    </TR>
                    <script>swapRows();</script>
                    
                    <!-- Truststore Type -->
                    <TR>
                        <script>writeTDWidth("row-l", "40%");</script><label for="truststoreType">Truststore Type</label></TD>
                        <script>writeTD("row-l");</script>
                            <select name="truststoreType" ID="truststoreType" onChange="valueAltered()">
                              <option value=""></option>
                  <option value="JKS">JKS</option>
                </select>
                      </TD>
                  </TR>
                </table>
             </DIV>

         <TABLE class="tableView" width="85%">
              <TR>
              <TD class="action" class="row" width="40%">
                <INPUT TYPE="hidden" NAME="action" VALUE="create">
                <INPUT TYPE="hidden" NAME="type" VALUE="BROKER">
                <INPUT type="submit" value="Save Changes" onClick="javascript:return confirmCreate()">
              </TD>
            </TR>
             
            %ifvar isUpdated equals('true')%
            <TR>
              <TD class="subheading">* Settings have been modified. Server restart is required.</TD>
            </TR>
            %endif%
            <tr>
                <td class="subheading" colspan=2>* webMethods Broker is deprecated.</td>
            </tr>
          
         </table>

        </FORM>
      </TD>
        <script>displaySettings(document.createform.clientAuth)</script>
    </TR>
  </TABLE>
</BODY>
</HTML>