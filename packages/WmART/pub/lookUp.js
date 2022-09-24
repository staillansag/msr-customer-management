/*
 * Copyright © 1996 - 2017 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
*/

function dynamicLookUpForEdit(frm,key,val,lblName){
	try {
				
			var lbl = document.getElementById(lblName);
			lbl.innerHTML = "Fetching lookup data...";
			var winname = '&lookupKey='+key + '&lookupKeyValue='+val+'&adapterTypeName='+frm.elements.adapterTypeName.value + '&connectionFactoryType='+frm.elements.connectionFactoryType.value ;
			
			var http = new XMLHttpRequest();
			http.open("POST", "getLookupDetails.dsp?", true);
			http.send(winname);
	
			http.onreadystatechange = function(){
				if(http.readyState == 4 && http.status == 200){
					var res = decodeURIComponent(http.responseText);
					res = res.trim();
					if(res.indexOf("Error encountered") == -1)
					{
						var jsonData = JSON.parse(res);
						for (var i = 0; i < jsonData.lookups.length; i++) {
							var lookup = jsonData.lookups[i];
							var fieldName = ".CPROP."+ lookup.name;
							var listBox = frm.elements[fieldName];
							listBox.options.length=0;
							for(var j =0;j<lookup.values.length;j++)
							{
								listBox.options[listBox.options.length] = new Option( lookup.values[j],lookup.values[j]);
							}
						}
						for(var k=0;k<jsonData.hiddenParams.length;k++)
						{
							var param = jsonData.hiddenParams[k];
							var fieldName = ".CPROP."+param;
							frm.elements[fieldName].parentElement.parentElement.style.display='none';
							if(frm.elements[fieldName].tagName=="INPUT")
							{
								if(frm.elements[fieldName].type=="password")
								{
									var retryPwdFieldName = "PWD.CPROP."+param;
									frm.elements[retryPwdFieldName].parentElement.parentElement.style.display='none';
								}
							}
						}
						
						for(var k=0;k<jsonData.showParams.length;k++)
						{
							var param = jsonData.showParams[k];
							var fieldName = ".CPROP."+param;
							frm.elements[fieldName].parentElement.parentElement.style.display='';
							if(frm.elements[fieldName].tagName=="INPUT")
							{
								if(frm.elements[fieldName].type=="password")
								{
									var retryPwdFieldName = "PWD.CPROP."+param;
									frm.elements[retryPwdFieldName].parentElement.parentElement.style.display='';
								}
							}
						}
					}
					else
					{
						alert(res);
					}
				}; 
			};
			lbl.innerHTML="";
			if(typeof(frm.resourceName) !== 'undefined')	
				nextwindow = location.href + "&resourceName=" + frm.resourceName.value;
			if(typeof(frm.resourceFolderName) !== 'undefined')
				nextwindow = nextwindow + "&resourceFolderName=" + frm.resourceFolderName.value;

	}
	catch(ex){
		alert(ex);
		alert(ex.message);
	}
}

function dynamicLookUp(frm,key,val){
	try {
				
			var winname = '&lookupKey='+key + '&lookupKeyValue='+val+'&adapterTypeName='+frm.elements.adapterTypeName.value + '&connectionFactoryType='+frm.elements.connectionFactoryType.value ;
			
			var http = new XMLHttpRequest();
			http.open("POST", "getLookupDetails.dsp?", true);
			http.send(winname);
	
			http.onreadystatechange = function(){
				if(http.readyState == 4 && http.status == 200){
				var res = decodeURIComponent(http.responseText);
				res = res.trim();
					if(res.indexOf("Error encountered") == -1)
					{
						var jsonData = JSON.parse(res);
						for (var i = 0; i < jsonData.lookups.length; i++) {
							var lookup = jsonData.lookups[i];
							var fieldName = ".CPROP."+ lookup.name;
							var listBox = frm.elements[fieldName];
							listBox.options.length=0;
							for(var j =0;j<lookup.values.length;j++)
							{
								listBox.options[listBox.options.length] = new Option( lookup.values[j],lookup.values[j]);
							}
						}
						for(var k=0;k<jsonData.hiddenParams.length;k++)
						{
							var param = jsonData.hiddenParams[k];
							var fieldName = ".CPROP."+param;
							frm.elements[fieldName].parentElement.parentElement.style.display='none';
							if(frm.elements[fieldName].tagName=="INPUT")
							{
								if(frm.elements[fieldName].type=="password")
								{
									var retryPwdFieldName = "PWD.CPROP."+param;
									frm.elements[retryPwdFieldName].parentElement.parentElement.style.display='none';
								}
							}
						}
						
						for(var k=0;k<jsonData.showParams.length;k++)
						{
							var param = jsonData.showParams[k];
							var fieldName = ".CPROP."+param;
							frm.elements[fieldName].parentElement.parentElement.style.display='';
							if(frm.elements[fieldName].tagName=="INPUT")
							{
								if(frm.elements[fieldName].type=="password")
								{
									var retryPwdFieldName = "PWD.CPROP."+param;
									frm.elements[retryPwdFieldName].parentElement.parentElement.style.display='';
								}
							}
						}
					}
					else
					{
						alert(res);
					}
				};   
			};
			if(typeof(frm.resourceName) !== 'undefined')	
				nextwindow = location.href + "&resourceName=" + frm.resourceName.value;
			if(typeof(frm.resourceFolderName) !== 'undefined')
				nextwindow = nextwindow + "&resourceFolderName=" + frm.resourceFolderName.value;

	}
	catch(ex){
		alert(ex);
		alert(ex.message);
	}
}

function dynamicLookUpForDisplay(frm,key,val,lblName){
	try {
				
			var winname = '&lookupKey='+key + '&lookupKeyValue='+val+'&adapterTypeName='+frm.elements.adapterTypeName.value + '&connectionFactoryType='+frm.elements.connectionFactoryType.value ;
			var lbl = document.getElementById(lblName);
			lbl.innerHTML = "Fetching lookup data...";
			var http = new XMLHttpRequest();
			http.open("POST", "getLookupDetails.dsp?", true);
			http.send(winname);
	
			http.onreadystatechange = function(){
				if(http.readyState == 4 && http.status == 200){
					var res = decodeURIComponent(http.responseText);
					res = res.trim();
					if(res.indexOf("Error encountered") == -1)
					{
						var jsonData = JSON.parse(res);
						for (var i = 0; i < jsonData.lookups.length; i++) {
							var lookup = jsonData.lookups[i];
							var fieldName = ".CPROP."+ lookup.name;
							var listBox = frm.elements[fieldName];
							listBox.options.length=0;
							for(var j =0;j<lookup.values.length;j++)
							{
								listBox.options[listBox.options.length] = new Option( lookup.values[j],lookup.values[j]);
							}
						}
						for(var k=0;k<jsonData.hiddenParams.length;k++)
						{
							var param = jsonData.hiddenParams[k];
							var fieldName = ".CPROP."+param;
							frm.elements[fieldName].parentElement.parentElement.style.display='none';
							if(frm.elements[fieldName].tagName=="INPUT")
							{
								if(frm.elements[fieldName].type=="password")
								{
									var retryPwdFieldName = "PWD.CPROP."+param;
									frm.elements[retryPwdFieldName].parentElement.parentElement.style.display='none';
								}
							}
						}
						
						for(var k=0;k<jsonData.showParams.length;k++)
						{
							var param = jsonData.showParams[k];
							var fieldName = ".CPROP."+param;
							frm.elements[fieldName].parentElement.parentElement.style.display='';
							if(frm.elements[fieldName].tagName=="INPUT")
							{
								if(frm.elements[fieldName].type=="password")
								{
									var retryPwdFieldName = "PWD.CPROP."+param;
									frm.elements[retryPwdFieldName].parentElement.parentElement.style.display='';
								}
							}
						}
					}
					else
					{
						alert(res);
					}
				};  
			};
			lbl.innerHTML="";
			if(typeof(frm.resourceName) !== 'undefined')	
				nextwindow = location.href + "&resourceName=" + frm.resourceName.value;
			if(typeof(frm.resourceFolderName) !== 'undefined')
				nextwindow = nextwindow + "&resourceFolderName=" + frm.resourceFolderName.value;

	}
	catch(ex){
		alert(ex);
		alert(ex.message);
	}
}
function changeInputType(oldObject, oType) {
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

function changeTextBoxValue(val, ele){
	ele.value = val;
}


