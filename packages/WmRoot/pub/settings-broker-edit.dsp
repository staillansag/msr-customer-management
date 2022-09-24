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

%invoke wm.server.dispatcher.adminui:getBrokerSettings%

<SCRIPT LANGUAGE="JavaScript">

function displayTrustore(flag) {
    if ( flag == "true")
    {
        document.all.divtruststore.style.display = 'block';
    }
    else
    {
        document.all.divtruststore.style.display = 'none';
    }
}

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

    function loadDocument() {    
        setNavigation('settings-broker-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_EditBrokerScrn');
        
        %switch certfileType%
<!-- Trax 1-1RI0MD - 'JKS' is not supported for Keystore type  -->  
<!--            %case 'JKS'% -->
<!--                document.editform.certfileType.selectedIndex=1; -->
                %case 'PKCS12'%
                    document.editform.certfileType.selectedIndex=1;
        %end%
        
        %switch truststoreType%
                %case 'JKS'%
                    document.editform.truststoreType.selectedIndex=1;
        %end%
        
        //isSSLAltered();
    }
    
    function valueAltered()
    {
        document.editform.isChanged.value = "true";
    }
    
    function isIllegalName(name)
    {
        // according to Enterprise Server Java Client API Reference Guide
        // '@', '\', '/' are restricted characters
        var illegalChars = "@/\\";

        for (var i=0; i<illegalChars.length; i++)
        {
            if (name.indexOf(illegalChars.charAt(i)) >= 0)
            return false;
        }
        return true;
    }
    
    function confirmEdit ()
    {   
        var configuredList = document.editform.BROKERCONFIGURATION;
        for (var i=0; i<configuredList.length; i++) {
            if (configuredList[i].checked) {
                config = configuredList[i].value;
            }
        }
        if ( config == "true" )
        {   
            
            if ( isblank(document.editform.brokerHost.value) )
            {
                alert ("Broker Host is required.");
                return false;
            }
            else if ( isblank(document.editform.brokerName.value) )
            {
                alert ("Broker Name is required.");
                return false;
            }
            else if ( isblank(document.editform.clientGroupName.value) )
            {
                alert ("Client Group is required.");
                return false;
            }
            else if ( isblank(document.editform.CLIENTPREFIX.value) )
            {
                alert("Client Prefix is required.");
                return false;
            }
            else if ( !isblank(document.editform.CLIENTPREFIX.value) &&
                      !isIllegalName(document.editform.CLIENTPREFIX.value))
            {
                        alert("Invalid Client Prefix value:\nRefer to Enterprise Server Java API Client Reference Guide for restricted characters.");
                return false;
            }
            
            //Client authentication Basic check
            if ( document.editform.clientAuth.value == "basic")
            {
                if (document.editform.brokerUser.value == "" || document.editform.brokerPassword.value == "")
                {
                    alert("Broker username and password are required for Basic client authentication");
                    return false;
                }
            }
            
            //Client authentication SSL check
            if ( document.editform.clientAuth.value == "ssl")
            {
                if (document.editform.certfile.value == "" || document.editform.certfileType.value == "" || document.editform.password.value == "")
                {
                    alert("Keystore file, type and password are required for SSL client authentication");
                    return false;
                }
            }
            
            if ( document.editform.isEncrypted[0].checked == true)
            {
                if (document.editform.truststore.value == "" || document.editform.truststoreType.value == "")
                {
                    alert("Truststore file and type are required for encryption");
                    return false;
                }
            }
            
                document.editform.submit();
                return true;
        }else 
        {
            document.editform.submit();
            return true;
        }
    }
</SCRIPT>  
</HEAD>
<body onLoad="loadDocument();">
<TABLE width="90%">
    <TR>
        <TD class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; Broker Settings &gt; Edit</TD>
    </TR>
    
    <TR>
        <TD colspan="2">
          <ul class="listitems">
            <li class="listitem">
			<script>
			createForm("htmlform_settings_broker", "settings-broker.dsp", "POST", "BODY");
			</script>
			<script>getURL("settings-broker.dsp", "javascript:document.htmlform_settings_broker.submit();", "Return to Broker Settings");</script>
			</li>
          </UL>
        </TD>
    </TR>
    
    <TR>
        <TD>
        <FORM NAME="editform" ACTION="settings-broker.dsp" METHOD="POST">
         %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
         <TABLE class="tableView" width="60%">
                <script>swapRows();</script>
                <TR>
                    <TD class="heading" colspan=3>Broker Configuration</TD>
                </TR>
                    %invoke wm.server.dispatcher.adminui:isBrokerConfigured%
                    <script>swapRows();</script>
                <TR>
                    <script>writeTDWidth("row", "25%");</script>
                        Configured
                    </TD>
                     %ifvar BROKERCONFIGURATION equals('false')%
                    
                    <script>writeTD("row-l");</script>
                        <INPUT TYPE="radio" NAME="BROKERCONFIGURATION" ID="BROKERCONFIGURATION1" VALUE="true" onChange="valueAltered()"><label for="BROKERCONFIGURATION1">Yes</label></INPUT>
                        <INPUT TYPE="radio" NAME="BROKERCONFIGURATION" ID="BROKERCONFIGURATION2" VALUE="false" onChange="valueAltered()" checked><label for="BROKERCONFIGURATION2">No</label></INPUT>
                    </TD>
                    %else%
                <script>writeTD("row-l");</script>
                    <INPUT TYPE="radio" NAME="BROKERCONFIGURATION" ID="BROKERCONFIGURATION1" VALUE="true" onChange="valueAltered()" checked><label for="BROKERCONFIGURATION1">Yes</label></INPUT>
                    <INPUT TYPE="radio" NAME="BROKERCONFIGURATION" ID="BROKERCONFIGURATION2" VALUE="false" onChange="valueAltered()"><label for="BROKERCONFIGURATION2">No</label></INPUT>
                </TD>               
                    %endif%
                </TR>

            <script>swapRows();</script>
            <TR>
                <script>writeTDWidth("row", "25%");</script><label for="brokerHost">Broker Host</label></TD>
                <script>writeTD("row-l");</script>
                    <INPUT TYPE="hidden" NAME="isChanged" VALUE="false">
					<INPUT NAME="brokerHost" ID="brokerHost" VALUE="%value brokerHost encode(htmlattr)%" onChange="valueAltered()">
                </TD>
            </TR>

            <script>swapRows();</script>
            <TR>
                <script>writeTDWidth("row", "25%");</script><label for="">Broker Name</label></TD>
                <script>writeTD("row-l");</script>
					<INPUT NAME="brokerName" VALUE="%value brokerName encode(htmlattr)%" onChange="valueAltered()">
                </TD>
            </TR>
            
            <script>swapRows();</script>
            <TR>
                <script>writeTDWidth("row", "25%");</script><label for="clientGroupName">Client Group</TD>
                <script>writeTD("row-l");</script>
					<INPUT NAME="clientGroupName" ID="clientGroupName" VALUE="%value clientGroupName encode(htmlattr)%" onChange="valueAltered()">
                </TD>
            </TR>                       
            
            <script>swapRows();</script>
            <TR>
                <script>writeTDWidth("row", "25%");</script><label for="CLIENTPREFIX">Client Prefix</label></TD>
                <script>writeTD("row-l");</script>
					<INPUT NAME="CLIENTPREFIX" ID="CLIENTPREFIX" size="55" VALUE="%value CLIENTPREFIX encode(htmlattr)%" onChange="valueAltered()">
                </TD>
            </TR>                       
            
            <script>swapRows();</script>
            <TR>

                <script>writeTDWidth("row", "25%");</script>Share Client Prefix</td>
                <script>writeTD("row-l");</script>
                    %ifvar isISClustered equals(true)%
                        <INPUT TYPE="radio" NAME="isISClustered" ID="isISClustered1" VALUE="true" checked disabled onChange="valueAltered()"><label for="isISClustered1">Yes</label></INPUT>
                        <INPUT TYPE="radio" NAME="isISClustered" ID="isISClustered2" VALUE="false" disabled onChange="valueAltered()"><label for="isISClustered2">No</label></INPUT>
                    %else%
                        %ifvar isClientPrefixShared equals(true)%               
                            <INPUT TYPE="radio" NAME="isClientPrefixShared" ID="isClientPrefixShared1" VALUE="true" checked onChange="valueAltered()"><label for="isClientPrefixShared1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isClientPrefixShared" ID="isClientPrefixShared2" VALUE="false" onChange="valueAltered()"><label for="isClientPrefixShared2">No</label></INPUT>
                        %else%
                            <INPUT TYPE="radio" NAME="isClientPrefixShared" ID="isClientPrefixShared1" VALUE="true" onChange="valueAltered()"><label for="isClientPrefixShared1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isClientPrefixShared" ID="isClientPrefixShared2" VALUE="false" checked onChange="valueAltered()"><label for="isClientPrefixShared2">No</label></INPUT>
                        %endif% 
                    %endif%
                </td>
            </TR>                
            
            <TR>
                <td class="heading" colspan=3>Client Authentication Settings</td>
            </TR>
            
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row", "25%");</script><label for="clientAuth">Client Authentication</label></TD>
                <script>writeTD("row-l");</script>
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
                </td>
            </tr>
            <script>swapRows();</script>        
            </TABLE>
            
            %ifvar clientAuth equals('basic')%
                <div id="divbasic" STYLE="display: block">
            %else%
                <div id="divbasic" STYLE="display: none">
            %endif% 
            
                <table class="tableView" width="60%">
                
                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row", "25%");</script><label for="brokerUser">Username</label></TD>
					<script>writeTD("row-l");</script><INPUT NAME="brokerUser" ID="brokerUser" VALUE="%value brokerUser encode(htmlattr)%" onChange="valueAltered()"></td>
                </tr>

                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row", "25%");</script><label for="brokerPassword">Password</label></TD>
					<script>writeTD("row-l");</script><INPUT NAME="brokerPassword" ID="brokerPassword" TYPE="password" autocomplete="off" VALUE="%value brokerPassword encode(htmlattr)%" onChange="valueAltered()" /></td>
                </tr>
                </table>
            </div>

            %ifvar clientAuth equals('ssl')%
                <div id="divssl" STYLE="display: block">
            %else%
                <div id="divssl" STYLE="display: none">
            %endif% 

                <table class="tableView" width="60%">
                
                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row", "25%");</script><label for="certfile">Keystore</label></TD>
					<script>writeTD("row-l");</script><INPUT NAME="certfile" ID="certfile" VALUE="%value certfile encode(htmlattr)%" onChange="valueAltered()"></td>
                </tr>
                
                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row", "25%");</script><label for="certfileType">Keystore Type</label></TD>
                    <script>writeTD("row-l");</script>
                        <select name="certfileType" ID="certfileType" onChange="valueAltered()">
                                <option value=""></option>
                                    <option value="PKCS12" >PKCS12</option>
                                </select>
                    </td>
                </tr>

                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row", "25%");</script><label for="password">Keystore Password</label></td>
					<script>writeTD("row-l");</script><INPUT NAME="password" ID="password" TYPE="password" autocomplete="off" value="%value password encode(htmlattr)%" onChange="valueAltered()" /></td>
                </tr>

                
               </table>
            </div>
        
            <TABLE class="tableView" width="60%">
            <TR>
                <td class="heading" colspan=3>Encryption Settings</td>
            </TR>
            <script>swapRows();</script>
            <tr>
                    <script>writeTDWidth("row", "25%");</script>Encryption</td>
                    <script>writeTD("row-l");</script>
                        %ifvar isEncrypted equals(true)%
                            <INPUT TYPE="radio" NAME="isEncrypted" ID="isEncrypted1" VALUE="true" checked onClick="displayTrustore('true');valueAltered()"><label for="isEncrypted1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isEncrypted" ID="isEncrypted2" VALUE="false" onClick="displayTrustore('false');valueAltered()"><label for="isEncrypted2">No</label></INPUT>
                        %else%
                            <INPUT TYPE="radio" NAME="isEncrypted" ID="isEncrypted1" VALUE="true" onClick="displayTrustore('true');valueAltered()"><label for="isEncrypted1">Yes</label></INPUT>
                            <INPUT TYPE="radio" NAME="isEncrypted" ID="isEncrypted2" VALUE="false" checked onClick="displayTrustore('false');valueAltered()"><label for="isEncrypted2">No</label></INPUT>
                        %endif%
                    </td>
            </tr>
            </table>
            
            %ifvar isEncrypted equals('true')%
                <div id="divtruststore" STYLE="display: block">
            %else%
                <div id="divtruststore" STYLE="display: none">
            %endif% 
            
                <table class="tableView" width="60%">
                    <script>swapRows();</script>                
                <tr>
                    <script>writeTDWidth("row", "25%");</script><label for="truststore">Truststore</label></TD>
					<script>writeTD("row-l");</script><INPUT NAME="truststore" ID="truststore" VALUE="%value truststore encode(htmlattr)%" onChange="valueAltered()"></td>
                </tr>
                
                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row", "25%");</script><label for="truststoreType">Truststore Type</label></TD>
                    <script>writeTD("row-l");</script>
                        <select name="truststoreType" ID="truststoreType" onChange="valueAltered()">
                                <option value=""></option>
                                    <option value="JKS">JKS</option>
                                </select>
                    </td>
                </tr>
                </table>
            </div>
            
        
        <table class="tableView" width="60%">
        <TR>
                <TD class="action" class="row" width="25%">
                  <INPUT TYPE="hidden" NAME="action" VALUE="edit">
                  <INPUT type="button" value="Save Changes" onclick="return confirmEdit()">
                </TD>
            </TR>
        
            %ifvar isUpdated equals('true')%
              <tr>
                <td class="subheading"> 
                  * Settings have been modified. Server restart is required.
                </td>
              </tr>
            %endif%   
        </table>
        </FORM>
      <script>displaySettings(document.editform.clientAuth)</script>
    </TR>
 </TABLE>
 </BODY>
 </HTML>
