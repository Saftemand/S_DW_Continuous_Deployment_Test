<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFReportData.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFReportData" codePage="65001" %>
<%@ Register TagPrefix="uc" TagName="generator" Src="../ReportGenerator.ascx" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head runat="server">
		<title></title>
        <meta http-equiv="x-ua-compatible" content="IE=EmulateIE9">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script type="text/javascript" src="Common.js?"></script>
		<style >
		.dtree A:hover{text-decoration:underline}
		</style>
		
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<div id="htmlToPDF">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<asp:Repeater ID="_rpt" Runat="server">
					<ItemTemplate>
						<tr>
							<td>
								<uc:generator id="_generator" runat="server" ReportID=<%#Container.DataItem%> ReportType=<%#_listIds.Htab(Container.DataItem)%>>
								</uc:generator>
							</td>
						</tr>
					</ItemTemplate>
				</asp:Repeater>
				<%if _listIds.List.Count = 0 then%>
				<tr>
					<td>No reports</td>
				</tr>
				<%end if%>
			</table>
			</div>
		</form>
		<script>
			window.parent.isLoadedData = true;
		</script>
	</body>
</html>
<%Translate.GetEditOnlineScript()%>
