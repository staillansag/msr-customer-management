<HTML>
  <HEAD>
    <LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <style>
      body { border-top: 1px solid #97A6CB; }
    </style>
    <script src="../WmRoot/common-menu.js"></script>
    <script src="../WmRoot/csrf-guard.js"></script>
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
    

  </HEAD>

  <BODY CLASS="menu" onload="initMenu('integration-live.dsp');">
    <form name="urlsaver">
      <input type="hidden" name="helpURL" value="doc/OnlineHelp/WmRoot.htm#CS_Server_Statistics.htm">
    </form>

    <table class="menuTable" width="100%" cellspacing="0" cellpadding="0" border="0">

      %scope param(expanded='true') param(text='Cloud')%
        %include ../../WmRoot/pub/menu/section-top.dsp%
          webMethods Cloud
        %include ../../WmRoot/pub/menu/section-bottom.dsp%
      %endscope%

      %scope param(section='Settings') param(text='Tenant Connections') param(url='integration-live-tenant-account.dsp')%
        %include ../../WmRoot/pub/menu-item-start.dsp%
          %scope%
          %rename text inString -copy%
          %invoke wm.server.csrfguard:replaceSpecialCharacters%
            <script>
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_%value replacedString%", "%value encode(javascript) url%", "POST", "BODY", "%ifvar target%%value $host%%value target%%else%body%endif%");
                setFormProperty("htmlform_menu_subelement_%value replacedString%", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value encode(htmlattr) url%" href="javascript:htmlform_menu_subelement_%value replacedString%.submit()"> Settings %ifvar target% ... %endif% </a>');
              } else {
                document.write('<a id="a%value encode(htmlattr) url%" target="%ifvar target%%value $host%%value target%%else%body%endif%" href="%value encode(javascript) url%"> Settings %ifvar target% ... %endif% </a>');
              }
            </script>
          %endinvoke%
          %endscope%
          </span>
        </td>
      </tr>
      %endscope%

      %scope param(section='Settings') param(text='Accounts') param(url='integration-live.dsp')%
        %include ../../WmRoot/pub/menu-item-start.dsp%
          %scope%
          %rename text inString -copy%
          %invoke wm.server.csrfguard:replaceSpecialCharacters%
            <script>
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_%value replacedString%", "%value encode(javascript) url%", "POST", "BODY", "%ifvar target%%value $host%%value target%%else%body%endif%");
                setFormProperty("htmlform_menu_subelement_%value replacedString%", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value encode(htmlattr) url%" href="javascript:htmlform_menu_subelement_%value replacedString%.submit()"> Accounts %ifvar target% ... %endif% </a>');
              } else {
                document.write('<a id="a%value encode(htmlattr) url%" target="%ifvar target%%value $host%%value target%%else%body%endif%" href="%value encode(javascript) url%"> Accounts %ifvar target% ... %endif% </a>');
              }
            </script>
          %endinvoke%
          %endscope%
          </span>
        </td>
      </tr>
      %endscope%

      %scope param(section='Settings') param(text='Applications') param(url='integration-live-metadata-share.dsp')%
        %include ../../WmRoot/pub/menu-item-start.dsp%
          %scope%
          %rename text inString -copy%
          %invoke wm.server.csrfguard:replaceSpecialCharacters%
            <script>
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_%value replacedString%", "%value encode(javascript) url%", "POST", "BODY", "%ifvar target%%value $host%%value target%%else%body%endif%");
                setFormProperty("htmlform_menu_subelement_%value replacedString%", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value encode(htmlattr) url%" href="javascript:htmlform_menu_subelement_%value replacedString%.submit()"> Applications %ifvar target% ... %endif% </a>');
              } else {
                document.write('<a id="a%value encode(htmlattr) url%" target="%ifvar target%%value $host%%value target%%else%body%endif%" href="%value encode(javascript) url%"> Applications %ifvar target% ... %endif% </a>');
              }
            </script>
          %endinvoke%
          %endscope%
          </span>
        </td>
      </tr>
      %endscope%

    </table>
<script>menuSelect('', 'integration-live.dsp')</script>
  </BODY>
</HTML>
