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
            .listbox { width: 100%; }
        </style>

        <script>
            function trim(str)
            {
                var retval = "";
                var start = str.length;
                var end = 0;
                for (i = 0; i < str.length; i++) {
                    if (start > i) {
                        if (! /\s/.test(str.charAt(i))) {
                            start = i;
                        }
                    }

                    if (! /\s/.test(str.charAt(i))) {
                        end = i;
                    }
                }

                if (start <= end) {
                    retval = str.substr(start, (end - start + 1));
                }

                return retval;
            }

            function checkLegalUserName(username)
            {
                var illegalChars = "\"\\\<&;";

                for (var i = 0; i < illegalChars.length; i++) {
                    if (username.indexOf(illegalChars.charAt(i)) >= 0) {
                        return illegalChars.charAt(i);
                    }
                }
                return "";
            }

            function containsNonAscii(username)
            {
                // Test for printable ascii characters only and return the opposite.
                var illegalRE = /^[\040-\177]*$/
                return ! illegalRE.test(username);
            }

            function checkPasses()
            {
		var users = document.getElementById("users").value.split("\n");
		for(i = 0; i < users.length; i++) {
			if(users[i].indexOf(";") != -1) {
			userpass = users[i].split(";");
			user = userpass[0];
			pass = userpass[1];
			} else {
			user = users[i];
			pass = "";
			}
			if(user.length > 256) {
				alert("Maximum allowed length exceeded. Max allowed is 256 characters for one username");
				document.getElementById("users").focus();
				return false;
			} else if(pass.length > 256) {
				alert("Maximum allowed length exceeded. Max allowed is 256 characters for one password");
				document.getElementById("users").focus();
				return false;
			}
		}
                if (document.form.allowDigestAuthentication.checked)
                {
                    document.form.allowDigestAuth.value = true;
                }
                else
                {
                    document.form.allowDigestAuth.value = false;
                }
                var covered = true;
                var passwdProvided = false;

                var userList   = document.form.users.value;
                var passField1 = document.form.pass.value;
                var passField2 = document.form.repass.value;
                var starStart  = /^\*+/;

                if (userList == "") {
                    alert("No users were entered into the list");
                    return false;
                }
                else if (passField1 != passField2) {
                    alert("Password fields do not match");
                    return false;
                }
                else if (passField1 == "" && passField2 == "") {
                    // allow this?
                    passwdProvided = false;
                }
                else if (passField1.search(starStart) >= 0) {
                    covered = false;
                    alert("Passwords must not start with *");
                    return false;
                }
                else if (passField1 != "" && passField2 != "") {
                    passwdProvided = true;
                }

                var userNameList = userList.split("\n");
                for (var i = 0; i < userNameList.length; i++) {
                    covered = false;
                    
                    var userName = trim(userNameList[i]);

                    var rc = checkLegalUserName(userName);

                    if (rc != "") {
                        alert("Username: " + userName + " contains illegal character \"" + rc + "\"");
                        return false;
                    }

                    if (containsNonAscii(userName)) {
                        alert("Username: " + userName + " contains non-ASCII character(s)");
                        return false;
                    }
                }

                if (!passwdProvided && !covered) {
                    if (userNameList.length > 1){
                          alert("Users do not have a password specified.");
                    }
                    else{
                      alert("User does not have a password specified.");
                  }
                }

                return covered || passwdProvided;
            }
			function unmaskPassword() {
				if (document.form.unmask.checked){
					document.form.pass.type='text';
				} else {
					document.form.pass.type='password';
				}
			}
        </script>
    </head>

    <SCRIPT SRC="webMethods.js"></SCRIPT>

    <BODY onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddRemoveUsersScrn');">
        <table width=100%>
            <tr>
                <td colspan=2 class="breadcrumb">
                    Security &gt;
                    User Management &gt;
                    Add and Remove Users
                </td>
            </tr>

            <form id="revert" name="revert" method="POST" action="users.dsp">
              %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            </form>

            <tr>
                <td colspan=2>
                    <ul class="listitems">
                        <li class="listitem">
						<script>
						createForm("htmlform_users", "users.dsp", "POST", "BODY");
						</script>
						<script>getURL("users.dsp","javascript:document.htmlform_users.submit();","Return to User Management");</script>
						</li>
                    </ul>
                </td>
            </tr>

            <tr>
                <td>
                    <form id="form" name="form" method="POST" action="users.dsp">
                        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                        <input type="hidden" name="action" value="addusers">
                        <input type="hidden" name="allowDigestAuth" value="false">
                        <table class="tableView" width="60%">
                            <tr>
                                <td class="heading" colspan=2>Create Users</td>
                            </tr>
                            <tr>
                              <td nowrap valign="top" class="oddrow"><label for="users">User Names</label></td>
                              <td class="oddrow-l">One "username" per line.<br>
                                <textarea style="width:100%;" wrap="off" rows="5" name="users" id="users" cols="20"></textarea></td>
                            </tr>
                            <tr>
                                <td class="evenrow-l" colspan=2>
                                    The password below will apply to all new users that do not have a password specified above.
                                </td>
                            </tr>
                            <tr>
                                <td class="oddrow"><label for="pass">Password</label></td>
                                <td class="oddrow-l">
                                    <input type="password" name="pass" id="pass" autocomplete="off" value=""/>
									<input type="checkbox" name="unmask" id="unmask" onclick="unmaskPassword();"><label for="unmask">Show Password</label></input>
                                </td>
                            </tr>
                            <tr>
                                <td class="evenrow"><label for="repass">Re-Enter Password</label></td>
                                <td class="evenrow-l">
                                    <input type="password" name="repass" id="repass" autocomplete="off" value=""/>
                                </td>
                            </tr>
                            <tr>
							    <td class="oddrow"><label for="allowDigestAuthentication">Allow Digest Authentication</label></td>
                                <td class="oddrow-l">
                                    <input type="checkbox" name="allowDigestAuthentication" id="allowDigestAuthentication">
                                </td>
                            </tr>

                            <tr>
                            <tr>
                                <td class="action" colspan=2>
                                    <input type="submit" value="Create Users" name="submit" onClick="return checkPasses();" >
                                </td>
                            </tr>
                        </table>
                    </form>

                    <form id="deleteusers" name="deleteusers" method="POST" action="users.dsp">
                        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                        <input type="hidden" name="action" value="removeusers">

                        <table class="tableView" width="60%">
                            <tr>
                                <td class="heading" colspan=2>Remove Users</td>
                            </tr>

                            <tr>
                                <td nowrap valign="top" class="oddrow">Select Users</td>
                                <td class="oddrow-l">
                                    <table class="tableInline">
                                        %invoke wm.server.access:userList%
                                            %loop users%
                                                <tr>
                                                    <td align="center">
                                                        %switch name%
                                                            %case 'Administrator'%-</td><td class="oddrow-l">Administrator (not removable)
                                                            %case 'Default'%-</td><td class="oddrow-l">Default (not removable)
                                                            %case 'Developer'%-</td><td class="oddrow-l">Developer (not removable)
                                                            %case 'Replicator'%-</td><td class="oddrow-l">Replicator (not removable)
                                                            %case 'SAPUser'%-</td><td class="oddrow-l">SAPUser (not removable)
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
                                <td class="action" colspan=2>
                                    <input type="submit" value="Remove Users" name="remove" onclick="return confirm('Are you sure you want to remove selected users?');">
                                </td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
    </body>
</html>
