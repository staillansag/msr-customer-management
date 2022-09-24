%ifvar operation equals('addNewProvider')%
    %invoke wm.server.net.listeners:addSecurityProvider%
    %endinvoke%
%endif%

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

  <BODY onLoad="setNavigation('security-keystoremgt.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_SecurityProviderAdd', 'foo');">
    <TABLE width="100%">

    <TR>
      <TD class="breadcrumb" colspan=2>
        Security &gt;
        Keystore &gt;
        Add Security Provider 
      </TD>
    </TR>
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
    %endif%

    <TR><TD colspan="2">
    <UL class="listitems">
	
	<script>
				createForm("htmlform_http_security_keystoremgt", "security-keystoremgt.dsp", "POST", "BODY");
    </script>
	
	<li>
	<script>getURL("security-keystoremgt.dsp","javascript:document.htmlform_http_security_keystoremgt.submit();","Return to Keystore");</script>
	</li>
    </UL>

    </TD>
    </TR>
    <TR>
      <TD>
        <TABLE class="tableView">

        <tr>
          <td class="heading" colspan="2">Add Security Provider</td>
        </tr>
        <form name="addsecprov" action="add-javasecurity-provider.dsp" method="post">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation" value="addNewProvider">
        <tr>
            <td class="oddrow"><label for="keyStoreProviderClass">Security Provider Class</label></td>
            <td class="oddrow-l">
	    	<input type="text" id="keyStoreProviderClass" name="keyStoreProviderClass" value="%value keyStoreProviderClass encode(html_javascript)%">
            </td>
        </tr>
        <tr>
            <td class="action" colspan="2"><input type="submit" value="Add Provider"></td>
        </tr>

        </form>
      </TABLE>
    </TD>
  </TR>
</TABLE>
</BODY>
</HTML>
