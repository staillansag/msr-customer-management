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
    function populateForm(form, mgrNm, oper)
    {
    	var actionElement = form.getAttribute("action");
		    
        if('add' == oper) {
            form.operation.value = oper;
            actionElement = setQueryParamDelim(actionElement) + "operation=add";
        }
        if('add' != oper) {
            form.cacheManagerName.value = mgrNm;
            actionElement = setQueryParamDelim(actionElement) + "cacheManagerName=" + mgrNm;
        }
        if('delete' == oper)
        {
            if (!confirm ("OK to delete '"+mgrNm+"'?")) {
                return false;
            }
            form.operation.value = 'cache_manager_delete';  
            actionElement = setQueryParamDelim(actionElement) + "operation=cache_manager_delete";
        }
        if('reload' == oper)
        {
            if (!confirm ("OK to reload '"+mgrNm+"'?")) {
                return false;
            }
            form.operation.value = 'cache_manager_reload';
            actionElement = setQueryParamDelim(actionElement) + "operation=cache_manager_reload";
        }
        if('shutdown' == oper)
        {
            if (!confirm ("OK to shutdown '"+mgrNm+"'?")) {
                return false;
            }
            form.operation.value = 'cache_manager_shutdown';
            actionElement = setQueryParamDelim(actionElement) + "operation=cache_manager_shutdown";
        }
        if('start' == oper)
        {
            if (!confirm ("OK to start '"+mgrNm+"'?")) {
                return false;
            }
            form.operation.value = 'cache_manager_start';
            actionElement = setQueryParamDelim(actionElement) + "operation=cache_manager_start";
        }
        
        form.setAttribute("action", actionElement);
    }
    
  </script>
  
  <body onLoad="setNavigation('settings-cache-managers.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CachingScrn');">
  <table class="tableView width50">
      <tr>
          <td class="heading" colspan="1">System Cache Managers</td>
      </tr>
      <tr>
          <th class="oddcol-l" scope="col">Name</th>
      </tr>
      %invoke wm.server.ehcache.admin:getCacheManagers%
      
      %loop systemCacheManagers%
          <tr>
              <script>writeTD("row-l");</script>
											<a href="javascript:document.htmlform_manager_view.submit();"  onClick="return populateForm(document.htmlform_manager_view,'%value cacheManagerName encode(javascript)%','view','System');">
												%value cacheManagerName encode(html)%
                  </a>
              </td>   
          </tr>
          <script>swapRows();</script>
          %endloop%
  
  <table class="tableView width50">
      <tr>
          <td class="heading" colspan="4">Public Cache Managers</td>
      </tr>
      <tr>
          <th class="oddcol-l" scope="col" >Name</th>
          <th class="oddcol" scope="col" >Reload</th>
          <th class="oddcol" scope="col" >Start/Shutdown</th>
          <th class="oddcol" scope="col" >Delete</th>
      </tr>
        
      %loop publicCacheManagers%
          
          <tr>
              <script>writeTD("row-l");</script>
											<a href="javascript:document.htmlform_manager_view.submit();" onClick="return populateForm(document.htmlform_manager_view,'%value cacheManagerName encode(javascript)%','view');" >
												%value cacheManagerName encode(html)%
                  </a>
              </td>
              <script>writeTD("rowdata");</script>
              <!-- need to update the link once code is added for deleting a asset form current list-->
										   <!--<a href="security-ports-editaccess.dsp?port=%value port encode(url)%&node=%value encode(url)%&Action=deleteNode&Page=Edit">-->
                %ifvar status equals('STATUS_ALIVE')%
											  <a href="javascript:document.htmlform_manager_all.submit();" onClick="return populateForm(document.htmlform_manager_all,'%value cacheManagerName encode(javascript)%','reload');" >
                      <img src="icons/icon_reload.png" border="no" alt="Public Cache Manager %value cacheManagerName encode(javascript)%">
                    </a>
                %else%
                      <img src="icons/reload.gif" height=16 width=14 border="no">
                %endif%
              </td>                       
              <script>writeTD("rowdata");</script>
                  %ifvar status equals('STATUS_ALIVE')%
												<a href="javascript:document.htmlform_manager_all.submit();" onClick="return populateForm(document.htmlform_manager_all,'%value cacheManagerName encode(javascript)%','shutdown');" >
                          Shutdown
                      </a>
                  %else%
												<a href="javascript:document.htmlform_manager_all.submit();" onClick="return populateForm(document.htmlform_manager_all,'%value cacheManagerName encode(javascript)%','start');" >
                          Start
                      </a>
                  %endif%
              </td>
              <script>writeTD("rowdata");</script>
												   <a href="javascript:document.htmlform_manager_all.submit();" onClick="return populateForm(document.htmlform_manager_all,'%value cacheManagerName encode(javascript)%','delete');" >
                          <img src="icons/delete.png" border="no" alt="Public Cache Manager %value cacheManagerName encode(javascript)%">
                         </a>
              </td>
          </tr>
          <script>swapRows();</script>
          %endloop%
  %endinvoke%     
    </table>
    <form name="htmlform_manager_view" action="settings-cache-manager-view.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="cacheManagerName">
    </form>
    <form name="htmlform_manager_add" action="settings-cache-manager-addedit.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        
    </form>
    <form name="htmlform_manager_all" action="settings-cache.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="operation">
        <input type="hidden" name="cacheManagerName">
    </form>
  </body>   
</head>
