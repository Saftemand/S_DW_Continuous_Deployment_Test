<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim strSQL As String
Dim FieldID As String
Dim MoveDirection As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			05-08-2003 
'
'	Purpose: Sort Elements
'
'	Revision history:
'		1.0 - 05-08-2003 - John Krogh
'		First version.
'**************************************************************************************************

Dim ShopConn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand

FieldID = Request.QueryString("FieldID")
MoveDirection = Request.QueryString("MoveDirection")

strSQL = "SELECT * FROM ShopProductField WHERE ShopProductFieldGroupID =" & Base.Request("GroupID") & " ORDER BY ShopProductFieldSort"

Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
Dim dsShop As DataSet = New DataSet

cmdShop.CommandText = strSQL
adShopAdapter.SelectCommand = cmdShop
adShopAdapter.Fill(dsShop)

base.w(dsShop.Tables(0).Rows.Count())

Database.SortListByDataSet(dsShop, "ShopProductFieldID", "ShopProductFieldSort", MoveDirection, FieldID)

adShopAdapter.Update(dsShop)

cmdShop.Dispose
ShopConn.Close
ShopConn.Dispose
dsShop.Dispose()

Response.Redirect("Product_Field_Group_Edit.aspx?GroupID=" & request("GroupID"))
%>
