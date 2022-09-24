<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache"></meta>
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></meta>
        <META HTTP-EQUIV="Expires" CONTENT="-1"></META>
        <title>Integration Server Settings</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css"></LINK>
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <SCRIPT SRC="webMethods.js"></SCRIPT>
    </head>
    
    <body onLoad="setNavigation('settings-resources.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ResourcesScrn');">
        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan="4">
                    Settings &gt; Resources
                </td>
            </tr>
        
            %ifvar action equals('change')%
                %invoke wm.server.admin:setSettings%
                    %ifvar message%
                        <tr><td colspan="4">&nbsp;</td></tr>
                        <tr><td class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html)%</td></tr>
                    %endif%
                %endinvoke%
            %endif%

            <tr>
                <td valign="top" colspan="4">
                    <ul class="listitems">
                        <!--<li class="listitem"><a href="trigger-management.dsp">Trigger Management</a></li>-->
						<script>
						createForm("htmlform_settings_docstores", "settings-docstores.dsp", "POST", "BODY");
						createForm("htmlform_settings_dochistory", "settings-dochistory.dsp", "POST", "BODY");
						createForm("htmlform_xamanualrecovery", "xamanualrecovery.dsp", "POST", "BODY");
						createForm("htmlform_settings_mimetypes", "settings-mimetypes.dsp", "POST", "BODY");
						createForm("htmlform_settings_resources_edit", "settings-resources-edit.dsp", "POST", "BODY");
						</script>
                        <li class="listitem"><script>getURL("settings-docstores.dsp", "javascript:document.htmlform_settings_docstores.submit();", "Store Settings");</script>
						</li>
						
                        <li class="listitem"><script>getURL("settings-dochistory.dsp", "javascript:document.htmlform_settings_dochistory.submit();", "Exactly Once Statistics");</script>
						</li>
						
                        <li class="listitem"><script>getURL("xamanualrecovery.dsp", "javascript:document.htmlform_xamanualrecovery.submit();", "XA Manual Recovery");</script>
						</li>
						
                        <li class="listitem"><script>getURL("settings-mimetypes.dsp", "javascript:document.htmlform_settings_mimetypes.submit();", "Mime Type Settings");</script>
						</li>
						
                        <li class="listitem"><script>getURL("settings-resources-edit.dsp", "javascript:document.htmlform_settings_resources_edit.submit();", "Edit Resource Settings");</script>
						</li>
                    </ul>
                </td>
            </tr>
        </table>

            %invoke wm.server.query:getResourceSettings%

                            %loop -struct Resources%
                        <table class="tableView" width="50%">
                                <!-- key == name of section -->
                                %scope #$key%
                                    <tr>
                                        <td class="heading" colspan="2">%value name encode(html)%</td>
                                    </tr>
                                    %comment%
                                        <!--                                              -->
                                        <!-- section is array of fields, of the structure -->
                                        <!--     key:   name                              -->
                                        <!--     value: record                            -->
                                        <!--         value                                -->
                                        <!--         resource                             -->
                                        <!--         description                          -->
                                        <!--         isrequired                           -->
                                        <!--         isodd                                -->
                                        <!--         calcvalue (calculated value)         -->
                                        <!--         calcdesc (calculated description)    -->
                                        <!--                                              -->
                                    %endcomment%

                                    %loop -struct fields%
                                        <tr>
                                            %scope #$key%
                                                <td 
                                                    %ifvar isodd equals('true')%
                                                        class="oddrow"
                                                    %else%
                                        class="evenrow"
                                                    %endif%
                                    nowrap width="50%" >
	                                            %value title encode(html)%
                                                </td>
    
                                                <td
                                                    %ifvar isodd equals('true')%
                                                        class="oddrowdata-l"
                                                    %else%
                                                        class="evenrowdata-l"
                                                    %endif%
                                                     width="50%" >
                                                    %ifvar value equals("")%
                                                        unspecified
                                                    %else%
                                                        %ifvar value equals('true')%
                                                          Yes
                                                        %else%
                                                          %ifvar value equals('false')%
                                                            No
                                                          %else%
                                                            %value value encode(html)% %value description encode(html)%
                                                            %ifvar calcvalue -notempty%
                                                              (%value calcvalue encode(html)% %value calcdesc encode(html)%)
                                                            %endif%
                                                          %endif%
                                                        %endif%

                                                    %endif%
                                                </td>
                                            %endscope%
                                        </tr>
                                    %endloop%     <!-- end of field -->
                                %endscope%
                        </table>
                            %endloop%             <!-- end of section -->
            %endinvoke%
    </body>
</html>
