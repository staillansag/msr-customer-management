/*
 * Copyright � 1996 - 2017 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG.
*/


var useJQueryTabs = false;


function toggle(node, bodyName) {
  var body = document.getElementById(bodyName);
  var applicationName = document.getElementById("applicationName").value;
  var image = document.getElementById('img'+bodyName);
  rows = body.rows;
   if (image.src.indexOf('plus') !=-1){
     image.src = "images/minus.gif";
     if (rows.length!=0){
       for(i = 0; i < rows.length; i++){
        rows[i].style.display="block";
        rows[i].style.display="table-row";
      }
    }else{
      loadData(bodyName,applicationName);
    }
  }else{
    image.src = "images/plus.gif";
    for(i = 0; i < rows.length; i++){
      rows[i].style.display = 'none';
    }
  }
}

function loadData(vtbodyName, vappName) {
  $.ajax({
    type: 'post',
    url: '/invoke/wm.client.integrationlive.metadatashare/getServicesForDisplay',
    data: {packageName:vtbodyName,applicationName:vappName},
    dataType: 'json',
    async: false,
    success:function(data){
      $.each(data, function(key, value) {
        if(key=='services'){
          if(jQuery.isEmptyObject(value)){
            createEmptyPackageRow(vtbodyName);
          }
            $.each(value,function(i,j){
              //if(i==0){
                //createHeadingRow(vtbodyName);
              //}
              var size=value.length;
              var svcName;
              var svcDesc;
              var isSelected;
              var isBatchSelected;
              var isBatchCandidate;
              var lastElement=false;
              $.each(j,function(k,v){
                if(k=='serviceName'){
                  svcName=v;
                }
                if(k=='displayName'){
                  svcDesc=v;
                }
                if(k=='isShared'){
                  isSelected=v;
                }
                if(k=='useBatch'){
                  isBatchSelected=v;
                }
                if(k=='isBatchCandidate'){
                  isBatchCandidate=v;
                }
              });

              if(size==1 ||size==i+1){
                lastElement="true";
              }else{
                lastElement="false";
              }
              createRow(i,vtbodyName,svcName,svcDesc,isSelected,isBatchSelected,isBatchCandidate,lastElement);
            });
          }
      });

    }
  });
}

function createEmptyPackageRow(vtbodyName){
  var table = document.getElementById(vtbodyName);
  var row = table.insertRow(0);

  var cell = row.insertCell(0);
  cell.setAttribute("width","60%");

  var labelElement = document.createElement("label");
  labelElement.setAttribute("id",vtbodyName+"_nodata");
  labelElement.innerHTML="<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No services satisfying the metadata share criteria found.</i>";
  cell.appendChild(labelElement);

  var cell1 = row.insertCell(1);
  cell1.setAttribute("width","10%");

  var cell2 = row.insertCell(2);
  cell2.setAttribute("width","30%");
}

function createHeadingRow(vtbodyName){
  var table = document.getElementById(vtbodyName);
  var row = table.insertRow(0);
  row.setAttribute("class","evenrow-l");

  var imgElement=document.createElement("img");
  imgElement.setAttribute("src","images/T.png");

  var labelElement = document.createElement("label");
  labelElement.innerHTML="<b>&nbsp;&nbsp;Service Name</b>";

  var cell = row.insertCell(0);
  cell.setAttribute("width","60%");
  cell.appendChild(imgElement);
  cell.appendChild(labelElement);

  var cell1 = row.insertCell(1);
  cell1.innerHTML = "<b>Batch API</b>";
  cell1.setAttribute("width","10%");

  var cell2 = row.insertCell(2);
  cell1.innerHTML = "<b>Display Name</b>";
  cell1.setAttribute("width","30%");
}

function createRow(vindex,vtbodyName,vsvcName,vsvcDesc,visSelected,vbatchIsSelected,visBatchCandidate,isLastElement){
  var table = document.getElementById(vtbodyName);
  var row = table.insertRow(vindex);

  var submitForm=document.getElementById("appSubmitForm");

  var imgElement=document.createElement("img");

  if(isLastElement=="true"){
    imgElement.setAttribute("src","images/L.png");
  }else{
    imgElement.setAttribute("src","images/T.png");
  }

  var cell = row.insertCell(0);
  cell.setAttribute("width","60%");
  cell.appendChild(imgElement);

  var imgElement2=document.createElement("img");
  imgElement2.setAttribute("src","images/ns_flow.GIF");
  imgElement2.setAttribute("class","imgStyle");
  cell.appendChild(imgElement2);

  var labelElement=document.createElement("label");
  var cbname="md_"+vsvcName+"_cb";
  var functionName="setDetails('"+vtbodyName+"','"+vsvcName+"');"
  var labelElement = document.createElement("label");
  var isEnabled = visBatchCandidate == true ? "": "disabled";

  if(visSelected==true){
    labelElement.innerHTML = '<input type="checkbox" class="cbstyle" name="'+cbname+'" value="'+vsvcName+'" onclick="'+functionName+'" checked> &nbsp;'+ vsvcName;
  }else{
    labelElement.innerHTML = '<input type="checkbox" class="cbstyle" name="'+cbname+'" value="'+vsvcName+'" onclick="'+functionName+'"> &nbsp;'+ vsvcName;
  }

  cell.appendChild(labelElement);

  var cell2 = row.insertCell(1);
  cell2.setAttribute("width","10%");
  //cell2.setAttribute("align","center");
  var labelElement2 = document.createElement("label");
  var cbname2="md_"+vsvcName+"_cb2";

  if(vbatchIsSelected == true){
    labelElement2.innerHTML = ' &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="cbstyle" name="'+cbname2+'" value="'+vsvcName+'" onclick="'+functionName+'" '+isEnabled+' checked > &nbsp;';
  }else{
    labelElement2.innerHTML = ' &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="cbstyle" name="'+cbname2+'" value="'+vsvcName+'" onclick="'+functionName+'" '+isEnabled+'> &nbsp;';
  }
  cell2.appendChild(labelElement2);

  var cell3 = row.insertCell(2);

  var txtField=document.createElement("input");
  txtField.setAttribute("type","textfield");
  txtField.setAttribute("name","md_"+vsvcName+"_tf");
  txtField.setAttribute("id","md_"+vsvcName+"_tf");
  txtField.setAttribute("value",vsvcDesc);
  txtField.setAttribute("size","45");
  txtField.setAttribute("onchange",functionName);
  cell3.appendChild(txtField);

  var hiddenField=document.createElement("input");
  hiddenField.setAttribute("type","hidden");
  hiddenField.setAttribute("id",vsvcName);
  hiddenField.setAttribute("name","details");
  hiddenField.setAttribute("value","");
  submitForm.appendChild(hiddenField);
  cell3.setAttribute("width","30%");

  if(visSelected==true){
    setDetails(vtbodyName,vsvcName);
  }
}

function setDetails(vpkgName,vsvcName){
  var appform=document.getElementById("applicationForm");
  var cbName="md_"+vsvcName+"_cb";
  var tfName="md_"+vsvcName+"_tf";
  var cb2Name="md_"+vsvcName+"_cb2";

  if(appform.elements[cbName].checked){
    if(appform.elements[cb2Name].checked){
      document.getElementById(vsvcName).value=vpkgName+","+vsvcName+","+document.getElementById(tfName).value+","+"true"+","+"true";
    }else{
      document.getElementById(vsvcName).value=vpkgName+","+vsvcName+","+document.getElementById(tfName).value+","+"true"+","+"false";
    }
  }else{
      document.getElementById(vsvcName).value=vpkgName+","+vsvcName+","+document.getElementById(tfName).value+","+"false";
  }
}

function submitForm(){
  document.getElementById("submitAppName").value=document.getElementById("applicationName").value;
  document.getElementById("submitDesc").value=document.getElementById("description").value;
}

function editApplication(varname){
  document.forms['applicationForm'].applicationName.value=varname;
  document.forms['applicationForm'].action='integration-live-metadata-applicationedit.dsp';

  return true;
}

function removeApplication(varname){
  var msg=confirm("Deleting the application from the on-premise Integration Server removes the application from webMethods Integration Cloud." +"\n"+
      " Are you sure you want to remove the application "+varname+"?");

  if(msg==false){
    return false;
  }

    document.getElementById("applicationName").value=varname;
    document.getElementById("deleteAction").value='yes';
    document.getElementById("applicationForm").action='integration-live-metadata-share.dsp';

   return true;
}

function uploadApplication(varname){
  document.forms['applicationForm'].applicationName.value=varname;
  document.forms['applicationForm'].action='integration-live-metadata-upload.dsp';

  return true;
}

function submitUploadApplication(){
  var varname=document.forms['applicationForm'].applicationName.value;

  if(!validateUploadData()){
    return false;
  }

  var msg=confirm("Uploading the application definition will replace the application on webMethods Integration Cloud." +"\n"+
      "This might affect the existing integration flows on webMethods Integration Cloud." +"\n"+
      "Are you sure you want to upload the application "+varname+"?");

  if(msg==false){
    return false;
  }
  if ( connectionsArray.length) {
    var connList = connectionsArray.join(',');
    document.forms['applicationForm'].connList.value = connList;
  }

   return true;
}

function validateData(){
  var varAppSubmitForm=document.getElementById("appSubmitForm");

  var detailsList=[];

  for(var j=0;j<varAppSubmitForm.elements.length;j++){
    var elmName=varAppSubmitForm.elements[j].name;
    if(elmName == 'details'){
      var detValue=varAppSubmitForm.elements[j].value;
      if(detValue==''){
        continue;
      }
      var svcArray=detValue.split(",");
      if(svcArray[3] == 'true'){
        setDetails(svcArray[0],svcArray[1]);
      }
      detailsList.push(varAppSubmitForm.elements[j].value);
    }
  }

  if(!validateApplicationName()){
    return false;
  }

  if(!validateDescription()){
    return false;
  }

  //var varDetails=document.getElementsByName("details");

  if(detailsList==null || detailsList.size<=0){
    return;
  }
  var dpNamesList=[];
  var dupFlag=false;
  var emptyFlag=false;

  for(var i=0;i<detailsList.length;i++){
    var fldValue=detailsList[i];
    if(fldValue==''){
      continue;
    }
    var valueArray=fldValue.split(",");
    var flag=valueArray[3];

    if(flag=='true'){
      var varDpName=valueArray[2];
      if(varDpName==''){
        alert("The Display Name is required.");
        return false;
      }

      if(!validateRestrictedChars(varDpName,"Display Name "+varDpName+" contains an invalid character.")){
        return false;
      }
      if(!validateReservedWords(varDpName,"Display Name "+varDpName+" cannot be a reserved word.")){
        return false;
      }

      var value=jQuery.inArray(varDpName,dpNamesList);
      if(value!=-1){
        alert("Duplicate Display Name : " + varDpName + ".");
        return false;
      }else{
        dpNamesList.push(varDpName);
      }
    }
  }

  return true;
}

function validateApplicationName(){
  var appName=document.getElementById("submitAppName").value;
  if(appName==null || appName==''){
    alert("The Name field is required.");
    return false;
  }

  if(appName.length>32){
    alert("The application name is longer than the maximum length. Application names cannot exceed 32 characters in length.");
    return false;
  }

  if(!validateRestrictedChars(appName,"The Name field contains an invalid character.")){
    return false;
  }

  if(!validateReservedWords(appName,"The application name "+appName+" cannot be a reserved word.")){
    return false;
  }
  return true;
}

function validateDescription(){
  var desr=document.getElementById("submitDesc").value;

  if(desr==null || desr==''){
    alert("Description is a required field.");
    return false;
  }
  return true;
}

function validateRestrictedChars(varName,msg){
  var restrictedChars=document.getElementById("restrictedChars").value;
  var varNameLength=varName.length;

  if(!isNaN(varName[0])){
    alert(msg+" ' "+varName[0]+" '");
    return false;
  }
  for(var i=0;i<varNameLength;i++){
    if(restrictedChars.indexOf(varName[i])!=-1){
      alert(msg+" "+varName[i]);
      return false;
    }
  }
  return true;
}

function validateReservedWords(varName,msg){
  var wordsArray=["abstract","assert","boolean","break","byte","byvalue", "case","cast","default","do","double","else", "extends",
                  "false","final","goto","if","implements","import","inner","instanceof","int","operator","outer","package",
                  "private","protected","public","rest","synchronized","this","throw","throws","transient","true","try",
                  "catch", "char","class","const","continue","finally","float","for","future","generic","interface","long",
                  "native","new","null","return","short","static","super","switch","var","void","volatile","while", "clone",
                  "equals","finalize","getClass","hashCode","notify","notifyAll","toString","wait","auto","enum","extern",
                  "register","signed","sizeof","static","struct","typedef","union", "unsigned","asm","delete","friend",
                  "inline","template","virtual"];

  var value=jQuery.inArray(varName,wordsArray);

  if(value!=-1){
    alert(msg);
    return false;
  }

  return true;
}

// ensure at least one account was selected and update a global variable with the connection-tenant-stage key
function validateUploadData(){

    connectionsArray = [];
    var isValid = false;

    try {
      var inputs = document.getElementsByTagName("INPUT");

      for ( var i=0; i<inputs.length; i++) {
        var inObj = inputs[i];
        var n = inObj.name;
        if ( n.startsWith("connections")) {
          if ( inObj.checked) {
            connectionsArray.push(inObj.value);
            isValid = true;
          }
        }
      }
    } catch (e) {
      console.log(e);
    }

    if ( !isValid) {
    alert("Select one or more accounts.");
    }
    return isValid;
}


function showTransferInfoMessages( tiData, parentID) {

  try {
    var transferInfo = JSON.parse( tiData);
    //console.log( JSON.stringify( transferInfo, undefined, 2) );

    var parent = document.getElementById(parentID);

    if ( parent && transferInfo) {

      if (useJQueryTabs) {
          showTransferInfoMessagesJQ( transferInfo, parent);
      } else {
          showTransferInfoMessagesBasic( transferInfo, parent);
        //parent.style.display = 'none';
        //parent.style.display = 'block';
        //parent.hidden = false;

      }
    }

  } catch (e) {

    console.log( e );
    console.log( tiData );
    alert( `Error processing status message for WmCloud service. ${tiData}` + e);
  }
}

function showTransferInfoMessagesBasic( transferInfo, parent) {

  if ( transferInfo && parent ) {

      var divMsg = document.createElement('div');
      var divMsgId = parent.id + '-transferInfo';
      divMsg.id = divMsgId;

      var len = transferInfo.tenants.length;
      if ( len > 0 ) {

        // After discussing with Dean, we decided to display only the last message to the user.
        // Showing all accrued messages is tmi.
       var fullMsg = '';
       var lastMsg = '';
       var p = document.createElement('p');
       p.className = parent.className;
       p.style.border = 'none';

       for( var idx=0; idx < transferInfo.transferEvents.length; idx++) {
        var te = transferInfo.transferEvents[idx];
        if ( te ) {
          var alias = te.tenantAlias;
          for ( jdx=0; jdx < te.messages.length; jdx++) {
              var msg = te.messages[jdx];
              if ( msg ) {
                // too ugly when alias is included in the message already
                // if ( alias != null && alias != '') {
                //    fullMsg += alias + ' - '
                //}
                fullMsg += msg.message + ' <br>';
                lastMsg = msg.message;
              }
            }
          }
        }

        if ( fullMsg != null && fullMsg != '') {
           //p.innerHTML = fullMsg;
           p.innerHTML = lastMsg;
           divMsg.appendChild( p);
        }


      }
      parent.appendChild( divMsg);
      parent.hidden = false;

    }
}

/*
 * This function accepts a JSON string representing a
 * com.softwareag.is.integrationlive.ILiveTransferInfo object.
 *
 * @param tiData String containing well-formed JSON data.
 * @param parentID DOM element id for the element displaying the tabs
 * @return a  </div> element containing displayable jQuery tabs content
 *
 *
<div id="tabs">
    <ul>
        <li><a href="#tabs-1">Tab 1</a>
        </li>
        <li><a href="#tabs-2">Tab 2</a>
        </li>
        <li><a href="#tabs-3">Tab 3</a>
        </li>
    </ul>
    <div id="tabs-1">
        <p>Content for Tab 1</p>
    </div>
    <div id="tabs-2">
        <p>Content for Tab 2</p>
    </div>
    <div id="tabs-3">
        <p>Content for Tab 3</p>
    </div>
</div>
<div id="tabid"></div>

 * Note: Tabs are chopped in-half w/o this style rule.
 * li.ui-tabs-active {
 *   display: block;
 *   height: auto;  < - critical
 *   padding: 0px;
 * }

 */
function showTransferInfoMessagesJQ( transferInfo, parent) {

  if ( transferInfo && parent ) {

      var divMsg = document.createElement('div');
      var divMsgId = parent.id + '-transferInfo';
      divMsg.id = divMsgId;

      var backColor = "lightgreen";
      backColor = getMessageColor( transferInfo.status);

      var len = transferInfo.tenants.length;
      if ( len > 0 ) {
        var divMap = new Map();
        var ul = document.createElement('ul');
        divMsg.appendChild( ul);
        for( var idx=0; idx < len; idx++) {
          var ti = transferInfo.tenants[idx];

          if ( ti) {
            var alias = transferInfo.tenants[idx].tenant;
            var li = document.createElement('li');
            ul.appendChild( li);
            var a = document.createElement('a');
            var divId = "tabs-"+idx;
            a.href= '#' + divId;
            var lbl = document.createTextNode(alias);
            a.appendChild(lbl);
            li.appendChild(a);

            var div = document.createElement('div');
            div.id = divId;
            divMap.set( alias, div);
            divMsg.appendChild(div);
          }
        }
      }


      for( var idx=0; idx < transferInfo.transferEvents.length; idx++) {
        var te = transferInfo.transferEvents[idx];
        if ( te ) {
          var alias = te.tenantAlias;
          for ( jdx=0; jdx < te.messages.length; jdx++) {
            var div = divMap.get(alias);
            if ( div ) {
              div.style.background = backColor;
              var msg = te.messages[jdx];
              if ( msg ) {
                var p = document.createElement('p');
                p.style.background = backColor;
                var txt = document.createTextNode( msg.message );
                p.appendChild( txt );
                div.appendChild( p);
              }
            }
          }
        }
      }
      parent.appendChild( divMsg);

      //console.log('divMsg...');
      //console.log( divMsg );


      // important! Don't display the tabs before the dom is ready!
      $(document).ready(function () {

        $('#'+divMsgId).tabs({
          activate: function (event, ui) {
          var active = $('#tabs').tabs('option', 'active');
          //$("#tabid").html('the tab id is ' + $("#tabs ul>li a").eq(active).attr("href"));
          }
        });

      });
    }
}

function getMessageColor( status) {


  if ( status ) {
    if ( useJQueryTabs ) {
      var backColor = "lightgreen";
      if ( status == "RED" ) {
        backColor = "lightpink";
      } else if ( status == "YELLOW" ) {
        backColor = "lightyellow";
      }
    }

  }
  return backColor;

}
