
<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%  
    <style>
      td .file-selection {
        border-top: none;
        border-left: none;
        border-right: none;
        border-bottom: none;
      }
    </style>
    <SCRIPT SRC="webMethods.js"></SCRIPT>
  </HEAD>
  %ifvar release%
    <BODY onLoad="setNavigation('package-exchange.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_CreateRelScrn');">
  %else%
    <BODY onLoad="setNavigation('package-list.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_ArchivePkgsScrn');">
  %endif%
  <SCRIPT LANGUAGE="JavaScript">

  %ifvar release%
    var ReleaseOrArchive = "Release";
  %else%
    var ReleaseOrArchive = "Archive";
  %end if%

  function SelectByID(id) {
    var elmt = document.getElementById(id);
    elmt.click();
  }

    function isIllegalName(name)
    {
      var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"";

        for (var i=0; i<illegalChars.length; i++)
        {
      if (name.indexOf(illegalChars.charAt(i)) >= 0)
        return false;
    }
    return true;

    }

    function isVersionFormatValid(version)
    {
         version = normalize(version);
         var words = new Array();
         words = version.split(".");
         if ( words.length < 2 )
            return false;
         for( var i=0; i<words.length; i++ ) {
           if( isNaN(parseInt(words[i])) )
             return false;
         }
         return true;
    }

    function isJVMFormatValid(jvmver)
    {
      jvmver = normalize(jvmver);
      words = jvmver.split(".");
      if ( words.length < 2 )
        return false;
      for( var i=0; i<words.length; i++ ) {
        if( isNaN(parseInt(words[i])) )
          return false;
      }
      return true;
    }

    function submitForm()
    {
      var name = document.form.name.value;
        var ver = document.form.version.value;
        var build = document.form.build.value;
        var targetver = document.form.target_pkg_version.value;
        var jvm = document.form.jvm_version.value;

      if (( name == null ) || ( name == "" )) {
        %ifvar release%
        alert("Release Name is required");
        %else%
        alert("Archive Name is required");
        %endif%
        return false;
        } else if (( ver == null ) || ( ver == "" )) {
            alert("Version is required");
            return false;
        } else if (( jvm == null ) || ( jvm == "" )) {
          alert("Minimum Version of JVM is required.");
          return false;
      } else if ( document.form.type[1].checked == true && (( targetver == null ) || ( targetver == "" )) ) {
            alert("Version of Target Package is required for releasing a patch");
            return false;
        } else {

          if ( !isIllegalName ( name ) ) {
            %ifvar release%
            alert("Invalid Release Name:\nRefer to Integration Server Administrator's Guide for listed illegal characters");
            %else%
            alert("Invalid Archive Name:\nRefer to Integration Server Administrator's Guide for listed illegal characters");
            %endif%
            return false;
          }

          if( !isVersionFormatValid(ver) ) {
            alert("Invalid Version format (ex: 1.1)");
            return false;
          }

          if ( (!(build == null || build == "" )) && isNaN(parseInt(normalize(build))) ) {
            alert("Invalid Build format (ex: 6)");
            return false;
          }

          if ( document.form.type[1].checked == true ) {
            if ( !isVersionFormatValid(targetver) ) {
              alert("Invalid Target Package Version format (ex: 1.0)");
              return false;
            }
          }

          if ( !isJVMFormatValid(jvm) ) {
            alert("Invalid JVM version (ex: 1.2)");
            return false;
          }

            document.form.submit();
          return false;
        }
    }
  </SCRIPT>

%ifvar release%
    <FORM NAME="form" action="package-exchange.dsp" method="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <INPUT type="hidden" name="action" value="release">
      <INPUT type="hidden" name="release" value="true">
%else%
    <FORM NAME="form" action="package-list.dsp" method="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <INPUT type="hidden" name="action" value="archive">
%end if%
      <INPUT type="hidden" name="package" value="%value package encode(htmlattr)%">
      <TABLE width=100%>
        <TR>
          <TD class="breadcrumb" colspan=2>
%ifvar release%
  Packages &gt;
  Publishing &gt;
  Create Release &gt;
  %value package encode(html)%
%else%
  Packages &gt;
  Management &gt;
  %value package encode(html)% &gt;
  Archive
%end if%
          </TD>
        </TR>
      <TR>
        <TD colspan=2>
          <UL class="listitems">
%ifvar release%
			<script>
			createForm("htmlform_package_release_selection", "package-release-selection.dsp", "POST", "BODY");
			</script>
            <li>
			<script>getURL("package-release-selection.dsp", "javascript:document.htmlform_package_release_selection.submit();", "Return to Create and Delete Releases");</script>
			</li>
%else%
            <script>
			createForm("htmlform_package_list", "package-list.dsp", "POST", "BODY");
			</script>
			<li>
			<script>getURL("package-list.dsp", "javascript:document.htmlform_package_list.submit();", "Return to Package Management");</script>
			</li>
%end if%
          </UL>
        </TD>
      </TR>

        <TR>
          <TD><TABLE class="tableView width50">
              <TR>
                %ifvar release%
                <TD class="heading" colspan=3>Specify Files for the Release
                %else%
                <TD class="heading" colspan=3>Specify Files for the Archive
                %endif%
                </TD>
              </TR>
              <TR>
          <td class="evenrow-l" colspan="3"><label for="file">Files available in %value package encode(html)%:</label></td></tr>
                    <TR class="fullinputwidth">
                      <TD class="evenrow-l" colspan="3" width="100%">
                      %invoke wm.server.replicator:packageFileList%
                        <SELECT name="file" id="file" size="24" multiple width="100%">
                        %loop files%<OPTION value="%value encode(htmlattr)%">%value encode(html)%</OPTION>%endloop%
                        </SELECT>%endinvoke%  </TD>
                    </TR>
      <tr>
              <TD valign=top class="oddrow">Files to Include</td>
              <TD valign=top colspan="2" style="margin: 0; padding: 0; border-collapse: collapse;">
                  <TABLE style="margin: 0; padding: 0; width: 100%; border-collapse: collapse;">
                    <tr><td class="oddrow file-selection" style="text-align: left;">
                      <INPUT type="radio" name="filter" id="filter1" value="includeall" checked onClick="SelectByID('archive-type-full')"><label for="filter1">All files</label></td></tr>
                    <tr><td class="oddrow file-selection" style="text-align: left;">
                        <INPUT type="radio" name="filter" id="filter2" value="include" onClick="SelectByID('archive-type-partial')"><label for="filter2">Selected files</label></td></tr>
                    <tr><td class="oddrow file-selection" style="text-align: left;">
                        <INPUT type="radio" name="filter" id="filter3" value="exclude" onClick="SelectByID('archive-type-partial')"><label for="filter3">All <i>except</i> selected files</label></td></tr>
                    <tr><td class="oddrow file-selection" style="text-align: left;">
                        <INPUT type="radio" name="filter" id="filter4" value="include" onClick="SelectByID('archive-type-partial')"><label for="filter4">Files specified by filter:</label><br>
                        <INPUT name="includepattern">
                    </td></tr>
                    <tr><td class="oddrow file-selection" style="text-align: left;">
                        <INPUT type="radio" name="filter" id="filter5" value="exclude" onClick="SelectByID('archive-type-partial')"><label for="filter5">All <i>except</i> files specified by filter:</label><br>
                        <INPUT name="excludepattern"> <BR>
                        (ex: *.java, *.class)
                    </td></tr>
                  </TABLE>
                </TD>
              </TR>
              <tr>
			    <td valign="top" class="evenrow"><label for="files_to_delete">Files to Delete from Target Package<BR>(For distributing upgrades only)</label>
                </td>
                <td class="evenrow-l" colspan="2">Use ";" to separate multiple file names.<BR>
                <input type="text" style="width:100%;" wrap="off" name="files_to_delete" id="files_to_delete" cols="35"></input>
                </td>
              </tr>

              <TR>
                %ifvar release%
                <TD class="heading" colspan=5>Package Release Information</TD>
                %else%
                <TD class="heading" colspan=5>Package Archive Information</TD>
                %endif%

              </TR>
              <TR>
                %ifvar release%
                    <TD class="oddrow">Release Type</TD>
                %else%
                    <TD class="oddrow">Archive Type</TD>
                %endif%
                <TD class="oddrow-l" colspan="2" nowrap>
                  <INPUT type="radio" id="archive-type-full" name="type" value="full" checked><label for="archive-type-full">Full <font style="font-weight: normal;">(Including all files is recommended)</label></font><br>
                  <INPUT type="radio" id="archive-type-partial" name="type" value="partial"><label for="archive-type-partial">Patch <font style="font-weight: normal;">(For distributing upgrades)</label></font>
                  </TD>
              </TR>
              <TR>
                %ifvar release%
				<TD class="evenrow"><label for="name">Release Name</label></TD>
                %else%
				<TD class="evenrow"><label for="name">Archive Name</label></TD>
                %endif%
                <TD class="evenrow-l"><INPUT name="name" id="name" value="%value package encode(htmlattr)%"></TD>
                <TD class="evenrow" nowrap>(.zip will be appended)</TD>
              </TR>

              <TR>
                <TD class="oddrow"><label for="description">Brief Description</label></TD>
                <TD class="oddrow-l" colspan="2"><INPUT name="description" id="description" value="%value description encode(htmlattr)%"></TD>
              </TR>


              <TR>
                <TD class="evenrow"><label for="version">Version</label></TD>
                <TD class="evenrow-l"><INPUT name="version" id="version" value="%value version encode(htmlattr)%"></TD>
                <TD class="evenrow" nowrap>(current version: %value version encode(html)%)</TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="build">Build Number</label></TD>
                <TD class="oddrow-l"><INPUT name="build" id="build" value="%value build encode(htmlattr)%"></TD>
                <TD class="oddrow" nowrap>
                %ifvar build%
                  (current build: %value build encode(html)%)
                %else%
                  (ex: 6)
                %endif%
                </TD>
              </TR>

              <TR>
                <TD class="evenrow"><label for="patch_nums">Previous Patches Included</label></TD>
                <TD class="evenrow-l"><INPUT name="patch_nums" id="patch_nums" value="%value patch_nums encode(htmlattr)%"></TD>
                <TD class="evenrow" nowrap>
                %ifvar patch_nums%
                  (current patches: %value patch_nums encode(html)%)
                %else%
                  (ex: 4, 5)
                %endif%
                </TD>
              </TR>

              <TR>
                <TD class="heading" colspan=4>Recommendations for Subscriber Install</TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="target_server_version">webMethods Integration Server</label></TD>
                <TD class="oddrow-l"><INPUT name="target_server_version" id="target_server_version" value="%value server_version encode(htmlattr)%"></TD>
                <TD class="oddrow" nowrap>(ex: 10.0)</TD>
              </TR>
              <TR>
                <TD class="evenrow"><label for="jvm_version">Minimum Version of JVM</label></TD>
                <TD class="evenrow-l"><INPUT name="jvm_version" id="jvm_version" value="%value jvm_version encode(htmlattr)%"></td>
                 <TD class="evenrow" nowrap>(ex: 1.8)</TD>
              </TR>

              <TR>
                <TD class="heading" colspan=4>Required Settings for Creating a Patch</TD>
              </TR>


              </TR>
                <TD class="oddrow"><label for="target_pkg_version">Version of Target Package</label></TD>
                <TD class="oddrow-l"><INPUT name="target_pkg_version" id="target_pkg_version" value="%value version encode(htmlattr)%"></TD>
                <TD class="oddrow" nowrap>(ex: 1.0)</TD>
              </TR>

              <TR>
                <TD class="action" colspan="5">
                %ifvar release%
                  <INPUT class="data" type="submit" onclick="return submitForm();" value="Create Release">
                %else%
                  <INPUT class="data" type="submit" onclick="return submitForm();" value="Create Archive">
                %endif%
                  </TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TD>
     </TABLE>
    </FORM>
  </BODY>
</HTML>
