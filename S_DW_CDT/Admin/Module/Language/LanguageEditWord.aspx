<%@ Page CodeBehind="LanguageEditWord.aspx.vb" ValidateRequest="false" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.LanguageEditWord" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<SCRIPT LANGUAGE="JavaScript">
<!--

function cc(objRow){ //Change color of row when mouse is over... (ChangeColor)
	objRow.style.backgroundColor='#E1DED8';
}

function ccb(objRow){ //Remove color of row when mouse is out... (ChangeColorBack)
	objRow.style.backgroundColor='';
}

function PickXandY(alt, lan) {
	//alert('LanguageEditWord.aspx?Page=<%=PagePath%>&js=<%=strJavaScript%>&translated=<%=strTranslated%>&word=<%=strWord%>&Language=' + lan +  '&intAlt=' + alt + '&key=<%=strKey%>');
	location='LanguageEditWord.aspx?Page=<%=PagePath%>&js=<%=strJavaScript%>&translated=<%=strTranslated%>&word=<%=Replace(strWord, "'", "\'")%>&Language=' + lan +  '&intAlt=' + alt + '&key=<%=Replace(strKey, "'", "\'")%>';
	
}
//-->
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<title><%=Translate.JSTranslate("Terminologi Editor")%></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</HEAD>

<BODY>

<%= Gui.MakeHeaders(Translate.Translate("%m% - %c%", "%m%", Translate.Translate("Terminologi Editor"), "%c%", strKey) & "<br><br>", Translate.Translate("Rediger %%", "%%", Translate.Translate("ord")) & ", " & Translate.Translate("Beskrivelse") & ", " & Translate.Translate("Matrix") & ", " & Translate.Translate("Filer"), "all") %>
<table border="0" cellspacing="0" cellpadding="0" class=tabTable>
	<form method="post" name="LanguageEditWord" action="">
		<tr align="top" valign="top">
			<td>
				<div ID="Tab1" STYLE="display:<%=Base.Iif((SelectTab="" or SelectTab="1"), "", "None")%>;">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr height=5>
							<td>
								<input type="hidden" value="" name="SaveForm">
								<input type="hidden" value="" name="ResetLang" id="ResetLang">
								<input type="hidden" value="<%=Request.QueryString("onlineTrans")%>" name="onlineTrans" id="onlineTrans">
								<input type="hidden" value="<%=NewAlt%>" name="NewAlt">
								<input type="hidden" value="<%=SelectTab%>" name="SelectTab">
							</td>
						</tr>
						<tr>
							<td>
								<%=Gui.GroupBoxStart(Translate.Translate("Ord"))%>
									<table cellpadding="2" cellspacing="0">
										<tr>
											<td width="170">
												<%=Translate.Translate("Nøgle")%>
											</td>
											<td>
												<input readonly type="text" name="AreaName" value="<%=Base.ChkValues(strKey)%>" maxlength="255" class=std>
											</td>
										</tr>
										<TR>
											<td>
												<%=Translate.Translate("Default")%>
											</td>
											<td>
												<input type="text" <%=Base.Iif(ChangeDefault=0, "readonly", "")%> name="Default" value="<%=Base.ChkValues(strDefault)%>" maxlength="255" class=std>&nbsp;<input type="checkbox" onclick="LanguageEditWord.SelectTab.value='1';LanguageEditWord.submit();" name="ChangeDefault" value="1" <%=Base.Iif(ChangeDefault=1, "Checked", "")%>><%=Translate.Translate("Rediger %%", "%%", Translate.Translate("default"))%>
											</td>
										</TR>
										<TR>
											<td>
												<%=Translate.Translate("JavaScript",1)%>
											</td>
											<td>
												<input type="checkbox" disabled name="javascript" <%=Base.Iif(strJavascript="True", "Checked", "")%>>
											</td>
										</TR>
										<TR>
											<td>
												<%=Translate.Translate("Alternativ")%>
											</td>
											<td>
												<select onchange="LanguageEditWord.submit();" name="alternative"><%=strAlternative%></select>
												&nbsp;<%=Gui.Button(Translate.Translate("Ny alternativ"), "LanguageEditWord.NewAlt.value='true';LanguageEditWord.submit();", 0)%>&nbsp;
												<%
												if NewAlt = "true" Then
													Response.Write(Gui.Button(Translate.Translate("Fjern ny alternativ"), "LanguageEditWord.NewAlt.value='';LanguageEditWord.submit();", 0))
												End If
												%>
											</td>
										</TR>
										<TR>
											<td>
												<%=Translate.Translate("Sprog")%>
											</td>
											<td>
												<select onchange="LanguageEditWord.submit();" name="Language"><%=strLanguage%></select>
											</td>
										</TR>
										<TR>
											<td>
												<%=Translate.Translate("Ord")%>
											</td>
											<td>
												<input type="text" name="Word" value="<%=Base.ChkValues(strWord)%>" maxlength="255" class=std>
											</td>
										</TR>
									</table>
								<%=Gui.GroupBoxEnd()%>
							</td>
						</tr>
					</table>
				</div>
				
				<div ID="Tab2" STYLE="display:<%=Base.Iif(SelectTab="2", "", "None")%>;" align="top" valign="top">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr height=5>
							<td>
							</td>
						</tr>
						<tr align="top" valign="top">
							<td>
								<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
									<table cellpadding="2" cellspacing="0">
										<tr>
											<td colspan="2">
												<textarea <%=Base.Iif(EditDescription=0, "readonly", "")%> cols="60" rows="15"  name="Description" ><%=strDescription%></textarea>
											</td>
										</tr>
										<TR>
											<td>
												
											</td>
											<td>
											<input type="checkbox" onclick="LanguageEditWord.SelectTab.value='2';LanguageEditWord.submit();" name="EditDescription" value="1" <%=Base.Iif(EditDescription=1, "Checked", "")%>><%=Translate.Translate("Rediger %%", "%%", Translate.Translate("beskrivelse"))%>
											</td>
										</TR>
									</table>
								<%=Gui.GroupBoxEnd()%>
							</td>
						</tr>
					</Table>
				</Div>
				<div ID="Tab3" STYLE="display:<%=Base.Iif(SelectTab="3", "", "None")%>;" align="top" valign="top">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr height=5>
							<td>
							</td>
						</tr>
						<tr  align="top" valign="top">
							<td>
								<%=Gui.GroupBoxStart(Translate.Translate("Matrix"))%>
									<table cellpadding="2" cellspacing="0">
										<tr>
											<td colspan="3">&nbsp;
											</td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td>
												<%=GetMatrix()%><br>
											</td>
											<td valign="top" width="200px">
												&nbsp;<%=strAltDescription%><br>
											</td>
											
										</tr>
									</table>
								<%=Gui.GroupBoxEnd()%>
							</td>
						</tr>
					</Table>
				</Div>
				<div ID="Tab4" STYLE="display:<%=Base.Iif(SelectTab="4", "", "None")%>;" align="top" valign="top">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr height=5>
							<td>
							</td>
						</tr>
						<tr  align="top" valign="top">
							<td>
								<%=Gui.GroupBoxStart(Translate.Translate("Filer"))%>
									<table cellpadding="2" cellspacing="0">
										<tr>
											<td colspan="3">&nbsp;
											</td>
										</tr>
										<tr>
											<td>&nbsp;
											</td>
											<td>
												<%=strFileList%><br>
											</td>
											<td valign="top" width="200px">
												&nbsp;
											</td>
											
										</tr>
									</table>
								<%=Gui.GroupBoxEnd()%>
							</td>
						</tr>
					</Table>
				</Div>
				</td>
			</tr>
			<tr  align="right" valign="bottom">
				<td>
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="right" valign="bottom">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td align="right"><%=Gui.Button(Translate.Translate("Ord liste"), "location='/Admin/Module/Language/LanguageEditPage.aspx?page=" & PagePath & "&Back=yes';", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("OK"), "LanguageEditWord.NewAlt.value='';LanguageEditWord.SaveForm.value='true';LanguageEditWord.submit();", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("Luk"), "window.close();", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("Reset Lang."), "LanguageEditWord.ResetLang.value='true';LanguageEditWord.submit();", 0)%></td>
										<td width="5"></td>
									</tr>
									<tr>
										<td colspan="6" height="5"></td>
									</tr>			
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</FORM>
</BODY>
</HTML>

<%
Dim TabID As String = SelectTab
Dim strTemp As String
If Not TabID = "" Then
    strTemp = "<script>" & vbNewLine
    strTemp += "	if (document.all.Tab" & TabID & "[0]) {" & vbNewLine
    strTemp += "		document.all.Tab" & TabID & "[0].click();" & vbNewLine
    strTemp += "	}" & vbNewLine
    strTemp += "</script>" & vbNewLine
End If
response.write( strTemp)
        
'	Translate.GetEditOnlineScript()
%>