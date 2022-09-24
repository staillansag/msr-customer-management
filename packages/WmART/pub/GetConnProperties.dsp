%comment%----- Displays Connection Parameters and Properties -----%endcomment%

<HTML> 
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Connection Properties</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css"></LINK>
		<Link REL="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></LINK>
        <SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
        <script SRC="artconnjs.js"></script>
		<script SRC="lookUp.js"></script>
		<script SRC="../%value adapterPackageName%/adapterConnPropValidator.js"></script>
		<SCRIPT SRC="csrfGuard.js"></SCRIPT>
    </head>
    
    <body>
        <form name="form" action="ListResources.dsp" method="POST">
        <input type="hidden" name="action" value="saveConnection">
        <input type="hidden" name="passwordChange" value="false">
        <input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">
        
     
        %invoke wm.art.admin:retrieveAdapterTypeData%
        %onerror%
        %endinvoke%
    
		%ifvar test equals(true)%
			<INPUT NAME="test" TYPE="hidden" VALUE="true">
		%else%
			%ifvar test equals(completed)%
				<INPUT NAME="test" TYPE="hidden" VALUE="completed">
			%else%
				<INPUT NAME="test" TYPE="hidden" VALUE="false">
			%endif%
		%endif%
		
        <table width="100%">  
            <tr>
               <td class="breadcrumb" colspan=7>Adapters &gt; %value displayName% &gt; Configure Connection Type</td>
            </tr>
			
			%ifvar test equals(true)%
			  %invoke wm.art.admin.connection:testResource% 
			  <SCRIPT>testCompleted();</SCRIPT>
			  %ifvar message%
				<TR><TD class="message" colspan="8">%value message encode(html)%</TD></TR>
			  %else%
			  %endif%
			  %onerror%
				 %ifvar localizedMessage%
                        <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                    %else%
                        %ifvar error%
                             <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                        %endif%
                    %endif%				
			  %endinvoke%
			%endif%
          
            <tr>
                <td colspan=2>
                    <ul>
			%comment%----- LG TRAX 1-KX9WM Added dspName=.LISTCONNECTIONTYPES -----%endcomment%
                        <li class="ulsize" ><a id="Return_to_%value displayName%_Connection_Types" href="ListAdapterConnTypes.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTCONNECTIONTYPES">Return to %value displayName% Connection Types</a><script>updateURL("Return_to_%value displayName%_Connection_Types", "Return to %value displayName% Connection Types");</script>
                    </ul>
                </td>
            </tr>
           
            %comment%----------------------ConnectionProperties--------------%endcomment%
			<tr>
			<td>
			<table class="tableView" width="100%">
			<tbody>
			
			%ifvar test equals(true)%
				%invoke wm.art.admin.connection:getResourceConfiguration%
					<tr>
						<td class="heading" colspan=2>Configure Connection Type &gt; %value displayName%</td>
					</tr>
					 <tr>
						%include GetISPackages.dsp%
						<script>swapRows();writeTD('row');</script>Folder Name</td>
						<script>writeTD('rowdata-l');</script>
						<input size=30 name="resourceFolderName" value="%value -urlencode resourceFolderName%"></input></td>
					</tr>

					<tr>
						<script>swapRows();writeTD('row');</script>Connection Name</td>
						<script>writeTD('rowdata-l');</script>
						<input size=30 name="resourceName" value="%value -urlencode resourceName%"></input></td>
					</tr>
					%include EditConnectionProperties.dsp%       
					%include EditConnectionManagerProperties.dsp%					
				%onerror%
					<tr>
						<td class="heading" colspan=2>Configure Connection Type</td>
					</tr>
					  %ifvar localizedMessage%
						%comment%-- Localized error message supplied --%endcomment%
						<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
					  %else%
						%ifvar error%
						  <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
						%endif%
					  %endif%
				%endinvoke%
			%else%
				%invoke wm.art.admin.connection:getConnectionProperties%
					<tr>
						<td class="heading" colspan=2>Configure Connection Type &gt; %value displayName%</td>
					</tr>
					%include DisplayConnectionProperties.dsp%         
				%onerror%
					<tr>
						<td class="heading" colspan=2>Configure Connection Type</td>
					</tr>
					  %ifvar localizedMessage%
						%comment%-- Localized error message supplied --%endcomment%
						<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
					  %else%
						%ifvar error%
						  <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
						%endif%
					  %endif%
				%endinvoke%
			 %endif%
            <tr>
                %comment%----------------------ConnectionManagerProperties--------------%endcomment%  
                %invoke wm.art.admin.connection:getConnectionManagerProperties% 
                    %include DisplayConnectionManagerProperties.dsp% 
                %onerror%
                    %ifvar localizedMessage%
                        %comment%-- Localized error message supplied --%endcomment%
                        <tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
                    %else%
                        %ifvar error%
                            <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
                        %endif%
                    %endif%
                %endinvoke%
			</tr>
			</tbody>
			</table>
			</td>
			</tr>
        </table>
    
        <table width=100%>
        <td class="action" colspan="2">
            <input type="submit" name="SUBMIT" value="Save Connection"  onclick="return validateForm(this.form)"/>		
			<input type="submit" name="TEST" value="Test Connection" onClick="return testConnection('GetConnProperties.dsp');" />
            <input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
            <input type="hidden" name="connectionFactoryType" value="%value connectionFactoryType%"> 
        </td>    
        </tr>
        </table>
        </form>    
    </body>
</html>
