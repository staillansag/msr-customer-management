<html>

<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js"></script>
  
  <script language ="javascript"> 
    var _isLocal = true;
    function setLocal(local) {
      _isLocal = local;
    }
    
    function getLocal() {
      return _isLocal;
    } 
    </script>
    
    <TITLE>Integration Server</TITLE>
  </HEAD>

  <BODY onLoad="setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_webMMsgingSettings_ChangeDefaultConnectionAliasScrn');">

    <TABLE width="100%">

    <TR>
      <TD class="breadcrumb" colspan=2>Settings &gt; Messaging &gt; webMethods Messaging Settings &gt; Change Default Connection Alias
      </TD>
    </TR>
    <TR><TD colspan="2">
    <ul class="listitems"><li class="listitem">
	<script>
	createForm("htmlform_settings_wm_messaging", "settings-wm-messaging.dsp", "POST", "BODY");
	</script>
	<script>getURL("settings-wm-messaging.dsp", "javascript:document.htmlform_settings_wm_messaging.submit();", "Return to webMethods Messaging Settings");</script>
	
	</li></UL>

    </TD>
    </TR>

    <TR>
      <TD>
        <TABLE class="tableView" width="25%">

        <tr>
          <td class="heading" colspan="2">Select New Default Connection Alias</td>
        </tr>
        
        <form name="primary" action="settings-wm-messaging.dsp" method="post">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation" value="setPrimary">
        <tr>
            <td class="oddrow"><label for="aliasName">Connection Alias Name</label></td>
            <td class="oddrow-l">
                %invoke wm.server.messaging:getConnectionAliasReport%
                <select id="aliasName" name="aliasName">
                  %loop aliasDataList%
                    <option value="%value aliasName encode(htmlattr)%" %ifvar defaultAlias equals('true')%selected%endif%>%value aliasName encode(html)%</option>
                    %ifvar defaultAlias equals('true')%
                      <script>setLocal(false);</script>
                    %endif%
                  %endloop%
                  <script>
                    if (getLocal()) {
                      document.write("<option value='[LOCAL]' selected></option>");
                    //} else {
                    // document.write("<option value='[LOCAL]'></option>");
                    }
                  </script>
                  
                </select>
                %endinvoke%
            </td>
        </tr>
        <tr>
            <td class="action" colspan="2">
              <input name="action" type="hidden" value="changeDefaultConnectionAlias">
              <input type="submit" value="Update">
            </td>
            
            
        </tr>

        </form>
      </TABLE>
    </TD>
  </TR>
</TABLE>
</BODY>
</HTML>
