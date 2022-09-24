<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <title>Package Exchange</title>
    <script src="webMethods.js"></script>
    <link rel="stylesheet" type="text/css" href="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%  
  </head>

  <body onLoad="setNavigation('package-exchange.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_PublishingPkgsScrn');">
    <table width=100%>
      <tr>
        <td class="breadcrumb" colspan="2"> 
           Packages &gt; Publishing
        </td>
      </tr>

%ifvar action%
%switch action%

%case 'release'%
  %invoke wm.server.replicator:packageRelease%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td class="message" colspan=2>%value message encode(html)%</td></tr>
    %endif%
  %onerror%
    %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
    %endif%
  %endinvoke%

%case 'sendrelease'%
  %invoke wm.server.replicator.adminui:packageSendZip%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td class="message" colspan=2>%value message encode(html)%</td></tr>
    %endif%
  %onerror%
    %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
    %endif%
  %endinvoke%

%case 'add'%
  %invoke wm.server.replicator.adminui:subscriberAdd%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value message encode(html)%</TD></TR>
    %endif%
  %onerror%
    %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
    %endif%
  %endinvoke%

%case 'updateall'%
  %invoke wm.server.replicator:getRefreshedSubscriptions%
  %endinvoke%

%case 'edit'%
  %invoke wm.server.replicator.adminui:subscriberEdit%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value message encode(html)%</TD></TR>
    %endif%
  %onerror%
    %ifvar errorMessage%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
    %endif%
  %endinvoke%

%case%
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td class="message" colspan=2>%value action encode(html)%</td></tr>
%endswitch%

%endif%

    <tr>
      <td colspan=2>
        <ul class="listitems">
		  <script>
		  %rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%
		  createForm("htmlform_package_release_selection", "package-release-selection.dsp", "POST", "BODY");
		  createForm("htmlform_package_add_subscriber", "package-add-subscriber.dsp", "POST", "BODY");
		  createForm("htmlform_package_remove_subscriber", "package-remove-subscriber.dsp", "POST", "BODY");
		  </script>
          <li class="listitem"><script>getURL("package-release-selection.dsp", "javascript:document.htmlform_package_release_selection.submit();", "Create and Delete Releases");</script>
		  </li>
          <li class="listitem"><script>getURL("package-add-subscriber.dsp", "javascript:document.htmlform_package_add_subscriber.submit();", "Add Subscribers");</script>
		  </li>
          <li class="listitem"><script>getURL("package-remove-subscriber.dsp", "javascript:document.htmlform_package_remove_subscriber.submit();", "Update and Remove Subscribers");</script>
		  </li>
        </ul>
      </td>
    </tr>

%invoke wm.server.packages:packageList%
    <tr>
      <td valign=top>
        <table class="tableView" width=100%>
          <tr>
            <td class="heading" colspan=2>Available Releases</td>
          </tr>

          <script>swapRows();</script>
          %invoke wm.server.replicator:getDetailedReleasedList%
          <script>
          var Releases = 0;
          </script>

    %ifvar packages%
      %loop packages%
        %ifvar released%
          <script>writeTDrowspan("rowdata-l",2);</script>%value name encode(html)%</TD>
          <td class="oddrow-l" style="padding: 0px;">

          %ifvar subscribers%
            <table class="tableInline" cellspacing=1 >
              <tr>
                <td class="oddrow">Subscribers:</td>
                <td>
                  <table class="tableInline" cellspacing=1 >
                    %loop subscribers%

                      <tr><td class="oddrow-l">
                  %value encode(html)%
                      </td></tr>
                    %endloop%

                    </tr>
                  </table>
                </td>
              </tr>
            </table>

          %else%
            Subscribers: none
          %endif%
          </td>

        </tr>

        <tr>
          <td style="padding: 0px;">
            <table class="tableInline" width=100% cellspacing=1>

              <tr>
                <script>writeTD("col-l");</script><nobr>Release Name</nobr></TD>
                <script>writeTD("col");</script>Version</TD>
                <script>writeTD("col");</script>Build</TD>
                <script>writeTD("col");</script>Created on</TD>
                <script>writeTD("col");</script><nobr>&nbsp;</nobr></TD>
              </tr>
              <script>swapRows();</script>

            %loop released%
              <tr>
                <script>writeTDrowspan("rowdata-l",2);</script>
                        %value name encode(html)%</td>
                <script>writeTD("rowdata");</script>
                        %value version encode(html)%</TD>
                <script>writeTD("rowdata");</script>
                        %value build encode(html)%</TD>
                <script>writeTD("rowdata");</script>
          %value time encode(html)%
                </td>

                <script>writeTDrowspan("rowdata-r",2);</script>
                %ifvar ../subscribers%
				  <script>
				  createForm("htmlform_package_send_release_select_subscribers_%value name%_%value $index%", "package-send-release-select-subscribers.dsp", "POST", "BODY");
				  setFormProperty("htmlform_package_send_release_select_subscribers_%value name%_%value $index%", "release", "%value name encode(url)%");
				  setFormProperty("htmlform_package_send_release_select_subscribers_%value name%_%value $index%", "package", "%value ../name encode(url)%");
				  </script>
				  <script>getURL("package-send-release-select-subscribers.dsp?release=%value name encode(url)%&package=%value ../name encode(url)%", "javascript:document.htmlform_package_send_release_select_subscribers_%value name%_%value $index%.submit();", "<nobr>Send Release</nobr>");</script>
                  
                %else%
                  <nobr>No subscribers</nobr>
                %endif%
                </td>

                </tr>
                <tr>
                    <script>writeTDspan("rowdata-l",3);</script>
                        %ifvar description equals('')%
                          -
                        %else%
                          <span style="font-weight: normal;">%value description encode(html)%</span>
                        %endif%
                    </td>
                </tr>

            %endloop%
            </table></td></tr>
            <script>swapRows();</script>
            <script>Releases++;</script>
            %endif%
        %endloop%
%endif%

<script>
if (Releases == 0) {
  document.write("<TR><TD class='oddrow-l' colspan=2>No Releases</TD></TR>");
}
</script>

            %endinvoke%
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
