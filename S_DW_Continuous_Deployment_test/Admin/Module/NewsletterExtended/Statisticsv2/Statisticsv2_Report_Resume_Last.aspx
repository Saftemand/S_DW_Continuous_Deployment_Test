<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>

<script language="VB" runat="Server">
Dim GwIP As String
Dim sql As String
Dim RefURL As String
Dim strWhere As String
Dim tmpDay As String
Dim tmpDate As String
Dim ShowSettings As Boolean
Dim Statv2SettingsOnePv As String
Dim Res As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			26-08-2003
'	Last modfied:		26-08-2003
'
'	Purpose: Report
'
'	Revision history:
'		1.0 - 26-08-2003 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************
ShowSettings = True

Dim objStatistic As New Statistic
objStatistic.StatInitializeWhere
%>

<!-- #INCLUDE FILE="Statisticsv2_Report_Common.aspx" -->

<style>
a:visited  {
	color :#006699;
}
</style>
<script>
function showUserReport(strLocation){
	window.open(strLocation, "", "resizable=no,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=600,height=700");
}
</script>
<%
Dim objDate As New Dates
%>


<%Response.Flush()%>

<!-- Last 10 newsletters Opened--->
<table width=512>
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Antal breve åbnet ved de sidste %% sendte nyhedsbreve","%%","10")%></strong></td>
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
			<%
			Dim cnNewsletter As System.Data.IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
            Dim cmdNewsletter As IDbCommand = cnNewsletter.CreateCommand	
		'	sql =	"SELECT TOP 10 NewsletterExtended.NewsletterSendCreated, NewsletterExtended.NewsletterName, (SELECT COUNT(NewsletterStatHitsID) AS [number1] FROM NewsletterExtendedStatHits " & _
			'		"WHERE NewsletterStatHitsStatID IN (Select NewsletterStatID from NewsletterExtendedStat Where NewsletterStatHitsType = 2 AND (NewsletterStatLetterID = NewsletterExtended.NewsletterID))) AS LettersOpened " & _
			'		"FROM NewsletterExtended ORDER BY NewsletterExtended.NewsletterSendCreated DESC"
         '  throw new exception(sql)
           
			'sql = "SELECT TOP 10 NewsletterExtended.NewsletterSendCreated, NewsletterExtended.NewsletterName, (SELECT Count(NewsletterStatHitsID) AS number1 FROM NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID WHERE NewsletterExtendedStatHits.NewsletterStatHitsStatID AND NewsletterStatHitsType = 2 AND NewsletterStatLetterID = NewsletterExtended.NewsletterID) AS LettersOpened FROM NewsletterExtended WHERE NewsletterExtended.NewsletterSendCreated IS NOT NULL ORDER BY NewsletterExtended.NewsletterSendCreated DESC" 
			sql = "SELECT TOP 10 NewsletterExtended.NewsletterSendCreated, NewsletterExtended.NewsletterName, (SELECT Count(NewsletterStatHitsID) AS number1 FROM NewsletterExtendedStatHits INNER JOIN NewsletterExtendedStat ON NewsletterExtendedStatHits.NewsletterStatHitsStatID = NewsletterExtendedStat.NewsletterStatID WHERE NewsletterStatHitsType = 2 AND NewsletterStatLetterID = NewsletterExtended.NewsletterID) AS LettersOpened FROM NewsletterExtended WHERE NewsletterExtended.NewsletterSendCreated IS NOT NULL ORDER BY NewsletterExtended.NewsletterSendCreated DESC" 
            cmdNewsletter.CommandText = sql
            Dim drNewsletter As IDataReader = cmdNewsletter.ExecuteReader()

            Dim NewsletterSendCreated As Integer = drNewsletter.getordinal("NewsletterSendCreated")
            Dim NewsletterName As Integer = drNewsletter.getordinal("NewsletterName")
            Dim LettersOpened As Integer = drNewsletter.getordinal("LettersOpened")

            Dim objGraph = New Graph2
            objGraph.BarFill = objStatistic.Statv2SettingsFillbar

	        Do While drNewsletter.Read
		        tmpDate = drNewsletter(NewsletterSendCreated).ToString
		        tmpDay = objDate.LongDay(WeekDay(tmpDate))
		        If drNewsletter(NewsletterName).ToString.Length > 24 Then
			        objGraph.SetBarValue(drNewsletter(NewsletterName).ToString.SubString(0, 24) & "..", drNewsletter(LettersOpened).ToString)
			    Else
			        objGraph.SetBarValue(drNewsletter(NewsletterName).ToString, drNewsletter(LettersOpened).ToString)
			    End If
	        Loop 

            Response.Write(objGraph.Output)
            
        			drNewsletter.Dispose()
		

            %>
		</td>
	</tr>
</table>

<!-- Last 10 newsletters --->
<table width=512>
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Antal sendte breve ved de sidste %% nyhedsbreve", "%%", "10")%></strong></td>
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
			<%
			'cnNewsletter = Database.CreateConnection("NewsletterExtended.mdb")
            'cmdNewsletter = cnNewsletter.CreateCommand	
			sql =	"SELECT TOP 10 NewsletterExtended.NewsletterSendCreated, NewsletterExtended.NewsletterName, NewsletterRecipientCount " & _
					"FROM NewsletterExtended WHERE (NewsletterExtended.NewsletterSendCreated Is Not Null) ORDER BY NewsletterExtended.NewsletterSendCreated DESC"
          ' throw new exception(sql)
            cmdNewsletter.CommandText = sql
            drNewsletter = cmdNewsletter.ExecuteReader()

            NewsletterSendCreated = drNewsletter.getordinal("NewsletterSendCreated")
            NewsletterName = drNewsletter.getordinal("NewsletterName")
            Dim NewsletterRecipientCount As Integer = drNewsletter.getordinal("NewsletterRecipientCount")

            objGraph = New Graph2
            objGraph.BarFill = objStatistic.Statv2SettingsFillbar

	        Do While drNewsletter.Read
		        tmpDate = drNewsletter(NewsletterSendCreated).ToString
		        tmpDay = objDate.LongDay(WeekDay(tmpDate))
		        If drNewsletter(NewsletterName).ToString.Length > 24 Then
			        objGraph.SetBarValue(drNewsletter(NewsletterName).ToString.SubString(0, 24) & "..", drNewsletter(NewsletterRecipientCount).ToString)
			    Else
			        objGraph.SetBarValue(drNewsletter(NewsletterName).ToString, drNewsletter(NewsletterRecipientCount).ToString)
			    End If
	        Loop 

            Response.Write(objGraph.Output)
            
            objGraph = Nothing
            objDate = Nothing
            objStatistic = Nothing
			
			drNewsletter.Dispose()
			cmdNewsletter.Dispose()
			cnNewsletter.Dispose()

            %>
		</td>
	</tr>
</table>

</body>
</html>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>
