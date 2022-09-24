%ifvar op equals('Apply')%
  %invoke wm.server.net.listeners:httpControls%
  %endinvoke%
%endif%

%invoke wm.server.net.listeners:getListener%

<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <TITLE>Advanced Port Controls</TITLE>
    <SCRIPT Language="JavaScript">
    
    function  setOperation(form1)
    {
        form1.op.value = "Apply";
        return true;
    }
        function changeAction(form) {
            if(null != form.op && undefined != form.op)
                form.op.value = "Cancel";
            form.action = "security-ports.dsp"
            return true;
        }

        function checkSuspend(form) {
            if (form.suspended.value == "true")
            {
              alert("Listener suspended, must be resumed before other controls can be applied");
              return false;
            }
            if (form.listenerCntl.checked)
            {
              var msg = "";
              if(form.listenerCntl.value == 'resume')
                msg = "Other controls can not be applied when resume has been selected.";
              if(form.listenerCntl.value == 'suspend')
                msg = "Other controls can not be applied when suspend has been selected.";
              alert(msg);
              return false;
            }
            return true;
        }
        function clearOtherAction(form) {
            document.properties.actionListener.checked = false;
            document.properties.actionListener.value = "";
            document.properties.stepsizeListener.value = "";
            document.properties.actionThreadPool.checked = false;
            document.properties.actionThreadPool.value = "";
            document.properties.numThreads.value = "";
            return true;
        }
    </SCRIPT>
    </HEAD>
  <BODY onLoad="setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AdvancedControlsScrn');">
  <TABLE width="100%">
   <TR>
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
      <TD class="breadcrumb" colspan=2>
        Security &gt;
        Ports &gt;
        Advanced Controls
        %ifvar listenerKey%
           &gt %value listenerKey encode(html)%
        %endif%
      </TD>
   </TR>
   <TR>
      <TD colspan="2">
          <UL>
		  <script>
						    createForm("htmlform_http_security_ports", "security-ports.dsp", "POST", "BODY");
           </script>			
		   
            <li>
			<script>getURL("security-ports.dsp", "javascript:document.htmlform_http_security_ports.submit();", "Return to Ports");</script>
			</li>
          </UL>
      </TD>
   </TR>
   <TR>
     <TD>
       <TABLE class="tableView">
          <tr>

            <form name="properties" action="http-advanced.dsp" method="POST">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            <input type="hidden" name="factoryKey" value="webMethods/HTTP">
            <input type="hidden" name="pkg" value="%value pkg encode(htmlattr)%">
            <input type="hidden" name="listenerKey" value="%value listenerKey encode(htmlattr)%">
            <input type="hidden" name="listening" value="%value listening encode(htmlattr)%">
            <input type="hidden" name="threadPool" value="%value threadPool encode(htmlattr)%">
            <input type="hidden" name="listenerType" value="%value listenerType encode(htmlattr)%">
            <input type="hidden" name="minThread" value="%value minThread encode(htmlattr)%">
            <input type="hidden" name="ssl" value="%value ssl encode(htmlattr)%">
            <input type="hidden" name="suspended" value="%value suspended encode(htmlattr)%">
            <!--added for PIE-21143 can not localize Apply button in http-advanced.dsp -->
            <input type="hidden" name="op" id="op" value="">

           <tr>
             <td class="heading" colspan="2">
                %switch listenerType%
                    %case 'Regular'%Regular
                    %case 'revinvoke'%Enterprise Gateway External
                    %case 'revinvokeinternal'%Enterprise Gateway Registration 
                    %case 'regularinternal'%Registration Internal
                    %case 'Diagnostic'%Diagnostic
                  %endswitch%
                  %ifvar ssl equals('true')%
                    HTTPS
                  %else%
                    HTTP
                  %endif%
             Listener State</td>
           </tr>
           <tr>
              <td class="oddrow">Started</td>
              <td class="oddrowdata-l">
                 %switch listening%
                    %case 'true'%Yes
                    %case 'false'%No
                    %case%Unknown
                 %endswitch%
              </td>
           </tr>
           <tr>
              <td class="oddrow">Suspended</td>
              <td class="oddrowdata-l">
                 %switch suspended%
                    %case 'true'%Yes
                    %case 'false'%No
                    %case%No
                 %endswitch%
              </td>
           </tr>
           <tr>
              <td class="oddrow">Throttled</td>
              <td class="oddrowdata-l">
                 %ifvar curDelay equals('0')%
                    No
                 %else%
                    Yes [%value curDelay encode(html)%ms]
                 %endif%
              </td>
           </tr>

           %ifvar threadPool equals('true')%
           <tr>
             <td class="heading" colspan="2">Private Thread Pool</td>
           </tr>
            <tr>
              <td class="oddrow">Max Number Threads</td>
              <td class="oddrowdata-l">
                 %value maxThread encode(html)%
              </td>
            </tr>
           %endif%

           %ifvar listenerType equals('regularinternal')%
             <tr>
               <td class="heading" colspan="2">Internal Server Registration Port</td>
             </tr>
             <tr>
               <td class="oddrow">Max Number Connections</td>
               <td class="oddrowdata-l">
                 %value maxConnections encode(html)%
               </td>
             </tr>
           %endif%

           <tr>
            <td class="space" colspan="2">&nbsp;</td>
           </tr>
           <tr>
           %ifvar listenerType equals('regularinternal')%
             <tr>
               <td class="heading" colspan="2">Internal Server Registration Port Controls</td>
             </tr>
          <tr>
             <td class="oddrow">
               <input type="radio" name="actionMaxConns" id="actionMaxConns1"  value="increase" %ifvar actionMaxConns equals('increase')%checked%endif%><label for="actionMaxConns1">Increase By</label>
               <input type="radio" name="actionMaxConns" id="actionMaxConns2"  value="decrease" %ifvar actionMaxConns equals('decrease')%checked%endif%><label for="actionMaxConns2">Decrease By</label>
               <input type="radio" name="actionMaxConns" id="actionMaxConns3"  value="set" %ifvar actionMaxConns equals('set')%checked%endif%><label for="actionMaxConns3">Set To</label></td>
             </td>
             <td class="oddrow-1">
               <input type="text" name="maxConns" value="%value maxConns encode(htmlattr)%">Connections
             </td>
           </tr>
           %else%
           <tr>
             <td class="heading" colspan="2">Listener Controls</td>
           </tr>
           <tr>
             %ifvar suspended equals('true')%
                 <td class="oddrow"><label for="resume">Resume</label></td>
               <td class="oddrow-l">
                 <input type="checkbox" name="listenerCntl" value="resume" id="resume" onclick="return clearOtherAction(document.properties);"></input>
               </td>
             %else%
                 <td class="oddrow"><label for="suspend">Suspend</label></td>
               <td class="oddrow-l">
              <input type="checkbox" name="listenerCntl" value="suspend" id="suspend" onclick="return clearOtherAction(document.properties);"></input>
               </td>
             %endif%
           </tr>
           <tr>
             <td class="oddrow">
               <input type="radio" name="actionListener" id="actionListener1" value="increase" %ifvar actionListener equals('increase')%checked%endif% onclick="return checkSuspend(document.properties);"><label for="actionListener1">Increase By</label>
               <input type="radio" name="actionListener" id="actionListener2" value="decrease" %ifvar actionListener equals('decrease')%checked%endif% onclick="return checkSuspend(document.properties);"><label for="actionListener2">Decrease By</label>
               <input type="radio" name="actionListener" id="actionListener3" value="set" %ifvar actionListener equals('set')%checked%endif% onclick="return checkSuspend(document.properties);"><label for="actionListener3">Set To</label></td>
             </td>
             <td class="oddrow-l">
               <input name="stepsizeListener" id="stepsizeListener" value="%value stepsizeListener encode(htmlattr)%"  onClick="return checkSuspend(document.properties);"><label for="stepsizeListener">Delay(ms)</label>
             </td>
           </tr>
          %endif%

           %ifvar threadPool equals('true')%
           <tr>
             <td class="heading" colspan="2">Private Thread Pool Controls</td>
           </tr>
           <tr>
             <td class="oddrow">
               <input type="radio" name="actionThreadPool" id="actionThreadPool1"  value="increase" %ifvar actionThreadPool equals('increase')%checked%endif% onClick="return checkSuspend(document.properties);" ><label for="actionThreadPool1">Increase By</label>
               <input type="radio" name="actionThreadPool" id="actionThreadPool2"  value="decrease" %ifvar actionThreadPool equals('decrease')%checked%endif% onClick="return checkSuspend(document.properties);"><label for="actionThreadPool2">Decrease By</label>
               <input type="radio" name="actionThreadPool" id="actionThreadPool3"  value="set" %ifvar actionThreadPool equals('set')%checked%endif% onClick="return checkSuspend(document.properties);" ><label for="actionThreadPool3">Set To</label></td>
             </td>
             <td class="oddrow-l">
               <input name="numThreads" id="numThreads1" value="%value numThreads encode(htmlattr)%" onClick="return checkSuspend(document.properties);"><label for="numThreads1">Threads</label>
             </td>
           </tr>
           %endif%

            <tr>
                <td  class="action">
                    <input type="submit" name="submitButton" value="Apply" onclick="return setOperation(this.form);">
                </td>
                <td  class="action">
                    <input type="submit" name="cancelButton" value="Cancel" onclick="return changeAction(document.properties);">
                </td>
            </tr>
            
      </form>
        </table>
      </td>
    </tr>
</TABLE>
</BODY>





</HTML>
%endinvoke%
