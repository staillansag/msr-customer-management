<html>
    <script Language="JavaScript">
        
        var submitCount=0;
        
        function clickOneTime() {  
           if (submitCount++ > 0) {
               return false;
           }
               
           return true;
           
        }
        
        function deleteTransaction(isUnresolved) {
        
            if (isUnresolved) {
                if (!window.confirm("Warning, this transaction may still be associated with one or more XA Resources.  It is recommended that you resolve this transaction before deleting.  Press OK to continue with the delete.  Press Cancel to cancel the delete."))
                    return false;
            
            }else {
                if (!window.confirm("Are you sure you want to delete this transaction?  Press OK to continue with the delete.  Press Cancel to cancel the delete."))
                    return false;     
            }
                
            return true;
        }
     
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

   <BODY onLoad="setNavigation('xamanualrecovery.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_DetailsForXIDScrn');">
        <table width="100%">
        
            <!-- ------------------------- -->
            <!-- perform possible actions  -->
            <!-- ------------------------- -->
            %ifvar performingAction equals('true')%
                %invoke wm.server.xarecovery:performActionsOnXAResources%
                %onerror%
                    <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
                %endinvoke%
            %endif%

            <tr>
                <td class="breadcrumb" colspan="2">
                    Settings &gt; Resources &gt; XA Manual Recovery &gt; Details for XID:&nbsp;%value xid encode(html)%
                </td>
            </tr>
            
            <!-- ------------------------- -->
            <!-- invoke get detail service -->
            <!-- ------------------------- -->
            %invoke wm.server.xarecovery:getXAResourceInfoForXid%
            
            <tr>
                <td valign="top" colspan="2">
                    <ul>
						<script>
						createForm("htmlform_xamanualrecovery_return", "xamanualrecovery.dsp", "POST", "BODY");
						createForm("htmlform_xamanualrecovery_props", "xamanualrecovery.dsp", "POST", "BODY");
						setFormProperty("htmlform_xamanualrecovery_props", "deleteXid", "true");
						setFormProperty("htmlform_xamanualrecovery_props", "xid", "%value xid encode(url)%");
						</script>
                        <li class="listitem">
						<script>getURL("xamanualrecovery.dsp", "javascript:document.htmlform_xamanualrecovery_return.submit();", "Return to XA Manual Recovery");</script>
						</li>
						
                        <li class="listitem">
						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<a href="javascript:document.htmlform_xamanualrecovery_props.submit();" onclick="return deleteTransaction(%value XAResourceInfo/isUnresolved encode(javascript)%)">Delete Transaction</a>');
							} else {
								var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
								if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
									document.write('<a href="xamanualrecovery.dsp?deleteXid=true&xid=%value xid encode(url)%&webMethods-wM-AdminUI=true" onclick="return deleteTransaction(%value XAResourceInfo/isUnresolved encode(javascript)%)">Delete Transaction</a>');
								}
								else {
									document.write('<a href="xamanualrecovery.dsp?deleteXid=true&xid=%value xid encode(url)%" onclick="return deleteTransaction(%value XAResourceInfo/isUnresolved encode(javascript)%)">Delete Transaction</a>');
								}
							}
						</script>
						
						</li>
                    </ul>
                </td>
            </tr>

            <tr>
                <td><img src="images/blank.gif" height=10 width=10 border=0></td>
                <td width="100%">
                    <table class="tableView" >
                    
                        <form name="performAction" action="xamanualrecovery-details.dsp" METHOD="POST">
                            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                            
                            <!-- ---------------- -->
                            <!-- write header     -->
                            <!-- ---------------- -->
                            
                            <tr>
                                <td class="heading" colspan=5>Global 2PC State: %value globalState encode(html)%</td>
                            </tr>
                            <tr>
                                <td class="oddcol-l subHeading" scope="col">XA&nbsp;Resource</td>
                                <td class="oddcol-l subHeading" scope="col">XID Exists?</td>
                                <td class="oddcol-l subHeading" scope="col">State</td>
                                <td class="oddcol-l subHeading" scope="col">Inferred&nbsp;Status</td>
                                <td class="oddcol-l subHeading" scope="col">Desired&nbsp;Action</td>
                            </tr>

                            <!-- ---------------------- -->
                            <!-- write line-item detail -->
                            <!-- ---------------------- -->
                            
                            %loop XAResourceInfo/XAResourceData%                      
                            
                            <input name="XAResourceName" type="hidden" value="%value XAResourceName encode(htmlattr)%"/>
                            
                            <tr>
                                <script>writeTD("rowdata-l");</script>%value XAResourceName encode(html)%</td>
                            
                                 %ifvar XIDExists equals('true')%
                                     <script>writeTD("rowdata-l");</script><img style="width: 13px; height: 13px;" alt="XID exists " src="images/green_check.png">Yes</td>
                                    
                                     <!-- <script>writeTD("rowdata-l");</script>Prepared or heuristically committed/rolled back</td> -->
                                     <script>writeTD("rowdata-l");</script>%value XAResourceStatusDisplayValue encode(html)%</td>
                                     <script>writeTD("rowdata-l");</script>%value XAResourceInferredStatus encode(html)%</td>
                           
                                     %ifvar XAResourceRecommendedAction equals('forget')%
                                         <script>writeTD("rowdata-l");</script>
                                             <select name=resourceAction size=1" >
                                                <option value="nothing">Do Nothing </option>
                                                <option value="commit">Commit </option>
                                                <option value="rollback">Rollback </option>
                                                <option value="forget" selected="selected" >Forget </option>
                                             </select>
                                         </td>
                                     %else%
                                         <script>writeTD("rowdata-l");</script>
                                             <select name=resourceAction size=1" >
                                                 <option value="nothing">Do Nothing </option>
                                                 <option value="commit">Commit </option>
                                                 <option value="rollback" selected="selected">Rollback </option>
                                                 <option value="forget">Forget </option>
                                             </select>
                                         </td>
                                     %endif%
                                     
                                %else%
                                    %ifvar ErrorMessage -notempty%
                                        <script>writeTD("rowdata-l");</script>Unknown</td> <!-- <img style="width: 13px; height: 13px;" alt="" src="icons/redxdot.gif">Unverified</td> -->
                                        <script>writeTD("rowdata-l");</script>%value ErrorMessage encode(html)%</td> 
                                        <script>writeTD("rowdata-l");</script>%value XAResourceInferredStatus encode(html)%</td>
                                    %else%
                                        <script>writeTD("rowdata-l");</script>No</td>
                                        <script>writeTD("rowdata-l");</script>%value XAResourceStatusDisplayValue encode(html)%</td>
                                        <script>writeTD("rowdata-l");</script>%value XAResourceInferredStatus encode(html)%</td>
                                    %endif%
                                    
                                    <input name="resourceAction" type="hidden" value="nothing"/>
                                    <script>writeTD("rowdata-l");</script>
                                        <select name=resourceAction-disabled size=1 disabled=true >
                                            <option>Do Nothing</option>
                                        </select>
                                    </td>
                                %endif%
                             
                            </tr>
                            <script>swapRows();</script>       
                                  
                            %endloop%
                       
                            <tr>
                                <td class="space" colspan=4>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="5" class="action">
                                    <input name="performingAction" type="hidden" value="true"/>
                                    <input name="xid" type="hidden" value="%value xid encode(htmlattr)%"/>
                                    <input type="submit" name="submit" value="Perform Action(s)" onclick="return clickOneTime();" />
                                </td>
                            </tr>       
                        </form>            
                    </table>
                </td>
            </tr>
             %onerror%
                <script>writeMessage("%value errorMessage encode(html_javascript)%");</script>
            %endinvoke%
        </table>
    </body>
</html>
