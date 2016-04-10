<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-06-2002
'
'	Purpose: Shop control panel
'
'	Revision history:
'		1.0 - 13-06-2002 - Rasmus Foged
'		First version.
'**************************************************************************************************
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
<TITLE><%=Translate.JsTranslate("Varekatalog",9)%></TITLE>
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

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Varekatalog",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type=hidden name=CheckboxNames>
		<TR>
			<TD valign="top">
				<%=Gui.MakeModuleHeader("Shop", "Varekatalog", False)%>

				<%=Gui.GroupBoxStart(Translate.Translate("Priser")) %>
					<TABLE border="0" cellpadding="2" cellspacing="0" ID="Table1">
						<TR>
							<TD width="170"><%=Translate.Translate("Afrund til hele beløb")%></TD>
							<TD><INPUT type="checkbox" value="True" <%= IIf(Base.GetGs("/Globalsettings/Modules/Shop/Price/Round")="True","checked","") %> id="/Globalsettings/Modules/Shop/Price/Round" name="/Globalsettings/Modules/Shop/Price/Round"></TD>
						</TR>
					</TABLE>
				<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("Integration"))%>
				<TABLE border="0" cellpadding="2" cellspacing="0">
					<TR>
						<TD width="170"><%=Translate.Translate("FTP Path")%></TD>
						<TD><INPUT type="text" maxlength="255" class="std" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Shop/Integration/FTPPath"))%>" name="/Globalsettings/Modules/Shop/Integration/FTPPath" id="/Globalsettings/Modules/Shop/Integration/FTPPath"></TD>
					</TR>
					<TR>
						<TD width="170"><%=Translate.Translate("Integration Import types")%></TD>
						<TD><INPUT type="text" maxlength="255" class="std" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Shop/Integration/IntegrationImportTypes"))%>" name="/Globalsettings/Modules/Shop/Integration/IntegrationImportTypes" id="/Globalsettings/Modules/Shop/Integration/IntegrationImportTypes"></TD>
					</TR>
					<TR>
						<TD width="170"><%=Translate.Translate("Integration Export types")%></TD>
						<TD><INPUT type="text" maxlength="255" class="std" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Shop/Integration/IntegrationExportTypes"))%>" name="/Globalsettings/Modules/Shop/Integration/IntegrationExportTypes" id="/Globalsettings/Modules/Shop/Integration/IntegrationExportTypes"></TD>
					</TR>
					</TR>
				</TABLE>
				<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("Redigering")) %>
					<table border="0" cellpadding="2" cellspacing="0" id="Table2">
						<tr>
							<td width="170"><%=Translate.Translate("Deaktiver gruppe og tilknyttede grupper")%></td>
							<td><input type="checkbox" value="True" <%= IIf(Base.GetGs("/Globalsettings/Modules/Shop/Edit/DeactivateGroups")="True","checked","") %> id="/Globalsettings/Modules/Shop/Edit/DeactivateGroups" name="/Globalsettings/Modules/Shop/Edit/DeactivateGroups"></td>
						</tr>
						<tr>
							<td width="170"><%=Translate.Translate("Side efter produkt redigering")%></td>
							<td><input type="text" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Shop/Edit/PageAfterEdit"))%>" id="/Globalsettings/Modules/Shop/Edit/PageAfterEdit" name="/Globalsettings/Modules/Shop/Edit/PageAfterEdit" class="std"></td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>
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
								<%=Gui.HelpButton("", "administration.controlpanel.shop")%>
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
