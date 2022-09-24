
<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server Settings</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
  </HEAD>
  %ifvar doc equals('edit')%
  <BODY onLoad="setNavigation('settings-repository.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditRepositoryScrn');">
  %else%
  <BODY onLoad="setNavigation('settings-repository.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_RepositoryScrn');">
  %endif%

    %ifvar doc equals('edit')%
      <FORM NAME="repository" METHOD="POST" ACTION="settings-repository.dsp">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <INPUT TYPE="hidden" NAME="action" VALUE="change">
      %ifvar mode%
        <input type="hidden" name="mode" value="%value mode encode(htmlattr)%">
      %else%
        <input type="hidden" name="mode" value="standalone">
      %endif%
      %ifvar fsdata.blockDevice%
        <input type="hidden" name="fsdata.blockDevice" value="%value fsdata.blockDevice encode(htmlattr)%">
      %else%
        <input type="hidden" name="fsdata.blockDevice" value="RAF">
      %endif%
    %endif%

    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Settings &gt;
          Repository
          %ifvar doc equals('edit')% &gt; Edit %endif%
      </TR>

      %ifvar action equals('change')%
        %invoke wm.server.admin:setRepoSettings%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message encode(html) empty='Settings Saved'%</TD></TR>
        %endinvoke%
          %ifvar message2%
             <TR><TD class="message" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message2 encode(html)%</TD></TR>
          %endif%
      %endif%

    %invoke wm.server.query:getRepoSettings%
      <TR>
        <TD colspan=2>
          <ul class="listitems">
%ifvar doc equals('edit')%
			<script>
			createForm("htmlform_settings_repository_return", "settings-repository.dsp", "POST", "BODY");
			</script>
            <li class="listitem"><a href="javascript:document.htmlform_settings_repository_return.submit();">Return to Repository Settings</a></li>
            %ifvar mode equals('standalone')%
				<script>
				createForm("htmlform_settings_repository_remote_repo", "settings-repository.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_repository_remote_repo", "doc", "edit");
				setFormProperty("htmlform_settings_repository_remote_repo", "mode", "shareoutproc");
				%ifvar fsdata.blockDevice -isnull%
				setFormProperty("htmlform_settings_repository_remote_repo", "fsdata.blockDevice", "RAF");
				%else%
				setFormProperty("htmlform_settings_repository_remote_repo", "fsdata.blockDevice", "%value fsdata.blockDevice encode(url)%");
				%endif%
				setFormProperty("htmlform_settings_repository_remote_repo", "action", "update");
				</script>
               <li class="listitem"><a href="javascript:document.htmlform_settings_repository_remote_repo.submit();">Change to Remote Repository Server</a></li>
            %ifvar fsdata.blockDevice equals('RAF')%
				<script>
				createForm("htmlform_settings_repository_persistent_db", "settings-repository.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_repository_persistent_db", "doc", "edit");
				setFormProperty("htmlform_settings_repository_persistent_db", "mode", "standalone");				
				setFormProperty("htmlform_settings_repository_persistent_db", "fsdata.blockDevice", "JDBC");
				setFormProperty("htmlform_settings_repository_persistent_db", "action", "update");
				</script>
               <li class="listitem"><a href="javascript:document.htmlform_settings_repository_persistent_db.submit();">Change Persistent Store to Database</a></li>
            %else%
				<script>
				createForm("htmlform_settings_repository_persistent_fs", "settings-repository.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_repository_persistent_fs", "doc", "edit");
				setFormProperty("htmlform_settings_repository_persistent_fs", "mode", "standalone");				
				setFormProperty("htmlform_settings_repository_persistent_fs", "fsdata.blockDevice", "RAF");
				setFormProperty("htmlform_settings_repository_persistent_fs", "action", "update");
				</script>
               <li class="listitem"><a href="javascript:document.htmlform_settings_repository_persistent_fs.submit();">Change Persisent Store to Filesystem</a></li>
            %endif%
            %else%
				<script>
				createForm("htmlform_settings_repository_persistent_change_local_repo", "settings-repository.dsp", "POST", "BODY");
				setFormProperty("htmlform_settings_repository_persistent_change_local_repo", "doc", "edit");
				setFormProperty("htmlform_settings_repository_persistent_change_local_repo", "mode", "standalone");				
				%ifvar fsdata.blockDevice -isnull%
				setFormProperty("htmlform_settings_repository_persistent_change_local_repo", "fsdata.blockDevice", "RAF");
				%else%
				setFormProperty("htmlform_settings_repository_persistent_change_local_repo", "fsdata.blockDevice", "%value fsdata.blockDevice encode(url)%");
				%endif%setFormProperty("htmlform_settings_repository_persistent_change_local_repo", "action", "update");
				</script>
               <li class="listitem"><a href="javascript:document.htmlform_settings_repository_persistent_change_local_repo.submit();">Change to Local Repository</a></li>
            %endif%
%else%
			<script>
			createForm("htmlform_settings_repository_doc_edit", "settings-repository.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_repository_doc_edit", "doc", "edit");
			</script>
            <li class="listitem"><a href="javascript:document.htmlform_settings_repository_doc_edit.submit();">Edit Repository Settings</a></li>
%endif%
          </UL>
        </TD>
      </TR>

      <TR>
        <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
        <TD>
          <TABLE class="%ifvar doc equals('edit')%tableView%else%tableView%endif%">
            <TR>
            %ifvar mode equals('standalone')%
              <TD colspan=2 class="heading">Local Repository Configuration</TD>
              </TR>
        <tr><td class="space" colspan="3">&nbsp;</td></tr>
              <TR>
                  %ifvar fsdata.blockDevice equals('RAF')%
                     <TD colspan=2 class="heading">Filesystem physical store</TD>
                  %else%
                     <TD colspan=2 class="heading">Database physical store</TD>
                  %endif%
                </TD>
              </TR>
              %ifvar fsdata.blockDevice equals('RAF')%
              <TR>
                <TD class="oddrow"><label for="localdata">Local Data Directory Name</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.dbGroup", "%value fsdata.dbGroup encode(html_javascript)%",'localdata');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="localLog">Local Log Directory Name</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.logGroup", "%value fsdata.logGroup encode(html_javascript)%",'localLog');</script>
                </TD>
              </TR>
              %endif%
              <TR>
                <TD class="oddrow"><label for="prefix">Local Data Filename Prefix</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.dbName", "%value fsdata.dbName encode(html_javascript)%",'prefix');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="errorlog">Repository Error Log Filename</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "logfile", "%value logfile encode(html_javascript)%",'errorlog');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="maxdata">Max Data Extents</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.dataMaxExtents", "%value  fsdata.dataMaxExtents encode(html_javascript)%",'maxdata');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="datathreshold">Data Threshold</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.dataThreshold", "%value  fsdata.dataThreshold encode(html_javascript)%",'datathreshold');</script>%
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="indexMaxExtents">Max Index Extents</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.indexMaxExtents", "%value  fsdata.indexMaxExtents encode(html_javascript)%",'indexMaxExtents');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="indexThreshold">Index Threshold</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.indexThreshold", "%value  fsdata.indexThreshold encode(html_javascript)%",'indexThreshold');</script>%
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="dbSize">Data File Size</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.dbSize", "%value  fsdata.dbSize encode(html_javascript)%",'dbSize');</script>MB
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="logSize">Log File Size</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.logSize", "%value  fsdata.logSize encode(html_javascript)%",'logSize');</script>MB
                </TD>
              </TR>
              %ifvar fsdata.blockDevice equals('JDBC')%
        <tr><td class="space" colspan="3">&nbsp;</td></tr>
              <TR>
                <TD colspan=2 class="heading">Database Settings</TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="jdbcdriver">JDBC Driver</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.jdbcdriver", "%value  fsdata.jdbc.jdbcdriver encode(html_javascript)%",'jdbcdriver');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="dburl">JDBC Database URL</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.dburl", "%value  fsdata.jdbc.dburl encode(html_javascript)%",'dburl');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="user">Database Userid</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.user", "%value  fsdata.jdbc.user encode(html_javascript)%",'user');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="password">Database Password</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEditPass("%value ../doc encode(javascript)%", "fsdata.jdbc.password", "%value  fsdata.jdbc.password encode(html_javascript)%",'password');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="sweeperInterval">Sweeper Interval</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.sweeperInterval", "%value  fsdata.jdbc.sweeperInterval encode(html_javascript)%",'sweeperInterval');</script> milliseconds
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="sweeperAge">Sweeper Age</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.sweeperAge", "%value  fsdata.jdbc.sweeperAge encode(html_javascript)%",'sweeperAge');</script> milliseconds
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="segmentSize">Segment Size</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.segmentSize", "%value  fsdata.jdbc.segmentSize encode(html_javascript)%",'segmentSize');</script> bytes
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="maxCache">Segment Cache</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.maxCache", "%value  fsdata.jdbc.maxCache encode(html_javascript)%",'maxCache');</script> segments
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="maxConnRetry">Database Connection Retry</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.maxConnRetry", "%value  fsdata.jdbc.maxConnRetry encode(html_javascript)%",'maxConnRetry');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="connRetryInterval">Database Connection Retry Delay</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.connRetryInterval", "%value  fsdata.jdbc.connRetryInterval encode(html_javascript)%",'connRetryInterval');</script> milliseconds
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="errorLog">Database Error Log Filename</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "fsdata.jdbc.errorLog", "%value  fsdata.jdbc.errorLog encode(html_javascript)%",'errorLog');</script>
                </TD>
              </TR>
              %endif%
        <tr><td class="space" colspan="3">&nbsp;</td></tr>
              <TR>
                 <TD colspan=2 class="heading">Repository recovery</TD>
              </TR>
              <TR>
                <TD class="oddrow">Full Consistency Check</TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  %ifvar doc equals('edit')%
                  <input type="radio" name="fsdata.fullConsistencyCheck" id="fullConsistencyCheck1" value="never" %ifvar fsdata.fullConsistencyCheck equals('never')%checked%endif%><label for="fullConsistencyCheck1">Never</label></input>
                  <input type="radio" name="fsdata.fullConsistencyCheck" id="fullConsistencyCheck2" value="conditional" %ifvar fsdata.fullConsistencyCheck equals('conditional')%checked%endif%><label for="fullConsistencyCheck2">Conditional</label></input>
                  <input type="radio" name="fsdata.fullConsistencyCheck" id="fullConsistencyCheck3" value="always" %ifvar fsdata.fullConsistencyCheck equals('always')%checked%endif%><label for="fullConsistencyCheck3">Always</label></input>
                  %else%
                  %value fsdata.fullConsistencyCheck encode(html)%
                  %endif%
                </TD>
              </TR>
              <TR>
                <TD class="oddrow">Attempt Repair</TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  %ifvar doc equals('edit')%
                  <input type="radio" name="fsdata.attemptRepair" id="attemptRepair1" value="true" %ifvar fsdata.attemptRepair equals('true')%checked%endif%><label for="attemptRepair1">Yes</label></input>
                  <input type="radio" name="fsdata.attemptRepair" id="attemptRepair2" value="false" %ifvar fsdata.attemptRepair equals('false')%checked%endif%><label for="attemptRepair2">No</label></input>
                  %else%
                    %ifvar fsdata.attemptRepair equals('true')%
                      Yes
                    %else%
                      No
                    %endif%
                  %endif%
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="sessiontimeout">Repository Session Timeout</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "sessiontimeout", "%value  sessiontimeout encode(html_javascript)%",'sessiontimeout');</script> milliseconds
                </TD>
              </TR>
              
            %else%
            <TR>
              <TD colspan=2 class="heading">Remote Repository Server Configuration</TD>
            </TR>
              <TR>
                <TD class="oddrow"><label for="hostname">Hostname</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "hostname", "%value  hostname encode(html_javascript)%",'hostname');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="port">Port</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "port", "%value  port encode(html_javascript)%",'port');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="connthreadmin">Minimum connection threads</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "connthreadmin", "%value  connthreadmin encode(html_javascript)%",'connthreadmin');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="connthreadmax">Maximum connection threads</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "connthreadmax", "%value  connthreadmax encode(html_javascript)%",'connthreadmax');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="retrycount">Connection retry count</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "retrycount", "%value  retrycount encode(html_javascript)%",'retrycount');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="retrydelay">Connection retry delay</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "retrydelay", "%value  retrydelay encode(html_javascript)%",'retrydelay');</script>
                </TD>
              </TR>
            %ifvar clusterservers%
            <TR>
              <TD colspan=2 class="heading">Remote Repository Cluster Servers</TD>
            </TR>
            %loop clusterservers%
              <TR>
                <TD class="oddrow"><label for="clusterhostname">Hostname</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "clusterhostname", "%value  clusterhostname encode(html_javascript)%",'clusterhostname');</script>
                </TD>
              </TR>
              <TR>
                <TD class="oddrow"><label for="clusterport">Port</label></TD>
                <TD class="%ifvar doc equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
                  <script>writeEdit("%value ../doc encode(javascript)%", "clusterport", "%value  clusterport encode(html_javascript)%",'clusterport');</script>
                </TD>
              </TR>
            %endloop%
            %endif%
            %endif%

          %ifvar ../doc equals('edit')%
            <TR>
              <TD class="action" colspan="3">
                <INPUT type="submit" name="submit" value="Save Settings"></INPUT>
              </TD>
            </TR>
            </FORM>
          %endif%
        </TD>
      </TABLE>
      </TR>
    </TABLE>
    %endinvoke%

  </BODY>
</HTML>
