<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Thread_List.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Thread_List" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<HTML>
	<HEAD>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
			<script language="javascript" src="Navigation.js"></script>
			<script language="javascript">
			<!--
				function ConfirmThreadDelete(thread)
				{
					return confirm("<%=Translate.Translate("Slet tråd")%> \"" + thread.ClientCommandArgument + "\"?");
				}

				function GetQueryValue(name)
				{
					var query = window.location.search, part, ret;
					var start = query.indexOf(name), end;
										
					name += "=";
					if(start >= 0)
					{
						part = query.substring(start + name.length, query.length);
					
						if((end = part.indexOf("&")) == -1)
							end = query.length;
												
						ret = query.substring(start + name.length, end);
					}
					
					return ret;
				}

				function RefreshView()
				{
					if(window.location.search.indexOf("Refresh=") >= 0)
						LoadCategory(GetQueryValue("Refresh"));
						
					<asp:Literal id="AccessProc" runat="server"></asp:Literal>
				}
				function cc(objRow){ //Change color of row when mouse is over... (ChangeColor)
					objRow.style.backgroundColor='#E1DED8';
				}

				function ccb(objRow){ //Remove color of row when mouse is out... (ChangeColorBack)
					objRow.style.backgroundColor='';
				}
			//-->
			</script>
			<style>
			</style>
	</HEAD>
	<body onload="RefreshView(); document.body.scroll = 'no';">
		<asp:panel id="FormPanel" Runat="server">
			<FORM id="ListThreads" method="post" runat="server">
				<TABLE style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; MARGIN-TOP: 2px; MARGIN-BOTTOM: 2px; BORDER-LEFT: gray 1px solid; BORDER-BOTTOM: gray 1px solid; BACKGROUND-COLOR: #ece9d8"
					width="100%" bgColor="#ce0a00">
					<TR>
						<TD align="left"><STRONG><%=Translate.Translate("Kategori")%>:</STRONG>&nbsp;
							<asp:Literal id="HeadText" Runat="server"></asp:Literal></TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" align="left" border="0">
					<TR>
						<TD vAlign="top" align="left">
							<asp:datagrid id="grdThreads" Runat="server" PagerStyle-Font-Bold="True"
								PagerStyle-Mode="NumericPages" AllowPaging="True" AllowSorting="True" Width="100%" AutoGenerateColumns="False"
								BorderStyle="None" BorderColor="#ece9d8" HeaderStyle-BorderStyle="None" HeaderStyle-BackColor="#ece9d8" GridLines="Horizontal"
								PageSize="10" HeaderStyle-CssClass="gridHeader">
								<Columns>
									<asp:TemplateColumn HeaderStyle-heIght="20" HeaderText="" ItemStyle-Width="16" ItemStyle-VerticalAlign="Bottom"
										HeaderStyle-Width="16">
										<ItemTemplate>
											<a href='Thread_Edit.aspx?ThreadID=<%# DataBinder.Eval(Container.DataItem, "ID") %>'>
												<img alt="<%=Translate.Translate("Rediger tråd")%>" src="/Admin/Images/Icons/Page_Approve.gif" border="0"></a>&nbsp;
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn SortExpression="[ForumV2ThreadHeadline]"
										ItemStyle-Width="200" ItemStyle-VerticalAlign="middle" HeaderStyle-Width="200">
										<HeaderTemplate><strong><%=Translate.Translate("Overskrift")%></strong></HeaderTemplate>
										<ItemTemplate>
											<a href='Post_List.aspx?ThreadID=<%# DataBinder.Eval(Container.DataItem, "ID") %>'>
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
									<asp:TemplateColumn SortExpression="[ForumV2ThreadDate]" ItemStyle-Width="130"
										HeaderStyle-Width="130">
										<HeaderTemplate><strong><%=Translate.Translate("Dato")%></strong></HeaderTemplate>
										<ItemTemplate>
											<%# DataBinder.Eval(Container.DataItem, "CreationDateMedium") %>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
										ItemStyle-Width="45" HeaderStyle-Width="45" SortExpression="[ForumV2ThreadSticky]">
										<HeaderTemplate><strong><%=Translate.Translate("Sticky")%></strong></HeaderTemplate>
										<ItemTemplate>
											<asp:ImageButton id="btnSticky" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StickyImg") %>' OnCommand="grdThreads_ToggleSticky" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' Runat="server">
											</asp:ImageButton>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
										ItemStyle-Width="45" HeaderStyle-Width="45" SortExpression="[ForumV2ThreadClosed]">
										<HeaderTemplate><strong><%=Translate.Translate("Lukket")%></strong></HeaderTemplate>
										<ItemTemplate>
											<asp:ImageButton ID="btnClosed" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ClosedImg") %>' OnCommand="grdThreads_ToggleClosed" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' Runat="server">
											</asp:ImageButton>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
										ItemStyle-Width="45" HeaderStyle-Width="45">
										<HeaderTemplate><strong><%=Translate.Translate("Slet")%></strong></HeaderTemplate>
										<ItemTemplate>
											<a runat="server" OnServerClick="grdThreads_Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmThreadDelete(this);' ClientCommandArgument='<%# HttpContext.Current.Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Headline"))%>'>
												<img src="/Admin/Images/Icons/Page_Delete.gif" alt="<%=Translate.Translate("Slet tråd")%>" border="0"></a>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid>
							<asp:literal id="noThreads" Runat="server"></asp:literal>
						
						</TD>
					</TR>
				</TABLE>
			</FORM>
		</asp:panel><asp:panel id="NoAccess" Runat="server">
			<TABLE height="80%" width="100%">
				<TR>
					<TD>
						<TABLE style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; MARGIN-TOP: 2px; BORDER-LEFT: gray 1px solid; BORDER-BOTTOM: gray 1px solid;"
							height="40" cellPadding="1" width="100%" align="center" border="0" valign="middle">
							<TR>
								<TD vAlign="middle" align="center"><BR>
									<STRONG><FONT color="#808080"><%=Translate.Translate("Du har ikke de nødvendige rettigheder til denne funktion.")%></FONT></STRONG>
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