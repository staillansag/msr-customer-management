function jdbcAdapterConnPropValidator(theForm)
{
	var portStr = (theForm.elements['.CPROP.portNumber'] != "undefined") ? theForm.elements['.CPROP.portNumber'].value : "";
	if((portStr.length > 0) && (!isNumber(portStr) || (parseInt(portStr) < 0) || (parseInt(portStr) > 65535) || portStr.length > 5))
	{
		return "Invalid Port Number.";
	}
	return "";
}
adapterConnPropValidator = jdbcAdapterConnPropValidator;