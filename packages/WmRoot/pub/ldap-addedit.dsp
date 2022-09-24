
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
  </HEAD>
  %ifvar action equals('edit')%
  <BODY onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_LDAPdirectoryScrn');">
  %else%
  <BODY onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_LDAPdirectoryScrn');">
  %endif%
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan="2">
            Settings &gt;
            LDAP Directory &gt;
            %ifvar action equals('edit')%
                Edit
            %else%
                Add
            %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
		  
		  <script>
						createForm("htmlform_http_ldap_settings", "ldap-settings.dsp", "POST", "BODY");
		  </script>
		  <li>
		  <script>getURL("ldap-settings.dsp","javascript:document.htmlform_http_ldap_settings.submit();","Return to User Management");</script></li>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
      <TABLE class="tableView">
        <TR>
            <TD colspan="3" class="heading">LDAP Directory Settings</TD>
        </TR>
          <FORM NAME="addform" ACTION="ldap-settings.dsp" METHOD="POST">
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          <SCRIPT LANGUAGE="JavaScript">
          var passwordChanged = false;
          function confirmEdit () {
            if((document.addform.url.value.indexOf('ldap://') != 0 ||
                document.addform.url.value.length < 8) && 
               (document.addform.url.value.indexOf('ldaps://') != 0 ||
                document.addform.url.value.length < 9)) {
              alert ("The Directory URL is required and must begin with ldap:// or ldaps://.");
              document.addform.url.focus();
              return false;
            }
            if(!isInteger(document.addform.timeout.value)) {
              alert ("The Connection Timeout must be an integer number of seconds.");
              document.addform.timeout.focus();
              return false;
            }
            if(!isIntegerGreaterThan(document.addform.poolmin.value, -1)) {
              alert ("The Minimum Connection Pool Size must be greater than or equal to zero.");
              document.addform.poolmin.focus();
              return false;
            }
            if(!isIntegerGreaterThan(document.addform.poolmax.value, document.addform.poolmin.value-1)) {
              alert ("The Maximum Connection Pool Size must be greater than or equal to the Minimum Connection Pool Size.");
              document.addform.poolmax.focus();
              return false;
            }
            // mattr or group needs to be set
            if(document.addform.mattr.value == '' &&
               document.addform.group.selectedIndex == 0) {
               alert ("You must provide a value for at least one of the Default Group or the Group Member Attribute fields.");
               document.addform.mattr.focus();
               return false;
            }
            
            //Validate guid & group dn
            if(document.addform.gidprop.value == '' ) {
                       alert ("You must provide a value for Group ID Property.");
                       document.addform.gidprop.focus();
                       return false;
            }
            

            // do this last because we don't want to click okay and then
            // get more warnings.
            if(!isIntegerGreaterThan(document.addform.timeout.value, 0)) {
              if(!confirm("Setting a Connection Timeout less than zero will cause a request to fail immediately if no resources are available, and a value equal to zero will cause the server to wait forever for resources to become available.  Any non-positive value will cause the connection timeout to be the default value for TCP on your system.")) {
                document.addform.timeout.focus();
                return false;
              }
            }


            if(!passwordChanged) {
                // don't want to change pw to '********'!!
                document.addform.cred.value = ""; 
            }
            document.addform.submit();
            return true;
          }
          function confirmAdd () {
            return confirmEdit();
          }
          
          </SCRIPT>
          %invoke wm.server.ldap:getConfiguredServer%
          <TR>
            <TD colspan=2 class="evenrow"><label for="url">Directory URL</label></td>
            <TD class="evenrow-l">
              <INPUT name="url" id="url" size="40" VALUE="%ifvar url%%value url encode(htmlattr)%%else%ldap://%endif%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="oddrow"><label for="prin">Principal</label></td>
            <TD class="oddrow-l">
              <INPUT name="prin" id="prin" size="40" VALUE="%value prin encode(htmlattr)%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="evenrow"><label for="cred">Credentials</label></td>
            <TD class="evenrow-l">
              <INPUT name="cred" id="cred" size="40" TYPE="password" autocomplete="off" %ifvar action equals('edit')%VALUE="%ifvar -notempty prin%********%endif%"%endif% onChange="javascript:passwordChanged=true;" /> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="oddrow"><label for="timeout">Connection Timeout (seconds)</label></td>
            <TD class="oddrow-l">
              <INPUT name="timeout" id="timeout" size="5" VALUE="%ifvar timeout%%value timeout encode(htmlattr)%%else%5%endif%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="evenrow"><label for="poolmin">Minimum Connection Pool Size</label></td>
            <TD class="evenrow-l">
              <INPUT name="poolmin" id="poolmin" size="5" VALUE="%ifvar poolmin%%value poolmin encode(htmlattr)%%else%0%endif%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="oddrow"><label for="poolmax">Maximum Connection Pool Size</label></td>
            <TD class="oddrow-l">
              <INPUT name="poolmax" id="poolmax" size="5" VALUE="%ifvar poolmax%%value poolmax encode(htmlattr)%%else%10%endif%"> </TD>
          </TR>
          <TR>
            <TD rowspan=2 class="evenrow-l"><input %ifvar useaf equals('false')%%else%checked%endif% type="radio" name="useaf" id="useaf1" value="true"
              onClick="this.form.dnprefix.disabled=false;this.form.dnsuffix.disabled=false;this.form.uidprop.disabled=true;this.form.userrootdn.disabled=true;"
              ><label for="useaf1">Synthesize DN</label></td>
              <td class="evenrow"><label for="dnprefix">DN Prefix</label></td>
              <td class="evenrow-l"><INPUT %ifvar useaf equals('false')%disabled%endif% name="dnprefix" id="dnprefix" size="40" VALUE="%value dnprefix encode(htmlattr)%"></td></tr>

              <tr><td class="evenrow"><label for="dnsuffix">DN Suffix</label></td>
              <td class="evenrow-l"><INPUT %ifvar useaf equals('false')%disabled%endif% name="dnsuffix" id="dnsuffix" size="40" VALUE="%value dnsuffix encode(htmlattr)%"></td>
          </TR>
          <TR>
            <TD rowspan=2 class="oddrow-l"><input type="radio" %ifvar useaf equals('false')%checked%endif% name="useaf" id="useaf2" value="false"
              onClick="this.form.dnprefix.disabled=true;this.form.dnsuffix.disabled=true;this.form.uidprop.disabled=false;this.form.userrootdn.disabled=false;"
              ><label for="useaf2">Query DN</label></td>
              <td class="oddrow"><label for="uidprop">UID Property</label></td>
              <td class="oddrow-l"><INPUT %ifvar useaf equals('false')%%else%disabled%endif% name="uidprop" id="uidprop" size="40" VALUE="%value uidprop encode(htmlattr)%"></td></tr>

              <tr><td class="oddrow"><label for="userrootdn">User Root DN</label></td>
              <td class="oddrow-l"><INPUT %ifvar useaf equals('false')%%else%disabled%endif% name="userrootdn" id="userrootdn" size="40" VALUE="%value userrootdn encode(htmlattr)%"></td>
          </TR>
		  <TR>
		  <td colspan=2 class="evenrow"><label for="useremail">User Email</label></td>
              <td class="evenrow-l">
				<INPUT name="useremail" id="useremail" size="20" VALUE="%value useremail encode(htmlattr)%">
			  </td>
		  </TR>
          <TR>
            <TD colspan=2 class="oddrow"><label for="group1">Default Group</label></td>
            <TD class="oddrow-l">

                %invoke wm.server.access:groupList%
                <SELECT NAME="group" id="group1">
                    <OPTION value="">&lt;None&gt;</OPTION>
                    %loop groups%
                    <OPTION value="%value name encode(htmlattr)%"
                    %ifvar name vequals('../group')% selected %endif%
                    >%value name encode(html)%</OPTION>
                    %endloop%
                </SELECT>
                %endinvoke%
            </TD>
          </TR>
          <TR>
            <TD colspan=2 class="evenrow"><label for="mattr">Group Member Attribute</label></td>
            <TD class="evenrow-l">
              <INPUT name="mattr" id="mattr" size="20" VALUE="%value mattr encode(htmlattr)%"> </TD>
          </TR>
	  <TR>
	      <TD colspan=2 class="oddrow"><label for="gidprop">Group ID Property</label></td>
	      <TD class="oddrow-l">
		<INPUT name="gidprop" id="gidprop" size="40" VALUE="%value gidprop encode(htmlattr)%"> </TD>
	  </TR>
	  <TR>
	      <TD colspan=2 class="evenrow"><label for="grouprootdn">Group Root DN</label></td>
	      <TD class="evenrow-l">
		<INPUT name="grouprootdn" id="grouprootdn" size="40" VALUE="%value grouprootdn encode(htmlattr)%"> </TD>
          </TR>
      
          <TR>
            <TD colspan=3 class="action">
			<INPUT TYPE="hidden" NAME="uuid" VALUE="%value uuid encode(htmlattr)%">
            %ifvar action equals('edit')%
              <INPUT TYPE="hidden" NAME="index" VALUE="%value index encode(htmlattr)%">
              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
            %else%
              <INPUT TYPE="hidden" NAME="action" VALUE="add">
              <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
            %endif%
            </TD>
          </TR>
          %endinvoke%

          
        </FORM>
      </TABLE>
    </TD>
  </TR>
</TABLE>

    </BODY>
  </HTML>
