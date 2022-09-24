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

    <BODY onLoad="setNavigation('package-exchange.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_AddSubsScrn');">

    <SCRIPT LANGUAGE="JavaScript">

      function onAdd()
      {
      var host = document.subadd.host.value;
      var port = document.subadd.port.value;
      var username = document.subadd.remoteuser.value;
      var password = document.subadd.remotepass.value;

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

    <TABLE width=100%>
        <TR>
            <TD class="breadcrumb" colspan="3">
                Packages &gt;
                Publishing &gt;
                Add Subscriber
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
                    <TD class="heading" colspan="2">Add Subscriber</TD>
                </TR>
      <FORM NAME="subadd" ACTION="package-exchange.dsp" METHOD="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <INPUT TYPE="hidden" NAME="action" VALUE="add">
                <tr>
                  <TD class="evenrow"><label for="package">Packages</label></TD>
                  <TD class="evenrow-l">
                    <SELECT name="package" id="package">
          %invoke wm.server.packages:packageList%
                    %loop packages%
                    <option value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %endloop%
                    </SELECT>
                  </TD>
                </tr>
                <tr>
                  <TD class="oddrow">
				  <label for="host">Host Name</label>
				  </TD>
                  <TD class="oddrow-l"><INPUT id="host" NAME="host" VALUE=""></INPUT></td>
                </tr>
                <tr>
                  <TD class="evenrow" class="evenrow">
				   <label for="port">Host Port</label>
				  </TD>
                  <TD class="evenrow-l"><INPUT id="port" NAME="port" VALUE=""></INPUT></td></tr>
                <tr>
                  <TD class="oddrow"> <label for="ssl">Transport</label></TD>
                  <TD class="oddrow-l">
                    <SELECT NAME="ssl" id="ssl">
                    <OPTION  value="HTTP">HTTP</OPTION>
                    <OPTION  value="HTTPS">HTTPS</OPTION>
                    </SELECT>
                  </TD>
                </tr>
                <tr>
                  <TD class="evenrow">
				  <label for="remoteusername">Remote User Name</label>
				  </TD>
                  <TD class="evenrow-l"><INPUT id="remoteusername" NAME="remoteuser" ></INPUT></td>
                </tr>
                <tr>
                  <TD class="oddrow">
				  <label for="remotepass">Remote Password</label>
				  </TD>
                  <TD class="oddrow-l"><INPUT id="remotepass" TYPE="password" NAME="remotepass" autocomplete="off"></INPUT></td>
                </tr>
                <tr>
                  <TD class="evenrow">
				  <label for="email">Notification Email</label>
				  </TD>
                  <TD class="evenrow-l">
                    <INPUT id="email" NAME="email"></INPUT>
                  </td>
                </tr>

                <tr>
                  <td colspan=2 class="action">
                    <INPUT type="submit" name="submit" onclick="return onAdd(); return false;" value="Add Subscriber">
                  </td>
                </tr>
              </table>

            </TD>
        </TR>
       </FORM>
  </table>
</BODY>
</HTML>
