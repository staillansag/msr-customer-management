<html>

<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">



<title>ServerUI</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<base target="_self">
<style>
  .listbox  { width: 100%; }
</style>
</head>
<script src="client.js"></script>
<script src="oauth.js"></script>
<SCRIPT SRC="webMethods.js"></SCRIPT>

<BODY class="main" onbeforeunload="checkDirty();" onLoad="setNavigation('security-oauth-tokens.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthAssociateScopesToClientsScrn');">


<TABLE width=100% >
  <TR>
    <TD class="breadcrumb" colspan=2>Security &gt; OAuth &gt; Scope Management &gt; Associate Scopes to Clients</TD>
  </TR>

     %ifvar action equals('update')%
        %invoke wm.server.oauth:updateScopeClientAssociations%
            %ifvar message%
                <TR><TD colspan="2">&nbsp;</TD></TR>
      			<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %endif%
            %onerror%
                <TR><TD colspan="2">&nbsp;</TD></TR>
				<TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
        %endinvoke%
    %endif%

     <TR>
       <TD colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_security_oauth_scope", "security-oauth-scope.dsp", "POST", "BODY");
		  </script>
          <li>
		  <script>getURL("security-oauth-scope.dsp","javascript:document.htmlform_security_oauth_scope.submit();","Return to Scope Management");</script></li>
        </UL>
      </TD>
    </TR>
    <TR>
    <TD>
   <TABLE class="tableView" width="100%" %ifvar edit% style="display:none"%endif%>
   
    <TR>
      <TD width="50%" style="padding: 0;">
        <DIV align="center">
          <CENTER>

            <form id="form" name="form" method="POST" action="security-oauth-scope-client-associations.dsp" >
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            <input type="hidden" name="action" value="nothing">

            <TABLE class="tableView" width="100%">
                <TR>
                    <TD class="title">Scopes</TD>
                </TR>
    
                <TR>
                    <TD class="evenrow">
                        <TABLE class="tableInline" width="100%" cellpadding="0" cellspacing="0">
                            <TR>
                                <TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
                                <TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
                            </TR>
                            <TR>
                                <TD align="left">
                                    <TABLE class="tableInline" width="100%">
                                        <TR>
                  							<TD class="evenrow" nowrap align="right"><label for="select">Select Scope:</label></TD>
                                            <TD class="evenrow" width="100%" align=right>
                  								<select id="select" class="listbox" onchange="changeScope(this.options[this.selectedIndex].value);" size="1" name="scopes">
                                                <option selected>---none---</option>
                                                </select>
                                            </TD>
                                        </TR>
                                        <TR><TD class="evenrow" colspan="3" align="right"><font style="font-size: 85%;">&nbsp;</font></TD></td></TR>
                                  </TABLE>
                                </TD>
                                <TD>  </TD>
                            </TR>
                            <TR>
                                <TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
                                <TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD class="oddrow">
                        <DIV align="center">
                        <TABLE width="100%">
                            <TR>
                                <TD width="50%" class="grouping-positive" valign="bottom" align="center">
              						<label for="memberclients">Clients associated with Scope</label><br>
                                    <SELECT class="listbox" onchange="unselect(this, availableclientsList, memberscopesList, availablescopesList);changeSelectedClient(this.options[this.selectedIndex].value);" size="10" id="memberclients" name="memberclients" multiple>
                                    <option>-----none-----</option>
                                    </select>
                                </TD>
                                <TD width="50%" class="grouping-neutral" valign="bottom" align="center">
              						<label for="availableclients">Remaining Clients</label><br>
                                    <select class="listbox" onchange="unselect(this, memberclientsList, memberscopesList, availablescopesList);changeSelectedClient(this.options[this.selectedIndex].value);" id="availableclients" size="10" name="availableclients" multiple>
                                    <option>------none------</option>
                                    </select>
                                </TD>
                            </TR>
                            <TR>
                                <TD class="oddcol" valign="bottom" align="center">
                                    <input onclick="moveitem(memberclientsList, availableclientsList);"  type="button" value="-&gt;" name="moveRight1" class="widebuttons">
                                </TD>
                                <TD class="oddcol" valign="bottom" align="center">
                                    <input onclick="moveitem(availableclientsList, memberclientsList);" type="button" value="&lt;-" name="moveLeft1" class="widebuttons">
                                </td>
                            </TR>
                        </TABLE>
                        </DIV>
                    </TD>
                </TR>
            </TABLE>
          </CENTER>
        </DIV>
      </TD>
      <TD width="50%" valign="top"  style="padding: 0;">
        <DIV align="center">
            <CENTER>
                <TABLE class="tableView" width="100%">
                    <TR>
                        <TD class="title">Clients</TD>
                    </TR>
                    <TR>
                        <TD class="evenrow"  style="padding: 0;">
                            <TABLE class="tableInline" width="100%" cellpadding="0" cellspacing="0">
                                <TR>
                                    <TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
                                    <TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
                                </TR>
                                <TR>
                                    <TD align="left">
                                        <TABLE class="tableInline" width="100%">
                                            <TR>
                  								<TD class="evenrow" nowrap align="right"><label for="clients">Select Client:</label>&nbsp;</TD>
                                                <TD class="evenrow" width="100%"><select class="listbox" onchange="changeClient(this.options[this.selectedIndex].value);" size="1" name="clients" id="clients">
                                                    <option selected>---none---</option>
                                                    </select>
                                                </TD>
                                            </TR>
                                            <TR><TD class="evenrow" colspan="3" align="right"><font style="font-size: 85%;">&nbsp;</font></TD></TR>
                                        </TABLE>
                                    </TD>
                                    <TD></TD>
                                </TR>
                                <TR>
                                    <TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
                                    <TD><img border="0" src="images/blank.gif" width="5" height="5"></TD>
                                </TR>
                            </TABLE>
                        </TD>
                    </TR>
                    <TR>
                        <TD class="oddrow">
                            <DIV align="center">
                                <TABLE width="100%">
                                    <TR>
                                        <TD class="grouping-positive" valign="bottom" align="center">
              								<label for="memberscopes">Scopes in <nobr>this Client</nobr></label><br>
                                            <select class="listbox" onchange="unselect(this, availablescopesList, availableclientsList, memberclientsList);changeSelectedScope(this.options[this.selectedIndex].value);" size="10" id="memberscopes" name="memberscopes" multiple>
                                            <option>-----none-----</option>
                                            </select>
                                        </TD>
                                        <TD class="grouping-neutral" valign="bottom" align="center">
              								<label for="availablescopes">Remaining Scopes</label><br>
                                            <select class="listbox" onchange="unselect(this, memberscopesList, availableclientsList, memberclientsList);changeSelectedScope(this.options[this.selectedIndex].value);" id="availablescopes" size="10" name="availablescopes" multiple>
                                            <option>------none------</option>
                                            </select>
                                        </TD>
                                    </TR>
                                    <TR>
                                        <TD class="oddcol" valign="bottom" align="center">
                                            <input onclick="moveitem(memberscopesList, availablescopesList);"  type="button" value="-&gt;" name="moveRight2" class="widebuttons">
                                        </TD>
                                        <TD class="oddcol" valign="bottom" align="center">
                                            <input onclick="moveitem(availablescopesList, memberscopesList);" type="button" value="&lt;-" name="moveLeft2" class="widebuttons">
                                        </TD>
                                    </TR>
                                </TABLE>
                            </DIV>
                        </TD>
                    </TR>
                </TABLE>
            </CENTER>
        </DIV>
      </TD>
    </TR>
    <TR>
      <TD colspan=2 class="action" align="center" width="100%"><input type="submit" onclick="saveChanges();"  value="Save Changes" name="OK">
        </TD>
    </TR>
  </TABLE>

  <input type="hidden" name="scopeclientdata" value="">
    
  </form>
</TD></TR>

<TR><TD>&nbsp;&nbsp;&nbsp;</TD></TR>
</TABLE>

<script>
  //declare form objects as variables
  var TheForm = document.forms["form"];
  //var userfilterList = TheForm.userFilter;
  var scopeList =  TheForm.scopes;
  var clientList = TheForm.clients;
  var memberclientsList = TheForm.memberclients;
  var availableclientsList = TheForm.availableclients;
  var memberscopesList = TheForm.memberscopes;
  var availablescopesList = TheForm.availablescopes;
  var newScope = TheForm.newscope;
  var hiddenSave = TheForm.scopeclientdata;
  var hiddenAction = TheForm.action;
</script>
<script>


%invoke wm.server.oauth:listAllScopesAndClientsAssociations%
%loop clients%

addClient("%value name encode(javascript)% (%value version encode(javascript)%)",[%loop scopes%"%value encode(javascript)%"%loopsep ','% %endloop%]);%endloop%

%loop scopes%
addScope("%value name encode(javascript)%",[%loop clients%"%value name encode(javascript)%"%loopsep ','% %endloop%]);%endloop%
</script>


<script>
setupPage();
</script>
</BODY>
</HTML>


