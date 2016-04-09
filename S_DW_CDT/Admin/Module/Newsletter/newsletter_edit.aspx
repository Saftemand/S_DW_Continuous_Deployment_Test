<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ Page CodeBehind="newsletter_edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim ParagraphID As Integer
Dim NewslettersChecked As New HashTable
Dim arrSNewsletters() As String
Dim Rows As Integer
Dim tmp As String
Dim sql As String
Dim i As Integer



If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(request("ParagraphID"))
Else
	ParagraphID = 0
End If

Dim propObj As new Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        propObj = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        propObj.Value("NewsletterParagraphType") = "1"
        propObj.Value("NewsletterParagraphSTextAboveForm") = ""
        propObj.Value("NewsletterParagraphSSubmitBtnText") = Translate.Translate("OK")
        propObj.Value("NewsletterParagraphSSubmitBtnText") = ""
        propObj.Value("NewsletterParagraphSConfirmText") = ""
        propObj.Value("NewsletterParagraphSConfirmShowData") = True
        propObj.Value("NewsletterParagraphSNeedConfirmAction") = False
        propObj.Value("NewsletterParagraphSMAilSubject") = ""
        propObj.Value("NewsletterParagraphSMailText") = ""
        propObj.Value("NewsletterParagraphSMailSender") = ""
        propObj.Value("NewsletterParagraphSScreenText") = ""
        propObj.Value("NewsletterParagraphSNewsletters") = ""
        propObj.Value("NewsletterParagraphSNameFieldText") = Translate.Translate("Navn")
        propObj.Value("NewsletterParagraphSEmailFieldText") = Translate.Translate("E-mail")
        propObj.Value("NewsletterParagraphSFormat") = 1
        propObj.Value("NewsletterParagraphSFormatFieldText") = Translate.Translate("E-mailformat")
        propObj.Value("NewsletterParagraphSBtn") = 1
        propObj.Value("NewsletterParagraphSBtnText") = Translate.Translate("Tilmeld")
        propObj.Value("NewsletterParagraphSBtnImage") = ""
        propObj.Value("NewsletterParagraphUSTextAboveForm") = ""
        propObj.Value("NewsletterParagraphUSConfirmCaption") = ""
        propObj.Value("NewsletterParagraphUSConfirmText") = ""
        propObj.Value("NewsletterParagraphUSNeedConfirmAction") = False
        propObj.Value("NewsletterParagraphUSMailSubject") = ""
        propObj.Value("NewsletterParagraphUSMailText") = ""
        propObj.Value("NewsletterParagraphUSMailSender") = ""
        propObj.Value("NewsletterParagraphUSScreenText") = ""
        propObj.Value("NewsletterParagraphUSEmailFieldText") = Translate.Translate("E-mail")
        propObj.Value("NewsletterParagraphUSBtn") = 1
        propObj.Value("NewsletterParagraphUSBtnText") = Translate.Translate("Afmeld")
        propObj.Value("NewsletterParagraphUSBtnImage") = ""
        propObj.Value("NewsletterParagraphListOrdering") = "0"
        propObj.Value("NewsletterEncodingUsed") = "utf-8"
    End If


If propObj.Value("NewsletterParagraphSNewsletters") <> "" Then
	arrSNewsletters = Split(propObj.Value("NewsletterParagraphSNewsletters"), ",")
	For i = 0 To UBound(arrSNewsletters)
		NewslettersChecked.Add(Trim(arrSNewsletters(i)), "True")
	Next 
End If
%>
<input type="hidden" name="Newsletter_settings" value="NewsletterParagraphType, NewsletterParagraphSTextAboveForm, NewsletterParagraphSSubmitBtnText, NewsletterParagraphSConfirmCaption, NewsletterParagraphSConfirmText, NewsletterParagraphSConfirmShowData, NewsletterParagraphSNeedConfirmAction, NewsletterParagraphSMAilSubject, NewsletterParagraphSMailText, NewsletterParagraphSMailSender, NewsletterParagraphSScreenText, NewsletterParagraphSNewsletters, NewsletterParagraphSNameFieldText, NewsletterParagraphSEmailFieldText, NewsletterParagraphSFormat, NewsletterParagraphSFormatFieldText, NewsletterParagraphUSTextAboveForm, NewsletterParagraphUSConfirmCaption, NewsletterParagraphUSConfirmText, NewsletterParagraphUSNeedConfirmAction, NewsletterParagraphUSMailSubject, NewsletterParagraphUSMailText, NewsletterParagraphUSMailSender, NewsletterParagraphUSScreenText, NewsletterParagraphUSEmailFieldText, NewsletterParagraphSBtn, NewsletterParagraphSBtnText, NewsletterParagraphSBtnImage, NewsletterParagraphUSBtn, NewsletterParagraphUSBtnText, NewsletterParagraphUSBtnImage, NewsletterParagraphListOrdering, NewsletterEncodingUsed">
<script language="Javascript">
function toggleType(){
	if (document.all["subscribe"].checked){
		document.all["SubscriptionGroup"].style.display = "";
		document.all["UnsubscriptionGroup"].style.display = "none";
	}else if (document.all["unsubscribe"].checked){
		document.all["UnsubscriptionGroup"].style.display = "";
		document.all["SubscriptionGroup"].style.display = "none";
	}else{
		document.all["UnsubscriptionGroup"].style.display = "";
		document.all["SubscriptionGroup"].style.display = "";
	}
}

function toggleSConfirmMailText(){
	if (document.all["NeedConf1"].checked){
		document.all["SConfirmTexts"].style.display="";
	}else{
		document.all["SConfirmTexts"].style.display="none";
	}
}

function toggleUSConfirmMailText(){
	if (document.all["NeedUConf1"].checked){
		document.all["USConfirmTexts"].style.display="";
	}else{
		document.all["USConfirmTexts"].style.display="none";
	}
}

function toggleSSubmitBtn(){
	if (document.all["SBtn1"].checked){
		document.all["SShowBtn1"].style.display = "";
		document.all["SShowBtn2"].style.display = "none";
	}else{
		document.all["SShowBtn1"].style.display = "none";
		document.all["SShowBtn2"].style.display = "";
	}
}

function toggleUSSubmitBtn(){
	if (document.all["USBtn1"].checked){
		document.all["USShowBtn1"].style.display = "";
		document.all["USShowBtn2"].style.display = "none";
	}else{
		document.all["USShowBtn1"].style.display = "none";
		document.all["USShowBtn2"].style.display = "";
	}
}

function select(mode){
	if(document.paragraph_edit.NewsletterParagraphSNewsletters.length){
		for (i = 0; i < document.paragraph_edit.NewsletterParagraphSNewsletters.length;i++){
			document.paragraph_edit.NewsletterParagraphSNewsletters[i].checked = mode;
		}
	}else{
		document.paragraph_edit.NewsletterParagraphSNewsletters.checked = mode;
	}
}
</script>
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("newsletter", "Nyhedsbrev")%>
	</TD>
</TR>
	<TR>
		<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170" align="left"><%=Translate.Translate("Vis")%></td>
				<td><input type="radio" name="NewsletterParagraphType" value="1" id="both" onclick="toggleType();"<%If propObj.Value("NewsletterParagraphType") = "1" Or propObj.Value("NewsletterParagraphType") = "" Then%> checked<%End If%>></td>
				<td><label for="both"><%=Translate.Translate("Til- og afmelding")%></label></td>
				<td><input type="radio" name="NewsletterParagraphType" value="2" id="subscribe" onclick="toggleType();"<%If propObj.Value("NewsletterParagraphType") = "2" Then%> checked<%End If%>></td>
				<td><label for="subscribe"><%=Translate.Translate("Tilmelding")%></label></td>
				<td><input type="radio" name="NewsletterParagraphType" value="3" id="unsubscribe" onclick="toggleType();"<%If propObj.Value("NewsletterParagraphType") = "3" Then%> checked<%End If%>></td>
				<td><label for="unsubscribe"><%=Translate.Translate("Afmelding")%></label></td>
			</tr>
			<tr>
				<td width="170" align="left"><%=Translate.Translate("Encoding")%></td>
				<td colspan="6"><%=Gui.EncodingList(propObj.Value("NewsletterEncodingUsed"), "NewsletterEncodingUsed", True)%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>

		<div id="SubscriptionGroup" style="display:<%If propObj.Value("NewsletterParagraphType") = "3" Then Response.Write(" none")%>;">
		<%=Gui.GroupBoxStart(Translate.Translate("Tilmelding"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td nowrap valign="top" width="170" align="left"><%=Translate.Translate("Tekst før formular")%></td>
				<td><textarea name="NewsletterParagraphSTextAboveForm" rows="4" class="std"><%=propObj.Value("NewsletterParagraphSTextAboveForm")%></textarea>
			</tr>
			<tr>
				<td nowrap><%=Translate.Translate("Kvittering overskrift")%></td>
				<td><input type="text" name="NewsletterParagraphSConfirmCaption" value="<%=propObj.Value("NewsletterParagraphSConfirmCaption")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td valign="top" nowrap><%=Translate.Translate("Kvittering tekst")%></td>
				<td><textarea name="NewsletterParagraphSConfirmText" rows="4" class="std"><%=propObj.Value("NewsletterParagraphSConfirmText")%></textarea>
			</tr>
			<tr>
				<td nowrap><%=Translate.Translate("Vis data på kvittering")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterParagraphSConfirmShowData" id="showdat1" value="true"<%If Base.ChkBoolean(propObj.Value("NewsletterParagraphSConfirmShowData")) = True Then%> checked<%End If%>></td>
							<td><label for="showdat1"><%=Translate.Translate("Ja")%></label></td>
							<td><input type="radio" name="NewsletterParagraphSConfirmShowData" id="showdat2" value="false"<%If Base.ChkBoolean(propObj.Value("NewsletterParagraphSConfirmShowData")) = False Then%> checked<%End If%>></td>
							<td><label for="showdat2"><%=Translate.Translate("Nej")%></label></td>
							<td width="100%">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Bekræft tilmelding")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterParagraphSNeedConfirmAction" id="NeedConf1" value="true"<%If Base.ChkBoolean(propObj.Value("NewsletterParagraphSNeedConfirmAction")) = True Then%> checked<%End If%> onclick="toggleSConfirmMailText();"></td>
							<td><label for="NeedConf1"><%=Translate.Translate("Ja")%></label></td>
							<td><input type="radio" name="NewsletterParagraphSNeedConfirmAction" id="NeedConf2" value="false"<%If Base.ChkBoolean(propObj.Value("NewsletterParagraphSNeedConfirmAction")) = False Then%> checked<%End If%> onclick="toggleSConfirmMailText();"></td>
							<td><label for="NeedConf2"><%=Translate.Translate("Nej")%></label></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="SConfirmTexts" style="display:<%If Base.ChkBoolean(propObj.Value("NewsletterParagraphSNeedConfirmAction")) = False Then%> none<%End If%>;">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="174">&nbsp;&nbsp;<%=Translate.Translate("E-mail emne")%></td>
								<td><input type="text" name="NewsletterParagraphSMAilSubject" maxlength="255" class="std" value="<%=propObj.Value("NewsletterParagraphSMAilSubject")%>"></td>
							</tr>
							<tr>
								<td valign="top">&nbsp;&nbsp;<%=Translate.Translate("E-mail tekst")%></td>
								<td><textarea name="NewsletterParagraphSMailText" rows="4" maxlength="255" class="std"><%=propObj.Value("NewsletterParagraphSMailText")%></textarea></td>
							</tr>
							<tr>
								<td>&nbsp;&nbsp;<%=Translate.Translate("Afsenderadresse")%></td>
								<td><input type="text" name="NewsletterParagraphSMailSender" value="<%=propObj.Value("NewsletterParagraphSMailSender")%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td valign="top">&nbsp;&nbsp;<%=Translate.Translate("Tekst til skærm")%></td>
								<td><textarea name="NewsletterParagraphSScreenText" rows="4" class="std"><%=propObj.Value("NewsletterParagraphSScreenText")%></textarea></td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Tilmeldingsmuligheder")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td nowrap>&nbsp;<img src='/Admin/Images/CheckAll.gif' alt='<%=Translate.Translate("Vælg alle")%>' onclick='Javascript:select(1);'>&nbsp;<img src='/Admin/Images/CheckNone.gif' alt='<%=Translate.Translate("Fravælg alle")%>' onclick='Javascript:select(0);'></td>
						</tr>
						<%

		Dim cnNewsletter		As IDbConnection	= Database.CreateConnection("Newsletter.mdb")
		Dim cmdNewsletter		As IDbCommand		= cnNewsletter.CreateCommand
		cmdNewsletter.CommandText = "SELECT * FROM NewsletterCategory"
		Dim drNewsletter As IDataReader = cmdNewsletter.ExecuteReader()
		Rows = 0
		Do While drNewsletter.Read()
			With Response
				.Write("<tr><td nowrap><input type=""CheckBox"" name=""NewsletterParagraphSNewsletters"" id=""news" & drNewsletter("NewsletterCategoryID").ToString & """ value=""" & drNewsletter("NewsletterCategoryID").ToString & """")
				If NewslettersChecked.Item(drNewsletter("NewsletterCategoryID").ToString) = "True" Then
					.Write(" checked")
				End If
				.Write("><label for=""news" & drNewsletter("NewsletterCategoryID").ToString & """>" & drNewsletter("NewsletterCategoryName").ToString & "</label></td></tr>" & vbCrLf & vbCrLf) ' bbr
				''Rows = Rows + 1
				''If Rows/2 = CInt(Rows/2) And Not RS.EOF Then
				''	.Write "</tr><tr>"
				''End If
			End With
		Loop 
				''If Rows/2 <> CInt(Rows/2) Then
				''	Response.Write "<td colspan=""2"">&nbsp;</td>"
				''End If
				''End If
				
		drNewsletter.Close()
		drNewsletter.Dispose()
		cmdNewsletter.Dispose()
		cnNewsletter.Dispose()
		%>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="6px"></td>
				<td></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Sorter alfabetisk")%></td>
				<td><%=Gui.CheckBox(propObj.Value("NewsletterParagraphListOrdering"), "NewsletterParagraphListOrdering")%></td>
			</tr>

			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2"><strong><%=Translate.Translate("Brugerdefinerede tekster")%></strong></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Tilmeld") & "</em>" )%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterParagraphSBtn" id="SBtn1" value="1" onclick="toggleSSubmitBtn();"<%If propObj.Value("NewsletterParagraphSBtn") = "1" Or propObj.Value("NewsletterParagraphSBtn") = "" Then%> checked<%End If%>></td>
							<td><label for="SBtn1"><%=Translate.Translate("Tekst")%></label></td>
							<td><input type="radio" name="NewsletterParagraphSBtn" id="SBtn2" value="2" onclick="toggleSSubmitBtn();"<%If propObj.Value("NewsletterParagraphSBtn") = "2" Then%> checked<%End If%>></td>
							<td><label for="SBtn2"><%=Translate.Translate("Billede")%></label></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr id="SShowBtn1" style="display: <%If propObj.Value("NewsletterParagraphSBtn") <> "1" And propObj.Value("NewsletterParagraphSBtn") <> "" Then%> none<%End If%>">
				<td width="170">&nbsp;</td>
				<td><input type="text" name="NewsletterParagraphSBtnText" value="<%=propObj.Value("NewsletterParagraphSBtnText")%>" maxlength="255" class="std"></td>
			</tr>
			<tr id="SShowBtn2" style="display: <%If propObj.Value("NewsletterParagraphSBtn") <> "2" Then%> none<%End If%>">
				<td width="170">&nbsp;</td>
				<td><%= Gui.FileManager(propObj.Value("NewsletterParagraphSBtnImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsletterParagraphSBtnImage")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Navnefelt")%></td>
				<td><input type="text" name="NewsletterParagraphSNameFieldText" value="<%=propObj.Value("NewsletterParagraphSNameFieldText")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("E-mailfelt")%></td>
				<td><input type="text" name="NewsletterParagraphSEmailFieldText" value="<%=propObj.Value("NewsletterParagraphSEmailFieldText")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Bruger vælger format")%></td>
				<td><%=Gui.CheckBox(propObj.Value("NewsletterParagraphSFormat"), "NewsletterParagraphSFormat")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Mailformatfelt")%></td>
				<td><input type="text" name="NewsletterParagraphSFormatFieldText" value="<%=propObj.Value("NewsletterParagraphSFormatFieldText")%>" maxlength="255" class="std"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>

		<div id="UnsubscriptionGroup" style="display:<%If propObj.Value("NewsletterParagraphType") = "2" Then Response.Write(" none")%>;">
		<%=Gui.GroupBoxStart(Translate.Translate("Afmelding"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td nowrap valign="top" width="170" align="left"><%=Translate.Translate("Tekst før formular")%></td>
				<td><textarea name="NewsletterParagraphUSTextAboveForm" rows="4" cols="45" class="std"><%=propObj.Value("NewsletterParagraphUSTextAboveForm")%></textarea>
			</tr>
			<tr>
				<td nowrap><%=Translate.Translate("Kvittering overskrift")%></td>
				<td><input type="text" name="NewsletterParagraphUSConfirmCaption" value="<%=propObj.Value("NewsletterParagraphUSConfirmCaption")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td nowrap valign="top" width="170" align="left"><%=Translate.Translate("Kvittering tekst")%></td>
				<td><textarea name="NewsletterParagraphUSConfirmText" rows="4" cols="45" class="std"><%=propObj.Value("NewsletterParagraphUSConfirmText")%></textarea>
			</tr>
			<tr>
				<td valign="top" width="170" align="left"><%=Translate.Translate("Bekræft afmelding")%></td>
				<td nowrap align="left">
					<input type="radio" name="NewsletterParagraphUSNeedConfirmAction" id="NeedUConf1" value="True"<%If Base.ChkBoolean(propObj.Value("NewsletterParagraphUSNeedConfirmAction")) = True Then%> checked<%End If%> onclick="Javascript:toggleUSConfirmMailText();">
					<label for="NeedUConf1"><%=Translate.Translate("Ja")%></label>
					<input type="radio" name="NewsletterParagraphUSNeedConfirmAction" id="NeedUConf2" value="False"<%If Base.ChkBoolean(propObj.Value("NewsletterParagraphUSNeedConfirmAction")) = False Then%> checked<%End If%> onclick="Javascript:toggleUSConfirmMailText();">
					<label for="NeedUConf2"><%=Translate.Translate("Nej")%></label></td>
				</td>
			</tr>
			<tr id="USConfirmTexts" style="display:<%If Base.ChkBoolean(propObj.Value("NewsletterParagraphUSNeedConfirmAction")) = False Then%> none<%End If%>;"><td colspan="2" align="left">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<td>
						<tr>
							<td width="170"><%=Translate.Translate("E-mail emne")%></td>
							<td width="4" rowspan="4"></td>
							<td><input type="text" name="NewsletterParagraphUSMailSubject" value="<%=propObj.Value("NewsletterParagraphUSMailSubject")%>" maxlength="255" class="std"></td>
						</tr>
						<tr>
							<td valign="top"><%=Translate.Translate("E-mail tekst")%></td>
							<td><textarea name="NewsletterParagraphUSMailText" rows="4" class="std"><%=propObj.Value("NewsletterParagraphUSMailText")%></textarea></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Afsenderadresse")%></td>
							<td><input type="text" name="NewsletterParagraphUSMailSender" value="<%=propObj.Value("NewsletterParagraphUSMailSender")%>" maxlength="255" class="std"></td>
						</tr>
						<tr>
							<td valign="top"><%=Translate.Translate("Tekst til skærm")%></td>
							<td><textarea name="NewsletterParagraphUSScreenText" rows="4" class="std"><%=propObj.Value("NewsletterParagraphUSScreenText")%></textarea></td>
						</tr>
					</td>
				</table>
			</td></tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2"><strong><%=Translate.Translate("Brugerdefinerede tekster")%></strong></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Afmeld") & "</em>" )%></td>
				<td nowrap align="left">
					<input type="radio" name="NewsletterParagraphUSBtn" id="USBtn1" value="1" onclick="toggleUSSubmitBtn();"<%If propObj.Value("NewsletterParagraphUSBtn") = "1" Or propObj.Value("NewsletterParagraphSBtn") = "" Then%> checked<%End If%>>
					<label for="USBtn1"><%=Translate.Translate("Tekst")%></label>
					<input type="radio" name="NewsletterParagraphUSBtn" id="USBtn2" value="2" onclick="toggleUSSubmitBtn();"<%If propObj.Value("NewsletterParagraphUSBtn") = "2" Then%> checked<%End If%>>
					<label for="USBtn2"><%=Translate.Translate("Billede")%></label>
				</td>
			</tr>
			<tr id="USShowBtn1" style="display: <%If propObj.Value("NewsletterParagraphUSBtn") <> "1" And propObj.Value("NewsletterParagraphSBtn") <> "" Then%> none<%End If%>">
					<td width="170">&nbsp;</td>
					<td><input type="text" name="NewsletterParagraphUSBtnText" value="<%=propObj.Value("NewsletterParagraphUSBtnText")%>" maxlength="255" class="std"></td>
			</tr>
			<tr id="USShowBtn2" style="display: <%If Not propObj.Value("NewsletterParagraphUSBtn") = "2" Then%> None<%End If%>">
				<td width="170">&nbsp;</td>
				<td><%= Gui.FileManager(propObj.Value("NewsletterParagraphUSBtnImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsletterParagraphUSBtnImage")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("E-mailfelt")%></td>
				<td><input type="text" name="NewsletterParagraphUSEmailFieldText" value="<%=propObj.Value("NewsletterParagraphUSEmailFieldText")%>" maxlength="255" class="std"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<div>
	</td>
</tr>

<%
 Translate.GetEditOnlineScript()
%>
