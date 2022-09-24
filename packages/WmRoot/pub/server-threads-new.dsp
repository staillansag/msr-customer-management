<HTML>
   <HEAD>

    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">

    <TITLE>Integration Server Threads</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT src="webMethods.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
      function confirmAction(action, name, fm, key1, val1, key2, val2)
      {
         var s1 = "OK to " + action + " the thread: '" + name + "' ?";
         if ( confirm (s1) ) {
			 fm.elements[key1].value = val1;
		  fm.elements[key2].value = val2;
        return true;         
         }
         else {
            return false;
         }
      }
	  
	  function populateForm(fm, key, val) {
		  fm.elements[key].value = val;
		  
		  var actionElement = fm.getAttribute("action");
		  
		  actionElement = setQueryParamDelim(actionElement) +  key + "=" + val;

		  fm.setAttribute("action", actionElement);
		  
		  return true;
	  }
	  
	  
      </SCRIPT>      
   </HEAD>
   <BODY onLoad="setNavigation('stats-general.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_SysThreadsScrn');">
      <DIV class="position">
         <TABLE width="100%">

         %ifvar action equals('kill')%  %invoke wm.server.query:killThread%
         %endinvoke%  %endif%

         %ifvar action equals('interrupt')%  %invoke wm.server.query:interruptThread%
         %endinvoke%  %endif%

         %invoke wm.server.query:getThreadList%

            <TR>
               <TD class="breadcrumb" colspan=5>Server &gt; Statistics &gt; System Threads</TD>
            </TR>
            <TR>
              <TD colspan=2>
              <UL class="listitems">
				<script>
				createForm("htmlform_stats_general", "stats-general.dsp", "POST", "BODY");
				createForm("htmlform_server_thread_dump", "server-thread-dump.dsp", "POST", "BODY");
				</script>
                  <li>
				  <script>getURL("stats-general.dsp","javascript:document.htmlform_stats_general.submit();","Return to Server Statistics");</script></li>
                  <li>
				  <script>getURL("server-thread-dump.dsp","javascript:document.htmlform_server_thread_dump.submit();","Generate JVM Thread Dump");</script></li>
                  <li class="listitem"><input type="checkbox" id="ssot" align="right" onclick="executeAction(this)" %ifvar checked equals('true')% checked %endif%><label for="ssot">Show threads that can be canceled or killed at the top of the list.</label></LI>
              </UL>

            <TR>
               <TD>
                  <!-- Thread table -->
                  <IMG SRC="images/blank.gif" height=10 width=10>
                  <TABLE class="tableView" id="servicecon" CELLPADDING=2>
                  
                     <TR>
                        <TD class="heading" colspan=9>System Threads</TD>
                     </TR>
                     <TR>
                        <TH class="oddcol" scope="col">Priority</TH>
                        <TH class="oddcol-l" scope="col">Name</TH>
                        <TH class="oddcol" scope="col">Alive</TH>
                        <TH class="oddcol" scope="col">Daemon</TH>
                        <TH class="oddcol" scope="col">Interrupted</TH>
                        <TH class="oddcol" scope="col">Cancel</TH>
                        <TH class="oddcol" scope="col">Kill</TH>
                        <TH class="oddcol" scope="col">Start Time</TH>
                        <TH class="oddcol" scope="col">Protocol</TH>
                        <script>resetRows();</script>
                     </TR>
					 <script>
					 createForm("htmlform_single_server_thread_dump", "single-server-thread-dump.dsp", "POST", "BODY");
					 setFormProperty("htmlform_single_server_thread_dump", "threadID", "");
					 
					 createForm("htmlform_server_threads_new_interrupt", "server-threads-new.dsp", "POST", "BODY");
					 setFormProperty("htmlform_server_threads_new_interrupt", "action", "");
					 setFormProperty("htmlform_server_threads_new_interrupt", "threadID", "");
					 
					 </script>
					 
                     %loop threads%
                     <TR id="%ifvar cancancel equals('true')%%value $index encode(htmlattr)%run%else%%ifvar cankill equals('true')% %value $index encode(htmlattr)%run%value $index encode(htmlattr)%run%else%%value $index encode(htmlattr)%%endif%%endif%">
                        <script>writeTD('rowdata');</script>%value priority encode(html)%</TD>
                        <td class="field">
                        
						<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write("<A class='imagelink' href='javascript:document.htmlform_single_server_thread_dump.submit();' onClick=\"return populateForm(document.htmlform_single_server_thread_dump, 'threadID', '%value threadid encode(url)%');\">%value name encode(javascript)%</A>");
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A class="imagelink" href="single-server-thread-dump.dsp?threadID=%value threadid encode(url)%&webMethods-wM-AdminUI=true">%value name encode(javascript)%</A>');
					}
					else {
						document.write('<A class="imagelink" href="single-server-thread-dump.dsp?threadID=%value threadid encode(url)%">%value name encode(javascript)%</A>');
					}
		       }
           </script>
				</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar alive equals('true')%<IMG SRC="images/green_check.png" height=13 width=13>%else%-%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar daemon equals('true')%<IMG SRC="images/green_check.png" height=13 width=13>%else%-%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar interrupted equals('true')%<IMG SRC="images/green_check.png" height=13 width=13>%else%-%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cancancel equals('false')%
                                  <IMG SRC="images/green_check.png" height=13 width=13>
                            %else%
                                  %ifvar cancancel equals('true')%

                                    <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write("<A class='imagelink' href='javascript:document.htmlform_server_threads_new_interrupt.submit();' onClick='return confirmAction('cancel', '%value name encode(javascript)%', document.htmlform_server_threads_new_interrupt, 'action', 'interrupt', 'threadID', '%value threadid encode(url)%');'><IMG src='images/yellow_check.png' border=0></A>");
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write("<A class='imagelink' href='server-threads-new.dsp?action=interrupt&threadID=%value threadid encode(url)%&webMethods-wM-AdminUI=true' onClick='return confirmAction('cancel', '%value name encode(javascript)%';'><IMG src='images/yellow_check.png' border=0></A>");
					}
					else {
						document.write("<A class='imagelink' href='server-threads-new.dsp?action=interrupt&threadID=%value threadid encode(url)%' onClick='return confirmAction('cancel', '%value name encode(javascript)%';'><IMG src='images/yellow_check.png' border=0></A>");
					}
		       }
           </script>
                                  %else%
                                    -
                                  %endif%   
                            %endif%</TD>
            <script>writeTD('rowdata');</script>
                %ifvar cankill equals('true')%

                  <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write("<A class='imagelink' href='javascript:document.htmlform_server_threads_new_interrupt.submit();' onClick='return confirmAction('cancel', '%value name encode(javascript)%', document.htmlform_server_threads_new_interrupt, 'action', 'interrupt', 'threadID', '%value threadid encode(url)%');'><IMG src='icons/delete.png' border=0></A>");
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write("<A class='imagelink' href='server-threads-new.dsp?action=kill&threadID=%value threadid encode(javascript)%&webMethods-wM-AdminUI=true' onClick='return confirmAction('kill', '%value name encode(javascript)%');'><IMG src='icons/delete.png' border=0></A>");
					}
					else {
						document.write("<A class='imagelink' href='server-threads-new.dsp?action=kill&threadID=%value threadid encode(javascript)%' onClick='return confirmAction('kill', '%value name encode(javascript)%');'><IMG src='icons/delete.png' border=0></A>");
					}
		       }
           </script>
                %else%
                    %ifvar cankill equals('false')%
                        <IMG src="icons/delete_disabled.png" border=0>
                    %else%  
                        -
                    %endif%             
                %endif%</TD>    
			<script>writeTD('rowdata');</script>%value startedat encode(html)%</TD>	
			<script>writeTD('rowdata');</script>%value protocol encode(html)%</TD>		
                        <script>swapRows();</script>
                     </TR> %endloop%
                  </TABLE>
                  <!-- Threads table --> %endinvoke%  </TD>
            </TR>
         </TABLE>
      </DIV>
   </BODY>
</HTML>

<script>

var stateChanged = false;
var originalURL;
var tempURL = window.location+"";
var index=tempURL.indexOf("?");
if(index!=-1){
    originalURL = tempURL.substring(0,index);
} else {
    originalURL = tempURL ;
}
					
function showRunningServicesOnTop(){

stateChanged=false;
var replaceCount = 2;
var table = document.getElementById('servicecon');
var rows = table.rows;

for(var i=2;i<rows.length;i++){
    if(rows[i].id.indexOf("run") != -1){
        var a = rows[replaceCount].innerHTML;
        rows[replaceCount].innerHTML= rows[i].innerHTML;
        rows[i].innerHTML=a;

		replaceCount++;
    }
}
if(replaceCount==2){
    return;
}
stateChanged = true;
resetRows();
for(var i=2;i<rows.length;i++){
    var cells = rows[i].cells;
    cells[0].className=row+"rowdata";
    cells[1].className=row+"rowdata-l";
    for(var j = 2;j<cells.length;j++){
        cells[j].className=row+"rowdata";
    }
    swapRows();
}
}

function executeAction(checkbox){
    if(checkbox.checked){
        //showRunningServicesOnTop();
        refreshPage();
    } else {
        refreshPage();
        //window.location.href=originalURL;
    }
}

function refreshPage(){
    var checkBox = document.getElementById("ssot");
    var url = originalURL;
	
	
	
    if(is_csrf_guard_enabled && needToInsertToken) {
		
		createForm("htmlform_url", url, "POST", "BODY");
		if(checkBox.checked)
		{
			setFormProperty("htmlform_url", "checked", "true");
		}
		else 
		{
			setFormProperty("htmlform_url", "checked", "false");
		}
		
        setFormProperty("htmlform_url", _csrfTokenNm_, _csrfTokenVal_);
		document.htmlform_url.submit();
    } 
	else
	{
		if(checkBox.checked)
    {
        url=url+"?checked=true";
    }
    else 
	{
        url=url+"?checked=false";
	}
	%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
	var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
	if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
		url += "&webMethods-wM-AdminUI=true";
	}
	window.location.href=url;
		
	}
	
	}

%ifvar checked equals('true')% showRunningServicesOnTop(); %endif%

</script>
