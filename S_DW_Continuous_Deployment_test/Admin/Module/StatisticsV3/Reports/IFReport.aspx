<%@ Register TagPrefix="uc" TagName="generator" Src="../ReportGenerator.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFReport.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFReport" codePage="65001" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script type="text/javascript" src="../Reports/Settings.js?"></script>
	</HEAD>
	<body bgcolor="#ffffff">
		<iframe id="_ifDownl" name="_ifDownl" src="about:blank" style="display:none;"></iframe>
		<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
			<tbody>
				<tr align="left" valign="top">
					<td height="50" nowrap>
						<iframe width="100%" height="108" src="IFReportTitle.aspx<%=_query%>" frameborder="0" marginheight="0"
							marginwidth="0" name="_ifReportTitle" id="_ifReportTitle" scrolling="no"></iframe>
					</td>
				</tr>
				<% 		If Not Dynamicweb.Gui.NewUI Then%>
				<tr>
					<td height="4">
						<table cellspacing="0" cellpadding="0" border="0" >	
							<tr bgColor="#ece9d8" height="4">
								<td background="/Admin/images/SpacerBG.gif" width="557"></td>
							</tr>
						</table>
					</td>
				</tr>
				<%else %>
				<tr height="1" bgcolor="<%=Dynamicweb.Gui.NewUIbgColor%>">
					<td>
					</td>
				</tr>
				<%End If%>
				<tr align="left" valign="top">
					<td nowrap>
						<iframe width="100%" height="100%" src="<%=_file + _query%>" frameborder="0" marginheight="0"
							marginwidth="0" name="_ifReportData" id="_ifReportData"></iframe>
					</td>
				</tr>
			</tbody>
		</table>
	</body>
	<script language="javascript">
			Init();
	</script>
</HTML>
<%Translate.GetEditOnlineScript()%>
