/*
 * Copyright � 1996 - 2017 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
*/
var _csrfTokenNm_           =  _csrfTokenNm_;
var _csrfTokenVal_          =  _csrfTokenVal_;    
var is_csrf_guard_enabled   =  is_csrf_guard_enabled;
var needToInsertToken       =  needToInsertToken;
var webMethods_wM_AdminUI   =  webMethods_wM_AdminUI;

if(is_csrf_guard_enabled != true && is_csrf_guard_enabled != false) {
    is_csrf_guard_enabled = false;
}

if(needToInsertToken != true && needToInsertToken != false) {
    needToInsertToken = false;
}
var row = "even";
var other = "odd";
var swap = "";

var path1 = "";
var menu1 = "";
var path1_class = "";


var normal = 1;
var error  = 2;
var serverkey = 4;


function w(text)
{
    document.write(text);
}

function isEmpty(msg)
{
    return trim(msg).length == 0;
}

function pathInit(css_class)
{
    path1 = "";
    path1_class = css_class;
    
}

function pathAdd(text, url)
{
    path1 += text;
    path1 += " &gt; ";
}

function pathShow()
{
    w("<table width=100% >");
    w("<tr>");
    w("<td class=" + path1_class + ">");
    w(path1);
    w("</td></tr></table>");
}


function menuInit()
{
    menu1 = "";
    
}


function normalize(text)
{
    var newstring = "";
    for(var i = 0; i < text.length; i++){
        if(text.substring(i,i+1) == "\uff11") newstring += "1"; 
        else if(text.substring(i,i+1) == "\uff12") newstring += "2"; 
        else if(text.substring(i,i+1) == "\uff13") newstring += "3"; 
        else if(text.substring(i,i+1) == "\uff14") newstring += "4"; 
        else if(text.substring(i,i+1) == "\uff15") newstring += "5"; 
        else if(text.substring(i,i+1) == "\uff16") newstring += "6"; 
        else if(text.substring(i,i+1) == "\uff17") newstring += "7"; 
        else if(text.substring(i,i+1) == "\uff18") newstring += "8"; 
        else if(text.substring(i,i+1) == "\uff19") newstring += "9"; 
        else if(text.substring(i,i+1) == "\uff10") newstring += "0"; 
        else if(text.substring(i,i+1) == "\uff0e") newstring += ".";
        else if(text.substring(i,i+1) == "\u3002") newstring += ".";
        else newstring += text.substring(i,i+1);
    }
    return newstring;
}

function menuAdd(text, url, bonus_text)
{
    menu1 += "<li>";
    menu1 += "<a href=\"" + url + "\">" + text + "</a>";
    if (bonus_text)
    {
        menu1 += "<br>";
        menu1 += bonus_text;
    }
    menu1 += "</li>";

}

function menuShow()
{
    w("<table width=100% >");
    w("<tr>");
    w("<td>");  //class=\"submenu\"
    w("<ul>");
    w(menu1);
    w("</ul>");
    w("</td></tr></table>");
}

function messageInit()
{
    message1 = "";
}

function messageAdd(text, message_type)
{
    menu1 += text;
}

function messageShow()
{
    w("<table width=100% >");
    w("<tr>");
    w("<td class=\"message\">");
    w(menu1);
    w("</td>");
    w("</tr>");
    w("</table>");
}

function writeEditPass(mode, name, value)
{
    if (mode == 'edit')
    {
        w("<input type=\"password\" name=\""+name+"\" value=\""+value+"\">");
    }
    else {
        if(value == "")
            value = "unspecified";
        w(value);
    }
}

function writeEdit(mode, name, value) {
    if (mode == 'edit')
    {
        w("<input type=\"text\" name=\""+name+"\" value=\""+value+"\">");
    }
    else {
        if(value == "")
            value = "unspecified";
        w(value);
    }
}

function writeEdit(mode, name, value, id)
{
	if(mode == 'edit')
	{
		w("<input id=\""+id+"\" type=\"text\" name=\""+name+"\" value=\""+value+"\">");
	}
	else
	{
		if(value == "")
			value = "unspecified";
		w(value);
	}
}
/*
function writeEdit_appendToParentElementID(mode, name, value, parentID){
    if (mode === 'edit') {
        var inputTag = document.createElement('input');
        inputTag.setAttribute('text', 'text');
        inputTag.setAttribute('name', name);
        inputTag.setAttribute('value', value);
        document.getElementById(parentID).appendChild(inputTag);
    } else {
        if (value === '') {
         value = 'unspecified';
            var spanTag = document.createElement('span');CsrfGuardUITest
            spanTag.textContent = value;
            document.getElementById(parentID).appendChild(spanTag);
        }
    }
}

function writeEdit_appendToParentElementID(mode, name, value, id, parentID){
    if (mode === 'edit') {
        var inputTag = document.createElement('input');
        inputTag.setAttribute('text', 'text');
        inputTag.setAttribute('id', id);
        inputTag.setAttribute('name', name);
        inputTag.setAttribute('value', value);
        document.getElementById(parentID).appendChild(inputTag);
    } else {
        if (value === '') {
         value = 'unspecified';
            var spanTag = document.createElement('span');
            spanTag.textContent = value;
            document.getElementById(parentID).appendChild(spanTag);
        }
    }
}
*/
function writeEditNullable(mode, name, value)
{
    if(mode == 'edit')
    {
        w("<input type=\"text\" name=\""+name+"\" value=\""+value+"\">");
    }
    else
    {
        w(value);
    }
}
function writeEditWithID(mode, name, value) {
    if (mode == 'edit')
    {
        w("<input type=\"text\" name=\""+name+"\" id=\""+name+"\" value=\""+value+"\">");
    }
    else {
        if(value == "")
            value = "unspecified";
        w(value);
    }
}


function writeMessage(msg)
{
    w("<TR><TD class=\"message\" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;"+msg+"</TD></TR>");
}

function reloadTopFrame()
{
    parent.topmenu.location.replace("top.dsp");
}

function reloadNavigationFrame()
{
    parent.menu.location.replace("menu.dsp");
}

function writeTD (c)
{
    w("<TD CLASS=\"");
    w(row);
    w(c);
    w("\">");
    return true;
}
function writeTDnowrap (c)
{
    w("<TD CLASS=\"");
    w(row);
    w(c);
    w("\" NOWRAP>");
    return true;
}

function writeTDspan(c,span)
{
    w("<TD CLASS=\"");
    w(row);
    w(c);
    w("\" COLSPAN=");
    w(span);
    w(">");
}

function writeTDrowspan(c,span)
{
    w("<TD CLASS=\"");
    w(row);
    w(c);
    w("\" ROWSPAN=");
    w(span);
    w(">");
}

function writeTDWidth (c, width)
{
    w("<TD CLASS=\"");
    w(row);
    w(c);
    w("\" WIDTH=");
    w(width);
    w(">");
}

function swapRows()
{
    swap = row;
    row = other;
    other = swap;
}

function resetRows()
{
    row = "even";
    other = "odd";
    swap = "";
}


function isNum(num) 
{
    num = num.toString();

    if (num.length == 0)
        return false;

    for (var i = 0; i < num.length; i++)
        if (num.substring(i, i+1) < "0" || num.substring(i, i+1) > "9")
            return false;

    return true;
}


function verifyRequiredField(form, field)
{
    var data = document.forms[form][field].value;

    if (isblank(data))
    {
        document.forms[form][field].focus();
        return false;
    }
    return true;
}

function verifyRequiredNonNegNumber(form, fieldName)
{
    var field = document.forms[form][fieldName];

    if (isblank(field.value))
    {
        field.focus();
        return false;
    }

    if ( !isNum(field.value))
    {
        field.focus();
        return false;
    }

    if ( field.value < 0)
    {
        field.focus();
        return false;
    }

    return true;
}



function verifyRequiredFieldList(form, fieldList)
{
    for (index in fieldList)
    {
    if (!verifyRequiredField(form, fieldList[index]))
    {
            alert ("Error: The selected field requires valid data.");
            return false;
    }
    }
    return true;
}

function verifyFieldsEqual(form, field1, field2)
{
    if (document.forms[form][field1].value != document.forms[form][field2].value)
    {
        alert("Error: Fields must have the same value.  Try typing them in again.");
        document.forms[form][field1].focus();
        return false;
    }
    return true;
}

function setNavigation(doc_url, help_url, is_doc)
{

    if(parent == null || parent.frames == null || parent.frames.menu == null || parent.frames.menu.document == null)
        return false;

    if(parent.frames.menu.moveArrow != null)
    {
        if(is_doc != null) parent.frames.menu.moveArrow(doc_url);
        else
            parent.frames.menu.moveArrow(doc_url+location.search);
    }

    if(parent.frames.menu.document.forms["urlsaver"] != null && parent.frames.menu.document.forms["urlsaver"].helpURL != null)
        parent.frames.menu.document.forms["urlsaver"].helpURL.value = help_url;
    
    return true;
    
}  


function initMenu(firstImage)
{
    var previousMenuImage = document.images[firstImage];
    previousMenuImage.src="images/selectedarrow.gif";
    return true;
}

function swapColor(objName, label) {

    if (navigator.appName == 'Netscape') {}
    else {
    var theObj = eval(objName);
    if(theObj.childNodes == null) return;
    for(var i = 1; i < theObj.childNodes.length; i=i+4){
        for(var j = 0; j < theObj.childNodes[1].childNodes.length; j++){
        theObj.childNodes[i].childNodes[j].style.background='#f0f0e0';
        }
        if (label==true)
        theObj.childNodes[i].firstChild.style.background='#f0f0e0';
    }
    }   
}

function isblank(s)
{
    for (var i=0; i<s.length; i++ ) {
        var c  = s.charAt(i);
        if ((c != ' ') && (c != '\n') && (c != '\t')) 
            return false;
    }
    return true;
}

function isInteger(input)
{
    if ( isNaN(parseInt(input)) || (input.indexOf(".") >= 0) ||
         (parseInt(input) != input))
    {
    return false;
    }
    return true;
}

function isIntegerGreaterThan(input, comp)
{
    if (! isInteger(input))
    {
        return false;
    }
    if (parseInt(input) <= parseInt(comp)) 
    {
    return false;
    }
    return true;
}
function isIntegerLessThan(input, comp)
{
    if (! isInteger(input))
    {
        return false;
    }
    if (parseInt(comp) < parseInt(input)) 
    {
        return false;
    }
    return true;
}

function writeExpiredValue(expires) {

    if (expires == "never") {
        w("never");
    }
    else if (expires == "temporary") {
        w("upon service completion");
    }
    else if (expires < 1) {
        w("expired");
    }
    else {
        w(expires);
        w(" sec");
    }
}

function isIPv6Address(host){
    var ipv6Pattern = /^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$/;
    var isIPv6Address = false;
    host = trim(host);
    if (host!='') {
        if (host.indexOf('[')==0 && host.lastIndexOf(']')== host.length-1) {
            host = host.substring(1, host.length- 1);
        }
        isIPv6Address = ipv6Pattern.test(host);
    }
    
    return isIPv6Address;
}

function concatHostAndPortString(host,port) {
    var retval = (host == '') ? '' : trim(host);
    if (!isblank(port)) {
    var isIPv6 = isIPv6Address(retval);
        if (isIPv6&&!(retval.indexOf('[')==0 && retval.lastIndexOf(']')== retval.length-1)) {
            retval = '[' + retval +']'; //surround host name with [] 
        }
        retval = retval+':'+port;
    }
    return retval;
}

function splitHostAndPortString(hostwithPortString) {
    var ipDetails = ["",""];

    if (!isblank(hostwithPortString)) {
        hostwithPortString = trim(hostwithPortString);
        ipDetails[0] = hostwithPortString;
        var index = -1;
        // To ensure that the entered String ipAddress has a port number towards the end,
        //if  it doesn't , do not enter the if block returning only the host in 1st index of array ipDetails
        if (!isIPv6Address(hostwithPortString)) {
            if (hostwithPortString.indexOf('[')==0
                && (index = hostwithPortString.lastIndexOf("]:")) > -1) {
                ipDetails[0] = hostwithPortString.substring(1, index);//ignore the '[' and ']' 
                ipDetails[1] = hostwithPortString.substring(index + 2);
            }
        else {
                // for IPv4 address- if ipAddress consists only of hostName
                // , indexOf returns -1 and empty port string is returned.
                index = hostwithPortString.lastIndexOf(':');
                if (index > -1) {
                    ipDetails[0] = hostwithPortString.substring(0, index);
                    ipDetails[1] = hostwithPortString.substring(index + 1);
                }
            }
        }
    }
    return ipDetails;
}
function trim (str) {
    var str = str.replace(/^\s\s*/, ''),
    ws = /\s/,
    i = str.length;
    while (ws.test(str.charAt(--i)));
    return str.slice(0, i + 1);
}

function isSpclChar(input){
    var iChars = "&()\\\';,/\":<>";
    for(var i=0;i<input.length;i++){
    if(iChars.indexOf(input.charAt(i)) != -1){
            return true;
    }
    }
    return false;
}

function createForm(formname, action, method, parent_tag) {
	if (!is_csrf_guard_enabled && !needToInsertToken) {
		return;
	}
	
	var htmlform = document.createElement('form');
	htmlform.setAttribute("name", formname);
	htmlform.setAttribute("id", formname);
	htmlform.setAttribute("method", method);
	
	if (webMethods_wM_AdminUI) {
		if (action.indexOf("webMethods-wM-AdminUI") < 0) {
		    action = setQueryParamDelim(action) + "webMethods-wM-AdminUI=true";
		}
		var element = document.createElement("input");
		element.setAttribute("type", "hidden");
	    element.setAttribute("name", "webMethods-wM-AdminUI");
	    element.setAttribute("value", "true");
		htmlform.appendChild(element);
	}
	
	htmlform.setAttribute("action", action);
	
	
	document.getElementsByTagName(parent_tag)[0].appendChild(htmlform);
}

function setFormProperty(form, propertyName, propertyValue) {
	if (!is_csrf_guard_enabled && !needToInsertToken) {
		return;
	}
	var element = document.createElement("input");
                                                 
	element.setAttribute("type", "hidden");
    element.setAttribute("name", propertyName);
    element.setAttribute("value", propertyValue);
    
	var htmlform = document.forms[form];
    htmlform.appendChild(element);
	
    if (form == "htmlForm_listeners" && propertyName == "listenerType" && (!propertyValue || propertyValue.length == 0)) {
    	return;
    }
    var actionElement = htmlform.getAttribute("action");
    if ((propertyName == "webMethods-wM-AdminUI" && actionElement.indexOf("webMethods-wM-AdminUI")) ||
    		propertyName == "secureCSRFToken") {
    	return;
    }
    
    actionElement = setQueryParamDelim(actionElement) + propertyName + "=" + encodeURIComponent(propertyValue);
    htmlform.setAttribute("action", actionElement);
}

function createFormWithTarget(formname, action, method, parent_tag, target) {
	if (!is_csrf_guard_enabled && !needToInsertToken) {
		return;
	}
	createForm(formname, action, method, parent_tag);
	var htmlform = document.forms[formname];
	htmlform.setAttribute("target", target);
}

function createFormWithTargetAndSetProperties(formname, action, method, parent_tag, target) {
	
	action = decodeURIComponent(action);
	//alert(action);
	var url = action;
	//alert("ori url:"+url);
	var qIndex = url.indexOf('?');
	if(qIndex > 0) {
		url = action.substring(0, qIndex);
		//alert("form url part:"+url);
		if(target == null) {
			createForm(formname, url, method, parent_tag);
		} else {
			createFormWithTarget(formname, url, method, parent_tag, target);
		}
		var paramStr = action.substring(qIndex+1);
		//alert("params:"+paramStr);
		if (paramStr.indexOf('?') > 0) {
			//alert("param string has ? :"+paramStr);
			var eqIdx = paramStr.indexOf('=');
			var name = paramStr.substring(0, eqIdx);
			var value = paramStr.substring(eqIdx+1);			
			setFormProperty(formname, name, value);			
		}
		var params = null;
		if(paramStr.indexOf('&amp;') > 0) {
			params = paramStr.split('&amp;');
		} else {
			params = paramStr.split('&');
		}
		if(params.length > 0) {
			for(var i=0; i < params.length; i++) {
				var param = params[i].split('=');
				if(param.length == 2) {
					var paramName = param[0];
					var paramValue = param[1];
					
					if(paramName != null && paramValue != null) {
						//alert(paramName + " : "+paramValue)
						setFormProperty(formname, paramName, paramValue);
					}
				}
			}
		}
	} else {
		if(target == null) {
			createForm(formname, url, method, parent_tag);
		} else {
			createFormWithTarget(formname, url, method, parent_tag, target);
		}
	}
}

function createFormAndSetProperties(formname, action, method, parent_tag) {
	if (!is_csrf_guard_enabled && !needToInsertToken) {
		return;
	}
	createFormWithTargetAndSetProperties(formname, action, method, parent_tag, null);
}

function populateForm(fm, pairs) {
	var actionElement = fm.getAttribute("action");
	var pairArray = pairs.split(';');
	var onePair;
	var keyVal;
	if(pairArray.length > 0) {
		for(var i=0;i < pairArray.length; i++) {
			onePair = pairArray[i];
			keyVal = onePair.split("=")
			if(keyVal.length > 0 && keyVal.length == 2) {
				fm.elements[keyVal[0]].value = keyVal[1];
				
			    if (keyVal[0] == "secureCSRFToken") {
			    	continue;
			    }
			    
			    if (actionElement.indexOf(keyVal[0] + "=") > 0) {
			    	actionElement = replaceUrlParam(actionElement, keyVal[0], encodeURIComponent(keyVal[1]));
			    }
			    else {
			    	actionElement = setQueryParamDelim(actionElement) + keyVal[0] + "=" + encodeURIComponent(keyVal[1]);
			    }
			}
		}
		fm.setAttribute("action", actionElement);
	}
	return true;
}

function replaceUrlParam(url, paramName, paramValue)
{
    if (paramValue == null) {
        paramValue = '';
    }
    var pattern = new RegExp('\\b('+paramName+'=).*?(&|#|$)');
    if (url.search(pattern)>=0) {
        return url.replace(pattern,'$1' + paramValue + '$2');
    }
    url = url.replace(/[?#]$/,'');
    return url + (url.indexOf('?')>0 ? '&' : '?') + paramName + '=' + paramValue;
}

function getURL_withParentLink(normalURL, submitURL, linkname, parentID) {

    var a = document.createElement("a");
    var newSubmitLink;
	if(is_csrf_guard_enabled && needToInsertToken) {
		newSubmitLink = submitURL;
		if (webMethods_wM_AdminUI) {
        		if (submitURL && submitURL.indexOf('.') > 0) {
                		  var res = submitURL.split(".");
                		  if (res && res.length > 1) {
                			  setFormProperty(res[1], 'webMethods-wM-AdminUI', 'true');
                		  }
                	  }
        	}
        	else {
        		var params = parseQueryString();
        		if (params["webMethods-wM-AdminUI"]) {
        			if (submitURL && submitURL.indexOf('.') > 0) {
                    		  var res = submitURL.split(".");
                    		  if (res && res.length > 1) {
                    			  setFormProperty(res[1], 'webMethods-wM-AdminUI', 'true');
                    		  }
                    	  }
        		}
        	}

    } else {
        newSubmitLink = normalURL;

		if (webMethods_wM_AdminUI) {
        		if (normalURL.includes("?")) {
                			newSubmitLink = newSubmitLink + '&webMethods-wM-AdminUI=true';
                		}
                		else {
                			newSubmitLink = newSubmitLink + '?webMethods-wM-AdminUI=true';
                		}
        	}
        	else {
        		var params = parseQueryString();
        		if (params["webMethods-wM-AdminUI"]) {
        			if (normalURL.includes("?")) {
                    			newSubmitLink = newSubmitLink + '&webMethods-wM-AdminUI=true';
                    		}
                    		else {
                    			newSubmitLink = newSubmitLink +'?webMethods-wM-AdminUI=true';
                    		}
        		}
        	}
	}
	a.href = newSubmitLink;
	a.title = linkname;
	var linkText = document.createTextNode(linkname);
	// Append the text node to anchor element.
	a.appendChild(linkText);
	document.getElementById(parentID).appendChild(a);
}

function getURL(normalURL, submitURL, linkname) {
	if(is_csrf_guard_enabled && needToInsertToken) {
		document.write('<a href=');
		document.write(submitURL);
		handleWmAdminUI(submitURL);
		document.write('>');
		document.write(linkname);
		document.write('</a>');		
    } else {
        document.write('<a href=');
		document.write(normalURL);
		handleWmAdminUI(normalURL);
		document.write('>');
		document.write(linkname);
		document.write('</a>');
    }
}

function handleWmAdminUI(sURL) {
	if (webMethods_wM_AdminUI) {
		addWmAdminUIQueryParam(sURL);
	}
	else {
		var params = parseQueryString();
		if (params["webMethods-wM-AdminUI"]) {
			addWmAdminUIQueryParam(sURL);
		}
	}
}

function addWmAdminUIQueryParam(sURL) {
	if(is_csrf_guard_enabled && needToInsertToken) {
		if (sURL && sURL.indexOf('.') > 0) {
		  var res = sURL.split(".");
		  if (res && res.length > 1) {
			  var htmlform = document.forms[res[1]];
			  if (htmlform) {
			      setFormProperty(res[1], 'webMethods-wM-AdminUI', 'true');
			  }
		  }
	  }
	}
	else {
		if (sURL.includes("?")) {
			document.write('&webMethods-wM-AdminUI=true');
		}
		else {
			document.write('?webMethods-wM-AdminUI=true');
		}
	}
}

function parseQueryString()  {

    var str = document.location.search;
    var objURL = {};

    str.replace(
        new RegExp( "([^?=&]+)(=([^&]*))?", "g" ),
        function( $0, $1, $2, $3 ){
            objURL[ $1 ] = $3;
        }
    );
    return objURL;
}

function getUrlParameter(keyword, query_string) {
    keyword = keyword.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp( keyword + '=([^&#]*)');
    var results = regex.exec( query_string );
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
};

function setQueryParamDelim(uVal) {
	if (uVal.indexOf("?") > 0) {
      uVal += "&";
    }
    else{
      uVal += "?";
    }
    return uVal;
}

// pie-73087
var deValidateHandler = function deInputValidator( event ) {

    // console.log( 'running deValidateHandler:  event = ' + event );
    ok = true;
    if ( event ) {

        var inputText;
        inputEl = event.target;
        if ( inputEl ) {
            var regKey = 'regexValidator-' + inputEl.name;
            var whiteListRegex = inputEl.getAttribute( regKey);
            var inputDesc = inputEl.getAttribute( 'inputDesc');
            if ( "undefined" == inputDesc) {
                inputDesc = undefined;
            }
		    inputText = inputEl.value;
		   if ( inputText &&  (typeof inputText === 'string') ) {
                var matchVal = inputText.match(whiteListRegex);
                ok = Boolean(matchVal);
                var errMsgTemplate = inputEl.getAttribute( 'errMsgTemplate');
                var formatErr = "unexpected am i";
                if ( !ok) {
                    try {
                       var substitute = '$inputText';
                       if ( !errMsgTemplate || "undefined" == errMsgTemplate) { // undefined converts to a string with attribute ref
                            errMsgTemplate = "Illegal value: ' " + substitute + " ' fails input validation!";
                       }

                       var errMsg;
                       var pos = errMsgTemplate.indexOf( substitute);
                       if ( pos >= 0) {
                            errMsg = errMsgTemplate.substring( 0, pos) + inputText + errMsgTemplate.substring( pos + substitute.length );
                       } else {
                            errMsg = errMsgTemplate;
                       }
                   } catch (e) {
                        formatErr = "Format error for ' " + errMsg + " ' cause: " + e.message;
                        errMsg = "Illegal value: ' + inputText + ' fails input validation! ";
                   } finally {
                        inputEl.value = "";
                   }

                    if ( inputDesc) {
                        alert( errMsg +'\n Please enter: ' + inputDesc );
                    } else {
                        alert( errMsg );
                    }
                   if ( formatErr) {
                        console.log(  formatErr );
                   }

                }
           }
        }
        // console.log( 'Is "' + inputText + '" clean? ' + ok );

    }
    return ok;
}

// pie-73087
function deInputValidation( errMsgTemplate) {

// console.log( 'running deInputValidation');

    try {
        var deMap = new Map();
        // This section is for looking up the root data elements.
        // This is needed because it is not possible to resolve a reference back to a root element.
        var sheets = Array.from(document.styleSheets);
        for ( var kdx = 0; kdx<sheets.length; kdx++) {
            var sheet = sheets[kdx];
            var rules = sheet.cssRules;
            for ( var ldx=0; ldx<rules.length; ldx++) {
                var rule = rules[ldx];
                try {
                    if ( rule.selectorText === ":root") {
                        // https://developer.mozilla.org/en-US/docs/Web/API/StylePropertyMapReadOnly
                        if ( rule.styleMap) {
                            var map = rule.styleMap.entries();
                            var propObj; // object for an attribute : value ; entry
                            do {
                                propObj = map.next();
                                if ( propObj.done) {
                                    break;
                                }
                                var attrName = propObj.value[0];
                                if ( attrName.indexOf( '--de-') >= 0 ) {
                                    // https://developer.mozilla.org/en-US/docs/Web/API/CSSUnparsedValue
                                    var valueMap = propObj.value[1];  //
                                    var attrValMap = valueMap.values().next().value;
                                    var attrVal = attrValMap.values().next().value; // why the second nesting here?
                                    // console.log( attrName + '=' + attrVal );
                                    // e.g. --de-alpha-numeric =  ^[a-zA-Z0-9 _-]*$
                                    deMap.set( attrName, attrVal);
                                }
                            } while ( !propObj.done );
                        }

                    }
                } catch (e)
                {
                    // console.log( 'Exception registering whitelist validation handler ' + e);
                }
            }
        }

        if ( document ) {

            var regex;
            var rootElement = document.documentElement;
            var root = document.querySelector(':root');
            var deName;

            var inputs = document.getElementsByTagName('input');
            // console.log( 'inputs.length = ' + inputs.length);
            for (var idx = 0; idx < inputs.length; idx++) {
                regex = undefined;
                var inputEl = inputs[idx];
                if ( 'TEXT' == inputEl.getAttribute('type').toUpperCase()) {
                    var inputName = inputEl.name;
                    regKey =  'regexValidator-' + inputName;
                    if ( inputEl.getAttribute( regKey ) == null ) {
                        deName = inputEl.style.getPropertyValue( "--input-validator");
                        if ( deName) {
                            regex = deMap.get( deName);
                        }
                        if ( !regex) {
                            // get the style attribute's text string and parse it
                                var attrStyles = inputEl.getAttribute('style');
                                if ( attrStyles) {
                                    var stylePairs = attrStyles.split(';');
                                    for ( var jdx = 0; jdx < stylePairs.length; jdx++ ) {
                                        var stylePair = stylePairs[jdx];
                                        if ( stylePair) {
                                            var aStyle = stylePair.split(':');
                                            if ( aStyle && aStyle.length == 2 && '--input-validator' == aStyle[0]) {
                                                regex = deMap.get( aStyle[1]);
                                                break;
                                            }
                                        }
                                    }
                                }
                        }
                        if ( !regex) {

                            //https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
                            //https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
                            regex = getComputedStyle(inputEl).getPropertyValue("--input-validator");

                        }

                        if ( !regex ) {
                            regex = "^[a-zA-Z0-9@., _-]*$ ;; only alpha-numeric or these characters:  @ <space> . , _ -";
                        }

                        var begin = regex.indexOf('"');
                        var inputDesc;
                        if ( begin >= 0) {
                                var end = regex.indexOf( ";;");
                                if ( end < 0 ) {
                                    end = regex.length;
                                    regex = regex.substring( begin+1, regex.length-1);
                                } else {
                                    inputDesc = regex.substring( end+2, regex.length-1);
                                    regex = regex.substring( begin+1, end-1);

                                }

                        }

                        if (regex) {
                            regex = regex.trim();
                        }
                        inputEl.addEventListener( 'focusout', deValidateHandler );
                        inputEl.setAttribute( regKey, regex);
                        inputEl.setAttribute( 'inputDesc', inputDesc);
                        inputEl.setAttribute( 'errMsgTemplate', errMsgTemplate);

                    } else {
                        // console.log( 'regexValidator property already set');
                    }
                } else {
                    // console.log( 'input element is not of type text');
                }
            } 
        }
    } catch (e) {        
        // console.log( 'Exception registering whitelist validation handler ' + e);
    }
}
