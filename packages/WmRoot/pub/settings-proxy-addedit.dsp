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
    <SCRIPT SRC="webMethods.js">
    </SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
                var agent = navigator.userAgent.toLowerCase();   
                var ie = (agent.indexOf("msie") != -1);
    
        
              function confirmEditBypass()
              {
                  document.addform.submit();
                  return true;
              }
              
              function toggleFtpSubtype(display)
              { 
                    ftpSubTypeRow = document.getElementById("ftpSubtype");
                    if (display == "on")
                    {
                        ftpSubTypeRow.style.display="block";
                        ftpSubTypeRow.style.display="table-row";
                    }
                    else {
                        ftpSubTypeRow.style.display="none";
                    }
              }
              
              function toggleSocksSubtype(display)
              { 
                    socksSubTypeRow = document.getElementById("SocksSubtype");
                    if (display == "on"){
                        socksSubTypeRow.style.display="block";
                        socksSubTypeRow.style.display="table-row";
                    }
                    else {
                        socksSubTypeRow.style.display="none";
                    }
              }
    
              function overwriteDefaultProxy()
              {
                // Check HTTP
                if ( document.addform.protocol[0].checked == true)
                { 
                    if ( document.addform.isDefault[0].checked == true &&
                         document.addform.defaultHTTPProxyAlias.value != "" &&
                         document.addform.defaultHTTPProxyAlias.value != document.addform.proxyAlias.value
                    )
                    {
                        var confirmation = confirm("\"" + document.addform.defaultHTTPProxyAlias.value + "\" is configured as default HTTP proxy server. Do you want to set \"" + document.addform.proxyAlias.value + "\" as the new default HTTP proxy server?");
                        if (confirmation == false)
                             return false;
                    }
                 }
                 // Check HTTPS
                 else if ( document.addform.protocol[1].checked == true)
                 {
                        if ( document.addform.isDefault[0].checked == true &&
                             document.addform.defaultHTTPSProxyAlias.value != "" &&
                             document.addform.defaultHTTPSProxyAlias.value != document.addform.proxyAlias.value
                        )
                        {
                            var confirmation = confirm("\"" + document.addform.defaultHTTPSProxyAlias.value + "\" is configured as default HTTPS proxy server. Do you want to set \"" + document.addform.proxyAlias.value + "\" as the new default HTTPS proxy server?");
                            if (confirmation == false)
                                 return false;
                        }
                 }
                 // Check FTP
                 else if ( document.addform.protocol[2].checked == true)
                 {
                        if ( document.addform.isDefault[0].checked == true &&
                             document.addform.defaultFTPProxyAlias.value != "" &&
                             document.addform.defaultFTPProxyAlias.value != document.addform.proxyAlias.value
                        )
                        {
                            var confirmation = confirm("\"" + document.addform.defaultFTPProxyAlias.value + "\" is configured as default FTP proxy server. Do you want to set \"" + document.addform.proxyAlias.value + "\" as the new default FTP proxy server?");
                            if (confirmation == false)
                                 return false;
                        }
                 }
                 return true;
              }
              
              function confirmEdit ()
              {
                if ((document.addform.proxyAlias.value == "") ||
                    (document.addform.port.value == "")  ||
                    (document.addform.host.value == "")
                    )
                {
                  alert ("You must specify the arguments (Alias, Host Name or IP Address, Port Number) for the proxy server.");
                }
                else
                {
                    // Check Alias Overwrite
                    if( overwriteAlias(document.addform.proxyAlias.value))
                    {
                        //Check Default Proxy overwrite
                        if (overwriteDefaultProxy())
                        {
                            document.addform.submit();
                            return true;
                        }
                    }
                    else
                        return false;
                  
                }
                return false;
              }
              function confirmAdd ()
              {
                    if ((document.addform.proxyAlias.value == "") ||
                        (document.addform.port.value == "")  ||
                        (document.addform.host.value == "")
                        )
                    {
                      alert ("You must specify the arguments (Alias, Host Name or IP Address, Port Number) for the proxy server.");
                      return false;
                    }
                    else if (! checkLegalName (document.addform.proxyAlias, "Alias") ||
                            (! checkLegalUserName (document.addform.username.value, "Username")))
                    {
                    }
                    else
                    {
                        if( overwriteAlias(document.addform.proxyAlias.value))
                        {
                            //Check Default Proxy overwrite
                            if (overwriteDefaultProxy())
                            {
                                document.addform.submit();
                                return true;
                            }
                        }
                        else
                            return false;
                }
                return true;
              }
              
              function overwriteAlias(alias)
              {
                           %ifvar action equals('edit')%
                              if (alias == document.addform.oldAlias.value)
                                 return true;
                           %endif%
                            
                          var aliasesArray;
                          if (! document.addform.aliases)
                          {
                            aliasesArray = new Array(0);
                          }
                          else if (! document.addform.aliases.length)
                          {
                            aliasesArray = new Array(1);
                            aliasesArray[0] = document.addform.aliases.value;
                          }
                          else
                          {
                            var aliasesLen = document.addform.aliases.length;
                            aliasesArray = new Array(aliasesLen);
                            for (i = 0; i < aliasesLen; i++)
                            {
                              aliasesArray[i] = document.addform.aliases[i].value;
                            }
                          }
                        
                          for (ind = 0; ind < aliasesArray.length; ind++)
                          {
                            if (aliasesArray[ind] == alias)
                            {
                                  var confirmation = confirm("Do you want to overwrite existing alias " + document.addform.proxyAlias.value + "?");
                                  if (confirmation == false)
                                  {
                                    return false;
                                  }
                            }
                          }
                          return true;
              }
              
              function checkLegalName(field, fieldName)
              {
                var name = field.value;
                var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"";
    
                for (var i=0; i<illegalChars.length; i++)
                {
                  if (name.indexOf(illegalChars.charAt(i)) >= 0)
                  {
                    alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
                    return false;
                  }
                }
                return true;
              }
              function checkLegalUserName(userName, fieldName)
              {
                var illegalChars = " \\\"";
    
                for (var i=0; i<illegalChars.length; i++)
                {
                  if (userName.indexOf(illegalChars.charAt(i)) >= 0)
                  {
                    alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
                    return false;
                  }
                }
                return true;
              }
              function clearAuthentication(isClear){
                var userName = document.getElementById('username');
                
                var pwd = document.getElementById('password');
                

                if(isClear){
                    uValue = userName.value;
                    pValue = pwd.value;
                    userName.value='';
                    userName.disabled = true;
                    pwd.value='';
                    pwd.disabled = true;
                }
                else{
                    userName.value=uValue;
                    userName.disabled = false;
                    pwd.value=pValue;
                    pwd.disabled = false;
                }
              }
              </SCRIPT>
  </HEAD>
  %switch action% 
  %case 'editBypass'%
  <BODY onLoad="setNavigation('settings-proxy-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditProxyBypassScrn');">
  %case 'edit'%
  <BODY onLoad="setNavigation('settings-proxy-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditProxyScrn');">
  %case%
  <BODY onLoad="setNavigation('settings-proxy-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CreateProxyAliasScrn');">
  %end%
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan="2">
            Settings &gt;
            Proxy Servers &gt;
            %ifvar action equals('edit')%
                %value proxyAlias encode(html)% &gt; Edit
            %else%
              %ifvar action equals('editBypass')%
                Edit Proxy Bypass
              %else%
                      Create Alias
              %endif%
            %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <ul class="listitems">
			<script>
			createForm("htmlform_settings_network", "settings-network.dsp", "POST", "BODY");
			</script>
            <li class="listitem"><script>getURL("settings-network.dsp", "javascript:document.htmlform_settings_network.submit();", "Return to Proxy Servers");</script>
			</li>
          </UL>
        </TD>
      </TR>
        
        <TR>
            <TD>
                 <TABLE class="tableView">
                    <TR>
                        <TD colspan="2" class="heading">%ifvar action equals('editBypass')%Proxy Bypass%else%Proxy Server Alias Properties%endif%</TD>
                    </TR>
                    <FORM NAME="addform" ACTION="settings-network.dsp" METHOD="POST">
                      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

              
                      %ifvar action equals('editBypass')%
                            %invoke wm.server.query:getSettings%
                            <TR>
			        		   <td class="oddrow"><label for="proxySkipList">Addresses</label></td>
                               <TD class="oddrow-l">
					           	<INPUT NAME="watt.net.proxySkipList" ID="proxySkipList" VALUE="%value watt.net.proxySkipList encode(htmlattr)%" size=40>
                             </TD>
                            </TR>
                            <TR>
                               <TD class="evenrow"/>
                               <TD class="evenrow-l">Use commas (,) to separate entries.</TD>
                            </TR>
                            %endinvoke%
                     %else%
                          <TR>
				            <TD class="oddrow"><label for="proxyAlias">Alias</label></td>
                            <TD class="oddrow-l">
				              <INPUT name="proxyAlias" id="proxyAlias" VALUE="%value proxyAlias encode(htmlattr)%"> 
                              </TD>
                          </TR>
                          <TR>
				            <TD class="evenrow"><label for="host">Host Name or IP Address</label></td>
                            <TD class="evenrow-l">
				              <INPUT name="host" id="host" VALUE="%value host encode(htmlattr)%"> </TD>
                          </TR>
                          <TR>
				            <TD class="oddrow"><label for="port">Port Number</label></td>
                            <TD class="oddrow-l">
				              <INPUT name="port" id="port" VALUE="%ifvar port equals('-1')%%else%%value port encode(htmlattr)%%endif%" SIZE=5 MAXLENGTH=5> </TD>
                          </TR>
                          <TR>
				            <TD class="evenrow"><label for="username">User Name (optional)</label></td>
                            <TD class="evenrow-l">
                              <INPUT name="username" id="username" VALUE="%value username%"> </TD>
                          </TR>
                          <TR>
				            <TD class="oddrow"><label for="password">Password (optional)</label></td>
                            <TD class="oddrow-l">
                              <INPUT name="password" id="password" TYPE="password" autocomplete="off" VALUE="%value password%"/> </TD>
                          </TR>
                          <TR>
						        <TD class="evenrow">Default</td>
                                <TD class="evenrow-l">
                                        <input type="radio" id="isDefault1" name="isDefault"  
                                            %ifvar isDefault equals('Y')%
                                                checked
                                            %endif%  
                                            value="Y"><label for="isDefault1">Yes</label></input>
                                        <input type="radio" id="isDefault2" name="isDefault"  
                                            %ifvar action equals('add')%
                                                checked 
                                            %else% 
                                                %ifvar isDefault equals('N')%
                                                    checked
                                                %endif% 
                                            %endif%
                                            value="N"><label for="isDefault2">No</label></input>
                                </TD>
                             </TR>

                          <TR>
                                <TD class="oddrow">Protocol</TD>
                                <TD class="oddrow-l">
                                    <input type="radio" 
                                        %ifvar action equals('add')%
                                            checked
                                        %else%
                                            %ifvar protocol equals('HTTP')%
                                                checked
                                            %endif%
                                        %endif% 
                                        name="protocol" id="HTTP" value="HTTP" onclick="toggleFtpSubtype('off');toggleSocksSubtype('off')"
                                        ><label for="HTTP">HTTP</label></input>
                                    <input type="radio" 
                                        %ifvar protocol equals('HTTPS')%checked%endif%
                                        name="protocol" id="HTTPS" value="HTTPS" onclick="toggleFtpSubtype('off');toggleSocksSubtype('off')" 
                                        ><label for="HTTPS">HTTPS</label></input>
                                    <input type="radio" 
                                    %ifvar protocol equals('FTP')%checked%endif%
                                    name="protocol" id="FTP" value="FTP" onclick="toggleFtpSubtype('on');toggleSocksSubtype('off')"
                                    ><label for="FTP">FTP</label></input>
                                    <input type="radio" 
                                    %ifvar protocol equals('SOCKS')%checked%endif%
                                    name="protocol" id="SOCKS" value="SOCKS" onclick="toggleSocksSubtype('on');toggleFtpSubtype('off')"
                                    ><label for="SOCKS">SOCKS</label></input>
                                </TD>
                          </TR>
                            <TR id="ftpSubtype">
                                <TD class="evenrow">Proxy Type</TD>
                                <TD class="evenrow-l">
                                        <input type="radio" name="ftpType"  id="ftpType1" checked %ifvar ftpType equals('0')%checked%endif% value="0"><label for="ftpType1">0. No proxy</label><br>
                                        <input type="radio" name="ftpType"  id="ftpType2" %ifvar ftpType equals('1')%checked%endif% value="1"><label for="ftpType2">1. ftp_user@ftp_host no proxy auth.</label><br>
                                        <input type="radio" name="ftpType"  id="ftpType3" %ifvar ftpType equals('2')%checked%endif% value="2"><label for="ftpType3">2. ftp_user@ftp_host proxy auth</label><br>
                                        <input type="radio" name="ftpType"  id="ftpType4" %ifvar ftpType equals('3')%checked%endif% value="3"><label for="ftpType4">3. site command</label><br>
                                        <input type="radio" name="ftpType"  id="ftpType5" %ifvar ftpType equals('4')%checked%endif% value="4"><label for="ftpType5">4. open command</label><br>
                                        <input type="radio" name="ftpType"  id="ftpType6" %ifvar ftpType equals('5')%checked%endif% value="5"><label for="ftpType6">5. ftp_user@proxy_user@ftp_host</label><br>
                                        <input type="radio" name="ftpType"  id="ftpType7" %ifvar ftpType equals('6')%checked%endif% value="6"><label for="ftpType7">6. proxy_user@ftp_host</label><br>
                                        <input type="radio" name="ftpType"  id="ftpType8" %ifvar ftpType equals('7')%checked%endif% value="7"><label for="ftpType8">7. ftp_user@ftp_host proxy_user</label><br>
                                </TD>
                             </TR>
                            <TR id="SocksSubtype">
                                  <TD class="evenrow">SOCKS Version</TD>
                                  <TD class="evenrow-l">
                                        <input type="radio" id="socksVersion1" name="socksVersion" onclick="clearAuthentication(true);"  %ifvar socksVersion equals('4')%checked%endif% value="4"><label for="socksVersion1">SOCKS v4</label><br>
                                        <input type="radio" id="socksVersion2" name="socksVersion" onclick="clearAuthentication(false);" %ifvar action equals('add')%checked%else%%ifvar socksVersion equals('5')%checked%endif%%endif% value="5"><label for="socksVersion2">SOCKS v5</label><br>
                                  </TD>
                            </TR>
                             %ifvar protocol equals('FTP')%
                                <SCRIPT>toggleFtpSubtype('on');</SCRIPT>
                            %else%
                                <SCRIPT>toggleFtpSubtype('off');</SCRIPT>
                            %endif%
                            
                            %ifvar protocol equals('SOCKS')%
                                <SCRIPT>toggleSocksSubtype('on');</SCRIPT>
                            %else%
                                <SCRIPT>toggleSocksSubtype('off');</SCRIPT>
                            %endif%
                            
                    %endif%  
            
            <!-- HIDDEN FIELDS -->
	        <INPUT type="hidden" NAME="status" VALUE="%value status encode(htmlattr)%"> 
            %invoke wm.server.proxy:getDefaultHTTPProxyAlias%
                %ifvar defaultHTTPProxyAlias -isnull%
                    <input type="hidden" name="defaultHTTPProxyAlias" value=""/>
                %else%
					<input type="hidden" name="defaultHTTPProxyAlias" value="%value defaultHTTPProxyAlias encode(htmlattr)%"/>
                %endif%
             %endinvoke%
            
            %invoke wm.server.proxy:getDefaultHTTPSProxyAlias%
                %ifvar defaultHTTPSProxyAlias -isnull%
                    <input type="hidden" name="defaultHTTPSProxyAlias" value=""/>
                %else%
					<input type="hidden" name="defaultHTTPSProxyAlias" value="%value defaultHTTPSProxyAlias encode(htmlattr)%"/>
                %endif%
             %endinvoke%
             
             %invoke wm.server.proxy:getDefaultFTPProxyAlias%
                %ifvar defaultFTPPProxyAlias -isnull%
                    <input type="hidden" name="defaultFTPProxyAlias" value=""/>
                %else%
					<input type="hidden" name="defaultFTPProxyAlias" value="%value defaultFTPProxyAlias encode(htmlattr)%"/>
                %endif%
             %endinvoke%
             

            %invoke wm.server.proxy:getProxyServerAliases%
              <TR>
              %loop proxyAliases%
                <TD>
	              <INPUT TYPE="hidden" NAME="aliases" VALUE="%value proxyAliases encode(htmlattr)%" />
                </TD>
              %endloop%
              </TR>
             %endinvoke%

              <TR>
                <TD colspan=2 class="action">
                %ifvar action equals('edit')%
                  <INPUT TYPE="hidden" NAME="action" VALUE="edit">
	              <INPUT TYPE="hidden" NAME="oldAlias" VALUE="%value proxyAlias encode(htmlattr)%">
                  <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
                %else%
                        %ifvar action equals('editBypass')%
                          <INPUT TYPE="hidden" NAME="action" VALUE="editBypass">
                          <INPUT type="button" value="Save Changes" onclick="return confirmEditBypass();">
                        %else%
                          <INPUT TYPE="hidden" NAME="action" VALUE="add">
                          <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
                        %endif%
                %endif%
                </TD>
              </TR>

            </FORM>
          </TABLE>
        </TD>
      </TR>       

      
  
    </TABLE>

    </BODY>
  </HTML>
