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
	
  </HEAD>

  <BODY onload="document.addListener.factoryKey[0].checked = true;setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddPortScrn');">
    
	<TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          Add Port</TD>
      </TR>
      <TR><TD colspan="2">
      <ul class="listitems">
	  <script>
	  createForm("htmlform_security_ports", "security-ports.dsp", "POST", "BODY");
	  </script>
      <li>
	  <script>getURL("security-ports.dsp", "javascript:document.htmlform_security_ports.submit();", "Return to Ports");</script>
	  </li>

      </UL>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE class="tableView">
            <TR>
              <TD class="heading" colspan="2">Select Type of Port to Configure</TD>
            </TR>
              <form name="addListener" action="security-ports.dsp" method="POST">
              %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
              <input type="hidden" name="operation" value="create">
              <input type="hidden" name="action" value="edit">
              <input type="hidden" name="mode" value="edit">
              <input type="hidden" name="listenerType" value="Regular">
            <tr>
                <td class="oddrow">Type</td>
                <td class="oddrow-l">
                    %invoke wm.server.net.listeners:listAllFactories%
                        %loop factories%
                            %switch name%
                              %case 'webMethods/HTTP'%
								<input type="radio" name="factoryKey" id="%value name encode(html)%" value="%value key encode(htmlattr)%" onclick="document.addListener.listenerType.value='Regular';"><label for="%value name encode(html)%">%value name encode(html)%</label></input><BR>
                              %case 'webMethods/HTTPS'%
								<input type="radio" name="factoryKey" id="factoryKey2" value="%value key encode(htmlattr)%" onclick="document.addListener.listenerType.value='Regular';"><label for="factoryKey2">%value name encode(html)%</label></input><BR>
                              %case 'HTTP Diagnostic'%  
							   <input type="radio" name="factoryKey" id="factoryKey3" value="%value key encode(htmlattr)%" onclick="document.addListener.listenerType.value='Diagnostic';"><label for="factoryKey3">HTTP Diagnostic</label></input><BR>
                              %case 'HTTPS Diagnostic'% 
							   <input type="radio" name="factoryKey" id="factoryKey4" value="%value key encode(htmlattr)%" onclick="document.addListener.listenerType.value='Diagnostic';"><label for="factoryKey4">HTTPS Diagnostic</label></input><BR> 
                              %case 'Enterprise Gateway Server'%    
							   <input type="radio" name="factoryKey" id="factoryKey5" value="%value key encode(htmlattr)%" onclick="document.addListener.listenerType.value='revinvoke';"><label for="factoryKey5">Enterprise Gateway Server</label></input><BR>
                              %case 'Internal Server'%  
							   <input type="radio" name="factoryKey" id="factoryKey6" value="%value key encode(htmlattr)%" onclick="document.addListener.listenerType.value='regularinternal';"><label for="factoryKey6">Internal Server</label></input><BR> 
                              %case 'webMethods/WebSocket'%  
                               <input type="radio" name="factoryKey" value="%value key encode(htmlattr)%" onclick="document.addListener.listenerType.value='WebSocket';">%value name encode(html)%</input><BR>
                              %case 'webMethods/WebSocketSecure'%
                               <input type="radio" name="factoryKey" value="%value key encode(htmlattr)%" onclick="document.addListener.listenerType.value='WebSocketSecure';">%value name encode(html)%</input><BR>
                              %case%
								<input type="radio" name="factoryKey" id="%value key encode(htmlattr)%" value="%value key encode(htmlattr)%"><label for="%value key encode(htmlattr)%">%value key encode(html)%</label></input><BR>
                            %endswitch%
                        %endloop%
                    %endinvoke%
                </td>
            </tr>
			
            <tr>
                <td colspan="2" class="action"><input type="submit" value="Submit"></td>
            </tr>
            </form>
          </table>
        </td>
      </tr>
    </table>
	
  </body>
  </html>
