
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
    <base target="_self">
    <style>
      .listbox  { width: 100%; }
    </style>
  </HEAD>
  %ifvar action equals('edit')%
  <BODY onLoad="loadKeyStoresOptions(); toggleSSL('%value ssl encode(javascript)%'); setNavigation('settings-remote.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditRemoteSvrAliasScrn');">
  %else%
  <BODY onLoad="loadKeyStoresOptions(); toggleSSL('%value ssl encode(javascript)%'); setNavigation('settings-remote.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CreateRemoteSvrAliasScrn');">
  %endif%
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan="2">
            Settings &gt;
            Remote Servers &gt;
            %ifvar action equals('edit')%
                %value alias encode(html)% &gt; Edit
            %else%
                Create Alias
            %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_remote", "settings-remote.dsp", "POST", "BODY");
		  </script>
            <li class="listitem"><script>getURL("settings-remote.dsp", "javascript:document.htmlform_settings_remote.submit();", "Return to Remote Servers");</script>
			
			</li>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
      <TABLE class="tableView">
        <TR>
            <TD colspan="2" class="heading">Remote Server Alias Properties</TD>
        </TR>
          <FORM NAME="addform" ACTION="settings-remote.dsp" METHOD="POST">
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          <SCRIPT LANGUAGE="JavaScript">
          
          var hiddenOptions = new Array();
      
          function loadKeyStoresOptions()
          {
                var ks = document.addform.keyStoreAlias.options
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
                            if (aliases.length == 0)
                            {
                                aliases[0] = new Option("","");     
                            }
                            hiddenOptions[ks.length-1] = aliases;
                   %endloop%
                %endinvoke%
                
                var keyOpts = document.addform.keyStoreAlias.options;
    			var key = "%value keyStoreAlias encode(javascript)%";
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
                
                var aliasOpts = document.addform.keyAlias.options;
    			var alias = "%value keyAlias encode(javascript)%";
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
            var ks = document.addform.keyStoreAlias.options;
            var selectedKS = document.addform.keyStoreAlias.value;
            for(var i=0; i<ks.length; i++) {
                if(selectedKS == ks[i].value) {
                    var aliases = hiddenOptions[i];
                    document.addform.keyAlias.options.length = aliases.length;
                    for(var j=0;j<aliases.length;j++) {
                        var opt = aliases[j];
                        document.addform.keyAlias.options[j] = new Option(opt.text, opt.value);
                    }
                }
            }
        }
        
          function confirmEdit ()
          {
            if ((document.addform.alias.value == "") ||
                (document.addform.port.value == "")  ||
                (document.addform.host.value == "")  ||
                (document.addform.user.value == "")  ||
                (document.addform.pass.value == "")  )
            {
              alert ("You must specify the arguments (Alias, Host Name or IP Address, Port Number, User Name, Password) for the remote server.");
            }
            else
            {
                if ( !isHostValid() ) {
                    return false;
                }
                
                if ( !isRetryServerValid() ) {
                    return false;
                }
                
                if (document.addform.ssl[0].checked)
                {
                    if (!checkSSL())
                    {
                        alert("KeyAlias is empty.");
                        return false;
                    }
                }
                
        if (!checkKeepAlive())
            return false;
                
                if (! checkLegalName (document.addform.alias, "Alias") ||
                    (! checkLegalUserName (document.addform.user.value, "User Name")))
                {
                    return false;
                }
        
        if ( !checkDuplicateAliases("edit") ) {
            return false;
        }
             
              document.addform.submit();
              return true;
            }
            return false;
          }
          
          function checkSSL()
          {
            if ( document.addform.keyStoreAlias.value == "" && document.addform.keyAlias.value == "" ) 
                return true;
            else if (document.addform.keyStoreAlias.value == "" || document.addform.keyAlias.value == "" )
                return false;
            else
                return true;
          }
          
          function isHostValid() {
                var host = addform.host.value;
                
                var invlaidChars = ' ';
                for(var i=0;i<host.length; i++)
                {
                    var ch = host.charAt(i);
                    if(-1 != invlaidChars.indexOf(ch))
                    {
                        alert('The specified host name or IP address is invalid. Host names and IP addresses cannot contain spaces.');
                        addform.host.focus();
                        return false;
                    }
                }
                
                return true;
          }

          function isRetryServerValid() {
                var host = addform.retryServer.value;
                
                var invlaidChars = ' ';
                for(var i=0;i<host.length; i++)
                {
                    var ch = host.charAt(i);
                    if(-1 != invlaidChars.indexOf(ch))
                    {
                        alert('The specified Retry Server is invalid. Retry Server cannot contain spaces.');
                        addform.retryServer.focus();
                        return false;
                    }
                }
                
                return true;
          }
          
          function checkDuplicateAliases(addoredit) {
                
                if ( addoredit == "edit" ) {
                if (document.addform.oldAlias.value == document.addform.alias.value) {
                   return true;
                }               
                }
          
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
                      if (aliasesArray[ind] == document.addform.alias.value)
                      {
                        var confirmation = confirm("Do you want to overwrite existing alias " + document.addform.alias.value + "?");
                        if (confirmation == false)
                        {
                          return false;
                        }
                }
              }
        
              return true;
          }
          
          function confirmAdd ()
          {
            if ((document.addform.alias.value == "") ||
                (document.addform.port.value == "")  ||
                (document.addform.host.value == "")  ||
                (document.addform.user.value == "")  ||
                (document.addform.pass.value == "")  )
            {
              alert ("You must specify the arguments (Alias, Host Name or IP Address, Port Number, User Name, Password) for the remote server.");              return false;
            }
            else if (! checkLegalName (document.addform.alias, "Alias") ||
                    (! checkLegalUserName (document.addform.user.value, "User Name")))
            {
            }
            else
            {
            
                if ( !isHostValid() ) {
                    return false;
                }

                if ( !isRetryServerValid() ) {
                    return false;
                }

        if ( !checkDuplicateAliases("add") ) {
            return false;
        }

              if (document.addform.ssl[0].checked)
             {
                if (!checkSSL())
                {
                    alert("KeyAlias is empty.");
                    return false;
                }
             }
             if (!checkKeepAlive())
                return false;
                
             document.addform.submit();
             return true;
            }
            return true;
          }
          
          function checkKeepAlive()
          {
             var regExp = /^[0-9]+$/;
             var keepAlive = document.addform.keepalive.value;
             if ( keepAlive != "")
             {
                 if (keepAlive <= 0 || keepAlive.match(regExp) == null)
                 {
                    alert("Max Keep Alive Connections must be a positive integer greater than 0");
                    document.addform.keepalive.focus();
                    return false;
                 }
              }         
    
         regExp = /^[0-9]*\.?[0-9]+$/;
             var timeOut = document.addform.timeout.value;
             if ( timeOut != "")
             {
                 if (timeOut <= 0 || timeOut.match(regExp) == null)
                 {
                    alert("Keep Alive Timeout must be a positive float value greater than 0");
                    document.addform.timeout.focus();
                    return false;
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
          
          var agent = navigator.userAgent.toLowerCase();
          var ie = (agent.indexOf("msie") != -1);          
          
          function toggleSSL(val)
          {
            elem = document.getElementById('sslSection');
            rows = elem.rows;
            if ( val == 'yes') {
                for(i = 0; i < rows.length; i++)
                {
                    if (ie) {
                        rows[i].style.display="block";
                    }
                    else
                    {
                        rows[i].style.display="block";
                        rows[i].style.display="table-row";
                    }
                }
            }
            else
            {
               for(i = 0; i < rows.length; i++)
                     rows[i].style.display="none";
            }
          }
          
          </SCRIPT>
          <TR>
            <td class="oddrow"><label for="alias">Alias</label></td>
            <TD class="oddrow-l">
              <INPUT id="alias" NAME="alias" VALUE="%value alias encode(htmlattr)%"> </TD>
          </TR>
          <TR>
            <td class="evenrow"><label for="host">Host Name or IP Address</label></td>
            <TD class="evenrow-l">
              <INPUT id="host" NAME="host" VALUE="%value host encode(htmlattr)%"> </TD>
          </TR>
          <TR>
            <td class="oddrow"><label for="port">Port Number</label></td>
            <TD class="oddrow-l">
              <INPUT id="port" NAME="port" VALUE="%value port encode(htmlattr)%" SIZE=5 MAXLENGTH=5> </TD>
          </TR>
          <TR>
            <td class="evenrow"><label for="user">User Name</label></td>
            <TD class="evenrow-l">
              <INPUT id="user" NAME="user" VALUE="%value user encode(htmlattr)%"> </TD>
          </TR>
          <TR>
            <td class="oddrow"><label for="pass">Password</label></td>
            <TD class="oddrow-l">
              <INPUT id="pass" NAME="pass" TYPE="password" autocomplete="off" VALUE="********"/> </TD>
          </TR>
          <TR>
            <td class="evenrow"><label for="acl">Execute ACL</label></td>
            <TD class="evenrow-l">%invoke wm.server.access.adminui:aclList%
              <SELECT name="acl" id="acl">
<!--                <OPTION value="">&lt;Default ACL&gt;</OPTION> -->
                %loop aclgroups%
                <OPTION id="Execute ACL"
                  %ifvar ../acl vequals(name)%selected%endif%
                  %ifvar ../acl%%else%%ifvar name equals('Internal')%selected%endif%%endif% value="%value name encode(htmlattr)%">%value name encode(html)%</OPTION>
                %endloop%
              </SELECT> %endinvoke%  </TD>
          </TR>
          <TR>
            <td class="oddrow"><label for="mklc">Max Keep Alive Connections</label></td>
            <TD class="oddrow-l">
              <INPUT id="mklc" NAME="keepalive" VALUE="%value keepalive encode(htmlattr)%" SIZE=5 MAXLENGTH=5> (Default 5)</TD>
          </TR>
          <TR>
            <td class="evenrow"><label for="kat">Keep Alive Timeout (minutes)</label></td>
            <TD class="evenrow-l">
              <INPUT id="kat" NAME="timeout" VALUE="%value timeout encode(htmlattr)%" SIZE=5 MAXLENGTH=5> (Default 1)</TD>
          </TR>
          <TR>
            <td class="oddrow">Use SSL</td>
            <TD class="oddrow-l">
				<input type="radio" name="ssl" id="ssl1" value="yes" onclick="toggleSSL('yes');" %ifvar ssl equals(yes)%checked%endif%><label for="ssl1">Yes</label></input>
				<input type="radio" name="ssl" id="ssl2" value="no"  onclick="toggleSSL('no');" %ifvar ssl equals(no)%checked %else% %ifvar action equals('edit')%%else%checked%endif%%endif%><label for="ssl2">No</label></input>
            </TD>
          </TR>
          
          <tbody id="sslSection">
              <TR>
				<td class="evenrow"><label for="ksa">Keystore Alias (optional)</label></td>
                <TD class="evenrowdata-l">
					<SELECT id="ksa" class="listbox" name="keyStoreAlias" onchange="changeval()"></SELECT>
                </TD>
              </TR>
              <TR>
			   	<td class="oddrow"><label for="ka">Key Alias (optional)</label></td>
                <TD class="oddrowdata-l">
		        	<select id="ka" class="listbox" name="keyAlias" ></select>  		
                </TD>
               </TR>
         </tbody>             
         
          <TR>
            <td class="evenrow"><label for="retryServer">Retry Server</label></td>
            <TD class="evenrow-l">
              <INPUT id="retryServer" NAME="retryServer" VALUE="%value retryServer encode(htmlattr)%"> </TD>
          </TR>

          %invoke wm.server.remote:serverList%

          <TR>
          %loop -struct servers%
            %scope #$key%
            <TD>
              <INPUT TYPE="hidden" NAME="aliases" VALUE="%value alias encode(htmlattr)%" />
            </TD>
            %endscope%
          %endloop%
          </TR>

          <TR>
            <TD colspan=2 class="action">
              <INPUT TYPE="hidden" NAME="args" VALUE="xxx">
            %ifvar action equals('edit')%
              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
              <INPUT TYPE="hidden" NAME="oldAlias" VALUE="%value alias encode(htmlattr)%">
              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
            %else%
              <INPUT TYPE="hidden" NAME="action" VALUE="add">
              <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
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
