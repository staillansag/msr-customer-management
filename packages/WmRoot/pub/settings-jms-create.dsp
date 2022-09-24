<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">
<link rel="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<script src="webMethods.js"></script>

<script language ="javascript">

/**
 * onChange to 'Create Connection Using' was made
 */ 
function displaySettings(object) {

    document.all.createform.producerCachingMode.value=0;

    document.getElementById('divCacheEnabled').style.display = 'none';
    document.getElementById('divCacheEnabledPer').style.display = 'none';
    document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
    document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
    document.getElementById('divCacheEnabled2').style.display = 'none';

    if (object.options[object.selectedIndex].value == "JNDI") {
        document.all.div1.style.display = 'block';
        document.all.div2.style.display = 'none';
        document.all.createform.producerCachingMode.disabled=false;

        if (document.createform.jndi_connectionFactoryUpdateType.value == "CLIENT_POLL") {
            document.all.divPoll.style.display = 'block';
        }else {
            document.all.divPoll.style.display = 'none';
        }

    }else if (object.options[object.selectedIndex].value == "WM") {
        document.all.div1.style.display = 'none';
        document.all.divPoll.style.display = 'none';
        document.all.div2.style.display = 'block';
        document.all.createform.producerCachingMode.disabled=false;

    }else {
        document.all.div1.style.display = 'none';
        document.all.divPoll.style.display = 'none';
        document.all.div2.style.display = 'none';
        document.all.createform.producerCachingMode.disabled=true;
    }
}


/**
 * onChange was made to the producer cache mode
 */
function producerModeSettings(object) {

    if (object.value == 0) { // disabled

        document.getElementById('divCacheEnabled').style.display = 'none';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
    document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
    document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
    document.getElementById('divCacheEnabled2').style.display = 'none';
    
    }else if (object.value == 1) { // enabled     

        document.getElementById('divCacheEnabled').style.display = 'block';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
        document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
        document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
    document.getElementById('divCacheEnabled2').style.display = 'block';

    }else if (object.value == 2) { // per destination
        
        var associationTypeElem = document.all.createform.associationType
        var associationTypeValue = associationTypeElem.options[associationTypeElem.selectedIndex].value

        if (associationTypeValue == 'JNDI') {   
            document.getElementById('divCacheEnabled').style.display = 'none';
            document.getElementById('divCacheEnabledPer').style.display = 'block';
            document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
            document.getElementById('divCacheEnabledPer_JNDI').style.display = 'block';
        document.getElementById('divCacheEnabled2').style.display = 'none';

        }else if (associationTypeValue == 'WM') {
            document.getElementById('divCacheEnabled').style.display = 'none';
            document.getElementById('divCacheEnabledPer').style.display = 'block';
            document.getElementById('divCacheEnabledPer_WM').style.display = 'block';
            document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
        document.getElementById('divCacheEnabled2').style.display = 'none';
        }
    }
}

/**
 *
 */
function displayPollingInterval(object) {
  if (object.options[object.selectedIndex].value == "CLIENT_POLL") {
      document.all.divPoll.style.display = 'block';
  }else {
      document.all.divPoll.style.display = 'none';
  }
}

/**
 *
 */
function loadDocument() {

    setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_CreateJMSaliasScrn');

    document.getElementById('divCacheEnabled').style.display = 'none';
    document.getElementById('divCacheEnabledPer').style.display = 'none';
    document.getElementById('divCacheEnabledPer_WM').style.display = 'none';
    document.getElementById('divCacheEnabledPer_JNDI').style.display = 'none';
    document.getElementById('divCacheEnabled2').style.display = 'none';
}

/**
 * Validation logic
 */
function validateForm(obj) {

    var associationTypeElem = obj.associationType
    var associationTypeValue = associationTypeElem.options[associationTypeElem.selectedIndex].value
    
    if (obj.aliasName.value == "") {
        alert("Connection Alias Name must be specified.");
        return false;
    }

    if (obj.description.value == "") {
        alert("Description must be specified.");
        return false;
    }

    if (obj.associationType.selectedIndex == 0) {
        alert("Create Connection Using must be specified.");
        return false;
    }

    if (obj.associationType.selectedIndex == 1) {
        if (obj.jndi_jndiAliasName.options.length == 0) {
            alert("No JNDI Provider Aliases are configured. You must first create a JNDI Provider Alias via Settings - Messaging - JNDI Settings.");
            return false;
        }
        if (obj.jndi_connectionFactoryLookupName.value == "") {
            alert("Connection Factory Lookup Name must be specified.");
            return false;
        }

        if (obj.jndi_connectionFactoryUpdateType.value == "CLIENT_POLL") {
            if (obj.jndi_connectionFactoryPollingInterval.value == '0' || !isInt(obj.jndi_connectionFactoryPollingInterval.value)) {
                alert("Polling Interval must be a positive integer.");
                return false;
            }
        }else {
            obj.jndi_connectionFactoryPollingInterval.value = 1440; //reset to default
        }

    }else if (obj.associationType.selectedIndex == 2) {

        if(obj.nwm_brokerHost.value == "") {
            alert("Broker Host must be specified.");
            return false;

        }else if(obj.nwm_brokerName.value == "") {
            alert("Broker Name must be specified.");
            return false;

        }else if(obj.nwm_clientGroup.value == "") {
            alert("Client Group must be specified.");
            return false;

        }else if(obj.clientID.value == "") {
            alert("Connection Client ID must be specified when connecting via Native webMethods API.");
            return false;
        }
    }

    if(obj.clientID.value != "") {
          var regex=/^([A-Za-z][_A-Za-z0-9$]*)$/;
          if(!regex.test(obj.clientID.value)) {
            alert("Connection Client ID must contain only letters, digits, underscores and dollar characters; and it must start with a letter.");
            return false;
        }
    }

    if (obj.csqSize.value != "" && obj.csqSize.value != "-1" && !isInt(obj.csqSize.value)) {
        alert("Maximum CSQ Size must be a positive integer, 0, or -1. A value of -1 indicates that the CSQ Size is unlimited.");
        return false;
    }
    
    /*
     * Producer Retry Validation
     */
     
    if (obj.producerMaxRetryAttempts.value != "" && !isInt(obj.producerMaxRetryAttempts.value)) {
        alert("Max Retry Attempts must be a positive integer.");
        return false;
    }
    
    if (obj.producerRetryInterval.value != "" && !isInt(obj.producerRetryInterval.value)) {
        alert("Retry Interval must be a positive integer.");
        return false;
    }     

    /*
     * Producer Caching Validation
     */

    var cacheMode = document.all.createform.producerCachingMode.value;
    var timeout;

    if (cacheMode == 1) { // enabled
      
        var minpool = document.all.createform.producerSessionPoolMinSize_divCacheEnabled.value;
        var maxpool = document.all.createform.producerSessionPoolSize_divCacheEnabled.value;

        var int_minpool = parseInt(minpool);
        var int_maxpool = parseInt(maxpool);

        timeout = document.all.createform.poolTimeout_divCacheEnabled2.value;

        if (maxpool == '' || int_maxpool < 1) {
            alert("Maximum Pool Size is required and must be greater than 0.");
            return false;
        }

        if ( (minpool != '') && (!isInt(minpool)) ) {
            alert("Minimum Pool Size must be a non-negative integer.");
            return false;
        }

        if (!isInt(maxpool)) {
            alert("Maximum Pool Size must be a positive integer.");
            return false;
        }

        if (int_minpool > int_maxpool) {
            alert("Minimum Pool Size cannot be greater than Maximum Pool Size.");
              return false;
        }

        if ( (timeout != '') && (!isInt(timeout)) && (timeout != "-1") ) {
            alert("Idle Timeout must be a positive integer, 0, or -1. A value of 0 indicates the pool entry will never expire. A value of -1 indicates the system default will be used.");
            return false;
        }

    } else if (cacheMode == 2) { // enabled per destination
      
        var minpoolPerDefault = document.all.createform.producerSessionPoolMinSize_divCacheEnabledPer.value;
        var maxpoolPerDefault = document.all.createform.producerSessionPoolSize_divCacheEnabledPer.value;
        var minpoolPer = document.all.createform.cacheProducersPoolMinSize_divCacheEnabledPer.value;
        var maxpoolPer = document.all.createform.cacheProducersPoolSize_divCacheEnabledPer.value;

        var int_minpoolPerDefault = parseInt(minpoolPerDefault);
        var int_maxpoolPerDefault = parseInt(maxpoolPerDefault);
        var int_minpoolPer = parseInt(minpoolPer);
        var int_maxpoolPer = parseInt(maxpoolPer);

        if (maxpoolPerDefault == '' || int_maxpoolPerDefault < 1) {
            alert("Maximum Pool Size (unspecified destinations) is required and must be greater than 0.");
            return false;
        }

        if ( (minpoolPerDefault != '') && (!isInt(minpoolPerDefault)) ) {
            alert("Minimum Pool Size (unspecified destinations) must be a nonnegative integer.");
            return false;
        }

        if (!isInt(maxpoolPerDefault)) {
            alert("Maximum Pool Size (unspecified destinations) must be a positive integer.");
            return false;
        }

        if ( (minpoolPerDefault != '') && (int_minpoolPerDefault > int_maxpoolPerDefault) ) {
            alert("Minimum Pool Size (unspecified destinations) cannot be greater than Maximum Pool Size (unspecified destinations).");
        return false;
        }

        if ( (minpoolPer != '') && (!isInt(minpoolPer)) ) {
            alert("Minimum Pool Size Per Destination must be a nonnegative integer.");
            return false;
        }

        if ( (maxpoolPer != '') && (!isInt(maxpoolPer)) ) {
            alert("Maximum Pool Size Per Destination must be a positive integer.");
            return false;
        }

        if (int_minpoolPer > int_maxpoolPer) {
            alert("Minimum Pool Size Per Destination cannot be greater than Maximum Pool Size Per Destination.");
        return false;
        }

        var queuelist = '';
        var topiclist = '';
        var destMsg = "The Maximum Pool Size Per Destination and at least one destination are required to enable per destination pooling.  To disable per destination pooling, set Maximum Pool Size Per Destination and the destination list(s) to blank."

        if (associationTypeValue == "WM") { // Native WM
            timeout = document.all.createform.poolTimeout_divCacheEnabledPer_WM.value;
            queuelist = document.all.createform.cacheProducersQueueList_divCacheEnabledPer_WM.value;
            topiclist = document.all.createform.cacheProducersTopicList_divCacheEnabledPer_WM.value;

            if ( (maxpoolPer != '' && maxpoolPer != '0') && queuelist == '' && topiclist == '') {
                alert(destMsg);
                return false;
            }

            if ( (queuelist != '' || topiclist != '') && (maxpoolPer == '' || maxpoolPer == '0') ) {
                alert(destMsg);
                return false;
            }

        }else { // JNDI
            timeout = document.all.createform.poolTimeout_divCacheEnabledPer_JNDI.value;
            queuelist = document.all.createform.cacheProducersQueueList_divCacheEnabledPer_JNDI.value;

            if (maxpoolPer != '' && maxpoolPer != '0' && queuelist == '') {
                alert(destMsg);
                return false;
            }

            if ( (queuelist != '') && (maxpoolPer == '' || maxpoolPer == '0') ) {
                alert(destMsg);
                return false;
            }
        }

        if ( (timeout != '') && (!isInt(timeout)) && (timeout != "-1") ) {
            alert("Idle Timeout must be a positive integer, 0, or -1. A value of 0 indicates the pool entry will never expire. A value of -1 indicates the system default will be used.");
            return false;
        }
    }

    return true;
}

/**
 * Check if value is an int
 */
function isInt(value) {

    var strValidChars = "0123456789";
    var strChar;
    var blnResult = true;

    for (i = 0; i < value.length && blnResult == true; i++) {
        strChar = value.charAt(i);
        if (strValidChars.indexOf(strChar) == -1) {
            blnResult = false;
        }
    }

  //  if (value.length == 0 || value > 2147483647) {
  //      return false;
  //  }

    return blnResult;
}

</script>
</head>

<body onLoad="loadDocument()">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JMS Settings &gt; JMS Connection Alias &gt; Create</td>
    </tr>

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jms", "settings-jms.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-jms.dsp","javascript:document.htmlform_settings_jms.submit();","Return to JMS Settings")</script>
		  </li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>

      <form name='createform' action="settings-jms.dsp" method="post">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

        <table class="tableView" width="100%">

          <!-- Connection Alias Name -->
          <script>swapRows();</script>
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="aliasName">Connection Alias Name</label></td>
            <td class="oddrow-l"><INPUT NAME="aliasName" ID="aliasName" size="50"></td>
          </tr>

          <!-- Description -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="description">Description</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="description" ID="description"size="50"></td>
          </tr>

          <!-- Transaction Type -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="transactionType">Transaction Type</label></td>
            <script>writeTD("row-l");</script>
              <select name="transactionType" ID="transactionType">
                <!-- <option value="blank"></option> -->
                <option value="0">NO_TRANSACTION</option>
                <option value="1">LOCAL_TRANSACTION</option>
                <option value="2">XA_TRANSACTION</option>
              </select>
            </td>
          </tr>

          <!-- Connection Client ID -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="clientID">Connection Client ID</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="clientID" ID="clientID" size="50"></td>
          </tr>

          <!-- User -->
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="user">User (optional)</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="user" ID="user" size="50"></td>
          </tr>

          <!-- Password -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="password">Password (optional)</label></td>
            <script>writeTD("row-l");</script><input type="password" name="password" ID="password" autocomplete="off" size="50" /></td>
          </tr>

          <tr>
            <td class="heading" colspan=2>Connection Protocol Settings</td>
          </tr>

          <!-- Connect Uisng -->

          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="associationType">Create Connection Using</label></td>
            <script>writeTD("row-l");</script>
              <select name="associationType" ID="associationType" onchange="displaySettings(this.form.associationType)">
                <option value="blank"></option>
                <option value="JNDI">JNDI LOOKUP</option>
                <option value="WM">NATIVE WEBMETHODS API (Deprecated)</option>
              </select>
            </td>
          </tr>
        </table>

        <!-- DIV: CONNECTION MODE: JNDI -->

        <div id="div1" STYLE="display: none">
        <table class="tableView" width="100%">
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="jndi_jndiAliasName">JNDI Provider Alias Name</label></td>
            <script>writeTD("row-l");</script>
              <select name="jndi_jndiAliasName" id="jndi_jndiAliasName" >
                %invoke wm.server.jndi:getJNDIAliases%
                  %loop jndiData%
                    <option value="%value jndiAliasName encode(htmlattr)%">%value jndiAliasName encode(html)%</option>
                  %endloop%
                %onerror%
                  %value errorService encode(html)%<br>%value error encode(html)%<br>%value errorMessage encode(html)%<br>
                %endinvoke%
              </select>
            </td>
          <script>swapRows();</script>
          </tr>
          <tr>
            <script>writeTD("row-l");</script><label for="jndi_connectionFactoryLookupName">Connection Factory Lookup Name</label></td>
            <script>writeTDnowrap("row-l");</script><INPUT NAME="jndi_connectionFactoryLookupName" id="jndi_connectionFactoryLookupName" size="50"></td>
          </tr>
          
          <tr>  
            <script>writeTD("row-l");</script><label for="jndi_automaticallyCreateUMAdminObjects">Create Administered Objects On Demand (Universal Messaging)</label></td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="jndi_automaticallyCreateUMAdminObjects" id="jndi_automaticallyCreateUMAdminObjects" >
            </td>
          </tr>
          
          <tr>
            <script>writeTD("row-l");</script><label for="jndi_enableFollowTheMaster">Enable Follow the Master (Universal Messaging)</label></td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="jndi_enableFollowTheMaster" id="jndi_enableFollowTheMaster" checked=true>
            </td>           
          </tr>

          <tr>
            <td class="evenrow-l"><label for="jndi_connectionFactoryUpdateType">Monitor webMethods Connection Factory</label></td>
            <td class="evenrowdata-l">
              <select name="jndi_connectionFactoryUpdateType" id="jndi_connectionFactoryUpdateType" onChange="displayPollingInterval(this.form.jndi_connectionFactoryUpdateType)")>
                <option value="NONE">No</option>
                <option value="CLIENT_POLL">Poll for changes (specify interval)</option>
                <option value="JNDI_POLL">Poll for changes (interval defined by webMethods Connection Factory)</option>
                <option value="NOTIFICATION">Register change listener</option>
              </select>
          </tr>
        </table>
        </div>

        <div id="divPoll" STYLE="display: none">
        <table class="tableView" width="100%">
          <tr>
            <td class="oddrow-l" width="40%"><label for="jndi_connectionFactoryPollingInterval">Polling Interval (minutes)</label></td>
            <td class="oddrowdata-l"><input name="jndi_connectionFactoryPollingInterval" id="jndi_connectionFactoryPollingInterval" size="50" value="1440"></td>
          </tr>
        </table>
        </div>

        <!-- DIV: CONNECTION MODE: WM -->

        <div id="div2" STYLE="display: none">
        <table class="tableView" width="100%">

     <!-- Connection Type
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Connection Type</td>
            <script>writeTD("row-l");</script>
              <select name="nwm_connectionType">
                <option value="queue">QUEUE</option>
                <option value="topic">TOPIC</option>
                <option value="xaqueue">XA QUEUE</option>
                <option value="xatopic">XA TOPIC</option>
              </select>
            </td>
          </tr>

     -->

          <!-- Broker Host -->
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="nwm_brokerHost">Broker Host</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerHost" id="nwm_brokerHost" size="50" value="localhost:6849"></td>
          </tr>

          <!-- Broker Name -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_brokerName">Broker Name</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerName" id="nwm_brokerName" size="50" value="Broker #1"></td>
          </tr>

          <!-- Client Group -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_clientGroup">Client Group</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_clientGroup" id="nwm_clientGroup" size="50" value="IS-JMS"></td>
          </tr>

          <!-- Shared State
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Shared State</td>
            <script>writeTD("row-l");</script>
               <input type="checkbox" name="nwm_sharedState" checked="true">
            </td>
          </tr>
          -->

          <!-- Shared State Order
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script>Shared State Order</td>
            <script>writeTD("row-l");</script>
              <select name="nwm_sharedStateOrder">
                <option value="0">NONE</option>
                <option value="1">ORDER BY PUBLISHER</option>
              </select>
            </td>
          </tr>
          -->

          <!-- Broker List -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_brokerList">Broker List (optional)</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerList" id="nwm_brokerList" size="50"></td>
          </tr>

          <!-- Keystore -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_keystore">Keystore (optional)</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_keystore" id="nwm_keystore" size="50"></td>
          </tr>

          <!-- Keystore Type -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_keystoreType">Keystore Type (optional)</label></td>
            <script>writeTD("row-l");</script>
              <select name="nwm_keystoreType" id="nwm_keystoreType">
                <option value=""></option>
                <option value="JKS">JKS</option>
                <option value="PKCS12">PKCS12</option>
              </select>
            </td>
          </tr>

          <!-- Truststore -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_truststore">Truststore (optional) </label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_truststore" id="nwm_truststore" size="50"></td>
          </tr>

          <!-- Truststore Type -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_truststoreType">Truststore Type (optional)</label></td>
            <script>writeTD("row-l");</script>
              <select name="nwm_truststoreType" id="nwm_truststoreType">
                <option value=""></option>
                <option value="JKS">JKS</option>
              </select>
            </td>
          </tr>

          <!-- Encrypted -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_encrypted">Encrypted</label></td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="nwm_encrypted" id="nwm_encrypted">
            </td>
          </tr>

          <!-- Dead Letter Only
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script>Dead Letter Only</td>
            <script>writeTD("row-l");</script>
               <input type="checkbox" name="nwm_deadLetterOnly">
            </td>
          </tr>
          -->

        </table>
        </div>

        <div id="div3" STYLE="display: block">
        <table class="tableView" width="100%">

          <tr>
            <td class="heading" colspan=2>Advanced Settings</td>
          </tr>

          <script>swapRows();</script>

          <!-- Class loader -->
          <tr>
            <script>writeTD("row-l");</script><label for="classLoader">Class Loader</label></td>
            <script>writeTD("row-l");</script>

            <select name="classLoader" id="classLoader">
                <option value="INTEGRATION_SERVER">INTEGRATION_SERVER</option>
                %invoke wm.server.packages:packageList%
                  %loop packages%
                    <option value="%value name encode(htmlattr)%">PACKAGE: %value name encode(html)%</option>
                  %endloop%
                %endinvoke%
              </select>
            </td>
          </tr>

          <!-- Max CSQ Size -->
          <script>swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="csqSize">Maximum CSQ Size (messages)</label></td>
            <script>writeTD("row-l");</script>
               <input name="csqSize" id="csqSize" size="50" value="-1">
            </td>
          </tr>

          <!-- Drain CSQ -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="csqDrainInOrder">Drain CSQ in Order</label></td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="csqDrainInOrder" id="csqDrainInOrder" checked=true>
            </td>
          </tr>

          <!-- Create Tempororay queue -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="optTempQueueCreate">Create Temporary Queue</label></td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="optTempQueueCreate" id="optTempQueueCreate" checked=true>
            </td>
          </tr>
          
          <!-- Reply To Consumer -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="allowReplyToConsumer">Enable Request-Reply Listener for Temporary Queue</label></td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="allowReplyToConsumer" id="allowReplyToConsumer">
            </td>
          </tr>          

          <!-- Manage Destinations -->
          <script>swapRows();</script>
          <tr>  
            <script>writeTD("row-l");</script><label for="manageDestinations">Enable Destination Management with Designer (Broker and Universal Messaging)</td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="manageDestinations" id="manageDestinations" checked=true>
            </td>
          </tr>
          
          <!-- Create New Connection per Trigger -->
          <script>swapRows();</script>
          <tr>  
            <script>writeTD("row-l");</script><label for="allowNewConnectionPerTrigger">Create New Connection per Trigger</td>
            <script>writeTD("row-l");</script>
              <input type="checkbox" name="allowNewConnectionPerTrigger" id="allowNewConnectionPerTrigger" />
            </td>
          </tr>

        </table>
      </div>

        <!-- --------------------- -->
        <!-- Producer Pool Caching -->
        <!-- --------------------- -->

        <table class="tableView" width="100%">
            <tr>
        <td class="heading" colspan=2>Producer Caching</td>
            </tr>
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script><label for="producerCachingMode">Caching Mode</label></td>
                <script>writeTD("rowdata-l");</script>
                    <select name="producerCachingMode" id="producerCachingMode" disabled="disabled" onchange="producerModeSettings(this.form.producerCachingMode)">
                        <option value="0">DISABLED</option>
                     <!--   <option value="1">ENABLED</option>  -->
                        <option value="2">ENABLED PER DESTINATION</option>
                    </select>
                </td>
            </tr>
        </table>

        <!-- Producer Pool Caching - Enabled -->
    <div id="divCacheEnabled" STYLE="display: block">
        <table class="tableView" width="100%">

        <script>swapRows();</script>
            <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="producerSessionPoolMinSize_divCacheEnabled">Minimum Pool Size</label></td>
            <script>writeTD("rowdata-l");</script><input name="producerSessionPoolMinSize_divCacheEnabled" id="producerSessionPoolMinSize_divCacheEnabled" size="50" value="1"></td>
        </tr>

        <script>swapRows();</script>
            <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="producerSessionPoolSize_divCacheEnabled">Maximum Pool Size</label></td>
            <script>writeTD("rowdata-l");</script>
                        <input name="producerSessionPoolSize_divCacheEnabled" id="producerSessionPoolSize_divCacheEnabled" size="50" value="30">
                    </td>
        </tr>

            </table>
        </div>

        <!-- Producer Pool Caching - Enabled Per Destination -->
    <div id="divCacheEnabledPer" STYLE="display: block">
        <table class="tableView" width="100%">

        <script>swapRows();</script>
            <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="producerSessionPoolMinSize_divCacheEnabledPer">Minimum Pool Size (unspecified destinations)</label></td>
            <script>writeTD("rowdata-l");</script><input name="producerSessionPoolMinSize_divCacheEnabledPer" id="producerSessionPoolMinSize_divCacheEnabledPer" size="50" value="1"></td>
        </tr>

        <script>swapRows();</script>
            <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="producerSessionPoolSize_divCacheEnabledPer">Maximum Pool Size (unspecified destinations)</label></td>
            <script>writeTD("rowdata-l");</script><input name="producerSessionPoolSize_divCacheEnabledPer" id="producerSessionPoolSize_divCacheEnabledPer" size="50" value="30"></td>
        </tr>
        
                <script>swapRows();</script>
        <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersPoolMinSize_divCacheEnabledPer">Minimum Pool Size Per Destination</label></td>
            <script>writeTD("rowdata-l");</script><input name="cacheProducersPoolMinSize_divCacheEnabledPer" id="cacheProducersPoolMinSize_divCacheEnabledPer" size="50" value=""></td>
        </tr>

                <script>swapRows();</script>
        <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersPoolSize_divCacheEnabledPer">Maximum Pool Size Per Destination</label></td>
            <script>writeTD("rowdata-l");</script><input name="cacheProducersPoolSize_divCacheEnabledPer" id="cacheProducersPoolSize_divCacheEnabledPer" size="50" value=""></td>
        </tr>

    </table>
        </div>

        <!-- Producer Pool Caching - Enabled Per Destination - Using WM -->
           <div id="divCacheEnabledPer_WM" STYLE="display: block">
               <table class="tableView" width="100%">
               <script>swapRows();</script>
                   <tr>
                       <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersQueueList_divCacheEnabledPer_WM">Queue List (semicolon delimited)</label></td>
                       <script>writeTD("row-l");</script>
                           <input name="cacheProducersQueueList_divCacheEnabledPer_WM" id="cacheProducersQueueList_divCacheEnabledPer_WM" size="50" value="">
                       </td>
                   </tr>
                                    
                 <script>swapRows();</script>
                   <tr>
                       <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersTopicList_divCacheEnabledPer_WM">Topic List (semicolon delimited)</label></td>
                       <script>writeTD("row-l");</script>
                           <input name="cacheProducersTopicList_divCacheEnabledPer_WM" id="cacheProducersTopicList_divCacheEnabledPer_WM" size="50" value="">
                      </td>
                   </tr>
                   <script>swapRows();</script>
                 <tr>
                     <script>writeTDWidth("row-l", "40%");</script><label for="poolTimeout_divCacheEnabledPer_WM">Idle Timeout (milliseconds)</label></td>
                     <script>writeTD("row-l");</script><INPUT NAME="poolTimeout_divCacheEnabledPer_WM" id="poolTimeout_divCacheEnabledPer_WM" size="50" value="60000"></td>
                 </tr>
            </table>
        </div>

        <!-- Producer Pool Caching - Using JNDI -->
        <div id="divCacheEnabledPer_JNDI" STYLE="display: block">
            <table class="tableView" width="100%">
              <!--<script>swapRows();</script>-->
                  <tr>
                      <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersQueueList_divCacheEnabledPer_JNDI">Destination Lookup Names (semicolon delimited)</label></td>
                      <script>writeTD("row-l");</script>
                          <input name="cacheProducersQueueList_divCacheEnabledPer_JNDI" id="cacheProducersQueueList_divCacheEnabledPer_JNDI" size="50" value="">
                      </td>
                </tr>
                      <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script><label for="poolTimeout_divCacheEnabledPer_JNDI">Idle Timeout (milliseconds)</label></td>
                    <script>writeTD("row-l");</script><INPUT NAME="poolTimeout_divCacheEnabledPer_JNDI" id="poolTimeout_divCacheEnabledPer_JNDI" size="50" value="60000"></td>
                </tr>
            </table>
        </div>

        <!-- Producer Pool Caching - Idle Timeout (only used when mode = enabled -->
        <div id="divCacheEnabled2" STYLE="display: block">
            <table class="tableView" width="100%">
              <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script><label for="poolTimeout_divCacheEnabled2">Idle Timeout (milliseconds)</label></td>
                    <script>writeTD("row-l");</script><INPUT NAME="poolTimeout_divCacheEnabled2" id="poolTimeout_divCacheEnabled2" size="50" value="60000"></td>
                </tr>

            </table>
        </div>
        
        <!-- --------------------- -->
        <!-- Producer Retry        -->
        <!-- --------------------- -->
        <table class="tableView" width="100%">
            <tr>
              <td class="heading" colspan=2>Producer Retry</td>
            </tr>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script><label for="producerMaxRetryAttempts">Max Retry Attempts</label></td>
                <script>writeTD("rowdata-l");</script>
                    <input name="producerMaxRetryAttempts" id="producerMaxRetryAttempts" size="50" value="0">
                </td>
            </tr>
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script><label for="producerRetryInterval">Retry Interval (milliseconds)</label></td>
                <script>writeTD("rowdata-l");</script>
                    <input name="producerRetryInterval" id="producerRetryInterval" size="50" value="1000">
                </td>
            </tr>
        <!--
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Retry Only if Connected</td>
                <script>writeTD("rowdata-l");</script>
                    <input type="checkbox" name="producerRetryOnlyIfConnected" checked="true">
                </td>
            </tr>
        -->

          <tr>
            <td class="heading" colspan=2>Enhanced Logging</td>
          </tr>

          <TR>
            <TD width="40%" class="oddrow-l"><label for="um_loggingOutput">Logging Type</label></TD>
            <TD class="oddrowdata-l">
              <select name="um_loggingOutput" id="um_loggingOutput" >      
                 <option value="0" selected>SERVER LOG</option>    
                 <option value="1">MESSAGING AUDIT LOG</option>
              </select>
            </TD>            
          </TR> 
        
          <TR>
            <TD width="40%" class="oddrow-l">
			<label for="um_producerMessageTracking">
              Enable Producer Message ID Tracking
			  </label>
            </TD>
            <TD class="oddrowdata-l">
              <INPUT TYPE="checkbox" NAME="um_producerMessageTracking" id="um_producerMessageTracking" >                                                                             
            </TD>
          </TR> 
           
          <TR>
            <TD class="oddrow-l"><label for="um_producerIncludedStrings">Producer Message ID Tracking: Include Destinations (semicolon delimited)</label></TD>
            <TD class="oddrowdata-l">
              <INPUT NAME="um_producerIncludedStrings" id="um_producerIncludedStrings" size="50" value="%value um_producerIncludedStrings encode(htmlattr)%">
            </TD>
          </TR>
          
          <TR>
            <TD class="oddrow-l"><label for="um_consumerMessageTracking">Enable Consumer Message ID Tracking</label></TD>
            <TD class="oddrowdata-l"> 
              <INPUT TYPE="checkbox" NAME="um_consumerMessageTracking" id="um_consumerMessageTracking" >
            </TD>
          </TR>
          <TR>
            <TD class="oddrow-l"><label for="um_consumerIncludedStrings">Consumer Message ID Tracking: Include Triggers (semicolon delimited)</label></TD>
            <TD class="oddrowdata-l">
              <INPUT NAME="um_consumerIncludedStrings" id="um_consumerIncludedStrings" size="50" value="%value um_consumerIncludedStrings encode(htmlattr)%">
            </TD>
          </TR>
          
        </table>

        <table class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>

                <input name="action" type="hidden" value="create">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">
              </td>
            </tr>
        </table>

       </form>

      </td>
    </tr>
  </table>
</body>
</html>
