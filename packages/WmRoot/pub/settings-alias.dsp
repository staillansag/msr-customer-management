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
  function confirmDelete (alias) {
    var msg = "OK to delete alias '"+alias+"' from configuration?";
    if (confirm (msg)) {
        document.deleteform.alias.value = alias;
        document.deleteform.submit();
          return false;
    } else return false;
  }
</SCRIPT>
</HEAD>

<BODY onLoad="setNavigation('settings-alias.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_URL_Aliases');">
<TABLE width="100%">
<TR>
    <TD class="breadcrumb" colspan="2">
    Settings &gt;
    URL Aliases </TD>
</TR>

%value message encode(html)%

%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.server.httpUrlAlias:addAlias%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endinvoke%
%case 'edit'%
  %invoke wm.server.httpUrlAlias:updateAlias%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endinvoke%
%case 'delete'%
  %invoke wm.server.httpUrlAlias:deleteAlias%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endinvoke%
%endswitch%
%endif%

<tr>
    <td colspan="2">
        <ul class="listitems">
			<script>
			createForm("htmlform_settings_alias_addedit_assoc_dev", "settings-alias-addedit.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_alias_addedit_assoc_dev", "association", "1");
			setFormProperty("htmlform_settings_alias_addedit_assoc_dev", "isDev", "false");
			</script>
            <li class="listitem">
			<script>getURL("settings-alias-addedit.dsp?association=1&isDev=false", "javascript:document.htmlform_settings_alias_addedit_assoc_dev.submit();", "Create URL Alias");</script>
			
			</li>
        </ul>
    </td>
</tr>
<TR>
    <TD>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=10>HTTP URL Alias List</TD>
    </TR>
%invoke wm.server.httpUrlAlias:listAlias%
<TR>
   <TH class="oddcol-l" scope="col">Alias</TH>
   <TH class="oddcol" scope="col">Default URL Path</TH>
   <TH class="oddcol" scope="col">Port Mappings</TH>
   <TH class="oddcol" scope="col">Association</TH>
   <TH class="oddcol" scope="col">Package</TH>
   <TH class="oddcol" scope="col">Delete</TH>
</TR>

%loop aliasList%
<TR>
    <script>writeTD("rowdata-l");</script>
	<script>
	createForm("htmlform_settings_alias_addedit_%value $index%", "settings-alias-addedit.dsp", "POST", "BODY");
	setFormProperty("htmlform_settings_alias_addedit_%value $index%", "action", "edit");
	setFormProperty("htmlform_settings_alias_addedit_%value $index%", "alias", "%value alias encode(url)%");
	setFormProperty("htmlform_settings_alias_addedit_%value $index%", "urlPath", "%value urlPath encode(url)%");
	setFormProperty("htmlform_settings_alias_addedit_%value $index%", "portList", "%value portList encode(url)%");
	setFormProperty("htmlform_settings_alias_addedit_%value $index%", "package", "%value package encode(url)%");
	setFormProperty("htmlform_settings_alias_addedit_%value $index%", "association", "%value association encode(url)%");
	%switch association%
		%case '0'%
		setFormProperty("htmlform_settings_alias_addedit_%value $index%", "isDev", "false");
		%case '1'%
		setFormProperty("htmlform_settings_alias_addedit_%value $index%", "isDev", "false");
		%case%
		setFormProperty("htmlform_settings_alias_addedit_%value $index%", "isDev", "true");
	%endif%
	</script>
	<script>
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.write("<a href='javascript:document.htmlform_settings_alias_addedit_%value $index%.submit();'> %ifvar alias equals('_DEFAULT_ALIAS_')%&lt;EMPTY&gt; %else% %value alias encode(html)% %endif%</a>");
		} else {
			%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				document.write("<a href='settings-alias-addedit.dsp?action=edit&alias=%value alias encode(url)%&urlPath=%value urlPath encode(url)%&portList=%value portList encode(url)%&association=%value association encode(url)%&package=%value package encode(url)%&isDev=%switch association%%case '0'%false%case '1' %false%case%true%endif%&webMethods-wM-AdminUI=true'> %ifvar alias equals('_DEFAULT_ALIAS_')% &lt;EMPTY&gt; %else% %value alias encode(html)% %endif%</a>");
			}
			else {
				document.write("<a href='settings-alias-addedit.dsp?action=edit&alias=%value alias encode(url)%&urlPath=%value urlPath encode(url)%&portList=%value portList encode(url)%&association=%value association encode(url)%&package=%value package encode(url)%&isDev=%switch association%%case '0'%false%case '1' %false%case%true%endif%'> %ifvar alias equals('_DEFAULT_ALIAS_')% &lt;EMPTY&gt; %else% %value alias encode(html)% %endif%</a>");
			}
		}
	</script>
        
    </TD>
    <script>writeTD("rowdata");</script>%value urlPath encode(html)%</TD>
    <script>writeTD("rowdata");</script>%loop portList% %value%<br>%endloop%</TD>
    <script>writeTD("rowdata");</script>
      %switch association%
      %case '0'%
        Server
      %case '1'%
        Package
      %case%
        %value association encode(html)%
      %endif%
    </TD>  
    <script>writeTD("rowdata");</script>%value package encode(html)%</TD>
    <script>writeTD("rowdata");</script>
     %ifvar nodelete%
      &nbsp;
     %else%
	 <script>
	 createForm("htmlform_settings_alias_%value $index%", "settings-alias.dsp", "POST", "BODY");
	 </script>		
	<script>
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.write('<a class="imagelink" href="javascript:document.htmlform_settings_alias_%value $index%.submit();" onClick="return confirmDelete(\'%value alias encode(javascript)%\');"> <img src="icons/delete.png" alt="HTTP URL Alias %value alias%" border="none"></a>');
		} else {
			document.write('<a class="imagelink" href="" onClick="return confirmDelete(\'%value alias encode(javascript)%\');"> <img src="icons/delete.png" alt="HTTP URL Alias %value alias%" border="none"></a>');
		}
	</script>	 
  
     %endif%</TD>

</TR>

    <script>swapRows();</script>
%endloop%
%endinvoke%
</TABLE>
</TD>
</TR>
</TABLE>

<FORM name="deleteform" action="settings-alias.dsp" method="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="alias">
</FORM>

</BODY>
</HTML>
