<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="ADODB" %>
<%'UPGRADE_NOTE: All function, subroutine and variable declarations were moved into a script tag global. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1007.htm%>
<script language="VB" runat="Server">
'UPGRADE_ISSUE: DWTranslate object was not upgraded. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup2068"'
Dim cTranslate As New DWTranslate
Dim DWnow() As Object
Dim CopyIterator As Byte
Dim CopyTime As Object
Dim PageIDsArray As String

Function CopyPage(ByRef FromPageID As String, ByRef ToLanguage As Object, ByRef MotherPage As String, ByRef CopyParagraphs As Boolean, ByRef CopySubPages As Boolean) As Object
	Dim SortVal As Object
	Dim sql As String
	Dim we() As Object
	Dim y As Object
	Dim CopyParagraphsRS As Object
	Dim PRS As Object
	Dim CopyID As Object
	Dim PID As String
	Dim conn As Object
	Dim CopyParagraphssql As String
	Dim DWSqlDate() As String
	Dim i As Object
	Dim z As Integer
	Dim PageRS As ADODB.Recordset
	Dim ParaRS As ADODB.Recordset
	CopyIterator = CopyIterator + 1
	If CopyIterator > 10 Then
		we("Error...")
	End If
	sql = "SELECT * FROM Page WHERE PageID = " & FromPageID
	PageRS = New ADODB.Recordset
	PageRS.CursorLocation = 3
	PageRS.open(sql, conn, 3, 3)
	
	PRS = PageRS.GetRows()
	PageRS.AddNew()
	
	For i = 1 To PageRS.fields.count - 1
		If PageRS.Fields(i).name <> "PageShortCut" Then
			PageRS.Fields(i).value = PRS(i, 0)
		End If
	Next 
	If Len(ToLanguage) > 0 Then
		PageRS.Fields("PageAreaID").Value = ToLanguage
	End If
	If Len(MotherPage) > 0 Then
		PageRS.Fields("PageParentPageID").Value = MotherPage
	End If
	If CInt(FromPageID) = CInt(CopyID) Then
		PageRS.Fields("PageSort").Value = SortVal
	End If
	If CInt(CopyID) = CInt(FromPageID) Then
		PageRS.Fields("PageMenuText").Value = cTranslate.Translate("Kopi af ") & PageRS.Fields("PageMenuText").Value
	End If
	PageRS.Fields("PageCreatedDate").Value = CopyTime
	PageRS.update()
	
	PID = PageRS.Fields("PageID").Value
	PageRS.close()
	'UPGRADE_NOTE: Object PageRS may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	PageRS = Nothing
	
	If CopyParagraphs Then
		CopyParagraphssql = "SELECT * FROM Paragraph WHERE ParagraphPageID = " & FromPageID
		ParaRS = New ADODB.Recordset
		ParaRS.open(CopyParagraphssql, conn, 3, 3)
		
		If Not ParaRS.eof Then
			CopyParagraphsRS = ParaRS.GetRows()
			For z = 0 To UBound(CopyParagraphsRS, 2)
				ParaRS.AddNew()
				
				For y = 1 To ParaRS.fields.count - 1
					ParaRS.Fields(y).value = CopyParagraphsRS(y, z)
				Next 
				If Len(PID) > 0 Then
					ParaRS.Fields("ParagraphPageID").Value = PID
				End If
				ParaRS.update()
			Next 
		End If
		
		ParaRS.close()
		'UPGRADE_NOTE: Object ParaRS may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		ParaRS = Nothing
	End If
	
	If CopySubPages Then
		sql = "SELECT PageID, PageMenuText FROM Page WHERE PageParentPageID = " & FromPageID & " AND PageCreatedDate < " & DWSqlDate(CopyTime)
		PageRS = New ADODB.Recordset
		PageRS.open(sql, conn, 3, 3)
		If Not PageRS.eof Then
			Do While Not PageRS.eof
				Call CopyPage(PageRS.Fields("PageID"), ToLanguage, PID, CopyParagraphs, CopySubPages)
				PageRS.MoveNext()
			Loop 
		End If
		PageRS.close()
		'UPGRADE_NOTE: Object PageRS may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		PageRS = Nothing
	End If
End Function

</script>
<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			24-02-2002
'	Last modfied:		24-02-2002
'
'	Purpose: Copies Areas, pages with subpages and paragraphs
'
'	Revision history:
'		1.0 - 24-02-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************
cTranslate = New DWTranslate
CopyIterator = 0
PageIDsArray = ""
CopyTime = DWnow().Clone()
%>
