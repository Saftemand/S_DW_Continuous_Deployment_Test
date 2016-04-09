<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim SQL As String

Function UpdateTable(ByVal ShopProductFieldSystemName As String, ByVal ID As String) As Object
	Dim UpdateSQL As String
	Dim DeleteSQL As String
	On Error Resume Next
	
	Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

	UpdateSQL = "ALTER TABLE [ShopProduct] DROP COLUMN ShopProductCustom_" & ShopProductFieldSystemName & " "
	sCmdShop.CommandText = UpdateSQL
	sCmdShop.ExecuteNonQuery()

	DeleteSQL = "DELETE FROM [ShopProductField] WHERE ShopProductFieldID = " & ID
	sCmdShop.CommandText = DeleteSQL
	sCmdShop.ExecuteNonQuery()

	sCmdShop.Dispose
	ShopConn.Dispose
End Function
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: Delete field
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

If Not IsNothing(Request.QueryString("ID")) Then
	Dim ShopConn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

	SQL = "SELECT * FROM ShopProductField WHERE ShopProductFieldID = " & Request.QueryString("ID")
	sCmdShop.CommandText = sql

	Dim drProductFieldReader As IDataReader = sCmdShop.ExecuteReader()

	If drProductFieldReader.Read Then
		UpdateTable(drProductFieldReader("ShopProductFieldSystemName"), Request.QueryString("ID"))
	End If

	drProductFieldReader.Dispose
	sCmdShop.Dispose

End If
Response.Redirect(("Product_Field_List.aspx"))
%>
