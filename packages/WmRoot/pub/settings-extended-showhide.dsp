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
  <TITLE>Integration Server Extended Settings</TITLE>

</HEAD>
<BODY onLoad="setNavigation('settings-extended.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ShowHideKeysScrn');">
 <TABLE width="100%">
    <TR>
      <TD colspan=2 class="breadcrumb">
	Settings &gt;
	Extended &gt;
	Show and Hide Keys </TD>
    </TR>


  <FORM NAME="visible" ACTION="settings-extended.dsp" METHOD="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <input type="hidden" name="action" value="showhide">
    <TR>
      <TD colspan="2">
	<ul class="listitems">
		  <script>
		  createForm("htmlform_settings_extended", "settings-extended.dsp", "POST", "BODY");
		  </script>
	  <li>
		  <script>getURL("settings-extended.dsp", "javascript:document.htmlform_settings_extended.submit();", "Return to Extended Settings");</script>
		  </li>
	</UL>
      </TD>
    </TR>
    <TR>
      <TD colspan="2">&nbsp;</TD>
    </TR>
    <TR>
	<TD>
	  <TABLE class="tableView" width="50%">
	    <TR>
	      <TD class="heading" colspan="2">Key Visibility</TD>
	    </TR>

	    <TR>
	      <TH class="oddcol">Visible</TH>
	      <TH class="oddcol-l">&nbsp;&nbsp;Key</TH>
	    </TR>

	%invoke wm.server.query:getExtendedSettingsVisible%
	%ifvar settings%
	    %loop settings%
	    <TR>
	      <script>writeTD("row");</script><input type="checkbox" id="%value name encode(htmlattr)%" name="%value name encode(htmlattr)%" value="on" %ifvar visible equals('true')%checked%endif%></TD> <script>writeTD("row-l");</script><label for="%value name encode(htmlattr)%">%value name encode(html)%</label></TD>
	      <script>swapRows();</script>
	    </TR>
	    %endloop%
	    <TR><TD class="action" colspan="2">
	      <input type="submit" value="Save Changes">
	      </TD></TR>
	%endif%
	  </TABLE>
	  </FORM>
	</TD>
      </TR>
    </TABLE>
%endinvoke%
</BODY>
</HTML>
