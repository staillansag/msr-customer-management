<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server - webMethods Cloud Applications</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
<SCRIPT SRC="metadata.js"></SCRIPT>
</HEAD>
 
<BODY onLoad="setNavigation('integration-live-metadata-share.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_ApplicationsScrn');">
  <TABLE width="100%">
   <TR>
      <TD class="breadcrumb" colspan="2">
          webMethods Cloud &gt; Applications 
      </TD>
    </TR>

     %ifvar operation -notempty%
        %invoke wm.client.integrationlive.metadatashare:saveApplication%
            %ifvar message%
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td class="message" colspan="2">%value message%</td></tr>
            %endif%
            %onerror%
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
            %endinvoke%
     %endif%

     %ifvar deleteAction -notempty%
        %invoke wm.client.integrationlive.metadatashare:deleteApplication%
            %ifvar message%
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td class="message" colspan="2">%value message%</td></tr>
            %endif%
            %onerror%
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
            %endinvoke%
     %endif%
     
     %ifvar uploadAction -notempty%
        %invoke wm.client.integrationlive.metadatashare:uploadApplication%
            %ifvar message%
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td class="message" colspan="2">%value message%</td></tr>
            %endif%
            %onerror%
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td class="message" colspan=2>%value errorMessage%</td></tr>
            %endinvoke%
     %endif%
     
    <TR>
      <TD colspan="2">
        <UL class="listitems">
              <LI>
			  <script>
				createForm("htmlform_integration_live_metadata_applicationadd", "integration-live-metadata-applicationadd.dsp", "POST", "BODY");
			  </script>
			  <script>getURL("integration-live-metadata-applicationadd.dsp","javascript:document.htmlform_integration_live_metadata_applicationadd.submit();","Define webMethods Cloud Application");</script></LI>
        </UL>
      </TD>
    </TR>
   
    <TR> 
    <TD width="98%">
       <TABLE width="75%" class="tableView">
       <TR> 
     
      <TD class="heading" colspan="5">webMethods Cloud Applications</TD>
    </TR>
    
    %invoke wm.client.integrationlive.metadatashare:getApplications%
    %endinvoke%
    
    <TR> 
      <TH scope="col" CLASS="oddcol-l" nowrap width="25%">Name</TH>
      <TH scope="col" CLASS="oddcol" nowrap width="35%">Description</TH>
      <TH scope="col" CLASS="oddcol" nowrap width="20%">Last Uploaded Time</TH>
      <TH scope="col" CLASS="oddcol" nowrap width="10%">Upload</TH>
      <TH scope="col" CLASS="oddcol" nowrap width="10%">Delete</TH>
    </TR>

    %loop applications%
    <TR>
     
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
           <A href="javascript:document.forms['applicationForm'].submit()" onClick="return editApplication('%value name%');">
          %value name%
        </A> 
      </TD>
      
       <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
          %value description% 
       </TD>
       
       <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
          %value uploadedTimeDateStr%
       </TD>
      
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
        <A href="javascript:document.forms['applicationForm'].submit()" onClick="return uploadApplication('%value name%')">
            %ifvar uploadPending equals('true')%
                  <IMG src="images/uploadPending.png" alt="Pending" border="none"/>
               %else%
                  <IMG src="images/upload.png" border="none"/>
                %endif%
        </A>          
      </TD>
      
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
       <A href="javascript:document.forms['applicationForm'].submit()" onClick="return removeApplication('%value name%');">
          <IMG src="../WmRoot/icons/delete.gif" alt="Application" border="none"/>
        </A>          
      </TD>
      <SCRIPT>swapRows();</SCRIPT>
      
    </TR>
    %endloop%
    
    </TABLE>
     </TD>
     </TR>
  </TABLE>
  <form name="applicationForm" id="applicationForm" method="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <input type="hidden" name="applicationName" id="applicationName"/>
      <input type="hidden" name="deleteAction" id="deleteAction"/>
      <input type="hidden" name="uploadAction" id="uploadAction"/>
  </form>      
</BODY>
</HTML>
