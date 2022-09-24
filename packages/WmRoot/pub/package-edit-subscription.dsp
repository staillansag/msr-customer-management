<HTML>
  <HEAD>
  <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  <TITLE>Integration Server -- Subscriber Packages</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%  
  <SCRIPT SRC="webMethods.js"></SCRIPT>

  <SCRIPT LANGUAGE="JavaScript">

    function onSave()
    {
    var package = document.subedit.package.value;
    var pullemail = document.subedit.pullemail.value;
    var password = document.subedit.reppass.value;

    if ( package == null || package == "" ) {
      alert("Package is required.");
      return false;
    } else if ( password == null || password == "" ) {
      alert("Password is required.");
      return false;
    }
    else if( document.subedit.autopull[0].checked== true && ( pullemail == null || pullemail == "") ) {
      alert("Automatic Pull Email is required when you selected Automatic Pull option.");
      return false;
    } else {
      return true;
    }

    }
  </SCRIPT>

  </HEAD>
  <BODY onLoad="setNavigation('package-subscribing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_EditSubscriptionScrn');">

 %invoke wm.server.replicator:getSubscriptionValues%

   <TABLE width="100%">
      <TR>
    <TD class="breadcrumb" colspan=2>
      Packages &gt;
      Subscribing &gt;
      Edit Subscription
    </TD>
      </TR>
      <TR>
    <TD colspan="2">
      <UL class="listitems">
        <LI>
		  <script>
		  createForm("htmlform_package_subscribing", "package-subscribing.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("package-subscribing.dsp", "javascript:document.htmlform_package_subscribing.submit();", "Return to Subscribing");</script>
          
        </LI>
      </UL>
    </TD>
      </TR>
      <TR>
    <TD>
      <TABLE class="tableView">
        <FORM NAME="subedit" ACTION="package-subscribing.dsp" METHOD="POST">
        <TR>
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <INPUT TYPE="hidden" NAME="action" VALUE="edit"></input>
        <INPUT TYPE="hidden" NAME="refresh" VALUE="true"></input>
        <INPUT TYPE="hidden" NAME="oldname", VALUE="%value pkgname encode(htmlattr)%">
        <INPUT TYPE="hidden" NAME="oldhostport", VALUE="%value hostport encode(htmlattr)%">
        <TR>
          <TD class="heading" colspan=2>Remote Package</TD>
        </TR>

        <TR>
		  <TD class="oddrow-l"><label for="package">Package</label></TD>
		  <TD class="oddrow-l"><INPUT name="package" id="package" VALUE="%value pkgname encode(htmlattr)%"></INPUT></td>
        </TR>
        <tr><TD class="evenrow-l">
		<script>
	    createForm("htmlform_settings_remote", "settings-remote.dsp", "POST", "BODY");
	    </script>
		<script>getURL("settings-remote.dsp", "javascript:document.htmlform_settings_remote.submit();", "Publisher Alias");</script>
		</TD>
          <TD class="evenrow-l">
		    <SELECT name="alias" id="alias">
              %invoke wm.server.remote:serverList%
              %loop -struct servers%
              %scope #$key%
		      <OPTION value="%value alias encode(htmlattr)%" %ifvar alias vequals(/alias)% selected %endif%>%value alias encode(html)%</OPTION>
              %endscope%
              %endloop%
              %endinvoke%
            </SELECT>
          </td>
        </tr>
		<tr><TD class="oddrow-l"><label for="locallistener">Local Port</label></TD>
          <TD class="oddrow-l">
            %invoke wm.server.net.listeners:listListeners%
		    <select name="locallistener" id="locallistener">
              %loop listeners%
              %ifvar equals('true') enabled%
              <!--check for valid listeners HTTP or HTTPS -->
              %switch protocol%
              %case 'HTTP'%
		      <option value="%value key encode(htmlattr)%" %ifvar port vequals(/localport)% selected %endif%>%value protocol encode(html)%@%value port encode(html)% </option>
              %case 'http'%
		      <option value="%value key encode(htmlattr)%" %ifvar port vequals(/localport)% selected %endif%>%value protocol encode(html)%@%value port encode(html)% </option>
              %case 'HTTPS'%
		      <option value="%value key encode(htmlattr)%" %ifvar port vequals(/localport)% selected %endif%>%value protocol encode(html)%@%value port encode(html)% </option>
              %case 'https'%
		      <option value="%value key encode(htmlattr)%" %ifvar port vequals(/localport)% selected %endif%>%value protocol encode(html)%@%value port encode(html)% </option>
              %endcase%
              %endif%
              %endloop%
            </select>
            %endinvoke%
          </td>
         </tr>
		<tr><TD class="evenrow-l"><label for="repuser">Local User Name</label></TD>
          <TD class="evenrow-l">
		    <SELECT name="repuser" id="repuser">
              %invoke wm.server.access:getAclGroupUsers%
              %loop repusers%
		      <OPTION value="%value name encode(htmlattr)%" %ifvar name vequals(/localuser)% selected %endif%>%value name encode(html)%</OPTION>
              %endloop%

              %endinvoke%
            </SELECT>
          </td>
        </tr>
		<tr><TD class="evenrow-l"><label for="reppass">Local Password</label></TD>
          <TD class="evenrow-l">
		    <INPUT name="reppass" id="reppass" TYPE="password" autocomplete="off" VALUE="%value reppass encode(htmlattr)%"></INPUT>
          </td>
        </tr>
		<tr><TD class="oddrow-l"><label for="email">Notification Email</label></TD>
          <TD class="oddrow-l">
		    <INPUT name="email" id="email" VALUE="%value email encode(htmlattr)%"></INPUT>
          </td>
        </tr>
        <tr><TD class="evenrow-l">Automatic Pull</TD>
          <TD class="evenrow-l">
		    <input type="radio" name="autopull" id="autopull1"  value="yes" %ifvar autopull equals('yes')% checked %endif%><label for="autopull1">Yes</label></input>
		    <input type="radio" name="autopull" id="autopull2"  value="no" %ifvar autopull equals('no')% checked %endif%><label for="autopull2">No</label></input>
          </td>
        </tr>
		<tr><TD class="oddrow-l"><label for="pullemail">Automatic Pull Email</label></TD>
          <TD class="oddrow-l">
		    <INPUT name="pullemail" id="pullemail" VALUE="%value pullemail encode(htmlattr)%"></INPUT>
          </td>
        </tr>
        <tr>
          <TD class="action" colspan=2>
            <INPUT TYPE="submit" VALUE="Submit Changes" onclick="return onSave(); return false;"></INPUT>
          </td>
        </tr>

      </table>
    </TD>
      </TR>
    </TABLE>
%endinvoke%
  </BODY>
</HTML>
