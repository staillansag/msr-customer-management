%ifvar schedState equals('expired')%
  <td class="rowdata" style="background-color: #faa">-expired-</td>
  <td class="rowdata" style="background-color: #faa">%value runAtTime%</td>
  <td class="rowdata" style="background-color: #faa">
    <a href="javascript:redirectPage('wakeup','%value oid encode(url)%')"
       onclick="alert('Cannot activate expired task. The end date and time must be in the future.'); return false;">
      Expired
    </a>
  </td> 
%else%
  %ifvar execState equals('suspended')%
    <td class="rowdata" style="background-color: #ccf">-suspended-</td>
    <td class="rowdata" style="background-color: #ccf">N/A</td>
    <td class="rowdata" style="background-color: #ccf">
      <a href="javascript:redirectPage('wakeup','%value oid encode(url)%')"
         onclick="return confirm('Activate task %value oid encode(url)%?');">
         Suspended
      </a>
    </td>
  %else%
    <td class="rowdata" style="background-color: #cfc">
      %ifvar target equals('$all')%
        N/A
      %else%
      <table width="100%">
        <tr><td>interval</td><td>%value msDelta decimal(-3,0) encode(html)% seconds<br/></td></tr>
        <tr><td>period</td><td>%value periodToNext%<br/></td></tr>
        <tr><td>local</td><td>%value nextExecTimeLocal%<br/></td></tr>
        <tr><td>period</td><td>%value nextExecTimeUTC%<br/></td></tr>
      </table>
      %endif%
    </td>
    <td class="rowdata">
      <a href="javascript:redirectPage('suspend','%value oid encode(url)%')"
         onclick="return confirm('Suspend task %value oid encode(url)%?');">
        <img src="images/green_check.gif" border="0">
        %ifvar execState equals('running')%
        Running
        %else%
        Active
        %endif%
      </a>
    </td>
  %endif%
<td class="rowdata" style="text-align: center">
  <a class="imagelink"
     href="javascript:redirectPage('cancel','%value oid encode(url)%')"
     onclick="return confirm('Remove task %value oid encode(url)%?');"><img src="icons/delete.gif" border="0">
  </a>
</td>
