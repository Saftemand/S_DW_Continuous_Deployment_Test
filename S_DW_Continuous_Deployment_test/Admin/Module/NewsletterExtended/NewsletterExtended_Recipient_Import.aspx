<%@ Page Codebehind="NewsletterExtended_Recipient_Import.aspx.vb" Language="vb" AutoEventWireup="false"
    Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_Import" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%
    Dim cStatusBar As New StatusBar
    Dim RecipinetEmail As String
    Dim RecipientPassword As String
    Dim RecipientMailFormat As String
    Dim RecipientName As String
    Dim NoRecipinetInvalid As Integer
    Dim NoRecipinet As Integer
    Dim arrFields() As String
    Dim dato As String = Dates.DWNow()
    Dim FileContent As String
    Dim NewsletterRecipientCategoryID As String

    Dim ImportFile As String
    Dim ImportFileEncoding As String
    Dim NewsletterRecipientFormat As String
    Dim PortingType As String
    Dim NumberOfLines As String
    Dim sPath As String
    Dim strFieldString As String
    Dim intUserFieldsCount As Integer
    Dim intUserFieldOptionsCount As Integer
    Dim Counter As Integer
    Dim strUserDataSQL As String
    Dim SQL As String


    Dim arrRecipient() As String
    Dim arrNewsletterRecipientCategoryID() As String

    Dim blnNewsletterRecipientFormat As Boolean

    Dim NewsletterRecipientID As String


    NoRecipinetInvalid = 0
    NoRecipinet = 0

    NewsletterRecipientCategoryID = Request.Item("NewsletterRecipientCategoryID")
    ImportFile = Request.Item("ImportFile")
    ImportFileEncoding = Request.Item("ImportFileEncoding")
    NewsletterRecipientFormat = Request.Item("NewsletterRecipientFormat")
    PortingType = Request.Item("PortingType")
    NumberOfLines = Request.Item("NumberOfLines")

    sPath = Server.MapPath("\Files\" & Dynamicweb.Content.Management.Installation.FilesFolderName & "\" & ImportFile)

    If File.Exists(Server.MapPath("/Files/DBFields.txt")) Then
        strFieldString = Base.ReadTextFile(Server.MapPath("/Files/DBFields.txt")) 'f.ReadAll
    ElseIf File.Exists(Server.MapPath("DBFields.txt")) Then
        strFieldString = Base.ReadTextFile(Server.MapPath("DBFields.txt"))
    End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title></title>
    <link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</head>
<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0" style="background-color: #ECE9D8;
    margin: 0px;">
    <br>
    <%
        If Not File.Exists(sPath) Then
            Response.Write((Translate.Translate("Filen blev ikke fundet: ") & sPath))
        ElseIf strFieldString = "" Or IsNothing(strFieldString) Then
            Response.Write(Translate.JsTranslate("Import/Export felt opsætning mangler"))
        Else
            cStatusBar = New StatusBar
            cStatusBar.Value = 0
            cStatusBar.MaxValue = NumberOfLines
            cStatusBar.Name = "Statusbar"
    %>
    <%=cStatusBar.Render()%>
    <div id="StatusText">
    </div>
    <%	
        strFieldString = Replace(Replace(Replace(strFieldString, "NewsletterRecipientID,", ""), ",NewsletterRecipientID", ""), "NewsletterRecipientID", "")
        strFieldString = Replace(Replace(Replace(strFieldString, "NewsletterRecipientCategoryID,", ""), ",NewsletterRecipientCategoryID", ""), "NewsletterRecipientCategoryID", "")
        strFieldString = Replace(strFieldString, """", "")
        arrFields = Split(strFieldString, ",")
        '		w strFieldString
        'If isFileUnicode(fso, sPath) Then
        '	fMode = True ' unicode
        'Else
        '	fMode = False ' ascii 
        'End If
        	
        '	FileContent = Base.ReadTextFile(sPath)
        ''cnNewsletterRecipient = Database.CreateConnection(CInt("NewsletterExtended.mdb"))
        	
        Dim cnUserFields As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
        Dim cmdUserFields As IDbCommand = cnUserFields.CreateCommand
        'RecordCount
        cmdUserFields.CommandText = "Select Count(NewsletterUserFieldID) As Amount FROM NewsletterExtendedUserField"
        intUserFieldsCount = cmdUserFields.ExecuteScalar()
        	
        cmdUserFields.CommandText = "Select * FROM NewsletterExtendedUserField"
        Dim drUserFields As IDataReader = cmdUserFields.ExecuteReader()
        		
        Dim cnUserFieldOptions As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
        Dim cmdUserFieldOptions As IDbCommand = cnUserFieldOptions.CreateCommand
        	
        cmdUserFieldOptions.CommandText = "Select Count(NewsletterUserFieldOptionsID) As Amount FROM NewsletterExtendedUserFieldOptions"
        intUserFieldOptionsCount = cmdUserFieldOptions.ExecuteScalar()
        'RecordCount
        cmdUserFieldOptions.CommandText = "Select * FROM NewsletterExtendedUserFieldOptions"
        Dim drUserFieldOptions As IDataReader = cmdUserFieldOptions.ExecuteReader()

        Dim cnNewsletterExtended As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
        Dim cmdNewsletterExtended As IDbCommand = cnNewsletterExtended.CreateCommand
        Dim dsNewsletterExtended As DataSet = New DataSet
        Dim daNewsletterExtended As IDbDataAdapter = Database.CreateAdapter()
        daNewsletterExtended.SelectCommand = cmdNewsletterExtended
        Dim dtNewsletterExtended As DataTable
        Dim row As DataRow
        	
        Dim sr As StreamReader = Nothing
        Select Case ImportFileEncoding.ToLower
            Case "ascii"
                sr = New StreamReader(sPath, Encoding.ASCII)
            Case "unicode"
                sr = New StreamReader(sPath, Encoding.Unicode)
            Case "utf-8"
                sr = New StreamReader(sPath, Encoding.UTF8)
            Case Else
                sr = New StreamReader(sPath, Encoding.Default)
        End Select
        'sr = New StreamReader(sPath, Encoding.GetEncoding(ImportFileEncoding))
        Dim strLine As String = ""
        Counter = 0
        'Reading File
        Dim blnImportError As Boolean = False
    	Try
        	

    		Do
    			Counter += 1
    			strLine = ""
    			strLine = sr.ReadLine()
    			If strLine <> "" Then
    				arrRecipient = Split(Replace(strLine, """", ""), ",")
    				'The line above causes problems when the imported line was "Krarup, Martin","mkr@dynamicweb.dk"
		                    
    				If arrRecipient.Length <> arrFields.Length Then
    					'Backup split function:
    					strLine = strLine.Replace(""",""", ";;;").Replace(""", """, ";;;")
    					strLine = strLine.Replace("""", "")
    					arrRecipient = Split(strLine, ";;;")
    					If arrRecipient.Length <> arrFields.Length Then
    						'Still fails, throw exception
    						Throw New Exception("Error1")
    					End If
    				End If
    				
    					
    				If Counter Mod 20 = 0 Then
    					Response.Write(cStatusBar.Increase())
    					Response.Flush()
    				End If
    				
    				If UBound(arrRecipient) = UBound(arrFields) Then
    					cmdNewsletterExtended.CommandText = "SELECT TOP 1 * FROM NewsletterExtendedRecipient"
    					daNewsletterExtended.Fill(dsNewsletterExtended)
    					dtNewsletterExtended = dsNewsletterExtended.Tables(0)
    					row = dtNewsletterExtended.NewRow()
    					dtNewsletterExtended.Rows.Add(row)
    								
    					blnNewsletterRecipientFormat = False
    					
    					For i As Integer = 0 To UBound(arrRecipient)
    						If InStr(arrFields(i), "NewsletterRecipientFormat") Then
    							blnNewsletterRecipientFormat = True
    							row(arrFields(i)) = LTrim(arrRecipient(i))
    						ElseIf InStr(arrFields(i), "NewsletterRecipientEmail") Or InStr(arrFields(i), "NewsletterRecipientPassword") Or InStr(arrFields(i), "NewsletterRecipientName") Then
    							row(arrFields(i)) = LTrim(arrRecipient(i))
    						Else
    							row("NewsletterCustomField_" & arrFields(i)) = arrRecipient(i)
    						End If
    					Next
    					If blnNewsletterRecipientFormat = False Then
    						row("NewsletterRecipientFormat") = NewsletterRecipientFormat
    					End If
    					row("NewsletterRecipientConfirmed") = -1
    					row("NewsletterRecipientCreated") = dato
    					
    					'Updates Database
    					Database.CreateCommandBuilder(daNewsletterExtended)
    					daNewsletterExtended.Update(dsNewsletterExtended)
    					Database.GetAddedIdentityKey(row, cnNewsletterExtended, 0)
    					NewsletterRecipientID = row(0)
    					dsNewsletterExtended.Dispose()
    				End If
    				
    								
    				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    				For i As Integer = 0 To UBound(arrRecipient)
    					strUserDataSQL = ""
    					If Not InStr(arrFields(i), "NewsletterRecipientFormat") Or Not InStr(arrFields(i), "NewsletterRecipientEmail") Or Not InStr(arrFields(i), "NewsletterRecipientPassword") Or Not InStr(arrFields(i), "NewsletterRecipientName") Then
    						If intUserFieldsCount > 0 Then
    							Do While drUserFields.Read()
    								If drUserFields("NewsletterUserFieldSystemName") = arrFields(i) Then
    									If drUserFields("NewsletterUserFieldType") = "Select" Or drUserFields("NewsletterUserFieldType") = "Radio" Then
    										Do While drUserFieldOptions.Read()
    											If drUserFieldOptions("NewsletterUserFieldOptionsValue") = arrRecipient(i) And drUserFields("NewsletterUserFieldID") = drUserFieldOptions("NewsletterUserFieldOptionsFieldID") Then
    												strUserDataSQL = " INSERT INTO NewsletterExtendedUserFieldData (NewsletterUserFieldID, NewsletterUserFieldOptionsID, NewsletterRecipientID, NewsletterUserFieldData) " & " VALUES (" & drUserFields("NewsletterUserFieldID") & ", " & drUserFieldOptions("NewsletterUserFieldOptionsID") & ", " & NewsletterRecipientID & ", '" & Replace(arrRecipient(i), "'", "''") & "')"
    											End If
    										Loop
    										If intUserFieldOptionsCount > 0 Then
    											cmdUserFieldOptions.CommandText = "Select * FROM NewsletterExtendedUserFieldOptions"
    											drUserFieldOptions = cmdUserFieldOptions.ExecuteReader()
    										End If
    									Else
    										'									w "SQL String"
    										strUserDataSQL = " INSERT INTO NewsletterExtendedUserFieldData (NewsletterUserFieldID, NewsletterUserFieldOptionsID, NewsletterRecipientID, NewsletterUserFieldData) " & " VALUES (" & drUserFields("NewsletterUserFieldID") & ", 0, " & NewsletterRecipientID & ", '" & Replace(arrRecipient(i), "'", "''") & "')"
    									End If
    								End If
    							Loop
    							drUserFields.Close()
    							cmdUserFields.CommandText = "Select * FROM NewsletterExtendedUserField"
    							drUserFields = cmdUserFields.ExecuteReader()
    						End If
    						
    							
    						If intUserFieldsCount > 0 Then
    							'	cmdUserFields.CommandText = "Select * FROM NewsletterExtendedUserField"
    							'	drUserFields = cmdUserFields.ExecuteReader()
    						End If
    						If strUserDataSQL <> "" Then
    							'							w "SQL CAll" 
    							cmdNewsletterExtended.CommandText = strUserDataSQL
    							cmdNewsletterExtended.ExecuteNonQuery()
    						End If
    					End If
    				Next
    				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    			
    				If NewsletterRecipientCategoryID <> "" Then
    					arrNewsletterRecipientCategoryID = Split(NewsletterRecipientCategoryID, ",")
    					For i As Integer = 0 To UBound(arrNewsletterRecipientCategoryID)
    						SQL = " INSERT INTO NewsletterExtendedCategoryRecipient (NewsletterCategoryRecipientRecipientID, NewsletterCategoryRecipientType, NewsletterCategoryRecipientCategoryID) " & " VALUES (" & NewsletterRecipientID & ", 1, " & arrNewsletterRecipientCategoryID(i) & ")"
    							
    						cmdNewsletterExtended.CommandText = SQL
    						cmdNewsletterExtended.ExecuteNonQuery()
    					Next
    				End If
    			End If
    				
    		Loop While strLine <> ""
    		
    		
    		
    		'Cleanup
    		sr.Close()
    		cmdNewsletterExtended.Dispose()
    		cmdUserFields.Dispose()
    		cmdUserFieldOptions.Dispose()
    		cnUserFields.Dispose()
    		cnUserFieldOptions.Dispose()
    		cnNewsletterExtended.Dispose()

    	Catch ex As Exception
    		sr.Close()
    		cmdNewsletterExtended.Dispose()
    		cmdUserFields.Dispose()
    		cmdUserFieldOptions.Dispose()
    		cnUserFields.Dispose()
    		cnUserFieldOptions.Dispose()
    		cnNewsletterExtended.Dispose()
    	    		
    		If ex.Message = "Error1" Then
    			Response.Write(Translate.Translate("Antal felter passer ikke med filen!") & "(Line:" & Counter & ")")
    			Response.End()
    			'Response.Write(Translate.Translate("Antal felter passer ikke med importfilen (Linie:" & Counter & ")"))
    			'Response.End()
    		Else
    			Response.Write(Translate.Translate("Der er sket en fejl under import. (Linie:" & Counter & ") Fejl:" & ex.Message))
    			Response.End()
    		End If
    	    		
    	End Try

    End If

    %>
    </div>
</body>
</html>

<script language="JavaScript">
    <!--
    parent.updateinfo("Total: <%=NoRecipinet%>/<%=NumberOfLines%> - Invalid: <%=NoRecipinetInvalid%>")
    parent.document.getElementById("ListRight").setAttribute("src", "NewsletterExtended_Blank.html");
    t = setTimeout("document.location = 'NewsletterExtended_Blank_with_color.html'", 5000);

    //-->
</script>

<%
    Translate.GetEditOnlineScript()
%>
