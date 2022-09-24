<html>
%invoke wm.server.security.certificate:getDetailedInfo%

<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
<script language="JavaScript">
    var mode = "%value operation encode(javascript)%";
    var user = "%value user empty=Default encode(javascript)%";

    function doSave()
    {
        document.info.action="security-certs.dsp";
        document.info.operation.value="update";
        document.info.oldUsage.value="%value oldUsage encode(javascript)%";
        document.info.submit();
        return;
    }

    function startup(nextPage, helpPage)
    {
        document.info.oldUsage.value="%value usage encode(javascript)%";
        setNavigation(nextPage, helpPage);
    }

    %comment%
        function setupData() removed as part of LDAP enhancements.
    %end%
</script>
</head>
%ifvar operation equals('edit')%
   <BODY onLoad="startup('security-certificates.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ClientCertifUserMappingScrn');">
%else%
   <BODY onLoad="startup('security-certificates.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_ClientCertifDetailsScrn');">
%endif%

<TABLE width="100%">
      <TR>
          <TD class="breadcrumb" colspan=2>
      Security &gt;
      Certificates &gt;
      Client Certificates &gt;
            Details
            %ifvar equals('edit') operation%
             &gt; Mapping
            %end if%
          </TD>
        </TR>
        <TR>
          <TD colspan=2>
            <UL>
			   <script>
				       createForm("htmlform_http_security_certs", "security-certs.dsp", "POST", "BODY");
               </script>
			   
			   <script>
				       createForm("htmlform_http_cert_detailed", "cert-detailed.dsp", "POST", "BODY");
					   setFormProperty("htmlform_http_cert_detailed", "action", "cert-detailed.dsp");
					   setFormProperty("htmlform_http_cert_detailed", "issuer", "%value issuer%")
					   setFormProperty("htmlform_http_cert_detailed", "serialNum", "%value serialNum%");
					   setFormProperty("htmlform_http_cert_detailed", "oldUsage", "%value usage%");
					   setFormProperty("htmlform_http_cert_detailed", "usage", "%value usage%");
					   setFormProperty("htmlform_http_cert_detailed", "operation", "edit");
				</script>
				
				<script>
				       createForm("htmlform_http_cert_detailed2", "cert-detailed.dsp", "POST", "BODY");
					   setFormProperty("htmlform_http_cert_detailed2", "action", "cert-detailed.dsp");
					   setFormProperty("htmlform_http_cert_detailed2", "issuer", "%value issuer%");
					   setFormProperty("htmlform_http_cert_detailed2", "serialNum", "%value serialNum%");
					   setFormProperty("htmlform_http_cert_detailed2", "oldUsage", "%value usage%");
					   setFormProperty("htmlform_http_cert_detailed2", "usage", "%value usage%");
					   setFormProperty("htmlform_http_cert_detailed2", "operation", "getDetailed");
				</script>
			   
			
                %ifvar operation equals('getDetailed')%
                <li>
				<script>getURL("security-certs.dsp", "javascript:document.htmlform_http_security_certs.submit();", "Return to Client Certificates");</script>
				
				</li>
                <li>
				<script>getURL("cert-detailed.dsp?action=cert-detailed.dsp&issuer=%value issuer encode(url)%&serialNum=%value serialNum encode(url)%&oldUsage=%value usage encode(url)%&usage=%value usage encode(url)%&operation=edit", "javascript:document.htmlform_http_cert_detailed.submit();", "Change Mapping");</script>
				</li>
                %end if%
                %ifvar operation equals('edit')%
                <li>
				<script>getURL("cert-detailed.dsp?action=cert-detailed.dsp&issuer=%value issuer encode(url)%&serialNum=%value serialNum encode(url)%&oldUsage=%value usage encode(url)%&usage=%value usage encode(url)%&operation=getDetailed", "javascript:document.htmlform_http_cert_detailed2.submit();", "Return to Details");</script>
				</LI>
                %end if%
            </UL>
          </TD>
        </TR>
        <TR>
          <TD>
            <table class="tableView" width="30%">
                <form name="info" method="post">
                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                <input type="hidden" name="issuer" value="%value issuer encode(htmlattr)%">
                <input type="hidden" name="serialNum" value="%value serialNum encode(htmlattr)%">
                <input type="hidden" name="operation" value="%value operation encode(htmlattr)%">
                <input type="hidden" name="oldUsage" value="%value oldUsage encode(htmlattr)%">

            <tr>
                <td class="heading" colspan="2">Mapping Information</td>
            </tr>

            <!--  RUN AS USER SUB CHANGES-->
            <SCRIPT>
                  function callback(val){
                        document.info.user.value=val;
                  }
            </SCRIPT>

            <tr>
				<td class="evenrow-l"><label for="user">User</label></td>
                %ifvar operation equals('edit')%
                <td class="evenrowdata-l" style="border-left: none;">
                    <!--  RUN AS USER SUB CHANGES START-->
					<input name="user" id="user"size=12 value="%value user encode(htmlattr)%"></input>
                    <link rel="stylesheet" type="text/css" href="subUserLookup.css" />
                    <script type="text/javascript" src="subUserLookup.js"></script>
					<a class="submodal" href="subUserLookup"><img border=0 align="bottom" alt="Select User" src="icons/magnifyglass.png"/></a> 
                    <!--  RUN AS USER SUB END-->
                </td>
                %else%
                <td class="evenrowdata-l">%value user encode(html)%</td>
                %endif%
            </tr>

            <TR>
				<TD class="oddrow-l"><label for="usage">Usage</label></td>
                %ifvar operation equals('edit')%
                <TD class="oddrowdata-l">
					<SELECT name="usage" id="usage"WIDTH=150>
                        <OPTION VALUE="SSL Authentication" %ifvar usage equals('SSL Authentication')% SELECTED %endif%>
                            SSL Authentication </OPTION>
                        <OPTION VALUE="Verify" %ifvar usage equals('Verify')% SELECTED %endif%>
                            Verify </OPTION>
                        <OPTION VALUE="Encrypt" %ifvar usage equals('Encrypt')% SELECTED %endif%>
                            Encrypt </OPTION>
                        <OPTION VALUE="Verify and Encrypt" %ifvar usage equals('Verify and Encrypt')% SELECTED %endif%>
                            Verify and Encrypt </OPTION>
                        <OPTION VALUE="Message Authentication" %ifvar usage equals('Message Authentication')% SELECTED %endif%>
                            Message Authentication </OPTION>
                    </SELECT>
                </TD>
                %else%
                %switch usage%
                    %case 'SSL Authentication'%<TD class="oddrowdata-l">SSL Authentication</TD>
                    %case 'Verify'%<TD class="oddrowdata-l">Verify</TD>
                    %case 'Encrypt'%<TD class="oddrowdata-l">Encrypt</TD>
                    %case 'Verify and Encrypt'%<TD class="oddrowdata-l">Verify and Encrypt</TD>
                    %case 'Message Authentication'%<TD class="oddrowdata-l">Message Authentication</TD>
                %endswitch%
                %endif%
            </TR>
            <tr>
                <td class="heading" colspan="2">Detailed Certificate Information</td>
            </tr>
        %scope info%
            <tr>
                <td class="evenrow">Version</td>
                <td class="evenrowdata-l">%value version encode(html)%</td>
            </tr>
            <tr>
                <td class="oddrow">Serial Number</td>
                <td class="oddrowdata-l">%value serialNumber encode(html)%</td>
            </tr>
            <tr>
                <td class="evenrow">Issuer</td>
                <td class="evenrowdata-l" style="padding: 0px;">
                    <table class="tableInline" cellspacing="1px" width="100%">
                        %loop -struct issuer%
                        <tr>
                            <td>%value $key encode(html)%</td>
                            <td class="evenrowdata-l">%value encode(html)%</td>
                        </tr>
                        %endloop%
                    </table>
                </td>
            </tr>
            <tr>
                <td class="oddrow">Valid Not Before</td>
                <td class="oddrowdata-l">%value validity/notBefore encode(html)%</td>
            </tr>
            <tr>
                <td class="evenrow">Valid Not After</td>
                <td class="evenrowdata-l">%value validity/notAfter encode(html)%</td>
            </tr>
            <tr>
                <td class="oddrow">Public Key Algorithm</td>
                <td class="oddrowdata-l">%value subjectPublicKeyAlgorithm encode(html)%</td>
            </tr>

            <tr>
                <td class="evenrow">Subject</td>
                <td class="evenrowdata-l" style="padding: 0px;">
                    <table class="tableInline" cellspacing="1px" width="100%">
                        %loop -struct subject%
                        <tr>
                            <td>%value $key encode(html)%</td>
                            <td class="evenrowdata-l">%value encode(html)%</td>
                        </tr>
                        %endloop%
                    </table>
                </td>
            </tr>
        %endscope%
                    %ifvar operation equals('edit')%
            <tr>
                <td class="action" colspan=2>
                    <input type=button onClick="doSave();" value="Save Changes">
                </td>
            </tr>
                    %endif%
        </form>
        </table>
</td>
</tr>
</table>
</body>
%endinvoke%
</html>
