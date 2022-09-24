<HTML>
  <HEAD>
    <TITLE>Integration Server -- Outbound Password Management</TITLE>

    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css"></LINK>
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT type="text/javascript" SRC="webMethods.js"></SCRIPT>

    <SCRIPT type="text/javascript">
      function changeProps()
      {
        var newInt = document.propsForm.newInterval.value;
        document.propsForm.action.value = "updateInterval";
        document.propsForm.expireInterval.value = newInt;
        document.propsForm.submit();
        return true;
      }
    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('masterPwExpire.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UpdateExpirationScrn');">

    <FORM method="post" name="propsForm" action="security-outboundpw.dsp">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

      <TABLE width="100%">

        <INPUT type="hidden" name="action" value="%value action encode(htmlattr)%"/>
        <INPUT type="hidden" name="expireInterval" value="%value expireInterval encode(htmlattr)%"/>
        <INPUT type="hidden" name="interval" value=""/>

        <TR>
          <TD class="breadcrumb" colspan="2"> Security &gt; Outbound Passwords &gt; Update Expiration Interval</TD>
        </TR>

        %invoke wm.server.internalOutboundPasswords:getMasterPasswordProperties%
          %rename expireInterval interval -copy%
          %onerror%
            %ifvar errorMessage%
              <TR><TD colspan="2">&nbsp;</TD></TR>
              <TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
            %endif%
        %endinvoke%

        %invoke wm.server.internalOutboundPasswords:getMasterExpireMessage%
          %ifvar expireMessage%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value expireMessage encode(html)%</TD></TR>
          %endif%
        %endinvoke%

        %ifvar message%
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%

        <TR>
          <TD colspan="2">
            <UL class="listitems">
			<script>
			createForm("htmlform_security_outboundpw", "security-outboundpw.dsp", "POST", "BODY");
			</script>
              <li>
			  <script>getURL("security-outboundpw.dsp","javascript:document.htmlform_security_outboundpw.submit();","Return to Outbound Passwords");</script></li>
            </UL>
          </TD
        </TR>

        <TR>
          <TD>
            <TABLE class="tableView" width="60%">
              <TR>
                <TD class="heading" colspan=2>Master Password Expiration Interval</TD>
              </TR>
              <script>resetRows();</script>
              <TR>
                <TD class="evenrow"><label for="interval">Expiration Interval (in days)</label></TD>
                <TD class="evenrow-l">
                  <INPUT type="text" name="newInterval" id="interval" SIZE="4"
                         value="%value interval encode(htmlattr)%"/></TD>
              </TR>
              <TR>
                <TD class="action" colspan=2>
                  <INPUT class="data" type="submit" value="Save Changes"
                         name="ok" onClick="return changeProps();"/>
                </TD>
              </TR>
            </TABLE>
          </TD>
        </TR>

      </TABLE>
    </FORM>

  </BODY>

</HTML>

