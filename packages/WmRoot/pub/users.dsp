<html>

<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<title>ServerUI</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<base target="_self">
<style>
  .listbox  { width: 100%; }

  .arrow {
      font-size: 1.4em;
      font-weight: bold;
      text-align: center;
      width: 100%;
  }
</style>
</head>
<script src="webMethods.js"></script>
<script src="client.js"></script>
<script src="users.js"></script>
<SCRIPT LANGUAGE="JavaScript">
    function checkCDSEnabled(){
        var e1 = document.getElementById('cds');
        var e2 = document.getElementById('pool');
        if (e1.checked == true){
            e2.disabled=false;
        }else{
            e2.disabled=true;
        }
    }

</SCRIPT>

<BODY class="main" onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UsersAndGroupsScrn');" onbeforeunload="checkDirty();">
<table width=100% style="border-collapse: collapse;">
  <tr>
    <td class="breadcrumb" colspan=2>Security &gt; User Management&nbsp;</td>
  </tr>

%ifvar action equals('editCommonUM')%
    %invoke wm.server.jndi:setCDSSettings%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
        %endif%
    %endinvoke%
%endif%


%ifvar action equals('update')%
    %invoke wm.server.access:updateUsersGroups%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
        %endif%
    %endinvoke%
%endif%

%ifvar action equals('addusers')%
  %invoke wm.server.access:addUsers%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
    %endif%
    %ifvar warning%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value warning%</TD></TR>
    %endif%
  %endinvoke%
%endif%

%ifvar action equals('removeusers')%
  %invoke wm.server.access:removeUsers%
      %ifvar message%
       <tr><td colspan="2">&nbsp;</td></tr>
     <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
     <script>
	 parent.document.getElementById('top').contentWindow.location.reload(true);
	 </script>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('addgroups')%
  %invoke wm.server.access:addGroups%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
    %endif%
  %endinvoke%
%endif%

%ifvar action equals('removegroups')%
  %invoke wm.server.access:removeGroups%
      %ifvar message%
       <tr><td colspan="2">&nbsp;</td></tr>
     <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('editPassword')%
  %invoke wm.server.admin:setPasswordSettings%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('setPassword')%
  %invoke wm.server.access:userChange%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
      %endif%
      %ifvar warning%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value warning encode(html)%</TD></TR>
      %endif%
  %endinvoke%
%endif%
<!------------------------------------------------------------------------------------------------------->
<tr>
   <td>

  <table width="100%" class="tableView">
    <tr>
      <td class="heading" colspan="2">Central User Management Configuration</td>
    </tr>

%ifvar edit%
%else%
%endif%

<tr><td style="padding: 0;">
<table width="100%">
%ifvar edit%
                      <td>
					<script>
					createForm("htmlform_users", "users.dsp", "POST", "BODY");
					</script>
					<li>
                    <script>getURL("users.dsp","javascript:document.htmlform_users.submit();","Return to User Management");</script>
					</li>
                      </td>
%endif%
                <TR><td class="heading" colspan="2">
                General
            </td></TR>

%ifvar edit%
<FORM id="commonUMForm" name="commonUMForm" method="POST" action="users.dsp" >
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

        <TR>
            <TD class="evenrow">Central User Management</TD>
            <TD class="evenrow-l">
                %invoke wm.server.jndi:getCDSSettings%
				<INPUT id="cds" TYPE="radio" name="cds" id="cds1"  value="true" onClick="checkCDSEnabled()" %ifvar cds equals('true')%checked%endif%><FONT id='cdsFont'><label for="cds1">Configured</label></FONT>
				<INPUT id="cds2" TYPE="radio" name="cds" id="cds2"  value="false" onClick="checkCDSEnabled()" %ifvar cds equals('false')%checked%endif%><label for="cds2">Not Configured</label></input>
                %endinvoke%
            </TD>
        </TR>
        <TR>
            <TD class="oddrow">Central User Management JDBC Pool</TD>
            <TD class="oddrowdata-l">
                %invoke wm.server.jdbcpool:getAvailablePoolDefinitions%
                  %ifvar message%
                    </TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                  %endif%

                  <SELECT id=pool NAME="jdbcpool">
<!--                    <OPTION VALUE="" %ifvar function.pool notempty% %else% SELECTED %endif%>None-->

                  %loop pools%
                    <OPTION VALUE="%value pool.name  encode(htmlattr)%" %ifvar ../function.pool vequals(pool.name)% SELECTED %endif%>%value pool.name encode(html)%
                  %endloop%
                  </SELECT>
                  </TD></TR>
                %onerror%
                  </TD></TR>
                  <TR><TD colspan="2">&nbsp;</TD></TR>
                  <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
                  <TR><TD colspan="2">&nbsp;</TD></TR>
                %endinvoke%

                <SCRIPT>
                    checkCDSEnabled();
                </SCRIPT>
            </TD>
        </TR>

        <TR>
            <TD class="action" colspan=2>
              <INPUT TYPE="hidden" NAME="action" VALUE="editCommonUM">
              <INPUT type="submit" id='cdsSubmit' value="Save Changes">
        <SCRIPT>
                    var poolElem = document.getElementById('pool');
            if (poolElem.length == 0){
                        document.getElementById('cds').disabled = true;
                        document.getElementById('cdsFont').style.color = 'grey';
                        document.getElementById('cds2').checked = true;
                    var newoption = new Option("JDBC Pool is Not Configured", "" );
                poolElem.options[0] = newoption;
                        document.getElementById('cdsSubmit').disabled = true;
                    }
        </SCRIPT>
            </TD>

        </TR>
</FORM>
%else%
        %invoke wm.server.jndi:getSettings%
                <TR>
                <TD class="evenrow" style="text-align: left; width: 20%">Central User Management</TD>
                <TD class="evenrowdata-l">
                %ifvar cdsRunning equals('true')%Configured%else%Not Configured%endif%
                </TD>
            </TR>
        %endinvoke%
%endif%
</table>
</td>
</tr>

</table>

<tr>
<td>
   <table class="tableView" width="100%" %ifvar edit% style="display:none"%endif%>
    <tr>
      <td class="heading" colspan=2>Local User Management</td>
    </tr>
    <tr>
      <td valign="top">
        <ul class="listitems">
		<script>
		createForm("htmlform_users_addremove", "users-addremove.dsp", "POST", "BODY");
		createForm("htmlform_users_provider_addremove", "users-provider-addremove.dsp", "POST", "BODY");
		createForm("htmlform_groups_addremove", "groups-addremove.dsp", "POST", "BODY");
		createForm("htmlform_users_disable", "users-disable.dsp", "POST", "BODY");
		</script>
          <li class="listitem">
		  <script>getURL("users-addremove.dsp","javascript:document.htmlform_users_addremove.submit();","Add and Remove Users");</script></li>
          <li class="listitem">
		  <script>getURL("users-provider-addremove.dsp","javascript:document.htmlform_users_provider_addremove.submit();","Add and Remove OpenID Provider Users");</script></li>
          <li class="listitem">
		  <script>getURL("groups-addremove.dsp","javascript:document.htmlform_groups_addremove.submit();","Add and Remove Groups");</script></li>
          <li class="listitem">
		  <script>getURL("users-disable.dsp","javascript:document.htmlform_users_disable.submit();","Enable and Disable Users");</script></li>
        </ul>
      </td>
      <td valign="top">
        <ul class="listitems">
          <li class="listitem">
		  <script>
		  createForm("htmlform_password_settings", "password-settings.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("password-settings.dsp","javascript:document.htmlform_password_settings.submit();","Password Restrictions");</script>
		  </li>

          %invoke wm.server.jndi:getSettings%
          <li class="listitem">
		  <script>
		  createForm("htmlform_jndi_settings", "jndi-settings.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("jndi-settings.dsp","javascript:document.htmlform_jndi_settings.submit();","LDAP Configuration");</script></li>
          %endinvoke%
		  <li class="listitem">
		  <script>
		  createForm("htmlform_password_expiry_settings", "password-expiry-settings.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("password-expiry-settings.dsp","javascript:document.htmlform_password_expiry_settings.submit();","Password Expiration Settings");</script>
		  </li>
		  <li class="listitem">
		  <script>
		  createForm("htmlform_account_locking_settings", "account-locking-settings.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("account-locking-settings.dsp","javascript:document.htmlform_account_locking_settings.submit();","Account Locking Settings");</script>
		  </li>
        </ul>
      </td>
    </tr>
    <tr>
      <td width="50%" style="padding: 0;" >
<form id="form" name="form" method="POST" action="users.dsp" onsubmit="return submitForm();" >
%ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
<input type="hidden" name="action" value="nothing">

  <table class="noborders" width="100%">
    <tr>
      <td class="heading">Users</td>
    </tr>
    <tr>
      <td class="evenrow" style="padding: 0; border-collapse: collapse; border: none;">
        <table class="tableInline" width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
          </tr>
          <tr>
            <td align="left">
              <table class="tableInline" width="100%">
<!--
                <tr>
                  <td nowrap align="right">Filter List:</td>
                  <td width="100%"><select size="1" name="userFilter" onchange="filterUserList(this.options[this.selectedIndex].value);" >
                <option selected value="0">---- Alll ----</option>
                <option>a</option>
                <option>b</option>
                <option>c</option>
                <option>d</option>
                <option>e</option>
                <option>f</option>
              </select></td>
                </tr>
-->
                <tr>
                  <td class="evenrow" nowrap align="right">
              <label for="users">Select User:</label></td>
                  <td class="evenrow" width="100%" align=right><select id="users" class="listbox" onchange="changeUser(this.options[this.selectedIndex].value);" size="1" name="users">
          <option selected>---none---</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>

        </select></td></tr>
        <tr><td class="evenrow" colspan=3 align=right>
		<script>
		createForm("htmlform_user_edit_users", "user-edit.dsp", "POST", "BODY");
		</script>
        <font style="font-size: 85%;">
		<script>
		       if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_user_edit_users.submit();" onclick="return editPassword(userList.options[userList.selectedIndex].value);">change password</a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('(<a href="user-edit.dsp?webMethods-wM-AdminUI=true" onclick="return editPassword(userList.options[userList.selectedIndex].value);">change password</a>)');
					}
					else {
						document.write('(<a href="user-edit.dsp" onclick="return editPassword(userList.options[userList.selectedIndex].value);">change password</a>)');
					}
		       }
           </script></font></td>
                </tr>
              </table>
            </td>
            <td>
            </td>
          </tr>
          <tr>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="oddrow">
        <table width="100%" class="noborders">
          <tr>
            <td class="grouping-positive" valign="bottom" align="center">
              <label for="membergroups">Groups user <nobr>belongs to</nobr></label><br>
              <select class="listbox" onchange="unselect(this, availablegroupsList, memberusersList, availableusersList);changeSelectedGroup(this.options[this.selectedIndex].value);" size="10" id="membergroups" name="membergroups" multiple>
          <option>-----none-----</option>
        </select>
            </td>
            <td class="grouping-neutral" valign="bottom" align="center">
              <label for="availablegroups">Remaining Groups</label><br>
              <select class="listbox" onchange="unselect(this, membergroupsList, memberusersList, availableusersList);changeSelectedGroup(this.options[this.selectedIndex].value);" id="availablegroups" size="10" name="availablegroups" multiple>
          <option>------none------</option>
        </select>
        </td>
          </tr>
          <tr>
            <td class="oddcol" valign="bottom" align="center" style="text-align: center">
              <input onclick="moveitem(membergroupsList, availablegroupsList);"  type="button" value="&#8594" name="moveRight1" class="widebuttons arrow">
            </td>
            <td class="oddcol" valign="bottom" align="center" style="text-align: center">
        <input onclick="moveitem(availablegroupsList, membergroupsList);" type="button" value="&#8592" name="moveLeft1" class="widebuttons arrow">
        </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
      </td>
      <td width="50%" valign="top"  style="padding: 0;">
  <table class="noborders" width="100%">
    <tr>
      <td class="heading">Groups</td>
    </tr>
    <tr>
      <td class="evenrow" style="padding: 0; border-collapse: collapse; border: none;">
        <table class="tableInline" width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
          </tr>
          <tr>
            <td align="left">
              <table class="tableInline" width="100%">
<!--
                <tr>
                  <td nowrap align="right">Filter List:</td>
                  <td width="100%"><select size="1" name="groupFilter">
                      <option selected>All Groups</option>
                    </select></td>
                </tr>
-->
                <tr>
                  <td class="evenrow" nowrap align="right"><label for="groups">Select group:&nbsp;</label></td>
                  <td class="evenrow" width="100%"><select id="groups" class="listbox" onchange="changeGroup(this.options[this.selectedIndex].value);" size="1" name="groups">
          <option selected>---none---</option>
          <option>placeholder placeholder</option>+
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>
          <option>placeholder placeholder</option>

        </select></td></tr>
        <tr><td class="evenrow" colspan="3" align="right"><font style="font-size: 85%;">&nbsp;</font></td></td>
                </tr>
              </table>
            </td>
            <td>
            </td>
          </tr>
          <tr>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
            <td><img border="0" src="images/blank.gif" width="5" height="5"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="oddrow" style="text-align: center">
        <table width="100%" class="noborders">
          <tr>
            <td class="grouping-positive" valign="bottom" align="center">
              <label for="memberusers">Users in <nobr>this Group</nobr></label><br>
              <select class="listbox" onchange="unselect(this, availableusersList, availablegroupsList, membergroupsList);changeSelectedUser(this.options[this.selectedIndex].value);" size="10" id="memberusers" name="memberusers" multiple>
          <option>-----none-----</option>
        </select>
            </td>
            <td class="grouping-neutral" valign="bottom" align="center">
              <label for="availableusers">Remaining Users</label><br>
              <select class="listbox" onchange="unselect(this, memberusersList, availablegroupsList, membergroupsList);changeSelectedUser(this.options[this.selectedIndex].value);" id="availableusers" size="10" name="availableusers" multiple>
          <option>------none------</option>
        </select>
        </td>
          </tr>
          <tr>
            <td class="oddcol" valign="bottom" align="center" style="text-align: center">
              <input onclick="moveitem(memberusersList, availableusersList);"  type="button" value="&#8594" name="moveRight2" class="widebuttons arrow">
            </td>
            <td class="oddcol" valign="bottom" align="center" style="text-align: center">
        <input onclick="moveitem(availableusersList, memberusersList);" type="button" value="&#8592" name="moveLeft2" class="widebuttons arrow">
        </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
      </td>
    </tr>
    <tr>
      <td colspan=2 class="action" align="center" width="100%"><input type="submit" onclick="saveChanges();"  value="Save Changes" name="OK">
        </td>
    </tr>

  </table>
  <input type="hidden" name="usergroupdata" value="">

  </form>

</td></tr>

<tr><td>&nbsp;&nbsp;&nbsp;</td></tr>

<script>
  //declare form objects as variables
  var TheForm = document.forms["form"];
  //var userfilterList = TheForm.userFilter;
  var userList =  TheForm.users;
  var groupList = TheForm.groups;
  var membergroupsList = TheForm.membergroups;
  var availablegroupsList = TheForm.availablegroups;
  var memberusersList = TheForm.memberusers;
  var availableusersList = TheForm.availableusers;
  var newUser = TheForm.newuser;
  var hiddenSave = TheForm.usergroupdata;
  var hiddenAction = TheForm.action;
</script>

<script>
%invoke wm.server.access:groupList%
%loop groups%
addGroup("%value name encode(javascript)%", [%loop membership%"%value encode(javascript)%"%loopsep ','% %endloop%]);%endloop%

</script>

<script>
setupPage();
</script>
</body>
</html>
