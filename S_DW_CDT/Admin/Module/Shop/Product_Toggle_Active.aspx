<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim sql As String
Dim ShopProductGroupID As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			07-02-2002
'	Last modfied:		07-02-2002
'
'	Purpose: List paragraphs
'
'	Revision history:
'		1.0 - 07-02-2002 - Nicolai Pedersen
'		First version.
'**************************************************************************************************
If Not IsNothing(Request.QueryString("ID")) Then
	Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim cmdShop As IDbCommand = ShopConn.CreateCommand

	SQL = "SELECT * FROM [ShopProduct] WHERE ShopProductID=" & request.QueryString("ID")

	Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
	Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
	Dim dsShop As DataSet = New DataSet
	Dim newRow As DataRow

	cmdShop.CommandText = sql
	adShopAdapter.SelectCommand = cmdShop
	adShopAdapter.Fill(dsShop)

	newRow = dsShop.Tables(0).Rows(0)
	newRow("ShopProductActive") = CInt(request.QueryString("active"))
	ShopProductGroupID = dsShop.Tables(0).Rows(0).Item("ShopProductGroupID")

	adShopAdapter.Update(dsShop)

	ShopConn.Dispose

End If

response.Redirect("Product_List.aspx?ID=" & ShopProductGroupID)
response.end
%>
