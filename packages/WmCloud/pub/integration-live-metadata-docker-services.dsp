<HTML>
<HEAD>
    <META http-equiv="Pragma" content="no-cache">
    <META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">

    <TITLE>Integration Server Settings</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="metadata.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
    <SCRIPT SRC="metadata.js"></SCRIPT>
</HEAD>

<BODY onLoad="setNavigation('integration-live-metadata-docker-services.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_DockerServicesScrn');">

<FORM id ="applicationForm" NAME="applicationForm" action="integration-live-metadata-docker-services.dsp" method="POST">
     %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
     %ifvar operation -notempty%
        %invoke wm.client.integrationlive.metadatashare:saveDockerServices%
            %ifvar message%
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td class="message" colspan="2">%value message%</td></tr>
            %endif%
            %onerror%
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
            %endinvoke%
     %endif%
  <TABLE WIDTH="100%">
             <TR>
                <TD class="breadcrumb" colspan="3">
                   webMethods Cloud &gt; Docker Services
                </TD>
            </TR>
            <TR>
             <TD width="70%">
                <TABLE WIDTH="100%" class="tableView">
                    <TR>
                        <TD class="heading" colspan="2">webMethods Cloud Docker Services</TD>
                    </TR>
                    <TR>
                        <TD class="oddrow" nowrap>Selected Docker Services</TD>
                        <TD class="oddrow-l" nowrap>
                        %invoke wm.client.integrationlive.metadatashare:getDockerServicePackages%
                        %endinvoke%
                           <TABLE width="100%">
                               <TR class="subheading2">
                                    <TD width="55%"><b>Package</b></TD>
                                    <TD width="25%" nowrap align="left"><b>Docker Services</b></TD>
                               </TR>
                               %loop packages%
                                 <TR>
                                     <TD><label for="dockerServices_%value $index%">%value packageName%</label>
                                     <input type="hidden" name="packageName" id="packageName" value="%value packageName%"/>
                                     </TD>
                                     <TD>
                                        <textarea name="dockerServices" id="dockerServices_%value $index%" rows="5" cols="40" >%value dockerServices%</textarea>
                                     </TD>
                                 </TR>
                               %endloop%
                        </TABLE>    
                         </TD>
                       </TR>
                </TABLE>
             </TD>
             <TD width="28%">
              &nbsp;
             </TD>
             </FORM>
            </TR>
            <TR>
                <TD  class="action" >
                    <input type="hidden" name="operation" value="save"/>
                    <input type="hidden" name="packageName"/>
                    <input type="hidden" name="dockerServices"/>
                    <input type="submit" name="submit" value="Save Changes" onclick="submitForm();"/>
                </TD>
                 <TD width="28%">
                  &nbsp;
                </TD>
            </TR>
    </TABLE>
</BODY>

</HTML>
