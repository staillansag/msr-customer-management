<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Package Exchange</TITLE>
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  </HEAD>

  <BODY onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_UserMgmtLDAPConfigScrn');">
    <TABLE WIDTH=100%>

    <TR>
      <TD class="breadcrumb" colspan=2>
        Security &gt;
        User Management &gt;
        LDAP Configuration
        %ifvar doc equals('edit')%
            &gt; Edit
        %endif%
        </TD>
    </TR>

%ifvar action equals('change')%
  %invoke wm.server.jndi:setSettings%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
  %endinvoke%
%endif%

    %invoke wm.server.jndi:getSettings%

    <SCRIPT LANGUAGE="JavaScript">

      var provider = "%value provider encode(javascript)%";
      %ifvar ../doc equals('edit')%
      %else%
        %ifvar provider equals('LDAP')%
        // Only jump to ldap settings for LDAP and only when we're not
        // editing
		
		
		if(is_csrf_guard_enabled && needToInsertToken) {
				   
				createForm("htmlForm_ldap_settings", 'ldap-settings.dsp', "POST", "BODY");
				setFormProperty("htmlForm_ldap_settings", _csrfTokenNm_, _csrfTokenVal_);
				var htmlForm_ldap_settings = document.forms["htmlForm_ldap_settings"];
		        htmlForm_ldap_settings.submit();   
				   }
				   else
				   {
						var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
						if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							document.location="ldap-settings.dsp?webMethods-wM-AdminUI=true";
						}
						else {
							document.location="ldap-settings.dsp";
						}
				   }
				   
				
		
        %endif%
      %endif%

      function doWarn (needRestart) {
        var msg = "WARNING: changing your provider settings can\neffectively disable your server if the settings\nyou supply are incorrect.\n\nMake sure your provider settings are correct.";
        if(needRestart) msg += "\nYou will have to restart your server to see\nthe effects of these changes.";
        msg += "\n\nDo you wish to continue?\n";
        return confirm (msg);
      }

      function providerSelect () {
        var proSel = document.forms['jndiform'].provider;
        var pro;
        
        for (var i=0; i<proSel.length; i++) {
             if (proSel[i].checked == true) 
                 pro=  proSel[i].value;
        }
        
        if(pro=='local'){
            document.forms['jndiform'].CacheSize.disabled=true;
            document.forms['jndiform'].CacheExpire.disabled=true;
        }else if(pro=='LDAP'){
            document.forms['jndiform'].CacheSize.disabled=false;
            document.forms['jndiform'].CacheExpire.disabled=false;
        } 
      }
      
      function providerSubmit () {      
          var proSel = document.forms['jndiform'].provider;
          var pro;
                
            for (var i=0; i<proSel.length; i++) {
                          if (proSel[i].checked == true) 
                            pro=  proSel[i].value;
                          
            }
          var old = document.providerform.provider.value;
          // we don't need to warn iff pro=LDAP&&old=local || pro=local&&old=LDAP
          if (doWarn(!((pro=='LDAP'&&old=='local')||
               (pro=='local'&&old=='LDAP') ))) {
        document.providerform.provider.value = pro;
        //document.providerform.submit();

        return true;
          }
        setProvider (provider);
        return false;
      }

      function setProvider (pro) {
        var proSel = document.forms['jndiform'].provider;        
        for (var i=0; i<proSel.length; i++) {
          if (proSel[i].value == provider) proSel[i].checked = true;
        }
        return true;
      }

    </SCRIPT>
	<script>
                  createForm("htmlform_jndi_settings", "jndi-settings.dsp", "POST", "BODY");
	
				  createForm("htmlform_users", "users.dsp", "POST", "BODY");
	
				  createForm("htmlform_jndi_settings2", "jndi-settings.dsp", "POST", "BODY");
				  setFormProperty("htmlform_jndi_settings2", "doc", "edit");
		  </script>
	
    <TR>
      <TD colspan=2>
        <UL>
          %ifvar ../doc equals('edit')%

            <li class="listitem">
			<script>getURL("jndi-settings.dsp","javascript:document.htmlform_jndi_settings.submit();","Return to LDAP Configuration");</script></li>
          %else%
            <li class="listitem">
			<script>getURL("users.dsp","javascript:document.htmlform_users.submit();","Return to User Management");</script></li>
            <li class="listitem">
			<script>getURL("jndi-settings.dsp?doc=edit","javascript:document.htmlform_jndi_settings2.submit();","Edit LDAP Configuration");</script></li>
          %endif%
      </TD>
    </TR>
    <TR>
      <TD>
	      <FORM name="jndiform" id="jndiform" method="POST" action="jndi-settings.dsp">
	      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <INPUT type="hidden" name="action" value="change">

        <TABLE class="%ifvar doc equals('edit')%tableView%else%tableView%endif%">
          <TR>
            <TD class="heading" colspan=2>
              LDAP Configuration
            </TD>
          </TR>
          <TR>
            <TD class="oddrow">Provider</TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              %ifvar ../doc equals('edit')%
                
                <!--
                <SELECT name="provider" onchange="providerSelect();">
                  %switch provider%
                  %case 'local'%
                    <OPTION value="local" SELECTED>Local</OPTION>
                    <OPTION value="LDAP">LDAP</OPTION>                    
                  %case 'LDAP'%
                    <OPTION value="local">Local</OPTION>
                    <OPTION value="LDAP" SELECTED>LDAP</OPTION>                                     
                  %endswitch%
                </SELECT>
                -->
                %switch provider%
            %case 'local'%
			<input type="radio" name="provider" id="provider" value="local" CHECKED onchange="providerSelect();"><label for="provider">Local</label></input>
			<input type="radio" name="provider" id="provider1" value="LDAP" onchange="providerSelect();"><label for="provider1">LDAP</label></input>
		        %case 'LDAP'%
		        <input type="radio" name="provider" id="provider" value="local" onchange="providerSelect();"><label for="provider">Local</label></input>
			<input type="radio" name="provider" id="provider1" value="LDAP" CHECKED onchange="providerSelect();"><label for="provider1">LDAP</label></input>
        %endswitch%
              %else%
                %switch provider%
                %case 'local'%
                  Local
                %case 'LDAP'%
                  LDAP
                %case 'CDS'%
                  Central User Management                
                %endswitch%
                
              %endif%
            </TD>
          </TR>

          %ifvar properties%
            %loop properties%
              <TR>
                <script>writeTD("row");</script>
                  <label for="%value name encode(html_javascript)%">%value description encode(html)%</label>
                </TD>
              %ifvar ../doc equals('edit')%
                <script>writeTD("rowdata-l");writeEdit("%value ../doc encode(javascript)%","%value name encode(html_javascript)%","%value value encode(html_javascript)%",'%value name encode(html_javascript)%');</script></TD>
	    %else%
                <script>writeTD("rowdata");writeEdit("%value ../doc encode(javascript)%","%value name encode(html_javascript)%","%value value encode(html_javascript)%");</script></TD>
        %endif%
                <script>swapRows();</script>
                </TR>
            %endloop%
          %else%
            <!-- this should be the case where provider is local-->
            %ifvar ../doc equals('edit')%
        <tr>
          <td class="evenrow"><label for="cachesize"> Cache Size (Number of Users) </label></td>
          <script>writeTD("rowdata-l");</script>
	  <input type="text" name="CacheSize" id="cachesize" value="10"></td>
          <script>swapRows();</script>
        </tr>

        <tr>
          <td class="oddrow"> <label for="ttl">Credential Time-to-Live (Minutes)</label> </td>
          <script>writeTD("rowdata-l");</script>
	  <input type="text" name="CacheExpire" id="ttl" value="60"></td>
          <script>swapRows();</script>
        </tr>
        
        <script>
        document.forms['jndiform'].CacheSize.disabled=true;
        document.forms['jndiform'].CacheExpire.disabled=true;
        </script>
            
        %endif%
          %endif%

          %endinvoke%

          %ifvar doc equals('edit')%
          <TR>
            <TD class="action" colspan="2">
              <INPUT class="button2" type="submit" name="submitbtn" value="Save Configuration" onclick="return providerSubmit()">
            </TD>
          </TR>
          %endif%
        </TABLE>
	</FORM>
        

        <FORM name="providerform" method="POST" action="jndi-settings.dsp">
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
          <INPUT type="hidden" name="action" value="change">
          <INPUT type="hidden" name="provider" value="%value provider encode(htmlattr)%">
          <INPUT type="hidden" name="doc" value="edit">
        </FORM>
        </TD>
      </TR>
    </TABLE>
</BODY>
</HTML>
