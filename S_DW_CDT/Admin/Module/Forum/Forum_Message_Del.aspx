<%@ Page CodeBehind="Forum_Message_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Message_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%
Dim strMessageID As String
Dim strCategoryID As String

strMessageID = Request.QueryString.Item("messageid")
strCategoryID = Request.QueryString.Item("categoryid")


If strMessageID <> "" Then
	DeleteMessages(strMessageID, True)
End If

Response.Redirect("forum_message_list.aspx?categoryid=" & strCategoryID)
%>
