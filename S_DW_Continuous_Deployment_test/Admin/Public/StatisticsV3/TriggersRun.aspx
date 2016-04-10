<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TriggersRun.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.TriggersRun" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>TriggersRun</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
			function ReloadPage()
			{
				document.location.href = "TriggersRun.aspx?Start=true"				
			}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:Label id="ScanStart" Runat="server"></asp:Label>&nbsp;
			<asp:Image ImageUrl="/Admin/Images/StatusRuler.gif" ID="StatusGif" Runat="server"></asp:Image>
			<br>
			<br>
			<%= _log %>
			<br>
			<asp:Label id="ScanFinish" Runat="server" Visible="False"></asp:Label>
		</form>
		<% = _reloadPageCall%>
	</body>
</HTML>
