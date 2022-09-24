<tr>
    <td class="oddrow"><label for="minThread">Threadpool Min</label></td>
    <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
        %ifvar ../mode equals('view')%
	        %value minThread encode(html)%
        %else%
            %ifvar minThread%
	            <input id="minThread" name="minThread" value="%value minThread encode(htmlattr)%">
            %else%
                <input id="minThread" name="minThread" value="10">
            %endif%
        %endif%
    </td>
</tr>

<tr>
    <td class="evenrow"><label for="maxThread">Threadpool Max</label></td>
    <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
        %ifvar ../mode equals('view')%
	        %value maxThread encode(html)%
        %else%
            %ifvar maxThread%
                <input id="maxThread" name="maxThread" value="%value maxThread encode(htmlattr)%">
            %else%
                <input id="maxThread" name="maxThread" value="200">
            %endif%
        %endif%
    </td>
</tr>

<tr>
    <td class="evenrow"><label for="threadPriority">Thread Priority</label></td>
    <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
        %ifvar ../mode equals('view')%
            %value threadPriority encode(html)%
        %else%
            <select id="threadPriority" name="threadPriority"></select>
        %endif%
    </td>
</tr>

%ifvar ../mode equals('view')%
%else%
    <script>
        function setThreadPriority() {
            var threadPriority = %ifvar threadPriority% %value threadPriority encode(javascript)% %else% 5 %endif%;
            var threadPriorityOptions = document.properties.threadPriority.options;
            for (var i=1;i<=10;i++) {
                var threadPriorityOption = document.createElement("option");
                threadPriorityOption.text = threadPriorityOption.value = i;
                if (i == threadPriority) {
                    threadPriorityOption.selected = true;
                }
                threadPriorityOptions.add(threadPriorityOption);
            }
        }
        setThreadPriority();
    </script>
%endif%
