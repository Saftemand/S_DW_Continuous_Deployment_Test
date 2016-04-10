<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%
Dim sql As String
Dim ThumbFolder As String
Dim Path As String

If Len(Request.QueryString("ID")) > 0 Then
	Dim mediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = mediaConn.CreateCommand

	sql = "DELETE FROM MediaDBThumbnails WHERE MediaDBThumbnailsID = " & Request.QueryString("ID")

	cmdMedia.CommandText = SQL
	cmdMedia.ExecuteNonQuery()

	mediaConn.Dispose
End If

ThumbFolder = Path & "\Thumbs\" & Request.QueryString("ID")
If System.IO.Directory.Exists(ThumbFolder) Then
	System.IO.Directory.Delete(ThumbFolder)
End If

Response.Redirect("Files_Thumbnails_List.aspx")
%>
