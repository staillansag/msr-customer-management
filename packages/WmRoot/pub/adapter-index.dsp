<html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge; Chrome=1" />
  <title>%value text encode(html)% - %value $host encode(html)% - webMethods Integration Server</title>
  <link rel="stylesheet" type="text/css" href="layout.css">
  <link rel="icon" HREF="favicon.ico" />
  <script>
    var doc = document.documentElement;
    var ua = navigator.userAgent;
            
    var agent = ua.indexOf("Trident/7.0") >= 0 || ua.indexOf("MSIE") >= 0 ? "IE" : "NotIE";
    doc.setAttribute('data-useragent', agent);
    if (agent == "IE") {
      document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"../WmRoot/layout-ie.css\">");
    }
    else {
      document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"../WmRoot/layout-nonie.css\">");
    }
    
    function frameload() {
      var topIFrame = document.getElementById('top');
	  %ifvar topIFrame.contentWindow%
			topIFrame.contentWindow.location.reload(true);
	  %endif%
    }
    </script>
</head>
<body>
  <div><iframe class="top" src="top.dsp?adapter=%value adapter encode(url)%&text=%value text encode(url)%%ifvar help%&help=%value help encode(url)%%endif%"></iframe></div>
  <div class="bottom">
    <iframe class="menuframe" name="menu" src="adapter-menu.dsp?tabset=%value adapter encode(url)%" scrolling="yes" seamless="seamless"></iframe>
    %invoke wm.server.ui:isValidAdapterURL%
        %ifvar result equals('true')%
            <iframe class="contentframe" name="body" src="%value url encode(htmlattr)%" onload="frameload()";></iframe>
        %else%
            <iframe class="contentframe" name="body" src="error.dsp" onload="frameload()";></iframe>
        %endif%
    %endinvoke%
  </div>
</body>
</html>
