<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim SQL As String
Dim ID As String
Dim MoveID As String
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
MoveID = request.QueryString("MoveID") 'Page to copy

'****** Find sort value ******
Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand

SQL = "SELECT MAX(ShopProductSort) AS SortMax FROM ShopProduct WHERE ShopProductGroupID = " & ID
cmdShop.CommandText = sql

Dim ShopReader As IDataReader = cmdShop.ExecuteReader()
If ShopReader.Read Then
	intSortMax = Base.ChkNumber(ShopReader("SortMax")) + 1
End If
ShopReader.Dispose


SQL = "UPDATE ShopProduct Set ShopProductGroupID = " & ID & ", ShopProductSort = " & intSortMax & " WHERE ShopProductID = " & MoveID
cmdShop.CommandText = SQL
cmdShop.ExecuteNonQuery()

ShopConn.Dispose
%>
<script language="JavaScript">
	window.opener.parent.location = "menu.aspx?ID=<%=ID%>";
	window.close();
</script>

