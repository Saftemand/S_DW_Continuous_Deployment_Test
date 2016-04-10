<%@ Page CodeBehind="News_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim ParagraphID As Integer
Dim sql As String
Dim ButtonText As String
Dim NewsParagraphCategoryIDList As String

If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(request("ParagraphID"))
Else
	ParagraphID = 0
End If

Dim prop As new Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        prop.Value("NewsParagraphCategoryID") = 0
        prop.Value("NewsParagraphShowFrom") = 1
        prop.Value("NewsParagraphShowTo") = 5
        prop.Value("NewsParagraphShowArchive") = "Active"
        prop.Value("NewsParagraphShowManchet") = "FirstXChars"
        prop.Value("NewsParagraphShowXCharacters") = 150
        prop.Value("NewsParagraphShowDate") = "1"
        prop.Value("NewsParagraphShowSmallImage") = "1"
        prop.Value("NewsParagraphShowDate") = "1"
        prop.Value("NewsParagraphRowspace") = "5"
        prop.Value("NewsParagraphImagespace") = "5"

        prop.Value("NewsParagraphListTemplate") = "List.html"
        prop.Value("NewsParagraphListElementTemplate") = "ListElement.html"
        'NewsParagraphListXSLTTemplate					= "ListXSLT.xslt"
        prop.Value("NewsParagraphElementTemplate") = ""

        prop.Value("NewsParagraphBackButtonPicture") = ""
        prop.Value("NewsParagraphBackButtonText") = Translate.Translate("Tilbage")
        prop.Value("NewsParagraphBackButton") = ""
        'NewsParagraphUseXLSTList						= "0"
        prop.Value("NewsParagraphCustomText") = Translate.Translate("År/Måned")
        prop.Value("NewsParagraphCustomType") = "YearMonth"
        prop.Value("NewsParagraphShowCustom") = "0"
        prop.Value("NewsParagraphCustomButton") = "0"
        prop.Value("NewsParagraphCustomButtonPicture") = ""
        prop.Value("NewsParagraphCustomButtonText") = ""
        prop.Value("NewsParagraphShowPersonalize") = "0"
        prop.Value("NewsParagraphPersonalizeButton") = "0"
        prop.Value("NewsParagraphPersonalizePicture") = ""
        prop.Value("NewsParagraphPersonalizeText") = ""
        prop.Value("NewsParagraphSortOrder") = "DESC"
        prop.Value("NewsParagraphCustomNumberPerList") = "5"
        prop.Value("NewsParagraphPagingButtonPrev") = ""
        prop.Value("NewsParagraphPagingButtonPrevPicture") = ""
        prop.Value("NewsParagraphPagingButtonPrevText") = Translate.Translate("Forrige")
        prop.Value("NewsParagraphPagingButtonNext") = ""
        prop.Value("NewsParagraphPagingButtonNextPicture") = ""
        prop.Value("NewsParagraphPagingButtonNextText") = Translate.Translate("Næste")
        prop.Value("NewsParagraphCustomPagingType") = "1"
        prop.Value("NewsParagraphShowBR") = "0"
        prop.Value("NewsParagraphReadMoreText") = Translate.Translate("Læs mere...")
        prop.Value("NewsParagraphReadMoreImage") = ""

    End If
    
    If prop.Value("NewsFunction") = "" Then
        prop.Value("NewsFunction") = "ShowNews"
    End If
If prop.Value("NewsSubmitNotifyTemplate")			= "" Then
	prop.Value("NewsSubmitNotifyTemplate")			= "Notify.html"
End If
If prop.Value("NewsSubmitFormTemplate")			= "" Then
	prop.Value("NewsSubmitFormTemplate")			= "Form.html"
End If

If prop.Value("NewsParagraphListTemplate")			= "" Then
	prop.Value("NewsParagraphListTemplate")			= "ListSTD.html"
End If
If prop.Value("NewsParagraphListElementTemplate")	= "" Then
	prop.Value("NewsParagraphListElementTemplate")	= "ListElementSTD.html"
End If

%>
<script>
function ShowHideNewsParagraphShowPersonalize(){

	if (document.all["NewsParagraphShowPersonalize"].checked) {
		document.all["TR_NewsParagraphShowPersonalize"].style.display = "";
	} 	else {
		document.all["TR_NewsParagraphShowPersonalize"].style.display = "none";
	}
}
function ShowHideNewsParagraphShowCustom(){

	if (document.all["NewsParagraphShowCustom"].checked) {
		document.all["TR_NewsParagraphShowCustom"].style.display = "";
	} 	else {
		document.all["TR_NewsParagraphShowCustom"].style.display = "none";
	}
}
function togglePagingType(intType){

	if (intType == 1) {
		document.all["TR_NewsParagraphCustomPaging"].style.display = "none";
	} 	else {
		document.all["TR_NewsParagraphCustomPaging"].style.display = "";
	}
}


function toggleSSubmitBtn(){
	if (document.all["SBtn1"].checked) {
		document.all["SShowBtn1"].style.display = "";
		document.all["SShowBtn2"].style.display = "none";
	}
	else if (document.all["SBtn2"].checked) {
		document.all["SShowBtn1"].style.display = "none";
		document.all["SShowBtn2"].style.display = "";
	}
	else if (document.all["SBtn3"].checked) {
		document.all["SShowBtn1"].style.display = "";
		document.all["SShowBtn2"].style.display = "";
	}
}

function ToggleCreate() {
	if (document.getElementById('CreateNews').checked) {
		document.getElementById('listcategory').style.display = 'none';
		document.getElementById('ListNewsShow').style.display = 'none';
		document.getElementById('ListNewsShow1').style.display = 'none';
		document.getElementById('ListNewsShow2').style.display = 'none';
		document.getElementById('ListNewsShow3').style.display = 'none';
		document.getElementById('submitcategory').style.display = 'block';
		document.getElementById('SubmitNewsShow').style.display = 'block';
	}else{
		document.getElementById('ListNewsShow').style.display = 'block';
		document.getElementById('ListNewsShow1').style.display = 'block';
		document.getElementById('ListNewsShow2').style.display = 'block';
		document.getElementById('ListNewsShow3').style.display = 'block';
		document.getElementById('listcategory').style.display = 'block';
		document.getElementById('submitcategory').style.display = 'none';
		document.getElementById('SubmitNewsShow').style.display = 'none';
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<input type="Hidden" name="News_settings" value="NewsParagraphCategoryID, NewsParagraphShowFrom, NewsParagraphShowTo, NewsParagraphShowArchive, NewsParagraphShowManchet, NewsParagraphShowDate, NewsParagraphShowSmallImage, NewsParagraphShowXCharacters, NewsParagraphRowspace, NewsParagraphImagespace, NewsParagraphReadMore, NewsParagraphReadMoreText, NewsParagraphReadMoreImage, NewsParagraphBackButtonPicture, NewsParagraphBackButtonText, NewsParagraphBackButton, NewsParagraphListTemplate, NewsParagraphListElementTemplate, NewsParagraphElementTemplate, NewsParagraphSettings, NewsParagraphCustomText, NewsParagraphCustomType, NewsParagraphShowCustom, NewsParagraphCustomButton, NewsParagraphCustomButtonPicture, NewsParagraphCustomButtonText, NewsParagraphShowPersonalize, NewsParagraphPersonalizeButton, NewsParagraphPersonalizeButtonPicture, NewsParagraphPersonalizeButtonText, NewsParagraphSortOrder, NewsParagraphCustomNumberPerList, NewsParagraphPagingButtonPrev, NewsParagraphPagingButtonPrevPicture, NewsParagraphPagingButtonPrevText, NewsParagraphPagingButtonNext, NewsParagraphPagingButtonNextPicture, NewsParagraphPagingButtonNextText, NewsParagraphCustomPagingType, NewsCulture, NewsFunction, NewsSubmitNotifyEmail, NewsSubmitNotify, NewsSubmitApprove, NewsSubmitNotifyTemplate, NewsSubmitFormTemplate, NewsSubmitReceiptPage, NewsApproveReceiptPage, NewsSubmitTemplateID, SNewsParagraphCategoryID, NewsSubmitNotifySubject">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("News", "Nyheder")%>
	</TD>
</TR>
<tr>
	<td>
					<%If Base.HasVersion("18.11.1.0") Then%>
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Funktion")%></td>
							<td>
								<table cellpadding=0 cellspacing=0 border=0>
									<tr>
										<td>
											<input type="Radio" class="clean" id="ShowNews" name="NewsFunction" value="ShowNews" onclick="ToggleCreate();"<%if prop.Value("NewsFunction")="ShowNews" then%> checked<%end if%>> <%=Translate.Translate("Nyhedsliste")%><BR>
											<input type="Radio" class="clean" id="CreateNews" name="NewsFunction" value="CreateNews" onclick="ToggleCreate();"<%if prop.Value("NewsFunction")="CreateNews" then%> checked<%end if%>> <%=Translate.Translate("Frontend_editering")%><BR>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%End If%>
		<div id="SubmitNewsShow" style="display:<%if prop.Value("NewsFunction")<>"CreateNews" then%>none<%end if%>">
		<%=Gui.GroupBoxStart(Translate.Translate("Frontend_editering"))%>
		<table cellpadding=2 cellspacing=0 border=0 >
			<tr valign="top">
				<td width=170><%=Translate.Translate("Template")%></td>
				<td>
				<select name="NewsSubmitTemplateID" class="std">
					<%=TemplateControl(prop.Value("NewsSubmitTemplateID"))%>
				</select>
				</td>
			</tr>
			<tr>
				<td valign=top width=170><%=Translate.Translate("Kvittering")%></td>
				<td valign=top><%=Gui.LinkManager(prop.Value("NewsSubmitReceiptPage"), "NewsSubmitReceiptPage", "")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Godkendelse"))%>
		<table cellpadding=2 cellspacing=0 border=0 >
			<tr>
				<td width=170><%=Translate.Translate("Notificer")%></td>
				<td><input type="checkbox" name="NewsSubmitNotify" value="1"<%if prop.Value("NewsSubmitNotify")="1"%>checked<%end if%>></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Email")%></td>
				<td><input type="text" name="NewsSubmitNotifyEmail" class="std" value="<%=prop.Value("NewsSubmitNotifyEmail")%>"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("E-mail_emne")%></td>
				<td><input type="text" name="NewsSubmitNotifySubject" class="std" value="<%=prop.Value("NewsSubmitNotifySubject")%>"></td>
			</tr>
			<tr>
				<td width=170><%=Translate.Translate("Godkend")%></td>
				<td><input type="checkbox" name="NewsSubmitApprove" value="1"<%if prop.Value("NewsSubmitApprove")="1"%>checked<%end if%> onclick="if (this.checked){document.getElementById('approvepage').style.display='block'}else{document.getElementById('approvepage').style.display='none'}"></td>
			</tr>
			<tr id="approvepage" style="display:<%if prop.Value("NewsSubmitApprove")<>"1"%>none<%end if%>">
				<td valign=top width=170><%=Translate.Translate("Kvittering")%></td>
				<td valign=top><%=Gui.LinkManager(prop.Value("NewsApproveReceiptPage"), "NewsApproveReceiptPage", "")%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Mail template")%></td>
				<td><%=Gui.FileManager(prop.Value("NewsSubmitNotifyTemplate"), "Templates/News/SubmitNews", "NewsSubmitNotifyTemplate")%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Form Template")%></td>
				<td><%=Gui.FileManager(prop.Value("NewsSubmitFormTemplate"), "Templates/News/SubmitNews", "NewsSubmitFormTemplate")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<div id="ListNewsShow" style="display:<%if prop.Value("NewsFunction")="CreateNews" then%>none<%end if%>">
		<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
		<table cellpadding=2 cellspacing=0 border=0 >
			<tr>
				<td width=170><%=Translate.Translate("Fra nyhed")%></td>
				<td><input type="text" name="NewsParagraphShowFrom" style="width:35px;" maxlength="5" class="std" value="<%=prop.Value("NewsParagraphShowFrom")%>"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Til nyhed")%></td>
				<td><input type="text" name="NewsParagraphShowTo" style="width:35px;" maxlength="5" class="std" value="<%=prop.Value("NewsParagraphShowTo")%>"></td>
			</tr>
			<tr>
				<td  valign="top"><%=Translate.Translate("Status")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("NewsParagraphShowArchive"), "NewsParagraphShowArchive", "Active")%>&nbsp;<%=Translate.Translate("Aktiv",1)%>
					<%=Gui.RadioButton(prop.Value("NewsParagraphShowArchive"), "NewsParagraphShowArchive", "Archive")%>&nbsp;<%=Translate.Translate("Arkiverede")%>
					<%=Gui.RadioButton(prop.Value("NewsParagraphShowArchive"), "NewsParagraphShowArchive", "All")%>&nbsp;<%=Translate.Translate("Alle")%><br>
				</td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Sortering")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("NewsParagraphSortOrder"), "NewsParagraphSortOrder", "DESC")%>&nbsp;<%=Translate.Translate("Faldende")%>
					<%=Gui.RadioButton(prop.Value("NewsParagraphSortOrder"), "NewsParagraphSortOrder", "ASC")%>&nbsp;<%=Translate.Translate("Stigende")%>
				</td>
			</tr>
			<tr>
				<td  valign="top"><%=Translate.Translate("Teaser tekst")%></td>
				<td>	
					<%=Gui.RadioButton(prop.Value("NewsParagraphShowManchet"), "NewsParagraphShowManchet", "FirstXChars")%>&nbsp;<%=Translate.Translate("Vis de første %% tegn","%%", "<input type='text' name='NewsParagraphShowXCharacters' size='4' maxlength='255' class='std' value='" & prop.Value("NewsParagraphShowXCharacters") &"' style='width:35px;'>")%>
					<br>
					<%=Gui.RadioButton(prop.Value("NewsParagraphShowManchet"), "NewsParagraphShowManchet", "Manchet")%>&nbsp;<%=Translate.Translate("Vis manchet")%><br>
				</td>
			</tr>
			<tr>
				<td  valign="top"><%=Translate.Translate("Række afstand")%></td>
				<td>	
					<%=Gui.SpacList(prop.Value("NewsParagraphRowspace"), "NewsParagraphRowspace")%>
				</td>
			</tr>
			<tr>
				<td  valign="top"></td>
				<td>
					<%=Gui.CheckBox(prop.Value("NewsParagraphShowDate"), "NewsParagraphShowDate")%> <%=Translate.Translate("Vis dato")%><br>
					<%=Gui.CheckBox(prop.Value("NewsParagraphShowSmallImage"), "NewsParagraphShowSmallImage")%> <%=Translate.Translate("Vis billede på oversigt")%><br>
				</td>
			</tr>
			<tr>
				<td  valign="top"><%=Translate.Translate("Billede/tekst afstand")%></td>
				<td>	
					<%=Gui.SpacList(prop.Value("NewsParagraphImagespace"), "NewsParagraphImagespace")%>
				</td>
			</tr>
			<%If Base.HasVersion("18.4.1.0") Or 1 = 1 Then%>
			<tr>
				<td width="170" valign="top"><%=Translate.Translate("Visning som")%></td>
				<td><%=Gui.Linkmanager(prop.Value("NewsParagraphSettings"), "NewsParagraphSettings", "", "0", "", False, "on", True)%></td>
			</tr>
			<%End If%>
			<tr>
				<td width="170" valign="top"><%=Translate.Translate("Link til nyhed")%></td>
				<td><%=Gui.ButtonText("NewsParagraphReadMore", prop.Value("NewsParagraphReadMore"), prop.Value("NewsParagraphReadMoreImage"), prop.Value("NewsParagraphReadMoreText"), "Image")%></td>
			</tr>
			<%If Base.HasVersion("18.1.1.0") Then%>
			<tr>
				<td width="170" valign="top"><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Tilbage") & "</em>")%></td>
				<td><%=Gui.ButtonText("NewsParagraphBackButton", prop.Value("NewsParagraphBackButton"), prop.Value("NewsParagraphBackButtonPicture"), prop.Value("NewsParagraphBackButtonText"))%></td>
			</tr>
			<%End If%>
			
			<%If Base.HasAccess("Personalize", "") Then%>
			<tr>
				<td valign="top"><%=Translate.Translate("Personalisering")%></td>
				<td>
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td><input onclick="ShowHideNewsParagraphShowPersonalize();" value="1" type="CheckBox" class="Clean" ID="CheckBox1" Name="NewsParagraphShowPersonalize" <%=Base.IIf(CStr(prop.Value("NewsParagraphShowPersonalize") & "") = "1", "checked", "")%>><br></td>
						</tr>
						<tr><td height="5"></td></tr>
						<tr ID="TR_NewsParagraphShowPersonalize" Style="DISPLAY: <%=Base.IIf(CStr(prop.Value("NewsParagraphShowPersonalize") & "") = "1", "Blocked", "None")%>">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td>
											<%=Gui.ButtonText("NewsParagraphPersonalizeButton", prop.Value("NewsParagraphPersonalizeButton"), prop.Value("NewsParagraphPersonalizeButtonPicture"), prop.Value("NewsParagraphPersonalizeButtonText"))%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>									
			</tr>
			<%End If%>
			<tr>
				<td Colspan="2" height=5></td>
			</tr>
		</table>
		
		<%=Gui.GroupBoxEnd%>
		</div>
	</td>
</tr>
<%If Base.HasVersion("18.6.1.0") Then%>
<tr id="ListNewsShow1" style="display:<%if prop.Value("NewsFunction")="CreateNews" then%>none<%end if%>">
	<td colspan=2">
		<%=Gui.GroupBoxStart(Translate.Translate("Vis tidligere"))%>
		<table>
			<tr>
				<td colspan="2">
					<table cellpadding="1" cellspacing="0" border="0" ID="Table1">
						<tr>
							<td width="170"><%=Translate.Translate("Vis tidligere")%></td>
							<td><input onclick="ShowHideNewsParagraphShowCustom();" value="1" type="CheckBox" class="Clean" ID="NewsParagraphShowCustom" Name="NewsParagraphShowCustom" <%=Base.IIf(CStr(prop.Value("NewsParagraphShowCustom") & "") = "1", "checked", "")%>></td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr ID="TR_NewsParagraphShowCustom" Style="DISPLAY: <%=Base.IIf(CStr(prop.Value("NewsParagraphShowCustom") & "") = "1", "Blocked", "None")%>">
				<td colspan="2">
					<table cellpadding="1" cellspacing="0" border="0">
						<tr>
							<td height="5"></td>
						</tr>
						<tr>
							<td width="170" valign="top"><%=Translate.Translate("Vis")%></td>
							<td align="left">
								<%=Gui.RadioButton(prop.Value("NewsParagraphCustomType"), "NewsParagraphCustomType", "Year")%><label for "Year"><%=Translate.Translate("År")%></label><br />
								<%=Gui.RadioButton(prop.Value("NewsParagraphCustomType"), "NewsParagraphCustomType", "YearMonth")%><label for "YearMonth"><%=Translate.Translate("År/Måned")%></label><br />
								<%=Translate.Translate("Tekst")%>&nbsp;<INPUT TYPE="text" NAME="NewsParagraphCustomText" size="4" maxlength="255" class="std" value="<%=prop.Value("NewsParagraphCustomText")%>" style="width:170px;">
							</td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Aktiver",1) & "</em>")%></td>
							<td><%=Gui.ButtonText("NewsParagraphCustomButton", prop.Value("NewsParagraphCustomButton"), prop.Value("NewsParagraphCustomButtonPicture"), prop.Value("NewsParagraphCustomButtonText"))%></td>
						</tr>
						<tr>
							<td width="170"><%=Translate.Translate("Antal per liste")%></td>
							<td>
								<input type="text" name="NewsParagraphCustomNumberPerList" style="width:35px;" maxlength="255" class="std" value="<%=prop.Value("NewsParagraphCustomNumberPerList")%>">
							</td>
						</tr>
						<tr>
							<td height=5></td>
						</tr>
						<tr>
							<td valign="top"><%=Translate.Translate("Paging type")%></td>
							<td>
								<table>
									<tr>
										<td><input type="radio" name="NewsParagraphCustomPagingType" id="NewsParagraphCustomPagingType1" value="1" onclick="togglePagingType(1);"<%	If prop.Value("NewsParagraphCustomPagingType") = "1" Or prop.Value("NewsParagraphCustomPagingType") = "" Then%> checked<%End If%>></td>
										<td><label for="NewsParagraphCustomPagingType1"><%=Translate.Translate("Side numre")%></label></td>
										<td><input type="radio" name="NewsParagraphCustomPagingType" id="NewsParagraphCustomPagingType2" value="2" onclick="togglePagingType(2);"<%	If prop.Value("NewsParagraphCustomPagingType") = "2" Then%> checked<%End If%>></td>
										<td><label for="NewsParagraphCustomPagingType2"><%=Translate.Translate("Frem/tilbage knapper")%></label></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr ID="TR_NewsParagraphCustomPaging" Style="DISPLAY: <%If CStr(prop.Value("NewsParagraphCustomPagingType") & "") = "2" Then Response.Write("Block") Else Response.Write("None")%>">
								<td colspan="4">
									<table>
										<tr>
											<td width="170" valign="top">&nbsp;&nbsp;<%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Frem") & "</em>")%></td>
											<td>
												<%=Gui.ButtonText("NewsParagraphPagingButtonNext", prop.Value("NewsParagraphPagingButtonNext"), prop.Value("NewsParagraphPagingButtonNextPicture"), prop.Value("NewsParagraphPagingButtonNextText"))%>
											</td>
										</tr>
										<tr>
											<td width="170" valign="top">&nbsp;&nbsp;<%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Tilbage") & "</em>")%></td>
											<td>
												<%=Gui.ButtonText("NewsParagraphPagingButtonPrev", prop.Value("NewsParagraphPagingButtonPrev"), prop.Value("NewsParagraphPagingButtonPrevPicture"), prop.Value("NewsParagraphPagingButtonPrevText"))%>
											</td>
										</tr>
									</table>
								</td>
							</tr>
					</table>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<%End If%>
<tr id="ListNewsShow2" style="display:<%if prop.Value("NewsFunction")="CreateNews" then%>none<%end if%>">
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste"))%></td>
					<td><%=Gui.FileManager(prop.Value("NewsParagraphListTemplate"), "Templates/News", "NewsParagraphListTemplate")%></td>
				</tr>
				<tr>
					<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste element"))%></td>
					<td><%=Gui.FileManager(prop.Value("NewsParagraphListElementTemplate"), "Templates/News", "NewsParagraphListElementTemplate")%></td>
				</tr>
				<tr>
					<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Vis element"))%></td>
					<td><%=Gui.FileManager(prop.Value("NewsParagraphElementTemplate"), "Templates/News", "NewsParagraphElementTemplate")%></td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>

<%If Base.HasVersion("18.10.1.0") Then%>

<tr id="ListNewsShow3" style="display:<%if prop.Value("NewsFunction")="CreateNews" then%>none<%end if%>">
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Formatering"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170">
						<%=Translate.Translate("Regionale indstillinger")%>
					</td>
					<td>
						<%=Gui.CultureList(prop.Value("NewsCulture"), "NewsCulture")%>
					</td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<%End If%>
<tr>
	<td colspan=2>
		<div id="listcategory" style="display:<%if prop.Value("NewsFunction")="ShowNews" then%>block<%else%>none<%end if%>">
		<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
		<table cellpadding="2" cellspacing="0">
			<tr>
				<td valign="top" width="170"><%=Translate.Translate("Medtag følgende kategorier")%></td>
				<td valign="top">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
							<%
							NewsParagraphCategoryIDList = "@" & Replace(prop.Value("NewsParagraphCategoryID"), ",", "@") & "@"

							
							Dim dr as IdataReader = Database.CreateDataReader("SELECT * FROM NewsCategory ORDER BY NewsCategoryName")

							Do While dr.Read()
								If Base.HasAccess("NewsCategories", dr("NewsCategoryID").ToString) Then
									Response.Write("<input type=""CheckBox"" name=""NewsParagraphCategoryID"" id=""news" & dr.Item("NewsCategoryID") & """ value=""" & dr.Item("NewsCategoryID") & """")
									If InStr(NewsParagraphCategoryIDList, "@" & dr.Item("NewsCategoryID") & "@") Then
										Response.Write(" checked")
									End If
									Response.Write(">")
									Response.Write("<label for=""news" & dr.Item("NewsCategoryID") & """> <nobr>" & dr.Item("NewsCategoryName") & "</nobr></label><br>" & vbCrLf)
								End If
							Loop 

							dr.Dispose()
							%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<div id="submitcategory" style="display:<%if prop.Value("NewsFunction")="CreateNews" then%>block<%else%>none<%end if%>">
		<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
		<table cellpadding="2" cellspacing="0">
			<tr>
				<td valign="top" width="170"><%=Translate.Translate("Medtag følgende kategorier")%></td>
				<td valign="top">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
							<%
							dr = Database.CreateDataReader("SELECT * FROM NewsCategory ORDER BY NewsCategoryName")

							Do While dr.Read()
								If Base.HasAccess("NewsCategories", dr("NewsCategoryID").ToString) Then
									Response.Write("<input type=""radio"" name=""SNewsParagraphCategoryID"" id=""snews" & dr.Item("NewsCategoryID") & """ value=""" & dr.Item("NewsCategoryID") & """")
									If Base.ChkNumber(prop.value("SNewsParagraphCategoryID"))= Base.ChkNumber(dr.Item("NewsCategoryID")) Then
										Response.Write(" checked")
									End If
									Response.Write(">")
									Response.Write("<label for=""snews" & dr.Item("NewsCategoryID") & """> <nobr>" & dr.Item("NewsCategoryName") & "</nobr></label><br>" & vbCrLf)
								End If
							Loop 

							dr.Dispose()
							%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
	</td>
</tr>
<%Translate.GetEditOnlineScript()%>
