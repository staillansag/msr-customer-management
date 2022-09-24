<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js"></script>
  
  <style>
  .disabledLink
  {
    color:#0D109B;
  }
  </style>

  <script language ="javascript">
  
  </script>
  
</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMSsetScrn');">
  <table width="100%">
  
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; Publishable Document Type Sync Report</td>
    </tr>
    
    %switch action%
    %case 'push'%
      %invoke wm.server.ed:submit%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan=2>Errors: %value errors encode(html)%</TD>
        </TR>
        <TR>    
          <TD class="message" colspan=2>Warnings: %value warnings encode(html)%</TD>
        </TR>
        <TR>
          <TD class="message" colspan=2>Success: %value successfulPDTs encode(html)%</TD>
        </TR>
      %endinvoke%
    %end%
    
    %invoke wm.server.messaging:getPublishableDocumentTypeReport%
    
    <!-- Navigation Menu -->
    
    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
		  createForm("htmlform_settings_wm_pdt", "settings-wm-pdt.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-messaging.dsp", "javascript:document.htmlform_settings_messaging.submit();", "Return to Messaging");</script>
		  
		  </li>
          <li class="listitem">
		  <script>getURL("settings-wm-pdt.dsp", "javascript:document.htmlform_settings_wm_pdt.submit();", "Refresh Page");</script>
		  
		  </li>
        </ul>
      </td>                                                                                                                       
    </tr>
    
    <tr>
      <td>

        <table class="tableView" width="100%">

          <!-- Headers -->

          <tr>
            <td class="heading" colspan=8>Publishable Document Type List</td>
          </tr>

          <tr>
            <TH class="oddcol-l" scope="col">Action</TH>
            <TH class="oddcol-l" scope="col">Document Name</TH>
            <TH class="oddcol-l" scope="col">Alias Name</TH>
            <TH class="oddcol-l" scope="col">Status</TH>
            <TH class="oddcol-l" scope="col">Channel Name</TH>
            
          </tr> 
          
          %loop pdts%
            <tr>      
            
              <!-- action -->
              %ifvar isConnected equals('false')%              
                  <script>writeTD("row-l");</script>Push</td> 
              %else%
                  <script>writeTD("row-l");</script>
				  <script>
				  createForm("htmlform_settings_wm_pdt_push_%value $index%", "settings-wm-pdt.dsp", "POST", "BODY");
				  setFormProperty("htmlform_settings_wm_pdt_push_%value $index%", "action", "push");
				  setFormProperty("htmlform_settings_wm_pdt_push_%value $index%", "nsName", "%value nsName encode(url)%");
				  </script>
				  <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_settings_wm_pdt_push_%value $index%.submit();">Push</a>');
						} else {
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="settings-wm-pdt.dsp?action=push&nsName=%value nsName encode(url)%&webMethods-wM-AdminUI=true">Push</a>');
							}
							else {
								document.write('<a href="settings-wm-pdt.dsp?action=push&nsName=%value nsName encode(url)%">Push</a>');
							}
						}
					</script>
				  </td> 
              %endif%  
                
              <!-- nsName -->   
              <script>writeTD("row-l");</script>%value nsName encode(html)%</td>
              
              <!-- aliasName -->              
              <script>writeTD("row-l");</script>%value aliasNameDisplay encode(html)%</td>      
              
              <!-- status -->
              
              <script>writeTD("row-l");</script>
                %switch syncState/status%
                  %case '2'%
                    IN_SYNC
                  %case '3'%
                    OUT_OF_SYNC
                  %case '4'%
                    DELETED_ON_PROVIDER
                  %case '5'%
                    CREATED_ON_IS                  
                  %end%
              </td>    
              
              <!-- eventDisplayName -->              
              <script>writeTD("row-l");</script>%value eventDisplayName encode(html)%</td>   
              
              <script>swapRows();</script>
            </tr>
          %endloop%
          
        </table>

      </td>
    </tr>
                
   %onerror%
   
   <tr>
     <td class="message" colspan=2>G%value errorService encode(html)%<br>%value error encode(html)%<br>%value errorMessage encode(html)%<br></td>
   </tr>
                  
   %endinvoke%

  </table>
</body>
</html>
