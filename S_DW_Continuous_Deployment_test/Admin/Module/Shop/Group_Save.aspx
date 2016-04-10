<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim ShopGroupID As Object
Dim SortVal As String
Dim sql As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: Save group
'
'	Revision history:
'		1.0 - 01-08-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand
Dim cmdShopReader As IDbCommand = ShopConn.CreateCommand

ShopGroupID = Request.Form("ShopGroupID")

sql = "SELECT * FROM ShopGroup WHERE ShopGroupID=" & ShopGroupID

Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
Dim dsShop As DataSet = New DataSet
Dim newRow As DataRow

cmdShop.CommandText = sql
adShopAdapter.SelectCommand = cmdShop
adShopAdapter.Fill(dsShop)

If CStr(ShopGroupID) <> "0" Then
    newRow = dsShop.Tables(0).Rows(0)
Else
	'SortVal hentes frem
	sql = "SELECT TOP 1 ShopGroupSort FROM ShopGroup WHERE ShopGroup.ShopGroupParentID=" & Request.Form.Item("ShopGroupParentID")
	sql = sql & " ORDER BY ShopGroupSort DESC "

	cmdShopReader.CommandText = sql
	Dim drShopGroupReader As IDataReader = cmdShopReader.ExecuteReader()

	If drShopGroupReader.Read Then
		SortVal = CInt(drShopGroupReader("ShopGroupSort")) + 1
	End If

	drShopGroupReader.Dispose
	cmdShopReader.Dispose

	If SortVal = "" Then
		SortVal = 1
	End If
	
	'værdier add'es

    newRow = dsShop.Tables(0).NewRow()
    dsShop.Tables(0).Rows.Add(newRow)

	newRow("ShopGroupSort") = SortVal
	newRow("ShopGroupParentID") = Request.Form("ShopGroupParentID")
	newRow("ShopGroupCreatedDate") = Dates.DWNow()
End If

newRow("ShopGroupName") = Base.ChkString(Request.Form("ShopGroupName"))
newRow("ShopGroupNumber") = Base.ChkValue(Request.Form("ShopGroupNumber"))
newRow("ShopGroupActive") = CInt(Request.Form("ShopGroupActive"))
newRow("ShopGroupActiveFrom") = Dates.ParseDate("ShopGroupActiveFrom")
newRow("ShopGroupActiveTo") = Dates.ParseDate("ShopGroupActiveTo")
newRow("ShopGroupFieldGroupID") = Base.ChkValue(Request.Form("SelectFieldGroups"))
newRow("ShopGroupUpdatedDate") = Dates.DWNow()
newRow("ShopGroupCustomFieldsList") = Base.ChkValue(Request.Form("ShopCustomFieldsList"))
newRow("ShopGroupCustomFieldsListElement") = Base.ChkValue(Request.Form("ShopCustomFieldsListElement"))
newRow("ShopGroupProductTemplate") = Base.ChkValue(Request.Form("ShopGroupProductTemplate"))
newRow("ShopGroupRead") = 0

newRow("ShopGroupDocTemplateID") = Base.ChkNumber(CInt(Request.Form("ShopGroupDocTemplateID")))

adShopAdapter.Update(dsShop)

dsShop.Dispose
cmdShop.Dispose
ShopConn.Dispose

%>

<script language="JavaScript">
	//location = "Product_List.aspx?ID=<%=ShopGroupID%>";
	//top.right.location = "Menu.aspx?ID=<%=ShopGroupID%>";
	parent.location = "menu.aspx?ID=<%=ShopGroupID%>";
</script>

