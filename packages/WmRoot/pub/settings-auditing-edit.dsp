<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <script src="client.js"></script>
  <script src="acls.js"></script>
  <SCRIPT type="text/javascript" SRC="webMethods.js"></SCRIPT>
  
  <script language ="javascript">
      var toggleRow = 1;
      function writeToggleClassRow() {
      	if(toggleRow == 0) {
      	   toggleRow = 1;
      	   document.write("<td class='evenrow-l'>");
      	} 
      	else {
      	   toggleRow = 0;
      	   document.write("<td class='oddrow-l'>");
      	}
    }

    var toggleData = 1;
      function writeToggleClassData() {
      	if(toggleData == 0) {
      	   toggleData = 1;
      	   document.write("<td class='evenrowdata-l'>");
      	} 
      	else {
      	   toggleData = 0;
      	   document.write("<td class='oddrowdata-l'>");
      	}
    }
  
  
  </script>

  <script language ="javascript">
  
	  function updateDisplay(providerType)
	  {
		 if ( providerType == 'um' ) {
			document.loggerform.connectionAlias.disabled=false;
			document.loggerform.readerThreads.disabled=false;
		}

		if ( providerType == 'lwq' ) {
			document.loggerform.connectionAlias.disabled=true;
			document.loggerform.readerThreads.value=1;
			document.loggerform.readerThreads.disabled=true;
		}	
	  }
	  
	  function onChangeDestination(isDatabase)
	  {
		 if ( isDatabase == 'true' ) {
			document.loggerform.maxRetries.disabled=false;
			document.loggerform.retryWait.disabled=false;
		}

		if ( isDatabase == 'false' ) {
			document.loggerform.maxRetries.disabled=true;
			document.loggerform.retryWait.disabled=true;
		}	
	  }
  </script>
  
  	<script language ="javascript">
  	
  	function getSelectedCategories(selectList, separator){
  	var i
  	var count = 0
  	var tempString = ""
  	for (i = 0; i < selectList.length; i++){
  	   if (selectList.options[i].selected){
  	      if (count > 0) tempString += separator
  	      tempString += selectList.options[i].text
  	      count++
  	      }
  	   }
          document.addform.categoriesVal.value = tempString    
          return tempString
  	
  	}
  	
  	var toggle = 1;
      function writeToggleClass() {
      	if(toggle == 0) {
      		toggle = 1;
      		document.write("<tr class='evenrow-l'>");
      	} else {
      		toggle = 0;
      		document.write("<tr class='oddrow-l'>");
      	}
      }
	</script> 
	
</head>


%switch loggerName%
	%case 'Document Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditDocumentLoggerScrn');">
	%case 'Error Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditErrorLoggerScrn');">				
	%case 'Guaranteed Delivery Inbound Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditGDInboundLoggerScrn');">				
	%case 'Guaranteed Delivery Outbound Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditGDOutboundLoggerScrn');">				
	%case 'Messaging Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditMessagingLoggerScrn');">				
	%case 'Security Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditSecurityLoggerScrn');">				
	%case 'Service Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditServiceLoggerScrn');">				
	%case 'Session Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditSessionsLoggerScrn');">				
	%case 'Mediator Transaction Logger'%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditMediatorTransactionLoggerScrn');">
	%case%
				<body onLoad="setNavigation('settings-auditing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LoggingScrn');">
%endswitch%


%invoke wm.server.auditing:getAuditLoggerDetails%

<table name="pagetable" align='left' width="100%">

    <tr>
      <td class="menusection-Settings" colspan="4">Settings &gt; Logging &gt; Edit %value loggerNameDisplay encode(html)% Details</td>
    </tr>

    <tr>
      <td colspan="2">
        <ul>
		<script>
		createForm("htmlform_settings_auditing", "settings-auditing.dsp", "POST", "BODY");
		createForm("htmlform_settings_auditing_detail", "settings-auditing-detail.dsp", "POST", "BODY");
		setFormProperty("htmlform_settings_auditing_detail", "loggerNameDisplay", "%value loggerNameDisplay%");
		setFormProperty("htmlform_settings_auditing_detail", "loggerName", "%value loggerName%");
		</script>
          <li>
		  <script>getURL("settings-auditing.dsp","javascript:document.htmlform_settings_auditing.submit();","Return to Logger List")</script>
          <li>
		  <script>getURL("settings-auditing-detail.dsp?loggerNameDisplay=%value loggerNameDisplay encode(url)%&loggerName=%value loggerName encode(url)%","javascript:document.htmlform_settings_auditing_detail.submit();","Return to View %value loggerNameDisplay encode(html)% Details")</script>
		  </li>
        </ul>
      </td>
    </tr>

    <form name="loggerform" action="settings-auditing-detail.dsp" METHOD="POST">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <tr>

      <td><img src="images/blank.gif" height=10 width=10></td>
      <td>
			<TR>
				<TD>
				    <table width="100%" class="tableView">
					<TR>
		    	 			<TD colspan="2" class="heading">Audit Logger Configuration</TD>
		    			</TR>				    

					  <tr>
					    <script>writeToggleClassRow();</script>Name</td>
					    <script>writeToggleClassData();</script>%value loggerNameDisplay encode(html)%</td>
					  </tr>


					  <tr>
					    <script>writeToggleClassRow();</script>Enabled</td>
					    
					    <script>writeToggleClassData();</script>
						 <input name="isEnabled" type="radio" id="isEnabled" value="true" %ifvar hasSecurity equals('true') % onClick="checkStatus(this.value)" %endif% %ifvar isEnabled equals('true')% checked %endif% %ifvar canDisable equals('false')%disabled%endif%><label for="isEnabled"> Yes</label></input>
						 <BR/><input name="isEnabled" type="radio" id="isEnabled2" value="false" %ifvar hasSecurity equals('true') % onClick="checkStatus(this.value)" %endif% %ifvar isEnabled equals('false')% checked %endif% %ifvar canDisable equals('false')%disabled%endif%><label for="isEnabled2"> No</label></input>
					    </td>

					  </tr>

					  %ifvar hasLevel equals('true')%
						  <tr>
						    <input name="hasLevel" type = "hidden" value="true">
						    <script>writeToggleClassRow();</script><label for="level">Level</label></td>
						    <script>writeToggleClassData();</script>
						    <SELECT id="level" NAME="level">
						       <OPTION %ifvar level equals('perSvc')% selected="selected" %endif% value ="perSvc">perSvc</OPTION>
						       <OPTION %ifvar level equals('brief')% selected="selected" %endif% value ="brief">brief</OPTION>
						       <OPTION %ifvar level equals('verbose')% selected="selected" %endif% value ="verbose">verbose</OPTION>						    
						    </SELECT
						    </td>
						  </tr>
					  %endif%

					  <tr>
					    <script>writeToggleClassRow();</script>Mode</td>
					    <script>writeToggleClassData();</script>
    						 <input name="isAsynchronous" type="radio" id="isAsynchronous" value="false" %ifvar isAsynchronous equals('false')%checked%endif%> <label for="isAsynchronous">Synchronous</label></input>
						 <BR/><input name="isAsynchronous" type="radio" id="isAsynchronous2" value="true" %ifvar isAsynchronous equals('true')%checked%endif%> <label for="isAsynchronous2">Asynchronous</label></input>
					    </td>
					  </tr>

					  <tr>
					    <script>writeToggleClassRow();</script>Guaranteed</td>
					    <script>writeToggleClassData();</script>
						 <input name="isGuaranteed" id="isGuaranteed" type="radio" value="true" %ifvar isGuaranteed equals('true')%checked%endif%><label for="isGuaranteed"> Yes</label></input>
						 <BR/><input name="isGuaranteed" id="isGuaranteed2" type="radio" value="false" %ifvar isGuaranteed equals('false')%checked%endif%><label for="isGuaranteed2"> No</label></input>
					    </td>
					  </tr> 

					  <tr>
					    <script>writeToggleClassRow();</script>Destination</td>
					    <script>writeToggleClassData();</script>
						 <input name="isDatabase" id="isDatabase1" type="radio" value="true" onclick="onChangeDestination('true')" %ifvar isDatabase equals('true')%checked%endif% %ifvar isDBAllowed equals('false')%disabled%endif%><label for="isDatabase1"> Database</label></input>
						 <BR/><input name="isDatabase" id="isDatabase2" type="radio" value="false" onclick="onChangeDestination('false')" %ifvar isDatabase equals('false')%checked%endif% %ifvar isFSAllowed equals('false')%disabled%endif%><label for="isDatabase2"> File</label></input>
					    </td>
					  </tr> 

					  <tr>
					    <script>writeToggleClassRow();</script><label for="maxQueueSize">Maximum Queue Size</label></td>
					    <script>writeToggleClassData();</script>
					    <INPUT NAME="maxQueueSize" id="maxQueueSize" size="10" value="%value maxQueueSize encode(htmlattr)%"> log entries</td>
					  </tr> 

					  <tr>
					    <script>writeToggleClassRow();</script>Queue Provider</td>
					    <script>writeToggleClassData();</script>
						 <input name="queueType" id="queueType" type="radio" value="lwq" onclick="updateDisplay('lwq')" %ifvar queueType equals('lwq')%checked%endif%><label for="queueType"> Internal</label></input>
						 <BR/><input name="queueType" id="queueType2" type="radio" value="um" onclick="updateDisplay('um')" %ifvar queueType equals('um')%checked%endif% %ifvar hasMessaging equals('true')%disabled%endif%><label for="queueType2"> Universal Messaging</label></input>
					    </td>
					  </tr> 

					  <tr>
					    <script>writeToggleClassRow();</script>
						<script>
						createForm("htmlform_settings_wm_um_create", "settings-wm-um-create.dsp", "POST", "BODY");
						</script>
						<script>getURL("settings-wm-um-create.dsp","javascript:document.htmlform_settings_wm_um_create.submit();","<b>Connection Alias</b>")</script></td>
					    <script>writeToggleClassData();</script>
						
							%invoke wm.server.messaging:getUMConnectionAliases%
							<select name="connectionAlias" id="connectionAlias">
								%loop connAliases%
								
									<option value="%value connAliases%" %ifvar connAliases vequals(connectionAlias)% selected %endif%>
										%value connAliases%
									</option>
								
								%endloop%
							</select>
					    </td>
						
					  </tr> 
					  
					  
					  <tr>
					     <script>writeToggleClassRow();</script><label for="maxRetries">Maximum Retries</label></td>
					     
					     <script>writeToggleClassData();</script>
					     <INPUT NAME="maxRetries" id="maxRetries" size="10" value="%value maxRetries encode(htmlattr)%"></td>
					  </tr> 

					  <tr>
					     <script>writeToggleClassRow();</script><label for="retryWait">Wait Between Retries</label></td>
					     <script>writeToggleClassData();</script>
					     <INPUT NAME="retryWait" id="retryWait" size="3" value="%value retryWait encode(htmlattr)%"> seconds</td>
					  </tr> 


					   %ifvar hasSecurity equals('true')%

			  			<tr>
					             <script>writeToggleClassRow();</script>Generate Auditing Data on Startup</td>
						    <script>writeToggleClassData();</script>
							 <input name="startup" id="startup1" type="radio" value="true" %ifvar startup equals('true')%checked%endif%><label for="startup1"> Yes</label></input>
							 <BR/><input name="startup" id="startup2" type="radio" value="false" %ifvar startup equals('false')%checked%endif%><label for="startup2"> No</label></input>
						    </td>
					        </tr>		


						<tr>
						    <script>writeToggleClassRow();</script><label for="result">Generate Auditing Data on </label></td>	
						    <script>writeToggleClassData();</script>

							   <SELECT id="result" NAME="result">
							       <OPTION %ifvar result equals('Success')% selected="selected" %endif% value ="Success" >Success</OPTION>
							       <OPTION %ifvar result equals('Failure')% selected="selected" %endif% value ="Failure" >Failure</OPTION>
							       <OPTION %ifvar result equals('Success or Failure')% selected="selected" %endif% value ="Success or Failure" >Success or Failure</OPTION>
							   </SELECT>
						</tr>

					   %endif%

				    
				    </table>				
				</TD>
		    			</TR>				    
			

		    			<TR>				    
			<TD valign="top">
				    <table width="100%" class="tableView">
					<TR>
		    	 			<TD colspan="2" class="heading">Audit Logger Reader Configuration</TD>
		    			</TR>				    

					  <tr>
					    <script>writeToggleClassRow();</script><label for="readerThreads">Number of Readers</label></td>
					    <script>writeToggleClassData();</script>
						<INPUT NAME="readerThreads" id="readerThreads" size="10" value="%value readerThreads%"></td>
					  </tr>
					  </table>
			</td>
			   
			</TR>

			%ifvar queueType equals('lwq')%
				<script>
					updateDisplay('lwq');
				</script>
			%endif%
			
			%ifvar isDatabase equals('false')%
				<script>
					onChangeDestination('false');
				</script>
			%endif%
			
			%ifvar hasSecurity equals('true')%
			
			<tr>
		          	<input name="categoriesVal" type = "hidden">
		          	<input name="selAreas" type = "hidden">
		          	<input name="sec-audit-conf-saved" type = "hidden" value="03233">
		          	<input name="hasSecurity" type = "hidden" value="true">
			</tr>


					<tr>
						<td>
						<table width="100%" class="tableView">
					       <TR>
						    <TD class="heading" colspan="2" >Security Areas to Audit</TD>
					       </TR>
					       <script>var allCategories ="";</script>
					    %loop defaultAreas%
						<script>writeToggleClass();
							 allCategories  = allCategories +"%value encode(javascript)%,";
						</script>
							<td>
							<input type="checkbox" name="%value encode(htmlattr)%" id="%value encode(htmlattr)%"></input>
							</td>
							<td width="100%"><label for="%value encode(htmlattr)%">%value encode(html)%</label></td>
						</tr>
						%endloop%
					</table>
					</td>
				</tr>


				<tr>
				    <script>writeTDspan('rowdata-l', 2)</script>
				      <div name="Aa" id="Aa">
					Select:
					<a href="#" onclick="SetOrUnset(true);">All</a>, 
					<a href="#" onclick="SetOrUnset(false);">None</a>
				     </div>
				    </td>
				</tr>

			%endif%
			
			%ifvar hasMessaging equals('true')%
			
					<tr>
		          	<input name="hasMessaging" type = "hidden" value="true">
			    </tr>
					<tr>
						<td>
						<table width="100%" class="tableView">
					       <TR>
						    <TD class="heading" colspan="2" >Messaging Audit Log Level</TD>
					       </TR>
                  <tr>
                    <td class="evenrow-l" style="width: 50%"><label for="logLevel">Logging Level</label></td>
                    <td class="evenrowdata-l" style="width: 50%">
                    
                    
                    	<select name="logLevel" id="logLevel">
								
												%ifvar logLevel equals('0')%
													<option value="0" selected="selected" >Info</option>
												%else%
													<option value="0" >Info</option>
												%endif%
												%ifvar logLevel equals('1')%
													<option value="1" selected="selected" >Debug</option>
												%else%
													<option value="1" >Debug</option>
												%endif%
												%ifvar logLevel equals('2')%
													<option value="2" selected="selected" >Trace</option>
												%else%
													<option value="2" >Trace</option>
												%endif%
											</select>

                    </td>
                </tr>

					</table>
					</td>
				</tr>

			%endif%

			
			<TR>
			    <TD>
			
			        <!-- Submit Button -->
			        
			        <TABLE class="tableView" width="100%">
			          <tr>
			              <td class="action" colspan=2>
			                
			                <input name="action" type="hidden" value="saveAuditData">
			                <input name="loggerName" type="hidden" value="%value loggerName encode(htmlattr)%">
			                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">
			                
			                
			              </td>
			            </tr>
			        
			        </table>
			       </TD> 
			 </TR>

      	</TABLE>
      </td>

    </tr>

   </form>
</body>

<SCRIPT>

	var selCategories = "";
	%loop categories%
	selCategories  = selCategories +"%value encode(javascript)%,";
	%endloop%
	selectCategories(selCategories);
	
	function selectCategories(scate) {
		var selOpt = scate.split(",");
		var selLen = selOpt.length;
		for (i = 0; i < selLen; i++){
			var opt = selOpt[i];
			var checkObj = document.getElementById(opt);
			if(checkObj!= null){
				checkObj.checked = true;
			}
		}
	}

	function SetOrUnset(val){
		var selOpt = allCategories.split(",");
		var selLen = selOpt.length;
		for (i = 0; i < selLen; i++){
			var opt = selOpt[i];
			var checkObj = document.getElementById(opt);
			if(checkObj!= null){
				checkObj.checked = val;
			}
		}
	}

	
	function getEnabledVals(){
		var selAreas ="";
	   	for(i=0;i<document.loggerform.length;i++){
			if(document.loggerform[i].type=="checkbox"&&document.loggerform[i].checked){
			   selAreas = selAreas +document.loggerform[i].name;
			   selAreas += ",";
			}
		}
		document.loggerform.selAreas.value = selAreas;
		return true;
 	}
 	
  function checkStatus(val) {
    	if(val == "true") {
  		disableElements(false);  		
  		document.getElementById("Aa").style.display="";
  		}
  	else {
  	 disableElements(true);
  	 }
  }
	
  function disableElements(disable) {
  	
  	for(i=0;i<document.loggerform.length;i++){
	    		var typ = document.loggerform[i].type;
				if(typ=="checkbox"){
			   		document.loggerform[i].disabled = disable;
	
				}
				
				if ( document.loggerform[i].name == "startup" ) {
					document.loggerform[i].disabled = disable;
				}
			}
			document.loggerform.result.disabled = disable;		
			document.getElementById("Aa").style.display="none";
  }
  
  function checkEnabled(){
        %ifvar hasSecurity equals('true')%
        	%ifvar isEnabled equals('false')%
        		disableElements(true);
        	%endif%
        %endif%

	return true;
 }

 function isValueInRange(dataValue, minValue, maxValue) {
 
       if (! isInteger(dataValue))
       {
       	return false;
       }
       
       if (parseInt(dataValue) < parseInt(minValue) || parseInt(dataValue) > parseInt(maxValue) ) 
       {
 	return false;
       }
       
       return true;
 }
 
 function validateForm(form) {

   var dataVal = form.maxQueueSize.value;
   var maxValue = 2147483647;
   var minValue = 0;

   if (dataVal == "") {
     alert("Maximum Queue Size must be specified.");
     
     return false;
   }

   if ( ! isValueInRange(dataVal, minValue, maxValue) ) {
     	alert("Invalid value for Maximum Queue Size specified. It must be >= " + minValue + " and <= " + maxValue);
     	return false;
   }

   var isDatabase = form.isDatabase.value;
   if (isDatabase == "true"){
	   dataVal = form.maxRetries.value;
	   if (dataVal == "") {
	     alert("Maximum Retries must be specified.");
	     return false;
	   }
	
	   if ( ! isValueInRange(dataVal, minValue, maxValue) ) {
	     	alert("Invalid value for Maximum Retries specified. It must be >= " + minValue + " and <= " + maxValue);
	     	return false;
	   }
	
	   dataVal = form.retryWait.value;
	   maxValue = 5;
	   if (dataVal == "") {
	     alert("Wait Between Retries must be specified.");
	     return false;
	   }
	
	   if ( ! isValueInRange(dataVal, minValue, maxValue) ) {
	     	alert("Invalid value for Wait Between Retries specified. It must be >= " + minValue + " and <= " + maxValue);
	     	return false;
	   }
   }
   
	%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
	var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
	if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
		form.setAttribute("action", "settings-auditing-detail.dsp?loggerNameDisplay=%value loggerNameDisplay encode(url)%&loggerName=%value loggerName encode(url)%&webMethods-wM-AdminUI=true");
	}		   
   
   getEnabledVals();
   return true;
 }

</script>
</html>