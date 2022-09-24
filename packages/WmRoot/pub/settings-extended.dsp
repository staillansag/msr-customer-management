<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


  <TITLE>Integration Server Extended Settings</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT SRC="webMethods.js"></SCRIPT>
  <SCRIPT>
  
    function validateSettingsInput(){
            
        var value=document.forms["extendedForm"]["settings"].value;
                        
        if(value==null ||  value=='' ){
            return true;
        }
        
        var valueArr = value.split("\n");
        var invalidvalues=null;
        
        for(var i = 0;i<valueArr.length;i++){
            valueArr[i]=valueArr[i].replace(/^\s+/,""); // left trim
            var tmp=valueArr[i];
            tmp=tmp.replace(/^\s/,""); //to avoid all spaces
            
            if(tmp==''){
                continue;
            }
                        
            if(valueArr[i].substr(0,5)!='watt.'){
                
                var idx=valueArr[i].indexOf("=");
                var valueStr=valueArr[i];
                if(idx>0){
                    valueStr=valueStr.substr(0,idx);
                }
                if(invalidvalues==null){
                    invalidvalues=valueStr;
                }else{
                    invalidvalues=invalidvalues+","+valueStr;
                }
            }
        }
        
        if(invalidvalues!=null){
            alert('Invalid property names : {'+invalidvalues+'}'+'\n'+'The names of extended properties must begin with "watt.".');                 
            return false;
        }
        return true;
    }
    
  </SCRIPT>
</HEAD>

   <BODY onLoad="setNavigation('settings-extended.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ExtendedScrn');">
  <TABLE WIDTH="100%">
    <TR>
      <TD class="breadcrumb" colspan="4">
        Settings &gt;
        Extended </TD>
    </TR>
    <TR>

%ifvar action equals('change')%
  %invoke wm.server.admin:setExtendedSettings%
    %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
    %endif%
  %endinvoke%
%endif%

%ifvar action equals('showhide')%
  %invoke wm.server.admin:setExtendedSettingsVisible%
    %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
    %endif%
  %endinvoke%
%endif%


    <TR>
      <td colspan=2>
        <ul class="listitems">
          %ifvar mode equals('edit')%
		  <script>
		  createForm("htmlform_settings_extended", "settings-extended.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-extended.dsp", "javascript:document.htmlform_settings_extended.submit();", "Return to Extended Settings");</script>
		  </li>
          %else%
		  <script>
		  createForm("htmlform_settings_extended_editmode", "settings-extended.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_extended_editmode", "mode", "edit");
		  createForm("htmlform_settings_extended_showhide", "settings-extended-showhide.dsp", "POST", "BODY");
		  </script>
          <li class="listitem"><script>getURL("settings-extended.dsp?mode=edit", "javascript:document.htmlform_settings_extended_editmode.submit();", "Edit Extended Settings");</script>
		  </li>
          <li class="listitem"><script>getURL("settings-extended-showhide.dsp", "javascript:document.htmlform_settings_extended_showhide.submit();", "Show and Hide Keys");</script>
		  </li>
          %endif%
        </ul>
    </tr>
    <TR>
      <TD>
          <FORM name="extendedForm" action="settings-extended.dsp" method="POST">
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          <INPUT type="hidden" name="action" value="change">

        <TABLE class="tableView" width="50%" >


          <TR>
            <TD class="heading"><label for="extsettings">Extended Settings</label></TD>
          </TR>

          <TR>
            <TD class="oddcol-l">Key=Value</TD>
          </TR>

          <TR>
            <TD class="evenrow-l">
              %ifvar mode equals('edit')%
			  %invoke wm.server.query:getExtendedSettings%
              <TEXTAREA id="extsettings" style="width:100%" wrap="off" rows="15" cols="40" name="settings">%value settings encode(html)%</TEXTAREA>
			  %endinvoke%
              %else%
			  %invoke wm.server.query:getExtendedSettingsForView%
              <PRE class="fixedwidth">%value settingsview encode(html)%</PRE>
			  %endinvoke%
              %endif%
            </TD>
          </TR>
          %ifvar mode equals('edit')%
          <TR>
            <TD class="action">
              <INPUT type="submit" name="submit" value="Save Changes" onClick="return validateSettingsInput();">
            </TD>
          </TR>
          %endif%
          </FORM>

        </TABLE>
      </TD>
    </TR>
  </TABLE>
</BODY>
