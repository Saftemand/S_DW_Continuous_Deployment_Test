<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>
<script language="VB" runat="Server">

Dim CurrentHourStr As String
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
Dim SQLTopReadHour As String
Dim SQLClickTop5Links As String
Dim SQLOpenLast5 As String
Dim SQLClicksTotal As String
Dim SQLClickLast5 As String

Dim ShortLink As String
Dim CurrrentHour As Byte
Dim ClicksTotal As Object
Dim LinksTotal As Object

Dim drStat As IDataReader 
Dim blndrStatHasRows As Boolean
Dim DWsqlmode As String = CStr(Base.GetGs("/Globalsettings/System/Database/Type"))
Dim tmpDate As String
Dim tmpDay As String
Dim myGraph As New Graph2
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
</script>
<%
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

SQLOpenStdInfo =	" SELECT	NewsletterSmtpServer,  " & _
					"			NewsletterRecipientCount,  " & _
					"			NewsletterSentType,  " & _
					"			NewsletterSendCreated,  " & _
					"			(SELECT Count(NewsletterStatHitsID) AS OpenAmount " & _
					"			FROM NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID " & _
					"			WHERE NewsletterExtendedStatHits.NewsletterStatHitsType=2 AND NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID AND NewsletterExtendedStat.NewsletterStatLetterID = " & NewsletterID & ") as OpenAmount " & _
					" FROM		NewsletterExtended  " & _
					" WHERE		NewsletterID = " & NewsletterID

SQLOpenAmontLast5 =	SQLOpenAmontLast5 & _
					" SELECT 	TOP 50 DATEPART(""YYYY"", NewsletterStatHitsCreated) as myYear, " & _
					"			DATEPART(""m"", NewsletterStatHitsCreated) as myMonth,  " & _
					"			DATEPART(""d"", NewsletterStatHitsCreated) as myDay,  " & _
					"			DATEPART(""w"", NewsletterStatHitsCreated) as myWeekDay,  " & _
					"			COUNT(NewsletterStatHitsID) as number1  " & _
					" FROM 		NewsletterExtendedStatHits  " & _
					" INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID " & _
					" WHERE NewsletterExtendedStatHits.NewsletterStatHitsType = 2 AND " & strSQLDate &  _
					" GROUP BY 	DATEPART(""YYYY"", NewsletterStatHitsCreated),  " & _
					"			DATEPART(""M"", NewsletterStatHitsCreated),  " & _
					"			DATEPART(""D"", NewsletterStatHitsCreated), " & _
					"			DATEPART(""W"", NewsletterStatHitsCreated), " & _
					"			NewsletterExtendedStat.NewsletterStatLetterID " & _
					" HAVING	NewsletterExtendedStat.NewsletterStatLetterID = " & NewsletterID & _
					" Order by 	DATEPART(""YYYY"", NewsletterStatHitsCreated) desc,  " & _
					"			DATEPART(""M"", NewsletterStatHitsCreated) desc,  " & _
					"			DATEPART(""D"", NewsletterStatHitsCreated)desc "
 

SQLClickAmontLast5 = " SELECT TOP 100 DATEPART(""YYYY"", NewsletterStatHitsCreated) as myYear, " & "			DATEPART(""m"", NewsletterStatHitsCreated) as myMonth,  " & "			DATEPART(""d"", NewsletterStatHitsCreated) as myDay,  " & "			DATEPART(""w"", NewsletterStatHitsCreated) as myWeekDay,  " & "			COUNT(NewsletterStatHitsID) as number1  " & " FROM 		NewsletterExtendedStatHits  " & " WHERE 	NewsletterStatHitsStatID IN (	Select NewsletterStatID  " & "											from 	NewsletterExtendedStat  " & "											Where 	NewsletterStatLetterID = " & NewsletterID & ") " & "			AND NewsletterStatHitsType = 1 AND " & strSQLDate & " GROUP BY 	DATEPART(""YYYY"", NewsletterStatHitsCreated),  " & "			DATEPART(""M"", NewsletterStatHitsCreated),  " & "			DATEPART(""D"", NewsletterStatHitsCreated), " & "			DATEPART(""W"", NewsletterStatHitsCreated) " & " Order by 	DATEPART(""YYYY"", NewsletterStatHitsCreated) desc,  " & "			DATEPART(""M"", NewsletterStatHitsCreated) desc,  " & "			DATEPART(""D"", NewsletterStatHitsCreated)desc "

 

SQLOpenLast5 =	" SELECT TOP 50	DATEPART(""YYYY"", NewsletterStatHitsCreated) as myYear,  " & _
				"				DATEPART(""m"", NewsletterStatHitsCreated) as myMonth,  " & _
				"				DATEPART(""d"", NewsletterStatHitsCreated) as myDay,  " & _
				"				NewsletterStatHitsUserID,  " & _
				"				NewsletterStatHitsCreated, " & _
				"				NewsletterRecipientName, " & _
				"				NewsletterAccessUserID, " & _
				"				NewsletterRecipientEmail " & _
				" FROM			NewsletterExtendedStatHits, NewsletterExtendedRecipient  " & _
				" WHERE			NewsletterRecipientID = NewsletterStatHitsUserID AND " & _
				"				NewsletterStatHitsStatID IN (	Select NewsletterStatID  " & _
				"												FROM NewsletterExtendedStat  " & _
				"												Where  NewsletterStatLetterID = " & NewsletterID & ") AND  " & _
				"				NewsletterStatHitsType = 2 AND " & strSQLDate & _
				" ORDER BY NewsletterStatHitsCreated desc " 

SQLTopReadHour =	" SELECT DatePart(" & Database.SqlDatePart("hour") & ",NewsletterStatHitsCreated) AS myHour, Count(NewsletterExtendedStatHits.NewsletterStatHitsID) AS number1 " & _
					" FROM NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID " & _
					" WHERE NewsletterExtendedStatHits.NewsletterStatHitsType = 2 AND " & strSQLDate & _
					" GROUP BY DatePart(" & Database.SqlDatePart("hour") & ",NewsletterStatHitsCreated), NewsletterExtendedStat.NewsletterStatLetterID " & _
					" HAVING NewsletterExtendedStat.NewsletterStatLetterID = " & NewsletterID & _
					" ORDER BY DatePart(" & Database.SqlDatePart("hour") & ",NewsletterStatHitsCreated) "
					
					


'Dim SQLOpenLast7Days As String = " SELECT TOP 50	DATEPART(""YYYY"", NewsletterStatHitsCreated) as myYear,  " & "				DATEPART(""m"", NewsletterStatHitsCreated) as myMonth,  " & "				DATEPART(""d"", NewsletterStatHitsCreated) as myDay,  " & "				NewsletterStatHitsUserID,  " & "				NewsletterStatHitsCreated, " & "				NewsletterRecipientName, " & "				NewsletterAccessUserID, " & "				NewsletterRecipientEmail " & " FROM			NewsletterExtendedStatHits, NewsletterExtendedRecipient  " & " WHERE			NewsletterRecipientID = NewsletterStatHitsUserID AND " & "				NewsletterStatHitsStatID IN (	Select NewsletterStatID  " & "												FROM NewsletterExtendedStat  " & "												Where  NewsletterStatLetterID = " & NewsletterID & ") AND  " & "				NewsletterStatHitsType = 2 " & " ORDER BY NewsletterStatHitsCreated desc "

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
<!-- TAB2 ------------------------------------------------------------------------------------------------------------------------------- -->

	<table width='512'>
	<tr>
		<td valign='top' rowspan='4'><img src='/Admin/Images/Icons/Statv2_Report_heading.gif' width='32' height='36' border='0'></td>
	</tr>
	<tr>
		<td width='402'><strong style='color:#003366;'><%=Translate.Translate("Generel info")%></strong></td>
		<td align='right' style='width:75px;'></td>
	</tr>
	<tr>
		<td style='background-color:#CCCCCC;height:1px;width:100%;' colspan='2'></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan='2'>
													<%
'Response.Write(("<table width='295'>"))
Response.Write("<table width='100%'>")

cmdStatistics.CommandText = SQLOpenStdInfo
drStat = cmdStatistics.ExecuteReader()
If drStat.Read() Then
	
	AntalBruger = drStat("NewsletterRecipientCount").ToString()
	If Len(drStat("NewsletterSmtpServer").ToString()) > 40 Then
		Response.Write(("<tr><TD>" & Translate.Translate("Send via") & "</td><td title='" & drStat("NewsletterSmtpServer").ToString() & "' align='right'>" & Left(drStat("NewsletterSmtpServer").ToString(), 40) & "...</td></tr>"))
	Else
		Response.Write(("<tr><TD>" & Translate.Translate("Send via") & "</td><td align='right'>" & drStat("NewsletterSmtpServer").ToString() & "</td></tr>"))
	End If
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Forsendelsemetode") & "</td><td align='right'>"))
	If drStat("NewsletterSentType").ToString() = "1" Then
		Response.Write((Translate.Translate("Online") & "</td></tr>"))
	ElseIf drStat("NewsletterSentType").ToString() = "2" Then 
		Response.Write((Translate.Translate("Dropbox") & "</td></tr>"))
	End If
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Send den") & "</td><td align='right'>"))
	If drStat("NewsletterSendCreated").ToString() <> "" Then
		Response.Write(Dates.ShowDate(CDate(drStat("NewsletterSendCreated").ToString()), Dates.Dateformat.Short, False))
	End If
	Response.Write(("</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Antal send") & "</td><td align='right'>" & drStat("NewsletterRecipientCount").ToString() & "</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Antal åbnet") & "</td><td align='right'>" & drStat("OpenAmount").ToString() & "</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	
	'										Myday & "-" & Mymonth & "-" & drStat("myYear") & "</td><td>" & drStat("NewsletterRecipientName") & "</td></tr>")
	
End If
drStat.Close()
Response.Write(("</table>"))
%>
												</TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
							</TABLE>
						</TD>
						&nbsp;	
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
						</TD>
					</TR>
				</TABLE>
			</DIV>

<table width=512>
	<tr>
		<td valign='top' rowspan='4'><img src='/Admin/Images/Icons/Statv2_Report_heading.gif' width='32' height='36' border='0'></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Antal breve åbnet i perioden")%></strong></td>
		<td align=right style="width:75px;"></td>
	</tr>
	<tr>
		<td style='background-color:#CCCCCC;height:1px;width:100%;' colspan='2'></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan='2'>
	          <%
	          myGraph = New Graph2
myGraph.BarFill = objStatistic.Statv2SettingsFillbar
Dim selectQuery As String = "SELECT DatePart(" & Database.SqlDatePart("Year") & ",[NewsletterStatHitsCreated]) AS [Year], DatePart(" & Database.SqlDatePart("Month") & ",[NewsletterStatHitsCreated]) AS [Month], DatePart(" & Database.SqlDatePart("day") & ",[NewsletterStatHitsCreated]) AS [Day], Count(NewsletterExtendedStatHits.NewsletterStatHitsID) AS Hits FROM NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID WHERE NewsletterExtendedStat.NewsletterStatLetterID =" & NewsletterID & " AND ((NewsletterExtendedStatHits.NewsletterStatHitsType)=2) AND " & strSQLDate & " GROUP BY DatePart(" & Database.SqlDatePart("year") & ",[NewsletterStatHitsCreated]),DatePart(" & Database.SqlDatePart("month") & ",[NewsletterStatHitsCreated]), DatePart(" & Database.SqlDatePart("day") & ",NewsletterStatHitsCreated) ORDER BY DatePart(" & Database.SqlDatePart("year") & ",NewsletterStatHitsCreated),DatePart(" & Database.SqlDatePart("month") & ",NewsletterStatHitsCreated), DatePart(" & Database.SqlDatePart("day") & ",NewsletterStatHitsCreated); "
cmdStatistics.CommandText = selectQuery
drStat = cmdStatistics.ExecuteReader()

Do While drStat.Read()
Dim strDate As String = drStat("Year").ToString & "-" & drStat("Month").ToString & "-" & drStat("Day").ToString
		myGraph.SetBarValue(strDate, Base.ChkValue(drStat("Hits").ToString()))
Loop 

drStat.Close()

Response.Write(myGraph.Output)
	          
	          %>
		
										
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					
					<!-- Make space --->
<tr>
	<td><br />
	</td>
</tr>
					<TR>
						<td valign="top">
									<table width='512'>
	<tr>
		<td valign='top' rowspan='4'><img src='/Admin/Images/Icons/Statv2_Report_heading.gif' width='32' height='36' border='0'></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Læst tidspunkter")%></strong></td>
		<td align=right style="width:75px;"></td>
	</tr>
	<tr>
		<td style='background-color:#CCCCCC;height:1px;width:100%;' colspan='2'></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan='2'>
		<%

myGraph = New Graph2
myGraph.BarFill = objStatistic.Statv2SettingsFillbar

cmdStatistics.CommandText = SQLTopReadHour
drStat = cmdStatistics.ExecuteReader()
Do While drStat.Read()
	Do While CurrentHour < CInt(drStat("myHour").ToString())
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
	If CInt(drStat("myHour").ToString()) = 0 Then
		myGraph.SetBarValue("00:00 --> 01:00", 0)
	ElseIf CInt(drStat("myHour").ToString()) < 9 Then 
		myGraph.SetBarValue("0" & CurrentHour & ":00 --> 0" & CurrentHour + 1 & ":00", drStat("Number1").ToString())
	ElseIf CInt(drStat("myHour").ToString()) = 9 Then 
		myGraph.SetBarValue("0" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", drStat("Number1").ToString())
	ElseIf CInt(drStat("myHour").ToString()) = 23 Then 
		myGraph.SetBarValue("" & CurrentHour & ":00 --> 00:00", drStat("Number1").ToString())
	Else
		myGraph.SetBarValue("" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", drStat("Number1").ToString())
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

drStat.Close()

Response.Write(myGraph.Output)

%>
									</TD>
								</TR>
							</table>
						</TD>
					</TR>
					<tr><td><br></td></tr>
					
				<table width='512' border='0'>
	<tr>
		<td valign='top' rowspan='4'><img src='/Admin/Images/Icons/Statv2_Report_heading.gif' width='32' height='36' border='0'></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Breve Åbnet")%></strong></td>
		<td align=right style="width:75px;"></td>
	</tr>
	<tr>
		<td style='background-color:#CCCCCC;height:1px;width:100%;' colspan='2'></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan='2'>
													<%
Response.Write("<table width='512'>")
cmdStatistics.CommandText = SQLOpenLast5
drStat = cmdStatistics.ExecuteReader()
Top5Counter = 0

blndrStatHasRows = false
Do While drStat.Read()
	If Not blndrStatHasRows Then 
		blndrStatHasRows = true
	End If
	If Len(drStat("NewsletterRecipientName").toString) > 35 Then
		Response.Write("<tr><td>" & drStat("NewsletterStatHitsCreated").ToString() & "</td><td title='" & drStat("NewsletterRecipientName").ToString() & "'><a href=""javascript:RecipientStats('" & drStat("NewsletterStatHitsUserID").ToString() & "');"">" & Left(drStat("NewsletterRecipientName").ToString(), 35) & "... </a></td></tr>")
	Else
		Response.Write("<tr><td>" & drStat("NewsletterStatHitsCreated").ToString() & "</td><td title='" & drStat("NewsletterRecipientName").ToString() & "'><a href=""javascript:RecipientStats('" & drStat("NewsletterStatHitsUserID").ToString() & "');"">" & drStat("NewsletterRecipientName").ToString() & "</a></td></tr>")
	End If
	'													Response.Write ("<tr><TD>" & Myday & "-" & Mymonth & "-" & drStat("myYear") & "</td><td>" & drStat("NewsletterRecipientName") & "</td></tr>")
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	
	Top5Counter = Top5Counter + 1
Loop 

If Not blndrStatHasRows Then
	Response.Write(Translate.Translate("Ingen data"))
End If

drStat.Close()
Response.Write(("</table>"))
%>
			</tr>
		</table>
	</td>
						<%
							
							'drStat.Close()
drStat.Dispose()
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
