<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SiteMap.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.SiteMap" %>
<%@ Register TagName="sitemap" TagPrefix="Asc" Src= "~/Admin/Module/StatisticsV3/Sitemap/UCSitemap.ascx"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>SiteMap</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script type="text/javascript" src="../../Module/StatisticsV3/Reports/Common.js?"></script>
		<script type="text/javascript" src="../../Module/StatisticsV3/Reports/Settings.js?"></script>
		<script src="../../Module/StatisticsV3/sitemap/sitemaptree.js" type="text/javascript"></script>
		<script type="text/javascript" language="javascript">
		    _SiteMapPageDetailFolder = "";
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">			
		    <asc:sitemap id="_sitemap" runat="server" Visible="false" />
		</form>
	</body>
</HTML>