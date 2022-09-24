<HTML>
  <HEAD>

    <TITLE>Integration Server - Outbound Password Master Password</TITLE>

    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css"></LINK>
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT type="text/javascript" SRC="webMethods.js"></SCRIPT>

    <SCRIPT>

      function checkPasses(protocol, local)
      {
        if ( !local && protocol == 'HTTP' ) {
          var msg = "Warning: Sending password information over non-SSL protocol is not secure, it is recommended that password information be submitted over SSL connections only.  Do you wish to continue?";

          if ( ! confirm( msg ) ) {
            return false;
          }
        }

        var covered = true;

        var passField1 = document.form.newPass.value;
        var passField2 = document.form.repass.value;
        var mismatchMsg = "Values for new password and re-entered new password do not match";

        if( (passField1 == "") && (passField2 != "") )
        {
          covered = false;
          alert(mismatchMsg);
        }
        else if( (passField1 != "") && (passField2 == "") )
        {
          covered = false;
          alert(mismatchMsg);
        }
        else
        {
          if( (passField1 != "") && (passField2 != "") )
          {
            if(passField1 != passField2)
            {
              covered = false;
              alert(mismatchMsg);
              return covered;
            }
          }
        }

        if ( covered ) {
          document.form.oldPassword.value=document.form.oldPass.value;
          document.form.newPassword.value=passField1;
          document.form.action.value="updateMaster";
          document.form.submit();
        }
        return covered;
      }
    </SCRIPT>
  </HEAD>


  <BODY onLoad="setNavigation('masterPw.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UpdateMasterPasswordScrn');">

    <TABLE width=100%>
      <TR>
        <TD colspan=2 class="breadcrumb" >
            Security &gt;
            Outbound Passwords &gt;
            Update Master Password</TD>
      </TR>

      <FORM id="form" name="form" method="POST" action="security-outboundpw.dsp">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <INPUT type="hidden" name="action" value=""></INPUT>
        <INPUT type="hidden" name="oldPassword" value=""></INPUT>
        <INPUT type="hidden" name="newPassword" value=""></INPUT>
        <INPUT type="hidden" name="encryptCode" value=""></INPUT>
        <INPUT type="hidden" name="protocolInUse" value=""></INPUT>

        <TR>
          <TD colspan="2">
            <UL class="listitems">
			<script>
			createForm("htmlform_confirm_outbound_reset", "confirm-outbound-reset.dsp", "POST", "BODY");
			createForm("htmlform_security_outboundpw", "security-outboundpw.dsp", "POST", "BODY");
			</script>
              <li>
			  <script>getURL("confirm-outbound-reset.dsp","javascript:document.htmlform_confirm_outbound_reset.submit();","Reset All Outbound Passwords");</script></li>
              <li>
			  <script>getURL("security-outboundpw.dsp","javascript:document.htmlform_security_outboundpw.submit();","Return to Outbound Passwords");</script></li>
            </UL>
          </TD>
        </TR>
        <TR>
          <TD>
            <TABLE class="tableView" width="60%">
              <TR>
                <TD class="heading" colspan=2>Current Password</TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="oldPass">Password</label></TD>
                <TD class="oddrow-l">
                  <INPUT type="password" name="oldPass" id="oldPass" autocomplete="off"
                         value=""></INPUT></TD>
              </TR>
              <TR>
                <TD class="space" colspan=2>&nbsp;</TD>
              </TR>
              <TR>
                <TD class="heading" colspan=2><label for="newPass">New Password</label></TD>
              </TR>
              <TR>
                <TD class="oddrow">Password</TD>
                <TD class="oddrow-l">
                  <INPUT type="password" name="newPass" id="newPass" autocomplete="off"
                         value=""></INPUT></TD>
              </TR>
              <TR>
                <TD class="evenrow"><label for="repass">Re-Enter Password</label></TD>
                <TD class="evenrow-l">
                  <INPUT type="password" name="repass" id="repass" autocomplete="off"
                         value=""></INPUT></TD>
              </TR>
              <TR>
                <TD class="action" colspan=2>
                  <INPUT type="submit" value="Change Password" name="submit"
                         onClick="return checkPasses('%value protocolInUse encode(javascript)%', '%value clientIsLocal encode(javascript)%');"></INPUT>
                </TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </FORM>
    </TABLE>

  </BODY>
</HTML>


