<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
    Dim NoFields As Integer
Dim MediaArray() As String
Dim MediaDBMediaGroupID As String
Dim SQL As String
Dim sqlWhere As String
Dim FieldCount As Integer

If Not IsNothing(Request.QueryString("MediaDBMediaGroupID")) And Not IsNothing(Request.QueryString("MediaID")) Then
        MediaArray = Split(Request.QueryString("MediaID"), ",")

	MediaDBMediaGroupID = Replace(Request.QueryString("MediaDBMediaGroupID"), "@", "")

	sqlWhere = "WHERE (MediaDBMediaID = " & MediaArray(0)
	If UBound(MediaArray) > 0 Then
            For i As Integer = 1 To UBound(MediaArray)
                sqlWhere = sqlWhere & " OR MediaDBMediaID = " & MediaArray(i)
            Next
	End If
	sqlWhere = sqlWhere & ")"
	
	Dim connMedia As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = connMedia.CreateCommand

	'*** Move the medias to selected group ***
	If Request.QueryString("Action") = "move" Then

		SQL = "SELECT * FROM MediaDBMedia " & sqlWhere

		Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
		Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter)
		Dim dsMedia As DataSet = New DataSet
		Dim Row As DataRow

		cmdMedia.CommandText = SQL
		adMediaAdapter.SelectCommand = cmdMedia
		adMediaAdapter.Fill(dsMedia)

		For Each Row In dsMedia.Tables(0).Rows
			Row("MediaDBMediaGroupID") = MediaDBMediaGroupID
		Next

		adMediaAdapter.Update(dsMedia)

	End If


	'*** Copy the medias to selected group ***
	If Request.QueryString("Action") = "copy" Then

		Dim connMediaAdapter As IDbConnection = Database.CreateConnection("DWMedia.mdb")
		Dim cmdMediaAdapter As IDbCommand = connMediaAdapter.CreateCommand

		Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
		Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter)
		Dim dsMedia As DataSet = New DataSet
		Dim newRow As DataRow

		SQL = "SELECT * FROM MediaDBMedia " & sqlWhere
		cmdMedia.CommandText = SQL
		Dim drMediaReader As IDataReader = cmdMedia.ExecuteReader

		SQL = "SELECT * FROM MediaDBMedia"
		cmdMediaAdapter.CommandText = SQL
		adMediaAdapter.SelectCommand = cmdMediaAdapter
		adMediaAdapter.Fill(dsMedia)

        FieldCount = drMediaReader.FieldCount - 1

		Do While drMediaReader.Read
			newRow = dsMedia.Tables(0).NewRow()
			dsMedia.Tables(0).Rows.Add(newRow)

                For i As Integer = 1 To FieldCount
                    newRow(drMediaReader.GetName(i).ToString) = drMediaReader(i)
                Next
			newRow("MediaDBMediaGroupID") = MediaDBMediaGroupID
			newRow("MediaDBMediaOriginalID") = drMediaReader("MediaDBMediaID")
		Loop

		adMediaAdapter.Update(dsMedia)
		drMediaReader.Dispose
		connMediaAdapter.Dispose

	End If

	connMedia.Dispose

End If

Response.Redirect("Media_List.aspx?ID=" & MediaDBMediaGroupID)
%>

