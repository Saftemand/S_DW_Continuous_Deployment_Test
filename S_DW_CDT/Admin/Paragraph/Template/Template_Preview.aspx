<%@ Page CodeBehind="Template_Preview.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Preview1" codePage="65001"%>
<%@ Import namespace="ADODB" %>
<%'UPGRADE_NOTE: All function, subroutine and variable declarations were moved into a script tag global. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1007.htm%>
<script language="VB" runat="Server">

Class DWTemplate
Private TemplateHTML As Object
	Private TemplatePath As String
	Private TemplateArray As Object
	Private TemplateFile As Object
	Private iTemplate As Integer
	
	Public Function Template(ByRef strTemplatePath As String) As Object
		Dim w() As Object
		Dim Root As String
		TemplatePath = HttpContext.Current.Server.MapPath(Root & "Files/Templates/Paragraph") & "/" & strTemplatePath
		w(strTemplatePath)
	End Function
	
	Public ReadOnly Property Output() As String
		Get
			Dim ReadTextFile() As String
			Dim tmpOutput As String
			tmpOutput = ReadTextFile(CInt(TemplatePath))
			
			For iTemplate = 0 To UBound(TemplateArray, 2)
				'UPGRADE_WARNING: Use of Null/IsNull() detected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1049"'
				If Not IsDbNull(TemplateArray(1, iTemplate)) And tmpOutput <> "" Then
					tmpOutput = Replace(tmpOutput, "<!--@" & TemplateArray(0, iTemplate) & "-->", TemplateArray(1, iTemplate))
				End If
			Next 
			Output = tmpOutput
		End Get
	End Property
	
	Public Function SetTemplateValue(ByRef TemplateValueName As Object, ByRef TemplateValueData As Object) As Object
		Dim newSize As Integer
		newSize = UBound(TemplateArray, 2) + 1
		ReDim Preserve TemplateArray(2, newSize)
		TemplateArray(0, newSize) = TemplateValueName
		TemplateArray(1, newSize) = TemplateValueData
	End Function
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1061"'
	Private Sub Class_Initialize_Renamed()
		ReDim TemplateArray(2, 0)
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
End Class

Sub TemplatePreview(ByRef TemplateID As String)
	Dim pageTemplate As New DWTemplate
	Dim TemplateSql As String
	Dim strWidth As String
	Dim ColWidth As Object
	Dim strSettings As String
	Dim GetConn() As Object
	Dim SpaceWidth As Double
	Dim TemplateRs As ADODB.Recordset
	TemplateRs = New ADODB.Recordset
	TemplateSql = "SELECT * FROM Template WHERE TemplateID=" & TemplateID
	TemplateRs.Open(TemplateSql, GetConn("dynamic.mdb"), 2, 1)
	
	ColWidth = "60"
	SpaceWidth = 5
	
	pageTemplate = New DWTemplate
	pageTemplate.Template(TemplateRs.Fields("TemplateFile").Value)
	
	If TemplateRs.Fields("TemplateSettings").Value <> "" Then
		strWidth = "65"
		strSettings = TemplateRs.Fields("TemplateSettings").Value
	Else
		strWidth = "100"
	End If
	pageTemplate.SetTemplateValue("ParagraphImage", "<img src=Image.gif STYLE=""BORDER: 1px solid #6E7A93; HEIGHT:100px; WIDTH:" & strWidth & "%;"" " & strSettings & "></DIV>")
	pageTemplate.SetTemplateValue("ParagraphText", "Zril feugait iriure consequat vel laoreet in autem veniam, illum praesent. Amet ut praesent duis duis vel ullamcorper erat exerci consectetuer hendrerit nulla dolore lorem adipiscing ad amet nisl, enim nostrud. Odio diam iusto illum, et autem dolor aliquip molestie ex vel nulla consequat qui ut et, nostrud autem. Zril feugait iriure consequat vel laoreet in autem veniam, illum praesent.")
	
	Response.Write(("<TABLE cellspacing=0 cellpadding=0 border=0 width=" & (6 * ColWidth) + (5 * SpaceWidth) & ">"))
	Response.Write(pageTemplate.Output)
	
Response.Write("" & vbCrLf)
Response.Write("	<tr>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=5></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(ColWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(SpaceWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(ColWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(SpaceWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(ColWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(SpaceWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(ColWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(SpaceWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(ColWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(SpaceWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("		<td><img src=""Files/Nothing.gif"" height=1 width=" & vbCrLf)


Response.Write(ColWidth)


Response.Write("></td>" & vbCrLf)
Response.Write("	</tr>" & vbCrLf)
Response.Write("	" & vbCrLf)

	
	Response.Write(("</TABLE>"))
	'UPGRADE_NOTE: Object pageTemplate may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	pageTemplate = Nothing
End Sub

</script>
<%'UPGRADE_NOTE: Language element '#INCLUDE' was migrated to the same language element but still may have a different behavior. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1011.htm  %>
<%'UPGRADE_NOTE: The file '../../common.asp' was not found in the migration directory. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1003.htm  %>
<!-- #INCLUDE FILE="../../common.asp" -->

<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>Untitled</TITLE>
	<Link HREF="../../Stylesheet.css" REL="stylesheet" REV="stylesheet">
</HEAD>

<BODY style="background-color:#FFFFFF;">
<%
Call TemplatePreview(Request.QueryString.Item("TemplateID"))
%>
</BODY>
</HTML>