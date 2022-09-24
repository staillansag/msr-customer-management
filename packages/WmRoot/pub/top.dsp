<html>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="top.css">
    <link rel="stylesheet" type="text/css" href="webMethods.css">
    <script src="csrf-guard.js"></script>

</head>



<body class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">

<script>
    function launchHelp() {
        var url="";
        if (parent.menu != null) {
            var helpURLFromPage = parent.menu.document.forms["urlsaver"].helpURL.value;
            var helptopic = helpURLFromPage.lastIndexOf("=");
            var topic = helpURLFromPage.substring(helptopic + 1);

            var def = helpURLFromPage.substring(0, helpURLFromPage.lastIndexOf("/"));

            %invoke wm.server.admin:getHelpTopicUrlMappings%
                %ifvar result%
                    switch (topic) {
                        %loop result%case "%value id%": url = "%value url%"; break;
                    %endloop%
                     default: url = def;
                }
                %endif%
            %endinvoke%
            window.open(url, 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
            }
        }
	function launchAdmin() {
        var hostUrl=window.location.origin;
		var url = hostUrl + "/WmAdmin/#/reuseAuth";
		console.log("url",url)
			window.open(url);
        }

    function logIEout() {
      if (confirm("OK to log off?")) {
        return true;
      }
      else {
        return false;
      }
    }

    function loadPage(url) {

      if (is_csrf_guard_enabled && needToInsertToken) {
		createForm("htmlForm_url", url, "POST", "BODY");
		setFormProperty("htmlForm_url", _csrfTokenNm_, _csrfTokenVal_);
        document.htmlForm_url.submit();
      } else {
		window.location.replace(url);
	  }

    }

    function switchToQuiesceMode(mode) {
      var link = document.getElementById("Qlink");
      var delayTime = -1;
      if (mode == "false" || mode == false) {
        delayTime = prompt("OK to enter quiesce mode?\nSpecify the maximum number of minutes to wait before disabling packages:",0);
        if (delayTime == null) {
          return false;
        }
        else {
          if (((parseFloat(delayTime) == parseInt(delayTime)) && !isNaN(delayTime)) && parseInt(delayTime) >= 0) {

			if (is_csrf_guard_enabled && needToInsertToken) {
				createFormWithTarget("htmlform_quiesce_report_switch_function", "quiesce-report.dsp", "POST", "BODY", "body");
				setFormProperty("htmlform_quiesce_report_switch_function", "isQuiesceMode", "true");
				setFormProperty("htmlform_quiesce_report_switch_function", "timeout", delayTime);
				setFormProperty("htmlform_quiesce_report_switch_function", _csrfTokenNm_, _csrfTokenVal_);

				link.href = "javascript:document.htmlform_quiesce_report_switch_function.submit();";
			} else {
				link.href = "quiesce-report.dsp?isQuiesceMode=true&timeout=" + delayTime;
			}
            return true;
          }
          else {
            alert("Enter positive integer value.");
            return false;
          }
        }
      }
      if (mode == "true" || mode == true) {
        if (confirm("OK to exit quiesce mode?")) {
			if (is_csrf_guard_enabled && needToInsertToken) {
			  createFormWithTarget("htmlform_quiesce_report_false", "quiesce-report.dsp", "POST", "BODY", "body");
			  setFormProperty("htmlform_quiesce_report_false", "isQuiesceMode", "false");
			  setFormProperty("htmlform_quiesce_report_false", _csrfTokenNm_, _csrfTokenVal_);

			  link.href = "javascript:document.htmlform_quiesce_report_false.submit();";
		  } else {
			link.href = "quiesce-report.dsp?isQuiesceMode=false";
		  }
          return true;
        }
        else {
          return false;
        }
      }
      return false;
    }

    function displayMode(mode) {
      var temp = document.getElementById("quiesceModeMessage");
      if (temp == null || temp == undefined)
        return;

      if (mode == "true" || mode == true) {
        if (temp.innerHTML == '' || temp.innerHTML == '&nbsp;'){
          temp.style.display = "inline-block";
          temp.innerHTML = "<span class=\"Centerer\"></span><span class=\"Centered\">Integration Server is running in quiesce mode.</span>";
        }
      }
    }

    function checkRestart(restart) {
      var temp = document.getElementById("restartMessage");
      if (temp == null || temp == undefined)
        return;

      if (restart == "true" || restart == true) {
        if (temp.innerHTML == '' || temp.innerHTML == '&nbsp;'){
          temp.style.display = "inline-block";

		  if (is_csrf_guard_enabled && needToInsertToken) {
			  temp.innerHTML = "<span class=\"Centerer\"></span><span><a target=\"body\" href=\"javascript:void(0);\" onclick=\"document.htmlform_server_shutdown.submit();\" class=\"Centered\">Restart is required for changes to take effect.</a><span>";
		  } else {
			  temp.innerHTML = "<span class=\"Centerer\"></span><span><a target=\"body\" href=\"server-shutdown.dsp\" class=\"Centered\">Restart is required for changes to take effect.</a></span>";
		  }

        }
      }
    }
	function checkMTAFailure(MTAFailureInput,failureReason) {
      var temp = document.getElementById("MTAFailure");
      if (temp == null || temp == undefined)
        return;
      if (MTAFailureInput == "true" || MTAFailureInput == true) {
        if (temp.innerHTML == '' || temp.innerHTML == '&nbsp;'){
          temp.style.display = "inline-block";

		  if (is_csrf_guard_enabled && needToInsertToken) {
			  temp.innerHTML = "<span class=\"Centerer\"></span><span><a target=\"body\" href=\"log-error-recent.dsp\" class=\"Centered\">"+failureReason+"</a><span>";
		  } else {
			  temp.innerHTML = "<span class=\"Centerer\"></span><span><a target=\"body\" href=\"log-error-recent.dsp\" class=\"Centered\">"+failureReason+"</a></span>";
		  }

        }
      }
    }
	function restartRedirect() {
        document.htmlform_server_shutdown.submit();
	}

    function displayMessage(mode, message) {
      var temp = document.getElementById("quiesceModeMessage");
      if (temp == null || temp == undefined)
        return;
      if (mode == "true" || mode == true) {
        temp.style.display = "inline-block";
        temp.innerHTML = "<span class=\"Centerer\"></span><span class=\"Centered\">"+message+"</span>";
      }
      else {
        temp.innerHTML = "";
        temp.style.display = "none";
      }
    }

    %ifvar message%
      %ifvar norefresh%
      %else%
        setTimeout("loadPage('top.dsp')", 30000);
      %endif%
    %endif%
  </script>


  
<table border=0 cellspacing=0 cellpadding=0 width="100%">
    <tr>
        <td class="tdmasthead">
            <table width="100%" cellspacing=0 cellpadding=0 border=0>
                <tr>
                    %invoke wm.server.query:getServerInstanceName%

                    <td class="saglogo">
                        %ifvar productname equals('Microservices Runtime')%
                        <img src="images/msc_logo.png" /><br/>
                        %else%
                        <img src="images/is_logo.png" /><br/>
                        %endif%
                    </td>

                    <td width="100%">
                        <table width="100%">
                            <tr class="toptittlerow">
                                <td class="toptitle" width="30%">
                                    %ifvar instancename%
                                    %value instancename encode(html)% ::
                                    %endif%
                                    %value $host%
                                    %invoke wm.server.query:getCurrentUser%
                                    %ifvar username%
                                    :: %value  username%
                                    %endif%
                                    %endinvoke%
                                </td>

                                %endinvoke%

                                <td width="20%" class="toptittlerow"><div class="keymessage"  id="quiesceModeMessage" name="quiesceModeMessage" style="display: none"></div></td>

                                <td width="20%" class="toptittlerow"><div class="keymessage"  id="restartMessage" name="restartMessage" style="display: none"></div></td>

								<td width="20%" class="toptittlerow"><div class="keymessage"  id="MTAFailure" name="MTAFailure" style="display: none"></div></td>
								
                                %ifvar adapter%
                                %else%
                                %invoke wm.server.query:isSafeMode%
                                %ifvar isSafeMode equals('true')%
                                %ifvar isSane equals('true')%
                                <td width="20%" class="toptittlerow"><div class="keymessage">
                                    <span class="Centerer"></span><span class="Centered">
                          SERVER IS RUNNING IN SAFE MODE.<br/>Master password sanity check failed - invalid master password provided.
                        </span>
                                </div>
                                </td>
                                %else%
                                <td width="20%" class="toptittlerow" ><div class="keymessage">
                                    <span class="Centerer"></span><span class="Centered">
                          SERVER IS RUNNING IN SAFE MODE
                        </span>
                                </div>
                                </td>
                                %endif%
                                %endif%
                                %endinvoke%

                                %invoke wm.server.query:getLicenseSettings%
                                <script>
				createFormWithTarget("htmlform_settings_license_edit", "settings-license-edit.dsp", "POST", "BODY", "body");
				</script>
                                %ifvar keyExpired%
                                <td width="20%" id="test" class="toptittlerow"><div class="keymessage">
                                    <span class="Centerer"></span><span class="Centered">

						<script>
							if(is_csrf_guard_enabled && needToInsertToken) {
								document.write('<a href="javascript:document.htmlform_settings_license_edit.submit();">License Key is Expired or Invalid.</a>');
							} else {
								document.write('<a href="settings-license-edit.dsp" target="body">License Key is Expired or Invalid.</a>');
							}
						</script>

                      </span>
                                </div>
                                </td>
                                %else%
                                %ifvar keyExpiresIn%
                                <td width="20%" class="toptittlerow" ><div class="keymessage">
                                    <span class="Centerer"></span><span class="Centered">

						  <script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<a href="javascript:document.htmlform_settings_license_edit.submit();"> %ifvar keyExpiresIn equals('0')% License Key expires today. %else% License Key expires in <br/>about %value keyExpiresIn encode(html)% days %endif% </a>');
								} else {
									document.write('<a href="settings-license-edit.dsp" target="body">%ifvar keyExpiresIn equals(\'0\')%License Key expires today. %else%       License Key expires in <br/>about %value keyExpiresIn encode(html)% days  %endif% </a>');
								}
							</script>


                        </span>
                                </div>
                                </td>
                                %endif%
                                %endif%
                                %endinvoke%
                                %endif%
                            </tr>
                        </table>
                    </td>

                    <script>
	    createForm("htmlform_thisform", "top.dsp", "POST", "BODY");
	    </script>
				<td nowrap class="topmenu" width="25%">
		
		
						<script>
						if(is_csrf_guard_enabled && needToInsertToken) {//launch new Admin UI 
							document.write('<a target=\'body\' onclick="launchAdmin();return false;" href=\'#\'><div style="display:inline-block;background-color:#3498DB;padding:0.5rem; " >Try the New Administration Console </div></a>');
						} else {
							document.write('<a target=\'body\' onclick="launchAdmin();return false;" href=\'#\'><div style="display:inline-block;background-color:#3498DB;padding:0.5rem; " >Try the New Administration Console </div></a>');
						}
						</script>
						
		</td>

                    <td nowrap class="topmenu" width="25%">

                        %ifvar adapter%
                        <a href='javascript:window.parent.close();'>Close Window</a>
                        %ifvar adapter equals('SAP')%
                        <script>
			  createForm("htmlform_SAP_sapAbout_aboutPage", "/SAP/sapAbout_aboutPage.dsp", "POST", "body");
			  </script>
                        | <script>getURL("/SAP/sapAbout_aboutPage.dsp", "javascript:document.htmlform_SAP_sapAbout_aboutPage.submit();", "About");</script>

                        %endif%
                        %invoke wm.server.Doc:hasOnlineHelp%
                        %ifvar hasHelp equals('true')%
                        |  <a target='body' onclick="launchHelp();return false;" href='#'>Help</a>&nbsp;
                        %endif%
                        %endinvoke%
                        %else%

                        %invoke wm.server.quiesce:getCurrentMode%
                        <script>
			  createFormWithTarget("htmlform_quiesce_report", "quiesce-report.dsp", "POST", "BODY", "body");
			  </script>
                        %ifvar isQuiesceMode equals('true')%
                        <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_quiesce_report.submit();" onclick="return switchToQuiesceMode(\'%value isQuiesceMode encode(javascript)%\');" id="Qlink">Exit Quiesce Mode</a>');
						} else {
							document.write('<a target="body" href="quiesce-report.dsp" onclick="return switchToQuiesceMode(\'%value isQuiesceMode encode(javascript)%\');" id="Qlink">Exit Quiesce Mode</a>');
						}
					</script>

                        %else%
                        <script>
						if(is_csrf_guard_enabled && needToInsertToken) {
							document.write('<a href="javascript:document.htmlform_quiesce_report.submit();" onclick="return switchToQuiesceMode(\'%value isQuiesceMode encode(javascript)%\');" id="Qlink">Enter Quiesce Mode</a>');
                        					} else {
							document.write('<a target="body" href="quiesce-report.dsp" onclick="return switchToQuiesceMode(\'%value isQuiesceMode encode(javascript)%\');" id="Qlink">Enter Quiesce Mode</a>');
                        					}
					</script>

                        %endif%
                        <script>displayMode("%value isQuiesceMode encode(javascript)%");</script>
                        |
                        %endinvoke%

                        %invoke wm.server.admin:isRestartNeeded%
                        <script>checkRestart("%value restartNeeded encode(javascript)%");</script>
                        %endinvoke%
						
						%invoke wm.server.admin:getMTAStatus%
                        <script>checkMTAFailure("%value MTAFailure encode(javascript)%","%value message encode(javascript)%");</script>
                        %endinvoke%

                        <script>
			  createFormWithTarget("htmlform_server_shutdown", "server-shutdown.dsp", "POST", "BODY", "body");

			  %ifvar css%
			  setFormProperty("htmlform_server_shutdown", "css", "%value css encode(url)%");
			  %endif%
			  createFormWithTarget("htmlform_top_logoff", "top-logoff.dsp", "POST", "BODY", '_top');
			  createFormWithTarget("htmlform_server_environment", "server-environment.dsp", "POST", "BODY", "body");
			  </script>
                        <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_server_shutdown.submit();">Shut Down and Restart</a>');
					} else {
						document.write('<a target=\'body\' href=\'server-shutdown.dsp%ifvar css%?css=%value css encode(url)%%endif%\'>Shut Down and Restart</a>');
					}
				</script>

                        |
                        <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_top_logoff.submit();" onclick="return logIEout();" >Log Off</a>');
					} else {
						document.write('<a target=\'_top\' href=\'top-logoff.dsp\' onclick="return logIEout();" >Log Off</a>');
					}
				</script>

                        |
                        <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a href="javascript:document.htmlform_server_environment.submit();">About</a>');
					} else {
						document.write('<a target=\'body\' href=\'server-environment.dsp\'>About</a>');
					}
				</script>

                        |
                        <script>
					if(is_csrf_guard_enabled && needToInsertToken) {
						document.write('<a target=\'body\' onclick="launchHelp();return false;" href=\'javascript:document.htmlform_thisform.submit();\'>Help</a>');
					} else {
						document.write('<a target=\'body\' onclick="launchHelp();return false;" href=\'#\'>Help</a>');
					}
				</script>
                        &nbsp;
                        %endif%
                    </td>
                </tr>
            </table>
        </td>
    </tr>


</table>
</body>
</html>
