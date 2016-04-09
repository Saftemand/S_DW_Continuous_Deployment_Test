<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFSummarySettings_edit.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFSummarySettings_edit" %>
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
		<%=Gui.MakeHeaders(translate.translate("Rediger rapport"), translate.translate("Rediger rapport"), "all")%>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<tbody>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="SummaryInfo" title="Summary detail" runat="server"></dw:groupboxstart>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td width="170">&nbsp;<%=translate.translate("Navn")%></td>
									<td>
										<asp:TextBox id="txtName" MaxLength="255" runat="server" CssClass="std"></asp:TextBox>
										<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="- required field" ControlToValidate="txtName"></asp:RequiredFieldValidator>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<table border="0" cellpadding="0" width="100%">
											<asp:repeater id="_rpt" runat="server">
												<HeaderTemplate>
													<tr>
														<td colspan="3">&nbsp;</td>
													</tr>
													<tr>
														<td align="left" width="500"><strong>&nbsp;<%=Translate.translate("Indhold")%></strong></td>
														<td align="left" nowrap><strong><%=Translate.translate("Sorter")%></strong></td>
														<td align="left" nowrap><strong><%=Translate.translate("Slet")%></strong></td>
													</tr>
													<tr>
														<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
													</tr>
												</HeaderTemplate>
												<ItemTemplate>
													<tr>
														<td align="left">&nbsp;<%#_listIds.Htab(Container.DataItem)%></a></td>
														<td align="center" nowrap>
															<table border="0" cellpadding="0" cellspacing="0">
																<tr>
																	<td nowrap width="15"><%#GetSortLink("up")%></td>
																	<td nowrap width="15"><%#GetSortLink("down")%></td>
																</tr>
															</table>
														</td>
														<td align="center"><a href="<%#GetDeleteLink()%>"><img src="/Admin/Images/Icons/Page_Delete.gif" border="0" /></a></td>
													</tr>
												</ItemTemplate>
												<SeparatorTemplate>
													<tr>
														<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
													</tr>
												</SeparatorTemplate>
												<FooterTemplate>
													<%if _listIds.List.Count = 0 then%>
													<tr>
														<td colspan="3"></td>
													</tr>
													<%end if%>
													<tr>
														<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
													</tr>
													<tr>
														<td colspan="3">&nbsp;</td>
													</tr>
												</FooterTemplate>
											</asp:repeater>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
							</table>
							<dw:groupboxend id="SummaryInfoEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td align="left">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="left">
										&nbsp;<asp:Button id="AddReports" runat="server" Text="Add" CssClass="buttonSubmit" CausesValidation="False"></asp:Button>
									</td>
									<td align="right">
							        <table>
								        <tr>
								        <td><asp:Button id="btnSave" runat="server" Text="Ok" CssClass="buttonSubmit"></asp:Button></td>
										<td><asp:Button id="btnCancel" runat="server" Text="Cancel" CssClass="buttonSubmit" CausesValidation="False"></asp:Button></td>
										<%=Gui.HelpButton("", "modules.statisticsv3.general.toolbar.customsummaries.edit")%>
									</td>
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