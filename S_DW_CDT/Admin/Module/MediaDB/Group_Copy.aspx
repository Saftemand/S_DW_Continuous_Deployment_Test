<%@ Page %>
<%@ Import namespace="ADODB" %>
<%
Dim SortVal As Object
Dim CopyIterator As Byte
Dim CopyConn As Object
Dim Conn As Object
Dim PageIDsArray As String
Dim CopyTime As Object
Dim GetConn() As Object
Dim DWnow() As Object
Dim CopyID As String
Dim SQL As String
Dim ID As String
Dim AreaID As String
Dim rsSort As ADODB.Recordset



%>
<!-- #INCLUDE FILE="../../Common.asp" -->


<!-- #INCLUDE FILE="Copy_functions.aspx" -->
<%
ID = request.QueryString.Item("ID") 'Parent page to copy to
CopyID = request.QueryString.Item("CopyID") 'Page to copy
AreaID = request.QueryString.Item("AreaID") 'Area to copy to

'****** Find sort value ******
Conn = GetConn(CInt("Dynamic.mdb"))
rsSort = New ADODB.Recordset
SQL = "SELECT TOP 1 PageSort FROM Page WHERE PageParentPageID=" & ID & " ORDER BY Page.PageSort DESC"
rsSort.Open(SQL, Conn, 3, 3)
If Not rsSort.eof Then
	SortVal = CInt(rsSort.Fields("PageSort").Value) + 1
End If
rsSort.close()
'UPGRADE_NOTE: Object rsSort may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
rsSort = Nothing
If SortVal = "" Then
	SortVal = 1
End If
'**********************************
'CopyPage(FromPageID, ToLanguage, MotherPage, CopyParagraphs, CopySubPages)
CopyConn = GetConn(CInt("Dynamic.mdb"))
Call CopyPage(CopyID, AreaID, ID, True, True)
'UPGRADE_NOTE: Object CopyConn may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
CopyConn = Nothing

%>
<%'UPGRADE_NOTE: Language element '#INCLUDE' was migrated to the same language element but still may have a different behavior. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1011.htm  %>
<%'UPGRADE_NOTE: The file 'Menu_Restart.asp' was not found in the migration directory. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1003.htm  %>
<!-- #INCLUDE FILE="Menu_Restart.asp" -->

<script language="JavaScript">
	window.close();
	top.opener.parent.left.location = "menu.aspx?ID=<%=ID%>&AreaID=<%=AreaID%>";
</script>
