<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%
Dim MoveDirection As String
Dim OldSort As Double
Dim sql As String
Dim MediaDBMediaGroupID As String
Dim i As Byte
Dim MediaDBMediaID As String
Dim mediaConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdMedia As IDbCommand = mediaConn.CreateCommand

MediaDBMediaID = request.QueryString("MediaDBMediaID")
MoveDirection = request.QueryString("MoveDirection")
MediaDBMediaGroupID = request.QueryString("MediaDBMediaGroupID")

sql = "SELECT * FROM MediaDBMedia WHERE MediaDBMediaGroupID = " & MediaDBMediaGroupID & " ORDER BY MediaDBMediaSort"

Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
Dim dsMedia As DataSet = New DataSet

cmdMedia.CommandText = SQL
adShopAdapter.SelectCommand = cmdMedia
adShopAdapter.Fill(dsMedia)

Base.SortListByDataSet(dsMedia, "MediaDBMediaID", "MediaDBMediaSort", MoveDirection, MediaDBMediaID)

adMediaAdapter.Update(dsShop)

cmdMedia.Dispose
mediaConn.Dispose

response.Redirect("Media_List.aspx?ID=" & MediaDBMediaGroupID)
%>
