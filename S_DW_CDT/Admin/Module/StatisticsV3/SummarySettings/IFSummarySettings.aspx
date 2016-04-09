<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFSummarySettings.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFSummarySettings" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="../StatCss.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
		function confirmDelete()
		{
			var ret; 
			ret = confirm('<%=Translate.JSTranslate("Slet")%>?');
			return ret;
		}
		</script>
	</head>
	<body>
			<form id="Form1" method="post" runat="server">
		<%=Gui.MakeHeaders(Translate.Translate("Rapporter"), Translate.Translate("Rapporter"), "all")%>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<tbody>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td valign="top">
							<table border="0" cellpadding="0" width="100%">
								<asp:repeater id="SummaryRepeater" runat="server">
									<HeaderTemplate>
										<tr>
											<td colspan="2">&nbsp;</td>
										</tr>
										<tr>
											<td align="left" width="530"><strong>&nbsp;<%=Translate.translate("Navn")%></strong></td>
											<td align="left" nowrap><strong><%=Translate.translate("Slet")%></strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
									</HeaderTemplate>
									<ItemTemplate>
										<tr>
											<td align="left">&nbsp;<a href="<%#GetLink(DataBinder.Eval(Container.DataItem, "Statv2SummaryID"), DataBinder.Eval(Container.DataItem, "Statv2SummaryName"))%>"><%# DataBinder.Eval(Container.DataItem, "Statv2SummaryName")%></a></td>
											<td align="center"><span id="linkDelete" style="display:<%#GetStyle(DataBinder.Eval(Container.DataItem, "Statv2SummaryID"))%>"><a href="<%#GetDeleteLink(DataBinder.Eval(Container.DataItem, "Statv2SummaryID"))%>" onclick="return confirmDelete();"><img src="/Admin/Images/Icons/Page_Delete.gif" border="0" /></a></span></td>
										</tr>
									</ItemTemplate>
									<SeparatorTemplate>
										<tr>
											<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
										</tr>
									</SeparatorTemplate>
									<FooterTemplate>
										<%if _isNoData then%>
										<tr>
											<td colspan="2"></td>
										</tr>
										<%end if%>
										<tr>
											<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
										</tr>
										<tr>
											<td colspan="2">&nbsp;</td>
										</tr>
									</FooterTemplate>
								</asp:repeater>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right" colspan="2" valign="bottom">
							<table>
								<tr>
						        <td align="right" valign="bottom">
							        <asp:Button id="btnAdd" runat="server" Text="Add" CssClass="buttonSubmit"></asp:Button>&nbsp;&nbsp;
						        </td>
        						<%=Gui.HelpButton("", "modules.statisticsv3.general.toolbar.customsummaries")%>
        						</tr>
        					</table>
        				</td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</tbody>
		</table>
			</form>
		<%=_customJS%>
	</body>
</html>
<%Translate.GetEditOnlineScript()%>