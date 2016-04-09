<%@ Page Language="vb" AutoEventWireup="false" Codebehind="System_cpl.aspx.vb" Inherits="Dynamicweb.Admin.System_cpl"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
<TITLE><%=Translate.JsTranslate("System")%></TITLE>
</HEAD>
<BODY>
<SCRIPT>


	function OK_OnClick() {
		document.getElementById('frmGlobalSettings').submit();
	}

	function findCheckboxNames(form) {
		var _names="";
		for(var i=0; i < form.length ; i++) {
			if(form[i].name!=undefined) {
				if(form[i].type=="checkbox") {
					_names = _names + form[i].name + "@"
				}
			}
		}
	form.CheckboxNames.value=_names;
	}
	
	function SSPI(Checked){
		if(Checked){
			//document.getElementById('frmGlobalSettings').DWsqlserver.disabled = true;
			//document.getElementById('frmGlobalSettings').DWsqldb.disabled = true;
			document.getElementById('frmGlobalSettings').DWsqluserid.disabled = true;
			document.getElementById('frmGlobalSettings').DWsqlpwd.disabled = true;

			document.getElementById('frmGlobalSettings').DWTranslationsqluserid.disabled = true;
			document.getElementById('frmGlobalSettings').DWTranslationsqlpwd.disabled = true;
			
			//document.getElementById('frmGlobalSettings').DWWebIP.disabled = true;
			//document.getElementById('frmGlobalSettings').DWsqlserver2.disabled = true;
			//document.getElementById('frmGlobalSettings').DWsqldb2.disabled = true;
			document.getElementById('frmGlobalSettings').DWsqluserid2.disabled = true;
			document.getElementById('frmGlobalSettings').DWsqlpwd2.disabled = true;
		}
		else{
			document.getElementById('frmGlobalSettings').DWsqlserver.disabled = false;
			document.getElementById('frmGlobalSettings').DWsqldb.disabled = false;
			document.getElementById('frmGlobalSettings').DWsqluserid.disabled = false;
			document.getElementById('frmGlobalSettings').DWsqlpwd.disabled = false;
			
			document.getElementById('frmGlobalSettings').DWWebIP.disabled = false;
			document.getElementById('frmGlobalSettings').DWsqlserver2.disabled = false;
			document.getElementById('frmGlobalSettings').DWsqldb2.disabled = false;
			document.getElementById('frmGlobalSettings').DWsqluserid2.disabled = false;
			document.getElementById('frmGlobalSettings').DWsqlpwd2.disabled = false;

			document.getElementById('frmGlobalSettings').DWTranslationsqlserver.disabled = false;
			document.getElementById('frmGlobalSettings').DWTranslationsqldb.disabled = false;
			document.getElementById('frmGlobalSettings').DWTranslationsqluserid.disabled = false;
			document.getElementById('frmGlobalSettings').DWTranslationsqlpwd.disabled = false;
		}
	}

	function CryptPassword(intType) {
	    // YZH: 04/04/2011. disable current code according remove old user manager. TFS:6127        
	    //		strPath = '../Access/Access_EncryptPasswords.aspx?type=' + intType
	    //		window.open(strPath, '_CryptPassword', 'resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=430,height=170,top=155,left=202');
	    top.right.location = '/Admin/Content/Management/Pages/ChangePassword.aspx';
	}
</SCRIPT>

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("System")),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type="hidden" name="CheckboxNames">
		<TR>
			<TD valign="top">
				<%=Gui.GroupBoxStart(Translate.Translate("Indstilling"))%>
				<table cellpadding='2' cellspacing='0' border='0' width='100%'>
					<TR>
						<td width=36 align=left><IMG src="../Images/Icons/cplSystem.gif"></TD>
						<td align=left nowrap style='font-size: 14; font-family: Verdana, Arial, Helvetica; font-weight: Bold;'><%=Translate.Translate("System")%></TD>
					</TR>
				</TABLE>
				<%=Gui.GroupBoxEnd%>

				<%If Session("DW_Admin_UserType") = 0 Then%>
					<%=Gui.GroupBoxStart(Translate.Translate("Database"))%>
					<TABLE border="0" cellpadding="2" cellspacing="0">
						<TR>
							<TD width="170"><%=Translate.Translate("Type")%></TD>
							<TD>
								<SELECT class="std" name="/Globalsettings/System/Database/Type" id="DWsqlmode">
									<OPTION value="ms_access" <%=IIf(Base.GetGs("/Globalsettings/System/Database/Type") = "ms_access", "selected", "")%>>Microsoft Access</OPTION>
									<OPTION value="ms_sqlserver" <%=IIf(Base.GetGs("/Globalsettings/System/Database/Type") = "ms_sqlserver", "selected", "")%>>Microsoft SQL Server</OPTION>
								</SELECT>
							</TD>
						</TR>
						<tr>
							<td><label for="/Globalsettings/System/Database/IntegratedSecurity"><%=Translate.Translate("Brug pålidelig forbindelse")%></label></td>
							<td><input type="checkbox" onClick="SSPI(this.checked)" value="True"  <%=IIf(Base.GetGs("/Globalsettings/System/Database/IntegratedSecurity") = "True", "checked", "")%> id="SecureAdminEncrypt" name="/Globalsettings/System/Database/IntegratedSecurity"></td>
						</tr>
						
						<TR>
							<TD width="170"><%=Translate.Translate("Server")%></TD>
							<TD><INPUT type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/SQLServer")%>" name="/Globalsettings/System/Database/SQLServer" id="DWsqlserver"></TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Database")%></TD>
							<TD><INPUT type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Database")%>" name="/Globalsettings/System/Database/Database" id="DWsqldb"></TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Brugernavn")%></TD>
							<TD><INPUT type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/UserName")%>" name="/Globalsettings/System/Database/UserName" id="DWsqluserid"></TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Adgangskode")%></TD>
							<TD><INPUT type="password" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Password")%>" name="/Globalsettings/System/Database/Password" id="DWsqlpwd"></TD>
						</TR>
						<tr>
							<td width="170"><%=Translate.Translate("Connection string")%></td>
							<td><input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/ConnectionString")%>" name="/Globalsettings/System/Database/ConnectionString" id="ConnectionString"></td>
						</tr>
						<TR><TD width='170'>
							<strong><%=Translate.Translate("Alternativ")%></strong></TD><td></td></TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Check IP")%></TD>
							<TD><INPUT type="text" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/DWWebIP")%>" name="/Globalsettings/System/Database/DWWebIP" id="DWWebIP"></TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Server 2")%></TD>
							<TD><INPUT type="text" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/SQLServer2")%>" name="/Globalsettings/System/Database/SQLServer2" id="DWsqlserver2"></TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Database 2")%></TD>
							<TD><INPUT type="text" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Database2")%>" name="/Globalsettings/System/Database/Database2" id="DWsqldb2"></TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Brugernavn 2")%></TD>
							<TD><INPUT type="text" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/UserName2")%>" name="/Globalsettings/System/Database/UserName2" id="DWsqluserid2"></TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Adgangskode 2")%></TD>
							<TD><INPUT type="password" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Password2")%>" name="/Globalsettings/System/Database/Password2" id="DWsqlpwd2"></TD>
						</TR>
						<tr>
							<td width="170"><%=Translate.Translate("Connection string 2")%></td>
							<td><input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/ConnectionString2")%>" name="/Globalsettings/System/Database/ConnectionString2" id="ConnectionString2"></td>
						</tr>
						<tr>
							<td>
								<strong><%=Translate.Translate("Oversættelse")%></strong></td>
							<td></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Server")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Translation/SQLServer")%>" name="/Globalsettings/System/Database/Translation/SQLServer" id="DWTranslationsqlserver"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Database")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Translation/Database")%>" name="/Globalsettings/System/Database/Translation/Database" id="DWTranslationsqldb"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Brugernavn")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Translation/UserName")%>" name="/Globalsettings/System/Database/Translation/UserName" id="DWTranslationsqluserid"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Adgangskode")%></td>
							<td>
								<input type="password" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Translation/Password")%>" name="/Globalsettings/System/Database/Translation/Password" id="DWTranslationsqlpwd"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Connection string")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Translation/ConnectionString")%>" name="/Globalsettings/System/Database/Translation/ConnectionString" id="TranslationConnectionString"></td>
						</tr>
					</TABLE>
					<%	
						Response.Write(Gui.GroupBoxEnd)
						Response.Write(Gui.GroupBoxStart(Translate.Translate("http")))
						%><table>
				<tr>
					<td width="170">
						
					</td>
					<td>
						<input id="/Globalsettings/System/http/DisableBaseHrefPort" <%=IIf(Base.GetGs("/Globalsettings/System/http/DisableBaseHrefPort") = "True", "checked", "")%>=""
							name="/Globalsettings/System/http/DisableBaseHrefPort" type="checkbox" value="True">
						<label for="/Globalsettings/System/http/DisableBaseHrefPort">
							<%=Translate.Translate("Disable portnumber in base href")%>
						</label>
							</td>
				</tr>
							<tr>
								<td width="170">
								</td>
								<td>
									<input id="/Globalsettings/System/http/DisableSQLInjectionCheck" <%=IIf(Base.GetGs("/Globalsettings/System/http/DisableSQLInjectionCheck") = "True", "checked", "")%>=""
										name="/Globalsettings/System/http/DisableSQLInjectionCheck" type="checkbox" value="True">
									<label for="/Globalsettings/System/http/DisableSQLInjectionCheck">
										<%=Translate.Translate("Disable SQL injection check")%>
									</label>
								</td>
							</tr>
						</table>
						<%
						Response.Write(Gui.GroupBoxEnd)
					Response.Write(Gui.GroupBoxStart(Translate.Translate("Mailserver")))
					%>
					<TABLE border="0" cellpadding="2" cellspacing="0">
						<TR>
							<TD width="170"><%=Translate.Translate("Type")%></TD>
							<TD>
								<SELECT class="std" onChange="" name="/Globalsettings/System/MailServer/Type" id="DWsmtpservermode">
									<OPTION value="ms_exchange" <%=IIf(Base.GetGs("/Globalsettings/System/MailServer/Type") = "ms_exchange", "selected", "")%>>Microsoft 
										Exchange</OPTION>
									<OPTION value="smtp" <%=IIf(Base.GetGs("/Globalsettings/System/MailServer/Type") = "smtp", "selected", "")%>><%=Translate.Translate("SMTP Server")%></OPTION>
								</SELECT>
							</TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Server")%></TD>
							<TD><INPUT type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/MailServer/Server")%>" name="/Globalsettings/System/MailServer/Server" id="DWsmtpserver"></TD>
						</TR>
					</TABLE>
					<%	
						Response.Write(Gui.GroupBoxEnd)
						Response.Write(Gui.GroupBoxStart(Translate.Translate("Mailserver")))
					%>
				<table border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td width="170">
							<%=Translate.Translate("Google sitemap verification token (verify-v1)")%>
						</td>
						<td>
							<input id="DWsmtpserver" class="std" maxlength="255" name="/Globalsettings/System/SEO/verifyv1" type="text" value="<%=Base.GetGs("/Globalsettings/System/SEO/verifyv1")%>">
						</td>
					</tr>
				</table>
				<%	
					Response.Write(Gui.GroupBoxEnd)
					Response.Write(Gui.GroupBoxStart(Translate.Translate("Active Directory")))
					%>
					<TABLE border="0" cellpadding="2" cellspacing="0">
						<TR>
							<TD width="170"><%=Translate.Translate("ADSI-Domain")%></TD>
							<TD><INPUT type="text" maxlength="255" <%If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" Then Response.Write("disabled Title='" & Translate.JSTranslate("Fravælg udvidet brugerstyrings komponent") &  "'")%> class="std" value="<%=Base.GetGs("/Globalsettings/System/ActiveDirectory/ADSI-Domain")%>" name="/Globalsettings/System/ActiveDirectory/ADSI-Domain" id="DWadsidomain"></TD>
						</TR>
						<tr>
							<td width="170"><%=Translate.Translate("ADSI-Domain 2")%></td>
							<td><input type="text" maxlength="255" <%If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" Then Response.Write("disabled Title='" & Translate.JSTranslate("Fravælg udvidet brugerstyrings komponent") &  "'")%> class="std" value="<%=Base.GetGs("/Globalsettings/System/ActiveDirectory/ADSI-Domain2")%>" name="/Globalsettings/System/ActiveDirectory/ADSI-Domain2" id="DWadsidomain2"></td>
						</tr>
						<TR>
							<TD width="170"><%=Translate.Translate("Brugernavn")%></TD>
							<TD><INPUT type="text" maxlength="255" class="std" <%If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" Then Response.Write("disabled Title='" & Translate.JSTranslate("Fravælg udvidet brugerstyrings komponent") &  "'")%> value="<%=Base.GetGs("/Globalsettings/System/ActiveDirectory/UserName")%>" name="/Globalsettings/System/ActiveDirectory/UserName" id="DWadsidomainUserName"></TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Adgangskode")%></TD>
							<TD><INPUT type="password" class="std" <%If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" Then Response.Write("disabled Title='" & Translate.JsTranslate("Fravælg udvidet brugerstyrings komponent") &  "'")%> value="<%=Base.GetGs("/Globalsettings/System/ActiveDirectory/Password")%>" name="/Globalsettings/System/ActiveDirectory/Password" id="DWadsidomainPassword"></TD>
						</TR>
					</TABLE>
					<%	
					Response.Write(Gui.GroupBoxEnd)
					Response.Write(Gui.GroupBoxStart(Translate.Translate("Web clustering")))
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								</TD>
							<TD>
							<%		If Dynamicweb.Clustering.Handler.IsPrimaryMachine Then%>
							<%=Translate.Translate("This is the primary webserver")%>
							<%Else%>
							<%=Translate.Translate("This is the secondary webserver. <br><small>These settings can only be changed on the primary server.</small>")%>
							<%End If%>
							</TD>
							
						</TR>
						<tr>
							<td width="170">
								<%=Translate.Translate("Local machinename")%></TD>
							<TD>
							<%		If Dynamicweb.Clustering.Handler.IsPrimaryMachine Then%>
							<INPUT type="text" maxlength="255" class="std" value="<%=Dynamicweb.Clustering.Handler.GetLocalMachineName%>" name="/Globalsettings/System/Clustering/LocalMachineName" id="Text1">
							<%Else%>
							<%=Dynamicweb.Clustering.Handler.GetLocalMachineName%>
							<%End If%>
							</TD>
							
						</TR>
						<tr>
							<td width="170"><%=Translate.Translate("Local hostname")%></td>
							<td>
							<%		If Dynamicweb.Clustering.Handler.IsPrimaryMachine Then%>
							<input type="text" maxlength="255" class="std" value="<%=Dynamicweb.Clustering.Handler.GetLocalUrl%>" name="/Globalsettings/System/Clustering/LocalUrl" id="Text2">
							<%Else%>
							<%=Dynamicweb.Clustering.Handler.GetLocalUrl%>
							<%End If%>
							</td>
						</tr>
						<TR>
							<TD width="170"><%=Translate.Translate("Remote machinename")%></TD>
							<TD>
							<%		If Dynamicweb.Clustering.Handler.IsPrimaryMachine Then%>
							<INPUT type="text" maxlength="255" class="std" value="<%=Dynamicweb.Clustering.Handler.GetRemoteMachineName%>" name="/Globalsettings/System/Clustering/RemoteMachineName" id="Text3">
							<%Else%>
							<%=Dynamicweb.Clustering.Handler.GetRemoteMachineName%>
							<%End If%>
							</TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Remote hostname")%></TD>
							<TD>
							<%		If Dynamicweb.Clustering.Handler.IsPrimaryMachine Then%>
							<INPUT type="text" class="std" value="<%=Dynamicweb.Clustering.Handler.GetRemoteUrl%>" name="/Globalsettings/System/Clustering/RemoteUrl" id="Password1">
							<%Else%>
							<%=Dynamicweb.Clustering.Handler.GetRemoteUrl%>
							<%End If%>
							</TD>
						</TR>
					</TABLE>
					<%	
						Response.Write(Gui.GroupBoxEnd)
						Response.Write(Gui.GroupBoxStart(Translate.Translate("Version")))
					%>
				<table border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td width="170">
							<%=Translate.Translate("Version")%>
						</td>
						<td>
							<input id="DWCurrentVersion" class="std" maxlength="255" name="/Globalsettings/System/Version/CurrentVersion" type="text" value="<%=Base.GetGs("/Globalsettings/System/Version/CurrentVersion")%>"></td>
					</tr>
					<tr>
						<td width="170">
							
						</td>
						<td>
							<%=Gui.CheckBox(Base.GetGs("/Globalsettings/System/Version/Oem"), "/Globalsettings/System/Version/Oem")%>
							<label for="/Globalsettings/System/Version/Oem">OEM
							</label></td>
					</tr>
					<tr>
						<td width="170">
							Max pages in OEM (Requires light!).
						</td>
						<td>
						<input name="/Globalsettings/System/Version/LightPageCount" type="text" value="<%=Base.GetGs("/Globalsettings/System/Version/LightPageCount")%>" class="std" />
					</tr>
					<tr>
						<td width="170"></td>
						<td>
							<input id="/Globalsettings/System/Version/Osmium" <%=IIf(Base.GetGs("/Globalsettings/System/Version/Osmium") = "True", "checked", "")%>="" name="/Globalsettings/System/Version/Osmium" type="checkbox" value="True">
							<label for="/Globalsettings/System/Version/Osmium">
								Osmium (Greek) version
							</label>
							</td>
					</tr>
				</table>
					<%	
					Response.Write(Gui.GroupBoxEnd)
					Response.Write(Gui.GroupBoxStart(Translate.Translate("Sprog")))
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170"><%=Translate.Translate("Domæne > 255 tegn")%></td>
							<td><%=DomainMoreThan255()%></td>
						</tr>
					</table>
					<%	
					Response.Write(Gui.GroupBoxEnd)
					If Not Database.IsAccess() Then
					Response.Write(Gui.GroupBoxStart(Translate.Translate("Ret DB felter")))
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170"><%=Translate.Translate("Statistik, udv. nyhedsbrev")%></td>
							<td><%=ExtendedNewsletterStat()%></td>
						</tr>
					</table>
					<%	
					Response.Write(Gui.GroupBoxEnd)
					End If
					Response.Write(Gui.GroupBoxStart("<INPUT type=""checkbox"" value=""show"" onclick=""if(this.checked==true) document.getElementById('tr_SecureAdmin').style.display=''; else document.getElementById('tr_SecureAdmin').style.display='none';""" & IIf(Base.GetGs("/Globalsettings/Modules/Users/UseInAdministration") = "show", "checked", "") & " id=""SecureAdmin"" name=""/Globalsettings/Modules/Users/UseInAdministration"">&nbsp;" & Translate.Translate("Adgangskodesikkerhed - %%", "%%", Translate.Translate("Dynamicweb administration"))))
					%>
					<TABLE border="0" cellpadding="2" cellspacing="0" id="tr_SecureAdmin" style="Display: <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/UseInAdministration") = "show", "", "None")%>;">
						<TR>
							<TD width="170"><LABEL for="/Globalsettings/Modules/Users/EncryptPassword"><%=Translate.Translate("Krypter")%></LABEL></TD>
										<TD><INPUT type="checkbox" value="encrypt"  <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/EncryptPassword") = "encrypt", "checked", "")%> id="SecureAdminEncrypt" name="/Globalsettings/Modules/Users/EncryptPassword"></TD>
									</TR>
									<TR>
							<TD width="170"><%=Translate.Translate("Udløbsfrist")%></TD>
										<TD>
											<select class="std" name="/Globalsettings/Modules/Users/PasswordExpireDays" id="SecureAdminPasswordExpires">
												<option value="never" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "never", "selected", "")%>><%=Translate.Translate("aldrig")%></option>
									<option value="30" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "30", "selected", "")%>><%=Translate.JSTranslate("%% dage", "%%", "30")%></option>
									<option value="60" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "60", "selected", "")%>><%=Translate.JSTranslate("%% dage", "%%", "60")%></option>
									<option value="90" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "90", "selected", "")%>><%=Translate.JSTranslate("%% dage", "%%", "90")%></option>
									<option value="180" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "180", "selected", "")%>><%=Translate.JSTranslate("%% dage", "%%", "180")%></option>
									<option value="360" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "360", "selected", "")%>><%=Translate.JSTranslate("%% dage", "%%", "360")%></option>
											</select>
										</TD>
									</TR>
									<TR>
										<TD width="170"><%=Translate.Translate("Kodeord genbrug")%></TD>
										<TD>
										</TD>
									</TR>
									<TR>
							<TD width="170">&nbsp;&nbsp;<%=Translate.Translate("Efter antal gange")%></TD>
										<TD>
											<%=Gui.SpacListExt(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfTimes"), "/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfTimes", 0, 50, 1, "")%>
										</TD>
									</TR>
									<TR>
							<TD width="170">&nbsp;&nbsp;<%=Translate.Translate("Efter Antal dage")%></TD>
										<TD>
											<select class="std" name="/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays" id="SecureAdminPasswordReuseDate">
												<option value="allways" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "allways", "selected", "")%>>0</option>
												<option value="30" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "30", "selected", "")%>>30</option>
												<option value="60" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "60", "selected", "")%>>60</option>
												<option value="90" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "90", "selected", "")%>>90</option>
												<option value="180" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "180", "selected", "")%>>180</option>
												<option value="360" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "360", "selected", "")%>>360</option>
												<option value="never" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "never", "selected", "")%>><%=Translate.Translate("aldrig")%></option>
											</select>
										</TD>
									</TR>
									<TR>
							<TD width="170"><%=Translate.Translate("Kompleksitet")%></TD>
										<TD>
											<select class="std" name="/Globalsettings/Modules/Users/PasswordSecurity" id="SecureAdminPasswordSecurity">
												<option value="low" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordSecurity") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordSecurity") = "low", "selected", "")%>><%=Translate.Translate("lav")%></option>
												<option value="medium" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordSecurity") = "medium", "selected", "")%>><%=Translate.Translate("mellem")%></option>
												<option value="high" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordSecurity") = "high", "selected", "")%>><%=Translate.Translate("høj")%></option>
											</select>
										</TD>
									</TR>
									<TR>
										<TD width="170"><%=Translate.Translate("Min. antal karakterer")%></TD>
										<TD>
											<%=Gui.SpacListExt(Base.GetGs("/Globalsettings/Modules/Users/MinimumOfCharacters"), "/Globalsettings/Modules/Users/MinimumOfCharacters", 0, 15, 1, "")%>
										</TD>
									</TR>
											<TR>
							<TD></TD>
							<TD><br />
								<%=Gui.Button(Translate.Translate("Krypter %%", "%%", Translate.Translate("brugere")), "EncryptPaswords(true);", 0)%>
												</TD>
											</TR>
								</TABLE>
					&nbsp;
					<%
					Response.Write(Gui.GroupBoxEnd)
					Response.Write(Gui.GroupBoxStart("<INPUT type=""checkbox"" value=""show"" onclick=""if(this.checked==true) document.getElementById('tr_SecureExtranet').style.display=''; else document.getElementById('tr_SecureExtranet').style.display='none';""" & IIf(Base.GetGs("/Globalsettings/Modules/Extranet/UseWithExtranet") = "show", "checked", "") & " id=""Checkbox1"" name=""/Globalsettings/Modules/Extranet/UseWithExtranet"">&nbsp;" & Translate.Translate("Adgangskodesikkerhed - %%", "%%", Translate.Translate("Extranet"))))
					%>
					<TABLE border="0" cellpadding="2" cellspacing="0" id="tr_SecureExtranet" style="Display: <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/UseWithExtranet") = "show", "", "None")%>;">
									<TR>
							<TD width="170"><LABEL for="/Globalsettings/Modules/Extranet/EncryptPassword"><%=Translate.Translate("Krypter")%></LABEL></TD>
										<TD><INPUT type="checkbox" value="encrypt"  <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/EncryptPassword") = "encrypt", "checked", "")%> id="Checkbox2" name="/Globalsettings/Modules/Extranet/EncryptPassword"></TD>
									</TR>
									<TR>
							<TD width="170"><%=Translate.Translate("Udløbsfrist")%></TD>
										<TD>
											<select class="std" name="/Globalsettings/Modules/Extranet/PasswordExpireDays" id="Select1">
												<option value="never" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "encrypt", "selected", "")%>><%=Translate.Translate("aldrig")%></option>
									<option value="30" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "30", "selected", "")%>><%=Translate.Translate("%% dage", "%%", "30")%></option>
									<option value="60" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "60", "selected", "")%>><%=Translate.Translate("%% dage", "%%", "60")%></option>
									<option value="90" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "90", "selected", "")%>><%=Translate.Translate("%% dage", "%%", "90")%></option>
									<option value="180" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "180", "selected", "")%>><%=Translate.Translate("%% dage", "%%", "180")%></option>
									<option value="360" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "360", "selected", "")%>><%=Translate.Translate("%% dage", "%%", "360")%></option>
											</select>
										</TD>
									</TR>
									<TR>
										<TD width="170"><%=Translate.Translate("Kodeord genbrug")%></TD>
										<TD>
										</TD>
									</TR>
									<TR>
							<TD width="170">&nbsp;&nbsp;<%=Translate.Translate("Efter antal gange")%></TD>
										<TD>
											<%=Gui.SpacListExt(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfTimes"), "/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfTimes", 0, 50, 1, "")%>
										</TD>
									</TR>
									<TR>
							<TD width="170">&nbsp;&nbsp;<%=Translate.Translate("Efter Antal dage")%></TD>
										<TD>
											<select class="std" name="/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays" id="SecureExtranetPasswordReuseDate">
												<option value="allways" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "allways", "selected", "")%>>0</option>
												<option value="30" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "30", "selected", "")%>>30</option>
												<option value="60" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "60", "selected", "")%>>60</option>
												<option value="90" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "90", "selected", "")%>>90</option>
												<option value="180" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "180", "selected", "")%>>180</option>
												<option value="360" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "360", "selected", "")%>>360</option>
												<option value="never" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "never", "selected", "")%>><%=Translate.Translate("aldrig")%></option>
											</select>
										</TD>
									</TR>
									<TR>
							<TD width="170"><%=Translate.Translate("Kompleksitet")%></TD>
										<TD>
											<select class="std" name="/Globalsettings/Modules/Extranet/PasswordSecurity" id="Select2">
												<option value="low" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordSecurity") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordSecurity") = "low", "selected", "")%>><%=Translate.Translate("lav")%></option>
												<option value="medium" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordSecurity") = "medium", "selected", "")%>><%=Translate.Translate("mellem")%></option>
												<option value="high" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordSecurity") = "high", "selected", "")%>><%=Translate.Translate("høj")%></option>
											</select>
										</TD>
									</TR>
									<TR>
										<TD width="170"><%=Translate.Translate("Min. antal karakterer")%></TD>
										<TD>
											<%=Gui.SpacListExt(Base.GetGs("/Globalsettings/Modules/Extranet/MinimumOfCharacters"), "/Globalsettings/Modules/Extranet/MinimumOfCharacters", 0, 15, 1, "")%>
										</TD>
									</TR>
											<TR>
									<TD width="170"></TD>
									<TD><br />
										<%=Gui.Button(Translate.Translate("Krypter %%", "%%", Translate.Translate("extranet")), "EncryptPaswords(false);", 0)%>
												</TD>
											</TR>

								</TABLE>
					&nbsp;
					<%=Gui.GroupBoxEnd%>
				<%Else%>		
					<TABLE border="0" cellpadding="6" cellspacing="6">
						<TR>
							<TD>
								<%=Translate.Translate("Du har ikke adgangsrettigheder til denne del af kontrolpanelet.")%>
							</TD>
						</TR>
					</TABLE>
				<%End If%>
					
				<TR>
					<TD align="right" valign=bottom>
						<TABLE>
							<TR>
								<TD>
									<%If Session("DW_Admin_UserType") = 0 Then%>
										<%=Gui.Button(Translate.Translate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%>
									<%End If%>
								</TD>
								<TD>
									<%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%>
								</TD>
								<%=Gui.HelpButton("", "administration.controlpanel.system")%>
								<TD width="2"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TD>
		<TR>
	</form>
</TABLE>
<%
Translate.GetEditOnlineScript()
%>
