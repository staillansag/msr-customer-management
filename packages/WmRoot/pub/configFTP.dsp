%ifvar mode equals('edit')%
  %ifvar disableport equals('true')%
    %invoke wm.server.net.listeners:disableListener%
    %endinvoke%
  %endif%
%endif%


%invoke wm.server.net.listeners:getListener%

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

    <SCRIPT Language="JavaScript">
        function confirmDisable()
        {
          var enabled = "%value ../listening encode(javascript)%";

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
			   
                   createForm("htmlForm_configFTP", 'configFTP.dsp', "POST", "HEAD");	
				   setFormProperty("htmlForm_configFTP", "listenerKey", "%value listenerKey%");
				   setFormProperty("htmlForm_configFTP", "pkg", "%value pkg%");
				   %ifvar listenerType%
				   setFormProperty("htmlForm_configFTP", "listenerType", "%value listenerType%");
				   %endif%
				   setFormProperty("htmlForm_configFTP", "mode", "edit");
				   setFormProperty("htmlForm_configFTP", "disableport", "true");
				   setFormProperty("htmlForm_configFTP", _csrfTokenNm_, _csrfTokenVal_);
			 	   var htmlForm_configFTP = document.forms["htmlForm_configFTP"];
				   htmlForm_configFTP.submit();
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				    	document.location.replace("configFTP.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true&webMethods-wM-AdminUI=true");
					}
					else {
				    	document.location.replace("configFTP.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true");
					}
				}
				   
            }
          }
          else {
			  if(is_csrf_guard_enabled && needToInsertToken) {
                   createForm("htmlForm_configFTP2", 'configFTP.dsp', "POST", "HEAD");
			       setFormProperty("htmlForm_configFTP2", "listenerKey", "%value listenerKey%");
				   setFormProperty("htmlForm_configFTP2", "pkg", "%value pkg%");
				   %ifvar listenerType%
				   setFormProperty("htmlForm_configFTP2", "listenerType", "%value listenerType%");
				   %endif%
				   setFormProperty("htmlForm_configFTP2", "mode", "edit");
				   
				   setFormProperty("htmlForm_configFTP2", _csrfTokenNm_, _csrfTokenVal_);
				   var htmlForm_configFTP2 = document.forms["htmlForm_configFTP2"];
				   htmlForm_configFTP2.submit();
				   
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				    	document.location.replace("configFTP.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&webMethods-wM-AdminUI=true");
					}
					else {
				    	document.location.replace("configFTP.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit");
					}
				}
				   
          }

          return false;
        }

        function setupData() {
            %ifvar port%
            document.properties.operation.value = "update";
            document.properties.oldPkg.value = "%value pkg encode(javascript)%";
            %else%
            document.properties.operation.value = "add";
            %endif%

        }

      function verify() {

        var e = document.properties.port.value;
        if (( e != null ) && ( e != "" ) && !isblank(e)) {

          for (count=0; count<e.length; count++){
            var sstr = e.substring(count,count+1);
            var test = parseInt(sstr);
            if (isNaN(test)) {
              alert("Invalid Port "+e);
              return (false);
            }
          }

        }

        document.properties.submit();
        return (true);

      }



    </SCRIPT>

  </HEAD>


  <body onLoad="setupData();setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_FTP_PortConfigScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar ../mode equals('view')%
            View FTP Port Details
          %else%
            Edit FTP Port Configuration
          %endif%
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
            %ifvar ../mode equals('view')%
              %ifvar listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit FTP Port Configuration
                </a></li>
              %endif%
            %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE class="%ifvar ../mode equals('view')%tableView%else%tableView%endif%">
          <tr>
              <td class="heading" colspan="2">FTP Listener Configuration</td>
          <tr>

          <form name="properties" action="security-ports.dsp" method="POST" onsubmit="return submit();">
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          <input type="hidden" name="factoryKey" value="webMethods/FTP">
          <input type="hidden" name="operation">
          <input type="hidden" name="listenerKey" value="%value listenerKey encode(htmlattr)%">
          <input type="hidden" name="oldPkg">
              %ifvar ../mode equals('edit')%
                <tr>
                    <td class="evenrow">Enable</td>
                    <td class="evenrow-l">
					  <input type="radio" name="enable" id="enable1"  value="yes" ><label for="enable1">Yes</label></input>
					  <input type="radio" name="enable" id="enable2"  value="no" checked><label for="enable2">No</label></input>
                    </td>
                </tr>
              %endif%         
              <td class="oddrow"><label for="port">Port</label></td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                <script>writeEdit("%value mode encode(javascript)%", 'port', "%value port encode(html_javascript)%",'port');</script>
              </td>
          </tr>
                      <tr>
                <td class="evenrow"><label for="portAlias">Alias</label></td>
                <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                  %ifvar listenerKey -notempty%
                    %value portAlias encode(html)% 
                  %else%
                    <input name="portAlias" id="portAlias" value="%value portAlias encode(htmlattr)%" size="60">
                  %endif%
                </td>
            </tr>
            <tr>
                <td class="oddrow"><label for="portDescription">Description (optional)</label></td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
                    %value portDescription encode(html)%
                  %else%
                    <input name="portDescription" id="portDescription" value="%value portDescription encode(htmlattr)%" size="60">
                  %endif%
                </td>
            </tr>

          <tr>
              <td class="evenrow"><label for="pkg">Package Name</label></td>
              <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                %ifvar mode equals('view')%
                  %value pkg encode(html)%
                %else%
                  %invoke wm.server.packages:packageList%
                  <select id="pkg" name="pkg">
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
                <td class="oddrow"><label for="bindAddress">Bind Address (optional)</label></td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                %ifvar ../mode equals('view')%
                  %value bindAddress encode(html)%
                %else%
                    <input id="bindAddress" name="bindAddress" value="%value bindAddress encode(htmlattr)%">
                %endif%
              </td>
           </tr>

	<tr>
	       <td class="evenrow"><label for="pasvAddr">Passive Mode Listen Address (optional)</label></td>
	       <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
	  		%ifvar ../mode equals('view')%
	                     %value pasvAddr encode(html)%
	                %else%
	                       <input id="pasvAddr" name="pasvAddr" value="%value pasvAddr encode(htmlattr)%">
	                %endif%
	       </td>
           </tr>
          %ifvar mode equals('view')%
          %else%
          <tr>
              <td colspan="2" class="action">
            <input type="button" value="Save Changes" onclick="submit();">
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
