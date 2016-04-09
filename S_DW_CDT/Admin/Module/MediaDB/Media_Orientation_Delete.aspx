<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim extList As String
Dim Root As String
Dim File As Object
Dim Path As String
Dim sql As String

If Len(Request.QueryString("ID")) > 0 Then
	Dim mediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = mediaConn.CreateCommand

	sql = "DELETE FROM MediaDBOrientation WHERE MediaDBOrientationID = " & Request.QueryString("ID")

	cmdMedia.CommandText = SQL
	cmdMedia.ExecuteNonQuery()

	cmdMedia.Dispose
	mediaConn.Dispose
End If

Response.Redirect(("Media_Orientation_List.aspx"))
%>
