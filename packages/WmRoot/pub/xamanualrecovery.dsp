<html>
    <script Language="JavaScript">
    </script>

    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Integration Server Settings</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <SCRIPT SRC="webMethods.js"></SCRIPT>
    </head>

   <BODY onLoad="setNavigation('xamanualrecovery.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_XAManualRecoveryScrn');">
        <table width="100%">
        
            <!-- ------------------------- -->
            <!-- delete xid                -->
            <!-- ------------------------- -->
            %ifvar deleteXid equals('true')%
                %invoke wm.server.xarecovery:eraseTransaction% <!-- xid was passed in from details page -->
                %onerror%
                    <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
                %endinvoke%
            %endif%
            <!-- ------------------------- -->
            <!-- set the value of writeRecoveryRecord field if it is passed in-->
            <!-- ------------------------- -->
            %ifvar writeRecoveryRecord%
                %invoke wm.server.xarecovery:setWriteRecoveryRecord% <!-- value was passed in from this page itself -->
                %endinvoke%
            %endif%

            <tr>
                <td class="breadcrumb" colspan=2>
                    Settings &gt; Resources &gt; XA Manual Recovery
                </td>
            </tr>
            <tr>
                <td colspan=2>
                    <ul>
                        <li class="listitem">
						<script>
						createForm("htmlform_settings_resources", "settings-resources.dsp", "POST", "BODY");
						</script>
						<script>getURL("settings-resources.dsp", "javascript:document.htmlform_settings_resources.submit();", "Return to Resource Settings");</script>
						
						</li>
                        %invoke wm.server.xarecovery:getWriteRecoveryRecord%
                          %ifvar writeRecoveryRecord equals('false')%
                            <li class="listitem">
							<script>
							createForm("htmlform_xamanualrecovery", "xamanualrecovery.dsp", "POST", "BODY");
							setFormProperty("htmlform_xamanualrecovery", "writeRecoveryRecord", "true");
							</script>
							<script>getURL("xamanualrecovery.dsp?writeRecoveryRecord=true", "javascript:document.htmlform_xamanualrecovery.submit();", "Enable XA Transaction Recovery");</script>
							
							</li>
                          %else%                
                            <li class="listitem">
							<script>
							createForm("htmlform_xamanualrecovery_false", "xamanualrecovery.dsp", "POST", "BODY");
							setFormProperty("htmlform_xamanualrecovery_false", "writeRecoveryRecord", "false");
							</script>
							<script>getURL("xamanualrecovery.dsp?writeRecoveryRecord=false", "javascript:document.htmlform_xamanualrecovery_false.submit();", "Disable XA Transaction Recovery");</script>
							
							</li>
                          %endif%
                    </ul>
                </td>
            </tr>

            <!-- ------------------------- -->
            <!-- invoke lookup service     -->
            <!-- ------------------------- -->
            %invoke wm.server.xarecovery:getUnresolvedTXs%

            <tr>
                <td><IMG SRC="images/blank.gif" height=10 width=10>&nbsp;</td>
                <td width="100%">
                    <table class="tableView">
                    
                        <!-- ---------------- -->
                        <!-- write header     -->
                        <!-- ---------------- -->
                        
                        <tr>
                            <td class="heading" colspan=5>Unresolved XA Transactions</td>
                        </tr>
                        <tr>
                            <td class="oddcol-l subHeading" scope="col">XID</td>
                            <td class="oddcol-l subHeading" scope="col">Global&nbsp;2PC&nbsp;State</td>
                            <td class="oddcol-l subHeading" scope="col">Error&nbsp;Message</td>
                            <td class="oddcol-l subHeading" scope="col">Recovery&nbsp;Action Attempted</td>
                        </tr>
                            
                        <!-- ---------------------- -->
                        <!-- write line-item detail -->
                        <!-- ---------------------- -->
                            
                        %loop unresolvedTXs%
                            
                        <tr>
                            <script>writeTD("rowdata-l");</script>
							<script>
							createForm("htmlform_xamanualrecovery_details_%value $index%", "xamanualrecovery-details.dsp", "POST", "BODY");
							setFormProperty("htmlform_xamanualrecovery_details_%value $index%", "xid", "%value xid %");
							setFormProperty("htmlform_xamanualrecovery_details_%value $index%", "globalState", "%value 2PCState %");
							</script>
							<script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<a href="javascript:document.htmlform_xamanualrecovery_details_%value $index%.submit();" >%value xid encode(html)%</a>');
								} else {
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<a href="xamanualrecovery-details.dsp?xid=%value xid encode(url)%&globalState=%value 2PCState encode(url)%&webMethods-wM-AdminUI=true"  >%value xid encode(html)%</a>');
									}
									else {
										document.write('<a href="xamanualrecovery-details.dsp?xid=%value xid encode(url)%&globalState=%value 2PCState encode(url)%"  >%value xid encode(html)%</a>');
									}
								}
							</script>
							
							</td>
                            <script>writeTD("rowdata-l");</script>%value 2PCState encode(html)%</td>
                            <script>writeTD("rowdata-l");</script>%value error encode(html)%</td>
                            <script>writeTD("rowdata-l");</script>%value recoveryActionAttempted encode(html)%</td>
                          <!--  <td class="evenrowdata-l"><a href="javascript:document.listeners.submit();" onClick="return eraseTransaction(document.listeners, '%value -code xid encode(javascript)%' );"><img src="icons/delete.png" border="no"></A></td> -->
                        </tr>
                        
                        <script>swapRows();</script>       
                            
                        %endloop%
                            
                    </table>
                </td>
            </tr>
            %onerror%
                <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
            %endinvoke%
            %endif%
        </table>
    </body>
</html>
