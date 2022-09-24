<HTML>
    <HEAD>
      <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
      <META HTTP-EQUIV="Expires" CONTENT="-1">
      <TITLE>Package Exchange</TITLE>
      <SCRIPT SRC="webMethods.js"></SCRIPT>
      <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
      %ifvar webMethods-wM-AdminUI%
        <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
        <script>webMethods_wM_AdminUI = 'true';</script>
      %endif%  
    </HEAD>

    <BODY onLoad="setNavigation('package-exchange.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_EditSubsScrn');">

    <SCRIPT LANGUAGE="JavaScript">

      function onSave()
      {
      var host = document.subedit.host.value;
      var port = document.subedit.port.value;
      var username = document.subedit.remoteuser.value;
      var password = document.subedit.remotepass.value;

      if ( host == null || host == "" ) {
        alert("Host Name is required.");
        return false;
      } else if( port == null || port == "" ) {
        alert("Host Port is required.");
        return false;
      } else if( username == null || username == "" ) {
        alert("Remote User Name is required.");
        return false;
      } else if( password == null || password == "" ) {
        alert("Remote Password is required.");
        return false;
      } else {
        return true;
      }

      }
    </SCRIPT>

    %invoke wm.server.replicator:getSubscriberValues%

    <TABLE width=100%>
        <TR>
            <TD class="breadcrumb" colspan="3">
                Packages &gt;
                Publishing &gt;
                Edit Subscriber
            </TD>
        </TR>
        <TR>
          <TD colspan=2>
            <UL class="listitems">
			  <script>
			  createForm("htmlform_package_exchange", "package-exchange.dsp", "POST", "BODY");
			  </script>
              <li>
			  <script>getURL("package-exchange.dsp", "javascript:document.htmlform_package_exchange.submit();", "Return to Publishing");</script>
			  </li>
            </UL>
          </TD>
        </TR>
        <TR>
            <TD valign=top>
                <TABLE class="tableView">
                <TR>
                    <TD class="heading" colspan="2">Edit Subscriber</TD>
                </TR>
      <FORM NAME="subedit" ACTION="package-exchange.dsp" METHOD="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <INPUT TYPE="hidden" NAME="action" VALUE="edit">
      <INPUT TYPE="hidden" NAME="oldname", VALUE="%value pkgname encode(htmlattr)%">
      <INPUT TYPE="hidden" NAME="oldhost", VALUE="%value host encode(htmlattr)%">
      <INPUT TYPE="hidden" NAME="oldport", VALUE="%value port encode(htmlattr)%">
                <TR>
                  <TD class="evenrow"><label for="package">Packages</label></TD>
                  <TD class="evenrow-l">
                    <SELECT name="package" id="package">
          %invoke wm.server.packages:packageList%
                    %loop packages%
                    	<option value="%value name encode(htmlattr)%" %ifvar name vequals(../package)% selected %endif% >%value name encode(html)%</option>
                    %endloop%
                    </SELECT>
                  </TD>
                </TR>
                <TR>
                  <TD class="oddrow"><label for="host">Host Name</label></TD>
                  <TD class="oddrow-l"><INPUT name="host" id="host" VALUE="%value host encode(htmlattr)%"></INPUT></td>
                </TR>
                <TR>
                  <TD class="evenrow" class="evenrow"><label for="port">Host Port</label></TD>
                  <TD class="evenrow-l"><INPUT name="port" id="port" VALUE="%value port encode(htmlattr)%"></INPUT></TD>
                </TR>
                <TR>
                  <TD class="oddrow"><label for="ssl">Transport</label></TD>
                  <TD class="oddrow-l">
                    <SELECT name="ssl" id="ssl">
                    <OPTION  value="HTTP" %ifvar ssl equals('no')% selected %endif% >HTTP</OPTION>
                    <OPTION  value="HTTPS"%ifvar ssl equals('yes')% selected %endif%>HTTPS</OPTION>
                    </SELECT>
                  </TD>
                </TR>
                <TR>
                  <TD class="evenrow"><label for="remoteuser">Remote User Name</label></TD>
                  <TD class="evenrow-l"><INPUT name="remoteuser" id="remoteuser" VALUE="%value repuser encode(htmlattr)%"></INPUT></td>
                </TR>
                <TR>
                  <TD class="oddrow"><label for="remotepass">Remote Password</label></TD>
                  <TD class="oddrow-l"><INPUT TYPE="password" name="remotepass" id="remotepass" autocomplete="off" VALUE="%value reppass encode(htmlattr)%"></INPUT></td>
                </TR>
                <TR>
                  <TD class="evenrow"><label for="email">Notification Email</label></TD>
                  <TD class="evenrow-l">
                    <INPUT name="email" id="email" VALUE="%value email encode(htmlattr)%"></INPUT>
                  </TD>
                </TR>
                <TR>
                  <TD colspan=2 class="action">
                    <INPUT type="submit" name="submit" onclick="return onSave(); return false;" value="Submit Changes">
                  </TD>
                </TR>
                </TABLE>
             </TD>
         </TR>
    </TABLE>

    %endinvoke%

    </BODY>
</HTML>
