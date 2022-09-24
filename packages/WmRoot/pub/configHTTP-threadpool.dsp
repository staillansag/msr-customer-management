       <tr>
       <td class="oddrow"><label for="min">Threadpool Min</label></td>
       <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
	    %value minThread encode(html)%
      %else%
        %ifvar minThread%
	      <input name="minThread" id="min" value="%value minThread encode(htmlattr)%">
        %else%
	      <input name="minThread" id="min" value="1">
        %endif%
      %endif%
       </td>
      </tr>
      <tr>
       <td class="evenrow"><label for="max">Threadpool Max</label></td>
       <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
                  %ifvar ../mode equals('view')%
	    %value maxThread encode(html)%
      %else%
        %ifvar maxThread%
	      <input name="maxThread" id="max" value="%value maxThread encode(htmlattr)%">
        %else%
	      <input name="maxThread" id="max" value="5">
        %endif%
      %endif%
       </td>
       </tr>
       <tr>
       <td class="oddrow"><label for="priority">Thread Priority</label></td>
       <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                  %ifvar ../mode equals('view')%
	    %value threadPriority encode(html)%
      %else%
        %ifvar threadPriority%
	      <input name="threadPriority" id="priority" value="%value threadPriority encode(htmlattr)%">
        %else%
	      <input name="threadPriority" id="priority" value="5">
        %endif%
      %endif%
       </td>
       </tr>
        %ifvar ../mode equals('view')%
              <tr>
              
              <td class="evenrow">Current Threads</td>
              <td class="evenrowdata-l">
                     
       	     %value usedThreadCount encode(html)%
             </td>
             </tr>
       %endif%
