<%@ Page CodeBehind="Forum_Category_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Category_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%
Dim strCategoryID As Object

    strCategoryID = Request.QueryString.Item("categoryid")
    If strCategoryID <> "" And Not strCategoryID = "0" Then
        Database.ExecuteNonQuery("DELETE FROM ForumMessage WHERE ForumMessageCategoryID = " & strCategoryID)
        Database.ExecuteNonQuery("DELETE FROM ForumCategory WHERE ForumCategoryID = " & strCategoryID)
    End If

Response.Redirect("forum_category_list.aspx")
%>
