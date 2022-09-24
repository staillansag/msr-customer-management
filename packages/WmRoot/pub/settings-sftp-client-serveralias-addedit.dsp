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
  <style>
	.listbox  { width: 100%; }
	.arrow {
		font-size: 1.4em;
		font-weight: bold;
		text-align: center;
		width: 100%;
	}
	.emailDiv {
		width: 200px;
		word-wrap: break-word;
	}
  </style>
  <script language="JavaScript">
    // functions for double list
	var isDirty = false;
	var dcVersion='';
	var dcAlias='';
	var dcHost='';
	var dcPort='';
	var dcProxy='';
	var dcHostKeyLoc='';
	var dcKEX='';
	var dcMACSC='';
	var dcMACCS='';
	var dcCipherCS='';
	var dcCiphersSC=''
	var dcMAXDH='';
	var dcMINDH='';
	
	function setDirty() {
		isDirty = true;
		dcVersion=document.htmlform_saConfig.version.value;
		dcAlias=document.htmlform_saConfig.alias.value;
		dcHost=document.htmlform_saConfig.hostName.value;
		dcPort=document.htmlform_saConfig.port.value;
		dcProxy=document.htmlform_saConfig.proxyAlias.options[htmlform_saConfig.proxyAlias.selectedIndex].value;
		dcHostKeyLoc=document.htmlform_saConfig.hostKeyLocation.value;
		dcKEX=getValueFromDropDown(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel);
		dcMACSC=getValueFromDropDown(document.htmlform_saConfig.preferredMACAlgorithmS2CSel);
		dcMACCS=getValueFromDropDown(document.htmlform_saConfig.preferredMACAlgorithmC2SSel);
		dcCipherCS=getValueFromDropDown(document.htmlform_saConfig.preferredCiphersC2SSel);
		dcCiphersSC=getValueFromDropDown(document.htmlform_saConfig.preferredCiphersS2CSel);
		dcMAXDH=document.htmlform_saConfig.maxDHKeySize.value;
		dcMINDH=document.htmlform_saConfig.minDHKeySize.value;
	}
	
	function updatePage(srcForm, destForm) {
		destForm.version.value = srcForm.version.value;
		destForm.alias.value = srcForm.alias.value;
		destForm.hostName.value = srcForm.hostName.value;
		destForm.port.value = srcForm.port.value;
		destForm.proxyAlias.value = srcForm.proxyAlias.value;
		destForm.minDHKeySize.value = srcForm.minDHKeySize.value;
		destForm.maxDHKeySize.value = srcForm.maxDHKeySize.value;
		destForm.submit();
	}
	
	function populateOptions(sList, s, rList, r) {
		var selectedOptions = s.split(",");
		var remainingOptions = r.split(",");
			
		if(s.length > 0 && selectedOptions.length > 0 ) {
			sList.options.length = 0;
			for(var i = 0; i < selectedOptions.length; i++) {
				var newOption = document.createElement("option");
				newOption.text = selectedOptions[i];
				newOption.value = selectedOptions[i];
				sList.add(newOption);
			}
		}
		if(r.length > 0 && remainingOptions.length > 0 ) {
			rList.options.length = 0;
			for(var i = 0; i < remainingOptions.length; i++) {
				if(!isPresentInSelectedOptions(selectedOptions, remainingOptions[i])) {
					var newOption = document.createElement("option");
					newOption.text = remainingOptions[i];
					newOption.value = remainingOptions[i];
					rList.add(newOption);
				}
			}
			addDummyToSource(rList);
		}
	}
	
	function isPresentInSelectedOptions(selectedOptions, str) {
		var found = false;
		if( selectedOptions.length > 0 ) {
			for(var i = 0; i < selectedOptions.length; i++) {
				if(str == selectedOptions[i] && !found) {
					found = true;
				}
			}
		}
		return found;
	}
	function moveToRight(lList, rList) {
		removeDummyFromDest(lList, rList);
		moveFromSourceToDest(lList, rList);
		addDummyToSource(lList);
	}
	function moveToLeft(lList, rList) {
		removeDummyFromDest(rList, lList);
		moveFromSourceToDest(rList, lList);
		addDummyToSource(rList);
	}
	function moveFromSourceToDest(fromlist, tolist) {
		var len = fromlist.length
		var selectedOptions = [];
		var j=0;
		for (var i = 0; i < fromlist.length; i++) {
			if (fromlist.options[i].selected) {
				if(fromlist.options[i].value != 'dummyOption' && (fromlist.options[i].text == fromlist.options[i].value)) {
					selectedOptions[j] = fromlist.options[i];
					var newOption = document.createElement("option");
					newOption.text = fromlist.options[i].text;
					newOption.value = fromlist.options[i].value;
					tolist.add(newOption);
					j++;
				}
			}
		}
		for(var i=0; i < selectedOptions.length; i++) {
			fromlist.removeChild(selectedOptions[i]);
		}
	}
	function removeDummyFromDest(fromlist, tolist) {
		var fromlen = fromlist.length
		var doNeedToRemove = false;
		for (var i = 0; i < fromlist.length; i++) {
			if (fromlist.options[i].selected) {
				if(fromlist.options[i].value != 'dummyOption' && (fromlist.options[i].text == fromlist.options[i].value)) {
					doNeedToRemove = true;
				}
			}
		}
		if(doNeedToRemove) {
		var len = tolist.options.length;
		if(len == 1) {
			if(tolist.options[0].value == 'dummyOption' && (tolist.options[0].text != tolist.options[0].value)) {
				tolist.removeChild(tolist.options[0]);
			}
		}
	}
	}
	function addDummyToSource(fromlist) {
		var len = fromlist.options.length;
		if(len == 0) {
			var newOption = document.createElement("option");
			newOption.text = '-----none-----';
			newOption.value = 'dummyOption';
			fromlist.add(newOption);
		}
	}
	
	function arrayToString(ary) {
		alert(ary);
	}
	
    // end 	-- functions for double list
	
    function validate( oper)
    {

        if(oper == 'edit')
        {
			if(checkIfDirty()) {
				return false;
			}
			var host = trimStr(document.htmlform_saConfig.hostName.value);
            document.htmlform_saConfig.hostName.value = host;
            var port = trimStr(document.htmlform_saConfig.port.value);
            document.htmlform_saConfig.port.value = port;
            if(0 == host.length)
            {
                alert("You must specify a valid value for the field : 'hostName'")
                document.htmlform_saConfig.hostName.focus();
                return false;
            } 
            if(!validatePort(port))
            {
                alert("You must specify a valid value for the field : 'port'")
                document.htmlform_saConfig.port.focus();
                return false;
            }
			
			if(!validateDHKeys(document.htmlform_saConfig.minDHKeySize, document.htmlform_saConfig.maxDHKeySize))
            {
                return false;
            }
						
		
			setValueFromDropDown(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel, document.htmlform_saConfig.preferredKeyExchangeAlgorithm);
			setValueFromDropDown(document.htmlform_saConfig.preferredMACAlgorithmS2CSel, document.htmlform_saConfig.preferredMACS2C);
			setValueFromDropDown(document.htmlform_saConfig.preferredMACAlgorithmC2SSel, document.htmlform_saConfig.preferredMACC2S);
			setValueFromDropDown(document.htmlform_saConfig.preferredCiphersS2CSel, document.htmlform_saConfig.preferredCiphersS2C);
			setValueFromDropDown(document.htmlform_saConfig.preferredCiphersC2SSel, document.htmlform_saConfig.preferredCiphersC2S);

            document.htmlform_saConfig.operation.value= 'edit';
			var inputs = document.htmlform_saConfig.version;
			for (var i = 0, len = inputs.length; i<len; i++){
				inputs[i].disabled = false;
			}
			document.htmlform_saConfig.version.disabled = false;
        }
        else
        {
            var svrAlias = trimStr(document.htmlform_saConfig.alias.value);
            document.htmlform_saConfig.alias.value = svrAlias;
            var host = trimStr(document.htmlform_saConfig.hostName.value);
            document.htmlform_saConfig.hostName.value = host;
            var port = trimStr(document.htmlform_saConfig.port.value);
            document.htmlform_saConfig.port.value = port;
			try {
				var hostkeyloc = trimStr(document.htmlform_saConfig.hostKeyLocation.value);
				document.htmlform_saConfig.hostKeyLocation.value = hostkeyloc;
			} catch (e) {}
            if(0 == svrAlias.length)
            {
                alert("You must specify a valid value for the field : 'alias'")
                document.htmlform_saConfig.alias.focus();
                return false;
            } 
            if(0 == host.length)
            {
                alert("You must specify a valid value for the field : 'hostName'")
                document.htmlform_saConfig.hostName.focus();
                return false;
            } 
            if(!validatePort(port))
            {
                alert("You must specify a valid value for the field : 'port'")
                document.htmlform_saConfig.port.focus();
                return false;
            } 
            if(0 == hostkeyloc.length)
            {
                alert("You must specify a valid value for the field : 'hostKeyLocation'")
                document.htmlform_saConfig.hostKeyLocation.focus();
                return false;
            } 
			if(checkIfDirty()) {
				return false;
			}
			if(!validateDHKeys(document.htmlform_saConfig.minDHKeySize, document.htmlform_saConfig.maxDHKeySize))
            {
                return false;
            }

			setValueFromDropDown(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel, document.htmlform_saConfig.preferredKeyExchangeAlgorithm);
			setValueFromDropDown(document.htmlform_saConfig.preferredMACAlgorithmS2CSel, document.htmlform_saConfig.preferredMACS2C);
			setValueFromDropDown(document.htmlform_saConfig.preferredMACAlgorithmC2SSel, document.htmlform_saConfig.preferredMACC2S);
			setValueFromDropDown(document.htmlform_saConfig.preferredCiphersS2CSel, document.htmlform_saConfig.preferredCiphersS2C);
			setValueFromDropDown(document.htmlform_saConfig.preferredCiphersC2SSel, document.htmlform_saConfig.preferredCiphersC2S);

            document.htmlform_saConfig.operation.value= 'add';
        }
        return true;
    }
    
	function validateDHKeys(minF, maxF) {
		var minD = trimStr(minF.value);
		minF.value = minD;
		var maxD = trimStr(maxF.value);
		maxF.value = maxD;
		minD = parseInt(minD);
		maxD = parseInt(maxD);
		if(0 < minD.length) {
			if(isNaN(minD) || minD < 1024) {
				alert("You must specify a valid value for the field 'Min DH Key Size', the value specified  must be greater than or equal to 1024.");
				minF.focus();
				return false;
			}
		}
		if(0 < maxD.length) {
			if(isNaN(maxD)) {
				alert("You must specify a valid value for the field 'Max DH Key Size'.");
				maxF.focus();
				return false;
			}
		}
		if(minD.length > 0 && maxD.length > 0 && minD >= maxD) {
			alert("The value specified for field 'Max DH Key Size' must be greater than the value specified for field 'Min DH Key Size'.");
			minF.focus();
			return false;
		}
		return true;
	}
	
    function validatePort(port){
        if((0 == port.length) || (isNaN(port)) || (0 > port) || (65535 < port))
            return false;
        return true;
    }
    function trimStr(str) {
      return str.replace(/^\s+|\s+$/g, '');
    }
     
    function populateForm(destForm, srcForm, oper)
    {
        destForm.operation.value = oper;
        destForm.user_action.value = 'gethostkey';
        destForm.alias.value = srcForm.alias.value;
        destForm.hostName.value = srcForm.hostName.value;
        destForm.port.value = srcForm.port.value;
		destForm.minDHKeySize.value = srcForm.minDHKeySize.value;
		destForm.maxDHKeySize.value = srcForm.maxDHKeySize.value;
		srcForm.version.disabled = false;
		destForm.version.value = srcForm.version.value;
		srcForm.version.disabled = true;
		var host = trimStr(destForm.hostName.value);
		destForm.hostName.value = host;
		var port = trimStr(destForm.port.value);
		destForm.port.value = port;
		
		if(0 == host.length)
        {
			alert("You must specify a valid value for the field : 'hostName'")
			srcForm.hostName.focus();
			return false;
		} 
		if(!validatePort(port))
		{
			alert("You must specify a valid value for the field : 'port'")
			srcForm.port.focus();
			return false;
		}
		if(!validateDHKeys(destForm.minDHKeySize, destForm.maxDHKeySize))
		{
			return false;
		}
		
		setValueFromDropDown(srcForm.preferredKeyExchangeAlgorithmSel, destForm.preferredKeyExchangeAlgorithm);
		setValueFromDropDown(srcForm.preferredMACAlgorithmS2CSel, destForm.preferredMACS2C);
		setValueFromDropDown(srcForm.preferredMACAlgorithmC2SSel, destForm.preferredMACC2S);
		setValueFromDropDown(srcForm.preferredCiphersS2CSel, destForm.preferredCiphersS2C);
		setValueFromDropDown(srcForm.preferredCiphersC2SSel, destForm.preferredCiphersC2S);
		
		destForm.proxyAlias.value = srcForm.proxyAlias.options[srcForm.proxyAlias.selectedIndex].value;
		try {
			destForm.hostKeyLocation.value = srcForm.hostKeyLocation.value;
		} catch(e) {}	
        if('edit' == oper){
            destForm.fingerprint.value = srcForm.fingerprint.value;
        }
        destForm.submit();
    }
	
	function setValueFromDropDown(src, dest) {
		var sep = "";
		var newOrderText = "";
		for (i = 0; i <= src.options.length-1; i++) {  
			if(src.options[i].value != 'dummyOption') {
				newOrderText += "" + sep + src.options[i].value;
				sep = ",";
			}
		}
		dest.value = newOrderText;
	}
	
	function getValueFromDropDown(src) {
		var sep = "";
		var newOrderText = "";
		for (i = 0; i <= src.options.length-1; i++) {  
			if(src.options[i].value != 'dummyOption') {
				newOrderText += "" + sep + src.options[i].value;
				sep = ",";
			}
		}
		return newOrderText;
	}
	
	function setSelection(selectID , value) {
        var selectO = document.getElementById(selectID);
        for (var i = 0; i < selectO.options.length; i++) {   
           if(value == selectO.options[i].value) {
             selectO.options[i].selected = true;    
           }
        }
    }
	
	function move(formO,selectO,to) {
		var index = selectO.selectedIndex;
		var selectLength  = selectO.length - 1;
		if (index == -1) return false;
		if(to == +1 && index == selectLength) {
		   return false;
		} else if(to == -1 && index == 0) {
		   return false;
		}
		swap(index,index+to,formO,selectO);
		selectO.options[index].selected = false;    
		selectO.options[index+to].selected = true; 
		return true;
    }
    
    function swap(fIndex,sIndex,formO,selectO) {
        fText  = selectO.options[fIndex].text;
        fValue = selectO.options[fIndex].value;
        selectO.options[fIndex].text  = selectO.options[sIndex].text;
        selectO.options[fIndex].value = selectO.options[sIndex].value;  
        selectO.options[sIndex].text = fText;
        selectO.options[sIndex].value = fValue;   
    }
	
	function updateSFTPClientVersion(srcForm, destForm) {
		destForm.version.value = srcForm.version.value;
		destForm.alias.value = srcForm.alias.value;
		destForm.hostName.value = srcForm.hostName.value;
		destForm.port.value = srcForm.port.value;
		destForm.proxyAlias.value = srcForm.proxyAlias.value;
		destForm.minDHKeySize.value = srcForm.minDHKeySize.value;
		destForm.maxDHKeySize.value = srcForm.maxDHKeySize.value;
		destForm.submit();
	}

    function checkIfDirty() {
		if(isDirty) {
			if(dcVersion != document.htmlform_saConfig.version.value) {
				alert("Value of 'SFTP Client Version' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.version.focus();
				return true;
			}
			if(dcAlias != document.htmlform_saConfig.alias.value) {
				alert("Value of 'Alias' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.alias.focus();
				return true;
			}
			if(dcHost != document.htmlform_saConfig.hostName.value) {
				alert("Value of 'Host Name or IP Address' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.hostName.focus();
				return true;
			}
			if(dcPort != document.htmlform_saConfig.port.value) {
				alert("Value of 'Port Number' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.port.focus();
				return true;
			}
			if(dcProxy != document.htmlform_saConfig.proxyAlias.options[htmlform_saConfig.proxyAlias.selectedIndex].value) {
				alert("Value of 'Proxy Alias' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.proxyAlias.focus();
				return true;
			}
			if(dcHostKeyLoc != document.htmlform_saConfig.hostKeyLocation.value) {
				alert("Value of 'Host Key Location' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.hostKeyLocation.focus();
				return true;
			}
			if(dcKEX != getValueFromDropDown(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel)) {
				alert("Value of 'Preferred Key Exchange Algorithms' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel.focus();
				return true;
			}	
			if(dcMACSC != getValueFromDropDown(document.htmlform_saConfig.preferredMACAlgorithmS2CSel)) {
				alert("Value of 'Preferred MAC Algorithms S2C' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.preferredMACAlgorithmS2CSel.focus();
				return true;
			}
			if(dcMACCS != getValueFromDropDown(document.htmlform_saConfig.preferredMACAlgorithmC2SSel)) {
				alert("Value of 'Preferred MAC Algorithms C2S' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.preferredMACAlgorithmC2SSel.focus();
				return true;
			}	
			if(dcCipherCS != getValueFromDropDown(document.htmlform_saConfig.preferredCiphersC2SSel)) {
				alert("Value of 'Preferred Ciphers C2S' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.preferredCiphersC2SSel.focus();
				return true;
			}	
			if(dcCiphersSC != getValueFromDropDown(document.htmlform_saConfig.preferredCiphersS2CSel)) {
				alert("Value of 'Preferred Ciphers S2C' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.preferredCiphersS2CSel.focus();
				return true;
			}
			if(dcMAXDH != document.htmlform_saConfig.maxDHKeySize.value) {
				alert("Value of 'Max DH Key Size' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.maxDHKeySize.focus();
				return true;
			}	
			if(dcMINDH != document.htmlform_saConfig.minDHKeySize.value) {
				alert("Value of 'Min DH Key Size' field modified after getting host key. Before you save, get host key again.");
				document.htmlform_saConfig.minDHKeySize.focus();
				return true;
			}	
		}
		return false;
	}	
  </script>
 </head>
  %ifvar operation equals('edit')%
    <body onLoad="setNavigation('settings-sftp-client-server-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SFTP_ServerAliasSettings_Edit');">
  %else%
    <body onLoad="setNavigation('settings-sftp-client-server-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_SFTP_ServerAliasSettings_Create');">
  %endif%
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> 
				Settings &gt; SFTP &gt; %ifvar operation equals('edit')%%value alias encode(html)%&nbsp;&gt;&nbsp;Edit%else%Create Server Alias%endif%
            </td>
        </tr>
        %ifvar user_action equals('gethostkey')%
            %invoke wm.server.sftpclient:getServerHostKey%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %else%
            %ifvar operation equals('edit')%
                %invoke wm.server.sftpclient:getServerAliasInfo%
                    %ifvar message%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                    %endif%
                    %onerror%
                        <tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
                    %endinvoke%
            %endif% 
        %endif%
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>
					createForm("htmlform_settings_sftp_client", "settings-sftp-client.dsp", "POST", "BODY");
					</script>
                    <li class="listitem">
					<script>getURL("settings-sftp-client.dsp", "javascript:document.htmlform_settings_sftp_client.submit();", "Return to SFTP");</script>
					
					</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <form name="htmlform_saConfig" action="settings-sftp-client.dsp" method="POST">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
			<input type="hidden" name="operation" value="%value operation encode(htmlattr)%">
			<input type="hidden" name="user_action" value="%value user_action encode(htmlattr)%">
			<input type="hidden" name="preferredKeyExchangeAlgorithm" id="preferredKeyExchangeAlgorithm">
			<input type="hidden" name="preferredMACS2C" id="preferredMACS2C">
			<input type="hidden" name="preferredMACC2S" id="preferredMACC2S">
			<input type="hidden" name="preferredCiphersS2C" id="preferredCiphersS2C">
			<input type="hidden" name="preferredCiphersC2S" id="preferredCiphersC2S">
            <table width="50%" class="tableView">
				<tr>
					<td class="heading" colspan="2">SFTP Server Alias Properties</td>
				</tr>
				<tr>
					<td class="oddrow" width="30%">SFTP Client Version</td>   
					<td class="oddrow-l" width="70%">
					%ifvar operation equals('add')%
						<input type="radio" id="version" name="version" value="v1" checked onclick="updatePage(document.htmlform_saConfig, document.htmlform_setVersion);"> Version 1&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id="version" name="version" value="v2" %ifvar version equals('v2')% checked %endif% onclick="updatePage(document.htmlform_saConfig, document.htmlform_setVersion);"> Version 2
					%endif% 
					%ifvar operation equals('edit')%
						<input type="radio" id="version" name="version" value="v1" %ifvar version equals('v1')% checked %endif% disabled> Version 1&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id="version" name="version" value="v2" %ifvar version equals('v2')% checked %endif% disabled> Version 2
					%endif%
					</td>
				</tr>
				<tr>
					<td class="oddrow" width="30%"><label for="alias">Alias</label></td>   
					<td class="oddrow-l" width="70%">
						%ifvar operation equals('add')%
							<input type="text" size="50" name="alias" id="alias" %ifvar user_action equals('gethostkey')% value="%value alias encode(htmlattr)%" %endif%>
						%endif% 
						%ifvar operation equals('edit')%
							<input type="text" size="50" name="alias" id="alias" value="%value alias encode(htmlattr)%" readonly="true" style="color:#808080;">
						%endif%
						
					</td>
				</tr>
				<tr>
					<td class="evenrow" width="30%"><label for="hostName">Host Name or IP Address</label></td>
					<td class="evenrow-l" width="70%">
						%ifvar operation equals('add')%
							<input type="text" size="50" name="hostName" id="hostName" %ifvar user_action equals('gethostkey')% value="%value hostName encode(htmlattr)%" %endif%>
						%endif% 
						%ifvar operation equals('edit')%
							<input type="text" size="50" name="hostName" id="hostName" value="%value hostName encode(htmlattr)%">
						%endif%
					</td>
				</tr>
				<tr>
					<td class="oddrow" width="30%"><label for="port">Port Number</label></td> 
					<td class="oddrow-l" width="70%">
						%ifvar operation equals('add')%
							<input type="text" size="5" maxlength="5" name="port" id="port" %ifvar user_action equals('gethostkey')% value="%value port encode(htmlattr)%" %endif%>
						%endif% 
						%ifvar operation equals('edit')%
							<input type="text" size="5" maxlength="5" name="port" id="port" value="%value port encode(htmlattr)%" >	
						%endif%
					</td>
				</tr>
				<tr>
					<td class="oddrow" width="30%">Proxy Alias</td>
					<td class="oddrow-l" width="70%">
						%ifvar operation equals('add')%
							<select name="proxyAlias" id="proxyAlias" >
								<option value="" ></option>
								%invoke wm.server.proxy:listProxyAliasNames%
									%loop proxyAliases%
										<option value="%value%">%value%</option>
									%endloop%    
								%endinvoke%    
							</select>
							%ifvar proxyAlias%
								<script>setSelection('proxyAlias','%value proxyAlias%');</script>
							%endif%
							
						%endif%    
						%ifvar operation equals('edit')%
							<select name="proxyAlias" id="proxyAlias" >
								<option value=""></option>
								%invoke wm.server.proxy:listProxyAliasNames%
									%loop proxyAliases%
										<option value="%value%">%value%</option>
									%endloop%    
								%endinvoke%    
								
							</select>
							<script>setSelection('proxyAlias','%value proxyAlias%');</script>
						%endif%
						
					</td>
				</tr>
				%ifvar fingerprint -notempty%
				<tr>
					<td class="evenrow" width="30%">Host Key Fingerprint</td>
					<td class="evenrow-l" width="70%">
						<input type="text" size="50" name="fingerprint" id="fingerprint" value="%value fingerprint encode(htmlattr)%" disabled>
					</td>
				</tr>
				%endif%
				<tr>
					<td class="evenrow" width="30%">Host Key Location</td>
					<td class="evenrow-l" width="70%">
						<input type="text" size="50" name="hostKeyLocation" id="hostKeyLocation" %ifvar hostKeyLocation -notempty%value="%value hostKeyLocation encode(htmlattr)%"%endif%>&nbsp;&nbsp;
						<input type="button" name="getHostKeyLocation" id="getHostKeyLocation" value="Get Host Key" onclick="populateForm(document.htmlform_gethostkey, document.htmlform_saConfig, '%value operation encode(javascript)%')">
					</td>
				</tr>
			</table>
			<table width="50%" class="tableView">		 
				<tr>
					<td class="heading" colspan="2">SFTP Server Alias Advanced Settings (Optional)</td>
				</tr>
				
				<tr %ifvar version equals('v2')%%else%style="display:none;"%endif%>
					<td class="oddrow" width="30%">Min DH Key Size</td>   
					<td class="oddrow-l" width="70%">
						<input type="text" size="50" name="minDHKeySize" id="minDHKeySize" %ifvar minDHKeySize% value="%value minDHKeySize%" %else% value="1024" %endif%>
					</td>
				</tr>	
				<tr %ifvar version equals('v2')%%else%style="display:none;"%endif%>
					<td class="oddrow" width="30%">Max DH Key Size</td>   
					<td class="oddrow-l" width="70%">
						<input type="text" size="50" name="maxDHKeySize" id="maxDHKeySize" %ifvar maxDHKeySize% value="%value maxDHKeySize%" %else% value="8192" %endif%>
					</td>
				</tr>
				<tr>
					<td colspan="2">				
						<table width="100%" >
							<tr>
								<td width="47%" class="grouping-positive" valign="top" align="center">
									Preferred Key Exchange Algorithms<br>
									<select class="listbox"  size="7" id="preferredKeyExchangeAlgorithmSel" name="preferredKeyExchangeAlgorithmSel" multiple>
									<option value="dummyOption">-----none-----</option>
									</select>
								</td>
								<td  width="6%" valign="center" align="center">
									<input type="button" style="width: 50px" value="&#8593" onClick="move(this.form,document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel,-1)" class="widebuttons arrow"><br>
									<input type="button" style="width: 50px" value="&#8595" onClick="move(this.form,document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel,+1)" class="widebuttons arrow"><br>
									<input onclick="moveToRight(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel, document.htmlform_saConfig.excludedKeyExchangeAlgorithmSel);" type="button" value="&#8594" name="moveRight1" class="widebuttons arrow"><br>
									<input onclick="moveToLeft(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel, document.htmlform_saConfig.excludedKeyExchangeAlgorithmSel);" type="button" value="&#8592" name="moveLeft1" class="widebuttons arrow">
								</td>

								<td width="47%" class="grouping-neutral" valign="top" align="center">
									Excluded Key Exchange Algorithms<br>
									<select class="listbox" id="excludedKeyExchangeAlgorithmSel" size="7" name="excludedKeyExchangeAlgorithmSel" multiple>
									<option value="dummyOption">------none------</option>
									</select>
								</td>
							</tr>
							%invoke wm.server.sftpclient:listKeyExchangeAlgorithms%
								%ifvar operation equals('edit')%
									<script>
										populateOptions(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel, '%value preferredKeyExchangeAlgorithm%', document.htmlform_saConfig.excludedKeyExchangeAlgorithmSel, '%value keyExchangeAlgorithmsStr%');
									</script>
								%else%
									%ifvar user_action equals('gethostkey')%
										<script>
											populateOptions(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel, '%value preferredKeyExchangeAlgorithm%', document.htmlform_saConfig.excludedKeyExchangeAlgorithmSel, '%value keyExchangeAlgorithmsStr%');
										</script>
									%else%
										<script>
											populateOptions(document.htmlform_saConfig.preferredKeyExchangeAlgorithmSel, '%value keyExchangeAlgorithmsStr%', document.htmlform_saConfig.excludedKeyExchangeAlgorithmSel, '');
										</script>
									%endif%
								%endif%	
							%endinvoke%
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">				
						<table width="100%" >
							<tr>
								<td width="47%" class="grouping-positive" valign="top" align="center">
									Preferred MAC Algorithms S2C<br>
									<select class="listbox"  size="7" id="preferredMACAlgorithmS2CSel" name="preferredMACAlgorithmS2CSel" multiple>
									<option value="dummyOption">-----none-----</option>
									</select>
								</td>
								<td  width="6%" valign="center" align="center">
									<input type="button" style="width: 50px" value="&#8593" onClick="move(this.form,document.htmlform_saConfig.preferredMACAlgorithmS2CSel,-1)" class="widebuttons arrow"><br>
									<input type="button" style="width: 50px" value="&#8595" onClick="move(this.form,document.htmlform_saConfig.preferredMACAlgorithmS2CSel,+1)" class="widebuttons arrow"><br>
									<input onclick="moveToRight(document.htmlform_saConfig.preferredMACAlgorithmS2CSel, document.htmlform_saConfig.excludedMACAlgorithmS2CSel);" type="button" value="&#8594" name="moveRight1" class="widebuttons arrow"><br>
									<input onclick="moveToLeft(document.htmlform_saConfig.preferredMACAlgorithmS2CSel, document.htmlform_saConfig.excludedMACAlgorithmS2CSel);" type="button" value="&#8592" name="moveLeft1" class="widebuttons arrow">
								</td>

								<td width="47%" class="grouping-neutral" valign="top" align="center">
									Excluded MAC Algorithms S2C<br>
									<select class="listbox" id="excludedMACAlgorithmS2CSel" size="7" name="excludedMACAlgorithmS2CSel" multiple>
									<option value="dummyOption">------none------</option>
									</select>
								</td>
							</tr>
							%invoke wm.server.sftpclient:listMACAlgorithmsS2C%
								%ifvar operation equals('edit')%
									<script>
										populateOptions(document.htmlform_saConfig.preferredMACAlgorithmS2CSel, '%value preferredMACS2C%', document.htmlform_saConfig.excludedMACAlgorithmS2CSel, '%value macAlgorithmsS2C%');
									</script>
								%else%
									%ifvar user_action equals('gethostkey')%
										<script>
											populateOptions(document.htmlform_saConfig.preferredMACAlgorithmS2CSel, '%value preferredMACS2C%', document.htmlform_saConfig.excludedMACAlgorithmS2CSel, '%value macAlgorithmsS2C%');
										</script>
									%else%
										<script>
											populateOptions(document.htmlform_saConfig.preferredMACAlgorithmS2CSel, '%value macAlgorithmsS2C%' , document.htmlform_saConfig.excludedMACAlgorithmS2CSel, '');
										</script>
									%endif%
								%endif%	
							%endinvoke%
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">				
						<table width="100%" >
							<tr>
								<td width="47%" class="grouping-positive" valign="top" align="center">
									Preferred MAC Algorithms C2S<br>
									<select class="listbox"  size="7" id="preferredMACAlgorithmC2SSel" name="preferredMACAlgorithmC2SSel" multiple>
									<option value="dummyOption">-----none-----</option>
									</select>
								</td>
								<td  width="6%" valign="center" align="center">
									<input type="button" style="width: 50px" value="&#8593" onClick="move(this.form,document.htmlform_saConfig.preferredMACAlgorithmC2SSel,-1)" class="widebuttons arrow"><br>
									<input type="button" style="width: 50px" value="&#8595" onClick="move(this.form,document.htmlform_saConfig.preferredMACAlgorithmC2SSel,+1)" class="widebuttons arrow"><br>
									<input onclick="moveToRight(document.htmlform_saConfig.preferredMACAlgorithmC2SSel, document.htmlform_saConfig.excludedMACAlgorithmC2SSel);" type="button" value="&#8594" name="moveRight1" class="widebuttons arrow"><br>
									<input onclick="moveToLeft(document.htmlform_saConfig.preferredMACAlgorithmC2SSel, document.htmlform_saConfig.excludedMACAlgorithmC2SSel);" type="button" value="&#8592" name="moveLeft1" class="widebuttons arrow">
								</td>

								<td width="47%" class="grouping-neutral" valign="top" align="center">
									Excluded MAC Algorithms C2S<br>
									<select class="listbox" id="excludedMACAlgorithmC2SSel" size="7" name="excludedMACAlgorithmC2SSel" multiple>
									<option value="dummyOption">------none------</option>
									</select>
								</td>
							</tr>
							%invoke wm.server.sftpclient:listMACAlgorithmsC2S%
								%ifvar operation equals('edit')%
									<script>
										populateOptions(document.htmlform_saConfig.preferredMACAlgorithmC2SSel, '%value preferredMACC2S%', document.htmlform_saConfig.excludedMACAlgorithmC2SSel, '%value macAlgorithmsC2S%');
									</script>
								%else%
									%ifvar user_action equals('gethostkey')%
										<script>
											populateOptions(document.htmlform_saConfig.preferredMACAlgorithmC2SSel, '%value preferredMACC2S%', document.htmlform_saConfig.excludedMACAlgorithmC2SSel, '%value macAlgorithmsC2S%');
										</script>
									%else%
										<script>
											populateOptions(document.htmlform_saConfig.preferredMACAlgorithmC2SSel, '%value macAlgorithmsC2S%' , document.htmlform_saConfig.excludedMACAlgorithmC2SSel, '');
										</script>
									%endif%
								%endif%	
							%endinvoke%
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">				
						<table width="100%" >
							<tr>
								<td width="47%" class="grouping-positive" valign="top" align="center">
									Preferred Ciphers S2C<br>
									<select class="listbox"  size="7" id="preferredCiphersS2CSel" name="preferredCiphersS2CSel" multiple>
									<option value="dummyOption">-----none-----</option>
									</select>
								</td>
								<td  width="6%" valign="center" align="center">
									<input type="button" style="width: 50px" value="&#8593" onClick="move(this.form,document.htmlform_saConfig.preferredCiphersS2CSel,-1)" class="widebuttons arrow"><br>
									<input type="button" style="width: 50px" value="&#8595" onClick="move(this.form,document.htmlform_saConfig.preferredCiphersS2CSel,+1)" class="widebuttons arrow"><br>
									<input onclick="moveToRight(document.htmlform_saConfig.preferredCiphersS2CSel, document.htmlform_saConfig.excludedCiphersS2CSel);" type="button" value="&#8594" name="moveRight1" class="widebuttons arrow"><br>
									<input onclick="moveToLeft(document.htmlform_saConfig.preferredCiphersS2CSel, document.htmlform_saConfig.excludedCiphersS2CSel);" type="button" value="&#8592" name="moveLeft1" class="widebuttons arrow">
								</td>

								<td width="47%" class="grouping-neutral" valign="top" align="center">
									Excluded Ciphers S2C<br>
									<select class="listbox" id="excludedCiphersS2CSel" size="7" name="excludedCiphersS2CSel" multiple>
									<option value="dummyOption">------none------</option>
									</select>
								</td>
							</tr>
							%invoke wm.server.sftpclient:listCiphersS2C%
								%ifvar operation equals('edit')%
									<script>
										populateOptions(document.htmlform_saConfig.preferredCiphersS2CSel, '%value preferredCiphersS2C%', document.htmlform_saConfig.excludedCiphersS2CSel, '%value ciphersS2C%');
									</script>
								%else%
									%ifvar user_action equals('gethostkey')%
										<script>
											populateOptions(document.htmlform_saConfig.preferredCiphersS2CSel, '%value preferredCiphersS2C%', document.htmlform_saConfig.excludedCiphersS2CSel, '%value ciphersS2C%');
										</script>
									%else%
										<script>
											populateOptions(document.htmlform_saConfig.preferredCiphersS2CSel, '%value ciphersS2C%' , document.htmlform_saConfig.excludedCiphersS2CSel, '');
										</script>
									%endif%
								%endif%	
							%endinvoke%
						</table>
					</td>
				</tr>							
				<tr>
					<td colspan="2">				
						<table width="100%" >
							<tr>
								<td width="47%" class="grouping-positive" valign="top" align="center">
									Preferred Ciphers C2S<br>
									<select class="listbox"  size="7" id="preferredCiphersC2SSel" name="preferredCiphersC2SSel" multiple>
									<option value="dummyOption">-----none-----</option>
									</select>
								</td>
								<td  width="6%" valign="center" align="center">
									<input type="button" style="width: 50px" value="&#8593" onClick="move(this.form,document.htmlform_saConfig.preferredCiphersC2SSel,-1)" class="widebuttons arrow"><br>
									<input type="button" style="width: 50px" value="&#8595" onClick="move(this.form,document.htmlform_saConfig.preferredCiphersC2SSel,+1)" class="widebuttons arrow"><br>
									<input onclick="moveToRight(document.htmlform_saConfig.preferredCiphersC2SSel, document.htmlform_saConfig.excludedCiphersC2SSel);" type="button" value="&#8594" name="moveRight1" class="widebuttons arrow"><br>
									<input onclick="moveToLeft(document.htmlform_saConfig.preferredCiphersC2SSel, document.htmlform_saConfig.excludedCiphersC2SSel);" type="button" value="&#8592" name="moveLeft1" class="widebuttons arrow">
								</td>

								<td width="47%" class="grouping-neutral" valign="top" align="center">
									Excluded Ciphers C2S<br>
									<select class="listbox" id="excludedCiphersC2SSel" size="7" name="excludedCiphersC2SSel" multiple>
									<option value="dummyOption">------none------</option>
									</select>
								</td>
							</tr>
							%invoke wm.server.sftpclient:listCiphersC2S%
								%ifvar operation equals('edit')%
									<script>
										populateOptions(document.htmlform_saConfig.preferredCiphersC2SSel, '%value preferredCiphersC2S%', document.htmlform_saConfig.excludedCiphersC2SSel, '%value ciphersC2S%');
									</script>
								%else%
									%ifvar user_action equals('gethostkey')%
										<script>
											populateOptions(document.htmlform_saConfig.preferredCiphersC2SSel, '%value preferredCiphersC2S%', document.htmlform_saConfig.excludedCiphersC2SSel, '%value ciphersC2S%');
										</script>
									%else%
										<script>
											populateOptions(document.htmlform_saConfig.preferredCiphersC2SSel, '%value ciphersC2S%' , document.htmlform_saConfig.excludedCiphersC2SSel, '');
										</script>
									%endif%

								%endif%	
							%endinvoke%
						</table>
					</td>
				</tr>		
				<tr>
					<td class="action" colspan=4>
						<input type="submit" name="submit" value="Save Changes" onclick="return validate('%value operation encode(javascript)%');">
					</td>
				</tr>
					</form>
					<form name="htmlform_gethostkey" action="settings-sftp-client-serveralias-addedit.dsp" method="POST">
					    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
						<input type="hidden" name="operation">
						<input type="hidden" name="user_action">
						<input type="hidden" name="alias">
						<input type="hidden" name="version">
						<input type="hidden" name="hostName">
						<input type="hidden" name="port">
						<input type="hidden" name="preferredKeyExchangeAlgorithm">
						<input type="hidden" name="preferredMACS2C">
						<input type="hidden" name="preferredMACC2S">
						<input type="hidden" name="preferredCiphersS2C">
						<input type="hidden" name="preferredCiphersC2S">
						<input type="hidden" name="minDHKeySize">
						<input type="hidden" name="maxDHKeySize">
						<input type="hidden" name="proxyAlias">
						<input type="hidden" name="fingerprint">
						<input type="hidden" name="hostKeyLocation">
					</form>
					<form name="htmlform_setVersion" action="settings-sftp-client-serveralias-addedit.dsp" method="POST">
					    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
						<input type="hidden" name="version">
						<input type="hidden" name="alias">
						<input type="hidden" name="hostName">
						<input type="hidden" name="port">
						<input type="hidden" name="proxyAlias">
						<input type="hidden" name="minDHKeySize">
						<input type="hidden" name="maxDHKeySize">
						<input type="hidden" name="operation" value="add">
					</form>
					</table>
				</td>
			</tr>
		</table>
		%ifvar user_action equals('gethostkey')%
			<script>setDirty();</script>
		%else%
			%ifvar operation equals('edit')%
				<script>setDirty();</script>
			%end%	
		%end%
	</body>   
</html>					

