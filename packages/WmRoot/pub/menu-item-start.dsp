<tr name="%value section%_subMenu" style="display: %value display%">
  <td id="i%value encode(htmlattr) url%"
    %ifvar url equals('nonedsp')%
      class="menuitem-unclickable"
    %else%
      class="menuitem %value className%"
      onmouseover="menuMouseOver(this, '%value url encode(javascript)%');"
      onmouseout="menuMouseOut(this, '%value url encode(javascript)%');"
      onclick="menuSelect(this, '%value url encode(javascript)%'); document.all['a%value url encode(javascript)%'].click();"
      %endif%>
  