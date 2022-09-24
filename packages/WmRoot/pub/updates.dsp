<HTML>
    <HEAD>
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV='Content-Type' CONTENT='text/html; CHARSET=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <TITLE>Integration Server Packages</TITLE>
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <SCRIPT SRC="webMethods.js"></SCRIPT>
    </HEAD>

    <BODY onLoad="setNavigation('support.dsp', '');">
        <DIV class="position">
            <TABLE WIDTH="100%">
                <TR>
                    <TD class="breadcrumb" colspan=2>Support &gt; webMethods Packages and Updates</TD>
                </TR>
        
                %invoke wm.server.packages:packageList%
        
                <TR>
                        %invoke wm.server.query.adminui:getSystemAttributes%
                    %endinvoke%
                    <TABLE class="tableView" width="100%">
                            <TR>
                                <TD class="heading" colspan=1>Updates</TD>
                            </TR>
                            <SCRIPT>resetRows();</SCRIPT>

                            %ifvar patches%
                                <TR>
                                    <TD CLASS="oddcol-l">
                                %loop patches%
                                            %value encode(html)%<BR>
                                        %endloop%
                            </TD>
                                </TR>
                    %else%
                            <TR><TD>None</TD></TR>
                    %endif%
                    </TABLE>
                </TR>

                    <TR>
                        <TD><IMG SRC="images/blank.gif" height="10" width="10"></TD>
                        <TD>
                            <TABLE class="tableView" WIDTH="100%">
                                <TR>
                                    <TD CLASS="heading" COLSPAN="4">Installed Packages and Updates</TD>
                                </TR>
                                <SCRIPT>resetRows();</SCRIPT>
                                <TR>
                                    <TH CLASS="oddcol-l" scope="col">Package Name</TH>
                                    <TH CLASS="oddcol" scope="col">Version</TH>
                                    <TH CLASS="oddcol" scope="col">Enabled</TH>
                                    <TH CLASS="oddcol" scope="col">Loaded</TH>
                                </TR>
                                <SCRIPT>resetRows();</SCRIPT>
                    
                                %loop packages%
                            %rename name package%
                            %invoke wm.server.packages:packageInfo%
                                        %scope param(truestr='true') param(falsestr='false') param(showpkg='false')%    
                                            %ifvar publisher equals('webMethods, Inc.')%
                                                %rename truestr showpkg -copy%
                                            %else%
                                                %ifvar publisher equals('Software AG')%
                                                    %rename truestr showpkg -copy%
                                                %endif%
                                            %endif%
    
                                            %ifvar showpkg equals('true')%
                                                <TR>
                                                    <SCRIPT>writeTD('rowdata-l')</SCRIPT>
													<script>
													createForm("htmlform_package_info_%value $index%", "package-info.dsp", "POST", "BODY");
													setFormProperty("htmlform_package_info_%value $index%", "package", "%value package encode(url)%");
													</script>
													<script>getURL("package-info.dsp?package=%value package encode(url)%", "javascript:document.javascript:document.htmlform_package_info_%value $index%.submit();.submit();", "%value package encode(html)%");</script>
                                                        
                                                    </TD>
                                                    <SCRIPT>writeTD('rowdata');</SCRIPT>%value version encode(html)%</TD>
                                                    <SCRIPT>writeTD('rowdata');</SCRIPT>%ifvar enabled equals('true')%Yes%else%No%endif%</TD>
                                                    <SCRIPT>writeTD('rowdata');</SCRIPT>
                                                        %ifvar loaderr equals('0')%
                                                            %ifvar enabled equals('false')%
                                                                No
                                                            %else%
                                                                %ifvar loadwarning equals('0')%
                                                                    Yes
                                                                %else%
                                                                    <font color="red">Warnings</font>
                                                                %endif%
                                                            %endif%
                                                        %else%
                                                            %ifvar loadok equals('0')%
                                                                No
                                                            %else%
                                                                <font color="red">Partial</font>
                                                            %endif%
                                                        %endif%
                                                    </TD>
                                                    <SCRIPT>swapRows();</SCRIPT>
                                                </TR>
                                      
                                                %loop patchlist%
                                                    <TR>
                                                        <SCRIPT>writeTD('rowdata-l');</SCRIPT>&nbsp;&nbsp;%value name encode(html)%</TD>
                                                        <SCRIPT>writeTD('rowdata');</SCRIPT>%value version encode(html)%</TD>
                                                        <SCRIPT>writeTD('rowdata');</SCRIPT>--</TD>
                                                        <SCRIPT>writeTD('rowdata');</SCRIPT>--</TD>
                                                        <SCRIPT>swapRows();</SCRIPT>
                                                    </TR>
                                                %endloop%
                                            %endif%
                                %endscope%
                            %endinvoke%
                        %endloop%
                            </TABLE>
                        </TD>
                    </TR>
                %endinvoke%
            </TABLE>
        </DIV>
    </BODY>
</HTML>
