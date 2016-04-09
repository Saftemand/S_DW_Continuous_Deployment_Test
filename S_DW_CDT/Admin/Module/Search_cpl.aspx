<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-06-2002
'
'	Purpose: Search control panel
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
<TITLE><%=Translate.JsTranslate("Udvidet søgning",9)%></TITLE>
</HEAD>
<BODY>
<script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
<SCRIPT>
	function OK_OnClick() {
		var minChars = document.getElementById("/Globalsettings/Modules/SearchExtended/MinimumOfCharacters");
		var ret = true;
		
		if(minChars.value.length > 0)
		{
			ret = ChkInt(minChars.value);
			if(!ret)
			{
				alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Minimum karakterer"))%>");
				minChars.focus();
			}
		}
		
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
<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Udvidet søgning",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type=hidden name=CheckboxNames>
		<TR>
			<TD valign="top">
				<%=Gui.MakeModuleHeader("SearchExtended", "Udvidet søgning", False)%>

				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<TABLE border="0" cellpadding="2" cellspacing="0">
					<TR>
						<TD width="150"><%= Translate.Translate("Index Server katalog")%></TD>
						<TD><INPUT type="text" name="/Globalsettings/Modules/SearchExtended/IndexCatalog" id="/Globalsettings/Modules/SearchExtended/IndexCatalog" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/SearchExtended/IndexCatalog"))%>" maxlength="255" class="std"></TD>
					</TR>
					<TR>
						<TD width="150"><%= Translate.Translate("Minimum karakterer")%></TD>
						<TD><INPUT type="text" name="/Globalsettings/Modules/SearchExtended/MinimumOfCharacters" id="/Globalsettings/Modules/SearchExtended/MinimumOfCharacters" value="<%=Base.GetGs("/Globalsettings/Modules/SearchExtended/MinimumOfCharacters")%>" maxlength="255" class="std"></TD>
					</TR>
				</TABLE>
				<%=Gui.GroupBoxEnd %>
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
								<%=Gui.HelpButton("", "administration.controlpanel.searchextended")%>
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