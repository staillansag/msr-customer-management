<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js"></script>
  <script language="JavaScript">
    <!--add jscript here-->
	function populateForm(form , issuer , oper)
    {
    	var actionElement = form.getAttribute("action");
	    
        if('edit' == oper) {
            form.operation.value = "edit";
            actionElement = setQueryParamDelim(actionElement) + "operation=edit";
        }
		if('add' == oper) {
			form.operation.value = "add";
			actionElement = setQueryParamDelim(actionElement) + "operation=add";
		}
        if('delete' == oper)
        {
            if (!confirm ("OK to delete '"+issuer+"'?")) {
                return false;
            }
            form.operation.value = 'delete_issuer';    
            actionElement = setQueryParamDelim(actionElement) + "operation=delete_issuer";
        }
        form.issuer.value = issuer;
        
	    actionElement = setQueryParamDelim(actionElement) + "issuer=" + issuer;
	    
		form.setAttribute("action", actionElement);

        return true
    }
    
  </script>
  
  <body onLoad="setNavigation('security-jwt-trusted-issuers.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_JWT_TrustedIssuersScrn');">
   
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> Security &gt; JWT &gt; Trusted Issuers </td>
        </tr>
        %ifvar operation equals('add_issuer')%
            %invoke wm.server.jwt:addIssuer%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%   
        %ifvar operation equals('edit_issuer')%
            %invoke wm.server.jwt:updateIssuer%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        %ifvar operation equals('delete_issuer')%
            %invoke wm.server.jwt:removeIssuer%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%     
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>createForm("htmlform_jwt_nav_jwt_settings", "security-jwt-settings.dsp", "POST", "body");</script>
					<li class="listitem">
						<script>getURL("security-jwt-settings.dsp","javascript:document.htmlform_jwt_nav_jwt_settings.submit();","Return to JWT");</script>
					</li>
                    <li class="listitem">
						<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							getURL("","javascript:document.htmlform_jwt_issuer_add.submit();","Add Issuer");
						} else {
							getURL("security-jwt-trusted-issuers-addedit.dsp?operation=add", "","Add Issuer");
						}
						</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
                        <td>    
                            <table  class="tableView" width="50%">
                                <tr>
                                    <td class="heading" colspan="4">Trusted Issuers</td>
                                </tr>
                                <tr>
                                    <TH class="oddcol-l" scope="col">Name</TH>
                                    <TH class="oddcol" scope="col">Description</TH>
									<TH class="oddcol" scope="col">Delete?</TH>
                                </tr>
                                %invoke wm.server.jwt:listIssuers%
                                    %loop trustedIssuers%
                                        <tr>
                                            <script>writeTD("row-l");</script>
												<a href="javascript:document.htmlform_jwt_issuer_edit.submit();" onClick="return populateForm(document.htmlform_jwt_issuer_edit,'%value issuer encode(javascript)%','edit');">
												   %value issuer encode(html)%
                                                </a>   
                                            </td>
                   
                                            <script>writeTD("rowdata");</script>
                                                %value description encode(html)%
                                            </td>
                                            <script>writeTD("rowdata");</script>
												<a href="javascript:document.htmlform_jwt_issuer_delete.submit();" onClick="return populateForm(document.htmlform_jwt_issuer_delete,'%value issuer encode(javascript)%','delete');">
                                                    <img src="icons/delete.png" border="no" alt="Delete Trusted Issuer %value issuer encode(html)%">
                                                </a>    
                                            </td>
                                        </tr>
                                        <script>swapRows();</script>
                                    %endloop%
                                %endinvoke% 
                            </table>
            </td>
        </tr>
    </table>
    <form name="htmlform_jwt_issuer_edit" action="security-jwt-trusted-issuers-addedit.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="issuer">
    </form>
	<form name="htmlform_jwt_issuer_add" action="security-jwt-trusted-issuers-addedit.dsp?operation=add" method="POST">
	    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation" value="add">
    </form>
    <form name="htmlform_jwt_issuer_delete" action="security-jwt-trusted-issuers.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="issuer">
    </form>
  </body>   
</head>
