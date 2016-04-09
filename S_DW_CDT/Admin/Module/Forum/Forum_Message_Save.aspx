<%@ Page CodeBehind="Forum_Message_Save.aspx.vb" ValidateRequest="false" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Message_Save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim dato As New Dates
Dim strMessageID As String
Dim strCategoryID As String

strMessageID = Request.QueryString.Item("messageid")
strCategoryID = Request.QueryString.Item("categoryid")

If strCategoryID <> "" Then
	Dim cnMessage	As IDbConnection	= Database.CreateConnection("Forum.mdb")
	Dim cmdMessage	As IDbCommand		= cnMessage.CreateCommand
	Dim dsMessage	As DataSet			= New DataSet
	Dim daMessage	As IDbDataAdapter	= Database.CreateAdapter()
	daMessage.SelectCommand				= cmdMessage
	Dim dtMessage	As DataTable
	Dim row			as DataRow
	
	If Request.QueryString.Item("mode") = "reply" Then
		'*** Reply
		cmdMessage.CommandText = "SELECT TOP 1 * FROM [ForumMessage]"
		daMessage.Fill(dsMessage)
		dtMessage = dsMessage.Tables(0)
		row = dtMessage.NewRow()
		dtMessage.Rows.Add(row)
		row("ForumMessageParentID") = strMessageID
		row("ForumMessageCategoryID") = strCategoryID
	ElseIf strMessageID <> "" And Not strMessageID ="0" Then 
		'*** Edit of post
		cmdMessage.CommandText = "SELECT * FROM ForumMessage WHERE ForumMessageID=" & strMessageID
		daMessage.Fill(dsMessage)
		dtMessage = dsMessage.Tables(0)
		row = dtMessage.Rows(0)
	Else
		'*** New post
		cmdMessage.CommandText = "SELECT TOP 1 * FROM [ForumMessage]"
		daMessage.Fill(dsMessage)
		dtMessage = dsMessage.Tables(0)
		row = dtMessage.NewRow()
		dtMessage.Rows.Add(row)
		row("ForumMessageParentID") = 0
		row("ForumMessageCategoryID") = strCategoryID
	End If
	'Test
	row("ForumMessageAuthorID")= 50
	'Test
	row("ForumMessageName") = Base.ChkValue(Request.Form.Item("ForumMessageName"))
	row("ForumMessageCreated") = dato.ParseDate("ForumMessageCreated")
	row("ForumMessageAuthor") = Base.ChkValue(Request.Form.Item("ForumMessageAuthor"))
	row("ForumMessageAuthorEMail") = Base.ChkValue(Request.Form.Item("ForumMessageAuthorEMail"))
	row("ForumMessageBody") = Base.ChkValueNoStrip(Request.Form.Item("ForumMessageBody") & "")
	
	Database.CreateCommandBuilder(daMessage)
	daMessage.Update(dsMessage)
	
	
	'*** If notify then do it.
	If Request.QueryString.Item("mode") = "reply" Then
		'TODO: Reply with email
		Dim strNewMessageID as String = Database.GetAddedIdentityKey(row, cnMessage, 0)
            NotifyAllByCategory(strMessageID, strNewMessageID, strCategoryID)
	End If
	
	dsMessage.Dispose()
	cmdMessage.Dispose()
	cnMessage.Dispose()
	
End If

Response.Redirect("Forum_Message_List.aspx?categoryid=" & strCategoryID)
%>
