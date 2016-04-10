<%@ Page CodeBehind="Form_Module_Option_SetActive.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Option_SetActive" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim strSetActive As String
Dim strFormOptionsID As String
Dim strFormFieldID As String

strFormOptionsID	= request.QueryString.Item("FormOptionsID")
strFormFieldID		= request.QueryString.Item("FormFieldID")
strSetActive		= request.QueryString.Item("SetActive")

If strFormFieldID <> "" And Not isNothing(strFormFieldID) Then
	Dim cn	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmd	As IDbCommand		= cn.CreateCommand()
	
	If strSetActive.ToLower() = "true" Then
		cmd.CommandText = "UPDATE [FormOptions] SET [FormOptionsActive]=" & Database.SqlBool(1) & " WHERE [FormOptionsID]=" & strFormOptionsID
		cmd.ExecuteNonQuery()
	Else
		cmd.CommandText = "UPDATE [FormOptions] SET [FormOptionsActive]=" & Database.SqlBool(0) & " WHERE [FormOptionsID]=" & strFormOptionsID
		cmd.ExecuteNonQuery()
	End If

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

