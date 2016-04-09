<%@ Page CodeBehind="TaskManager_Edit.aspx.vb" ValidateRequest="false" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.TaskManager_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim TaskID As String
Dim SortField As String
Dim ShowComments As String
Dim SortOrder As String
Dim TaskTakerID As String
Dim TaskNotification As String
Dim strSQLTakenTask As String
Dim returnPage As String
Dim strAccessSql As String
Dim strSQLrsArchivedTask As String
Dim dato as New Dates
Dim TaskStatus As String
Dim TaskDescription As String
Dim strSQLSelectedTask As String
Dim ShowEditor As String
Dim TaskGiverID As String
Dim TaskPriority As String
Dim UserList As String
Dim TaskHeader As String
Dim TaskDeadline As String
Dim SQLGetOrder As String
Dim TaskComments As String
Dim strSQLGivenTask As String

Dim intPageAmount As Integer
Dim intCurPos As Integer

Dim intTypes As Integer

Dim dicUsersEmail As New HashTable
Dim dicAccssUser As New HashTable
Dim strArchive as String
</script>
<%
'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			05-08-2003
'	Last modfied:		05-08-2003
'
'	Purpose: Administrator for the TaskManager
'
'	Revision history:
'		1.0 - 05-08-2003 - John Krogh
'		First version.
'**************************************************************************************************

TaskID			= Base.ChkNumber(Request.QueryString.Item("TaskID"))
strArchive		= Request.QueryString.Item("strArchive")
SortOrder		= Request.Item("SortOrder")
SortField		= Request.Item("SortField")
intPageAmount	= 20
intCurPos		= Base.ChkNumber(Request.Item("CurPos"))

If isNothing(intCurPos) Then
	intCurPos = 0
End If

If Request.Item("Page") = "default" Then
	returnPage = "/Admin/MyPage/Default.aspx"
Else
	returnPage = "/Admin/Module/Modules.aspx"
End If

If TaskID <> "0" Then
	Dim cn As IDbConnection = Database.CreateConnection("Dynamic.mdb")
	Dim cmd As IDbCommand = cn.CreateCommand()
	strSQLSelectedTask = " SELECT * FROM TaskManager WHERE TaskID = " & TaskID
	cmd.CommandText = strSQLSelectedTask
	Dim drSelectedTask As IDataReader = cmd.ExecuteReader()
	If drSelectedTask.Read() Then
		TaskHeader			= drSelectedTask("TaskHeader").ToString
		TaskDeadline		= drSelectedTask("TaskDeadline").ToString
		TaskTakerID			= drSelectedTask("TaskTakerID").ToString
		TaskNotification	= drSelectedTask("TaskNotification").ToString
		TaskStatus			= drSelectedTask("TaskStatus").ToString
		TaskPriority		= drSelectedTask("TaskPriority").ToString
		TaskDescription		= drSelectedTask("TaskDescription").ToString
		TaskComments		= drSelectedTask("TaskComments").ToString
		TaskGiverID			= drSelectedTask("TaskGiverID").ToString
	End If
	drSelectedTask.Close()
	drSelectedTask.Dispose()
	'Cleanup
	cmd.Dispose()
	cn.Dispose()

Else
	TaskDeadline = dato.DWNow
End If

If TaskGiverID = "" Or TaskGiverID = Session("DW_Admin_UserID") Then
	ShowEditor = ""
	ShowComments = "None"
Else
	ShowEditor = "None"
	ShowComments = ""
End If

If CStr(strArchive) = "true" Then
	ShowEditor = "None"
	ShowComments = ""
End If

If SortOrder = "" Then
	SortOrder = "ASC"
End If
If SortField = "" Then
	SortField = "TaskHeader"
End If
SQLGetOrder = " ORDER BY " & SortField & " " & SortOrder

strSQLGivenTask = " SELECT * FROM TaskManager WHERE TaskStatus <> 3 AND TaskGiverID = " & Session("DW_Admin_UserID")

strSQLTakenTask = " SELECT * FROM TaskManager WHERE TaskStatus <> 3 AND TaskTakerID = " & Session("DW_Admin_UserID")
'we strSQLTakenTask

strSQLrsArchivedTask = " SELECT * FROM TaskManager WHERE TaskStatus = 3 AND (TaskGiverID = " & Session("DW_Admin_UserID") & " OR TaskTakerID = " & Session("DW_Admin_UserID") & ")" & SQLGetOrder
'w strSQLrsArchivedTask
intTypes = 0
'Dim varSettings			:	varSettings = Array("230", Translate.JsTranslate("Medlem"), Translate.JsTranslate("Andre grupper"))

strAccessSql = " SELECT AccessUserID, AccessUserName, AccessUserEmail FROM AccessUser " & " WHERE (AccessUserType IN (4,5,3)) " & " ORDER BY AccessUserID ASC"

Dim cnAccess	As IDbConnection	= Database.CreateConnection("Access.mdb")
Dim cmdAccess	As IDbCommand		= cnAccess.CreateCommand()
cmdAccess.CommandText				= strAccessSql
Dim drAccess	As IDataReader		= cmdAccess.ExecuteReader()

Do While drAccess.Read()
	dicAccssUser.Add(CStr(drAccess(0)), CStr(drAccess(1) & ""))
	dicUsersEmail.Add(CStr(drAccess(0)), CStr(drAccess(2) & ""))
Loop 

drAccess.Close()
drAccess.Dispose()
cmdAccess.Dispose()
cnAccess.Dispose()
%>

<SCRIPT LANGUAGE="JavaScript">

function SaveTask() {
	if(TaskManagerEditorForm.TaskHeader.value == '') {
		alert('<%=Translate.JsTranslate("Der skal skrives et emne!")%>')
		TaskManagerEditorForm.TaskHeader.focus();
	} else if(TaskManagerEditorForm.TaskTakerID.value == 0) {
		alert('<%=Translate.JsTranslate("Vælg en bruger!")%>')
		TaskManagerEditorForm.TaskTakerID.focus();
	} else {
		html();
		TaskManagerEditorForm.submit()
	}
}

	function SetSort(intSortField) {
		if(TaskManagerArchiveForm.SortField == intSortField) {
			if(TaskManagerArchiveForm.SortOrder == 'ASC') {	
				TaskManagerArchiveForm.SortOrder = 'DESC'
			} else {
				TaskManagerArchiveForm.SortOrder = 'ASC'
			}
			TaskManagerArchiveForm.submit();
		}else {
			TaskManagerArchiveForm.SortField = intSortField
			TaskManagerArchiveForm.submit();
		}
	}


	function Paging(intDirection) {
		if(intDirection==-1) {
			TaskManagerArchiveForm.CurPos = <%=intCurPos - intPageAmount%>
		} else {
			TaskManagerArchiveForm.CurPos = <%=intCurPos + intPageAmount%>
		}
		TaskManagerArchiveForm.submit();
	}

</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE><%=Translate.JSTranslate("Notificering",9)%></TITLE>
		<LINK REL="STYLESHEET" TYPE="text/css" HREF="/Admin/Stylesheet.css">
	</HEAD>
	<BODY>
		<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Notificering",9),"%c%",Translate.Translate("opgave")), Translate.Translate("Opgaver"), "all")%>
		<div id="Tab1" style="display:;">
			<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable" ID="Table5">
				<TR>
				<form method="post" action="TaskManager_Save.aspx" id="TaskManagerEditorForm" name="TaskManagerEditorForm">
					<TD valign="top">
						<BR><input type="hidden" name="TaskID" id="TaskID" value="<%=TaskID%>">
						<div ID="Div1" STYLE="display:;">
							<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
							<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table6">
								<TR style="display: <%=ShowEditor%>">
									<TD WIDTH="170">&nbsp;<%=Translate.Translate("Deadline")%></TD>
									<TD>
										<%=dato.DateSelect(TaskDeadline, false, false, false, "TaskDeadline")%>
									</TD>
								</TR>
								<%
If ShowComments = "" Then
	Response.Write("<tr><TD WIDTH=""170"">&nbsp;" & Translate.Translate("Deadline") & "</TD><td>" & TaskDeadline & "</td></tr>")
End If

%>
								<TR style="display: <%=ShowEditor%>">
									<TD WIDTH="170">&nbsp;<%=Translate.Translate("Emne")%></TD>
									<TD>
										<input CLASS="std" maxlength="255" type="text" id="TaskHeader" Name="TaskHeader" value="<%=TaskHeader%>">
									</TD>
								</TR>
								<%
If ShowComments = "" Then
	Response.Write("<tr><TD WIDTH=""170"">&nbsp;" & Translate.Translate("Emne") & "</TD><td>" & TaskHeader & "</td></tr>")
End If

%>
								<TR>
									<TD WIDTH="170">&nbsp;<%=Translate.Translate("Tildel til")%></TD>
									<td>
									<%
If ShowComments = "None" Then
	Response.Write(Gui.UserList("TaskTakerID", Base.ChkNumber(TaskTakerID & "")))
Else
	Response.Write(dicAccssUser.Item(CStr(TaskTakerID) & "") & "<input type=""hidden"" name=""TaskTakerID"" id=""TaskTakerID"" value=""" & TaskTakerID & """)")
End If
%>
									</td>
								</TR>
								<TR>
									<TD WIDTH="170">&nbsp;<%=Translate.Translate("Prioritet")%></TD>
									<td>
									<%
If ShowEditor = "None" Then
	If TaskPriority = 1 Then
		Response.Write(Translate.JsTranslate("Høj"))
	ElseIf TaskPriority = 2 Then 
		Response.Write(Translate.JsTranslate("Normal"))
	ElseIf TaskPriority = 3 Then 
		Response.Write(Translate.JsTranslate("Lav"))
	End If
	Response.Write("<input type=""hidden"" name=""TaskPriority"" id=""TaskPriority"" value=""" & TaskPriority & """)")
Else
	Response.Write("<SELECT CLASS=""std"" ID=""TaskPriority"" Name=""TaskPriority"">")
	Response.Write("	<Option ")
	If TaskPriority = 1 Then
		Response.Write(" SELECTED ")
	End If
	Response.Write(" value=""1"">" & Translate.JsTranslate("Høj"))
	Response.Write("	<Option ")
	If TaskPriority = 2 Then
		Response.Write(" SELECTED ")
	End If
	Response.Write(" value=""2"">" & Translate.JsTranslate("Normal"))
	Response.Write("	<Option ")
	If TaskPriority = 3 Then
		Response.Write(" SELECTED ")
	End If
	Response.Write(" value=""3"">" & Translate.JsTranslate("Lav"))
	Response.Write("</SELECT>")
End If
%>
									
									</td>
								</TR>
								<TR>
									<TD WIDTH="170">&nbsp;<%=Translate.Translate("Status")%></TD>
									<td>
									<%
Response.Write("<SELECT CLASS=""std"" ID=""TaskStatus"" Name=""TaskStatus"">")
Response.Write("	<Option ")
If TaskStatus = 1 Then
	Response.Write(" SELECTED ")
End If
Response.Write(" value=""1"">" & Translate.JsTranslate("Tildelt"))

Response.Write("	<Option ")
If TaskStatus = 2 Then
	Response.Write(" SELECTED ")
End If
Response.Write(" value=""2"">" & Translate.JsTranslate("Åben"))
Response.Write("	<Option ")
If TaskStatus = 3 Then
	Response.Write(" SELECTED ")
End If
Response.Write(" value=""3"">" & Translate.JsTranslate("Lukket"))
Response.Write("</SELECT>")
%>
									</td>
								</TR>
								<TR>
									<TD WIDTH="170">&nbsp;<%=Translate.Translate("Notificer ved ændring")%></TD>
									<td>
									<%
If ShowComments = "None" Then
	Response.Write(Gui.CheckBox(TaskNotification, "TaskNotification"))
Else
	Response.Write("<input type=""CheckBox"" ")
	
	If TaskNotification = "True" Then
		Response.Write(" CHECKED ")
	End If
	Response.Write(" READONLY Name=""TaskNotification"">")
End If
%>
									
									</td>
								</TR>
							</TABLE>
							<%=Gui.GroupBoxEnd%>
						</div>
					</TD>
				</TR>
				<TR style="Display:<%=ShowEditor%>;">
					<TD valign="top">
						<BR>
						<div ID="Div2" STYLE="display:;">
							<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
							<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table7">
								<TR>
									<TD>
										<%= Gui.Editor("TaskDescription", 550, 400, TaskDescription)%>
									</TD>
								</TR>
							</TABLE>
							<%=Gui.GroupBoxEnd%>
						</div>
					</TD>
				</TR>
				<%
				If CStr(strArchive) = "true" Then
				%>
				<TR>
					<TD valign="top">
						<BR>
						<div ID="Div4" STYLE="display:;">
							<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
							<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table12">
								<TR>
									<TD>
										<%=TaskDescription%>
									</TD>
								</TR>
							</TABLE>
							<%=Gui.GroupBoxEnd%>
						</div>
					</TD>
				</TR>
				<%	
				End If
				%>
				<%
'If strArchive = "true" Then
'	ShowComments="None"
'End If
%>
				<TR style="Display: <%=ShowComments%>;">
					<TD valign="top">
						<BR>
						<div ID="Div3" STYLE="display:;">
							<%=Gui.GroupBoxStart(Translate.Translate("Kommentar"))%>
							<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table9">
								<TR>
									<TD>
										&nbsp;<textarea id="TaskComments" <%If CStr(strArchive) = "true" Then Response.Write("READONLY")
										if strArchive = "true" Then 
											Response.Write("READONLY")
										End If%> 
										Style="BACKGROUND-COLOR: #F4F4F4; BORDER-BOTTOM: #666666 solid 1px; BORDER-LEFT: #666666 solid 1px; BORDER-RIGHT: #666666 solid 1px; BORDER-TOP: #666666 solid 1px; COLOR: #333333; FONT-FAMILY: Verdana, Helvetica, Arial, Tahoma, Verdana, Arial; FONT-SIZE: 11px;" name="TaskComments" cols="90" rows="10"><%=TaskComments%></textarea><br><br>
									</TD>
								</TR>
							</TABLE>
							<%=Gui.GroupBoxEnd%>
						</div>
					</TD>
				</TR>
				<TR>
					<TD ALIGN="RIGHT" VALIGN="BOTTOM">
						<TABLE ID="Table8">
							<TR>
								<TD><%=Gui.Button(Translate.Translate("Ok"), "SaveTask();", 90)%></TD>
								<TD><%=Gui.Button(Translate.Translate("Annuller"), "location='TaskManager_Administration.aspx'", 0)%></TD>
								<%=Gui.HelpButton("", "modules.taskmanager.general.list.tasks.edit")%>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</form>
			</TABLE>
		</div>
	</BODY>
</HTML>
<%=Gui.SelectTab()%>

<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>