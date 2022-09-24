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
  </head>
<SCRIPT SRC="webMethods.js"></SCRIPT>

  <BODY>

    <script>
    function writeCheckBox(value)
    {
      document.write("<input type=\"checkbox\" name=\"" + value + "\" value=\"REMOVE\">" + value + "<br>");
    }
    </script>


    <table width=100%>
      <tr>
        <td class="breadcrumb" colspan=2>
            Security &gt;
            Access Control Lists &gt;
            Precedence
        </td>
      </tr>
      <tr>
        <td colspan=2>
          <ul>
		  
		  <script>
				createForm("htmlform_http_acls", "acls.dsp", "POST", "BODY");
          </script>
		
          <li class="listitem">
		  <script>getURL("acls.dsp","javascript:document.htmlform_http_acls.submit();","Return to ACLs");</script>
		  </li>
          </ul>
        </td>
      </tr>
    <form id="form" name="form" method="POST" action="acls.dsp">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="action" value="changePrecedence">
      <tr>
        <TD>
          <TABLE>
            <TR>
              <td class="heading" colspan=2>Precedence Setting</td>
            </tr>
            <tr>
              <td nowrap class="oddrow">Precedence</td>
              <td class="oddrow-l">
              %invoke wm.server.access:getDefaultAccess%
                <input type="radio" value="allow" name="precedence" id="precedence1" %ifvar defaultAccess equals('allow')% checked %endif%><label for="precedence1">Allow: Users in a group that are in either both "Allowed" and "Denied" or neither "Allowed" nor "Denied" will have access.</label></input><BR><BR>
Allow: Users in either both or neither Allowed and Denied will be Allowed.  (Default)
                <input type="radio" value="deny"  name="precedence" id="precedence2" %ifvar defaultAccess equals('deny')% checked %endif%><label for="precedence2">Deny: Users in groups that are in either both "Allowed" and "Denied" or neither "Allowed" nor "Denied" will not have access.</label></input>
              %endinvoke%
              </td>
            </tr>
            <tr>
              <td class="evenrow-l" colspan="2"> Warning: This setting is server-wide and
                drasticaly changes how ACLs work. If this setting is
                changed, all ACL's may need to be updated. </td>
            </tr>
            <tr>
              <td colspan="2" class="action"><input type="submit" value="Change Precedence" name="changePrecedence"></td>
            </tr>
          </table>
          </td>
        </tr>
    </table>

    </form>
</body>
</html>
