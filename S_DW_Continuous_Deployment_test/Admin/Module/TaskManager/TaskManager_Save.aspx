<%@ Page CodeBehind="TaskManager_Save.aspx.vb" validateRequest="false"	 Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.TaskManager_Save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Admin" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>

<script language="VB" runat="Server">
Dim strSQL As String
Dim dato as New Dates
Dim strTaskID As String
</script>
<%
'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			12-02-2002
'	Last modfied:		12-02-2002
'
'	Purpose: File to save category
'
'	Revision history:
'		1.0 - 12-02-2002 - Gorm Kjeldsen
'		First version.
'**************************************************************************************************

strTaskID = Base.ChkNumber(request.Form.Item("TaskID"))

	Dim cnTask	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdTask	As IDbCommand		= cnTask.CreateCommand
	Dim dsTask	As DataSet			= New DataSet
	Dim daTask	As IDbDataAdapter	= Database.CreateAdapter()
	daTask.SelectCommand			= cmdTask
	Dim dtTask	As DataTable
	Dim row		As DataRow

If strTaskID = "0" Or strTaskID = "" Then
	cmdTask.CommandText		= "SELECT TOP 1 * FROM [TaskManager]"
	daTask.Fill(dsTask)
	dtTask = dsTask.Tables(0)
	row = dtTask.NewRow()
	dtTask.Rows.Add(row)
	
	row("TaskCreated")		= dato.DWNow()
	row("TaskGiverID")		= Session("DW_Admin_UserID")
	row("TaskStatus")		= 1
	row("TaskPriority")		= 2
	row("TaskHeader")		= request.Form.Item("TaskHeader").ToString
	row("TaskDeadline")		= dato.ParseDate("TaskDeadline").ToString
	row("TaskTakerID")		= request.Form.Item("TaskTakerID").ToString
	row("TaskNotification")	= Base.ChkBoolean(CStr(request.Form.Item("TaskNotification")) & "")
	row("TaskDescription")	= request.Form.Item("TaskDescription").ToString
	row("TaskComments")		= request.Form.Item("TaskComments").ToString
	
	'row("TaskPriority")	= request.form("TaskPriority")
	
	Database.CreateCommandBuilder(daTask)
	daTask.Update(dsTask)
	'TODO
        'SendNotificationMail(CStr(Session("DW_Admin_UserID")), CStr(request.Form.Item("TaskTakerID")), "0")
Else
	cmdTask.CommandText = "SELECT * FROM TaskManager WHERE TaskID = " & strTaskID
	daTask.Fill(dsTask)
	dtTask = dsTask.Tables(0)
	row = dtTask.Rows(0)
	
	row("TaskHeader")		= request.Form.Item("TaskHeader")
	row("TaskDeadline")		= dato.ParseDate("TaskDeadline")
	row("TaskTakerID")		= request.Form.Item("TaskTakerID")
	row("TaskNotification")	= Base.ChkBoolean(CStr(request.Form.Item("TaskNotification")) & "")
	
	row("TaskDescription")	= request.Form.Item("TaskDescription")
	row("TaskComments")		= request.Form.Item("TaskComments")
	'rsTask("TaskPriority")	= request.form("TaskPriority")
	row("TaskStatus")		= request.Form.Item("TaskStatus")
	row("TaskPriority")		= request.Form.Item("TaskPriority")
	
	Database.CreateCommandBuilder(daTask)
	daTask.Update(dsTask)
	
	If row("TaskNotification") = True Then
		If Session("DW_Admin_UserID") = row("TaskGiverID") Then
                SendNotificationMail(CStr(Session("DW_Admin_UserID")), CStr(row("TaskTakerID")), strTaskID)
		Else
                SendNotificationMail(CStr(Session("DW_Admin_UserID")), CStr(row("TaskGiverID")), strTaskID)
		End If
	End If
End If

dsTask.Dispose()
cmdTask.Dispose()
cnTask.Dispose()
	
Response.Redirect("TaskManager_Administration.aspx")
%>
