<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>IS Service Statistics</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <!--<META http-equiv="refresh" content="90">-->

    <SCRIPT src="webMethods.js"></SCRIPT>

  </HEAD>

  %scope%
  %invoke wm.server.query:getLicenseInfo%
  
  <BODY onLoad="setNavigation('stats-services.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_ServiceUsageScrn');">
      <TABLE width="100%">
         <TR>
            <TD class="breadcrumb" colspan=14>Server &gt; Service Usage</TD>
         </TR>

      %ifvar /action equals('resetcache')%
        %invoke wm.server.cache.adminui:resetCache%
            <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Server cache cleared</TD></TR>
        %endinvoke%
      %endif%

          <tr>
            <td colspan=2>
              <ul>
                  <li class="listitem">
				  <script>
				  createForm("htmlform_stats_services", "stats-services.dsp", "POST", "BODY");
				  setFormProperty("htmlform_stats_services", "action", "resetcache");
				  </script>
				  <script>getURL("stats-services.dsp?action=resetcache","javascript:document.htmlform_stats_services.submit();","Reset Server Cache");</script></li>
                  <li class="listitem-input">
                    <input type="checkbox" id="ssot" align="right" onclick="executeAction(this)" %ifvar ../checked% checked %endif%><label for="ssot">Show running services on top</label></li>
                </ul>
              </td>
            </tr>

            %invoke wm.server.query:getServiceStats%
            <TR>
               <TD>
                  <TABLE class="tableView" width="100%" id="servicecon">
                     <TR>
                        <TD CLASS="heading" COLSPAN=6>Service</td>
                     <TR class="subheading2">
                        <TH CLASS="oddcol-l" scope="col">Name (instances currently running)</TH>
                        <TH CLASS="oddcol" scope="col">Count</TH>
                        <TH CLASS="oddcol" nowrap scope="col">Last Ran</TH>
                        <TH CLASS="oddcol" scope="col">Cached</TH>
                        <TH CLASS="oddcol" scope="col">Prefetched</TH>
						%ifvar ../LicenseInfo/Microservices equals('true')%
                        <TH CLASS="oddcol" scope="col">Circuit Breaker Enabled</TH>
						%endif%
                     </TR>
                     %ifvar SvcStats%
                     <script>resetRows();</script>

                     %loop SvcStats%
                     <TR id="%ifvar sRunning equals('&nbsp;')%%value $index encode(htmlattr)%%else%%value $index encode(htmlattr)%run%endif%">
                        <td class="field">
						<script>
						createForm("htmlform_service_info_1_%value $index%", "service-info.dsp", "POST", "BODY");
						setFormProperty("htmlform_service_info_1_%value $index%", "service", "%value ifc encode(url)%:%value svc encode(url)%");
						</script>						
						<script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A href="javascript:document.htmlform_service_info_1_%value $index%.submit();" title="%value ifc encode(html)%:%value svc encode(html)% Service"> %value ifc encode(html)%:%value svc encode(html)%</A>');
		       } else {
		       		%rename ../../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="service-info.dsp?service=%value ifc encode(url)%:%value svc encode(url)%&webMethods-wM-AdminUI=true" title="%value ifc encode(html)%:%value svc encode(html)% Service"> %value ifc encode(html)%:%value svc encode(html)%</A>');
					}
					else {
						document.write('<A href="service-info.dsp?service=%value ifc encode(url)%:%value svc encode(url)%" title="%value ifc encode(html)%:%value svc encode(html)% Service"> %value ifc encode(html)%:%value svc encode(html)%</A>');
					}
		       }
           </script>
                            %ifvar equals('&nbsp;') sRunning%%else%(%value sRunning encode(html)%)%endif%</nobr></TD>
                        <script>writeTD('rowdata');</script>
                            %value none sAccessTotal%</TD>
                        <script>writeTD('rowdata');</script>
                           <nobr>%value none sAccessLast%</nobr></TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar equals('N') isCached%-%else%<IMG SRC="images/green_check.png" height=13 width=13>%endif%</TD>
                        <script>writeTD('rowdata');</script>
							%ifvar equals('N') isPrefetched%-%else%<IMG SRC="images/green_check.png" height=13 width=13>%endif%</TD>
			 %ifvar ../../LicenseInfo/Microservices equals('true')%
                        <script>writeTD('rowdata');</script>
						%ifvar equals('N') cCircuitBreaker%-%else%<IMG SRC="images/green_check.png" height=13 width=13>%endif%</TD>
			 %endif%
                     </TR><script>swapRows();</script>%endloop%
             %else%
                     <TR>
                        <TD CLASS="evenrow-l" colspan=5>No services</TD>
                     </TR>
             %endif%
                  </TABLE>
                </TD>

               </TR>
               <TR>
               <TD>
                  <IMG SRC="images/blank.gif" WIDTH=10 HEIGHT=10>

                  <TABLE class="tableView" width="100%">
                     <TR>
                        <TD CLASS="heading" COLSPAN=9>Cache and Prefetch Information</TD>
						
                     <TR class="subheading2">
                        <TH nowrap CLASS="oddcol" scope="col">Name</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Last Cache Hit</TH>
                        <TH nowrap CLASS="oddcol"  scope="col">Cache Hits</TH>
                        <TH CLASS="oddcol" nowrap scope="col">Cache Hits/<BR>Total Count</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Cache Entries</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Cache Expires</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Last Prefetch</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Total Prefetches</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Recent Prefetch</TH>

                     </TR>
                     <script>resetRows();</script>
                     <script>var count=0;</script>
                     %loop SvcStats%
                       %ifvar isCached equals('Y')%<TR>

                       <script>count++;</script>
                        <td class="field">
							<script>
							createForm("htmlform_service_info_2_%value $index%", "service-info.dsp", "POST", "BODY");
							setFormProperty("htmlform_service_info_2_%value $index%", "service", "%value ifc  encode(url)%:%value svc encode(url)%");
							</script>
                           <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A href="javascript:document.htmlform_service_info_2_%value $index%.submit();" title="%value ifc encode(html)%:%value svc encode(html)% Cache and Prefetch Information"> %value ifc encode(html)%:%value svc encode(html)%</A>');
		       } else {
		       		%rename ../../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="service-info.dsp?service=%value ifc  encode(url)%:%value svc encode(url)%&webMethods-wM-AdminUI=true" title="%value ifc encode(html)%:%value svc encode(html)% Cache and Prefetch Information"> %value ifc encode(html)%:%value svc encode(html)%</A>');
					}
					else {
						document.write('<A href="service-info.dsp?service=%value ifc  encode(url)%:%value svc encode(url)%" title="%value ifc encode(html)%:%value svc encode(html)% Cache and Prefetch Information"> %value ifc encode(html)%:%value svc encode(html)%</A>');
					}
		       }
           </script>
						</TD>
                        <script>writeTD('rowdata');</script>
                           %ifvar cHitLast equals('&nbsp;')%-%else%%value cHitLast encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cHitTotal equals('&nbsp;')%-%else%%value cHitTotal encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cHitRatio equals('&nbsp;')%-%else%%value cHitRatio encode(html)%%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cEntries equals('&nbsp;')%-%else%%value cEntries encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cExpires equals('&nbsp;')%-%else%%value cExpires encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cPrefetchLast equals('&nbsp;')%-%else%%value cPrefetchLast encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cPrefetchTotal equals('&nbsp;')%-%else%%value cPrefetchTotal encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar cPrefetched equals('&nbsp;')%-%else%%value cPrefetched encode(html)%%endif%</TD>
                        </TR><script>swapRows();</script>
                      %endif%
                     %endloop%
                     <script>
                     if (count == 0) {
                        document.write("<TR>");
                        document.write("<TD CLASS='evenrow-l' colspan=9>No Services Cached</TD>");
                        document.write("</TR>");
                      }
                     </script>
                  </TABLE></TD>
            </TR>
			%ifvar ../LicenseInfo/Microservices equals('true')%
              %invoke wm.server.query:getCircuitBreakerStats%
              <TR>
               <TD>
                  <IMG SRC="images/blank.gif" WIDTH=10 HEIGHT=10>

                  <TABLE class="tableView" width="100%">
                     <TR>
                        <TD CLASS="heading" COLSPAN=7>Circuit Breaker Information</TD>
                     <TR class="subheading2">
                        <TH nowrap CLASS="oddcol" scope="col">Name</TH>
                        <TH nowrap CLASS="oddcol" scope="col">State</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Open Time</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Half-Open Time</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Closed Time</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Open Count</TH>
                        <TH nowrap CLASS="oddcol" scope="col">Request Count</TH>

                     </TR>
                     <script>resetRows();</script>
                     <script>var cbcount=0;</script>
                     %loop SvcStats%
                       <script>cbcount++;</script>
                        <td class="field">
							<script>
 							createForm("htmlform_service_info_3_%value $index%", "service-info.dsp", "POST", "BODY");
							setFormProperty("htmlform_service_info_3_%value $index%", "service", "%value ifc  encode(url)%:%value svc encode(url)%");
							</script>
                           <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<A href="javascript:document.htmlform_service_info_3_%value $index%.submit();" title="%value ifc encode(html)%:%value svc encode(html)% Circuit Breaker Information"> %value ifc encode(html)%:%value svc encode(html)%</A>');
		       } else {
		       		%rename ../../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<A href="service-info.dsp?service=%value ifc  encode(url)%:%value svc encode(url)%&webMethods-wM-AdminUI=true" title="%value ifc encode(html)%:%value svc encode(html)% Circuit Breaker Information"> %value ifc encode(html)%:%value svc encode(html)%</A>');
					}
					else {
						document.write('<A href="service-info.dsp?service=%value ifc  encode(url)%:%value svc encode(url)%" title="%value ifc encode(html)%:%value svc encode(html)% Circuit Breaker Information"> %value ifc encode(html)%:%value svc encode(html)%</A>');
					}
		       }
           </script>
						</TD>
                        <script>writeTD('rowdata');</script>
                           %ifvar state equals('&nbsp;')%-%else%%value state encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar circuitOpenTime equals('&nbsp;')%-%else%%value circuitOpenTime encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar circuitHalfOpenTime equals('&nbsp;')%-%else%%value circuitHalfOpenTime encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar circuitClosedTime equals('&nbsp;')%-%else%%value circuitClosedTime encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar circuitOpenCount equals('&nbsp;')%-%else%%value circuitOpenCount encode(html)%%endif%</TD>
                        <script>writeTD('rowdata');</script>
                            %ifvar requestCount equals('&nbsp;')%-%else%%value requestCount encode(html)%%endif%</TD>
                        </TR><script>swapRows();</script>
                     %endloop%
                     <script>
                     if (cbcount == 0) {
                        document.write("<TR>");
                        document.write("<TD CLASS='evenrow-l' colspan=9>No Services with Circuit Breaker Enabled</TD>");
                        document.write("</TR>");
                      }
                     </script>
                  </TABLE></TD>
            </TR>
			%endinvoke%
			%endif%
         </TABLE>
        %endinvoke%
   </BODY>
   %endscope%
   %endinvoke%
</HTML>

<script>
var stateChanged = false;
var originalURL;
var tempURL = window.location+"";
var index = tempURL.indexOf("?");

if (index != -1) {
    originalURL = tempURL.substring(0,index);
} else {
    originalURL = tempURL ;
}
if (webMethods_wM_AdminUI) {
	originalURL += '?webMethods-wM-AdminUI=true';
}

var MSIE = false;
if(navigator.userAgent.indexOf("MSIE")!=-1){
    MSIE = true;
}

function showRunningServicesOnTop(){

stateChanged=false;
var replaceCount = 2;
var table = document.getElementById('servicecon');
var rows = table.rows;
var len = rows.length;
var j = len-1;
var i = 2;

while(i < j) {
    
    var isRunningService = true;
    while(isRunningService) {
        if(i > len-1) {
            break;
        }
        if(rows[i].id.indexOf("run") == -1) {
            isRunningService = false;
        } else {
            i++;
        }
    } 
    var isNonRunningService = true;
    while(isNonRunningService) {
        if(j < 0) {
            break;
        }
        if(rows[j].id.indexOf("run") != -1) {
            isNonRunningService = false;
        } else {
            j--;
        }
    }
    
    if(i<j) {
        if(MSIE){
            rows[j].swapNode(rows[i]);
        } else {
            var a = rows[i].innerHTML;
            rows[i].innerHTML= rows[j].innerHTML;
            rows[j].innerHTML=a;
        }
        
        var cells1 = rows[i].cells;
        var cells2 = rows[j].cells;
        if(cells1[0].className != cells2[0].className) {
            for(var j1 = 0;j1 < cells1.length; j1++){
                var a11 = cells1[j1].className;
                cells1[j1].className = cells2[j1].className;
                cells2[j1].className=a11;
            }
        }
        i++;
        j--;
    }

}
stateChanged = true;
return;
/*if(replaceCount==2){
    return;
}
stateChanged = true;
resetRows();

for(var i=2;i<rows.length;i++){
    var cells = rows[i].cells;
    cells[0].className=row+"rowdata-l";
    for(var j = 1;j<cells.length;j++){
        cells[j].className=row+"rowdata";
    }
    swapRows();
}*/
}

function executeAction(checkbox){
    if(checkbox.checked){
        showRunningServicesOnTop();
    } else if(stateChanged){
		
        if(is_csrf_guard_enabled && needToInsertToken) {
			createForm("htmlForm_original_url", originalURL, "POST", "BODY");
			setFormProperty("htmlForm_original_url", _csrfTokenNm_, _csrfTokenVal_);  
            window.location.href="javascript:document.htmlForm_original_url.submit()";			
        }
		
		else
		{
			window.location.href=originalURL;
		}
    }
}

function refreshPage(){
    var checkBox = document.getElementById("ssot");
    var url = originalURL;
	
    
    if(is_csrf_guard_enabled && needToInsertToken) {
		
		createForm("htmlForm_url", url, "POST", "BODY");
		if(checkBox.checked){
			setFormProperty("htmlForm_url", "checked", "true");
		}
        setFormProperty("htmlForm_url", _csrfTokenNm_, _csrfTokenVal_);
        window.location.href="javascript:document.htmlForm_url.submit()";
    }
	
	else
	{ 
        if(checkBox.checked){
			url=url+"?checked=true";
		}
		window.location.href=url;
	}
}

%ifvar checked% showRunningServicesOnTop(); %endif%

</script>
        %scope param(property='watt.server.serviceUsageDSP.RefreshInterval')%
            %invoke wm.server.query:getSetting%
                %ifvar property -notempty%
                    %ifvar property matches('-*')%
                    %else%
						<script> window.setInterval("refreshPage()","%value property encode(javascript)%"*1000);</script>
                    %endif%
                %else%
                    <script> window.setInterval("refreshPage()",90*1000);</script>
                %endif%
            %endinvoke%
        %endscope%
