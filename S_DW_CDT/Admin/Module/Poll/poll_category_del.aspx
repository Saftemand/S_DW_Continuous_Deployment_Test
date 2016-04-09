<%@ Page CodeBehind="poll_category_del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_category_del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

'**************************************************************************************************
'	Current version:	1.1.0
'	Created:			29-07-2002
'	Last modfied:		1.1.0 - 02-06-2004
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
Dim intCategoryID As Integer
intCategoryID = Request.QueryString.Item("categoryid")

If IsNumeric(intCategoryID) And intCategoryID <> 0 Then
        Database.ExecuteNonQuery(String.Format("DELETE FROM PollAnswer WHERE PollAnswerItemID IN (SELECT PollItemID FROM PollItem WHERE PollItemCategoryID = {0})", intCategoryID), "Poll.mdb")
        Database.ExecuteNonQuery("DELETE FROM PollItem WHERE PollItemCategoryID = " & intCategoryID, "Poll.mdb")
        Database.ExecuteNonQuery("DELETE FROM PollCategory WHERE PollCategoryID = " & intCategoryID, "Poll.mdb")
End If

Response.Redirect("poll_category_list.aspx")
%>
