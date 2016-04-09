<%@ Page AutoEventWireup="false" Codebehind="File_ImportExe.aspx.vb" Inherits="Dynamicweb.Admin.File_ImportExe" Language="vb" ValidateRequest="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.drawing" %>
<%@ Import namespace="System.drawing.imaging" %>
<%@ Import namespace="System.drawing.drawing2d" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="WebSupergoo.ImageGlue6" %>

<%
Dim arrMediaDBMediaFileName() As String
Dim varInboxFolder As String
Dim ThumbPath As String
Dim ColorSpace As String
Dim MediaDBMediaBlackWhite As String
Dim ThumbHeight As Integer
Dim ThumbWidth As Integer
Dim Width As Integer
Dim Height As Integer
Dim OriginalPath As String
Dim MediaDBMediaActiveFrom As Object
Dim DumpTime As String
Dim MediaDBMediaActiveTo As Object
Dim MediaDBMediaCopyright As String
Dim Params As String
Dim Path As String
Dim SQL As String
Dim i As Integer
Dim Root As String
Dim ThumbRatio As Double
Dim File As Object
Dim Depth As String
Dim Resolution As Integer
Dim extList As String
Dim MediaDBMediaGroupID As String
Dim iName As Object
Dim Factor As Double
Dim SavePath As String
Dim MediaDBMediaKeywords As String
Dim j As Integer
Dim getOrientationArray As Object
Dim FileNameOnly As String
Dim Ratio As Double
Dim MediaDBMediaActive As String
Dim Extension As String
Dim inboxpath As String
Dim ThumbSettings As Object
Dim FileName As String
Dim alThumbSettings As ArrayList = New ArrayList
Dim getThumbSettingID As String
Dim getThumbSettingMaxwidth As String
Dim getThumbSettingMaxheight As String
Dim getThumbSettingPatern As String
Dim getThumbSettingQuality As String
Dim FullFileFrom As String
Dim FullFileTo As String

Server.ScriptTimeOut = 7200 '2 hours 

Base.MediaSettings(Path, extList)

MediaDBMediaKeywords = Request.Form("MediaDBMediaKeywords")
MediaDBMediaCopyright = Request.Form("MediaDBMediaCopyright")
MediaDBMediaGroupID = Request.Form("MediaDBMediaGroupID")
MediaDBMediaBlackWhite = Request.Form("MediaDBMediaBlackWhite")
MediaDBMediaActive = Request.Form("MediaDBMediaActive")
MediaDBMediaCopyright = Request.Form("MediaDBMediaCopyright")
varInboxFolder = Request.Form("InboxFolder")
MediaDBMediaActiveFrom = Dates.ParseDate("MediaDBMediaActiveFrom")
MediaDBMediaActiveTo = Dates.ParseDate("MediaDBMediaActiveTo")

arrMediaDBMediaFileName = Split(Request.Form("MediaDBMediaFileName"), ",")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</head>
<%=Gui.MakeHeaders("<br>" & Translate.Translate("Importer"), Translate.Translate("Status"), "All")%>
<%Response.Flush()%>
<div ID="Tab1" STYLE="display:;" class=tabTable>
<br>
	<%
If IsArray(arrMediaDBMediaFileName) Then
	Value = 0
	MaxValue = UBound(arrMediaDBMediaFileName) + 1
	Name = "Statusbar"%>
	<%=StatusRender%>
<%
End If
%>
	<b><%=Translate.Translate("Importerer:")%></b>
	<div id="StatusText"></div>
	<%

	    Response.Flush()
	    ThumbPath = Path & "\Thumbs"
	    OriginalPath = Path & "\Originals"
	    '************** Get settings for thumbnails *************
	    Dim connMedia As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	    Dim cmdMedia As IDbCommand = connMedia.CreateCommand

	    SQL = "SELECT MediaDBThumbnailsID, MediaDBThumbnailsMaxwidth, MediaDBThumbnailsMaxheight, MediaDBThumbnailsResizePatern, MediaDBThumbnailsQuality "
	    SQL = SQL & "FROM MediaDBThumbnails "
	    SQL = SQL & "ORDER BY (MediaDBThumbnails.MediaDBThumbnailsMaxwidth*MediaDBThumbnails.MediaDBThumbnailsMaxheight) DESC"

	    cmdMedia.CommandText = SQL

	    Dim drThumbnailsReader As IDataReader = cmdMedia.ExecuteReader

	    Do While drThumbnailsReader.Read
	        Dim objValues(drThumbnailsReader.FieldCount) As Object
	        drThumbnailsReader.GetValues(objValues)
	        alThumbSettings.Add(objValues)
	    Loop

	    For Each Row As Object() In alThumbSettings
	        If Not System.IO.Directory.Exists(Path & "\Thumbs\" & Row(i)) Then
	            System.IO.Directory.CreateDirectory(Path & "\Thumbs\" & Row(i))
	        End If
	    Next

	    drThumbnailsReader.Dispose()


	    '************** End get settings ***************

	    SQL = "SELECT * FROM MediaDBMedia"
	    Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
	    Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter)
	    Dim dsMedia As DataSet = New DataSet
	    Dim newRow As DataRow

	    cmdMedia.CommandText = SQL
	    adMediaAdapter.SelectCommand = cmdMedia
	    adMediaAdapter.Fill(dsMedia)
	    
	    Dim gs As New Gestalt
	    Try
	        gs.License = "357-567-964-488-9635-441"
	    Catch ex As Exception
	    End Try
	    
	    For i = 0 To UBound(arrMediaDBMediaFileName)
    	
	        inboxpath = Replace(Path, "\" & Dynamicweb.Content.Management.Installation.ImagesFolderName & "\MediaDB", "") & Replace(varInboxFolder, "/", "\") & "\" & arrMediaDBMediaFileName(i)
    	
	        Response.Write("<script>document.getElementById('StatusText').innerHTML = '" & Base.JSEnable(arrMediaDBMediaFileName(i)) & "';</script>")
	        Response.Flush()
	        Extension = Base.getFileextension(arrMediaDBMediaFileName(i))
	        FileNameOnly = Left(arrMediaDBMediaFileName(i), Len(arrMediaDBMediaFileName(i)) - (Len(Extension) + 1))

	        iName = 1

	        If System.IO.File.Exists(Path & "\InboxThumbs\" & arrMediaDBMediaFileName(i) & ".jpg") Then
	            'w "findes"
	            System.IO.File.Delete(Path & "\InboxThumbs\" & arrMediaDBMediaFileName(i) & ".jpg")
	        End If
    	
	        Do While System.IO.File.Exists(Path & "\Originals\" & arrMediaDBMediaFileName(i))
	            arrMediaDBMediaFileName(i) = FileNameOnly & iName & "." & Extension
	            iName = iName + 1
	        Loop
    	
	        If Base.IsImage(Extension) Then 'And Not Extension.ToLower() = "pdf" Then 'Caused a problem with PDF
	            '***** Loading original image *****
	            
	            Dim canvas As New Canvas()
	            Dim image As New Graphic()
	            Dim rect As New XRect()

	            image.SetFile(inboxpath)
	            rect.String = image(0).Rectangle

	            Width = image(0).Width
	            Height = image(0).Height
	            Depth = image(0).Depth
	            If Depth <> "" Then
	                Depth = Depth
	            End If
	            Resolution = image(0).Resolution
	            ColorSpace = image(0).ColorSpace
	            Ratio = Width / Height

	            '***** Create thumbnails *****
	            For Each Row As Object() In alThumbSettings
	                getThumbSettingID = Base.ChkString(Row(0))
	                getThumbSettingMaxwidth = Base.ChkString(Row(1))
	                getThumbSettingMaxheight = Base.ChkString(Row(2))
	                getThumbSettingPatern = Base.ChkString(Row(3))
	                getThumbSettingQuality = Base.ChkString(Row(4))

	                ThumbRatio = getThumbSettingMaxwidth / getThumbSettingMaxheight
	                '1) Max bredde og højde
	                '2) Samme bredde
	                '3) Samme højde
	                '4) Stræk
	                If getThumbSettingPatern = 1 Then
	                    If ThumbRatio > Ratio Then
	                        'Højde bestemmer beregning...
	                        Factor = Height / getThumbSettingMaxheight
	                    Else
	                        'Bredde bestemmer beregning...
	                        Factor = Width / getThumbSettingMaxwidth
	                    End If
	                    ThumbWidth = Width / Factor
	                    ThumbHeight = Height / Factor
	                ElseIf getThumbSettingPatern = 2 Then
	                    'Bredde bestemmer beregning...
	                    Factor = Width / getThumbSettingMaxwidth
	                    ThumbWidth = Width / Factor
	                    ThumbHeight = Height / Factor
	                ElseIf getThumbSettingPatern = 3 Then
	                    'Højde bestemmer beregning...
	                    Factor = Height / getThumbSettingMaxheight
	                    ThumbWidth = Width / Factor
	                    ThumbHeight = Height / Factor
	                ElseIf getThumbSettingPatern = 4 Then
	                    'Tvungen størrelse
	                    ThumbWidth = getThumbSettingMaxwidth
	                    ThumbHeight = getThumbSettingMaxheight
	                End If
	                ThumbWidth = System.Math.Round(ThumbWidth)
	                ThumbHeight = System.Math.Round(ThumbHeight)

	                If LCase(Extension) = "swf" Then
	                    'w Image(1).Time
	                    DumpTime = (image(1).Time / 10) * 2
	                    'w DumpTime
	                    Params = " Time=" & DumpTime
	                End If

	                If ThumbHeight = 0 Then
	                    ThumbHeight = 1
	                End If

	                canvas.Width = ThumbWidth
	                canvas.Height = ThumbHeight
    			
	                canvas.DrawFile(inboxpath, "size=" & canvas.Width & "," & canvas.Height & Params)

	                FileName = Replace(arrMediaDBMediaFileName(i), ".", "_")
	                SavePath = Path & "\Thumbs\" & getThumbSettingID & "\" & FileName & ".jpg"

	                canvas.SaveAs(SavePath, "Quality=" & getThumbSettingQuality)
	                canvas.Clear()
	            Next
	            canvas.Dispose()
	        End If

			'***** Copy og delete file from inbox folder ******
			Dim pathFrom As String = inboxpath.Replace(FileNameOnly & "." & Extension, "")
			Dim pathTo As String = Path & "\Originals\"
			
	        If Not IsNothing(Request.Form("ImportDeleteOriginal")) Then
	            If CBool(Base.ChkBoolean(Request.Form("ImportDeleteOriginal"))) Then
	                System.IO.File.Delete(inboxpath)
	            End If
			ElseIf pathFrom <> pathTo Then
				FullFileFrom = inboxpath
				FullFileTo = Path & "\Originals\" & arrMediaDBMediaFileName(i)

				Dim fiFrom As IO.File
				Dim fiTo As IO.File

				If fiFrom.Exists(FullFileFrom) And Not fiTo.Exists(FullFileTo) Then
					IO.File.Copy(FullFileFrom, FullFileTo)
				End If
	        End If

	        '***** Done moving or deleting file from inbox folder ******


	        '***** Save data to dataset ******
	        newRow = dsMedia.Tables(0).NewRow()
	        dsMedia.Tables(0).Rows.Add(newRow)
    	
	        newRow("MediaDBMediaName") = arrMediaDBMediaFileName(i)
	        newRow("MediaDBMediaGroupID") = Replace(Request.Form("MediaDBMediaGroupID"), "@", "")
	        newRow("MediaDBMediaCreatedDate") = Dates.DWNow()
	        newRow("MediaDBMediaUpdatedDate") = Dates.DWNow()
	        newRow("MediaDBMediaActive") = CInt(Request.Form("MediaDBMediaActive"))
	        newRow("MediaDBMediaBlackWhite") = CInt(Request.Form("MediaDBMediaBlackWhite"))
    	
	        If Dates.ParseDate("MediaDBMediaActiveFrom") <> "" Then
	            newRow("MediaDBMediaActiveFrom") = Dates.ParseDate("MediaDBMediaActiveFrom")
	        Else
	            newRow("MediaDBMediaActiveFrom") = Dates.DWNow()
	        End If

	        If Dates.ParseDate("MediaDBMediaActiveTo") <> "" Then
	            newRow("MediaDBMediaActiveTo") = Base.ChkValue(Dates.ParseDate("MediaDBMediaActiveTo"))
	        Else
	            newRow("MediaDBMediaActiveTo") = DBNull.Value
	        End If
	        newRow("MediaDBMediaDescription") = Base.ChkValueNoStrip(Request.Form("MediaDBMediaDescription"))
	        newRow("MediaDBMediaKeywords") = Left(Base.ChkValue(Request.Form("MediaDBMediaKeywords")), 255)
	        newRow("MediaDBMediaCopyright") = Left(Base.ChkValue(Request.Form("MediaDBMediaCopyright")), 255)
	        newRow("MediaDBMediaFileName") = arrMediaDBMediaFileName(i)
	        If Width <> 0 Then
	            newRow("MediaDBMediaWidth") = Width
	        End If
	        If Height <> 0 Then
	            newRow("MediaDBMediaHeigth") = Height
	        End If
	        newRow("MediaDBMediaColors") = Depth
	        newRow("MediaDBMediaResolution") = Resolution
	        newRow("MediaDBMediaColorSpace") = ColorSpace
	        newRow("MediaDBMediaType") = Extension
	        'newRow("MediaDBMediaOriginalID") = ""

	        '***** Done saving data to dataset ******
    	
	        'Response.flush
	        '***** Done creating thumbnails ******
	        'imgMyImage.Dispose
	%>
	<%'=Increase%>
<%	
Next 

adMediaAdapter.Update(dsMedia)

dsMedia.Dispose
connMedia.Dispose

Response.Write("<script>document.getElementById('StatusText').innerHTML = """ & Translate.JSTranslate("Import færdig") & """;</script>")
%>
	<script>
	setTimeout("location='Media_list.aspx?ID=<%=Replace(MediaDBMediaGroupID, "@", "")%>'", 1500);
	</script>
</div>
</body>
</html>
<%
	Translate.GetEditOnlineScript()
%>