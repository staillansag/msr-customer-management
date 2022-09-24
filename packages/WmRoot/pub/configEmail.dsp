%ifvar mode equals('edit')%
  %ifvar disableport equals('true')%
    %invoke wm.server.net.listeners:disableListener%
    %endinvoke%
  %endif%
%endif%


%invoke wm.server.net.listeners:getListener%

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
    <TITLE>Integration Server -- Port Access Management</TITLE>

	<STYLE>
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
	</STYLE>

    <SCRIPT Language="JavaScript">
	var authCodeValue;
	var windowOpened = false;
	var windowObjectReference = null;
	var containsCode = null;
	
        function confirmDisable()
        {
          var enabled = "%value ../listening encode(javascript)%";

          if(enabled == "primary")
          {
            alert("Port must be disabled to edit these settings.  Primary port cannot be disabled.  To edit these settings, please select a new primary port");
            return false;
          }
          else if(enabled == "true")
          {
            if(confirm("Port must be disabled so that you can edit these settings.  Would you like to disable the port?"))
            {
				if(is_csrf_guard_enabled && needToInsertToken) {
					createForm("htmlForm_configEmail", 'configEmail.dsp', "POST", "HEAD");
					setFormProperty("htmlForm_configEmail", "listenerKey", "%value listenerKey%");
					setFormProperty("htmlForm_configEmail", "pkg", "%value pkg%");
					%ifvar listenerType%
					setFormProperty("htmlForm_configEmail", "listenerType", "%value listenerType%");
					%endif%
					setFormProperty("htmlForm_configEmail", "mode", "edit");
					setFormProperty("htmlForm_configEmail", "disableport", "true");						
				    setFormProperty("htmlForm_configEmail", _csrfTokenNm_, _csrfTokenVal_);
					
					var htmlForm_configEmail = document.forms["htmlForm_configEmail"];
					htmlForm_configEmail.submit();
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
					  document.location.replace("configEmail.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true&webMethods-wM-AdminUI=true");
					}
					else {
					  document.location.replace("configEmail.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true");
					}
				}
            }
          }
          else {
			  if(is_csrf_guard_enabled && needToInsertToken) {
			    createForm("htmlForm_configEmail2", 'configEmail.dsp', "POST", "HEAD");
				setFormProperty("htmlForm_configEmail2", "listenerKey", "%value listenerKey%");
				setFormProperty("htmlForm_configEmail2", "pkg", "%value pkg%");
				%ifvar listenerType%
				setFormProperty("htmlForm_configEmail2", "listenerType", "%value listenerType%");
				%endif%
				setFormProperty("htmlForm_configEmail2", "mode", "edit");
				setFormProperty("htmlForm_configEmail2", _csrfTokenNm_, _csrfTokenVal_);
				var htmlForm_configEmail2 = document.forms["htmlForm_configEmail2"];
		        htmlForm_configEmail2.submit();
				   
			} else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				    document.location.replace("configEmail.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&webMethods-wM-AdminUI=true");
				}
				else {
				    document.location.replace("configEmail.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit");
				}
			}
				   
			  }
		    
          return false;
        }

      var userndx;

        function setupData() {
            %ifvar port%
            document.properties.operation.value = "update";
            document.properties.oldPkg.value = "%value pkg encode(url)%";
            %else%
            document.properties.operation.value = "add";
            %endif%
            
        userndx=-1;
        //TODO change the validation according to the new runasuser sub changes
	/*
        // set user to default by default
        for (count=0; count<document.properties.runuser.length; count++ ) {
          if (document.properties.runuser[count].value.toLowerCase()=="default" ) {
          userndx=count;
          break;
          }
        }

        // No default user, so find next user that is not administrator
        if (userndx==-1) {
          for (count=1; count<document.properties.runuser.length; count++ ) {
            if (document.properties.runuser[count].value.toLowerCase()!="administrator" ) {
            userndx=count;
            break;
            }
          }
        }

        // no valid user found
        if (userndx==-1) userndx=0;
        */
        }

      function setMultithread(value) {

        if ( value == true ) {
          if ( document.properties.type[0].checked==true ) {
            alert("Cannot use multithreading for POP3 servers");
            document.properties.multithread[0].checked=false;
            document.properties.multithread[1].checked=true;
            return false;
          }
          document.properties.num_threads.value = 3;
        }
        else {
          document.properties.num_threads.value = 0;
        }

        return true;

      }

      function setLogout(value) {

        if ( value == true ) {
          if ( document.properties.type[0].checked==false ) {
            alert("Log out only supported for POP3 servers");
            document.properties.logout[0].checked=false;
            document.properties.logout[1].checked=true;
            return false;
          }
        }

        return true;

      }

      function setThreads() {

        if (document.properties.multithread[0].checked == false) {
          document.properties.num_threads.value="0";
          return false;
        }

        return true;

      }

      function setRemove() {

        if ( document.properties.type[0].checked==true ) {
          alert("Messages from POP3 servers are always deleted");
          document.properties.remove[0].checked=true;
          document.properties.remove[1].checked=false;
          return false;
        }
        return true;
      }

	  function setUrlEncodedBody() {

        if ( document.properties.authorize[0].checked==true ) {
          alert("Must first disable authorization");
          document.properties.urlEncodedBody[0].checked=true;
          document.properties.urlEncodedBody[1].checked=false;
          return false;
        }
        return true;
	  }

	  function setBreakMPMsg() {
		return true;
	  }

	  function passEmailHdrs() {
	  	return true;
	  }

      function setBadRemove() {

        if ( document.properties.type[0].checked==true ) {
          alert("Messages from POP3 servers are always deleted");
          document.properties.bad_remove[0].checked=true;
          document.properties.bad_remove[1].checked=false;
          return false;
        }
        return true;
      }

      function setAuthorize(value) {


        if (value == true) {

       		if ( document.properties.urlEncodedBody[0].checked==false ) {
          		alert("Must first enable URL encoded email body");
          		document.properties.authorize[0].checked=false;
          		document.properties.authorize[1].checked=true;
          		return false;
       	 	}
          	//document.properties.runuser.selectedIndex = 0;
          	disableUserSearch();
        } else {
          //document.properties.runuser.selectedIndex = userndx;
          enableUserSearch();
        }
        return true;
      }
	  
	  function setUseJSSE(value) {


        if (value == true) {

       		if ( document.properties.urlEncodedBody[0].checked==false ) {
          		document.properties.useJSSE[0].checked=false;
          		document.properties.useJSSE[1].checked=true;
          		return false;
       	 	}
          	disableuseJSSE();
        } else {
          enableuseJSSE();
        }
        return true;
      }
	  
	  	  function setAuth(value) {
        if (value == "Basic") {
       		if ( document.properties.urlEncodedBody[0].checked==false ) {
          		document.properties.auth[0].checked=true;
          		document.properties.auth[1].checked=false;
          		return false;
       	 	}
          	enableBasic();
        } else {
          enableOAuth();
        }
        return true;
      }
	  
	  function respondToClientAuthChange(cAuth) {
		if (cAuth == 'Basic') {
			setAuth("Basic");
		}
		else {
			setAuth("OAuth");
		}
	}


      function setUser(newuser) {
	/*
        if ((document.properties.authorize[0].checked==true) &&
          (document.properties.runuser.selectedIndex>0) ) {
          document.properties.runuser.selectedIndex=0;
          alert ("Must turn off authorization before selecting user");
          return false;
        }
        else if ( (document.properties.authorize[0].checked==false)
          && (document.properties.runuser.selectedIndex==0)) {
          alert("Must select valid user if authorization is turned off");
          return false;
        }

        userndx=document.properties.runuser.selectedIndex;
        */
        return true;

      }
  
      function disableUserSearch(){
       obj = document.getElementById("subUserSearchlink");
       obj.style.display = 'none';       
       document.properties.runuser.disabled=true;
       document.properties.runuser.value="";
       
      }
      
      function enableUserSearch(){
       obj = document.getElementById("subUserSearchlink");
       obj.style.display = 'inline';       
       document.properties.runuser.disabled=false;
      }
	  
	  function disableuseJSSE(){
       obj = document.getElementById("subUserSearchlink");
       obj.style.display = 'none';       
       document.properties.useJSSE.disabled=false;
       document.properties.useJSSE.value="false";
      }
      
      function enableuseJSSE(){
       obj = document.getElementById("subUserSearchlink");
       obj.style.display = 'inline';       
       document.properties.useJSSE.disabled=true;
	   document.properties.useJSSE.value="true";
      }
	  
	    function enableOAuth(){
			if ( document.properties.type[0].checked==true ) {
            alert("Cannot use OAuth for POP3 servers");
				enableBasic();
          		return false;
          }
       document.properties.auth.value="OAuth";
	   auth = "OAuth";
	   obj = document.getElementById("password");
       obj.style.display = 'inline';
	   document.properties.password.disabled=true;
	   document.properties.authURLID.disabled=false;
	   document.properties.clientID.disabled=false;
	   document.properties.clientSecret.disabled=false;
	   document.properties.scope.disabled=false;
	   document.properties.redirectURL.disabled=false;
	   document.properties.accessTokenURL.disabled=false;      
      }
      
      function enableBasic(){   
	   document.properties.auth.value="Basic";
	   auth = "Basic";
	   obj = document.getElementById("password");
       obj.style.display = 'inline';       
       document.properties.password.disabled=false;
	   obj1 = document.getElementById("authURLID");
       obj1.style.display = 'inline';
	   document.properties.authURLID.disabled=true;
	   document.properties.clientID.disabled=true;
	   document.properties.clientSecret.disabled=true;
	   document.properties.scope.disabled=true;
	   document.properties.redirectURL.disabled=true;
	   document.properties.accessTokenURL.disabled=true;
      }
 
      function setType(server_type) {
        if (server_type == 1) { // pop3
          document.properties.multithread[0].checked=false;
          document.properties.multithread[1].checked=true;
        }

        if (server_type == 1) { // pop3
          document.properties.remove[0].checked=true;
          document.properties.remove[1].checked=false;
        }

        if (server_type == 1) { // pop3
          document.properties.bad_remove[0].checked=true;
          document.properties.bad_remove[1].checked=false;
        }
		
		if (server_type == 1) { // pop3
          enableBasic();
        }

        if (server_type == 2) {  // imap
          document.properties.logout[0].checked=false;
          document.properties.logout[1].checked=true;
        }

      }
      
      function verify() {

        var e = document.properties.host.value;

        if (( e == null ) || ( e == "" ) || isblank(e)) {
          alert("Host Name required");
          return (false);
        }

        var e = document.properties.user.value;

        if (( e == null ) || ( e == "" ) || isblank(e)) {
          alert("User Name required");
          return (false);
        }

        var e = document.properties.server_port.value;
        if (( e != null ) && ( e != "" ) && !isblank(e)) {

          for (count=0; count<e.length; count++){
            var sstr = e.substring(count,count+1);
            var test = parseInt(sstr);
            if (isNaN(test)) {
              alert("Invalid Port "+e);
              return (false);
            }
          }

        }


        for (count=0; count<document.properties.interval.value.length; count++){
          var sstr = document.properties.interval.value.substring(count,count+1);
          var test = parseInt(sstr);
          if (isNaN(test)) {
            alert("Invalid Time Interval: valid range 1-9999");
            return (false);
          }
        }

        var interval = parseInt(document.properties.interval.value, 10);
        if ((isNaN(interval)) || (interval<1) || (interval>9999)) {
          alert("Invalid Time Interval: valid range 1-9999");
          return (false);
        }


        for (count=0; count<document.properties.num_threads.value.length; count++){
          var sstr = document.properties.num_threads.value.substring(count,count+1);
          var test = parseInt(sstr);
          if (isNaN(test)) {
            alert("Invalid number of threads: valid range 1-99");
            return (false);
          }
        }

        var num_threads = parseInt(document.properties.num_threads.value, 10);
        if ((isNaN(num_threads)) || (num_threads<0) || (num_threads>99)) {
          alert("Invalid number of threads: valid range 1-99");
          return (false);
        }

        if ((num_threads >0) && (document.properties.multithread[0].checked==false) ) {
          alert("Number of threads must be zero if multithreading is turned off" );
          return (false);
        }

	
	if (! checkLegalHostName (document.properties.host, "host") )
	{
	  return false;                 
	}
	
		var auth = document.properties.auth.value;
		if((auth=="OAuth") ){
		var authurl = document.properties.authURLID.value;
        if (( authurl == null ) || ( authurl == "" ) || isblank(authurl)) {
          alert("Auth URL required");
          return (false);
        }
		if(!isValidURL(authurl)){
		  alert("Auth URL is invalid : " + authurl);
          return (false);
		}

		
		var clientID = document.properties.clientID.value;
        if (( clientID == null ) || ( clientID == "" ) || isblank(clientID)) {
          alert("Client ID required");
          return (false);
        }
		
		var clientSecret = document.properties.clientSecret.value;
		if (( clientSecret == null ) || ( clientSecret == "" ) || isblank(clientSecret)) {
          alert("Client Secret required");
          return (false);
        }

	    var scope = document.properties.scope.value;
        if (( scope == null ) || ( scope == "" ) || isblank(scope)) {
          alert("OAuth Scope required");
          return (false);
        }
		
		var accessTokenURL = document.properties.accessTokenURL.value;
        if (( accessTokenURL == null ) || ( accessTokenURL == "" ) || isblank(accessTokenURL)) {
          alert("Access Token URL required");
          return (false);
        }
		
		if(!isValidURL(accessTokenURL)){
		  alert("Access Token URL is invalid : " + accessTokenURL);
          return (false);
		}
		
		var redirectURL = document.properties.redirectURL.value;
        if (( redirectURL == null ) || ( redirectURL == "" ) || isblank(redirectURL)) {
          alert("Redirect URL required");
          return (false);
         }
		
		if(!isValidRedirectURL(redirectURL)){
		  alert("Redirect URL is invalid " + "If you are accessing Integration Server locally, redirect URLs must be http://localhost:{port}/WmRoot/security-oauth-get-authcode.dsp or https://localhost:{port}/WmRoot/security-oauth-get-authcode.dsp • If you are accessing Integration Server remotely, use https://{ISHostName}:{port}/WmRoot/security-oauth-get-authcode.dsp");
          return (false);
		}		 
		}

        document.properties.submit();
        return (true);
        

      }
	  
	  function isValidRedirectURL(url){
        return url.match(/^((https|http):\/\/)+([0-9A-Fa-f]{2}|[-()_.!~*';?:@&=+$,A-Za-z0-9])+\/WmRoot\/security-oauth-get-authcode.dsp$/);
    }
	
	function isValidURL(url){
        return url.match(/^(ht)tps?:\/\/[a-zA-Z0-9]/);
    }
	  
	   function windowOpen(windowOpenValue){
		
	  if((windowObjectReference == null || windowObjectReference.closed) && windowOpenValue=="true"){
		  	windowOpened = document.createElement("input");
			windowOpened.setAttribute("type", "hidden");	
			windowOpened.setAttribute("name", "windowOpened");
			windowOpened.setAttribute("value", "true");
			document.properties.appendChild(windowOpened);
	    var auth = document.properties.auth.value;
		if((auth=="Basic") ){
			alert("Get code is applicable only for OAuth");
			return;
		}

		var authurl = document.properties.authURLID.value;
        if (( authurl == null ) || ( authurl == "" ) || isblank(authurl)) {
          alert("Auth URL required");
          return;
        }
	
		if(!isValidURL(authurl)){
		  alert("Auth URL is invalid : " + authurl);
          return;
		}
		
		var clientID = document.properties.clientID.value;
        if (( clientID == null ) || ( clientID == "" ) || isblank(clientID)) {
          alert("Client ID required");
          return;
        }
		
		var clientSecret = document.properties.clientSecret.value;
		if (( clientSecret == null ) || ( clientSecret == "" ) || isblank(clientSecret)) {
          alert("Client Secret required");
          return;
        }
				
	    var scope = document.properties.scope.value;
        if (( scope == null ) || ( scope == "" ) || isblank(scope)) {
          alert("OAuth Scope required");
          return;
        }
		
		var accessTokenURL = document.properties.accessTokenURL.value;
        if (( accessTokenURL == null ) || ( accessTokenURL == "" ) || isblank(accessTokenURL)) {
          alert("Access Token URL required");
          return;
        }
		
		if(!isValidURL(accessTokenURL)){
		  alert("Access Token URL is invalid : " + accessTokenURL);
          return;
		}
		var redirectURL = document.properties.redirectURL.value;
        if (( redirectURL == null ) || ( redirectURL == "" ) || isblank(redirectURL)) {
          alert("Redirect URL required");
          return;
         }
		 
		if(!isValidRedirectURL(redirectURL)){
		  alert("Redirect URL is invalid " + "If you are accessing Integration Server locally, redirect URLs must be http://localhost:{port}/WmRoot/security-oauth-get-authcode.dsp or https://localhost:{port}/WmRoot/security-oauth-get-authcode.dsp • If you are accessing Integration Server remotely, use https://{ISHostName}:{port}/WmRoot/security-oauth-get-authcode.dsp");
          return;
		}		 
		 
		   var url = authurl.concat("?response_type=code&client_id=").concat(clientID).concat("&scope=").concat(scope).concat("&redirect_uri=").concat(redirectURL);
				   windowObjectReference = window.open(url,"DescriptiveWindowName",	"resizable,scrollbars,status");
			   }
								setTimeout(function() {
				//Sends request to Redirect URL's Web Page receiveMessage					
				windowObjectReference.postMessage("Get the Auth Code", "*");
				if(( authCodeValue == null ) || ( authCodeValue == "" ) || isblank(authCodeValue)){
					windowOpen('false');
				}
				}, 2000);   
	  }
	  //Listens to Request coming in from Redirect URL Web Page
	  function receiveMessage(event)
	{
	var span = document.getElementById("mySpan");

	span.onclick = function() {
	modal.style.display = "none";
	}
	var modal = document.getElementById("myModal");
	modal.style.display = "none";
	var redirectURL = document.properties.redirectURL.value;
	if (event.origin !== redirectURL){
		var currentURL = event.data;
		containsCode = currentURL.includes("code=");
		if(containsCode){
			authCodeValue = document.createElement("input");
			authCodeValue.setAttribute("type", "hidden");	
			authCodeValue.setAttribute("name", "authCodeValue");
			authCodeValue.setAttribute("value", currentURL);
			document.properties.appendChild(authCodeValue);
			modal.style.display = "block";
			windowObjectReference.close();
			return true;
   } else {
	   return false;
   }
  }
}
//Event Listener
window.addEventListener("message", receiveMessage, true);
      
      
      function checkLegalHostName(field, fieldName)
 	        	  {
 	      var name = field.value;
 	      var illegalChars = "#&@^!%$/\\`;,~+=)(|}{][><\"";

 	      for (var i=0; i<illegalChars.length; i++)
 	      {
 		if (name.indexOf(illegalChars.charAt(i)) >= 0)
 		{
 		  alert ("Server Host Name contains illegal character: '" + illegalChars.charAt(i) + "'");
		 return false;
	       }
	     }
	
   	  return true;
      }
    </SCRIPT>
    	<base target="_self">
    		<style>
    	  		.listbox  { width: 100%; }
		</style>

  </HEAD>
  <body onLoad="%ifvar mode equals('edit')%setupData();%endif%setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_Email_PortConfigScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar mode equals('view')%
            View Email Client Details
          %else%
            Edit Email Client Configuration
          %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
             <li>
			
			<script>
						    createForm("htmlform_http_security_ports", "security-ports.dsp", "POST", "BODY");
           </script>			
			<script>getURL("security-ports.dsp", "javascript:document.htmlform_http_security_ports.submit();", "Return to Ports");</script>
			
		  </li>
            %ifvar mode equals('view')%
              %ifvar listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit Email Client Configuration
                </A></LI>
              %endif%
            %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
          <TABLE class="tableForm">

            <tr>
              <td class="heading" colspan="4">Email Client Listener Configuration</td>
            </tr>

            <form name="properties" method="post" action="security-ports.dsp" onsubmit="return verify();">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            <input type="hidden" name="factoryKey" value="webMethods/Email">
            <input type="hidden" name="operation">
            <input type="hidden" name="listenerKey" value="%value listenerKey encode(htmlattr)%">
            <input type="hidden" name="oldPkg">
	    <input type="hidden" name="passwordChanged" value="false">
		<input type="hidden" name="clientSecretChanged" value="false">

            <tr>
        <td valign=top>
        <table class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%" width="100%">

        <tr><td class="heading" colspan=2>Package</td></tr>
        <tr><td class="evenrow"><label for="pkg">Package Name</label></td>
          <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            %ifvar mode equals('view')%
              %value pkg encode(html)%
            %else%
              %invoke wm.server.packages:packageList%
              <select id="pkg" name="pkg" width=30%>
              %loop packages%
              %ifvar enabled equals('false')%
              %else%
              %ifvar ../pkg -notempty%
                <option size="15" width=30% %ifvar ../pkg vequals(name)%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
              %else%
                <option size="15" width=30% %ifvar name equals('WmRoot')%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
              %endif%
              %endif%
              %endloop%
              </select>
              </td>
              </tr>
              %endinvoke%
            %endif%
                  <tr>
          <td class="oddrow"><label for="portAlias">Alias</label></td>
          <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
            %ifvar listenerKey -notempty%
              %value portAlias encode(html)% 
            %else%
              <input id="portAlias" name="portAlias" value="%value portAlias encode(htmlattr)%" size="60">
            %endif%
          </td>
      </tr>
      <tr>
          <td class="evenrow"><label for="portDescription">Description (optional)</label></td>
          <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            %ifvar ../mode equals('view')%
              %value portDescription encode(html)%
            %else%
              <input id="portDescription" name="portDescription" value="%value portDescription encode(htmlattr)%" size="60">
            %endif%
          </td>
      </tr>

            <tr>
              <td class="space" colspan="2">&nbsp;</td>
            </tr>

        <tr><td class="heading" colspan=2>Server Information</td></tr>
		  %ifvar ../mode equals('edit')%
			<tr>
				<td class="oddrow">Enable</td>
				<td class="oddrow-l">
				  <input type="radio" name="enable" id="enable1"  value="yes" ><label for="enable1">Yes</label></input>
				  <input type="radio" name="enable" id="enable2"  value="no" checked><label for="enable2">No</label></input>
				</td>
			</tr>
		  %endif%
	    <tr>
	      <td class="evenrow">Type</td>
	      <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
		%ifvar mode equals('view')%
		  %switch type%
		  %case 'imap'%IMAP
		  %case 'pop3'%POP3
		  %endswitch%
		%else%
		  <input type="radio" value="pop3" name="type" id="type1"  onclick="setType(1);"
		    %ifvar type equals('pop3')%checked%endif%><label for="type1">POP3</label>
		      <input type="radio" name="type" id="type2"  value="imap"onclick="setType(2);"
		    %ifvar type equals('pop3')%%else%checked%endif%><label for="type2">IMAP</label></input>
		%endif%
	      </td>
            </tr>
          
          <tr>
            <td class="oddrow"><label for="host">Host Name</label></td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit("%value mode encode(javascript)%", 'host', "%value host encode(html_javascript)%");</script>
            </td>
          </tr>

          <tr>
            <td class="evenrow"><label for="server_port">Port (optional)</label></td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              <script>writeEdit("%value mode encode(javascript)%", 'server_port', "%value server_port encode(html_javascript)%");</script>
            </td>
          </tr>
          
          <tr>
            <td class="oddrow"><label for="user">User Name</label></td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit("%value mode encode(javascript)%", 'user', "%value user encode(html_javascript)%");</script>
            </td>
          </tr>
		  
		  <tr>
            <td class="evenrow">Authentication</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch auth%
                  %case 'OAuth'%OAuth
                  %case%Basic Authentication
                %endswitch%
              %else%
					  <select name="auth" id="auth" onchange="
					  respondToClientAuthChange(this.value, '%value listenerType%');">
					  <option %ifvar auth equals('Basic')%selected %endif%value="Basic">Basic Authentication</option>
				 	   		<option %ifvar auth equals('OAuth')%selected %endif%value="OAuth">OAuth</option>
              %endif%
				</td>
          </tr>
		  
          <tr>
            <td class="evenrow"><label for="password">Password</label></td>
		%ifvar auth equals('OAuth')%
		<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
		*****
              %else%
		    %ifvar ../mode equals('edit')%
			   <input id="password"  type="password" name="password" autocomplete="off" value="*****" onChange="document.properties.passwordChanged.value=true;"DISABLED/>
		    %else%
			   <input id="password" type="password" name="password" autocomplete="off" value=""DISABLED/>
		    %endif%
              %endif%
            </td>
		%else%
				<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
		*****
              %else%
		    %ifvar ../mode equals('edit')%
			   <input id="password"  type="password" name="password" autocomplete="off" value="*****" onChange="document.properties.passwordChanged.value=true;"/>
		    %else%
			   <input id="password" type="password" name="password" autocomplete="off" value=""/>
		    %endif%
              %endif%
            </td>
			%endif%
          </tr>
		  
          <tr>
		  <td  class="oddrow"><label for="authURL">Auth URL</label></td>
           <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		  %ifvar mode equals('view')%
                %value authURLID encode(html)%
              %else%
			  %ifvar auth equals('OAuth')%
              <input id="authURLID" name="authURLID" value="%value authURLID encode(htmlattr)%"></input>
            
		 %else%
              <input id="authURLID" name="authURLID" value="%value authURLID encode(htmlattr)%"DISABLED></input>
		%endif%
		%endif%		
		</td>	
        </tr>
		  
		  <tr>
            <td  class="oddrow"><label for="clientID">Client ID</label></td>
			      <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		  %ifvar mode equals('view')%
                %value clientID encode(html)%
              %else%
			  %ifvar auth equals('OAuth')%

              <input id="clientID" name="clientID" value="%value clientID encode(htmlattr)%"></input>
            
		  %else%
              <input id="clientID" name="clientID" value="%value clientID encode(htmlattr)%"DISABLED></input>
		  %endif%
	      %endif%		
		  </td>		
          </tr>
		  
          <tr>
            <td class="evenrow"><label for="clientSecret">Client Secret</label></td>
		%ifvar auth equals('OAuth')%
		<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
		*****
              %else%
		    %ifvar ../mode equals('edit')%
			   <input id="clientSecret"  type="password" name="clientSecret" autocomplete="off" value="*****" onChange="document.properties.clientSecretChanged.value=true;"/>
		    %else%
			   <input id="clientSecret" type="password" name="clientSecret" autocomplete="off" value=""/>
		    %endif%
              %endif%
            </td>
			%else%
			<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
		*****
              %else%
		    %ifvar ../mode equals('edit')%
			   <input id="clientSecret"  type="password" name="clientSecret" autocomplete="off" value="*****" onChange="document.properties.clientSecretChanged.value=true;"DISABLED/>
		    %else%
			   <input id="clientSecret" type="password" name="clientSecret" autocomplete="off" value=""DISABLED/>
		    %endif%
              %endif%
            </td>
			%endif%
          </tr>
		  
		  <tr>
            <td  class="oddrow"><label for="scope">Scope</label></td>
                      <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		  %ifvar mode equals('view')%
                %value scope encode(html)%
              %else%
			  %ifvar auth equals('OAuth')%

              <input id="scope" name="scope" value="%value scope encode(htmlattr)%"></input>
            
			%else%
              <input id="scope" name="scope" value="%value scope encode(htmlattr)%"DISABLED></input>
			%endif%
			%endif%		
			</td>
          </tr>
		  
		  <tr>
            <td  class="oddrow"><label for="accessTokenURL">Access Token URL</label></td>
                      <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		  %ifvar mode equals('view')%
                %value accessTokenURL encode(html)%
              %else%
			  %ifvar auth equals('OAuth')%

              <input id="accessTokenURL" name="accessTokenURL" value="%value accessTokenURL encode(htmlattr)%"></input>
            
			%else%
              <input id="accessTokenURL" name="accessTokenURL" value="%value accessTokenURL encode(htmlattr)%"DISABLED></input>
			%endif%
			%endif%		
			</td>
          </tr>
		  
   	      <tr>
            <td  class="oddrow"><label for="redirectURL">Redirect URL</label></td>
                     <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		  %ifvar mode equals('view')%
			%value redirectURL encode(html)%
              %else%
			  %ifvar auth equals('OAuth')%

              <input id="redirectURL" name="redirectURL" value="%value redirectURL encode(htmlattr)%"></input>
            
			%else%
              <input id="redirectURL" name="redirectURL" value="%value redirectURL encode(htmlattr)%"DISABLED></input>
			%endif%
			%endif%		
			</td>
          </tr>

		  %ifvar mode equals('view')%
		  <tr>
            <td  class="oddrow"><label for="expiryTime">Access Token Expiry Time</label></td>
                      <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
			%value expiryTime encode(html)%		
		  </td>
        </tr>		  
		%endif%
		
			%ifvar mode equals('edit')%
		   	      <tr>
            <td  class="oddrow"><label for="testlink">Authorization Code</label></td>
                     <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
						<a id="testlink_OAuth" href="javascript:windowOpen('true')">Get Authorization Code</a>			
			</td>
          </tr>
		%endif%

	   <div id="myModal" class="modal" style="display:none">
			<div class="modal-content">
			<span id="mySpan" class="close">&times;</span>
			<p>Received Auth Code</p>
			</div>
	   </div>		
		
	  <tr>
	    <td class="oddrow"><label for="tlsSettings">Transport Layer Security</label></td>
	    <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		%ifvar mode equals('view')%
		  %switch tlsSettings%
			%case 'None'%None
			%case 'Explicit'%Explicit
			%case 'Implicit'%Implicit
			%case%None
		  %endswitch%
		%else%
		  <select id="tlsSettings" name="tlsSettings">
		  <option %ifvar tlsSettings equals('None')%selected %endif%value="None">None</option>
		  <option %ifvar tlsSettings equals('Explicit')%selected %endif%value="Explicit">Explicit</option>
		  <option %ifvar tlsSettings equals('Implicit')%selected %endif%value="Implicit">Implicit</option>
		  </select>
		%endif%
	    </td>
	  </tr>

	  <tr>
		<td class="evenrow"><label for="trustStore">Truststore Alias (optional)</label></td>
		<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
			%ifvar mode equals('view')%
				 %value trustStore encode(html)%
			%else%
				<select id="trustStore" name="trustStore" class="listbox">
						%invoke wm.server.security.keystore:listTrustStores%
								<option name="" value=""></option>
							%loop trustStores%
								%ifvar isLoaded equals('true')%
									<option name="%value keyStoreName encode(htmlattr)%" value="%value keyStoreName encode(htmlattr)%" %ifvar ../trustStore vequals(keyStoreName)%selected%endif%>%value keyStoreName encode(html)%</option>
								%endif%
						   %endloop%
						%endinvoke%
				</select>
			%endif%
		</td>
	    </tr>

          <tr>
            <td class="oddrow"><label for="interval">Time Interval (seconds)</label></td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit("%value mode encode(javascript)%", 'interval', "%value interval encode(html_javascript)%",'interval');</script>
            </td>
          </tr>

          <tr>
            <td class="evenrow">Log out after each mail check</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            %ifvar mode equals('view')%
              %switch logout%
                %case 'yes'%Yes
                %case% No
              %endswitch%
            %else%
              <input type="radio" value="yes" name="logout" id="logout1" 
                %ifvar logout equals('yes')%checked%endif%><label for="logout1">Yes</label>
                  <input type="radio" name="logout" id="logout2"  value="no"
                %ifvar logout equals('yes')%%else%checked%endif%><label for="logout2">No</label></input>
            %endif%
            </td>
          </tr>	

          <tr><td class="space" colspan="2">&nbsp;</td></tr>
          
          <tr> <td class="heading" colspan=2>Security</td> </tr>
          <!--  RUN AS USER SUB CHANGES-->
	  	<SCRIPT>
	  			function callback(val){      	    
	  			document.properties.runuser.value=val;
	  			}
		</SCRIPT>
          <tr>
          
            <td class="oddrow"><label for="runuser">Run services as user</label></td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %value runuser encode(html)%
              %else%
                <!--  RUN AS USER SUB CHANGES START-->
                		%ifvar authorize equals('no')%
					<input id="runuser" name="runuser" size=12 value="%value runuser encode(htmlattr)%"></input>
				%else%
					<input id="runuser" name="runuser" size=12 value="%value runuser encode(htmlattr)%" DISABLED></input>
				%endif%
				
				
				<link rel="stylesheet" type="text/css" href="subUserLookup.css" />
				<script type="text/javascript" src="subUserLookup.js"></script>
				
				%ifvar authorize equals('no')%
				
				<a class="submodal" style="display:inline" id=subUserSearchlink href="subUserLookup"><img border=0 align="bottom" alt="Select User" src="icons/magnifyglass.gif"/></a>  
	    			%else%
	    				<a class="submodal" style="display:none" id=subUserSearchlink href="subUserLookup"><img border=0 align="bottom" alt="Select User" src="icons/magnifyglass.gif"/></a>  
	    				  
	    			%endif%
	    			
	    	<!--  RUN AS USER SUB END-->
              %endif%
            </td>
          </tr>
          <tr>
            <td class="evenrow">Require authentication within message</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch authorize%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input id="subUserSearchYes" type="radio" value="yes" name="authorize" id="authorize1"  onclick="setAuthorize(true);" 
                	%ifvar authorize equals('no')%%else%checked%endif%><label for="authorize1">Yes</label></input>
                  <input type="radio" value="no" name="authorize" id="authorize2"  onclick="setAuthorize(false);"
                %ifvar authorize equals('no')%checked%endif%><label for="authorize2">No</label></input>
                <script>
                	obj = document.getElementById("subUserSearchYes");
			if (obj && obj.checked == true) {
				disableUserSearch();
			} else {
			  enableUserSearch();
			}
                </script>
              %endif%
            </td>
          </tr>
			<tr>
            <td class="evenrow">Use JSSE</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch useJSSE%
                  %case 'false'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="true" name="useJSSE" onclick="setuseJSSE(true);"
                	%ifvar useJSSE equals('false')%%else%checked%endif%><label for="useJSSE1">Yes</label></input>
                <input type="radio" value="false" name="useJSSE" onclick="setuseJSSE(false);"
                    %ifvar useJSSE equals('false')%checked%endif%><label for="useJSSE2">No</label></input>
              %endif%
            </td>
          </tr>
          </table>
          </td>
          <!-- END OF LEFT TABLE -->

          <!-- RIGHT TABLE -->
          <td valign=top >
          <table class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%" width=100% >
          <tr>
            <td class="heading" colspan=2>Message Processing</td>
          </tr>
          <tr>
            <td class="oddrow"><label for="gservice">Global Service (optional)</label></td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              <script>writeEdit("%value mode encode(javascript)%", 'gservice', "%value gservice encode(html_javascript)%",'gservice');</script>
            </td>
          </tr>
          <tr>
            <td class="evenrow"><label for="dservice">Default Service (optional)</label></td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
            <script>writeEdit("%value mode encode(javascript)%", 'dservice', "%value dservice encode(html_javascript)%",'dservice');</script>
            </td>
          </tr>
          <tr>
            <td class="oddrow">Send reply email with service output</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch reply%
                  %case 'yes'%Yes
                  %case%No
                %endswitch%
              %else%
                <input type="radio" value="yes" name="reply" id="reply1" 
                %ifvar reply equals('yes')%checked%endif%><label for="reply1">Yes</label>
                  <input type="radio" name="reply" id="reply2"  value="no"
                %ifvar reply equals('yes')%%else%checked%endif%><label for="reply2">No</label></input>
              %endif%
            </td>
          </tr>

          <tr>
            <td class="evenrow">Send reply email on error</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch replyonerr%
                  %case 'yes'%Yes
                  %case%No
                %endswitch%
              %else%
                <input type="radio" value="yes" name="replyonerr" id="replyonerr1" 
                 %ifvar replyonerr equals('yes')%checked%endif%><label for="replyonerr1">Yes</label>
                <input type="radio" name="replyonerr" id="replyonerr2"  value="no"
                 %ifvar replyonerr equals('yes')%%else%checked%endif%><label for="replyonerr2">No</label></input>
              %endif%
            </td>
          </tr>
          <tr>
            <td class="oddrow">Delete valid messages (IMAP only)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch remove%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="remove" id="remove1" 
                %ifvar remove equals('no')%%else%checked%endif%><label for="remove1">Yes</label>
                  <input type="radio" value="no" name="remove" id="remove2"  onclick="setRemove();"
                %ifvar remove equals('no')%checked%endif%><label for="remove2">No</label></input>
              %endif%
            </td>
          </tr>
          <tr>
            <td class="evenrow">Delete invalid messages (IMAP only)</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch bad_remove%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="bad_remove" id="bad_remove1" 
                %ifvar bad_remove equals('no')%%else%checked%endif%><label for="bad_remove1">Yes</label>
                  <input type="radio" value="no" name="bad_remove" id="bad_remove2"  onclick="setBadRemove();"
                %ifvar bad_remove equals('no')%checked%endif%><label for="bad_remove2">No</label></input>
              %endif%
            </td>
          </tr>
          <tr>
            <td class="oddrow">Multithreaded processing (IMAP only)</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch multithread%
                  %case 'yes'%Yes
                  %case%No
                %endswitch%
              %else%
                <input type="radio" value="yes" name="multithread" id="multithread1"  onclick="setMultithread(true);"
                %ifvar multithread equals('yes')%checked%endif%><label for="multithread1">Yes</label>
                  <input type="radio" name="multithread" id="multithread2"  value="no" onclick="setMultithread(false);"
                %ifvar multithread equals('yes')%%else%checked%endif%><label for="multithread2">No</label></input>
              %endif%
            </td>
          </tr>
          <tr>
            <td class="evenrow"><label for="num_threads">Number of threads if multithreading turned on</label></td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %ifvar multithread equals('yes')%
                  %value num_threads encode(html)%
                %else%
                  0
                %endif%
              %else%
                <input name="num_threads" id="num_threads" size="2" MAXLENGTH="2" value="%ifvar multithread equals('yes')%%value num_threads encode(htmlattr)%%else%0%endif%"/>
              %endif%
             </td>
          </tr>

          <tr>
            <td class="oddrow">Invoke service for each part of multipart message</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch break_mmsg%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="break_mmsg" id="break_mmsg1" 
                %ifvar break_mmsg equals('no')%%else%checked%endif%><label for="break_mmsg1">Yes</label>
                  <input type="radio" value="no" name="break_mmsg" id="break_mmsg2"  onclick="setBreakMPMsg();"
                %ifvar break_mmsg equals('no')%checked%endif%><label for="break_mmsg2">No</label></input>
              %endif%
            </td>
          </tr>

          <tr>
            <td class="evenrow">Include email headers when passing message to content handler</td>
            <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
              %ifvar mode equals('view')%
                %switch includeHdrs%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="includeHdrs" id="includeHdrs1" 
                %ifvar includeHdrs equals('yes')%checked%endif%><label for="includeHdrs1">Yes</label>
                  <input type="radio" value="no" name="includeHdrs" id="includeHdrs2"  onclick="passEmailHdrs();"
                %ifvar includeHdrs equals('yes')%%else%checked%endif%><label for="includeHdrs2">No</label></input>
              %endif%
            </td>
          </tr>


          <tr>
            <td class="oddrow">Email body contains URL encoded input parameters</td>
            <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
              %ifvar mode equals('view')%
                %switch urlEncodedBody%
                  %case 'no'%No
                  %case%Yes
                %endswitch%
              %else%
                <input type="radio" value="yes" name="urlEncodedBody" id="urlEncodedBody1" 
                %ifvar urlEncodedBody equals('no')%%else%checked%endif%><label for="urlEncodedBody1">Yes</label>
                  <input type="radio" value="no" name="urlEncodedBody" id="urlEncodedBody2"  onclick="setUrlEncodedBody();"
                %ifvar urlEncodedBody equals('no')%checked%endif%><label for="urlEncodedBody2">No</label></input>
              %endif%
            </td>
          </tr>

          </table>

          %ifvar mode equals('view')%
          %else%
          <tr>
            <td colspan="2" class="action">
            <input type="button" value="Save Changes" onclick="verify();">
            </td>
          </tr>
          %endif%
          </form>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
%endinvoke%