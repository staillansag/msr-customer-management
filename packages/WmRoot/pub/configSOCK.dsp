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
                   createForm("htmlForm_configSOCK", 'configSOCK.dsp', "POST", "HEAD");	
				   
				   setFormProperty("htmlForm_configSOCK", "listenerKey", "%value listenerKey%");
				   setFormProperty("htmlForm_configSOCK", "pkg", "%value pkg%");
				   %ifvar listenerType%
				   setFormProperty("htmlForm_configSOCK", "listenerType", "%value listenerType%");
				   %endif%
				   setFormProperty("htmlForm_configSOCK", "mode", "edit");
				   setFormProperty("htmlForm_configSOCK", "disableport", "true");
				
				   setFormProperty("htmlForm_configSOCK", _csrfTokenNm_, _csrfTokenVal_);
					var htmlForm_configSOCK = document.forms["htmlForm_configSOCK"];
					htmlForm_configSOCK.submit();
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.location.replace("configSOCK.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true&webMethods-wM-AdminUI=true");
					}
					else {
						document.location.replace("configSOCK.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true");
					}
				}
				   
            }
          }
          else {
			    if(is_csrf_guard_enabled && needToInsertToken) {
                   createForm("htmlForm_configSOCK2", 'configSOCK.dsp', "POST", "HEAD");
				   setFormProperty("htmlForm_configSOCK2", "listenerKey", "%value listenerKey%");
				   setFormProperty("htmlForm_configSOCK2", "pkg", "%value pkg%");
				   %ifvar listenerType%
				   setFormProperty("htmlForm_configSOCK2", "listenerType", "%value listenerType%");
				   %endif%
				   setFormProperty("htmlForm_configSOCK2", "mode", "edit");
				   
				   setFormProperty("htmlForm_configSOCK2", _csrfTokenNm_, _csrfTokenVal_);
					var htmlForm_configSOCK2 = document.forms["htmlForm_configSOCK2"];
					htmlForm_configSOCK2.submit();
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.location.replace("configSOCK.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&webMethods-wM-AdminUI=true");
					}
					else {
						document.location.replace("configSOCK.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit");
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
    </SCRIPT>

  </HEAD>


  <body onLoad="setupData();setNavigation('security-ports.dsp', 'doc/OnlineHelp/WmRoot.htm#CS_Security_Ports_EditSOCK.htm', 'foo');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar ../mode equals('view')%
            View Socket Listener Details
          %else%
            Edit Socket Listener Configuration
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
              %ifvar ../listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit Socket Listener Configuration
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
            <TD class="heading" colspan="2">Socket Listener Configuration</TD>
        <tr>

        <form onLoad="setupData();" name="properties" action="security-ports.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="factoryKey" value="webMethods/SOCK">
        <input type="hidden" name="operation">
        <input type="hidden" name="listenerKey" value="%value listenerKey encode(htmlattr)%">
        <input type="hidden" name="oldPkg">
        %ifvar listenerType%
          <input type="hidden" name="listenerType" value="%value listenerType encode(htmlattr)%">
        %endif%

            <td class="oddrow">Port</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar ../mode equals('view')%
                %value port encode(html)%
              %else%
                <input name="port" value="%value port encode(htmlattr)%">
              %endif%
            </td>
        </tr>
        <tr>
            <td class="evenrow">Package Name</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar ../mode equals('view')%
                %value pkg encode(html)%
              %else%
                %invoke wm.server.packages:packageList%
                <select name="pkg">
                %loop packages%
                    %ifvar enabled equals('false')%
                    %else%
                    %ifvar ../pkg -notempty%
                    <option %ifvar ../pkg vequals(name)%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %else%
                    <option %ifvar name equals('WmRoot')%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %endif%
                    %endif%
                %endloop%
                </select>
                %endinvoke%
              %endif%
            </td>
        </tr>
        <tr>
                <td class="oddrow">Bind Address (optional)</td>
                <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                %ifvar ../mode equals('view')%
                  %value bindAddress encode(html)%
                %else%
                    <input name="bindAddress" value="%value bindAddress encode(htmlattr)%">
                %endif%
              </td>
        </tr>


        %ifvar mode equals('view')%
        %else%
          <tr>
              <td colspan="2" class="action">
                  <input type="submit" value="Save Changes">
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
