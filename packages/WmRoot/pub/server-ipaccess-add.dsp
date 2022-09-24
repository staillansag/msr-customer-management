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
    <TITLE>Integration Server -- IP Access Management</TITLE>
  </HEAD>

   <BODY onLoad="setNavigation('server-ipaccess-add.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddHoststoListScrn');">

    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          IP Access &gt;
          Add Hosts
          %ifvar listenerKey%
            %ifvar listenerKey equals('global')%
                &gt; global
            %else%
				&gt; %value listenerKey encode(html)%
            %endif%
          %endif%
      </TD>
      </TR>

      <TR>
        <TD colspan="2">
          <ul class="listitems">
			<script>
			createForm("htmlform_server_ipaccess", "server-ipaccess.dsp", "POST", "BODY");
			setFormProperty("htmlform_server_ipaccess", "listenerKey", "%value listenerKey encode(url)%");
			setFormProperty("htmlform_server_ipaccess", "pkg", "%value pkg encode(url)%");
			</script>
            <li>
			<script>getURL("server-ipaccess.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%", "javascript:document.htmlform_server_ipaccess.submit();", "Return to IP Access");</script>
			</li>
          </UL>
        </TD>
      </TR>
      <SCRIPT>
        function doAddAllow(){
            if (document.allowadd.allow.value==""){
                return false;
            }
            if (!validateHostPattern(document.allowadd.allow.value))
                return false;
            var form = document.allowadd;
            form.submit();
            return true;
        }

        function doAddDeny(){
        if (document.denyadd.deny.value==""){
            return false;
        }
            if (!validateHostPattern(document.denyadd.deny.value))
                return false;
            var form = document.denyadd;
            form.submit();
            return true;
        }
        function validateHostPattern(hostPatterns)
        {
            var regex = new RegExp("^ *[a-zA-Z0-9\-.\*\?]+ *$");
            var hostPattersnList = hostPatterns.split(",");
            for ( i = 0; i < hostPattersnList.length ; i++)
            {
                var hostPattern = hostPattersnList[i];
                //var hostPattern = hostPattern.trim();
                var match = regex.exec(hostPattern);
                if (!match && !(isIPv6Address(hostPattern)))
                {
                    alert("Invalid host pattern: " + hostPattern);
                    return false; 
                }
            }
            return true;
        }
         </SCRIPT>
      <TR>
        <TD>
      %switch type%
          %case 'exclude'%
      <table class="tableView">
            <TR>
              <TD class="heading" colspan="2">Allow Host</TD>
            </TR>
            <TR>
              <TD class="subheading" colspan="2">Separate hosts with commas</TD>
            </TR>
            <TR>
              <TD class="oddrow" valign="top"><label for="allow">Hosts</label></TD>
              <TD class="oddrow-l">
                <FORM NAME="allowadd" ACTION="server-ipaccess.dsp" METHOD="POST">
                  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                  <INPUT TYPE="hidden" NAME="action" VALUE="add">
                  <INPUT TYPE="hidden" NAME="listenerKey" VALUE="%value listenerKey encode(htmlattr)%">
                  <INPUT TYPE="hidden" NAME="pkg" VALUE="%value pkg encode(htmlattr)%">
                  <INPUT id="allow" NAME="allow" size="40" VALUE=""></INPUT>
                  Example: *.allowme.com, *.allowme2.com
              </TD>
            </TR>
            <tr>
              <td colspan="2" class="action"><input type="button" value="Add Hosts" onClick="doAddAllow();"></td>
            </tr>
                </FORM>
          </table>
    %case 'include'%
          <TABLE class="tableView">
            <TR>
              <TD class="heading" colspan="2">Deny Host</TD>
            </TR>
            <TR>
              <TH class="subheading" scope="col" colspan="2">Separate hosts with commas</TH>
            </TR>
            <TR>
              <TD class="oddrow" valign="top"><label for="deny">Hosts</label></TD>
              <TD class="oddrow-l">
                <FORM NAME="denyadd" ACTION="server-ipaccess.dsp" METHOD="POST">
                  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                  <INPUT TYPE="hidden" NAME="action" VALUE="add">
                  <INPUT TYPE="hidden" NAME="listenerKey" VALUE="%value listenerKey encode(htmlattr)%">
                  <INPUT TYPE="hidden" NAME="pkg" VALUE="%value pkg encode(htmlattr)%">
                  <INPUT id="deny" NAME="deny" size="40" VALUE=""></INPUT>
                  Example: *.denyme.com, *.denyme2.com
               </TD>
            </TR>
            <tr>
               <td colspan="2" class="action"><input type="button" value="Add Hosts" onClick="doAddDeny();"></td>
            </tr>
                </FORM>
          </table>
    %endswitch%
        </td>
      </tr>


    </table>
  </body>
  </html>
