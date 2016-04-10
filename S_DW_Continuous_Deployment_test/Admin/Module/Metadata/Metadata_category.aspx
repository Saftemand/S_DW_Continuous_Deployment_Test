<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Metadata_category.aspx.vb" Inherits="Dynamicweb.Admin.Metadata.Metadata_category" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title><%=Translate.translate("Metadata")%></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		<%=Gui.MakeHeaders(Translate.translate("Metadata"), Translate.translate("Kategori"),"all")%>
		<table border="0" cellpadding="0" cellspacing="0" class="TabTable" style="HEIGHT:180px">
			<tr>
				<td>
					<fieldset style='MARGIN: 5px;'>
						<legend class='gbTitle'>
							<%=Translate.translate("Kategorier")%>&nbsp;</legend>
						<table border="0" cellpadding="0" width="570">
							<asp:repeater id="CategoryRepeater" runat="server">
								<HeaderTemplate>
									<tr>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
											<td align="left"><strong>&nbsp;<%=Translate.translate("Kategori")%></strong></td>
											<td align="left"><strong><%=Translate.translate("Rediger")%></strong></td>
											<td align="left"><strong><%=Translate.translate("Slet")%></strong></td>
										</tr>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left" width="85%">&nbsp;<a href="<%#GetLink(DataBinder.Eval(Container.DataItem, "CategoryID"))%>"><%# DataBinder.Eval(Container.DataItem, "CategoryName")%></a></td>
										<td align="center">
											<a href="<%#GetEditLink(DataBinder.Eval(Container.DataItem, "CategoryID"))%>"><img src="/Admin/Images/Icons/Page_edit.gif" alt="Edit" border="0" width="15" height="17"/></a>
										</td>
										<td align="center"><a href="<%#GetDeleteLink(DataBinder.Eval(Container.DataItem, "CategoryID"))%>"><img src="/Admin/Images/Icons/Page_Delete.gif" border="0" width="16" height="16" /></a></td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
								<FooterTemplate>
									<%if _isNoData then%>
											<tr>
												<td colspan="3"><%=Translate.translate("Ingen kategorier")%></td>
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
					</fieldset>
				</td>
			</tr>
			<tr>
				<td align="right">
					<asp:Button id="btnAdd" runat="server" Text="Add" CssClass="buttonSubmit"></asp:Button>
					<asp:Button id="btnCencel" runat="server" Text="Cancel" CssClass="buttonSubmit"></asp:Button>&nbsp;
				</td>
			</tr>
		</table>
		</form>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
