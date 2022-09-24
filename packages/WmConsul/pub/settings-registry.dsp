<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<TITLE>Integration Server - webMethods Microservice Registry Servers</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css">
<SCRIPT SRC="webMethods.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
  function confirmDelete (alias) {
    var msg = "OK to delete registry server '"+alias+"' from configuration?";
    if (confirm (msg)) {
        document.deleteform.alias.value = alias;
            document.deleteform.submit();
          return false;
    } else return false;
  }
  function test (alias)
  {
    document.testform.alias.value = alias;
      document.testform.submit();
    return false;
  }

</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('settings-registry.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ConsulRegistryServersScrn');">
<TABLE width="100%">
<TR>
    <TD class="breadcrumb" colspan="2">Microservice Consul Registry Servers</TD>
</TR>

%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.server.consul.util:addServer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endif%
%case 'edit'%
  %invoke wm.server.consul.util:addServer%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endif%
%case 'test'%
  %invoke wm.server.consul.util:testAlias%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %endif%
%case 'delete'%
  %invoke wm.server.consul.util:deleteServer%
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
            <li class="listitem"><a href="settings-registry-addedit.dsp">Create Microservice Consul Registry Server Alias</a></li>
            <li class="listitem"><a href="settings-registry-changedefault.dsp">Change Default Alias</a></li>
        </ul>
    </td>
</tr>
%ifvar operation equals('setDefault')%
  %invoke wm.server.consul.util:setDefaultAlias%
  %endinvoke%
%endif%
<tr>

%invoke wm.server.consul.util:serverList%
    %ifvar message%
      %ifvar status equals('warning')%
        <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
      %endif%
    %endif%

<TD>
<TABLE class="tableView" width=100%>
	
    <TR>
        <TD class="heading" colspan=10>Microservice Consul Registry Server List</TD>
    </TR>
<TR>
   <TD  class="oddcol-l">Alias</TD>
   <TH  align="center" class="oddcol">Type</TH>
   <TH  align="center" class="oddcol">Host</TH>
   <TH  align="center" class="oddcol">Port</TH>
   <TH  align="center" class="oddcol">User</TH>
   <TH  align="center" class="oddcol">SSL</TH>
   <TH  align="center" class="oddcol">Test</TH>
   <TH  align="center" class="oddcol">Delete</TH>
</TR>

%loop -struct servers%
%scope #$key%
<TR>
    <script>writeTD("rowdata-l");</script>
        <a
	   href="settings-registry-addedit.dsp?action=edit&default=%value default%&alias=%value alias encode(url)%&type=%value type encode(url)%&host=%value host encode(url)%&port=%value port encode(url)%&user=%value user encode(url)%&healthcheck=%value healthcheck%&ssl=%value ssl encode(url)%&keyStoreAlias=%value keyStoreAlias encode(url)%&keyAlias=%value keyAlias encode(url)%&pass=********&trustStoreAlias=%value trustStoreAlias encode(url)%"
        >%value alias encode(html)%</a> 
        
      <INPUT TYPE="hidden" NAME="type" VALUE="%value type%">
      <INPUT TYPE="hidden" NAME="default" VALUE="%value default%">

    </TD>
    <script>writeTD("rowdata");</script>
       %ifvar default equals('true')%
          <IMG SRC="images/green_check.png">
       %endif%
        %value type encode(html)%</TD>
    <script>writeTD("rowdata");</script>%value host encode(html)%</TD>
    <script>writeTD("rowdata");</script>%value port encode(html)%</TD>
    <script>writeTD("rowdata");</script>%value user encode(html)%</TD>
    <script>writeTD("rowdata");</script>
      %ifvar ssl equals('yes')%
        <IMG SRC="images/green_check.png" height=13 width=13>Yes
      %else%
        No
      %endif%
    </TD>
    <script>writeTD("rowdata");</script><a class="imagelink" href="" onclick="return test('%value alias encode(javascript)%');"><IMG src="icons/checkdot.png" border="none" width="14" height="14" ></a></TD>
    <script>writeTD("rowdata");</script>
     %ifvar nodelete%
      &nbsp;
     %else%
  <a class="imagelink" href="" onClick="return confirmDelete('%value alias encode(javascript)%');">
      <img src="icons/delete.png" border="none"></a>
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

<FORM name="deleteform" action="settings-registry.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="alias">
</FORM>

<FORM name="testform" action="settings-registry.dsp" method="POST">
  <INPUT type="hidden" name="action" value="test">
  <INPUT type="hidden" name="alias">
</FORM>

</BODY>
</HTML>
