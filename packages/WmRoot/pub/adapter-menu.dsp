<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Expires" content="-1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge; Chrome=1" />
    <link rel="stylesheet" type="text/css" href="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <style>
      body { border-top: 1px solid #97A6CB; }
    </style>
    <script src="common-menu.js"></script>
	<script src="csrf-guard.js"></script>
    <script type="text/javascript">
var selected = null;
var menuInit = false;

function menuSelect(object, id) {
  selected = menuext.select(object, id, selected);
}

function menuMouseOver(object, id) {
  menuext.mouseOver(object, id, selected);
}

function menuMouseOut(object, id) {
  menuext.mouseOut(object, id, selected);
}

function initMenu(firstImage) {
    menuInit = true;
    return true;
}
</script>

  </head>

  %invoke wm.server.ui:getMenuTabs%

  <body class="menu" onload="initMenu('%value buttonUrls[0]/url encode(javascript)%')">
    <form name="urlsaver">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <input type="hidden" name="helpURL" value="doc/OnlineHelp/WmRoot.htm#help-settings.dsp">
    </form>

    <table class="menuTable" width="100%" cellspacing="0" cellpadding="0" border="0">
    
      %scope param(truestr='true') param(falsestr='false') param(expanded='true')%
        %rename ../name name -copy%
        %rename ../text text -copy%
        %include menu-section.dsp%
      %endscope%
    
      %loop buttonUrls%
        %scope param(tablerow='table-row') param(display='table-row')%
          %rename ../../text section -copy%
          %rename ../name text -copy%
          %rename ../url url -copy%
          %rename ../target target -copy%
          %include menu-subelement.dsp%
        %endscope%
      %endloop%
    
    </table>
	<script>
	document.querySelectorAll(".menusection-")[0].style.color="#ffffff";
	</script>
  </body>
  <script>menuSelect(null, "%value buttonUrls[0]/url encode(javascript)%");</script>
</html>
