%invoke wm.server.query:getCalendar%   

<html>

    <head>
        <title>Set %value /which%</title>
        <link rel="stylesheet" type="text/css" href="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <script src="csrf-guard.js"></script>
		<SCRIPT SRC="webMethods.js"></SCRIPT>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <style>
            .scrollbutton { 
                font-size: 70%; 
                letter-spacing: 1px; 
                font-weight: bold; 
                background-color: #666666;
                color: #ffffff;
                width: 30%; 
            }

            td .yearmonth {
                color: #666666;
                background-color: #ffffff;
                font-weight: bold;
                padding: 5px;
            }

            td .dayname {
                text-align: center;
                padding: 5px;
                border-bottom: #ccc 1px solid;
            }

            td .day {
                text-align: center;
                padding: 5px;
                width: 14%;
            }

            td.day a {
                color: #007aa3;
                text-decoration: none;
            }

            td.day a:hover {
                text-decoration: underline;
            }
        </style>
        <script language="JavaScript1.2">

            var today = (new Date()).getDate();

            function setDate( date )
            {
                var m = new Number("%value month encode(javascript)%") + 1;
                if( m < 10 ) {
                    m = "0" + m;
                }
                if( date < 10 ) {
                    date = "0" + date;
                }
                document.calForm.dateSelected.value = "%value year encode(javascript)%-" + m + "-"+date+" 00:00:00";
            }

            function submitCal( whichEnd )
            {
                var theField = null;
                if( whichEnd == "From Creation Date" ) {
                    theField = opener.document.logform.qfromdate;
                } else {
                    theField = opener.document.logform.qtodate;
                }
                theField.value = trimDate( document.calForm.dateSelected.value );
                window.close();
            }

            function trimDate( date )
            {
                if( date.lastIndexOf(":") > 0 )
                {
                    date = date.substring( 0, (date.lastIndexOf(":")+3) );
                }
                if( date.indexOf(" " ) != 0 )
                {
                    return date;
                } else {
                    while( date.indexOf(" ") == 0 ) {
                        date = date.substring( 1, date.lastIndexOf(":")+3 );
                    }
                    return date;
                }    
            }

            function monthBack() 
            {
                var pMonth = new Number("%value month encode(javascript)%") - 1;
                var pYear = new Number("%value year encode(javascript)%");
                if( pMonth == -1 ) {
                    pMonth = 11; 
                    pYear = pYear - 1;
                }
                //alert( "roll back to month = " + pMonth );
				
				
				if(is_csrf_guard_enabled && needToInsertToken) 
				{
					createForm("htmlForm_calendar", 'calendar.dsp', "POST", "HEAD");
					setFormProperty("htmlForm_calendar", "year", pYear);	
					setFormProperty("htmlForm_calendar", "month", pMonth);
					setFormProperty("htmlForm_calendar", "which", "%value which%");
				    setFormProperty("htmlForm_calendar", _csrfTokenNm_, _csrfTokenVal_);
					document.htmlForm_calendar.submit();
				} else {
					document.location.replace( "calendar.dsp?year="+pYear+"&month="+pMonth+"&which=%value which encode(url)%" );
				}
				   
				
            }

            function monthForward() 
            {
                var nMonth = new Number("%value month encode(javascript)%") + 1;
                var nYear = new Number("%value year encode(javascript)%");
                if( nMonth == 12 ) {
                    nMonth = 0;  
                    nYear = nYear + 1;
                }
                //alert( "roll forward to next month = " + nMonth + " and year = " + nYear );
				
				
				if(is_csrf_guard_enabled && needToInsertToken) 
				   {
					   createForm("htmlForm_calendar2", 'calendar.dsp', "POST", "HEAD");
						setFormProperty("htmlForm_calendar2", "year", nYear);	
						setFormProperty("htmlForm_calendar2", "month", nMonth);
						setFormProperty("htmlForm_calendar2", "which", "%value which%");
						setFormProperty("htmlForm_calendar2", _csrfTokenNm_, _csrfTokenVal_);
						document.htmlForm_calendar2.submit();
				   } else {
					   document.location.replace( "calendar.dsp?year="+nYear+"&month="+nMonth+"&which=%value which encode(url)%" );
				   }
				   
				
		        
            }
            function yearBack() 
            {
                var pYear = new Number("%value year encode(javascript)%") - 1;
				
				
				if(is_csrf_guard_enabled && needToInsertToken) 
				{
					createForm("htmlForm_calendar3", 'calendar.dsp', "POST", "HEAD");
					setFormProperty("htmlForm_calendar3", "year", pYear);	
					setFormProperty("htmlForm_calendar3", "month", "%value month encode(javascript)%");
					setFormProperty("htmlForm_calendar3", "which", "%value which%");
				   setFormProperty("htmlForm_calendar3", _csrfTokenNm_, _csrfTokenVal_);
				   document.htmlForm_calendar3.submit();
				} else {
					document.location.replace( "calendar.dsp?year=" + pYear + "&month=%value month encode(url)%&which=%value which encode(url)%" );
				}
				
            }

            function yearForward() 
            {
                var nYear = new Number("%value year encode(javascript)%") + 1;
				
				
				if(is_csrf_guard_enabled && needToInsertToken) 
				{
					createForm("htmlForm_calendar4", 'calendar.dsp', "POST", "HEAD");
					setFormProperty("htmlForm_calendar4", "year", nYear);	
					setFormProperty("htmlForm_calendar4", "month", "%value month encode(javascript)%");
					setFormProperty("htmlForm_calendar4", "which", "%value which%");
					setFormProperty("htmlForm_calendar4", _csrfTokenNm_, _csrfTokenVal_);
					document.htmlForm_calendar4.submit();
				} else {
					document.location.replace( "calendar.dsp?year=" + nYear + "&month=%value month encode(url)%&which=%value which encode(url)%" );
				}
				   
            }

            function readDate( whichEnd )
            {
                var d = null;
                if( whichEnd == "From Date" ) {
                    d = opener.document.logform.qfromdate.value;
                } else {
                    d = opener.document.logform.qtodate.value;
                }
                //alert( "opener date is " + d );
                document.calForm.dateSelected.value = d;
            }
        </script> 
    </head>
    
    %invoke wm.server.query:getCalendar%
    
    <body onload="javascript:readDate('%value /which encode(javascript)%');">
        <table width="100%">
            <tr>
                <td width="100%">
                    <form name="scrollForm" method="post">
                    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                    <table width="100%">
                        <tr>
                            <td colspan="7" width="100%">
                                <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0" bgcolor="#000000">
                                    <tr>
                                        <td align="center" style="width: 20%">
                                            <input type="button" name="prevYear" value="<<" class="scrollbutton" onClick="yearBack();">
                                        </td>
                                        <td align="center" style="width: 20%">
                                            <input class="scrollbutton" type="button" name="prevMonth" value="<" onClick="monthBack();">
                                        </td>
                                        <td align="center" style="width: 20%" class="yearmonth">
                                            %ifvar locale equals('ja')%
												%value yearName encode(html)% %value monthName encode(html)%
											%else%
												%ifvar locale equals('ja-JP')%
													%value yearName encode(html)% %value monthName encode(html)%
												%endif%
											%else% 
												%value monthName encode(html)% %value year encode(html)%
										    %endif%
                                        </td>
                                        <td align="center" style="width: 20%">
                                            <input class="scrollbutton" type="button" name="nextMonth" value=">" onClick="monthForward();">
                                        </td>
                                        <td align="center" style="width: 20%">
                                            <input type="button" name="nextYear" value=">>" class="scrollbutton" onClick="yearForward();">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </form>
                    <form name="calForm" action="svc_queryframe.dsp" method="post">
                        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                        <tr>
                            %scope calendarRec%
                            %loop weekdays%
                            <td class="dayname">
                                %value weekdays encode(html)%
                            </td>
                            %endloop weekdays%
                        </tr>
                        %loop weeks%
                        <tr>
                            %loop dates%
                            <td class="day">
                                <a href="javascript:setDate('%value dates encode(url_javascript)%');">%value dates encode(html)%</a>
                            </td>
                            %endloop dates%
                        </tr>
                        %endloop weeks%

                        <tr>
                            <td colspan="7" class="day" style="border-top: 1px #ccc solid;">
                                &nbsp;
                            </td>
                        </tr>

                        <tr>
                            <td colspan="7" style="text-align: right"><label for="dateSelected">
                                &nbsp;&nbsp;%value /which encode(html)%</label>
                                <input type="text" id="dateSelected" name="dateSelected" size="19">
                                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="button" name="set" value="Set" onClick="submitCal('%value /which encode(javascript)%');">
                            </td>
                        </tr>
                    </table>
                    </form>
                </td>
            </tr>
        </table>
   
    </body>
    %endinvoke%
</html>
