<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">
<title>IS Task Scheduler</title>
<link rel="stylesheet" type="text/css" href="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<script src="webMethods.js"></script>
<script src="scheduledservicesfilter.js"></script>
<script language="JavaScript">
    function confirmPause () {
        return confirm("OK to pause the Scheduler?\nNo scheduled tasks will be initiated until the Scheduler is resumed.");
    }
    function confirmResume() {
        return confirm("OK to resume the Scheduler?\nThe Scheduler will proceed to initiate scheduled tasks.");
    }
</script>

</head>

%switch mode%

%case sys%
<body onLoad="setNavigation('scheduler.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_ViewSysTaskScrn');">

<!-- =========================== sys =========================== -->

%invoke wm.server.query:getTaskList%
<!-- Server tasks table -->
<table width="100%">

<tr><td class="breadcrumb" colspan=4>
    Server &gt;
    Scheduler &gt;
    View System Tasks</td>
</tr>

<tr><td colspan=2>
    <ul class="listitems">
		<script>
		createForm("htmlform_scheduler_return", "scheduler.dsp", "POST", "BODY");
		createForm("htmlform_scheduler_refresh", "scheduler.dsp", "POST", "BODY");
		setFormProperty("htmlform_scheduler_refresh", "mode", "sys");
		</script>
        <li>
		<script>getURL("scheduler.dsp", "javascript:document.htmlform_scheduler_return.submit();", "Return to Scheduler");</script>
		</li>
        <li>
		<script>getURL("scheduler.dsp?mode=sys", "javascript:document.htmlform_scheduler_refresh.submit();", "Refresh System Tasks");</script>
		</li>
    </ul>
</td></tr>
    <tr>
      <td>
        <table class="tableView" width=100%>
            %ifvar tasks%
            <tr><td class="heading" colspan=5>Simple Interval Tasks</td></tr>
            <tr class="subheading2">
              <th scope="col" CLASS="oddcol-l">Name</th>
              <th scope="col" CLASS="oddcol-l" colspan=2>Next Run</th>
              <th scope="col" CLASS="oddcol-r">Interval</th>
              <th scope="col" CLASS="oddcol-r">Status</th>
            </tr>
            %endif%
                <script>resetRows();</script>
            %loop tasks%
            <tr>
                <script>writeTD("rowdata-l");</script>%value name encode(html)%</td>
                <script>writeTD("rowdata");</script><nobr>%value nextRun encode(html)%</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value msDelta decimal(-3,1) encode(html)% sec</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value interval decimal(-3,0) encode(html)% sec</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value execState encode(html)% </nobr></td>
            </tr>
                <script>swapRows();</script>
            %endloop%

            <tr><td class="space" colspan="5">&nbsp;</td></tr>

            <tr><td class="heading" colspan=5>Complex Repeating Tasks</td></tr>
            <TR class="subheading2">
              <th scope="col" CLASS="oddcol-l">Name</th>
              <th scope="col" CLASS="oddcol-l" colspan=2>Last Run</th>
              <th scope="col" CLASS="oddcol-r">Interval</th>
              <th scope="col" CLASS="oddcol-r">Status</th>
            </tr>
            %ifvar -notempty extTasks%
                <script>resetRows();</script>
            %loop extTasks%
            <tr>
                <script>writeTD("rowdata-l");</script>%value name encode(html)%</td>
                <script>writeTD("rowdata-l");</script><nobr>%value msDelta encode(html)%</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value msDelta decimal(-3,1) encode(html)% sec</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value interval decimal(-3,0) encode(html)% sec</nobr></td>
                <script>writeTD("rowdata-r");</script><nobr>%value execState encode(html)% </nobr></td>
            </tr>
                <script>swapRows();</script>
            %endloop%
          %else%
           %ifvar error%
           <tr><td class="evenrow-l" colspan=11>error: %value error encode(html)%</td></tr>
           %else%
             <tr><td class="evenrow-l" colspan=11>No tasks are currently scheduled</td></tr>
           %endif%
          %endif%

            </table>
          </td>
        </tr>
      </table>
    %endinvoke%

%case useradd%
<body onLoad="setNavigation('scheduler.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_CreateTaskScrn'); setDefaultSettings()">

<!-- =========================== useradd =========================== -->

<!-- User tasks table -->

<SCRIPT LANGUAGE="JavaScript">
  function onAdd() {
	
    var type = "";

    // (1) validate service name
    var svc = document.schedule.service.value;
    var idx = svc.lastIndexOf(":");
    if (svc == "" || idx < 0 || idx > svc.length-1) {
      alert (
        "Specify service name in the form:\n\n"+
        "          folder.subfolder:service\n"
      );
      document.schedule.service.focus();
      return false;
    }

   // Validate user, schedule type
   if (document.schedule.runAsUser.value == "" )
   {
    alert("Specify user");
    document.schedule.runAsUser.focus();
    return false;
    }

   // If latenessAction is NOT "Run immediately", then Check for Lateness time
    var latenessActionList = document.schedule.latenessAction;
    var isLatenessActionChecked = false;
    for (var i=0; i<latenessActionList.length; i++) {
    if ( latenessActionList[i].checked)
        isLatenessActionChecked = true;
    if ( (latenessActionList[i].value == 1 && latenessActionList[i].checked) ||
         (latenessActionList[i].value == 2 && latenessActionList[i].checked))
    {
        var lateness = document.schedule.lateness;
        if ( lateness.value == "")
        {
            alert("Specify lateness (in minutes)");
            lateness.focus();
            return false;
        } else if(isNaN(lateness.value)) {
            alert("lateness (in minutes) is not a valid number");
            lateness.focus();
            return false;
        } else {
            if(parseInt(lateness.value) > 35000) {
                alert("The maximum number of minutes that the if more than xxx minutes late field can accept is 35000");
                lateness.focus();
                return false;
            }               
        }
    }
    }
    if ( !isLatenessActionChecked ) {
    alert("Specify overdue option");
    return false;
    }

    // (3) determine type of service to be added
    var typeList = document.schedule.type;
    document.schedule.schaction.value='Add Task';
    for (var i=0; i<typeList.length; i++) {
      if (typeList[i].checked) type = typeList[i].value;

    }
    if ( type == "" ){
    alert("Specify schedule type");
    return false;
    }

    // (4) check inputs for that type

    // (4a) one-time tasks need a date and time
    if (type == "once") {
      var d = document.schedule.date.value;
      var t = document.schedule.time.value;
      if (d == "") {
        alert (
          "Specify date in the form:\n\n"+
          "          YYYY/MM/DD\n"
        );
        return false;
      }
      if (t == "") {
        alert (
          "Specify time in the form:\n\n"+
          "          HH:MM:SS\n"
        );
        return false;
      }
    }

   // (4b) repeating tasks need an interval
    else if (type == "repeat") {
      var i = document.schedule.interval.value;
      if (i == "") {
        alert ("Specify interval (in seconds)");
    document.schedule.interval.focus();
        return false;
      }
	    
        document.schedule['start-date'].value = document.schedule.sd1.value;
        document.schedule['start-time'].value = document.schedule.st1.value;
        document.schedule['end-date'].value = document.schedule.ed1.value;
        document.schedule['end-time'].value = document.schedule.et1.value;
    }

    // (4c) complex tasks don't need anything specified -- if
    // nothing is specified, they'll be run every minute
    else {
        // if it's complex, we need to copy the start/end values
        // into the fields with the right name.  We can't just specify
        // start-date, etc, twice (once for repeating, and once for
        // complex) because the form will submit both, and the IS will
        // pick up the blank value for repeating and ignore the proper one
        document.schedule['start-date'].value = document.schedule.sd2.value;
        document.schedule['start-time'].value = document.schedule.st2.value;
        document.schedule['end-date'].value = document.schedule.ed2.value;
        document.schedule['end-time'].value = document.schedule.et2.value;
    }

    document.schedule.submit();
  }

  function onUpdate() {
    document.schedule.schaction.value='Update Task';
    document.schedule.submit();
  }

  function validateTypeForLatesnessOpt(latenessAction)
  {
    if (latenessAction.value == 0)
        document.schedule.lateness.disabled = true;
    else
        document.schedule.lateness.disabled = false;

    // If latenessAction is "Skip and run" option Then "Run Once" schedule type is Invalid
    if (document.schedule.type[0] != null) // Create Mode
    {
        if ( latenessAction.value == 1 )
            document.schedule.type[0].disabled = true;
        else
            document.schedule.type[0].disabled = false;
    }
  }

  function validateLatesnessOptForType(type)
  {
    // If Schedule type is "Run Once" Then "Skip and run" latenessAction option is Invalid.
    if ( type.value == "once" ){
        document.schedule.latenessAction[1].disabled = true;
		enableInputs("once");
		disableInputs("repeat");
		disableInputs("complex");
	}
	else if( type.value == "repeat" ){
		enableInputs("repeat");
		disableInputs("once");
		disableInputs("complex");
	}
	else if( type.value == "complex" ){
		enableInputs("complex");
		disableInputs("repeat");
		disableInputs("once");
	}
    else
        document.schedule.latenessAction[1].disabled = false;
  }
  
  function disableInputs(classname)
  {
		var x = document.getElementsByClassName(classname);
		var i;
		for (i = 0; i < x.length; i++) {
		  x[i].disabled = true;
		}
  }
  
  function enableInputs(classname)
  {
		var x = document.getElementsByClassName(classname);
		var i;
		for (i = 0; i < x.length; i++) {
		  x[i].disabled = false;
		}
  }

  function setDefaultSettings()
  {
    if (document.schedule.type[0] != null)  // Create Mode
    {
        if ( document.schedule.latenessAction[0].checked)
            document.schedule.lateness.disabled = true;
        else
            document.schedule.lateness.disabled = false;
    }
    else
    {
        if ( document.schedule.latenessAction[0].checked)
        document.schedule.lateness.disabled = true;
    }
  }
</SCRIPT>

<table width="100%" style="border-collapse: collapse; border: 0px">
%invoke wm.server.schedule:getDefaultTimeZoneOffset%
%ifvar smode%
<tr><td class="breadcrumb-left" colspan=7>
    Server &gt;
    Scheduler &gt;
    User Tasks &gt;
    Modify Task</td><td class="breadcrumb-right" align="right">
    All times %value timeZoneOffset%</td></tr>
%else%
<tr><td class="breadcrumb-left" colspan=6>
    Server &gt;
    Scheduler &gt;
    User Tasks &gt;
    New Task</td><td class="breadcrumb-right" align="right">
    All times %value timeZoneOffset%</td></tr>
%endif%
%endinvoke%

  <form name="schedule" action="scheduler.dsp" method="POST">
    %ifvar webMethods-wM-AdminUI% <input type="hidden" id="webMethods-wM-AdminUI" name="webMethods-wM-AdminUI" value="true"> %endif%
    <tr>
      <td colspan=2>
        <ul class="listitems">
		<script>
		createForm("htmlform_scheduler_return_to_scheduler", "scheduler.dsp", "POST", "BODY");
		</script>
          <li>
		  <script>getURL("scheduler.dsp", "javascript:document.htmlform_scheduler_return_to_scheduler.submit();", "Return to Scheduler");</script>
		  </li>
        </ul>
      </td>
    </tr>

    <tr>
      <td>
        <table class="tableView">
        %invoke wm.server.schedule:getUserTask%

        <script type="text/javascript">
          var trgt = "%value target encode(javascript)%";

          // define function to scroll through selections on
          // document.schedule.runAsUser
          function updateTargetSelector () {
            var sel = document.schedule.target;
            for (var i=0; i<sel.options.length; i++) {
              if (sel.options[i].value == trgt) sel.selectedIndex = i;
            }
          }
        </script>

        <tr><td class="heading" colspan=7>Service Information</td></tr>
        <tr>
          <td class="oddrow" colspan=2><label for="description">Description</label></TD>
          <td class="oddrow-l" colspan=5><input name="description" id="description" size=40 value="%value description encode(htmlattr)%"></input></td>
        </tr>
        <tr>
          <td class="evenrow" colspan=2><label for="service">folder.subfolder:service</label></TD>
          <td class="evenrow-l" colspan=5><input id="service" name="service" size=40 value="%value name encode(htmlattr)%"></input>
          %rename inputs scheduleData -copy%
          %invoke wm.server.schedule:getSchedulerInputAsString%
			  <input type="hidden" name="scheduleDataStr" id="scheduleDataStr" value="%value scheduleDataStr encode(htmlattr)%"/>
          %endinvoke%

          <link rel="stylesheet" type="text/css" href="subUserLookup.css" />
          <script type="text/javascript" src="subUserLookup.js"></script>
          <script type="text/javascript">
            function showService() {
                var svc = document.getElementById("service").value;
                var idx = svc.lastIndexOf(":");
                if (svc == "" || idx < 0 || idx > svc.length-1) {
                  alert (
                    "Specify service name in the form:\n\n"+
                    "          folder.subfolder:service\n"
                  );
                  document.schedule.service.focus();
                  return false;
                } else {
                    var width = 280;
                    var height = 350;
					showSub("scheduler-service-input-dummy", width, height, null);
                }
            }

            function getServiceName() {
                var service = document.getElementById("service");
                return service.value;
            }

            function setInputString(input) {
                document.schedule.scheduleDataStr.value = input;
            }

            function getInputString() {
                var inputStringField = document.getElementById("scheduleDataStr");
                return inputStringField.value;
            }
          </script>
          <a id="servicepopup" onClick="javascript:return showService();" href="#" onmouseover="this.style.cursor='pointer'">Assign Inputs<img border=0 align="bottom" alt="Assign inputs for the service" src="icons/service_input.gif"/></a>
          </td>
        </tr>

    <!--  RUN AS USER SUB -->
    <SCRIPT>
      //This function can be changed to do something with the user
      function callback(val){
        document.schedule.runAsUser.value=val;
      }
    </SCRIPT>
        <tr>
          <td class="oddrow" colspan=2><label for="runAsUser">Run As User</label></TD>
          <td class="oddrow-l" colspan=5>
          <input name="runAsUser" id="runAsUser" size=12 value="%value runAsUser encode(htmlattr)%"></input>
    <link rel="stylesheet" type="text/css" href="subUserLookup.css" />
    <script type="text/javascript" src="subUserLookup.js"></script>
	<a class="submodal" href="subUserLookup"><img border=0 align="bottom" alt="Select User" src="icons/magnifyglass.png"/></a>
          </td>
        </tr>
        <!-- END RUN AS USER SUB -->

        <tr>
          <td class="evenrow" colspan=2><label for="target">Target Node</label></TD>
          <td class="evenrow-l" colspan=5>

          %invoke wm.server.schedule:getTargetNodeList%
          <SELECT name="target" id="target">
            <OPTION value="$any"%ifvar target equals('$any')% selected%endif%>Any server</OPTION>
            %ifvar currentlyClustered equals('true')%
                <OPTION value="$all"%ifvar target equals('$all')% selected%endif%>All servers</OPTION>
            %endif%
            %loop hosts%
            <OPTION value="%value logicalServerName encode(htmlattr)%" %ifvar logicalServerName vequals(../target)% selected %endif%>
                %value logicalServerName encode(html)%
            </OPTION>
            %endloop%
          </SELECT>
          %endinvoke%
          </td>
        </tr>
        %comment% <!-- if we want it in black -->
        <tr><td class="space" colspan="7">&nbsp;</td></tr>
        <tr><td class="heading" colspan=7>If the Task is Overdue</td></tr>
        %endcomment%
        <tr><td class="subHeading" colspan=7>If the Task is Overdue</td></tr>
        <tr>
		  <td class="oddrow-l" colspan=7><input name="latenessAction" id="latenessAction" %ifvar mode equals('useradd')% checked %else% %ifvar latenessAction equals(0)% checked%endif%%endif% onclick="validateTypeForLatesnessOpt(this)" value="0"  type="radio"><label for="latenessAction">Run immediately</label></input></td>
        </tr>
        <tr>
		  <td class="evenrow-l" colspan=3><input name="latenessAction" id="latenessAction1" value="1" onclick="validateTypeForLatesnessOpt(this)" type="radio" %ifvar latenessAction equals(1)% checked%endif%><label for="latenessAction1">Skip and run at next scheduled interval</label></input></td>
		  <td class="evenrow-l" colspan=4 rowspan=2><label for="lateness">if more than </label><input name="lateness" id="lateness" size=12 value="%value lateness encode(htmlattr)%"></input> minutes late.</td>
        </tr>
        <tr>
		  <td class="oddrow-l" colspan=3><input name="latenessAction" id="latenessAction2" onclick="validateTypeForLatesnessOpt(this)" value="2"  type="radio"%ifvar latenessAction equals(2)% checked%endif%><label for="latenessAction2">Suspend</label></input></td>
        </tr>
        %comment%
        <tr>
          <td class="oddrow" colspan=2>Lateness</td>
          <td class="oddrow-l" colspan=5><input name="lateness" size=12 value="%value lateness encode(htmlattr)%"></input> minutes</td>
        <tr>
          <td class="evenrow" colspan=2>Lateness Action</td>
          <td class="evenrow-l" colspan=5>

          <SELECT NAME="latenessAction">
            <option value="0"%ifvar latenessAction equals(0)% selected%endif%>Original</option>
            <option value="1"%ifvar latenessAction equals(1)% selected%endif%>Now</option>
            <option value="2"%ifvar latenessAction equals(2)% selected%endif%>Suspend</option>
          </SELECT>
          </td>
        </tr>
        %endcomment%

%comment%
<!--
        <tr>
          <td class="oddrow" colspan=2>Persistence</td>
          <td class="oddrow-l" colspan=5>
          <input name="persistJob" type="checkbox" value="true"
                 %ifvar custom/persistJob equals(true)%checked%endif%
               %ifvar custom/persistJob%%else%checked%endif%>
          Persist after restart</input>
          </td>
        </tr>
        <tr>
          <td class="evenrow" colspan=2>Clustering</td>
          <td class="evenrow-l" colspan=5>


          %ifvar inCluster%
          <input name="runInCluster" type="checkbox" value="true"
                 %ifvar custom/runInCluster equals(true)%checked%endif%>
          Scheduled for cluster</input>
          %else%
          Not in cluster.
          %endif%
          </td>
        </tr>
-->
%endcomment%

        %ifvar smode%

          %switch type%

          %case 'once'%
<tr><td class="subHeading" colspan=7>One-Time Tasks</td></tr>
%ifvar type equals(once)%<input name="type" type="hidden" value="once" >%endif%
            <tr>
              <td class="oddrow" colspan=1><label for="date">Date</label></TD>
              <td class="oddrow-l" colspan=6>
              <input name="date" id="date" size=12 value="%value start-date encode(htmlattr)%"> YYYY/MM/DD</input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" colspan=1><label for="time">Time</label></TD>
              <td class="evenrow-l" colspan=6>
              <input name="time" id="time" size=12 value="%value start-time encode(htmlattr)%"> HH:MM:SS </input>
              </td>
            </tr>
          %case 'repeat'%
            <tr><td class="subHeading" colspan=7>Repeating Tasks With a Simple Interval</td></tr>
%ifvar type equals(repeat)%<input name="type" id="type" type="hidden" value="repeat" >%endif%
            <tr>
              <td class="oddrow" ><label for="start-date">Start Date</label></TD>
              <td class="oddrow-l" colspan=6>
              <input name="start-date" id="start-date" value="%value start-date encode(htmlattr)%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" ><label for="start-time">Start Time</label></TD>
              <td class="evenrow-l" colspan=6>
              <input name="start-time" id="start-time" value="%value start-time encode(htmlattr)%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="oddrow" ><label for="end-date">End Date</label></TD>
              <td class="oddrow-l" colspan=6>
              <input name="end-date" id="end-date" value="%value end-date encode(htmlattr)%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" ><label for="end-time">End Time</label></TD>
              <td class="evenrow-l" colspan=6>
              <input name="end-time" id="end-time" value="%value end-time encode(htmlattr)%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
			  <td class="oddrow" colspan=1>Repeating</TD>
              <td class="oddrow-l" colspan=5>
		  		<input type="checkbox" name="doNotOverlap" id="doNotOverlap3" %ifvar doNotOverlap equals('true')%checked%endif% size=12 value="true"><label for="doNotOverlap3">Repeat after completion</label></input>
              </td>

            </tr>
            <tr>
              <td class="evenrow" colspan=1><label for="interval">Interval</label></TD>
              <td class="evenrow-l" colspan=6>
              <input name="interval" id="interval" size=12 value="%value interval decimal(-3,0) encode(htmlattr)%"> seconds</input><BR>
              </td>
            </tr>

          %case 'complex'%
<tr><td class="subHeading" colspan=7>Repeating Tasks with Complex Schedules</td></tr>
%ifvar type equals(complex)%<input name="type" type="hidden" value="complex">%endif%
            <tr>
              <td class="oddrow" ><label for="start-date">Start Date</label></TD>
              <td class="oddrow-l" colspan=6>
              <input name="start-date" id="start-date" value="%value start-date encode(htmlattr)%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" ><label for="start-time">Start Time</label></TD>
              <td class="evenrow-l" colspan=6>
              <input name="start-time" id="start-time" value="%value start-time encode(htmlattr)%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="oddrow" ><label for="end-date">End Date</label></TD>
              <td class="oddrow-l" colspan=6>
              <input name="end-date" id="end-date" value="%value end-date encode(htmlattr)%" size=12 > YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" ><label for="end-time">End Time</label></TD>
              <td class="evenrow-l" colspan=6>
              <input name="end-time" id="end-time" value="%value end-time encode(htmlattr)%" size=12 > HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
			  <td class="oddrow" colspan=1>Repeating</TD>
              <td class="oddrow-l" colspan=5>
		  		<input type="checkbox" name="doNotOverlap" id="doNotOverlap4" %ifvar doNotOverlap equals('true')%checked%endif% size=12 value="true"><label for="doNotOverlap4">Repeat after completion</label></input>
              </td>

            </tr>
            <tr>
              <td class="evenrow" rowspan="3" >Run Mask</TD><td class="evenrow-l" ><label for="month">Months</label></TD><td class="evenrow-l" ><label for="mo_day">Days</label></TD><td class="evenrow-l" ><label for="wk_day">Weekly Days</label></TD><td class="evenrow-l" ><label for="hour">Hours</label></TD><td class="evenrow-l" ><label for="min">Minutes</label></TD>
            </tr>
            <tr>

              <td class="evenrow-l" valign="top">
              <select name="month" id="month" size="12" multiple>
              %loop moMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
              </select>
              </td>
              <td class="evenrow-l" valign="top">
              <select name="mo_day" id="mo_day" size="31" multiple>
              %loop dayMoMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
              </select>
              </td>
              <td class="evenrow-l" valign="top">
              <select name="wk_day" id="wk_day" size="7" multiple>
              %loop dayWkMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
              </select>
              </td>
              <td class="evenrow-l" valign="top">
              <select name="hour" id="hour" size="24" multiple>
              %loop hourMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
              </select>
              </td>
              <td class="evenrow-l" valign="top">
              <select name="min" id="min" size="30" multiple>
              %loop minMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
              </select>
              </td>
            </tr>
            <tr>
              <td class="evenrow" colspan=5>
              <i>Selecting no items is equivalent to selecting all items for a given list</i>
              </td>
            </tr>

          %endswitch%

        %else%
    <tr><td class="space" colspan="7">&nbsp;</td></tr>
    <tr><td class="heading" colspan=7>Schedule Type and Details</td></tr>
        <tr><td class="subHeading" colspan=7>One-Time Tasks</td></tr>
        <tr>
          <td class="oddrow-l" rowspan=2 valign="top">
            <input name="type" id="type1" type="radio" onclick="validateLatesnessOptForType(this)" value="once" %ifvar type equals(once)%checked%endif%><label for="type1">Run Once</label></input>
          </td>
          <td class="oddrow" colspan=1><label for="date">Date</label></TD>
          <td class="oddrow-l" colspan=5>
            <input class="once" name="date" id="date" size=12 value="%value start-date encode(htmlattr)%" %ifvar type equals(once)% %else%disabled%endif%> YYYY/MM/DD</input>
          </td>
        </tr>
        <tr>
          <td class="evenrow" colspan=1><label for="time">Time</label></TD>
          <td class="evenrow-l" colspan=5>
              <input class="once" name="time" id="time" size=12 value="%value start-time encode(htmlattr)%" %ifvar type equals(once)% %else%disabled%endif%> HH:MM:SS </input>
          </td>
        </tr>
        <tr><td class="subHeading" colspan=7>Repeating Tasks With a Simple Interval </td></tr>
		 <input type="hidden" name="start-date" id="start-date" value="%value start-date encode(htmlattr)%"/>
		 <input type="hidden" name="start-time" id="start-time" value="%value start-time encode(htmlattr)%"/>
		 <input type="hidden" name="end-date" id="end-date" value="%value end-date encode(htmlattr)%"/>
		 <input type="hidden" name="end-time" id="end-time" value="%value end-time encode(htmlattr)%"/>
        <tr>
          <td class="oddrow-l" rowspan="6" valign="top">
            <input name="type" id="type2" type="radio" onclick="validateLatesnessOptForType(this)" value="repeat" %ifvar type equals(repeat)%checked%endif%><label for="type2">Repeating</label></input>
          </td>
              <td class="oddrow" ><label for="sd1">Start Date</label></TD>
              <td class="oddrow-l" colspan=6>
              <input class="repeat" name="sd1" id="sd1" value="%value sd1 encode(htmlattr)%" size=12 %ifvar type equals(repeat)% %else%disabled%endif%> YYYY/MM/DD <i>(optional)</i></input>
              </td>
    </tr>
            <tr>
              <td class="evenrow" ><label for="st1">Start Time</label></TD>
              <td class="evenrow-l" colspan=6>
              <input  class="repeat" name="st1" id="st1" value="%value st1 encode(htmlattr)%" size=12 %ifvar type equals(repeat)% %else%disabled%endif%> HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="oddrow" ><label for="ed1">End Date</label></TD>
              <td class="oddrow-l" colspan=6>
              <input  class="repeat" name="ed1" id="ed1" value="%value ed1 encode(htmlattr)%" size=12 %ifvar type equals(repeat)% %else%disabled%endif%> YYYY/MM/DD <i>(optional)</i></input>
              </td>
            </tr>
            <tr>
              <td class="evenrow" ><label for="et1">End Time</label></TD>
              <td class="evenrow-l" colspan=6>
              <input  class="repeat" name="et1" id="et1" value="%value et1 encode(htmlattr)%" size=12 %ifvar type equals(repeat)% %else%disabled%endif%> HH:MM:SS <i>(optional)</i></input>
              </td>
            </tr>
    <tr>
    <td class="oddrow">Repeating</TD>
          <td class="oddrow-l" colspan=6>
            <input  class="repeat" type="checkbox" name="doNotOverlap" id="doNotOverlap1" size=12 value="true" disabled><label for="doNotOverlap1">Repeat after completion</label></input>
          </td>

        </tr>
       <tr>
          <td class="evenrow"><label for="interval">Interval</label></TD>
          <td class="evenrow-l" colspan=6>
            <input  class="repeat" name="interval" id="interval" size=12 value="%value interval decimal(-3,0) encode(htmlattr)%" %ifvar type equals(repeat)% %else%disabled%endif%> seconds</input><BR>

          </td>
        </tr>

        <tr><td class="subHeading" colspan=7>Repeating Tasks with Complex Schedules</td></tr>
        <tr>
          <td valign="top" class="oddrow-l" rowspan=8 valign="top">
            <input  name="type" id="type3" type="radio" %ifvar mode equals('useradd')% checked %else% %ifvar type equals(complex)%checked%endif%%endif% onclick="validateLatesnessOptForType(this)" value="complex"><label for="type3">Complex Repeating</label></input>
          </td>
          <td class="oddrow"><label for="sd2">Start Date</label></TD>
          <td class="oddrow-l" colspan=6>
          <input class="complex" name="sd2" id="sd2" size=12 %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%> YYYY/MM/DD <i>(optional)</i></input>
          </td>
        </tr>
        <tr>
          <td class="evenrow"><label for="st2">Start Time</label></TD>
          <td class="evenrow-l" colspan=5>
          <input class="complex" name="st2" id="st2" size=12 %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%> HH:MM:SS <i>(optional)</i></input>
          </td>
        </tr>
        <tr>
          <td class="oddrow"><label for="ed2">End Date</label></TD>
          <td class="oddrow-l" colspan=6>
          <input class="complex" name="ed2" id="ed2" size=12 %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%> YYYY/MM/DD <i>(optional)</i></input>
          </td>
        </tr>
        <tr>
          <td class="evenrow"><label for="et2">End Time</label></TD>
          <td class="evenrow-l" colspan=6>
          <input class="complex" name="et2" id="et2" size=12 %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%> HH:MM:SS <i>(optional)</i></input>
          </td>
        </tr>
        <tr>
          <td class="oddrow" colspan=1>Repeating</TD>
          <td class="oddrow-l" colspan=5>
            <input class="complex" type="checkbox" name="doNotOverlap" id="doNotOverlap2" size=12 value="true" %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%><label for="doNotOverlap2">Repeat after completion</label></input>
          </td>

        </tr>
        <tr>
          <td class="evenrow" rowspan=3>Run Mask</td><td class="evenrow-l"><label for="month">Months</label></TD><td class="evenrow-l"><label for="mo_day">Days</label></TD><td class="evenrow-l"><label for="wk_day">Weekly Days</label></TD><td class="evenrow-l"><label for="hour">Hours</label></TD><td class="evenrow-l"><label for="min">Minutes</label></TD>
        </tr>
        <tr>
          <td class="evenrow-l" valign="top">
            <select class="complex" name="month" id="month" size="12" multiple %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%>
            %loop moMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
            </select>
          </td>
          <td class="evenrow-l" valign="top">
            <select class="complex" name="mo_day" id="mo_day" size="31" multiple %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%>
            %loop dayMoMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
            </select>
          </td>
          <td class="evenrow-l" valign="top">
            <select class="complex" name="wk_day" id="wk_day" size="7" multiple %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%>
            %loop dayWkMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
            </select>
          </td>
          <td class="evenrow-l" valign="top">
            <select class="complex" name="hour" id="hour" size="24" multiple %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%>
            %loop hourMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
            </select>
          </td>
          <td class="evenrow-l" valign="top">
            <select class="complex" name="min" id="min" size="30" multiple %ifvar mode equals('useradd')%%else%%ifvar type equals(complex)% %else%disabled%endif%%endif%>
            %loop minMask%<option value="%value idx encode(htmlattr)%" %value selected encode(htmlattr)%>%value name encode(html)%</option>%endloop%
            </select>
          </td>
        </tr>
        <tr>
          <td class="evenrow" colspan=5>
          <i>Selecting no items is equivalent to selecting all items for a given list</i>
          </td>
        </tr>

        %endif%

          <tr>
            <td class="action" colspan=7>
			  %ifvar webMethods-wM-AdminUI% <input type="hidden" id="webMethods-wM-AdminUI" name="webMethods-wM-AdminUI" value="true"> %endif%
              <input type="hidden" id="oid" name="oid" value="%value oid encode(htmlattr)%"></input>
              <input type="hidden" name="schaction"></input>
              %ifvar smode%
              <input type="button" value="Update task" onclick="return onUpdate();"></input>
              %else%
              <input type="button" value="Save Task" onclick="return onAdd();"></input>
              %endif%
            </td>
          </tr>



        %endinvoke%

      </form>

    </table>
    </td>
  </tr>
</table>


%case%
<body onLoad="setNavigation('scheduler.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_SrvrSchedScrn');">

<!-- =========================== user =========================== -->

<!-- User tasks table -->

<table width="100%" style="border-collapse: collapse; border: 0px">
 %invoke wm.server.schedule:getDefaultTimeZoneOffset%
    <tr>
    <td colspan="2">
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td class="breadcrumb-left" colspan="2">
                Server &gt; Scheduler</td>
            <td class="breadcrumb-right" align="right">
                All times %value timeZoneOffset%</td>
        </tr> 
    </table>
    </td></tr>
 %endinvoke%
  %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      %ifvar act%
          %switch act%
              %case 'CUT'%
                %ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Cancelled Task ID: %value message encode(html)%</td></tr>
                %endif%    
                %ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error cancelling task: %value message encode(html)%</td></tr>
                %endif%    
              %case 'SUT'%
                %ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Suspended Task ID: %value message encode(html)%</td></tr>
                %endif%    
                %ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error suspending task: %value message encode(html)%</td></tr>
                %endif%
              %case 'WUT'%
                %ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Woke Up Task ID: %value message encode(html)%</td></tr>
                %endif%    
                %ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error waking up task: %value message encode(html)%</td></tr>
                %endif%
              %case 'AUT'%
                %ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Added new task ID: %value message encode(html)%</td></tr>
                %endif%    
                %ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error scheduling task: %value message encode(html)%</td></tr>
                %endif%
              %case 'UUT'%
                %ifvar msgType equals('success')%
					<tr><td class="message" colspan="2">Updated task ID: %value message encode(html)%</td></tr>
                %endif%    
                %ifvar msgType equals('error')%
					<tr><td class="message" colspan="2">Error updating task: %value message encode(html)%</td></tr>
                %endif%
              %case 'PSC'%
                %ifvar msgType equals('success')%
                    <tr><td class="message" colspan="2">The Scheduler has been paused. No scheduled tasks will be initiated until the Scheduler is resumed.</td></tr>
                %endif%    
                %ifvar msgType equals('error')%
                    <tr><td class="message" colspan="2">Error pausing Scheduler.</td></tr>
                %endif%
              %case 'RSC'%
                %ifvar msgType equals('success')%
                    <tr><td class="message" colspan="2">The Scheduler has been resumed.</td></tr>
                %endif%    
                %ifvar msgType equals('error')%
                    <tr><td class="message" colspan="2">Error resuming Scheduler.</td></tr>
                %endif%
          %endswitch%
          %rename act oldACT%
        %else%
			<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
        %endif%
    %endif%

    %ifvar schaction%
    %switch schaction%

    %case 'cancel'%
      <!-- =============== cancel =============== -->
      %invoke wm.server.schedule:cancelUserTask%
        <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_success", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_success", "act", "CUT");
				setFormProperty("htmlform_scheduler_success", "msgType", "success");
				setFormProperty("htmlform_scheduler_success", "message", "%value oid %");
				setFormProperty("htmlform_scheduler_success", "filterTask", "%value filterTask%");
				setFormProperty("htmlform_scheduler_success", "statusActive", "%value statusActive%");
				setFormProperty("htmlform_scheduler_success", "thisISOnly", "%value thisISOnly%");
				setFormProperty("htmlform_scheduler_success", "showAll", "true");
				setFormProperty("htmlform_scheduler_success", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_success.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=CUT&msgType=success&message=%value oid encode(url)%&filterTask=%value filterTask encode(url)%&statusActive=%value statusActive encode(url)%&thisISOnly=%value thisISOnly encode(url)%&showAll=true&webMethods-wM-AdminUI=true");
			    }
				else {
				  document.location.replace("scheduler.dsp?act=CUT&msgType=success&message=%value oid encode(url)%&filterTask=%value filterTask encode(url)%&statusActive=%value statusActive encode(url)%&thisISOnly=%value thisISOnly encode(url)%&showAll=true");
				}
			}
			
        </script>    
      %onerror%
        <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_error", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_error", "act", "CUT");
				setFormProperty("htmlform_scheduler_error", "msgType", "error");
				setFormProperty("htmlform_scheduler_error", "message", "%value errorMessage%");
				setFormProperty("htmlform_scheduler_error", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_error.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=CUT&msgType=error&message=%value errorMessage encode(url)%&showAll=true&webMethods-wM-AdminUI=true");
			    }
				else {
				  document.location.replace("scheduler.dsp?act=CUT&msgType=error&message=%value errorMessage encode(url)%");
				}
			}
			
        </script>
      %endinvoke%

    %case 'suspend'%
      <!-- =============== suspend =============== -->
      %invoke wm.server.schedule:suspendUserTask%
       %ifvar taskSuspended equals('true')%
          <script>
			
			if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_sut_success", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_sut_success", "act", "SUT");
				setFormProperty("htmlform_scheduler_sut_success", "msgType", "success");
				setFormProperty("htmlform_scheduler_sut_success", "message", "%value oid%");
				setFormProperty("htmlform_scheduler_sut_success", "filterTask", "%value filterTask%");
				setFormProperty("htmlform_scheduler_sut_success", "statusActive", "%value statusActive%");
				setFormProperty("htmlform_scheduler_sut_success", "thisISOnly", "%value thisISOnly%");
				setFormProperty("htmlform_scheduler_sut_success", "showAll", "true");
				setFormProperty("htmlform_scheduler_sut_success", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_sut_success.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=SUT&msgType=success&message=%value oid encode(url)%&filterTask=%value filterTask encode(url)%&statusActive=%value statusActive encode(url)%&thisISOnly=%value thisISOnly encode(url)%&showAll=true&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=SUT&msgType=success&message=%value oid encode(url)%&filterTask=%value filterTask encode(url)%&statusActive=%value statusActive encode(url)%&thisISOnly=%value thisISOnly encode(url)%&showAll=true");
				}
			}
			
          </script>
      %endif%
      %ifvar taskSuspended equals('false')%
             <script>
			
			if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_sut_error", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_sut_error", "act", "SUT");
				setFormProperty("htmlform_scheduler_sut_error", "msgType", "error");
				setFormProperty("htmlform_scheduler_sut_error", "message", "%value errorMessage%");
				setFormProperty("htmlform_scheduler_sut_error", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_sut_error.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=SUT&msgType=error&message=%value errorMessage encode(url)%&showAll=true&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=SUT&msgType=error&message=%value errorMessage encode(url)%");
				}
			}
			
        </script>
        %endif%
      %onerror%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_sut_error1", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_sut_error1", "act", "SUT");
				setFormProperty("htmlform_scheduler_sut_error1", "msgType", "error");
				setFormProperty("htmlform_scheduler_sut_error1", "message", "%value errorMessage%");
				setFormProperty("htmlform_scheduler_sut_error1", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_sut_error1.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=SUT&msgType=error&message=%value errorMessage encode(url)%&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=SUT&msgType=error&message=%value errorMessage encode(url)%");
				}
			}
			
      </script>
      %endinvoke%

    %case 'wakeup'%
      <!-- =============== wakeup =============== -->
      %invoke wm.server.schedule:wakeupUserTask%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_wut_success", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_wut_success", "act", "WUT");
				setFormProperty("htmlform_scheduler_wut_success", "msgType", "success");
				setFormProperty("htmlform_scheduler_wut_success", "message", "%value oid%");
				setFormProperty("htmlform_scheduler_wut_success", "filterTask", "%value filterTask%");
				setFormProperty("htmlform_scheduler_wut_success", "statusActive", "%value statusActive%");
				setFormProperty("htmlform_scheduler_wut_success", "thisISOnly", "%value thisISOnly%");
				setFormProperty("htmlform_scheduler_wut_success", "showAll", "true");
				setFormProperty("htmlform_scheduler_wut_success", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_wut_success.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=WUT&msgType=success&message=%value oid encode(url)%&filterTask=%value filterTask encode(url)%&statusActive=%value statusActive encode(url)%&thisISOnly=%value thisISOnly encode(url)%&showAll=true&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=WUT&msgType=success&message=%value oid encode(url)%&filterTask=%value filterTask encode(url)%&statusActive=%value statusActive encode(url)%&thisISOnly=%value thisISOnly encode(url)%&showAll=true");
				}
			}
			
      </script>
      %onerror%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_wut_error", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_wut_error", "act", "WUT");
				setFormProperty("htmlform_scheduler_wut_error", "msgType", "error");
				setFormProperty("htmlform_scheduler_wut_error", "message", "%value errorMessage%");
				setFormProperty("htmlform_scheduler_wut_error", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_wut_error.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=WUT&msgType=error&message=%value errorMessage encode(url)%&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=WUT&msgType=error&message=%value errorMessage encode(url)%");
				}
			}
			
      </script>
      %endinvoke%

    %case 'Add Task'%
      <!-- =============== Add Task =============== -->
      %invoke wm.server.schedule:addTask%
        <script>
			
			if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_aut_success", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_aut_success", "act", "AUT");
				setFormProperty("htmlform_scheduler_aut_success", "msgType", "success");
				setFormProperty("htmlform_scheduler_aut_success", "message", "%value oid%");
				setFormProperty("htmlform_scheduler_aut_success", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_aut_success.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=AUT&msgType=success&message=%value oid encode(url)%&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=AUT&msgType=success&message=%value oid encode(url)%");
				}
			}
			
        </script>
      %onerror%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_aut_error", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_aut_error", "act", "AUT");
				setFormProperty("htmlform_scheduler_aut_error", "msgType", "error");
				setFormProperty("htmlform_scheduler_aut_error", "message", "%value errorMessage%");
				setFormProperty("htmlform_scheduler_aut_error", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_aut_error.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=AUT&msgType=error&message=%value errorMessage encode(url)%&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=AUT&msgType=error&message=%value errorMessage encode(url)%");
				}
			}
			
      </script>
      %endinvoke%

    %case 'Update Task'%
      <!-- =============== Update Task =============== -->
      %invoke wm.server.schedule:updateTask%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_uut_success", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_uut_success", "act", "UUT");
				setFormProperty("htmlform_scheduler_uut_success", "msgType", "success");
				setFormProperty("htmlform_scheduler_uut_success", "message", "%value oid%");
				setFormProperty("htmlform_scheduler_uut_success", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_uut_success.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=UUT&msgType=success&message=%value oid encode(url)%&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=UUT&msgType=success&message=%value oid encode(url)%");
				}
			}
			
      </script>
      %onerror%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_uut_error", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_uut_error", "act", "UUT");
				setFormProperty("htmlform_scheduler_uut_error", "msgType", "error");
				setFormProperty("htmlform_scheduler_uut_error", "message", "%value errorMessage%");
				setFormProperty("htmlform_scheduler_uut_error", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_uut_error.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=UUT&msgType=error&message=%value errorMessage encode(url)%&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=UUT&msgType=error&message=%value errorMessage encode(url)%");
				}
			}
			
      </script>
      %endinvoke%

    %case 'Pause Scheduler'%
      <!-- =============== Pause Scheduler =============== -->
      %invoke wm.server.schedule:pauseScheduler%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_psc_success", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_psc_success", "act", "PSC");
				setFormProperty("htmlform_scheduler_psc_success", "msgType", "success");
				setFormProperty("htmlform_scheduler_psc_success", "message", "The Scheduler has been paused.  No scheduled tasks will be initiated until the Scheduler is resumed.");
                setFormProperty("htmlform_scheduler_psc_success", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_psc_success.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=PSC&msgType=success&message=The Scheduler has been paused.  No scheduled tasks will be initiated until the Scheduler is resumed.&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=PSC&msgType=success&message=The Scheduler has been paused.  No scheduled tasks will be initiated until the Scheduler is resumed.");
				}
			}
			
      </script>
      %onerror%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_psc_error", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_psc_error", "act", "PSC");
				setFormProperty("htmlform_scheduler_psc_error", "msgType", "error");
				setFormProperty("htmlform_scheduler_psc_error", "message", "Error pausing Scheduler.");
                setFormProperty("htmlform_scheduler_psc_error", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_psc_error.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=PSC&msgType=error&message=Error pausing Scheduler.&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=PSC&msgType=error&message=Error pausing Scheduler.");
				}
			}
			
      </script>
      %endinvoke%

    %case 'Resume Scheduler'%
      <!-- =============== Pause Scheduler =============== -->
      %invoke wm.server.schedule:resumeScheduler%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_rsc_success", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_rsc_success", "act", "RSC");
				setFormProperty("htmlform_scheduler_rsc_success", "msgType", "success");
				setFormProperty("htmlform_scheduler_rsc_success", "message", "The Scheduler has been resumed.");
                setFormProperty("htmlform_scheduler_rsc_success", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_rsc_success.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=RSC&msgType=success&message=The Scheduler has been resumed.&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=RSC&msgType=success&message=The Scheduler has been resumed.");
				}
			}
			
      </script>
      %onerror%
      <script>
			
            if(is_csrf_guard_enabled && needToInsertToken) {
				createForm("htmlform_scheduler_rsc_error", "scheduler.dsp", "POST", "BODY");
				setFormProperty("htmlform_scheduler_rsc_error", "act", "RSC");
				setFormProperty("htmlform_scheduler_rsc_error", "msgType", "error");
				setFormProperty("htmlform_scheduler_rsc_error", "message", "Error resuming Scheduler.");
                setFormProperty("htmlform_scheduler_rsc_error", _csrfTokenNm_, _csrfTokenVal_);
				document.htmlform_scheduler_rsc_error.submit();
            } else {
				var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				  document.location.replace("scheduler.dsp?act=RSC&msgType=error&message=Error resuming Scheduler.&webMethods-wM-AdminUI=true");
				}
				else {
				  document.location.replace("scheduler.dsp?act=RSC&msgType=error&message=Error resuming Scheduler.");
				}
			}
			
  </script>
      %endinvoke%

    %endswitch%
    %endif%

    <tr>
      <td colspan=2>
    <ul class="listitems">
          %invoke wm.server.schedule:getSchedulerState%
          %ifvar state equals('running')%
            <li class="listitem">
			<script>
			createForm("htmlform_scheduler_pause_scheduler", "scheduler.dsp", "POST", "BODY");
			setFormProperty("htmlform_scheduler_pause_scheduler", "schaction", "Pause Scheduler");
			</script>
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<a href="javascript:document.htmlform_scheduler_pause_scheduler.submit();" onclick="return confirmPause();">Pause Scheduler (currently Running)</a>');
				} else {
				    var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				    if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				      document.write('<a href="scheduler.dsp?schaction=Pause Scheduler&webMethods-wM-AdminUI=true" onclick="return confirmPause();">Pause Scheduler (currently Running)</a>');
				    }
				    else {
				      document.write('<a href="scheduler.dsp?schaction=Pause Scheduler" onclick="return confirmPause();">Pause Scheduler (currently Running)</a>');
				    }
				}
			</script>
			</li>
          %else%
			<script>
			createForm("htmlform_scheduler_resume_scheduler", "scheduler.dsp", "POST", "BODY");
			setFormProperty("htmlform_scheduler_resume_scheduler", "schaction", "Resume Scheduler");
			</script>
            <li class="listitem">
			<script>
				if(is_csrf_guard_enabled && needToInsertToken) {
					document.write('<a href="javascript:document.htmlform_scheduler_resume_scheduler.submit();" onclick="return confirmResume();">Resume Scheduler (currently Paused)</a>');
				} else {
				    var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				    if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				      document.write('<a href="scheduler.dsp?schaction=Resume Scheduler&webMethods-wM-AdminUI=true" onclick="return confirmResume();">Resume Scheduler (currently Paused)</a>');
				    }
				    else {
				      document.write('<a href="scheduler.dsp?schaction=Resume Scheduler" onclick="return confirmResume();">Resume Scheduler (currently Paused)</a>');
				    }
				}
			</script>
			
			</li>
          %endif%
          %endinvoke%
		  <script>
		  createForm("htmlform_scheduler_mode_sys", "scheduler.dsp", "POST", "BODY");
		  setFormProperty("htmlform_scheduler_mode_sys", "mode", "sys");
		  createForm("htmlform_scheduler_mode_useradd", "scheduler.dsp", "POST", "BODY");
		  setFormProperty("htmlform_scheduler_mode_useradd", "mode", "useradd");		  
		  createForm("htmlform_scheduler_showall", "scheduler.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("scheduler.dsp?mode=sys", "javascript:document.htmlform_scheduler_mode_sys.submit();", "View System Tasks");</script>
		  </li>
          <li class="listitem">
		  <script>getURL("scheduler.dsp?mode=useradd", "javascript:document.htmlform_scheduler_mode_useradd.submit();", "Create a Scheduled Task");</script>
		  </li>
        <li class="listitem" id="showfew" name="showfew"><a href="javascript:showFilterPanel(true)">Filter Services</a></li>
        <li class="listitem" style="display:none" id="showall" name="showall">
		<script>getURL("scheduler.dsp", "javascript:document.htmlform_scheduler_showall.submit();", "Show All Services");</script>
		</li>

        <div id="filterContainer" name="filterContainer" style="display:none;padding-top=2mm;">
                  <br>
                  <table>
                  <tr valign="top">
                  <td>
				  <span ><label for="filterTask">Enter Complete/Part of Service Name</label></span><br>
				  <input type="text" name="filterTask" id="filterTask" value="%value filterTask encode(htmlattr)%" onKeyPress="filterServices(event)"/>

                <IMG SRC="images/blank.gif" height=20 width=40>
                <input type="checkbox" id="statusActive" name="statusActive" %ifvar statusActive equals('true')%checked%endif% />

				<span id="statustitle" name="statustitle"><label for="statusActive">Status is Active</label></span>

                <IMG SRC="images/blank.gif" height=20 width=40>
                <input type="checkbox" id="thisISOnly" name="thisISOnly" %ifvar thisISOnly equals('true')%checked%endif% />
				<span id="thisIStitle" name="thisIStitle"><label for="thisISOnly">Hide Remote Tasks</label></span>

                </td> <td>
              <IMG SRC="images/blank.gif" height=20 width=40>
              <input type="Button" id="submit" name="submit" value="Submit" onclick="refreshAndFilter()"/>
              </td> </tr></table>
              <TR><TD id="result" name="result" colspan="2" align="right"></TD></TR>
    </DIV>
        </ul>
      </td>
    </tr>

    <tr>
      <td>
        <table class="tableView" width=100% id="head" name="head">
          %invoke wm.server.schedule:getUserTaskList%

          <tr><td class="heading" colspan=11>One-Time and Simple Interval Tasks</td></tr>
          <tr class="subheading2">
            <th class="oddcol" scope="col">ID</th>
            <th class="oddcol" scope="col">Service</th>
            <th class="oddcol" scope="col" width="100px">Description</th>
            <th class="oddcol" scope="col">Queue Name</th>
            <th class="oddcol" scope="col">Last Error</th>
            <th class="oddcol" nowrap  scope="col">Run As User</th>
            <th class="oddcol" scope="col">Target</th>
            <th class="oddcol" scope="col">Interval (sec)</th>
            <th class="oddcol" scope="col">Next Run (sec)</th>
            <th class="oddcol" scope="col">Status</th>
            <th class="oddcol" scope="col">Remove</td>
          </tr>
          %ifvar -notempty tasks%
              <script>resetRows();</script>
          %loop tasks%
          <tr>
              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %value oid encode(html)%</td>

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
	              	%value name encode(html)%
					<script> document.write('<input type="hidden" name="sourceValue" value="%value name encode(html)%"/>');	 </script>
					</td>
              %else%
                <script>writeTD("rowdata-l");</script>
					<script>
					createForm("htmlform_scheduler_mode_useradd_smode_edit_%value $index%", "scheduler.dsp", "POST", "BODY");
					setFormProperty("htmlform_scheduler_mode_useradd_smode_edit_%value $index%", "mode", "useradd");
					setFormProperty("htmlform_scheduler_mode_useradd_smode_edit_%value $index%", "oid", "%value oid%");
					setFormProperty("htmlform_scheduler_mode_useradd_smode_edit_%value $index%", "smode", "Edit");
					</script>
					<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_scheduler_mode_useradd_smode_edit_%value $index%.submit();">%value name encode(html)%</a>');
						} else {
				            var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				            if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							  document.write('<a href="scheduler.dsp?mode=useradd&oid=%value oid encode(url)%&smode=Edit&webMethods-wM-AdminUI=true">%value name encode(html)%</a>');
							}
							else {
							  document.write('<a href="scheduler.dsp?mode=useradd&oid=%value oid encode(url)%&smode=Edit">%value name encode(html)%</a>');
							}
						}
						document.write('<input type="hidden" name="sourceValue" value="%value name encode(html)%"/>');
					</script>
    	        	
					</td>
              %endif%

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %value description encode(html)%</td>

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %ifvar qName%%value qName encode(html)%%else%N/A%endif%</td>

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %ifvar lastError%%value lastError encode(html)%%else%N/A%endif%</td>

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %value runAsUser encode(html)%</td>

              %ifvar target equals('$all')%
                  %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
                  All Servers</td>
              %else%
                 %ifvar target equals('$any')%
                    %ifvar parentID%%value%
                        <script>writeTD("childrow");</script>
                    %else%
                        <script>writeTD("rowdata-l");</script>
                    %endif%
                    Any Server</td>
                 %else%
                  %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
                  %value target encode(html)%</td>
                %endif%
              %endif%

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %ifvar interval equals(0)%once%else%%value interval decimal(-3,1) encode(html)% %endif%</td>

            %ifvar schedState equals('expired')%
                    <script>writeTD("rowdata");</script>--</td>

                    %ifvar parentID%%value%
                        <script>writeTD("childrow");</script>
                    %else%
                        <script>writeTD("rowdata-l");</script>
                    %endif%
                  	<a href="javascript:redirectPage('wakeup','%value oid encode(url)%')" onclick="alert('Cannot activate expired task.  The end date and time must be in the future.'); return false;">Expired</a></td>
            %else%
              %ifvar execState equals('suspended')%
                    <script>writeTD("rowdata");</script>--</td>

                    %ifvar parentID%%value%
                        <script>writeTD("childrow");</script>
                    %else%
                        <script>writeTD("rowdata-l");</script>
                    %endif%
                    <a href="javascript:redirectPage('wakeup','%value oid encode(url)%')" onclick="return confirm('Are you sure you want to activate this task?');">Suspended</a></td>
              %else%
	                %ifvar %value parentID encode(html)%%
                        <script>writeTD("childrow");</script>
                    %else%
                        <script>writeTD("rowdata-l");</script>
                    %endif%
                    %ifvar target equals('$all')% N/A %else%  %value msDelta decimal(-3,1) encode(html)% %endif% </td>

                    %ifvar parentID%%value%
                        <script>writeTD("childrow");</script>
                    %else%
                        <script>writeTD("rowdata-l");</script>
                    %endif%
                    <a href="javascript:redirectPage('suspend','%value oid encode(url)%')" onclick="return confirm('Are you sure you want to suspend task?');"><img src="images/green_check.png" alt="Scheduled Task Status" border=0>%ifvar execState equals('running')%Running%else%Active%endif%</a></td>
              %endif%
            %endif%

            <script>writeTD("rowdata");</script>
                 <a class="imagelink" href="javascript:redirectPage('cancel','%value oid encode(url)%')" onclick="return confirm('Are you sure you want to remove this task?');"><img src="icons/delete.png" alt="Delete the scheduled task" border=0></a></td>
          </tr>

          <script>swapRows();</script>
          %endloop%
          %else%
           %ifvar error%
           <tr><td class="evenrow-l" colspan=11>%value error encode(html)%</td></tr>
           %else%
             <tr><td class="evenrow-l" colspan=11>No tasks are currently scheduled</td></tr>
           %endif%
          %endif%

          <tr><td class="space" colspan="11">&nbsp;</td></tr>

          <tr><td class="heading" colspan=11>Complex Repeating Tasks</td></tr>
          <TR class="subheading2">
            <th class="oddcol" scope="col">ID</th>
            <th class="oddcol" scope="col">Service</th>
            <th class="oddcol" scope="col" width="100px">Description</th>
            <th class="oddcol" scope="col">Queue Name</th>
            <th class="oddcol" scope="col">Last Error</th>
            <th class="oddcol" nowrap  scope="col">Run As User</th>
            <th class="oddcol" scope="col">Target</th>
            <th class="oddcol" scope="col">Interval Masks</th>
            <th class="oddcol" scope="col">Next Run (sec)</th>
            <th class="oddcol" scope="col">Status</th>
            <th class="oddcol" scope="col">Remove</th>
          </tr>
          %ifvar -notempty extTasks%
              <script>resetRows();</script>
          %loop extTasks%
          <tr>
               %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %value oid encode(html)%</td>

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
	              	%value name encode(html)%
					<script> document.write('<input type="hidden" name="sourceValue" value="%value name encode(html)%"/>');	 </script>
					</td>
              %else%
                <script>writeTD("rowdata-l");</script>
					<script>
					createForm("htmlform_scheduler_mode_useradd_smode_edit1_%value $index%", "scheduler.dsp", "POST", "BODY");
					setFormProperty("htmlform_scheduler_mode_useradd_smode_edit1_%value $index%", "mode", "useradd");
					setFormProperty("htmlform_scheduler_mode_useradd_smode_edit1_%value $index%", "oid", "%value oid%");
					setFormProperty("htmlform_scheduler_mode_useradd_smode_edit1_%value $index%", "smode", "Edit");
					</script>
    	        	<script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_scheduler_mode_useradd_smode_edit1_%value $index%.submit();">%value name encode(html)%</a>');
						} else {
				            var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
				            if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
							  document.write('<a href="scheduler.dsp?mode=useradd&oid=%value oid encode(url)%&smode=Edit&webMethods-wM-AdminUI=true">%value name encode(html)%</a>');
							}
							else {
							  document.write('<a href="scheduler.dsp?mode=useradd&oid=%value oid encode(url)%&smode=Edit">%value name encode(html)%</a>');
							}
						}
						document.write('<input type="hidden" name="sourceValue" value="%value name encode(html)%"/>');	
					</script>
					
					</td>
              %endif%

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %value description encode(html)%</td>

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
			  %ifvar qName%%value qName encode(html)%%else%N/A%endif%</td>

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %ifvar lastError%%value lastError encode(html)%%else%N/A%endif%</td>

              %ifvar parentID%%value%
                <script>writeTD("childrow");</script>
              %else%
                <script>writeTD("rowdata-l");</script>
              %endif%
              %value runAsUser encode(html)%</td>

              %ifvar target equals('$all')%
                  %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
                  All Servers</td>
              %else%
                 %ifvar target equals('$any')%
                    %ifvar parentID%%value%
                        <script>writeTD("childrow");</script>
                    %else%
                        <script>writeTD("rowdata-l");</script>
                    %endif%
                    Any Server</td>
                 %else%
                  %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
    	          %value target encode(html)%</td>
                %endif%
              %endif%
          <td class="rowdata" colspan="1" style="padding: 0px;">
                <table width="100%" class="tableInline" cellspacing="1" style="background-color: #ffffff">
                                    <tr>
                                        <script>writeTD("row");</script>
                                            Months
                                        </td>
                                        %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
            %ifvar monthMaskAlt%
		    %value monthMaskAlt  encode(html)%
            %else%
            January..December
            %endif%
                                        </td>
                                    </tr>
                                    <tr>
                                        <script>writeTD("row");</script>
                                            Days
                    </td>
                                        %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
            %ifvar dayOfMonthMaskAlt%
		    %value dayOfMonthMaskAlt encode(html)%
            %else%
            1..31
            %endif%
                                        </td>
                                    </tr>
                                    <tr>
                                        <script>writeTD("row");</script>
                                            Days&nbsp;of Week
                                        </td>
                                        %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
            %ifvar dayOfWeekMaskAlt%
		    %value dayOfWeekMaskAlt encode(html)%
            %else%
            Sunday..Saturday
            %endif%
                                        </td>
                                    </tr>
                                    <tr>
                                        <script>writeTD("row");</script>
                        Hours
                    </td>
                                        %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
            %ifvar hourMaskAlt%
		    %value hourMaskAlt encode(html)%
            %else%
            0..23
            %endif%
                                        </td>
                                    </tr>
                                    <tr>
                                        <script>writeTD("row");</script>
                                            Minutes
                    </td>
                                        %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
            %ifvar minuteMaskAlt%
		    %value minuteMaskAlt encode(html)%
            %else%
            0..59
            %endif%
                                        </td>
                                    </tr>
                                </table>
                            </td>

            %ifvar schedState equals('expired')%
              <script>writeTD("rowdata");</script>
                  --</td>
              %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
                  <a href="javascript:redirectPage('wakeup','%value oid encode(url)%')" onclick="alert('Cannot activate expired task.  The end date and time must be in the future.'); return false;">Expired</a></td>
            %else%
              %ifvar execState equals('suspended')%
                <script>writeTD("rowdata");</script>
                    --</td>
                %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
                    <a href="javascript:redirectPage('wakeup','%value oid encode(url)%')" onclick="return confirm('Are you sure you want to activate this task?');">Suspended</a></td>
              %else%
                %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
                  %ifvar target equals('$all')% N/A %else%  %value msDelta decimal(-3,1) encode(html)% %endif% </td>
                %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
                    <a href="javascript:redirectPage('suspend','%value oid encode(url)%')" onclick="return confirm('Are you sure you want to suspend task?');"><img src="images/green_check.png" alt="Scheduled Task Status"  border=0>%ifvar execState equals('running')%Running%else%Active%endif%</a></td>
              %endif%
            %endif%

              %ifvar parentID%%value%
                    <script>writeTD("childrow");</script>
                  %else%
                    <script>writeTD("rowdata-l");</script>
                  %endif%
                  <a class="imagelink" href="javascript:redirectPage('cancel','%value oid encode(url)%')" onclick="return confirm('Are you sure you want to remove this task?');"><img src="icons/delete.png" alt="Delete scheduled task" border=0></a></td>
          </tr>
              <script>swapRows();</script>
          %endloop%
          %else%
           %ifvar error%
           <tr><td class="evenrow-l" colspan=11>%value error encode(html)%</td></tr>
           %else%
             <tr><td class="evenrow-l" colspan=11>No tasks are currently scheduled</td></tr>
           %endif%
          %endif%


          %endinvoke%
         <script>filterServicesInternal();</script>
         %ifvar showAll%<script>showFilterPanel()</script>%endif%
          </table>
      %endswitch%

        </td>
      </tr>
    </table>
</body>
</html>
