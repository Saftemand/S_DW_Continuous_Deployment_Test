<%@ Import namespace="Dynamicweb.Backend" %>
<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			26-08-2003
'	Last modfied:		26-08-2003
'
'	Purpose: Common subs, functions and settings for reports
'
'	Revision history:
'		1.0 - 26-08-2003 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

'TODO: check at disse udkommenterede objStatistic erklæringer ikke længere er nødvendige?

'objStatistic.Statv2SettingsCrawlers 		= Request.QueryString("Crawlers")
'objStatistic.Statv2SettingsFillbar 		= Request.QueryString("Fillbar")
'objStatistic.Statv2SettingsArea	 		= Request.QueryString("Statv2Area")
'objStatistic.Statv2SettingsAdmins 			= Request.QueryString("Admins")
'objStatistic.Statv2SettingsOnePv 			= Request.QueryString("OnePv")
'objStatistic.Statv2SettingsExtranetusers	= Request.QueryString("Extranetusers")
'objStatistic.Statv2SettingsIPfiltering 	= Request.QueryString("IPfiltering")

objStatistic.Statv2SettingsFrom 			= objStatistic.StatParseDate("Statv2From")
objStatistic.Statv2SettingsTo 				= objStatistic.StatParseDate("Statv2To") & " 23:59:59"

'*** Is it an Export?
'Export = Request.QueryString("Export")

'If Export = "True" Then
'	FSO = New Scripting.FileSystemObject
'	FSO.CopyFile(Server.MapPath("/admin/statisticsv2/export.xls"), Server.MapPath("/files/filer/Dynamicweb_Stat_" & Day(Now) & Month(Now) & Year(Now) & ".xls"))
'	'UPGRADE_NOTE: Object FSO may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
'	FSO = Nothing
'End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<link rel="STYLESHEET" type="text/css" href="/admin/Stylesheet.css">
<style type="text/css">
.barBG {
	height:18px;
	width:240px;
	font-family:verdana;
	font-size:10px;
	background-color:#d1d1d1;
}

.bar {
	height:100%;
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#0000dd', EndColorStr='#000066');
}
</style>
<script>
var timTheTimer

function append(){
		if(document.getElementById('statusText').style.display != 'none'){
			document.getElementById('statusText').innerHTML = document.getElementById('statusText').innerHTML + '.';
			wait();
		}
}

function wait(){
	timTheTimer = setTimeout("append();", 300);
}
function stopTimer() {
	clearTimeout(timTheTimer);
}

function downloadXLSExport(){
	if(location.search.indexOf('Export=True') > 0){
		window.frames.dl.location = '/Admin/Download.aspx?File=<%="/Files/" & Dynamicweb.Content.Management.Installation.FilesFolderName & "/Dynamicweb_Stat_" & Day(Now) & Month(Now) & Year(Now) & ".xls"%>';
	}
}
</script>
</head>
<body onLoad="document.getElementById('statusText').style.display = 'none';setTimeout('downloadXLSExport();', 500);">
<%If ShowSettings Then%>
<iframe name=dl src="about:blank" style="display:none;"></iframe>
<br>
<table cellpadding=0 cellspacing=0 border=0 width=512>
	<tr>
		<td valign=top rowspan=5><img src="/admin/Images/Icons/Statv2_Report_settings.gif" alt="" width="35" height="36" border="0"></td>
	</tr>
	<tr>
		<td width=377><strong style="color:#003366;"><%=Translate.Translate("Indstillinger")%></strong></td>
		<td align=right style="width:100px;"><!--<img src="/admin/Images/Icons/Module_Newsletter_small.gif" width="16" height="16" alt="Send som mail" border="0"> <img src="/admin/Images/Icons/Statv2_Report_Download.gif" width="16" height="16" alt="Download som HTML" border="0"> <img src="/admin/Images/Icons/Statv2_Report_Export.gif" alt="Export&egrave;r data som CSV" width="16" height="16" border="0"> <img src="/admin/Images/ext/xls.gif" alt="<%=Translate.JSTranslate("Eksporter")%>" width="22" height="18" border="0" style="cursor:pointer;" onClick="location=location+'&Export=True';"> <img src="/admin/Images/Icons/Statv2_Report_Print.gif" alt="<%=Translate.JSTranslate("Udskriv")%>" width="16" height="16" border="0" onClick="print();" style="cursor:hand;"></td>-->
	</tr>
	<tr>
		<td style="background-color:#CCCCCC;height:1px;width:100%" colspan=2></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan=2>
			<table>
				<tr>
					<td width=170><%=Translate.Translate("Tidspunkt")%></td>
					<td><i><%=Dates.ShowDate(CDate(Dates.DWNow()), Dates.Dateformat.Short, True)%></i></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Periode")%></td>
					<td><i><%=Dates.ShowDate(CDate(objStatistic.Statv2SettingsFrom), Dates.Dateformat.Short, True)%> - <%=Dates.ShowDate(CDate(objStatistic.Statv2SettingsTo), Dates.Dateformat.Short, True)%> (<%=Translate.Translate("%% dage", "%%", CStr(DateDiff("D", objStatistic.Statv2SettingsFrom, objStatistic.Statv2SettingsTo) + 1))%>)</i></td>
				</tr>
				<%	If objStatistic.Statv2SettingsArea <> "" Then%>
				<tr>
					<td><%=Translate.Translate("Sprog")%></td>
					<td><i><%=Base.GetAreaName(objStatistic.Statv2SettingsArea)%></i></td>
				</tr>
				<%	End If%>
			</table>
		</td>
	</tr>
</table>
<%End If%>
<table cellpadding=0 cellspacing=0 border=0 width=512>
	<tr>
		<td colspan=2>&nbsp;<span id="statusText" style="margin-left:35px;color:#990000;"><%=Translate.JSTranslate("Beregner rapport...")%></span></td>
	</tr>
</table>

<script>append();</script>
<%
Response.Flush()
%>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>
