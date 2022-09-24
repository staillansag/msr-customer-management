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

    <SCRIPT LANGUAGE="JavaScript">
    var agent = navigator.userAgent.toLowerCase();   
    var ie = (agent.indexOf("msie") != -1);

    var margin = 2;
      
    function writeLogLevelOptions (select)
    {
    	if (! isValidLevel(select)){
    		 select = "Error";
    	}
			 
	    for (i = 7; i > -1; i--) {

 			   if (i != 6 || select == getLogLevelDisplayName(6) ){
		 			   w("<option ");
		 			   
		 			   if (select == getLogLevelDisplayName(i)){
		 			  		w("selected ");
		 			   }
		 			   
		 			   w("value=\"");
		 			   w(getLogLevelDisplayName(i));
		 			   w("\">");
		 			   w(getLogLevelDisplayName(i));
		 			   w("</option>");
 			   }
        }
    }
    
    function isValidLevel(select){
    	
    	for (i=0; i<8 ; i++){
    		if (getLogLevelDisplayName(i) == select) {
    			return true;
    		}
    	}    	
    	return false;
    }
    
    function getLogLevelDisplayName(level){
    	switch (level) {
		    case 0:
		        return "Trace";
		    case 1:
		        return "Debug";
		    case 2:
		        return "Info";
		    case 3:
		        return "Warn";
		    case 4:
		        return "Error";
		    case 5:
		        return "Fatal";
		    case 6:
		        return "All";
		    case 7:
		        return "Off";
			} 
    }

	function writeTraceLogLevelOptions (select)
    {
    	if (! isValidTraceLevel(select)){
    		 select = "Off";
    	}
    	
	    for (i = 2; i > -1; i--) {
			   
		 			   w("<option ");
		 			   
		 			   if (select == getTraceLogLevelDisplayName(i)){
		 			  		w("selected ");
		 			   }
		 			   
		 			   w("value=\"");
		 			   w(getTraceLogLevelDisplayName(i));
		 			   w("\">");
		 			   w(getTraceLogLevelDisplayName(i));
		 			   w("</option>");
        }
    }
    
    function isValidTraceLevel(select){	
    	for (i=0; i<3 ; i++){
    		if (getLogLevelDisplayName(i) == select) {
    			return true;
    		}
    	}    	
    	return false;
    }
    
    function getTraceLogLevelDisplayName(level){
    	switch (level) {
		    case 0:
		        return "Trace";
		    case 1:
		        return "Info";
		    case 2:
		        return "Off";
			} 
    }
	  
    function onEdit ()
    {
	  if(is_csrf_guard_enabled && needToInsertToken) {
		createForm("htmlform_settings_um_logging", "settings-um-logging.dsp", "POST", "HEAD");
		setFormProperty("htmlform_settings_um_logging", "doc", "edit");
        setFormProperty("htmlform_settings_um_logging", _csrfTokenNm_, _csrfTokenVal_);
		document.htmlform_settings_um_logging.submit();
      } else {
		  %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		  var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
			  document.location.replace("settings-um-logging.dsp?doc=edit&webMethods-wM-AdminUI=true");
		  }
		  else {
			  document.location.replace("settings-um-logging.dsp?doc=edit");
		  }
	  }
    }

    function doSubmit()
    {
    }
    
    </SCRIPT>
  </HEAD>

  %ifvar doc equals('edit')%
  <BODY onLoad="setNavigation('settings-um-logging.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditUMClientLoggerScrn');">
  %else%
  <BODY onLoad="setNavigation('settings-um-logging.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_UMClientLoggerScrn');">
  %endif%
    <TABLE width="100%">
        <TR>
           <TD class="breadcrumb" colspan=2>
                Settings &gt;
                Logging

                %ifvar doc equals('edit')%
                    &gt; Edit UM Client Logger Details
                %else%
                    &gt; View UM Client Logger Details
                %endif%
           </TD>
        </TR>
 %ifvar action equals('change')%
    %invoke wm.server.messaging:setUMLoggerSettings%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
        %endif%
    %endinvoke%
%endif%

     %invoke wm.server.query:getSettings%
          
                   <TR>
                    <TD colspan=2>
                      <ul class="listitems">
                        <li class="listitem">
						<script>
						createForm("htmlform_settings_auditing", "settings-auditing.dsp", "POST", "BODY");
						</script>
						<script>getURL("settings-auditing.dsp","javascript:document.htmlform_settings_auditing.submit();","Return to Logger List")</script></li>
        %ifvar ../doc equals('edit')%
						<script>
						createForm("htmlform_settings_um_logging", "settings-um-logging.dsp", "POST", "BODY");
						</script>
                        <LI>
						<script>getURL("settings-um-logging.dsp","javascript:document.htmlform_settings_um_logging.submit();","Return to View UM Client Logger Details")</script></li>
        %else%
								        <LI><a href="javascript:onEdit();" >Edit UM Client Logger</a></li>
        %endif%
                      </UL>
                    </TD>
                   </TR>
        <TR>
        <TD>

          <TABLE class="tableView">
            <FORM name="logform" action="settings-um-logging.dsp" method="POST">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

<TR>
 <TD colspan="3" style="border-collapse: collapse; padding: 0; margin: 0; border: none">
  <TABLE id="Default" style="border-collapse: collapse; padding: 0; margin: 0; border: none">  
            
	<TR>
      <TD CLASS="heading" colspan="2" width="360">
	    UM Client Log Configuration<SPAN  style='font-family:"Roboto",Arial,Sans-serif;font-size:14;font-style:italic'>&nbsp;</SPAN>
	  </TD>
	<TR>
	  
    <script>resetRows();</script>

    <TR>
	  <TD>
	    <label for="logLevel">Log Level</label>
	  </TD>
	  <TD>
 	    %ifvar ../doc equals('edit')%
          <select name="watt.um.clientLog.level" id="logLevel" >
	 	    <script>writeLogLevelOptions("%value watt.um.clientLog.level encode(html)%");</script>
	 	  </select>
        %else%
	   	  <script>w("%value watt.um.clientLog.level encode(html)%");</script>
 	    %endif%
 	  </TD>
    </TR>

    <TR> 
	  <TD>
	    <label for="logSize">Log Size</label>
	  </TD>
	  <TD>
 	    %ifvar ../doc equals('edit')%
 		  <script>writeEdit("%value ../doc  encode(javascript)%", "watt.um.clientLog.size", %value watt.um.clientLog.size encode(html_javascript)%,"logSize"); </script>&nbsp;MB
        %else%
	 	  <script>w(%value watt.um.clientLog.size encode(html)%);</script>&nbsp;MB
 	    %endif%
 	  </TD> 
 	</TR>
    
	<TR> 
      <TD>
	    <label for="logDepth">Log Depth</label>
	  </TD>
	  <TD>
 	    %ifvar ../doc equals('edit')%
 		  <script>writeEdit("%value ../doc  encode(javascript)%", "watt.um.clientLog.fileDepth", "%value watt.um.clientLog.fileDepth encode(html_javascript)%","logDepth"); </script>
        %else%
	 	  %value watt.um.clientLog.fileDepth encode(html)%
 	    %endif%
 	  </TD> 
 	</TR>
	
	<TR>
      <TD CLASS="heading" colspan="2" width="360">UM Client Event Lifecycle Log Configuration<SPAN style='font-family:"Roboto",Arial,Sans-serif;font-size:14;font-style:italic'>&nbsp;</SPAN></TD>
	<TR>
	
	<TR> 
	  <TD>
	    <label for="traceLogLevel">Trace Store Log Level</label>
	  </TD> 
      <TD>
 	    %ifvar ../doc equals('edit')%
          <select name="watt.um.clientTraceLog.level" id="traceLogLevel" >
	 	    <script>writeTraceLogLevelOptions("%value watt.um.clientTraceLog.level encode(html)%");</script>
	 	  </select>
        %else%
	   	  <script>w("%value watt.um.clientTraceLog.level encode(html)%");</script>
 	    %endif%
 	  </TD>	  
 	</TR>
	
	<TR> 
	  <TD>
	    <label for="traceLogStores">Trace Stores (comma-delimited list or *)</label>
	  </TD>
	  <TD>
 	    %ifvar ../doc equals('edit')%
 		  <script>writeEdit("%value ../doc  encode(javascript)%", "watt.um.clientTraceLog.stores", "%value watt.um.clientTraceLog.stores encode(html_javascript)%","logDepth"); </script>
        %else%
	 	  %value watt.um.clientTraceLog.stores encode(html)%
 	    %endif%
 	  </TD> 
 	</TR>
	
	<TR> 
	  <TD>
	    <label for="traceLogFolderSize">Trace Folder Log Size</label>
	  </TD>
	  <TD>
 	    %ifvar ../doc equals('edit')%
 		  <script>writeEdit("%value ../doc  encode(javascript)%", "watt.um.clientTraceLog.folderLogSize", "%value watt.um.clientTraceLog.folderLogSize encode(html_javascript)%","logDepth"); </script>&nbsp;MB
        %else%
	 	  %value watt.um.clientTraceLog.folderLogSize encode(html)%&nbsp;MB
 	    %endif%
 	  </TD> 
 	</TR>
	
	<TR> 
	  <TD>
	    <label for="traceLogStoreSize">Trace Store Log Size</label>
	  </TD>
	  <TD>
 	    %ifvar ../doc equals('edit')%
 		  <script>writeEdit("%value ../doc  encode(javascript)%", "watt.um.clientTraceLog.storeLogSize", "%value watt.um.clientTraceLog.storeLogSize encode(html_javascript)%","logDepth"); </script>&nbsp;MB
        %else%
	 	  %value watt.um.clientTraceLog.storeLogSize encode(html)%&nbsp;MB
 	    %endif%
 	  </TD> 
 	</TR>
	
	
  </TABLE>
  </TD>
 </TR>

        %ifvar ../doc equals('edit')%
          <TR>
              <TD colspan=3 class="action">
              		<INPUT type="hidden" name="action" value="change">
                    <INPUT onclick="doSubmit()" type="submit" value="Save Changes" name="submit">
              </TD>
          </TR>
         %endif%


 %endinvoke%
          </TABLE> </TD>
      </TR>
    </TABLE>
  </DIV>
</HTML>
