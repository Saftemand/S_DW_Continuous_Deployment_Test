<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-06-2002
'
'	Purpose: Stylesheet control panel
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
<TITLE><%=Translate.JsTranslate("Stylesheet")%></TITLE>
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

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Stylesheet")),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type=hidden name=CheckboxNames>
		<TR>
			<TD valign="top">
				<%=Gui.GroupBoxStart(Translate.Translate("Indstilling"))%>
				<table cellpadding='2' cellspacing='0' border='0' width='100%'>
					<TR>
						<td width=36 align=left><IMG src="../Images/Icons/Module_StyleSheet.gif"></TD>
						<td align=left nowrap style='font-size: 14; font-family: Verdana, Arial, Helvetica; font-weight: Bold;'><%=Translate.Translate("Stylesheet")%></TD>
					</TR>
				</TABLE>
				<%=Gui.GroupBoxEnd%>

				<%If Base.chkNumber(Session("DW_Admin_UserType")) <= 3 Then%>
					<%=Gui.GroupBoxStart(Translate.Translate("Farver"))%>
						<TABLE border="0" cellpadding="2" cellspacing="0">

							<TR>
								<TD width="170"><LABEL for="/Globalsettings/Modules/Stylesheet/Color/WindowsColor"><%=Translate.Translate("Windows farver")%></LABEL></TD>
								<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Color/WindowsColor") = "True", "checked", "")%> id="/Globalsettings/Modules/Stylesheet/Color/WindowsColor" name="/Globalsettings/Modules/Stylesheet/Color/WindowsColor"></TD>
							</TR>
							<TR>
								<TD><LABEL for="/Globalsettings/Modules/Stylesheet/Color/WebSafeColors"><%=Translate.Translate("Web Safe farver")%></LABEL></TD>
								<TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Color/WebSafeColors") = "True", "checked", "")%> id="/Globalsettings/Modules/Stylesheet/Color/WebSafeColors" name="/Globalsettings/Modules/Stylesheet/Color/WebSafeColors"></TD>
							</TR>
							
							<tr>
								<td width="170"><%=Translate.Translate("Baggrundsfarve")%></td>
								<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/BackgroundColor") = "True", "checked", "")%> id="/Globalsettings/Modules/Stylesheet/BackgroundColor" name="/Globalsettings/Modules/Stylesheet/BackgroundColor"><label for="/Globalsettings/Modules/Stylesheet/BackgroundColor"><%=Translate.Translate("Medtag i CSS fil")%></label></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td width="170">
							
						</td>
						<td>
							<input id="/Globalsettings/Modules/Stylesheet/Settings/DontUseDwCSS" <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/DontUseDwCSS") = "True", "checked", "")%>="" name="/Globalsettings/Modules/Stylesheet/Settings/DontUseDwCSS" type="checkbox" value="True">
							<label for="/Globalsettings/Modules/Stylesheet/Settings/DontUseDwCSS">
								<%=Translate.Translate("Dont use Dynamicweb generated CSS")%>
							</label>
						</td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("Flash"))%>
				<table border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td width="170"><%=Translate.Translate("Embed version")%></td>
						<td>
						<%
							If String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion")) Then
								Base.SetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion", "8")
							End If
						 %>
							<select id="fv" class="std" name="/Globalsettings/Modules/Stylesheet/Settings/FlashVersion">
								<option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion") = "7", "selected", "")%>="" value="7">7</option>
								<option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion") = "8", "selected", "")%>="" value="8">8</option>
								<option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion") = "9", "selected", "")%>="" value="9">9</option>
								<option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion") = "10", "selected", "")%>="" value="10">10</option>
							</select>
							
						</td>
					</tr>
					<tr>
						<td width="170">
							<%=Translate.Translate("Wmode")%>
						</td>
						<td>
							<%
								If String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode")) Then
									Base.SetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode", "Opaque")
								End If
							%>
							<select id="fwm" class="std" name="/Globalsettings/Modules/Stylesheet/Settings/FlashWmode">
								<option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode") = "Window", "selected", "")%>="" value="Window">Window</option>
								<option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode") = "Opaque", "selected", "")%>="" value="Opaque">Opaque</option>
								<option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode") = "Transparent", "selected", "")%>="" value="Transparent">Transparent</option>
							</select>
						</td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%Else%>		
					<TABLE border="0" cellpadding="6" cellspacing="6">
						<TR>
							<TD>
								<%=Translate.Translate("Du har ikke de nødvendige rettigheder til denne funktion.")%>
							</TD>
						</TR>
					</TABLE>
				<%End If%>
				<TR>
					<TD align="right" valign=bottom>
						<TABLE>
							<TR>
								<TD>
									<%		If Session("DW_Admin_UserType") <= 3 Then%>
										<%=Gui.Button(Translate.Translate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%>
									<%End If%>
								</TD>
								<TD>
									<%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%></TD>
								<%=Gui.HelpButton("", "administration.controlpanel.stylesheet")%>
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
