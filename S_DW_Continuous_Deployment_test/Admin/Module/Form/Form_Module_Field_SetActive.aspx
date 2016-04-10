<%@ Page CodeBehind="Form_Module_Field_SetActive.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Field_SetActive" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%

Dim SetActive As String
Dim FormID As String
Dim FormFieldID As String

FormID = request.QueryString.Item("FormID")
FormFieldID = request.QueryString.Item("FormFieldID")
SetActive = request.QueryString.Item("SetActive")

Dim cn	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmd As IDbCommand		= cn.CreateCommand

If SetActive = "True" Then
	cmd.CommandText = "UPDATE [FormField] SET [FormFieldActive]= " & Database.SqlBool(1) & " WHERE [FormFieldID] = " & FormFieldID
	cmd.ExecuteNonQuery()
Else	
	cmd.CommandText = "UPDATE [FormField] SET [FormFieldActive]= " & Database.SqlBool(0) & " WHERE [FormFieldID] = " & FormFieldID
	cmd.ExecuteNonQuery()
End If

'Cleanup - Or active updates gets delayed
cmd.Dispose()
cn.Dispose()

response.Redirect("Form_Module_Edit.aspx?FormID=" & FormID & "&Tab=2")
%>

