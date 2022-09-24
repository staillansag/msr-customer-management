
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="Expires" content="-1">
<script src="webMethods.js"></script>
  <script language="JavaScript">
  </script>
</head>

<body>
<script>
 function confirmDelete(ip) {
         return confirm("Are you sure you want to delete " + ip + " ?");
    }
</script>
    <table width="100%" class="tableView">
        <tr>
            <td colspan="2" class="heading">
               Denied IP Address List
            </td>
        </tr>
        <tr>
			<th scope="col" CLASS="oddcol-l" width="80%">
				IP address
			</th>
			<th scope="col" CLASS="oddcol" >
				Delete
			</th>
        </tr>
        %invoke wm.server.enterprisegateway:getDeniedIPList%
            %loop deniedIPList%
                <tr>
                    <td class="evencol-l" width="80%">
					  %value encode(html)%
                    </td>
                    <td class="evencol" >
					
					<script>
						    createForm("htmlform_http_enterprisegateway_dos_options", "enterprisegateway-dos-options.dsp", "POST", "BODY");
							setFormProperty("htmlform_http_enterprisegateway_dos_options", "action", "delete");
							setFormProperty("htmlform_http_enterprisegateway_dos_options", "IP", "%value encode(url)%");
							
           </script>			
		   
					  <script>
		        if(is_csrf_guard_enabled && needToInsertToken) {
		     	document.write('<a class="imagelink" href="javascript:document.htmlform_http_enterprisegateway_dos_options.submit();" onclick="return confirmDelete(\'%value encode(javascript)%\')"><img src="icons/delete.png" alt="Delete IP Address" border="none"></a>');
		       } else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
						document.write('<a class="imagelink" href="enterprisegateway-dos-options.dsp?action=delete&IP=%value encode(url)%&webMethods-wM-AdminUI=true" onclick="return confirmDelete(\'%value encode(javascript)%\')"><img src="icons/delete.png" alt="Delete IP Address" border="none"></a>');
					}
					else {
						document.write('<a class="imagelink" href="enterprisegateway-dos-options.dsp?action=delete&IP=%value encode(url)%" onclick="return confirmDelete(\'%value encode(javascript)%\')"><img src="icons/delete.png" alt="Delete IP Address" border="none"></a>');
					}
		       }
           </script>
                    </td>
                </tr>
            %end%
        %endinvoke%
            </table>
			
</body>
</html>