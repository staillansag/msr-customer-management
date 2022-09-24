<HTML>
  <HEAD>
    <TITLE>Integration Server Audit Log</TITLE>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <META http-equiv="refresh" content="90">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <SCRIPT>
    function checkEverything()
    {
      if (!verifyRequiredNonNegNumber('logform', 'numlines'))
        {
          alert("Number of lines to display must be a non negative number.");
          return false;
        }
      return true;
    }
    </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('log-audit-recent.dsp', 'doc/OnlineHelp/WmRoot.htm#CS_Logs_Audit.htm', 'foo');">
  %scope param(log='serviceactivity') param(checked='CHECKED') param(35lines='35')%
    <FORM NAME="logform">
     %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
     %ifvar order -notempty%
       %switch order%
         %case 'Ascending'%
           %rename checked ascendchecked -copy%
           %rename descendchecked%
         %case%
           %rename checked descendchecked -copy%
           %rename ascendchecked%
       %endswitch%
     %else%
       %rename checked descendchecked -copy%
       %rename ascendchecked%
      %endif%
     %ifvar numlines -notempty%
     %else%
       %rename 35lines numlines -copy%
      %endif%
          <TABLE width=100%>
            <TR>
              <TD class="breadcrumb" colspan="2">
                Logs &gt;
                Audit
              </TD>
            </TR>
            <TR>
           <td colspan=2 class="padding">&nbsp;</TD>
            </TR>
            <TR>
              <TD colspan=2>
                <UL>
				<script>
						    createForm("htmlform_http_log_audit_recent", "log-audit-recent.dsp", "POST", "BODY");
							setFormProperty("htmlform_http_log_audit_recent", "numlines", "35");
                </script>	
				
				<script>
						    createForm("htmlform_http_log_auditassoc_recent", "log-auditassoc-recent.dsp", "POST", "BODY");
							setFormProperty("htmlform_http_log_auditassoc_recent", "numlines", "35");
                </script>	
				
				
				
                  <li>
				  <script>getURL("log-audit-recent.dsp?numlines=35","javascript:document.htmlform_http_log_audit_recent.submit();","View Audit Log");</script></LI>
                  <li>
				  <script>getURL("log-auditassoc-recent.dsp?numlines=35","javascript:document.htmlform_http_log_auditassoc_recent.submit();","View Audit Associations Log");</script></LI>
                </UL>
              </TD>
            </TR>
%comment%
            <TR>
              <TD colspan=2>
                <UL>
				<script>
						    createForm("htmlform_http_log_audit_recent2", "log-audit-recent.dsp", "POST", "BODY");
							setFormProperty("htmlform_http_log_audit_recent2", "numlines", "99");
                </script>	
				
				
                  <li>
				  <script>getURL("log-audit-recent.dsp?numlines=99","javascript:document.htmlform_http_log_audit_recent2.submit();","View Entire Audit Log");</script> (Loading entire log may take some time)
				  </LI>
                </UL>
              </TD>
            </TR>
%endcomment%
            <TR>
               <TD>
                  <TABLE class="tableView">
                    <TR>
                      <TD colspan=4 class="heading">Log display controls</TD>
                    </TR>
                    <TR>
                      <TD class="oddrow" nowrap>
                        <TABLE>
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" name="order" id="order1"  VALUE="Ascending" %value ascendchecked encode(htmlattr)%>
                            </TD>
                            <TD>
                              <label for="order1">Display Log Entries oldest to newest starting from the beginning</label>
                            </TD>
                          </TR>
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" name="order" id="order2"  VALUE="Descending" %value descendchecked encode(htmlattr)%>
                            </TD>
                            <TD>
                              <label for="order2">Display Log Entries newest to oldest starting from the end</label>
                            </TD>
                          </TR>
                        </TABLE>
                      </TD>
                      <TD class="oddrow" nowrap>
                        <label for="numlines">Number of entries to display</label>
                        <INPUT name="numlines" id="numlines"  size=5 value="%value numlines encode(htmlattr)%">
                      </TD>
                      <TD class="oddrow">  <INPUT type=SUBMIT VALUE="Refresh" onClick="return checkEverything();"></TD>
                    </TR>
                  </TABLE>
               </TD>
           <TD class="padding">&nbsp;</TD>
            </TR>
            <TR>
           <TD colspan=2 class="padding">&nbsp;</TD>
            </TR>
              %invoke wm.server.query:getPartialLog%
            <TR>
          <TD colspan=2>
            <TABLE class="tableView">
                  <TR>
                  %ifvar logdate%
                    <TD colspan=14 class="heading">Audit Activity Log Entries as of %value logdate encode(html)%</TD>
                  %else%
                    <TD colspan=14 class="heading">Audit Activity Log Entries</TD>
                  %endif%
                  </TR>
                  <TR>
                    <TD nowrap class="oddcol">Time Stamp</TD>
                    <TD nowrap class="oddcol">User Id</TD>
                    <TD nowrap class="oddcol">Entry Type</TD>
                    <TD nowrap class="oddcol">Server Id</TD>
                    <TD nowrap class="oddcol">Brief Message</TD>
                    <TD nowrap class="oddcol">Full Message</TD>
                    <TD nowrap class="oddcol">Root Context</TD>
                    <TD nowrap class="oddcol">Parent Context</TD>
                    <TD nowrap class="oddcol">Current Context</TD>
                  </TR>
                  %invoke wm.server.query:getPartialLog%
                  %ifvar message%
                    <TR><TD colspan="14">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan=14>%value message encode(html)%</TD></TR>
                  %endif%
                  %ifvar ascendchecked equals('CHECKED')%
                    <TD colspan=14 class="oddrowdata-l">---------------------------------- Beginning of Current Log ----------------------------------</TD>
                  %else%
                    <TD colspan=14 class="oddrowdata-l">---------------------------------- End of Current Log ----------------------------------</TD>
                  %endif%

                  %loop logEntries%
                  <TR>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value AuditTimestamp encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value UserID encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ServerID encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value EntryType encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value BriefMessage encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value FullMessage encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value RootContextID encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ParentContextID encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ContextID encode(html)%</TD>
                     <SCRIPT>swapRows();</SCRIPT>
                  </TR>
                  %endloop%
                </TABLE>
              </TD>
            </TR>
          </TABLE>
      %endinvoke%
   </FORM>
   %endscope%
  </BODY>
</HTML>

