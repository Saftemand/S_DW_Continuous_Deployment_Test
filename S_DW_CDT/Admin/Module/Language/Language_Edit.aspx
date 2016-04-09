<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="Language_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Language_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<SCRIPT LANGUAGE="JavaScript">
<!--

function LanguageDelete(ID)
{
	if(confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("sprog"))%>'))
	{
		document.location = "Language_Del.aspx?caller=<%=Caller%>&Type=Delete&ID=" + ID;
	}
}

function EncodingDelete(EditCharSets)
{
	if(confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("encoding"))%>'))
	{
		document.location = "Encoding_Del.aspx?caller=<%=Caller%>&Type=Delete&EditCharSet=" + EditCharSets;
	}
}

function WordsDelete(DelWordKey)
{
	if(confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("ord",1))%>'))
	{
		document.location = "Words_Del.aspx?Type=Delete&DelWordKey=" + DelWordKey;
	}
}

function ClearForm(tab)
{
	document.location = "Language_Edit.aspx?caller=<%=Caller%>&Tab=Tab" + tab;
}

function LanguageActivate(ID, Active)
{
	document.location = "Language_Save.aspx?caller=<%=Caller%>&Type=Activate&ID=" + ID + "&Active=" + Active;
}

function CheckForm()
{
	if(frmLanguage.LanguageName.value != "")
		frmLanguage.submit();
	else
		alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
}

function EditText(Key, alt, lang, word)
{
	//window.open('LanguageEditWord.aspx?js=False&translated=True&word=' + word + '&intAlt=' + alt + '&key=' + Key + '&language=' + lang, "	"
	window.open('LanguageEditWord.aspx?onlineTrans=false&TermListe="bbr"&Page=/Admin/&js=False&translated=True&word=' + word + '&intAlt=' + alt + '&key=' + Key + '&language=' + lang, 'Edit_Words', 'resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=650,height=400,top=155,left=202');
	//document.location = "Language_Edit.aspx?WordsID=" + WordsID + "&Tab=Tab2&TypeRecall=<%=varTypes%>&SearchWordsRecall=<%=varSearchWords%>&SearchLanguageIDRecall=<%=varSearchLanguageID%>";
}

function EditEncodings(EncodingID)
{
	document.location = "Language_Edit.aspx?caller=<%=Caller%>&EncodingID=" + EncodingID + "&Tab=Tab3";
}

function SaveText()
{
	document.EditWord.Recall.value = "1"
	EditWord.submit();
}

function SaveEncoding()
{
	if(EditEncoding.EditCharSet.value != "" && EditEncoding.EditEncodingName.value != "" )
		EditEncoding.submit();
	else
		alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("%0% og %1%", "%0%", Translate.JsTranslate("Charset"), "%1%", Translate.JsTranslate("Navn")))%>');	
}

function SearchAllNotTranlated()
{
    document.location = "Language_Edit.aspx?caller=<%=Caller%>&Type=AllNotTranslatet&SearchLanguageID=" + document.getElementById('AllLanguagDropDown').options[document.getElementById('AllLanguagDropDown').selectedIndex].value + "&Tab=Tab2";
}

function JumpToIDs()
{
    document.location = "Language_Edit.aspx?caller=<%=Caller%>&WordsID=" + document.getElementById('JumpToID').value + "&Tab=Tab1";
}

function SearchForText()
{
    document.location = "Language_Edit.aspx?caller=<%=Caller%>&FindNotTrans=" + document.getElementById('FindNotTrans').checked + "&FileName=" + document.getElementById('FileName').value + "&Type=SearchWords&SearchWords=" + document.getElementById('word').value + "&Tab=Tab1&SearchLanguageID=" + document.getElementById('AllLanguagDropDown').value;
}

function popvalue()
{
alert(document.getElementById('AllLanguagDropDown').value)
}

function GetCodePage()
{
frmLanguage.LanguageCodePage.value = document.getElementById(document.getElementById('AreaEncodingDropDown').value).value;
}

//-->
</SCRIPT>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE></TITLE>
<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</HEAD>
<BODY>
<% 
    Dim headers As String = Translate.Translate("Kontrolpanel - %%", "%%", Translate.Translate("Brugergrænseflade"))
    If CalledFromManagementCenter Then
        headers = String.Empty
    End If
%>
<%=Gui.MakeHeaders(headers, Translate.Translate("Ord") + ", " + Translate.Translate("Sprog", 2) + ", " + Translate.Translate("Encodings"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="TabTable">
<!-- Region Terminologi -->
<TR style='display: <%=Base.IIF(CalledFromManagementCenter, "none", "")%>'>
	<TD>
		<%=Gui.MakeModuleHeader("Language", "Brugergrænseflade", False)%>
	</TD>
<TR>
<TR>
	<TD>
		<table bgcolor='#ffffe1' style='border: 1px solid Black;width: 95%;' cellpadding='2' align='center'><tr valign='top'><td width='20'><img src="/Admin/Images/icons/alert_small.gif" align="absmiddle" alt=""></td><td><%=Translate.JSTranslate("ADVARSEL!")%><br/><%=Translate.JSTranslate("Ændringer til disse indstillinger påvirker samtlige løsninger på serveren!")%></td></tr></table>
	</TD>
<TR>
	<TD>
		<div ID="Tab1" STYLE="display:;">
		<form Name="Search" method="Post" style="padding: 0px;" ID="frmTerm" action="">
		<input type="hidden" id="ResetLang" name="ResetLang">
		<input type="hidden" value="" name="SaveForm">
			<table cellpadding="0" cellspacing="0" border="0"><tr><td>
					<%=Gui.GroupBoxStart(Translate.Translate("Søg")) %>
						<TABLE border="0"  cellpadding="2" width="570">
							<tr>
							<td width="170"><%=Translate.Translate("Sprog")%></td>
							<td><%=sbLanguage.ToString%></td>
							</tr>	
							<tr>
							<TD><%=Translate.Translate("Filnavn")%></td>
								<td><INPUT id="FileName" tabindex="1" name="FileName"class="std"></td>
							</tr>
							<tr>
							<TD><%=Translate.Translate("Fritekst")%></td>
								<td><INPUT id="word" tabindex="2" name="word" class="std"></td>
							</tr>	
							<tr>
							<TD></td>
								<td><input type="checkbox" <%=Base.Iif(varFindNotTrans = "true", " CHECKED ", "")%> name="FindNotTrans" id="FindNotTrans" onclick="JavaScript:Search.word.value='';Search.FileName.value='';"> <%=Translate.Translate("Find ikke oversatte ord")%></td>
							</tr>	
						</table>
						<table align="right" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td colspan="3" height="5"></td>
							</tr>
							<tr>
							<td><%=Gui.Button(Translate.Translate("Søg"), "SearchForText();", 0)%></td>
							<td width="5"></td>
							<td><%=Gui.Button(Translate.Translate("Nulstil"), "ClearForm(1);", 0)%></td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>
				</form>
			</td></tr>
			<tr style='display: <%=Base.IIF(CalledFromManagementCenter, "none", "")%>'><td>
				<table align="right" border="0" cellpadding="0" cellspacing="0"><tr>
							<td><%=Gui.Button(Translate.Translate("Luk"), "location='/Admin/Module/ControlPanel.aspx';", 0)%></td>
							<td width="5"></td>
				</tr></table>
			</td></tr>
			<tr><td>
				<%If varTypes <> "" Then%>
					<br />
					<%=Gui.GroupBoxStart(Translate.Translate("Ord liste"))%>
					<TABLE border="0"  cellpadding="2" width="570">
						<%=sbSearch.ToString%>
					</table>
					<%=Gui.GroupBoxEnd%>
					<br />
				<%  End If%>
			</tr></td></table>
		</div>

<!-- End Region Terminologi -->
<!-- Region Sprog -->

		<div ID="Tab2" STYLE="display:None;">
		<table cellpadding="0" cellspacing="0" border="0"><tr><td>
			<FORM method="post" Action="Language_Save.aspx?caller=<%=Caller%>" name="frmLanguage" id="frmLanguage">
					<%=Gui.GroupBoxStart(Translate.Translate("Opret/Edit"))%>
						<TABLE border="0"  cellpadding="2" width="570">
							<TR>
							<TD width="170"><INPUT type="Hidden" Name="ID" value="<%=varLanguageID%>" ID="ID"><%=Translate.Translate("Sprognavn")%></TD>
								<TD><INPUT type="text" maxlength="255" name="LanguageName" value="<%=varLanguageName%>" id="LanguageName" class="std"></TD>
							</TR>
							<TR>
						<TD><%=Translate.Translate("Kort datoformat")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageDateFormatShort" value="<%=varLanguageDateFormatShort%>" id="LanguageDateFormatShort" class="std"></TD>
							</TR>
							<TR>
						<TD><%=Translate.Translate("Kort datoformat med tid")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageDateFormatShortAndTime" value="<%=varLanguageDateFormatShortAndTime%>" id="LanguageDateFormatShortAndTime" class="std"></TD>
							</TR>
							<TR>
						<TD><%=Translate.Translate("Mellem datoformat")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageDateFormatMedium" value="<%=varLanguageDateFormatMedium%>" id="LanguageDateFormatMedium" class="std"></TD>
							</TR>
							<TR>
						<TD><%=Translate.Translate("Mellem datoformat med tid")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageDateFormatMediumAndTime" value="<%=varLanguageDateFormatMediumAndTime%>" id="LanguageDateFormatMediumAndTime" class="std"></TD>
							</TR>
							<TR>
						<TD><%=Translate.Translate("Langt datoformat")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageDateFormatLong" value="<%=varLanguageDateFormatLong%>" id="LanguageDateFormatLong" class="std"></TD>
							</TR>
							<TR>
						<TD><%=Translate.Translate("Langt datoformat med tid")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageDateFormatLongAndTime" value="<%=varLanguageDateFormatLongAndTime%>" id="LanguageDateFormatLongAndTime" class="std"></TD>
							</TR>
							<TR>
						<TD><%=Translate.Translate("Datoformat til drop down")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageDateFormatDropDown" value="<%=varLanguageDateFormatDropDown%>" id="LanguageDateFormatDropDown" class="std"></TD>
							</TR>
							<TR>
						<TD><%=Translate.Translate("Datoformat til drop down med tid")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageDateFormatDropDownAndTime" value="<%=varLanguageDateFormatDropDownAndTime%>" id="LanguageDateFormatDropDownAndTime" class="std"></TD>
							</TR>

						<TR>
						<TD><%=Translate.Translate("Landestandard ID")%></TD>
								<TD><INPUT type="test" maxlength="250" name="LanguageLocale" value="<%=varLanguageLocale%>" id="LanguageLocale" class="std"></TD>
							</TR>
						</TABLE>
				<table align="right" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="3" height="5"></td>
			</tr>
			<tr>
							<td><%=Gui.Button(Translate.Translate("OK"), "CheckForm()", 0)%></td>
							<td width="5"></td>
							<td><%=Gui.Button(Translate.Translate("Nulstil"), "ClearForm(2);", 0)%></td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd%>
			</form>
		</td></tr>
		<tr style='display: <%=Base.IIF(CalledFromManagementCenter, "none", "")%>'><td>
				<table align="right" border="0" cellpadding="0" cellspacing="0"><tr>
							<td><%=Gui.Button(Translate.Translate("Luk"), "location='/Admin/Module/ControlPanel.aspx';", 0)%></td>
							<td width="5"></td>
				</tr></table>
			</td></tr>
			<tr>
				<td>
					<br />
					<%=Gui.GroupBoxStart(Translate.Translate("Sprog liste"))%>
					<%=sbLanguageList.tostring%>
					<%=Gui.GroupBoxEnd()%>
				</td>
			</tr>
		</table>
		<br />
		</div>

<!-- End Region Sprog -->
<!-- Region Encoding -->
			
		<div ID="Tab3" STYLE="display:None;">
		<table cellpadding="0" cellspacing="0" border="0"><tr><td>
					<form Name="EditEncoding" Action="Encoding_Save.aspx?caller=<%=Caller%>" method="Post" id="frmEncoding">
					<%=Gui.GroupBoxStart(Translate.Translate("Opret/Edit"))%>
						<TABLE border="0" cellpadding="2" cellspacing="0" width="570">
							<TR>
								<TD width="170"><%=Translate.Translate("Charset")%></TD>
								<TD><INPUT tabindex="1" maxlength="250" name="EditCharSet" value="<%=varEditCharSet%>" id="EditCharSet" class="std"></TD>
							</TR>
							<TR>
								<TD><%=Translate.Translate("Navn")%></TD>
								<TD><INPUT tabindex="3" maxlength="250" name="EditEncodingName" value="<%=varEditEncodingName%>" id="EditEncodingName" class="std"></TD>
							</TR>
							<TR>
								<TD><%=Translate.Translate("CodePage")%></TD>
								<TD><INPUT tabindex="4" maxlength="250" name="EditCodePage" value="<%=varEditCodePage%>" id="EditCodePage" class="std"></TD>
							</TR>
						</TABLE>
						<table border="0" cellpadding="0" cellspacing="0" align="right" ID="Table2">
							<tr>
								<td colspan="3" height="5"></td>
							</tr>
							<tr>
								<td><%=Gui.Button(Translate.Translate("OK"), "SaveEncoding();", 0)%></td>
								<td width="5"></td>
								<td><%=Gui.Button(Translate.Translate("Nulstil"), "ClearForm(3);", 0)%></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</form>
				</td>
			</tr>
			<tr style='display: <%=Base.IIF(CalledFromManagementCenter, "none", "")%>'>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" align="right">
						<tr>
							<td><%=Gui.Button(Translate.Translate("Luk"), "location='/Admin/Module/ControlPanel.aspx';", 0)%></td>
							<td width="5"></td>
						</tr>

					</table>
				</td>
			</tr>
			<tr>
				<td>
					<br />
					<%=Gui.GroupBoxStart(Translate.Translate("Encoding liste"))%>
					<%=sbEncodingList.ToString%>
					<%=Gui.GroupBoxEnd()%>
				</td>
			</tr>
		</table>
		<br />
		</div>
<!-- End Region Encoding -->
	</td></tr>
</TABLE>

<%

'Translate.GetEditOnlineScript()
%>
	<BODY>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>