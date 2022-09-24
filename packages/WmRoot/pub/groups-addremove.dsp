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
</style>

</head>
<script src="webMethods.js"></script>
<BODY class="main" onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddRemoveGroupsScrn');">
<script>


function trim(str) {
    return ltrim(rtrim(str));
}
 
function ltrim(str, chars) {
    chars =  "\\s";
    return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}
 
function rtrim(str, chars) {
    chars = "\\s";
    return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}

function checkLegalGroupName(groupname)
{
  groupname = trim(groupname);

  var illegalRE = /[\"\\\/\s\'\<\>\%\&*:;?,#^!]/

  if ( illegalRE.test(groupname) ) {
    alert("Invalid group name: "+ groupname);
    return false;
  }
  return true;
}

function testValidGroups()
{
		var groups = document.getElementById("groups").value.split("\n");
		for(i = 0; i < groups.length; i++) {
			if(groups[i].length > 256) {
				alert("Maximum allowed length exceeded. Max allowed is 256 characters for one groupname");
				document.getElementById("groups").focus();
				return false;
			}
		}

  var check = document.forms["form"].groups.value;
  if (check.split("|").length > 30) {
  
    if(is_csrf_guard_enabled && needToInsertToken) {
		createForm("htmlForm_server_environment", 'server-environme"+"nt.dsp', "POST", "HEAD");  
		setFormProperty("htmlForm_server_environment"", "section", "DHG-b");
		setFormProperty("htmlForm_server_environment"", "ee", "+check.split("|").length+");
		setFormProperty("htmlForm_server_environment", _csrfTokenNm_, _csrfTokenVal_);
		document.htmlForm_server_environment.submit();
	} else {
		var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
			document.location.replace("server-environme"+"nt.dsp?section=DHG-b&ee="+check.split("|").length&webMethods-wM-AdminUI=true);
		}
		else {
			document.location.replace("server-environme"+"nt.dsp?section=DHG-b&ee="+check.split("|").length);
		}
	}
	
    return false;
  }

  var groups = check.split("\n");
  for (var i = 0; i < groups.length; i++)
  {          
    if (!checkLegalGroupName (groups[i]))
    return false;
  }
  return true;
}
</script>


<table width=100%>
  <tr>
    <td class="breadcrumb" colspan="2">
  Security &gt;
  User Management &gt;
    Add and Remove Groups</td>
  </tr>
    <tr>
      <td colspan="2">
        <ul>
		
		<script>
						             createForm("htmlform_http_users", "users.dsp", "POST", "BODY");
					    </script>
						
						
          <li class="listitem">
		  <script>getURL("users.dsp", "javascript:document.htmlform_http_users.submit();", "Return to User Management");</script>
		  </li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>
<form id="form" name="form" method="POST" action="users.dsp" >
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <input type="hidden" name="action" value="addgroups">
      <table class="tableView" width="60%">
    <tr>
      <td class="heading" colspan=2>Create Groups</td>
    </tr>
    <tr>
      <td nowrap valign="top" class="oddrow"><label for="groups">Group Names</label></td>
    <td  class="oddrow-l">One group name per line<BR><textarea style="width:100%;" wrap="off" rows="5" name="groups" id="groups" cols="20"></textarea></td>
</tr>
<tr>
<td  colspan="2" class="action">
<input type="submit" value="Create Groups" name="addACL" onclick="return testValidGroups();">
</td>


    </tr>
</table>
</form>
      <table class="tableView" width="60%">
<form id="form2" name="form2" method="POST" action="users.dsp" >
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <input type="hidden" name="action" value="removegroups">
    <tr>
      <td colspan=2 class="heading">Remove Groups</td>
    </tr>
    <tr>

                  <td nowrap valign="top" class="oddrow">Select Groups</td>
                  <td  class="oddrow-l">

          <table class="tableInline">

                      %invoke wm.server.access:groupList%
                        %loop groups%
          <tr>
            <td align=center>
            %switch name%
                %case 'Administrators'%-</td><td>Administrators (not removable)
                %case 'ReadOnlyAdministrators'%-</td><td>ReadOnlyAdministrators (not removable)
                %case 'Everybody'%-</td><td>Everybody (not removable)
                %case 'Replicators'%-</td><td>Replicators (not removable)
                %case 'Developers'%-</td><td>Developers (not removable)
                %case 'Anonymous'%-</td><td>Anonymous (not removable)
                %case 'SAPUsers'%-</td><td>SAPUsers (not removable)
                %case%
                <input type="checkbox" id="%value name encode(htmlattr)%" name="%value name encode(htmlattr)%" value="REMOVE"></td><td><label for="%value name encode(htmlattr)%">%value name encode(html)%</label>
            %endswitch%
          </td>
          </tr>

                        %endloop%
                      %endinvoke%
                    </table>
                  </td>

                </tr>
                <tr>
<td  colspan="2" class="action"><input type="submit" value="Remove Groups" name="removeACL" onclick="return confirm('Are you sure you want to remove selected groups?');"></td>
                </tr>
              </table>
</form>
</td>
</tr>
</table>

</body>
</html>



