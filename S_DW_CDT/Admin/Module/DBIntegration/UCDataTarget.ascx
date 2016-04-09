<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCDataTarget.ascx.vb" Inherits="Dynamicweb.Admin.DBIntegration.UCDataTarget" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
<%FillConnectFields()%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<TBODY>
		<TR>
			<TD width="170"></TD>
			<TD>
				<asp:checkbox id="ChbDeleteAllWhichIsNotUpdated" Width="300" Text="Delete all which is not updated"
					BorderStyle="None" runat="server"></asp:checkbox></TD>
		</TR>
<tr><td colspan="2" width="100%" align="left">
		<asp:Panel ID="_panelDatabase" Runat="server" width="100%" border="0">
			<tr>
				<td style="HEIGHT: 7px"><%=Translate.translate("Database")%></td>
				<td style="HEIGHT: 7px">
					<asp:DropDownList id="DdlDatabaseList" Runat="server" Width="300" CssClass="std" AutoPostBack="True"></asp:DropDownList></td>
			</tr>
		</asp:Panel>
</td></tr>
		<tr>
			<td width="170px"><%=Translate.translate("Tabel")%></td>
			<td><asp:DropDownList Runat="server" id="DdlTargetTable" AutoPostBack="False" Width="300" CssClass="std" />
				<asp:Button id="btnAdd" Text="Add" runat="server" CssClass="buttonSubmit"></asp:Button></td>
		</tr>
		<tr>
			<td colspan="2" align="center" valign="top">
				<table border="0" cellpadding="0" width="500">
					<asp:repeater id="_tableRepeater" runat="server">
						<HeaderTemplate>
							<tr>
								<td colspan="4">&nbsp;</td>
							</tr>
							<tr>
								<td align="left" width="85%"><strong><%=Translate.translate("Target table")%></strong></td>
								<td align="center"><strong><%=Translate.translate("Slet")%></strong></td>
							</tr>
							<tr>
								<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
							</tr>
						</HeaderTemplate>
						<ItemTemplate>
							<tr>
								<td align="left"><%# DataBinder.Eval(Container.DataItem, "Table")%></td>
								<td align="center">
									<a runat="server" OnServerClick="OnDeleteTarget" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='if (!ConfirmDelete(this)) return false;' ClientCommandArgument='<%# DataBinder.Eval(Container.DataItem, "Table")%>' ID="A1">
										<img src="/Admin/Images/Delete.gif" alt="<%=Translate.Translate("Slet")%>" border="0">
									</a>
								</td>
							</tr>
						</ItemTemplate>
						<SeparatorTemplate>
							<tr>
								<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
							</tr>
						</SeparatorTemplate>
					</asp:repeater>
					<tr>
						<td colspan="4"><asp:Label id="_noTables" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
					</tr>
					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</TBODY>
</table>
