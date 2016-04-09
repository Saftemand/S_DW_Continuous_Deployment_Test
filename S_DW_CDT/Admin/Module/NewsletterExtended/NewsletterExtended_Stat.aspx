<%@ Page CodeBehind="NewsletterExtended_Stat.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Stat" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>

<%
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
Dim NewsletterName As String
Dim SQLClickTop5Links As String
Dim ClicksTotal As Object
Dim NewsletterID As String
Dim LinksTotal As Object
Dim SQLOpenLast5 As String
Dim SQLClicksTotal As String
Dim drLast5 As IDataReader 
Dim blnDrLast5HasRows As Boolean
Dim DWsqlmode As String = "" 'Todo

NewsletterID = Base.ChkNumber(Request.QueryString.Item("ID"))
NewsletterName = Request.QueryString.Item("Name")


If DWsqlmode = "ms_sqlserver" Then
	SQLOpenAmontLast5 = "SET DATEFIRST 7 " & vbnewline
End If
SQLOpenAmontLast5 = SQLOpenAmontLast5 & " SELECT 	TOP 5 DATEPART(""YYYY"", NewsletterStatHitsCreated) as myYear, " & "			DATEPART(""m"", NewsletterStatHitsCreated) as myMonth,  " & "			DATEPART(""d"", NewsletterStatHitsCreated) as myDay,  " & "			DATEPART(""w"", NewsletterStatHitsCreated) as myWeekDay,  " & "			COUNT(NewsletterStatHitsID) as number1  " & " FROM 		NewsletterExtendedStatHits  " & " WHERE 	NewsletterStatHitsStatID IN (	Select NewsletterStatID  " & "											from 	NewsletterExtendedStat  " & "											Where 	NewsletterStatLetterID = " & NewsletterID & ") " & "			AND NewsletterStatHitsType = 2 " & " GROUP BY 	DATEPART(""YYYY"", NewsletterStatHitsCreated),  " & "			DATEPART(""M"", NewsletterStatHitsCreated),  " & "			DATEPART(""D"", NewsletterStatHitsCreated), " & "			DATEPART(""W"", NewsletterStatHitsCreated) " & " Order by 	DATEPART(""YYYY"", NewsletterStatHitsCreated) desc,  " & "			DATEPART(""M"", NewsletterStatHitsCreated) desc,  " & "			DATEPART(""D"", NewsletterStatHitsCreated)desc "

SQLClickAmontLast5 = " SELECT 	TOP 5 DATEPART(""YYYY"", NewsletterStatHitsCreated) as myYear, " & "			DATEPART(""m"", NewsletterStatHitsCreated) as myMonth,  " & "			DATEPART(""d"", NewsletterStatHitsCreated) as myDay,  " & "			DATEPART(""w"", NewsletterStatHitsCreated) as myWeekDay,  " & "			COUNT(NewsletterStatHitsID) as number1  " & " FROM 		NewsletterExtendedStatHits  " & " WHERE 	NewsletterStatHitsStatID IN (	Select NewsletterStatID  " & "											from 	NewsletterExtendedStat  " & "											Where 	NewsletterStatLetterID = " & NewsletterID & ") " & "			AND NewsletterStatHitsType = 1 " & " GROUP BY 	DATEPART(""YYYY"", NewsletterStatHitsCreated),  " & "			DATEPART(""M"", NewsletterStatHitsCreated),  " & "			DATEPART(""D"", NewsletterStatHitsCreated), " & "			DATEPART(""W"", NewsletterStatHitsCreated) " & " Order by 	DATEPART(""YYYY"", NewsletterStatHitsCreated) desc,  " & "			DATEPART(""M"", NewsletterStatHitsCreated) desc,  " & "			DATEPART(""D"", NewsletterStatHitsCreated)desc "

SQLOpenLast5 = " SELECT TOP 5	DATEPART(""YYYY"", NewsletterStatHitsCreated) as myYear,  " & "				DATEPART(""m"", NewsletterStatHitsCreated) as myMonth,  " & "				DATEPART(""d"", NewsletterStatHitsCreated) as myDay,  " & "				NewsletterStatHitsUserID,  " & "				NewsletterStatHitsCreated, " & "				NewsletterRecipientName, " & "				NewsletterAccessUserID, " & "				NewsletterRecipientEmail " & " FROM			NewsletterExtendedStatHits, NewsletterExtendedRecipient  " & " WHERE			NewsletterRecipientID = NewsletterStatHitsUserID AND " & "				NewsletterStatHitsStatID IN (	Select NewsletterStatID  " & "												FROM NewsletterExtendedStat  " & "												Where  NewsletterStatLetterID = " & NewsletterID & ") AND  " & "				NewsletterStatHitsType = 2 " & " ORDER BY NewsletterStatHitsCreated desc "

SQLClickLast5 = " SELECT TOP 5	DATEPART(""YYYY"", NewsletterStatHitsCreated) as myYear,  " & "				DATEPART(""m"", NewsletterStatHitsCreated) as myMonth,  " & "				DATEPART(""d"", NewsletterStatHitsCreated) as myDay,  " & "				NewsletterStatHitsUserID,  " & "				NewsletterStatHitsCreated, " & "				NewsletterRecipientName, " & "				NewsletterAccessUserID, " & "				NewsletterRecipientEmail " & " FROM			NewsletterExtendedStatHits, NewsletterExtendedRecipient  " & " WHERE			NewsletterRecipientID = NewsletterStatHitsUserID AND " & "				NewsletterStatHitsStatID IN (	Select NewsletterStatID  " & "												FROM NewsletterExtendedStat  " & "												Where  NewsletterStatLetterID = " & NewsletterID & ") AND  " & "				NewsletterStatHitsType = 1 " & " ORDER BY NewsletterStatHitsCreated desc "

SQLOpenStdInfo = " select	NewsletterSmtpServer,  " & "			NewsletterRecipientCount,  " & "			NewsletterSentType,  " & "			NewsletterSendCreated,  " & "			(SELECT COUNT(NewsletterStatHitsID) as OpenAmount " & " FROM		NewsletterExtendedStatHits  " & " WHERE		NewsletterStatHitsType = 2 AND  " & "			NewsletterStatHitsStatID IN (	SELECT NewsletterStatID  " & "											FROM NewsletterExtendedStat  " & "											WHERE NewsletterStatLetterID = " & NewsletterID & ")) as OpenAmount " & " from		NewsletterExtended  " & " where		NewsletterID = " & NewsletterID

SQLClickTop5Links = " SELECT TOP 5	NewsletterStatLink , COUNT(NewsletterStatID) AS ClickAmount" & " FROM			NewsletterExtendedStat, NewsletterExtendedStatHits " & " WHERE			NewsletterStatID = NewsletterStatHitsStatID AND  " & "				NewsletterStatHitsType = 1 AND  " & "				NewsletterStatLetterID = " & NewsletterID & " GROUP BY		NewsletterStatLink " & " ORDER BY		COUNT(NewsletterStatID) DESC"

SQLClicksTotal = " select COUNT(NewsletterStatID) AS ClicksTotal " & " FROM NewsletterExtendedStat, NewsletterExtendedStatHits " & " where NewsletterStatLetterID = " & NewsletterID & "		AND NewsletterStatHitsStatID = NewsletterStatID AND NewsletterStatHitsType = 1"

SQLLinksTotal = " select COUNT(NewsletterStatID) AS LinksTotal " & " FROM NewsletterExtendedStat " & " where NewsletterStatLetterID = " & NewsletterID & " AND NewsletterStatLink NOT LIKE 'Open Mail'"

HourSqlDatePart = Database.SqlDatePart("hour")

SQLTopLinkHour = " SELECT  DATEPART(" & HourSqlDatePart & ", NewsletterStatHitsCreated) as myHour, COUNT(NewsletterStatHitsID) as number1  " & " FROM   NewsletterExtendedStatHits  " & " WHERE   NewsletterStatHitsStatID IN (Select NewsletterStatID FROM NewsletterExtendedStat Where  NewsletterStatLetterID = " & NewsletterID & ") AND NewsletterStatHitsType = 1 " & " GROUP BY DATEPART(" & HourSqlDatePart & ", NewsletterStatHitsCreated) " & " Order by  DATEPART(" & HourSqlDatePart & ", NewsletterStatHitsCreated) "

Dim cnStatistics As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdStatistics As IDbCommand = cnStatistics.CreateCommand


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
//-->
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title><%=Translate.JsTranslate("Rediger %%","%%",Translate.Translate("modtager")%></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	

<%=Gui.MakeHeaders(Translate.Translate("Nyhedsbrev statistik"), Translate.Translate("Læst") & ", " & Translate.Translate("Clicks"), "javascript")%>
<body LEFTMARGIN="20" TOPMARGIN="16">
<%=Gui.MakeHeaders(Translate.Translate("Nyhedsbrev statistik") & ": " & NewsletterName, Translate.Translate("Læst") & ", " & Translate.Translate("Clicks"), "html")%>

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="tabTable">
	<TR>
		<TD VALIGN="top"><BR>
			<DIV ID="Tab1">
				<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
					<TR>
						<TD>
							<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD width="100%" colspan="3"><STRONG><%=Translate.Translate("Åbnede sidste %% dage", "%%", "5")%></STRONG></TD>
								</TR>
								<TR>
									<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="5"></TD>
									<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD width="100%" colspan="3" valign="top">
										<%
dwgFrontStatistics = New Graph
dwgFrontStatistics.Width = 585
dwgFrontStatistics.BarAreaWidth = 380
dwgFrontStatistics.GraphOrientation = 1

dwgFrontStatistics.BarTitles = True
dwgFrontStatistics.BarValues = True

dwgFrontStatistics.BarColor = "#003366"
dwgFrontStatistics.BarBackgroundColor = "Gainsboro"
dwgFrontStatistics.BarBorderWidth = 10
cmdStatistics.CommandText = SQLOpenAmontLast5
drLast5 = cmdStatistics.ExecuteReader()

blnDrLast5HasRows = false
Do While drLast5.Read()
	If Not blnDrLast5HasRows Then 
		blnDrLast5HasRows = true
	End If
	
	If CInt(drLast5("myDay")) < 10 Then
		Myday = "0" & drLast5("myDay").ToString()
	Else
		Myday = drLast5("myDay").ToString()
	End If
	If CInt(drLast5("myMonth")) < 10 Then
		Mymonth = "0" & drLast5("myMonth")
	Else
		Mymonth = drLast5("myMonth").ToString()
	End If
	dwgFrontStatistics.AddBar(Dates.LongDay(drLast5("myWeekDay")) & "</TD><TD>" & Myday & "-" & Mymonth & "-" & drLast5("myYear").ToString(), drLast5("Number1").ToString())
	Loop 
If Not blnDrLast5HasRows Then
	Response.Write((Translate.Translate("Ingen data")))
End If

drLast5.Close()
dwgFrontStatistics.Draw()
dwgFrontStatistics = Nothing
%>
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR>
						<TD><BR>
							<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
								<TR>
									<td valign="top">
										<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="50%">
											<TR>
												<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
												<TD colspan="3"><STRONG><%=Translate.Translate("Sidste %% Åbnede", "%%", "5")%></STRONG></TD>
											</TR>
											<TR>
												<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
											<TR>
												<TD width="4"><IMG src="../images/nothing.gif" width="4" height="5"></TD>
												<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
											<TR>
												<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
												<TD colspan="3" valign="top">
													<%
Response.Write(("<table width='295'>"))
cmdStatistics.CommandText = SQLOpenLast5
drLast5 = cmdStatistics.ExecuteReader()
Top5Counter = 0
Do While drLast5.Read() And Top5Counter < 5
	If CInt(drLast5("myDay")) < 10 Then
		Myday = "0" & drLast5("myDay").ToString()
	Else
		Myday = drLast5("myDay").ToString()
	End If
	If CInt(drLast5("myMonth")) < 10 Then
		Mymonth = "0" & drLast5("myMonth").ToString()
	Else
		Mymonth = drLast5("myMonth").ToString()
	End If
	If Len(drLast5("NewsletterRecipientName")) > 26 Then
		Response.Write(("<tr><TD>" & Myday & "-" & Mymonth & "-" & drLast5("myYear").ToString() & "</td><td title='" & drLast5("NewsletterRecipientName").ToString() & "'>" & Left(drLast5("NewsletterRecipientName").ToString(), 26) & "...</td></tr>"))
	Else
		Response.Write(("<tr><TD>" & Myday & "-" & Mymonth & "-" & drLast5("myYear").ToString() & "</td><td>" & drLast5("NewsletterRecipientName").ToString() & "</td></tr>"))
	End If
	'													Response.Write ("<tr><TD>" & Myday & "-" & Mymonth & "-" & drLast5("myYear") & "</td><td>" & drLast5("NewsletterRecipientName") & "</td></tr>")
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	
	Top5Counter = Top5Counter + 1
Loop 
Do While Top5Counter < 5
	Response.Write(("<tr><TD height='15'></td><td></td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Top5Counter = Top5Counter + 1
Loop 

drLast5.Close()
Response.Write(("</table>"))
%>
												</TD>
											</tr>
										</table>
									</td>
									<td valign="top">
										<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="50%">
											<TR>
												<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
												<TD colspan="3"><STRONG><%=Translate.Translate("Standard Info")%></STRONG><BR></TD>
											</TR>
											<TR>
												<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
											<TR>
												<TD width="4"><IMG src="../images/nothing.gif" width="4" height="5"></TD>
												<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
											<TR>
												<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
												<TD colspan="3" valign="top" align="right">
													<%
Response.Write(("<table width='295'>"))
cmdStatistics.CommandText = SQLOpenStdInfo
drLast5 = cmdStatistics.ExecuteReader()
If drLast5.Read() Then
	
	AntalBruger = drLast5("NewsletterRecipientCount").ToString()
	If Len(drLast5("NewsletterSmtpServer").ToString()) > 20 Then
		Response.Write(("<tr><TD>" & Translate.Translate("Send via") & "</td><td title='" & drLast5("NewsletterSmtpServer").ToString() & "' align='right'>" & Left(drLast5("NewsletterSmtpServer").ToString(), 20) & "...</td></tr>"))
	Else
		Response.Write(("<tr><TD>" & Translate.Translate("Send via") & "</td><td align='right'>" & drLast5("NewsletterSmtpServer").ToString() & "</td></tr>"))
	End If
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Forsendelsemetode") & "</td><td align='right'>"))
	If drLast5("NewsletterSentType").ToString() = "1" Then
		Response.Write((Translate.Translate("Online") & "</td></tr>"))
	ElseIf drLast5("NewsletterSentType").ToString() = "2" Then 
		Response.Write((Translate.Translate("Dropbox") & "</td></tr>"))
	End If
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Send den") & "</td><td align='right'>"))
	If drLast5("NewsletterSendCreated").ToString() <> "" Then
		Response.Write(Dates.ShowDate(CDate(drLast5("NewsletterSendCreated").ToString()), Dates.Dateformat.Short, False))
	End If
	Response.Write(("</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Antal send") & "</td><td align='right'>" & drLast5("NewsletterRecipientCount").ToString() & "</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>" & Translate.Translate("Antal åbnet") & "</td><td align='right'>" & drLast5("OpenAmount").ToString() & "</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	
	'										Myday & "-" & Mymonth & "-" & drLast5("myYear") & "</td><td>" & drLast5("NewsletterRecipientName") & "</td></tr>")
	
End If
drLast5.Close()
Response.Write(("</table>"))
%>
												</TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR>
						<TD>
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
							<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
								<TR>
									<TD VALIGN="top">
									<br>
										<DIV ID="Open30close" STYLE="display:block">
											<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
												<TR>
													<TD width="4px">
														<IMG src="../images/nothing.gif" width="4px" height="17">
													</TD>
													<TD ALIGN="LEFT" width="100%" colspan="2">
														<STRONG><%=Translate.Translate("Åbnede sidste %% dage", "%%", "30")%></STRONG>
													</TD>
													<TD ALIGN="RIGHT">
														<IMG onClick="javascript:unhide('Open30');" src="../../images/Round_arrow_down.gif" title="<%=Translate.Translate("Vis")%>" style="cursor: hand">&nbsp;
													</TD>
												</TR>
												<TR>
													<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD>
												</TR>
											</TABLE>
										</DIV>
										<DIV ID="Open30open" style="display:none">
											<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
												<TR>
													<TD width="2px">
														<IMG src="../images/nothing.gif" width="2" height="17">
													</TD>
													<TD ALIGN="LEFT" colspan="2">
														<STRONG><%=Translate.Translate("Åbnede sidste %% dage", "%%", "30")%></STRONG>
													</TD>
													<TD ALIGN="RIGHT">
														<IMG onClick="javascript:hide('Open30');" src="../../images/Round_arrow_up.gif" title="<%=Translate.Translate("Skjul")%>" style="cursor: hand">&nbsp;
													</TD>
												</TR>
												<TR>
													<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD>
												</TR>
												<TR>
													<TD><IMG src="../images/nothing.gif" width="2" height="5"></TD>
													<TD colspan="3" width="100%"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
												<TR>
												<TR>
													<TD width="2px"><IMG src="../images/nothing.gif" width="2" height="17"></TD>
													<TD colspan="10" valign="top">
														<%
dwgFrontStatistics = New Graph
dwgFrontStatistics.Width = 585
dwgFrontStatistics.BarAreaWidth = 380
dwgFrontStatistics.GraphOrientation = 1

dwgFrontStatistics.BarTitles = True
dwgFrontStatistics.BarValues = True

dwgFrontStatistics.BarColor = "#003366"
dwgFrontStatistics.BarBackgroundColor = "Gainsboro"
dwgFrontStatistics.BarBorderWidth = 10

SQLOpenAmontLast5 = Replace(SQLOpenAmontLast5, "TOP 5", "TOP 30")
cmdStatistics.CommandText = SQLOpenAmontLast5
drLast5 = cmdStatistics.ExecuteReader()

	blnDrLast5HasRows = false
	Do While drLast5.Read()
		If Not blnDrLast5HasRows Then
			blnDrLast5HasRows = true
		End If
				
		If CInt(drLast5("myDay").ToString()) < 10 Then
			Myday = "0" & drLast5("myDay").ToString()
		Else
			Myday = drLast5("myDay").ToString()
		End If
		If CInt(drLast5("myMonth")) < 10 Then
			Mymonth = "0" & drLast5("myMonth").ToString()
		Else
			Mymonth = drLast5("myMonth").ToString()
		End If
		dwgFrontStatistics.AddBar(Dates.LongDay(drLast5("myWeekDay").ToString()) & drLast5("myWeekDay").ToString() & "</TD><TD>" & Myday & "-" & Mymonth & "-" & drLast5("myYear").ToString(), drLast5("Number1").ToString())
	Loop 
If Not blnDrLast5HasRows Then
	Response.Write((Translate.Translate("Ingen data")))
End If
drLast5.Close()
dwgFrontStatistics.Draw()
%>
													</TD>
												</TR>
											</table>
										</div>
									</td>
								</tr>
							</table>
							&nbsp;	
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
						</TD>
					</TR>
				</TABLE>
			</DIV>
			<DIV ID="Tab2" STYLE="display:None;">
				<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
					<TR>
						<TD COLSPAN="2" VALIGN="top">
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
							<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
								<TR>
									<TD VALIGN="top" width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3"  WIDTH="100%"><STRONG><%=Translate.Translate("Clicks sidste %% dage", "%%", "5")%></STRONG></TD>
								</TR>
								<TR>
									<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="5"></TD>
									<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3" WIDTH="100%" valign="top">
										<%
dwgFrontStatistics = New Graph
dwgFrontStatistics.Width = 585
dwgFrontStatistics.BarAreaWidth = 380
dwgFrontStatistics.GraphOrientation = 1

dwgFrontStatistics.BarTitles = True
dwgFrontStatistics.BarValues = True

dwgFrontStatistics.BarColor = "#003366"
dwgFrontStatistics.BarBackgroundColor = "Gainsboro"
dwgFrontStatistics.BarBorderWidth = 10

cmdStatistics.CommandText = SQLClickAmontLast5
drLast5 = cmdStatistics.ExecuteReader()

blnDrLast5HasRows = false
	Do While drLast5.Read()
		If Not blnDrLast5HasRows Then
			blnDrLast5HasRows = true
		End If
		If CInt(drLast5("myDay").ToString()) < 10 Then
			Myday = "0" & drLast5("myDay")
		Else
			Myday = drLast5("myDay").ToString()
		End If
		If CInt(drLast5("myMonth").ToString()) < 10 Then
			Mymonth = "0" & drLast5("myMonth").ToString()
		Else
			Mymonth = drLast5("myMonth").ToString()
		End If
		dwgFrontStatistics.AddBar(Dates.LongDay(drLast5("myWeekDay").ToString()) & "</TD><TD>" & Myday & "-" & Mymonth & "-" & drLast5("myYear").ToString(), drLast5("Number1").ToString())
		
	Loop 
If Not blnDrLast5HasRows Then
	Response.Write((Translate.Translate("Ingen data")))
End If

drLast5.Close()
dwgFrontStatistics.Draw()
%>
									</TD>
								</TR>
							</table>
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
						</TD>
					</TR>
					<TR>
						<TD COLSPAN="2">&nbsp;
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
							<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
								<TR>
									<TD VALIGN="top" width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3"  WIDTH="100%"><STRONG><%=Translate.Translate("Top 5 Links")%></STRONG></TD>
								</TR>
								<TR>
									<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="5"></TD>
									<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3" WIDTH="100%" valign="top">
										<%
dwgFrontStatistics = New Graph
dwgFrontStatistics.Width = 585
dwgFrontStatistics.BarAreaWidth = 380
dwgFrontStatistics.GraphOrientation = 1

dwgFrontStatistics.BarTitles = True
dwgFrontStatistics.BarValues = True

dwgFrontStatistics.BarColor = "#003366"
dwgFrontStatistics.BarBackgroundColor = "Gainsboro"
dwgFrontStatistics.BarBorderWidth = 10

cmdStatistics.CommandText = SQLClickTop5Links
drLast5 = cmdStatistics.ExecuteReader()

blnDrLast5HasRows = false
	Do While drLast5.Read()
		If Not blnDrLast5HasRows Then
			blnDrLast5HasRows = true
		End If
		StartIndex = InStrRev(drLast5("NewsletterStatLink").ToString(), "/")
		ShortLink = "<A Href=""" & drLast5("NewsletterStatLink").ToString() & """ TARGET=""_Blank"">" & Mid(drLast5("NewsletterStatLink").ToString(), StartIndex + 1, 20) & "</A>"
		If Len(ShortLink) < 21 Then
			ShortLink = ShortLink & "..."
		End If
		dwgFrontStatistics.AddBar("<td title='" & drLast5("NewsletterStatLink").ToString() & "'>" & ShortLink & "</TD>", drLast5("ClickAmount").ToString())
		
	Loop 
If Not blnDrLast5HasRows Then
	Response.Write((Translate.Translate("Ingen data")))
End If

drLast5.Close()
dwgFrontStatistics.Draw()
%>
									</TD>
								</TR>
							</table>
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
						</TD>
					</TR>
					<TR>
						<td valign="top">&nbsp;
						<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
							<table cellspacing="0" border="0" cellpadding="0" width="50%">
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3"><STRONG><%=Translate.Translate("Sidste %% Clickede", "%%", "5")%></STRONG></TD>
								</TR>
								<TR>
									<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="5"></TD>
									<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3" valign="top">
										<%
Response.Write(("<table width='295'>"))

intCounter = 0
cmdStatistics.CommandText = SQLClickLast5
drLast5 = cmdStatistics.ExecuteReader()
		
Do While drLast5.Read()
	If CInt(drLast5("myDay").ToString()) < 10 Then
		Myday = "0" & drLast5("myDay").ToString()
	Else
		Myday = drLast5("myDay").ToString()
	End If
	If CInt(drLast5("myMonth").ToString()) < 10 Then
		Mymonth = "0" & drLast5("myMonth")
	Else
		Mymonth = drLast5("myMonth").ToString()
	End If
	Response.Write(("<tr><TD>" & Myday & "-" & Mymonth & "-" & drLast5("myYear").ToString() & "</td><td>" & drLast5("NewsletterRecipientName").ToString() & "</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	
	
	intCounter = intCounter + 1
Loop 
Do While intCounter < 5
	Response.Write(("<tr><TD> &nbsp;</td><td></td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	intCounter = intCounter + 1
Loop 
drLast5.Close()
Response.Write(("</table>"))
%>
									</TD>
								</tr>
							</table>
						</td>
						<td valign="top">&nbsp;
							<table cellspacing="0" border="0" cellpadding="0" width="50%">
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3"><STRONG><%=Translate.Translate("Standard Info")%></STRONG></TD>
								</TR>
								<TR>
									<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="5"></TD>
									<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3" valign="top" align="right">
										<%
Response.Write(("<table width='295'>"))
cmdStatistics.CommandText = SQLLinksTotal
LinksTotal = cmdStatistics.ExecuteScalar()
cmdStatistics.CommandText = SQLClicksTotal
ClicksTotal = cmdStatistics.ExecuteScalar()

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
		Response.Write(("<tr><TD>" & Translate.Translate("Gns. Clicks per bruger") & "</td><td align='right'>0</td></tr>"))
	Else
		Response.Write(("<tr><TD>" & Translate.Translate("Gns. clicks per link") & "</td><td align='right'>" & FormatNumber(ClicksTotal / LinksTotal / AntalBruger, 2) & "</td></tr>"))
	End If
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	Response.Write(("<tr><TD>&nbsp;" & "</td><td align='right'>" & "</td></tr>"))
	Response.Write(("<TR><TD colspan='2' bgcolor='#c4c4c4'></TD></TR>"))
	
End If
Response.Write(("</table>"))
%>
									</TD>
								</tr>
							</table>
							<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
						</TD>
					</TR>
					<TR>
						<TD colspan="2">
							<br>
							<div ID="Click30close" style="display:block">
							<table cellspacing="0" border="0" cellpadding="0" width="100%">
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD ALIGN="LEFT" width="100%" colspan="2"><STRONG><%=Translate.Translate("Clicks sidste %% dage", "%%", "30")%></STRONG></TD>
									<TD align="RIGHT"><IMG onClick="javascript:unhide('Click30');" src="../../images/Round_arrow_down.gif" title="<%=Translate.Translate("Vis")%>" style="cursor: hand">&nbsp;</TD>
								</TR>
								<TR>
									<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
								<TR>
							</table>
							</div>
							<div ID="Click30open" style="display:none">
							<table cellspacing="0" border="0" cellpadding="0" width="100%">
								<TR>
									<TD width="2">
										<IMG src="../images/nothing.gif" width="2" height="17">
									</TD>
									<TD ALIGN="LEFT" colspan="2">
										<STRONG><%=Translate.Translate("Clicks sidste %% dage", "%%", "30")%></STRONG>
									</TD>
									<TD ALIGN="RIGHT">
										<IMG onClick="javascript:hide('Click30');" src="../../images/Round_arrow_up.gif" title="<%=Translate.Translate("Skjul")%>" style="cursor: hand">&nbsp;
									</TD>
								</TR>
								<TR>
									<TD colspan="4">
										<IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD>
								</TR>
								<TR>
									<TD width="2"><IMG src="../images/nothing.gif" width="2" height="5"></TD>
									<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
								<TR>
									<TD width="2"><IMG src="../images/nothing.gif" width="2" height="17"></TD>
									<TD colspan="3" valign="top">
										<%
dwgFrontStatistics = New Graph
dwgFrontStatistics.Width = 585
dwgFrontStatistics.BarAreaWidth = 380
dwgFrontStatistics.GraphOrientation = 1

dwgFrontStatistics.BarTitles = True
dwgFrontStatistics.BarValues = True

dwgFrontStatistics.BarColor = "#003366"
dwgFrontStatistics.BarBackgroundColor = "Gainsboro"
dwgFrontStatistics.BarBorderWidth = 10

SQLClickAmontLast5 = Replace(SQLClickAmontLast5, "TOP 5", "TOP 30")

cmdStatistics.CommandText = SQLClickAmontLast5
drLast5 = cmdStatistics.ExecuteReader()

blnDrLast5HasRows = false
	Do While drLast5.Read()
		If Not blnDrLast5HasRows Then
			blnDrLast5HasRows = true
		End If
		If CInt(drLast5("myDay").ToString()) < 10 Then
			Myday = "0" & drLast5("myDay").ToString()
		Else
			Myday = drLast5("myDay").ToString()
		End If
		If CInt(drLast5("myMonth")) < 10 Then
			Mymonth = "0" & drLast5("myMonth").ToString()
		Else
			Mymonth = drLast5("myMonth").ToString()
		End If
		dwgFrontStatistics.AddBar(Dates.LongDay(drLast5("myWeekDay").ToString()) & "</TD><TD>" & Myday & "-" & Mymonth & "-" & drLast5("myYear").ToString(), drLast5("Number1").ToString())
		
	Loop 
If Not blnDrLast5HasRows Then
	Response.Write((Translate.Translate("Ingen data")))
End If
drLast5.Close()
dwgFrontStatistics.Draw()
%>
									</TD>
								</TR>
							</table>
							</div>
							<!--YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY-->
						</TD>
					</TR>
					<TR>
						<TD COLSPAN="2">&nbsp;
						<!--NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN-->
							<div ID="ClickHourclose" style="display:block">
							<table cellspacing="0" border="0" cellpadding="0" width="100%">
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD Width="100%" ALIGN="LEFT" colspan="2"><STRONG><%=Translate.Translate("Click tidspunkter")%></STRONG></TD>
									<TD><IMG onClick="javascript:unhide('ClickHour');" src="../../images/Round_arrow_down.gif"title="<%=Translate.Translate("Vis")%>"  style="cursor: hand">&nbsp;</TD>
								</TR>
								<TR>
									<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
								<TR>
							</table>
							</div>
							<div ID="ClickHouropen" style="display:none">
							<table cellspacing="0" border="0" cellpadding="0" width="100%">
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD Width="100%" colspan="2"><STRONG><%=Translate.Translate("Click tidspunkter")%></STRONG></TD>
									<TD><IMG onClick="javascript:hide('ClickHour');" src="../../images/Round_arrow_up.gif" title="<%=Translate.Translate("Skjul")%>" style="cursor: hand">&nbsp;</TD>
								</TR>
								<TR>
									<TD colspan="4"><IMG src="../../images/horisontalLine.gif" vspace="0" hspace="0"></TD></TR>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="5"></TD>
									<TD width="3"><IMG src="../../images/nothing.gif" width="4" height="5"></TD>
								<TR>
									<TD width="4"><IMG src="../images/nothing.gif" width="4" height="17"></TD>
									<TD colspan="3" valign="top">
										<%
dwgFrontStatistics = New Graph
dwgFrontStatistics.Width = 570
dwgFrontStatistics.BarAreaWidth = 370
dwgFrontStatistics.GraphOrientation = 1

dwgFrontStatistics.BarTitles = True
dwgFrontStatistics.BarValues = True

dwgFrontStatistics.BarColor = "#003366"
dwgFrontStatistics.BarBackgroundColor = "Gainsboro"
dwgFrontStatistics.BarBorderWidth = 10
CurrrentHour = 0
CurrentHourStr = ""

cmdStatistics.CommandText = SQLTopLinkHour
drLast5 = cmdStatistics.ExecuteReader()
Do While drLast5.Read()
	Do While CurrentHour < CInt(drLast5("myHour").ToString())
		If CurrentHour = 0 Then
			dwgFrontStatistics.AddBar("</TD><TD>00:00 --> 01:00", 0)
		ElseIf CurrentHour < 9 Then 
			dwgFrontStatistics.AddBar("</TD><TD>0" & CurrentHour & ":00 --> 0" & CurrentHour + 1 & ":00", 0)
		ElseIf CurrentHour = 9 Then 
			dwgFrontStatistics.AddBar("</TD><TD>0" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", 0)
		ElseIf CurrentHour = 23 Then 
			dwgFrontStatistics.AddBar("</TD><TD>" & CurrentHour & ":00 --> 00:00", 0)
		Else
			dwgFrontStatistics.AddBar("</TD><TD>" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", 0)
		End If
		
		CurrentHour = CurrentHour + 1
		'w CurrentHour
	Loop 
	If CInt(drLast5("myHour").ToString()) = 0 Then
		dwgFrontStatistics.AddBar("</TD><TD>00:00 --> 01:00", 0)
	ElseIf CInt(drLast5("myHour").ToString()) < 9 Then 
		dwgFrontStatistics.AddBar("</TD><TD>0" & CurrentHour & ":00 --> 0" & CurrentHour + 1 & ":00", drLast5("Number1").ToString())
	ElseIf CInt(drLast5("myHour").ToString()) = 9 Then 
		dwgFrontStatistics.AddBar("</TD><TD>0" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", drLast5("Number1").ToString())
	ElseIf CInt(drLast5("myHour").ToString()) = 23 Then 
		dwgFrontStatistics.AddBar("</TD><TD>" & CurrentHour & ":00 --> 00:00", drLast5("Number1").ToString())
	Else
		dwgFrontStatistics.AddBar("</TD><TD>" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", drLast5("Number1").ToString())
	End If
	CurrentHour = CurrentHour + 1
	'										dwgFrontStatistics.AddBar "</TD><TD>" & drLast5("myHour") & ":00" ,drLast5("Number1")
	
Loop 

If CurrentHour < 23 Then
	Do While CurrentHour < 24
		If CurrentHour = 0 Then
			dwgFrontStatistics.AddBar("</TD><TD>00:00 --> 01:00", 0)
		ElseIf CurrentHour < 9 Then 
			dwgFrontStatistics.AddBar("</TD><TD>0" & CurrentHour & ":00 --> 0" & CurrentHour + 1 & ":00", 0)
		ElseIf CurrentHour = 9 Then 
			dwgFrontStatistics.AddBar("</TD><TD>0" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", 0)
		ElseIf CurrentHour = 23 Then 
			dwgFrontStatistics.AddBar("</TD><TD>" & CurrentHour & ":00 --> 00:00", 0)
		Else
			dwgFrontStatistics.AddBar("</TD><TD>" & CurrentHour & ":00 --> " & CurrentHour + 1 & ":00", 0)
		End If
		'											dwgFrontStatistics.AddBar "</TD><TD>" & CurrentHourStr & ":00" ,0
		CurrentHour = CurrentHour + 1
	Loop 
End If

dwgFrontStatistics.Draw()

drLast5.Dispose()
cmdStatistics.Dispose()
cnStatistics.Dispose()
%>
									</TD>
								</TR>
							</table>
							</div>&nbsp;
						<!--NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN-->
						</TD>
					</TR>
				</TABLE>
			</DIV>
		</TD>
	</TR>
</TABLE>


</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>

