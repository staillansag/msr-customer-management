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
        document.editform.isEncrypted[1].disabled = false;         
      }else if (object.options[object.selectedIndex].value == "ssl") {
        document.all.divbasic.style.display = 'none';
        document.all.divssl.style.display = 'block';
        document.editform.isEncrypted[0].checked = true;
        document.editform.isEncrypted[1].disabled = true;
        displayTrustore('true');
      }else {
        document.all.divbasic.style.display = 'none';
        document.all.divssl.style.display = 'none';
        document.editform.isEncrypted[1].disabled = false;
      }
    }
    
    /**
     *
     */         
    function loadDocument() {
	    //alert("%value certfileType encode(javascript)%");
    
          setNavigation('settings-broker-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ConnectionAlias_EditBrokerScrn');
        
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
        
      if (isblank(document.editform.brokerHost.value)) {
              alert ("Broker Host is required.");
              return false;
            }else if ( isblank(document.editform.brokerName.value) ) {
              alert ("Broker Name is required.");
          return false;
        }else if ( isblank(document.editform.clientGroupName.value) ) {
            alert ("Client Group is required.");
            return false;
        }else if ( isblank(document.editform.CLIENTPREFIX.value) ) {
            alert("Client Prefix is required.");
            return false;
        }else if ( !isblank(document.editform.CLIENTPREFIX.value) &&
         !isIllegalName(document.editform.CLIENTPREFIX.value)) {
         alert("Invalid Client Prefix value:\nRefer to Enterprise Server Java API Client Reference Guide for restricted characters.");
            return false;
        }
            
            //Client authentication Basic check
        if ( document.editform.clientAuth.value == "basic") {
          if (document.editform.brokerUser.value == "" || document.editform.brokerPassword.value == "") {
              alert("Broker username and password are required for Basic client authentication");
                return false;
            }
        }
            
        //Client authentication SSL check
          if ( document.editform.clientAuth.value == "ssl") {
          if (document.editform.certfile.value == "" || document.editform.certfileType.value == "" || document.editform.password.value == "") {
              alert("Keystore file, type and password are required for SSL client authentication");
                return false;
            }
        }
            
          if ( document.editform.isEncrypted[0].checked == true) {
            if (document.editform.truststore.value == "" || document.editform.truststoreType.value == "") {
                alert("Truststore file and type are required for encryption");
                return false;
            }
        }
          
      //document.editform.submit();
          //  return true;
            
        //}else {
        //  document.editform.submit();
        //  return true;
        //}
        
        return true;
      }
  
  </SCRIPT>
</HEAD>

<body onLoad="loadDocument();">

  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Broker Connection Alias &gt; Edit</TD>
    </TR>
    <TR>
      <TD colspan="2">
        <ul class="listitems">
          <li class="listitem">
		  <script>
		  createForm("htmlform_settings_wm_broker_detail", "settings-wm-broker-detail.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_wm_broker_detail", "aliasName", "%value aliasName%");
		  </script>
		  <script>getURL("settings-wm-broker-detail.dsp?aliasName=%value aliasName encode(url)%","javascript:document.htmlform_settings_wm_broker_detail.submit();","Return to Broker Connection Alias")</script>
		  </li>
        </UL>
      </TD>
    </TR>
    <TR>
      <TD>
        <FORM name="editform" action="settings-wm-broker-detail.dsp" METHOD="POST">
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
            <TD class="oddrowdata-l"><INPUT NAME="aliasName" id="aliasName" size="50" value="%value aliasName encode(htmlattr)%" DISABLED></TD>
          </TR>

          <!-- Description -->
          <TR>
            <TD class="evenrow-l"><label for="description">Description</label></TD>
            <TD class="evenrowdata-l"><INPUT NAME="description" id="description" size="50" value="%value description encode(htmlattr)%"></TD>
          </TR>
          
          <!-- Client Prefix -->
          <TR>
            <TD class="oddrow-l"><label for="CLIENTPREFIX">Client Prefix</label></TD>
            <TD class="oddrowdata-l"><INPUT NAME="CLIENTPREFIX" id="CLIENTPREFIX" size="50" value="%value CLIENTPREFIX encode(htmlattr)%"></TD>
          </TR>
          
          <!-- Share Client Prefix -->
          <TR>
            <TD class="evenrow-l" scope="row">Client Prefix Is Shared (prevents removal of shared messaging provider objects)</TD>
            <TD class="evenrowdata-l">
              %ifvar isISClustered equals(true)%
                            <INPUT TYPE="radio" NAME="isISClustered" id="isISClustered1" VALUE="true" checked disabled onChange="valueAltered()"><label for="isISClustered1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isISClustered" id="isISClustered2" VALUE="false" disabled onChange="valueAltered()"><label for="isISClustered2">No</label></INPUT>
                        %else%
                            %ifvar isClientPrefixShared equals(true)%               
                                <INPUT TYPE="radio" NAME="isClientPrefixShared" id="isClientPrefixShared1" VALUE="true" checked onChange="valueAltered()"><label for="isClientPrefixShared1">Yes</label></INPUT>
                                <INPUT TYPE="radio" NAME="isClientPrefixShared" id="isClientPrefixShared2" VALUE="false" onChange="valueAltered()"><label for="isClientPrefixShared2">No</label></INPUT>
                            %else%
                                <INPUT TYPE="radio" NAME="isClientPrefixShared" id="isClientPrefixShared1" VALUE="true" onChange="valueAltered()"><label for="isClientPrefixShared1">Yes</label></INPUT>
                                <INPUT TYPE="radio" NAME="isClientPrefixShared" id="isClientPrefixShared2" VALUE="false" checked onChange="valueAltered()"><label for="isClientPrefixShared2">No</label></INPUT>
                            %endif% 
                        %endif%
                      </TD>
          </TR>
          
          <!--                     -->
          <!-- Connection Settings -->
          <!--                     -->
         
          <TR>
            <TD class="heading" colspan=2>Connection Settings</TD>
          </TR>

          <!-- Broker Host -->
          <TR>
            <TD class="oddrow-l"><label for="brokerHost">Broker Host</label></TD>
            <TD class="oddrowdata-l"><INPUT NAME="brokerHost" size="50" id="brokerHost" value="%value brokerHost encode(htmlattr)%"></TD>
          </TR>
          
          <!-- Broker Name -->
          <TR>
            <TD class="evenrow-l"><label for="brokerName">Broker Name</label></TD>
            <TD class="evenrowdata-l"><INPUT NAME="brokerName" id="brokerName" size="50" value="%value brokerName encode(htmlattr)%"></TD>
          </TR>
          
          <!-- Client Group -->
          <TR>
            <TD class="oddrow-l"><label for="clientGroupName">Client Group</label></TD>
            <TD class="oddrowdata-l"><INPUT NAME="clientGroupName" id="clientGroupName" size="50" value="%value clientGroupName encode(htmlattr)%"></TD>
          </TR>
          
          <!--                                -->
          <!-- Client Authentication Settings -->
          <!--                                -->
            
           <TR>
                    <TD class="heading" colspan=3>Client Authentication Settings</TD>
                </TR> 

          <!-- Client Authentication -->
          <TR>
            <TD class="oddrow-l"><label for="clientAuth">Client Authentication</label></TD>
            <TD class="oddrowdata-l">
              <select name="clientAuth" id="clientAuth" onchange="displaySettings(this.form.clientAuth);valueAltered()">
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
					    <TD class="evenrowdata-l"><INPUT NAME="brokerUser" id="brokerUser" VALUE="%value brokerUser encode(htmlattr)%" onChange="valueAltered()"></TD>
                    </TR>
                    <TR>
                        <TD class="oddrow-l"><label for="brokerPassword">Password</label></TD>
					   <TD class="oddrowdata-l"><INPUT NAME="brokerPassword" id="brokerPassword" TYPE="password" autocomplete="off" VALUE="%value brokerPassword encode(htmlattr)%" onChange="valueAltered()"/></TD>
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
			 		    <TD class="evenrowdata-l"><INPUT NAME="certfile" id="certfile" VALUE="%value certfile encode(htmlattr)%" onChange="valueAltered()"></TD>
                    </TR>
                    <TR>
                        <TD class="oddrow-l"><label for="certfileType">Keystore Type</label></TD>
                        <TD class="oddrowdata-l">
                            <select name="certfileType" id="certfileType" onChange="valueAltered()">
                              <option value=""></option>
                   <option value="PKCS12" >PKCS12</option>
                 </select>
                        </TD>
                    </TR>
                    <TR>
                        <TD class="evenrow-l"><label for="password">Keystore Password</label></TD>
		     			<TD class="evenrowdata-l"><INPUT NAME="password" id="password" TYPE="password" autocomplete="off" value="%value password encode(htmlattr)%" onChange="valueAltered()"/></TD>
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
                            <INPUT TYPE="radio" NAME="isEncrypted" id="isEncrypted1" VALUE="true" checked onClick="displayTrustore('true');valueAltered()"><label for="isEncrypted1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isEncrypted" id="isEncrypted2" VALUE="false" onClick="displayTrustore('false');valueAltered()"><label for="isEncrypted2">No</label></INPUT>
                        %else%
                            <INPUT TYPE="radio" NAME="isEncrypted" id="isEncrypted1" VALUE="true" onClick="displayTrustore('true');valueAltered()"><label for="isEncrypted1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isEncrypted" id="isEncrypted2" VALUE="false" checked onClick="displayTrustore('false');valueAltered()"><label for="isEncrypted2">No</label></INPUT>
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
					    <script>writeTD("row-l");</script><INPUT NAME="truststore" id="truststore" VALUE="%value truststore encode(htmlattr)%" onChange="valueAltered()" onChange="valueAltered()"></TD>
                    </TR>
                    <script>swapRows();</script>
                    
                    <!-- Truststore Type -->
                    <TR>
                        <script>writeTDWidth("row-l", "40%");</script><label for="truststoreType">Truststore Type</label></TD>
                        <script>writeTD("row-l");</script>
                            <select name="truststoreType" id="truststoreType" onChange="valueAltered()">
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
                <INPUT TYPE="hidden" NAME="action" VALUE="edit">
        	    <INPUT TYPE="hidden" NAME="aliasName" VALUE="%value aliasName encode(htmlattr)%">
                <INPUT TYPE="hidden" NAME="type" VALUE="BROKER">
                <INPUT type="submit" value="Save Changes" onClick="javascript:return confirmEdit()">
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
        %endinvoke%
        </FORM>
      </TD>
        <script>displaySettings(document.editform.clientAuth)</script>
    </TR>
  </TABLE>
</BODY>
</HTML>