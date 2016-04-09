<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Post_List.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Post_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<HTML>
	<HEAD>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
			<script language="javascript" src="Navigation.js"></script>
			<script language="javascript">
			<!--
				function ConfirmPostDelete(post)
				{
					return confirm("Delete post \"" + post.ClientCommandArgument + "\" ?");
				}
				
				function RefreshView()
				{
					<asp:Literal id="AccessProc" runat="server"></asp:Literal>
				}
			//-->
			</script>
	</HEAD>
	<body onload="RefreshView(); document.body.scroll = 'no';">
		<asp:Panel ID="FormPanel" Runat="server">
			<FORM id="ListPosts" method="post" runat="server">
				<TABLE style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; MARGIN-TOP: 2px; MARGIN-BOTTOM: 2px; BORDER-LEFT: gray 1px solid; BORDER-BOTTOM: gray 1px solid; BACKGROUND-COLOR: #ece9d8"
					cellSpacing="1" width="100%" >
					<TR>
						<TD align="left"><STRONG><%=Translate.Translate("Tråd")%>:</STRONG>&nbsp;
							<asp:Literal id="HeadText" Runat="server"></asp:Literal></TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" align="left"
					border="0">
					<TR>
						<TD vAlign="top" align="left">
							<asp:datagrid id="grdPosts" Runat="server" PageSize="10" GridLines="Horizontal" HeaderStyle-BackColor="#ece9d8"
								HeaderStyle-BorderStyle="None" BorderStyle="None" BorderColor="#ece9d8" AutoGenerateColumns="False" Width="100%"
								AllowSorting="True" AllowPaging="True" PagerStyle-Mode="NumericPages" PagerStyle-Font-Bold="True">
								<Columns>
									<asp:TemplateColumn HeaderStyle-heIght="30" HeaderText="" ItemStyle-Width="16" ItemStyle-VerticalAlign="Bottom"
										HeaderStyle-Width="16">
										<ItemTemplate>
											<a href='Post_Edit.aspx?PostID=<%# DataBinder.Eval(Container.DataItem, "ID") %>'><img alt="<%=Translate.Translate("Rediger indlæg")%>" src="/Admin/Images/Icons/Page_Approve.gif" border="0"></a>&nbsp;
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderStyle-Height="30" SortExpression="[ForumV2PostHeadline]"
										ItemStyle-Width="290" HeaderStyle-Width="290">
										<HeaderTemplate><strong><%=Translate.Translate("Overskrift")%></strong></HeaderTemplate>
										<ItemTemplate>
											<a href='Post_Edit.aspx?PostID=<%# DataBinder.Eval(Container.DataItem, "ID") %>'>
												<%# DataBinder.Eval(Container.DataItem, "Headline") %>
											</a>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn SortExpression="Author" ItemStyle-Width="93"
										HeaderStyle-Width="93">
										<HeaderTemplate><strong><%=Translate.Translate("Opretter")%></strong></HeaderTemplate>
										<ItemTemplate>
											<%# DataBinder.Eval(Container.DataItem, "AuthorName") %>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn SortExpression="[ForumV2PostDate]" ItemStyle-Width="130"
										HeaderStyle-Width="130">
										<HeaderTemplate><strong><%=Translate.Translate("Dato")%></strong></HeaderTemplate>
										<ItemTemplate>
											<%# DataBinder.Eval(Container.DataItem, "CreationDateMedium") %>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
										ItemStyle-Width="45" HeaderStyle-Width="45">
										<HeaderTemplate><strong><%=Translate.Translate("Slet")%></strong></HeaderTemplate>
										<ItemTemplate>
											<a runat="server" OnServerClick="grdPosts_Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmPostDelete(this);' ClientCommandArgument='<%# HttpContext.Current.Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Headline"))%>'>
												<img src="/Admin/Images/Icons/Page_Delete.gif" alt="Delete post" border="0"></a>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid>
							<asp:literal id="noPosts" Runat="server"></asp:literal></TD>
					</TR>
				</TABLE>
			</FORM>
		</asp:Panel>
		<asp:panel id="NoAccess" Runat="server">
			<TABLE height="80%" width="100%">
				<TR>
					<TD>
						<TABLE style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; MARGIN-TOP: 2px; BORDER-LEFT: gray 1px solid; BORDER-BOTTOM: gray 1px solid; BACKGROUND-COLOR: #ffffff"
							height="40" cellPadding="1" width="100%" align="center" border="0" valign="middle">
							<TR>
								<TD vAlign="middle" align="center"><BR>
									<STRONG><FONT color="#808080">You have no permissions to process this operation.</FONT></STRONG>
								</TD>
							</TR>
							<TR>
								<TD>&nbsp;</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</asp:panel>
	</body>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>