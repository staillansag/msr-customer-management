<tbody id="headerMsgDiv">
<TR>
    <TD colspan="2" class="heading">WS Security Properties (Optional)</TD>
</TR>
</tbody>
<tbody id="usernameMsgDiv">
<TR>
    <TD class="oddrow"><label for="messageUser">User Name</label></TD>
    <TD class="oddrow-l">
        %ifvar ../../action equals('view')%
			%value user encode(html)%
        %else%
			<INPUT NAME="messageUser" id="messageUser" VALUE="%value user encode(htmlattr)%" style="width:40%" />
        %endif% 
    </TD>
</TR>

%ifvar action ../../action equals('view')%
%else%
<TR>
    <TD class="evenrow"><label for="messagePassword">Password</label></TD>
    <TD class="evenrow-l">
		<INPUT TYPE="password" NAME="messagePassword" id="messagePassword" autocomplete="off" VALUE="%value password encode(htmlattr)%" style="width:40%" />
    </TD>
</TR>

<TR>
    <TD class="oddrow"><label for="retype_messagePassword">Retype Password</label></TD>
    <TD class="oddrow-l">
		<INPUT TYPE="password" NAME="retype_messagePassword" id="retype_messagePassword" autocomplete="off" VALUE="%value password encode(htmlattr)%" style="width:40%" />
    </TD>
</TR>
%endif%
</tbody>
<tbody id="partnerCertMsgDiv">
<TR>
    <TD class="evenrow"><label for="messagePartnerPublicKeyFileName">Partner's Certificate</label></TD>
    <TD class="evenrow-l">
        %ifvar ../../action equals('view')%
			%value partnerPublicKeyFileName encode(html)%
        %else%
			<INPUT NAME="messagePartnerPublicKeyFileName" id="messagePartnerPublicKeyFileName" VALUE="%value partnerPublicKeyFileName encode(htmlattr)%" style="width:100%">
        %endif% 
    </TD>
</TR>
</tbody>
<tbody id="keystoreMsgDiv">
<TR>
    <TD class="oddrow"><label for="messageKeyStoreAlias">Keystore Alias</label></TD>
    <TD class="oddrow-l">
        %ifvar ../../action equals('view')%
			%value keyStoreAlias encode(html)%
        %else%
            <SELECT NAME="messageKeyStoreAlias" id="messageKeyStoreAlias" style="width:40%" class="listbox"  onchange="changeval('messageKeyStoreAlias')"></SELECT>
        %endif%
    </TD>
</TR>
<TR>
    <TD class="evenrow"><label for="messagePrivateKeyAlias">Key Alias</label></TD>
    <TD class="evenrow-l">
        %ifvar ../../action equals('view')%
			%value keyAlias encode(html)%
        %else%
            <select name="messagePrivateKeyAlias" id="messagePrivateKeyAlias" style="width:40%" class="listbox"></select>
        %endif%
    </TD>
</TR>
</tbody>
<tbody id="truststoreMsgDiv">
<TR>
    <TD class="oddrow"><label for="messageTrustStoreAlias">Truststore Alias</label></TD>
    <TD class="oddrow-l">
        %ifvar ../../action equals('view')%
			%value trustStoreAlias encode(html)%
        %else%
            %ifvar ../../action equals('edit')%
                <select name="messageTrustStoreAlias" id="messageTrustStoreAlias" class="listbox" style="width:40%">
                %invoke wm.server.security.keystore:listTrustStores%
                    <option name="" value=""></option>
                    %loop trustStores%
						<option name="%value keyStoreName encode(htmlattr)%" value="%value keyStoreName encode(htmlattr)%" %ifvar ../trustStoreAlias vequals(keyStoreName)%selected%endif%>%value keyStoreName encode(html)%</option>
                    %endloop%
                %endinvoke%
                </select>
            %else%
                <select name="messageTrustStoreAlias" id="messageTrustStoreAlias" class="listbox" style="width:40%">
                %invoke wm.server.security.keystore:listTrustStores%
                    <option name="" value=""></option>
                    %loop trustStores%
                        %ifvar isLoaded equals('true')%
							<option name="%value keyStoreName encode(htmlattr)%" value="%value keyStoreName encode(htmlattr)%" %ifvar ../msgTruststore vequals(keyStoreName)%selected%endif%>%value keyStoreName encode(html)%</option>
                        %endif%
                    %endloop%
                %endinvoke%
                </select>
            %endif%
        %endif%
    </TD>
</TR>
</tbody>
<tbody id="timestampMsgDiv">
<TR>
    <TD class="evenrow"><label for="messageTimestampPrecisionInMillis">Timestamp Precision</label></TD>
    <TD class="evenrow-l">
        %ifvar ../../action equals('view')%
          %ifvar timestampPrecisionInMillis%
            %ifvar timestampPrecisionInMillis equals('true')%milliseconds%else%seconds%endif%
      %endif%
        %else%
            <select name="messageTimestampPrecisionInMillis" id="messageTimestampPrecisionInMillis" class="listbox" style="width:40%">
                <option name="default" value="" %ifvar timestampPrecisionInMillis%%else%selected%endif%></option>
                <option name="milliseconds" value="true" %ifvar timestampPrecisionInMillis equals('true')%selected%endif%>milliseconds</option>
                <option name="seconds" value="false" %ifvar timestampPrecisionInMillis equals('false')%selected%endif%>seconds</option>
            </select>
        %endif% 
    </TD>
</TR>

<TR>
    <TD class="oddrow"><label for="messageTimestampTimeToLive">Timestamp Time to Live (seconds)</label></TD>
    <TD class="oddrow-l">
        %ifvar ../../action equals('view')%
			%value timestampTimeToLive encode(html)%
        %else%
			<INPUT NAME="messageTimestampTimeToLive" id="messageTimestampTimeToLive" VALUE="%value timestampTimeToLive encode(htmlattr)%" style="width:40%">
        %endif% 
    </TD>
</TR>

<TR>
    <TD class="evenrow"><label for="messageTimestampMaximumSkew">Timestamp Maximum Skew (seconds)</label></TD>
    <TD class="evenrow-l">
        %ifvar ../../action equals('view')%
			%value timestampMaximumSkew encode(html)%
        %else%
			<INPUT NAME="messageTimestampMaximumSkew" id="messageTimestampMaximumSkew" VALUE="%value timestampMaximumSkew encode(htmlattr)%" style="width:40%">
        %endif% 
    </TD>
</TR>
</tbody>
<tbody id="usernameTokenMsgDiv">
<TR>
    <TD class="oddrow"><label for="messageUsernameTokenTTL">Username Token TTL (seconds)</label></TD>
    <TD class="oddrow-l">
        %ifvar ../../action equals('view')%
			%value usernameTokenTTL encode(html)%
        %else%
			<INPUT NAME="messageUsernameTokenTTL" id="messageUsernameTokenTTL" VALUE="%value usernameTokenTTL encode(htmlattr)%" style="width:40%">
        %endif% 
    </TD>
</TR>

<TR>
    <TD class="evenrow"><label for="messageUsernameTokenFutureTTL">Username Token Future TTL (seconds)</label></TD>
    <TD class="evenrow-l">
        %ifvar ../../action equals('view')%
			%value usernameTokenFutureTTL encode(html)%
        %else%
			<INPUT NAME="messageUsernameTokenFutureTTL" id="messageUsernameTokenFutureTTL" VALUE="%value usernameTokenFutureTTL encode(htmlattr)%" style="width:40%">
        %endif% 
    </TD>
</TR>
</tbody>

<!-- Message Kerberos Properties-->

<tbody id="kerberosPropsDiv">
<TR>
    <TD colspan="2" class="heading">Kerberos Properties (Optional)</TD>
</TR>
<TR>
    <TD class="evenrow"><label for="krbJaasContext">JAAS Context</label></TD>
    <TD class="evenrow-l">
        %ifvar ../../action equals('view')%
			%value kerberosSettings/jaasContext encode(html)%
        %else%
			<input type="text" name="krbJaasContext" id="krbJaasContext" value="%value kerberosSettings/jaasContext encode(htmlattr)%" style="width:40%">
        %endif% 
    </TD>
</TR>
<TR>
    <TD class="oddrow"><label for="krbClientPrincipal">Principal</label></TD>
    <TD class="oddrow-l">
        %ifvar ../../action equals('view')%
			%value kerberosSettings/clientPrincipal encode(html)%
        %else%
			<input type="text" name="krbClientPrincipal" id="krbClientPrincipal" VALUE="%value kerberosSettings/clientPrincipal encode(htmlattr)%" style="width:40%">
        %endif% 
    </TD>
</TR>
%ifvar action ../../action equals('view')%
%else%
    <TR id="clntPwdRow">
        <TD class="evenrow"><label for="krbClientPassword">Principal Password</label></TD>
        <TD class="evenrowdata-l">
			<input type="password" name="krbClientPassword" id="krbClientPassword" value="%value kerberosSettings/clientPassword encode(htmlattr)%" autocomplete="off" style="width:40%">
        </TD>
    </TR>
    <TR id="clntPwdReRow">
        <TD class="oddrow"><label for="retype_krbClientPassword">Retype Principal Password</label></TD>
        <TD class="oddrowdata-l">
			<input type="password" name="retype_krbClientPassword" id="retype_krbClientPassword" value="%value kerberosSettings/clientPassword encode(htmlattr)%" autocomplete="off" style="width:40%">
        </TD>
    </TR>
%endif%
</tbody>
<tbody id="kerberosPropsSPNFormatDivConsumer">
<TR>
    <TD class="evenrow">Service Principal Name Format</TD>
    <TD class="evenrow-l">
	%ifvar ../../action equals('view')%
            %ifvar kerberosSettings/servicePrincipalForm equals('username')% username %else% host-based %endif%
        %else%
            <label>
                <input type="radio" name="krbServicePrincipalForm" value="hostbased" 
                    %ifvar kerberosSettings/servicePrincipalForm equals('username')%
                    %else%checked%endif% />
                host-based
            </label>
            <label>
                <input type="radio" name="krbServicePrincipalForm" value="username" 
                    %ifvar kerberosSettings/servicePrincipalForm equals('username')%checked%endif% />
                username
            </label>
        %endif%
	</TD>
</TR>
</tbody>
<tbody id="kerberosPropsSPNFormatDivProvider">
<TR>
    <TD class="evenrow">Service Principal Name Format</TD>
    <TD class="evenrow-l">
	%ifvar ../../action equals('view')%
		%ifvar kerberosSettings/servicePrincipalForm equals('username')%username%endif%
	%else%
		username
	%endif%
	</TD>
</TR>
</tbody>
<tbody id="kerberosPropsSPNDiv">
<TR>
    <TD class="oddrow"><label for="krbServicePrincipal">Service Principal Name</label></TD>
    <TD class="oddrow-l">
        %ifvar ../../action equals('view')%
			%value kerberosSettings/servicePrincipal encode(html)%
        %else%
			<input type="text" name="krbServicePrincipal" id="krbServicePrincipal" value="%value kerberosSettings/servicePrincipal encode(htmlattr)%" style="width:40%">
        %endif% 
    </TD>
</TR>
</tbody>
