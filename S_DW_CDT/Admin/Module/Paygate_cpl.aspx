<%@ Page Language="vb" AutoEventWireup="false" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-06-2002
'
'	Purpose: Paygate control panel
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
<TITLE><%=Translate.JsTranslate("Betalingsgateway",9)%></TITLE>
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

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Betalingsgateway",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type=hidden name=CheckboxNames>
		<TR>
			<TD valign="top">
				<%=Gui.MakeModuleHeader("Paygate", "Betalingsgateway", False)%>

				<%=Gui.GroupBoxStart(Translate.Translate("DOBS - Online betaling"))%>
					<TABLE border="0" cellpadding="2" cellspacing="0" ID="Table1">
						<TR>
							<TD width=170><%=Translate.Translate("Merchant ID")%></TD>
							<TD><INPUT type="text" name="/Globalsettings/Modules/Paygate/DOBS/MerchantID" id="/Globalsettings/Modules/Paygate/DOBS/MerchantID" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Paygate/DOBS/MerchantID"))%>" maxlength="255" class="std"></TD>
						</TR>
						<TR>
							<TD><%=Translate.Translate("Valuta")%></TD>
							<TD>
								<SELECT class="std" name="/Globalsettings/Modules/Paygate/DOBS/Currency" id="/Globalsettings/Modules/Paygate/DOBS/Currency" width="250px">
									<OPTION><%=Translate.Translate("Ikke valgt")%></OPTION>
									<OPTION value="208" <%=IIf(Base.GetGs("/Globalsettings/Modules/Paygate/DOBS/Currency") = "208", "selected", "")%>><%=Translate.Translate("Dansk")%></OPTION>
								</SELECT>
							</TD>
						</TR>
					</TABLE>
				<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("DIBS - Online betaling"))%>
					<TABLE border="0" cellpadding="2" cellspacing="0">
						<TR>
							<TD><%=Translate.Translate("Merchant ID")%></TD>
							<TD><INPUT type="text" name="/Globalsettings/Modules/Paygate/DIBS/MerchantID" id="/Globalsettings/Modules/Paygate/DIBS/MerchantID" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/MerchantID"))%>" maxlength="255" class="std"></TD>
						</TR>
						<TR>
							<TD><%=Translate.Translate("Valuta")%></TD>
							<TD>
								<SELECT class="std" name="/Globalsettings/Modules/Paygate/DIBS/Currency" id="/Globalsettings/Modules/Paygate/DIBS/Currency" width="250px">
									<OPTION><%=Translate.Translate("Ikke valgt")%></OPTION>
									<OPTION value="208" <%=IIf(Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/Currency") = "208", "selected", "")%>><%=Translate.Translate("Dansk")%></OPTION>
								</SELECT>
							</TD>
						</TR>
						<TR>
							<TD width=170><%=Translate.Translate("Kontrolnøgle 1")%></TD>
							<TD><INPUT type="text" name="/Globalsettings/Modules/Paygate/DIBS/ControlKey1" id="/Globalsettings/Modules/Paygate/DIBS/ControlKey1" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/ControlKey1"))%>" maxlength="255" class="std"></TD>
						</TR>
						<TR>
							<TD><%=Translate.Translate("Kontrolnøgle 2")%></TD>
							<TD><INPUT type="text" name="/Globalsettings/Modules/Paygate/DIBS/ControlKey2" id="/Globalsettings/Modules/Paygate/DIBS/ControlKey2" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/ControlKey2"))%>" maxlength="255" class="std"></TD>
						</TR>
						<TR>
							<TD><%=Translate.Translate("Farve på betalingsvindue")%></TD>
							<TD>
								<SELECT class="std" name="/Globalsettings/Modules/Paygate/DIBS/WindowColor" id="/Globalsettings/Modules/Paygate/DIBS/WindowColor" width="250px">
									<OPTION value="Blue" <%=IIf(Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/WindowColor") <> "Sand", "selected", "")%>><%=Translate.Translate("Blå")%></OPTION>
									<OPTION value="Sand" <%=IIf(Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/WindowColor") = "Sand", "selected", "")%>><%=Translate.Translate("Sandfarvet")%></OPTION>
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
								<%=Gui.HelpButton("", "administration.controlpanel.paygate")%>
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
