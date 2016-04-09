<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim MoveID As String
Dim sql As String
Dim ID As String
Dim intSortMax As String

ID = request.QueryString("ID") 'Parent ID to copy to
MoveID = request.QueryString("MoveID") 'ID to copy

Dim mediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As IDbCommand = mediaConn.CreateCommand

'****** Find sort value ******

SQL = "SELECT MAX(MediaDBGroupSort) AS MediaMax FROM MediaDBGroup WHERE MediaDBGroupParentID = " & ID
cmdMedia.CommandText = SQL

Dim SortMaxReader As IDataReader = cmdMedia.ExecuteReader
If SortMaxReader.Read Then
	intSortMax = Base.ChkNumber(SortMaxReader("MediaMax"))
End If

SortMaxReader.Dispose

sql = "UPDATE MediaDBGroup SET MediaDBGroupParentID = " & ID & ", MediaDBGroupSort = " & Base.ChkNumber(intSortMax) + 1 & " WHERE  MediaDBGroupID = " & MoveID

cmdMedia.CommandText = SQL
cmdMedia.ExecuteNonQuery()

cmdMedia.Dispose
mediaConn.Dispose
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
window.opener.document.location.reload();
window.close();
//-->
</SCRIPT>

