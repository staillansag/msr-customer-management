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
    <TITLE>Integration Server -- Port Management</TITLE>
%ifvar listenerType matches('revinvoke*')%
    %include configHTTP-revinvoke.dsp%
%else%
 %ifvar listenerType equals('regularinternal')%
     %include configHTTP-internal.dsp%
 %else%

  %ifvar mode equals('edit')%
    %ifvar disableport equals('true')%
      %invoke wm.server.net.listeners:disableListener%
      %endinvoke%
    %endif%
  %endif%

%invoke wm.server.net.listeners:getListener%

    <SCRIPT Language="JavaScript">
        var agent = navigator.userAgent.toLowerCase();
        var ie = (agent.indexOf("msie") != -1);
        var hiddenOptions = new Array();

        function setupData() {
            %ifvar listenerKey -notempty%
            document.properties.operation.value = "update";
            document.properties.oldPkg.value = "%value pkg%";
            %else%
            document.properties.operation.value = "add";
            %endif%

            %ifvar ssl equals('true')%
                setupKeystoreData(document.properties);
            %endif%
        }


        function confirmDisable()
        {
          var enabled = "%value ../listening%";

          if(enabled == "primary")
          {
            alert("Port must be disabled to edit these settings.  Primary port cannot be disabled.  To edit these settings, please select a new primary port");
            return false;
          }
          else if(enabled == "true")
          {
            if(confirm("Port must be disabled so that you can edit these settings.  Would you like to disable the port?"))
            {
				if(is_csrf_guard_enabled && needToInsertToken) {
					  createForm("htmlForm_configHTTP", 'configHTTP.dsp', "POST", "HEAD");
					  setFormProperty("htmlForm_configHTTP", "listenerKey", "%value listenerKey%");
					  setFormProperty("htmlForm_configHTTP", "pkg", "%value pkg%");
					  %ifvar listenerType%
					  setFormProperty("htmlForm_configHTTP", "listenerType", "%value listenerType%");
					  %endif%
					  setFormProperty("htmlForm_configHTTP", "mode", "edit");
					  setFormProperty("htmlForm_configHTTP", "disableport", "true");
					  setFormProperty("htmlForm_configHTTP", _csrfTokenNm_, _csrfTokenVal_);
					  var htmlForm_configHTTP = document.forms["htmlForm_configHTTP"];
					  htmlForm_configHTTP.submit();
 			    } else {
 			    	var tempLoc = "configHTTP.dsp?listenerKey=%value encode(url) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(url) listenerType%%endif%&mode=edit&disableport=true";
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					  tempLoc = "configHTTP.dsp?listenerKey=%value encode(url) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(url) listenerType%%endif%&mode=edit&disableport=true&webMethods-wM-AdminUI=true";
					}
					document.location.replace(tempLoc);
				}
            }
          }
          else {
			  if(is_csrf_guard_enabled && needToInsertToken) {
				  createForm("htmlForm_configHTTP2", 'configHTTP.dsp', "POST", "HEAD");
				  setFormProperty("htmlForm_configHTTP2", "listenerKey", "%value listenerKey%");
				  setFormProperty("htmlForm_configHTTP2", "pkg", "%value pkg%");
				  %ifvar listenerType%
				  setFormProperty("htmlForm_configHTTP2", "listenerType", "%value listenerType%");
				  %endif%
				  setFormProperty("htmlForm_configHTTP2", "mode", "edit");
				  setFormProperty("htmlForm_configHTTP2", _csrfTokenNm_, _csrfTokenVal_);
				   
				  var htmlForm_configHTTP2 = document.forms["htmlForm_configHTTP2"];
				  htmlForm_configHTTP2.submit();
			  } else {
				  var tempLoc = "configHTTP.dsp?listenerKey=%value encode(url) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(url) listenerType%%endif%&mode=edit";
				  var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				      tempLoc = "configHTTP.dsp?listenerKey=%value encode(url) listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value encode(url) listenerType%%endif%&mode=edit&webMethods-wM-AdminUI=true";
				  }
				  document.location.replace(tempLoc);
			  }
			}
          return false;
        }
        function setListenerType(form, ltype) {
            form.listenerType.value = ltype;
            if (ltype == "diagnostic")
            {
            setThreadPool(form, 'enable');
            }
            return true;
        }


        function setThreadpool(checkId, bool) {
        if (bool==true){
            document.getElementById(checkId).value="true";
        }else{
            document.getElementById(checkId).value="false";
        }

     }

     function toggleThreadpool(checkId, spanId) {

        if (document.getElementById(checkId).value=="true"){
            elem = document.getElementById(spanId);
            rows = elem.rows;
            for(i = 0; i < rows.length; i++){
               if (ie) {
                 rows[i].style.display="block";
               }else{
                 rows[i].style.display="block";
                 rows[i].style.display="table-row";
               }
            }
            eEnable = document.getElementById(spanId+"enable");
            if(eEnable!=null){
                document.getElementById(spanId+"enable").style.display="none";
            }
        } else {
            elem = document.getElementById(spanId);
            rows = elem.rows;
            //length = rows.length;
            for(i = 0; i < rows.length; i++){
               rows[i].style.display="none";
            }
            eEnable = document.getElementById(spanId+"enable");
            if(eEnable!=null){
                document.getElementById(spanId+"enable").style.display="block";
                if (!ie) {
                    document.getElementById(spanId+"enable").style.display="table-row";
                }
            }
        }

      }


        function changeAction(form) {
            if(processKrbOnSubmit()) {
                form.action = "security-ports.dsp"
                return true;
            } else {
                return false;
            }
        }


    </SCRIPT>
    <base target="_self">
    <style>
      .listbox  { width: 100%; }
    </style>
  </HEAD>


  <body onLoad="setupData();setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_%ifvar listenerType equals('Diagnostic')%Diagnostic%endif%%ifvar ssl equals('true')%HTTPS%else%HTTP%endif%_PortConfigScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar ../mode equals('view')%
            View %ifvar ssl equals('true')%HTTPS%else%HTTP%endif% Port Details
          %else%
            Edit %ifvar ssl equals('true')%HTTPS%else%HTTP%endif% Port Configuration
          %endif% </TD>
      </TR>

      <TR>
        <TD colspan="2">
          <UL>
            <li>
			
			<script>
						    createForm("htmlform_http_security_ports", "security-ports.dsp", "POST" , "BODY");
           </script>			
			<script>getURL("security-ports.dsp", "javascript:document.htmlform_http_security_ports.submit();", "Return to Ports");</script>
			
		  </li>
            %ifvar ../mode equals('view')%
              %ifvar ../listening equals('primary')%
              %else%
                 %ifvar ../listening equals('quiesce')%
                 %else%
                    <LI><A onclick="return confirmDisable();" HREF="">
                      Edit %ifvar ssl equals('true')% HTTPS %else% HTTP %endif% Port Configuration
                    </a></li>
                %endif%
              %endif%
            %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE class="%ifvar ../mode equals('view')%tableView%else%tableView%endif%">
            <tr>
                <td class="heading" colspan="2">
                  %switch listenerType%
                    %case 'Regular'%Regular
                    %case 'revinvoke'%Proxy
                    %case 'revinvokeinternal'%Registration(P)
                    %case 'regularinternal'%Registration(I)
                    %case 'Diagnostic'%Diagnostic
                  %endswitch%
                  %ifvar ssl equals('true')%
                    HTTPS Listener Configuration
                  %else%
                    HTTP Listener Configuration
                  %endif%
                </td>
            </tr>
            <tr>

            <form onLoad="setupData();" name="properties" action="configHTTP.dsp" method="POST">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            <input type="hidden" name="factoryKey" value="webMethods/HTTP">
            <input type="hidden" name="operation">
            <input type="hidden" name="listenerKey" value="%value listenerKey%">
            <input type="hidden" name="serverType">
            <input type="hidden" name="oldPkg">
            <input type="hidden" name="listening" value="%value listening%">
            <input type="hidden" name="listenerType" value="%value listenerType%">
            <input type="hidden" name="ssl" value="%value ssl%">
            <input type="hidden" name="mode" value="%value mode%">
            <input type="hidden" name="certChain" value="%value certChain%">
            <input type="hidden" name="formName" value="properties">

            %ifvar listenerType%
                %ifvar ../mode equals('edit')%
                <tr>
                    <td class="evenrow">Enable</td>
                    <td class="evenrow-l">
					  <input type="radio" name="enable" id="enable1" value="yes" ><label for="enable1">Yes</label></input>
					  <input type="radio" name="enable" id="enable2" value="no" checked><label for="enable2">No</label></input>
                    </td>
                </tr>
                %endif%
               <tr>
                <TD class="oddrow"><label for="port">Port</label></TD>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
                    %value port%
                  %else%
                    <input name="port" id="port" value="%value port%">
                  %endif%
                </td>
            </tr>
            <tr>
                <TD class="evenrow"><label for="portAlias">Alias</label></TD>
                <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                  %ifvar listenerKey -notempty%
                    %value portAlias%
                  %else%
                    <input name="portAlias" id="portAlias" value="%value portAlias%" size="60">
                  %endif%
                </td>
            </tr>
            <tr>
                <TD class="oddrow" ><label for="portDescription">Description (optional)</label></TD>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
                    %value portDescription%
                  %else%
                    <input name="portDescription" id="portDescription"value="%value portDescription%" size="60">
                  %endif%
                </td>
            </tr>
            <tr>
                <TD class="evenrow"><label for="pkg">Package Name</label></TD>
                <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">%invoke wm.server.packages:packageList%
                %ifvar ../mode equals('view')%
                  %value pkg%
                %else%
                  %ifvar listenerType equals('Diagnostic')%
                      WmRoot
                      <input type="hidden" name="pkg" value="WmRoot">
                      <input type="hidden" name="threadPriority" value="10">
                  %else%
                  <select id="pkg" name="pkg">
                  %loop packages%
                      %ifvar enabled equals('false')%
                      %else%
                      %ifvar ../pkg -notempty%
                      <option %ifvar ../pkg vequals(name)%selected %endif%value="%value name%">%value name%</option>
                      %else%
                      <option %ifvar name equals('WmRoot')%selected %endif%value="%value name%">%value name%</option>
                      %endif%
                      %endif%
                  %endloop%
                  </select>
                  %endif%
                %endif%
              %endinvoke%
              </td>
            </tr>
 	          <tr>
                <TD class="oddrow"><label for="bindAddress">Bind Address (optional)</label></TD>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                        %ifvar ../mode equals('view')%
                  %value bindAddress%
                %else%
                    <input name="bindAddress" id="bindAddress" value="%value bindAddress%">
                %endif%
              </td>
            </tr>
          <tr>
             <TD class="evenrow"><label for="maxQueue">Backlog</label></TD>
             <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                        %ifvar ../mode equals('view')%
                  %value maxQueue%
                %else%
                  %ifvar maxQueue%
                    <input name="maxQueue" id="maxQueue" value="%value maxQueue%">
                  %else%
                    <input name="maxQueue" id="maxQueue" value="200">
                  %endif%
                %endif%
              </td>
          </tr>
          <tr>
             <TD class="oddrow"><label for="keepalive">Keep Alive Timeout</label></TD>
             <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                %ifvar ../mode equals('view')%
                    %value keepAliveTimeout%
                %else%
                  %ifvar keepAliveTimeout%
                    <input name="keepAliveTimeout" id="keepalive" value="%value keepAliveTimeout%">
                  %else%
                    <input name="keepAliveTimeout" id="keepalive" value="20000">
                  %endif%
                %endif%
              </td>
          </tr>
          %ifvar listenerType equals('revinvoke')%
          <tr>
             <td class="heading" colspan="2">Reverse Invoke Server</td>
           </tr>
            <tr>
              <td class="oddrow">Registration(P) Port</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                         %ifvar ../mode equals('view')%
                   %value internalPort%
                 %else%
                   <input name="internalPort" value="%value internalPort%">
                 %endif%
               </td>
            </tr>
          %endif%

          %ifvar listenerType equals('revinvokeinternal')%
          <tr>
             <td class="heading" colspan="2">Registration Reverse Invoke Server</td>
           </tr>
           <tr>
              <td class="oddrow">Proxy Port</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                         %ifvar ../mode equals('view')%
                   %value proxyPort%
                 %else%
                   <input name="proxyPort" value="%value proxyPort%">
                 %endif%
               </td>
            </tr>
          %endif%

          %ifvar listenerType equals('regularinternal')%
              <tr>
                <td class="heading" colspan="2">Registration Internal Server</td>
              </tr>
           <tr>
              <td class="oddrow">Proxy Host</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                         %ifvar ../mode equals('view')%
                   %value proxyHost%
                 %else%
                   <input name="proxyHost" value="%value proxyHost%">
                 %endif%
               </td>
            </tr>
              <tr>
                <td class="oddrow">Bind Address (optional)</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                        %ifvar ../mode equals('view')%
                  %value proxybindAddress%
                %else%
                    <input name="proxybindAddress" value="%value proxybindAddress%">
                %endif%
              </td>
            </tr>
           <tr>
              <td class="oddrow">Max Connections</td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                         %ifvar ../mode equals('view')%
                   %value maxConnections%
                 %else%
                   %ifvar maxConnections%
                     <input name="maxConnections" value="%value maxConnections%">
                   %else%
                     <input name="maxConnections" value="50">
                   %endif%
                 %endif%
               </td>
            </tr>
          %endif%

    %ifvar ../mode equals('view')%
    %else%
    <tr id="tpRIGenable">
      <td class="evenrow">Threadpool</td>
      <td class="evenrow-l">
     <a name="anchor_a" href="#anchor_b" onclick="setThreadpool('tpRIGon',true);toggleThreadpool('tpRIGon', 'tpRIG');"><u>Enable</u></a>
      </td>
    </tr>
    %endif%
 <tbody id="tpRIG">
    <tr>
      <td class="heading" colspan="2">Private Threadpool Configuration</td>
    <input id="tpRIGon" type="hidden" name="threadPool" value="%value threadPool%">
    </tr>
    %ifvar ../mode equals('view')%
    %else%
       <tr>
          <td class="evenrow">Threadpool</td>
          <td class="evenrow-l">
         <a href="#anchor_a" name="anchor_b" onclick="setThreadpool('tpRIGon',false);toggleThreadpool('tpRIGon', 'tpRIG');"><u>Disable</u></a>
          </td>
       </tr>
    %endif%
    %include configHTTP-threadpool.dsp%
</tbody>
    <SCRIPT>toggleThreadpool('tpRIGon', 'tpRIG');</SCRIPT>
    %include config-common-sec-properties.dsp%
          %ifvar ssl equals('true')%
          <!-- Include Common KeyStore section --->
          %include config-keystore-common.dsp%


        %endif%

            %ifvar mode equals('view')%
            %else%
            <tr>
                <td colspan="2" class="action">
                    <input type="submit" onClick="return changeAction(document.properties);" value="Save Changes">
                </td>
            </tr>
            %endif%

            %else%
            <td class="space" colspan="2">&nbsp;</td>
          </tr>
          <tr>
              <td class="heading" colspan="2">Select Type of Port to Configure</td>
          </tr>
          <tr>
               <td class="oddrow">Type</td>
               <td class="oddrow-1">
                  <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'Regular');">Regular</a><BR>
                  <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'revinvoke');">Reverse Invoke Proxy</a><BR>
                     %invoke wm.server.net.listeners:getServerType%
                     %ifvar serverType equals('proxy')%
                        <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'revinvokeinternal');">Proxy Registration</a><BR>
                     %else%
                        <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'regularinternal');">Internal Registration</a><BR>
                     %endif%
                     %endinvoke%
                    <a HREF="javascript:document.properties.submit();" onclick="return setListenerType(document.properties, 'Diagnostic');">Diagnostic</a>
                  </td>
               </tr>
            %endif%
          </form>
        </table>
      </td>
    </tr>
    </table>
  </body>
</html>
%endinvoke%

 %endif%
%endif%
