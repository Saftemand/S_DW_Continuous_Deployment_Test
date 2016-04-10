<%@ Page CodeBehind="FAQ_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim FAQBullet As String
Dim FAQParagraphCategoryIDList As String
Dim ParagraphID As Integer

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

	
        If prop.Value("FaqSortBy") = "" Then
            prop.Value("FaqSortBy") = "FAQItemSort"
        End If
        If prop.Value("FaqSortOrder") = "" Then
            prop.Value("FaqSortOrder") = "ASC"
        End If
    Else
        prop.Value("FAQParagraphCategoryID") = 0
        prop.Value("FAQParagraphShow") = 100
        prop.Value("FAQParagraphShowDate") = "1"
        prop.Value("FAQParagraphFramecolor") = "#CCCCCC"
        prop.Value("FAQType") = "1"
        prop.Value("FAQList") = "1"
        prop.Value("FAQParagraphShowSender") = "0"
        prop.Value("FAQParagraphShowAnswere") = "0"
	
        prop.Value("FaqSortBy") = "FAQItemSort"
        prop.Value("FaqSortOrder") = "ASC"
	
        prop.Value("FAQParagraphShowQuestion") = "1"
        prop.Value("FAQParagraphTextDate") = Translate.Translate("Dato")
        prop.Value("FAQParagraphTextName") = Translate.Translate("Navn")
        prop.Value("FAQParagraphTextMail") = Translate.Translate("E-mail")
        prop.Value("FAQParagraphTextHeading") = Translate.Translate("Overskrift")
        prop.Value("FAQParagraphTextMessage") = Translate.Translate("Spørgsmål")
        prop.Value("FAQParagraphTextSend") = Translate.Translate("Indsend")
	
        prop.Value("FAQParagraphMailSubject") = Translate.Translate("Nyt FAQ spørgsmål")
        prop.Value("FAQParagraphMailQuestion") = "1"
	
        prop.Value("FAQHeadingBackgroundcolor") = "#e1e1e1"
        prop.Value("FAQHeadingFont") = "Verdana, Helvetica, Arial"
        prop.Value("FAQHeadingFontSize") = "12px"
        prop.Value("FAQHeadingFontColor") = "#000000"
        prop.Value("FAQHeadingFontBold") = "0"
	
        prop.Value("FAQTextBackgroundcolor") = "#f1f1f1"
        prop.Value("FAQTextFont") = "Verdana, Helvetica, Arial"
        prop.Value("FAQTextFontSize") = "12px"
        prop.Value("FAQTextFontColor") = "#000000"
        prop.Value("FAQTextFontBold") = "0"
		prop.Value("FAQMailTemplate") = "FAQMail.html"
	
    End If

Dim IconPath As String
Dim IconPath2 As String
Dim IconPath3 As String
Dim ModuleIcon As String

IconPath = server.MapPath("../Images/Icons/Module_FAQ.gif")
IconPath2 = server.MapPath("FAQ/Module_FAQ.gif")
IconPath3 = server.MapPath("/CustomModules/FAQ/Module_FAQ.gif")
If System.IO.File.Exists(IconPath) Then 'Does an icon exist for this module?
	ModuleIcon = "../Images/Icons/Module_FAQ.gif"
ElseIf System.IO.File.Exists(IconPath2) Then 
	ModuleIcon = "FAQ/Module_FAQ.gif"
ElseIf System.IO.File.Exists(IconPath3) Then 
	ModuleIcon = "/CustomModules/FAQ/Module_FAQ.gif"
Else
	ModuleIcon = "../Images/Icons/Module_Default.gif"
End If

%>
<script>
function ShowHideLayout(ListID){
	if(ListID == "2"){
		document.all.LayoutDesign1.style.display = "";
		document.all.LayoutDesign2.style.display = "";
		document.all.LayoutDesign3.style.display = "";
		document.all.ShowInfo1.style.display = "";
		document.all.ShowInfo2.style.display = "";
		document.all.ShowInfo3.style.display = "";
	}
	else{
		document.all.LayoutDesign1.style.display = "none";
		document.all.LayoutDesign2.style.display = "none";
		document.all.LayoutDesign3.style.display = "none";
		document.all.ShowInfo1.style.display = "none";
		document.all.ShowInfo2.style.display = "none";
		document.all.ShowInfo3.style.display = "none";
	}
	if(ListID == "1"){
		document.all.Bullet.style.display = "";
	}
	else{
		document.all.Bullet.style.display = "none";
	}
}
</script>
<input type="Hidden" name="FAQ_settings" value="FAQParagraphCategoryID, FAQBullet, FAQParagraphShow, FAQParagraphShowDate, FAQParagraphFramecolor, FAQList, FAQType, FAQParagraphShowSender, FAQParagraphShowAnswere, FAQParagraphShowQuestion, FAQParagraphTextDate, FAQParagraphTextName, FAQParagraphTextMail, FAQParagraphTextHeading, FAQParagraphTextMessage, FAQParagraphTextSend, FAQParagraphMailQuestion, FAQParagraphMailAdress, FAQParagraphMailSubject, FAQHeadingBackgroundcolor, FAQHeadingFont, FAQHeadingFontSize, FAQHeadingFontColor, FAQHeadingFontBold, FAQTextBackgroundcolor, FAQTextFont, FAQTextFontSize, FAQTextFontColor, FAQTextFontBold, FAQRedirect, FAQMailTemplate, FaqSortBy, FaqSortOrder">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("FAQ", "FAQ")%>
	</TD>
</TR>
<tr>
	<td>
		<table border="0" width="598" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td width=170><%=Translate.Translate("Max antal")%></td>
							<td><input type="text" name="FAQParagraphShow" style="width:35px;" maxlength="255" class="std" value="<%=prop.Value("FAQParagraphShow")%>"></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste")%></td>
							<td>
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td><input type="radio" name="FAQList" id="FAQList1" value="1"<%If prop.Value("FAQList") = "1" Then%> checked<%End If%> onClick="ShowHideLayout(this.value);"></td>
										<td><label for="FAQList1"><%=Translate.Translate("Indholdsfortegnelse med link")%></label></td>
									</tr>
									<tr>
										<td><input type="radio" name="FAQList" id="FAQList2" value="2"<%If prop.Value("FAQList") = "2" Then%> checked<%End If%> onClick="ShowHideLayout(this.value);"></td>
										<td><label for="FAQList2"><%=Translate.Translate("Indrammet")%></label></td>
									</tr>
									<tr>
										<td><input type="radio" name="FAQList" id="FAQList3" value="3"<%If prop.Value("FAQList") = "3" Then%> checked<%End If%> onClick="ShowHideLayout(this.value);"></td>
										<td><label for="FAQList3"><%=Translate.Translate("Overskrift med svar")%></label></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr ID="Bullet"<%=Base.IIf(prop.Value("FAQList") <> "1", "style=""display:none;""", "")%>>
							<td width=170><%=Translate.Translate("Bullet")%></td>
							<td><%=Gui.FileManager(FAQBullet, "Navigation", "FAQBullet")%></td>
						</tr>
						<tr ID="ShowInfo1"<%=Base.IIf(prop.Value("FAQList") <> "2", "style=""display:none;""", "")%>>
							<td width=170><%=Translate.Translate("Vis dato")%></td>
							<td><%=Gui.CheckBox(prop.Value("FAQParagraphShowDate"), "FAQParagraphShowDate")%></td>
						</tr>
						<tr ID="ShowInfo2"<%=Base.IIf(prop.Value("FAQList") <> "2", "style=""display:none;""", "")%>>
							<td width=170><%=Translate.Translate("Vis spørger")%></td>
							<td><%=Gui.CheckBox(prop.Value("FAQParagraphShowSender"), "FAQParagraphShowSender")%></td>
						</tr>
						<tr ID="ShowInfo3"<%=Base.IIf(prop.Value("FAQList") <> "2", "style=""display:none;""", "")%>>
							<td width=170><%=Translate.Translate("Vis svarer")%></td>
							<td><%=Gui.CheckBox(prop.Value("FAQParagraphShowAnswere"), "FAQParagraphShowAnswere")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
			
			<tr ID="LayoutDesign1"<%=Base.IIf(prop.Value("FAQList") <> "2", "style=""display:none;""", "")%>>
				<td colspan=2>
					<%Response.Write(Gui.GroupBoxStart(Translate.Translate("Ramme")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width=170><%=Translate.Translate("Rammefarve")%></td>
							<td><%=Gui.ColorSelect(prop.Value("FAQParagraphFramecolor"), "FAQParagraphFramecolor")%></td>
						</tr>
					</table>
					<%Response.Write(Gui.GroupBoxEnd)%>
				</td>
			</tr>
			<tr ID="LayoutDesign2"<%=Base.IIf(prop.Value("FAQList") <> "2", "style=""display:none;""", "")%>>
				<td colspan=2>
					<%Response.Write(Gui.GroupBoxStart(Translate.Translate("Overskrift")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width=170><%=Translate.Translate("Baggrundsfarve")%></td>
							<td><%=Gui.ColorSelect(prop.Value("FAQHeadingBackgroundcolor"), "FAQHeadingBackgroundcolor")%>
						</tr>
						<tr>
							<td><%=Translate.Translate("Font")%></td>
							<td><%=Gui.FontFamilyList(prop.Value("FAQHeadingFont"), "FAQHeadingFont")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fontstørrelse")%></td>
							<td><%=Gui.FontSizeList(prop.Value("FAQHeadingFontSize"), "FAQHeadingFontSize")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fontfarve")%></td>
							<td><%=Gui.ColorSelect(prop.Value("FAQHeadingFontColor"), "FAQHeadingFontColor")%>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fed")%></td>
							<td><%=Gui.CheckBox(prop.Value("FAQHeadingFontBold"), "FAQHeadingFontBold")%>
						</tr>
					</table>
					<%Response.Write(Gui.GroupBoxEnd)%>
				</td>
			</tr>
			<tr ID="LayoutDesign3"<%=Base.IIf(prop.Value("FAQList") <> "2", "style=""display:none;""", "")%>>
				<td colspan=2>
					<%Response.Write(Gui.GroupBoxStart(Translate.Translate("Tekst")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width=170><%=Translate.Translate("Baggrundsfarve")%></td>
							<td><%=Gui.ColorSelect(prop.Value("FAQTextBackgroundcolor"), "FAQTextBackgroundcolor")%>
						</tr>
						<tr>
							<td><%=Translate.Translate("Font")%></td>
							<td><%=Gui.FontFamilyList(prop.Value("FAQTextFont"), "FAQTextFont")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fontstørrelse")%></td>
							<td><%=Gui.FontSizeList(prop.Value("FAQTextFontSize"), "FAQTextFontSize")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fontfarve")%></td>
							<td><%=Gui.ColorSelect(prop.Value("FAQTextFontColor"), "FAQTextFontColor")%>
						</tr>
						<tr>
							<td><%=Translate.Translate("Fed")%></td>
							<td><%=Gui.CheckBox(prop.Value("FAQTextFontBold"), "FAQTextFontBold")%>
						</tr>
					</table>
					<%Response.Write(Gui.GroupBoxEnd)%>
				</td>
			</tr>
			
			<%If Base.HasVersion("18.9.1.0") Then%>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Sortering"))%>
					<table cellpadding=2 cellspacing=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Sorter efter")%></td>
							<td>
								<%=Gui.RadioButton(prop.Value("FaqSortBy"), "FaqSortBy", "FAQItemSort")%>&nbsp;<label for="FaqSortByFAQItemSort"><%=Translate.Translate("Sortering")%></label><br>
								<%=Gui.RadioButton(prop.Value("FaqSortBy"), "FaqSortBy", "FAQItemDate")%>&nbsp;<label for="FaqSortByFAQItemDate"><%=Translate.Translate("Dato")%></label><br>
								<%=Gui.RadioButton(prop.Value("FaqSortBy"), "FaqSortBy", "FAQItemQHeader")%>&nbsp;<label for="FaqSortByFAQItemQHeader"><%=Translate.Translate("Overskrift")%></label><br>
							</td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Sortering")%></td>
							<td>
								<%=Gui.RadioButton(prop.Value("FaqSortOrder"), "FaqSortOrder", "ASC")%>&nbsp;<label for="FaqSortOrderASC"><%=Translate.Translate("Stigende")%></label><br>
								<%=Gui.RadioButton(prop.Value("FaqSortOrder"), "FaqSortOrder", "DESC")%>&nbsp;<label for="FaqSortOrderDESC"><%=Translate.Translate("Faldende")%></label><br>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
			<%End If%>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Formular"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top><%=Translate.Translate("Placering")%></td>
							<td>
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td><input type="radio" name="FAQType" id="FAQType1" value="1"<%If prop.Value("FAQType") = "1" Then%> checked<%End If%>></td>
										<td><label for="FAQType1"><%=Translate.Translate("Formular under liste")%></label></td>
									</tr>
									<tr>
										<td><input type="radio" name="FAQType" id="FAQType2" value="2"<%If prop.Value("FAQType") = "2" Then%> checked<%End If%>></td>
										<td><label for="FAQType2"><%=Translate.Translate("Formular over liste")%></label></td>
									</tr>
									<tr>
										<td><input type="radio" name="FAQType" id="FAQType3" value="3"<%If prop.Value("FAQType") = "3" Then%> checked<%End If%>></td>
										<td><label for="FAQType3"><%=Translate.Translate("Ingen formular")%></label></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Vis spørgsmål")%></td>
							<td><%=Gui.CheckBox(prop.Value("FAQParagraphShowQuestion"), "FAQParagraphShowQuestion")%></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Dato")%></td>
							<td><input type="text" name="FAQParagraphTextDate" maxlength="255" class="std" value="<%=prop.Value("FAQParagraphTextDate")%>"></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Navn")%></td>
							<td><input type="text" name="FAQParagraphTextName" maxlength="255" class="std" value="<%=prop.Value("FAQParagraphTextName")%>"></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("E-mail")%></td>
							<td><input type="text" name="FAQParagraphTextMail" maxlength="255" class="std" value="<%=prop.Value("FAQParagraphTextMail")%>"></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Overskrift")%></td>
							<td><input type="text" name="FAQParagraphTextHeading" maxlength="255" class="std" value="<%=prop.Value("FAQParagraphTextHeading")%>"></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Spørgsmål")%></td>
							<td><input type="text" name="FAQParagraphTextMessage" maxlength="255" class="std" value="<%=prop.Value("FAQParagraphTextMessage")%>"></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Indsend")%></td>
							<td><input type="text" name="FAQParagraphTextSend" maxlength="255" class="std" value="<%=prop.Value("FAQParagraphTextSend")%>"></td>
						</tr>
						<tr>
							<td valign="top"><%=Translate.Translate("Side efter indsendelse")%>&nbsp;&nbsp;</td>
							<td><%=Gui.LinkManager(prop.Value("FAQRedirect"), "FAQRedirect", "")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("E-mail"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td width=170><%=Translate.Translate("Send e-mail ved spørgsmål")%></td>
							<td><%=Gui.CheckBox(prop.Value("FAQParagraphMailQuestion"), "FAQParagraphMailQuestion")%></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("E-mail")%></td>
							<td><input type="text" name="FAQParagraphMailAdress" class="std" value="<%=prop.value("FAQParagraphMailAdress")%>"></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Emne")%></td>
							<td><input type="text" name="FAQParagraphMailSubject" class="std" value="<%=prop.Value("FAQParagraphMailSubject")%>"></td>
						</tr>
						<tr>
							<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("E-mail"))%></td>
							<td><%=Gui.FileManager(prop.Value("FAQMailTemplate"), "Templates/FAQ", "FAQMailTemplate")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
					<table cellpadding=2 cellspacing=0>
						<tr>
							<td valign="top" width=170></td>
							<td>
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td>
										<%
										FAQParagraphCategoryIDList = "@" & Replace(prop.Value("FAQParagraphCategoryID"), ",", "@") & "@"
										
										Dim drFaqCategory As IDataReader = Database.CreateDataReader("SELECT * FROM FAQCategory ORDER BY FAQCategoryName")
										Do While drFaqCategory.Read()
											If Base.HasAccess("FAQCategories", drFaqCategory("FAQCategoryID").ToString) Then
												Response.Write("<input type=""CheckBox"" name=""FAQParagraphCategoryID"" id=""FAQ" & drFaqCategory.Item("FAQCategoryID").ToString & """ value=""" & drFaqCategory.Item("FAQCategoryID") & """")
												If InStr(FAQParagraphCategoryIDList, "@" & drFaqCategory.Item("FAQCategoryID").ToString & "@") Then
													Response.Write(" checked")
												End If
												'Execute "If SFAQletters" & CStr(Trim(RS("FAQCategoryID"))) & " = True Then response.Write "" checked"""
												Response.Write(">")
												Response.Write("<label for=""FAQ" & drFaqCategory.Item("FAQCategoryID").ToString & """><nobr>" & drFaqCategory.Item("FAQCategoryName").ToString & "</nobr></label><br>" & vbCrLf)
											End If
										Loop 

										drFaqCategory.Close()
										drFaqCategory.Dispose()
										%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
		</table>
	</td>
</tr>
<%
 Translate.GetEditOnlineScript()
%>
