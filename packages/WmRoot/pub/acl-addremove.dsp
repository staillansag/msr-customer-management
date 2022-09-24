<html>
  <head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
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
<SCRIPT SRC="webMethods.js"></SCRIPT>
<SCRIPT>
	function checkMaxLength() {
		var acls = document.getElementById("acls").value.split("\n");
		for(i = 0; i < acls.length; i++) {
			if(acls[i].length > 256) {
				alert("Maximum allowed length exceeded. Max allowed is 256 characters for one acl name");
				document.getElementById("acls").focus();
				return false;
			}
		}
		return true;
	}
</SCRIPT>

<body class="main" onLoad="setNavigation('acls.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddRemoveACLsScrn');">
  
  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">
        Security &gt;
        Access Control Lists &gt;
        Add and Remove ACLs
      </td>
    </tr>
  
    <tr>
      <td colspan=2>
        <ul>
		
		<script>
				createForm("htmlform_http_acls", "acls.dsp", "POST", "BODY");
        </script>
		
          <li class="listitem"><script>getURL("acls.dsp","javascript:document.htmlform_http_acls.submit();","Return to ACLs");</script>
		  </li>
        </ul>
      </td>
    </tr>
  
    <form id="form" name="form" method="POST" action="acls.dsp">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <input type="hidden" name="action" value="add">
  
      <tr>
        <td>
          <table width="40%">
            <tr><td>
              <table class="tableView" width="100%">
                <tr>
                  <td class="heading" colspan=2>Create ACL</td>
                </tr>
                <tr>
              <td nowrap valign="top" class="oddrow"><label for="acls">ACL Names</label></TD>
                  <td class="oddrow-l">One ACL name per line.<br>
                    <textarea style="width:100%;" wrap="off" rows="5" name="acls" id="acls" cols="20"></textarea>
                  </td>
                </tr>
                <td class="action" colspan=2>
                  <input type="submit" value="Create ACLs" name="addACL" onClick="return checkMaxLength()">
                </td>
              </tr>
          </table>
            </form>
  
    <table class="tableView" width="100%">
      <form id="form" name="form" method="POST" action="acls.dsp"  >
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <input type="hidden" name="action" value="remove">
            <tr>
              <td class="heading" colspan=2>Remove ACLs</td>
            </tr>
            <tr>
              <td nowrap valign="top" class="oddrow">Select ACLs</td>
              <td class="oddrow-l">
  
              <table class="tableInline">
  
                    %invoke wm.server.access.adminui:aclList%
                    %loop aclgroups%
          <tr>
          <td align=center>
                    %switch name%
                          %case 'Administrators'%-</td><td class="oddrow-l">Administrators (not removable)
                          %case 'ReadOnlyAdministrators'%-</td><td class="oddrow-l">ReadOnlyAdministrators (not removable)
                          %case 'Default'%-</td><td class="oddrow-l">Default (not removable)
                          %case 'Developers'%-</td><td class="oddrow-l">Developers (not removable)
                          %case 'Replicators'%-</td><td class="oddrow-l">Replicators (not removable)
                          %case 'Anonymous'%-</td><td class="oddrow-l">Anonymous (not removable)
                          %case 'Internal'%-</td><td class="oddrow-l">Internal (not removable)
                          %case 'SAPUsers'%-</td><td class="oddrow-l">SAPUsers (not removable)
                          %case 'WmPartnersUsers'%-</td><td class="oddrow-l">WmPartnersUsers (not removable)
                          %case%
                          <input type="checkbox" name="%value name encode(htmlattr)%" id="%value name encode(htmlattr)%" value="REMOVE"></td><td class="oddrow-l"><label for="%value name encode(htmlattr)%">%value name encode(html)%</label>
                          %switch inUse%
                                %case 'true'%(in use)
                          %endswitch%
                    %endswitch%
          </td>
          </tr>
  
                      %endloop%
                    %endinvoke%
            </table>
              </td>
            </tr>
            <tr>
              <td class="action" colspan=2>
              <input type="submit" value="Remove ACLs" name="removeACL" onclick="return confirm('Are you sure you want to remove selected ACLs? The ACLs will be removed from any services they currently protect.');">
              </td>
            </tr>
          </table>
          </td></tr></table>
          </form>
        </td>
      </tr>
    </table>
  </body>
</html>
