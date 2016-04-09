<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFExportCSV.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFExportCSV" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table width="512">
				<tr>
					<td valign="top" rowspan="4"><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td width="402"><strong style="color:#003366;"><%=Translate.Translate("Eksporter")%></strong></td>
					<td align="right" style="width:75px;"></td>
				</tr>
				<tr>
					<td style="background-color:#CCCCCC;height:1px;width:100%" colspan="2"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<%If Save2CSV Then%>
						<a href='/Files/DwStatExport.csv' target=_blank><img src='/Admin/Images/Icons/Statv2_Report_Export.gif' alt='' title ='<%=Translate.Translate("Download datafil")%>' border='0'><%=Translate.Translate("Download datafil")%></a>
						<%Else%>
						No data found.
						<%End If%>
					</td>
				</tr>
			</table>
		</form>
		<script>
			window.parent.isLoadedData = true;
			<%If Save2CSV Then%>
				window.parent.download('/DwStatExport.csv');
			<%end if%>
		</script>
	</body>
</html>
