<HTML>
<HEAD>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT SRC="webMethods.js"></SCRIPT>

</HEAD>
<BODY onLoad="setNavigation('security-jwt-settings.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_JWTScrn');">
   
    <table width="100%">
    <tr>
        <td class="breadcrumb" colspan="2"> Security &gt; JWT </td>
    </tr>

	%ifvar operation equals('global_settings_edit')%
		%invoke wm.server.jwt:updateGlobalSettings%
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
		    
			<script>createForm("htmlform_jwt_trusted_issuers", "security-jwt-trusted-issuers.dsp", "POST", "body");</script>
            <li class="listitem">
			<script>getURL("security-jwt-trusted-issuers.dsp","javascript:document.htmlform_jwt_trusted_issuers.submit();","Trusted Issuers");</script></li>
			
			<script>createForm("htmlform_jwt_issuer_cert_mapping", "security-jwt-issuer-cert-mappings.dsp", "POST", "body");</script>
            <li class="listitem">
			<script>getURL("security-jwt-issuer-cert-mappings.dsp","javascript:document.htmlform_jwt_issuer_cert_mapping.submit();","Issuer Configuration");</script></li>
			
			<script>createForm("htmlform_jwt_global_settings", "security-jwt-global-settings-edit.dsp", "POST", "body");</script>
            <li class="listitem">
			<script>getURL("security-jwt-global-settings-edit.dsp","javascript:document.htmlform_jwt_global_settings.submit();","Edit Global Claim Settings");</script></li>
			
			
          </ul>
        </td>
      </tr>        

        <tr>
            <td>
                <table width="50%">
                    <tr>
                        <td>    
                            <table class="tableView" width="50%">
                                <tr>
                                    <td class="heading" colspan="2">Global Claim Settings</td>
                                </tr>
                              %invoke wm.server.jwt:getGlobalSettings%
							   
								  <TR>
									 <TD nowrap class="oddrow">Audience</TD>
									 %ifvar audience%
										<TD nowrap class="oddrowdata-l">%value audience%</TD>
									 %else%
										<TD nowrap class="oddrowdata-l"></TD>
									 %endif%
								  </TR>
								  
								  <TR>
									 <TD nowrap class="oddrow">Max Global Skew (in seconds)</TD>
									 %ifvar maxGlobalSkew%
										<TD nowrap class="oddrowdata-l">%value maxGlobalSkew%</TD>
									 %else%
										<TD nowrap class="oddrowdata-l">0</TD>
									 %endif%
								  </TR>
							  
							 %endinvoke%	
                            </table>
						</td>
					</tr>
                          
					<tr><td>&nbsp;<br>&nbsp;<br></td></tr>
					
                </table>
            </td>
        </tr>      
     </table>

</BODY>
</HTML>
