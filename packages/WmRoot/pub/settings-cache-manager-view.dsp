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
    
    function populateCacheManagerForm(form , mgr , oper)
    {
    	var actionElement = form.getAttribute("action");
    	
        form.operation.value = oper;
        actionElement = setQueryParamDelim(actionElement) + "operation=" + oper;
        
        if('edit' == oper)
        {
            form.cacheManagerName.value = mgr;
            actionElement = setQueryParamDelim(actionElement) + "cacheManagerName=" + mgr;
        }
        
        form.setAttribute("action", actionElement);
        
        return true;
    }
    function populateCacheForm(form , mgr , cacheNm , oper)
    {
    	var actionElement = form.getAttribute("action");
    	
        form.operation.value = oper;
        form.cacheManagerName.value = mgr;
        actionElement = setQueryParamDelim(actionElement) + "operation=" + oper + "&cacheManagerName=" + mgr;
        
        if('edit' == oper || 'clear' == oper || 'delete' == oper || 'sync' == oper)
        {
            form.cacheName.value = cacheNm;
            actionElement = setQueryParamDelim(actionElement) + "cacheName=" + cacheNm;
        }
        
        form.setAttribute("action", actionElement);
        
        if('disable' == oper)
        {
            if (!confirm ("OK to disable '"+cacheNm+"'?")) {
                return false;
            }
        }
        
        if('clear' == oper)
        {
            if (!confirm ("OK to clear '"+cacheNm+"'?")) {
                return false;
            }
        }
        if('delete' == oper)
        {
            if (!confirm ("OK to delete '"+cacheNm+"'?")) {
                return false;
            }
        }
        if('enable' == oper)
        {
            if (!confirm ("OK to enable '"+cacheNm+"'?")) {
                return false;
            }
        }
        
        form.setAttribute("action", actionElement);
        
        return true;
    }
    function enableDisableCache(form , mgr , cacheNm , oper,  enDis)
    {
        form.cacheName.value = cacheNm;
        if('true' == enDis)
        {
            oper = 'disable';
        }
        else
        {   
            oper = 'enable';
        }
        var boolVal = populateCacheForm(form , mgr , cacheNm , oper);
        return boolVal;
    }
  </script>
  
  <body onLoad="setNavigation('settings-cache-manager-view.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_CacheManager_Details');">
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> Settings &gt; Caching &gt; %value cacheManagerName encode(html)%</td>
        </tr>
        %ifvar operation equals('clear')%
            %invoke wm.server.ehcache.admin:clearCache%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif% 
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>	
            %endinvoke%
        %endif%
        %ifvar operation equals('enable')%
            %invoke wm.server.ehcache.admin:enableCache%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>	
            %endinvoke%
        %endif%
        %ifvar operation equals('disable')%
            %invoke wm.server.ehcache.admin:disableCache%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%
        %ifvar operation equals('delete')%
            %invoke wm.server.ehcache.admin:deleteCache%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%
        %ifvar operation equals('add')%
            %scope rparam(nonStopConfiguration={enabled='false'}) rparam(terracottaConfiguration={clustered='false'})%
                %scope nonStopConfiguration%
                    %ifvar ../../enabled equals('true')% 
                        %rename ../../enabled enabled -copy%
                    %else%
                        %rename ../../tempBool enabled -copy%
                    %endif% 
                    %ifvar ../../immediateTimeout equals('true')% 
                        %rename ../../immediateTimeout immediateTimeout -copy%
                    %else%
                        %rename ../../tempBool immediateTimeout -copy%  
                    %endif% 
                    
                    %rename ../../timeoutBehaviorType timeoutBehaviorType -copy%
                    
                    %rename ../../timeoutMillis timeoutMillis -copy%
                %endscope%
                %scope terracottaConfiguration%
                    %ifvar ../../clustered equals('true')% 
                        %rename ../../clustered clustered -copy%
                    %else%
                        %rename ../../tempBool clustered -copy% 
                    %endif% 
                    
                    %ifvar ../../synchronousWrites equals('true')% 
                        %rename ../../synchronousWrites synchronousWrites -copy%
                    %else%
                        %rename ../../tempBool synchronousWrites -copy% 
                    %endif% 
                    %rename ../../consistency consistency -copy%
                    
                    %rename ../nonStopConfiguration nonStopConfiguration -copy%
                %endscope%
                %invoke wm.server.ehcache.admin:addCache%
                    %ifvar message%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                    %endif%
                    %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                %endinvoke%
            %endscope%
        %endif%
        %ifvar operation equals('edit')%
            %scope rparam(nonStopConfiguration={enabled='false'}) rparam(terracottaConfiguration={clustered='false'})%
                %scope nonStopConfiguration%
                    %ifvar ../../enabled equals('true')% 
                        %rename ../../enabled enabled -copy%
                    %else%
                        %rename ../../tempBool enabled -copy%
                    %endif% 
                    %ifvar ../../immediateTimeout equals('true')% 
                        %rename ../../immediateTimeout immediateTimeout -copy%
                    %else%
                        %rename ../../tempBool immediateTimeout -copy%  
                    %endif% 
                    
                    %rename ../../timeoutBehaviorType timeoutBehaviorType -copy%
                    
                    %rename ../../timeoutMillis timeoutMillis -copy%
                %endscope%
                %scope terracottaConfiguration%
                    %ifvar ../../clustered equals('true')% 
                        %rename ../../clustered clustered -copy%
                    %else%
                        %rename ../../tempBool clustered -copy% 
                    %endif% 
                    
                    %ifvar ../../synchronousWrites equals('true')% 
                        %rename ../../synchronousWrites synchronousWrites -copy%
                    %else%
                        %rename ../../tempBool synchronousWrites -copy% 
                    %endif% 
                    %rename ../../consistency consistency -copy%
                
                    %rename ../nonStopConfiguration nonStopConfiguration -copy%
                %endscope%
                %invoke wm.server.ehcache.admin:updateCache%
                    %ifvar message%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                    %endif%
                    %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                %endinvoke%
            %endscope%
        %endif%
        %ifvar message%
            %rename message oldMessage%
        %endifvar%
        %invoke wm.server.ehcache.admin:getCacheManager%
            %ifvar message%
                <tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
            %endif%
            %onerror%
                <tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
        %endinvoke%

        <tr>
            <td colspan="2">
                <ul class="listitems">
                    <li class="listitem">
					<script>
					createForm("htmlform_settings_cache", "settings-cache.dsp", "POST", "BODY");
					</script>
					<script>getURL("settings-cache.dsp","javascript:document.htmlform_settings_cache.submit();","Return to Caching")</script>
					</li>
                    %ifvar isInternal equals('false')%
                        <li class="listitem"><a href="javascript:document.htmlform_cache_add.submit();" onClick="return populateCacheForm(document.htmlform_cache_add,'%value cacheManagerName encode(javascript)%','','add');">Add Cache</a></li>
                        <li class="listitem"><a href="javascript:document.htmlform_manager_edit.submit();" onClick="return populateCacheManagerForm(document.htmlform_manager_edit,'%value cacheManagerName encode(javascript)%','edit');">Edit Cache Manager Configuration</a></li>
                    %endif%
                </ul>
            </td>
        </tr>
        
        <tr>
             <td>
                            <table class="tableView width50">
                            <tr>
                                <td class="heading" colspan="2">Cache Manager Configuration</td>
                            </tr>
                            
                            <tr>
                                <td class="oddrow" scope="row" width="50%">Name</td>
                                <td class="oddrowdata-l">
									%value cacheManagerName encode(html)%
                                </td>
                            </tr>
                            
                            <tr>
                                <td class="evenrow" scope="row">Terracotta Server Array URLs</td>
                                <td class="evenrowdata-l">
									%value tsaURL encode(html)%
                                </td>
                            </tr>
                            
                            <tr>
                                <td class="oddrow" scope="row">Rejoin</td>  
                                <td class="oddrowdata-l">
                                    %ifvar rejoin equals('true')%
                                        Yes
                                    %else%
                                        No
                                    %endif% 
                                </td>
                            </tr>

                            <tr>
                                <td class="evenrow" scope="row">BigMemory Allocated</td>
                                <td class="evenrowdata-l">
									%ifvar totalBigMemory -notempty% %value totalBigMemory encode(html)% MB
                                     %else% None
                                     %endif%                                                                
                                </td>
                            </tr>
                            
                            </table>
            </td>
        </tr>

        <tr>
            <td>
                        <table class="tableView width50" width="%ifvar isInternal equals('false')%50%%else%25%%endif%">
                            <tr>
                                <td class="heading" colspan="5">Cache List</td>
                            </tr>

                            <tr>
                                <th class="oddcol-l" scope="col">Cache Name</th>
                                %ifvar isInternal equals('false')%
                                    <th class="oddcol" scope="col">BigMemory</th>
                                    <th class="oddcol" scope="col">Enabled</th>
                                    <th class="oddcol" scope="col">Clear</th>
                                    <th class="oddcol" scope="col">Delete</th>
                                %endif%     
                                
                            </tr>
                            %invoke wm.server.ehcache.admin:getCaches%
                            %loop caches%
                            
                            <tr>
                                <script>writeTD("row-l");</script>
									<a href="javascript:document.htmlform_cache_edit.submit();" onClick="return populateCacheForm(document.htmlform_cache_edit,'%value ../cacheManagerName encode(javascript)%','%value cacheName encode(javascript)%','edit');" >
											%value cacheName encode(html)% 
                                    </a>
                                    
                                </td>
                                %ifvar isInternal equals('false')%
                                    <script>writeTD("rowdata");</script>
                                    
									 %ifvar maxMemoryOffHeap -notempty% %value maxMemoryOffHeap encode(html)%
                                     %else% None
                                     %endif%
                                     
                                    </td>
                                    <script>writeTD("rowdata");</script>
									 <a href="javascript:document.htmlform_cache_other.submit();" onClick="return enableDisableCache(document.htmlform_cache_other,'%value ../cacheManagerName encode(javascript)%','%value cacheName encode(javascript)%','ED','%value enabled encode(javascript)%');" >
                                          %ifvar enabled equals('true')%
                                            Yes
                                          %else%
                                            No
                                          %endif%   
                                     </a>
                                    </td>
                                    <script>writeTD("rowdata");</script>
                                    
									  <a href="javascript:document.htmlform_cache_other.submit();" onClick="return populateCacheForm(document.htmlform_cache_other,'%value ../cacheManagerName encode(javascript)%','%value cacheName encode(javascript)%','clear');">
                                            <IMG SRC="images/clear_icon_16.png" border="0"
                                                height=16 width=16  alt="Cache %value cacheName encode(javascript)%">
                                            
                                        </a>
                                        
                                    </td>
                                
                                    <script>writeTD("rowdata");</script>
									<a href="javascript:document.htmlform_cache_other.submit();" onClick="return populateCacheForm(document.htmlform_cache_other,'%value ../cacheManagerName encode(javascript)%','%value cacheName encode(javascript)%','delete');">
                                        <img src="icons/delete.png" border="no" alt="Cache %value cacheName encode(javascript)%">
                                     </a>
                                    
                                    </td>
                                    
                                %endif% 
                                    
                            </tr>
                            <script>swapRows();</script>
                            %endloop%
                            
                            %endinvoke%
            </table>
            </td>
        </tr>
    </table>
    <form name="htmlform_manager_edit" action="settings-cache-manager-addedit.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="cacheManagerName">
        <input type="hidden" name="operation">
    </form>
    <form name="htmlform_cache_edit" action="settings-cache-addedit.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="cacheManagerName">
        <input type="hidden" name="cacheName">
        <input type="hidden" name="operation">
    </form>
    <form name="htmlform_cache_add" action="settings-cache-addedit.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="cacheManagerName">
        <input type="hidden" name="operation">
    </form>
    <form name="htmlform_cache_other" action="settings-cache-manager-view.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="cacheManagerName">
        <input type="hidden" name="cacheName">
        <input type="hidden" name="operation">
    </form>
    <form name="htmlform_cache_sync" action="settings-cache-diff.dsp" method="POST">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <input type="hidden" name="cacheManagerName">
        <input type="hidden" name="cacheName">
        <input type="hidden" name="operation">
    </form>
  </body>   
</head>
