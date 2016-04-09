<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim sql As String
Dim mediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As IDbCommand = mediaConn.CreateCommand

sql = "SELECT * FROM MediaDBThumbnails WHERE MediaDBThumbnailsID = " & Base.ChkNumber(Request.Form("MediaDBThumbnailsID"))
Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter)
Dim dsMedia As DataSet = New DataSet
Dim newRow As DataRow

cmdMedia.CommandText = SQL
adMediaAdapter.SelectCommand = cmdMedia
adMediaAdapter.Fill(dsMedia)

If Len(Request.Form("MediaDBThumbnailsID")) > 0 Then
    newRow = dsMedia.Tables(0).Rows(0)
Else
    newRow = dsMedia.Tables(0).NewRow()
    dsMedia.Tables(0).Rows.Add(newRow)
End If

newRow("MediaDBThumbnailsName") = Base.ChkValue(Request.Form("MediaDBThumbnailsName"))
newRow("MediaDBThumbnailsTemplateName") = Base.ChkValue(Request.Form("MediaDBThumbnailsTemplateName"))
newRow("MediaDBThumbnailsMaxwidth") = Base.ChkValue(Request.Form("MediaDBThumbnailsMaxwidth"))
newRow("MediaDBThumbnailsMaxheight") = Base.ChkValue(Request.Form("MediaDBThumbnailsMaxheight"))
newRow("MediaDBThumbnailsResizePatern") = Base.ChkValue(Request.Form("MediaDBThumbnailsResizePatern"))
newRow("MediaDBThumbnailsQuality") = Base.ChkValue(Request.Form("MediaDBThumbnailsQuality"))
newRow("MediaDBThumbnailsActive") = CInt(Request.Form("MediaDBThumbnailsActive"))

adMediaAdapter.Update(dsMedia)

dsMedia.Dispose
mediaConn.Dispose

Response.Redirect(("Files_Thumbnails_List.aspx"))
%>
