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
    <SCRIPT SRC="webMethods.js"></SCRIPT>

    <TITLE>Integration Server -- Port Access Management</TITLE>
    <SCRIPT SRC="ports.js"></SCRIPT>
    


  </HEAD>

  <BODY onLoad="setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_PortsScrn');">
    %invoke wm.server.net.listeners:ListenerAdmin%

  %ifvar configURL%

    <script>
		
		if(is_csrf_guard_enabled && needToInsertToken) {
			createForm("htmlForm_listeners", '%value configURL%', "POST", "BODY");
			setFormProperty("htmlForm_listeners", "listenerKey", "%value encode(javascript) listenerKey%");
			setFormProperty("htmlForm_listeners", "pkg", "%value pkg%");
			setFormProperty("htmlForm_listeners", "ssl", "%value ssl%");
			setFormProperty("htmlForm_listeners", "listenerType", "%value listenerType%");
			setFormProperty("htmlForm_listeners", "mode", "%value mode%");
			setFormProperty("htmlForm_listeners", "listening", "%value listening%");
			setFormProperty("htmlForm_listeners", "portName", "%value encode(javascript) portName%");		
			setFormProperty("htmlForm_listeners", _csrfTokenNm_, _csrfTokenVal_);
			document.htmlForm_listeners.submit();
		} else {
			%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				document.location.replace("..%value configURL%?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%&ssl=%value ssl encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%%ifvar mode%&mode=%value mode encode(url)%%endif%%ifvar listening%&listening=%value listening encode(url)%%endif%%ifvar portName%&portName=%value portName encode(url)%%endif%&webMethods-wM-AdminUI=true");
			}
			else {
				document.location.replace("..%value configURL%?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%&ssl=%value ssl encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%%ifvar mode%&mode=%value mode encode(url)%%endif%%ifvar listening%&listening=%value listening encode(url)%%endif%%ifvar portName%&portName=%value portName encode(url)%%endif%");
			}
		}
		
		
    </script>
  %endif%

  %ifvar message%
    <script>				
		if(is_csrf_guard_enabled && needToInsertToken) {
			createForm("htmlform_security_ports_message", 'security-ports.dsp', "POST", "BODY");
			setFormProperty("htmlform_security_ports_message", "message2", "%value message encode(javascript)%");		
			setFormProperty("htmlform_security_ports_message", _csrfTokenNm_, _csrfTokenVal_);
			document.htmlform_security_ports_message.submit();
		} else {
			%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				document.location.replace("security-ports.dsp?message2=%value message encode(url)%&webMethods-wM-AdminUI=true");
			}
			else {
				document.location.replace("security-ports.dsp?message2=%value message encode(url)%");
			}
		}
		        
    </script>
  %endif%

<!-- endinvoke for wm.server.net.listeners:ListenerAdmin -->
%endinvoke%
	<TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan="2"> Security &gt; Ports  </TD>
      </TR>
        %ifvar message2%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message2 encode(html)%</TD></TR>
        %endif%

      <TR>
        <TD colspan="2">
          <ul class="listitems">			  
			<script>
			createForm("htmlform_security_ports_add", "security-ports-add.dsp", "POST", "BODY");
			createForm("htmlform_security_ports_primary", "security-ports-primary.dsp", "POST", "BODY");
			createForm("htmlform_server_ipaccess", "server-ipaccess.dsp", "POST", "BODY");
			setFormProperty("htmlform_server_ipaccess", "listenerKey", "global");
			</script>
			
            <li class="listitem"><script>getURL("security-ports-add.dsp", "javascript:document.htmlform_security_ports_add.submit();", "Add Port");</script>
			</li>			
            <li class="listitem"><script>getURL("security-ports-primary.dsp", "javascript:document.htmlform_security_ports_primary.submit();", "Change Primary Port");</script>
			</li>
            <li class="listitem"><script>getURL("server-ipaccess.dsp?listenerKey=global", "javascript:document.htmlform_server_ipaccess.submit();", "Change Global IP Access Restrictions");</script>
			</li>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE class="tableView" width="100%">
            %invoke wm.server.ports:listListeners%
            <TR>
              <TD class="heading" colspan="11">Port List</TD>
            </TR>

            <TR>
              <TH class="oddcol" scope="col">Port</TH>
              <TH class="oddcol" scope="col">Alias</TH>
              <TH class="oddcol" scope="col">Protocol</TH>
              <TH class="oddcol" scope="col">Type</TH>
              <TH class="oddcol" scope="col">Package</TH>
              <TH class="oddcol" scope="col">Enabled</TH>
              <TH class="oddcol" scope="col">Access Mode</TH>
              <TH class="oddcol" scope="col">IP Access</TH>
              <TH class="oddcol" scope="col">Advanced</TH>
              <TH class="oddcol" scope="col">Delete</TH>
              <TH class="oddcol" scope="col">Description</TH>
            </TR>

            %loop listeners%
            %invoke wm.server.quiesce:isDisableQuiescePort%
            <TR>
              <!-- PORT -->
              <script>writeTD("rowdata");</script>
                %ifvar protocol equals('Email')%
                  <A HREF="javascript:editListener(document.listeners, '%value key encode(javascript)%', '%value user encode(javascript)%@%value host encode(javascript)%' , '%value pkg encode(javascript)%', '%value factoryKey encode(javascript)%', %ifvar primary equals('javascript')%'primary'%else%'%value listening encode(javascript)%'%endif%);">
                    %value encode(html) user%@%value host encode(html)%
                  </A>
                %else%
                  %ifvar listenerType equals('regularinternal')%
                    <A HREF="javascript:editListener(document.listeners, '%value key encode(javascript)%', '%value proxyHost encode(javascript)%:%value port encode(javascript)%', '%value pkg encode(javascript)%', '%value factoryKey encode(javascript)%', %ifvar primary equals('true')%'primary'%else%'%value listening encode(javascript)%'%endif%);">
				    %value proxyHost encode(html)%:%value port encode(html)%
                    </A>
                  %else%
					<A HREF="javascript:editListener(document.listeners, '%value key encode(javascript)%', '%value port encode(javascript)%', '%value pkg encode(javascript)%', '%value factoryKey encode(javascript)%', %ifvar primary equals('true')%'primary'%else% %ifvar isDisableQuiescePort equals('true')%'quiesce'%else%'%value listening encode(javascript)%'%endif%%endif%);">
             %value port encode(html)%
                    </A>
                  %endif%
                %endif%
              </TD>

              <!-- ALIAS -->
              <script>writeTD("rowdata");</script>%value portAlias encode(html)%</TD>

              <!-- PROTOCOL -->
              <script>writeTD("rowdata");</script>
                    		%value protocol encode(html)% </TD>

              <!-- TYPE -->
              <script>writeTD("rowdata");</script>
                          %ifvar listenerType%
                            %switch listenerType%
                              %case 'revinvokeinternal'%
                                Enterprise Gateway Registration
                              %case 'regularinternal'%
                                Registration Internal
                              %case 'revinvoke'%
                               Enterprise Gateway External
                              %case 'Regular'%
                                %ifvar primary equals('true')%
                                  <IMG SRC="images/green_check.png"> Primary
                                %else%
                                  Regular
                                %endif%
                              %case 'Diagnostic'%
                                Diagnostic
                              %case%
                                %value listenerType encode(html)%
                              %endswitch%
                          %else%
                            Regular
                          %endif%</TD>

              <!-- PACKAGE -->
              <script>writeTD("rowdata");</script>%value pkg encode(html)%</TD>

              <!-- ENABLED -->
              <script>writeTD("rowdata");</script>

                %ifvar primary equals('true')%
                  %ifvar listening equals('true')%
                    <img src="images/green_check.png" border="no">Yes
                  %else%
                    &nbsp;&nbsp;&nbsp;No
                  %endif%
                %else%
                  %ifvar listening equals('true')%
                    <a class="imagelink" href="javascript:document.listeners.submit();" onClick="return enableListener(document.listeners, 'disable', '%value key encode(javascript)%', '%value pkg encode(javascript)%', '%ifvar protocol equals('Email')%%value user encode(javascript)%@%value host encode(javascript)%%else%%value key encode(javascript)%%endif%');"><img src="images/green_check.png" alt="Port %value key %" border="no">Yes</a>
                  %else%
                    &nbsp;&nbsp;&nbsp;<a href="javascript:document.listeners.submit();" onClick="return enableListener(document.listeners, 'enable', '%value key encode(javascript)%', '%value pkg encode(javascript)%', '%ifvar protocol equals('Email')%%value user encode(javascript)%@%value host encode(javascript)%%else%%value key encode(javascript)%%endif%');">No</a>
                  %endif%
                %endif%
              </TD>

              <!-- ACCESS MODE -->
              <script>writeTD("rowdata");</script>
                %ifvar protocol equals('Email')%
				  <script>
				  createForm("htmlform_security_ports_editaccess_email_%value $index%", "security-ports-editaccess.dsp", "POST", "BODY");
				  setFormProperty("htmlform_security_ports_editaccess_email_%value $index%", "port", "%value key%");
				  %ifvar listenerType%
					setFormProperty("htmlform_security_ports_editaccess_email_%value $index%", "listenerType", "%value listenerType%");
				  %endif%
				  </script>
				  <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write("<A href='javascript:document.htmlform_security_ports_editaccess_email_%value $index%.submit();'> %ifvar accessMode equals('Allow')% Allow %else% Deny %endif% %ifvar hasAccessList equals('true')% +%endif% </A>");
					} else {
						%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write("<A href='security-ports-editaccess.dsp?port=%value key encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&webMethods-wM-AdminUI=true'> %ifvar accessMode equals('Allow')% Allow %else% Deny %endif% %ifvar hasAccessList equals('true')% +%endif% </A>");
						}
						else {
							document.write("<A href='security-ports-editaccess.dsp?port=%value key encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%'> %ifvar accessMode equals('Allow')% Allow %else% Deny %endif% %ifvar hasAccessList equals('true')% +%endif% </A>");
						}
					}
				</script>
                  
                %else%
                    %ifvar provider equals('JBoss')%
                      Not Applicable
                    %else%
                      %ifvar provider equals('JBossMQ')%
                        Not Applicable
                      %else%
                        %switch listenerType%
                        %case 'revinvokeinternal'%
                            Not Applicable
                        %case 'revinvoke'%
                            Not Applicable
                        %case%
						  <script>
						  createForm("htmlform_security_ports_editaccess_regular_%value $index%", "security-ports-editaccess.dsp", "POST", "BODY");
						  setFormProperty("htmlform_security_ports_editaccess_regular_%value $index%", "port", "%value encode(javascript) key%");
						  %ifvar listenerType%
							setFormProperty("htmlform_security_ports_editaccess_regular_%value $index%", "listenerType", "%value listenerType%");
						  %endif%
						  </script>
						  <script>
							if(is_csrf_guard_enabled && needToInsertToken) {								
								document.write("<A href='javascript:document.htmlform_security_ports_editaccess_regular_%value $index%.submit();'> %ifvar accessMode equals('Allow')% Allow %else%  Deny %endif% %ifvar hasAccessList equals('true')% + %endif% </A>");
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write("<A href='security-ports-editaccess.dsp?port=%value key encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&webMethods-wM-AdminUI=true'> %ifvar accessMode equals('Allow')% Allow %else%  Deny %endif% %ifvar hasAccessList equals('true')% + %endif% </A>");
								}
								else {
									document.write("<A href='security-ports-editaccess.dsp?port=%value key encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%'> %ifvar accessMode equals('Allow')% Allow %else%  Deny %endif% %ifvar hasAccessList equals('true')% + %endif% </A>");
								}
							}
						</script>
                          
                        %endswitch%
                      %endif%
                    %endif%
                %endif%
              </TD>           

              <!-- IP ACCESS MODE -->
              <script>writeTD("rowdata");</script>
                    %ifvar provider equals('JBoss')%
                      Not Applicable
                    %else%
                      %ifvar provider equals('JBossMQ')%
                        Not Applicable
                      %else%
                      %ifvar listenerType equals('regularinternal')%
                        Not Applicable
                      %else%
                    %ifvar protocol equals('Email')%
					  <script>
					  createForm("htmlform_server_ipaccess_email_%value $index%", "server-ipaccess.dsp", "POST", "BODY");
					  setFormProperty("htmlform_server_ipaccess_email_%value $index%", "listenerKey", "%value encode(javascript) key%");
					  setFormProperty("htmlform_server_ipaccess_email_%value $index%", "pkg", "%value pkg%");					  
					  </script>
					  <script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write("<a href='javascript:document.htmlform_server_ipaccess_email_%value $index%.submit();'> %ifvar ipAccessMode equals('Allow')% Allow %else% Deny %endif% %ifvar hasIPAccessList equals('true')% +%endif% </a>");
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write("<a href='server-ipaccess.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg encode(url)%&webMethods-wM-AdminUI=true'> %ifvar ipAccessMode equals('Allow')% Allow  %else% Deny %endif% %ifvar hasIPAccessList equals('true')% +%endif% </a>");
								}
								else {
									document.write("<a href='server-ipaccess.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg encode(url)%'> %ifvar ipAccessMode equals('Allow')% Allow  %else% Deny %endif% %ifvar hasIPAccessList equals('true')% +%endif% </a>");
								}
							}
						</script>
	                  
                    %else%
					  <script>
					  createForm("htmlform_server_ipaccess_regular_%value $index%", "server-ipaccess.dsp", "POST", "BODY");
					  setFormProperty("htmlform_server_ipaccess_regular_%value $index%", "listenerKey", "%value encode(javascript) key%");
					  setFormProperty("htmlform_server_ipaccess_regular_%value $index%", "pkg", "%value pkg%");					  
					  </script>
					  <script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write("<a href='javascript:document.htmlform_server_ipaccess_regular_%value $index%.submit();'> %ifvar ipAccessMode equals('Allow')% Allow %else% Deny %endif% %ifvar hasIPAccessList equals('true')% +%endif% </a>");
							} else {
								%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write("<a href='server-ipaccess.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg encode(url)%&webMethods-wM-AdminUI=true'> %ifvar ipAccessMode equals('Allow')% Allow %else% Deny %endif% %ifvar hasIPAccessList equals('true')% +%endif% </a>");
								}
								else {
									document.write("<a href='server-ipaccess.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg encode(url)%'> %ifvar ipAccessMode equals('Allow')% Allow %else% Deny %endif% %ifvar hasIPAccessList equals('true')% +%endif% </a>");
								}
							}
						</script>
	                  
                    %endif%
                      %endif%
                    %endif%
              </TD>
              
              <!-- ADVANCED -->
              <script>writeTD("rowdata");</script>
                %ifvar primary equals('true')%
                  &nbsp;
                %else%
                  %ifvar isDisableQuiescePort equals('true')%
                     &nbsp;
                  %else%    
                     %switch protocol%
                     %case 'HTTP'%
							<script>
						    createForm("htmlform_http_advanced_http_%value port%", "http-advanced.dsp", "POST", "BODY");
						    setFormProperty("htmlform_http_advanced_http_%value port%", "listenerKey", "%value encode(javascript) key%");
						    setFormProperty("htmlform_http_advanced_http_%value port%", "pkg", "%value pkg%");
						    %ifvar listening%
							  setFormProperty("htmlform_http_advanced_http_%value port%", "listening", "%value listening%");
						    %else%
							  setFormProperty("htmlform_http_advanced_http_%value port%", "listening", "false");
						    %endif%
						    </script>
							<script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<a href="javascript:document.htmlform_http_advanced_http_%value port%.submit();">Edit</a>');
								} else {
									%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<a href="http-advanced.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg encode(url)%&listening=%ifvar listening%%value listening encode(url)%%else%false%endif%&webMethods-wM-AdminUI=true">Edit</a>');
									}
									else {
										document.write('<a href="http-advanced.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg encode(url)%&listening=%ifvar listening%%value listening encode(url)%%else%false%endif%">Edit</a>');
									}
								}
							</script>
							
                     %case 'HTTPS'%
							<script>
						    createForm("htmlform_http_advanced_https_%value $index%", "http-advanced.dsp", "POST", "BODY");
						    setFormProperty("htmlform_http_advanced_https_%value $index%", "listenerKey", "%value eencode(javascript) key%");
							setFormProperty("htmlform_http_advanced_https_%value $index%", "pkg", "%value pkg%");
							setFormProperty("htmlform_http_advanced_https_%value $index%", "listening", "%value listening%");						    
						    </script>
							<script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<a href="javascript:document.htmlform_http_advanced_https_%value $index%.submit();">Edit</a>');
								} else {
									%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<a href="http-advanced.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg encode(url)%&listening=%value listening encode(url)%&webMethods-wM-AdminUI=true">Edit</a>');
									}
									else {
										document.write('<a href="http-advanced.dsp?listenerKey=%value key encode(url)%&pkg=%value pkg encode(url)%&listening=%value listening encode(url)%">Edit</a>');
									}
								}
							</script>
							
                     %case%
                         Not Applicable
                     %endswitch%
                   %endif%
                %endif%
              </TD>

              <!-- DELETE -->
              <script>writeTD("rowdata");</script>
                <a href="javascript:document.listeners.submit();" onClick="return removeListener(document.listeners, '%value key encode(javascript)%', '%value pkg encode(javascript)%', '%ifvar protocol equals('Email')%%value user encode(javascript)%@%value host encode(javascript)%%else%%value key encode(javascript)%%endif%' );"><img src="icons/delete.png" alt="Port %value key%"  border="no"></A>
              </TD>
              
       <!-- DESCRIPTION -->
              <script>writeTD("rowdata");</script>
                    		%value portDescription encode(html)% </TD>

            </TR>
            <script>swapRows();</script>
            %endinvoke%
            %endloop%

            %endinvoke%
          </TABLE>
        </TD>
      </TR>
    </TABLE>
	
	<form name="listeners" action="security-ports.dsp" method="POST">
	    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="listenerKey">
    <input type="hidden" name="portName">
    <input type="hidden" name="factoryKey">
    <input type="hidden" name="operation">
    <input type="hidden" name="mode">
    <input type="hidden" name="listening">
    <input type="hidden" name="pkg">
    </form>	
		
    <form name="addListener" action="security-ports.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="operation" value="create">
    <input type="hidden" name="action" value="edit">
    </form>

  </BODY>
</HTML>

