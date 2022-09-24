<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Service List</TITLE>

    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
    var currentInterface = "";
    function confirmDelete (svc)
    {
      var msg = "OK to delete '"+svc+"' service?";
      return confirm (msg);
    }
    function aclAssign ()
    {
    }
  var effectiveACL = 0;
  var effectiveACLBrowse = 0;
  var effectiveACLRead = 0;
  var effectiveACLWrite = 0;

    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('package-list.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_BrowseFldrScrn');">
    <TABLE WIDTH=100%>
      <TR>
        <TD class="breadcrumb" colspan=2>
          Packages &gt;
          Management &gt;
          Folders &gt;
          %ifvar interface% <script>currentInterface="%value interface encode(html_javascript)%";document.write(currentInterface.replace(/\./g, " &gt; "  ));</script> %else% Top Level%endif%
        </TD>
      </TR>
        %ifvar action%
          %switch action%
            %case 'aclassign'%
              %invoke wm.server.access:aclAssign%
                %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
                  <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                %endif%
              %endinvoke%
            %endswitch%
          %endif%

          %invoke wm.server.access.adminui:aclList%
          %invoke wm.server.xidl.adminui:getInterfacesPlus%
		  
		  <script>
		  createForm("htmlform_package_list", "package-list.dsp", "POST", "BODY");		  
		  </script>

          %ifvar parent%
            <TR>
              <TD colspan=2>
                <ul class="listitems">
                  <li>
				  <script>getURL("package-list.dsp", "javascript:document.htmlform_package_list.submit();", "Return to Package Management");</script>
				  </li>
				  <script>
				  createForm("htmlform_service_list_up_one_level", "service-list.dsp", "POST", "BODY");
				  setFormProperty("htmlform_service_list_up_one_level", "interface", "%value /parent%");
				  </script>
                  <li>
				  <script>getURL("service-list.dsp?interface=%value /parent encode(url)%", "javascript:document.htmlform_service_list_up_one_level.submit();", "Up one level");</script>
				  
				  (<script>document.write("%value /parent encode(html_javascript)%".replace(/.*\./g, ""  ));</script>)</LI>
                </UL>
              </TD>
            </TR>
          %else%
            %ifvar interface%
            <TR>
              <TD colspan=2>
                <ul class="listitems">
                  <li>
				  <script>getURL("package-list.dsp", "javascript:document.htmlform_package_list.submit();", "Return to Package Management");</script>
				  </li>
				  <script>
				  createForm("htmlform_service_list", "service-list.dsp", "POST", "BODY");
				  </script>
                  <li>
				  <script>getURL("service-list.dsp", "javascript:document.htmlform_service_list.submit();", "Up one level");</script>
				  </LI>
                </UL>
              </TD>
            </TR>
            %else%
            <TR>
              <TD colspan=2>
                <ul class="listitems">
                  <li>
				  <script>getURL("package-list.dsp", "javascript:document.htmlform_package_list.submit();", "Return to Package Management");</script>
				  </li>
                </UL>
              </TD>
            </TR>
            %endif%
          %endif%
      <TR>
        <TD>
          <TABLE class="tableView">
          <TR>
            <TD class="heading" colspan=7>Folder List</TD>
          </TR>
            <TR>
              <TH scope="col" class="oddcol-l">Folders</TH>
              <TH scope="col" class="oddcol-l">List ACL</TH>
              <TH scope="col" class="oddcol-l">Read ACL</TH>
              <TH scope="col" class="oddcol-l">Write ACL</TH>
              <TH scope="col" class="oddcol-l">Execute ACL</TH>
              <TH scope="col" class="oddcol">Folders</TH>
              <TH scope="col" class="oddcol">Services</TH>
            </TR>

			<script>
			
			createForm("htmlform_service_list_interface", "service-list.dsp", "POST", "BODY");
			setFormProperty("htmlform_service_list_interface", "interface", "");
			
			createForm("htmlform_acl_assign_parent_interface", "acl-assign.dsp", "POST", "BODY");
			setFormProperty("htmlform_acl_assign_parent_interface", "parent", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "interface", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "acl", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "browseaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "readaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "writeaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "effectiveAcl", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "effectiveAclBrowse", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "effectiveAclRead", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "effectiveAclWrite", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "parentexecuteaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "parentbrowseaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "parentreadaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface", "parentwriteaclgroup", "");
			
			createForm("htmlform_acl_assign_parent_interface_1", "acl-assign.dsp", "POST", "BODY");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "parent", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "interface", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "acl", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "browseaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "readaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "writeaclgroup", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "effectiveAcl", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "effectiveAclBrowse", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "effectiveAclRead", "");
			setFormProperty("htmlform_acl_assign_parent_interface_1", "effectiveAclWrite", "");

			</script>
			
          %ifvar interfaces%
            <script>resetRows();</script>
            %loop interfaces%
            <TR>
				
              <script>writeTD("rowdata-l");</script><nobr>&nbsp;&nbsp;
			  <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A HREF="javascript:document.htmlform_service_list_interface.submit();" onClick="return populateForm(document.htmlform_service_list_interface, \'interface=%value fullname%\')"><IMG src="icons/dir.png" alt="Folder Name %value fullname%" border=0></A>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A HREF="service-list.dsp?interface=%value fullname%&webMethods-wM-AdminUI=true"><IMG src="icons/dir.png" alt="Folder Name %value fullname%" border=0></A>');
						}
						else {
							document.write('<A HREF="service-list.dsp?interface=%value fullname%"><IMG src="icons/dir.png" alt="Folder Name %value fullname%" border=0></A>');
						}
					}
				</script>			  
			  &nbsp;
				
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A HREF="javascript:document.htmlform_service_list_interface.submit();" onClick="return populateForm(document.htmlform_service_list_interface, \'interface=%value fullname%\')">');
						document.write(" %value fullname encode(html_javascript)%".replace(currentInterface + ".", ""  ));
						document.write('</A>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A HREF="service-list.dsp?interface=%value fullname encode(url)%&webMethods-wM-AdminUI=true">');
						}
						else {
							document.write('<A HREF="service-list.dsp?interface=%value fullname encode(url)%">');
						}
						document.write(" %value fullname encode(html_javascript)%".replace(currentInterface + ".", ""  ));
						document.write('</A>');
					}
				</script>
                
				
				</nobr></TD>

              <script>writeTD("rowdata-l");</script>

                %ifvar browseaclgroup -notempty%
				
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">%value browseaclgroup encode(html)%</A>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">%value browseaclgroup encode(html)%</A>');
							}
							else {
								document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">%value browseaclgroup encode(html)%</A>');
							}
						}
					</script>
                    
                %else%
                   %ifvar effectiveAclBrowse -notempty%
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value effectiveAclBrowse encode(html)%&gt;</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value effectiveAclBrowse encode(html)%&gt;</A>');
								}
								else {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value effectiveAclBrowse encode(html)%&gt;</A>');
								}
							}
						</script>
                      
                   %else%
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value /parentbrowseaclgroup encode(html)%&gt;</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentbrowseaclgroup encode(html)%&gt;</A>');
								}
								else {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value /parentbrowseaclgroup encode(html)%&gt;</A>');
								}
							}
						</script>
                      
                   %endif%
                   <script>
                  effectiveACLBrowse++;
               </script>
                %endif%
              </TD>

              <script>writeTD("rowdata-l");</script>
                %ifvar readaclgroup -notempty%
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">%value readaclgroup encode(html)%</A>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">%value readaclgroup encode(html)%</A>');
							}
							else {
								document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">%value readaclgroup encode(html)%</A>');
							}
						}
					</script>
                    
                %else%
                   %ifvar effectiveAclRead -notempty%
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value effectiveAclRead encode(html)%&gt;</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value effectiveAclRead encode(html)%&gt;</A>');
								}
								else {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value effectiveAclRead encode(html)%&gt;</A>');
								}
							}
						</script>
                      
                   %else%
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value /parentreadaclgroup encode(html)%&gt;</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentreadaclgroup encode(html)%&gt;</A>');
								}
								else {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value /parentreadaclgroup encode(html)%&gt;</A>');
								}
							}
						</script>
                      
                   %endif%
                   <script>
                  effectiveACLRead++;
               </script>
                %endif%
              </TD>

              <script>writeTD("rowdata-l");</script>
                %ifvar writeaclgroup -notempty%
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface_1.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface_1, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%\')">%value writeaclgroup encode(html)%</A>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&webMethods-wM-AdminUI=true">%value writeaclgroup encode(html)%</A>');
							}
							else {
								document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%">%value writeaclgroup encode(html)%</A>');
							}
						}
					</script>
                    
                %else%
                   %ifvar effectiveAclWrite -notempty%
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface_1.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface_1, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%\')">&lt;%value effectiveAclWrite encode(html)%&gt;</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&webMethods-wM-AdminUI=true">&lt;%value effectiveAclWrite encode(html)%&gt;</A>');
								}
								else {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%">&lt;%value effectiveAclWrite encode(html)%&gt;</A>');
								}
							}
						</script>
                      
                   %else%
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface_1.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface_1, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%\')">&lt;%value /parentwriteaclgroup encode(html)%&gt;</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentwriteaclgroup encode(html)%&gt;</A>');
								}
								else {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%">&lt;%value /parentwriteaclgroup encode(html)%&gt;</A>');
								}
							}
						</script>
                      
                   %endif%
                   <script>
                  effectiveACLWrite++;
               </script>
                %endif%
              </TD>

              <script>writeTD("rowdata-l");</script>
                %ifvar acl -notempty%
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">%value acl encode(html)%</A>');
						} else {
							%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">%value acl encode(html)%</A>');
							}
							else {
								document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">%value acl encode(html)%</A>');
							}
						}
					</script>
                    
                %else%
                   %ifvar effectiveAcl -notempty%
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value effectiveAcl encode(html)%&gt;</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value effectiveAcl encode(html)%&gt;</A>');
								}
								else {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value effectiveAcl encode(html)%&gt;</A>');
								}
							}
						</script>
                      
                   %else%
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<A href="javascript:document.htmlform_acl_assign_parent_interface.submit();" onClick="return populateForm(document.htmlform_acl_assign_parent_interface, \'parent=%value /interface%;interface=%value fullname%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value /parentexecuteaclgroup encode(html)%&gt;</A>');
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentexecuteaclgroup encode(html)%&gt;</A>');
								}
								else {
									%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentexecuteaclgroup encode(html)%&gt;</A>');
									}
									else {
										document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value fullname encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value /parentexecuteaclgroup encode(html)%&gt;</A>');
									}
								}
							}
						</script>
                      
                   %endif%
                   <script>
                  effectiveACL++;
               </script>
                %endif%
              </TD>

              <script>writeTD("rowdata");</script>%value numIfc encode(html)%</TD>
              <script>writeTD("rowdata");</script>%value numSvc encode(html)%</TD>
            </TR>
              <script>swapRows();</script>
            %endloop%
         %else%
          <TR>
            <TD class="evenrow-l" colspan=7>No sub-folders</TD>
          </TR>
         %endif%
       </TABLE>
      <BR>
      <TABLE class="tableView">
      <TR>
        <TD class="heading" colspan=6>Service List</TD>
      </TR>
      <TR>
        <TH scope="col" class="oddcol-l">Service Name</TH>
        <TH scope="col" class="oddcol-l">List ACL</TH>
        <TH scope="col" class="oddcol-l">Read ACL</TH>
        <TH scope="col" class="oddcol-l">Write ACL</TH>
        <TH scope="col" class="oddcol-l">Execute ACL</TH>
        <TH scope="col" class="oddcol">Test</TH>
      </TR>

	  <script>
	  	createForm("htmlform_service_info_browse_folders", "service-info.dsp", "POST", "BODY");
		setFormProperty("htmlform_service_info_browse_folders", "service", "");
		setFormProperty("htmlform_service_info_browse_folders", "browsefolders", "");
	  
	  	createForm("htmlform_service_test", "service-test.dsp", "POST", "BODY");
	    setFormProperty("htmlform_service_test", "interface", "");
	    setFormProperty("htmlform_service_test", "service", "");
		
	    createForm("htmlform_acl_assign_2", "acl-assign.dsp", "POST", "BODY");
	    setFormProperty("htmlform_acl_assign_2", "parent", "");
		setFormProperty("htmlform_acl_assign_2", "interface", "");
		setFormProperty("htmlform_acl_assign_2", "service", "");
		setFormProperty("htmlform_acl_assign_2", "acl", "");
		setFormProperty("htmlform_acl_assign_2", "browseaclgroup", "");
		setFormProperty("htmlform_acl_assign_2", "readaclgroup", "");
		setFormProperty("htmlform_acl_assign_2", "writeaclgroup", "");
		setFormProperty("htmlform_acl_assign_2", "effectiveAcl", "");
		setFormProperty("htmlform_acl_assign_2", "effectiveAclBrowse", "");
		setFormProperty("htmlform_acl_assign_2", "effectiveAclRead", "");
		setFormProperty("htmlform_acl_assign_2", "effectiveAclWrite", "");
		setFormProperty("htmlform_acl_assign_2", "parentexecuteaclgroup", "");
		setFormProperty("htmlform_acl_assign_2", "parentbrowseaclgroup", "");
		setFormProperty("htmlform_acl_assign_2", "parentreadaclgroup", "");
		setFormProperty("htmlform_acl_assign_2", "parentwriteaclgroup", "");	  
		
	  </script>
	  
      %ifvar services%
      <script>resetRows();</script>
      %loop services%
      <TR>
        <script>writeTD("rowdata-l");</script>
		
         <nobr>
		    <script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A HREF="javascript:document.htmlform_service_info_browse_folders.submit();" onClick="return populateForm(document.htmlform_service_info_browse_folders, \'service=%value /interface%:%value name%;browsefolders=true\')"><IMG src="icons/file.png" alt="Service Name %value name%" border=0></A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A HREF="service-info.dsp?service=%value /interface encode(url)%:%value name encode(url)%&browsefolders=true&webMethods-wM-AdminUI=true"><IMG src="icons/file.png" alt="Service Name %value name%" border=0></A>');
					}
					else {
						document.write('<A HREF="service-info.dsp?service=%value /interface encode(url)%:%value name encode(url)%&browsefolders=true"><IMG src="icons/file.png" alt="Service Name %value name%" border=0></A>');
					}
				}
			</script>
		 &nbsp;
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A valign="middle" HREF="javascript:document.htmlform_service_info_browse_folders.submit();"  onClick="return populateForm(document.htmlform_service_info_browse_folders, \'service=%value /interface%:%value name%;browsefolders=true\')">%value name encode(html)%</A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A valign="middle" HREF="service-info.dsp?service=%value /interface encode(url)%:%value name encode(url)%&browsefolders=true&webMethods-wM-AdminUI=true">%value name encode(html)%</A>');
					}
					else {
						document.write('<A valign="middle" HREF="service-info.dsp?service=%value /interface encode(url)%:%value name encode(url)%&browsefolders=true">%value name encode(html)%</A>');
					}
				}
			</script>
		 </nobr></TD>

        <script>writeTD("rowdata-l");</script>
        %ifvar browseaclgroup -notempty%
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">%value browseaclgroup encode(html)%</A>');
			} else {
				%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">%value browseaclgroup encode(html)%</A>');
				}
				else {
					document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">%value browseaclgroup encode(html)%</A>');
				}
			}
		</script>
	   
        %else%
           %ifvar effectiveAclBrowse -notempty%
                <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value effectiveAclBrowse encode(html)%&gt;</A>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value effectiveAclBrowse encode(html)%&gt;</A>');
						}
						else {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value effectiveAclBrowse encode(html)%&gt;</A>');
						}
					}
				</script>
			  
           %else%
		   <script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value /parentbrowseaclgroup encode(html)%&gt;</A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentbrowseaclgroup encode(html)%&gt;</A>');
					}
					else {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value /parentbrowseaclgroup encode(html)%&gt;</A>');
					}
				}
			</script>
  	      
           %endif%
           <script>
          effectiveACLBrowse++;
       </script>
        %endif%
        </TD>

        <script>writeTD("rowdata-l");</script>
        %ifvar readaclgroup -notempty%
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">%value readaclgroup encode(html)%</A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">%value readaclgroup encode(html)%</A>');
					}
					else {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">%value readaclgroup encode(html)%</A>');
					}
				}
			</script>
	   
        %else%
           %ifvar effectiveAclRead -notempty%
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value effectiveAclRead encode(html)%&gt;</A>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value effectiveAclRead encode(html)%&gt;</A>');
						}
						else {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value effectiveAclRead encode(html)%&gt;</A>');
						}
					}
				</script>
              
           %else%
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value /parentreadaclgroup encode(html)%&gt;</A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentreadaclgroup encode(html)%&gt;</A>');
					}
					else {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value /parentreadaclgroup encode(html)%&gt;</A>');
					}
				}
			</script>
  	      
           %endif%
           <script>
          effectiveACLRead++;
       </script>
        %endif%
        </TD>

        <script>writeTD("rowdata-l");</script>
        %ifvar writeaclgroup -notempty%
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">%value writeaclgroup encode(html)%</A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">%value writeaclgroup encode(html)%</A>');
					}
					else {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">%value writeaclgroup encode(html)%</A>');
					}
				}
			</script>
	   
        %else%
           %ifvar effectiveAclWrite -notempty%
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value effectiveAclWrite encode(html)%&gt;</A>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value effectiveAclWrite encode(html)%&gt;</A>');
						}
						else {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value effectiveAclWrite encode(html)%&gt;</A>');
						}
					}
				</script>
              
           %else%
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value /parentwriteaclgroup encode(html)%&gt;</A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentwriteaclgroup encode(html)%&gt;</A>');
					}
					else {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value /parentwriteaclgroup encode(html)%&gt;</A>');
					}
				}
			</script>
  	      
           %endif%
           <script>
          effectiveACLWrite++;
       </script>
        %endif%
        </TD>

        <script>writeTD("rowdata-l");</script>
        %ifvar acl -notempty%
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">%value acl encode(html)%</A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">%value acl encode(html)%</A>');
					}
					else {
						document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">%value acl encode(html)%</A>');
					}
				}
			</script>
	   
        %else%
           %ifvar effectiveAcl -notempty%
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value effectiveAcl encode(html)%&gt;</A>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value effectiveAcl encode(html)%&gt;</A>');
						}
						else {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value effectiveAcl encode(html)%&gt;</A>');
						}
					}
				</script>
              
           %else%
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A href="javascript:document.htmlform_acl_assign_2.submit();" onClick="return populateForm(document.htmlform_acl_assign_2, \'parent=%value /interface%;interface=%value /interface%;service=%value name%;acl=%value acl%;browseaclgroup=%value browseaclgroup%;readaclgroup=%value readaclgroup%;writeaclgroup=%value writeaclgroup%;effectiveAcl=%value effectiveAcl%;effectiveAclBrowse=%value effectiveAclBrowse%;effectiveAclRead=%value effectiveAclRead%;effectiveAclWrite=%value effectiveAclWrite%;parentexecuteaclgroup=%value /parentexecuteaclgroup%;parentbrowseaclgroup=%value /parentbrowseaclgroup%;parentreadaclgroup=%value /parentreadaclgroup%;parentwriteaclgroup=%value /parentwriteaclgroup%\')">&lt;%value /parentexecuteaclgroup encode(html)%&gt;</A>');
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%&webMethods-wM-AdminUI=true">&lt;%value /parentexecuteaclgroup encode(html)%&gt;</A>');
						}
						else {
							document.write('<A href="acl-assign.dsp?parent=%value /interface encode(url)%&interface=%value /interface encode(url)%&service=%value name encode(url)%&acl=%value acl encode(url)%&browseaclgroup=%value browseaclgroup encode(url)%&readaclgroup=%value readaclgroup encode(url)%&writeaclgroup=%value writeaclgroup encode(url)%&effectiveAcl=%value effectiveAcl encode(url)%&effectiveAclBrowse=%value effectiveAclBrowse encode(url)%&effectiveAclRead=%value effectiveAclRead encode(url)%&effectiveAclWrite=%value effectiveAclWrite encode(url)%&parentexecuteaclgroup=%value /parentexecuteaclgroup encode(url)%&parentbrowseaclgroup=%value /parentbrowseaclgroup encode(url)%&parentreadaclgroup=%value /parentreadaclgroup encode(url)%&parentwriteaclgroup=%value /parentwriteaclgroup encode(url)%">&lt;%value /parentexecuteaclgroup encode(html)%&gt;</A>');
						}
					}
				</script>
  	      
           %endif%
           <script>
          effectiveACL++;
       </script>
        %endif%
        </TD>

        <script>writeTD("rowdata");</script>
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<A href="javascript:document.htmlform_service_test.submit();" onClick="return populateForm(document.htmlform_service_test, \'interface=%value /interface%;service=%value name%\')"><IMG src="icons/checkdot.png" alt="Service Name %value name%" border=0></A>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="service-test.dsp?interface=%value /interface encode(url)%&service=%value name encode(url)%&webMethods-wM-AdminUI=true"><IMG src="icons/checkdot.png" alt="Service Name %value name%" border=0> </A>');
					}
					else {
						document.write('<A href="service-test.dsp?interface=%value /interface encode(url)%&service=%value name encode(url)%"><IMG src="icons/checkdot.png" alt="Service Name %value name%" border=0> </A>');
					}
				}
			</script>
          
        </TD>

      </TR>
        <script>swapRows();</script>
      %endloop%
         %else%
          <TR>
            <TD class="evenrow-l" colspan=6>No services in this folder</TD>
          </TR>

      %endif%
      </TABLE>
    <script>
    if ((effectiveACL > 0) || (effectiveACLBrowse > 0) || (effectiveACLRead > 0) || (effectiveACLWrite > 0))
    {
      document.write("<BR>");
        document.write("<> ACL setting inherited from parent.");
    }
    </script>
      </TD></TR>

    </TABLE> %endinvoke%  %endinvoke%
  </BODY>
</HTML>
