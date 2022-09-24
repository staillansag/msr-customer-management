%ifvar action equals('killAll')%  
	%invoke wm.server.admin:killAllExceptYourSession%
	%endinvoke%  
%endif%
<HTML>
  <HEAD>
    <META http-equiv="refresh" content="90">
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Settings Cluster</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT src="webMethods.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
	var currentSession = null;
	var message = null;
     function confirmDelete()
      {
       return confirm("All sessions except this session will be terminated. Do you want to continue?"); 
      }
      function confirmSession() 
      {
		%invoke wm.server.query:getCurrentSession%
		currentSession = "%value currentSessionID%";
		%endinvoke%
			
		return currentSession;
	  }
    </SCRIPT>
 </HEAD>
 <BODY onLoad="setNavigation('stats-general.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_TotalSessionsScrn');">
         <TABLE width=100%>
            %invoke wm.server.securityimpl:getSessionMaskingStatus%
            <TR>
               <TD class="breadcrumb" colspan=2>
                Server &gt;
                Statistics &gt;
                Sessions</TD>
            </TR>
             <TR>
              <TD colspan=2>
                <ul class="listitems">
				%ifvar equals('shutdown') returnto%
				<script>
				  createForm("htmlform_server_shutdown", "server-shutdown.dsp", "POST", "BODY");
				  </script>
				<li>
				<script>getURL("server-shutdown.dsp", "javascript:document.htmlform_server_shutdown.submit();", "Return to Shut Down and Restart");</script>
				</li>
				%else%
				<script>
				  createForm("htmlform_stats_general", "stats-general.dsp", "POST", "BODY");
				  createForm("htmlform_server_cluster", "server-cluster.dsp", "POST", "BODY");
				  setFormProperty("htmlform_server_cluster", "action", "killAll");
				  </script>
                  <li>
				  <script>getURL("stats-general.dsp", "javascript:document.htmlform_stats_general.submit();", "Return to Server Statistics");</script>
				  </li>
                  %ifvar sessionMaskingStatus equals('1')%
                  	<li>Kill All Except Your Session</a></li>
                  %else%
                  	<li>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_server_cluster.submit();" onclick="return confirmDelete();">Kill All Except Your Session</a>');
						} else {
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="server-cluster.dsp?action=killAll&webMethods-wM-AdminUI=true" onclick="return confirmDelete();">Kill All Except Your Session</a>');
							}
							else {
								document.write('<a href="server-cluster.dsp?action=killAll" onclick="return confirmDelete();">Kill All Except Your Session</a>');
							}
						}
					</script>
					</li>
                  %endif%

%endif%
                </UL>
              </TD>
            </TR>

            <TR>
               <TD>
                  <TABLE class="tableView" width=100%>
                     %ifvar action equals('kill')%  %invoke wm.server.admin:killSession%
                        %ifvar message%
                            <script>
                                 if(is_csrf_guard_enabled && needToInsertToken) {
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										parent.topmenu.location.replace("top.dsp?message=%value -urlencode message%&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_ + "&webMethods-wM-AdminUI=true");
									}
									else {
										parent.topmenu.location.replace("top.dsp?message=%value -urlencode message%&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_);
									}
                                 } else {
                                    message = "%value message%";
									message=message.replace("Deleted session ","").trim();
									confirmSession();
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										parent.topmenu.location.replace("top.dsp?message=%value -urlencode message%&webMethods-wM-AdminUI=true");
									}
									else {
										parent.topmenu.location.replace("top.dsp?message=%value -urlencode message%");
									}
                                 }
                            </script>    
                        %endif%
                     %endinvoke%  %endif%

                     %invoke wm.server.query:getSessionList%
                     <TR>
                        <TD class="heading" colspan=8>Current Sessions</TD>
                     <TR>
                        <TH class="oddcol-l" scope="col">User</TH>
                        <TH class="oddcol" scope="col">From</TH>
                        <TH class="oddcol" scope="col">Stateful</TH>
                        <TH class="oddcol" scope="col">Requests</TH>
                        <TH class="oddcol" nowrap scope="col">Connect Time</TH>
                        <TH class="oddcol" nowrap scope="col">Last Request</TH>
                        <TH class="oddcol" nowrap scope="col">Session Expires</TH>
                        <TH class="oddcol" scope="col">Kill</TH>
                        <script>resetRows();</script>
                     </TR> %loop sessions%
                     <TR>
                        <script>writeTD('rowdata-l');</script>%value user%
                          %ifvar $index equals('0')%
                         <IMG src="icons/current_user.png" border=0>
						 %endif%</TD>
                        <script>writeTD('rowdata');</script>%value name%</TD>
                        <script>writeTD('rowdata');</script>%value stateful%</TD>
                        <script>writeTD('rowdata');</script>%value calls%</TD>
                        <script>writeTD('rowdata');</script>%value time% sec</TD>
                        <script>writeTD('rowdata');</script>%value last% sec</TD>
                        <script>writeTD('rowdata');</script><script>writeExpiredValue("%value expires%")</script></TD>
                        <script>writeTD('rowdata');</script>
                        %ifvar ../sessionMaskingStatus equals('1')%
                        	<IMG src="icons/delete_disabled.png" border=0>
                        %else%
                           %ifvar expires equals('never')%
                               <IMG src="icons/delete_disabled.png" border=0>
                           %else%
                               %ifvar expires equals('temporary')%
                                   <IMG src="icons/delete_disabled.png" border=0>
                               %else%
									<script>
									createForm("htmlform_server_cluster_kill_session_%value $index%", "server-cluster.dsp", "POST", "BODY");
									setFormProperty("htmlform_server_cluster_kill_session_%value $index%", "action", "kill");
									setFormProperty("htmlform_server_cluster_kill_session_%value $index%", "sessionID", "%value ssnid -urlencode%");
									</script>
									<script>
										if(is_csrf_guard_enabled && needToInsertToken) {
											document.write('<A class="imagelink" href="javascript:document.htmlform_server_cluster_kill_session_%value $index%.submit();"><IMG src="icons/delete.png" border=0 alt="Kill %value user% session"></A>');
										} else {
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<A class="imagelink" href="server-cluster.dsp?action=kill&sessionID=%value ssnid -urlencode%&webMethods-wM-AdminUI=true"><IMG src="icons/delete.png" border=0 alt="Kill %value user% session"></A>');
											}
											else {
												document.write('<A class="imagelink" href="server-cluster.dsp?action=kill&sessionID=%value ssnid -urlencode%"><IMG src="icons/delete.png" border=0 alt="Kill %value user% session"></A>');
											}
										}
									</script>
								   
                               %endif%
                           %endif%
                        %endif%
                        </TD>
                     </TR> <script>swapRows();</script>%endloop%
                  </TABLE> %endinvoke%  </TD>
            </TR>
            %endinvoke%
         </TABLE>
          <script>
		 if (currentSession != null && message != null &&  currentSession != "" && currentSession == message) {
					parent.document.getElementById('body').contentWindow.location.reload(true);
					parent.document.getElementById('top').contentWindow.location.reload(true);
		 } 
		 </script>
   </BODY>
</HTML>
