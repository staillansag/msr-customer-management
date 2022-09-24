<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>
      webMethods_wM_AdminUI = 'true';
    </script>
  %endif%
  <script src="webMethods.js"></script>
  <script language ="javascript">
   var aliasAry = [];
  function confirmDelete(index) {
	var msg = 'Are you sure you want to delete JNDI Provider Alias '+aliasAry[index];
	return confirm(msg);  
  }
  </script>
</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JNDIsetScrn');">

  <table width="100%">
    <tr><td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JNDI Settings</td></tr>

    %switch action%
      %case 'create'%
        %invoke wm.server.jndi:setJNDIAliasData%    
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value message encode(html)%</td></tr>
        %onerror%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
        %endinvoke%
        %rename jndiAliasName createdAliasName%
    
      %case 'delete'%
        %invoke wm.server.jndi:deleteJNDIAliasData%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value message encode(html)%</td></tr>
        %onerror%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
        %endinvoke%
        %rename jndiAliasName deletedAliasName%
      
      %case 'test'%
        %invoke wm.server.jndi:testJNDILookup%
          
          
          %loop messages%
          
           
           <tr><td class="message" colspan=2>%value messages encode(html)%</td></tr>
           
           %endloop%
           
        
        %onerror%
          <tr><td colspan="2">&nbsp;</td></tr>
          <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
        %endinvoke%
        %rename jndiAliasName testedAliasName%
      %end%
    
    %invoke wm.server.jndi:getJNDIAliasData%
    
    %onerror%
      <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
    %endinvoke%

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
		  createForm("htmlform_settings_jndi_create", "settings-jndi-create.dsp", "POST", "BODY");
		  </script>
      %ifvar webMethods-wM-AdminUI% 
      %else%
          <li class="listitem"><script>getURL("settings-messaging.dsp", "javascript:document.htmlform_settings_messaging.submit();", "Return to Messaging");</script>
		      </li>
      %endif%
          <li class="listitem"><script>getURL("settings-jndi-create.dsp", "javascript:document.htmlform_settings_jndi_create.submit();", "Create JNDI Provider Alias");</script>
		  </li>
        </ul>
      </td>
    </tr>

    <tr>
      <td>
        <table class="tableView" width="100%">

          <tr>
            <td class="heading" colspan=4>JNDI Provider Alias Definitions</td>
          </tr>
 
          <!-- Row Heading -->
 
          <tr>
            <th class="oddcol-l" scope="col">JNDI Alias Name</th>
            <th class="oddcol-l" scope="col">Description</th>
            <th class="oddcol" scope="col">Test Lookup</th>
            <th class="oddcol" scope="col">Delete</th>
          </tr> 
          
          %loop aliasDataAry%
		   <script> aliasAry['%value $index%'] = '%value aliasName encode(javascript)%'; </script>
   
          <tr>
          
            <!-- Alias Name -->
            
            <script>writeTD("row-l");</script>
			<script>
		    createForm("htmlform_settings_jndi_detail_jndi_alias_%value $index%", "settings-jndi-detail.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_jndi_detail_jndi_alias_%value $index%", "jndiAliasName", "%value aliasName %");
		    </script>
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<a href="javascript:document.htmlform_settings_jndi_detail_jndi_alias_%value $index%.submit();">%value aliasName encode(html)%</a>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
						document.write('<a href="settings-jndi-detail.dsp?jndiAliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true">%value aliasName encode(html)%</a>');
					}
					else {
						document.write('<a href="settings-jndi-detail.dsp?jndiAliasName=%value aliasName encode(url)%">%value aliasName encode(html)%</a>');
					}
				}
			</script>
			</td>
            
            <!-- Description -->
            
            <script>writeTD("row-l");</script>%value description encode(html)%</td>
            
            <!-- Test link -->
            
            <script>writeTD("rowdata");</script>
			<script>
		    createForm("htmlform_settings_jndi_test_jndi_alias_%value $index%", "settings-jndi.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_jndi_test_jndi_alias_%value $index%", "action", "test");
			setFormProperty("htmlform_settings_jndi_test_jndi_alias_%value $index%", "jndiAliasName", "%value aliasName %");
		    </script>
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<a href="javascript:document.htmlform_settings_jndi_test_jndi_alias_%value $index%.submit();"><IMG src="icons/checkdot.png" border="none" alt="JNDI Alias %value aliasName encode(url)%"></a>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
						document.write('<a href="settings-jndi.dsp?action=test&jndiAliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true"><IMG src="icons/checkdot.png" border="none" alt="JNDI Alias %value aliasName encode(url)%"></a>');
					}
					else {
						document.write('<a href="settings-jndi.dsp?action=test&jndiAliasName=%value aliasName encode(url)%"><IMG src="icons/checkdot.png" border="none" alt="JNDI Alias %value aliasName encode(url)%"></a>');
					}
				}
			</script>			
			</d>
            
            <!-- Delete link -->
            
            <script>writeTD("rowdata");</script>
			<script>
		    createForm("htmlform_settings_jndi_delete_jndi_alias_%value $index%", "settings-jndi.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_jndi_delete_jndi_alias_%value $index%", "action", "delete");
			setFormProperty("htmlform_settings_jndi_delete_jndi_alias_%value $index%", "jndiAliasName", "%value aliasName %");
		    </script>
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<a href="javascript:document.htmlform_settings_jndi_delete_jndi_alias_%value $index%.submit();" onClick="return confirmDelete(\'%value $index%\')"><img style="width: 13px; height: 13px;" alt="JNDI Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
				} else {
					%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
						document.write('<a href="settings-jndi.dsp?action=delete&jndiAliasName=%value aliasName encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDelete(\'%value $index%\')"> <img style="width: 13px; height: 13px;" alt="JNDI Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
					}
					else {
						document.write('<a href="settings-jndi.dsp?action=delete&jndiAliasName=%value aliasName encode(url)%" onClick="return confirmDelete(\'%value $index%\')"> <img style="width: 13px; height: 13px;" alt="JNDI Alias %value aliasName encode(url)%" border="0" src="icons/delete.png"></a>');
					}
				}
			</script>
              &nbsp;
            </td>
            
          </tr>
          
          %ifvar ../testedAliasName vequals(aliasName)%
          
            <tr>
              <script>writeTDspan("row-l", 4);</script>
                %loop ../jndiLookupData%
                  %value nameClassPair encode(html)%<br>
                %endloop%
              </td>
            </tr>
            
          %endif%
          <script>swapRows();</script>
          %endloop%
          
        </table>   
      </td>
    </tr>
    
  </table>
</body>
</html>
