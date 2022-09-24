<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js"></script>
  <script language="JavaScript">
    <!--add jscript here-->
	function populateForm(form , uName)
    {
    
		if (!confirm ("Ok to unlock '"+uName+"'?")) {
			return false;
		}

		var actionElement = form.getAttribute("action");
		
        form.userName.value = uName;
        actionElement = setQueryParamDelim(actionElement) + "userName=" + uName;
        
	    form.setAttribute("action", actionElement);
		  
        return true
    }
    
  </script>
  
  <body onLoad="setNavigation('settings-global-variables.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UnlockUserScrn');">
   
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> Security &gt; User Management &gt; Account Locking Settings &gt; Locked Users </td>
        </tr>
   
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<li class="listitem">
						<script>
							createForm("htmlform_nav_account_locking", "account-locking-settings.dsp", "POST", "BODY");
						</script>
						<script>getURL("account-locking-settings.dsp","javascript:document.htmlform_nav_account_locking.submit();","Return to Account Locking Settings");</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
			<td>    
				<table class="tableView" width="50%">
					<tr>
						<td class="heading" colspan="4">Locked Users</td>
					</tr>
					<tr>
						<TH scope="col" class="oddcol-l">User Name</TH>
						<TH scope="col" class="oddcol">Unlock</TH>
					</tr>
					%invoke wm.server.access:listLockedAccounts%
						%loop lockedAccounts%
							<tr>
								<script>writeTD("row-l");</script>
									 %value%
								</td>
								
								<script>writeTD("rowdata");</script>
									<a href="javascript:document.htmlform_al_delete.submit();" onClick="return populateForm(document.htmlform_al_delete,'%value encode(javascript)%');">
										<img src="icons/delete.png" alt="Unlock User %value%" border="no">
									</a>    
								</td>
							</tr>
							<script>swapRows();</script>
						%endloop%
					%endinvoke% 
				</table>
            </td>
        </tr>
    </table>

    <form name="htmlform_al_delete" action="account-locking-settings.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation" value="unlockAccount">
        <input type="hidden" name="userName">
    </form>
  </body>   
</head>
