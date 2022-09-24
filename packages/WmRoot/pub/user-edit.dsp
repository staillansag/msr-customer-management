<html>
  <head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  <title>User Edit</title>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT src="webMethods.js"></SCRIPT>
</head>
<body>
  <table width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">
        Security&gt;
        Users &amp; Groups&gt;
        Change Password</TD>
    </TR>
    <TR>
      <TD colspan=2>
        <UL>
          <li>
		  <script>
		  createForm("htmlform_users", "users.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("users.dsp","javascript:document.htmlform_users.submit();","Return to Users and Groups");</script></li>
        </UL>
      </TD>
    </TR>

    <TR>
      <TD>
        <TABLE class="tableView">




<script>
function checkEverything()
{
  if (!verifyRequiredField('setPassword', 'password'))
    {
      alert("A new password is required.");
      return false;
    }

  if (!verifyRequiredField('setPassword', 'password2'))
    {
      alert("The password must be typed in twice to verify it is typed in correctly.");
      return false;
    }
  
  try {
   var pw = document.forms['setPassword'].password.value;  
  if ( pw.search(/^\*+/) >= 0 )
    {
      alert("The password must not start with *");
      return false;
    }
  } catch (e) {
    alert('password error = ' + e);
  }

    if (document.setPassword.allowDigestAuthentication.checked)
    {
        document.setPassword.allowDigestAuth.value = true;
    }
    else
    {
        document.setPassword.allowDigestAuth.value = false;
    }
  return verifyFieldsEqual('setPassword', 'password', 'password2');

}
function unmaskPassword() {
	if (document.setPassword.unmask.checked){
		document.setPassword.password.type='text';
	} else {
		document.setPassword.password.type='password';
	}
}
</script>
        %invoke wm.server.access:isDigestAuthAllowedForUser%

        <FORM NAME="setPassword" METHOD="POST" ACTION="users.dsp">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <INPUT TYPE="hidden" NAME="username" VALUE="%value username encode(htmlattr)%">
        <INPUT TYPE="hidden" NAME="action" VALUE="setPassword">
        <input type="hidden" name="allowDigestAuth" value="false">
          <TR>
            <TD class="heading" colspan=2>Change Password</TD>
          </TR>
          <TR>
            <TD class="oddrow"><label for="user">  User </label></TD>
            <TD class="oddrow-l"><b id="user">%value username encode(html)%</b>
            </TD>
          </TR>

          <TR><TD class="evenrow"><label for="password1">  New Password</label></TD>
            <TD class="evenrow-l"><INPUT type="password" name="password" id="password1" autocomplete="off"></INPUT>
			<input type="checkbox" name="unmask" id="unmask" onclick="unmaskPassword();"><label for="unmask">Show Password</label></input>
			</TD>
          </TR>


          <TR><TD class="oddrow"><label for="password2"> Confirm Password</label></TD>
            <TD class="oddrow-l"><INPUT type="password" name="password2" id="password2" autocomplete="off"></INPUT>
			</TD>
          </TR>

         <tr>
            <td class="evenrow"><label for="allowDigestAuthentication"> Allow Digest Authentication</label></td>
            <td class="evenrow-l">
                <input type="checkbox" name="allowDigestAuthentication" id="allowDigestAuthentication" %ifvar allowDigestAuthentication equals('true')%checked%endif% >
            </td>
          </tr>


          <TR>
            <TD class="action" colspan=2>
            <INPUT class="data" type="submit" onclick="return checkEverything();" value="Save Password">
            </TD>
          </TR>
        </FORM>
%endinvoke%


</table>
</td></tr></table>
</body>

</html>
