%comment%----- Displays connection type parameters -----%endcomment%
%comment%----- LG TRAX 1-MHXZY -----%endcomment%
%comment%----- Move occurrances of swaprows() to make alternate -----%endcomment%
%comment%----- display lines in form have alternating colors -----%endcomment%
%ifvar parameters%
    <script>resetRows();</script>
    <script>setNavigation('ListAdapterConnTypes.dsp', '%value TemplateURL%', 'foo');</script>

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

    <tr>
	<td class="subheading" colspan=2>Connection Properties</td></tr>

    %loop parameters%
	    %comment%-- start trax# 1-122V6J --%endcomment%
	    %ifvar isHidden%
			%ifvar isPassword%
							<tr style="display:none;">
								<script>writeTD('row');</script>%value displayName%</td>
								<script>writeTD('rowdata-l');swapRows();</script>
						%comment%----- LG TRAX 1-BKBFM -----%endcomment%
						%comment%----- Change password field from "******" to "" -----%endcomment%
						%comment%----- LG TRAX 1-I49V9 -----%endcomment%
						%comment%----- Added second argument to passwordChange() function -----%endcomment%
						%comment%----- to support artconnjs.js for multiple password fields -----%endcomment%
								<input size=60 
									   type=password
									   onChange="return passwordChanged(this.form, '%value -urlencode systemName%')"
									   name=".CPROP.%value -urlencode systemName%"
									   value=""></input></td></tr>
							<tr style="display:none;">
								<script>writeTD('row');</script>Retype %value displayName%</td>
								<script>writeTD('rowdata-l'); swapRows();</script>
						%comment%----- LG TRAX 1-BKBFM -----%endcomment%
						%comment%----- Change Retype field from "******" to "" -----%endcomment%
								<input size=60
									   type=password
									   name="PWD.CPROP.%value -urlencode systemName%"
									   value=""></input></td></tr>
			 %else%
			 <tr style="display:none;">
	            <script>writeTD('row');</script>%value displayName%</td>
				%comment%-- set a hidden value --%endcomment%
				<script>writeTD('rowdata-l');swapRows();</script>
				
				%ifvar resourceDomain -notEmpty%
					<select name=".CPROP.%value systemName%">
						%loop resourceDomain%
							<option width=300 value="%value resourceDomain%">%value resourceDomain%</option>
						%endloop%
					</select>
				%else%
					%ifvar isLookupDependent%
						<select name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%" />									
					%else%
						<input size=60 type="text" name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"> </input>
				%endif%	
				%endif%				
				%endif%
			</td></tr>
	    %else%
	    %comment%-- end trax# 1-122V6J --%endcomment%
	    
	        <tr>
	            <script>writeTD('row');</script>%value displayName%</td>
	 
	            %ifvar isPassword%
	                <script>writeTD('rowdata-l');swapRows();</script>
			%comment%----- LG TRAX 1-BKBFM -----%endcomment%
			%comment%----- Change password field from "******" to "" -----%endcomment%
			%comment%----- LG TRAX 1-I49V9 -----%endcomment%
			%comment%----- Added second argument to passwordChange() function -----%endcomment%
			%comment%----- to support artconnjs.js for multiple password fields -----%endcomment%
	                <input size=60 
	                       type=password
	                       onChange="return passwordChanged(this.form, '%value -urlencode systemName%')"
	                       name=".CPROP.%value -urlencode systemName%"
	                       value=""></input></td></tr>
	
	                <script>writeTD('row');</script>Retype %value displayName%</td>
	                <script>writeTD('rowdata-l'); swapRows();</script>
			%comment%----- LG TRAX 1-BKBFM -----%endcomment%
			%comment%----- Change Retype field from "******" to "" -----%endcomment%
	                <input size=60
	                       type=password
	                       name="PWD.CPROP.%value -urlencode systemName%"
	                       value=""></input></td></tr>
	            %else%
	                <script>writeTD('rowdata-l'); swapRows();</script>
	                    %ifvar resourceDomain -notEmpty%
							%ifvar isLookupKey%
								<select name=".CPROP.%value systemName%" onclick='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)' onchange='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)'>
									%loop resourceDomain%
										<option width=300 value="%value resourceDomain%">%value resourceDomain%</option>
									%endloop%
								</select>
							%else%
								%ifvar editable%
									<select onclick='changeTextBoxValue(this.value,this.form.elements[".CPROP.%value -urlencode systemName%"])'
									onchange='changeTextBoxValue(this.value,this.form.elements[".CPROP.%value -urlencode systemName%"])'>
										%loop resourceDomain%
											<option width=300 value="%value resourceDomain%">%value resourceDomain%</option>
										%endloop%
									</select>
									<input name=".CPROP.%value systemName%" style="width:296;margin-left:-319;border:none;height:13"/> 
								%else%
									<select name=".CPROP.%value systemName%">
										%loop resourceDomain%
											<option width=300 value="%value resourceDomain%">%value resourceDomain%</option>
										%endloop%
									</select>
								%endif%
							%endif%
	                    %else%						
							%ifvar isLookupKey%							
									%ifvar isLookupDependent%
										<select name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%" onclick='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)' onchange='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)' />
									%else%
										<input size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input>
										<input type="button" value="LookUp" onclick='dynamicLookUpForDisplay(this.form,"%value -urlencode systemName%",this.form.elements[".CPROP.%value -urlencode systemName%"].value,".LBL.CPROP.%value -urlencode systemName%")' />
										<label id=".LBL.CPROP.%value -urlencode systemName%"></label>
									%endif%
							 %else%
								%ifvar isLookupDependent%
									<select name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%" />									
								%else%
									<input size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input>
								%endif%
							%endif%
	                    %endif%
	                </td>
	            %endif%
	        </tr>
        %endif%
    %endloop%
%endif%
