<%

Function GetIcon(ByRef ext As String) As String
	Dim tmp As String
	tmp = "na"
	If InStr(CStr(extList), "." & LCase(ext) & ".") > 0 Then
		tmp = ext
		GetIcon = tmp
	End If
	If LCase(ext) = "tml" Then
		tmp = "html"
		GetIcon = tmp
	End If
	GetIcon = tmp
End Function

Function IsImage(ByRef ext As String) As Boolean
	Dim iIsImage As Integer
	Dim ImageExtensions() As String
	IsImage = False
	ImageExtensions = Split("BMP, PNG, TIFF, TIF, JPEG, JPG, JPE, JFIF, GIF, PSD, PICT, M_OV, A_VI, PNG, EPS, PDF", ", ")
	For iIsImage = 0 To UBound(ImageExtensions)
		If LCase(ImageExtensions(iIsImage)) = LCase(ext) Then
			IsImage = True
			Exit For
		End If
	Next 
End Function


Function getFileextension(ByRef FileName As String) As String
	If Len(FileName) > 3 Then
		getFileextension = Right(FileName, Len(FileName) - InStrRev(FileName, "."))
	Else
		getFileextension = ""
	End If
End Function

Function getOrientation(ByRef OrientationWidth As Double, ByRef OrientationHeight As Double, ByRef AsArray As Boolean) As String
    Dim alOrientation As ArrayList = New ArrayList
	Dim igetOrientation As Integer
	Dim getOrientationTmp As String
	Dim getOrientationRatio As String
	Dim SQL As String
	
	'OrientationWidth - width of image
	'OrientationHeight - height of image
	'AsArray - If true the function returns an array, otherwise a string
	getOrientationTmp = ""
	If OrientationWidth > 0 And OrientationHeight > 0 Then
		getOrientationRatio = OrientationWidth / OrientationHeight
	Else
		getOrientationRatio = ""
	End If

	Dim MediaConn As IDbConnection = Database.GetConn("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

	SQL = "SELECT MediaDBOrientationName, MediaDBOrientationMinratio, MediaDBOrientationMaxratio FROM MediaDBOrientation ORDER BY MediaDBOrientationName"
	cmdMedia.CommandText = SQL

	Dim drOrientationReader As IDataReader = cmdMedia.ExecuteReader()

    Do While drOrientationReader.Read
        Dim objValues(drOrientationReader.FieldCount) As Object
        drOrientationReader.GetValues(objValues)
        alOrientation.Add(objValues)
    Loop

	drOrientationReader.Dispose
	cmdMedia.Dispose
	MediaConn.Dispose
	
    For Each Row As Object() In alOrientation
		If getOrientationRatio > Row(1) And getOrientationRatio <= Row(2) Then
			If getOrientationTmp <> "" Then
				getOrientationTmp = getOrientationTmp & ", "
			End If
			getOrientationTmp = getOrientationTmp & Row(0)
		End If
	Next 


	If AsArray Then
'		getOrientation = Split(getOrientationTmp)
	Else
		getOrientation = getOrientationTmp
	End If
End Function


Function getRatio(ByRef RatioWidth As Double, ByRef RatioHeight As Double) As Object
	If RatioWidth > 0 And RatioHeight > 0 Then
		getRatio = System.Math.Round(RatioWidth / RatioHeight, 1)
	Else
		getRatio = "N/A"
	End If
End Function


Function getFileSize(ByRef getFileSizeBytes As Double) As String
	If (getFileSizeBytes / 1024) > 999 Then
		getFileSize = System.Math.Round((getFileSizeBytes / 1024) / 1024, 1) & " Mb."
	Else
		getFileSize = System.Math.Round(getFileSizeBytes / 1024, 0) & " Kb."
	End If
End Function


Path = Root & "/Files/" & Dynamicweb.Content.Management.Installation.ImagesFolderName &"/MediaDB"
Path = Server.MapPath(Path)

If Not System.IO.Directory.Exists(Path) Then
	System.IO.Directory.CreateDirectory(Path)
End If

If Not System.IO.Directory.Exists(Path & "\Originals") Then
	System.IO.Directory.CreateDirectory(Path & "\Originals")
End If

If Not System.IO.Directory.Exists(Path & "\Thumbs") Then
	System.IO.Directory.CreateDirectory(Path & "\Thumbs")
End If

'**************

Dim FileInfo as System.IO.FileInfo  
Dim extFiles() As String = System.IO.Directory.GetFiles(Server.MapPath("../../images/ext"))
Dim File As String
For Each File In extFiles
	Fileinfo = New System.IO.FileInfo(File)  
	extList = extList & "." & Left(FileInfo.Name,len(FileInfo.Name)-4).ToLower() & "."
Next

%>
