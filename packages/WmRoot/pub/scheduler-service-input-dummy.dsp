<HTML>
    <HEAD language="JavaScript">
        <title>Assign Input Values</title>
		<script src="csrf-guard.js"></script>
    </HEAD>
   <BODY>
   <form name="dummyform" id="dummyform" method="post" action="scheduler-service-input.dsp">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    <input type="hidden" name="service" id="service" />
    <input type="hidden" name="scheduleDataStr" id="scheduleDataStr" />
   </form>
   <script>
    var data = window.parent.getInputString();
    var input = document.getElementById("scheduleDataStr");
    input.value = data;
    var svcName = window.parent.getServiceName();
    var svcNameInput = document.getElementById("service");
    svcNameInput.value = svcName;
	setFormProperty("dummyform", _csrfTokenNm_, _csrfTokenVal_);
    document.dummyform.submit();
   </script>
   </BODY>
</HTML>
