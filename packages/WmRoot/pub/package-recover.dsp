<html>
   <head>
      <meta http-equiv="Pragma" content="no-cache">
      <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
      <meta http-equiv="Expires" content="-1">
      <TITLE>Integration Server -- Manage Packages</TITLE>
      <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
      %ifvar webMethods-wM-AdminUI%
        <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
        <script>webMethods_wM_AdminUI = 'true';</script>
      %endif%
      <SCRIPT src="webMethods.js"></SCRIPT>
   </HEAD>

  <BODY onLoad="setNavigation('package-list.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_RecoverPkgsScrn');">
    <TABLE WIDTH=100%>
      <TR>
        <TD class="breadcrumb" colspan=2>
          Packages &gt;
          Management &gt;
          Recover Packages
        </TD>
      </TR>

      %ifvar action%
          %switch action%
              %case 'recover'%
                  %invoke wm.server.packages:packageRecover%
                      %ifvar message%
                          <tr><td colspan="2">&nbsp;</td></tr>
                          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
                      %endif%
                  %endinvoke%
          %endswitch%
      %endif%

      <TR>
        <TD colspan=2>
          <UL class="listitems">
			<script>
			createForm("htmlform_package_list", "package-list.dsp", "POST", "BODY");
			</script>
            <li>
			<script>getURL("package-list.dsp", "javascript:document.htmlform_package_list.submit();", "Return to Package Management");</script>
			</li>
          </UL>
        </TD>
      </TR>

        %scope param(additional='all')%
        %invoke wm.server.packages:packageList%
        <TR>
            <TD>
                <TABLE class="tableView">
                  <FORM name="recover" action="package-recover.dsp" method="POST">
                     %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                     <INPUT type="hidden" name="action" value="recover">
                     <TR>
                        <TD class="heading" colspan=3>Recover Packages
                        </TD>
                     </TR>
                     %ifvar recoverable%
                       <TR>
                          <TD class="oddrow"><label for="package">Package name</label></TD>
                          <TD class="oddrow-l">
                             <SELECT NAME="package" id="package" WIDTH=150>
                                %loop recoverable%
                                <OPTION VALUE="%value encode(htmlattr)%">%value encode(html)%</OPTION>
                                %endloop%
                             </SELECT>
                             <BR> </TD>
                       </TR>
                       <TR>
                          <TD class="evenrow">Option</TD>
                          <TD class="evenrow-l">
                             <INPUT type="checkbox" id="activateOnRecover" name="activateOnRecover"
                             checked><label for="activateOnRecover">Activate upon Recovery</label> </INPUT> </TD>
                       </TR>
                        <TR>
                          <TD class="action" colspan=2>
                            <INPUT type="submit"
                            value="Recover"> </TD>
                        </TR>
                     %else%
                        <TR>
                          <TD class="oddrow-l" colspan=3>
                            No recoverable packages</TD>
                        </TR>
                     %endif%
               </FORM>
               %endinvoke% 
              %endscope%
         </TABLE>
       </TD>
     </TR>
   </TABLE>
  </BODY>
</HTML>
