<%@ Page CodeBehind="TaskManager_Administration.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.TaskManager_Administration" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim strSQLArchivedTask As String
Dim strAccessSql As String
Dim strSQLTakenTask As String
Dim strSQLSelectedTask As String
Dim strSQLGivenTask As String
Dim SQLGetOrder As String

Dim ShowEditor As String
Dim ShowComments As String
Dim SortOrder As String

Dim TaskHeader As String
Dim TaskID As String
Dim TaskPriority As String
Dim TaskStatus As String
Dim TaskDescription As String
Dim TaskDeadline As String
Dim TaskGiverID As String
Dim TaskTakerID As String
Dim TaskNotification As String
Dim TaskComments As String

Dim intPageAmount As Integer
Dim intCurPos As Integer
Dim intCurEndCounter As Integer
Dim intTypes As Integer
Dim intPosCounter As Integer
Dim intNextPos As Integer
Dim intArchivedTaskRecordCount As Integer = 0

Dim returnPage As String
Dim SortField As String
Dim blnShowOK As Boolean
Dim strArchive As String

Dim dicUsersEmail As New HashTable
Dim dicAccssUser As New HashTable
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
Dim cn		As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmd		As IDbCommand		= cn.CreateCommand()

TaskID		= Base.ChkNumber(Request.QueryString.Item("TaskID"))
strArchive	= Request.QueryString.Item("Archive")
SortOrder	= Request.Item("SortOrder")
SortField	= Request.Item("SortField")

intPageAmount = 20
intCurPos = Base.ChkNumber(Request.Item("CurPos"))

If isNothing(intCurPos) Then
	intCurPos = 0
End If
intCurPos = 0

If Request.Item("Page") = "default" Then
	returnPage = "/Admin/MyPage/Default.aspx"
Else
	returnPage = "../../Content/Moduletree/EntryContent.aspx"
End If

If TaskID <> "0" Then
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
	
End If


If TaskGiverID = "" Or CStr(Session("DW_Admin_UserID")) = TaskGiverID Then
	ShowEditor		= ""
	ShowComments	= "None"
Else
	ShowEditor		= "None"
	ShowComments	= ""
End If

If strArchive = "true" Then
	ShowEditor		= "None"
	ShowComments	= ""
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

strSQLArchivedTask = " SELECT * FROM TaskManager WHERE TaskStatus = 3 AND (TaskGiverID = " & Session("DW_Admin_UserID") & " OR TaskTakerID = " & Session("DW_Admin_UserID") & ")" & SQLGetOrder
'w strSQLrsArchivedTask
intTypes = 0
'Dim varSettings			:	varSettings = Array("230", Translate.JsTranslate("Medlem"), Translate.JsTranslate("Andre grupper"))

strAccessSql = " SELECT AccessUserID, AccessUserName, AccessUserEmail FROM AccessUser " & " WHERE (AccessUserType IN (4,5,3)) " & " ORDER BY AccessUserID ASC"

Dim cnAccess	As IDbConnection	= Database.CreateConnection("Access.mdb")
Dim cmdAccess	As IDbCommand		= cnAccess.CreateCommand()
cmdAccess.CommandText = strAccessSql
Dim drAccess	As IDataReader		= cmdAccess.ExecuteReader()

Do While drAccess.Read()
	dicAccssUser.Add(drAccess(0).ToString, drAccess(1).ToString)
	dicUsersEmail.Add(drAccess(0).ToString, drAccess(2).ToString)
Loop 

drAccess.Close()
drAccess.Dispose()
cmdAccess.Dispose()
cnAccess.Dispose()
%>

<SCRIPT LANGUAGE="JavaScript">

function SaveTask() {
	if(TaskManagerEditorForm.TaskHeader=='') {
		alert('<%=Translate.JsTranslate("Der skal skrives et emne!")%>')
		TaskManagerEditorForm.TaskHeader.focus();
	} else {
		html();
		TaskManagerEditorForm.submit()
	}
}

	function SetSort(intSortField) {
		if(TaskManagerArchiveForm.SortField == intSortField) {
			if(TaskManagerArchiveForm.SortOrder == 'ASC') {	
				document.getElementById('TaskManagerArchiveForm').SortOrder = 'DESC'
			} else {
				document.getElementById('TaskManagerArchiveForm').SortOrder = 'ASC'
			}
			TaskManagerArchiveForm.submit();
		}else {
			TaskManagerArchiveForm.SortField = intSortField
			TaskManagerArchiveForm.submit();
		}
	}


	function Paging(intDirection) {
		if(intDirection==-1) {
			TaskManagerArchiveForm.CurPos.value = <%=intCurPos - intPageAmount%>
		} else {
			TaskManagerArchiveForm.CurPos.value = <%=intCurPos + intPageAmount%>
		}
		TaskManagerArchiveForm.submit();
	}


	function TaskDelete(TaskTakerID, TaskID, TaskHeader, TabID){
		if (confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("opgave"))%>\n(' + TaskHeader + ')')){
			location = "TaskManager_delete.aspx?Tab=" + TabID + "&TaskTaker=" + TaskTakerID + "&TaskID=" + TaskID
		}
	}


</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE><%=Translate.JSTranslate("Notificering",9)%></TITLE>
		<LINK REL="STYLESHEET" TYPE="text/css" HREF="/Admin/Stylesheet.css">
	</HEAD>
	<BODY>
		<%=Gui.MakeHeaders(Translate.Translate("Notificering",9), Translate.Translate("Opgaver") & ", " & Translate.Translate("Arkiv"), "all")%>
			<div id="Tab1" style="display:;">
				<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable" ID="Table1">
				<form method="post" action="TaskManager_Status_close.aspx" id="TaskManagerTakerForm" name="TaskManagerTakerForm">
					<TR>
						<TD valign="top">
							<BR>
							<div ID="Tab1" STYLE="display:;">
								<%=Gui.GroupBoxStart(Translate.Translate("Mine opgaver"))%>
								<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table4">
								<%

cmd.CommandText = strSQLTakenTask
Dim drTakenTask As IDataReader = cmd.ExecuteReader()

Dim blnDrTakenTaskHasRows As Boolean = False

If drTakenTask.Read() Then
	blnDrTakenTaskHasRows = True
End If

drTakenTask.Close()
drTakenTask = cmd.ExecuteReader()

If Not blnDrTakenTaskHasRows Then
	blnShowOK = False
	%>
									<TR>
										<TD COLSPAN="4">
											<strong><%=Translate.Translate("Ingen opgaver")%></strong>
										</TD>
									</TR>
								<%	
Else
	blnShowOK = True
	%>
	
									<TR>
										<td>
											<!--STRONG>
												<%=Translate.Translate("Afslut")%>
											</STRONG-->
										</TD>
										<TD width="45%"> 
											<STRONG>
												<%=Translate.Translate("Emne")%>
											</STRONG>
										</td>
										<td width="24%">
											<STRONG>
												<%=Translate.Translate("Deadline")%>
											</STRONG>
										</TD>
										<td>
											<STRONG>
												<%=Translate.Translate("Stiller")%>
											</STRONG>
										</TD>
									</TR>
								<%	
End If

Do While drTakenTask.Read()
%>
									<TR>
										<TD title="<%=Translate.Translate("Opdater")%>" align="center" WIDTH="5%">
											<input type="CheckBox" value="<%=drTakenTask("TaskID")%>" id="cbCompleteTask" name="cbCompleteTask">
										</TD>
										<TD style="cursor: hand;" onclick="Javascript: location='TaskManager_Edit.aspx?TaskID=<%=drTakenTask("TaskID")%>'" width="40%">&nbsp;<%=drTakenTask("TaskHeader")%></TD>
										<TD><%=drTakenTask("TaskDeadline")%></TD>
										<TD><a title="mailto" style="text-decoration :underline;" href="mailto:<%=dicUsersEmail.Item(CStr(drTakenTask("TaskGiverID") & ""))%>"><%=dicAccssUser.Item(CStr(drTakenTask("TaskGiverID") & ""))%></a></TD>
									</TR>
									<TR>
										<TD COLSPAN="4" BGCOLOR="#C4C4C4">
										</TD>
									</TR>
								<%	
Loop 

drTakenTask.Close()
drTakenTask.Dispose()


%>
									<TR>
										<TD COLSPAN="4">
											&nbsp;
										</TD>
									</TR>
									<tr>
										<td width="150"></td>
										<td colspan="3" align=right><%If blnShowOK = True Then Response.Write(Gui.Button(Translate.Translate("Afslut markerede"), "TaskManagerTakerForm.submit();", 0))%>
									</tr>
								</TABLE>
								<%=Gui.GroupBoxEnd%>

								<%=Gui.GroupBoxStart(Translate.Translate("Stillede opgaver"))%>
								<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table2">
								<%

Dim blnDrGivenTaskHasRows as Boolean = False

cmd.CommandText = strSQLGivenTask
Dim drGivenTask As IDataReader = cmd.ExecuteReader()

If drGivenTask.Read() Then
	blnDrGivenTaskHasRows = True
End If
drGivenTask.Close()
drGivenTask = cmd.ExecuteReader()

If Not blnDrGivenTaskHasRows Then
	%>
									<TR>
										<TD COLSPAN="4"><strong><%=Translate.Translate("Ingen opgaver")%></strong></TD>
									</TR>
								<%	
Else
	%>
									<TR>
										<TD width="50%">&nbsp;&nbsp; 
												<STRONG>
												<%=Translate.Translate("Emne")%>
												</STRONG>
										</td>
										<td>
											<STRONG>
												<%=Translate.Translate("Deadline")%>
											</STRONG>
										</TD>
										<td>
											<STRONG>
												<%=Translate.Translate("Tildelt til")%>
											</STRONG>
										</TD>
										<td>
											<STRONG>
												<%=Translate.Translate("Slet")%>
											</STRONG>
										</TD>
									</TR>
									<TR>
										<TD COLSPAN="4" BGCOLOR="#C4C4C4">
										</TD>
									</TR>

								<%	
End If

Do While drGivenTask.Read()
%>
									<!--TR>
										<TD COLSPAN="4" BGCOLOR="#C4C4C4">
										</TD>
									</TR-->
									<TR>
										<TD style="cursor: hand;" onclick="Javascript: location='TaskManager_Edit.aspx?TaskID=<%=drGivenTask("TaskID")%>&'" height="15px" width="50%">&nbsp;<%=drGivenTask("TaskHeader")%></TD>
										<TD><%=drGivenTask("TaskDeadline")%></TD>
										<TD><a title="mailto" style="text-decoration :underline;" href="mailto:<%=dicUsersEmail.Item(CStr(drGivenTask("TaskTakerID") & ""))%>"><%=dicAccssUser.Item(CStr(drGivenTask("TaskTakerID") & ""))%></a></TD>
										<TD align="center" WIDTH="5%"><img src="/admin/images/delete.gif" alt="<%=Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("opgave"))%>" style="cursor: hand;" onclick="JavaScript:TaskDelete('<%=drGivenTask("TaskTakerID").ToString%>', '<%=drGivenTask("TaskID")%>', '<%=drGivenTask("TaskHeader")%>', 1)"></TD>
									</TR>
									<TR>
										<TD COLSPAN="4" BGCOLOR="#C4C4C4">
										</TD>
									</TR>
								<%	
	
Loop 

drGivenTask.Dispose()

%>

									<TR>
										<TD COLSPAN="4">
											&nbsp;
										</TD>
									</TR>
								</TABLE>
								<%=Gui.GroupBoxEnd%>
							</div>
						</TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT" VALIGN="BOTTOM">
							<TABLE ID="Table3">
								<TR>
									<TD><%=Gui.Button(Translate.Translate("Ny opgave"), "location='TaskManager_Edit.aspx'", 0)%></TD>
									<TD><%=Gui.Button(Translate.Translate("Luk"), "location='" & returnPage & "'", 0)%></TD>
									<%=Gui.HelpButton("", "modules.taskmanager.general.list.tasks")%>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</form>
			</TABLE>
		</div>
		<div id="Tab2" style="display:None;">
			<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable" ID="Table10">
				<form method="post" action="TaskManager_Administration.aspx?Tab=2" id="TaskManagerArchiveForm" name="TaskManagerArchiveForm">
					<input type="hidden" ID="SortOrder" name="SortOrder" value="<%=SortOrder%>">
					<input type="hidden" ID="SortField" name="SortField" value="<%=SortField%>">
					<input type="hidden" ID="CurPos" name="CurPos" value="">
					<TR>
						<TD valign="top">
							<BR />
							<div ID="Div5" STYLE="display:;">
								<%=Gui.GroupBoxStart(Translate.Translate("Arkiv"))%>
								<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table11">
								<%
intPosCounter = 0
intNextPos = intCurPos + intPageAmount

cmd.CommandText = strSQLArchivedTask
Dim drArchivedTask As IDataReader = cmd.ExecuteReader()

Dim blnDrArchivedTaskHasRows As Boolean = False

If drArchivedTask.Read() Then
	blnDrArchivedTaskHasRows = True
End If

drArchivedTask.Close()
drArchivedTask = cmd.ExecuteReader()

Do While drArchivedTask.Read()
	intArchivedTaskRecordCount += 1
Loop

drArchivedTask.Close()
drArchivedTask = cmd.ExecuteReader()


If Not blnDrArchivedTaskHasRows Then
	%>
									<TR>
										<TD COLSPAN="5"><strong><%=Translate.Translate("Ingen opgaver")%></strong></TD>
									</TR>
								<%	
Else
	%>
									<TR>
										<TD width="30%">&nbsp;&nbsp; 
											<STRONG>
												<Span style="cursor: hand;<%If SortField = "TaskHeader" Then Response.Write("text-decoration :underline;")
											if SortField = "TaskHeader" Then 
												Response.Write("text-decoration :underline;") 
											End If%>" 
											onclick="SetSort('TaskHeader');"><%=Translate.Translate("Emne")%></Span>
											</STRONG>
										</td>
										<td>
											<STRONG>
												<Span style="cursor: hand;<%	If SortField = "TaskDeadline" Then Response.Write("text-decoration :underline;")
												if SortField = "TaskDeadline" Then 
													Response.Write("text-decoration :underline;") 
												End If %>
												onclick="SetSort('TaskDeadline');"><%=Translate.Translate("Deadline")%></Span>
											</STRONG>
										</TD>
										<td>
											<STRONG>
												<Span style="cursor: hand;<%	If SortField = "TaskGiverID" Then Response.Write("text-decoration :underline;")
												if SortField = "TaskGiverID" Then 
													Response.Write("text-decoration :underline;")
												End If%>
												onclick="SetSort('TaskGiverID');"><%=Translate.Translate("Opgavestiller")%></Span>
											</STRONG>
										</TD>
										<td>
											<STRONG>
												<Span style="cursor: hand;<%	If SortField = "TaskTakerID" Then Response.Write("text-decoration :underline;")
												if SortField = "TaskTakerID" Then 
													Response.Write("text-decoration :underline;") 
												End If%> 
												onclick="SetSort('TaskTakerID');"><%=Translate.Translate("Tildelt til")%></Span>
											</STRONG>
										</TD>
										<td>
											<STRONG>
												<%=Translate.Translate("Slet")%>
											</STRONG>
										</TD>
									</TR>
								<%	
									End If
								%>
									
											<%
'w intPosCounter & ":" & intNextPos & ":" & intCurPos & ":" & intCurEndCounter + 1 & ":" & (intCurEndCounter + 1) & " > " & rsAudit.RecordCount
If intNextPos <> intPageAmount Then
	Response.Write("<img style=""cursor: hand;"" onclick=""Javascript:Paging(-1);"" src=""/Admin/images/Page_Previous.gif"">&nbsp;")
Else
End If
If CInt(intCurEndCounter + 1) < CInt(intArchivedTaskRecordCount) Then
	Response.Write("<img style=""cursor: hand;"" onclick=""Javascript:Paging(1);"" src=""/Admin/images/Page_Next.gif"">&nbsp;")
Else
	Response.Write("<img src=""/x.gif"" height=""1px"" width=""20px"">&nbsp;")
End If

Do While drArchivedTask.Read()
	If Not blnDrArchivedTaskHasRows Then blnDrArchivedTaskHasRows = True
	If intPosCounter >= intCurPos And intPosCounter < intNextPos Then
									%>
									<TR>
										<TD COLSPAN="5" BGCOLOR="#C4C4C4">
										</TD>
									</TR>
									<TR>
										<TD style="cursor: hand;" onclick="Javascript: location='TaskManager_Administration.aspx?Archive=true&TaskID=<%=drArchivedTask("TaskID")%>&Tab=2'" width="30%">&nbsp;<%=drArchivedTask("TaskHeader")%></TD>
										<TD><%=drArchivedTask("TaskDeadline")%></TD>
										<TD><a title="mailto" style="text-decoration :underline;" href="mailto:<%=dicUsersEmail.Item(CStr(drArchivedTask("TaskGiverID") & ""))%>"><%=dicAccssUser.Item(CStr(drArchivedTask("TaskGiverID") & ""))%></a></TD>
										<TD title="<%=Translate.Translate("Tildelt til")%>">
											<a title="mailto" style="text-decoration :underline;" href="mailto:<%=dicUsersEmail.Item(CStr(drArchivedTask("TaskTakerID") & ""))%>"><%=dicAccssUser.Item(CStr(drArchivedTask("TaskTakerID") & ""))%></a>
										</TD>
										<TD align="center" WIDTH="5%">
										<%		If drArchivedTask("TaskGiverID") = Session("DW_Admin_UserID") Then%>
											<img src="/admin/images/delete.gif" alt="<%=Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("opgave"))%>" style="cursor: hand;" onclick="JavaScript:TaskDelete('<%=drArchivedTask("TaskTakerID").ToString%>', '<%=drArchivedTask("TaskID")%>', '<%=drArchivedTask("TaskHeader")%>', 2)"></TD>
										<%		End If%>
									</TR>
								<%		
		intCurEndCounter = intPosCounter
	End If
	intPosCounter = intPosCounter + 1
Loop 

drArchivedTask.Dispose()

%>
										</TD>
									</TR>
									<!--tr>
										<td width="150"></td>
										<td colspan="3" align=right>
										<%=Gui.Button("Ok", "", 90)%></td>
									</tr-->
								</TABLE>
								<%=Gui.GroupBoxEnd%>
							</div>
						</TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT" VALIGN="BOTTOM">
							<TABLE ID="Table13">
								<TR>
									<TD><%=Gui.Button(Translate.Translate("Ny opgave"), "location='TaskManager_Edit.aspx'", 0)%></TD>
									<TD><%=Gui.Button(Translate.Translate("Luk"), "location='" & returnPage & "'", 0)%></TD>
									<%=Gui.HelpButton("", "modules.taskmanager.general.list.archive")%>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</form>
			</TABLE>
		</div>
	</BODY>
</HTML>
<%
cmd.Dispose()
cn.Dispose()
%>
<%=Gui.SelectTab()%>

<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>