
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
    <script SRC="webMethods.js"></SCRIPT>
	<script src="csrf-guard.js"></script>
    <TITLE>Integration Server -- WebSocket Session Management</TITLE>

    <SCRIPT Language="JavaScript">
	    var agent = navigator.userAgent.toLowerCase();
        var ie = (agent.indexOf("msie") != -1);
        var hiddenOptions = new Array();
		
		var sessionIdArray = new Array();
		
		function emptySessionIdArray() {
			sessionIdArray = new Array();
		}
		
		function addSessionId(sessionId) {
			var index = sessionIdArray.indexOf(sessionId);
			if (index == -1) {
				sessionIdArray.push(sessionId);
			}
		}
		
		function deleteSessionId(sessionId)
		{
			var index = sessionIdArray.indexOf(sessionId);
			if (index > -1) {
				sessionIdArray.splice(index, 1);
			}
		}
		
		function populateSessionIds() {
			var tempSessionIds="";
			for(var i=0; i<sessionIdArray.length; i++) {
                if(tempSessionIds=="") {
					tempSessionIds+=sessionIdArray[i];
				} else {
					tempSessionIds = tempSessionIds + ",";
					tempSessionIds+=sessionIdArray[i];
				}
            }
			
			var sessionIds = document.getElementById('sessionIds');
			sessionIds.value = tempSessionIds;
		}
		
		function setOperation(operationValue) {
			var operation = document.getElementById('operation');
			operation.value = operationValue;
		}
		
		function toggleCheckbox(element)
		{
			if(element.checked) {
			  element.checked = true;
			  addSessionId(element.id);
			} else {
			  element.checked = false;
			  deleteSessionId(element.id);
			}
			
			if(sessionIdArray.length > 0) {
				enableSessionButtons();
			} else {
				disableSessionButtons();
			}
			
		}

		function checkAll() {
			var parent = document.getElementById("parent");
			var child = document.getElementsByName('child');
			var action;
			for (var i = 0; i < child.length; i++) {
				child[i].checked = parent.checked;
				if(child[i].checked) {
					addSessionId(child[i].id);
					action="enable";
				} else {
					deleteSessionId(child[i].id);
					action="disable";
				}
			}
			
			if(sessionIdArray.length > 0) {
				enableSessionButtons();
			} else {
				disableSessionButtons();
			}
			
		}
		
		function enableSessionButtons() {
			var button = document.getElementsByName('sessionButton');
			for (var i = 0; i < button.length; i++) {
			    button[i].disabled = false;
			}
		}
		
		function disableSessionButtons() {
			var button = document.getElementsByName('sessionButton');
			for (var i = 0; i < button.length; i++) {
			    button[i].disabled = true;
			}
		}
		
		function refreshSessions() {
			if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlForm_refresh_websocket_sessions", 'websocket-server-sessions.dsp', "GET", "HEAD");
				setFormProperty("htmlForm_refresh_websocket_sessions", "webSocketURI", "%value webSocketURI encode(javascript)%");
				setFormProperty("htmlForm_refresh_websocket_sessions", "port", "%value port encode(html)%");
				setFormProperty("htmlForm_refresh_websocket_sessions", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlForm_refresh_websocket_sessions.submit();
			} else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					document.location.replace( "websocket-server-sessions.dsp?webSocketURI=%value webSocketURI encode(javascript)%&port=%value port encode(html)%&webMethods-wM-AdminUI=true");
				}
				else {
					document.location.replace( "websocket-server-sessions.dsp?webSocketURI=%value webSocketURI encode(javascript)%&port=%value port encode(html)%");
				}
			}
		}

    </SCRIPT>

  </HEAD>


  <body onLoad="emptySessionIdArray(); setNavigation('websocket-server-sessions.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_WebsockeServer_Endpoint_Scrn');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          WebSocket Server Sessions
        </TD>
      </TR>
	  
%ifvar operation%
%switch operation%
%case 'suspend'%
  %invoke wm.server.net.websocket:suspendSession%
        %ifvar message%
          <tr><td colspan="3">&nbsp;</td></tr>
          <TR><TD class="message" colspan="3">%value message%</TD></TR>
        %endif%
  %onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
  %endinvoke%
%case 'resume'%
  %invoke wm.server.net.websocket:resumeSession%
        %ifvar message%
          <tr><td colspan="3">&nbsp;</td></tr>
          <TR><TD class="message" colspan="3">%value message%</TD></TR>
        %endif%
  %onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
  %endinvoke%
%case 'close'%
  %invoke wm.server.net.websocket:closeSession%
        %ifvar message%
          <tr><td colspan="3">&nbsp;</td></tr>
          <TR><TD class="message" colspan="3">%value message%</TD></TR>
        %endif%
  %onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
  %endinvoke%
%case 'disconnect'%
  %invoke wm.server.net.websocket:disconnectSession%
        %ifvar message%
		  <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage%</td></tr>
	%endinvoke%
%endswitch%
%endif%
	  
      <TR>
        <TD colspan="2">
          <UL>
            <li>
			
			<script>
			createForm("htmlform_http_security_ports", "security-ports.dsp", "POST", "BODY");
            </script>			
			<script>getURL("security-ports.dsp", "javascript:document.htmlform_http_security_ports.submit();", "Return to Ports");</script>
			
		  </li>
          <li>
			<a href="" onclick="refreshSessions(); return false;">Refresh WebSocket Sessions</a>
		  </li>
          </UL>
        </TD>
      </TR>
	  
	  
    <TR>
      <TD colspan="2">&nbsp;</TD>
    </TR>
    
	
	<TR>
        <TD>
		
          <FORM name="operationForm" action="websocket-server-sessions.dsp" method="POST">
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          <INPUT type="hidden" Id="sessionIds" name="sessionIds" value="">
		  <INPUT type="hidden" Id="operation" name="operation" value="">
		  <INPUT type="hidden" Id="webSocketURI" name="webSocketURI" value="%value -urldecode webSocketURI%">
		  <INPUT type="hidden" Id="port" name="port" value="%value port%">
		  
          <TABLE class="tableView">
            <TR>
              <td class="heading" colspan="8">Active WebSocket Sessions - %value -urldecode webSocketURI%</td>
            </TR>
            
			%invoke wm.server.net.websocket:listSessionsByURI%
            %ifvar sessions -notempty%			
            <TR>
			  <TD> <input type="checkbox" id="parent" onclick="checkAll();"/> </TD>
			  <TD span style="font-weight:bold" class="oddcol">Session Id</TD>
              <TD span style="font-weight:bold" class="oddcol">Local Address</TD>
              <TD span style="font-weight:bold" class="oddcol">Remote Address</TD>
			  <TD span style="font-weight:bold" class="oddcol">Protocol Version</TD>
			  <TD span style="font-weight:bold" class="oddcol">Idle Timeout</TD>
			  <TD span style="font-weight:bold" class="oddcol">Secure</TD>
			  <!--<TD span style="font-weight:bold" class="oddcol">Suspended</TD>-->
            </TR>
              %loop sessions%
			  <TR>
                <script>writeTD("row");</script> <input type="checkbox" name="child" id="%value sessionId encode(html)%" onclick="toggleCheckbox(this);"/> </TD>
                <script>writeTD("row");</script>%value sessionId encode(html)%</TD>
                <script>writeTD("row");</script>%value localAddress encode(html)%</TD>
			    <script>writeTD("row");</script>%value remoteAddress encode(html)%</TD>
			    <script>writeTD("row");</script>%value protocolVersion encode(html)%</TD>
			    <script>writeTD("row");</script>%value idleTimeOut encode(html)%</TD>
			    <script>writeTD("row");</script>%value isSecure encode(html)%</TD>
				<!--<script>writeTD("row");</script>%value isSuspended encode(html)%</TD>-->
				<script>swapRows();</script>
			  </TR>
              %endloop%
			%else%
			<TR>
              <td span style="font-weight:bold" class="oddcol" colspan="7">No Active WebSocket Sessions found for WebSocket Endpoint URI %value -urldecode webSocketURI%</td>
            </TR>
            %endif%
			%endinvoke%
			
          </TABLE>
		  <TABLE class="tableView">
		  <TR>
            <td class="rowdata">
			<!--<INPUT TYPE="button" disabled name="sessionButton" Id="suspend" VALUE="Suspend" ONCLICK="populateSessionIds(); setOperation('suspend'); document.operationForm.submit();"></INPUT>-->
			<!--<INPUT TYPE="button" disabled name="sessionButton" Id="resume" VALUE="Resume" ONCLICK="populateSessionIds(); setOperation('resume'); document.operationForm.submit();"></INPUT>-->
			<INPUT TYPE="button" disabled name="sessionButton" Id="close" VALUE="Close" ONCLICK="populateSessionIds(); setOperation('close'); document.operationForm.submit();"></INPUT>
			<INPUT TYPE="button" disabled name="sessionButton" Id="disconnect" VALUE="Disconnect" ONCLICK="populateSessionIds(); setOperation('disconnect'); document.operationForm.submit();"></INPUT>
			</td>
		  </TR>
		  </TABLE>
		  </FORM>
        </TD>
      </TR>
	  
 </TABLE>
</body>
</HTML>

