<%@ Page %>
<%
Function CopyPage(ByRef FromPageID As String, ByRef ToLanguage As String, ByRef MotherPage As String, ByRef CopyParagraphs As Boolean, ByRef CopySubPages As Boolean) As Object
	Dim DWSqlDate() As String
	Dim CopyParagraphssql As String
	Dim PID As String
	Dim i As Object
	Dim CopyParagraphsRS As Object
	Dim we() As Object
	Dim z As Integer
	Dim PRS As Object
	Dim y As Object
	Dim PageRS As ADODB.Recordset
	Dim ParaRS As ADODB.Recordset
	CopyIterator = CopyIterator + 1
	If CopyIterator > 10 Then
		we("Error...")
	End If
	SQL = "SELECT * FROM Page WHERE PageID = " & FromPageID
	PageRS = New ADODB.Recordset
	PageRS.CursorLocation = 3
	PageRS.Open(SQL, Conn, 3, 3)
	
	PRS = PageRS.GetRows()
	PageRS.AddNew()
	
	For i = 1 To PageRS.Fields.count - 1
		If PageRS.Fields(i).name <> "PageShortCut" Then
			PageRS.Fields(i).Value = PRS(i, 0)
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
		PageRS.Fields("PageMenuText").Value = Translate.Translate("Kopi af ") & PageRS.Fields("PageMenuText").Value
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
		ParaRS.Open(CopyParagraphssql, Conn, 3, 3)
		
		If Not ParaRS.eof Then
			CopyParagraphsRS = ParaRS.GetRows()
			For z = 0 To UBound(CopyParagraphsRS, 2)
				ParaRS.AddNew()
				
				For y = 1 To ParaRS.Fields.count - 1
					ParaRS.Fields(y).Value = CopyParagraphsRS(y, z)
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
		SQL = "SELECT PageID, PageMenuText FROM Page WHERE PageParentPageID = " & FromPageID & " AND PageCreatedDate < " & DWSqlDate(CopyTime)
		PageRS = New ADODB.Recordset
		PageRS.Open(SQL, Conn, 3, 3)
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


CopyIterator = 0
PageIDsArray = ""
CopyTime = DWnow().Clone()
%>
