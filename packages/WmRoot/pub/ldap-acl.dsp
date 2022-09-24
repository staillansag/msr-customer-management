
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
    <SCRIPT SRC="webMethods.js">
    </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_MapGroupsToACLsScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan="2">
            Settings &gt;
            LDAP Directory &gt;
            Map Groups to ACLs
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
		  <script>
				createForm("htmlform_http_ldap_settings", "ldap-settings.dsp", "POST", "BODY");
		  </script>
		  <li>
		  <script>getURL("ldap-settings.dsp","javascript:document.htmlform_http_ldap_settings.submit();","Return to External User Management");</script></li>
          </UL>
        </TD>
      </TR>
      %ifvar action equals('list')%
      <TR>
        <TD colspan="2">
          <UL>
		  
		  <script>
				  createForm("htmlform_http_ldap_acl", "ldap-acl.dsp", "POST", "BODY");
			      setFormProperty("htmlform_http_ldap_acl", "index", "%value index%");
					    
		  </script>
		  
		    <li>
			<script>getURL("ldap-acl.dsp?index=%value index encode(url)%","javascript:document.htmlform_http_ldap_acl.submit();","Return to Find LDAP Groups");</script></li>
          </UL>
        </TD>
      </TR>
      %endif%
      <TR>
        <TD>
          <FORM NAME="addform" ACTION="ldap-acl.dsp" METHOD="POST">
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <TABLE class="tableView">
%ifvar action equals('create')%
%invoke wm.server.ldap:createMappings%
        %ifvar message%
        <tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
        %else%
        <tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mappings created successfully.</TD></TR>
        %endif%
%endinvoke%
%endif%
%ifvar action equals('list')%
%invoke wm.server.ldap:findLDAPGroups%
        %ifvar message%
        <tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
        %endif%
        <TR>
            <TD colspan="2" class="heading">Map LDAP Groups to
                                            %value aclgroup encode(html)% ACL</TD>
        </TR>
        <TR>
            <SCRIPT>
              function select(v) {
                if(document.addform.mapping) {
                for(i=0;i<document.addform.mapping.length;i++) {
                  document.addform.mapping[i].checked=v;
                }
                }
              }
            </SCRIPT>
            <TD class="oddcol">Select<br>
                <a onClick="javascript:select(true); return false;" href="">all</a>|<a onClick="javascript:select(false); return false;" href="">none</a></TD>
            <TD class="oddcol-l">Group Name</TD>
        </TR>
%loop -struct groups%
        <TR>
            <script>writeTD("rowdata");</script>
                <input type="checkbox" name="mapping" value="%value $key encode(htmlattr)%;%value encode(htmlattr)%">
            </TD>
            <script>writeTD("rowdata-l");</script>
                %value $key encode(html)%
            </TD>
        </TR>
        <script>swapRows();</script>
%endloop%
%endinvoke%
        <TR>
          <TD colspan=2 class="action">
            <INPUT type="hidden" name="action" value="create">
            <INPUT TYPE="hidden" NAME="index" VALUE="%value index encode(htmlattr)%">
            <INPUT TYPE="hidden" NAME="aclgroup" VALUE="%value aclgroup encode(htmlattr)%">
            <INPUT type="hidden" name="filter" value="%value filter encode(htmlattr)%">
            <INPUT type="hidden" name="grouproot" value="%value grouproot encode(htmlattr)%">
            <INPUT type="hidden" name="gnattr" value="%value gnattr encode(htmlattr)%">
            <INPUT type="submit" value="Create Mappings">
          </TD>
        </TR>
%else%
        <TR>
            <TD colspan="2" class="heading">Find LDAP Groups</TD>
        </TR>
          <TR>
            <TD class="oddrow"><label for="aclgroup">ACL</label></td>
            <TD class="oddrow-l">
              %invoke wm.server.access:aclList%
              <SELECT name="aclgroup" id="aclgroup" >
                 %loop aclgroups%
                 <OPTION value="%value name encode(htmlattr)%">%value name encode(html)%</OPTION>
                 %endloop%
              </SELECT>
              %endinvoke%
              </TD>
          </TR>
          <TR>
            <TD class="evenrow"><label for="grouproot">Group Root</label></td>
            <TD class="evenrow-l">
              <INPUT name="grouproot" id="grouproot"  SIZE=50 VALUE="%value grouproot encode(htmlattr)%"> </TD>
          </TR>
          <TR>
            <TD class="oddrow"><label for="filter">Filter</label></td>
            <TD class="oddrow-l">
              <INPUT name="filter" id="filter"  SIZE=50 VALUE="%value filter encode(htmlattr)%"> </TD>
          </TR>
          <TR>
            <TD class="evenrow"><label for="gnattr">Group Name Attribute</label></td>
            <TD class="evenrow-l">
              <INPUT name="gnattr" id="gnattr"  SIZE=50 VALUE="%value gnattr encode(htmlattr)%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="action">
              <INPUT type="hidden" name="action" value="list">
              <INPUT TYPE="hidden" NAME="index" VALUE="%value index encode(htmlattr)%">
              <INPUT type="submit" value="Run Query">
            </TD>
          </TR>
%endif%
      </TABLE>
        </FORM>
    </TD>
  </TR>
</TABLE>

    </BODY>
  </HTML>
