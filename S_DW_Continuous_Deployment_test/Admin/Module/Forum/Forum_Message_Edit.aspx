<%@ Page CodeBehind="Forum_Message_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Message_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim strForumMessageBody As Object
Dim strForumMessageAuthorEMail As String
Dim DWEditorHideTableToolbar As Boolean
Dim strForumMessageAuthor As String
Dim EditMode As String
Dim strForumMessageCreated As Object
Dim strForumMessageName As String
Dim intMessageID As String
Dim intCategoryID As String

intMessageID = Request.QueryString.Item("messageid")
intCategoryID = Request.QueryString.Item("categoryid")

If Request.QueryString.Item("mode") = "reply" Then
	EditMode = "reply"
Else
	EditMode = "edit"
End If

If intMessageID <> "" And IsNumeric(intMessageID) Then
	Dim cnMessage	As IDbConnection = Database.CreateConnection("Forum.mdb")
	Dim cmdSelect	As IDbCommand	 = cnMessage.CreateCommand
	cmdSelect.CommandText = "SELECT * FROM ForumMessage WHERE ForumMessageID=" & intMessageID
	Dim drMessage	As IDataReader	 = cmdSelect.ExecuteReader()
	
	If drMessage.Read() Then
		strForumMessageBody = drMessage("ForumMessageBody").ToString
		strForumMessageName = drMessage("ForumMessageName").ToString
		strForumMessageCreated = drMessage("ForumMessageCreated").ToString
		strForumMessageAuthor = drMessage("ForumMessageAuthor").ToString
		strForumMessageAuthorEMail = drMessage("ForumMessageAuthorEMail").ToString
	End If
	drMessage.Close()
	drMessage.Dispose()
	cmdSelect.Dispose()
	cnMessage.Dispose()
Else
	strForumMessageCreated = Dates.DWNow().Clone()
End If

%>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
		<script src="/Admin/Module/Common/Common.js" type="text/javascript"></script>
	</HEAD>
	<SCRIPT LANGUAGE="javascript">
		<!--
			function DoNewMessage() {
				if (document.getElementById('frmNewMessage').ForumMessageName.value == "") {
					alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Overskrift"))%>");
					document.getElementById('frmNewMessage').ForumMessageName.focus();
				}
				else if (document.getElementById('frmNewMessage').ForumMessageAuthor.value == "") {
					alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Forfatter"))%>");
					document.getElementById('frmNewMessage').ForumMessageAuthor.focus();
				}
				else if (!ValidateEmailRegExp(document.forms["frmNewMessage"].elements["ForumMessageAuthorEMail"].value))
				{
					alert("<%=Translate.JsTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("E-mail"))%>");
					document.forms["frmNewMessage"].elements["ForumMessageAuthorEMail"].focus();
				}
				else {
					//if(html()){
						document.getElementById('frmNewMessage').submit();
					//}
				}
			}
			
			function DoReplyMessage() {
				location.href = "Forum_Message_Edit.aspx?categoryid=<%=intCategoryID%>&mode=reply&messageid=<%=intMessageID%>";
			}
		//-->
	</SCRIPT>
	<BODY>
	<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%", Translate.Translate("Forum",9), "%c%", Translate.Translate("indlæg")), Translate.Translate("Indlæg"), "all")%>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<tr>
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table height="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
								<BR>
								<%If EditMode = "reply" Then%>
								<%=Gui.GroupBoxStart(Translate.Translate("Oprindelig indlæg"))%>
									<TABLE border="0" cellpadding="0" cellspacing="2" width="560">
										<TR>
											<TD width="160"><%=Translate.Translate("Overskrift")%></TD>
											<TD width="400"><%=Server.HtmlEncode(strForumMessageName)%></TD>
										</TR>
										<TR>
											<TD width="160"><%=Translate.Translate("Forfatter")%></TD>
											<TD width="400"><%=Server.HtmlEncode(strForumMessageAuthor)%></TD>
										</TR>
										<TR>
											<TD width="160"><%=Translate.Translate("E-mail")%></TD>
											<TD width="400"><%=Server.HtmlEncode(strForumMessageAuthorEMail)%></TD>
										</TR>
										<TR>
											<TD width="160"><%=Translate.Translate("Dato")%></TD>
											<TD width="400"><%=Dates.ShowDate(CDate(strForumMessageCreated), Dates.Dateformat.Long, True)%></TD>
										</TR>
										<TR>
											<TD colspan="2"><BR><%=strForumMessageBody%></TD>
										</TR>
									</TABLE>
								<%=Gui.GroupBoxEnd%>
								<%End If%>
								<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
									<TABLE border="0" cellpadding="0" cellspacing="2" width="100%">
										<FORM id="frmNewMessage" name="frmNewMessage" action="Forum_Message_Save.aspx?<%=Base.IIf(EditMode = "reply", "mode=reply&", "")%>categoryid=<%=intCategoryID & Base.IIf(intMessageID <> "", "&messageid=" & intMessageID, "")%>" method="post">
										<TR>
											<TD width="170"><%=Translate.Translate("Overskrift")%></TD>
											<TD><INPUT type="text" maxlength="250" class="std" name="ForumMessageName" id="ForumMessageName" value="<%=Base.IIf(EditMode = "reply", Translate.Translate("Sv") & ": " & Replace(Server.HtmlEncode(strForumMessageName) & "", Translate.Translate("Sv") & ": ", ""), Server.HtmlEncode(strForumMessageName))%>"></TD>
										</TR>
										<TR>
											<TD><%=Translate.Translate("Forfatter")%></TD>
											<TD><INPUT type="text" maxlength="250" class="std" name="ForumMessageAuthor" id="ForumMessageAuthor" value="<%=Base.IIf(EditMode = "reply", "", Server.HtmlEncode(strForumMessageAuthor))%>"></TD>
										</TR>
										<TR>
											<TD><%=Translate.Translate("E-mail")%></TD>
											<TD><INPUT type="text" maxlength="250" class="std" name="ForumMessageAuthorEMail" id="ForumMessageAuthorEMail" value="<%=Base.IIf(EditMode = "reply", "", Server.HtmlEncode(strForumMessageAuthorEMail))%>"></TD>
										</TR>
										<TR>
											<TD><%=Translate.Translate("Dato")%></TD>
											<TD><%=Dates.DateSelect(Base.IIf(EditMode = "reply", Dates.DWNow(), strForumMessageCreated), True, True, False, "ForumMessageCreated")%></TD>
										</TR>
									</table>
								<%=Gui.GroupBoxEnd%>
								<%=Gui.GroupBoxStart(Translate.Translate("Tekst"))%>
									<TABLE border="0" cellpadding="0" cellspacing="2" width="100%">
										<TR>
											<TD colspan="2">
												<BR>
												<%DWEditorHideTableToolbar = True
												Response.Write(Gui.Editor("ForumMessageBody", 550,  400, Base.IIf(EditMode = "reply", "", strForumMessageBody)))
												%>
											</TD>
										</TR>
										</FORM>
									</TABLE>
								<%=Gui.GroupBoxEnd%>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<%If intMessageID <> "" And EditMode = "edit" Then%>
											<td><%=	Gui.Button(Translate.Translate("Besvar"), "DoReplyMessage();", 0)%></td>
											<td width="5"></td>
										<%End If%>
										<td><%=Gui.Button(Translate.Translate("OK"), "html();DoNewMessage();", 0)%></td>
										<td width="5"></td>
										<td><%=Gui.Button(Translate.Translate("Annuller"), "history.back();", 0)%></td>
										<%=Gui.HelpButton("forum", "modules.forum.general.list.item.edit",,5)%>
										<td width="10"></td>
									</tr>
									<tr>
										<td colspan="4" height="5"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
<%=Gui.SelectTab()%>
	<BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
