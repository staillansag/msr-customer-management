<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="no-cache" http-equiv="Pragma">
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  <meta content="-1" http-equiv="Expires">
  <title>Server &gt; Statistics</title>
  <link href="webMethods.css" type="text/css" rel="stylesheet">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="webMethods.js"></script>
</head>

<body onLoad="setNavigation('trigger-management-cluster.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ClusterViewScrn');">

<table width="100%">
  <tbody>
    <tr>
      <td class="breadcrumb" colspan="3">Settings &gt; Messaging &gt; webMethods Messaging Trigger Management &gt; Cluster View</td>
    </tr>
  </tbody>
</table>   
<table width="100%">
  <tbody>
    <tr>
      <td colspan="2">
      <ul>
	    <script>
		createForm("htmlform_trigger_management", "trigger-management.dsp", "POST", "BODY");
		createForm("htmlform_trigger_conditions", "trigger_conditions.dsp", "POST", "BODY");
		</script>
        <li class="listitem">
		<script>getURL("trigger-management.dsp", "javascript:document.htmlform_trigger_management.submit();", "Return to webMethods Messaging Trigger Management");</script>
		</li>
        <!-- <li class="listitem"><a href="javascript:document.htmlform_trigger_conditions.submit();">Document Routing View</a></li> -->
      </ul>
      </td>
    </tr>
    <tr>
    </tr>
    <tr>
      <td><img style="width: 10px; height: 10px;" alt="" src="images/blank.gif"><br>
      </td>
      <td>
      <table width="100%">
        <tbody>
          <tr>
            <td class="heading">Cluster Server List<br>
            </td>
          </tr>
        </tbody>
      </table>
      <table width="100%">
        <tbody>
          <tr>
            <th class="oddcol-l" scope="col">Remote&nbsp;Server Alias</th>
            <th class="oddcol-l" scope="col">Remote&nbsp;Server In&nbsp;Sync?&nbsp;&nbsp;</th>
            <th class="oddcol-l" scope="col">Trigger Name</th>
            <th class="oddcol-l" scope="col">Trigger In&nbsp;Sync?</th>
            <th class="oddcol-l" scope="col">Error Message</th>
          </tr>

          %rename triggerName empty%
          %invoke wm.server.triggers:getClusterReport%
          
            %loop aliasList%
            
              <tr>
              
                %ifvar aliasURL -notempty%
                    <script>writeTD("row-l");</script>
					<script>
					createForm("htmlform_trigger_management_%value $index%", "%value aliasURL encode(url)%trigger-management.dsp", "POST", "BODY");
					</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_trigger_management_%value $index%.submit();" target="_blank">%value aliasName encode(html)%</a>');
						} else {
							var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
							if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
								document.write('<a href="%value aliasURL encode(url)%trigger-management.dsp?webMethods-wM-AdminUI=true" target="_blank">%value aliasName encode(html)%</a>');
							}
							else {
								document.write('<a href="%value aliasURL encode(url)%trigger-management.dsp" target="_blank">%value aliasName encode(html)%</a>');
							}
						}
					</script>
					
					</td> 
                %else%
                    <script>writeTD("row-l");</script>%value aliasName encode(html)%</td> 
                %endif%
               
                %ifvar exception -notempty%
                  <script>writeTD("rowdata");</script>No</td> 
                  <script>writeTD("row-l");</script>&nbsp</td> 
                  <script>writeTD("row-l");</script>&nbsp</td> 
                  <script>writeTD("row-l");</script>Unable to retrieve cluster report: %value exception encode(html)%</td> 
                %else%
                  %ifvar inSync equals('true')%                    
                    <script>writeTD("rowdata");</script><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</td>
                  %else%
                    <script>writeTD("rowdata");</script>No</td>
                  %endif%
                  <script>writeTDspan("row-l", 3);</script>&nbsp</td> 
                %endif%
              </tr>
              
              %ifvar exception -notempty%
              %else%
                %loop triggerDetail%
                  <tr>
                    <script>writeTD("row-l");</script>&nbsp</td> 
                    <script>writeTD("row-l");</script>&nbsp</td> 
                    <script>writeTD("row-l");</script>%value ../aliasName encode(html)%::%value triggerName encode(html)%</td> 
                    %ifvar inSync equals('true')%                    
                      <script>writeTD("rowdata");</script><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">Yes</td>
                      <script>writeTD("row-l");</script>&nbsp;</td>
                    %else%
                      <script>writeTD("rowdata");</script>No</td>
                      <script>writeTDnowrap("row-l");</script>
                      %loop msg%
                        %value encode(html)%<br>
                      %endloop%
                      </td>
                    %endif%
  
                  </tr>
                %endloop%
              %endif%
            
              <script>swapRows();</script>
            %endloop%
          
          
          
          %onerror%
            %value errorMessage encode(html)%
          %endinvoke%
 
        </tbody>
      </table>
      </td>
    </tr>
  </tbody>
</table>
</body>
</html>
