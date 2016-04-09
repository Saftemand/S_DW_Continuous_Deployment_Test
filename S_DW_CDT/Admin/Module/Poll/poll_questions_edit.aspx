<%@ Page CodeBehind="poll_questions_edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_questions_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			29-07-2002
'	Last modfied:		29-07-2002
'
'	Purpose: Edit categories of poll
'
'	Revision history:
'		1.0.0 - 29-07-2002
'		First version.
'
'		1.1.0 - 02-06-2004 - David Frandsen
'		Converted to .NET
'
'**************************************************************************************************
Dim intItemID As Integer
Dim intCategoryID As Integer
Dim strItemText As String
Dim strSql As String
Dim intPosition As String

Dim bolActive As Boolean 

intItemID = 0
intCategoryID = 0
strItemText = ""

intCategoryID = Request.QueryString.Item("categoryid")
bolActive = True

If Not IsNothing(Request.QueryString.GetValues("itemid")) Then
	intItemID = Request.QueryString.Item("itemid")
	
	Dim cnPollQuestionEdit As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
	Dim cmdSelect As IDbCommand = cnPollQuestionEdit.CreateCommand
	cmdSelect.CommandText = "SELECT * FROM PollItem WHERE PollItemID=" & intItemID
	Dim drPollEditItem as IDataReader = cmdSelect.ExecuteReader()

	'Gets and stores ordinal numbers for the columnnames
	Dim intOrdinalValuePollItemCategoryID, intOrdinalValuePollItemText, intOrdinalValuePollItemActive as Integer
	intOrdinalValuePollItemCategoryID = drPollEditItem.GetOrdinal("PollItemCategoryID")
	intOrdinalValuePollItemText = drPollEditItem.GetOrdinal("PollItemText")
	intOrdinalValuePollItemActive = drPollEditItem.GetOrdinal("PollItemActive")
	
	If drPollEditItem.Read() Then
		intCategoryID = Cint(drPollEditItem(intOrdinalValuePollItemCategoryID).ToString)
		strItemText = drPollEditItem(intOrdinalValuePollItemText).ToString
		bolActive = Base.ChkBoolean(drPollEditItem(intOrdinalValuePollItemActive).ToString)
	End If
	drPollEditItem.Close()
	drPollEditItem.Dispose()
	cmdSelect.Dispose()
	cnPollQuestionEdit.Dispose()
End If

%>
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
        <script type="text/javascript">function html() { return true; }</script>
	</HEAD>
	<SCRIPT LANGUAGE="javascript">
		<!--
		function ConfirmDeleteAnswer(intAnswerID, strAnswerName) {
			if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("svarmulighed"))%>\n(' + strAnswerName + ')')==true) {
				window.location.href = "poll_answer_del.aspx?questionid=<%=intItemID%>&answerid=" + intAnswerID;
			}
		}
		function CheckForm() {
			//alert(document.getElementById('frmQuestion').QuestionText.length);
			document.getElementById('frmQuestion').submit();
			return;
			if (document.getElementById('frmQuestion').QuestionText.value == "") {
				alert("<%=Translate.JSTranslate("Du skal angive et spørgsmål")%>");
			}
			else if (document.getElementById('frmQuestion').QuestionText.value.length > 100) {
				alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","100")%><%=Translate.JSTranslate("Tekst")%>");
				document.frmCategory.PollCategoryName.focus();
			}
			else {
				document.getElementById('frmQuestion').submit();
			}
		}
		
		function NewAnswer() {
			if (document.getElementById('frmNewAnswer').PollAnswerTitle.value == "") {
				alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Svarmulighed"))%>!');
				document.getElementById('frmNewAnswer').PollAnswerTitle.focus();
				return false;
			}
			else if (document.getElementById('frmNewAnswer').PollAnswerTitle.value.length > 100) {
				alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","100")%><%=Translate.JSTranslate("Svarmulighed")%>");
				document.getElementById('frmNewAnswer').PollAnswerTitle.focus();
				return false;
			}
			else {
				document.getElementById('frmNewAnswer').submit();
			}
		}
		//-->
	</SCRIPT>
	<BODY>
		<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("afstemningsspørgsmål")), Translate.Translate("Spørgsmål",1), "all")%>
		<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
			<tr>
				<td valign="top">
					<div ID="Tab1" STYLE="display:;">
						<TABLE height="100%" border="0" cellpadding="0" cellspacing="0">
							<TR>
								<TD valign="top">
									<TABLE border="0" cellpadding="0" width="598">
										<form method="post" action="poll_questions_save.aspx?categoryid=<%=intCategoryID%>&questionid=<%=intItemID%>" name="frmQuestion" id="frmQuestion">
											<TR>
												<TD colspan="2"><BR>
													<%=Gui.GroupBoxStart(Translate.Translate("Tekst"))%>
													<%=Gui.Editor("QuestionText", 0, 0, strItemText)%>
													<BR>
													<INPUT type="checkbox" <%=IIf(bolActive = True, "checked", "")%> name="PollQuestionActive" id="PollQuestionActive" value="True" class="clean">&nbsp;<%=Translate.Translate("Aktiv")%><BR>
													<%=Gui.GroupBoxEnd%>
												</TD>
											</TR>
										</form>
										<%If Not IsNothing(Request.QueryString.GetValues("itemid")) Then%>
										<TR>
											<TD>
												<%=Gui.GroupBoxStart(Translate.Translate("Svarmuligheder"))%>
												<TABLE border="0" cellpadding="0" width="100%" border="0">
													<TR>
														<TD><strong><%=Translate.Translate("Titel")%></strong></TD>
														<TD width="80" align="center"><strong><%=Translate.Translate("Sortering")%></strong></TD>
														<TD width="40" align="center"><strong><%=Translate.Translate("Slet")%></strong></TD>
													</TR>
													<TR>
														<TD colspan="3" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width="1" height="1" alt="" border="0"></TD>
													</TR>
<%	
strSql = "SELECT Count(*) As Amount FROM PollAnswer WHERE PollAnswerItemID=" & Request.QueryString.Item("itemid")
Dim cnPollAnswers As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
Dim cmdSelect As IDbCommand = cnPollAnswers.CreateCommand
cmdSelect.CommandText = strSql


Dim intRecordCount as Integer = 0
intRecordCount = cmdSelect.ExecuteScalar()

strSql = "SELECT * FROM PollAnswer WHERE PollAnswerItemID=" & Request.QueryString.Item("itemid") & " ORDER BY PollAnswerSort ASC"

cmdSelect.CommandText = strSql
Dim drPollAnswers as IDataReader = cmdSelect.ExecuteReader()

'Gets and stores ordinal numbers for the columnnames
Dim intOrdinalValuePollAnswerID, intOrdinalValuePollAnswerTitle, intOrdinalValuePollAnswerSort as Integer
intOrdinalValuePollAnswerID = drPollAnswers.GetOrdinal("PollAnswerID")
intOrdinalValuePollAnswerTitle = drPollAnswers.GetOrdinal("PollAnswerTitle")
intOrdinalValuePollAnswerSort = drPollAnswers.GetOrdinal("PollAnswerSort")

Dim blnHasRow as Boolean = false

Dim intAbsolutePosition as Integer = 0
Do While drPollAnswers.Read()
	If Not blnHasRow Then blnHasRow = True
	With Response
		
		.Write("<TR>")
		.Write("<TD>" & drPollAnswers(intOrdinalValuePollAnswerTitle).ToString & "</TD>")
		.Write("<TD align=""center"">")
		
		If intAbsolutePosition >= 1 Then
			.Write("<A href=""poll_questions_sort.aspx?questionid=" & Request.QueryString.Item("itemid") & "&direction=up&itemid=" & drPollAnswers(intOrdinalValuePollAnswerID).ToString & """><IMG border=""0"" src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """></A>")
		Else
			.Write("<IMG border=""0"" src=""../../images/nothing.gif"" height=""15"" width=""15"">")
		End If
		
		If Not intAbsolutePosition = intRecordCount-1 Then
			.Write("<A href=""poll_questions_sort.aspx?questionid=" & Request.QueryString.Item("itemid") & "&direction=down&itemid=" & drPollAnswers(intOrdinalValuePollAnswerID).ToString & """><IMG border=""0"" src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """></A>")
		Else
			.Write("<IMG border=""0"" src=""../../images/nothing.gif"" height=""15"" width=""15"">")
		End If
		
		.Write("</TD>") '" & drPollAnswers("PollAnswerSort") & "
		.Write("<TD align=""center""><A href=""javascript:ConfirmDeleteAnswer(" & drPollAnswers(intOrdinalValuePollAnswerID).ToString & ",'" & drPollAnswers(intOrdinalValuePollAnswerTitle).ToString & "');""><IMG src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("svarmulighed")) & """></A></TD>")
		.Write("</TR>")
		
		.Write("<TR><TD colspan=""3"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 alt="""" border=""0""></td></TR>")
	End With
	intAbsolutePosition = intAbsolutePosition + 1
Loop 

drPollAnswers.Close()
drPollAnswers.Dispose()
cnPollAnswers.Dispose()
cmdSelect.Dispose()
%>
													<%If Not blnHasRow Then%>
													<tr>
														<td colspan="3"><br /><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("svarmuligheder"))%></strong></td>
													</tr>
													<%End If%>
												</TABLE>
												<BR>
												<TABLE border="0" cellpadding="0" cellspacing="0" width="100%">
													<form method="post" action="poll_answer_save.aspx?questionid=<%=intItemID%>" name="frmNewAnswer" id="frmNewAnswer">
														<TR>
															<TD><%=Translate.Translate("Ny svarmulighed")%></TD>
															<TD align="right"><INPUT type="text" class="std" name="PollAnswerTitle" id="PollAnswerTitle"></TD>
															<TD width="80" align="right"><%=Gui.Button(Translate.Translate("Tilføj"), "NewAnswer();", 90)%></TD>
														</TR>
													</form>
												</TABLE>
												<%=Gui.GroupBoxEnd%>
											</TD>
										</TR>
										<%End If%>
									</TABLE>
								</TD>
							</TR>
							<TR>
								<td align="right" valign="bottom">
									<%=Gui.MakeOkCancelHelp("if(html()){CheckForm()}",  "window.location='poll_questions_list.aspx?categoryid=" & intCategoryID & "'", True, "modules.poll.general.list.item.edit",  ,,"Luk")%>
								</td>
							</TR>
						</TABLE>
					</div>
				</td>
			</tr>
		</TABLE>
<BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>
