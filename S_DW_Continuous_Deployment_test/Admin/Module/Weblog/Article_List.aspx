<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Article_List.aspx.vb" Inherits="Dynamicweb.Admin.Weblog.Article_List" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Article_List</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
		function ConfirmArticleDelete(article)
		{
			return confirm('<%=Translate.JSTranslate("Slet")%> ' + article.ClientCommandArgument + ' ?');
		}
		function ConfirmTeammateDelete(teammate)
		{
			return confirm('<%=Translate.JSTranslate("Slet")%> ' + teammate.ClientCommandArgument + ' ?');
		}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Weblog" runat="server" Headers="Artikler, Deltagere" ToolTip="Articles"></dw:tabheader>
			<div id="Tab1">
				<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
					<tr>
						<td valign="top">
							<asp:Repeater ID="List" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" width="598">
										<tr valign="top">
											<td colspan="4"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="200"><strong>&nbsp;<%=Translate.translate("Overskrift")%></strong></td>
											<td align="center" width="150"><strong><%=Translate.translate("Kategori")%></strong></td>
											<td align="center" width="200"><strong><%=Translate.translate("Oprettelsesdato")%></strong></td>
											<td align="center"><strong><%=Translate.translate("Slet")%>&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Article_Edit.aspx?ArticleID=<%# DataBinder.Eval(Container.DataItem, "ID") %>&BlogID=<%=_blogID%>'><%# DataBinder.Eval(Container.DataItem, "Headline") %></a></td>
										<td align="center"><%# DataBinder.Eval(Container.DataItem, "CategoryName") %></td>
										<td align="center"><%# DataBinder.Eval(Container.DataItem, "CreationDateMedium") %></td>
										<td align="center">
											<a runat="server" OnServerClick="OnArticleDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmArticleDelete(this);' ClientCommandArgument='<%# Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Headline"))%>'>
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.translate("Slet")%>" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:Repeater>
						</td>
					</tr>
					<tr>
						<td valign="top">
							&nbsp;<dw:translatelabel id="ArticleNotFound" runat="server" Text="Ikke fundet"></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR>
				<tr>
					<td colspan="4" align="right" valign="bottom">
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="left"><asp:Literal ID="PagesArticles" Runat="server"></asp:Literal></td>
								<td align="right"><%=Gui.Button(Translate.translate("Annuller"), "location='Blog_List.aspx?Page=-1'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
				</TABLE>
			</div>
			<div id="Tab2" style="DISPLAY:none">
				<table cellspacing="0" cellpadding="0" width="598" border="0" class="tabTable">
					<tr>
						<td valign="top">
							<asp:Repeater ID="ListTeammates" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" width="598">
										<tr>
											<td colspan="3"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="400"><strong><%=Translate.translate("Brugernavn")%></strong></td>
											<td align="center" width="150"><strong><%=Translate.translate("Administrator")%></strong></td>
											<td align="center"><strong><%=Translate.translate("Slet")%></strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<%# Databinder.Eval(Container.DataItem, "UserName") %></td>
										<td align="center">
											<asp:ImageButton AlternateText="Change permissions" ID="btnAdmin" Runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="ChangeAdmin" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "AdminImage") %>'>
											</asp:ImageButton>
										</td>
										<td align="center">
											<a runat="server" OnServerClick="OnTeammateDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmTeammateDelete(this);' ClientCommandArgument='<%# Base.JSEnable(DataBinder.Eval(Container.DataItem, "UserName"))%>'>
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.translate("Slet")%>" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:Repeater>
						</td>
					</tr>
					<tr>
						<td valign="top">
							&nbsp;<dw:translatelabel id="TeammateNotFound" runat="server" Text="Ikke fundet"></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR>
				<tr>
					<td colspan="3" align="right" valign="bottom">
						<table width="100%" cellspacing="0" cellpadding="0" border="0">
							<TBODY>
								<tr>
									<td align="right"><%=Gui.Button(Translate.translate("Annuller"), "location='Blog_List.aspx?Page=-1'", 0)%></td>
									<td width="10">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="3" height="5"></td>
								</tr>
				</tr>
				</TBODY></TABLE></TD></TR>
			</div>
		</form>
		<%=Gui.SelectTab()%>
	</body>
</HTML>
<% 
	Translate.GetEditOnlineScript()
%>