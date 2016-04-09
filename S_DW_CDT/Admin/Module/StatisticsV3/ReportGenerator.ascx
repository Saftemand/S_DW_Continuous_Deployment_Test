<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ReportGenerator.ascx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.ReportGenerator" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagName="sitemap" TagPrefix="Asc" src="Sitemap\UCSitemap.ascx"%>
<%@ Register TagName="StatisticsSummary" TagPrefix="Asc" src="UCReportSummary.ascx"%>
<%@ Register TagName="Statistics" TagPrefix="Asc" src="UCReportGraph.ascx"%>
<%@ Register TagName="ReportTree" TagPrefix="Asc" src="UCReportTree.ascx"%>
<%  If _reportType = Dynamicweb.StatisticsV3.ReportType.Graph Then%>
<asc:statistics id="_stat" runat="server" />
<%elseif _reportType = Dynamicweb.StatisticsV3.ReportType.Summary then%>
<asc:statisticsSummary id="_info" runat="server" />
<%elseif _reportType = Dynamicweb.StatisticsV3.ReportType.Sitemap then%>
<asc:sitemap id="_sitemap" runat="server" />
<%  ElseIf _reportType = Dynamicweb.StatisticsV3.ReportType.ReportTree Then%>
<asc:reporttree id="_reportTree" runat="server" />
<%elseif _reportType = Dynamicweb.StatisticsV3.ReportType.Header then%>
<%end if%>
