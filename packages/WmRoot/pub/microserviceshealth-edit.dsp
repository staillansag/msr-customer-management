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
	  function confirmAction(name, func)
	  {
		confirm("Got here");
	    var s1 = "OK to "+func+" the "+name+" Health Indicator?\n\n";
	    return confirm(s1);
	  }

  </script>
  
  
<BODY onLoad="setNavigation('microserviceshealth-edit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Microservices_HealthGauge_IndicatorProperties');">
<TABLE width="100%">
<TR>
    <TD class="breadcrumb" colspan="2">
    Microservices &gt;
    Health Gauge &gt;
	%value name encode(html)% Properties
    </TD>
</TR>

%ifvar action equals('update')%
  %invoke wm.server.healthindicators:updateHealthIndicatorProperties%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endinvoke%
%endif%

<tr></tr>

<TR>
    <TD>
    <TABLE class="tableView" width=50%>
  <TD colspan=3>
     <ul class="listitems">
	  <script>
	  createForm("htmlform_microserviceshealth", "microserviceshealth.dsp", "POST", "BODY");
	  </script>
	  <li>
	  <script>getURL("microserviceshealth.dsp", "javascript:document.htmlform_microserviceshealth.submit();", "Return to Indicators");</script>
	  </li>
	  </ul>
  </TD>
<tr></tr>
 %invoke wm.server.healthindicators:getHealthIndicatorProperties%
    <TR>
        <TD class="heading" colspan=3>%value name encode(html)% Health Indicator Properties</TD>
    </TR>
<TR>
   <TD class="oddcol-l" width=50%>Name</TD>
   <TD class="oddcol" style="text-align: center" width=25%>Value</TD>
   <TD class="oddcol" style="text-align: center" width=25%>Edit</TD>
</TR>

%loop properties%
<TR>
    <script>writeTD("rowdata-l");</script>%value displayName encode(html)% </TD>
        
     <script>writeTD("rowdata");</script>%value value encode(html)%</TD>
     
     <script>writeTD("rowdata");</script>
	<script>
	createForm("htmlform_microserviceshealth_property_%value $index%", "microserviceshealth-edit-property.dsp", "POST", "BODY");
	setFormProperty("htmlform_microserviceshealth_edit_%value $index%", "action", "edit");
	setFormProperty("htmlform_microserviceshealth_edit_%value $index%", "name", "%value /name encode(url)%");
	setFormProperty("htmlform_microserviceshealth_edit_%value $index%", "propertyName", "%value propertyName encode(url)%");
	setFormProperty("htmlform_microserviceshealth_edit_%value $index%", "displayName", "%value displayName encode(url)%");
	setFormProperty("htmlform_microserviceshealth_edit_%value $index%", "value", "%value value encode(url)%");
	</script>
         <script>
		    if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A href="javascript:document.htmlform_microserviceshealth_property_%value $index%.submit();">Edit</A>');
		    } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					document.write('<A href="microserviceshealth-property.dsp?action=edit&name=%value /name encode(url)%&propertyName=%value propertyName encode(url)%&displayName=%value displayName encode(url)%&value=%value value encode(url)%&webMethods-wM-AdminUI=true ">Edit</A>');
				}
				else {
					document.write('<A href="microserviceshealth-property.dsp?action=edit&name=%value /name encode(url)%&propertyName=%value propertyName encode(url)%&displayName=%value displayName encode(url)%&value=%value value encode(url)% ">Edit</A>');
				}
		    }
           </script>
      </TD>
  
 </TR>

    <script>swapRows();</script>
%endloop%
%endinvoke%
</TABLE>
</TD>
</TR>
</head>