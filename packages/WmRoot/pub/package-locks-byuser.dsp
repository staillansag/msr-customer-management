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
			setFormProperty("htmlform_package_locks_details", "node_nsName", val);
			setFormProperty("htmlform_package_locks_details", "returnURL", "package-locks.dsp");
			setFormProperty("htmlform_package_locks_details", "returnName", "encodeURI(str)");
			
			var aStr="<a href="javascript:document.htmlform_package_locks_details.submit();">;
		} else {
			var str="Locked Elements";
			var aStr="<a href=\"package-locks-details.dsp?node_nsName="+val+"&returnURL=package-locks.dsp&returnName=";
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				aStr="<a href=\"package-locks-details.dsp?node_nsName="+val+"&returnURL=package-locks.dsp&returnName=&webMethods-wM-AdminUI=true";
			}
		  w(aStr);
		  w(encodeURI(str));
		  w("\">");
		}
      
    }
  </script>
    </head>
    <body onLoad="setNavigation('package-list.dsp', 'doc/OnlineHelp/WmRoot.htm#CS_Packages_Mgmt.htm');">
        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan=2>
                    Packages
                    &gt; Management
                    &gt; Locked Elements
                    &gt; By User</td>
            </tr>

            %ifvar action equals('unlock')%
                %invoke wm.server.ns.adminui:unLockMultipleNodes%
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
							createForm("htmlform_package_locks_byuser", "package-locks-byuser.dsp", "POST", "BODY");
							</script>
                            <li>
							<script>getURL("package-locks-byuser.dsp", "javascript:document.htmlform_package_locks_byuser.submit();", "Return to Locked Elements By User");</script>
							</li>
                        %else%
							<script>
							createForm("htmlform_package_locks", "package-locks.dsp", "POST", "BODY");
							createForm("htmlform_package_locks_byuser_edit_mode", "package-locks-byuser.dsp", "POST", "BODY");
							setFormProperty("htmlform_package_locks_byuser_edit_mode", "mode", "edit");
							</script>
                            <li>
							<script>getURL("package-locks.dsp", "javascript:document.htmlform_package_locks.submit();", "Return to Locked Elements");</script>
							</li>
                            <li>
							<script>getURL("package-locks-byuser.dsp?mode=edit", "javascript:document.htmlform_package_locks_byuser_edit_mode.submit();", "Unlock Elements");</script>
							</li>
                        %endif%
                    </ul>
                </td>
            </tr>
            <tr>
                <td width=100%>
                    %invoke wm.server.ns.adminui:getLockedNodesForAllUsers%

                        %ifvar ../mode equals('edit')%
                            <form method="POST" name=unlockNodes action="package-locks-byuser.dsp">
                            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                            <input type="hidden" name="action" value="unlock">
                        %endif%

                        %loop byUser%
                        <table width=100%>
                            <tr>
								<td class="heading" colspan=4>Locked by %value USER_NAME encode(html)%</td>
                            </tr>
                            <tr>
                                %ifvar ../../mode equals('edit')%
                                    <th scope="col" class="oddcol">Unlock</th>
                                %endif%
								<th scope="col" class="oddcol-l">Locked Element</th>
								<th scope="col" class="oddcol-l">Host</th>
                            </tr>
                            <script>resetRows(); var rowcount=0;</script>

                            %loop -struct USER_LOCKS%
                            <tr>
                                %ifvar ../../mode equals('edit')%
                                    <script>writeTD("rowdata");</script>
										<input type="checkbox" name="unlock" value="%value $key encode(htmlattr)%">
                                    </td>
                                %endif%
                                <script>writeTD("rowdata-l");</script>
                                    %ifvar ../../mode equals('edit')%
										%value $key encode(html)%
                                    %else%
										<script>writeTag("%value $key encode(javascript)%");</script>%value $key encode(html)%</a>
                                    %endif%
                                </td>
                                <script>writeTD("row-l");</script>
									%value HOST encode(html)%
                                </td>
                            </tr>
                            <script>swapRows(); rowcount++; </script>
                            %endloop%

                            <script>
                                if(rowcount == 0)
									document.write("<tr><td class=evenrow-l colspan=4>No Elements locked by %value USER_NAME encode(html_javascript)%</td></tr>");
                            </script>

                        </table>
                        <br>
                        %endloop%

                        <table width=100%>
                        %ifvar ../mode equals('edit')%
                            <tr>
                                <td class=action colspan=4>
                                    <input type=submit name=submit value="Unlock Selected Elements">
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
