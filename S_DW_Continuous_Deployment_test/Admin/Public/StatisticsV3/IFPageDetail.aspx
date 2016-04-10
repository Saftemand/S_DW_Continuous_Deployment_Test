<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFPageDetail.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFPageDetail" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		<table  cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
			<tr>
			<td align="center" valign="top">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" align="center">
				<asp:repeater id="_fromRepeater" runat="server">
					<HeaderTemplate>
						<tr>
							<td colspan="4">&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="82%"><strong>&nbsp;<%=Translate.translate("Fra (Top 10)")%></strong></td>
							<td width="12%"><strong>&nbsp;<%=Translate.translate("Antal")%></strong></td>
							<td align="center"><strong>&nbsp;<%=Translate.translate("%")%></strong></td>
						</tr>
						<tr>
							<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr>
							<td><%#CountRowsFrom%></td>
							<td align="left">&nbsp;<a href="<%#DataBinder.Eval(Container.DataItem, "PageUrl")%>" title="<%#GetPageName(DataBinder.Eval(Container.DataItem, "ID"), DataBinder.Eval(Container.DataItem, "Url"), false)%>" target="_blank">
									<%#GetPageName(DataBinder.Eval(Container.DataItem, "ID"), DataBinder.Eval(Container.DataItem, "Url"))%>
								</a>
							</td>
							<td align="center"><%#DataBinder.Eval(Container.DataItem, "Count")%></td>
							<td align="center"><%#Percentage(_totalCountFrom, DataBinder.Eval(Container.DataItem, "Count"))%>%</td>
						</tr>
					</ItemTemplate>
					<SeparatorTemplate>
						<tr>
							<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
						</tr>
					</SeparatorTemplate>
					<FooterTemplate>
						<tr>
							<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
						</tr>
						<tr>
							<td colspan="4">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="4" align="center" valign="bottom"><img src="/Admin/Images/Attach90.gif" width="32" height="32" /></td>
						</tr>
					</FooterTemplate>
				</asp:repeater>
				<tr>
					<td colspan="4" align="center"><strong> <a href="/Default.aspx?ID=<%=_detailId%>" title="" target="_blank">
								<%=GetPageName(_detailId, "")%>
							</a></strong>
					</td>
				</tr>
				<asp:repeater id="_toRepeater" runat="server">
					<HeaderTemplate>
						<tr>
							<td colspan="4" align="center" valign="bottom"><img src="/Admin/Images/Attach90.gif" width="32" height="32" /></td>
						</tr>
						<tr>
							<td colspan="4">&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><strong>&nbsp;<%=Translate.translate("Til (Top 10)")%></strong></td>
							<td><strong>&nbsp;<%=Translate.translate("Antal")%></strong></td>
							<td><strong>&nbsp;<%=Translate.translate("%")%></strong></td>
						</tr>
						<tr>
							<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr>
							<td><%#CountRowsTo%></td>
							<td align="left">&nbsp;<a href="<%#DataBinder.Eval(Container.DataItem, "PageUrl")%>" title="<%#GetPageName(DataBinder.Eval(Container.DataItem, "ID"), DataBinder.Eval(Container.DataItem, "Url"), false)%>" target="_blank">
									<%#GetPageName(DataBinder.Eval(Container.DataItem, "ID"), DataBinder.Eval(Container.DataItem, "Url"))%>
								</a>
							</td>
							<td align="center"><%#DataBinder.Eval(Container.DataItem, "Count")%></td>
							<td align="center"><%#Percentage(_totalCountTo, DataBinder.Eval(Container.DataItem, "Count"))%>%</td>
						</tr>
					</ItemTemplate>
					<SeparatorTemplate>
						<tr>
							<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
						</tr>
					</SeparatorTemplate>
					<FooterTemplate>
						<tr>
							<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
						</tr>
						<tr>
							<td colspan="4">&nbsp;</td>
						</tr>
					</FooterTemplate>
				</asp:repeater>
			</table>
			</td>
			</tr>
			<tr align="right" valign="bottom">
					<td><input id="btnClose" type="button" class="buttonSubmit" value="<%=Translate.Translate("Luk")%>" onclick="window.close();"/></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
<%Translate.GetEditOnlineScript()%>
