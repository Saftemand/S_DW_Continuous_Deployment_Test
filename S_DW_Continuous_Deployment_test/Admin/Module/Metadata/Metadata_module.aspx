<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Metadata_module.aspx.vb" Inherits="Dynamicweb.Admin.Metadata.Metadata_module" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Metadata module</title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
	</HEAD>
	<body>
		<%=Gui.MakeHeaders(Translate.Translate("Metadata"), Translate.Translate("Metadata"),"all")%>
		<table border="0" cellpadding="0" cellspacing="0" class="TabTable" style="height:180px;">
			<tr>
				<td colspan="1">
					<fieldset style='margin:5px;'>
						<legend class='gbTitle'><%=Translate.translate("Felter")%>&nbsp;</legend>&nbsp;
						<table border="0" cellpadding="0" width="570">
							<asp:repeater id="FieldRepeater" runat="server">
								<HeaderTemplate>
									<tr>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td align="left"><strong>&nbsp;<%=Translate.translate("Feltnavn")%></strong></td>
										<td align="left"><strong><%=Translate.translate("Feltnavn")%></strong></td>
										<td align="center"><strong><%=Translate.translate("Rediger")%></strong></td>
									</tr>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left" width="70%">&nbsp;<a href="<%#GetLink(DataBinder.Eval(Container.DataItem, "FieldID"), DataBinder.Eval(Container.DataItem, "FieldTypeID"))%>"><%# DataBinder.Eval(Container.DataItem, "FieldName")%></a></td>
										<td align="left">
											<%#DataBinder.Eval(Container.DataItem, "TypeName")%> 											
										</td>
										<td align="center">
											<a href="<%#GetEditLink(DataBinder.Eval(Container.DataItem, "FieldID"))%>"><img src="/Admin/Images/Icons/Page_edit.gif" alt="Edit" border="0" width="15" height="17"/></a>
										</td>
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
												<td colspan="3"><%=Translate.translate("Ingen felter")%></td>
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
			<tr valign="bottom">
				<td align="right">
				    <table>
				    <tr>
				    <td>
					<%=Gui.Button(Translate.translate("Annuller"), "location = '/Admin/Module/Modules.aspx';", 0)%>&nbsp;
					</td>
                    <%=Gui.HelpButton("form", "modules.metadata.general.field.list", 0)%>
                    </tr>
                    </table>
				</td>
			</tr>
		</table>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
