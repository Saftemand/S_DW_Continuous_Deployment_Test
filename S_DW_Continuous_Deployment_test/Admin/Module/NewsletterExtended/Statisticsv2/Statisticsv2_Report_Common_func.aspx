<script language="VB" runat="Server">
Public Function StatInitializeWhere() As Object
	Dim sql As String
	Dim IpFilteringWhere As String
	Dim Statv2ExcludeFromIP As Object
	Dim DWSqlDate() As String
	Dim cnStat As Object
	Dim GetConn() As Object
	Dim Statv2ExcludeToIp As Object
	Dim rs As ADODB.Recordset
	RobotsWhere = "("
	strWhere = "("
	
	If Statv2SettingsFrom <> "" And Statv2SettingsTo <> "" Then
		strWhere = strWhere & "(Statv2SessionTimestamp BETWEEN " & DWSqlDate(CInt(Statv2SettingsFrom)) & " AND " & DWSqlDate(Statv2SettingsTo) & ")"
	Else
		strWhere = strWhere & "(1=1)"
	End If
	
	'WHERE (Statv2Session.Statv2SessionAreaID = " & Statv2SettingsArea & ")
	If Statv2SettingsArea <> "" Then
		strWhere = strWhere & " AND (Statv2SessionAreaID = " & Statv2SettingsArea & ")"
	End If
	
	RobotsWhere = strWhere & ")"
	
	'WHERE (Statv2SessionAdminUserID Is Null)
	If Statv2SettingsAdmins = "False" Then
		strWhere = strWhere & " AND (Statv2SessionAdminUserID Is Null OR Statv2SessionAdminUserID = 0)"
	End If
	
	'WHERE (Statv2SessionPageviews > 1)
	If Statv2SettingsOnePv = "False" Then
		strWhere = strWhere & " AND (Statv2SessionPageviews > 1)"
	End If
	
	'WHERE (Statv2SessionExtranetUserID Is Null)
	If Statv2SettingsExtranetusers = "False" Then
		strWhere = strWhere & " AND (Statv2SessionExtranetUserID Is Null OR Statv2SessionExtranetUserID = 0)"
	End If
	
	'WHERE ((Statv2SessionGwIPDbl Not Between 167772161 And 184549375) AND (Statv2SessionGwIPDbl Not Between 3232235521 And 3232301055))
	If Statv2SettingsIPfiltering = "False" Then
		sql = "SELECT * FROM Statv2Exclude"
		cnStat = GetConn(CInt("Statisticsv2.mdb"))
		rs = New ADODB.Recordset
		
		rs.Open(sql, cnStat, 1, 1)
		If Not rs.Eof Then
			IpFilteringWhere = " AND ("
			Do While Not rs.Eof
				Statv2ExcludeFromIP = CQuad(rs.fields("Statv2ExcludeFromIP").value)
				Statv2ExcludeToIp = CQuad(rs.fields("Statv2ExcludeToIp").value)
				IpFilteringWhere = IpFilteringWhere & "(Statv2SessionGwIPDbl Not Between " & Statv2ExcludeFromIP & " And " & Statv2ExcludeToIp & ")"
				rs.MoveNext()
				If Not rs.Eof Then
					IpFilteringWhere = IpFilteringWhere & " AND "
				End If
			Loop 
			IpFilteringWhere = IpFilteringWhere & ")"
		End If
		
		rs.close()
		'UPGRADE_NOTE: Object rs may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		rs = Nothing
		'UPGRADE_NOTE: Object cnStat may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		cnStat = Nothing
		
		strWhere = strWhere & IpFilteringWhere
	End If
	
	strWhere = strWhere & ")"
End Function


Public Function StatGetSettingsFromDB() As Object
	Dim sql As String
	Dim Conn As Object
	Dim GetConn() As Object
	Dim rs As ADODB.Recordset
	sql = "SELECT * FROM Statv2Settings WHERE Statv2SettingsID = 1"
	Conn = GetConn(CInt("Statisticsv2.mdb"))
	rs = New ADODB.Recordset
	
	rs.Open(sql, Conn, 1, 1)
	If Not rs.Eof Then
		Statv2SettingsCrawlers = rs.fields("Statv2SettingsCrawlers").value
		Statv2SettingsFillbar = rs.fields("Statv2SettingsFillbar").value
		Statv2SettingsAdmins = rs.fields("Statv2SettingsAdmins").value
		Statv2SettingsOnePv = rs.fields("Statv2SettingsOnePv").value
		Statv2SettingsExtranetusers = rs.fields("Statv2SettingsExtranetusers").value
		Statv2SettingsIPfiltering = rs.fields("Statv2SettingsIPfiltering").value
	End If
	
	rs.close()
	'UPGRADE_NOTE: Object rs may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	rs = Nothing
	'UPGRADE_NOTE: Object Conn may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	Conn = Nothing
End Function


Public Function CQuad(ByVal varIPv4 As String) As Object
	Dim varIPAdresses() As String
	Dim i As Integer 'Cast IPv4 to Quad
	Dim varTempIP As Double
	
	varIPAdresses = Split(varIPv4, ".")
	For i = 1 To 4
		varTempIP = ((CDbl(varIPAdresses(i - 1)) Mod 256) * (256 ^ (4 - i))) + varTempIP
	Next 
	
	CQuad = CDbl(varTempIP)
End Function


Public Function StatParseDate(ByVal Name As String) As Object
	Dim MonthVar As Object
	Dim TimeVar As String
	Dim DayVar As Object
	If IsNothing(Request.QueryString.GetValues(Name & "_year")) Then 'Does values exist for the name specified?
		StatParseDate = ""
	Else
		If Not IsNothing(Request.QueryString.GetValues(Name & "_hour")) Then
			TimeVar = " " & Request.QueryString.Item(Name & "_hour") & ":" & Request.QueryString.Item(Name & "_minute")
		End If
		MonthVar = Request.QueryString.Item(Name & "_month")
		DayVar = Request.QueryString.Item(Name & "_day")
		If MonthVar = 2 And DayVar > 28 Then 'Make sure it's a valid date
			DayVar = 28
		End If
		If (MonthVar = 4 Or MonthVar = 6 Or MonthVar = 9 Or MonthVar = 11) And DayVar > 30 Then
			DayVar = 30
		End If
		StatParseDate = Request.QueryString.Item(Name & "_year") & "-" & MonthVar & "-" & DayVar & TimeVar
	End If
End Function


Public Function GetBrowserName(ByVal strBrw As String) As String
	Select Case LCase(strBrw)
		Case "o3"
			GetBrowserName = "Opera 3"
		Case "o4"
			GetBrowserName = "Opera 4"
		Case "o5"
			GetBrowserName = "Opera 5"
		Case "o6"
			GetBrowserName = "Opera 6"
		Case "o7"
			GetBrowserName = "Opera 7"
		Case "o8"
			GetBrowserName = "Opera 8"
		Case "ie3"
			GetBrowserName = "Internet Explorer 3"
		Case "ie4"
			GetBrowserName = "Internet Explorer 4"
		Case "ie5"
			GetBrowserName = "Internet Explorer 5"
		Case "ie55"
			GetBrowserName = "Internet Explorer 5.5"
		Case "ie6"
			GetBrowserName = "Internet Explorer 6"
		Case "ns2"
			GetBrowserName = "Netscape 2"
		Case "ns3"
			GetBrowserName = "Netscape 3"
		Case "ns4"
			GetBrowserName = "Netscape 4"
		Case "ns6"
			GetBrowserName = "Netscape 6"
		Case "ns7"
			GetBrowserName = "Netscape 7"
		Case "safari"
			GetBrowserName = "Safari"
		Case "konqueror"
			GetBrowserName = "Konqueror"
		Case "mz1"
			GetBrowserName = "Mozilla 1.x"
		Case Else
			GetBrowserName = strBrw
	End Select
End Function


Public Function GetOsName(ByVal strOs As String) As String
	Select Case LCase(strOs)
		Case "winxp"
			GetOsName = "Windows XP"
		Case "win2003"
			GetOsName = "Windows 2003 Server"
		Case "win2000"
			GetOsName = "Windows 2000"
		Case "win98"
			GetOsName = "Windows 98"
		Case "winnt"
			GetOsName = "Windows NT 4.0"
		Case "winme"
			GetOsName = "Windows ME"
		Case "win95"
			GetOsName = "Windows 95"
		Case "wince"
			GetOsName = "Windows CE"
		Case "linux"
			GetOsName = "Linux"
		Case "unix"
			GetOsName = "Unix"
		Case "powerpc"
			GetOsName = "MAC Power PC"
		Case "osx"
			GetOsName = "MAC OS X"
		Case "os2"
			GetOsName = "OS/2"
		Case Else
			GetOsName = strOs
	End Select
End Function


Public Function GetPageName(ByVal intID As String) As String
	Dim cnPage As Object
	Dim strName As String
	Dim GetConn() As Object
	Dim rsPage As Object
	Dim HTMLEncode() As String
	If intID <> "" Then
		cnPage = GetConn(CInt("dynamic.mdb"))
		rsPage = cnPage.Execute("SELECT Page.PageMenuText, Area.AreaName FROM Area RIGHT JOIN Page ON Area.AreaID = Page.PageAreaID WHERE PageID =" & intID)
		
		If Not rsPage.Eof Then
			strName = HTMLEncode(rsPage("PageMenuText"))
			'strAreaName = HTMLEncode(rsPage("AreaName"))
			GetPageName = "<A target=""_blank"" href=""../../Default.aspx?ID=" & intID & """>" & strName & "</A>"
		End If
		
		'UPGRADE_NOTE: Object rsPage may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		rsPage = Nothing
		'UPGRADE_NOTE: Object cnPage may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		cnPage = Nothing
	End If
End Function


Public Function GetExtranetUserName(ByVal intUserID As String) As String
	Dim rsAccessUser As Object
	Dim cnAccess As Object
	Dim GetConn() As Object
	If intUserID <> "" Then
		cnAccess = GetConn(CInt("Access.mdb"))
		rsAccessUser = cnAccess.Execute("SELECT AccessUserUserName, AccessUserName FROM AccessUser WHERE AccessUserID =" & intUserID)
		If Not rsAccessUser.Eof Then
			GetExtranetUserName = rsAccessUser("AccessUserName") & " (" & rsAccessUser("AccessUserUserName") & ")"
		End If
		'UPGRADE_NOTE: Object rsAccessUser may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		rsAccessUser = Nothing
		'UPGRADE_NOTE: Object cnAccess may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		cnAccess = Nothing
	End If
End Function


Public Function GetNewsName(ByVal NewsID As String) As String
	Dim DWDateMedium As Object
	Dim cnAccess As Object
	Dim GetConn() As Object
	Dim rsAccessUser As Object
	If NewsID <> "" Then
		cnAccess = GetConn(CInt("Dynamic.mdb"))
		rsAccessUser = cnAccess.Execute("SELECT NewsHeading, NewsDate FROM News WHERE NewsID =" & NewsID)
		If Not rsAccessUser.Eof Then
			'UPGRADE_WARNING: Use of Null/IsNull() detected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1049"'
			GetNewsName = rsAccessUser("NewsHeading") & " (" & DWShowDate(rsAccessUser("NewsDate"), DWDateMedium, False, System.DBNull.Value) & ")"
		End If
		'UPGRADE_NOTE: Object rsAccessUser may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		rsAccessUser = Nothing
		'UPGRADE_NOTE: Object cnAccess may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		cnAccess = Nothing
	End If
End Function


Public Function GetFormName(ByVal FormID As String) As Object
	Dim rsAccessUser As Object
	Dim cnAccess As Object
	Dim GetConn() As Object
	If FormID <> "" Then
		cnAccess = GetConn(CInt("Dynamic.mdb"))
		rsAccessUser = cnAccess.Execute("SELECT FormName FROM Form WHERE FormID =" & FormID)
		If Not rsAccessUser.Eof Then
			GetFormName = rsAccessUser("FormName")
		End If
		'UPGRADE_NOTE: Object rsAccessUser may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		rsAccessUser = Nothing
		'UPGRADE_NOTE: Object cnAccess may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		cnAccess = Nothing
	End If
End Function


Public Function RStoCSV(ByRef RecordSet As Object, ByVal FilePath As String) As Object
	Dim Header As Object
	Dim Line As String
	Dim tmpVal As String
	Dim FieldCount As Double
	Dim iRecordSet As Integer
	If Not RecordSet.Eof Then
		FSO = New Scripting.FileSystemObject
		File = FSO.CreateTextfile(FilePath, True, True)
		FieldCount = RecordSet.fields.Count - 1
		For iRecordSet = 0 To FieldCount
			Header = Header & """" & RecordSet(iRecordSet).Name & """;"
		Next 
		File.WriteLine((Header))
		
		Do While Not RecordSet.Eof
			For iRecordSet = 0 To FieldCount
				tmpVal = RecordSet.fields(iRecordSet).value
				'If tmpVal <> "" Then
				'	tmpVal = Replace(tmpVal, ";", "")
				'End If
				Line = Line & """" & tmpVal & """;"
			Next 
			File.WriteLine((Line))
			Line = ""
			RecordSet.MoveNext()
		Loop 
		
		'UPGRADE_NOTE: Object File may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		File = Nothing
		'UPGRADE_NOTE: Object FSO may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
		FSO = Nothing
		RStoCSV = Header
		RStoCSV = True
	Else
		RStoCSV = False
	End If
End Function


Class DWGraph2
Private l_BarArray As Object
	Private l_BarTotal As Double
	Private l_BarHeigh As Object
	Private l_BarFill As Boolean
	Private l_BarFactor As Double
	Private l_BarMin1Percent As Boolean
	
	
	Public Property BarFill() As Boolean
		Get
			Dim BarType As Boolean
			BarType = l_BarFill
		End Get
		Set(ByVal Value As Boolean)
			l_BarFill = Value
		End Set
	End Property
	
	Public WriteOnly Property BarMin1Percent() As Boolean
		Set(ByVal Value As Boolean)
			l_BarMin1Percent = Value
		End Set
	End Property
	
	Public ReadOnly Property Output() As String
		Get
			Dim iBar As Integer
			Dim StripHTML() As Object
			Dim ExportConn As Object
			Dim tmp As String
			Dim tmpPercent As Double
			Dim Export As String
			If CInt(l_BarTotal) < 1 Then
				l_BarTotal = 1
			End If
			If CInt(l_BarHeigh) < 1 Then
				l_BarHeigh = 1
			End If

			Dim ExportRS As ADODB.Recordset
			If Export = "True" Then
                    ExportConn = GetXLSConn(HttpContext.Current.Server.MapPath("/files/" & Dynamicweb.Content.Management.Installation.FilesFolderName.ToLower() & "/Dynamicweb_Stat_" & Day(Now) & Month(Now) & Year(Now) & ".xls"))
				ExportRS = HttpContext.Current.Server.CreateObject("ADODB.Recordset")
				ExportRS.Open("[Sheet1$]", ExportConn, 3, 3)
			End If
			If UBound(l_BarArray, 2) > 0 Then
				If l_BarFill Then
					l_BarFactor = (l_BarTotal / l_BarHeigh)
				End If
				tmp = "<table cellpadding=0 cellspacing=0 border=0 width=""100%"">"
				For iBar = 1 To UBound(l_BarArray, 2)
					tmpPercent = (l_BarArray(1, iBar) / l_BarTotal) * 100
					If l_BarMin1Percent And tmpPercent < (1 / 2) Then
					Else
						tmp = tmp & "<tr>"
						tmp = tmp & "<td width=170>" & l_BarArray(0, iBar) & "</td>"
						tmp = tmp & "<td class=""barBG"">"
						tmp = tmp & "<SPAN STYLE=""width:" & System.Math.Round(tmpPercent * l_BarFactor) & "%;"" class=""bar""></SPAN>"
						tmp = tmp & "</td>"
						tmp = tmp & "<td align=right>&nbsp;" & l_BarArray(1, iBar) & "</td>"
						tmp = tmp & "<td align=right>&nbsp;" & System.Math.Round(tmpPercent) & "%</td>"
						tmp = tmp & "</tr>"
						If iBar < UBound(l_BarArray, 2) Then
							tmp = tmp & "<tr><td height=2></td></tr>"
						End If
						If Export = "True" Then
							ExportRS.AddNew()
							ExportRS.Fields(0).Value = StripHTML(l_BarArray(0, iBar))
							ExportRS.Fields(1).Value = Int(CDbl(l_BarArray(1, iBar)))
							ExportRS.Fields(2).Value = System.Math.Round(tmpPercent) & "%"
							ExportRS.Update()
						End If
					End If
				Next 
				tmp = tmp & "</table>"
				Output = tmp
			End If
			If Export = "True" Then
				'UPGRADE_NOTE: Object ExportConn may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
				ExportConn = Nothing
				ExportRS.Close()
				'UPGRADE_NOTE: Object ExportRS may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
				ExportRS = Nothing
			End If
		End Get
	End Property
	
	Public Function SetBarValue(ByVal BarLabel As Object, ByVal BarValue As Object) As Object
		Dim newSize As Integer
		If BarValue > -1 And IsNumeric(BarValue) Then
			If BarValue > l_BarHeigh Then
				l_BarHeigh = BarValue
			End If
			newSize = UBound(l_BarArray, 2) + 1
			ReDim Preserve l_BarArray(2, newSize)
			l_BarArray(0, newSize) = BarLabel
			l_BarArray(1, newSize) = BarValue
			l_BarTotal = l_BarTotal + BarValue
		End If
	End Function
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1061"'
	Private Sub Class_Initialize_Renamed()
		l_BarTotal = 0
		l_BarHeigh = 0
		l_BarFactor = 1
		l_BarMin1Percent = False
		ReDim l_BarArray(2, 0)
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
End Class


' ======================================================================
'
' QSort2
'
' This version sorts a 2-dimensional array on the iIdx column
' Performance on a P233MMX with 64M of RAM:
' ~55 seconds to sort 100,000 rows of random integers.
'
' Parameters:
'
' aData					array to be sorted
' iIdx		index of column to use for sorting
' iLb			lower-bound of elements to be sorted
' iUb			upper-bound of elements to be sorted
'
' e.g. QSort2(aData, 0, 0, ubound(aData)) ' sort the entire array based on column 0
'						QSort2(aData, 3, 3, 8) ' sort elements from index 3 to 8 based on column 3

Public Sub QSort2(ByRef aData As Object, ByRef iIdx As Integer, ByRef iLb As Double, ByRef iUb As Double)
	Dim lbStack(32) As Double
	Dim ubStack(32) As Double
	Dim sp As Double ' stack pointer
	Dim iLbx As Double ' current lower-bound
	Dim iUbx As Double ' current upper-bound
	Dim m As Double
	Dim p As Double ' index to pivot
	Dim i As Double
	Dim j As Double
	Dim t As Object ' temp used for exchanges
	
	lbStack(0) = iLb
	ubStack(0) = iUb
	sp = 0
	Do While sp >= 0
		iLbx = lbStack(sp)
		iUbx = ubStack(sp)
		
		Do While (iLbx < iUbx)
			
			' select pivot and exchange with 1st element
			p = iLbx + (iUbx - iLbx) \ 2
			
			' exchange iLbx, p
			Swap(aData, iLbx, p)
			
			' partition into two segments
			i = iLbx + 1
			j = iUbx
			Do 
				Do While i < j
					If aData(iLbx, iIdx) <= aData(i, iIdx) Then Exit Do
					i = i + 1
				Loop 
				
				Do While j >= i
					If aData(j, iIdx) <= aData(iLbx, iIdx) Then Exit Do
					j = j - 1
				Loop 
				
				If i >= j Then Exit Do
				
				' exchange i, j
				Swap(aData, i, j)
				
				j = j - 1
				i = i + 1
			Loop 
			
			' pivot belongs in aData[j]
			' exchange iLbx, j
			Swap(aData, iLbx, j)
			
			m = j
			
			' keep processing smallest segment, and stack largest
			If m - iLbx <= iUbx - m Then
				If m + 1 < iUbx Then
					lbStack(sp) = m + 1
					ubStack(sp) = iUbx
					sp = sp + 1
				End If
				iUbx = m - 1
			Else
				If m - 1 > iLbx Then
					lbStack(sp) = iLbx
					ubStack(sp) = m - 1
					sp = sp + 1
				End If
				iLbx = m + 1
			End If
		Loop 
		sp = sp - 1
	Loop 
End Sub


' ======================================================================
'
' Swap()
'
' Used by QSort2, this sub swaps two rows in a 2 dimensional array
'
' Parameters:
'
' aData					array to work with
' iRow1					index of first row
' iRow2					index of second row
'
' e.g. Swap(A, 3, 8) ' swap the 4th and 9th rows in A.

Public Sub Swap(ByRef aData As Object, ByRef iRow1 As Double, ByRef iRow2 As Double)
	Dim tmp() As Object
	Dim i As Integer
	
	' Get values into Tmp
	For i = 0 To UBound(aData, 2)
		tmp = aData(iRow1, i)
		aData(iRow1, i) = aData(iRow2, i)
		aData(iRow2, i) = tmp.Clone()
	Next 
End Sub


' ======================================================================
'
' Transpose()
'
' Changes the data in a two dimensional array from:
' (x,y) => (y,x).		This can be useful if you don't
' like the way RECORDSET.getrows() works.		Calling
' Transpose() is a quick way to get your array into
' the proper form for QSort2().
'
' Parameters:
'
' aData					array to be transposed
'
' Returns:
'
' New transposed array.
'
' Performance on a P233MMX with 64M of RAM:
' ~5 seconds to transpose 100,000 rows.
'
' e.g. a2 = Transpose(a1)

Public Function Transpose(ByRef aData As Object) As Object
	Dim aTmp As Object
	Dim j As Integer
	Dim i As Integer
	
	' Dimension Tmp the opposite of A
	ReDim aTmp(UBound(aData, 2), UBound(aData))
	
	' Transpose
	For i = 0 To UBound(aData, 2)
		For j = 0 To UBound(aData)
			aTmp(i, j) = aData(j, i)
		Next 
	Next 
	
	Transpose = aTmp
End Function


Sub QSort(ByRef aData() As Object, ByRef iLb As Double, ByRef iUb As Double)
	'http://groups.google.com/groups?q=sort+array+asp&hl=en&lr=&ie=UTF-8&oe=UTF-8&newwindow=1&selm=%23nCYDpwd%24GA.282%40cppssbbsa04&rnum=2
	Dim lbStack(32) As Double
	Dim ubStack(32) As Double
	Dim sp As Double
	Dim iLbx As Double
	Dim iUbx As Double
	Dim m As Double
	Dim p As Double
	Dim i As Double
	Dim j As Double
	Dim t As Object
	
	' Init stacks
	lbStack(0) = iLb
	ubStack(0) = iUb
	sp = 0
	
	Do While sp >= 0
		iLbx = lbStack(sp)
		iUbx = ubStack(sp)
		
		Do While (iLbx < iUbx)
			
			' select pivot and exchange with 1st element
			p = iLbx + (iUbx - iLbx) \ 2
			
			' exchange iLbx, p
			t = aData(iLbx)
			aData(iLbx) = aData(p)
			aData(p) = t
			
			' partition into two segments
			i = iLbx + 1
			j = iUbx
			Do 
				Do While i < j
					If aData(iLbx) <= aData(i) Then Exit Do
					i = i + 1
				Loop 
				
				Do While j >= i
					If aData(j) <= aData(iLbx) Then Exit Do
					j = j - 1
				Loop 
				
				If i >= j Then Exit Do
				
				' exchange i, j
				t = aData(i)
				aData(i) = aData(j)
				aData(j) = t
				
				j = j - 1
				i = i + 1
			Loop 
			
			' pivot belongs in aData[j]
			' exchange iLbx, j
			t = aData(iLbx)
			aData(iLbx) = aData(j)
			aData(j) = t
			
			m = j
			
			' keep processing smallest segment, and stack largest
			If m - iLbx <= iUbx - m Then
				If m + 1 < iUbx Then
					lbStack(sp) = m + 1
					ubStack(sp) = iUbx
					sp = sp + 1
				End If
				iUbx = m - 1
			Else
				If m - 1 > iLbx Then
					lbStack(sp) = iLbx
					ubStack(sp) = m - 1
					sp = sp + 1
				End If
				iLbx = m + 1
			End If
		Loop 
		sp = sp - 1
	Loop 
End Sub


'*** Creating the connection to an XLS file.
Public Function GetXLSConn(ByVal strXLS As String) As ADODB.Connection
	Dim tmpConn As ADODB.Connection
	tmpConn = New ADODB.Connection
	tmpConn.CommandTimeout = 30
	tmpConn.ConnectionTimeout = 20
	With tmpConn
		.Provider = "Microsoft.Jet.OLEDB.4.0"
		.ConnectionString = "Data Source=" & strXLS & ";" & "Extended Properties=Excel 8.0;"
		.Open()
	End With
	GetXLSConn = tmpConn
	'Must DO!
	'UPGRADE_NOTE: Object tmpConn may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	tmpConn = Nothing
End Function

</script>
<%
'*** Is it an Export?
Export = Request.QueryString.Item("Export")

If Export = "True" Then
	FSO = New Scripting.FileSystemObject
        FSO.CopyFile(Server.MapPath("/admin/statisticsv2/export.xls"), Server.MapPath("/files/" & Dynamicweb.Content.Management.Installation.FilesFolderName.ToLower() & "/Dynamicweb_Stat_" & Day(Now) & Month(Now) & Year(Now) & ".xls"))
	'UPGRADE_NOTE: Object FSO may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	FSO = Nothing
End If

RobotsWhere = ""
strWhere = ""

Statv2SettingsCrawlers = Request.QueryString.Item("Crawlers")
Statv2SettingsFillbar = Request.QueryString.Item("Fillbar")
Statv2SettingsArea = Request.QueryString.Item("Statv2Area")
Statv2SettingsAdmins = Request.QueryString.Item("Admins")
Statv2SettingsOnePv = Request.QueryString.Item("OnePv")
Statv2SettingsExtranetusers = Request.QueryString.Item("Extranetusers")
Statv2SettingsIPfiltering = Request.QueryString.Item("IPfiltering")
Statv2SettingsFrom = StatParseDate("Statv2From")
Statv2SettingsTo = StatParseDate("Statv2To") & " 23:59:59"
%>
