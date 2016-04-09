<%@ Page CodeBehind="Form_Module_Option_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Option_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%

Dim strFormOptionsID As String
Dim strFormFieldID As String

strFormOptionsID	= request.QueryString.Item("FormOptionsID")
strFormFieldID		= request.QueryString.Item("FormFieldID")

If strFormFieldID <> "" And Not isNothing(strFormFieldID) Then
	Dim cn	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmd	As IDbCommand		= cn.CreateCommand()
	
	cmd.CommandText = "Delete from FormOptions where FormOptionsID = " & strFormOptionsID
	cmd.ExecuteNonQuery()

	'Cleanup
	cn.Close()
	cmd.Dispose()
	cn.Dispose()
	
End if

If IsNothing(request.QueryString.GetValues("Redirect")) Then
	response.Redirect("Form_Module_Field_Edit.aspx?FormFieldID=" & strFormFieldID)
Else
	response.Redirect("Form_Module_Option_Edit.aspx?FormFieldID=" & strFormFieldID & "&Redirect=Option")
End If
%>

