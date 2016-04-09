<%@ Page CodeBehind="NewsletterExtended_Preview_File.aspx.vb" Language="vb" AutoEventWireup="false" ValidateRequest="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Preview_File" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="aspNetEmail" %>


<%
Dim NewsletterContentText As String
Dim NewsletterStylesheetID As String
Dim NewsletterContent As String
Dim bgColor As String
Dim FileHome As String = "\files\" & Dynamicweb.Content.Management.Installation.FilesFolderName.ToLower()  
Dim TestEmailAddress As String
Dim NewsletterID As String
Dim strPath As String
Dim strUserFieldSQL As String
Dim SQLCatID As String
Dim strUserFieldData As String
Dim strAccessUserID As String
Dim SQLNewsletter As String
Dim SQLRecipient As String
Dim CategoryID As String
Dim EndIndex As Double
Dim CurrentLinkTemp As Object
Dim CurrentLink As Object
Dim StartIndex As Double
Dim ParsedContent As String

NewsletterID = Request.Item("NewsletterID")
TestEmailAddress = "test@dynamicsystems.dk"'Request.Item("TestEmailAddress")
Dim newsletterParser As New Dynamicweb.Admin.NewsletterExtended(true)

Dim dato As New Dates

Dim cn As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmd As IDbCommand = cn.CreateCommand

Dim cnNewsletterExtended As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletterExtended As IDbCommand = cnNewsletterExtended.CreateCommand
Dim dsNewsletterExtended As DataSet = New DataSet
Dim daNewsletterExtended As IDbDataAdapter = Database.CreateAdapter()
daNewsletterExtended.SelectCommand = cmdNewsletterExtended
Dim dtNewsletterExtended As DataTable
Dim rowNewsletterExtended As DataRow

NewsletterID = Request.Item("NewsletterID")

SQLCatID = " SELECT NewsLetterCategoryLetterCategoryID FROM NewsletterExtendedCategoryLetter Where NewsLetterCategoryLetterLetterID = " & NewsletterID
cmd.CommandText = SQLCatID
CategoryID = cmd.ExecuteScalar().ToString()

SQLNewsletter = " SELECT * FROM NewsletterExtended WHERE NewsletterID = " & NewsletterID
cmdNewsletterExtended.CommandText = SQLNewsletter
daNewsletterExtended.Fill(dsNewsletterExtended)
dtNewsletterExtended = dsNewsletterExtended.Tables(0)
rowNewsletterExtended = dtNewsletterExtended.Rows(0)

bgColor = ""
bgColor = newsletterParser.GetStyleSheet(Base.ChkNumber(rowNewsletterExtended("NewsletterStylesheetID").ToString()))

Dim cnRecipient As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdRecipient As IDbCommand = cnRecipient.CreateCommand

If newsletterParser.HasCustomRecipientList(Base.ChkNumber(NewsletterID)) Then
            SQLRecipient = newsletterParser.GetCustomRecipientList(Base.ChkNumber(NewsletterID))
Else
	  SQLRecipient = "SELECT TOP 1 * FROM NewsletterExtendedRecipient"
            'SQLRecipient = " SELECT * " & " FROM NewsletterExtendedRecipient " & _
            '  " WHERE  NewsletterRecipientFormat = '2' And newsletterRecipientid IN (SELECT DISTINCT NewsletterCategoryRecipientRecipientID " & _
            '  " FROM NewsletterExtendedCategoryRecipient " & _
            '  " WHERE NewsletterCategoryRecipientCategoryID IN (select NewsletterCategoryLetterCategoryID " & _
            '  " FROM NewsletterExtendedCategoryLetter " & _
            '  " WHERE NewsletterCategoryLetterLetterID = " & NewsletterID & "))  "
End If
	
'we SQLRecipient
cmdRecipient.CommandText = SQLRecipient
Dim drRecipient As IDataReader = cmdRecipient.ExecuteReader()

strAccessUserID = "0"

If drRecipient.Read() Then

    If IsNumeric(drRecipient("NewsletterAccessUserID").ToString()) And Not drRecipient("NewsletterAccessUserID").ToString() = "0" Then

    Else

		If rowNewsletterExtended("NewsletterStylesheetID").ToString() <> "" And IsNumeric(rowNewsletterExtended("NewsletterStylesheetID").ToString()) Then
			NewsletterStylesheetID = rowNewsletterExtended("NewsletterStylesheetID").ToString()
		Else
			NewsletterStylesheetID = "1"
		End If

		newsletterParser.ReplaceTags(NewsletterContent, NewsletterContentText, rowNewsletterExtended, drRecipient, CategoryID, NewsletterStylesheetID, bgColor)

		strUserFieldSQL = "SELECT * FROM NewsletterExtendedUserField"
		cmd.CommandText = strUserFieldSQL
		
		Dim drUserField As IDataReader = cmd.ExecuteReader()
        Dim cnUserFieldData As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
        Dim cmdUserFieldData As IDbCommand = cnUserFieldData.CreateCommand

        Do While drUserField.Read()
            If drUserField("NewsletterUserFieldType").ToString() = "TextInput" Then
                NewsletterContent = Replace(NewsletterContent, "<!--@DW" & drUserField("NewsletterUserFieldSystemName").ToString() & "-->", drRecipient("NewsletterCustomField_" & drUserField("NewsletterUserFieldSystemName").ToString()).ToString() & "")
            Else
                strUserFieldData = "SELECT * FROM NewsletterExtendedUserFieldData WHERE NewsletterUserFieldID = " & drUserField("NewsletterUserFieldID").ToString() & " AND NewsletterRecipientID = " & drRecipient("NewsletterRecipientID").ToString()

                cmdUserFieldData.CommandText = strUserFieldData
                Dim drUserFieldData As IDataReader = cmdUserFieldData.ExecuteReader()
                If drUserFieldData.Read() Then
                    NewsletterContent = Replace(NewsletterContent, "<!--@DW" & drUserField("NewsletterUserFieldSystemName").ToString() & "-->", drUserFieldData("NewsletterUserFieldData").ToString() & "")
                End If

                drUserFieldData.Close()
            End If
        Loop

        drUserField.Close()
        drUserField.Dispose()
        cmdUserFieldData.Dispose()
        cnUserFieldData.Close()
        cnUserFieldData.Dispose()

		cn.Dispose()
		cmd.Dispose()
		
		strPath = FileHome & "\" & "mailtest" & NewsletterID & ".txt"
		
		'Dim sw As System.IO.StreamWriter = New System.IO.StreamWriter(Server.Mappath(strPath), False, System.Text.Encoding.Default)          
		If Replace(RTrim(LTrim(NewsletterContentText)), vbTab, "") <> "" Then
			Base.WriteTextFile(NewsletterContentText, Server.Mappath(strPath), false)
		'	sw.Write(NewsletterContentText)
        Else
			Base.WriteTextFile(Base.StripHTML(NewsletterContent), Server.Mappath(strPath), false)
		'	sw.Write(Base.StripHTML(NewsletterContent))
		End If
        'sw.Close()		
		
	End If

End If

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
window.open('../../Public/Download.aspx?File=<%=Replace(Replace(strPath, "\", "/"), "/files", "")%>', "Preview", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=1,height=1,top=2000,left=2000");
document.location = "NewsletterExtended_letter_body_Preview.aspx?ID=<%=NewsletterID%>&Tab=Tab2"
//-->
</SCRIPT>
