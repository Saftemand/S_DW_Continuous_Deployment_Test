<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-06-2002
'
'	Purpose: Dynamicdoc control panel
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
<TITLE><%=Translate.JsTranslate("Dynamicdoc",9)%></TITLE>
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

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Dynamicdoc",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<FORM method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type=hidden name=CheckboxNames>
		<TR>
			<TD valign="top">
				<%=Gui.MakeModuleHeader("Dynamicdoc", "Dynamicdoc", False)%>

				<% If Session("DW_Admin_UserType") = 0 Then %>
					<%=Gui.GroupBoxStart(Translate.Translate("Licens")) %>
						<TABLE border="0" cellpadding="2" cellspacing="0">
							<TR>
								<TD width="150"><%= Translate.Translate("Brugere") %></TD>
								<TD><INPUT type="text" maxlength="255" name="/Globalsettings/Modules/Dynamicdoc/License/Users" id="/Globalsettings/Modules/Dynamicdoc/License/Users" value="<%=Base.GetGs("/Globalsettings/Modules/Dynamicdoc/License/Users")%>" class="std"></TD>
							</TR>
							<TR>
								<TD width="150"><%= Translate.Translate("Skabeloner") %></TD>
								<TD><INPUT type="text" maxlength="255" name="/Globalsettings/Modules/Dynamicdoc/License/Templates" id="/Globalsettings/Modules/Dynamicdoc/License/Templates" value="<%=Base.GetGs("/Globalsettings/Modules/Dynamicdoc/License/Templates")%>" class="std"></TD>
							</TR>
						</TABLE>
					<%=Gui.GroupBoxEnd %>
					<%=Gui.GroupBoxStart(Translate.Translate("Pitstop")) %>
						<TABLE border="0" cellpadding="2" cellspacing="0">
							<TR>
								<TD width="150"><%= Translate.Translate("Pitstop sti") %></TD>
								<TD><INPUT type="text" maxlength="255" name="/Globalsettings/Modules/Dynamicdoc/Pitstop/PitstopPath" id="/Globalsettings/Modules/Dynamicdoc/Pitstop/PitstopPath" value="<%=Base.GetGs("/Globalsettings/Modules/Dynamicdoc/Pitstop/PitstopPath")%>" class="std"></TD>
							</TR>
						</TABLE>
					<%=Gui.GroupBoxEnd %>
				<% Else %>
					<INPUT type="hidden" name="/Globalsettings/Modules/Dynamicdoc/License/Users" id="/Globalsettings/Modules/Dynamicdoc/License/Users" value="<%=Base.GetGs("/Globalsettings/Modules/Dynamicdoc/License/Users")%>">
					<INPUT type="hidden" name="/Globalsettings/Modules/Dynamicdoc/License/Templates" id="/Globalsettings/Modules/Dynamicdoc/License/Templates" value="<%=Base.GetGs("/Globalsettings/Modules/Dynamicdoc/License/Templates")%>">
					<INPUT type="hidden" name="/Globalsettings/Modules/Dynamicdoc/Pitstop/PitstopPath" id="/Globalsettings/Modules/Dynamicdoc/Pitstop/PitstopPath" value="<%=Base.GetGs("/Globalsettings/Modules/Dynamicdoc/Pitstop/PitstopPath")%>">
				<% End If %>
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
								<%=Gui.HelpButton("", "administration.controlpanel.dynamicdoc")%>
								<TD width="2"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TD>
		<TR>
	</FORM>
</TABLE>

<%
Translate.GetEditOnlineScript()
%>