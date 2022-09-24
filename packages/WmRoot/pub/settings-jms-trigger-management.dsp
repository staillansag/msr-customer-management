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
  <script src="webMethods.js"></script>
  
  <script language ="javascript">

    var hideStandard = "false";
    var hideSOAP = "false";

    /**
     *
     */     
    function changeTriggerState() {
      return confirm("Would you like to make this change across the entire cluster?");  
    }
  
    /**
     *
     */     
    function popUp(URL) {
      day = new Date();
      id = day.getTime();
      if(is_csrf_guard_enabled && needToInsertToken) {
        if(URL.indexOf("?") != -1){
          URL = URL+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
        } else {
          URL = URL+"?"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
        }
      } 
      eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=200,height=200,left = 540,top = 412');");
    }
  
    /**
     *
     */ 
    function toggle2(id, imgID) {
      if (id == "") {
        return;
      }
      toggleState = 1; 
      var imgElem = document.getElementById(imgID); 
      var elements = getElements2("TR", id);
      var lastElementDisplay;
      for ( var i = 0; i < elements.length; i++) {     
        var element = elements[i];
        lastElementDisplay = element.style.display;
        element.style.display = (lastElementDisplay != 'none' ? 'none' : '' );
      }
    
      if (lastElementDisplay == 'none') {
        imgElem.src = 'images/expanded_blue.gif';
        //alert('set: ' + id + ' to open');
        sessionStorage.setItem("wm.is.jms." + id, '1');
      }else {
        imgElem.src = 'images/collapsed_blue.gif';
        //alert('set: ' + id + ' to closed');
        sessionStorage.removeItem("wm.is.jms." + id);  
      }
    }
    
    function showFilters() {
      document.getElementById('filtercriteria').style.display = 'block'; 
      document.getElementById('showfilterlink').style.display = 'none';
      document.getElementById('hidefilterlink').style.display = 'block';      
    }
    
    function hideFilters() {
      document.getElementById('filtercriteria').style.display = 'none';
      document.getElementById('showfilterlink').style.display = 'block';
      document.getElementById('hidefilterlink').style.display = 'none';
    }
    
    function hideAndRefreshFilters() {
      document.getElementById('filtercriteria').style.display = 'none';
      document.getElementById('showfilterlink').style.display = 'block';
      document.getElementById('hidefilterlink').style.display = 'none';
      
      if(is_csrf_guard_enabled && needToInsertToken) {
        var appendStrAmp = '';
        var appendStrQue = '';
        if(is_csrf_guard_enabled && needToInsertToken) {
          appendStrAmp = "&"+_csrfTokenNm_+"="+_csrfTokenVal_ 
          appendStrQue = "?"+_csrfTokenNm_+"="+_csrfTokenVal_ 
        }
        createForm("htmlform_settings_jms_trigger_management_hiderefresh", "settings-jms-trigger-management.dsp", "POST", "BODY");
	      setFormProperty("htmlform_settings_jms_trigger_management_hiderefresh", _csrfTokenNm_, _csrfTokenVal_);
        window.location = "javascript:document.htmlform_settings_jms_trigger_management_hiderefresh.submit();";
      }else {
        var appendStrAmp = '';
        var appendStrQue = '';
        if(is_csrf_guard_enabled && needToInsertToken) {
          appendStrAmp = "&"+_csrfTokenNm_+"="+_csrfTokenVal_ 
          appendStrQue = "?"+_csrfTokenNm_+"="+_csrfTokenVal_ 
        }
        %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
		    if (appendStrAmp == '') {
		      window.location = "settings-jms-trigger-management.dsp"+"?webMethods-wM-AdminUI=true";
		    }
		    else {
			  window.location = "settings-jms-trigger-management.dsp"+appendStrAmp+"&webMethods-wM-AdminUI=true";
			}
		}
		else {
			window.location = "settings-jms-trigger-management.dsp"+appendStrAmp;
		}
      }
    }
    
    function submitFilters(element) {
    
      var n = element.triggerFilterValue.value;
      if (n != null) {
        sessionStorage.setItem("wm.is.jms.filter_name", n);
      }else {
        sessionStorage.removeItem("wm.is.jms.filter_name");
      }
      
      var a = element.aliasFilterValue.value;
      if (a != null) {
        sessionStorage.setItem("wm.is.jms.filter_alias", a);
      }else {
        sessionStorage.removeItem("wm.is.jms.filter_alias");
      }
      
      var d = element.destinationFilterValue.value;
      if (d != null) {
        sessionStorage.setItem("wm.is.jms.filter_dest", d);
      }else {
        sessionStorage.removeItem("wm.is.jms.filter_dest");
      }
    }

    /**
     *
     */     
    function getElements2(tag, id) {
      var elem = document.getElementsByTagName(tag);
      var arr = new Array();
      for(i=0, idx=0; i<elem.length; i++) {
        att = elem[i].getAttribute("id");
      
        if(att == id) {
          arr[idx++] = elem[i];
        }
      }
      return arr;
    }
  
    /**
     *
     */
    function loadDocument() {

      setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerMgmt');
      
      var arr = [];
      var elem = document.getElementsByName('trigList');

      for(i=0, idx=0; i<elem.length; i++) {
        att = elem[i].getAttribute("id");  
 
        if (att) {        
          var openFlag = sessionStorage.getItem("wm.is.jms." + att);

          if (openFlag) {
            // already open
          }else {
            if (!contains(arr, att)) {
              arr.push(att);
            }
          }              
        }
      }  
      
      for (var i = 0; i < arr.length; i++) {
        var item = arr[i];
        toggle2(item, item + 'img');
      }
      
      %ifvar triggerFilterValue -notempty%
        showFilters();
      %else%
        %ifvar aliasFilterValue -notempty%
          showFilters();
        %else%
          %ifvar destinationFilterValue -notempty%
            showFilters();
          %else%
            hideFilters();
          %endif%
        %endif%   
      %endif%
    }
    
    /**
     *
     */         
    function contains(a, obj) {
      
     // alert("in contains");
      for (var i = 0; i < a.length; i++) {
        if (a[i] === obj) {
          return true;
        }
      }
      return false;
    }
   
    /**
     *
     */     
    function refreshDSP() { 

      if(is_csrf_guard_enabled && needToInsertToken) {
        var appendStrAmp = '';
        var appendStrQue = '';
        if(is_csrf_guard_enabled && needToInsertToken) {
          appendStrAmp = "&"+_csrfTokenNm_+"="+_csrfTokenVal_ 
          appendStrQue = "?"+_csrfTokenNm_+"="+_csrfTokenVal_ 
        }
        createForm("htmlform_settings_jms_trigger_management", "settings-jms-trigger-management.dsp", "POST", "BODY");
        setFormProperty("htmlform_settings_jms_trigger_management", "triggerFilterValue", "%value triggerFilterValue encode(htmlattr)%");
        setFormProperty("htmlform_settings_jms_trigger_management", "aliasFilterValue", "%value aliasFilterValue encode(htmlattr)%");
        setFormProperty("htmlform_settings_jms_trigger_management", "destinationFilterValue", "%value destinationFilterValue encode(htmlattr)%");
	      setFormProperty("htmlform_settings_jms_trigger_management", _csrfTokenNm_, _csrfTokenVal_);
        window.location = "javascript:document.htmlform_settings_jms_trigger_management.submit();";
      }else {
        var appendStrAmp = '';
        var appendStrQue = '';
        if(is_csrf_guard_enabled && needToInsertToken) {
          appendStrAmp = "&"+_csrfTokenNm_+"="+_csrfTokenVal_ 
          appendStrQue = "?"+_csrfTokenNm_+"="+_csrfTokenVal_ 
        }
        %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
			window.location = "settings-jms-trigger-management.dsp?triggerFilterValue=%value triggerFilterValue encode(htmlattr)%&aliasFilterValue=%value aliasFilterValue encode(htmlattr)%&destinationFilterValue=%value destinationFilterValue encode(htmlattr)%"+appendStrAmp+"&webMethods-wM-AdminUI=true";
		}
		else {
			window.location = "settings-jms-trigger-management.dsp?triggerFilterValue=%value triggerFilterValue encode(htmlattr)%&aliasFilterValue=%value aliasFilterValue encode(htmlattr)%&destinationFilterValue=%value destinationFilterValue encode(htmlattr)%"+appendStrAmp;
		}
      }
    } 
    
    /**
     *
     */     
    function refreshDSPOld() {      
	
      if(is_csrf_guard_enabled && needToInsertToken) {
        var appendStrAmp = '';
        var appendStrQue = '';
        if(is_csrf_guard_enabled && needToInsertToken) {
          appendStrAmp = "&"+_csrfTokenNm_+"="+_csrfTokenVal_ 
          appendStrQue = "?"+_csrfTokenNm_+"="+_csrfTokenVal_ 
        }
        if (hideStandard == "false" && hideSOAP == "false") {
	        createForm("htmlform_settings_jms_trigger_management_all", "settings-jms-trigger-management.dsp", "POST", "BODY");
	        setFormProperty("htmlform_settings_jms_trigger_management_all", "type", "all");
	        setFormProperty("htmlform_settings_jms_trigger_management_all", _csrfTokenNm_, _csrfTokenVal_);
	
          window.location = "javascript:document.htmlform_settings_jms_trigger_management_all.submit();";
        }else if (hideStandard == "false") {
	        createForm("htmlform_settings_jms_trigger_management_standard", "settings-jms-trigger-management.dsp", "POST", "BODY");
	        setFormProperty("htmlform_settings_jms_trigger_management_standard", "type", "standard");
	        setFormProperty("htmlform_settings_jms_trigger_management_standard", _csrfTokenNm_, _csrfTokenVal_);
          window.location = "javascript:document.htmlform_settings_jms_trigger_management_standard.submit();";
        }else if (hideSOAP == "false") {
		      createForm("htmlform_settings_jms_trigger_management_soap", "settings-jms-trigger-management.dsp", "POST", "BODY");
	        setFormProperty("htmlform_settings_jms_trigger_management_soap", "type", "soap");
	        setFormProperty("htmlform_settings_jms_trigger_management_soap", _csrfTokenNm_, _csrfTokenVal_);
          window.location = "javascript:document.htmlform_settings_jms_trigger_management_soap.submit();";
        }else {
		      createForm("htmlform_settings_jms_trigger_management", "settings-jms-trigger-management.dsp", "POST", "BODY");
	        setFormProperty("htmlform_settings_jms_trigger_management", _csrfTokenNm_, _csrfTokenVal_);
          window.location = "javascript:document.htmlform_settings_jms_trigger_management.submit();";
        }
	    } else {
		    var appendStrAmp = '';
        var appendStrQue = '';
        if(is_csrf_guard_enabled && needToInsertToken) {
          appendStrAmp = "&"+_csrfTokenNm_+"="+_csrfTokenVal_ 
          appendStrQue = "?"+_csrfTokenNm_+"="+_csrfTokenVal_ 
        }
        if (hideStandard == "false" && hideSOAP == "false") {
          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		  var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
			window.location = "settings-jms-trigger-management.dsp?type=all"+appendStrAmp+"&webMethods-wM-AdminUI=true";
		  }
		  else {
			window.location = "settings-jms-trigger-management.dsp?type=all"+appendStrAmp;
		  }
        }else if (hideStandard == "false") {
          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		  var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
			window.location = "settings-jms-trigger-management.dsp?type=standard"+appendStrAmp+"&webMethods-wM-AdminUI=true";
		  }
		  else {
			window.location = "settings-jms-trigger-management.dsp?type=standard"+appendStrAmp;
		  }
        }else if (hideSOAP == "false") {
          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		  var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
			window.location = "settings-jms-trigger-management.dsp?type=soap"+appendStrAmp+"&webMethods-wM-AdminUI=true";
		  }
		  else {
			window.location = "settings-jms-trigger-management.dsp?type=soap"+appendStrAmp;
		  }
        }else {
          %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		  var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		  if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
			window.location = "settings-jms-trigger-management.dsp"+appendStrQue+"&webMethods-wM-AdminUI=true";
		  }
		  else {
			window.location = "settings-jms-trigger-management.dsp"+appendStrQue;
		  }
        }
	    }
    }   

  </script>
  
</head>

<body onLoad="loadDocument();">
  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JMS Trigger Management</td>
    </tr>

    <!-- Enable/Disable Logic -->
                 
    %switch action%
    
    <!-- Stop/Suspend/Enable Trigger Logic -->
    
    %case 'suspendTrigger'%
      %invoke wm.server.jms:suspendJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage encode(html)%</td>
      %endinvoke%  
      %rename triggerName editedTriggerName%
    
    %case 'enableTrigger'%
      %invoke wm.server.jms:enableJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage encode(html)%</td>
      %endinvoke%
      %rename triggerName editedTriggerName%
      
    %case 'disableTrigger'%  
      %invoke wm.server.jms:disableJMSTriggers%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %onerror%
         <td class="message" colspan=2>%value errorMessage encode(html)%</td>
      %endinvoke%
      %rename triggerName editedTriggerName%

    <!-- Set Global Trigger Settings -->
    
    %case 'setSettings'%
      %invoke wm.server.jms:setSettings%
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %endinvoke%  
    
    %case 'filter'%

    %end%
      
    %invoke wm.server.jms:getTriggerReportWithGroupings%  

<!-- Navigation Menu -->
    
    <tr>
      <td colspan="2">
        <ul class="listitems">
		      <script>
		        createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
		        createForm("htmlform_settings_jms", "settings-jms.dsp", "POST", "BODY");
		        createForm("htmlform_settings_jms_global_trigger", "settings-jms-global-trigger.dsp", "POST", "BODY");
		      </script>
          %ifvar webMethods-wM-AdminUI% 
          %else%
            <li class="listitem"><script>getURL("settings-messaging.dsp", "javascript:document.htmlform_settings_messaging.submit();", "Return to Messaging");</script>
            </li>
            <li class="listitem"><script>getURL("settings-jms.dsp", "javascript:document.htmlform_settings_jms.submit();", "View JMS Settings");</script>
            </li>
          %endif%
          <li class="listitem"><script>getURL("settings-jms-global-trigger.dsp", "javascript:document.htmlform_settings_jms_global_trigger.submit();", "Edit JMS Global Trigger Controls");</script>
		      </li>   
          <li class="listitem"><a href="javascript:refreshDSP(); void 0">Refresh Page</a>
          </li>
          
         
          
          <li class="listitem">
            <a href="javascript:showFilters();" id="showfilterlink" >Search Triggers</a>      
            <a href="javascript:hideAndRefreshFilters();" id="hidefilterlink" style="display:none" >Show All Triggers</a>
          </li>    
        </ul>
        
      </td>
    </tr>
    
    <tr>
      <form id="filterform" action="settings-jms-trigger-management.dsp" METHOD="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif% 
      <table width="100%" class="tableView" id="filtercriteria">
         <tr >
           <td class="heading" colspan="5">
             Search Criteria
           </td>
         </tr> 
         <tr>
           <td>
             <label for="triggerFilterValue">Trigger Name</label><br>
             <INPUT NAME="triggerFilterValue" ID="triggerFilterValue" size="40" value="%value triggerFilterValue%">
           </td>
           <td>
             <label for="aliasFilterValue">Connection Alias Name</label><br>
             <INPUT NAME="aliasFilterValue" ID="aliasFilterValue" size="40" value="%value aliasFilterValue%">
           </td>
           <td>
             <label for="destinationFilterValue">Destinations</label><br>
             <INPUT NAME="destinationFilterValue" ID="destinationFilterValue" size="40" value="%value destinationFilterValue%">
           </td>
           <td>
             <input name="action" type="hidden" value="filter">
             <input type="submit" value="Search" onClick="javascript:return submitFilters(this.form)">
           </td>
           <td width="50%">
             &nbsp; 
           </td>
         </tr>
      </table>
      </form>  
    </tr>
    
    <tr>
      <td>
        
<!-- Global JMS Trigger Controls -->
        
        <table width="100%" class="tableView">
        
          <tr>
            <td class="heading" colspan=4>Global JMS Trigger Controls</td>
          </tr>
          
           <tr>
            <td class="subheading2" width="20%">Thread Pool Throttle</td>
            <td class="oddrow-l" width="30%">%value settings/threadPoolMaxThreads encode(html)% (%value settings/threadPoolThrottle encode(html)%% of Server Thread Pool)</td>
            <td class="subheading2" width="20%">Processing Throttle</td>
            <td class="oddrow-l" width="30%">%value settings/processingThrottle encode(html)%%</td>
          </tr>          
        </table>    

<!-- Individual Standard JMS Trigger Controls  -->

        <table width="100%" class="tableView" id="JMS_TABLE">  
        
          <tr>
            <td class="heading" colspan=8>
              &nbsp;Individual Standard JMS Trigger Controls
            </td>
          </tr>

          %ifvar settings/soapTriggerCount%
           <tr>
             <script>writeTDspan("col", 8);</script><a href="#SOAP_TABLE">[Go to Individual SOAP JMS Trigger Controls]</a></td>
           </tr>
          %endif%
   
          <tr name="Standard" style="display: table-row;">
            <td class="subheading2">Trigger Name</td>
            <td class="subheading2" nowrap>
              State&nbsp;&nbsp;
              %ifvar webMethods-wM-AdminUI%
                <a href="settings-jms-edit-state.dsp?triggerName=all&setState=check&jmsTriggerTypeReq=0&type=standard&triggerFilterValue=%value triggerFilterValue encode(url)%&aliasFilterValue=%value aliasFilterValue encode(url)%&destinationFilterValue=%value destinationFilterValue encode(url)%&webMethods-wM-AdminUI=true" >
                  edit&nbsp;all
                </a>
              %else%
                <a href="settings-jms-edit-state.dsp?triggerName=all&setState=check&jmsTriggerTypeReq=0&type=standard&triggerFilterValue=%value triggerFilterValue encode(url)%&aliasFilterValue=%value aliasFilterValue encode(url)%&destinationFilterValue=%value destinationFilterValue encode(url)%" >
                  edit&nbsp;all
                </a>
              %endif%
            </td>
            <td class="subheading2" scope="col" >Status</td>
            <td class="subheading2" scope="col" >Connection Alias Name</td>
            <td class="subheading2" scope="col" nowrap>Destination(s)</td>
            <td class="subheading2" scope="col" >Processing Mode</td>
            <td class="subheading2" scope="col" >Maximum Threads</td>
            <td class="subHeading2" scope="col" >Current Threads</td>       
          </tr> 
          
            <script>resetRows();</script>
            %loop triggerDataList%
            
              %ifvar trigger/jmsTriggerType equals('0')%
 
                <tr id="%value trigger/groupParentId encode(html)%" name="trigList"  >
                
                  <!-- trigger name -->
                  <td onClick="toggle2('%value trigger/groupId encode(html)%', '%value trigger/groupId encode(html)%img');">
                    %ifvar trigger/groupId -isnotempty%            
                      %value node_nsName encode(html)%&nbsp;
                      <img id='%value trigger/groupId encode(html)%img' src="images/expanded_blue.gif" border="0"><a name="StandardAnchor2">
                      &nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    %else%     
                      %ifvar trigger/groupParentId -notempty%
                        &nbsp;&nbsp;&nbsp;%value node_nsName encode(html)%
                      %else%
                        %value node_nsName encode(html)%
                      %endif%
                    %endif%
                  </td>
                  
                  <!-- State -->
                  <script>writeTDnowrap("col");</script>
                   
                    %ifvar trigger/groupParentId -notempty%
                      &nbsp;&nbsp;&nbsp;
                    %endif%

                    %switch trigger/status%
                    
                    %case '0'%
                      %ifvar trigger/currentThreads equals('-1')%

                        <script>              
                          createForm("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "settings-jms-edit-state.dsp", "POST", "BODY");
						              setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "triggerName", "%value node_nsName%");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "setState", "EnabledButNotConnected");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "type", "standard");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "triggerFilterValue", "%value ../triggerFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "aliasFilterValue", "%value ../aliasFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "destinationFilterValue", "%value ../destinationFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "groupHeader", "%value trigger/groupHeader encode(url)%");
                        </script>
            
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">
                        
					              <script>
							            if(is_csrf_guard_enabled && needToInsertToken) {
								            document.write('<a href="javascript:document.htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%.submit();">%value trigger/localizedState%<br></a>');
						              }else {
						              		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=EnabledButNotConnected&type=standard&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%&webMethods-wM-AdminUI=true">%value trigger/localizedState%<br></a>');
											}
											else {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=EnabledButNotConnected&type=standard&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%">%value trigger/localizedState%<br></a>');
											}
							            }
					              </script>
        
                      %else%
                        <script>
						              createForm("htmlform_settings_jms_edit_state_enabled_%value $index%", "settings-jms-edit-state.dsp", "POST", "BODY");
						              setFormProperty("htmlform_settings_jms_edit_state_enabled_%value $index%", "triggerName", "%value node_nsName%");
						              setFormProperty("htmlform_settings_jms_edit_state_enabled_%value $index%", "setState", "Enabled");
						              setFormProperty("htmlform_settings_jms_edit_state_enabled_%value $index%", "type", "standard");
						              setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "triggerFilterValue", "%value ../triggerFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "aliasFilterValue", "%value ../aliasFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "destinationFilterValue", "%value ../destinationFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "groupHeader", "%value trigger/groupHeader encode(url)%");
						            </script>
                        
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">         
                        
                        <script>
							            if(is_csrf_guard_enabled && needToInsertToken) {
							              document.write('<a href="javascript:document.htmlform_settings_jms_edit_state_enabled_%value $index%.submit();">%value trigger/localizedState%<br></a>');
						              }else {
						              		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Enabled&type=standard&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%&webMethods-wM-AdminUI=true">%value trigger/localizedState%<br></a>');
											}
											else {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Enabled&type=standard&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%">%value trigger/localizedState%<br></a>');
											}
						              }
					              </script>                      
                      %endif%
                      
                    %case '1'%
                      <script>
					              createForm("htmlform_settings_jms_edit_state_disabled_%value $index%", "settings-jms-edit-state.dsp", "POST", "BODY");
					              setFormProperty("htmlform_settings_jms_edit_state_disabled_%value $index%", "triggerName", "%value node_nsName%");
					              setFormProperty("htmlform_settings_jms_edit_state_disabled_%value $index%", "setState", "Disabled");
					              setFormProperty("htmlform_settings_jms_edit_state_disabled_%value $index%", "type", "standard");
					              setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "triggerFilterValue", "%value ../triggerFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "aliasFilterValue", "%value ../aliasFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "destinationFilterValue", "%value ../destinationFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "groupHeader", "%value trigger/groupHeader encode(url)%");
					            </script>
								
								      <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">      
								
                      <script>
									      if(is_csrf_guard_enabled && needToInsertToken) {
									        document.write('<a href="javascript:document.htmlform_settings_jms_edit_state_disabled_%value $index%.submit();">%value trigger/localizedState%</a>');
								        }else {
								        	%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Disabled&type=standard&type=standard&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%&webMethods-wM-AdminUI=true">%value trigger/localizedState%<br></a>');
											}
											else {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Disabled&type=standard&type=standard&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%">%value trigger/localizedState%<br></a>');
											}
								        }
							        </script>
                       
                    %case '2'%                     
                      <script>
					              createForm("htmlform_settings_jms_edit_state_suspended_%value $index%", "settings-jms-edit-state.dsp", "POST", "BODY");
					              setFormProperty("htmlform_settings_jms_edit_state_suspended_%value $index%", "triggerName", "%value node_nsName%");
					              setFormProperty("htmlform_settings_jms_edit_state_suspended_%value $index%", "setState", "Suspended");
					              setFormProperty("htmlform_settings_jms_edit_state_suspended_%value $index%", "type", "standard");
					              setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "triggerFilterValue", "%value ../triggerFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "aliasFilterValue", "%value ../aliasFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "destinationFilterValue", "%value ../destinationFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_jms_edit_state_enabled_not_connected_%value $index%", "groupHeader", "%value trigger/groupHeader encode(url)%");
					            </script>
					            
                      <img style="width: 13px; height: 13px;" alt="suspended" border="0" src="images/yellow_check.png">
					            
                      <script>
						            if(is_csrf_guard_enabled && needToInsertToken) {
					              	document.write('<a href="javascript:document.htmlform_settings_jms_edit_state_suspended_%value $index%.submit();">%value trigger/localizedState%<br></a>');
					              }else {
					                %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Suspended&type=standard&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%&webMethods-wM-AdminUI=true">%value trigger/localizedState%<br></a>');
									}
									else {
										document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Suspended&type=standard&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%">%value trigger/localizedState%<br></a>');
									}
					              }
				              </script>
                               
                    %case%
                                   
                      <!-- Trigger Group State -->
                      
                      %ifvar trigger/isGroupRunning%
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">
                        
                      %else%
                        %ifvar trigger/stateLocalizedString equals('Disabled')%
                        %else%  
                          <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">
                        
                        %endif%
                      %endif%
                      <font color=#007AA3>%value trigger/localizedState%</font>
                    %end%  
                  </td>
   
                  <!-- Status -->
                  %ifvar trigger/groupParentId -notempty%
                    %ifvar trigger/lastError%
                      <td>
                        &nbsp;&nbsp;&nbsp;<font color=red>%value trigger/statusLocalizedString%</font>
                      </td> 
                    %else%
                      <td nowrap="true">
                        &nbsp;&nbsp;&nbsp;%value trigger/statusLocalizedString%
                      </td>
                    %endif%     
                  %else%
                    %ifvar trigger/lastError%
                      <td><font color=red>%value trigger/statusLocalizedString encode(html)%</font></td>
                    %else%
                      <td nowrap="true">
                      %ifvar trigger/isGroupEnabled equals('true')%
                        %value trigger/statusLocalizedString%
                      %else%
                        %value trigger/statusLocalizedString%
                      %endif%
                      </td>
                    %endif%              
                  %endif%
                  
                  <!-- Alias, Dest, Mode, Max, Current, Error --> 
                  %ifvar trigger/groupParentId -notempty%
                    <td>&nbsp;&nbsp;&nbsp;%value trigger/aliasName encode(html)%</td>
                    <td><p style="margin-left: 10px"> %value trigger/destinationsString encode(html)%</p></td>
                    <td>&nbsp;&nbsp;&nbsp;%value trigger/processingModeLocalizedString encode(html)%</td>
                    <td>&nbsp;&nbsp;&nbsp;%value trigger/maxThreadsString encode(html)%</td>         
                    <td>&nbsp;&nbsp;&nbsp;%value trigger/currentThreadsLocalizedString encode(html)%</td>      
                    %ifvar trigger/lastError%
                      <tr id="%value trigger/groupParentId encode(html)%" name="Standard" style="display: table-row;">
                        <td colspan="8">
                          &nbsp;&nbsp;&nbsp;<font color=red>%value trigger/lastError encode(html)%</font>
                        </td>
                      </tr>
                    %endif%  
                    
                  %else%
                    <script>writeTD("row-l");</script>%value trigger/aliasName encode(html)%</td>
                    <script>writeTD("row-l");</script>%value trigger/destinationsString encode(html)%</td>
                    <script>writeTD("row-l");</script>%value trigger/processingModeLocalizedString encode(html)%</td>
                    <script>writeTD("row-l");</script>%value trigger/maxThreadsString encode(html)%</td>
                    <script>writeTDnowrap("row-l");</script>%value trigger/currentThreadsLocalizedString encode(html)%</td>   
                    %ifvar trigger/lastError%
                      <tr id="%value trigger/groupParentId encode(html)%" name="Standard" style="display: table-row;">
                        <td colspan="8">
                          <font color=red>%value trigger/lastError encode(html)%</font>
                        </td>
                      </tr>
                    %endif%           
                  %endif%            
                </tr>
                
                <script>swapRows();</script>        
              %endif%

            %endloop%
        </table>

<!-- Individual SOAP JMS Trigger Controls  -->
      
        %ifvar settings/soapTriggerCount%
        
        <table name="triggerlist" width="100%" class="tableView" id="SOAP_TABLE">  
        
          <tr>
            <td class="heading" colspan=8 name="SOAPAnchor">
              &nbsp;Individual SOAP JMS Trigger Controls
            </td>
          </tr>
          
          <tr>
            <script>writeTDspan("col", 8);</script><a href="#JMS_TABLE">[Go to Individual Standard JMS Trigger Controls]</a></td>
          </tr>
   
          <tr name="SOAP" style="display: table-row;">
            <TH class="subheading2" scope="col">Trigger Name</TH>
            <TH class="subheading2" scope="col" nowrap>
              State&nbsp;&nbsp;
			  %ifvar webMethods-wM-AdminUI%
	              <a href="settings-jms-edit-state.dsp?triggerName=all&setState=check&jmsTriggerTypeReq=0&type=soap&triggerFilterValue=%value triggerFilterValue encode(url)%&aliasFilterValue=%value aliasFilterValue encode(url)%&destinationFilterValue=%value destinationFilterValue encode(url)%&webMethods-wM-AdminUI=true">
	                edit&nbsp;all
	              </a>
			  %else%
	              <a href="settings-jms-edit-state.dsp?triggerName=all&setState=check&jmsTriggerTypeReq=0&type=soap&triggerFilterValue=%value triggerFilterValue encode(url)%&aliasFilterValue=%value aliasFilterValue encode(url)%&destinationFilterValue=%value destinationFilterValue encode(url)%">
	                edit&nbsp;all
	              </a>
			  %endif%
            </TH>
            <TH class="subheading2" scope="col" >Status</TH>
            <TH class="subheading2" scope="col" >Connection Alias Name</TH>
            <TH class="subheading2" scope="col" nowrap>Destination(s)</TH>
            <TH class="subheading2" scope="col" >Processing Mode</TH>
            <TH class="subheading2" scope="col" >Maximum Threads</TH>
            <TH class="subHeading2" scope="col" >Current Threads</TH>   <!-- we were using oddcol-l -->       
          </tr> 
          
            <script>resetRows();</script>
            %loop triggerDataList%
          
              %ifvar trigger/jmsTriggerType equals('1')%
                
                 <tr id="%value trigger/groupParentId encode(html)%" name="trigList"  >
                  
                  <!-- trigger name -->
                  <td onClick="toggle2('%value trigger/groupId encode(html)%', '%value trigger/groupId encode(html)%img');">  <!-- xxx -->
                    %ifvar trigger/groupId -isnotempty%            
                      %value node_nsName encode(html)%&nbsp;
                      <img id='%value trigger/groupId encode(html)%img' src="images/expanded_blue.gif" border="0"><a name="StandardAnchor2">
                      &nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    %else%     
                      %ifvar trigger/groupParentId -notempty%
                        &nbsp;&nbsp;&nbsp;%value node_nsName encode(html)%
                      %else%
					    %ifvar trigger/wseAlias -notempty%
						  <script>
						  createForm("htmlform_endpoint_trigger_details_%value trigger/wseAlias%", "endpoint-trigger-details.dsp", "POST", "BODY");
						  setFormProperty("htmlform_endpoint_trigger_details_%value trigger/wseAlias%", "triggerName", "%value node_nsName%");
						  getURL("endpoint-trigger-details.dsp?triggerName=%value node_nsName%", "javascript:document.htmlform_endpoint_trigger_details_%value trigger/wseAlias%.submit();", "WS Endpoint Trigger: %value trigger/wseAlias%");						  
						  </script>
						%else%
                          %value node_nsName encode(html)%
						%endif%
                      %endif%
                    %endif%
                  </td>
                  
                  <!-- State -->
                  <script>writeTDnowrap("col");</script>
                   
                    %ifvar trigger/groupParentId -notempty%
                      &nbsp;&nbsp;&nbsp;
                    %endif%
                   
                    %switch trigger/status%
                    
                    %case '0'%
                      %ifvar trigger/currentThreads equals('-1')%

                        <script>              
                          createForm("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "settings-jms-edit-state.dsp", "POST", "BODY");
						              setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "triggerName", "%value node_nsName%");
                          setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "setState", "EnabledButNotConnected");
                          setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "type", "soap");
                          setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "triggerFilterValue", "%value ../triggerFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "aliasFilterValue", "%value ../aliasFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "destinationFilterValue", "%value ../destinationFilterValue encode(url)%");
					          	    setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "groupHeader", "%value trigger/groupHeader encode(url)%");
                        </script>
            
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">
					
                        <script>
							            if(is_csrf_guard_enabled && needToInsertToken) {
							              document.write('<a href="javascript:document.htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%.submit();">%value trigger/localizedState%<br></a>');
						              }else {
						              		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=EnabledButNotConnected&type=soap&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%&webMethods-wM-AdminUI=true">%value trigger/localizedState%<br></a>');
											}
											else {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=EnabledButNotConnected&type=soap&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%">%value trigger/localizedState%<br></a>');
											}
							            }
					              </script>
      
                      %else%
                        <script>
						              createForm("htmlform_settings_soapjms_edit_state_enabled_%value $index%", "settings-jms-edit-state.dsp", "POST", "BODY");
						              setFormProperty("htmlform_settings_soapjms_edit_state_enabled_%value $index%", "triggerName", "%value node_nsName%");
						              setFormProperty("htmlform_settings_soapjms_edit_state_enabled_%value $index%", "setState", "Enabled");
						              setFormProperty("htmlform_settings_soapjms_edit_state_enabled_%value $index%", "type", "soap");
						              setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "triggerFilterValue", "%value ../triggerFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "aliasFilterValue", "%value ../aliasFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "destinationFilterValue", "%value ../destinationFilterValue encode(url)%");
                          setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "groupHeader", "%value trigger/groupHeader encode(url)%");
						            </script>
                        
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">
                        
						            <script>
							            if(is_csrf_guard_enabled && needToInsertToken) {
							              document.write('<a href="javascript:document.htmlform_settings_soapjms_edit_state_enabled_%value $index%.submit();">%value trigger/localizedState%<br></a>');
						              }else {
						              		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Enabled&type=soap&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%&webMethods-wM-AdminUI=true">%value trigger/localizedState%<br></a>');
											}
											else {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Enabled&type=soap&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%">%value trigger/localizedState%<br></a>');
											}
						              }
					              </script>
                                              
                      %endif%
                      
                    %case '1'%
                      <script>
					              createForm("htmlform_settings_soapjms_edit_state_disabled_%value $index%", "settings-jms-edit-state.dsp", "POST", "BODY");
					              setFormProperty("htmlform_settings_soapjms_edit_state_disabled_%value $index%", "triggerName", "%value node_nsName%");
					              setFormProperty("htmlform_settings_soapjms_edit_state_disabled_%value $index%", "setState", "Disabled");
					              setFormProperty("htmlform_settings_soapjms_edit_state_disabled_%value $index%", "type", "soap");
					              setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "triggerFilterValue", "%value ../triggerFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "aliasFilterValue", "%value ../aliasFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "destinationFilterValue", "%value ../destinationFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "groupHeader", "%value trigger/groupHeader encode(url)%");
					            </script>
							
							        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">
							
                      <script>
								        if(is_csrf_guard_enabled && needToInsertToken) {
								          document.write('<a href="javascript:document.htmlform_settings_soapjms_edit_state_disabled_%value $index%.submit();">%value trigger/localizedState%</a>');
							          }else {
							          		%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
											var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
											if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Disabled&type=soap&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%&webMethods-wM-AdminUI=true">%value trigger/localizedState%<br></a>');
											}
											else {
												document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Disabled&type=soap&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%">%value trigger/localizedState%<br></a>');
											}
							          }
						          </script>

                    %case '2'%                     
                      <script>
					              createForm("htmlform_settings_soapjms_edit_state_suspended_%value $index%", "settings-jms-edit-state.dsp", "POST", "BODY");
					              setFormProperty("htmlform_settings_soapjms_edit_state_suspended_%value $index%", "triggerName", "%value node_nsName%");
					              setFormProperty("htmlform_settings_soapjms_edit_state_suspended_%value $index%", "setState", "Suspended");
					              setFormProperty("htmlform_settings_soapjms_edit_state_suspended_%value $index%", "type", "soap");
					              setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "triggerFilterValue", "%value ../triggerFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "aliasFilterValue", "%value ../aliasFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "destinationFilterValue", "%value ../destinationFilterValue encode(url)%");
                        setFormProperty("htmlform_settings_soapjms_edit_state_enabled_not_connected_%value $index%", "groupHeader", "%value trigger/groupHeader encode(url)%");
					            </script>
					            
                      <img style="width: 13px; height: 13px;" alt="suspended" border="0" src="images/yellow_check.png">
                      
                      <script>
							          if(is_csrf_guard_enabled && needToInsertToken) {
							            document.write('<a href="javascript:document.htmlform_settings_soapjms_edit_state_suspended_%value $index%.submit();">%value trigger/localizedState%<br></a>');
						            }else {
						            	%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
										var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
										if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
											document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Suspended&type=soap&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%&webMethods-wM-AdminUI=true">%value trigger/localizedState%<br></a>');
										}
										else {
											document.write('<a href="settings-jms-edit-state.dsp?triggerName=%value node_nsName encode(url)%&setState=Suspended&type=soap&triggerFilterValue=%value ../triggerFilterValue encode(url)%&aliasFilterValue=%value ../aliasFilterValue encode(url)%&destinationFilterValue=%value ../destinationFilterValue encode(url)%&groupHeader=%value trigger/groupHeader encode(url)%">%value trigger/localizedState%<br></a>');
										}
						            }
					            </script>
					  
                      
                    %case%
                      %ifvar trigger/isGroupRunning%
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.png">
                      %else%
                        %ifvar trigger/stateLocalizedString equals('Disabled')%
                        %else%
                          <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/yellow_check.png">
                        %endif%
                      %endif%
                      <font color=#007AA3>%value trigger/localizedState%</font>
                    %end%  
                  </td>
   
                  <!-- Status -->
                  %ifvar trigger/groupParentId -notempty%
                    %ifvar trigger/lastError%
                      <td>
                        &nbsp;&nbsp;&nbsp;<font color=red>%value trigger/statusLocalizedString%</font>
                      </td> 
                    %else%
                      <td nowrap="true">
                        &nbsp;&nbsp;&nbsp;%value trigger/statusLocalizedString%
                      </td>
                    %endif%     
                  %else%
                    %ifvar trigger/lastError%
                      <td>%value trigger/statusLocalizedString encode(html)%</td>
                    %else%
                      <td nowrap="true">
                      %ifvar trigger/isGroupEnabled equals('true')%
                        %value trigger/statusLocalizedString%
                      %else%
                        %value trigger/statusLocalizedString%
                      %endif%
                      </td>
                    %endif%              
                  %endif%
                  
                  <!-- Alias, Dest, Mode, Max, Current, Error --> 
                  %ifvar trigger/groupParentId -notempty%
                    <td>&nbsp;&nbsp;&nbsp;%value trigger/aliasName encode(html)%</td>
                    <td><p style="margin-left: 10px"> %value trigger/destinationsString encode(html)%</p></td>
                    <td>&nbsp;&nbsp;&nbsp;%value trigger/processingModeLocalizedString encode(html)%</td>
                    <td>&nbsp;&nbsp;&nbsp;%value trigger/maxThreadsString encode(html)%</td>         
                    <td>&nbsp;&nbsp;&nbsp;%value trigger/currentThreadsLocalizedString encode(html)%</td>      
                    %ifvar trigger/lastError%
                      <tr id="%value trigger/groupParentId encode(html)%" name="Standard" style="display: table-row;">
                        <td colspan="8">
                          &nbsp;&nbsp;&nbsp;<font color=red>%value trigger/lastError encode(html)%</font>
                        </td>
                      </tr>
                    %endif%  
                    
                  %else%
                    <script>writeTD("row-l");</script>%value trigger/aliasName encode(html)%</td>
                    <script>writeTD("row-l");</script>%value trigger/destinationsString encode(html)%</td>
                    <script>writeTD("row-l");</script>%value trigger/processingModeLocalizedString encode(html)%</td>
                    <script>writeTD("row-l");</script>%value trigger/maxThreadsString encode(html)%</td>
                    <script>writeTDnowrap("row-l");</script>%value trigger/currentThreadsLocalizedString encode(html)%</td>   
                    %ifvar trigger/lastError%
                      <tr id="%value trigger/groupParentId encode(html)%" name="Standard" style="display: table-row;">
                        <td colspan="8">
                          <font color=red>%value trigger/lastError encode(html)%</font>
                        </td>
                      </tr>
                    %endif%           
                  %endif%            
                </tr>
                
                <script>swapRows();</script>        
              %endif%
            %endloop%
      %endinvoke%
    </table>    
  </body>
</html>
