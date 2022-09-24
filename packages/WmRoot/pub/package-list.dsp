<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server Packages</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%  
    <script src="webMethods.js"></script>
    <script src="packagefilter.js"></script>

    <SCRIPT LANGUAGE="JavaScript">
	
	function enablePackage(package_name) {
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.write('<A class="imagelink" HREF="javascript:document.pkg_list_pkg_enable.submit();" ONCLICK="return confirmEnableForm(\''+package_name+'\', document.pkg_list_pkg_enable, \'action=enable;package='+package_name+'\');"><IMG border="0" SRC="images/blank.gif" alt="Package Disabled" height=13 width=13>No</A>');
		} else {
			%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				document.write('<A class="imagelink" HREF="package-list.dsp?action=enable&package='+package_name+'&webMethods-wM-AdminUI=true" ONCLICK="return confirmEnable(\''+package_name+'\');"><IMG border="0" SRC="images/blank.gif" alt="Package Disabled" height=13 width=13>No</A>');
			}
			else {
				document.write('<A class="imagelink" HREF="package-list.dsp?action=enable&package='+package_name+'" ONCLICK="return confirmEnable(\''+package_name+'\');"><IMG border="0" SRC="images/blank.gif" alt="Package Disabled" height=13 width=13>No</A>');
			}
		}
	}

	function disablePackage(package_name) {
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.write('<A class="imagelink" HREF="javascript:document.pkg_list_pkg_disable.submit();" ONCLICK="return confirmDisableForm(\''+package_name+'\', document.pkg_list_pkg_disable, \'action=disable;package='+package_name+'\');"><IMG SRC="images/green_check.png" alt="Package Enabled" border="0" height=13 width=13>Yes</A>');
		} else {
			%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				document.write('<A class="imagelink" HREF="package-list.dsp?action=disable&package='+package_name+'&webMethods-wM-AdminUI=true" ONCLICK="return confirmDisable(\''+package_name+'\');"><IMG SRC="images/green_check.png" alt="Package Enabled" border="0" height=13 width=13>Yes</A>');
			}
			else {
				document.write('<A class="imagelink" HREF="package-list.dsp?action=disable&package='+package_name+'" ONCLICK="return confirmDisable(\''+package_name+'\');"><IMG SRC="images/green_check.png" alt="Package Enabled" border="0" height=13 width=13>Yes</A>');
			}
		}
	}
      function confirmDeleteForm(pkg, safe,fm,pairs)
      {

        if(pkg == "WmRoot")
        {
            alert("'WmRoot' cannot be deleted");
            return false;
        }
         if(pkg == "WmAdmin")
        {
            alert("'WmAdmin' cannot be deleted");
            return false;
        }
        var s1 = "OK to Delete the '"+pkg+"' package?\n\n";
        var s2 = "Package will be sent to the salvage directory\n";
		populateForm(fm,pairs);
        if(safe == "true")
        {
          return confirm(s1+s2);
        }
        else
        {
          return confirm(s1);
        }
      }

      function confirmReloadForm(pkg,pkgType,fm,pairs)
      {
         if (pkg == "WmRoot")
         {
            alert("'WmRoot' cannot be reloaded");
            return false;
         }
         if (pkg == "WmAdmin")
          {
             alert("'WmAdmin' cannot be reloaded");
             return false;
          }
         var s1 = "OK to reload the `"+pkg+"' package?\n\n";
         var s2 = "Reloading a package may cause sessions currently using\n";

         var s3 = "services in that package to fail.\n";
         var doReload;
         doReload = confirm (s1+s2+s3);
         if(doReload)
         {
            var sNativeWarning = "Warning: This package contains native code\n";
            var sNativeWarning2 = "libraries.  You must restart the server\n";

            var sNativeWarning3 = "to reload Java services.\n";
            if(pkgType == "2")
            alert(sNativeWarning+sNativeWarning2+sNativeWarning3);
         }
		 populateForm(fm,pairs);
         return doReload;
      }

      function confirmDisableForm (pkg,fm,pairs)
      {
         if(pkg == "WmRoot")
         {
            alert("'WmRoot' cannot be disabled");
            return false;
         }
         if(pkg == "WmAdmin")
          {
             alert("'WmAdmin' cannot be disabled");
             return false;
          }
         var s1 = "OK to disable the `"+pkg+"' package?\n\n";
         var s2 = "Disabling a package causes all its services to be \n";
         var s3 = "unloaded and marked unavailable for use.\n";
		 populateForm(fm,pairs);
         return confirm (s1+s2+s3);
      }

      function confirmEnableForm (pkg,fm,pairs)
      {
         var s1 = "OK to enable the `"+pkg+"' package?\n\n";
         var s2 = "Enabling a package causes all its services to be \n";
         var s3 = "loaded and marked available for use.\n";
		 populateForm(fm,pairs);
         return confirm (s1+s2+s3);
      }
	  
	  function confirmDelete(pkg, safe)
      {
        if(pkg == "WmRoot")
        {
            alert("'WmRoot' cannot be deleted");
            return false;
        }
         if(pkg == "WmAdmin")
        {
            alert("'WmAdmin' cannot be deleted");
            return false;
        }
        var s1 = "OK to Delete the '"+pkg+"' package?\n\n";
        var s2 = "Package will be sent to the salvage directory\n";

        if(safe == "true")
        {
          return confirm(s1+s2);
        }
        else
        {
          return confirm(s1);
        }
      }

      function confirmReload(pkg,pkgType)
      {
         if (pkg == "WmRoot")
         {
            alert("'WmRoot' cannot be reloaded");
            return false;
         }
          if (pkg == "WmAdmin")
           {
              alert("'WmAdmin' cannot be reloaded");
              return false;
           }
         var s1 = "OK to reload the `"+pkg+"' package?\n\n";
         var s2 = "Reloading a package may cause sessions currently using\n";

         var s3 = "services in that package to fail.\n";
         var doReload;
         doReload = confirm (s1+s2+s3);
         if(doReload)
         {
            var sNativeWarning = "Warning: This package contains native code\n";
            var sNativeWarning2 = "libraries.  You must restart the server\n";

            var sNativeWarning3 = "to reload Java services.\n";
            if(pkgType == "2")
            alert(sNativeWarning+sNativeWarning2+sNativeWarning3);
         }
         return doReload;
      }

      function confirmDisable (pkg)
      {
         if(pkg == "WmRoot")
         {
            alert("'WmRoot' cannot be disabled");
            return false;
         }
         if(pkg == "WmAdmin")
          {
             alert("'WmAdmin' cannot be disabled");
             return false;
          }
         var s1 = "OK to disable the `"+pkg+"' package?\n\n";
         var s2 = "Disabling a package causes all its services to be \n";
         var s3 = "unloaded and marked unavailable for use.\n";
         return confirm (s1+s2+s3);
      }

      function confirmEnable (pkg)
      {
         var s1 = "OK to enable the `"+pkg+"' package?\n\n";
         var s2 = "Enabling a package causes all its services to be \n";
         var s3 = "loaded and marked available for use.\n";
         return confirm (s1+s2+s3);
      }

      function loadDocument()
      {
         setNavigation('package-list.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_MngmtScrn');
         if(window.history.replaceState && window.location.search.indexOf('action') != -1) {
            window.history.replaceState({},'Integration Server Packages',window.location.origin + window.location.pathname);
         }
      }
    </script>
  </head>

   <body onLoad="loadDocument();">
      <div class="position">
         <table width="100%">
            <tr>
               <td class="breadcrumb" colspan=2>Packages &gt; Management</TD>
            </TR>
    %ifvar action%
      %switch action%
        %case 'archive'%
          %invoke wm.server.replicator:packageRelease%
              %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
                  <TR><TD class="message" colspan=2>%value  message encode(html)%</TD></TR>
              %endif%
          %onerror%
              %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
                  <TR><TD class="message" colspan=2>%value  errorMessage encode(html)%</TD></TR>
              %endif%
          %endinvoke%
        %case 'enable'%
          %invoke wm.server.packages:packageEnable%
            %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
              <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %endif%
          %endinvoke%
        %case 'disable'%
          %invoke wm.server.packages:packageDisable%
            %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
              <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %endif%
          %endinvoke%
        %case 'reload'%
          %invoke wm.server.packages.adminui:packageReload%
            %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
              <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %endif%
          %endinvoke%
        %case 'delete'%
          %invoke wm.server.packages.adminui:packageDelete%
            %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
              <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %endif%
          %endinvoke%
        %case 'backup'%
          %invoke wm.server.packages:backup%
            %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
              <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %endif%
          %endinvoke%
      %endswitch%
    %endif action%

     %invoke wm.server.packages:packageList%
            <tr>
                <td colspan="2">
                    <ul class="listitems">
						<script>
						createForm("htmlform_package_inbound", "package-inbound.dsp", "POST", "BODY");
						setFormProperty("htmlform_package_inbound", "mode", "inbound");
						createForm("htmlform_package_manage", "package-manage.dsp", "POST", "BODY");
						setFormProperty("htmlform_package_manage", "mode", "inactive");
						createForm("htmlform_package_recover", "package-recover.dsp", "POST", "BODY");
						createForm("htmlform_package_locks", "package-locks.dsp", "POST", "BODY");
						createForm("htmlform_service_list", "service-list.dsp", "POST", "BODY");
						createForm("htmlform_package_list", "package-list.dsp", "POST", "BODY");
						</script>
                        <li>
						<script>getURL("package-inbound.dsp?mode=inbound", "javascript:document.htmlform_package_inbound.submit();", "Install Inbound Releases");</script>
						</li>
                        <li>
						<script>getURL("package-manage.dsp?mode=inactive", "javascript:document.htmlform_package_manage.submit();", "Activate Inactive Packages");</script>
						</li>
                        <li>
						<script>getURL("package-recover.dsp", "javascript:document.htmlform_package_recover.submit();", "Recover Packages");</script>
						</li>
                        <li>
						<script>getURL("service-list.dsp", "javascript:document.htmlform_service_list.submit();", "Browse Folders");</script>
						</li>
                        <li>
						<script>getURL("package-locks.dsp", "javascript:document.htmlform_package_locks.submit();", "View Locked Elements");</script>
						</li>
                        <li id="showfew" name="showfew">
						<a href="javascript:showFilterPanel(true)">Filter Packages</a>
						</li>
                        <li style="display:none" id="showall" name="showall">
						<script>getURL("package-list.dsp", "javascript:document.htmlform_package_list.submit();", "Show All Packages");</script>
						</li>
                        <div id="filterContainer" name="filterContainer" style="display:none;padding-top=2mm;">
                        <br>
                <table>
                <tr valign="top">
                <td>
                     <label for="pfilter">Filter criteria</label><br>
                     <input type="text" id="pfilter" name="pfilter" onKeyPress="filterPackages(event)"/>
                </td>

                <td>

                  <table><tr><td>
                    <input type="radio" id="enablep" name="enablep" onclick="setFlag('enabled')"/>
                    <span id="enabletitle" name="enabletitle"><label for="enablep">Include Enabled Packages</label></span>

                </td></tr><tr><td>
                    <input type="radio" id="disablep" name="enablep" onclick="setFlag('disabled')"/>
                    <span id="disabletitle" name="disabletitle"><label for="disablep">Include Disabled Packages</label></span>

                </td></tr><tr><td>
                    <input type="radio" id="both" name="enablep" checked onclick="setFlag('both')"/>
                    <span id="enabletitle" name="enabletitle"><label for="both">Include Both</label></span>

                  </td></tr></table>

                </td> <td>
                  <input type="checkbox" id="nested" name="nested" />
                              <span id="nesttitle" name="nesttitle"><label for="nested">Filter on result</label></span>
                </td> <td>
                  <input type="checkbox" id="exclude" name="exclude" />
                              <span id="excludetitle" name="excludetitle"><label for="exclude">Exclude from result</label></span>
                </td> <td>
                              <input type="Button" id="submitbtn" name="submitbtn" value="Submit" onclick="filterPackagesInternal()"/>
                        </td> </tr></table>
                        </DIV>
                    </UL>
                </TD>
            </TR>
            <TR>
          <TD id="result" colspan="2" align="right"></TD>
        </TR>
        <TR>
        <td>
        <table class="tableView" width="100%" id="head" name="head">
          <tr>
            <td class="heading" colspan="8">Package List</td>
          </tr>
          <TR class="subheading2">
            <TH scope="col">Package Name</TH>
            <TH scope="col">Home</TH>
            <TH scope="col">Reload</TH>
            <TH scope="col">Enabled</TH>
            <TH scope="col">Loaded</TH>
            <TH scope="col">Archive</TH>
            <TH scope="col">Safe Delete</TH>
            <TH scope="col">Delete</TH>
          </TR>
            <script>resetRows();</script>
			<script>
				createForm("pkg_list_pkg_info", "package-info.dsp", "POST", "BODY");
			    setFormProperty("pkg_list_pkg_info", "package", "");
				
				createForm("pkg_list_pkg_reload", "package-list.dsp", "POST", "BODY");
				setFormProperty("pkg_list_pkg_reload", "action", "");
				setFormProperty("pkg_list_pkg_reload", "package", "");
				
				createForm("pkg_list_pkg_disable", "package-list.dsp", "POST", "BODY");
				setFormProperty("pkg_list_pkg_disable", "action", "");
				setFormProperty("pkg_list_pkg_disable", "package", "");
				
				createForm("pkg_list_pkg_enable", "package-list.dsp", "POST", "BODY");
				setFormProperty("pkg_list_pkg_enable", "action", "");
				setFormProperty("pkg_list_pkg_enable", "package", "");
				
				createForm("pkg_list_pkg_archive", "package-archive.dsp", "POST", "BODY");
				setFormProperty("pkg_list_pkg_archive", "package", "");
				setFormProperty("pkg_list_pkg_archive", "archive", "");
				
				createForm("pkg_list_pkg_safe_delete", "package-list.dsp", "POST", "BODY");
				setFormProperty("pkg_list_pkg_safe_delete", "action", "");
				setFormProperty("pkg_list_pkg_safe_delete", "package", "");
				setFormProperty("pkg_list_pkg_safe_delete", "safeDelete", "");
				  
				createForm("pkg_list_pkg_delete", "package-list.dsp", "POST", "BODY");
				setFormProperty("pkg_list_pkg_delete", "action", "");
				setFormProperty("pkg_list_pkg_delete", "package", "");
				
			</script>
            %loop packages%
            <TR >
               <td class="field">
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A HREF="javascript:document.pkg_list_pkg_info.submit();" onClick="return populateForm(document.pkg_list_pkg_info, \'package=%value name%\');">%value name encode(html)%</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A HREF="package-info.dsp?package=%value name encode(url)%&webMethods-wM-AdminUI=true">%value name encode(html)%</A>');
								}
								else {
									document.write('<A HREF="package-info.dsp?package=%value name encode(url)%">%value name encode(html)%</A>');
								}
							}
							document.write('<input type="hidden" name="packageNameValue" value="%value name encode(html)%"/>');
						</script>
               			
               </TD>
               <script>writeTD('rowdata');</script>
                       %ifvar enabled equals('true')%
										<A class="imagelink" HREF="../%value name encode(htmlattr)%/" TARGET="newwindow">
                                        <IMG SRC="icons/icon_home.png" border="0"
                                        alt="Package %value name%"></A>
                                    %else%
										<A class="imagelink" HREF="../%value name encode(htmlattr)%/" onclick="alert('Home Page is unavailable when package is disabled.'); return false;">
                                        <IMG SRC="icons/icon_home.png" border="0"
                                        alt="Package %value name%"></A>
                                    %endif%
                             </TD>
               <script>writeTD('rowdata');</script>

					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<A class="imagelink" HREF="javascript:document.pkg_list_pkg_reload.submit();"  ONCLICK="return confirmReloadForm(\'%value name encode(javascript)%\',\'%value pkgType encode(javascript)%\', document.pkg_list_pkg_reload, \'action=reload;package=%value name%\');">                  <IMG SRC="icons/icon_reload.png" border="0" alt="Package %value name%"></A>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<A class="imagelink" HREF="package-list.dsp?action=reload&package=%value name encode(url)%&webMethods-wM-AdminUI=true"  ONCLICK="return confirmReload(\'%value name encode(javascript)%\',\'%value pkgType encode(javascript)%\');"><IMG SRC="icons/icon_reload.png" border="0" alt="Package %value name%"></A>');
							}
							else {
								document.write('<A class="imagelink" HREF="package-list.dsp?action=reload&package=%value name encode(url)%"  ONCLICK="return confirmReload(\'%value name encode(javascript)%\',\'%value pkgType encode(javascript)%\');"><IMG SRC="icons/icon_reload.png" border="0" alt="Package %value name%"></A>');
							}
						}
					</script>
                  </TD>
               <script>writeTD('rowdata');</script>
                  %ifvar enabled equals('true')%

				  <script>
						disablePackage("%value encode(javascript) name%");

					</script>
                  
                  %else%

				  <script>
						enablePackage("%value encode(javascript) name%");
						
					</script>
                  
                  %endif%</TD>
               <script>writeTD('rowdata');</script>
                  %ifvar loaderr equals('0')%
                    %ifvar enabled equals('false')%
                      <IMG SRC="images/blank.gif" height=13 width=13
                      alt="Disabled"> No
                    %else%
                        %ifvar loadwarning equals('0')%
                              <IMG SRC="images/green_check.png" height=13 width=13 alt="Loaded Package %value name%"> Yes
                          %else%
                              <IMG SRC="images/yellow_check.png" height=13 width=13 alt="Warnings during load."> <font color="red"> Warnings </font>
                          %endif%
                    %endif%
                  %else%
                    %ifvar loadok equals('0')%
                      <IMG SRC="images/blank.gif" height=13 width=13
                      alt="Load Errors"> No
                    %else%
                      <IMG SRC="images/yellow_check.png" height=13 width=13 alt="Error during load."> <font color="red">Partial</font>
                    %endif%
                  %endif%
               </TD>
         <script>writeTD('rowdata');</script>

					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<A class="imagelink"  HREF="javascript:document.pkg_list_pkg_archive.submit();" onClick="return populateForm(document.pkg_list_pkg_archive, \'package=%value name%;archive=true\')"><IMG src="images/archive_package.png" alt="Package %value name%" border=0 width=43 height=16></A>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<A class="imagelink"  HREF="package-archive.dsp?package=%value name encode(url)%&archive=true&webMethods-wM-AdminUI=true"><IMG src="images/archive_package.png" alt="Package %value name%" border=0 width=43 height=16></A>');
							}
							else {
								document.write('<A class="imagelink"  HREF="package-archive.dsp?package=%value name encode(url)%&archive=true"><IMG src="images/archive_package.png" alt="Package %value name%" border=0 width=43 height=16></A>');
							}
						}
					</script>
                  </TD>
         </td>
               <script>writeTD('rowdata');</script>

					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<A class="imagelink"  HREF="javascript:document.pkg_list_pkg_safe_delete.submit();" onclick="return confirmDeleteForm(\'%value name encode(javascript)%\', \'true\', document.pkg_list_pkg_safe_delete, \'action=delete;package=%value name%;safeDelete=checked\');"><IMG src="images/safe_delete.png" alt="Package %value name%" border=0 width=43 height=16></A>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<A class="imagelink"  HREF="package-list.dsp?action=delete&package=%value name encode(url)%&safeDelete=checked&webMethods-wM-AdminUI=true" onclick="return confirmDelete(\'%value name encode(javascript)%\', \'true\');"><IMG src="images/safe_delete.png" alt="Package %value name%" border=0 width=43 height=16></A>');
							}
							else {
								document.write('<A class="imagelink"  HREF="package-list.dsp?action=delete&package=%value name encode(url)%&safeDelete=checked" onclick="return confirmDelete(\'%value name encode(javascript)%\', \'true\');"><IMG src="images/safe_delete.png" alt="Package %value name%" border=0 width=43 height=16></A>');
							}
						}
					</script>
                  </TD>
               <script>writeTD('rowdata');swapRows();</script>

					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<A class="imagelink" HREF="javascript:document.pkg_list_pkg_delete.submit();" onclick="return confirmDeleteForm(\'%value name encode(javascript)%\', \'false\', document.pkg_list_pkg_delete, \'action=delete;package=%value name%\');"><IMG SRC="icons/delete.png" alt="Package %value name%" border="0"></A>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<A class="imagelink" HREF="package-list.dsp?action=delete&package=%value name encode(url)%&webMethods-wM-AdminUI=true" onclick="return confirmDelete(\'%value name encode(javascript)%\', \'false\');"><IMG SRC="icons/delete.png" alt="Package %value name%" border="0"></A>');
							}
							else {
								document.write('<A class="imagelink" HREF="package-list.dsp?action=delete&package=%value name encode(url)%" onclick="return confirmDelete(\'%value name encode(javascript)%\', \'false\');"><IMG SRC="icons/delete.png" alt="Package %value name%" border="0"></A>');
							}
						}
					</script>
                  </TD>
            </TR> %endloop%
            </TABLE></TD></TR>
         </TABLE> %endinvoke%
         
         %ifvar pfilter -notempty%
         <script>
             showFilterPanel();

             var pfilter = document.getElementById("pfilter");
         	pfilter.value="%value pfilter encode(javascript)%"

             %ifvar regex -notempty%
             var regex = document.getElementById("regex");
             pfilter.checked=true;
             %endif%

             %ifvar exclude -notempty%
        var excludeFromResult = document.getElementById("exclude");
        excludeFromResult.checked=true;
             %endif%

        filterPackagesInternal();

         </script>
          %endif%

      </div>
   </body>
</html>
