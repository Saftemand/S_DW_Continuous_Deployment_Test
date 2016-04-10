<%@ Page CodeBehind="Form_Module_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>


<%
Dim FormID As String

FormID = Request.QueryString.Item("FormID")

    If FormID <> "" And Not IsNothing(FormID) Then
        Database.ExecuteNonQuery("DELETE FROM FormOptions WHERE FormOptionsFormFieldID IN (SELECT FormFieldID FROM FormField WHERE FormFieldFormID =  " & FormID & ")")
        Database.ExecuteNonQuery("DELETE FROM FormField WHERE FormFieldFormID = " & FormID)
        Database.ExecuteNonQuery("DELETE FROM Form WHERE FormID = " & FormID)
    End If

response.Redirect("Form_Module_List.aspx")
%>
