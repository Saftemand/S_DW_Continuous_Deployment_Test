<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Page Language="vb" debug="true" trace="false" validateRequest="false" AutoEventWireup="false" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>

<%
Dim dato As New Dates
Dim CurrentHourStr As String
Dim SQLTopLinkHour As String
Dim AntalBruger As Double
Dim Mymonth As String
Dim intCounter As Byte
Dim StartIndex As Integer
Dim SQLLinksTotal As String
Dim SQLOpenStdInfo As String
Dim Top5Counter As Integer
Dim Myday As String
Dim CurrentHour As Byte
Dim HourSqlDatePart As String
Dim SQLClickAmontLast5 As String
Dim SQLOpenAmontLast5 As String
Dim ShortLink As String
Dim SQLClickLast5 As String
Dim CurrrentHour As Byte
Dim dwgFrontStatistics As New Graph
Dim SQLClickTop5Links As String
Dim ClicksTotal As Object
Dim LinksTotal As Object
Dim SQLOpenLast5 As String
Dim SQLClicksTotal As String
Dim drLast5 As IDataReader 
Dim blnDrLast5HasRows As Boolean
Dim DWsqlmode As String = CStr(Base.GetGs("/Globalsettings/System/Database/Type"))
Dim tmpDate As String
Dim tmpDay As String
Dim myGraph As New Graph2
Dim ShowSettings As Boolean = true
Dim objStatistic As New Statistic
objStatistic.StatInitializeWhere

Dim strStatsForLastAmountDays As String = "" & DateDiff("D", objStatistic.Statv2SettingsFrom, objStatistic.Statv2SettingsTo) + 1
%>

<!-- #INCLUDE FILE="Statisticsv2_Report_Common.aspx" -->
<%
Dim NewsletterID As String = Base.ChkNumber(Request.Item("ID"))
'''' Stats '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

If DWsqlmode = "ms_sqlserver" Then
	SQLOpenAmontLast5 = "SET DATEFIRST 7 " & vbnewline
End If

Dim strSQLDateFrom As String = Request.Item("Statv2From_year") & "-" & Request.Item("Statv2From_month") & "-" & Request.Item("Statv2From_day")
Dim strSQLDateTo As String = Request.Item("Statv2To_year") & "-" & Request.Item("Statv2To_month") & "-" & Request.Item("Statv2To_day") & " 23:59:59"
Dim strSQLDate As String = " NewsletterStatHitsCreated BETWEEN " & Database.SqlDate(strSQLDateFrom) & " AND " & Database.SqlDate(strSQLDateTo)

SQLClickAmontLast5 =" SELECT TOP 100	DatePart(""yyyy"",NewsletterStatHitsCreated) AS myYear, " & _
					"				DatePart(""m"",NewsletterStatHitsCreated) AS myMonth, " & _
					"				DatePart(""d"",NewsletterStatHitsCreated) AS myDay, " & _
					"				DatePart(""w"",NewsletterStatHitsCreated) AS myWeekDay, " & _
					"				Count(NewsletterExtendedStatHits.NewsletterStatHitsID) AS number1 " & _
					" FROM 		NewsletterExtendedStatHits  " & _
					" INNER JOIN	NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID " & _
					" WHERE			NewsletterExtendedStatHits.NewsletterStatHitsType = 1 AND " & strSQLDate & _
					" GROUP BY		DatePart(""yyyy"",NewsletterStatHitsCreated), " & _
					"				DatePart(""m"",NewsletterStatHitsCreated), " & _
					"				DatePart(""d"",NewsletterStatHitsCreated), " & _
					"				DatePart(""w"",NewsletterStatHitsCreated), " & _
					"				NewsletterExtendedStat.NewsletterStatLetterID " & _
					" HAVING		NewsletterExtendedStat.NewsletterStatLetterID = " & NewsletterID & _
					" ORDER BY		DatePart(""yyyy"",NewsletterStatHitsCreated) DESC , " & _
					"				DatePart(""m"",NewsletterStatHitsCreated) DESC , " & _
					"				DatePart(""d"",NewsletterStatHitsCreated) DESC "

SQLClickLast5 = "SELECT TOP 50 NewsletterExtendedStatHits.NewsletterStatHitsUserID, NewsletterExtendedStatHits.NewsletterStatHitsCreated, NewsletterExtendedRecipient.NewsletterRecipientName, NewsletterExtendedRecipient.NewsletterRecipientEmail, NewsletterExtendedStat.NewsletterStatLink FROM NewsletterExtendedRecipient, NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID WHERE			NewsletterRecipientID = NewsletterStatHitsUserID AND " & "				NewsletterStatHitsStatID IN (	Select NewsletterStatID  " & "												FROM NewsletterExtendedStat  " & "												Where  NewsletterStatLetterID = " & NewsletterID & ") AND  " & "				NewsletterStatHitsType = 1 AND " & strSQLDate & " ORDER BY NewsletterStatHitsCreated desc "


'SQLOpenStdInfo = " select	NewsletterSmtpServer,  " & "			NewsletterRecipientCount,  " & "			NewsletterSentType,  " & "			NewsletterSendCreated,  " & "			(SELECT COUNT(NewsletterStatHitsID) as OpenAmount " & " FROM		NewsletterExtendedStatHits  " & " WHERE		NewsletterStatHitsType = 2 AND  " & "			NewsletterStatHitsStatID IN (	SELECT NewsletterStatID  " & "											FROM NewsletterExtendedStat  " & "											WHERE NewsletterStatLetterID = " & NewsletterID & ")) as OpenAmount " & " from		NewsletterExtended  " & " where		NewsletterID = " & NewsletterID
SQLOpenStdInfo =	"SELECT NewsletterSmtpServer, NewsletterRecipientCount, NewsletterSentType, NewsletterSendCreated, (SELECT Count(NewsletterStatHitsID) AS OpenAmount " & _
					"FROM NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID=NewsletterExtendedStat.NewsletterStatID " & _
					"WHERE NewsletterExtendedStatHits.NewsletterStatHitsType=2 And NewsletterExtendedStat.NewsletterStatLetterID=" & NewsletterID & ") AS OpenAmount " & _
					"FROM NewsletterExtended WHERE NewsletterID=" & NewsletterID

SQLClickTop5Links = " SELECT TOP 10	NewsletterStatLink , COUNT(NewsletterStatID) AS ClickAmount" & " FROM			NewsletterExtendedStat, NewsletterExtendedStatHits " & " WHERE			NewsletterStatID = NewsletterStatHitsStatID AND  " & "				NewsletterStatHitsType = 1 AND  " & "				NewsletterStatLetterID = " & NewsletterID & " AND " & strSQLDate & "   GROUP BY		NewsletterStatLink " & " ORDER BY		COUNT(NewsletterStatID) DESC"
'throw new exception(SQLClickTop5Links)
SQLClicksTotal = " select COUNT(NewsletterStatID) AS ClicksTotal " & " FROM NewsletterExtendedStat, NewsletterExtendedStatHits " & " where NewsletterStatLetterID = " & NewsletterID & "		AND NewsletterStatHitsStatID = NewsletterStatID AND NewsletterStatHitsType = 1"

SQLLinksTotal = " select COUNT(NewsletterStatID) AS LinksTotal " & " FROM NewsletterExtendedStat " & " where NewsletterStatLetterID = " & NewsletterID & " AND NewsletterStatLink NOT LIKE 'Open Mail'"

HourSqlDatePart = Database.SqlDatePart("hour")

SQLTopLinkHour =	" SELECT DatePart(" & Database.SqlDatePart("hour") & ",NewsletterStatHitsCreated) AS myHour, Count(NewsletterExtendedStatHits.NewsletterStatHitsID) AS number1 " & _
					" FROM NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID " & _
					" WHERE NewsletterExtendedStatHits.NewsletterStatHitsType = 1 AND " & strSQLDate & _
					" GROUP BY DatePart(" & Database.SqlDatePart("hour") & ",NewsletterStatHitsCreated), NewsletterExtendedStat.NewsletterStatLetterID " & _
					" HAVING NewsletterExtendedStat.NewsletterStatLetterID = " & NewsletterID & _
					" ORDER BY DatePart(" & Database.SqlDatePart("hour") & ",NewsletterStatHitsCreated) "

Dim cnStatistics As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdStatistics As IDbCommand = cnStatistics.CreateCommand

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function hide(strDiv)
{
	document.getElementById(strDiv + "open").style.display= 'none'
	document.getElementById(strDiv + "close").style.display= 'block'
	document.getElementById(strDiv + "open").outerHTML = document.getElementById(strDiv + "open").outerHTML
	document.getElementById(strDiv + "close").outerHTML = document.getElementById(strDiv + "close").outerHTML

}

function unhide(strDiv)
{
	document.getElementById(strDiv + "open").style.display= 'block'
	document.getElementById(strDiv + "close").style.display= 'none'
	document.getElementById(strDiv + "open").outerHTML = document.getElementById(strDiv + "open").outerHTML
	document.getElementById(strDiv + "close").outerHTML = document.getElementById(strDiv + "close").outerHTML

}

function RecipientStats(strRecipientID) {
	recipientwin = window.open ('Report_Letter_Recipient.aspx?RecipientID=' + strRecipientID, 'newwindow', config='height=500, width=715, toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no')
	recipientwin.focus();
}
//-->
</SCRIPT>


<!-- TAB3 ------------------------------------------------------------------------------------------------------------------------------- -->
<div ID="Tab3">
<td valign="top">
	<table width="512">
	<tr>
		<td valign='top' rowspan='4'><img src='/Admin/Images/Icons/Statv2_Report_heading.gif' width='32' height='36' alt='' border='0'></td>
	</tr>
	<tr>
				<td width="402"><strong style="color:#003366;"><%=Translate.Translate("Standard Info")%></strong></td>
				<td align="right" style="width:75px;"></td>
	</tr>
	<tr>
				<td style="background-color:#CCCCCC;height:1px;width:100%" colspan="2"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
				<td colspan="2">
										<%
Response.Write(("<table width='100%'>"))
cmdStatistics.CommandText = SQLLinksTotal
LinksTotal = cmdStatistics.ExecuteScalar()
cmdStatistics.CommandText = SQLClicksTotal
ClicksTotal = cmdStatistics.ExecuteScalar()
cmdStatistics.CommandText = "SELECT NewsletterRecipientCount FROM NewsletterExtended WHERE NewsletterID =" & NewsletterID
AntalBruger = cmdStatistics.ExecuteScalar()


If isNumeric(ClicksTotal) And isNumeric(LinksTotal) Then
	'										If LinksTotal = 0 Then 
	'											LinksTotal = 1
	'										End If
	'										If ClicksTotal = 0 Then 
	'											ClicksTotal =1
	'										End If
	'										If Base.ChkNumber(AntalBruger) = 0 Then 
	'											AntalBruger= 1
	'										End If
	Response.Write(("<tr><TD>" & Translate.Translate("Total antal Clicks") & "</td><td align='right'>" & ClicksTotal & "</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	If ClicksTotal = 0 Or AntalBruger = 0 Then
		Response.Write(("<tr><TD>" & Translate.Translate("Gns. Clicks per bruger") & "</td><td align='right'>0</td></tr>"))
	Else
		Response.Write(("<tr><TD>" & Translate.Translate("Gns. Clicks per bruger") & "</td><td align='right'>" & FormatNumber(ClicksTotal / AntalBruger, 2) & "</td></tr>"))
	End If
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Antal Links per mail") & "</td><td align='right'>" & LinksTotal & "</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	If ClicksTotal = 0 Or AntalBruger = 0 Or LinksTotal = 0 Then
		Response.Write(("<tr><TD>" & Translate.Translate("Gns. clicks per link") & "</td><td align='right'>0</td></tr>"))
	Else
		Response.Write(("<tr><TD>" & Translate.Translate("Gns. clicks per link") & "</td><td align='right'>" & FormatNumber(ClicksTotal / LinksTotal / AntalBruger, 2) & "</td></tr>"))
	End If
	
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	'Response.Write(("<tr><TD>&nbsp;" & "</td><td align='right'>" & "</td></tr>"))
	'Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	
End If
Response.Write(("</table>"))
%>
				</td>
								</tr>
							</table>
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
	</td>
					</TR>
	<tr>
		<td><br>
		</td>
	</tr>
<!-- 
<td valign="top">
									<table width=512>
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Antal links åbnet i perioden")%></strong></td>
		<td align=right style="width:75px;"></td>
	</tr>
	<tr>
		<td style="background-color:#CCCCCC;height:1px;width:100%" colspan=2></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan=2>
		<!--
	            <iframe border="0" name="GraphFrame" align="left" marginWidth="0" marginHeight="0" src="Report_Letter_Graph_Click.aspx?NewsletterID=<%=NewsletterID%>&DaysSince=<%=strStatsForLastAmountDays%>" frameBorder="0" width="100%" scrolling="no" height="350">
    	        </iframe>
		-->
		<%
'	          myGraph = New Graph2
'	myGraph.BarFill = objStatistic.Statv2SettingsFillbar
'	Dim selectQuery As String = " SELECT     NewsletterExtendedStat.NewsletterStatID, NewsletterExtendedStat.NewsletterStatLink," & _
'							" COUNT(NewsletterExtendedStat.NewsletterStatID) AS Hits" & _
'							" FROM         NewsletterExtendedStat INNER JOIN" & _
'							" NewsletterExtendedStatHits ON NewsletterExtendedStat.NewsletterStatID = NewsletterExtendedStatHits.NewsletterStatHitsStatID" & _
'							" GROUP BY NewsletterExtendedStat.NewsletterStatID, NewsletterExtendedStat.NewsletterStatLetterID," & _
'							" NewsletterExtendedStat.NewsletterStatLink, NewsletterExtendedStat.NewsletterStatID, " & _
'							" NewsletterExtendedStatHits.NewsletterStatHitsType" & _
'							" HAVING      (NewsletterExtendedStat.NewsletterStatLetterID = " & newsletterID & ") AND (COUNT(NewsletterExtendedStat.NewsletterStatID) > 10) " & _
'							" AND (NewsletterExtendedStatHits.NewsletterStatHitsType = 1) " & _
'							" ORDER BY Hits DESC, NewsletterExtendedStat.NewsletterStatLink "
'
'
'
''"SELECT NewsletterExtendedStat.NewsletterStatID, NewsletterExtendedStat.NewsletterStatLink FROM NewsletterExtendedStat INNER JOIN NewsletterExtendedStatHits ON NewsletterExtendedStat.NewsletterStatID = NewsletterExtendedStatHits.NewsletterStatHitsStatID GROUP BY NewsletterExtendedStat.NewsletterStatID, NewsletterExtendedStat.NewsletterStatLetterID, NewsletterExtendedStat.NewsletterStatLink, NewsletterExtendedStat.NewsletterStatID, NewsletterExtendedStatHits.NewsletterStatHitsType             HAVING(((NewsletterExtendedStat.NewsletterStatLetterID) = " & NewsletterID & ") And ((Count(NewsletterExtendedStat.NewsletterStatID)) > 10) And ((NewsletterExtendedStatHits.NewsletterStatHitsType) = 1)) ORDER BY NewsletterExtendedStat.NewsletterStatLink;" '"SELECT DatePart(" & Database.SqlDatePart("Year") & ",[NewsletterStatHitsCreated]) AS [Year], DatePart(" & Database.SqlDatePart("Month") & ",[NewsletterStatHitsCreated]) AS [Month], DatePart(" & Database.SqlDatePart("day") & ",[NewsletterStatHitsCreated]) AS [Day], Count(NewsletterExtendedStatHits.NewsletterStatHitsID) AS Count FROM NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID WHERE NewsletterExtendedStat.NewsletterStatLetterID =" & NewsletterID & " AND ((NewsletterExtendedStatHits.NewsletterStatHitsType)=2) GROUP BY DatePart(" & Database.SqlDatePart("year") & ",[NewsletterStatHitsCreated]),DatePart(" & Database.SqlDatePart("month") & ",[NewsletterStatHitsCreated]), DatePart(" & Database.SqlDatePart("day") & ",NewsletterStatHitsCreated) ORDER BY DatePart(" & Database.SqlDatePart("year") & ",NewsletterStatHitsCreated),DatePart(" & Database.SqlDatePart("month") & ",NewsletterStatHitsCreated), DatePart(" & Database.SqlDatePart("day") & ",NewsletterStatHitsCreated); "
''throw new exception(selectQuery)
'cmdStatistics.CommandText = selectQuery
'drLast5 = cmdStatistics.ExecuteReader()
'
'Do While drLast5.Read()
'	If Not blnDrLast5HasRows Then
'			blnDrLast5HasRows = true
'		End If
'		StartIndex = InStrRev(drLast5("NewsletterStatLink").ToString(), "/")
'		ShortLink = "<A Href=""" & drLast5("NewsletterStatLink").ToString() & """ TARGET=""_Blank"">" & Mid(drLast5("NewsletterStatLink").ToString(), StartIndex + 1, 20) & "</A>"
'		If Len(ShortLink) < 21 Then
'			ShortLink = ShortLink & "..."
'		End If
'	myGraph.SetBarValue(ShortLink, Base.ChkValue(drLast5("Hits").ToString()))
'Loop 

'drLast5.Close()

'Response.Write(myGraph.Output)
	          
	          %>
		<!--
										
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
			
						</TD>
					</TR>
					
					<tr><td><br></td></tr>		
					-->						
			<td valign="top">
		<table width="512">
	<tr>
				<td valign="top" rowspan="4"><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt=""
						border="0"></td>
	</tr>
	<tr>
				<td width="402"><strong style="color:#003366;"><%=Translate.Translate("Top 10 Links")%></strong></td>
				<td align="right" style="width:75px;"></td>
	</tr>
	<tr>
				<td style="background-color:#CCCCCC; height:1px; width:100%" colspan="2"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
				<td colspan="2">
										<%
cmdStatistics.CommandText = SQLClickTop5Links
drLast5 = cmdStatistics.ExecuteReader()

myGraph = New Graph2
myGraph.BarFill = objStatistic.Statv2SettingsFillbar



blnDrLast5HasRows = false
	Do While drLast5.Read()
		If Not blnDrLast5HasRows Then
			blnDrLast5HasRows = true
		End If
		StartIndex = InStr(drLast5("NewsletterStatLink").ToString(), "/")+1
		ShortLink = "<A Href=""" & drLast5("NewsletterStatLink").ToString() & """ TARGET=""_Blank"">" & Mid(drLast5("NewsletterStatLink").ToString(), StartIndex + 1, 20) & "</A>"
		If Len(ShortLink) < 21 Then
			ShortLink = ShortLink & "..."
		End If
		'dwgFrontStatistics.AddBar("<td title='" & drLast5("NewsletterStatLink").ToString() & "'>" & ShortLink & "</TD>", drLast5("ClickAmount").ToString())
	myGraph.SetBarValue(ShortLink, drLast5("ClickAmount").ToString())		
	Loop 
If Not blnDrLast5HasRows Then
	Response.Write((Translate.Translate("Ingen data")))
End If

drLast5.Close()
'dwgFrontStatistics.Draw()
Response.Write(myGraph.Output)

%>
				</td>
			</tr>
							</table>
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
	</td>
					</TR>
					<!-- Make space --->
	<tr>
		<td><br></td>
	</tr>
					<TR>
						<td valign="top">
			<table width="512">
	<tr>
					<td valign="top" rowspan="4"><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
					<td width="402"><strong style="color:#003366;"><%=Translate.Translate("Åbnede links de sidste %% dage", "%%", strStatsForLastAmountDays)%></strong></td>
					<td align="right" style="width:75px;"></td>
	</tr>
	<tr>
					<td style="background-color:#CCCCCC;height:1px;width:100%" colspan="2"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
					<td colspan="2">
										<%
Response.Write(("<table width='100%'>"))

intCounter = 0
cmdStatistics.CommandText = SQLClickLast5
drLast5 = cmdStatistics.ExecuteReader()

blnDrLast5HasRows = false
	
Do While drLast5.Read()
	If Not blnDrLast5HasRows Then
			blnDrLast5HasRows = true
	End If
	Dim link as string = Base.ChkString(drLast5("NewsletterStatLink"))
    'Dim FirstSlashIndex As Integer 'Never even used...
	'If link.Length > 7 Then
	'    FirstSlashIndex = link.IndexOf("/", 7)
	'End If
	StartIndex = InStrRev(link, "/")
	If link.Length > 26 Then
		ShortLink = "<A Href=""" & link & """ TARGET=""_Blank"">" & link.SubString(0, 24) & ".." & "</A>"
	Else
		ShortLink = "<A Href=""" & link & """ TARGET=""_Blank"">" & link & "</A>"
	End If
	Response.Write(("<tr><TD>" & drLast5("NewsletterStatHitsCreated").ToString() & "</td><td><a href=""javascript:RecipientStats('" & drLast5("NewsletterStatHitsUserID").ToString() & "');"">" & drLast5("NewsletterRecipientName").ToString() & "</a></td><td>" & ShortLink & "</td></tr>"))
	Response.Write(("<TR><TD colspan='3' bgcolor='#c4c4c4'></TD></TR>"))
		
	intCounter = intCounter + 1
Loop 
If Not blnDrLast5HasRows Then
	Response.Write((Translate.Translate("Ingen data")))
End If
drLast5.Close()
Response.Write(("</table>"))
%>
					</td>
								</tr>
							</table>
						</td>
					</TR>
					<!-- Make space --->
	<tr>
		<td><br></td>
	</tr>
					<TR>
						<td valign="top">
			<table width="512">
	<tr>
					<td valign="top" rowspan="4"><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
					<td width="402"><strong style="color:#003366;"><%=Translate.Translate("Click tidspunkter")%></strong></td>
					<td align="right" style="width:75px;"></td>
	</tr>
	<tr>
					<td style="background-color:#CCCCCC;height:1px;width:100%" colspan="2"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
					<td colspan="2">
		<%

myGraph = New Graph2
myGraph.BarFill = objStatistic.Statv2SettingsFillbar

cmdStatistics.CommandText = SQLTopLinkHour
drLast5 = cmdStatistics.ExecuteReader()
Do While drLast5.Read()
	Do While CurrentHour < CInt(drLast5("myHour").ToString())
		If CurrentHour = 0 Then
			myGraph.SetBarValue("00:00 --> 01:00", 0)		
		ElseIf CurrentHour < 9 Then 
			myGraph.SetBarValue("0" & CurrentHour & ":00 --> 0" & CurrentHour + 1 & ":00", 0)
		ElseIf CurrentHour = 9 Then 
			myGraph.SetBarValue("0" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", 0)
		ElseIf CurrentHour = 23 Then 
			myGraph.SetBarValue("" & CurrentHour & ":00 --> 00:00", 0)
		Else
			myGraph.SetBarValue("" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", 0)
		End If
		
		CurrentHour = CurrentHour + 1
		'w CurrentHour
	Loop 
	If CInt(drLast5("myHour").ToString()) = 0 Then
		myGraph.SetBarValue("00:00 --> 01:00", 0)
	ElseIf CInt(drLast5("myHour").ToString()) < 9 Then 
		myGraph.SetBarValue("0" & CurrentHour & ":00 --> 0" & CurrentHour + 1 & ":00", drLast5("Number1").ToString())
	ElseIf CInt(drLast5("myHour").ToString()) = 9 Then 
		myGraph.SetBarValue("0" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", drLast5("Number1").ToString())
	ElseIf CInt(drLast5("myHour").ToString()) = 23 Then 
		myGraph.SetBarValue("" & CurrentHour & ":00 --> 00:00", drLast5("Number1").ToString())
	Else
		myGraph.SetBarValue("" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", drLast5("Number1").ToString())
	End If
	CurrentHour = CurrentHour + 1
	
Loop 
If CurrentHour < 24 Then
	Do While CurrentHour < 24
		If CurrentHour = 0 Then
			myGraph.SetBarValue("00:00 --> 01:00", 0)
		ElseIf CurrentHour < 9 Then 
			myGraph.SetBarValue("0" & CurrentHour & ":00 --> 0" & CurrentHour + 1 & ":00", 0)
		ElseIf CurrentHour = 9 Then 
			myGraph.SetBarValue("0" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", 0)
		ElseIf CurrentHour = 23 Then 
			myGraph.SetBarValue("" & CurrentHour & ":00 --> 00:00", 0)
		Else
			myGraph.SetBarValue("" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", 0)
		End If
						'							dwgFrontStatistics.AddBar "</TD><TD>" & CurrentHourStr & ":00" ,0
		CurrentHour = CurrentHour + 1
	Loop 
End If
Response.Write(myGraph.Output)

%>
					</td>
				</tr>
							</table>
</div>
&nbsp; 
						<!--NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN-->
							<%
							'drLast5.Close()
drLast5.Dispose()
cmdStatistics.Dispose()
cnStatistics.Dispose()
							
							%>
						</TD>
					</TR>
				</TABLE>
			</DIV>
		</TD>
	</TR>
</TABLE>

<%
Translate.GetEditOnlineScript()
%>
