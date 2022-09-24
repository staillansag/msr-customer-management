<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <title>
            Integration Server Packages
        </title>
        <link rel="stylesheet" type="text/css" href="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%  
        <script src="webMethods.js"></script>
        <script Language="JavaScript">
        function writeTag(val)
        {
		  if (is_csrf_guard_enabled && needToInsertToken) {
			var str="Locked Elements";

			createForm("htmlform_package_locks_details", "package-locks-details.dsp", "POST", "HEAD");
			setFormProperty("htmlform_package_locks_details", "node_nsName", "+val+");
			setFormProperty("htmlform_package_locks_details", "returnURL", "package-locks.dsp");
			setFormProperty("htmlform_package_locks_details", "returnName", "");
			
			var aStr="<a href=\"javascript:document.htmlform_package_locks_details.submit();\"></a>";
		  } else {
			var str="Locked Elements";
		    var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
			  str+="&webMethods-wM-AdminUI=true";
			}
			var aStr="<a href=\"package-locks-details.dsp?node_nsName="+val+"&returnURL=package-locks.dsp&returnName=";
		    w(aStr);
		    w(encodeURI(str));
		    w("\">");
		  }
        }
  </script>
    </head>

     %ifvar mode equals('edit')%
         <body onLoad="setNavigation('package-locks.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_UnlockElemensScrn');">
     %else%
         <body onLoad="setNavigation('package-locks.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_VwLockedScrn');">
     %endif%

        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan=2>
                    Packages
                    &gt; Management &gt;
                    %ifvar mode equals('edit')%
                        Unlock Elements
                    %else%
                        Locked Elements
                    %endif%
                </td>
            </tr>
            %ifvar action equals('sync')%
                %invoke wm.server.ns.adminui:syncToNamespace%
                <tr><td colspan="2">&nbsp;</td></tr>
                  <TR><TD class="message" colspan=2>%value message encode(html)%</TD></TR>
                  %endinvoke%
            %endif%

            %ifvar action equals('unlock')%
                %invoke wm.server.ns.adminui:unLockMultipleNodes%
      <tr><td colspan="2">&nbsp;</td></tr>
                        <tr>
                            <td class="message" colspan=2>
								%value message encode(html)%
                            </td>
                        </tr>
                %endinvoke%
            %endif action%

            <tr>
                <td colspan=2>
                    <ul class="listitems">
                        %ifvar mode equals('edit')%
							<script>
							createForm("htmlform_package_locks", "package-locks.dsp", "POST", "BODY");
							%ifvar username%
							setFormProperty("htmlform_package_locks", "username", "%value username encode(url)%");
							%endif%
							</script>
							<li>
							<script>getURL("package-locks.dsp%ifvar username%?username=%value username encode(url)%%endif%", "javascript:document.htmlform_package_locks.submit();", "Return to Locked Elements");</script>
							</li>
                        %else%
							<script>
							createForm("htmlform_package_list", "package-list.dsp", "POST", "BODY");
							createForm("htmlform_package_locks_edit_mode", "package-locks.dsp", "POST", "BODY");
							setFormProperty("htmlform_package_locks_edit_mode", "mode", "edit");
							%ifvar username%
							setFormProperty("htmlform_package_locks_edit_mode", "username", "%value username encode(url)%");
							%endif%
							createForm("htmlform_package_locks_sync", "package-locks.dsp", "POST", "BODY");
							setFormProperty("htmlform_package_locks_sync", "action", "sync");
							</script>
                            <li>
							<script>getURL("package-list.dsp", "javascript:document.htmlform_package_list.submit();", "Return to Package Management");</script>
							</li>
							<li>
							<script>getURL("package-locks.dsp?mode=edit%ifvar username%&username=%value username encode(url)%%endif%", "javascript:document.htmlform_package_locks_edit_mode.submit();", "Unlock Elements");</script>
							</li>
                            <li>
							<script>getURL("package-locks.dsp?action=sync", "javascript:document.htmlform_package_locks_sync.submit();", "Sync to Name Space");</script>
							</li>
                        %endif%
                    </ul>
                </td>
            </tr>
            <tr>
                <td width=100%>
                    %invoke wm.server.ns.adminui:getLockedNodesForUser%
                        <table class="tableView" width=100%>
                            <tr>
                                <td class="heading" colspan=3>Locked by System</td>
                            </tr>
                            <tr>
								<TH scope="col" CLASS="oddcol-l">Locked Element</TH>
								<TH scope="col" CLASS="oddcol-l">Host</TH>
								<TH scope="col" CLASS="oddcol-l">Date Locked</TH>
                            </tr>
                            <script>resetRows(); var rowcount=0;</script>

                            %loop -struct SYSTEM_LOCKS%
                            <tr>
                                <script>writeTD("rowdata-l");</script>
                                    %ifvar ../mode equals('edit')%
										%value $key encode(html)%
                                    %else%
										<script>writeTag("%value $key encode(javascript)%");</script>%value $key encode(html)%</a>
                                    %endif%
                                </td>
                                <script>writeTD("rowdata-l");</script>
									<span style="font-weight: normal;">%value HOST encode(html)%</span>
                                </td>
                                <script>writeTD("rowdata-l");</script>
                                    <span style="font-weight: normal;">%value -localize LOCK_TIME%</span>
                                </td>

                            </tr>
                            <script>swapRows(); rowcount++; </script>
                            %endloop%

                            <script>
                                if(rowcount == 0)
                                {
                                    document.write("<tr><td class=evenrow-l colspan=3>No Elements locked by System</td></tr>");
                                }
                            </script>

                        </table>

                    %endinvoke%
                    <br>
                    %invoke wm.server.ns.adminui:getLockedNodesForUser%
                        <table class="tableView" width=100%>
                            <tr>
								<td class="heading" colspan="%ifvar ../mode equals('edit')%4%else%3%endif%">Locked by Current User (%value username encode(html)%)</td>
                            </tr>
                            <tr>
                                %ifvar ../mode equals('edit')%
									<TH class="oddcol">Unlock</TH>
                                %endif%
								<TH scope="col" CLASS="oddcol-l">Locked Element</TH>
								<TH scope="col" CLASS="oddcol-l">Host</TH>
								<TH scope="col" CLASS="oddcol-l">Date Locked</TH>
                            </tr>
                            <script>resetRows(); var rowcount=0;</script>

                            %ifvar ../mode equals('edit')%
                                <form method="POST" name=unlockNodes action="package-locks.dsp">
                                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                                <input type="hidden" name="action" value="unlock">
                            %endif%

                            %loop -struct USER_LOCKS%
                            <tr>
                                %ifvar ../mode equals('edit')%
                                    <script>writeTD("row");</script>
										<input type="checkbox" name="unlock" id="%value $key encode(html)%" value="%value $key encode(htmlattr)%">
                                    </td>
                                %endif%
                                <script>writeTD("rowdata-l");</script>
                                    %ifvar ../mode equals('edit')%
										<label for="%value $key encode(html)%">%value $key encode(html)%</label>
                                    %else%
										<script>writeTag("%value $key encode(javascript)%");</script>%value $key encode(html)%</a>
                                    %endif%
                                </td>
                                <script>writeTD("rowdata-l");</script>
									%value HOST encode(html)%
                                </td>

                                <script>writeTD("rowdata-l");</script>
                                    %value -localize LOCK_TIME%
                                </td>
                            </tr>
                            <script>swapRows(); rowcount++; </script>
                            %endloop%

                            <script>
                                if(rowcount == 0)
									document.write("<tr><td class='evenrow-l' colspan='%ifvar ../mode equals('edit')%4%else%3%endif%'>No Elements locked by %value username encode(html_javascript)%</td></tr>");
                            </script>

                        </table>
                        <br>

                        <table class="tableView" width=100%>
                            <tr>
                                <td class="heading" colspan="%ifvar ../mode equals('edit')%5%else%4%endif%">Locked by Other Users</td>
                            </tr>
                            <tr>
                                %ifvar ../mode equals('edit')%
									<TH class="oddcol">Unlock</TH>
                                %endif%
								<TH scope="col" CLASS="oddcol-l">Locked Element</TH>
								<TH scope="col" CLASS="oddcol">User</TH>
								<TH scope="col" CLASS="oddcol-l">Host</TH>
								<TH scope="col" CLASS="oddcol-l">Date Locked</TH>
                            </tr>
                            <script>resetRows(); var rowcount=0;</script>

                            %ifvar ../mode equals('edit')%
                                <form method="POST" name=unlockNodes action="package-locks.dsp">
                                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                                <input type="hidden" name="action" value="unlock">
                            %endif%

                            %loop -struct OTHER_LOCKS%
                            <tr>
                                %ifvar ../mode equals('edit')%
                                    <script>writeTD("row");</script>
										<input type="checkbox" name="unlock" id="%value $key encode(html)%" value="%value $key encode(htmlattr)%">
                                    </td>
                                %endif%
                                <script>writeTD("rowdata-l");</script>
                                    %ifvar ../mode equals('edit')%
										<label for="%value $key encode(html)%">%value $key encode(html)%</label>
                                    %else%
										<script>writeTag("%value $key encode(javascript)%");</script>%value $key encode(html)%</a>
                                    %endif%
                                </td>
                                <script>writeTD("rowdata");</script>
									%value OWNER encode(html)%
									%loop DEPENDENT_LOCKS%%value encode(html)%%loopsep '<br>'%%endloop%


                                </td>
                                <script>writeTD("rowdata-l");</script>
									%value HOST encode(html)%
                                </td>
                                <script>writeTD("rowdata-l");</script>
                                    %value -localize LOCK_TIME%
                                </td>

                            </tr>
                            <script>swapRows(); rowcount++; </script>
                            %endloop%

                            <script>
                                if(rowcount == 0)
                                    document.write("<tr><td class='evenrow-l' colspan='%ifvar ../mode equals('edit')%5%else%4%endif%'>No Elements locked by other users</td></tr>");
                            </script>

                            %ifvar ../mode equals('edit')%
                                <tr>
                                    <td class=action colspan=5>
                                        <input class="button2" type=submit name=submit value="Unlock Selected Elements">
                                    </td>
                                </tr>
                                </form>
                            %endif%

                        </table>


                    %endinvoke%
                </td>
            </tr>
        </table>
    </body>
</html>
