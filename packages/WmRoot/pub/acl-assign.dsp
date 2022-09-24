
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
    <SCRIPT LANGUAGE="JavaScript">
    var currentAcl =  %ifvar acl -notempty% "%value acl encode(javascript)%"; 
		      %else% 
			%ifvar effectiveAcl -notempty% "<%value effectiveAcl encode(javascript)%> (inherited)"; 
			%else% 
			"<%value parentexecuteaclgroup encode(javascript)%> (inherited)";
			%endif%
		      %endif%

    var currentBrowseAcl =  %ifvar browseaclgroup -notempty%  "%value browseaclgroup encode(javascript)%"; 
		%else%  
			%ifvar effectiveAclBrowse -notempty% "<%value effectiveAclBrowse encode(javascript)%> (inherited)"; 
			%else% 
			"<%value parentbrowseaclgroup encode(javascript)%> (inherited)";
			%endif%
		%endif%

    var currentReadAcl =  %ifvar readaclgroup -notempty%  "%value readaclgroup encode(javascript)%"; 
		%else%  
			%ifvar effectiveAclRead -notempty%"<%value effectiveAclRead encode(javascript)%> (inherited)"; 
			%else% 
			"<%value parentreadaclgroup encode(javascript)%> (inherited)";
			%endif%
		%endif%

    var currentWriteAcl =  %ifvar writeaclgroup -notempty%  "%value writeaclgroup encode(javascript)%"; 
		%else%  
			%ifvar effectiveAclWrite -notempty%"<%value effectiveAclWrite encode(javascript)%> (inherited)"; 
			%else% 
			"<%value parentwriteaclgroup encode(javascript)%> (inherited)";
			%endif%
		%endif%
    
	
    function onClick (action)
    {
      if (action == "reset")
      {
        document.forms["aclForm"].reset();
      }
      else if (action == "submit")
      {
        document.forms["aclForm"].submit();
      }
      else
      {
        document.forms["aclForm"].action.value = "xxx";
        document.forms["aclForm"].submit();
      }
    }
    function updateSelector ()
    {
      var sel = document.forms["aclForm"].acl;
      for (var i=0; i<sel.options.length; i++)
      {
        if (sel.options[i].value == currentAcl) sel.selectedIndex = i;
      }
      var selbrowse = document.forms["aclForm"].browseaclgroup;
      for (var i=0; i<selbrowse.options.length; i++)
      {
        if (selbrowse.options[i].value == currentBrowseAcl) selbrowse.selectedIndex = i;
      }
      var selread = document.forms["aclForm"].readaclgroup;
      for (var i=0; i<selread.options.length; i++)
      {
        if (selread.options[i].value == currentReadAcl) selread.selectedIndex = i;
      }
      var selwrite = document.forms["aclForm"].writeaclgroup;
      for (var i=0; i<selwrite.options.length; i++)
      {
        if (selwrite.options[i].value == currentWriteAcl) selwrite.selectedIndex = i;
      }
    }
    </SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('package-list.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_SetACLsScrn');updateSelector();">
   <FORM name="aclForm" action="service-list.dsp" METHOD="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <INPUT type="hidden" name="action" value="aclassign">
      <INPUT type="hidden" name="interface" value="%value parent encode(htmlattr)%">
      %ifvar service%
      <INPUT type="hidden" name="target" value="%value interface encode(htmlattr)%:%value service encode(htmlattr)%">
      %else%
      <INPUT type="hidden" name="target" value="%value interface encode(htmlattr)%">
      %endif%
     <TABLE width=100%>

        <TR>
          <TD class="breadcrumb" colspan=2>
            Packages &gt;
            Management &gt;
      %value interface encode(html)% &gt;
            Set ACLs
          </TD>
        </TR>
         <TR>
          <TD colspan=2>
            <UL>
			
			<script>
				createForm("htmlform_http_service_list", "service-list.dsp", "POST", "BODY");
				setFormProperty("htmlform_http_service_list", "interface", "%value interface%");
            </script>
			
			<script>
				createForm("htmlform_http_service_list2", "service-list.dsp", "POST", "BODY");
				setFormProperty("htmlform_http_service_list2", "interface", "%value parent%");
            </script>

			<script>
				createForm("htmlform_http_service_list3", "service-list.dsp", "POST", "BODY");
				setFormProperty("htmlform_http_service_list3", "interface", "%value interface%");
            </script>
			
              <!-- <li class="listitem">
			  <script>getURL("service-list.dsp?interface=%value interface encode(url)%","javascript:document.htmlform_http_service_list.submit();","Return to browsing %value interface%")</script>
			  
			  </li> -->
              %ifvar parent -notempty%
              	<li class="listitem">
				<script>getURL("service-list.dsp?interface=%value parent encode(url)%","javascript:document.htmlform_http_service_list2.submit();","Return to browsing %value parent encode(html)%");</script>
				</li>
              %else%
                <li class="listitem">
				<script>getURL("service-list.dsp?interface=%value interface encode(url)%","javascript:document.htmlform_http_service_list3.submit();","Return to browsing %value interface encode(html)%");</script>
				</li>
              %endif%
            </UL>
          </TD>
        </TR>

    <TR>
          <TD>
            <TABLE class="tableView">
              <TR>
                <TD class="heading" colspan=2>ACL Information</TD>
              </TR>
              <TR>
                <TD class="oddrow">Target</TD>
                <TD class="oddrow-l"><b>
                  %ifvar service%
                    %value interface encode(html)%:%value service encode(html)%
                  %else%
                    %value interface encode(html)%
                  %endif%</b>
                </TD>
              </TR>

              <TR>
                <TD class="evenrow"><label for="browseaclgroup">List ACL</label></TD>
                <TD class="evenrow-l">
                  %invoke wm.server.access.adminui:aclList%
                  <SELECT name="browseaclgroup" id="browseaclgroup">
                    %ifvar effectiveAclBrowse -notempty%<OPTION value="">&lt;%value effectiveAclBrowse encode(html)%&gt; (inherited)</OPTION>
                    %else%<OPTION value="">&lt;%value parentbrowseaclgroup encode(html)%&gt; (inherited)</OPTION>%endif%
                    %loop aclgroups%
                    <OPTION value="%value name encode(htmlattr)%">%value name encode(html)%</OPTION>
                    %endloop%
                  </SELECT>
                  %endinvoke%
                </TD>
              </TR>

              <TR>
                <TD class="oddrow"><label for="readaclgroup">Read ACL</label></TD>
                <TD class="oddrow-l">
                  %invoke wm.server.access.adminui:aclList%
                  <SELECT name="readaclgroup" id="readaclgroup">
                    %ifvar effectiveAclRead -notempty%<OPTION value="">&lt;%value effectiveAclRead encode(html)%&gt; (inherited)</OPTION>
                    %else% <OPTION value="">&lt;%value parentreadaclgroup encode(html)%&gt; (inherited)</OPTION>%endif%
                    %loop aclgroups%
                    <OPTION value="%value name encode(htmlattr)%">%value name encode(html)%</OPTION>
                    %endloop%
                  </SELECT>
                  %endinvoke%
                </TD>
              </TR>

              <TR>
                <TD class="evenrow"><label for="writeaclgroup">Write ACL</label></TD>
                <TD class="evenrow-l">
                  %invoke wm.server.access.adminui:aclList%
                  <SELECT name="writeaclgroup" id="writeaclgroup">
                    %ifvar effectiveAclWrite -notempty%<OPTION value="">&lt;%value effectiveAclWrite encode(html)%&gt; (inherited)</OPTION>
                    %else%<OPTION value="">&lt;%value parentwriteaclgroup encode(html)%&gt; (inherited)</OPTION>%endif%
                    %loop aclgroups%
                    <OPTION value="%value name encode(htmlattr)%">%value name encode(html)%</OPTION>
                    %endloop%
                  </SELECT>
                  %endinvoke%
                </TD>
              </TR>

              <TR>
                <TD class="oddrow"><label for="acl">Execute ACL</label></TD>
                <TD class="oddrow-l">
                  %invoke wm.server.access.adminui:aclList%
                  <SELECT name="acl" id="acl">
                    %ifvar effectiveAcl -notempty%<OPTION value="">&lt;%value effectiveAcl encode(html)%&gt; (inherited)</OPTION>
                    %else%<OPTION value="">&lt;%value parentexecuteaclgroup encode(html)%&gt; (inherited)</OPTION>%endif%
                    %loop aclgroups%
                    <OPTION value="%value name encode(htmlattr)%">%value name encode(html)%</OPTION>
                    %endloop%
                  </SELECT>
                  %endinvoke%
                </TD>
              </TR>

              %ifvar service%
              <TR>
                %invoke wm.server.services.adminui:serviceInfo%
                <TD class="evenrow">Enforce ACL on Internal Invokes</TD>
                <TD class="evenrow-l">
                        <INPUT type="radio" id="check1" name="check_internal_acls" value="true"
                        %ifvar check_internal_acls equals('true')% checked %endif% >&nbsp;
                        <label for="check1">On</label>
                        </INPUT>
                        <INPUT type="radio" id="check2" name="check_internal_acls" value="false"
                        %ifvar check_internal_acls equals('false')% checked %endif% >&nbsp; <label for="check2">Off (recommended)</label>
                        </INPUT> </TD>
                %endinvoke%
              %endif%
              </TR>
              <TR>
                <TD colspan=2 class="action">
                  <INPUT type="button" value="Save Changes"
                  onclick="onClick('submit')  ;">
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
    </FORM>
  </BODY>
</HTML>
