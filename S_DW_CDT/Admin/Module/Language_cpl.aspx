<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" %>
<HTML>
	<HEAD>
	<TITLE><%=Translate.JsTranslate("Sprogpakke",9)%></TITLE>
		<%
Dim DWAdminLanguage As String = CStr(Base.GetGS("/Globalsettings/Modules/LanguagePack/DefaultLanguage"))
Dim sql As String
%>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
		<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
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
		</SCRIPT>
		<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Sprogpakke",9)),Translate.Translate("Konfiguration"), "all")%>
		<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
			<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
				<INPUT type="hidden" name="CheckboxNames">
				<TBODY>
		<TR>
						<TD valign="top">
						<%=Gui.MakeModuleHeader("LanguagePack", "Sprogpakke", False)%>

							<%=Gui.GroupBoxStart(Translate.Translate("Standard"))%>
							<TABLE border="0" cellpadding="2" cellspacing="0">
								<TR>
									<TD width="170"><%=Translate.Translate("Sprog")%></TD>
									<TD>
										<select class="std" name="/Globalsettings/Modules/LanguagePack/DefaultLanguage" id="/Globalsettings/Modules/LanguagePack/DefaultLanguage">
											<%	
									If Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage") = "" Then
										DWAdminLanguage = 1
									End If

											    Using LanguageConn As System.Data.IDbConnection = Backend.Translate.LanguageDB.CreateConnection()
											        Using cmdLanguage As IDbCommand = LanguageConn.CreateCommand()

											            sql = "SELECT * FROM [Languages] WHERE LanguageActive=1"

											            cmdLanguage.CommandText = sql
											            Using drLanguageReader As IDataReader = cmdLanguage.ExecuteReader()
											                Dim opLanguageName As Integer = drLanguageReader.GetOrdinal("LanguageName")
											                Dim opid As Integer = drLanguageReader.GetOrdinal("LanguageID")

											                Do While drLanguageReader.Read()
											                    Response.Write("<option value=""" & drLanguageReader(opid) & """ " & IIf(CStr(drLanguageReader(opid)) = Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage"), "Selected", "") & ">" & drLanguageReader(opLanguageName) & "</option>")
											                Loop

											            End Using
											        End Using
											    End Using
									%>
										</select>
									</TD>
								</TR>
							</TABLE>
							<%=Gui.GroupBoxEnd%>
				<TR>
						<TD align="right" valign="bottom">
							<TABLE>
								<TR>
									<TD>
										<%=Gui.Button(Translate.Translate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%>
									</TD>
									<TD>
										<%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%>
									<%=gui.helpbutton("", "administration.controlpanel.languagepack")%>
									<TD width="2"></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
			</TD>
		<TR>
			</form>
			</TR></TBODY>
		</TABLE>
		<%
 Translate.GetEditOnlineScript()
%>
	</BODY>
</HTML>
