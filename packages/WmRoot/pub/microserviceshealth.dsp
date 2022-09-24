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
	var s1 = "OK to "+func+" the "+name+" Health Indicator?\n\n";
	return confirm(s1);
	}

  </script>
  
  
<BODY onLoad="setNavigation('microserviceshealth.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Microsersvices_HealthGauge');">
  
<TABLE width="100%">
<TR>
    <TD class="breadcrumb" colspan="2">
    Microservices &gt;
    Health Gauge</TD>
</TR>

%value message encode(html)%

%ifvar action%
%switch action%
%case 'disable'%
  %invoke wm.server.healthindicators:changeHealthIndicator%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endinvoke%
%case 'enable'%
  %invoke wm.server.healthindicators:changeHealthIndicator%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endinvoke%
%endswitch%
%endif%

<TR>
    <TD>
    <TABLE class="tableView" width=50%>
<tr></tr>

    <TR>
        <TD class="heading" colspan=2>Health Indicator List</TD>
    </TR>
<tr></tr>
%invoke wm.server.healthindicators:getAllHealthIndicators%
<TR>
   <TD class="oddcol-l" width=75%>Indicator Name</TD>
   <TD class="oddcol" style="text-align: center" width=25%>Enabled</TD>
</TR>

%loop indicators%
<TR>
    <script>writeTD("rowdata-l");</script>
	<script>
	createForm("htmlform_microserviceshealth_edit_%value $index%", "microserviceshealth-edit.dsp", "POST", "BODY");
	setFormProperty("htmlform_microserviceshealth_edit_%value $index%", "action", "edit");
	setFormProperty("htmlform_microserviceshealth_edit_%value $index%", "name", "%value name encode(url)%");
	</script>
	%ifvar hasProperties equals('true')%
         <script>
		    if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A href="javascript:document.htmlform_microserviceshealth_edit_%value name%.submit();">%value name%</A>');
		    } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					document.write('<A href="microserviceshealth-edit.dsp?action=Edit&name=%value name encode(url)%&webMethods-wM-AdminUI=true">%value name%</A>');
				}
				else {
					document.write('<A href="microserviceshealth-edit.dsp?action=Edit&name=%value name encode(url)%">%value name%</A>');
				}
		    }
           </script>
      %else%
        %value name%
      %endif%
      </TD>
        
     <script>writeTD("rowdata");</script>
      %ifvar enabled equals('true')%

	  <script>
		 createForm("htmlform_microserviceshealth_%value $index%", "microservicehealth.dsp", "POST", "BODY");
		 setFormProperty("htmlform_microserviceshealth_%value $index%", "action", "disable");
		 setFormProperty("htmlform_microserviceshealth_%value $index%", "name", "%value name encode(url)%");
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.write('<A class="imagelink" HREF="javascript:document.htmlform_microservicehealth_%value $index%.submit();" ONCLICK="return confirmAction(\'%value name encode(javascript)%\', \'disable\');"><IMG SRC="images/green_check.png" border="0" height=13 width=13>Yes</A>');
		} else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				document.write('<A class="imagelink" HREF="microserviceshealth.dsp?action=disable&name=%value name encode(javascript)%&webMethods-wM-AdminUI=true" ONCLICK="return confirmAction(\'%value name encode(javascript)%\', \'disable\');"><IMG SRC="images/green_check.png" border="0" height=13 width=13>Yes</A>');
			}
			else {
				document.write('<A class="imagelink" HREF="microserviceshealth.dsp?action=disable&name=%value name encode(javascript)%" ONCLICK="return confirmAction(\'%value name encode(javascript)%\', \'disable\');"><IMG SRC="images/green_check.png" border="0" height=13 width=13>Yes</A>');
			}
		}

		</script>
      
      %else%

	  <script>
		 createForm("htmlform_microserviceshealth_%value $index%", "microservicehealth.dsp", "POST", "BODY");
		 setFormProperty("htmlform_microserviceshealth_%value $index%", "action", "enable");
		 setFormProperty("htmlform_microserviceshealth_%value $index%", "name", "%value name encode(url)%");
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.write('<A class="imagelink" HREF="javascript:document.htmlform_microservicehealth_%value $index%.submit();" ONCLICK="return confirmAction(\'%value name encode(javascript)%\', \'enable\');"><IMG border="0" SRC="images/blank.gif" height=13 width=13>No</A>');
		} else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				document.write('<A class="imagelink" HREF="microserviceshealth.dsp?action=enable&name=%value name encode(javascript)%&webMethods-wM-AdminUI=true" ONCLICK="return confirmAction(\'%value name encode(javascript)%\', \'enable\');"><IMG border="0" SRC="images/blank.gif" height=13 width=13>No</A>');
			}
			else {
				document.write('<A class="imagelink" HREF="microserviceshealth.dsp?action=enable&name=%value name encode(javascript)%" ONCLICK="return confirmAction(\'%value name encode(javascript)%\', \'enable\');"><IMG border="0" SRC="images/blank.gif" height=13 width=13>No</A>');
			}
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
</head>