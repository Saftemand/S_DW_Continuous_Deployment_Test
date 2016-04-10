<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFReportTitle.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFReportTitle" codePage="65001" ValidateRequest="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script type="text/javascript" src="Common.js?"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<input type="hidden" id="reportTitle" name="reportTitle" value="" />
			<input type="hidden" id="reportHtml" name="reportHtml" value="" />
		</form>
		<div id="title_content">
			<table cellpadding="0" cellspacing="0" border="0" width="512">
				<tr>
					<td valign="top" rowspan="5"><img src="<%=_hostname%>/Admin/Images/Icons/Statv2_Report_settings.gif" alt="" width="35" height="36"
							border="0"></td>
				</tr>
				<tr>
					<td width="377"><strong style="color:#003366;"><%=Translate.Translate("Indstillinger")%></strong></td>
					<td align="right" style="width:100px;">
						<%if _showButtons then%>
						<img src="<%=_hostname%>/Admin/Images/ext/xls.gif" alt="XLS <%=Translate.JSTranslate("Eksporter")%>" width="22" height="18" border="0" style="<%=_style%>" onClick="window.parent.ReloadReport('reports/IFReport.aspx<%=_query%>&Export=True');">
						<img src="<%=_hostname%>/Admin/Images/ext/pdf.gif" alt="PDF <%=Translate.JSTranslate("Eksporter")%>" width="22" height="18" border="0" style="cursor:pointer;" onClick="window.parent.exportPDF();">
						<img src="<%=_hostname%>/Admin/Images/Icons/Statv2_Report_Print.gif" alt="<%=Translate.JSTranslate("Udskriv")%>" width="16" height="16" border="0" onClick="window.parent.printReport();" style="cursor:pointer;">
						<%end if%>
					</td>
				</tr>
				<tr>
					<td style="background-color:#CCCCCC;height:1px;width:100%" colspan="2"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">
						<table>
							<tr>
								<td width="170" nowrap><%=Translate.Translate("Tidspunkt")%></td>
								<td nowrap><i><%=Dates.ShowDate(Base.ChkDate(Dates.DWNow()), Dates.DateFormat.Short, True)%></i></td>
							</tr>
							<tr>
								<td nowrap><%=Translate.Translate("Periode")%></td>
								<td nowrap><i><%=Dates.ShowDate(Base.ChkDate(objStatistic.Statv2SettingsFrom), Dates.DateFormat.Short, True)%>
										-
										<%=Dates.ShowDate(Base.ChkDate(objStatistic.Statv2SettingsTo), Dates.DateFormat.Short, True)%>
										(<%=Translate.Translate("%% dage", "%%", Base.ChkString(DateDiff("D", objStatistic.Statv2SettingsFrom, objStatistic.Statv2SettingsTo) + 1))%>)</i></td>
							</tr>
							<tr>
								<td><dw:translatelabel id="LanguageLabel" runat="server" Text="Sprog"></dw:translatelabel></td>
								<td><i><asp:label id="SettingsAreaLabel" runat="server" Text=""></asp:label></i></td>
							</tr>
							<%If Base.ChkBoolean(Base.Request("Export")) Or _isPdf Then%>
							<tr>
								<td><%=Translate.Translate("Eksporter")%></td>
								<td><a href="<%=_hostname%>/Admin/Public/download.aspx?File=<%=IIf(_isPdf, _filePathPdf,_filePathXls)%>" target="_blank"><img src="<%=_hostname%>/Admin/Images/Icons/Statv2_Report_Export.gif" border="0" align="absmiddle"
											width="16" height="16">Download</a></td>
							</tr>
							<%End If%>
						</table>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" border="0" width="512">
				<tr>
					<td colspan="2">&nbsp;<span id="statusText" style="margin-left:35px;color:#990000;display:;"><%=Translate.Translate("Beregner rapport...")%></span></td>
				</tr>
			</table>
			<script>
				window.parent.append();
				window.parent.downloadXLSExport('<%=_filePathXls%>');
			</script>
			<%if _isPdf then%>
			<script>
					<%_filePathPdf += "&StatisticsPdf=True" %>
					window.parent.download('<%=_filePathPdf%>');
			</script>
			<%end if%>
		</div>
	</body>
</html>
<%Translate.GetEditOnlineScript()%>
