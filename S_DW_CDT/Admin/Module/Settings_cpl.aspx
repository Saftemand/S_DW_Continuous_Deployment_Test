<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Settings_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Settings_cpl"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<%
Dim DWAdminLanguage As String = CStr(Base.GetGS("/Globalsettings/Modules/LanguagePack/DefaultLanguage"))
Dim sql As String
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
<TITLE><%=Translate.JsTranslate("Generelt")%></TITLE>
</HEAD>
<BODY>
<script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
<SCRIPT>
	function OK_OnClick() {
		var eml = document.getElementById("/Globalsettings/Settings/CommonInformation/Email");
		var ret = true;
		
		if(eml.value.length > 0)
			ret = IsEmailValid(eml,	"<%=Translate.JSTranslate("Ugyldig_værdi_i:_%%", "%%", Translate.Translate("E-mail"))%>");
				
		if(ret)
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
</SCRIPT>

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Generelt")),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type="hidden" name="CheckboxNames">
		<TR>
			<TD valign="top">
				<%=Gui.GroupBoxStart(Translate.Translate("Indstilling"))%>
				<table cellpadding='2' cellspacing='0' border='0' width='100%'>
					<TR>
						<td width=36 align=left><IMG src="../Images/Icons/cplGeneral.gif"></TD>
						<td align=left nowrap style='font-size: 14; font-family: Verdana, Arial, Helvetica; font-weight: Bold;'><%=Translate.Translate("Generelt")%></TD>
					</TR>
				</TABLE>
				<%=Gui.GroupBoxEnd%>

				<%=Gui.GroupBoxStart(Translate.Translate("Generel information"))%>
				<TABLE border="0" cellpadding="2" cellspacing="0">
					<TR>
						<TD width="170"><LABEL for="/Globalsettings/Settings/CommonInformation/SolutionTitle"><%=Translate.Translate("Løsningstitel")%></LABEL></TD>
						<TD><INPUT type="text" maxlength="255" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionTitle"))%>" class="std" id="/Globalsettings/Settings/CommonInformation/SolutionTitle" name="/Globalsettings/Settings/CommonInformation/SolutionTitle"></TD>
					</TR>
					<TR>
						<TD><LABEL for="/Globalsettings/Settings/CommonInformation/Partner"><%=Translate.Translate("Partner")%></LABEL></TD>
						<TD><INPUT type="text" maxlength="255" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/CommonInformation/Partner"))%>" class="std" id="/Globalsettings/Settings/CommonInformation/Partner" name="/Globalsettings/Settings/CommonInformation/Partner"></TD>
					</TR>
					<TR>
						<TD><LABEL for="/Globalsettings/Settings/CommonInformation/Email"><%=Translate.Translate("E-mail")%></LABEL></TD>
						<TD><INPUT type="text" maxlength="255" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/CommonInformation/Email"))%>" class="std" id="/Globalsettings/Settings/CommonInformation/Email" name="/Globalsettings/Settings/CommonInformation/Email"></TD>
					</TR>
					<TR>
						<TD valign="top"><LABEL for="/Globalsettings/Settings/CommonInformation/CopyrightMetaInformation"><%=Translate.Translate("Copyright")%></LABEL></TD>
						<TD><textarea class="std" name="/Globalsettings/Settings/CommonInformation/CopyrightMetaInformation"
								ID="/Globalsettings/Settings/CommonInformation/CopyrightMetaInformation" rows="5"><%=Base.GetGs("/Globalsettings/Settings/CommonInformation/CopyrightMetaInformation")%></textarea></TD>
					</TR>
				</TABLE>
				<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("IE 8 Compatibility"))%>
				<table border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td width="170"></td>
					<td>
						<%
							If Base.GetGs("/Globalsettings/Settings/IE8/Mode") = "" Then
								Base.SetGs("/Globalsettings/Settings/IE8/Mode", "EmulateIE7")
							End If
						%>
						<input type="radio" value="IE8Standards" <%=IIf(Base.GetGs("/Globalsettings/Settings/IE8/Mode") = "IE8Standards", "checked", "")%> id="Mode3" name="/Globalsettings/Settings/IE8/Mode"><label for="Mode3"><%=Translate.Translate("Standards Compliance")%> (<%=Translate.Translate("Standard")%>)</label><br />
						<input type="radio" value="EmulateIE7" <%=IIf(Base.GetGs("/Globalsettings/Settings/IE8/Mode") = "EmulateIE7", "checked", "")%> id="Mode1" name="/Globalsettings/Settings/IE8/Mode"><label for="Mode1"><%=Translate.Translate("Emulate IE 7")%>: "IE=EmulateIE7"</label><br />
						<input type="radio" value="IE8Comp" <%=IIf(Base.GetGs("/Globalsettings/Settings/IE8/Mode") = "IE8Comp", "checked", "")%> id="Mode2" name="/Globalsettings/Settings/IE8/Mode"><label for="Mode2"><%=Translate.Translate("Force IE 7 Standards Compliance")%>: "IE=7"</label>
						
					</td>
				</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("Performance"))%>
				<TABLE border="0" cellpadding="2" cellspacing="0" ID="Table1">
					<TR>
						<TD width="170"></TD>
						<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/AllNavigationImagesInTheSameJavascript") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/AllNavigationImagesInTheSameJavascript" name="/Globalsettings/Settings/Performance/AllNavigationImagesInTheSameJavascript"><LABEL for="/Globalsettings/Settings/Performance/AllNavigationImagesInTheSameJavascript"><%=Translate.Translate("Alle navigationsbilleder i samme Javascript")%></LABEL></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/ActivateDublinCore") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/ActivateDublinCore" name="/Globalsettings/Settings/Performance/ActivateDublinCore"><LABEL for="/Globalsettings/Settings/Performance/ActivateDublinCore"><%=Translate.Translate("Aktiver Dublin Core")%></LABEL></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/ActivateMouseoverTextsOnMenuItems") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/ActivateMouseoverTextsOnMenuItems" name="/Globalsettings/Settings/Performance/ActivateMouseoverTextsOnMenuItems"><LABEL for="/Globalsettings/Settings/Performance/ActivateMouseoverTextsOnMenuItems"><%=Translate.Translate("Aktiver mouseover tekster på menupunkter")%></LABEL></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/ActivateTitleTextsOnMenuItems") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/ActivateTitleTextsOnMenuItems" name="/Globalsettings/Settings/Performance/ActivateTitleTextsOnMenuItems"><LABEL for="/Globalsettings/Settings/Performance/ActivateTitleTextsOnMenuItems"><%=Translate.Translate("Aktiver title tekster på menupunkter")%></LABEL></TD>
					</TR>
					<TR>
						<TD></TD>
						<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/DeactivateBrowserCache") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/DeactivateBrowserCache" name="/Globalsettings/Settings/Performance/DeactivateBrowserCache"><LABEL for="/Globalsettings/Settings/Performance/DeactivateBrowserCache"><%=Translate.Translate("Deaktiver browser cache")%></LABEL></TD>
					</TR>
					<tr>
						<td></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/DeactivateParagraphAnchor") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/DeactivateParagraphAnchor" name="/Globalsettings/Settings/Performance/DeactivateParagraphAnchor"><label for="/Globalsettings/Settings/Performance/DeactivateParagraphAnchor"><%=Translate.Translate("Deaktiver afsnits bogmærke")%></label></td>
					</tr>
					<tr>
						<td></td>
						<td><input id="/Globalsettings/Settings/Performance/ActivateDropDownCache" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/ActivateDropDownCache") = "True", "checked", "")%>="" name="/Globalsettings/Settings/Performance/ActivateDropDownCache" type="checkbox" value="True"><label for="/Globalsettings/Settings/Performance/ActivateDropDownCache"><%=Translate.Translate("Aktiver dropdown cache")%></label></td>
					</tr>
				</TABLE>
				<%=Gui.GroupBoxEnd%>
				<%
				If Session("DW_Admin_UserID") < 3 Then
					Response.Write(Gui.GroupBoxStart(Translate.Translate("Kundeadgang")))
					%>
					<TABLE border="0" cellpadding="2" cellspacing="0">
						<TR>
							<TD width="170"><%=Translate.Translate("Standardsprog")%></TD>
							<TD>
								<select class="std" name="/Globalsettings/Modules/LanguagePack/DefaultLanguage" id="/Globalsettings/Modules/LanguagePack/DefaultLanguage">
									<%	
									    If Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage") = "" Then
									        DWAdminLanguage = 1
									    End If

									    Using LanguageConn As System.Data.IDbConnection = Translate.LanguageDB.CreateConnection()
									        Using cmdLanguage As IDbCommand = LanguageConn.CreateCommand
								
									            cmdLanguage.CommandText = "SELECT * FROM [Languages] WHERE LanguageActive=1"
									            Using drLanguageReader As IDataReader = cmdLanguage.ExecuteReader()
									                Dim opLanguageName As Integer = drLanguageReader.GetOrdinal("LanguageName")
									                Dim opid As Integer = drLanguageReader.GetOrdinal("LanguageID")

									                Do While drLanguageReader.Read
									                    Response.Write("<option value=""" & drLanguageReader(opid) & """ " & IIf(CStr(drLanguageReader(opid)) = Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage"), "Selected", "") & ">" & drLanguageReader(opLanguageName) & "</option>")
									                Loop

									            End Using
									        End Using
									    End Using
							%>
								</select>
							</TD>
						</TR>
						<tr>
							<td width="170">
								<%=Translate.Translate("Dynamicweb login URL")%>
							</td>
							<td>
								<select name="/Globalsettings/Settings/DynamicwebLoginUrl" class="std">
									<option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.dk", "selected", "")%>="" value="www.dynamicweb.dk">dynamicweb.dk</option>
									<option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.se", "selected", "")%> value="www.dynamicweb.se">dynamicweb.se</option>
									<option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.no", "selected", "")%>="" value="www.dynamicweb.no">dynamicweb.no</option>
									<option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.nl", "selected", "")%>="" value="www.dynamicweb.nl">dynamicweb.nl</option>
									<option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.pt", "selected", "")%>="" value="www.dynamicweb.pt">dynamicweb.pt</option>
									<option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.biz", "selected", "")%>="" value="www.dynamicweb.biz">dynamicweb.biz</option>
								</select>
							</td>
						</tr>
						<TR>
							<TD width="170"><%=Translate.Translate("Vis ved login")%></TD>
							<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/ShowAreabox") = "True", "checked", "")%> id="DWShow_Areabox" name="/Globalsettings/Settings/CustomerAccess/ShowAreabox">
							<label for="DWShow_Areabox"><%=Translate.Translate("Sprog", 9)%></label>
							</TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Lås")%></TD>
							<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockStylesheet") = "True", "checked", "")%> id="DWLock_Stylesheet" name="/Globalsettings/Settings/CustomerAccess/LockStylesheet">
							<label for="DWLock_Stylesheet"><%=Translate.Translate("Fanen %%","%%",Translate.Translate("Stylesheet"))%></label>
							</TD>
						</TR>
						<TR>
							<TD width="170"></TD>
							<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockTemplateFolder") = "True", "checked", "")%> id="DWLock_Templates" name="/Globalsettings/Settings/CustomerAccess/LockTemplateFolder">
							<label for="DWLock_Templates"><%=Translate.Translate("Mappen %%","%%",Translate.Translate("Template"))%></label>
							</TD>
						</TR>
						<TR>
							<TD width="170"></TD>
							<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockNavigationFolder") = "True", "checked", "")%> id="DWLock_Navigation" name="/Globalsettings/Settings/CustomerAccess/LockNavigationFolder">
							<label for="DWLock_Navigation"><%=Translate.Translate("Mappen %%","%%",Translate.Translate("Navigation"))%></label>
							</TD>
						</TR>
						<TR>
							<TD width="170"></TD>
							<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockSystemFolder") = "True", "checked", "")%> id="DWLock_System" name="/Globalsettings/Settings/CustomerAccess/LockSystemFolder">
							<label for="DWLock_System"><%=Translate.Translate("Mappen %%","%%",Translate.Translate("System"))%></label>
							</TD>
						</TR>
					</TABLE>
					<%	
					Response.Write(Gui.GroupBoxEnd)
				End If%>
				<%=Gui.GroupBoxStart(Translate.Translate("Min side"))%>
					<TABLE border="0" cellpadding="2" cellspacing="0" ID="Table1">
						<TR>
							<TD width="170"><LABEL for="/Globalsettings/Settings/MyPage/HideStat"><%=Translate.Translate("Skjul statistik")%></LABEL></TD>
							<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/MyPage/HideStat") = "True", "checked", "")%> id="/Globalsettings/Settings/MyPage/HideStat" name="/Globalsettings/Settings/MyPage/HideStat"></TD>
						</TR>
						<TR>
							<TD width="170"><LABEL for="/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation"><%=Translate.Translate("Seneste nyt side")%></LABEL></TD>
							<TD><INPUT type="text" class="std" value="<%=Base.GetGs("/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation")%>" id="/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation" name="/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation"></TD>
						</TR>
					</TABLE>
				<%=Gui.GroupBoxEnd%>
				<%If Base.HasVersion("18.10.1.0") Then%>
				<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede fejlsider"))%>
					<table border="0" cellpadding="2" cellspacing="0" id="Table1">
						<tr>
							<td width="170"><label for="PageNotFoundRedirectTo"><%=Translate.Translate("HTTP 404")%></label></td>
							<td><%=Gui.LinkManager(base.GetGs("/Globalsettings/Settings/PageNotFound/RedirectTo"), "PageNotFoundRedirectTo", "")%></td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>
				<%End If%>
				<TR>
					<TD align="right" valign=bottom>
						<TABLE>
							<TR>
								<TD>
									<%=Gui.Button(Translate.Translate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%>
								</TD>
								<TD>
									<%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%>
								</TD>
								<%=Gui.HelpButton("", "administration.controlpanel.general")%>
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
