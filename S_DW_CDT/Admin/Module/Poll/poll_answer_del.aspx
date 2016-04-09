<%@ Page CodeBehind="poll_answer_del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_answer_del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%
'**************************************************************************************************
'	Current version:	1.1.0
'	Created:			29-07-2002
'	Last modfied:		02-06-2004
'
'	Purpose: Edit categories of poll
'
'	Revision history:
'		1.0.0 - 29-07-2002
'		First version.
'
'		1.1.0 - 02-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************
Dim intAnswerID As Integer
Dim intQuestionID As Integer

intAnswerID = Request.QueryString.Item("answerid")
intQuestionID = Request.QueryString.Item("questionid")

If Not isNothing(intAnswerID) And intAnswerID <> 0
	Dim cnAnswerDel As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
	Dim cmdAnswerDel As IDbCommand = cnAnswerDel.CreateCommand()
	cmdAnswerDel.CommandText = "DELETE FROM PollAnswer WHERE PollAnswerID = " & intAnswerID
	cmdAnswerDel.ExecuteNonQuery()
	'Cleanup
	cnAnswerDel.Close()
	cmdAnswerDel.Dispose()
	cnAnswerDel.Dispose()
End if


Response.Redirect("poll_questions_edit.aspx?itemid=" & intQuestionID)
%>
