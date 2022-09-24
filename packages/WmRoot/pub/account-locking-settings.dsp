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
		<script language="JavaScript">
			
			function validate(htmlForm) {
				
				if(htmlForm.isEnabledChk.checked) {
					htmlForm.isEnabled.value='true';
				} else {
					htmlForm.isEnabled.value='false';
				}
				
				if(!verifyRequiredNonNegNumber('htmlform_ALSettings', 'maximumLoginAttempts') || Number(htmlForm.maximumLoginAttempts) < 0) {
					alert("Specify a valid non-zero positive integer value for 'Maximum Login Attempts'.")
					return false;
				}
				
				if(!verifyRequiredNonNegNumber('htmlform_ALSettings', 'timeInterval') || Number(htmlForm.timeInterval) < 0) {
					alert("Specify a valid non-zero positive integer value for 'Time Interval'.")
					return false;
				}
				
				if(!verifyRequiredNonNegNumber('htmlform_ALSettings', 'blockDuration') || Number(htmlForm.blockDuration) < 0) {
					alert("Specify a valid non-zero positive integer value for 'Lockout Duration'.")
					return false;
				}
				return true;
			}

		</script>
	</head>
	%ifvar doc equals('edit')%
    <body onLoad="setNavigation('password-expiry-settings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditAccountLockScrn');">
	%else%
    <body onLoad="setNavigation('password-expiry-settings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AccountLockScrn');">
	%endif%
		<table width="100%">
			<tr>
				<td class="breadcrumb" colspan="2"> 
					Security &gt; User Management &gt;  Account Locking Settings %ifvar doc equals('edit')% &gt; Edit %endif%
				</td>
			</tr>
			%ifvar action equals('updateAccountLockingSettings')%
			  %invoke wm.server.access:updateAccountLockingSettings%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
				%endif%
				%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			  %endinvoke%
			%endif%
			%ifvar operation equals('unlockAccount')%
				%invoke wm.server.access:unlockAccount%
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
								createForm("htmlform_nav_al_settings", "account-locking-settings.dsp", "POST", "BODY");
							</script>
							<script>getURL("users.dsp","javascript:document.htmlform_nav_back_users.submit();","Return to User Management");</script>
						</li>
						%ifvar doc equals('edit')%
							<li class="listitem">
								<script>getURL("account-locking-settings.dsp","javascript:document.htmlform_nav_al_settings.submit();","Return to Account Locking Settings");</script>
							</li>
						%else%
							<script>setFormProperty("htmlform_nav_al_settings", "doc", "edit");</script>
							<li class="listitem">
								<script>getURL("account-locking-settings.dsp?doc=edit","javascript:document.htmlform_nav_al_settings.submit();","Edit Account Locking Settings");</script>
							</li>
						%endif%
						<li class="listitem">
							<script>
								createForm("htmlform_nav_list_locked_accounts", "account-locking-list.dsp", "POST", "BODY");
							</script>
							<script>getURL("account-locking-list.dsp","javascript:document.htmlform_nav_list_locked_accounts.submit();","Locked Users");</script>
						</li>
					</ul>
				</td>
			</tr>
			<tr>
				<td>
					<table width="50%" class="%ifvar doc equals('edit')%tableView%else%tableView%endif%">
						<form name="htmlform_ALSettings" id="htmlform_ALSettings" action="account-locking-settings.dsp" method="POST">
						    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
							<input type="hidden" name="isEnabled" id="isEnabled">
							<input type="hidden" name="action" id="action" value="updateAccountLockingSettings">
							%invoke wm.server.access:getAccountLockingSettings%
								<tr>
									<td class="heading" colspan=2>Account Locking Settings</TD>
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
									<td class="evenrow"><label for="maximumLoginAttempts">Maximum Login Attempts</label></td>
									<td class="%ifvar doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										%ifvar doc equals('edit')%
											<input type="text" name="maximumLoginAttempts" id="maximumLoginAttempts" size="8" value="%value maximumLoginAttempts encode(htmlattr)%">
											&nbsp;in&nbsp;
											<input type="text" name="timeInterval" id="timeInterval" size="8" value="%value timeInterval encode(htmlattr)%">
											&nbsp;
											<select name="timeIntervalUnit" id="timeIntervalUnit">
											  <option value="Minutes">Minutes</option>
											  <option value="Hours" %ifvar timeIntervalUnit equals('Hours')%selected%endif%>Hours</option>
											  <option value="Days" %ifvar timeIntervalUnit equals('Days')%selected%endif%>Days</option>
											</select>
										%else%
											%ifvar maximumLoginAttempts%
												%value maximumLoginAttempts%
												&nbsp;in
												&nbsp;%value timeInterval%
												&nbsp;
												%ifvar timeIntervalUnit equals('Minutes')%
													Minutes
												%else%
													%ifvar timeIntervalUnit equals('Days')%
														Days
													%else%
														%ifvar timeIntervalUnit equals('Hours')%
															Hours
														%endif%
													%endif%
												%endif%
											%else%
												None
											%endif%	
										%endif%										
									</td>
								</tr>
								<tr>
									<td class="evenrow"><label for="blockDuration">Lockout Duration</label></td>
									<td class="%ifvar doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										%ifvar doc equals('edit')%
											<input type="text" name="blockDuration" id="blockDuration" size="8" value="%value blockDuration encode(htmlattr)%">
											&nbsp;
											<select name="blockDurationUnit" id="blockDurationUnit">
											  <option value="Minutes">Minutes</option>
											  <option value="Hours" %ifvar blockDurationUnit equals('Hours')%selected%endif%>Hours</option>
											  <option value="Days" %ifvar blockDurationUnit equals('Days')%selected%endif%>Days</option>
											</select> 
										%else%
											%ifvar blockDuration%
												%value blockDuration%
												&nbsp;
												%ifvar blockDurationUnit equals('Minutes')%
													Minutes
												%else%
													%ifvar blockDurationUnit equals('Days')%
														Days
													%else%
														%ifvar blockDurationUnit equals('Hours')%
															Hours
														%endif%
													%endif%
												%endif%	
											%else%
												None
											%endif%
										%endif%										
									</td>
								</tr>
								<tr>
									<td class="evenrow"><label for="">Apply Account Locking Policy To</label></td>
									<td class="%ifvar doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									      %ifvar appliesToUsers equals('allUsers')%
											%ifvar doc equals('edit')%
												<input type="radio" id="appliesToUsers1" name="appliesToUsers" value="allUsers" checked><label for="appliesToUsers1">All Users</label></input><br>
												<input type="radio" id="appliesToUsers2" name="appliesToUsers" value="allUsersExceptPredefinedUsers"><label for="appliesToUsers2">All Users except Predefined Users</label></input>
											%else%
												All Users
											%end%	
										  %else%
											%ifvar doc equals('edit')%
												<input type="radio" id="appliesToUsers1" name="appliesToUsers" value="allUsers"><label for="appliesToUsers1">All Users</label></input><br>
												<input type="radio" id="appliesToUsers2" name="appliesToUsers" value="allUsersExceptPredefinedUsers" checked><label for="appliesToUsers2">All Users except Predefined Users</label></input>
											%else%
												All Users except Predefined Users
											%end%	
										  %endif%
									</td>
								</tr>
								
								%ifvar doc equals('edit')%
									<tr>
										<td class="action" colspan="2">
											<input type="submit" name="submit" value="Save Changes" onclick="return validate(this.form);">
										</td>
									</tr>
								%endif%
							%endif%
						</form>
					</table>	
				</td>
			</tr>
		</table>
	</body>   
</html>	