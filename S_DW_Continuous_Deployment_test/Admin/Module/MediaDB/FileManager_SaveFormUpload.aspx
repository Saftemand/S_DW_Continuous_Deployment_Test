<%@ Page %>
<%@ Import namespace="ASPUPLOADLib" %>
<%
Dim MaxFileSize As Integer
Dim File As Object


Dim FileHome As String
Dim Root As String
Dim Home As String
Dim dwdir As String
Dim Path As String
Dim myPath As String

Dim Dir_Renamed As String
Dim FileName As String
Dim AbsolutFileName As String
Dim Upload As ASPUPLOADLib.UploadManager


%>

<%
Session.TimeOut = 450
Server.ScriptTimeOut = 1200

Upload = New ASPUPLOADLib.UploadManager
Upload.CodePage = 65001
Upload.SetMaxSize(MaxFileSize, True)
Upload.Save()

' From COMMON.ASP
Home = LCase(Request.ServerVariables.Item("PATH_INFO"))
Root = Mid(Home, 1, InStrRev(Home, "/admin/"))
Home = Mid(Home, 1, InStrRev(Home, "/admin/")) & "Admin/"
FileHome = Mid(LCase(Request.ServerVariables.Item("PATH_INFO")), 1, InStrRev(LCase(Request.ServerVariables.Item("PATH_INFO")), "/admin/")) & "Files/"

' Get real paths
dwdir = Upload.Form.Item("ActualPath").Value
Dir_Renamed = Replace(dwdir, "/", "\")
Path = Server.MapPath(FileHome)

myPath = Path & Dir_Renamed

' Loop through files and save
For	Each File In Upload.Files
	FileName = Replace(Replace(Replace(File.FileName, ",", "_"), "'", ""), " ", "_")
	AbsolutFileName = dwdir & "/" & FileName
	
	File.SaveAs(myPath & "\" & FileName)
Next File

'UPGRADE_NOTE: Object Upload may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
Upload = Nothing
%>

<SCRIPT language="JavaScript">
<!--
	parent.uploadWindow.style.display = "none";
	parent.UploadAnimation.style.display = "none";
	parent.document.PathForm.reset();

	parent.document.frames.FileManagerListFolder.location.reload()
//-->
</SCRIPT>
