<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="client.js"></script>
  <script src="acls.js"></script>
  <script type="text/javascript" SRC="webMethods.js"></script>
 
  <script LANGUAGE="JavaScript">  
     function confirmDisable (feature)
      {
         var s1 = "OK to disable the `"+feature+"' feature?";
         return confirm (s1);
      }
      function confirmEnable (feature)
      {
         var s1 = "OK to enable the `"+feature+"' feature?";
         return confirm (s1);
      }
  </script>
</head>

<body onLoad="setNavigation('settings-parsing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EnhancedXMLParsing');">

  <table name="pagetable" align='left' width="100%">

    <tr>
      <td class="breadcrumb" colspan="4">Settings &gt; Enhanced XML Parsing </td>
    </tr>

    %ifvar action equals('change')%
      %invoke wm.server.parsing:saveSettings%
      %onerror%
        <tr><td colspan="2" class="message">error: %value errorMessage encode(html)%</td></tr>
      %endinvoke%
    %endif%
     
    %ifvar action equals('enable')%
      %invoke wm.server.parsing:toggleFeature%
      %onerror%
        <tr><td colspan="2" class="message">error: %value errorMessage encode(html)%</td></tr>
      %endinvoke%
    %endif%
  
    %ifvar action equals('disable')%
      %invoke wm.server.parsing:toggleFeature%
      %onerror%
        <tr><td colspan="2" class="message">error: %value errorMessage encode(html)%</td></tr>
      %endinvoke%
    %endif%

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_parsing_edit", "settings-parsing-edit.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-parsing-edit.dsp","javascript:document.htmlform_settings_parsing_edit.submit();","Edit Enhanced XML Parsing Settings")</script>
		  </li>
        </ul>
      </td>
    </tr>
    
    <tr>
      <td>
        <table class="tableView" width="60%">
          %invoke wm.server.parsing:getProperties%
            
            <tr>
              <td class="heading" colspan=2>Enhanced Parser Settings</td>
            </tr>
            
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Default partition size</td>
              <script>writeTDWidth("rowdata-l", "60%")</script>%value parserSettings/defaultPartitionBytes encode(html)%
              <script>swapRows();</script>
              </td>
            </tr>         
          %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage encode(html)%</td></tr>
          %endinvoke%
        </table>
      </td>
      
    </tr> 
      
    <tr>
      <td>
        <table class="tableView" width="60%">
          %invoke wm.server.parsing:getProperties%
            <tr>
              <td class="heading" colspan=2>Caching</td>
            </tr>
            
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Enabled</td>
              <script>writeTDWidth('rowdata-l', "60%");</script>
              
              %ifvar parserSettings/useCache equals('true')%
				<script>
			    createForm("htmlform_settings_parsing_disable", "settings-parsing.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_parsing_disable", "action", "disable");
				setFormProperty("htmlform_settings_parsing_disable", "feature", "usecache");
			    </script>
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A class="imagelink" HREF="javascript:document.htmlform_settings_parsing_disable.submit();" ONCLICK="return confirmDisable(\'Caching\');"><IMG SRC="images/green_check.png" border="0" height=13>&nbspYes</A>');
					} else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A class="imagelink" HREF="settings-parsing.dsp?action=disable&feature=usecache&webMethods-wM-AdminUI=true" ONCLICK="return confirmDisable(\'Caching\');"><IMG SRC="images/green_check.png" border="0" height=13>&nbspYes</A>');
						}
						else {
							document.write('<A class="imagelink" HREF="settings-parsing.dsp?action=disable&feature=usecache" ONCLICK="return confirmDisable(\'Caching\');"><IMG SRC="images/green_check.png" border="0" height=13>&nbspYes</A>');
						}
					}
				</script>
                
              %else%
				<script>
			    createForm("htmlform_settings_parsing_enable", "settings-parsing.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_parsing_enable", "action", "enable");
				setFormProperty("htmlform_settings_parsing_enable", "feature", "usecache");
			    </script>
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<A class="imagelink" HREF="javascript:document.htmlform_settings_parsing_enable.submit();" ONCLICK="return confirmEnable(\'Caching\');">No</A>');
					} else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A class="imagelink" HREF="settings-parsing.dsp?action=enable&feature=usecache&webMethods-wM-AdminUI=true" ONCLICK="return confirmEnable(\'Caching\');">No</A>');
						}
						else {
							document.write('<A class="imagelink" HREF="settings-parsing.dsp?action=enable&feature=usecache" ONCLICK="return confirmEnable(\'Caching\');">No</A>');
						}
					}
				</script>
                
              %endif%</td>
              <script>swapRows();</script>
              </td>
            </tr>

            <tr>
              <script>writeTDWidth("row-l", "30%")</script>Maximum heap allocation for all documents combined</td>
              <script>writeTDWidth("rowdata-l", "70%")</script>%value parserSettings/maximumHeapBytes encode(html)%
              <script>swapRows();</script>
              </td>
            </tr>
    
            <tr>
              <script>writeTD("row-l")</script>Maximum heap allocation for any single document</td>
              <script>writeTDWidth("rowdata-l", "30%")</script>%value parserSettings/maximumDocBytes encode(html)%
              <script>swapRows();</script>
              </td>
            </tr>
            
            %ifvar parserSettings/failureMessage%
              <tr>
                <script>writeTD("row-l")</script>Warning! The cache failed to initialize properly</td>
                <script>writeTDWidth("rowdata-l", "30%")</script>%value parserSettings/failureMessage encode(html)%
                <script>swapRows();</script>
                </td>
              </tr>
            %endif%
           
          %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage encode(html)%</td></tr>
          %endinvoke%
        </table>
      </td>
      
    </tr> 
       
    <tr>  
      <td>
        <table class="tableView" width="60%">
          %invoke wm.server.parsing:getProperties%

            <tr>
              <td class="heading" colspan=2>%value parserSettings/offheapTitle%</td>
            </tr>

            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Enabled</td>
              <script>writeTD('rowdata-l');</script>
              
              %ifvar parserSettings/useBigMemory equals('true')%
				<script>
			    createForm("htmlform_settings_parsing_disable_bigmemory", "settings-parsing.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_parsing_disable_bigmemory", "action", "disable");
				setFormProperty("htmlform_settings_parsing_disable_bigmemory", "feature", "bigmemory");
			    </script>
				<script>
				    if(is_csrf_guard_enabled && needToInsertToken) {
					    document.write('<A class="imagelink" HREF="javascript:document.htmlform_settings_parsing_disable_bigmemory.submit();" ONCLICK="return confirmDisable(\'%value parserSettings/offheapTitle% caching\');"><IMG SRC="images/green_check.png" border="0" height=13>&nbspYes</A>');
				    } else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A class="imagelink" HREF="settings-parsing.dsp?action=disable&feature=bigmemory&webMethods-wM-AdminUI=true" ONCLICK="return confirmDisable(\'%value parserSettings/offheapTitle% caching\');"><IMG SRC="images/green_check.png" border="0" height=13>&nbspYes</A>');
						}
						else {
							document.write('<A class="imagelink" HREF="settings-parsing.dsp?action=disable&feature=bigmemory" ONCLICK="return confirmDisable(\'%value parserSettings/offheapTitle% caching\');"><IMG SRC="images/green_check.png" border="0" height=13>&nbspYes</A>');
						}
			  	    }
				</script>
                
              %else%
				<script>
			    createForm("htmlform_settings_parsing_enable_bigmemory", "settings-parsing.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_parsing_enable_bigmemory", "action", "enable");
				setFormProperty("htmlform_settings_parsing_enable_bigmemory", "feature", "bigmemory");
			    </script>
				<script>
					if(is_csrf_guard_enabled && needToInsertToken) {
					   	document.write('<A class="imagelink" HREF="javascript:document.htmlform_settings_parsing_enable_bigmemory.submit();" ONCLICK="return confirmEnable(\'%value parserSettings/offheapTitle% caching\');">No</A>');
					} else {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.write('<A class="imagelink" HREF="settings-parsing.dsp?action=enable&feature=bigmemory&webMethods-wM-AdminUI=true" ONCLICK="return confirmEnable(\' %value parserSettings/offheapTitle% caching\');">No</A>');
						}
						else {
							document.write('<A class="imagelink" HREF="settings-parsing.dsp?action=enable&feature=bigmemory" ONCLICK="return confirmEnable(\' %value parserSettings/offheapTitle% caching\');">No</A>');
						}
					}
				</script>
                
              %endif%</td>
              <script>swapRows();</script>
              </td>
            </tr>
    
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Maximum %value parserSettings/offheapTitle% allocation</td>
              <script>writeTDWidth("rowdata-l", "50")</script>%value parserSettings/maximumBigMemoryBytes encode(html)%
              <script>swapRows();</script>
              </td>
            </tr>
     
          %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage encode(html)%</td></tr>
          %endinvoke%
        </table>
      </td>
    </tr>
    
    <tr>  
      <td>
        <table class="tableView" width="60%">
          %invoke wm.server.parsing:getProperties%

            <tr>
              <td class="heading" colspan=2>Peak Usage Statistics</td>
            </tr>
    
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Peak heap allocation for all documents combined </td>
              <script>writeTDWidth("rowdata-l", "50")</script>%value parserSettings/peakSystemLocalMBytes encode(html)%m
              <script>swapRows();</script>
              </td>
            </tr>
            
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Peak heap allocation for any single document </td>
              <script>writeTDWidth("rowdata-l", "50")</script>%value parserSettings/peakDocumentLocalMBytes encode(html)%m
              <script>swapRows();</script>
              </td>
            </tr>
            
            <tr>
              <script>writeTDWidth("row-l", "40%")</script>Peak BigMemory use </td>
              <script>writeTDWidth("rowdata-l", "50")</script>%value parserSettings/peakBigMemoryUseMBytes encode(html)%m
              <script>swapRows();</script>
              </td>
            </tr>
     
          %onerror%
            <tr><td colspan="2" class="message">error: %value errorMessage encode(html)%</td></tr>
          %endinvoke%
        </table>
      </td>
    </tr>
    
  </table>
</body>

</html>
