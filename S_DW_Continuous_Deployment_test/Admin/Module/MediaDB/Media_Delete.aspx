<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim getOrientationArray As Object
Dim Path As String
Dim File As Object
Dim extList As String
Dim ThumbFolder As Object
Dim Root As String
Dim SQL As String
Dim ThumbNail As String

Base.MediaSettings(Path, extList)

If Not IsNothing(Request.QueryString("ID")) Then

	Dim connMedia As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = connMedia.CreateCommand

	SQL = "SELECT * FROM MediaDBMedia WHERE MediaDBMediaID = " & Request.QueryString("ID")

    cmdMedia.CommandText = SQL

    Dim drDBMediaReader As IDataReader = cmdMedia.ExecuteReader

	If drDBMediaReader.Read Then
		'*** Dont delete shortcuts...! ***
		If drDBMediaReader("MediaDBMediaFileName") <> "" And (Base.ChkString(drDBMediaReader("MediaDBMediaOriginalID")) = "" Or IsDbNull(drDBMediaReader("MediaDBMediaOriginalID"))) Then
			If System.IO.File.Exists(Path & "\Originals\" & drDBMediaReader("MediaDBMediaFileName")) Then
				System.IO.File.Delete((Path & "\Originals\" & drDBMediaReader("MediaDBMediaFileName")))
			End If

			Dim SubFolders() As String = System.IO.Directory.GetDirectories(Path & "\Thumbs\")
	        Dim FolderInfo As System.IO.DirectoryInfo
			Dim Folder As String
			For Each Folder In SubFolders
				FolderInfo = New System.IO.DirectoryInfo(Folder)  
				ThumbNail = Path & "\Thumbs\" & FolderInfo.Name & "\" & Replace(drDBMediaReader("MediaDBMediaFileName"), ".", "_") & ".jpg"
				If System.IO.File.Exists(ThumbNail) Then
					System.IO.File.Delete((ThumbNail))
				End If
			Next
		End If
	End If

	drDBMediaReader.Dispose
	
	SQL = "DELETE FROM MediaDBMedia WHERE MediaDBMediaID = " & Request.QueryString("ID")
	
	cmdMedia.CommandText = SQL
	cmdMedia.ExecuteNonQuery()

	connMedia.Dispose

End If
Response.Redirect(("Media_List.aspx?ID=" & Request.QueryString("MediaDBMediaGroupID")))
%>
