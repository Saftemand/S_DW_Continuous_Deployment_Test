<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim MediaDBGroupID As String
Dim SortVal As String
Dim sql As String

Dim mediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As IDbCommand = mediaConn.CreateCommand
Dim cmdMediaReader As IDbCommand = mediaConn.CreateCommand

MediaDBGroupID = request.Form("MediaDBGroupID")

sql = "SELECT * FROM MediaDBGroup WHERE MediaDBGroupID=" & MediaDBGroupID

Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter )
Dim dsMedia As DataSet = New DataSet
Dim newRow As DataRow

cmdMedia.CommandText = sql
adMediaAdapter.SelectCommand = cmdMedia
adMediaAdapter.Fill(dsMedia)

If Not CStr(MediaDBGroupID) = "0" Then
    newRow = dsMedia.Tables(0).Rows(0)
Else
	'SortVal hentes frem
	sql = "SELECT TOP 1 MediaDBGroupSort  FROM MediaDBGroup WHERE MediaDBGroup.MediaDBGroupParentID=" & request.Form.Item("MediaDBGroupParentID")
	sql = sql & " ORDER BY MediaDBGroupSort DESC "

	cmdMediaReader.CommandText = sql
	Dim drMediaGroupReader As IDataReader = cmdMediaReader.ExecuteReader()

	If drMediaGroupReader.Read Then
		SortVal = CInt(drMediaGroupReader("MediaDBGroupSort")) + 1
	End If

	drMediaGroupReader.Dispose
	cmdMediaReader.Dispose

	If SortVal = "" Then
		SortVal = 1
	End If
	
	'værdier add'es

    newRow = dsMedia.Tables(0).NewRow()
    dsMedia.Tables(0).Rows.Add(newRow)

	newRow("MediaDBGroupSort") = SortVal
	newRow("MediaDBGroupParentID") = request.Form("MediaDBGroupParentID")
	newRow("MediaDBGroupCreatedDate") = Dates.DWNow()
End If

newRow("MediaDBGroupName") = Base.ChkValue(request.Form("MediaDBGroupName"))
newRow("MediaDBGroupKeywords") = Left(Base.ChkValue(request.Form("MediaDBGroupKeywords")), 255)
newRow("MediaDBGroupDescription") = Left(Base.ChkValue(request.Form("MediaDBGroupDescription")), 255)
newRow("MediaDBGroupNumber") = Base.ChkValue(request.Form("MediaDBGroupNumber"))
newRow("MediaDBGroupActive") = CInt(request.Form("MediaDBGroupActive"))
If Dates.ParseDate("MediaDBGroupActiveFrom") <> "" Then
	newRow("MediaDBGroupActiveFrom") = Dates.ParseDate("MediaDBGroupActiveFrom")
End If
If Dates.ParseDate("MediaDBGroupActiveTo") <> "" Then
	newRow("MediaDBGroupActiveTo") = Dates.ParseDate("MediaDBGroupActiveTo")
End If
newRow("MediaDBGroupUpdatedDate") = Dates.DWNow()

adMediaAdapter.Update(dsMedia)

If CStr(MediaDBGroupID) = "0" Then
	MediaDBGroupID = CType(Database.GetAddedIdentityKey(dsMedia.Tables(0).Rows.Item(dsMedia.Tables(0).Rows.Count - 1), mediaConn, 0), String)
End If

dsMedia.Dispose
mediaConn.Dispose
%>
<script language="JavaScript">
	parent.location = "menu.aspx?ID=<%=MediaDBGroupID%>";
</script>

