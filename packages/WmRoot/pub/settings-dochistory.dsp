<HTML>
    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <SCRIPT SRC="webMethods.js"></SCRIPT>
    </HEAD>

    <BODY onLoad="setNavigation('settings-dochistory.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ExactlyOnceStatsScrn');">
        <TABLE width="100%">
            <TR>
                <TD class="breadcrumb" colspan="2">
                    Settings &gt; Resources &gt; Exactly Once Statistics
                </TD>
            </TR>

        %ifvar action equals('deleteExpiredUUID')%
            %invoke wm.server.dispatcher.adminui:deleteExpiredUUID%
            <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %onerror%
            <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
            %endinvoke%
        %endif%

        %ifvar action equals('clearDupeOrInDoubtDocsStat')%
            %invoke wm.server.dispatcher.adminui:clearDupeOrInDoubtDocsStat%
            <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %onerror%
            <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
            %endinvoke%
        %endif%

        %ifvar action equals('clearTriggerDupeOrInDoubtDocsStat')%
            %invoke wm.server.dispatcher.adminui:clearTriggerDupeOrInDoubtDocsStat%
            <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
            %onerror%
            <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan="2">%value errorMessage encode(html)%</TD></TR>
            %endinvoke%
        %endif%
            <TR>
                <TD colspan="2">
                    <ul class="listitems">
						<script>
						createForm("htmlform_settings_resources", "settings-resources.dsp", "POST", "BODY");
						createForm("htmlform_settings_dochistory_delete_expired_UUID", "settings-dochistory.dsp", "POST", "BODY");
						setFormProperty("htmlform_settings_dochistory_delete_expired_UUID", "action", "deleteExpiredUUID");
						createForm("htmlform_settings_dochistory_clear_docs_stat", "settings-dochistory.dsp", "POST", "BODY");
						setFormProperty("htmlform_settings_dochistory_clear_docs_stat", "action", "clearDupeOrInDoubtDocsStat");
						</script>
                        <li class="listitem">
						<script>getURL("settings-resources.dsp", "javascript:document.htmlform_settings_resources.submit();", "Return to Resource Settings");</script>
						</li>
                        <li class="listitem">
						<script>getURL("settings-dochistory.dsp?action=deleteExpiredUUID", "javascript:document.htmlform_settings_dochistory_delete_expired_UUID.submit();", "Remove Expired Document History Entries");</script>
						
						</li>
                        <li class="listitem">
						<script>getURL("settings-dochistory.dsp?action=clearDupeOrInDoubtDocsStat", "javascript:document.htmlform_settings_dochistory_clear_docs_stat.submit();", "Clear All Duplicate or In Doubt Document Statistics");</script>
						
						</li>
                    </UL>
                </TD>
            </TR>

            <TR>
                <TD width="100%">
                    <TABLE class="tableView">
                            <TR>
                                <TD class="heading" colspan=3>Duplicate or In Doubt Document Statistics</TD>
                            </TR>

                        <script>swapRows();</script>
                        %invoke wm.server.dispatcher.adminui:getDupeOrInDoubtDocsInfo%
                        %ifvar topentries%
                            %loop topentries%
                                <TR>
                                    <script>writeTD("rowdata-l",2);</script>%value name encode(html)%</TD>
                                    <script>writeTD("rowdata",2);</script>
                                        <FORM name="clearStatForm" action="settings-dochistory.dsp" method="POST">
                                        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                                        <INPUT type="submit" name=submit value=Clear></INPUT>
                                        <INPUT type="hidden" name=triggerName value="%value name encode(htmlattr)%"></INPUT>
                                        <INPUT type="hidden" name=action value=clearTriggerDupeOrInDoubtDocsStat></INPUT>
                                        </FORM>
                                    </TD>
                                    <TD>
                                        <TABLE class="tableview">
                                        <TR>
                                            <script>writeTDrowspan("col", 2);</script><nobr>Document Name</nobr></TD>
                                            <script>writeTDrowspan("col", 2);</script>Document UUID</TD>
                                            <script>writeTDrowspan("col", 2);</script>Document Status</TD>
                                        </TR>
                                        <script>swapRows();</script>
                                        %loop entries%
                                    <TR>
                                    <TD>
                                            <TR>
                                                <script>writeTDrowspan("rowdata", 2);</script><nobr>%value DOCNAME encode(html)%</nobr></TD>
                                                <script>writeTDrowspan("rowdata", 2);</script>%value UUID encode(html)%</TD>
                                                <script>writeTDrowspan("rowdata", 2);</script>%value STATUS encode(html)%</TD>
                                            </TR>
                                    </TD>
                                    </TD>
                                    </TR>
                                    %endloop%
                                </TABLE>
                                </TD>
                                </TR>
                                <script>swapRows();</script>
                            %endloop%
                            <TR>
                                <TD class="space" colspan="2">&nbsp;</TD>
                            </TR>
                        %else%
                        <TR><TD class='oddrow-l' colspan=2>No Document whose status is either Duplicate or In Doubt.</TD></TR>
                        %endif%
                        %endinvoke%

                    </TABLE>
                </TD>
            </TR>

        </TABLE>
    </BODY>
</HTML>
