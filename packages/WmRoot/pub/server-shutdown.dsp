<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <STYLE>
        %include webMethods.css%
    </STYLE>
    %ifvar webMethods-wM-AdminUI%
      <STYLE>
        %include webMethods-wM-AdminUI.css%
      </STYLE>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
    var shutdown = true;
    var drain = true;
    var goodTimeout = true;

    function verifyInteger ( timeout )
    {
            goodTimeout = true;

            if(timeout.length <= 0) {
                goodTimeout = false;
            }

            for( var i = 0; i < timeout.length; i++)
            {
                if(timeout.charAt(i) >= "0" && timeout.charAt(i) <= "9")
                {
                    // Do nothing
                }
                else
                {
                    goodTimeout = false;
                }
            }

        }

    function confirmShutdown ()
    {
            if( drain && !goodTimeout )
            {
                alert("You must specify an integer value for the maximum wait time");
                return false;
            }

            var s;
            if ( drain ) {
                s = "OK to shutdown this server after\n the specified delay period?";
            }else {
                s = "OK to shutdown this server immediately?\n(This will terminate active sessions)";
            }
      if (confirm(s))
      {
        document.shutdownform.bounce.value = "no";
        document.shutdownform.submit();
    <!-- document.execCommand("ClearAuthenticationCache");  -->
        return true;
      }
      return false;
    }
    function confirmRestartInQuisceMode()
    {
          var s;
          if( drain && !goodTimeout )
            {
                alert("You must specify an integer value for the maximum wait time");
                return false;
            }
          if( drain ) {
            s = "OK to restart this server in quiesce mode after\n the specified delay period?";
          } else {
            s = "OK to restart this server in quiesce mode immediately?\nQuiescing the server immediately causes all active sessions to be terminated.";
          }
          if (confirm(s))
          {
            document.shutdownform.bounce.value = "yes";
            document.shutdownform.quiesce.value = "true";
            document.shutdownform.submit();
            return true;
          }
          return false;
    }

    function confirmRestart ()
    {
            if( drain && !goodTimeout )
            {
                alert("You must specify an integer value for the maximum wait time");
                return false;
            }

      var s;
      if( drain ) {
        s = "OK to restart this server after\n the specified delay period?";
      } else {
        s = "OK to restart this server immediately?\n(This will terminate active sessions)";
      }
      if (confirm(s))
      {
        document.shutdownform.bounce.value = "yes";
        document.shutdownform.submit();
    <!-- document.execCommand("ClearAuthenticationCache");  -->
        return true;
      }
      return false;
    }
    function confirmCancel()
    {
      var s = "OK to cancel pending shutdown/restart\n requests on this Integration Server?";
      if (confirm (s))
      {
        document.cancelform.submit();
        return true;
      }
      return false;
    }
    </SCRIPT>
  </HEAD>

  <BODY %ifvar option%%else%onLoad="setNavigation('stats-general.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_ShutdownRestartScrn');"%endif%>
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>Server &gt; Shut Down and Restart </TD>
      </TR>
            %ifvar option equals('cancel')%
                    %invoke wm.server.admin:cancelPendingShutdown%
                            %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
									<TR><TD class="message" colspan=2>%value message encode(html)%</TD></TR>
                            %endif%
                    %endinvoke%
            %else%
                    %ifvar option%
                            %invoke wm.server.admin:shutdown%
                                    %ifvar message%
                                        %ifvar message equals('INVALID')%
                                            <tr><td colspan="2">&nbsp;</td></tr>
                                            <TR><TD class="message" colspan="2">Unable to quiesce Integration Server. All of the following conditions must be satisfied to switch Integration Server in quiesce mode
                                                <ul class="listitems">
                                                    <li>Quiesce port should be set.</li>
                                                    <li>Quiesce port should be enabled.</li>
                                                    <li>Quiesce port should not be suspended.</li>
                                                    <li>Quiesce port should have allow access mode.</li>
                                                </ul>
                                             </TD></TR>
                                        %else%
                                            <tr><td colspan="2">&nbsp;</td></tr>
											<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                                        %endif%
                                    %endif%
                            %endinvoke%
                    %endif%
            %endif%
      <TR>
        <TD colspan="2">
          <ul class="listitems">
		  <script>
		  createForm("htmlform_server_cluster", "server-cluster.dsp", "POST", "BODY");
		  setFormProperty("htmlform_server_cluster", "returnto", "shutdown");
		  </script>
           <li>
		   <script>getURL("server-cluster.dsp?returnto=shutdown", "javascript:document.htmlform_server_cluster.submit();", "Current Sessions");</script>

		   </li>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE class="tableView" width="50%">
            %invoke wm.server.query:getSettings%
            <FORM name="shutdownform" method="POST" action="server-shutdown.dsp">
              %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
              <INPUT type="hidden" name="bounce" value="xxx">
              <INPUT type="hidden" name="quiesce" value="false">
              <TR>
                <TD class="heading" colspan="2">Shut Down or Restart...</TD>
              </TR>
              <TR>
                <TD class="oddrow-l" style="border-right: none">
                  <INPUT type="radio" onclick="drain=true;"  name="option" id="option" value="drain" checked />
                  <label for="option">After all client sessions end...</label></td>
                <td class="oddrow" style="border-left: none"> <label for="timeout">Maximum wait time:</label>
                  <INPUT name="timeout" id="timeout" value="%value watt.server.clientTimeout encode(htmlattr)%" size=3 onchange="verifyInteger(this.value);"></INPUT>
                  minutes</TD>
              </TR>

            <TR>
              <TD class="evenrow-l" colspan="2">
                <INPUT type="radio" onclick="drain=false;"  name="option" id="option1" value="force"><label for="option1"> Immediately</label></INPUT></TD>
            </TR>
            <TR>

                <TD class="action" colspan="2">
                  <INPUT type="button" value="Shut Down" onclick="confirmShutdown();"></INPUT>
                  <INPUT type="button" value="Restart"  onclick="confirmRestart();"></INPUT>
                  <INPUT type="button" value="Restart in Quiesce Mode"  onclick="confirmRestartInQuisceMode();"></INPUT>

                  %invoke  wm.server.admin:listPendingShutdown%
                    %ifvar shutdownRestart%

             %ifvar shutdownRestartType equals('bounce')%
            <INPUT type="button" value="Cancel Restart" onclick="confirmCancel();"></INPUT>
            %else%
            <INPUT type="button" value="Cancel Shut Down" onclick="confirmCancel();"></INPUT>
            %end if%
                    %else%
                      %ifvar  shutdownRestartIdle%
                        <INPUT type="button" value="Cancel Restart" onclick="confirmCancel();"></INPUT>
                      %endif%
                    %endif%
                 </TD>

            </TR>
</FORM>
             %endinvoke%
          </TABLE> </TD>
      </TR>
    </TABLE>
                    <FORM name="cancelform"  action="server-shutdown.dsp" method="POST">
                    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                    <INPUT type="hidden" name="option"  value="cancel"></INPUT>
                  </FORM>

</BODY>
</HTML>
