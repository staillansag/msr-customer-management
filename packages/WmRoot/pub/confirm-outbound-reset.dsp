<HTML>
  <HEAD>
    <TITLE>Integration Server -- Confirm Outbound Password Clearing</TITLE>

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
      function goAhead() {
        if ( confirm( "WARNING: This operation can not be undone!\nAre you sure you want to reset all outbound passwords?" ) ) {
          document.resetForm.action.value = "reset";
          document.resetForm.submit();
          return true;
        }
        return false;
      }
    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('confirm-outbound-reset.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ResetAllPasswordsScrn');">

    <FORM method="post" name="resetForm" action="security-outboundpw.dsp">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <INPUT type="hidden" name="action" value=""/>

      <TABLE width="100%">
        <TR>
          <TD class="breadcrumb" colspan="2"> Security &gt;
                                                        Outbound Passwords &gt;
                                                        Reset All Outbound Passwords
          </TD>
        </TR>

        <TR>
          <TD colspan="2">
            <UL>
			<li>
			
			<script>
						    createForm("htmlform_http_masterPwUpdate", "masterPwUpdate.dsp", "POST", "BODY");
           </script>			
			
			<script>getURL("masterPwUpdate.dsp", "javascript:document.htmlform_http_masterPwUpdate.submit();", "Return to Update Master Password");</script>
			
		  </li>
            </UL>
          </TD>
        </TR>
        <TR>
          <TD class="message" colspan="2">WARNING! This operation is NOT reversible</TD>
        </TR>
        <TR>
          <TD>
            <TABLE class="tableView" width="80%">
              <TR>
                <TD class="heading" colspan="2">Reset All Outbound Passwords</TD>
              </TR>
              <TR>
                <TD class="evenrow"></TD>
              </TR>
              <TR>
                <TD class="oddrowdata-l">
                  Perform this procedure only if your Integration Server
                  encrypts outbound passwords using Password-Based
                  Encryption (PBE) and you have lost your master password.
                  This procedure clears (blanks out) the stored outbound
                  passwords and resets the master password to the default value.
                </TD>
              <TR>
                <TD class="evenrow"></TD>
              </TR>
              <TR>
                <TD class="oddrowdata-l">
                  After you reset the passwords, the Integration Server will
                  no longer be able to connect to the applications/subsystems
                  for which the passwords are required. You must manually
                  re-enter the appropriate passwords for all
                  applications/subsystems on their respective configuration
                  screens in the Server Administrator. In addition, you
                  must reset the master password to be something other than
                  the default value.
                </TD>
              </TR>
              <TR>
                <TD class="action">
                  <INPUT class="data" type="button" value="Reset Passwords"
                         onclick="goAhead();"></INPUT>
                </TD>
              </TR>
      </TABLE>
    </FORM>

  </BODY>

</HTML>

