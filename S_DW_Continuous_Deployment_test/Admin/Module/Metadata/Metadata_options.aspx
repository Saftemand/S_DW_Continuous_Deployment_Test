<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Metadata_options.aspx.vb" Inherits="Dynamicweb.Admin.Metadata.Metadata_options" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Metadata module</title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		<%=Gui.MakeHeaders(Translate.translate("Metadata"), Translate.translate("Valgmuligheder"),"all")%>
		<table border="0" cellpadding="0" cellspacing="0" class="TabTable" style="HEIGHT:180px">
				<tr>
					<td>
						<fieldset style='MARGIN: 5px;'>
							<legend class='gbTitle'>
							<%=Translate.translate("Valgmuligheder")%>&nbsp;</legend>
							<table border="0" cellpadding="0" width="570">
								<asp:repeater id="OptionRepeater" runat="server">
									<HeaderTemplate>
										<tr>
											<td colspan="2">&nbsp;</td>
										</tr>
										<tr>
											<td align="left"><strong>&nbsp;<%=Translate.translate("Valgmulighed")%></strong></td>
											<td align="left"><strong>&nbsp;<%=Translate.translate("Slet")%></strong></td>
										</tr>
										<tr>
											<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
									</HeaderTemplate>
									<ItemTemplate>
										<tr>
											<td align="left" width="93%"><a href="<%#GetEditLink(DataBinder.Eval(Container.DataItem, "OptionID"))%>"><%# DataBinder.Eval(Container.DataItem, "OptionValue")%></a></td>
											<td align="center"><a href="<%#GetDeleteLink(DataBinder.Eval(Container.DataItem, "OptionID"))%>"><img src="/Admin/Images/Icons/Page_Delete.gif" border="0" width="16" height="16"/></a></td>
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
												<td colspan="2"><%=Translate.translate("Ingen valgmuligheder")%></td>
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
						</fieldset>
					</td>
					<td></td>
				</tr>
				<tr  valign="bottom">
					<td align="right">
					    <table>
					    <tr>
					    <td>
						<asp:Button id="btnAdd" runat="server" Text="Add" CssClass="buttonSubmit"></asp:Button>
						<asp:Button id="btnCancel" runat="server" Text="Cancel" CssClass="buttonSubmit"></asp:Button>
						</td>
                        <%=Gui.HelpButton("form", "modules.metadata.general.field.edit.option.list")%>
    					</tr>
    					</table>
					</td>
				</tr>
		</table>
		</form>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
