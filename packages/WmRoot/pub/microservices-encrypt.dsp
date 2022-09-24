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
	function validate(thisform,oper)
    {
		thisform.operation.value=oper;
		
		var dataValue = thisform.plainData.value;
		
		if(0 == dataValue.length)
            {
                alert("You must specify a valid value for the field : 'Value'")                
				thisform.plainData.focus();
                return false;
            }			
        return true;
    }
    
    function changeInputType(chkBox) {
        var oType = "password";
        if(chkBox.checked) {
            oType = "text";
        }
        var oldObject = document.getElementById("plainData");
        var newObject = document.createElement('input');
        newObject.type = oType;
        if(oldObject.size) newObject.size = oldObject.size;
        if(oldObject.value) newObject.value = oldObject.value;
        if(oldObject.name) newObject.name = oldObject.name;
        if(oldObject.id) newObject.id = oldObject.id;
        if(oldObject.className) newObject.className = oldObject.className;
        oldObject.parentNode.replaceChild(newObject,oldObject);
      return newObject;
    }
	
	function copyText(thisform,oper) {
	  thisform.operation.value=oper;
	  var copyText = document.getElementById("encryptedData");
	  var dataValue = copyText.value;
	  
		if(0 == dataValue.length)
		{
			alert("Invalid text for Encrypted Value");      
			thisform.plainData.focus();
			return false;
		}			
	  
	  copyText.select();
	  document.execCommand("Copy");
	  return true;
	}	
	
  </script>
     
    <body onLoad="setNavigation('settings-global-variables-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Microservices_EncryptedValue');">

    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> 
				Microservices &gt; Configuration Variables &gt; Generate Encrypted Configuration Variable
            </td>
        </tr>
         
        %ifvar operation equals('Encrypt')%
            %invoke wm.server.configurationvariables:encryptData%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        %ifvar operation equals('Copy')%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">Copied Encrypted Value to clipboard.</td></tr>
        %endif% 
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>
					createForm("htmlform_microservices_dynamic_variables", "microservices.dsp", "POST", "BODY");
					</script>
                    <li class="listitem">
					<script>getURL("microservices.dsp","javascript:document.htmlform_microservices_dynamic_variables.submit();","Return to Configuration Variables")</script>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <form name="htmlform_dvConfig" action="microservices-encrypt.dsp" method="POST">
            
                        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
						<input type="hidden" name="operation" >
                        <table class="tableView width40">
                            <tr>
                                <td class="heading" colspan="3">Encrypt Configuration Variable</td>
                            </tr>
							
                            <tr>
                                <td class="evenrow" >Value</td>
                                <td class="evenrow-l" >
								
									%ifvar displayPlainText equals('on')%
										<input type="text" size="40" name="plainData" id="plainData" value="%value plainData encode(htmlattr)%">
									%else%
										<input type="password" autocomplete="off" size="40" name="plainData" id="plainData" value="%value plainData encode(htmlattr)%"/>
									%endif% 
                                    <input type="checkbox" name="displayPlainText" id="displayPlainText" onclick="changeInputType(this)" %ifvar displayPlainText equals('on')%checked%endif%>Show Value
                                </td>
                            </tr>
                            <tr>
                                <td class="oddrow">Encrypted Value</td>   
                                <td class="oddrow-l">
									<input type="text" size="40" name="encryptedData" id="encryptedData" value="%value encryptedData encode(htmlattr)%" readonly="true">
                                </td>
                            </tr>
                            
                                    
                            <tr>
                                <td class="action" colspan=3>
									<input type="submit" name="submit" value="Encrypt" onclick="return validate(this.form,'Encrypt');">
									<input type="submit" name="submit" value="Copy" onclick="return copyText(this.form,'Copy');">
                                </td>
							</tr>	
            </form>
            </table>
            </td>
        </tr>
        
    </table>
    
  </body>   
</head>
