function generateURL(linkId, sourceUrl, linkContent)
{
	linkId=linkId.replace(/ /g,"_").replace(/\./g,"_");
	var formName = "htmlform_" + linkId;
	createFormAndSetProperties(formName, sourceUrl, "POST", "BODY");
	var submitUrl = "javascript:document." + formName + ".submit(); id='" + linkId + "' ";
	sourceUrl += " id='" + linkId + "'";
	getURL(sourceUrl, submitUrl, linkContent);
}

function updateURL(elemId, linkContent)
{
	if(!is_csrf_guard_enabled && !needToInsertToken)
	{
		return;
	}
	var elem = document.getElementById(elemId);
	if(elem == undefined || elem == null)
	{
		return;
	}
	elem.parentNode.removeChild(elem);
	var url = elem.href;
	if (url != null) url = decodeURIComponent(url);
	if(url && url.indexOf("javascript:submitURL") >= 0)
	{
		var startIndx = url.indexOf("('");
		var endIndx = url.indexOf("')");
		url = url.substring(startIndx + 2, endIndx);
	}
	generateURL(elemId, url, linkContent);
	var newElem = document.getElementById(elemId);
	for(var j = 0, attrs = elem.attributes; j < attrs.length; j++)
	{
		if(attrs[j].nodeName != 'href' && attrs[j].nodeName != 'id')
		{
			var attrVal = elem.getAttribute(attrs[j].nodeName);
			newElem.setAttribute(attrs[j].nodeName, attrVal);
		}
	}
}