<%@ Page CodeBehind="NewsletterExtended_StatRedirect.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_StatRedirect2" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

Dim StatType As String

StatType = Request.QueryString.Item("Type")

If StatType <> "" And Not IsNumeric(StatType) Then
	If IsNumeric(Mid(StatType, 1, 1)) Then
		StatType = Mid(StatType, 1, 1)
	Else
		StatType = "0"
	End If
End If

If StatType = "1" Then
	RunStat()
Else
	RunStat()
End If
%>
