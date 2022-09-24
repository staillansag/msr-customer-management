
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
		
		function showSessions(form, webSocketURI, port) {
			form.webSocketURI.value = webSocketURI;
			form.port.value = port;
			form.submit();
			return false;
		}
		
		function refreshEndpoints() {
			if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlForm_refresh_websocket_endpoints", 'websocket-server-endpoints.dsp', "GET", "HEAD");
				setFormProperty("htmlForm_refresh_websocket_endpoints", "port", %value port encode(html)%);
				setFormProperty("htmlForm_refresh_websocket_endpoints", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlForm_refresh_websocket_endpoints.submit();
			} else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					document.location.replace( "websocket-server-endpoints.dsp?port=%value port encode(html)%&webMethods-wM-AdminUI=true");
				}
				else {
					document.location.replace( "websocket-server-endpoints.dsp?port=%value port encode(html)%");
				}
			}
		}
	  
    </SCRIPT>

  </HEAD>


  <body onLoad="setNavigation('websocket-server-endpoints.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_WebsockeServer_Endpoint_Scrn');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          WebSocket Server Endpoints
        </TD>
      </TR>
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
			<a href="" onclick="refreshEndpoints(); return false;">Refresh WebSocket Server Endpoints</a>
		  </li>		  
          </UL>
        </TD>
      </TR>
	  
	  
    <TR>
      <TD colspan="2">&nbsp;</TD>
    </TR>
    <TR>
        <TD>
          <TABLE class="tableView">
            <TR>
              <td class="heading" colspan="2">WebSocket - Registered Server Endpoints</td>
            </TR>

        %invoke wm.server.net.websocket:listSessionsByPort%
        %ifvar sessionsByURI -notempty%
            <TR>
              <TD span style="font-weight:bold" class="oddcol">WebSocket URI</TD>
              <TD span style="font-weight:bold" class="oddcol">Active Sessions</TD>
            </TR>
            %loop sessionsByURI%
            <TR>
              <script>writeTD("row");</script>%value webSocketURI encode(html)%</TD>

              <script>writeTD("row-l");</script>
			  <A HREF="javascript:showSessions(document.showSessions, '%value webSocketURI encode(javascript)%', '%value ../port encode(html)%');">
			    %value numSessions encode(html)%
              </A>
			  </TD>
              <script>swapRows();</script>
            </TR>
            %endloop%
		%else%
			<TR>
              <td span style="font-weight:bold" class="oddcol" colspan="2">No Active Sessions found for WebSocket Port %value port encode(html)%</td>
            </TR>
        %endif%
		%endinvoke%
          </TABLE>
        </TD>
      </TR>
	  
 </TABLE>
 
   	<form name="showSessions" action="websocket-server-sessions.dsp" method="POST">
   	%ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="webSocketURI">
	<input type="hidden" name="port">
    </form>
	
</body>
</HTML>

