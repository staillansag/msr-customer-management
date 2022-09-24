
%invoke wm.art.metadata:getLookUpData% 

%ifvar dynamicLookups%
 		    %value -urlencode dynamicLookups%
%endif%
%onerror%
	
%ifvar localizedMessage%
%comment%-- Localized error message supplied --%endcomment%
		Error encountered <%value error%> %value localizedMessage%
%else%
%ifvar error%
		Error encountered <%value error%> %value errorMessage%
%endif%
%endif%
	
%endinvoke%