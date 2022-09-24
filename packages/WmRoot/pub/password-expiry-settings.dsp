<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>Password Expiry Settings</title>
		<link REL="stylesheet" type="text/css" href="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
		<script src="webMethods.js"></script>
		<style>
			.listbox  { width: 100%; }
			.arrow {
				font-size: 1.4em;
				font-weight: bold;
				text-align: center;
				width: 100%;
			}
			.emailDiv {
				width: 200px;
				word-wrap: break-word;
			}
		</style>
		<script language="JavaScript">
			function populateUsers(s, r) {
				var selectedUsers = s.split(";");
				var remainingUsers = r.split(";");
				if(s.length > 0 && selectedUsers.length > 0 ) {
					htmlform_psExirySettings.selecteduserslist.options.length = 0;
					for(var i = 0; i < selectedUsers.length; i++) {
						var newOption = document.createElement("option");
						newOption.text = selectedUsers[i];
						newOption.value = selectedUsers[i];
						htmlform_psExirySettings.selecteduserslist.add(newOption);
					}
				}
				if(r.length > 0 && remainingUsers.length > 0 ) {
					htmlform_psExirySettings.remaininguserslist.options.length = 0;
					for(var i = 0; i < remainingUsers.length; i++) {
						var newOption = document.createElement("option");
						newOption.text = remainingUsers[i];
						newOption.value = remainingUsers[i];
						htmlform_psExirySettings.remaininguserslist.add(newOption);
					}
				}
			}
			function moveUsersToRemainingList() {
				removeDummyFromDest(htmlform_psExirySettings.remaininguserslist);
				move(htmlform_psExirySettings.selecteduserslist, htmlform_psExirySettings.remaininguserslist);
				addDummyToSource(htmlform_psExirySettings.selecteduserslist);
			}
			function moveUsersToSelectedList() {
				removeDummyFromDest(htmlform_psExirySettings.selecteduserslist);
				move(htmlform_psExirySettings.remaininguserslist, htmlform_psExirySettings.selecteduserslist);
				addDummyToSource(htmlform_psExirySettings.remaininguserslist);
			}
			function move(fromlist, tolist) {
				var len = fromlist.length
				var selectedOptions = [];
				var j=0;
				for (var i = 0; i < fromlist.length; i++) {
					if (fromlist.options[i].selected) {
						if(fromlist.options[i].value != 'dummyuser' && (fromlist.options[i].text == fromlist.options[i].value)) {
							selectedOptions[j] = fromlist.options[i];
							var newOption = document.createElement("option");
							newOption.text = fromlist.options[i].text;
							newOption.value = fromlist.options[i].value;
							tolist.add(newOption);
							j++;
						}
					}
				}
				for(var i=0; i < selectedOptions.length; i++) {
					fromlist.removeChild(selectedOptions[i]);
				}
			}
			function removeDummyFromDest(tolist) {
				var len = tolist.options.length;
				if(len == 1) {
					if(tolist.options[0].value == 'dummyuser' && (tolist.options[0].text != tolist.options[0].value)) {
						tolist.removeChild(tolist.options[0]);
					}
				}
			}
			function addDummyToSource(fromlist) {
				var len = fromlist.options.length;
				if(len == 0) {
					var newOption = document.createElement("option");
					newOption.text = '-----none-----';
					newOption.value = 'dummyuser';
					fromlist.add(newOption);
				}
			}
			function validate(htmlForm) {
				if(!verifyRequiredNonNegNumber('htmlform_psExirySettings', 'expirationInterval')) {
					alert("Specify a valid non-zero positive integer value for 'Expiration Interval'.")
					return false;
				}
				if(!verifyRequiredNonNegNumber('htmlform_psExirySettings', 'expiryEmailBefore')) {
					alert("Specify a valid positive integer value for 'Expiration Email Reminders'.")
					return false;
				}
				var expirationInterval = htmlForm.expirationInterval.value;
				var expiryEmailBefore = htmlForm.expiryEmailBefore.value;
				if(Number(expiryEmailBefore) >= Number(expirationInterval)) {
					alert("The value specified for 'Expiration Email Reminders' must be less than the value specifed for 'Expiration Interval'.");
					return false;
				}
				if(htmlForm.isEnabledChk.checked) {
					htmlForm.isEnabled.value='true';
				} else {
					htmlForm.isEnabled.value='false';
				}
				var selectedOptions = htmlForm.selecteduserslist.options;
				var selectedUserString="";
				if(selectedOptions.length == 1 && selectedOptions[0].value == 'dummyuser' && selectedOptions[0].text != selectedOptions[0].value) {
				} else {
					for(var i=0; i < selectedOptions.length; i++) {
						if(i != selectedOptions.length - 1) {
							selectedUserString = selectedUserString + selectedOptions[i].value + ";";
						} else {
							selectedUserString = selectedUserString + selectedOptions[i].value;
						}
					}
					htmlForm.applicableUsers.value=selectedUserString;
				}
				
				return true;
			}
			function populateUsersInPre(users) {
				var selectedUsers = users.split(";");
				var u = "None";
				var sep = "";
				if(selectedUsers.length > 0) {
					u = "";
					for(var i = 0; i < selectedUsers.length; i++) {
						u = u + sep + selectedUsers[i];
						if(i==0) {
							sep="\n";	
						}
					}	
				}
				var preAppliesToUsers = document.getElementById('preAppliesToUsers');
				if (preAppliesToUsers.innerText) {
					preAppliesToUsers.innerText = u;
				} else {
					preAppliesToUsers.innerHTML = u;
				}
			}
		</script>
	</head>
	%ifvar doc equals('edit')%
    <body onLoad="setNavigation('password-expiry-settings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditPasswordExpiryScrn');">
	%else%
    <body onLoad="setNavigation('password-expiry-settings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_PasswordExpiryScrn');">
	%endif%
		<table width="100%">
			<tr>
				<td class="breadcrumb" colspan="2"> 
					Security &gt; User Management &gt; Password Expiration Settings %ifvar doc equals('edit')% &gt; Edit %endif%
				</td>
			</tr>
			%ifvar action equals('updatePasswordExpirySettings')%
			  %invoke wm.server.access:updateExpirySettings%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			  %endinvoke%
			%endif%
   			<tr>
				<td colspan="2">
					<ul class="listitems">
						<li class="listitem">
							<script>
								createForm("htmlform_nav_back_users", "users.dsp", "POST", "BODY");
								createForm("htmlform_nav_password_settings", "password-expiry-settings.dsp", "POST", "BODY");
							</script>
							<script>getURL("users.dsp","javascript:document.htmlform_nav_back_users.submit();","Return to User Management");</script>
						</li>
						%ifvar doc equals('edit')%
							<li class="listitem">
								<script>getURL("password-expiry-settings.dsp","javascript:document.htmlform_nav_password_settings.submit();","Return to Password Expiration Settings");</script>
							</li>
						%else%
							<script>setFormProperty("htmlform_nav_password_settings", "doc", "edit");</script>
							<li class="listitem">
								<script>getURL("password-expiry-settings.dsp?doc=edit","javascript:document.htmlform_nav_password_settings.submit();","Edit Password Expiration Settings");</script>
							</li>
						%endif%
					</ul>
				</td>
			</tr>
			<tr>
				<td>
					<table width="40%" class="%ifvar doc equals('edit')%tableView%else%tableView%endif%">
						<form name="htmlform_psExirySettings" id="htmlform_psExirySettings" action="password-expiry-settings.dsp" method="POST">
						    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
							<input type="hidden" name="applicableUsers" id="applicableUsers">
							<input type="hidden" name="isEnabled" id="isEnabled">
							<input type="hidden" name="action" id="action" value="updatePasswordExpirySettings">
							%invoke wm.server.access:getPasswordExpirySettings%
								<tr>
									<td class="heading" colspan=2>Password Expiration Settings</TD>
								</tr>
								<tr>
									<td class="evenrow"><label for="isEnabledChk">Enabled</label></td>
									<td class="%ifvar doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										%ifvar doc equals('edit')%
											<input type="checkbox" name="isEnabledChk" id="isEnabledChk" %ifvar isEnabled equals('true')%checked%endif%>
										%else%
											%ifvar isEnabled equals('true')%
												Yes
											%else%
												No
											%endif%	
										%endif%
									</td>
								</tr>
								<tr>
									<td class="evenrow"><label for="expirationInterval">Expiration Interval</label></td>
									<td class="%ifvar doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										%ifvar doc equals('edit')%
											<input type="text" name="expirationInterval" id="expirationInterval" value="%value expirationInterval encode(htmlattr)%">
										%else%
											%value expirationInterval%
										%endif%
										&nbsp;Days
									</td>
								</tr>
								<tr>
									<td class="evenrow"><label for="emailIds">Expiration Notice Email Addresses</label></td>
									<td class="%ifvar doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										%ifvar doc equals('edit')%
											<textarea name="emailIds" wrap="off" id="emailIds"  rows="5" cols="30" style="width:100%">%value emailIds encode(html)%</textarea>
											<br>Enter one email address per line.
										%else%
											%ifvar emailIds equals('')%
                                                    None
											%else%
												<table width="100%">
													<tr>
														<td class="oddrowdata-l">
															<pre class="fixedwidth">%value emailIds encode(html)% </pre>
														</td>
													</tr>
												</table>
											%endif%
										%endif%
									</td>
								</tr>
								<tr>
									<td class="evenrow">Expiration Email Reminders</td>
									<td class="%ifvar doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									  <script>writeEdit("%value doc encode(javascript)%", "expiryEmailBefore", "%value expiryEmailBefore encode(html_javascript)%");</script>
									  &nbsp;Days Prior to Password Expiry
									</td>
									
								</tr>
								<tr>
									%ifvar doc equals('edit')%
										<td colspan="2">				
											<table width="100%" class="noborders">
												<tr>
													<td width="50%" class="grouping-positive" valign="bottom" align="center">
														<label for="selecteduserslist">Applies to Users</label><br>
														<select class="listbox"  size="10" id="selecteduserslist" name="selecteduserslist" multiple>
														<option value="dummyuser">-----none-----</option>
														</select>
													</td>
													<td width="50%" class="grouping-neutral" valign="bottom" align="center">
														<label for="remaininguserslist">Remaining Users</label><br>
														<select class="listbox" id="remaininguserslist" size="10" name="remaininguserslist" multiple>
														<option value="dummyuser">------none------</option>
														</select>
													</td>
												</tr>
												<script>populateUsers('%value applicableUsers%', '%value remainingUsers%');</script>
												%ifvar doc equals('edit')%
												<tr>
													<td class="oddcol" valign="bottom" align="center">
														<input onclick="moveUsersToRemainingList();" type="button" value="&#8594" name="moveRight1" class="widebuttons arrow">
													</td>
													<td class="oddcol" valign="bottom" align="center">
														<input onclick="moveUsersToSelectedList();" type="button" value="&#8592" name="moveLeft1" class="widebuttons arrow">
													</td>
												</tr>
												%endif%
											</table>
										</td>
									%else%
										<td class="evenrow"><label for="preAppliesToUsers">Applies to Users</label></td>
										<td class="evenrowdata-l">
											%ifvar applicableUsers equals('')%
                                                    None
											%else%
												<table width="100%">
													<tr>
														<td class="oddrowdata-l">
															<pre class="fixedwidth" id="preAppliesToUsers"></pre>
														</td> 
													</tr>
												</table>
												<script>populateUsersInPre('%value applicableUsers%')</script>
											%endif%	
										</td>	
											
									%endif%	
								</tr>
								%ifvar doc equals('edit')%
								<tr>
									<td class="action" colspan="2">
										<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);">
									</td>
								</tr>
								%endif%
							%endinvoke%
						</form>
					</table>	
				</td>
			</tr>
		</table>
	</body>   
</html>	