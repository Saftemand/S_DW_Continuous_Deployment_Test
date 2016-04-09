<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim sql As String
Dim mediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As IDbCommand = mediaConn.CreateCommand

SQL = "SELECT * FROM MediaDBFiletypes WHERE MediaDBFiletypesID = " & Base.ChkNumber(Request.Form("MediaDBFiletypesID"))
Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter)
Dim dsMedia As DataSet = New DataSet
Dim newRow As DataRow

cmdMedia.CommandText = SQL
adMediaAdapter.SelectCommand = cmdMedia
adMediaAdapter.Fill(dsMedia)

If Len(Request.Form("MediaDBFiletypesID")) > 0 Then
    newRow = dsMedia.Tables(0).Rows(0)
Else
    newRow = dsMedia.Tables(0).NewRow()
    dsMedia.Tables(0).Rows.Add(newRow)
End If

newRow("MediaDBFiletypesName") = Base.ChkValue(Request.Form("MediaDBFiletypesName"))
newRow("MediaDBFiletypesExtensions") = Base.ChkValue(Request.Form("MediaDBFiletypesExtensions"))

adMediaAdapter.Update(dsMedia)

dsMedia.Dispose
mediaConn.Dispose

Response.Redirect(("Media_Types_List.aspx"))
%>
