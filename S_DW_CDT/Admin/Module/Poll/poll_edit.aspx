<%@ Page CodeBehind="poll_edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
Dim PollPageAfter As String
Dim PollTemplateList As Object
Dim PollMultiple As Boolean
Dim PollButton As String
Dim ParagraphID As Object

Dim PollShowCountBy As String
Dim PollShowCountType As String
Dim PollButtonImage As String
Dim PollShowText As String
Dim PollShowBy As String

Dim PollID As String
Dim PollCategoryID As String

Dim LinkManagerExt As Object
Dim ParagraphModuleSettings As String
Dim PollTemplateMain As String
Dim strSQL As String
Dim PollShowAfterVote As Integer
Dim PollButtonText As String

Dim strHeader As String


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
        prop.Value("PollShowCountType") = "1"
        prop.Value("PollShowCountBy") = "1"
        prop.Value("PollShowText") = "True"
        prop.Value("PollShowBy") = "1"
        prop.Value("PollCategoryID") = ""
        prop.Value("PollID") = ""
        prop.Value("PollButtonText") = "" & Translate.Translate("Stem") & ""
        prop.Value("PollButton") = "1"
        prop.Value("PollButtonImage") = ""
        prop.Value("PollMultiple") = True
        prop.Value("PollTemplateMain") = "Poll.html"
        prop.Value("PollTemplateList") = "Poll_List.html"
    End If

%>
	<INPUT type="Hidden" name="Poll_settings" value="PollTemplateMain, PollTemplateList, PollPageAfter, PollMultiple, PollButtonImage, PollButton, PollShowCountType, PollShowCountBy, PollShowText, PollShowBy, PollCategoryID, PollID, PollButtonText, PollShowAfterVote">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("poll", "Afstemning")%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			<TABLE cellpadding="2" cellspacing="0" border="0">
				<TR>
					<TD width="170" valign="top"><%=Translate.Translate("Afstemningstype")%></strong></TD>
					<TD>
						<TABLE border="0" cellpadding="0" cellspacing="0">
							<TR>
								<TD><input type="radio" onClick="javascript:TogglePollShowBy();" id="PollShowBy1" <%=IIf(prop.Value("PollShowBy") = "1", "checked", "")%> value="1" name="PollShowBy"><%=Translate.Translate("Fast afstemning")%></TD>
							</TR>
							<TR>
								<TD><input type="radio" onClick="javascript:TogglePollShowBy();" id="PollShowBy2" <%=IIf(prop.Value("PollShowBy") = "2", "checked", "")%> value="2" name="PollShowBy"><%=Translate.Translate("Vilkårlig fra kategori")%></TD>
							</TR>
							<TR>
								<TD>
									<BR>
									<DIV id="PollShowByPollDIV" style="display: ">
										<SELECT name="PollID" id="PollID" class="std">
										<%
										strHeader = ""
										strSQL = "SELECT PollCategory.PollCategoryName, PollItem.PollItemID " & "FROM PollCategory RIGHT JOIN PollItem ON PollCategory.PollCategoryID = PollItem.PollItemCategoryID " & "GROUP BY PollCategory.PollCategoryName, PollItem.PollItemID, PollItem.PollItemActive " & "HAVING (((PollItem.PollItemActive)=" & Database.SqlBool(1) & ")) ORDER BY PollCategory.PollCategoryName DESC , PollItem.PollItemID DESC"

										Dim cnPolls As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
										Dim cmdPolls As IDbCommand = cnPolls.CreateCommand
										cmdPolls.CommandText = strSQL
										Dim drPolls as IDataReader = cmdPolls.ExecuteReader()

										Do While drPolls.Read()
											If strHeader = "" Then
												strHeader = drPolls("PollCategoryName")
												Response.Write("<OPTGROUP label=""" & drPolls("PollCategoryName") & """>")
											ElseIf strHeader <> drPolls("PollCategoryName") Then 
												Response.Write("</OPTGROUP>")
												Response.Write("<OPTGROUP label=""" & drPolls("PollCategoryName") & """>")
											End If
											
											Response.Write("<OPTION " & IIf(CStr(prop.Value("PollID")) = CStr(drPolls("PollItemID")), "selected", "") & " value=""" & drPolls("PollItemID") & """>" & Left(Base.StripHtml(GetCategoryText(drPolls("PollItemID").ToString)), 30) & "</OPTION>")
										Loop 

										Response.Write("</OPTGROUP>")

										drPolls.Close()
										drPolls.Dispose()
										cnPolls.Dispose()
										cmdPolls.Dispose()
										%>
										</SELECT>
									</DIV>
									<DIV id="PollShowFromCategoryDIV" style="display: none">
										<SELECT name="PollCategoryID" id="PollCategoryID" class="std">
											<OPTION value=""><%=Translate.JSTranslate("Alle")%></OPTION>
											<%
											strSQL = "SELECT * FROM PollCategory ORDER BY PollCategoryName"
											Dim cnPollCategories As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
											Dim cmdPollCategories As IDbCommand = cnPollCategories.CreateCommand
											cmdPollCategories.CommandText = strSQL
											Dim drPollCategories as IDataReader = cmdPollCategories.ExecuteReader()

											Do While drPollCategories.Read()
												Response.Write("<OPTION " & IIf(CStr(prop.Value("PollCategoryID")) = CStr(drPollCategories("PollCategoryID")), "selected", "") & " value=""" & drPollCategories("PollCategoryID") & """>" & drPollCategories("PollCategoryName") & "</OPTION>")
											Loop 

											drPollCategories.Close()
											drPollCategories.Dispose()
											cmdPollCategories.Dispose()
											cnPollCategories.Dispose()
											%>
										</SELECT>
									</DIV>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			<TABLE cellpadding="2" cellspacing="0" border="0">
				<TR>
					<TD width="170"><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Stem") & "</em>" )%></TD>
					<TD>
						<TABLE border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><input type="radio" name="PollButton" id="PollButton1" value="1" onclick="togglePollButton();" <%=IIf(prop.Value("PollButton") = "1" Or prop.Value("PollButton") = "", "checked", "")%>></td>
								<td><label for="PollButton1"><%=Translate.Translate("Tekst")%></label></td>
								<td><input type="radio" name="PollButton" id="PollButton2" value="2" onclick="togglePollButton();" <%=IIf(prop.Value("PollButton") = "2" Or prop.Value("PollButton") = "", "checked", "")%>></td>
								<td><label for="PollButton2"><%=Translate.Translate("Billede")%></label></td>
							</tr>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			<DIV id="PollButtonShow1" style="display: <%If prop.Value("PollButton") <> "1" And prop.Value("PollButton") <> "" Then%> none<%End If%>">
				<TABLE cellpadding="2" cellspacing="0" border="0">
					<TR>
						<TD width="170">&nbsp;</TD>
						<TD><input type="text" name="PollButtonText" value="<%=prop.Value("PollButtonText")%>" class="std"></td>
					</TR>
				</TABLE>
			</DIV>
			<DIV id="PollButtonShow2" style="display: <%If Not prop.Value("PollButton") = "2" Then%> None<%End If%>">
				<TABLE border="0" cellpadding="2" cellspacing="0" width="540">
					<TR>
						<TD width="170">&nbsp;</TD>
						<TD>
							<%= Gui.FileManager(prop.Value("PollButtonImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "PollButtonImage")%>
						</TD>
					</TR>
				</TABLE>
			</DIV>
			<TABLE cellpadding="2" cellspacing="0" border="0">
				<TR>
					<TD width="170"><LABEL for="PollMultiple"><%=Translate.Translate("Tillad flere stemmer")%></LABEL></TD>
					<TD><%=Gui.CheckBox(prop.Value("PollMultiple"), "PollMultiple")%></TD>
				</TR>
				<TR>
					<TD width="170"><LABEL for="PollPageAfter"><%=Translate.Translate("Side efter indsendelse")%></LABEL></TD>
					<TD><%=Gui.LinkManager(prop.Value("PollPageAfter"), "PollPageAfter", "")%></TD>
				</TR>
			</TABLE>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
			<TABLE cellpadding="2" cellspacing="0" border="0">
				<TR>
					<TD width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste"))%></strong></TD>
					<TD>
						<%=Gui.FileManager(prop.Value("PollTemplateMain"), "Templates/Poll", "PollTemplateMain")%>
					</TD>
				</TR>
				<TR>
					<TD width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste element"))%></strong></TD>
					<TD>
						<%=Gui.FileManager(prop.Value("PollTemplateList"), "Templates/Poll", "PollTemplateList")%>
					</TD>
				</TR>
			</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
			<TABLE cellpadding="2" cellspacing="0" border="0">
				<TR>
					<TD width="170">&nbsp;</TD>
					<TD><INPUT type="CheckBox" name="PollShowText" <%=IIf(prop.Value("PollShowText") = "True", "checked", "")%> id="PollShowText" value="True"<label for="PollShowText"><%=Translate.Translate("Vis tekst")%></TD>
				</TR>
				<%If Base.HasVersion("18.5.1.0") Then%>
				<TR>
					<TD width="170">&nbsp;</TD>
					<TD><%=Gui.CheckBox(prop.Value("PollShowAfterVote"), "PollShowAfterVote")%><label for="PollShowAfterVote"><%=Translate.Translate("Vis kun resultat efter afstemning")%></label></TD>
				</TR>
				<%End If%>
				<TR>
					<TD valign="top" width="170"><%=Translate.Translate("Vis måling")%></strong></TD>
					<TD>
						<TABLE cellpadding="0" cellspacing="0" border="0">
							<TR>
								<TD><INPUT type="radio" <%=IIf(prop.Value("PollShowCountType") = "1", "checked", "")%> name="PollShowCountType" id="PollShowCountType" value="1"></TD>
								<TD><%=Translate.Translate("Procentvis")%></TD>
							</TR>
							<TR>
								<TD><INPUT type="radio" <%=IIf(prop.Value("PollShowCountType") = "2", "checked", "")%> name="PollShowCountType" id="PollShowCountType" value="2"></TD>
								<TD><%=Translate.Translate("Antal")%></TD>
							</TR>
							<TR>
								<TD><INPUT type="radio" <%=IIf(prop.Value("PollShowCountType") = "4", "checked", "")%> name="PollShowCountType" id="PollShowCountType" value="4"></TD>
								<TD><%=Translate.Translate("Antal og procentvis")%></TD>
							</TR>
							<TR>
								<TD><INPUT type="radio" <%=IIf(prop.Value("PollShowCountType") = "3", "checked", "")%> name="PollShowCountType" id="PollShowCountType" value="3"></TD>
								<TD><%=Translate.Translate("Vis ikke")%></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD valign="top" width="170"><%=Translate.Translate("Afkrydsning")%></strong></TD>
					<TD>
						<TABLE cellpadding="0" cellspacing="0" border="0">
							<TR>
								<TD><INPUT type="radio" <%=IIf(prop.Value("PollShowCountBy") = "1", "checked", "")%> name="PollShowCountBy" id="PollShowCountBy" value="1"></TD>
								<TD><%=Translate.Translate("Enkelt")%></TD>
							</TR>
							<TR>
								<TD><INPUT type="radio" <%=IIf(prop.Value("PollShowCountBy") = "2", "checked", "")%> name="PollShowCountBy" id="PollShowCountBy" value="2"></TD>
								<TD><%=Translate.Translate("Flere")%></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		<%=Gui.GroupBoxEnd%>
	</TD>
</TR>

<SCRIPT LANGUAGE="javascript">
<!--
	function togglePollButton() {
		if (document.all["PollButton1"].checked) {
			document.all["PollButtonShow1"].style.display = "";
			document.all["PollButtonShow2"].style.display = "none";
		}
		else {
			document.all["PollButtonShow1"].style.display = "none";
			document.all["PollButtonShow2"].style.display = "";
		}
	}

	function TogglePollShowBy() {
		if (document.all("PollShowBy1").checked) {
			document.all("PollShowByPollDIV").style.display = "";
			document.all("PollShowFromCategoryDIV").style.display = "none";
		}
		else {
			document.all("PollShowByPollDIV").style.display = "none";
			document.all("PollShowFromCategoryDIV").style.display = "";
		}
	}
	
	TogglePollShowBy();
//-->
</SCRIPT>

<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>