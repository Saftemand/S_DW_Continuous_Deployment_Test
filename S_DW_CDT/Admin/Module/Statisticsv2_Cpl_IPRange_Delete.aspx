<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim strSql As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0.1
'	Created:			04-09-2003
'	Created by:			Nicolai Pedersen, np@dynamicsystems.dk
'	Last modfied:		30-06-2005
'
'	Purpose: Settings for Stat v2.
'
'	Revision history:
'		1.0.1 - 30-06-2005 - Bo Brandt, bbr@dynamicsystems.dk - Moved to Control Panel
'		1.0.0 - 04-09-2003 - Nicolai Pedersen, np@dynamicsystems.dk
'		First version.
'**************************************************************************************************

Dim Statisticsv2Conn As System.Data.IDbConnection = Database.CreateConnection("Statisticsv2.mdb")
Dim sCmdStatisticsv2 As IDbCommand = Statisticsv2Conn.CreateCommand

If Request.QueryString("Statv2ExcludeID") <> "" Then
	strSql = "DELETE FROM Statv2Exclude WHERE Statv2ExcludeID = " & Request.QueryString("Statv2ExcludeID")
	sCmdStatisticsv2.CommandText = strSql
	sCmdStatisticsv2.ExecuteNonQuery()
End If

Statisticsv2Conn.Dispose()
sCmdStatisticsv2.Dispose()

Response.Redirect(("Statisticsv2_Cpl.aspx?Tab=2&filtering=true"))
%>
