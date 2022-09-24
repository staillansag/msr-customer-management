%comment%----- LG TRAX 1-MHXP3 -----%endcomment%
%comment%----- New DSP for Connection COPY ONLY -----%endcomment%
%comment%----- New for Elbe Release -----%endcomment%
%ifvar parameters%
    <script>setNavigation('ListResources.dsp', '%value TemplateURL%', 'foo');</script>
    
    <tr >
	<td class="subheading" colspan=2>Connection Copy Properties</td>
	</tr>
    
    %comment%-- Copy Edit mode --%endcomment%
    %loop parameters%          
		%comment%-- start trax# 1-122V6J --%endcomment%
		%ifvar isHidden%
			%comment%-- set a hidden value --%endcomment%
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
	                               value=""
	                               onchange= "return passwordChanged(this.form, '%value -urlencode systemName%')"></input></td></tr>
	
	                <script>writeTD('row');</script>Retype %value displayName%</td>
	                <script>writeTD('rowdata-l'); swapRows();</script>
	                <input size=60 type=password name="PWD.CPROP.%value -urlencode systemName%" value=""></input></td>
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
	                        <select name=".CPROP.%value systemName%">
	                            %loop resourceDomain%
	                                <option value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
	                            %endloop%
	                        </select>
							%endif%
	                    %else%						
							%ifvar isLookupKey%							
									%ifvar isLookupDependent%
										<select name=".CPROP.%value -urlencode systemName%" value="%value value%" onclick='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)' onchange='dynamicLookUp(this.form,"%value -urlencode systemName%",this.value)'>
											<option value="%value value%">%value value%</option>
										</select>
									%else%
										<input size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
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
%else%
    <tr><td class="message" colspan=4>Connection Copy Properties Not Found</td></tr>
%endif%
