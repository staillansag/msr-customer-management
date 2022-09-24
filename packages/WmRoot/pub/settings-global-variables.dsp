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
	function populateForm(form , glNm ,oper)
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
            if (!confirm ("OK to delete '"+glNm+"'?")) {
                return false;
            }
            form.operation.value = 'gl_del';
            actionElement = setQueryParamDelim(actionElement) + "operation=gl_del";
        }
        form.key.value = glNm;
        actionElement = setQueryParamDelim(actionElement) + "key=" + glNm;
        
        form.setAttribute("action", actionElement);
        
        return true
    }
    
  </script>
  
  <body onLoad="setNavigation('settings-global-variables.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GlobalVariables');">
   
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> Settings &gt; Global Variables </td>
        </tr>
        %ifvar operation equals('gl_add')%
            %invoke wm.server.globalvariables:addGlobalVariable%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%   
        %ifvar operation equals('gl_edit')%
            %invoke wm.server.globalvariables:editGlobalVariable%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        %ifvar operation equals('gl_del')%
            %invoke wm.server.globalvariables:removeGlobalVariable%
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
                    <li class="listitem">
						<a href="javascript:document.htmlform_gl_edit.submit();" onClick="return populateForm(document.htmlform_gl_edit, '%value operation encode(javascript)%','add');">
							Add&nbsp;Global&nbsp;Variable
						</a>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
                        <td>    
                            <table class="tableView" width="50%">
                                <tr>
                                    <td class="heading" colspan="4">Global Variables</td>
                                </tr>
                                <tr>
                                    <th class="oddcol-l" scope="col">Key</th>
                                    <th class="oddcol" scope="col">Value</th>
                                    <th class="oddcol" scope="col">Is Password?</th>
                                    <th class="oddcol" scope="col">Delete</th>
                                </tr>
                                %invoke wm.server.globalvariables:listGlobalVariables%
                                    %loop globalVariables%
                                        <tr>
                                            <script>writeTD("row-l");</script>
												<a href="javascript:document.htmlform_gl_edit.submit();" onClick="return populateForm(document.htmlform_gl_edit,'%value key encode(javascript)%','edit');">
												   %value key encode(html)%
                                                </a>   
                                            </td>
                                            <script>writeTD("rowdata");</script>
                                                %ifvar isSecure equals('true')%
                                                    ******
                                                %else%
													%value value encode(html)%
                                                %endif%
                                            </td>                       
                                            <script>writeTD("rowdata");</script>
                                                %ifvar isSecure equals('true')%
                                                    Yes
                                                %else%
                                                    No
                                                %endif%
                                            </td>
                                            <script>writeTD("rowdata");</script>
												<a href="javascript:document.htmlform_gl_delete.submit();" onClick="return populateForm(document.htmlform_gl_delete,'%value key encode(javascript)%','delete');">
                                                    <img src="icons/delete.png" alt="Global variable key %value key%" border="no">
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
    <form name="htmlform_gl_edit" action="settings-global-variables-addedit.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="key">
    </form>
    <form name="htmlform_gl_delete" action="settings-global-variables.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="key">
    </form>
  </body>   
</head>
