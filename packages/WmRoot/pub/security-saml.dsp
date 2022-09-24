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
  function confirmDelete (IssuerName) {
    var msg = "OK to delete saml issuer '"+IssuerName+"' from configuration?";
    if (confirm (msg)) {
        document.deleteform.IssuerName.value = IssuerName;
            document.deleteform.submit();
          return false;
    } else return false;
  }


</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('security-saml.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_SAMLScrn');">
<TABLE width="100%">
<TR>
    <TD class="breadcrumb" colspan="2">
    Security &gt;
    SAML </TD>
</TR>


%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.server.saml:addIssuer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endif%
%case 'edit'%
  %invoke wm.server.saml:addIssuer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endif%
%case 'delete'%
  %invoke wm.server.saml:deleteIssuer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endif%
%endswitch%
%endif%


<tr>
    <td colspan="2">
        <ul class="listitems">
		    <script>
			createForm("htmlform_security_saml_add", "security-saml-addedit.dsp", "POST", "BODY");
			</script>
            <li class="listitem">
			<script>getURL("security-saml-addedit.dsp","javascript:document.htmlform_security_saml_add.submit();","Add SAML Token Issuer");</script></li>
        </ul>
    </td>
</tr>
<TR>
    <TD>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=10>Trusted SAML Token Issuers List</TD>
    </TR>
%invoke wm.server.saml:listIssuers%
<TR>
   <TH class="oddcol-l" scope="col">Issuer Name</TH>
   <TH class="oddcol" scope="col">Truststore Alias</TH>
   <TH class="oddcol" scope="col">Certificate Alias</TH>
   <TH class="oddcol" scope="col">Clock Skew</TH>
   <TH class="oddcol" scope="col">Delete</TH>
</TR>
<script>
createForm("htmlform_security_saml_edit", "security-saml-addedit.dsp", "POST", "BODY");
setFormProperty("htmlform_security_saml_edit", "action", "");
setFormProperty("htmlform_security_saml_edit", "IssuerName", "");
setFormProperty("htmlform_security_saml_edit", "TruststoreAlias", "");
setFormProperty("htmlform_security_saml_edit", "CertAlias", "");
setFormProperty("htmlform_security_saml_edit", "ClockSkew", "");

</script>
%loop -struct issuers%
%scope #$key%
<TR>
    <script>writeTD("rowdata-l");</script>

        <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_security_saml_edit.submit();" onClick="return populateForm(document.htmlform_security_saml_edit,\'action=edit;IssuerName=%value IssuerName%;TruststoreAlias=%value TruststoreAlias%;CertAlias=%value CertAlias%;ClockSkew=%value ClockSkew%\')">%value IssuerName encode(html)%</a>');
		       } else {
		       		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="security-saml-addedit.dsp?action=edit&IssuerName=%value IssuerName encode(url)%&TruststoreAlias=%value TruststoreAlias encode(url)%&CertAlias=%value CertAlias encode(url)%&ClockSkew=%value ClockSkew encode(url)%&webMethods-wM-AdminUI=true">%value IssuerName encode(html)%</a>');
					}
					else {
						document.write('<a href="security-saml-addedit.dsp?action=edit&IssuerName=%value IssuerName encode(url)%&TruststoreAlias=%value TruststoreAlias encode(url)%&CertAlias=%value CertAlias encode(url)%&ClockSkew=%value ClockSkew encode(url)%">%value IssuerName encode(html)%</a>');
					}
		       }
           </script>
    </TD>
    <script>writeTD("rowdata");</script>%value TruststoreAlias encode(html)%</TD>
    <script>writeTD("rowdata");</script>%value CertAlias encode(html)%</TD>
    <script>writeTD("rowdata");</script>%value ClockSkew encode(html)%</TD>
    <script>writeTD("rowdata");</script>
     %ifvar nodelete%
      &nbsp;
     %else%
	<a class="imagelink" href="" onClick="return confirmDelete('%value IssuerName encode(javascript)%');">
      <img src="icons/delete.png" border="none" alt="%value IssuerName encode(html)% SAML Token Issuer"></a>
     %endif%</TD>

</TR>

    <script>swapRows();</script>
%endscope%
%endloop%
%endinvoke%
</TABLE>
</TD>
</TR>
</TABLE>

<FORM name="deleteform" action="security-saml.dsp" method="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="IssuerName">
</FORM>

</BODY>
</HTML>
