<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VersionControl_cpl.aspx.vb" Inherits="Dynamicweb.Admin.VersionControl_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim Access_PasswordMode As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-06-2002
'
'	Purpose: Users control panel
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
<TITLE><%=Translate.JsTranslate("Kontrol Panel - %%","%%",Translate.JsTranslate("Versionsstyring",9))%></TITLE>
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

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Versionsstyring",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type=hidden name=CheckboxNames>
		<TR>
			<TD valign="top">
				<%=Gui.MakeModuleHeader("VersionControl", "Versionsstyring", False)%>
                <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<TABLE border="0" cellpadding="2" cellspacing="0">
					<TR>
						<TD width=170><%=Translate.Translate("Godkendelse")%></TD>
						<TD>
							<SELECT class="std" name="/Globalsettings/Modules/VersionControl/Approval/ApprovalType" id="/Globalsettings/Modules/VersionControl/Approval/ApprovalType" width="250px">
								<OPTION value="Immediate" <%=IIf(Base.GetGs("/Globalsettings/Modules/VersionControl/Approval/ApprovalType") = "Immediate", "selected", "")%>><%=Translate.Translate("Strakspublicer")%></OPTION>
								<OPTION value="Approval" <%=IIf(Base.GetGs("/Globalsettings/Modules/VersionControl/Approval/ApprovalType") = "Approval", "selected", "")%>><%=Translate.Translate("Godkendelse")%></OPTION>
							</SELECT>
						</TD>
					</TR>
					<TR>
						<TD width="170"><%= Translate.Translate("Vis antal versioner") %></TD>
						<TD>
							<SELECT class="std" name="/Globalsettings/Modules/VersionControl/List/Max" id="/Globalsettings/Modules/VersionControl/List/Max" width="250px">
								<OPTION value="5"  <%=IIf(Base.GetGs("/Globalsettings/Modules/VersionControl/List/Max") = "5", "selected", "")%>>5</OPTION>
								<OPTION value="10" <%=IIf(Base.GetGs("/Globalsettings/Modules/VersionControl/List/Max") = "10", "selected", "")%>>10</OPTION>
								<OPTION value="20" <%=IIf(Base.GetGs("/Globalsettings/Modules/VersionControl/List/Max") = "20", "selected", "")%>>20</OPTION>
								<OPTION value="50" <%=IIf(Base.GetGs("/Globalsettings/Modules/VersionControl/List/Max") = "50", "selected", "")%>>50</OPTION>
								<OPTION value="0"  <%=IIf(Base.GetGs("/Globalsettings/Modules/VersionControl/List/Max") = "0", "selected", "")%>><%= Translate.Translate("Alle") %></OPTION>
							</SELECT>
						</TD>
					</TR>
				</TABLE>
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
								<%=Gui.HelpButton("", "administration.controlpanel.versioncontrol")%>
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
