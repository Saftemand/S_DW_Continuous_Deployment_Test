<%@ Page validateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="TaskList.aspx.vb" Inherits="Dynamicweb.Admin.ScheduledTask_cpl.TaskList" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script language="javascript">
		function ConfirmDelete(elm)
		{
			return confirm('<%=Translate.JSTranslate("Slet")%> ' + elm.ClientCommandArgument);
		}
		</script>
	</HEAD>
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
	<form id="Form1" method="post" runat="server">
		<dw:TabHeader id="ListTabHeader" runat="server" title="Scheduled tasks" Headers="Konfiguration" />
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
					<div id="Tab1">
						<dw:GroupBoxStart id="SettingGroupBoxStart" runat="server" title="Indstillinger"></dw:GroupBoxStart>
							<table cellpadding='2' cellspacing='0' border='0' width='100%'>
								<TR>
									<td width=36 align=left><IMG src="/Admin/Images/Icons/cplScheduledTasks.gif"></TD>
									<td align=left nowrap style='font-size: 14; font-family: Verdana, Arial, Helvetica; font-weight: Bold;'><%=Translate.Translate("Scheduled Tasks")%></TD>
								</TR>
							</TABLE>
						<dw:GroupBoxEnd id="SettingGroupBoxEnd" runat="server"></dw:GroupBoxEnd>
						<dw:GroupBoxStart id="ListGroupBoxStart" runat="server" title="Task liste"></dw:GroupBoxStart>
							<asp:Repeater ID="TaskRepeater" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign="top">
												<table border="0" cellpadding="0" >
													<tr valign="top">
														<td colspan="6"><br></td>	
												</tr>
												<tr>
													<td align="left" width="200"><strong><%=Translate.translate("Task")%></strong></td>
													<td align="left" width="200"><strong><%=Translate.translate("Afvikles")%></strong></td>
													<td align="center" width="140"><strong><%=Translate.translate("Næste afvikling")%></strong></td>
													<td align="center" width="140"><strong><%=Translate.translate("Sidst afviklet")%></strong></td>
													<td align="center" width="20"><strong><%=Translate.translate("Aktiv")%></strong></td>
													<td align="center" width="20"><strong><%=Translate.translate("Slet")%></strong></td>
												</tr>
												<tr>
													<td colspan="6" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
												</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td valign=top align="left"><a href="TaskEdit.aspx?TaskID=<%# DataBinder.Eval(Container.DataItem, "ID")%>"><%# DataBinder.Eval(Container.DataItem, "Name") %></a></td>
										<td valign=top align="left"><%# DataBinder.Eval(Container.DataItem, "Schedule") %></td>
										<td valign=top align="center"><%# DataBinder.Eval(Container.DataItem, "NextRun") %></td>
										<td valign=top align="center"><%# DataBinder.Eval(Container.DataItem, "LastRun") %></td>
										<td valign=top align="center">
											<a runat="server" OnServerClick="OnChangeActive" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>'><img src="<%# DataBinder.Eval(Container.DataItem, "ActiveImage") %>" alt="Change active" border="0"/></a>
										</td>
										<td valign=top align="center">
											<a runat="server" OnServerClick="OnDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='if (!ConfirmDelete(this)) return false;' ClientCommandArgument='<%# Base.JSEnable(DataBinder.Eval(Container.DataItem, "Name"))%>'>
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.translate("Slet")%>" border="0">
											</a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="6" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
								<FooterTemplate>
									<tr>
										<td colspan="6" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</FooterTemplate>
							</asp:Repeater>
							<tr>
								<td valign="top">
									&nbsp;<dw:translatelabel id="NotFound" runat="server" Text="Ingen tasks oprettet"></dw:translatelabel>
								</td>
							</tr>
							</table>
							</td></tr>
							</table>
						<dw:GroupBoxEnd id="ListGroupBoxEnd" runat="server"></dw:GroupBoxEnd>
					</div>
				</td>
			</tr>
			<tr>
				<td align="right" valign="bottom">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<asp:Button id="AddTask" CssClass="buttonSubmit" runat="server" Text="Add Task"></asp:Button>
								<asp:Button id="Cancel" CssClass="buttonSubmit" runat="server" Text="Cancel"></asp:Button>
								<%=Gui.HelpButton("form", "administration.controlpanel.scheduledtasks", , 5)%>
							</td>
							<td width="10"></td>
						</tr>
						<tr>
							<td colspan="3" height="5"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>