%ifvar mode equals('edit')%
    %ifvar disableport equals('true')%
        %invoke wm.server.net.listeners:disableListener%
        %endinvoke%
    %endif%
%endif%

%invoke wm.server.net.listeners:getListener%

<html>
<head>
  	  <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <script src="webMethods.js"></script>
    <title>Integration Server -- Port Access Management</title>
    <script Language="JavaScript">
        var agent = navigator.userAgent.toLowerCase();
		var ie = (agent.indexOf("msie") != -1);
		var hiddenOptions = new Array();

        function setupData() {
            %ifvar port%
                document.properties.operation.value = "update";
                document.properties.oldPkg.value = "%value pkg encode(javascript)%";
            %else%
                document.properties.operation.value = "add";
            %endif%
            %ifvar listenerType equals('WebSocketSecure')%
                setupKeystoreData(document.properties);
            %endif%
        }

        function confirmDisable() {
            var enabled = "%value ../listening encode(javascript)%";
            if (enabled == "true") {
                if (confirm("Port must be disabled so that you can edit these settings.  Would you like to disable the port?")) {
                    if (is_csrf_guard_enabled && needToInsertToken) {
                        createForm("htmlForm_configWebSocket", 'configWebSocket.dsp', "POST", "HEAD");
                        setFormProperty("htmlForm_configWebSocket", "listenerKey", "%value listenerKey%");
                        setFormProperty("htmlForm_configWebSocket", "pkg", "%value pkg%");
                        %ifvar listenerType%
                            setFormProperty("htmlForm_configWebSocket", "listenerType", "%value listenerType%");
                        %endif%
                        setFormProperty("htmlForm_configWebSocket", "mode", "edit");
                        setFormProperty("htmlForm_configWebSocket", "disableport", "true");
                        setFormProperty("htmlForm_configWebSocket", _csrfTokenNm_, _csrfTokenVal_);
                        var htmlForm_configWebSocket = document.forms["htmlForm_configWebSocket"];
                        htmlForm_configWebSocket.submit();
                    } else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.location.replace("configWebSocket.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true&webMethods-wM-AdminUI=true");
						}
						else {
							document.location.replace("configWebSocket.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true");
						}
                    }
                }
            } else {
                if (is_csrf_guard_enabled && needToInsertToken) {
                    createForm("htmlForm_configWebSocket2", 'configWebSocket.dsp', "POST", "HEAD");
                    setFormProperty("htmlForm_configWebSocket2", "listenerKey", "%value listenerKey%");
                    setFormProperty("htmlForm_configWebSocket2", "pkg", "%value pkg%");
                    %ifvar listenerType%
                        setFormProperty("htmlForm_configWebSocket2", "listenerType", "%value listenerType%");
                    %endif%
                    setFormProperty("htmlForm_configWebSocket2", "mode", "edit");
                    setFormProperty("htmlForm_configWebSocket2", _csrfTokenNm_, _csrfTokenVal_);
                    var htmlForm_configWebSocket2 = document.forms["htmlForm_configWebSocket2"];
                    htmlForm_configWebSocket2.submit();
               } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.location.replace("configWebSocket.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&webMethods-wM-AdminUI=true");
					}
					else {
						document.location.replace("configWebSocket.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit");
					}
                }
            }
            return false;
        }

		function verify() {
		    var e = document.properties.port.value;
			if (( e != null ) && ( e != "" ) && !isblank(e)) {
			    for (count=0; count < e.length; count++) {
			        var sstr = e.substring(count,count+1);
			        var test = parseInt(sstr);
			        if (isNaN(test)) {
			            alert("Invalid Port " + e);
			            return (false);
                    }
                }
            }
	        document.properties.submit();
			return true;
        }

		function showEndpoints(form, port) {
		    form.port.value = port;
			form.submit();
			return false;
        }
    </script>
</head>
<body onLoad="setupData();setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_Edit_%ifvar listenerType equals('WebSocketSecure')%Websocketsecure%else%Websocket%endif%_Port_Scrn');">
<table width="100%">
    <tr>
        <td class="breadcrumb" colspan=2>
            Security &gt; Ports &gt;
            %ifvar ../mode equals('view')%
                %ifvar listenerType equals('WebSocketSecure')%
                    View WebSocket Secure Port Details
                %else%
                    View WebSocket Port Details
                %endif%
            %else%
                %ifvar listenerType equals('WebSocketSecure')%
                    Edit WebSocket Secure Port Configuration
                %else%
                    Edit WebSocket Port Configuration
                %endif%
            %endif%
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <ul>
                <li>
                    <script>createForm("htmlform_http_security_ports", "security-ports.dsp", "POST", "BODY"); </script>
                    <script>getURL("security-ports.dsp", "javascript:document.htmlform_http_security_ports.submit();", "Return to Ports");</script>
                </li>
                %ifvar ../mode equals('view')%
                    %ifvar listening equals('primary')%
                    %else%
                        <li>
                            <a onclick="return confirmDisable();" href="">
                                Edit WebSocket%ifvar listenerType equals('WebSocketSecure')%Secure%else%%endif% Port Configuration
                            </a>
                        </li>
                    %endif%
                %endif%
                %ifvar ../mode equals('view')%
                    <li><a href="javascript:showEndpoints(document.showEndpoints, '%value port encode(javascript)%');">WebSocket Server Endpoints</a></li>
                %endif%
            </ul>
        </td>
    </tr>
    <tr>
        <td>
            <form name="properties" action="security-ports.dsp" method="POST" onsubmit="return submit();">
                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                %ifvar listenerType equals('WebSocketSecure')%
                    <input type="hidden" name="factoryKey" value="webMethods/WebSocketSecure">
                %else%
                    <input type="hidden" name="factoryKey" value="webMethods/WebSocket">
                %endif%
                <input type="hidden" name="operation">
                <input type="hidden" name="listenerKey" value="%value listenerKey encode(htmlattr)%">
                <input type="hidden" name="listenerType" value="%value listenerType%">
                <input type="hidden" name="mode" value="%value ../mode%">
                <input type="hidden" name="oldPkg">
                <input type="hidden" name="formName" value="properties">
                <table class="tableView">
                    <tr>
                        <td class="heading" colspan="2">WebSocket Listener Configuration</td>
                    </tr>
                    %ifvar ../mode equals('edit')%
                        <tr>
                            <td class="evenrow">Enable</td>
                            <td class="evenrow-l">
                                <input type="radio" id="enable1" name="enable" value="yes"><label for="enable1">Yes</label></input>
                                <input type="radio" id="enable2" name="enable" value="no" checked><label for="enable2">No</label></input>
                            </td>
                        </tr>
                    %endif%
                    <tr>
                        <td class="evenrow"><label for="port">Port</label></td>
                        <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                            <script>writeEdit("%value mode encode(javascript)%", 'port', "%value port encode(html_javascript)%",'port');</script>
                        </td>
                    </tr>
                    <tr>
                        <td class="oddrow"><label for="portAlias">Alias</label></td>
                        <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                            %ifvar listenerKey -notempty%
                                %value portAlias encode(html)%
                            %else%
                                <input name="portAlias" id="portAlias" value="%value portAlias encode(htmlattr)%" size="60">
                            %endif%
                        </td>
                    </tr>
                    <tr>
                        <td class="evenrow"><label for="portDescription">Description (optional)</label></td>
                        <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                            %ifvar ../mode equals('view')%
                                %value portDescription encode(html)%
                            %else%
                            <input name="portDescription" id="portDescription" value="%value portDescription encode(htmlattr)%" size="60">
                            %endif%
                        </td>
                    </tr>
                    <tr>
                        <td class="oddrow"><label for="pkgName">Package Name</label></td>
                        <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                            %ifvar mode equals('view')%
                                %value pkg encode(html)%
                            %else%
                                %invoke wm.server.packages:packageList%
                                    <select id="pkgName" name="pkg">
                                        %loop packages%
                                            %ifvar enabled equals('false')%
                                            %else%
                                                %ifvar ../pkg -notempty%
                                                    <option size="15" width=30% %ifvar ../pkg vequals(name)%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                                                %else%
                                                    <option size="15" width=30% %ifvar name equals('WmRoot')%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                                                %endif%
                                            %endif%
                                        %endloop%
                                    </select>
                                %endinvoke%
                            %endif%
                        </td>
                    </tr>
                    <tr>
                        <td class="evenrow"><label for="bindAddress">Bind Address (optional)</label></td>
                        <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                            %ifvar ../mode equals('view')%
                                %value bindAddress encode(html)%
                            %else%
                                <input name="bindAddress" id="bindAddress" value="%value bindAddress encode(htmlattr)%">
                            %endif%
                        </td>
                    </tr>
                    <tr>
                        <td class="oddrow"><label for="maxQueue">Backlog</label></td>
                        <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                            %ifvar ../mode equals('view')%
                                %value maxQueue%
                            %else%
                                %ifvar maxQueue%
                                    <input id="maxQueue" name="maxQueue" value="%value maxQueue%">
                                %else%
                                    <input id="maxQueue" name="maxQueue" value="6000">
                                %endif%
                            %endif%
                        </td>
                    </tr>
                    <tr>
                        <td class="heading" colspan="2">
                            Threadpool Configuration
                        </td>
                    </tr>
                    <tbody>
                        %include configWebSocket-threadpool.dsp%
                    </tbody>
                    <tr>
                        <td class="heading" colspan="2">
                            WebSocket Policy
                        </td>
                    </tr>
                    <tr>
                        <td class="oddrow"><label for="idleTimeout">Idle Timeout(ms)</label></td>
                        <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                            %ifvar ../mode equals('view')%
                               %value idleTimeout%
                            %else%
                                %ifvar idleTimeout%
                                    <input id="idleTimeout" name="idleTimeout" value="%value idleTimeout%">
                                %else%
                                    <input id="idleTimeout" name="idleTimeout" value="300000">
                                %endif%
                            %endif%
                        </td>
                    </tr>
                    <tr>
                        <td class="heading" colspan="2">
                            Security Configuration
                        </td>
                    </tr>
                    <tr name="ClientAuthRow">
                        <td class="evenrow"><label for="clientAuth">Client Authentication</label></td>
                        <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                            %ifvar ../mode equals('view')%
                                %ifvar clientAuth equals('basic')%Username/Password%endif%
                            %else%
                                <select name="clientAuth" id="clientAuth">
                                    <option %ifvar clientAuth equals('basic')%selected %endif%value="basic">Username/Password</option>
                                </select>
                            %endif%
                        </td>
                    </tr>
                    %ifvar listenerType equals('WebSocketSecure')%
                        %include config-keystore-common.dsp%
                    %endif%
                    %ifvar mode equals('view')%
                    %else%
                        <tbody>
                            <tr>
                                <td colspan="2" class="action">
                                    <input type="button" value="Save Changes" onclick="submit();">
                                </td>
                            </tr>
                        </tbody>
                    %endif%
                </table>
            </form>
        </td>
    </tr>
</table>
<form name="showEndpoints" action="websocket-server-endpoints.dsp" method="POST">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="port">
</form>
</body>
</html>
%endinvoke%