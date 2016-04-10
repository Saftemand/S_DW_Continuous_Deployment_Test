<%@ Page CodeBehind="TaskManager_Status_close.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.TaskManager_Status_close" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>

<script language="VB" runat="Server">
Dim strSQL As String
Dim TaskIDs As String
Dim tskMail As New TaskManagerMail
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

TaskIDs = Request.Form.Item("cbCompleteTask")

If TaskIDs <> "" Then
	Dim cnTask	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdTask As IDbCommand		= cnTask.CreateCommand()
	
	strSQL = "UPDATE [TaskManager] SET [TaskStatus] = 3 WHERE [TaskID] IN (" & TaskIDs & ")"
	cmdTask.CommandText = strSQL
	cmdTask.ExecuteNonQuery()
	
	strSQL = "SELECT * FROM [TaskManager] WHERE TaskID IN (" & TaskIDs & ")"
	cmdTask.CommandText = strSQL
	Dim drTask as IDataReader = cmdTask.ExecuteReader()
	Do While drTask.Read()
		If Not isDBNull(drTask("TaskGiverID")) Or isDBNull(drTask("TaskTakerID")) Or isDBNull(drTask("TaskID")) Then
			tskMail.SendNotificationMail(drTask("TaskGiverID").ToString, drTask("TaskTakerID").ToString, drTask("TaskID").ToString)
		End If
	Loop 
	
	drTask.Close()
	drTask.Dispose()
	cmdTask.Dispose()
	cnTask.Dispose()
	
End If

If Request.Item("Page") = "default" Then
	Response.Redirect("/Admin/MyPage/Default.aspx")
Else
	Response.Redirect("TaskManager_Administration.aspx")
End If
%>
