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
    function add()
    {
      if (!verifyRequiredField("form1","function.name"))
      {
         alert("Function Alias must be specified");
         return false;
      }
      var pool = document.forms["form1"]["pool"].value;
      if (pool.length < 1)
      {
         if (!confirm("Do you really want to add the Functional Alias without an Associated Pool?"))
         {
             return false;
         } 
      }   
      document.forms["form1"]["funct"].value = "UpdateAdd";
      return true;
    }
    function update()
    {
      var pool = document.forms["form1"]["pool"].value;
      var failfastmode = document.forms["form1"]["isFailFastMode"].value;
      if (pool.length < 1)
      {
         if (!confirm("Do you really want to update the Functional Alias without an Associated Pool?"))
         {
             return false;
         } 
      }   
      document.forms["form1"]["origfunct"].value = document.forms["form1"]["funct"].value;
      document.forms["form1"]["funct"].value = "Update";
      document.forms["form1"]["function.pool"].value = pool;
      document.forms["form1"]["function.failfastmode"].value = failfastmode;
      return true;
    }
    function generate()
    {
      if (!verifyRequiredField("form1","function.name"))
      {
         alert("Function Alias must be specified");
         return false;
      }
      var pool = document.forms["form1"]["pool"].value;
      if (pool.length > 0)
      {
         if (!confirm("Do you really want to generate the .XML file with an Associated Pool?"))
         {
          return false;
         }
      }   
      document.forms["form1"]["origfunct"].value = document.forms["form1"]["funct"].value;
      document.forms["form1"]["funct"].value = "Generate";
      document.forms["form1"]["function.pool"].value = pool;
      return true;
    }
    function deleteFunct(alias)
    {
      var msg = " Delete the Funtional Alias:"+alias;
      if(confirm(msg))
      {
        document.forms["form1"]["funct"].value = "Delete";
        return true;
      }
      return false;
    }
    function updated(alias)
    {
		
        if(is_csrf_guard_enabled && needToInsertToken) {            
			createForm("htmlform_settings_jdbcpool_update_alias", "settings-jdbcpool.dsp", "POST", "HEAD");
			setFormProperty("htmlform_settings_jdbcpool_update_alias", "message", "Functional Alias "+alias+" updated. Please restart the server to make the new settings take effect.");
			setFormProperty("htmlform_settings_jdbcpool_update_alias", _csrfTokenNm_, _csrfTokenVal_);
			location.href="javascript:document.htmlform_settings_jdbcpool_update_alias.submit();";
        } else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				location.href=encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" updated. Please restart the server to make the new settings take effect.&webMethods-wM-AdminUI=true");
			}
			else {
				location.href=encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" updated. Please restart the server to make the new settings take effect.");
			}
		}
        
    }
    function added(alias)
    {
		
        if(is_csrf_guard_enabled && needToInsertToken) {    
			createForm("htmlform_settings_jdbcpool_add_alias", "settings-jdbcpool.dsp", "POST", "HEAD");
			setFormProperty("htmlform_settings_jdbcpool_add_alias", "message", "Functional Alias "+alias+" added. Please restart the server to make the new settings take effect.");
			setFormProperty("htmlform_settings_jdbcpool_add_alias", _csrfTokenNm_, _csrfTokenVal_);
			location.href="javascript:document.htmlform_settings_jdbcpool_add_alias.submit();";
        } else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				location.href=encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" added. Please restart the server to make the new settings take effect.&webMethods-wM-AdminUI=true");
			}
			else {
				location.href=encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" added. Please restart the server to make the new settings take effect.");
			}
		}
        
    }
    function deleted(alias)
    {
		        
        if(is_csrf_guard_enabled && needToInsertToken) {          
			createForm("htmlform_settings_jdbcpool_delete_alias", "settings-jdbcpool.dsp", "POST", "HEAD");
			setFormProperty("htmlform_settings_jdbcpool_delete_alias", "message", "Functional Alias "+alias+" deleted.");
			setFormProperty("htmlform_settings_jdbcpool_delete_alias", _csrfTokenNm_, _csrfTokenVal_);
			location.href="javascript:document.htmlform_settings_jdbcpool_delete_alias.submit();";
        } else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				location.href=encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" deleted.&webMethods-wM-AdminUI=true");
			}
			else {
				location.href=encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" deleted.");
			}
		}
        
    }
    function generated(alias)
    {
		
        if(is_csrf_guard_enabled && needToInsertToken) {
			createForm("htmlform_settings_jdbcpool_generate_alias", "settings-jdbcpool.dsp", "POST", "HEAD");
			setFormProperty("htmlform_settings_jdbcpool_generate_alias", "message", "Functional Alias "+alias+" generated.");
            setFormProperty("htmlform_settings_jdbcpool_generate_alias", _csrfTokenNm_, _csrfTokenVal_);
			location.href="javascript:document.htmlform_settings_jdbcpool_generate_alias.submit();";
        } else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				location.href=encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" generated.&webMethods-wM-AdminUI=true");
			}
			else {
				location.href=encodeURI("settings-jdbcpool.dsp?message=Functional Alias "+alias+" generated.");
			}
		}
        
    }
    function updatefailed()
    {
        document.forms["form1"]["funct"].value = "Edit";
    }
    function deletefailed()
    {
        document.forms["form1"]["funct"].value = "Edit";
    }
    function generatefailed()
    {
        document.forms["form1"]["funct"].value = document.forms["form1"]["origfunct"].value;
    }
    function addfailed()
    {
        document.forms["form1"]["funct"].value = "Add";
    }
</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('settings-editjdcbfunction.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditJDBC_FunctionalAliasScrn');">
%comment%
    body
    %loop -struct%
    %value $key encode(html)% %value%<BR>
    %endloop%
%endcomment%
<FORM NAME="form1" method="post">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <INPUT NAME="function" TYPE="hidden" VALUE="%value function encode(htmlattr)%">  
  <INPUT NAME="funct" TYPE="hidden" VALUE="%value funct encode(htmlattr)%">  
  <INPUT NAME="origfunct" TYPE="hidden" VALUE="%value funct encode(htmlattr)%">  
  <INPUT NAME="internal" TYPE="hidden" VALUE="%value internal encode(htmlattr)%">  
  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">
          Settings &gt;
          JDBC Pools &gt;
          Functional Definitions
          %ifvar funct equals(Edit)%                
          &gt Edit
          %endif%
      </TD>
    </TR>
    %switch funct%
    %case 'UpdateAdd'%
      %invoke wm.server.jdbcpool:addFunctionalAlias%
        %ifvar message%
          <SCRIPT>addfailed();</SCRIPT>
          %ifvar message%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %endif%
        %else%
          <SCRIPT>added("%value function encode(javascript)%");</SCRIPT>
        %endif%
      %onerror%
          <SCRIPT>addfailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %case 'Generate'%
      %invoke wm.server.jdbcpool:generateFunctionalAlias%
        %ifvar message%
          <SCRIPT>generatefailed();</SCRIPT>
          %ifvar message%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %endif%
        %else%
          <SCRIPT>generated("%value function encode(javascript)%");</SCRIPT>
        %endif%
      %onerror%
          <SCRIPT>generatefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %case 'Update'%
      %invoke wm.server.jdbcpool:updateFunctionalAlias%
        %ifvar message%
          <SCRIPT>updatefailed();</SCRIPT>
          %ifvar message%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %endif%
        %else%
          <SCRIPT>updated("%value function encode(javascript)%");</SCRIPT>
        %endif%
      %onerror%
          <SCRIPT>updatefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %case 'Delete'%
      %invoke wm.server.jdbcpool:deleteFunctionalAlias%
        %ifvar message%
          <SCRIPT>deletefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
        %else%
          <SCRIPT>deleted("%value function encode(javascript)%");</SCRIPT>
        %endif%
      %onerror%
          <SCRIPT>deletefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %case 'Edit'%
      %invoke wm.server.jdbcpool:getFunctionalAlias%
        %ifvar message%
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
        %endif%
      %onerror%
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
      %endinvoke%
    %endswitch%
    <TR>
      <TD colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jdbcpool", "settings-jdbcpool.dsp?", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-jdbcpool.dsp?","javascript:document.htmlform_settings_jdbcpool.submit();","Return to JDBC Pool Definitions")</script></li>
        </UL>
      </TD>
    </TR>
    <TR> 
      <TD>
          <TABLE class="tableView" style="width: 25%">
          <TR>
            <TD class="heading" colspan="2">JDBC Functional Alias</TD>
          </TR>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Function Name</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Add)%
                <INPUT NAME="function.name" TYPE="TEXT" VALUE="">
              %else%
                <INPUT NAME="function.name" TYPE="HIDDEN" VALUE="%value function.name encode(htmlattr)%">
                %value function.name encode(html)%
              %endif%
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Function Description</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Add)%
                <INPUT NAME="function.description" TYPE="TEXT" VALUE="%value function.description encode(htmlattr)%">
               %else%
                 %ifvar funct equals(Edit)%
                   %ifvar internal equals(true)%
                     <INPUT TYPE="TEXT" NAME="function.description" VALUE="%value function.description encode(htmlattr)%">
                   %else%
                     <INPUT NAME="function.description" TYPE="HIDDEN" VALUE="%value function.description encode(htmlattr)%">
                     %value function.description encode(html)%
                   %endif%                
                 %else%  
                   <INPUT NAME="function.description" TYPE="HIDDEN" VALUE="%value function.description encode(htmlattr)%">
                   %value function.description encode(html)%
                 %endif%
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              <label for="pool">Associated Pool Alias</label></TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                %invoke wm.server.jdbcpool:getAvailablePoolDefinitions%
                  %ifvar message%
                    </TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                    <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                    <TR><TD colspan="2">&nbsp;</TD></TR>
                  %endif%
                  <SELECT id="pool" NAME="pool">
                    <OPTION VALUE="" %ifvar function.pool notempty% %else% SELECTED %endif%>None
                  %loop pools%
                    <OPTION VALUE="%value pool.name encode(htmlattr)%" %ifvar ../function.pool vequals(pool.name)% SELECTED %endif%>%value pool.name encode(html)%
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
			%ifvar function.exposeFailFast equals('false')%
				<INPUT type="hidden" name="isFailFastMode" id="isFailFastMode2"  VALUE="false">
			%else%
            <tr>
                <td class="oddrow">Fail-Fast Mode Enabled</td>
                <td class="oddrow-l">
                    %ifvar function.failfastmode equals('true')%
						<INPUT TYPE="radio" name="isFailFastMode" id="isFailFastMode1"  VALUE="true" checked><label for="isFailFastMode1">Yes</label></INPUT>
						<INPUT TYPE="radio" name="isFailFastMode" id="isFailFastMode2"  VALUE="false"><label for="isFailFastMode2">No</label></INPUT>
                    %else%
						<INPUT TYPE="radio" name="isFailFastMode" id="isFailFastMode1"  VALUE="true" ><label for="isFailFastMode1">Yes</label></INPUT>
						<INPUT TYPE="radio" name="isFailFastMode" id="isFailFastMode2"  VALUE="false" checked><label for="isFailFastMode2">No</label></INPUT>
                    %endif%
                </td>
            </tr>   
            <SCRIPT>swapRows();</SCRIPT>
            <tr>
                <td class="oddrow">Currently In Fail-Fast?</td>
                <td class="oddrow-l">
                    %ifvar function.infailfastmode equals('true')%
                        Yes
                    %else%
                        No
                    %endif%
                </td>
            </tr>  
			%endif%
          %switch funct%
            %case 'Add'%
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Auto Commit</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <INPUT NAME="function.autocommit" TYPE="checkbox" VALUE="active" %ifvar function.autocommit equals(active)%CHECKED%endif%>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Statement Cache</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <INPUT NAME="function.cache" TYPE="checkbox" VALUE="active" %ifvar function.cache equals(active)%CHECKED%endif%>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Isolation Level</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <SELECT NAME="isolationlevel">
                      <OPTION VALUE="-1" %ifvar function.isolationlevel equals(-1)%SELECTED%endif%>Database default
                      <OPTION VALUE="0" %ifvar function.isolationlevel equals(0)% SELECTED%endif%>TRANSACTION_NONE
                      <OPTION VALUE="1" %ifvar function.isolationlevel equals(1)% SELECTED%endif%>TRANSACTION_READ_UNCOMMITTED
                      <OPTION VALUE="2" %ifvar function.isolationlevel equals(2)% SELECTED%endif%>TRANSACTION_READ_COMMITTED
                      <OPTION VALUE="4" %ifvar function.isolationlevel equals(4)% SELECTED%endif%>TRANSACTION_REPEATABLE_READ
                      <OPTION VALUE="8" %ifvar function.isolationlevel equals(8)% SELECTED%endif%>TRANSACTION_SERIALIZABLE
                    </SELECT>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                 <TD class="action">
                    <INPUT type="submit" value="Generate .XML" onClick="return generate();">
                  </TD>
                  <TD class="action">
                    <INPUT type="submit" value="Save into Repository" onClick="return add();">
                  </TD>
                 </TR>
            %case 'Edit'%
              %ifvar internal equals(true)%
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Auto Commit</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <INPUT NAME="function.autocommit" TYPE="checkbox" VALUE="active" %ifvar function.autocommit equals(active)%CHECKED%endif%>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Statement Cache</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <INPUT NAME="function.cache" TYPE="checkbox" VALUE="active" %ifvar function.cache equals(active)%CHECKED%endif%>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <SCRIPT>writeTDnowrap("row");</SCRIPT>
                    Isolation Level</TD>
                  <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                    <SELECT NAME="isolationlevel">
                      <OPTION VALUE="-1" %ifvar function.isolationlevel equals(-1)%SELECTED%endif%>Database default
                      <OPTION VALUE="0" %ifvar function.isolationlevel equals(0)% SELECTED%endif%>TRANSACTION_NONE
                      <OPTION VALUE="1" %ifvar function.isolationlevel equals(1)% SELECTED%endif%>TRANSACTION_READ_UNCOMMITTED
                      <OPTION VALUE="2" %ifvar function.isolationlevel equals(2)% SELECTED%endif%>TRANSACTION_READ_COMMITTED
                      <OPTION VALUE="4" %ifvar function.isolationlevel equals(4)% SELECTED%endif%>TRANSACTION_REPEATABLE_READ
                      <OPTION VALUE="8" %ifvar function.isolationlevel equals(8)% SELECTED%endif%>TRANSACTION_SERIALIZABLE
                    </SELECT>
                  </TD>
                </TR>
                <SCRIPT>swapRows();</SCRIPT>
                <TR>
                  <TD class="action">
                    <INPUT type="submit" value="Generate .XML" onClick="return generate();">
                  </TD>
                  <TD class="action">
                    <TABLE>
                      <TR>
                        <TD> 
                          <INPUT type="submit" value="Save into Repository" onClick="return update();">
                        </TD>
                        <TD>
                          <INPUT type="submit" value="Delete from Repository" onClick="return deleteFunct('%value function.name encode(javascript)%');">
                        </TD>
                      </TR>
                    </TABLE>
                  </TD> 
                </TR>
              %else%
                <TR>
                  <TD colspan="2" class="action">
                    <INPUT type="submit" value="Save Settings" onClick="return update();">
                  </TD>
                </TR>
                <INPUT NAME="isolationlevel" TYPE="hidden" VALUE="%value function.isolationlevel encode(htmlattr)%">
                <INPUT NAME="function.cache" TYPE="hidden" VALUE="%value function.cache encode(htmlattr)%">
                <INPUT NAME="function.autocommit" TYPE="hidden" VALUE="%value function.autocommit encode(htmlattr)%">
                <INPUT NAME="function.pool" TYPE="hidden" VALUE="%value function.pool encode(htmlattr)%">
                <INPUT NAME="function.description" TYPE="HIDDEN" VALUE="%value function.description encode(htmlattr)%">
              %endif%
          %endswitch%
        </TABLE>
      </TD>
    </TR>
  </TABLE>      
</FORM>
</BODY>
</HTML>
