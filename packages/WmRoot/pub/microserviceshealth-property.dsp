<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js"></script>
  <script language="JavaScript">
  </script>
  
  
<BODY onLoad="setNavigation('microserviceshealth-edit-property.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Microservices_HealthGauge_IndicatorProperties_Edit');">
<form name="form1" action="microserviceshealth-edit.dsp" method="POST">
%ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
 
<TABLE width="50%">
<TR>
    <TD class="breadcrumb" colspan="2">
    Microservices &gt;
    Health Gauge &gt;
	%value name encode(html)% Properties &gt;
    Edit
    </TD>
</TR>
<tr></tr>
<TR>
  <TD colspan=2>
     <ul class="listitems">
	  <script>
	  createForm("htmlform_microserviceshealth_edit", "microserviceshealth-edit.dsp", "POST", "BODY");
	  </script>
	  <li>
	  <script>getURL("microserviceshealth-edit.dsp?name=%value name encode(url)%", "javascript:document.htmlform_microserviceshealth_edit.submit();", "Return to Properties");</script>
	  </li>
	  </ul>
  </TD>
</TR>
<tr></tr>

<TR>
    <TD>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=10>%value name encode(html)% Health Indicator Property</TD>
    </TR>
<TR>
   <TD class="oddcol">Name</TD>
   <TD class="oddcol">%value displayName encode(html)%</TD>
</TR>
<TR>
   <TD class="oddcol">Value</TD>
   <TD class="oddcol">
     <input name="value" value="%value value encode(html)%">
   </TD>
</TR>
<tr></tr>

<TR>
   <TD colspan=2 class="action">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="name" value="%value /name encode(url)%">
		<input type="hidden" name="propertyName" value="%value propertyName encode(url)%">
		<input type="hidden" name="displayName" value="%value displayName%">
		<input type="hidden" name="value" value="%value value encode(url)%">
    <INPUT type="submit" name="submit" value="Save Changes">
   </TD> 
</TR>

 %endinvoke%
</TABLE>
</TD>
</TR>
</form>
</BODY>
</head>