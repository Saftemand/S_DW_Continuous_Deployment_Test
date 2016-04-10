<%@ Page CodeBehind="poll_questions_del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_questions_del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			29-07-2002
'	Last modfied:		02-06-2004
'
'	Purpose: Del categories of poll
'
'	Revision history:
'		1.0.0 - 29-07-2002
'		First version.
'
'		1.1.0 - 02-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************

Dim intItemID As Integer
Dim intCategoryID As Integer
intItemID = Request.QueryString.Item("itemid")
intCategoryID = Request.QueryString.Item("categoryid")

    If IsNumeric(intItemID) And intItemID <> 0 Then
        Database.ExecuteNonQuery("DELETE FROM PollAnswer WHERE PollAnswerItemID = " & intItemID, "Poll.mdb")
        Database.ExecuteNonQuery("DELETE FROM PollItem WHERE PollItemID = " & intItemID, "Poll.mdb")
    End If

Response.Redirect("poll_questions_list.aspx?categoryid=" & intCategoryID)
%>
