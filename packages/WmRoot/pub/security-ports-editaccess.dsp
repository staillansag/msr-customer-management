<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js">
    </SCRIPT>
    <TITLE>Integration Server -- Port Access Management</TITLE>
  </HEAD>
<script>
	function confirmAction(msg, fm, pairs) {
		if (confirm (msg)) {
			populateForm(fm, pairs);
			return true;
		} else return false;
	}
</script>
  <BODY onLoad="setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditAccessModeScrn');">
	<form method="post" name="htmlform_security_ports_editaccess_delete" id="htmlform_security_ports_editaccess_delete" action="security-ports-editaccess.dsp">
	    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
		<input type="hidden" name="port">
		<input type="hidden" name="listenerType">
		<input type="hidden" name="node">
		<input type="hidden" name="Action" value="deleteNode">
		<input type="hidden" name="Page" value="Edit">
	</form>

	<form method="post" name="htmlform_security_ports_editaccess_include_exclude" id="htmlform_security_ports_editaccess_include_exclude" action="security-ports-editaccess.dsp">
	    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
		<input type="hidden" name="port">
		<input type="hidden" name="listenerType">
		<input type="hidden" name="Action" value="deleteNode">
		<input type="hidden" name="type" value="Edit">
	</form>
	
	<form method="post" name="htmlform_security_ports_addaccess_include_exclude" id="htmlform_security_ports_addaccess_include_exclude" action="security-ports-addaccess.dsp">
	    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
		<input type="hidden" name="port">
		<input type="hidden" name="listenerType">
	</form>
	
	<form method="post" name="htmlform_security_ports_editaccess_reset" id="htmlform_security_ports_editaccess_reset" action="security-ports-editaccess.dsp">
	    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
		<input type="hidden" name="port">
		<input type="hidden" name="listenerType">
		<input type="hidden" name="Action" value="deleteNode">
	</form>
	
	%switch Action%
          %case 'resetPort'%
            %invoke wm.server.portAccess:resetPort%
              <script>
                    if(is_csrf_guard_enabled && needToInsertToken) {
						createForm("htmlForm_security_ports_editaccess_change_reset", "security-ports-editaccess.dsp", "POST", "BODY");
						setFormProperty("htmlForm_security_ports_editaccess_change_reset", "port", "%value encode(javascript) port%");
						setFormProperty("htmlForm_security_ports_editaccess_change_reset", "listenerType", "%value encode(javascript) listenerType%");
						%ifvar message%
							setFormProperty("htmlForm_security_ports_editaccess_change_reset", "message", "%value message%");
						%endif%
						setFormProperty("htmlForm_security_ports_editaccess_change_reset", _csrfTokenNm_, _csrfTokenVal_);						
						document.htmlForm_security_ports_editaccess_change_reset.submit();
                    } else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.location.replace("security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%%ifvar message%&message=%value message encode(url)%%endif%&webMethods-wM-AdminUI=true");
						}
						else {
							document.location.replace("security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%%ifvar message%&message=%value message encode(url)%%endif%");
						}
                    }
               </script>
            %endinvoke%
          %case 'addNode'%
            %invoke wm.server.portAccess:addNodes%
              <script>
                    if(is_csrf_guard_enabled && needToInsertToken) {
						createForm("htmlForm_security_ports_editaccess_change_addnode", "security-ports-editaccess.dsp", "POST", "BODY");
						setFormProperty("htmlForm_security_ports_editaccess_change_addnode", "port", "%value encode(javascript) port%");
						setFormProperty("htmlForm_security_ports_editaccess_change_addnode", "listenerType", "%value encode(javascript) listenerType%");
						%ifvar message%
							setFormProperty("htmlForm_security_ports_editaccess_change_addnode", "message", "%value message%");
						%endif%
						setFormProperty("htmlForm_security_ports_editaccess_change_addnode", _csrfTokenNm_, _csrfTokenVal_);						
						document.htmlForm_security_ports_editaccess_change_addnode.submit();
                    } else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.location.replace("security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%%ifvar message%&message=%value message encode(url)%%endif%&webMethods-wM-AdminUI=true");
						}
						else {
							document.location.replace("security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%%ifvar message%&message=%value message encode(url)%%endif%");
						}
                    }   
              </script>
            %endinvoke%
          %case 'deleteNode'%
            %invoke wm.server.portAccess:deleteNode%
              <script>
                    if(is_csrf_guard_enabled && needToInsertToken) {
						createForm("htmlForm_security_ports_editaccess_change_deletenode", "security-ports-editaccess.dsp", "POST", "BODY");
						setFormProperty("htmlForm_security_ports_editaccess_change_deletenode", "port", "%value encode(javascript) port%");
						setFormProperty("htmlForm_security_ports_editaccess_change_deletenode", "listenerType", "%value encode(javascript) listenerType%");
						
						%ifvar message%
							setFormProperty("htmlForm_security_ports_editaccess_change_deletenode", "message", "%value message%");
						%endif%
						setFormProperty("htmlForm_security_ports_editaccess_change_deletenode", _csrfTokenNm_, _csrfTokenVal_);						
						document.htmlForm_security_ports_editaccess_change_deletenode.submit();
                    } else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.location.replace("security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%%ifvar message%&message=%value message encode(url)%%endif%&webMethods-wM-AdminUI=true");
						}
						else {
							document.location.replace("security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%%ifvar message%&message=%value message encode(url)%%endif%");
						}
                    }                   
              </script>
            %endinvoke%
          %case 'setType'%
            %invoke wm.server.portAccess:setType%
              <script>
                    if(is_csrf_guard_enabled && needToInsertToken) {
						createForm("htmlForm_security_ports_editaccess_change_settype", "security-ports-editaccess.dsp", "POST", "BODY");
						setFormProperty("htmlForm_security_ports_editaccess_change_settype", "port", "%value encode(javascript) port%");
						setFormProperty("htmlForm_security_ports_editaccess_change_settype", "listenerType", "%value encode(javascript) listenerType%");
						%ifvar message%
							setFormProperty("htmlForm_security_ports_editaccess_change_settype", "message", "%value message%");
						%endif%
						setFormProperty("htmlForm_security_ports_editaccess_change_settype", _csrfTokenNm_, _csrfTokenVal_);						
						document.htmlForm_security_ports_editaccess_change_settype.submit();
                    } else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.location.replace("security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%%ifvar message%&message=%value message encode(url)%%endif%&webMethods-wM-AdminUI=true");
						}
						else {
							document.location.replace("security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%%ifvar message%&message=%value message encode(url)%%endif%");
						}
                    }       
              </script>
            %endinvoke%
        %endswitch%
	
    <FORM action="security-ports-editaccess.dsp" method="POST">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <INPUT TYPE="HIDDEN" NAME=Action VALUE="addNode">
    <INPUT TYPE="HIDDEN" NAME=Page VALUE="Edit">
	<input type="HIDDEN" name="listenerType" value="%value listenerType encode(url)%">

    <TABLE width="100%">

    <TR>
      <TD class="breadcrumb" colspan=2>
        Security &gt;
        Ports &gt;
        Edit Access Mode &gt;
        %value port encode(html)% </TD>
    </TR>

  %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
    <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
  %endif%

    <TR>
      <TD colspan="2">
    %ifvar listenerType equals('registration')%
      <ul class="listitems">
          <li>
		  <script>
		  createForm("htmlform_security_ports_done", "security-ports.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("security-ports.dsp", "javascript:document.htmlform_security_ports_done.submit();", "Done");</script>
		  </li>
      </UL>
       <TR>
        <TD  class="heading"colspan=2>Service Lists cannot be edited on a Registration Listener</TD>
       </TR>
    %else%

    %invoke wm.server.portAccess:getPort%

        <ul class="listitems">
		<script>
		  createForm("htmlform_security_ports_return", "security-ports.dsp", "POST", "BODY");
		  </script>
          <li>
		  <script>getURL("security-ports.dsp", "javascript:document.htmlform_security_ports_return.submit();", "Return to Port List");</script>
		  </li>
          %switch type%
            %case 'exclude'%


              <li>
			  <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_security_ports_addaccess_include_exclude.submit();" onClick="return populateForm(document.htmlform_security_ports_addaccess_include_exclude,\'port=%value encode(javascript) port%;listenerType=%value encode(javascript) listenerType%\')">Add Folders and Services to Allow List</a>');
					} else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<a href="security-ports-addaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%&webMethods-wM-AdminUI=true">Add Folders and Services to Allow List</a>');
						}
						else {
							document.write('<a href="security-ports-addaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%">Add Folders and Services to Allow List</a>');
						}
					}
				</script>
			  </li>
			  
              <LI>
			  <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a onclick="return confirmAction(\'Warning: You will allow access to all services through this port until services are added to the deny list.  The current service list will be cleared.  Are you sure?\', document.htmlform_security_ports_editaccess_include_exclude, \'port=%value port%;listenerType=%value encode(javascript) listenerType%;Action=setType;type=include\');" href="javascript:document.htmlform_security_ports_editaccess_include_exclude.submit();">Set Access Mode to Allow by Default</A>');
					} else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<a onclick="return confirm(\'Warning: You will allow access to all services through this port until services are added to the deny list.  The current service list will be cleared.  Are you sure?\');" href="security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%&Action=setType&type=include&webMethods-wM-AdminUI=true">Set Access Mode to Allow by Default</A>');
						}
						else {
							document.write('<a onclick="return confirm(\'Warning: You will allow access to all services through this port until services are added to the deny list.  The current service list will be cleared.  Are you sure?\');" href="security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%&Action=setType&type=include">Set Access Mode to Allow by Default</A>');
						}
					}
				</script>
			  
            %case 'include'%

              <li>
			  <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_security_ports_addaccess_include_exclude.submit();" onClick="return populateForm(document.htmlform_security_ports_addaccess_include_exclude, \'port=%value port%;listenerType=%value encode(javascript) listenerType%\');">Add Folders and Services to Deny List</a>');
					} else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<a href="security-ports-addaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%&webMethods-wM-AdminUI=true">Add Folders and Services to Deny List</a>');
						}
						else {
							document.write('<a href="security-ports-addaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%">Add Folders and Services to Deny List</a>');
						}
					}
				</script>
			  </li>
			  <LI>
			  <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a onclick="return confirmAction(\'Warning: You will block all access to the server through this port until services are added to the allow list.  The current service list will be cleared and defaults will be provided.  Are you sure?\', document.htmlform_security_ports_editaccess_include_exclude, \'port=%value port%;listenerType=%value encode(javascript) listenerType%;Action=setType;type=exclude\');" href="javascript:document.htmlform_security_ports_editaccess_include_exclude.submit();">Set Access Mode to Deny by Default</A>');
					} else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<a onclick="return confirm(\'Warning: You will block all access to the server through this port until services are added to the allow list.  The current service list will be cleared and defaults will be provided.  Are you sure?\');" href="security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%&Action=setType&type=exclude&webMethods-wM-AdminUI=true">Set Access Mode to Deny by Default</A>');
						}
						else {
							document.write('<a onclick="return confirm(\'Warning: You will block all access to the server through this port until services are added to the allow list.  The current service list will be cleared and defaults will be provided.  Are you sure?\');" href="security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%&Action=setType&type=exclude">Set Access Mode to Deny by Default</A>');
						}
					}
				</script>
			  
              </LI>
          %endswitch%

          <li>
		  <script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<a href="javascript:document.htmlform_security_ports_editaccess_reset.submit();" onClick="return confirmAction(\'Warning: You will block all access to the server through this port until services are added to the allow list.  The current service list will be cleared and defaults will be provided.  Are you sure?\', document.htmlform_security_ports_editaccess_reset, \'port=%value port%;listenerType=%value encode(javascript) listenerType%;Action=resetPort\');">Reset to default access settings</a>');
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%&Action=resetPort&webMethods-wM-AdminUI=true" onClick="return confirm(\'Warning: You will block all access to the server through this port until services are added to the allow list.  The current service list will be cleared and defaults will be provided.  Are you sure?\');">Reset to default access settings</a>');
					}
					else {
						document.write('<a href="security-ports-editaccess.dsp?port=%value port encode(url)%&listenerType=%value listenerType encode(url)%&Action=resetPort" onClick="return confirm(\'Warning: You will block all access to the server through this port until services are added to the allow list.  The current service list will be cleared and defaults will be provided.  Are you sure?\');">Reset to default access settings</a>');
					}
				}
			</script>
		  </li>
        </UL>
      </TD>
    </TR>

    <TR>
      <TD width=100%>
        <TABLE class="tableView">

        <!-- Display Edit Page -->

        <!-- GENERATE PORT LIST -->

       <TR>
          <TD class="heading" colspan=2>Port Service Access Settings</TD>
        </TR>
        %ifvar port%
     	   <INPUT TYPE="hidden" NAME="port" VALUE="%value port encode(htmlattr)%">
        %endif%
       <TR>
          <TD class="oddrow">Access Mode</TD>
          <TD class="oddrowdata-l">
                %switch type%
                  %case 'include'%
                    Allow by Default
                  %case 'exclude'%
                    Deny by Default
                %endswitch%
                </SELECT>
          </TD>
        </TR>
        </TABLE>
        <BR>
        <TABLE class="tableView">

        <TR>
          <TD class="heading" colspan=2>
            %switch type%
              %case 'include'%
                Deny List
              %case 'exclude'%
                Allow List
            %endswitch%
          </TD>
        </TR>
        <TR>
          <th scope="col" class="oddcol">Folders and Services</th>
          <th scope="col" class="oddcol">Remove</th>
        </TR>
        
		
		%scope%
		
		%rename port inString -copy%				
		%invoke wm.server.csrfguard:replaceSpecialCharacters%
		%loop nodeList%
        <TR>
			
            <script>writeTD("rowdata-l");</script>%value encode(html)%</TD>
            <script>writeTD("rowdata");</script>
			
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<a href="javascript:document.htmlform_security_ports_editaccess_delete.submit();" onClick="return populateForm(document.htmlform_security_ports_editaccess_delete, \'port=%value port%;node=%value%\')"><img src="icons/delete.png" alt="Remove Folders and Services %value encode(url)%" border="no"></a>');
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="security-ports-editaccess.dsp?port=%value port encode(url)%&node=%value encode(url)%&Action=deleteNode&Page=Edit&webMethods-wM-AdminUI=true"><img src="icons/delete.png" alt="Remove Folders and Services %value encode(url)%"  border="no"></a>');
					}
					else {
						document.write('<a href="security-ports-editaccess.dsp?port=%value port encode(url)%&node=%value encode(url)%&Action=deleteNode&Page=Edit"><img src="icons/delete.png" alt="Remove Folders and Services %value encode(url)%"  border="no"></a>');
					}
				}
			</script>
                   
            </TD>
            <script>swapRows();</script>
        </TR>
		%endinvoke%
		
        %endloop%
		%endscope%
        %endinvoke%
    %endif%
        </TABLE>
      </TD>
    </TR>
  </TABLE>
</FORM>

</BODY>
</HTML>
