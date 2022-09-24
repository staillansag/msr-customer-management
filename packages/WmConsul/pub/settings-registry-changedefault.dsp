<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css">
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <TITLE>Integration Server -- Port Access Management</TITLE>
  </HEAD>

  <BODY onLoad="setNavigation('security-ports.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ChgPrimaryConsulSvrScrn');">

    <TABLE width="100%">

    <TR>
      <TD class="breadcrumb" colspan=2>
         Microservice Consul Registry Servers &gt;
        Change Default Alias
      </TD>
    </TR>
    <TR><TD colspan="2">
    <ul class="listitems">
        <li class="listitem"><a href="settings-registry.dsp">Return to Microservice Registry Servers List</a></li>

    </TD>
    </TR>

    <TR>
      <TD>
        <TABLE class="tableView" width="50%">

        <tr>
          <td class="heading" colspan="2">Select New Default Alias</td>
        </tr>
        <form name="primary" action="settings-registry.dsp" method="post">
        <input type="hidden" name="operation" value="setDefault">
        <tr>
            <td class="oddrow" width="50%">Default Alias</td>
            <td class="oddrow-l">
                %invoke wm.server.consul.util:serverList%
            	<select name="alias">
				%loop -struct servers%
				%scope #$key%
                  <option value="%value alias encode(html)%" %ifvar default equals('yes')%selected%endif%>
                      %value alias encode(html)%  (%value type encode(html)%)
                    </option>
                 %endscope%
                 %endloop%
                </select>
                %endinvoke%
            </td>
        </tr>
        <tr>
            <td class="action" colspan="2"><input type="submit" value="Update"></td>
        </tr>

        </form>
      </TABLE>
    </TD>
  </TR>
</TABLE>
</BODY>
</HTML>
