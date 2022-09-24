%invoke wm.server.ws:listProviderEndpoints%

    <TR manualhide="true" id="Provider%value transportType encode(htmlattr)%ToggleRow" onClick="toggle(this, 'Provider%value transportType encode(javascript)%Row', 'Provider%value transportType encode(javascript)%Img');">
        <TD class="subHeading" style="cursor: pointer" colspan=10><img id="Provider%value transportType encode(htmlattr)%Img" src="images/collapsed_blue.gif" border="0"> <a href="#" name="anchorProvider%value transportType encode(htmlattr)%">%value transportType encode(html)%</a></TD>
    </TR>
    
    <script>
        resetRows();
    </script>
    %loop endpoints%
		<TR name="Provider%value ../transportType encode(htmlattr)%Row" style="display:none;">
    <script>writeTD("rowdata");</script>
    %ifvar defaultAlias equals('true')%
        <img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png"></a>              
    %else%
        &nbsp;
    %endif%
    </TD>
    <script>writeTD("rowdata-l");</script>
		<script>
		createForm("htmlform_settings_wsendpoints_addedit_provider_%value transportInfo/transportType%_%value $index%", "settings-wsendpoints-addedit.dsp", "POST", "BODY");
		setFormProperty("htmlform_settings_wsendpoints_addedit_provider_%value transportInfo/transportType%_%value $index%", "action", "view");
		setFormProperty("htmlform_settings_wsendpoints_addedit_provider_%value transportInfo/transportType%_%value $index%", "alias", "%value alias encode(url)%");
		setFormProperty("htmlform_settings_wsendpoints_addedit_provider_%value transportInfo/transportType%_%value $index%", "type", "provider");
		setFormProperty("htmlform_settings_wsendpoints_addedit_provider_%value transportInfo/transportType%_%value $index%", "transportType", "%value transportInfo/transportType encode(url)%");
		</script>
		<script>
			if(is_csrf_guard_enabled && needToInsertToken) {
				document.write('<a href="javascript:document.htmlform_settings_wsendpoints_addedit_provider_%value transportInfo/transportType%_%value $index%.submit();">%value alias encode(html)%</a>');
			} else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					document.write('<a href="settings-wsendpoints-addedit.dsp?action=view&alias=%value alias encode(url)%&type=provider&transportType=%value transportInfo/transportType encode(url)%&webMethods-wM-AdminUI=true">%value alias encode(html)%</a>');
				}
				else {
					document.write('<a href="settings-wsendpoints-addedit.dsp?action=view&alias=%value alias encode(url)%&type=provider&transportType=%value transportInfo/transportType encode(url)%">%value alias encode(html)%</a>');
				}
			}
		</script>
		    
        </TD>
		    <script>writeTD("row-l");</script>%value description encode(html)%</TD>
            <script>writeTD("rowdata");</script>
			<script>
			createForm("htmlform_wsendpoints_listProviders_%value $index%", "wsendpoints-listProviders.dsp", "POST", "BODY");
			</script>
      %ifvar defaultAlias equals('true')%
         &nbsp;
      %else%
	  <script>
		if(is_csrf_guard_enabled && needToInsertToken) {
			document.write('<a class="imagelink" href="javascript:document.htmlform_wsendpoints_listProviders_%value $index%.submit();" onClick="return confirmDelete(\'%value alias encode(javascript)%\',\'provider\', \'%value transportInfo/transportType encode(javascript)%\');"> <img src="icons/delete.png" alt="Delete Web Service Provider Endpoint alias : %value alias encode(htmlattr)%" border="none"></a>');
		} else {
			document.write('<a class="imagelink" href="" onClick="return confirmDelete(\'%value alias encode(javascript)%\',\'provider\', \'%value transportInfo/transportType encode(javascript)%\');"> <img src="icons/delete.png" alt="Delete Web Service Provider Endpoint alias : %value alias encode(htmlattr)%" border="none"></a>');
		}
	</script>
         
        </TD>

        </TR>

        <script>
        swapRows();</script>
    %endloop%
%endinvoke%
<script>checkPrevState("Provider%value transportType encode(javascript)%ToggleRow", "Provider%value transportType encode(javascript)%Row", "Provider%value transportType encode(javascript)%Img");</script>