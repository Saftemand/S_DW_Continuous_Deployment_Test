<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim sql As String
Dim MediaDBMediaGroupID As String

If Not IsNothing(Request.QueryString("ID")) Then

	Dim MediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

	SQL = "SELECT * FROM [MediaDBMedia] WHERE MediaDBMediaID=" & request.QueryString("ID")

	Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
	Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter)
	Dim dsMedia As DataSet = New DataSet
	Dim newRow As DataRow

	cmdMedia.CommandText = sql
	adMediaAdapter.SelectCommand = cmdMedia
	adMediaAdapter.Fill(dsMedia)

	newRow = dsMedia.Tables(0).Rows(0)
	newRow("MediaDBMediaActive") = CBool(request.QueryString("active"))
	MediaDBMediaGroupID = dsMedia.Tables(0).Rows(0).Item("MediaDBMediaGroupID")

	adMediaAdapter.Update(dsMedia)

	MediaConn.Dispose

End If

response.Redirect("Media_List.aspx?ID=" & MediaDBMediaGroupID)
%>
