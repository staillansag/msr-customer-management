<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server - webMethods Cloud Accounts</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%

<SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function confirmDelete ( tenantAlias, aliasName, stage, stageDisplay) {
    var msg = "Delete on-premise account '" + aliasName + "' on tenant '" + tenantAlias + "' for stage '" + stageDisplay + "'?";
    if (confirm (msg)) {
        document.deleteform.aliasName.value = aliasName;
		    document.deleteform.stage.value = stage;
		    document.deleteform.tenantAlias.value = tenantAlias;
        document.deleteform.submit();
        return false;
    }
	else
		return false;
  }

function confirmUpload (tenantAlias, aliasName, stage, stageDisplay) {
    var msg = "Upload on-premise account '" + aliasName + "' on tenant '" + tenantAlias + "' for stage '" + stageDisplay + "'? \n" +
				"This will replace the account on webMethods Integration Cloud.";
    if (confirm (msg)) {
        document.uploadform.aliasName.value = aliasName;
		    document.uploadform.stage.value = stage;
		    document.uploadform.tenantAlias.value = tenantAlias;
        document.uploadform.submit();
        return false;
    }
	else
		return false;
  }

</SCRIPT>
</HEAD>

<BODY onLoad="setNavigation('integration-live.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_AccountsScrn');">
  <TABLE width="100%">
   <TR>
      <TD class="breadcrumb" colspan="2">
          webMethods Cloud &gt; Accounts
      </TD>
    </TR>

%ifvar action%
%switch action%
%case 'test'%
  %invoke wm.client.integrationlive.connections:testUMConnectionAlias%
        %ifvar message%
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
	%onerror%
		<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
	%endinvoke%

%case 'addFrom'%
        %ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
		%ifvar errorMessage%
			<tr><td colspan="3">&nbsp;</td></tr>
			<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
		%endif%
%case 'editFrom'%
        %ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
		%ifvar errorMessage%
			<tr><td colspan="3">&nbsp;</td></tr>
			<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
		%endif%
%case 'add'%
  %invoke wm.client.integrationlive.connections:createUMConnection%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
	%endinvoke%
%case 'edit'%
  %invoke wm.client.integrationlive.connections:updateUMConnection%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
	%endinvoke%
%case 'delete'%
  %invoke wm.client.integrationlive.connections:removeUMConnection%
        %ifvar message%
		  <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
	%endinvoke%
%case 'upload'%
  %invoke wm.client.integrationlive.connections:uploadUMConnection%
        %ifvar message%
		  <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
	%endinvoke%
%case 'enable'%
  %invoke wm.client.integrationlive.connections:enableUMConnection%
        %ifvar message%
		  <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
	%endinvoke%
%case 'disable'%
  %invoke wm.client.integrationlive.connections:disableUMConnection%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  	%onerror%
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
	%endinvoke%
%endswitch%
%endif%

   <TR>
      <TD colspan="2">
        <UL class="listitems">
          <LI>	

            <script>
		      if(is_csrf_guard_enabled && needToInsertToken) {
		        document.write('<A HREF="javascript:document.htmlform_integration_live_connections_addedit.submit();" onClick="setNavigation(\'integration-live-connections-addedit.dsp\', \'/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmIntegrationLivepkg_AddConnectionScrn\');">Create On-Premise Account</A>');
		      } else {
		      	%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
			    	document.write('<A HREF="integration-live-connections-addedit.dsp?action=add&isEnabled=true&webMethods-wM-AdminUI=true" onClick="setNavigation(\'integration-live-connections-addedit.dsp\', \'/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmIntegrationLivepkg_AddConnectionScrn\');">Create On-Premise Account</A>');
				}
				else {
			    	document.write('<A HREF="integration-live-connections-addedit.dsp?action=add&isEnabled=true" onClick="setNavigation(\'integration-live-connections-addedit.dsp\', \'/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmIntegrationLivepkg_AddConnectionScrn\');">Create On-Premise Account</A>');
				}
		      }
           </script>		  
		   </LI>
        </UL>
      </TD>
    </TR>

    <TR>
    <TD width="98%">
       <TABLE width="75%" class="tableView">
       <TR>
      <TD class="heading" colspan="9">On-Premise Accounts</TD>
    </TR>

   	%invoke wm.client.integrationlive.connections:listUMConnections%
    <TR>
      <TH scope="col" class="oddcol-l" nowrap width="15%">Alias</TH>
      <TH scope="col" class="oddcol" nowrap width="20%">Description</TH>
      <TH scope="col" class="oddcol" nowrap width="15%">Tenant Alias</TH>
	  <TH scope="col" class="oddcol" nowrap width="10%">Stage</TH>
	  <TH scope="col" class="oddcol" nowrap width="20%">Last Uploaded Time</TH>
	  <TH scope="col" class="oddcol" nowrap width="5%">Upload</TH>
	  <TH scope="col" class="oddcol" nowrap width="5%">Test</TH>
      <TH scope="col" class="oddcol" nowrap width="5%">Enabled</TH>
      <TH scope="col" class="oddcol" nowrap width="5%">Delete</TH>
    </TR>

    %loop UMConnections%
    <TR>
	  <script>
			createForm("htmlform_integration_live_connections_edit_%value $index%", "integration-live-connections-addedit.dsp", "POST", "BODY");
			setFormProperty("htmlform_integration_live_connections_edit_%value $index%", "action", "edit");
			setFormProperty("htmlform_integration_live_connections_edit_%value $index%", "aliasName", "%value aliasName%");
			setFormProperty("htmlform_integration_live_connections_edit_%value $index%", "stage", "%value stage%");
			setFormProperty("htmlform_integration_live_connections_edit_%value $index%", "tenantAlias", "%value tenantAlias%");
      </script>
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%ifvar aliasName%
      <script>
		       if(is_csrf_guard_enabled && needToInsertToken) {
		     	 document.write('<A href="javascript:document.htmlform_integration_live_connections_edit_%value $index%.submit();" onClick="setNavigation(\'integration-live-connections-addedit.dsp\', \'/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmIntegrationLivepkg_EditConnectionScrn\');">%value aliasName encode(html)%</A>');
		       } else {
		        %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		        var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
                    document.write('<A href="integration-live-connections-addedit.dsp?action=edit&tenantAlias=%value tenantAlias encode(url)%&aliasName=%value aliasName encode(url)%&stage=%value stage encode(url)%&webMethods-wM-AdminUI=true" onClick="setNavigation(\'integration-live-connections-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmIntegrationLivepkg_EditConnectionScrn\');">%value aliasName encode(html)%</A>');
				}
				else {
			    	document.write('<A href="integration-live-connections-addedit.dsp?action=edit&tenantAlias=%value tenantAlias encode(url)%&aliasName=%value aliasName encode(url)%&stage=%value stage encode(url)%" onClick="setNavigation(\'integration-live-connections-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_WmIntegrationLivepkg_EditConnectionScrn\');">%value aliasName encode(html)%</A>');
				}
		       }
      </script>
	  %else%&nbsp;%endif%
      </TD>

      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%value description encode(html)%
      </TD>

      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>%value tenantAlias encode(html)%
      </TD>

      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>%value stageDisplay encode(html)%
      </TD>

      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>%value lastUploadedTimeStr encode(html)%
      </TD>

      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
  		<A href="" onClick="return confirmUpload( '%value tenantAlias encode(javascript)%', '%value aliasName encode(javascript)%', '%value stage encode(javascript)%', '%value stageDisplay encode(javascript)%');">
        	%ifvar uploadPending equals('true')%
          		<IMG src="images/uploadPending.png" alt="Upload alias %value aliasName%" border="none"/>
       		%else%
          		<IMG src="images/upload.png" alt="Upload alias %value aliasName%" border="none"/>
       	 	%endif%
        </A>
      </TD>

      <SCRIPT>writeTD("rowdata");</SCRIPT>
        
		<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A href="javascript:document.deleteform.submit();" onClick="return populateForm(document.deleteform, \'action=test;tenantAlias=%value tenantAlias%;aliasName=%value aliasName%;stage=%value stage%\')"><IMG src="../WmRoot/icons/checkdot.gif" alt="Test alias %value aliasName%" border="none"></A>');
		       } else {

					         %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				 var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				 if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
            			    	document.write('<A href="integration-live.dsp?action=test&tenantAlias=%value tenantAlias encode(url)%&aliasName=%value aliasName encode(url)%&stage=%value stage encode(url)%&webMethods-wM-AdminUI=true"><IMG src="../WmRoot/icons/checkdot.gif" alt="Test alias %value aliasName%" border="none"></A>');
            				 }
            				 else {
                                document.write('<A href="integration-live.dsp?action=test&tenantAlias=%value tenantAlias encode(url)%&aliasName=%value aliasName encode(url)%&stage=%value stage encode(url)%"><IMG src="../WmRoot/icons/checkdot.gif" alt="Test alias %value aliasName%" border="none"></A>');
            				 }

		     }
           </script>
      </TD>

	  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
	  <!-- Enable -->
	  %switch isEnabled%
		%case 'true'%

		<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.deleteform.submit();" onClick="return populateForm(document.deleteform, \'action=disable;tenantAlias=%value tenantAlias%;aliasName=%value aliasName%;stage=%value stage%\')"><img style="width: 13px; height: 13px;" alt="enabled" border="0" alt="Disable alias %value aliasName%" src="../WmRoot/images/green_check.gif">Yes</a>');
		       } else {
		       		          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				 var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				 if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
               			    	document.write('<a href="integration-live.dsp?action=disable&tenantAlias=%value tenantAlias encode(url)%&aliasName=%value aliasName encode(url)%&stage=%value stage encode(url)%&webMethods-wM-AdminUI=true"><img style="width: 13px; height: 13px;" alt="enabled" border="0" alt="Disable alias %value aliasName%" src="../WmRoot/images/green_check.gif">Yes</a>');
               				  }
               				  else {
                                document.write('<a href="integration-live.dsp?action=disable&tenantAlias=%value tenantAlias encode(url)%&aliasName=%value aliasName encode(url)%&stage=%value stage encode(url)%"><img style="width: 13px; height: 13px;" alt="enabled" border="0" alt="Disable alias %value aliasName%" src="../WmRoot/images/green_check.gif">Yes</a>');
               				  }

		     }
           </script>
		%case 'false'%

		<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.deleteform.submit();" onClick="return populateForm(document.deleteform, \'action=enable;aliasName=%value aliasName%;stage=%value stage%\')">No</a>');
		       } else {

					         %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
				 var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				 if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%' || webMethods_wM_AdminUI) {
            			    	document.write('<a href="integration-live.dsp?action=enable&tenantAlias=%value tenantAlias encode(url)%&aliasName=%value aliasName encode(url)%&stage=%value stage encode(url)%&webMethods-wM-AdminUI=true">No</a>');
            				 }
            				 else {
					            document.write('<a href="integration-live.dsp?action=enable&tenantAlias=%value tenantAlias encode(url)%&aliasName=%value aliasName encode(url)%&stage=%value stage encode(url)%"><img style="width: 13px; height: 13px;" alt="enabled" border="0" alt="Disable alias %value aliasName%" src="../WmRoot/images/green_check.gif">Yes</a>');
            			     }

		     }
           </script>
		
	  %endswitch%
      </TD>

      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
  		<A href="" onClick="return confirmDelete('%value tenantAlias encode(javascript)%', '%value aliasName encode(javascript)%', '%value stage encode(javascript)%', '%value stageDisplay encode(javascript)%');">
          <IMG src="../WmRoot/icons/delete.gif" alt="Delete alias %value aliasName%" border="none">
        </A>
      </TD>
      <SCRIPT>swapRows();</SCRIPT>
    </TR>
    %endloop%

    </TABLE>
     </TD>
     </TR>
  </TABLE>
  <form name="integrationLiveConnection" id="integrationLiveConnection" action="integration-live.dsp" method="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  	<input type="hidden" name="aliasName">
  </form>
  <FORM name="deleteform" id="deleteform" action="integration-live.dsp" method="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
	<INPUT type="hidden" name="action" value="delete">
	<INPUT type="hidden" name="aliasName">
	<INPUT type="hidden" name="stage">
	<INPUT type="hidden" name="tenantAlias">
  </FORM>
  <FORM name="uploadform" id="uploadform" action="integration-live.dsp" method="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
	<INPUT type="hidden" name="action" value="upload">
	<INPUT type="hidden" name="aliasName">
	<INPUT type="hidden" name="stage">
	<INPUT type="hidden" name="tenantAlias">
  </FORM>
  <FORM name="htmlform_integration_live_connections_addedit" id="htmlform_integration_live_connections_addedit" action="integration-live-connections-addedit.dsp" method="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
	<INPUT type="hidden" name="action" value="add">
	<INPUT type="hidden" name="isEnabled" value="true">
  </FORM>
 </BODY>
</HTML>
