<HTML>
  <HEAD>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
  </HEAD>
  <BODY>
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Packages &gt;
          Publishing &gt;
          Send Release
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
        <TD>
          <TABLE class="tableView">
            <TR>
              <TD class="heading" colspan=3>Subscribers</TD>
            </TR>
            <TR>
              <TD class="oddrow">Package</TD>
              <TD class="oddrowdata-l" colspan=2>%value package encode(html)%</TD>
            </TR>
            <TR>
              <TD class="evenrow">Release</TD>
              <TD class="evenrowdata-l" colspan=2>%value release encode(html)%</TD>
            </TR>

    <script>
    function selectAll(form, checkboxes, checked)
    {
     for (index in checkboxes)
     {
       document.forms[form][checkboxes[index]].checked = checked;
     }
    }

    function onSend(form, checkboxes)
    {
      var cnt = 0;
      for ( index in checkboxes)
      {
        if( document.forms[form][checkboxes[index]].checked == true )
          cnt ++;
      }

      if ( cnt < 1 ) {
        alert("Select a Subscriber first.");
        return false;
      }
      else
        return true;
    }
    var checkboxArray1 = [];

    </script>

            <form action="package-exchange.dsp" name="sendform">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            <input type="hidden" name="action" value="sendrelease">
            <input type="hidden" name="package" value="%value package encode(htmlattr)%">
            <input type="hidden" name="release" value="%value release encode(htmlattr)%">
            <TR>
              <TD class="oddrow">Subscribers</TD>
              <TD class="oddrowdata-l">
                %invoke wm.server.replicator:publishedList%
                    %loop published%
                    %ifvar ../package vequals(package)%
                <script>checkboxArray1 = [%loop subscribers%'sub-%value encode(javascript)%'%loopsep ', '%%endloop%];</script>

          %ifvar subscribers%
                      %loop subscribers%
                <input type="checkbox" name="sub-%value encode(htmlattr)%" id="sub-%value encode(htmlattr)%" value="%value encode(htmlattr)%" checked><label for="sub-%value encode(htmlattr)%">%value encode(html)%</label></input><BR>
                      %endloop%
                     %else%
                     No subscribers
                     %end if%
                    %endloop%

                 %endinvoke%
              </TD>
              <TD class="oddrowdata-l">
				<script>
				createForm("htmlform_package_send_release_select_subscribers", "package-send-release-select-subscribers.dsp", "POST", "BODY");
				</script>
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_package_send_release_select_subscribers.submit();" onclick="selectAll(\'sendform\', checkboxArray1, true); return false;">Select All</a>');
					} else {
						document.write('<a href="#" onclick="selectAll(\'sendform\', checkboxArray1, true); return false;">Select All</a>');
					}
				</script>
                <br>
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_package_send_release_select_subscribers.submit();" onclick="selectAll(\'sendform\', checkboxArray1, false); return false;">Un-Select All</a>');
					} else {
						document.write('<a href="#" onclick="selectAll(\'sendform\', checkboxArray1, false); return false;">Un-Select All</a>');
					}
				</script>
                
              </TD>
            </TR>
            <TR>
              <TD colspan="3" class="action">
                <INPUT type="submit" name="submit" onclick="return onSend('sendform', checkboxArray1); " value="Send Release">
              </TD>
            </TR>
            </form>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </BODY>
</HTML>
