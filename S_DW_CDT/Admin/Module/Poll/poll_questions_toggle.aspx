<%@ Page CodeBehind="poll_questions_toggle.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_questions_toggle" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
'**************************************************************************************************
'	Current version:	1.1.0
'	Created:			29-07-2002
'	Last modfied:		03-06-2004
'
'	Purpose: Edit categories of poll
'
'	Revision history:
'		1.0.0 - 29-07-2002
'		First version.
'
'		1.1.0 - 03-06-2004 - David Frandsen
'		Converted to .Net
'
'**************************************************************************************************
Dim intCategoryID As Integer
Dim intItemID As Integer

intCategoryID = Request.QueryString.Item("categoryid")
intItemID = Request.QueryString.Item("itemid")

If IsNumeric(intItemID) And intItemID <> 0 Then
	Dim cnQuestion As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
	Dim cmd As IDbCommand = cnQuestion.CreateCommand
	cmd.CommandText = "SELECT * FROM PollItem WHERE PollItemID=" & intItemID
	Dim drQuestion as IDataReader = cmd.ExecuteReader()
		
	If drQuestion.Read() Then
		Dim blnToggle = Not Cbool(drQuestion("PollItemActive"))
		drQuestion.Close()
		cmd.CommandText = "UPDATE [PollItem] SET [PollItemActive] = " & Dynamicweb.Database.SqlBool(blnToggle) & " WHERE [PollItemID] =" & intItemID 
		cmd.ExecuteNonQuery()
	End If
	
	cnQuestion.Close()
	drQuestion.Dispose()
	cmd.Dispose()
	cnQuestion.Dispose()
	
End If

Response.Redirect("poll_questions_list.aspx?categoryid=" & intCategoryID)
%>
