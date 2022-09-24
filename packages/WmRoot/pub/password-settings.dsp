<html>
  <head>
  <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  <title>ServerUI</title>
  <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
  %ifvar webMethods-wM-AdminUI%
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
    <script>webMethods_wM_AdminUI = 'true';</script>
  %endif%
  <SCRIPT SRC="webMethods.js"></SCRIPT>
</head>
%ifvar doc equals('edit')%
	<body onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditPasswordRestrictScrn');">
%else%
	<body onLoad="setNavigation('users.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_PasswordRestrictScrn');">
%endif%
  <table width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">
        Security &gt;
        User Management &gt;
        Password Restrictions %ifvar doc equals('edit')% &gt; Edit %endif%
      </TD>
    </TR>
    <TR>
      <TD colspan=2>
        <UL class="listitems">
          <li class="listitem">
		  <script>
		  createForm("htmlform_users", "users.dsp", "POST", "BODY");
		  createForm("htmlform_password_settings", "password-settings.dsp", "POST", "BODY");
		  </script>
		  <script>getURL("users.dsp","javascript:document.htmlform_users.submit();","Return to User Management");</script></li>

          %ifvar doc equals('edit')%
            <li class="listitem">
			<script>getURL("password-settings.dsp","javascript:document.htmlform_password_settings.submit();","Return to Password Restrictions");</script></li>
          %else%
			<script>
			setFormProperty("htmlform_password_settings", "doc", "edit");
			</script>
            <li class="listitem">
			<script>getURL("password-settings.dsp?doc=edit","javascript:document.htmlform_password_settings.submit();","Edit Password Restrictions");</script></li>
          %endif%

        </UL>
      </TD>
    </TR>

    <TR>
      <TD>
        <TABLE class="%ifvar doc equals('edit')%tableView%else%tableView%endif%">

        %invoke wm.server.query:getPasswordSettings%

        <FORM NAME="password" METHOD="POST" ACTION="users.dsp">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <INPUT TYPE="hidden" NAME="action" VALUE="editPassword">

          <TR>
            <TD class="heading" colspan=2>Password Restrictions</TD>
          </TR>
          <TR>
            <TD class="oddrow">Enable Password Change</TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              %ifvar ../doc equals('edit')%
                %ifvar watt.server.enablePasswordChange equals('true')%
                  <INPUT type="radio" id="yes" name="watt.server.enablePasswordChange" value="true" CHECKED ><label for="yes"> Yes</label></INPUT><BR>
                  <INPUT type="radio" id="no" name="watt.server.enablePasswordChange" value="false" ><label for="no"> No</label></INPUT><BR>
                %else%
                  <INPUT type="radio" id="yes" name="watt.server.enablePasswordChange" value="true" ><label for="yes"> Yes</label></INPUT><BR>
                  <INPUT type="radio" id="no" name="watt.server.enablePasswordChange" value="false" CHECKED ><label for="no"> No</label></INPUT>
                %endif%
              %else%
                %ifvar watt.server.enablePasswordChange equals('true')%
                  Yes
                %else%
                  No
                %endif%
              %endif%
            </TD>
          </TR>
		  <TR>
           <TD class="oddrow">Password Enforcement Mode</TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              %ifvar ../doc equals('edit')%
                %ifvar watt.server.password.mode equals('lax')%
                  <INPUT type="radio" name="watt.server.password.mode" id="enable1" value="lax" CHECKED /> <label for="enable1">Lax</label></INPUT><BR>
                  <INPUT type="radio" name="watt.server.password.mode" id="enable2" value="strict" /><label for="enable2"> Strict</label></INPUT><BR>
                %else%
                  <INPUT type="radio" name="watt.server.password.mode" id="enable1" value="lax" /><label for="enable1"> Lax</label></INPUT><BR>
                  <INPUT type="radio" name="watt.server.password.mode" id="enable2" value="strict" CHECKED /> <label for="enable2">Strict</label></INPUT><BR>
                %endif%
              %else%
                %ifvar watt.server.password.mode equals('lax')%
                  Lax
                %else%
                  Strict
                %endif%
              %endif%
            </TD>
          </TR>
          <!-- Minimum Password Length -->

          <TR><TD class="evenrow"><label for="minlen">Minimum Password Length</label></TD>
            <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
              <script>writeEdit("%value ../doc encode(javascript)%", "watt.server.password.minLength", "%value watt.server.password.minLength encode(html_javascript)%",'minlen');</script>
            </TD>
          </TR>

		  <TR><TD class="evenrow"><label for="maxlen">Maximum Password Length</label></TD>
            <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
              <script>writeEdit("%value ../doc encode(javascript)%", "watt.server.password.maxLength", "%value watt.server.password.maxLength encode(html_javascript)%",'maxlen');</script>
            </TD>
          </TR>
		  
          <!-- Minimum Number of Upper Case Characters -->
          <TR><TD class="oddrow"><label for="minupper">Minimum Number of Uppercase Characters</label></TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              <script>writeEdit("%value ../doc encode(javascript)%", "watt.server.password.minUpperChars", "%value watt.server.password.minUpperChars encode(html_javascript)%",'minupper');</script>
            </TD>
          </TR>

          <!-- Minimum Number of Lower Case Characters -->
    <TR><TD class="evenrow"><label for="minlower">Minimum Number of Lowercase Characters</label></TD>
      <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
        <script>writeEdit("%value ../doc encode(javascript)%", "watt.server.password.minLowerChars", "%value watt.server.password.minLowerChars encode(html_javascript)%",'minlower');</script>
      </TD>
          </TR>

          <!-- Minimum Number of Digits -->
          <TR><TD class="oddrow"><label for="mindigits">Minimum Number of Digits</label></TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              <script>writeEdit("%value ../doc encode(javascript)%", "watt.server.password.minDigits", "%value watt.server.password.minDigits encode(html_javascript)%",'mindigits');</script>
            </TD>
          </TR>

          <!-- Minimum Number of Special Characters -->
          <TR><TD class="evenrow"><label for="specialchars">Minimum Number of Special Characters<br>(neither alphabetic nor digits)</label></TD>
            <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
              <script>writeEdit("%value ../doc encode(javascript)%", "watt.server.password.minSpecialChars", "%value watt.server.password.minSpecialChars encode(html_javascript)%",'specialchars');</script>
            </TD>
          </TR>

		  <TR><TD class="evenrow"><label for="maxIdenticalChars">Maximum Number of Identical Characters in a Row</label></TD>
            <TD class="%ifvar ../doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
              <script>writeEdit("%value ../doc encode(javascript)%", "watt.server.password.maxIdenticalCharsInARow", "%value watt.server.password.maxIdenticalCharsInARow encode(html_javascript)%",'maxIdenticalChars');</script>
            </TD>
          </TR>
		  

		  <TR><TD class="evenrow"><label for="numOldPassword">Number of Old Passwords to Remember<br>(per user)</label></TD>
            <TD class="%ifvar ../doc equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
              <script>writeEdit("%value ../doc encode(javascript)%", "watt.server.password.historyLength", "%value watt.server.password.historyLength encode(html_javascript)%",'numOldPassword');</script>
            </TD>
          </TR>
          %ifvar ../doc equals('edit')%
          <TR>
            <TD class="action" colspan=2>
            <INPUT class="button2" type="submit" onclick="return verifyEntries();" value="Save Password Settings">
            </TD>
          </TR>
          %endif%
        </FORM>

<script>
function verifyEntries()
{
	if(!verifyRequiredNonNegNumber("password", "watt.server.password.minLength")) {
		alert("The value specified for \"Minimum Password Length\" must be an integer greater than or equal to 1 and less than the value specified for \"Maximum Password Length\".");
		return false;
	}
	
	if(!verifyRequiredNonNegNumber("password", "watt.server.password.maxLength")) {
		alert("The value specified for \"Maximum Password Length\" must be an integer between 1 and 128.");
		return false;
	}
	
	var minLen = document.forms["password"]["watt.server.password.minLength"].value;
	var maxLen = document.forms["password"]["watt.server.password.maxLength"].value;
	if(Number(minLen) < 1) {
		alert("The value specified for \"Minimum Password Length\" must be an integer greater than or equal to 1 and less than the value specified for \"Maximum Password Length\".");
		return false;
	}
	if(Number(maxLen) < 1) {
		alert("The value specified for \"Maximum Password Length\" must be an integer between 1 and 128.");
		return false;
	}

	if(Number(maxLen) > 128) {
		alert("The value specified for \"Maximum Password Length\" must be an integer between 1 and 128.");
		return false;
	}
	
	if(Number(minLen) > Number(maxLen)) {
		alert("The value specified for \"Minimum Password Length\" must be less than or equal to the value specified for \"Maximum Password Length\".");
		return false;
	}
	
	if(!verifyFieldValue("watt.server.password.minUpperChars", "Minimum Number of Upper Case Characters", 0, maxLen)) {
		return false;
	}
	
	if(!verifyFieldValue("watt.server.password.minLowerChars", "Minimum Number of Lower Case Characters", 0, maxLen)) {
		return false;
	}
	
	if(!verifyFieldValue("watt.server.password.minDigits", "Minimum Number of Digits", 0, maxLen)) {
		return false;
	}
	
	if(!verifyFieldValue("watt.server.password.minSpecialChars", "Minimum Number of Special Characters", 0, maxLen)) {
		return false;
	}
	
	var a = document.forms["password"]["watt.server.password.minUpperChars"].value;
	var b = document.forms["password"]["watt.server.password.minLowerChars"].value;
	var c = document.forms["password"]["watt.server.password.minDigits"].value;
	var d = document.forms["password"]["watt.server.password.minSpecialChars"].value;
	var sum = Number(a) + Number(b) + Number(c) + Number(d);
	if(Number(sum) > maxLen) {
		alert("Sum of \"Minimum Number of Uppercase Characters\", \"Minimum Number of Lowercase Characters\", \"Minimum Number of Digits\" and \"Minimum Number of Special Characters\" must be less than or equal to \"Maximum Password Length\".");
		return false;
	}
	
	if(!verifyFieldValue("watt.server.password.maxIdenticalCharsInARow", "Maximum Number of Identical Characters in a Row", 0, maxLen)) {
		return false;
	}

	
	if(!verifyRequiredNonNegNumber("password", "watt.server.password.historyLength")) {
		alert("The value specified for \"Number of Old Passwords to Remember\" must be an integer between 0 and 12.");
		return false;
	} else {
		var historyLen = document.forms["password"]["watt.server.password.historyLength"].value;
		if(Number(historyLen) < 0 || Number(historyLen) > 12) {
			alert("The value specified for \"Number of Old Passwords to Remember\" must be an integer between 0 and 12.");
			return false;
		}
	}

  return true;
}

function verifyFieldValue(fieldName, fieldText, fieldMinValue, maxLen) {
	if(!verifyRequiredNonNegNumber("password", fieldName)) {
		alert("The value specified for \""+fieldText+"\" must be an integer greater than or equal to "+fieldMinValue+" and less than the value specified for \"Maximum Password Length\".");
		return false;
	} else {
		var fieldValue = document.forms["password"][fieldName].value;
		if(Number(fieldValue) > Number(maxLen) || Number(fieldValue) < fieldMinValue) {
			alert("The value specified for \""+fieldText+"\" must be an integer greater than or equal to "+fieldMinValue+" and less than the value specified for \"Maximum Password Length\".");
			return false;
		}
	}
	
	return true;
}
</script>

</table>
</td></tr></table>
</body>
</html>
