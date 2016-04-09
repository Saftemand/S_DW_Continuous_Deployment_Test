<%@ Page CodeBehind="NewsletterExtended_Letter_Save.aspx.vb" Language="vb" AutoEventWireup="false" ValidateRequest="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
	parent.document.getElementById('ContentCell').setAttribute("src", "NewsletterExtended_Treeview.aspx?OpenWhat=Letters");
<%
	If	Request.QueryString("SendMail") = "true" Then
		Response.Write("	document.location='NewsletterExtended_Letter_Body_Send.aspx?ID=" & NewsletterID & "&Tab=Tab1';" & vbNewLine)
	Elseif Request.QueryString("PreviewMail") = "true" Then
		Response.Write("	document.location='NewsletterExtended_Letter_Body_Preview.aspx?ID=" & NewsletterID & "&Tab=Tab1';" & vbNewLine)
	Elseif Request.QueryString("SaveAttachment") = "true" Then
		Response.Write("	document.location='NewsletterExtended_attachment_save.aspx?NewsletterID=" & NewsletterID & "&NewsletterMailAttach=" & CStr(Request.Item("NewsletterMailAttach")) & "&Tab=Tab3';" & vbNewLine)
	Elseif Request.QueryString("DeleteAttachment") = "true" Then
		Response.Write("	document.location='NewsletterExtended_attachment_del.aspx?NewsletterID=" & NewsletterID & "&ID=" & CStr(Request.Item("ID")) & "&Tab=Tab3';" & vbNewLine)
	Else
		Response.Write("	document.location='NewsletterExtended_letter_body.aspx?ID=" & NewsletterID & "&Tab=" & Base.IIf(request.Item("Tab") <> "", request.Item("Tab"), "Tab1") & "';" & vbNewLine)
	End If
	
%>	
//-->
</SCRIPT>