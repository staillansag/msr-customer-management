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
    <script>
    <!--
    function wrap(s, n) {
        var ret='';
        while(true) {
            var len = s.length;
            if(len <= n) {
                ret += s;
                return ret;
            }
            ret+= ((s.substring(0,n))+'<BR/>');
            s = s.substring(n);
        }
    }

	var aliasAry = [];
    function confirmDelete(index) {
		var url = aliasAry[index];
		var msg = 'Are you sure you want to delete the configuration for\n'+wrap(url,60)+'?';
       return confirm(msg);

    }
    //-->
    </script>
  </HEAD>
  <BODY onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ExternalUserMgmtConfigScrn');">
    <TABLE WIDTH=100%>

    <TR>
      <TD class="breadcrumb" colspan=2>
        Security &gt;
        Users &amp; Groups &gt;
        LDAP Configuration</TD>
    </TR>

%ifvar action equals('delete')%
  %invoke wm.server.ldap:deleteConfiguredServer%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('priority')%
  %invoke wm.server.ldap:updatePriority%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('edit')%
  %invoke wm.server.ldap:editConfiguredServer%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%ifvar action equals('add')%
  %invoke wm.server.ldap:addConfiguredServer%
      %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
  <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</TD></TR>
      %endif%
  %endinvoke%
%endif%

%invoke wm.server.ldap:getSettings%

    <TR>
      <TD colspan=2>
        <UL>
      <li>
	  <script>
		createForm("htmlform_users", "users.dsp", "POST", "BODY");					
      </script>
	  <script>getURL("users.dsp","javascript:document.htmlform_users.submit();","Return to User Management");</script></li>
            <li>
			<script>
		      createForm("htmlform_jndi_settings", "jndi-settings.dsp", "POST", "BODY");	
              setFormProperty("htmlform_jndi_settings", "doc", "edit");			  
            </script>
			<script>getURL("jndi-settings.dsp?doc=edit","javascript:document.htmlform_jndi_settings.submit();","Edit LDAP Configuration");</script>
			</li>
      </TD>
    </TR>

    <TR>
      <TD>
        <TABLE class="tableView">
          <TR>
            <TD class="heading" colspan=2>
              LDAP Configuration
            </TD>
          </TR>
          <TR>
            <script>writeTD("row");</script>
                Provider
            </TD>
            <script>writeTD("rowdata-l")</script>LDAP
            </TD>
          </TR>
            <script>swapRows();</script>
          <TR>
            <script>writeTD("row");</script>
                <label for="cachesize">Cache Size (Number of Users)</label>
            </TD>
            <script>writeTD("rowdata-l");writeEdit("%value doc encode(javascript)%","%value CacheSize encode(html_javascript)%","%value CacheSize encode(html_javascript)%",'cachesize');</script></TD>

          </TR>
            <script>swapRows();</script>
          %comment% <!-- not going to expose CacheTTL in the UI -->
          <TR>
            <script>writeTD("row");</script>
                <label for="ttl">Cache Time-to-Live (Hours)</label>
            </TD>
            <script>writeTD("rowdata-l");writeEdit("%value doc encode(javascript)%","%value CacheTTL encode(html_javascript)%","%value CacheTTL encode(html_javascript)%",'ttl');</script></TD>

          </TR>
            <script>swapRows();</script>
          %endcomment%
          <TR>
            <script>writeTD("row");</script>
                Credential Time-to-Live (Minutes)
            </TD>
            <script>writeTD("rowdata-l");writeEdit("%value doc encode(javascript)%","%value CacheExpire encode(html_javascript)%","%value CacheExpire encode(html_javascript)%");</script></TD>

          </TR>
            <script>swapRows();</script>

        </TABLE>

<TR>
    <TD colspan="2">
        <UL>
            <li>
			<script>
		      createForm("htmlform_ldap_addedit", "ldap-addedit.dsp", "POST", "BODY");					
            </script>
			
			<script>getURL("ldap-addedit.dsp","javascript:document.htmlform_ldap_addedit.submit();","Add LDAP Directory");</script></li>
        </UL>
    </TD>
</TR>
<TR>
    <TD>
    <TABLE class="tableView" width=100%>

    <TR>
        <TD class="heading" colspan=9>LDAP Directory List</TD>
    </TR>
<TR>
   <th scope="col" CLASS="evencol-l" width="70%">Directory URL</th>
   <th scope="col" CLASS="evencol-l">Delete</th>
   <th scope="col" CLASS="evencol-l">Priority</th>
</TR>

%loop ConfiguredServers%
<script> aliasAry['%value $index%'] = '%value url encode(javascript)%'; </script>
<TR valign=top>
   <script>writeTD("rowdata-l");</script>
   <script>
		      createForm("htmlform_ldap_addedit1_%value $index%", "ldap-addedit.dsp", "POST", "BODY");	
              setFormProperty("htmlform_ldap_addedit1_%value $index%", "action", "edit");
              setFormProperty("htmlform_ldap_addedit1_%value $index%", "index", "%value $index%");		  
   </script>
   
   <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_ldap_addedit1_%value $index%.submit();">');
				document.writeln(wrap("%value  url encode(html_javascript)%", 90));
				document.write('</a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="ldap-addedit.dsp?action=edit&index=%value $index encode(url)%&webMethods-wM-AdminUI=true">');
					}
					else {
						document.write('<a href="ldap-addedit.dsp?action=edit&index=%value $index encode(url)%">');
					}
					document.writeln(wrap("%value  url encode(html_javascript)%", 90));
					document.write('</a>');
		       }
           </script>
   </TD>
   <!--
   <script>writeTD("rowdata");</script>
   <script>
		      createForm("htmlform_ldap_acl_%value $index%", "ldap-acl.dsp", "POST", "BODY");	
              setFormProperty("htmlform_ldap_acl_%value $index%", "index", "%value $index encode(url)%");
   </script>
    <a href="javascript:document.htmlform_ldap_acl_%value $index%.submit();">Map</a>
    </TD>
    -->
   <script>writeTD("rowdata");</script>
   <script>
		      createForm("htmlform_ldap_settings_%value $index%", "ldap-settings.dsp", "POST", "BODY");	
			  setFormProperty("htmlform_ldap_settings_%value $index%", "action", "delete");
              setFormProperty("htmlform_ldap_settings_%value $index%", "index", "%value $index%");
   </script>
    
	<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a class="imagelink" href="javascript:document.htmlform_ldap_settings_%value $index%.submit();" onClick="return confirmDelete(\'%value $index%\');"><img src="icons/delete.png" alt="Delete Directory URL" border="none"></a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a class="imagelink" href="ldap-settings.dsp?action=delete&index=%value $index encode(url)%&webMethods-wM-AdminUI=true" onClick="return confirmDelete(\'%value $index%\');"><img src="icons/delete.png" alt="Delete Directory URL" border="none"></a>');
					}
					else {
						document.write('<a class="imagelink" href="ldap-settings.dsp?action=delete&index=%value $index encode(url)%" onClick="return confirmDelete(\'%value $index%\');"><img src="icons/delete.png" alt="Delete Directory URL" border="none"></a>');
					}
			   }
           </script>
    </TD>
   <script>writeTD("rowdata");</script>
   <script>
		      createForm("htmlform_ldap_settings1_%value $index%", "ldap-settings.dsp", "POST", "BODY");	
			  setFormProperty("htmlform_ldap_settings1_%value $index%", "action", "priority");
			  setFormProperty("htmlform_ldap_settings1_%value $index%", "direction", "up");
              setFormProperty("htmlform_ldap_settings1_%value $index%", "index", "%value $index%");
   </script>
    <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_ldap_settings1_%value $index%.submit();"><img id = "link_up_%value $index encode(htmlattr)%" src="icons/moveup_enabled.png" alt="Increase priority" border="none"></a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="ldap-settings.dsp?action=priority&direction=up&index=%value $index encode(url)%&webMethods-wM-AdminUI=true"><img id = "link_up_%value $index encode(htmlattr)%" src="icons/moveup_enabled.png" alt="Increase priority" border="none"></a>');
					}
					else {
						document.write('<a href="ldap-settings.dsp?action=priority&direction=up&index=%value $index encode(url)%"><img id = "link_up_%value $index encode(htmlattr)%" src="icons/moveup_enabled.png" alt="Increase priority" border="none"></a>');
					}
		       }
           </script>

    <script>
		      createForm("htmlform_ldap_settings2_%value $index%", "ldap-settings.dsp", "POST", "BODY");	
			  setFormProperty("htmlform_ldap_settings2_%value $index%", "action", "priority");
			  setFormProperty("htmlform_ldap_settings2_%value $index%", "direction", "down");
              setFormProperty("htmlform_ldap_settings2_%value $index%", "index", "%value $index%");
   </script>	
    
	<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a href="javascript:document.htmlform_ldap_settings2_%value $index%.submit();"><img id = "link_down_%value $index encode(htmlattr)%" src="icons/movedown_enabled.png" alt="Decrease priority" border="none"></a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a href="ldap-settings.dsp?action=priority&direction=down&index=%value $index encode(url)%&webMethods-wM-AdminUI=true"><img id = "link_down_%value $index encode(htmlattr)%" src="icons/movedown_enabled.png" alt="Decrease priority" border="none"></a>');
					}
					else {
						document.write('<a href="ldap-settings.dsp?action=priority&direction=down&index=%value $index encode(url)%"><img id = "link_down_%value $index encode(htmlattr)%" src="icons/movedown_enabled.png" alt="Decrease priority" border="none"></a>');
					}
		       }
           </script> 
    %ifvar $index equals('0')%
          <script>
                var firstUp =document.getElementById("link_up_%value $index encode(javascript)%");
                var lastDown;
          </script>
    %endif%
    <script>
        lastDown =  document.getElementById("link_down_%value $index encode(javascript)%");
    </script> 
   </TD>
</TR>
    <script>swapRows();</script>
%endloop%    
%endinvoke%
<script>
    function disableDirectionImage(link,direction){
         if('UP' == direction){
            link.src='icons/moveup_disabled.png';
         }
         else{
            link.src='icons/movedown_disabled.png';
         }
         link.disabled=true;
         link.style.color='gray';
         link.style.cursor='default';
         link.onclick=function (){return false;}
    }
    disableDirectionImage(firstUp,'UP');
    disableDirectionImage(lastDown,'DOWN');
</script>

<!-- ================================= -->


        </FORM>

        </TD>
      </TR>
    </TABLE>

</BODY>
</HTML>
