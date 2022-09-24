<tr manualhide="%ifvar expanded equals('true')%false%else%true%endif%" 
    onClick="toggle(this, '%value text encode(javascript)%_subMenu', '%value text encode(javascript)%_twistie');" 
    onMouseOver="this.className='cursor';" id="%value text encode(html)%"/>
  <td class="menusection menusection-%ifvar expanded equals('true')%expanded%else%collapsed%endif%" 
      id="elmt_%value text%_subMenu"/>
    <img id='%value text%_twistie' 
         src="../WmRoot/images/%ifvar expanded equals('true')%expanded.gif%else%collapsed_blue.png%endif%" />
      <a style="text-decoration:none" href="#" class="menusection-%value name encode(htmlattr)%">&nbsp;%value text encode(html)%</a>
  </td>
</tr>