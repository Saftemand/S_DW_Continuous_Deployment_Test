<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim strSql As String
Dim strRangeFrom As String
Dim strRangeTo As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			04-09-2003
'	Created by:			Nicolai Pedersen, np@dynamicsystems.dk
'	Last modfied:		04-09-2002
'
'	Purpose: Settings for Stat v2.
'
'	Revision history:
'		1.0.1 - 30-06-2005 - Bo Brandt, bbr@dynamicsystems.dk - Moved to Control Panel
'		1.0.0 - 04-09-2003 - Nicolai Pedersen, np@dynamicsystems.dk
'		First version.
'**************************************************************************************************

strRangeFrom = Request.Form("StatisticsExclusionRangeFrom")
strRangeTo = Request.Form("StatisticsExclusionRangeTo")

Dim Statisticsv2Conn As System.Data.IDbConnection = Database.CreateConnection("Statisticsv2.mdb")
Dim sCmdStatisticsv2 As IDbCommand = Statisticsv2Conn.CreateCommand

If Request.Form("Statv2ExcludeID") <> "" Then
	strSql = "UPDATE [Statv2Exclude] SET Statv2ExcludeDescription = '" & Database.SqlEscapeInjection(Request.Form("Statv2ExcludeDescription")) & "', Statv2ExcludeFromIP = '" & Request.Form("Statv2ExcludeFromIP") & "', Statv2ExcludeToIP = '" & Request.Form("Statv2ExcludeToIP") & "'" & _
			" WHERE Statv2ExcludeID = " & Request.Form("Statv2ExcludeID")
	sCmdStatisticsv2.CommandText = strSql
	sCmdStatisticsv2.ExecuteNonQuery()
Else
	strSql = "INSERT INTO [Statv2Exclude](Statv2ExcludeDescription, Statv2ExcludeFromIP, Statv2ExcludeToIP) VALUES('" & Database.SqlEscapeInjection(Request.Form("Statv2ExcludeDescription")) & "', '" & Request.Form("Statv2ExcludeFromIP") & "', '" & Request.Form("Statv2ExcludeToIP") & "')"
	sCmdStatisticsv2.CommandText = strSql
	sCmdStatisticsv2.ExecuteNonQuery()
End If


If Request.Form("filtering") = "true" Then
	strSql = "UPDATE [Statv2Settings] SET Statv2SettingsIPfiltering = " & Database.SQLBool(0)
	sCmdStatisticsv2.CommandText = strSql
	sCmdStatisticsv2.ExecuteNonQuery()
End If

Statisticsv2Conn.Dispose()
sCmdStatisticsv2.Dispose()

Response.Redirect(("Statisticsv2_Cpl.aspx?filtering=true"))
%>
