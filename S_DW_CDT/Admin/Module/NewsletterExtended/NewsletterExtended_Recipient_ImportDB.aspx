<%@ Page CodeBehind="NewsletterExtended_Recipient_ImportDB.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_ImportDB" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.IO" %>

<%
Response.Buffer = True
	Dim cStatusBar As New StatusBar
	Dim NumberOfLines As String
	Dim NoRecipinetInvalid As Integer
	Dim NoRecipinet As Integer
	
Dim i As Integer
		Dim counter As Integer
		Dim NewsletterRecipientID As Integer
		Dim NewsletterRecipientCategoryID As String
		Dim NewsletterRecipientFormat As Integer
		Dim NewsletterList As String

		Dim dato As New Dates
		Dim SQLRecipient As String
		Dim arrNewsletterRecipientCategoryID() As String
		Dim SQL As String

		Dim RecipinetEmail As String
		Dim RecipientPassword As String
		Dim RecipientName As String
		Dim RecipientMailFormat As String
	

		Dim cnNewsletter As IDbConnection = Database.CreateConnection("Newsletter.mdb")
		Dim cmdNewsletter As IDbCommand = cnNewsletter.CreateCommand

		Dim cnNewsletterExtended As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
		Dim cmdNewsletterExtended As IDbCommand = cnNewsletterExtended.CreateCommand
		Dim dsNewsletterExtended As DataSet = New DataSet
		Dim daNewsletterExtended As IDbDataAdapter = Database.CreateAdapter()
		daNewsletterExtended.SelectCommand = cmdNewsletterExtended
		Dim dtNewsletterExtended As DataTable
		Dim row As DataRow
NoRecipinetInvalid = 0
		NoRecipinet = 0
		NumberOfLines = Request.Item("NumberOfLines")
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</head>
<body bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0 style="background-color:#ECE9D8;margin:0px;">
<br>
<%
cStatusBar = New StatusBar()
cStatusBar.Value = 0
cStatusBar.MaxValue = NumberOfLines
cStatusBar.Name = "Statusbar"
Response.Write(cStatusBar.Render())
Response.Flush()
%>

			<div id="StatusText"></div>
		<%
		Response.Flush()
		Response.Flush()

		

		NewsletterRecipientCategoryID = Request.Item("NewsletterRecipientCategoryID")
		NewsletterRecipientFormat = Base.ChkNumber(Request.Item("NewsletterRecipientFormat"))
		
		NewsletterList = Request.Item("NewsletterList")
		'		Eneste(tal)
		'9

		'		Første(tal)
		'9,*

		'		i(rækken)
		'*,9,*
		'* 9,*

		'		Sidste(tal)
		'*, 9
		'*,9
		SQLRecipient = "SELECT * FROM NewsletterRecipient WHERE " & _
		"NewsletterRecipientCategoryID LIKE '" & NewsletterList & "' " & _
		"OR NewsletterRecipientCategoryID LIKE '" & NewsletterList & ",%' " & _
		"OR NewsletterRecipientCategoryID LIKE '%," & NewsletterList & ",%' " & _
		"OR NewsletterRecipientCategoryID LIKE '% " & NewsletterList & ",%' " & _
		"OR NewsletterRecipientCategoryID LIKE '%, " & NewsletterList & "' " & _
		"OR NewsletterRecipientCategoryID LIKE '%," & NewsletterList & "'"

		cmdNewsletter.CommandText = SQLRecipient
		'Base.w(SQLRecipient)
		Dim drRecipient As IDataReader = cmdNewsletter.ExecuteReader()

		counter = 0

		'Ordinal Values
		Dim intNewsletterRecipientEmail As Integer = drRecipient.GetOrdinal("NewsletterRecipientEmail")
		Dim intNewsletterRecipientName As Integer = drRecipient.GetOrdinal("NewsletterRecipientName")
		Dim intNewsletterRecipientFormat As Integer = drRecipient.GetOrdinal("NewsletterRecipientFormat")
		Dim strNewsletterRecipientCreated As String = dato.DWNow()

		    Do While drRecipient.Read()
		        counter = counter + 1
		        If counter Mod 20 = 0 Then
		            Response.Write(cStatusBar.Increase())
		            Response.Flush()
		        End If
		        If Base.ValidateEmail(drRecipient(intNewsletterRecipientEmail).ToString) Then

		            Dim NewsletterRecipientEmail As String = drRecipient(intNewsletterRecipientEmail).ToString()
		            Dim NewsletterRecipientCreated As String = strNewsletterRecipientCreated
		            Dim NewsletterRecipientName As String = Database.SqlEscapeInjection(drRecipient(intNewsletterRecipientName).ToString())
		            Dim NewsletterRecipientPassword As String = ""
		            If drRecipient(intNewsletterRecipientFormat).ToString() = "txt" Then
		                NewsletterRecipientFormat = 1
		            Else
		                NewsletterRecipientFormat = 2
		            End If
		            Dim mySQL As String = "SELECT NewsletterRecipientID FROM NewsletterExtendedRecipient WHERE NewsletterRecipientEmail = '" & drRecipient(intNewsletterRecipientEmail).ToString & "'"
		            NewsletterRecipientID = Base.ChkNumber(Database.ExecuteScalar(mySQL, "NewsletterExtended.mdb"))
		            If NewsletterRecipientID = 0 Then               'User does not exists
		                cmdNewsletterExtended.CommandText = "INSERT INTO NewsletterExtendedRecipient (NewsletterRecipientEmail, NewsletterRecipientCreated, NewsletterRecipientName, NewsletterRecipientPassword, NewsletterRecipientFormat, NewsletterRecipientConfirmed) " & _
		                   "VALUES('" & NewsletterRecipientEmail & "', '" & NewsletterRecipientCreated & "', '" & NewsletterRecipientName & "', '" & NewsletterRecipientPassword & "', '" & NewsletterRecipientFormat & "', -1)"
		                cmdNewsletterExtended.ExecuteNonQuery()
		                NewsletterRecipientID = Base.ChkNumber(Database.GetAddedIdentityKey(cnNewsletterExtended))
		            End If
		            If NewsletterRecipientCategoryID <> "" And Not NewsletterRecipientCategoryID = "0" Then
		                NewsletterRecipientCategoryID = Replace(NewsletterRecipientCategoryID, ", ", ",")
		                arrNewsletterRecipientCategoryID = Split(NewsletterRecipientCategoryID, ",")
		                For i = 0 To UBound(arrNewsletterRecipientCategoryID)
		                    SQL = " INSERT INTO NewsletterExtendedCategoryRecipient (NewsletterCategoryRecipientRecipientID, NewsletterCategoryRecipientType, NewsletterCategoryRecipientCategoryID) " & " VALUES (" & NewsletterRecipientID & ", 1, " & arrNewsletterRecipientCategoryID(i) & ")"
		                    cmdNewsletterExtended.CommandText = SQL
		                    cmdNewsletterExtended.ExecuteNonQuery()
		                Next
		            End If

		            NoRecipinet = NoRecipinet + 1
		        Else
		            NoRecipinetInvalid = NoRecipinetInvalid + 1
		        End If
		    Loop

		cmdNewsletterExtended.Dispose()
		cmdNewsletter.Dispose()
		cnNewsletter.Dispose()
		cnNewsletterExtended.Dispose()


%>
</div>
</body>
</html>

<SCRIPT LANGUAGE="JavaScript">
<!--
parent.updateinfo("Total: <%=NoRecipinet%>/<%=NumberOfLines%> - Invalid: <%=NoRecipinetInvalid%>")
parent.document.getElementById("ListRight").setAttribute("src", "NewsletterExtended_Blank.html");
t = setTimeout("document.location = 'NewsletterExtended_Blank_with_color.html'", 5000);

//-->
</SCRIPT>
<%
Translate.GetEditOnlineScript()
%>