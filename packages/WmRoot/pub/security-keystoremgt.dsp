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

    <TITLE>Integration Server -- Keystore Management</TITLE>
    <SCRIPT LANGUAGE="JavaScript">
        //scrpt to delete the key store with the given name
        function deleteKeyStore (keyStoreName, typeVal) {
            
            var msg = "";
            if (typeVal == "key")
                msg = "OK to delete keystore alias '"+keyStoreName+"'?";
            else
                msg = "OK to delete truststore alias '"+keyStoreName+"'?";
            if (confirm (msg)) {
                    document.deleteform.keyStoreName.value = keyStoreName;
                     document.deleteform.type.value = typeVal;
                    document.deleteform.submit();
                      return false;
            } else return false;
          }
      
        function viewKeyStore (errorMessage, keyStoreName,keyStoreType,keyStoreLocation,keyStoreProvider,typeVal) {         
                  document.viewform.keyStoreName.value = keyStoreName;
                  document.viewform.keyStoreType.value = keyStoreType;
                  document.viewform.keyStoreLocation.value = keyStoreLocation;
                  document.viewform.keyStoreProvider.value = keyStoreProvider;
                  document.viewform.type.value = typeVal;
                  document.viewform.errorMessage.value = errorMessage;                  
                  document.viewform.submit();
                  return true;          
          }
          
          function confirmReload(name, type)
          {
                var msg = "";
            if (type == "key")
                msg = "OK to reload keystore alias '"+name+"'?";
            else
                msg = "OK to reload truststore alias '"+name+"'?";
                
              if (confirm(msg))
            {
                document.reloadform.keyStoreName.value = name;
                document.reloadform.type.value = type;
                document.reloadform.submit();
                return false;
            }
            else
             return false;                      
          }
    </SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('security-keystoremgt.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_KeystoreScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan="2"> Security &gt; Keystore </TD>
      </TR>
      
      %ifvar mode%
          %switch mode%
          %case 'add'%
                %invoke wm.server.security.keystore:createStore%
                      %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
	      	          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                      %endif%
                %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
	      	          <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                %endinvoke%
            
          %case 'edit'%
                                  
                %invoke wm.server.security.keystore:createStore%
                      %ifvar message%
                        <tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                      %endif%
                %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
	      	          <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                %endinvoke%
       %case 'edit_add'%
                                  
                %invoke wm.server.security.keystore:createStore%
                      %ifvar message%
                        <tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                      %endif%
                %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
	      	          <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                %endinvoke%
         %case 'edit_edit'%
                                  
                %invoke wm.server.security.keystore:createStore%
                      %ifvar message%
                            <tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                      %endif%
                %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
	      	          <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                %endinvoke%
         
         %case 'reload'%
             %invoke wm.server.security.keystore:refreshStore%
                     %ifvar message%
                            <tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                      %endif%
             %onerror%
                             <tr><td colspan="2">&nbsp;</td></tr>
	      	          		<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
               %endinvoke% 

        %case 'delete'%
             %invoke wm.server.security.keystore:deleteStore%
                      %ifvar message%
                            <tr><td colspan="2">&nbsp;</td></tr>
	      	          	<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                      %endif%
               %endinvoke% 
         %endswitch%
     %endif%

      <TR>
        <TD colspan="2">
          <ul class="listitems">
			<script>
			createForm("htmlform_security_keystoremgt_keystore", "security-keystoremgt-keystore.dsp", "POST", "BODY");
			setFormProperty("htmlform_security_keystoremgt_keystore", "type", "key");
			setFormProperty("htmlform_security_keystoremgt_keystore", "mode", "add");
			createForm("htmlform_security_keystoremgt_truststore", "security-keystoremgt-keystore.dsp", "POST", "BODY");
			setFormProperty("htmlform_security_keystoremgt_truststore", "type", "trust");
			setFormProperty("htmlform_security_keystoremgt_truststore", "mode", "add");
			createForm("htmlform_add_javasecurity_provider", "add-javasecurity-provider.dsp?", "POST", "BODY");
			</script>
            <LI class="listitem">
			<script>getURL("security-keystoremgt-keystore.dsp?type=key&mode=add","javascript:document.htmlform_security_keystoremgt_keystore.submit();","Create Keystore Alias");</script></li>
            <LI class="listitem">
			<script>getURL("security-keystoremgt-keystore.dsp?type=trust&mode=add","javascript:document.htmlform_security_keystoremgt_truststore.submit();","Create Truststore Alias");</script></li>
            <LI class="listitem">
			<script>getURL("add-javasecurity-provider.dsp?","javascript:document.htmlform_add_javasecurity_provider.submit();","Add Security Provider");</script></li>            
          </UL>
        </TD>
      </TR>
      <TR>
        <td>
            <table width="100%">
                <tr>
                    <td>
                        <TABLE  class="tableView" width="100%">
           
                <TR>
                  <TD class="heading" colspan="8">Keystore List</TD>
                </TR>

			    <TR>
			      <TH scope="col" CLASS="oddcol-l">Alias</TH>
			      <TH scope="col" CLASS="oddcol">Type</TH>
			      <TH scope="col" CLASS="oddcol">Provider</TH>
				  <TH scope="col" CLASS="oddcol">Location</TH>			      
			      <!-- <TH scope="col" CLASS="oddcol">Execute ACL</TH> -->
				  <TH scope="col" CLASS="oddcol">Loaded</TH>			      			      
				  <TH scope="col" CLASS="oddcol">Reload</TH>			      			      				  
			      <TH scope="col" CLASS="oddcol">Delete</TH>
                </TR>
                
                %invoke wm.server.security.keystore:listKeyStores%
                %loop keyStores%
                    <TR>
					  <script>
					  createForm("htmlform_keystore_management_%value $index%", "security-keystoremgt.dsp", "POST", "BODY");
					  </script>
                      <script>writeTD("rowdata-l");</script>               
					  <A HREF="javascript:viewKeyStore('%value errorMessage encode(javascript)%','%value keyStoreName encode(javascript)%', '%value keyStoreType encode(javascript)%', '%value keyStoreLocation encode(javascript)%','%value keyStoreProvider encode(javascript)%','key');">
					    %value keyStoreName encode(html)%
                      </A>                
                      </TD>
				      <script>writeTD("rowdata");</script>%value keyStoreType encode(html)%</TD>
				      <script>writeTD("rowdata");</script>%value keyStoreProvider encode(html)%</TD>
				      <script>writeTD("rowdata");</script>%value keyStoreLocation encode(html)% </TD>				                    
   				      <!-- <script>writeTD("rowdata");</script>%value acl encode(html)%</TD> -->
                         <script>writeTD("rowdata");</script>%ifvar isLoaded equals('true')%<IMG SRC="images/green_check.png">Yes%else%No%endif%</TD>                                                                
   				      <script>writeTD("rowdata");</script>					  
					  <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A class="imagelink" HREF="javascript:document.htmlform_keystore_management_%value $index%.submit();"  ONCLICK="return confirmReload(\'%value keyStoreName encode(javascript)%\', \'key\');"><IMG SRC="icons/icon_reload.png" alt="Keystore Alias %value keyStoreName%" border="0"alt="Keystore"></A>');
		       } else {
			document.write('<A class="imagelink" HREF=""  ONCLICK="return confirmReload(\'%value keyStoreName encode(javascript)%\', \'key\');"><IMG SRC="icons/icon_reload.png" border="0" alt="Keystore Alias %value keyStoreName%"></A>');
		     }
           </script>
					  
					                                                                                           
                      <script>writeTD("rowdata");</script>               
                          <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a class="imagelink"  href="javascript:document.htmlform_keystore_management_%value $index%.submit();" onClick="return deleteKeyStore(\'%value keyStoreName encode(javascript)%\',\'key\');"><img src="icons/delete.png" alt="Keystore Alias %value keyStoreName%" border="none"></a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write("<a class='imagelink'  href='security-keystoremgt.dsp?webMethods-wM-AdminUI=true' onClick='return deleteKeyStore(\"%value keyStoreName encode(javascript)%\",\"key\");'><img src='icons/delete.png' alt='Keystore Alias %value keyStoreName%' border='none'></a>");
					}
					else {
						document.write("<a class='imagelink'  href='security-keystoremgt.dsp' onClick='return deleteKeyStore(\"%value keyStoreName encode(javascript)%\",\"key\");'><img src='icons/delete.png' alt='Keystore Alias %value keyStoreName%' border='none'></a>");
					}
		       }
           </script>
                      </TD>

                    </TR>
                    <script>swapRows();</script>
                %endloop%
                %endinvoke%
                
                <TR><TD colspan="11"><IMG SRC="images/blank.gif" height="10" width="10"></TD></TR>
                <TR><TD class="heading" colspan="11">Truststore List</TD></TR>                
				<TR>
      			      <TH scope="col" CLASS="oddcol-l">Alias</TH>
      			      <TH scope="col" CLASS="oddcol">Type</TH>
      			      <TH scope="col" CLASS="oddcol">Provider</TH>
      			      <TH scope="col" CLASS="oddcol">Location</TH>      			      
				      <!-- <TH scope="col" CLASS="oddcol">Execute ACL</TH> -->
					  <TH scope="col" CLASS="oddcol">Loaded</TH>			      			      
					  <TH scope="col" CLASS="oddcol">Reload</TH>			      			      				  
      			      <TH scope="col" CLASS="oddcol">Delete</TH>
                   </TR>
                %invoke wm.server.security.keystore:listTrustStores%
                    
                      %loop trustStores%
                          <TR>
                            <script>writeTD("row-l");</script>               
      					  <A HREF="javascript:viewKeyStore('%value errorMessage encode(javascript)%','%value keyStoreName encode(javascript)%', '%value keyStoreType encode(javascript)%', '%value keyStoreLocation encode(javascript)%','%value keyStoreProvider encode(javascript)%','trust');">
      					    %value keyStoreName encode(html)%
                            </A>                
                            </TD>
      				      <script>writeTD("rowdata");</script>%value keyStoreType encode(html)%</TD>
      				      <script>writeTD("rowdata");</script>%value keyStoreProvider encode(html)%</TD>
      				      <script>writeTD("rowdata");</script>%value keyStoreLocation encode(html)% </TD>
      				      <!-- <script>writeTD("rowdata");</script>%value acl encode(html)%</TD> -->
                             <script>writeTD("rowdata");</script>%ifvar isLoaded equals('true')%<IMG SRC="images/green_check.png">Yes%else%No%endif%</TD>                                                                
	   				      <script>writeTD("rowdata");</script>
						  <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A class="imagelink" HREF="javascript:document.htmlform_keystore_management.submit();"  ONCLICK="return confirmReload(\'%value keyStoreName encode(javascript)%\', \'trust\');"><IMG SRC="icons/icon_reload.png" border="0" alt="Truststore Alias %value keyStoreName%"></A>');
		       } else {
			document.write('<A class="imagelink" HREF=""  ONCLICK="return confirmReload(\'%value keyStoreName encode(javascript)%\', \'trust\');"><IMG SRC="icons/icon_reload.png" border="0" alt="Truststore Alias %value keyStoreName%"></A>');
		     }
           </script>
				</TD>                                                                                         
                                                                      
                            <script>writeTD("rowdata");</script>               
                                
								<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a class="imagelink" href="javascript:document.htmlform_keystore_management.submit();" onClick="return deleteKeyStore(\'%value keyStoreName encode(javascript)%\',\'trust\');"><img src="icons/delete.png" alt="Truststore Alias %value keyStoreName%" border="none"></a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a class="imagelink" href="security-keystoremgt.dsp?webMethods-wM-AdminUI=true" onClick="return deleteKeyStore(\'%value keyStoreName encode(javascript)%\',\'trust\');"><img src="icons/delete.png" alt="Truststore Alias %value keyStoreName%" border="none"></a>');
					}
					else {
						document.write('<a class="imagelink" href="security-keystoremgt.dsp" onClick="return deleteKeyStore(\'%value keyStoreName encode(javascript)%\',\'trust\');"><img src="icons/delete.png" alt="Truststore Alias %value keyStoreName%" border="none"></a>');
					}
		       }
           </script>
                            </TD>
      
                          </TR>
                          <script>swapRows();</script>
                      %endloop%
                      %endinvoke%
          </TABLE>
                    </td>
                </tr>
            </table>
        </td>
      </TR>
      
      
      
    </TABLE>

    <form name="viewform" action="security-keystoremgt-keystore.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="keyStoreName">
        <input type="hidden" name="errorMessage">        
        <input type="hidden" name="keyStoreType">
        <input type="hidden" name="keyStoreLocation">
        <input type="hidden" name="keyStoreProvider">
        <input type="hidden" name="mode" value="view">
        <input type="hidden" name="type">
     </form>

    <form name="reloadform" action="security-keystoremgt.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="keyStoreName">
        <input type="hidden" name="mode" value="reload">
        <input type="hidden" name="type">
    </form>

    <form name="deleteform" action="security-keystoremgt.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="keyStoreName">
        <input type="hidden" name="mode" value="delete">
        <input type="hidden" name="type">
    </form>

  </BODY>
</HTML>

