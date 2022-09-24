<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <link rel="stylesheet" type="text/css" href="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <script type="text/javascript" src="webMethods.js"></script>
    </head>

    <body onLoad="setNavigation(broker-sync.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_XXX');">

        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan="2">Broker &gt; Sync</td>
            </tr>

            <tr>
                <td colspan=2>
                    <ul>
					
					<script>
				       createForm("htmlform_http_settings_broker", "settings-broker.dsp", "POST", "BODY");
                    </script>
					<li>
					<script>getURL("settings-broker.dsp", "javascript:document.htmlform_http_settings_broker.submit();", "Return to Broker Settings");</script>
					
					</li>
                  </ul>
                </td>
            </tr>

            <tr>
                <td>
                    <table class="tableView">
                        <td class="heading" width="50%">Document</td>
                        <td class="heading" width="25%">Direction</td>
                        <td class="heading" width="25%">Status</td>

                        <script>resetRows();</script>
                        %invoke wm.server.ed:syncWithBroker%
                            %loop -struct documents%
                                %scope #$key%
                                    <tr>
                                        <script>writeTD("rowdata-l")</script>%value name encode(html)%</td>
                                        <script>writeTD("rowdata-l")</script>%ifvar isPull equals('true')% Pull %else% Push %endif%</td>
                                        <script>writeTD("rowdata-l")</script>%ifvar successful equals('true')% Succeeded %else% Failed %endif%</td>
                                        <script>swapRows();</script>
                                    </tr>
                                %endscope%
                            %endloop%
                        %onerror%
                            <tr></td>%value errorMessage encode(html)%</td></tr>
                        %endinvoke%
                    </table>
               </td>
            </tr>
        </table>
    </body>
</html>
