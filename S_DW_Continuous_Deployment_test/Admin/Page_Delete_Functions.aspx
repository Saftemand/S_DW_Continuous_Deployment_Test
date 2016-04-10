<%@ Page %>
<script language="VB" runat="Server">
Function DeletePages(ByRef PageID As Object, ByRef TopPage As Boolean) As Object
	Dim rsDelete As ADODB.Recordset
	Dim cnDynamic As Object
	
	If TopPage Then
		sql = "SELECT * FROM Page WHERE PageID=" & PageID & " OR PageParentPageID=" & PageID & " OR PageVersionParentID = " & PageID
	Else
		sql = "SELECT * FROM Page WHERE PageParentPageID=" & PageID
	End If
	
	cnDynamic = Database.GetConn(CInt("dynamic.mdb"))
	rsDelete = New ADODB.Recordset
	rsDelete.CursorLocation = 3
	rsDelete.Open(sql, cnDynamic, 3, 3)
	
	If Not rsDelete.Eof Then
		Do While Not rsDelete.Eof
			If Int(CDbl(ID)) <> Int(CDbl(rsDelete.Fields("PageID").Value)) Then
				DeletePages(rsDelete.Fields("PageID"), False)
			Else
				ParentID = rsDelete.Fields("PageParentPageID").Value
				AreaID = rsDelete.Fields("PageAreaID").Value
			End If
			
			rsDelete.delete()
			rsDelete.update()
			
			rsDelete.MoveNext()
		Loop 
	End If
	rsDelete.Close()
	'UPGRADE_NOTE: Object rsDelete may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	rsDelete = Nothing
	'UPGRADE_NOTE: Object cnDynamic may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	cnDynamic = Nothing
End Function





</script>
