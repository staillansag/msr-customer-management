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
      <SCRIPT src="webMethods.js"></SCRIPT>
   </HEAD>
   <BODY onLoad="setNavigation('stats-general.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_ThreadDumpScrn');">
      <DIV class="position">
         %invoke wm.server.query:getThreadDump%
         <TABLE width="100%">
            <TR>
               <TD class="breadcrumb" colspan=5>Server &gt; Statistics &gt; System Threads &gt; Thread Dump</TD>
            </TR>
            <TR>
              <TD>
                <ul class="listitems">
                     %ifvar threadkillsupported equals('true')%
						<script>
						createForm("htmlform_server_threads_new", "server-threads-new.dsp", "POST", "BODY");
						</script>
                         <li>
						 <script>getURL("server-threads-new.dsp","javascript:document.htmlform_server_threads_new.submit();","Return to System Threads");</script></li>
                     %else%
						<script>
						createForm("htmlform_server_threads", "server-threads.dsp", "POST", "BODY");
						</script>
                         <li>
						 <script>getURL("server-threads.dsp","javascript:document.htmlform_server_threads.submit();","Return to System Threads");</script></li>
                     %endif%                
                </UL>
              </TD>
            </TR>
         <TABLE class="tableView" width="100%">
         
          <TR>
            <TD class="heading">Server Thread Dump</TD>
          </TR>

          <TR>
            <TD class="oddcol-l">
              <TABLE width="100%">
                <TR>
                  <TD><PRE class="fixedwidth">%value threadDump encode(html)%

</PRE>
                  </TD>
                </TR>
                </TABLE>
                </TR>
              </TABLE>
         </TABLE>
      </DIV>
   </BODY>
</HTML>