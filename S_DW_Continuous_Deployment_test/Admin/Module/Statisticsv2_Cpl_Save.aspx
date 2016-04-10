<%@ Page Language="vb" AutoEventWireup="false" Debug="true"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
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

Dim strSql As String
Dim Statisticsv2Conn As System.Data.IDbConnection = Database.CreateConnection("Statisticsv2.mdb")
Dim sCmdStatisticsv2 As IDbCommand = Statisticsv2Conn.CreateCommand
Dim IPfiltering As String

If Request.Form("Statv2SettingsIPfiltering") = ""
	IPfiltering = "1"
Else
	IPfiltering = "0"
End If

	
	Base.SetGs("/Globalsettings/Modules/Statistics/RemoteHostVariable", Request.Form("/Globalsettings/Modules/Statistics/RemoteHostVariable"))
	Base.SetGs("/Globalsettings/Modules/Statistics/DisablePageStatistics", Request.Form("/Globalsettings/Modules/Statistics/DisablePageStatistics"))
	Base.SetGs("/Globalsettings/Modules/Statistics/DisableStatistics", Request.Form("/Globalsettings/Modules/Statistics/DisableStatistics"))
		
	If Not IsNothing(Request.Form.GetValues("Statv2SettingsID")) Then
		strSql = "UPDATE [Statv2Settings] SET "
		strSql = strSql & "Statv2SettingsCrawlers = " & Database.SqlBool(CType(Request.Form("Statv2SettingsCrawlers"), Integer)) & ","
		strSql = strSql & "Statv2SettingsAdmins = " & Database.SqlBool(CType(Request.Form("Statv2SettingsAdmins"), Integer)) & ","
		strSql = strSql & "Statv2SettingsOnePv = " & Database.SqlBool(CType(Request.Form("Statv2SettingsOnePv"), Integer)) & ","
		strSql = strSql & "Statv2SettingsExtranetusers = " & Database.SqlBool(CType(Request.Form("Statv2SettingsExtranetusers"), Integer)) & ","
		strSql = strSql & "Statv2SettingsIPfiltering = " & Database.SqlBool(CType(IPfiltering, Integer)) & ","
		strSql = strSql & "Statv2SettingsFillbar = " & Database.SqlBool(CType(Request.Form("Statv2SettingsFillbar"), Integer))
		strSql = strSql & " WHERE Statv2SettingsID = " & Request.Form("Statv2SettingsID")
		sCmdStatisticsv2.CommandText = strSql
		sCmdStatisticsv2.ExecuteNonQuery()
	Else
		strSql = "INSERT INTO [Statv2Settings](Statv2SettingsCrawlers, Statv2SettingsAdmins, Statv2SettingsOnePv, Statv2SettingsExtranetusers, Statv2SettingsIPfiltering, Statv2SettingsFillbar) VALUES(" & Base.ChkBoolean(Request.Form("Statv2SettingsCrawlers")) & ", " & Base.ChkBoolean(Request.Form("Statv2SettingsAdmins")) & ", " & Base.ChkBoolean(Request.Form("Statv2SettingsOnePv")) & ", " & Base.ChkBoolean(Request.Form("Statv2SettingsExtranetusers")) & ", " & Base.ChkBoolean(IPfiltering) & ", " & Base.ChkBoolean(Request.Form("Statv2SettingsFillbar")) & ")"
		sCmdStatisticsv2.CommandText = strSql
		sCmdStatisticsv2.ExecuteNonQuery()
	End If

	Statisticsv2Conn.Dispose()
	sCmdStatisticsv2.Dispose()
%>
<script>
	function IsInStatisticsModule() {
		var loc = ""+ parent.parent.right.document.location.href;
		if (loc) {
			var chkStr = ""+ loc.toLowerCase();
			if (chkStr.indexOf("statisticsv3/main.aspx") != -1) {
				return true;
			}
		}
		return false;
	}
	function CloseStatisticsSettings() {

		if(IsInStatisticsModule()){
			parent.document.location='/Admin/Module/StatisticsV3/Main.aspx';
		}
        else {
            var SaveOnly = '<%=Request.Form("SaveAndClose")%>';
            if (SaveOnly == 'yes') {
                location = '/Admin/Module/ControlPanel.aspx';
            }
            else {
                location = '/Admin/Module/Statisticsv2_Cpl.aspx';
            }
		}
    }

if(IsInStatisticsModule()){
	parent.document.report.Crawlers.value 		= '<%=CBool(Base.ChkBoolean(Request.Form("Statv2SettingsCrawlers")))%>';
	parent.document.report.Admins.value 		= '<%=CBool(Base.ChkBoolean(Request.Form("Statv2SettingsAdmins")))%>';
	parent.document.report.OnePv.value 			= '<%=CBool(Base.ChkBoolean(Request.Form("Statv2SettingsOnePv")))%>';
	parent.document.report.Extranetusers.value 	= '<%=CBool(Base.ChkBoolean(Request.Form("Statv2SettingsExtranetusers")))%>';
	parent.document.report.IPfiltering.value 	= '<%=CBool(Base.ChkBoolean(Request.Form("Statv2SettingsIPfiltering")))%>';
	parent.document.report.Fillbar.value 		= '<%=CBool(Base.ChkBoolean(Request.Form("Statv2SettingsFillbar")))%>';
}

CloseStatisticsSettings();

/*<%if request("ReturnToModule")="1" then%>
parent.document.location = "/Admin/Module/StatisticsV3/Main.aspx"
<%end if%>
<%if not request("ReturnToControlPanel")="false" then%>
location = "ControlPanel.aspx"
<%end if%>*/

</script>
<%'if not request("ReturnToControlPanel")="false" then response.redirect("ControlPanel.aspx")%>