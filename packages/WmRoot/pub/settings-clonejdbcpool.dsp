<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<SCRIPT SRC="webMethods.js"></SCRIPT>
<SCRIPT>
    String.prototype.trim = function () {
        return this.replace(/^\s*/, "").replace(/\s*$/, "");
    }
    function update()
    {
      if (!verifyRequiredField("form1","clonename"))
      {
         alert("Pool Alias must be specified");
         return false;
      }
      if (document.forms["form1"]["funct"].value == "Clone")
        document.forms["form1"]["funct"].value = "CloneAdd";
      document.forms["form1"]["url"].value = (document.forms["form1"]["url"].value).trim();
      return true;
    }
    function cloned(pool)
    {
    
		setFormProperty("htmlform_settings_jdbcpool", "addEditACT", "clonePool");
		setFormProperty("htmlform_settings_jdbcpool", "message", pool);
	    
        
        if(is_csrf_guard_enabled && needToInsertToken) {
			setFormProperty("htmlform_settings_jdbcpool", _csrfTokenNm_, _csrfTokenVal_);   
			document.htmlform_settings_jdbcpool.submit();			
        } else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				location.href=encodeURI("settings-jdbcpool.dsp?addEditACT=clonePool&message="+pool+"&webMethods-wM-AdminUI=true");
			}
			else {
				location.href=encodeURI("settings-jdbcpool.dsp?addEditACT=clonePool&message="+pool);
			}
		}
        
    }
    function clonefailed()
    {
        document.forms["form1"]["funct"].value = "Clone";
    }
    function clonecancel()
    {
        document.forms["form1"]["clonename"].value = "";
		var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
            location.href=encodeURI("settings-jdbcpool.dsp?&webMethods-wM-AdminUI=true");
        }
        else{
             location.href=encodeURI("settings-jdbcpool.dsp");
         }
    }

</SCRIPT>
</HEAD>


<BODY onLoad="setNavigation('settings-clonejdcbpool.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CopyJDBC_PoolAliasScrn');">
<script>
createForm("htmlform_settings_jdbcpool", "settings-jdbcpool.dsp", "POST", "BODY");
</script>
<FORM NAME="form1" method="post" >
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <INPUT NAME="funct" TYPE="hidden" VALUE="%value funct encode(htmlattr)%">

  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">
          Settings &gt;
          JDBC Pools &gt;
          Connection Aliases &gt;
          Copy
      </TD>
    </TR>
    %ifvar funct equals(CloneAdd)%
      %invoke wm.server.jdbcpool:clonePoolAlias%
      %ifvar message%
        <SCRIPT>addfailed();</SCRIPT>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %else%
        <SCRIPT>cloned("%value clonename encode(javascript)%")</SCRIPT>
      %endif%
      %onerror%
        <SCRIPT>clonefailed();</SCRIPT>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %endif%
    <TR>
      <TD colspan="2">
        <ul class="listitems">
		  <script>
	      createForm("htmlform_settings_jdbcpool_return", "settings-jdbcpool.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-jdbcpool.dsp","javascript:document.htmlform_settings_jdbcpool_return.submit();","Return to JDBC Pool Definitions");</script></li>
          %ifvar funct equals(Display)%
		  <script>
	      createForm("htmlform_settings_editjdbcpool", "settings-editjdbcpool.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_editjdbcpool", "funct", "Edit");
		  setFormProperty("htmlform_settings_editjdbcpool", "pool", "%value pool%");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-editjdbcpool.dsp?funct=Edit&pool=%value pool encode(url)%","javascript:document.htmlform_settings_editjdbcpool.submit();","Edit this JDBC Connection Pool Alias definition");</script></li>
          %endif%
        </UL>
      </TD>
    </TR>
    <TR>
      <TD>
        <TABLE class="tableView" style="width: 40%">
          <TR>
            <TD class="heading" colspan="2">JDBC Connection Pool Alias - Copy</TD>
          </TR>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              <label for="pool">Copy From</label></TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                %invoke wm.server.jdbcpool:getPoolDefinitions%
                  %ifvar message%
                    </TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                  %endif%
                  <SELECT id="pool" NAME="pool">
                  %loop pools%
                    <OPTION VALUE="%value pool.name encode(htmlattr)%" %ifvar ../pool vequals(pool.name)% SELECTED %endif%>%value pool.name encode(html)%
                  %endloop%
                  </SELECT>
                  </TD></TR>
                %onerror%
                  </TD></TR>
                  <TR><TD colspan="2">&nbsp;</TD></TR>
                  <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
                  <TR><TD colspan="2">&nbsp;</TD></TR>
                %endinvoke%
            <SCRIPT>swapRows();</SCRIPT>
          <TR class="fullinputwidth">
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              <label for="clonename">Alias Name</label></TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
            <INPUT NAME="clonename" id="clonename" TYPE="TEXT" VALUE="">
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
            <TR>
              <TD colspan="2" class="action">
                <INPUT type="submit" value="Copy Settings" onClick="return update();">
                <INPUT type="button" value="Cancel" onClick="return clonecancel();">
              </TD>
            </TR>
         </TABLE>
      </TD>
    </TR>
  </TABLE>
</FORM>
</BODY>
</HTML>
