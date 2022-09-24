<HTML>
  <HEAD>
    <TITLE>IS Messaging Log</TITLE>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <script language="JavaScript1.3">
        function checkEverything(invokedByUser)
        {
            if (!verifyRequiredNonNegNumber('logform', 'numlines'))
            {
              alert("Number of lines to display must be a non negative number.");
              return false;
            }
			var numEntered = document.getElementById("numlines").value;
			if(numEntered <=0 || numEntered > 65535)
			{
				alert("Number of lines to display must be between 1 to 65535.");
				return false;
			}
            if ( document.logform.qfromdate != null &&
                document.logform.qtodate != null ) {
          
           var fromDate = document.logform.qfromdate.value; 
          
           var invalidItems = /\;|\,|\_|\<|\>|\@|\?|\#|\*|\&|\^|\~|\%|\!|\"|\$|\/|[a-zA-Z]/ig;

            if (fromDate.match(invalidItems))
            {
                alert("From Date can only contain valid date values in YYYY-MM-DD HH:MM:SS format.");
                return false;
            }
         
             var toDate = document.logform.qtodate.value; 
             if (toDate.match(invalidItems))
                 {
                 alert("To Date can only contain valid date values in YYYY-MM-DD HH:MM:SS format.");
                 return false;
            }
            }
            var alertMaxEntries = document.getElementById("alertMaxEntries").value;

            if( isEmpty(alertMaxEntries) || isNaN(alertMaxEntries) || parseInt(alertMaxEntries) < 1 || !isInteger(alertMaxEntries))
            {
                document.logform.submit();
                return true;
            }

            if(invokedByUser){
            var numEntries = document.getElementById("numlines").value;
            alertMaxEntries = parseInt(alertMaxEntries);
            numEntries = parseInt(numEntries);
            if(numEntries > alertMaxEntries)
            {
                var choice=confirm("Number of entries to display exceed the value specified for the watt.server.log.alertMaxEntries property.\n\nIncreasing the number of entries displayed can slow system performance.\n\nDo you wish to continue?" );
                if (choice==false)
                {
                    document.getElementById("numlines").value = document.getElementById("oldNumLines").value;
                    return false;
                }
        }
            }
            document.logform.submit();
         }

        function refreshSearch() {
            document.queryform.action = "svc_queryframe.dsp"
               document.queryform.target = "query"
               document.queryform.submit();                  // Submit the page
            }
        
            var today = new Date();
            var thisMonth = today.getMonth(); 
            var thisYear = today.getFullYear();
            var thisDate = today.getDate();
            var headerExist = false;
            function openCalendar( which ) 
            {
               window.open( "calendar.dsp?month="+thisMonth+"&year="+thisYear+"&date="+thisDate
                   +"&which="+escape(which), "calendar", "width=600,height=350,top=50,left=50,resizable=yes" );
            }
            function getTodayDate() {
               return thisYear + "-" + thisMonth + "-" + thisDate;
            }
            
            </script>
             
             %scope param(property='watt.server.log.refreshInterval')%
             %invoke wm.server.query:getSettingAdmin%
                %ifvar property -notempty%
                %ifvar property matches('-*')%
              %else%
                  <script> window.setInterval("checkEverything(false)","%value property encode(javascript)%"*1000);</script>
            %endif%
              %else%
                  <script> window.setInterval("checkEverything(false)",90*1000);</script>
              %endif%   
              %endinvoke%    
          %endscope%
  </HEAD>
  <BODY onLoad="setNavigation('log-messaging-recent.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Logs_MessagingScrn');">
    %scope param(property='watt.server.log.alertMaxEntries')%
        %invoke wm.server.query:getSettingAdmin%
			<input type="hidden" name="alertMaxEntries" id="alertMaxEntries" value="%value property encode(htmlattr)%">
        %endinvoke%    
    %endscope%
    %ifvar numlines -notempty%
         %scope param(watt.server.log.maxEntries=numlines)%
                  %rename numlines watt.server.log.maxEntries -copy%
                  %invoke wm.server.admin:setSettings%
                  %onerror%
                  %ifvar errorMessage%
              	<TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
                  %endif%
                %endinvoke%
              %endscope%
    %endif%
    
    %scope param(property='watt.server.log.maxEntries')%
    %invoke wm.server.query:getSettingAdmin%
    
     %scope param(log='messaging') param(checked='CHECKED') param(35lines=property)%  
      <SCRIPT>%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%</SCRIPT>
      <FORM NAME="logform" method="post">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
     
     %rename ../../order order -copy%
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
                Logs &gt; Messaging
              </TD>
            </TR>
            <TR>
           <td colspan=2 class="padding">&nbsp;</TD>
            </TR>
            <TR>
               <TD>
                  <TABLE class="tableView">
                    <TR>
                      <TD colspan=4 class="heading">Log display controls</TD>
                    </TR>
                    <TR>
                      <TD class="oddrow" nowrap>
                        <TABLE class="noborders">
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" name="order" id="order1" VALUE="Ascending" %value ascendchecked encode(htmlattr)%>
                            </TD>
                            <TD>
                              <label for="order1">Display Log Entries oldest to newest starting from the beginning</label>
                            </TD>
                          </TR>
                          <TR>
                            <TD>
                              <INPUT TYPE="radio" name="order" id="order2" VALUE="Descending" %value descendchecked encode(htmlattr)%>
                            </TD>
                            <TD>
                              <label for="order2">Display Log Entries newest to oldest starting from the end</label>
                            </TD>
                          </TR>
                        </TABLE>
                      </TD>

                      <TD class="oddrow" nowrap>
                        <label for="numlines">Number of entries to display</label>
                        <INPUT name="numlines" id="numlines" size="5" value="%value property encode(htmlattr)%">
						<input name="oldNumlines" id="oldNumLines" type="hidden" value="%value property encode(htmlattr)%"/>
                      </TD>
                      <TD class="oddrow">  <INPUT type="SUBMIT" VALUE="Refresh" onClick="return checkEverything(true);"></TD>
                    </TR>
                    %scope param(property='watt.server.auditStore')%
                
              <TR class="oddrow">                   
              <TD  nowrap></TD>

               <TD style="text-align: right">
               <br>

            <label for="uuid">UUID:</label>   
            <input name="uuid" id="uuid">

               </TD>        

               <TD  nowrap align="right"></TD>

               </TR>
                </TABLE>
                </TD>
                </TR>
                
             %endscope%
                  </TABLE>
               </TD> 
           <TD class="padding">&nbsp;</TD>
            </TR> 
            <TR>
           <TD colspan=2 class="padding">&nbsp;</TD>
            </TR>
          %rename property numlines -copy% 
      %rename ../../qfromdate qfromdate -copy%
          %rename ../../qtodate qtodate -copy%
          %rename ../../uuid uuid -copy%
          
          %invoke wm.server.query:getPartialLog%
 <TR>
          <TD colspan=2>
            <TABLE class="tableView">
                  <TR>
                  %ifvar logdate%
                    <TD colspan=10 class="heading">Messaging Log Entries as of %value logdate encode(html)%</TD>
                  %else%    
                    <TD colspan=10 class="heading">Messaging Log Entries</TD>
                  %endif%
                  </TR>  
                  <TR class="subheading2">
                    <TD>Time Stamp</TD>
                    <TD>Mode</TD>
                    <TD>Message</TD>
                    <TD>UUID</TD>
                    <TD>Alias</TD>
                    <TD>Destination</TD>
                    <TD>Message ID</TD>
                    <TD>Trigger</TD>
                  </TR>
                  %ifvar message%
                    <TR><TD colspan="10">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan=10>%value message encode(html)%</TD></TR>
                  %endif%
                  %ifvar ascendchecked equals('CHECKED')%
                    <TD colspan=10 class="oddrowdata-l">---------------------------------- Beginning of Current Log ----------------------------------</TD>
                  %else%
                    <TD colspan=10 class="oddrowdata-l">---------------------------------- End of Current Log ----------------------------------</TD>
                  %endif% 

                  %loop logEntries%
                  <TR>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value AuditTimestamp encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value MODE encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value MESSAGE encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value UUID encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value ALIAS encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value DESTINATION encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value MESSAGEID encode(html)%</TD>
                     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value TRIGGER encode(html)%</TD>
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
   %endinvoke%
 %endscope%
  </BODY>
</HTML>
<script>
if ( document.logform.qfromdate != null && document.logform.qtodate != null ) 
{
logform.qfromdate.value="%value qfromdate encode(javascript)%";
logform.qtodate.value="%value qtodate encode(javascript)%";
}
if ( document.logform.uuid != null) 
{
logform.uuid.value="%value uuid encode(javascript)%";
}

</script>