
<HTML>
   <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


      <TITLE>Integration Server Threads
      </TITLE>
      <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
      %ifvar webMethods-wM-AdminUI%
        <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
        <script>webMethods_wM_AdminUI = 'true';</script>
      %endif%
      <META http-equiv="refresh" content="90">
      <SCRIPT src="webMethods.js"></SCRIPT>
   </HEAD>
   <BODY onLoad="setNavigation('stats-general.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_SysThreadsScrn');">
      <DIV class="position">
         <TABLE width="100%">
            <TR>
               <TD class="breadcrumb" colspan=5>Server &gt; Statistics &gt; System Threads</TD>
            </TR>
            <TR>
              <TD colspan=2>
                <ul class="listitems">
				<script>
				createForm("htmlform_stats_general", "stats-general.dsp", "POST", "BODY");
				createForm("htmlform_server_thread_dump", "server-thread-dump.dsp", "POST", "BODY");
				</script>
                  <li>
				  <script>getURL("stats-general.dsp","javascript:document.htmlform_stats_general.submit();","Return to Server Statistics");</script></li>
                  <li>
				  <script>getURL("server-thread-dump.dsp","javascript:document.htmlform_server_thread_dump.submit();","Generate JVM Thread Dump");</script></li>
                </UL>
              </TD>
            </TR>
           %invoke wm.server.query:getThreadList%
            <TR>
               <TD>
                  <!-- Thread table -->
                  <TABLE class="tableView" CELLPADDING=2>
                     <TR>
                        <TD class="heading" colspan=5>System Threads</TD>
                     <TR>
                        <TH class="oddcol" scope="col">Priority</TH>
                        <TH class="oddcol-l" scope="col">Name</TH>
                        <TH class="oddcol" scope="col">Alive</TH>
                        <TH class="oddcol" scope="col">Daemon</TH>
                        <TH class="oddcol" scope="col">Interrupted</TH>
                        <script>resetRows();</script>
                     </TR> %loop threads%
                     <TR>
                        <script>writeTD('rowdata');</script>%value priority encode(html)%</TD>
                        <script>writeTD('rowdata-l');</script>%value name encode(html)%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar alive equals('true')%<IMG SRC="images/green_check.png" height=13 width=13>%else%-%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar daemon equals('true')%<IMG SRC="images/green_check.png" height=13 width=13>%else%-%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar interrupted equals('true')%<IMG SRC="images/green_check.png" height=13 width=13>%else%-%endif%</TD>
                        <script>swapRows();</script>
                     </TR> %endloop%
                  </TABLE>
                  <!-- Threads table --> %endinvoke%  </TD>
            </TR>
         </TABLE>
      </DIV>
   </BODY>
</HTML>
