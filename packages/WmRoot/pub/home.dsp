%invoke wm.server.ui:mainMenu%

<html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=11">
  <title>%value $host encode(html)% - webMethods Integration Server</title>
  <link rel="stylesheet" type="text/css" href="layout.css">
  <script>
    var doc = document.documentElement;
    var ua = navigator.userAgent;
    var agent = ua.indexOf("Trident/7.0") >= 0 || ua.indexOf("MSIE") >= 0 ? "IE" : "NotIE";
    doc.setAttribute('data-useragent', agent);
    if (agent == "IE") {
      document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"layout-ie.css\">");
    }
    else {
      document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"layout-nonie.css\">");
    }
  </script>
  
  <link rel="icon" HREF="favicon.ico" />
</head>
<body>
  <div><iframe class="top" src="top.dsp" id="top"></iframe></div>
  <div class="bottom">
    <iframe class="menuframe" name="menu" src="menu.dsp" scrolling="yes" seamless="seamless"></iframe>
    <iframe class="contentframe" name="body" id="body" src="stats-general.dsp"></iframe>
  </div>
</body>
</html>

%onerror%

<html>
  <head>
    <title>Access Denied</title>
  </head>
  <body>
    Access Denied.
    <br>
    <br>
    Services necessary to show the Integration Server Administrator are currently unavailable on this 
    port.  This is most likely due to port security restrictions.
    <br>
    <br>
    If this is the only port available to access the Integration Server, contact webMethods Support.
  </body>
</html>

%endinvoke%
