<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SearchfriendlyUrls_cpl.aspx.vb" Inherits="Dynamicweb.Admin.SearchfriendlyUrls_cpl"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
<TITLE><%=Translate.JsTranslate("Brugerdefinerede URLer",9)%></TITLE>
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

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Brugerdefinerede URLer",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<FORM method="post" action="ControlPanel_Save.aspx?Type=URL" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type="hidden" name="CheckboxNames">
		<TR>
			<TD valign="top">
				<%=Gui.MakeModuleHeader("SearchFriendlyUrls", "Brugerdefinerede URLer", False)%>

				<%If Session("DW_Admin_UserType") < 4 Then%>
					<%If Base.HasVersion("18.9.1.0") Then%>
					
					<%=(Gui.GroupBoxStart(Translate.Translate("Url")))%>
					<%
					Dim UrlType As String = Base.GetGs("/Globalsettings/System/Url/Type")
					If UrlType = "" Then
						UrlType = "None"
					End If
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170"><%=Translate.Translate("URL type")%></td>
							<td><%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "None")%><label for="/Globalsettings/System/Url/TypeNone"><%=Translate.Translate("Kun standard")%>&nbsp;<code><%=Replace("(Default.aspx?ID=%i%)","%i%", "<i>" & Translate.Translate("Side-ID") & "</i>")%></code></label></td>
						</tr>
						<tr>
							<td></td>
							<td><%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "PageID")%><label for="/Globalsettings/System/Url/TypePageID"><%=Translate.Translate("Tekst med side ID")%>&nbsp;<code><%=Replace(Replace("(/%t%-%i%.aspx)","%i%", "<i>" & Translate.Translate("Side-ID") & "</i>"),"%t%", "<i>" & Translate.Translate("Tekst") & "</i>")%></code></label><br />
							<img src="/Admin/Images/Nothing.gif" width="20" /><%=Translate.Translate("Tekst")%>:&nbsp;<input type="text" name="/Globalsettings/System/Url/TypePageID/Prefix" id="/Globalsettings/System/Url/TypePageID/Prefix" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/System/Url/TypePageID/Prefix"))%>" maxlength="25" style="width:200px;" class="std"><br></td>
						</tr>						
						<tr>
							<td></td>
							<td><%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "PagenameID")%><label for="/Globalsettings/System/Url/TypePagenameID"><%=Translate.Translate("Sidenavn og side ID")%>&nbsp;<code><%=Replace(Replace("(/%s%-%i%.aspx)","%i%", "<i>" & Translate.Translate("Side-ID") & "</i>"),"%s%", "<i>" & Translate.Translate("Sidenavn") & "</i>")%></code></label><br></td>
						</tr>
						<tr>
							<td></td>
							<td><%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "PagenameQS")%><label for="/Globalsettings/System/Url/TypePagenameQS"><%=Translate.Translate("Sidenavn med ID")%>&nbsp;<code><%=Replace(Replace("(/%s%.aspx?ID=%i%)","%i%", "<i>" & Translate.Translate("Side-ID") & "</i>"),"%s%", "<i>" & Translate.Translate("Sidenavn") & "</i>")%></code></label><br></td>
						</tr>
						<tr>
							<td></td>
							<td><%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "Path")%><label for="/Globalsettings/System/Url/TypePath"><%=Translate.Translate("Placering og sidenavn")%>&nbsp;<code><%=Replace(Replace("(/%p%/.../%s%.aspx)","%p%", "<i>" & Translate.Translate("Sti") & "</i>"),"%s%", "<i>" & Translate.Translate("Sidenavn") & "</i>")%></code></label><br>
							<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UseAreaNameInPath") = "True", "checked", "")%> id="/Globalsettings/System/Url/UseAreaNameInPath" name="/Globalsettings/System/Url/UseAreaNameInPath"><label for="/Globalsettings/System/Url/UseAreaNameInPath"><%=Translate.Translate("Start med sproglagets navn")%></label><br />
							<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UseAreaRegionalInPath") = "True", "checked", "")%> id="/Globalsettings/System/Url/UseAreaRegionalInPath" name="/Globalsettings/System/Url/UseAreaRegionalInPath"><label for="/Globalsettings/System/Url/UseAreaRegionalInPath"><%=Translate.Translate("Use ISO code from regional settings (i.e. en-GB)")%></label><br />
							<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UniqueForEachLanguage") = "True", "checked", "")%> id="/Globalsettings/System/Url/UniqueForEachLanguage" name="/Globalsettings/System/Url/UniqueForEachLanguage"><label for="/Globalsettings/System/Url/UniqueForEachLanguage"><%=Translate.Translate("Ensure unique paths for each area (Requires unique domain for each area) (WARNING: This can break links on your website.)")%></label>
							</td>
						</tr>
						
						<%If Base.HasVersion("18.10.1.0") Then%>
						<tr>
							<td><%=Translate.Translate("Interne links")%></td>
							<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/ParseContentURL") = "True", "checked", "")%> id="/Globalsettings/System/Url/ParseContentURL" name="/Globalsettings/System/Url/ParseContentURL"><label for="/Globalsettings/System/Url/ParseContentURL"><%=Translate.Translate("Brug brugerdefinerede URLer")%></label></td>
						</tr>
						<%End If%>

						<tr>
							<td valign="top"><%=Translate.Translate("Formatering")%></td>
							<td>
							<%
							'Changed by NP 27/4-2006
							Dim TrimSpaces As String = Base.GetGs("/Globalsettings/System/Url/TrimSpaces")
							If TrimSpaces = "" Or TrimSpaces = "False" Then
								TrimSpaces = "KeepSpaces"
							End If
							If TrimSpaces = "True" Then
								TrimSpaces = "Underscore"
							End If
							If TrimSpaces <> "KeepSpaces" AND TrimSpaces <> "Underscore" AND TrimSpaces <> "Hyphen" Then
								TrimSpaces = "KeepSpaces"
							End If
							%>
							<%=Gui.RadioButton(TrimSpaces, "/Globalsettings/System/Url/TrimSpaces", "KeepSpaces")%><label for="/Globalsettings/System/Url/TrimSpacesKeepSpaces"><%=Translate.Translate("Ingen")%></label><br />
							<%=Gui.RadioButton(TrimSpaces, "/Globalsettings/System/Url/TrimSpaces", "Hyphen")%><label for="/Globalsettings/System/Url/TrimSpacesHyphen"><%=Translate.Translate("Erstat [Space] med [dash]")%></label><br />
							<%=Gui.RadioButton(TrimSpaces, "/Globalsettings/System/Url/TrimSpaces", "Underscore")%><label for="/Globalsettings/System/Url/TrimSpacesUnderscore"><%=Translate.Translate("Erstat [Space] med [underscore]")%></label><br />
							</td>
						</tr>
						<%If Base.HasVersion("18.10.1.0") Then%>
						<tr>
							<td></td>
							<td><input id="/Globalsettings/System/Url/CaseInsensitive" <%=IIf(Base.GetGs("/Globalsettings/System/Url/CaseInsensitive") = "True", "checked", "")%>="" name="/Globalsettings/System/Url/CaseInsensitive" type="checkbox" value="True"><label for="/Globalsettings/System/Url/CaseInsensitive"><%=Translate.Translate("Case insensitive URLs")%></label></td>
						</tr>
						<%End If%>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%Else%>
					<table>
						<tr>
							<td><%=Translate.Translate("Du har ikke adgang til modulet")%></td>
						</tr>
					</table>
					<%End If%>
					
					<%If Base.HasVersion("18.10.1.0") Then%>
						<%=(Gui.GroupBoxStart(Translate.Translate("E-mail")))%>
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td width="170"></td>
								<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/EmailMunging") = "True", "checked", "")%> id="/Globalsettings/System/Url/EmailMunging" name="/Globalsettings/System/Url/EmailMunging"><label for="/Globalsettings/System/Url/EmailMunging"><%=Translate.Translate("Masker_e-mailadresser")%></label></td>
							</tr>						
						</table>
						<%=Gui.GroupBoxEnd()%>
					<%End If%>
					
						<%=(Gui.GroupBoxStart(Translate.Translate("Indeksering")))%>
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td width="170"></td>
								<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/DisableRobotsOnDwUrl") = "True", "checked", "")%> id="/Globalsettings/System/Url/DisableRobotsOnDwUrl" name="/Globalsettings/System/Url/DisableRobotsOnDwUrl"><label for="/Globalsettings/System/Url/DisableRobotsOnDwUrl"><%=Translate.Translate("Brug noindex,nofollow ved *.dynamicweb.* url'er")%></label></td>
							</tr>
							<tr>
								<td width="170">
								</td>
								<td>
									<input id="/Globalsettings/System/Url/DisableRobotsOnPrinterFriendly" <%=IIf(Base.GetGs("/Globalsettings/System/Url/DisableRobotsOnPrinterFriendly") = "True", "checked", "")%>=""
										name="/Globalsettings/System/Url/DisableRobotsOnPrinterFriendly" type="checkbox"
										value="True"><label for="/Globalsettings/System/Url/DisableRobotsOnPrinterFriendly"><%=Translate.Translate("Brug noindex,nofollow ved printvenlige sider")%></label></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
					
					
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
									<%If Session("DW_Admin_UserType") < 4 Then%>
										<%=Gui.Button(Translate.Translate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%>
									<%End If%>
								</TD>
								<TD>
									<%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%>
								</TD>
								<%=Gui.HelpButton("", "administration.controlpanel.searchfriendlyurls")%>
								<TD width="2"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TD>
		<TR>
	</FORM>
</TABLE>
<script language="javascript">
var objForm = document.getElementById('frmGlobalSettings')
var objFormElement = objForm.elements["/Globalsettings/System/Url/TypePageID/Prefix"]
if (objFormElement.value == ""){
	objFormElement.value = "Page";
}
</script>
<%
Translate.GetEditOnlineScript()
%>
