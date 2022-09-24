<TR>
  <TD colspan="2" class="heading">Web Service Endpoint Alias Properties</TD>
</TR>

<TR>
  <TD class="oddrow" width="30%"><B><label for="alias">Alias</label></B></TD>
  <TD class="oddrow-l" width="70%">
    %ifvar ../../action equals('view')%
			<B>%value alias encode(html)%</B>
    %else%
      <INPUT TYPE="hidden" NAME="dummyEmptyValue" VALUE="" />
      %ifvar ../../action equals('edit')%
				<INPUT name="alias" id="alias" type="hidden" VALUE="%value alias encode(htmlattr)%" style="width:40%">
				<B>%value alias encode(html)%</B>
      %else%
				<INPUT name="alias" id="alias" VALUE="%value alias encode(htmlattr)%" style="width:40%">
      %endif%
    %endif%
  </TD>
</TR>

<TR>
  <TD class="evenrow"><label for="description">Description</label></TD>
  <TD class="evenrow-l">
    %ifvar ../../action equals('view')%
			%value description encode(html)%
    %else%
			<INPUT name="description" id="description" VALUE="%value description encode(htmlattr)%" style="width:100%">
    %endif%
  </TD>
</TR>

<TR>
  <TD class="oddrow">Type</TD>
  <TD class="oddrow-l">
    %ifvar ../../action equals('view')%
      %ifvar ../type equals('provider')% Provider %else% %ifvar ../type equals('addressing')% Message Addressing %else% Consumer %endif% %endif%
    %else%
      %ifvar ../../action equals('edit')%
				<INPUT name="type" type="hidden" VALUE="%value ../type encode(htmlattr)%">
        %ifvar ../type equals('provider')% Provider %else% %ifvar ../type equals('addressing')% Message Addressing %else% Consumer %endif% %endif%
      %else%
        <INPUT TYPE="radio" NAME="wsetype" ID="wsetype1" VALUE="provider" checked onclick="toggleProperties('wsetype')"><label for="wsetype1">Provider</label></INPUT>
        <INPUT TYPE="radio" NAME="wsetype" ID="wsetype2" VALUE="consumer" onclick="toggleProperties('wsetype')"><label for="wsetype2">Consumer</label></INPUT>
        <INPUT TYPE="radio" NAME="wsetype" ID="wsetype3" VALUE="addressing" onclick="toggleProperties('wsetype')"><label for="wsetype3">Message Addressing</label></INPUT>
      %endif%
    %endif%
  </TD>
</TR>


<TR>
  <TD class="evenrow">Transport Type</TD>
  <TD class="evenrow-l">
    %ifvar ../../action equals('view')%
			%value  transportInfo/transportType encode(html)%
    %else%
      %ifvar ../../action equals('edit')%
				<INPUT name="transportType" type="hidden" VALUE="%value transportInfo/transportType encode(htmlattr)%">
				%value transportInfo/transportType encode(html)%
      %else%
        <INPUT TYPE="radio" NAME="transType" ID="transTypeHTTP" VALUE="HTTP" checked onclick="toggleProperties('transType')"><label for="transTypeHTTP">HTTP</label></INPUT>
        <INPUT TYPE="radio" NAME="transType" ID="transTypeHTTPS" VALUE="HTTPS" onclick="toggleProperties('transType')"><label for="transTypeHTTPS">HTTPS</label></INPUT>
        <INPUT TYPE="radio" NAME="transType" ID="transTypeJMS" VALUE="JMS" onclick="toggleProperties('transType')"><label for="transTypeJMS">JMS</label></INPUT>
      %endif%
    %endif%
  </TD>
</TR>
