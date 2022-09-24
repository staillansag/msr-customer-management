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
			var str="System Locks";
			
			createForm("htmlform_package_locks_details", "package-locks-details.dsp", "POST", "HEAD");
			setFormProperty("htmlform_package_locks_details", "node_nsName", val);
			setFormProperty("htmlform_package_locks_details", "returnURL", "package-locks-system.dsp");
			setFormProperty("htmlform_package_locks_details", "returnName", "encodeURI(str)");
			
			var aStr="<a href="javascript:document.htmlform_package_locks_details.submit();">;
		} else {
			var str="System Locks";
			var aStr="<a href=\"package-locks-details.dsp?node_nsName="+val+"&returnURL=package-locks-system.dsp&returnName=";
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				aStr="<a href=\"package-locks-details.dsp?node_nsName="+val+"&returnURL=package-locks-system.dsp&returnName=&webMethods-wM-AdminUI=true";
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
                    &gt; System Locks</td>
            </tr>

            <tr>
                <td colspan=2>
                    <ul class="listitems">
							<script>
							createForm("htmlform_package_locks", "package-locks.dsp", "POST", "BODY");
							</script>
                            <li>
							<script>getURL("package-locks.dsp", "javascript:document.htmlform_package_locks.submit();", "Return to Locked Elements");</script>
							</li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td width=100%>
                    %invoke wm.server.ns.adminui:getLockedNodesForUser%
                        <table width=100%>
                            <tr>
                                <td class="heading" colspan=4>Locked by System</td>
                            </tr>
                            <tr>
								<th scope="col" class="oddcol-l">Locked Element</th>
								<th scope="col" class="oddcol-l">Host</th>
                            </tr>
                            <script>resetRows(); var rowcount=0;</script>

                            %loop -struct SYSTEM_LOCKS%
                            <tr>
                                <script>writeTD("rowdata-l");</script>
									<script>writeTag("%value $key encode(javascript)%");</script>%value $key encode(html)%</a>
                                </td>
                                <script>writeTD("row-l");</script>
									%value HOST encode(html)%
                                </td>
                            </tr>
                            <script>swapRows(); rowcount++; </script>
                            %endloop%

                            <script>
                                if(rowcount == 0)
                                {
                                    document.write("<tr><td class=evenrow-l colspan=4>No Elements locked by System</td></tr>");
                                }
                            </script>

                        </table>

                    %endinvoke%
                </td>
            </tr>
        </table>
    </body>
</html>
