<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DBIntegration_List.aspx.vb" Inherits="Dynamicweb.Admin.DBIntegration.DBIntegration_List" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Jobs_List</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
		function ConfirmDelete(elm)
		{
			return confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("job"))%>\n(' + elm.ClientCommandArgument + ')');
		}
		
		function GetNewName(elm)
		{
			var name = prompt('<%=Translate.JSTranslate("Indtast navn")%>:', "Copy of " + elm.ClientCommandArgument);
			if (name != null)
			{
				document.getElementById("NewName").value = name;
				return true;
			}
			else
				return false;
		}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="ListForm" method="post" runat="server">
			<dw:tabheader id="JobsTab" title="Jobs" runat="server" Headers="Jobs" ToolTip="Jobs"></dw:tabheader>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
				<tr>
					<td valign="top">
						<asp:repeater id="List" runat="server">
							<HeaderTemplate>
								<table border="0" cellpadding="0" width="598">
									<tr valign="top">
										<td colspan="3"><br />
										</td>
									</tr>
									<tr>
										<td align="left" width="100%"><strong>&nbsp;<%=Translate.Translate("Job")%></strong></td>
										<td align="center" nowrap><strong><%=Translate.Translate("Import")%>&nbsp;</strong></td>
										<td align="center" nowrap><strong><%=Translate.Translate("Kopier")%>&nbsp;</strong></td>
										<td align="center" nowrap><strong><%=Translate.Translate("Slet")%>&nbsp;</strong></td>
									</tr>
									<tr>
										<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
									</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr>
									<td align="left">&nbsp;<a href='DBIntegration_View.aspx?JobID=<%# DataBinder.Eval(Container.DataItem, "ID")%>'><%# DataBinder.Eval(Container.DataItem, "Name") %></a></td>
									<td align="center">
										<a href='DBIntegration_import.aspx?JobID=<%# DataBinder.Eval(Container.DataItem, "ID")%>'>
											<img src="/Admin/Images/Replace.gif" alt="<%=Translate.Translate("Import")%>" border="0"> </a>
									</td>
									<td align="center">
										<a runat="server" OnServerClick="OnCopy" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='if (!GetNewName(this)) return false;' ClientCommandArgument='<%# DataBinder.Eval(Container.DataItem, "Name")%>' ID="Copy">
											<img src="/Admin/Images/Icons/Page_Copy.gif" alt="<%=Translate.Translate("Kopier")%>" border="0"> </a>
									</td>
									<td align="center">
										<a runat="server" OnServerClick="OnDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='if (!ConfirmDelete(this)) return false;' ClientCommandArgument='<%# DataBinder.Eval(Container.DataItem, "Name")%>' ID="A1">
											<img src="/Admin/Images/Delete.gif" alt="<%=Translate.Translate("Slet")%>" border="0"> </a>
									</td>
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
							</FooterTemplate>
						</asp:repeater>
				<tr>
					<td valign="top">
						&nbsp;<dw:translatelabel id="NotFound" runat="server" Text=""></dw:translatelabel>
					</td>
				</tr>
			</table>
			</TD></TR>
			<tr>
				<td align="right" valign="bottom">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><td><%=Gui.Button(Translate.Translate("Nyt job"), "location = 'DBIntegration_View.aspx?JobID=0';", 0)%></td>
							<td width="5"></td>
							<td><%=Gui.Button(Translate.Translate("Annuller"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
							<td width="5"></td>
							<%=Gui.HelpButton("Integration", "modules.integration.general")%>
							<td width="10"></td>
						</tr>
						<tr>
							<td colspan="5" height="5"></td>
						</tr>
					</table>
				</td>
			</tr>
			</TABLE> <input type="hidden" name="NewName" id="NewName">
		</form>
	</body>
</HTML>
<%Translate.GetEditOnlineScript()%>
