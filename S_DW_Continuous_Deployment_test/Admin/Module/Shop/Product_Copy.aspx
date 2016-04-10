<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim Counter As Byte
Dim Conn As Object
Dim ID As String
Dim i As Integer
Dim CopyID As String
Dim SQL As String
Dim FieldCount As Integer
Dim intSortMax As Integer
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			24-02-2002
'	Last modfied:		24-02-2002
'
'	Purpose: Copies a page with subpages and paragraphs
'
'	Revision history:
'		1.0 - 24-02-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

ID = request.QueryString("ID") 'Parent page to copy to
CopyID = request.QueryString("CopyID") 'Page to copy

'****** Find sort value ******
Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand
Dim ShopAdapterConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShopAdapter As IDbCommand = ShopAdapterConn.CreateCommand

SQL = "SELECT MAX(ShopProductSort) AS SortMax FROM ShopProduct WHERE ShopProductGroupID = " & ID
cmdShop.CommandText = sql

Dim drShopReader As IDataReader = cmdShop.ExecuteReader()
If drShopReader.Read Then
	intSortMax = Base.ChkNumber(drShopReader("SortMax")) + 1
End If
drShopReader.Dispose



SQL = "SELECT * FROM ShopProduct WHERE ShopProductID = " & CopyID
cmdShop.CommandText = sql
Dim drProductReader As IDataReader = cmdShop.ExecuteReader()

If drProductReader.Read Then
	SQL = "SELECT * FROM ShopProduct"

	Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
	Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
	Dim dsShop As DataSet = New DataSet
	Dim newRow As DataRow

	cmdShopAdapter.CommandText = SQL
	adShopAdapter.SelectCommand = cmdShopAdapter
	adShopAdapter.Fill(dsShop)

	newRow = dsShop.Tables(0).NewRow()
	dsShop.Tables(0).Rows.Add(newRow)

	Counter = 0

    FieldCount = drProductReader.FieldCount - 1
    For i = 0 To FieldCount
		If Counter > 1 Then
			newRow(drProductReader.GetName(i)) = drProductReader(i)
		End If
		Counter = Counter + 1
    Next

	newRow("ShopProductGroupID") = ID
	newRow("ShopProductSort") = intSortMax

	adShopAdapter.Update(dsShop)

End If

drProductReader.Dispose

ShopConn.Dispose
ShopAdapterConn.Dispose

%>
<script language="JavaScript">
	window.opener.parent.location = "menu.aspx?ID=<%=CopyID%>";
	window.close();
</script>

