<%@ Page CodeBehind="Form_Module_Field_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Field_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%

Dim strFormID As String
Dim strFormFieldID As String

strFormFieldID	= request.QueryString.Item("FormFieldID")
strFormID		= request.QueryString.Item("FormID")

If strFormFieldID <> "" And Not isNothing(strFormFieldID) Then
	
        Database.ExecuteNonQuery("DELETE FROM FormOptions WHERE FormOptionsFormFieldID = " & strFormFieldID)
        Database.ExecuteNonQuery("DELETE FROM FormField WHERE FormFieldID = " & strFormFieldID)
	
End if

response.Redirect("Form_Module_Edit.aspx?FormID=" & strFormID & "&Tab=2")
%>

