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
    function update()
    {
      if (!verifyRequiredField("form1","driver"))
      {
         alert("Driver Alias Must be specified");
         return false;
      }
      if (!verifyRequiredField("form1","classname"))
      {
         alert("Driver Class Name Must be specified");
         return false;
      }
      if (document.forms["form1"]["funct"].value == "Add")
        document.forms["form1"]["funct"].value = "UpdateAdd";
      if (document.forms["form1"]["funct"].value == "Edit")
        document.forms["form1"]["funct"].value = "Update";
      return true;
    }
 
    function added(driver)
    {
		
        if(is_csrf_guard_enabled && needToInsertToken) {            
			setFormProperty("htmlform_settings_jdbcpool_add_driver", "addEditACT", "addDriver");
			setFormProperty("htmlform_settings_jdbcpool_add_driver", "message", driver);        
			setFormProperty("htmlform_settings_jdbcpool_add_driver", _csrfTokenNm_, _csrfTokenVal_);
			document.htmlform_settings_jdbcpool_add_driver.submit();
        } else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				location.href = encodeURI("settings-jdbcpool.dsp?addEditACT=addDriver&message="+driver+"&webMethods-wM-AdminUI=true");
			}
			else {
				location.href = encodeURI("settings-jdbcpool.dsp?addEditACT=addDriver&message="+driver);
			}
		}
        
    }
    function updated(driver)
    {	
		
        if(is_csrf_guard_enabled && needToInsertToken) {            
			setFormProperty("htmlform_settings_jdbcpool_update_driver", "addEditACT", "updateDriver");
			setFormProperty("htmlform_settings_jdbcpool_update_driver", "message", driver);         
			setFormProperty("htmlform_settings_jdbcpool_update_driver", _csrfTokenNm_, _csrfTokenVal_);
			document.htmlform_settings_jdbcpool_update_driver.submit();
        } else {
			var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
			if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				location.href = encodeURI("settings-jdbcpool.dsp?addEditACT=updateDriver&message="+driver+"&webMethods-wM-AdminUI=true");
			}
			else {
				location.href = encodeURI("settings-jdbcpool.dsp?addEditACT=updateDriver&message="+driver);
			}
		}
        
    }
    function updatefailed()
    {
        document.forms["form1"]["funct"].value = "Edit";
    }
    function addfailed()
    {
        document.forms["form1"]["funct"].value = "Add";
    }
</SCRIPT>
</HEAD>
%ifvar funct equals(Add)%
    
  <BODY onLoad="setNavigation('settings-editjdcbdriver.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CreateJDBC_DriverAliasScrn');">

%else%
  
  <BODY onLoad="setNavigation('settings-editjdcbdriver.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditJDBC_DriverAliasScrn');">
  
%endif%


<script>
createForm("htmlform_settings_jdbcpool_update_driver", "settings-jdbcpool.dsp", "POST", "BODY");
createForm("htmlform_settings_jdbcpool_add_driver", "settings-jdbcpool.dsp", "POST", "BODY");
</script>
<FORM NAME="form1" method="post">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  %ifvar funct equals(Add)%
  %else%
  <INPUT NAME="driver" TYPE="hidden" VALUE="%value driver encode(htmlattr)%">  
  %endif%
  <INPUT NAME="funct" TYPE="hidden" VALUE="%value funct encode(htmlattr)%">  
  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">
          Settings &gt;
          JDBC Pools &gt;
          Driver Aliases
          %switch funct%
        %case 'Add'%          
          &gt;
          New
        %case 'Edit'%  
        &gt Edit
          %endswitch%
      </TD>
    </TR>
    %switch funct%
      %case 'Update'%
        %invoke wm.server.jdbcpool:updateDriverAlias%
          %ifvar message%
            <SCRIPT>updatefailed();</SCRIPT>
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %else%  
            <SCRIPT>updated("%value driver encode(javascript)%");</SCRIPT>
          %endif%
        %onerror%
          <SCRIPT>updatefailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
        %endinvoke%
      %case 'UpdateAdd'%
        %invoke wm.server.jdbcpool:addDriverAlias%
          %ifvar message%
            <SCRIPT>addfailed();</SCRIPT>
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            <TR><TD colspan="2">&nbsp;</TD></TR>
          %else%  
            <SCRIPT>added("%value driver encode(javascript)%");</SCRIPT>
          %endif%
        %onerror%
          <SCRIPT>addfailed();</SCRIPT>
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
          <TR><TD colspan="2">&nbsp;</TD></TR>
        %endinvoke%
    %endswitch%

    %ifvar funct equals(Add)%
    %else%
      %invoke wm.server.jdbcpool:getDriverAlias%
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
    %endif%
    <TR>
      <TD colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jdbcpool", "settings-jdbcpool.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-jdbcpool.dsp","javascript:document.htmlform_settings_jdbcpool.submit();","Return to JDBC Pool Definitions")</script></li>
        </UL>
      </TD>
    </TR>
    <TR> 
      <TD>
          <TABLE class="tableView" style="width: 40%">
          <TR>
             %ifvar funct equals(Add)% 
                <TD class="heading" colspan="2">Add JDBC Driver Alias</TD>
             %else%
              %ifvar funct equals(Edit)% 
                <TD class="heading" colspan="2">Edit JDBC Driver Alias</TD>
              %else%
	            <TD class="heading" colspan="2">%value funct encode(html)% JDBC Driver Alias</TD>              
              %endif%
             %endif%
            
          </TR>
          <TR class="fullinputwidth">
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              <label for="alias">Alias Name</label></TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Add)%
                <INPUT NAME="driver" id="alias" TYPE="TEXT" VALUE="">
              %else%
                %value driver.name encode(html)%
              %endif%
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR class="fullinputwidth">
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
               <label for="description">Alias Description</label></TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%
                %value driver.description encode(html)%              
               %else%
                <INPUT NAME="description" id="description" TYPE="TEXT" VALUE="%value driver.description encode(htmlattr)%">
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR class="fullinputwidth">
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
               <label for="classname">Driver Class Name</label></TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
              %ifvar funct equals(Display)%
                %value driver.class encode(html)%              
              %else%
                <INPUT NAME="classname" id="classname" TYPE="TEXT" VALUE="%value driver.class encode(htmlattr)%">
              %endif%
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          %ifvar funct equals(Display)%
          %else%
            <TR>
              <TD colspan="2" class="action">
                <INPUT type="submit" value="Save Settings" onClick="return update();">
              </TD>
            </TR>
          %endif%
        </TABLE>
      </TD>
    </TR>
  </TABLE>      
</FORM>
</BODY>
</HTML>
