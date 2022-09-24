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
 

<BODY onLoad="setNavigation('integration-live-metadata-upload.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_UploadApplicationScrn');">

<FORM id ="applicationForm" NAME="applicationForm" action="integration-live-metadata-share.dsp" method="POST" onsubmit="return submitUploadApplication();">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <input type="hidden" name="uploadAction" value="yes"/>

  <input type="hidden" name="connList" />

  <TABLE WIDTH="100%">

            <TR>
                <TD class="breadcrumb">
                   webMethods Cloud &gt; Applications &gt; Upload Application 
                </TD>
            </TR>

            <TR>
                <TD>
                    <UL class="listitems">
                        <LI>
						<script>
					    createForm("htmlform_integration_live_metadata_share", "integration-live-metadata-share.dsp", "POST", "BODY");
					    </script>
						<script>getURL("integration-live-metadata-share.dsp","javascript:document.htmlform_integration_live_metadata_share.submit();","Return to webMethods Cloud Applications");</script>
						</LI>
                    </UL>
                </TD>
            </TR>
            %invoke wm.client.integrationlive.metadatashare:getApplicationForUploadDisplay%
      %endinvoke%
      %ifvar message -notempty%      
        <TR>
           <TD width="50%" class="message">%value message%</TD>
        </TR>
      %endif%
            <TR>
             <TD width="70%">
                              
              <TABLE WIDTH="100%" class="tableView">
                <TR>
                  <TD class="heading" colspan="2">Upload Application</TD>
                </TR>
                
                <TR>
            			<TD class="oddrow" nowrap><label for="applicationName">Name</label></TD>
                  <TD class="oddrow-l">
                       <INPUT NAME="applicationName" id="applicationName" TYPE="TEXT" VALUE="%value applicationName%" SIZE="50" readonly/>
                   </TD>
                </TR>
                <TR>
                  <TD class="evenrow" nowrap>Select Accounts</TD>
                  <TD class="evenrow-l">
                    <TABLE cellpadding=4 cellspacing=4>
                      <TR>
                        <TD class="evenrow-l" nowrap ><B>Select</B></TD>
                        <TD class="evenrow-l" nowrap ><B>Alias</B></TD>
                        <TD class="evenrow-l" nowrap ><B>Stage</B></TD>
                        <TD class="evenrow-l" nowrap ><B>Tenant Connection</B></TD>
                        %loop connections%
                          <TR>
                            <TD class="evenrow-l" nowrap >
                              %ifvar isSelected equals('true')%
                                 &nbsp; <INPUT TYPE="CHECKBOX" NAME="connections[%value $index%]" CLASS="cbstyle" VALUE="%value tenantAlias%/%value aliasName%@%value stage%" CHECKED/>
                               %else%
                                 &nbsp; <INPUT TYPE="CHECKBOX" NAME="connections[%value $index%]" CLASS="cbstyle" VALUE="%value tenantAlias%/%value aliasName%@%value stage%"/>
                               %endif%
                            </TD>
                            <TD class="evenrow-l" nowrap > %value connectionName%</TD>
                            <TD class="evenrow-l" nowrap >%value connectionStageDisplayName%</TD>
                            <TD class="evenrow-l" nowrap >%value tenantAlias%</TD>

                          </TR>
                         %endloop%
                      </TR>
                    </TABLE>
                    
                   </TD>
                </TR>
              </TABLE>
             </TD>
        </TR>
            <TR>
        <TD  class="action" >
        %ifvar message -notempty%  
          <input type="submit" name="submit" value="Upload" disabled/>
        %else%
          <input type="submit" name="submit" value="Upload"/>
        %endif%
        </TD>
         <TD width="28%">
          &nbsp;
        </TD>
        </FORM>
      </TR>
    </TABLE>
</BODY>
</HTML>
