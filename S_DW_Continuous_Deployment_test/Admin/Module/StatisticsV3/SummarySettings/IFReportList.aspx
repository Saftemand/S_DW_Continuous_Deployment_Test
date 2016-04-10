<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFReportList.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFReportList" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="../StatCss.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body>
			<form id="Form1" method="post" runat="server">
		<%=Gui.MakeHeaders(translate.translate("Rediger indhold"), translate.translate("Rediger indhold"), "all")%>
		<table border="0" cellpadding="0" cellspacing="0"  class="tabTable">
				<tbody>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top" align="left">
							<dw:groupboxstart id="ReportGroup" title="Report list" runat="server"></dw:groupboxstart>
								<table border="0" cellpadding="0" width="100%">
									<asp:repeater id="ReportRepeater" runat="server" OnItemDataBound="ItemBound">
										<HeaderTemplate>
											<tr>
												<td colspan="2">&nbsp;</td>
											</tr>
											<tr>
												<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
											</tr>
										</HeaderTemplate>
										<ItemTemplate>
											<tr>
												<td align="left"><%#DataBinder.Eval(Container.DataItem, "Statv2ReportName")%></a></td>
												<td align="center"><%#CreateCheckBox(DataBinder.Eval(Container.DataItem, "Statv2ReportID"))%></td>
											</tr>
											<tr>
												<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
											</tr>
										</ItemTemplate>
										<FooterTemplate>
											<tr>
												<td colspan="2">&nbsp;</td>
											</tr>
										</FooterTemplate>
									</asp:repeater>
								</table>
							<dw:groupboxend id="ReportGroupEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td align="right">
							<table>
								<tr>
						        <td><asp:Button id="btnAdd" runat="server" Text="Add" CssClass="buttonSubmit"></asp:Button></td>
						        <td><asp:Button id="btnCancel" runat="server" Text="Cancel" CssClass="buttonSubmit"></asp:Button></td>
						        <%=Gui.HelpButton("", "modules.statisticsv3.general.toolbar.customsummaries.edit.content.edit")%>
							</tr>
							</table>
						</td>
					</tr>
				</tbody>
		</table>
			</form>
	</body>
</HTML>
<%Translate.GetEditOnlineScript()%>