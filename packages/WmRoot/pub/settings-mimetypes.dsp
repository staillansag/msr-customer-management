<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


  <TITLE>Integration Server Mime Type Settings</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT SRC="webMethods.js"></SCRIPT>
</HEAD>

%ifvar mode equals('edit')%
<BODY onLoad="setNavigation('settings-mimetypes.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_MimeTypesScrn_Edit', 'foo');">
%else%
<BODY onLoad="setNavigation('settings-mimetypes.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_MimeTypesScrn', 'foo');">
%endif%
  <TABLE WIDTH="100%">
    <TR>
    %ifvar mode equals('edit')%
      <TD class="breadcrumb" colspan="4">
        Settings &gt; 
        Resources &gt; 
        Mime Types &gt;
        Edit </TD>
    %else%
      <TD class="breadcrumb" colspan="4">
        Settings &gt; 
        Resources &gt; 
        Mime Types </TD>
    %endif%
    </TR>
    <TR>

%ifvar action equals('change')%
  %invoke wm.server.mimetypes:writeMimeTypes%
    %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
    %endif%
  %endinvoke%
%endif%
%ifvar action equals('reload')%
  %invoke wm.server.mimetypes:initMimeTypes%
    %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
    %endif%
  %endinvoke%
%endif%

    <TR>
      <TD colspan=2>
        <ul class="listitems">
          %ifvar mode equals('edit')%
		  <script>
		  createForm("htmlform_settings_mimetypes", "settings-mimetypes.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-mimetypes.dsp", "javascript:document.htmlform_settings_mimetypes.submit();", "Return to Mime Types Settings");</script>
		  </li>
          %else% 
		  <script>
		  createForm("htmlform_settings_resources", "settings-resources.dsp", "POST", "BODY");
		  createForm("htmlform_settings_mimetypes_edit", "settings-mimetypes.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_mimetypes_edit", "mode", "edit");
		  createForm("htmlform_settings_mimetypes_reload", "settings-mimetypes.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_mimetypes_reload", "action", "reload");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-resources.dsp", "javascript:document.htmlform_settings_resources.submit();", "Return to Resource Settings");</script>
		  </li>
          <li class="listitem">
		  <script>getURL("settings-mimetypes.dsp?mode=edit", "javascript:document.htmlform_settings_mimetypes_edit.submit();", "Edit Mime Types Settings");</script>
		  </li>
          <li class="listitem">
		  <script>getURL("settings-mimetypes.dsp?action=reload", "javascript:document.htmlform_settings_mimetypes_reload.submit();", "Reload Mime Types Settings");</script>
		  </li>
          %endif%
        </UL>
    </TR>
    <TR>
      <TD>
          <FORM action="settings-mimetypes.dsp" method="POST">
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          <INPUT type="hidden" name="action" value="change">

        <TABLE class="tableView" %ifvar mode equals('edit')%width="100%"%else%width="50%"%endif% >


          <TR>
            <TD class="heading">Mime Types Settings</TD>
          </TR>

          <TR>
            <TH class="oddcol-l" scope="col" >Content-Type File Extension(s)</TH>
          </TR>

          <TR>
            <TD class="evenrow-l">
              %ifvar mode equals('edit')%
			  %invoke wm.server.mimetypes:readMimeTypes%
              <TEXTAREA style="width:100%; font-family:monospace;" wrap="off" rows=15 cols=40 name="mimeTypes">%value mimeTypes encode(html)%</TEXTAREA>
			  %endinvoke%
              %else%
			  %invoke wm.server.mimetypes:readMimeTypesForView%
               <PRE class="fixedwidth"><code>%value mimeTypesView encode(html)%</code></PRE>
			   %endinvoke%
              </td>
                </TR>
              </TABLE>
              %endif%
            </TD>
          </TR>
          %ifvar mode equals('edit')%
          <TR>
            <TD class="action">
              <INPUT type="submit" name="submit" value="Save Changes">
            </TD>
          </TR>
          %endif%
          </FORM>
          <TR>
            <TD class="oddrow-l">These settings go into the Integration Server <i>lib</i> directory and are used to define what HTTP Content-Type files of the listed extensions are.</TD>
          </TR>


        </TABLE>
      </TD>
    </TR>
  </TABLE>
</BODY>
