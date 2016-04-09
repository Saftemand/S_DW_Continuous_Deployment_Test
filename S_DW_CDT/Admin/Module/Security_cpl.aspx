<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Security_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Security_cpl"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
<TITLE></TITLE>
</HEAD>
<BODY>
<script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
<SCRIPT>
	function OK_OnClick() {
		var eml = document.getElementById("/Globalsettings/System/Security/FormAntiSpamReportTo");
		if(IsEmailValid(eml, 
			"<%=Translate.JSTranslate("Ugyldig_værdi_i:_%%", "%%", Translate.JsTranslate("Send kopi til e-mail"))%>"))
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

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Sikkerhed",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx?Type=URL" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type="hidden" name="CheckboxNames">
		<TR>
			<TD valign="top">
			<br>
					<%If Base.HasVersion("18.10.1.0") Then%>
						<%=(Gui.GroupBoxStart(Translate.Translate("E-mail")))%>
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td width="170"><%=Translate.Translate("Masker_e-mailadresser")%></td>
								<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/EmailMunging") = "True", "checked", "")%> id="/Globalsettings/System/Url/EmailMunging" name="/Globalsettings/System/Url/EmailMunging"></td>
							</tr>						
						</table>
						<%=Gui.GroupBoxEnd()%>
					<%End If%>
					<%If Base.HasVersion("18.11.1.0") Then%>
						<%=(Gui.GroupBoxStart(Translate.Translate("Formular")))%>
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td width="170"><%=Translate.Translate("Aktiver antispam funktion")%></td>
								<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Security/FormAntiSpam") = "True", "checked", "")%> id="/Globalsettings/System/Security/FormAntiSpam" name="/Globalsettings/System/Security/FormAntiSpam"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Send kopi til e-mail")%></td>
								<td><input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Security/FormAntiSpamReportTo")%>" name="/Globalsettings/System/Security/FormAntiSpamReportTo" id="/Globalsettings/System/Security/FormAntiSpamReportTo"></td>
							</tr>	
						</table>
						<%=Gui.GroupBoxEnd()%>
					<%End If%>
					<%If Base.HasVersion("18.11.1.0") AndAlso (Session("DW_Admin_UserID") = 2 Or Session("DW_Admin_UserID") = 4) Then%>
					    <%=(Gui.GroupBoxStart(Translate.Translate("Dynamicweb support")))%>
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td width="170"><%=Translate.Translate("Restrict access for support users")%></td>
								<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Security/AngelLocked") = "True", "checked", "")%> id="/Globalsettings/System/Security/AngelLocked" name="/Globalsettings/System/Security/AngelLocked"></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
					<%End If%>
					
				<TR>
					<TD align="right" valign=bottom>
						<TABLE>
							<TR>
								<TD><%=Gui.Button(Translate.Translate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%></TD>
								<TD><%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%></TD>
								<td><%=Gui.HelpButton("", "administration.controlpanel.security")%></td>
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
