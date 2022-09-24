<html>
<head>
<title>Select Connection Status</title>
<LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css">
<SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
<SCRIPT SRC="../WmART/connectionfilter.js"></SCRIPT>
<script type="text/javascript">

function closePopup()
{
	window.parent.hideSub(false);
}

function saveConnectionState()
{
	var aliasName = document.getElementById("suspendedConnectionAlias").value;
	var adapterTypeName = document.getElementById("adapterTypeName").value;
	var status = document.getElementById("status").value;
	
	if(status == "enable")
	{
	  var connId = document.getElementById("suspendedConnectionId").value;
      var connele = window.parent.document.getElementById(connId);
	  var parenttd = connele.parentNode;
	  parenttd.removeChild(connele);
	  var t = document.createTextNode("Pending enabled");
	  parenttd.appendChild(t);
	  window.parent.hideSub(false);
	  submitURLFromSubFrame('../WmART/ListResources.dsp?action=enableConnection&connectionState=enabled&adapterTypeName='+adapterTypeName+'&connectionAlias='+aliasName+'&dspName=.LISTRESOURCES');
	 	
	}else
	{
	 window.parent.hideSub(false);
	 submitURLFromSubFrame('../WmART/ListResources.dsp?action=saveConnectionState&connectionState=disable&adapterTypeName='+adapterTypeName+'&connectionAlias='+aliasName+'&dspName=.LISTRESOURCES');	
	}
				
}

</script>
</head>
<body style="border-spacing: 0; border-width: 0">
<table id="suspendedConnectionTable" class="tableView" width="100%" style="cell-spacing:0 border-spacing: 0; border-collapse:collapse; border-width:0; border-style:solid; border-color:gray">
 <tbody>      
        <tr> 
            <th class="title" align="left" scope="col">Connection Name</th>
            <th class="title" align="left" scope="col">Status</th>
            
        </tr>
		<tr>
            <script>writeTD('oddrowdata-l');</script>%value connectionAlias%</td>
			<script>writeTD('oddrowdata-l');</script>
				<select id="status" class="listbox">
				  <option value="enable">Enable</option>
				  <option value="disable">Disable</option>
				</select>
			</td>	
		</tr>
 </tbody>		
</table>

<p></p>
<table width="100%" >
           <tr>
                <td colspan=3>
				<button type="button" onclick="saveConnectionState()">Submit</button>
				</td>
             </tr>
			   
             
</table>	

<input type="hidden" id="suspendedConnectionAlias" value="%value connectionAlias%">
<input type="hidden" id="adapterTypeName" value="%value adapterTypeName%">
<input type="hidden" id="searchConnectionName" value="">
<input type="hidden" id="suspendedConnectionId" value="%value connectionsId%">
</body>
</html>

