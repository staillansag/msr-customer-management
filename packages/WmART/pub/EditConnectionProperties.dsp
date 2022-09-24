%comment%----- Edit connection node -----%endcomment%

%ifvar parameters%
    <script>setNavigation('ListResources.dsp', '%value TemplateURL%', 'foo');</script>
    
    <tr >
	<td class="subheading" colspan=2>Connection Properties</td>
	</tr>
    
    %ifvar readOnly equals('true')%
      %invoke wm.art.admin:htmlEncodeConnProps%
        %loop parameters%          
			%comment%-- start trax# 1-122V6J --%endcomment%
			%ifvar isHidden%
				%comment%-- set a hidden value --%endcomment%
				<input type="hidden" name=".CPROP.%value -urlencode systemName%" value="%value value%"> </input>
			%else%
			%comment%-- end trax# 1-122V6J --%endcomment%
	
	            <tr>
	                <script>writeTDspan('row');</script>%value displayName%</td>              
	                <script>writeTDspan('rowdata-l');</script><span class="wordbreak">
	                    %ifvar isPassword%
	                         ******
	                    %else%
				%comment%----- TRAX 1-KPWS1 -----%endcomment%
	 			    %value value%
	                    %endif%
						</span>
	                </td>
	                <script>swapRows();</script>
	            </tr>
			%endif%
        %endloop%
      %onerror%
       <script> alert("Error invoking htmlEncode");</SCRIPT>
      %endinvoke%
    %else%
        %comment%-- edit mode --%endcomment%
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
					%ifvar isLookupKey%
					
						<select name=".CPROP.%value systemName%" onchange='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)'>
										%loop resourceDomain%
											<option value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
										%endloop%
						 </select>
					%else%
						<select name=".CPROP.%value systemName%">
										%loop resourceDomain%
											<option value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
										%endloop%
						 </select>
					%endif%
				%else%
					%ifvar isLookupDependent%
						<select name=".CPROP.%value -urlencode systemName%" value="%value value%"> <option value="%value value%">%value value%</option>
						</select>								
					%else%
						<input size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"> </input>
				%endif%	
				%endif%				
				%endif%
			</td></tr>
			%else%
			%comment%-- end trax# 1-122V6J --%endcomment%
	
	            <tr>
	                <script>writeTDspan('row');</script>%value displayName%</td>
	                %ifvar isPassword%
	                    <script>writeTDspan('rowdata-l'); swapRows();</script>
				%comment%----- LG TRAX 1-I49V9 -----%endcomment%
			        %comment%----- Added second argument to passwordChange() function -----%endcomment%
			        %comment%----- to support artconnjs.js for multiple password fields -----%endcomment%
	                        <input size=60
	                               type=password
	                               name=".CPROP.%value -urlencode systemName%"
	                               value="******"
	                               onchange= "return passwordChanged(this.form, '%value -urlencode systemName%')"></input></td></tr>
	
	                    <script>writeTD('row');</script>Retype %value displayName%</td>
	                    <script>writeTD('rowdata-l'); swapRows();</script>
	                    <input size=60 type=password name="PWD.CPROP.%value -urlencode systemName%" value="******"></input></td>
	                %else%
	                    <script>writeTDspan('rowdata-l'); swapRows();</script>
	                        %ifvar resourceDomain -notEmpty%
								%ifvar isLookupKey%
									<select name=".CPROP.%value systemName%" onclick='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)' onchange='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)'>
										%loop resourceDomain%
											<option value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
										%endloop%
									</select>
								%else%
									%ifvar editable%
										<select onclick='changeTextBoxValue(this.value,this.form.elements[".CPROP.%value -urlencode systemName%"])'
										onchange='changeTextBoxValue(this.value,this.form.elements[".CPROP.%value -urlencode systemName%"])'>
											%loop resourceDomain%
												<option value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
											%endloop%
										</select>
										<input name=".CPROP.%value systemName%" style="width:296;margin-left:-319;border:none;height:13"/> 
									%else%
										<select name=".CPROP.%value systemName%">
											%loop resourceDomain%
												<option value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
											%endloop%
										</select>
									%endif%
								%endif%
	                    %else%						
							%ifvar isLookupKey%							
									%ifvar isLookupDependent%
										<select name=".CPROP.%value -urlencode systemName%" value="%value value%" onclick='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)' onchange='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)'>
											<option value="%value value%">%value value%</option>
										</select>
									%else%
										<input size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%" onchange='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)'></input>
										<input type="button" value="LookUp" onclick='dynamicLookUpForEdit(this.form,"%value -urlencode systemName%",this.form.elements[".CPROP.%value -urlencode systemName%"].value,".LBL.CPROP.%value -urlencode systemName%")' />
										<label id=".LBL.CPROP.%value -urlencode systemName%"></label>
									%endif%
							 %else%
								%ifvar isLookupDependent%
									<select name=".CPROP.%value -urlencode systemName%" value="%value value%"> <option value="%value value%">%value value%</option>
									</select>									
								%else%
	                            <input size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
	                        %endif%
							%endif%
	                    %endif%
	                    </td></tr>
	                %endif%
	            </tr>
			%endif%
        %endloop%
    %endif%
%else%
    <tr><td class="message" colspan=4>Connection properties not found</td></tr>
%endif%
