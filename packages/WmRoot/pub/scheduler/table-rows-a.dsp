<td class="oddrowdata-l"><a href="scheduler.dsp?mode=useradd&oid=%value oid encode(url)%&smode=Edit">%value oid encode(html)%</a></td>
<td class="rowdata">%value name encode(html)%</td>
<td class="rowdata">%value description encode(html)%</td>
<td class="rowdata">%ifvar qName%%value qName encode(html)%%else%N/A%endif%</td>
<td class="rowdata">%ifvar lastError%%value lastError encode(html)%%else%N/A%endif%</td>
<td class="rowdata">%value runAsUser encode(html)%</td>
<td class="rowdata">%ifvar target equals('$all')%
  All Servers
  %else%
  %ifvar target equals('$any')%
  Any Server
  %else%
  %value target encode(html)%</td>
%endif%
%endif%
</td>
