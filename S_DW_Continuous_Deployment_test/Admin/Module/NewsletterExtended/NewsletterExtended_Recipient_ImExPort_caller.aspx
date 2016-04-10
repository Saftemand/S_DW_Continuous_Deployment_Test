<%@ Page CodeBehind="NewsletterExtended_Recipient_ImExPort_caller.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_ImExPort_caller" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.IO" %>


<%
    Dim NewsletterList As String
    Dim ImPortingType As String
    Dim PortingType As String
    Dim NewsletterRecipientFormat As String
    Dim sql As String

    Dim ImportFile As String
    Dim ImportFileEncoding As String
    Dim FileHome As String = "/Files/"
    Dim NewsletterRecipientCategoryID As String
    Dim sPath As String
    Dim NumberOfLines As Integer

    NewsletterRecipientCategoryID = Request.Form.Item("NewsletterRecipientCategoryID")
    ImportFile = Request.Form.Item("ImportFile")
    ImportFileEncoding = Request.Form.Item("ImportFileEncoding")
    NewsletterRecipientFormat = Request.Form.Item("NewsletterRecipientFormat")
    PortingType = Request.Form.Item("PortingType")
    ImPortingType = Request.Form.Item("cbImType")
    NewsletterList = Request.Form.Item("NewsletterList")

    Dim cnNewsletterExtended As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
    Dim cmdNewsletterExtended As IDbCommand = cnNewsletterExtended.CreateCommand

    Dim cnNewsletter As IDbConnection = Database.CreateConnection("Newsletter.mdb")
    Dim cmdNewsletter As IDbCommand = cnNewsletter.CreateCommand


%>
<HTML>
<HEAD>
<TITLE><%=Translate.JsTranslate("Import/Export")%></TITLE>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</HEAD>
<BODY>
<%
    If CInt(PortingType) = 1 Then
        If CInt(ImPortingType) = 1 Then
            sPath = Server.MapPath(FileHome & Dynamicweb.Content.Management.Installation.FilesFolderName.ToLower() & "/" & ImportFile)
            NumberOfLines = 0
            'fso = New Scripting.FileSystemObject
            If Not File.Exists(sPath) Then
                Response.Write((Translate.Translate("Filen blev ikke fundet: %%", "%%", sPath)))
            Else
                'If isFileUnicode(fso, sPath) Then
                '	fMode = True ' unicode
                'Else
                '		fMode = False ' ascii 
                '	End If
                'FileContent = fso.OpenTextFile(sPath, 1, True, fMode)
                'Do While FileContent.AtEndOfStream = False
                '	NumberOfLines = NumberOfLines + 1
                '	FileContent.ReadLine()
                'Loop 
                'FileContent.close()
                'FileContent = Nothing
    			
                ' Create an instance of StreamReader to read from a file.
                Dim sr As StreamReader = New StreamReader(sPath, Encoding.Default)
                Dim strLine As String = ""
                ' Read and display the lines from the file until the end 
                ' of the file is reached.
                
                Do
                    strLine = sr.ReadLine()
                    If strLine <> "" Then
                        NumberOfLines = NumberOfLines + 1
                    End If
                Loop While strLine <> ""
                sr.Close()
    			
                If NumberOfLines > 0 Then
                    Response.Write(Translate.Translate("Importere %% modtagere.", "%%", NumberOfLines.ToString))
                Else
                    Response.Write(Translate.Translate("Filen Indeholder ingen modtagere"))
                End If
            End If
    		
            'fso = Nothing
            If NumberOfLines > 0 Then
                Response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & "<!--" & vbNewLine & "parent.document.getElementById(""StatusFrame"").setAttribute(""src"", ""NewsletterExtended_recipient_import.aspx?NewsletterRecipientCategoryID=" & NewsletterRecipientCategoryID & "&ImportFile=" & ImportFile & "&ImportFileEncoding=" & ImportFileEncoding & "&NumberOfLines=" & NumberOfLines & "&NewsletterRecipientFormat=" & NewsletterRecipientFormat & """);" & vbNewLine & "//-->" & vbNewLine & "</SCRIPT>")
            End If
        ElseIf CInt(ImPortingType) = 2 Then
            'sql = "SELECT COUNT(NewsletterRecipientID) as NumberOfLines FROM NewsletterRecipient WHERE ', ' + NewsletterRecipientCategoryID + ',' LIKE '%" & NewsletterList & ",%'"
            sql = "SELECT COUNT(NewsletterRecipientID) as NumberOfLines FROM NewsletterRecipient WHERE " & _
            "NewsletterRecipientCategoryID LIKE '" & NewsletterList & "' " & _
            "OR NewsletterRecipientCategoryID LIKE '" & NewsletterList & ",%' " & _
            "OR NewsletterRecipientCategoryID LIKE '%," & NewsletterList & ",%' " & _
            "OR NewsletterRecipientCategoryID LIKE '% " & NewsletterList & ",%' " & _
            "OR NewsletterRecipientCategoryID LIKE '%, " & NewsletterList & "' " & _
            "OR NewsletterRecipientCategoryID LIKE '%," & NewsletterList & "'"
    	
            cmdNewsletter.CommandText = sql
            Dim dr As IDataReader = cmdNewsletter.ExecuteReader()
            If dr.Read Then
                NumberOfLines = Base.ChkNumber(dr("NumberOfLines").ToString())
            End If
            Response.Write(Translate.Translate("Initierer import af %n% %%.", "%n%", NumberOfLines.ToString, "%%", Translate.Translate("modtager")))
            Response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & "<!--" & vbNewLine & "parent.document.getElementById(""StatusFrame"").setAttribute(""src"", ""NewsletterExtended_recipient_importDB.aspx?NewsletterRecipientCategoryID=" & NewsletterRecipientCategoryID & "&NewsletterList=" & NewsletterList & "&NumberOfLines=" & NumberOfLines & "&NewsletterRecipientFormat=" & NewsletterRecipientFormat & """);" & vbNewLine & "//-->" & vbNewLine & "</SCRIPT>")
            'response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & "<!--" & vbNewLine & "location = ""NewsletterExtended_recipient_importDB.aspx?NewsletterRecipientCategoryID=" & NewsletterRecipientCategoryID & "&NewsletterList=" & NewsletterList & "&NumberOfLines=" & NumberOfLines & "&NewsletterRecipientFormat=" & NewsletterRecipientFormat & """;" & vbNewLine & "//-->" & vbNewLine & "</SCRIPT>")
            dr.Dispose()
        End If
    Else
        sql = "SELECT Count(NewsletterCategoryRecipientRecipientID) as NumberOfLines FROM (SELECT DISTINCT NewsletterCategoryRecipientRecipientID FROM NewsletterExtendedCategoryRecipient WHERE NewsletterCategoryRecipientCategoryID IN (" & NewsletterRecipientCategoryID & ")) a"
        cmdNewsletterExtended.CommandText = sql
        Dim dr As IDataReader = cmdNewsletterExtended.ExecuteReader()
        If dr.Read Then
            NumberOfLines = Base.ChkNumber(dr("NumberOfLines").ToString())
        End If
        Response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & "<!--" & vbNewLine & "parent.document.getElementById(""StatusFrame"").setAttribute(""src"", ""NewsletterExtended_recipient_export.aspx?NewsletterRecipientCategoryID=" & NewsletterRecipientCategoryID & "&NumberOfLines=" & NumberOfLines & """);" & vbNewLine & "//-->" & vbNewLine & "</SCRIPT>")
        dr.Dispose()
    End If

    cmdNewsletter.Dispose()
    cmdNewsletterExtended.Dispose()
    cnNewsletter.Dispose()
    cnNewsletterExtended.Dispose()

%>
</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
