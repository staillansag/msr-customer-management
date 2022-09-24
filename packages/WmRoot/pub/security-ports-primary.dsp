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

  <BODY onLoad="setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ChgPrimaryPortScrn');">

    <TABLE width="100%">

    <TR>
      <TD class="breadcrumb" colspan=2>
        Security &gt;
        Ports &gt;
        Change Primary Port
      </TD>
    </TR>
    <TR><TD colspan="2">
    <ul class="listitems">
	<script>
	createForm("htmlform_security_ports", "security-ports.dsp", "POST", "BODY");
	</script>
	<li>
	<script>getURL("security-ports.dsp", "javascript:document.htmlform_security_ports.submit();", "Return to Ports");</script>
	</li></UL>

    </TD>
    </TR>

    <TR>
      <TD>
        <TABLE class="tableView">

        <tr>
          <td class="heading" colspan="2">Select New Primary Port</td>
        </tr>
        <form name="primary" action="security-ports.dsp" method="post">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation" value="setPrimary">
        <tr>
            <td class="oddrow"><label for="primary">Primary Port</label></td>
            <td class="oddrow-l">
                %invoke wm.server.ports:listListeners%
                <select name="primaryListener" id="primary">
                %loop listeners%
                %ifvar matches('HTTP*') protocol%
                %ifvar equals('true') enabled%
                %ifvar equals('WmRoot') pkg%
          %ifvar equals('Regular') listenerType%
                    <option value="%value key encode(htmlattr)%" %ifvar primary equals('true')%selected%endif%>
                      %value portAlias encode(html)%(%value port encode(html)%)
                    </option>
          %endif%
                %endif%
                %endif%
                %endif%
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
