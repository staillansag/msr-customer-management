<HTML>
    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
		<meta http-equiv="cache-control" content="no-cache, no-store"> 
    </HEAD>

    
    <BODY class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<script>

function receiveMessage(){
  event.source.postMessage(window.location.href,event.origin);
}

window.addEventListener("message", receiveMessage, false);


</script>
<h3>URL Re-directed to</h3>
<p id="demo"></p>
<script>
document.getElementById("demo").innerHTML = 
 window.location.href;
</script>

    </BODY>
</HTML>
