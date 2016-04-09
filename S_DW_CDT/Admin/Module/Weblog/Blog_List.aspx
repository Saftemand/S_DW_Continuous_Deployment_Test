<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Blog_List.aspx.vb" Inherits="Dynamicweb.Admin.Weblog.Blog_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Blog_List</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
		<script language="javascript">
			function ConfirmDelete(element)
			{
				return confirm('<%=Translate.JSTranslate("Slet")%> ' + element.ClientCommandArgument + ' ?');
			}
			
			function ValidateSettingsForm()
			{
				var ret = false;
				var pageCtrlName = "lnkPage";
				var pageCtrl = document.getElementById(pageCtrlName);
				
				if(pageCtrl)
				{
					ret = pageCtrl.value.length < 50;
					if(!ret)
					{
						alert("<%=Translate.JSTranslate("Max_%%_tegn_i:_", "%%", "50") & Translate.Translate("Side")%>");
						document.getElementById("Link_" + pageCtrlName).focus();
					}
				}
				
				if(ret)
					ret = IsEmailValid(document.getElementById("txFrom"),
						"<%=Translate.JSTranslate("Ugyldig_værdi_i:_%%", "%%", Translate.Translate("Fra_adresse"))%>");
				
				return ret;
			}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="ListBlog" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Weblog" runat="server" ToolTip="Weblog" Headers="Blogs, Ban list, Category, Settings"></dw:tabheader>
			<div id="Tab1">
				<table class="tabTable" cellSpacing="0" cellPadding="0" width="598" border="0">
					<tr>
						<td vAlign="top"><asp:repeater id="BlogList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" width="598">
										<tr valign="top">
											<td colspan="3"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="350"><strong>&nbsp;<%=Translate.translate("Navn")%></strong></td>
											<td align="center" width="200"><strong><%=Translate.translate("Oprettet")%></strong></td>
											<td align="center"><strong><%=Translate.translate("Slet")%>&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Article_List.aspx?BlogID=<%# DataBinder.Eval(Container.DataItem, "ID") %>'><%# DataBinder.Eval(Container.DataItem, "Name") %></a></td>
										<td align="center"><%# DataBinder.Eval(Container.DataItem, "CreationDateMedium") %></td>
										<td align="center">
											<a runat="server" OnServerClick="OnBlogDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmDelete(this);' ClientCommandArgument='<%# HttpUtility.HtmlDecode(DataBinder.Eval(Container.DataItem, "Name"))%>'>
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.translate("Slet")%>" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:repeater></td>
					</tr>
					<tr>
						<td vAlign="top">&nbsp;<dw:translatelabel id="BlogNotFound" runat="server" Text="Ikke fundet"></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR><tr>
					<td valign="bottom" align="right" colspan="3">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="left"><asp:literal id="PagesBlogs" Runat="server"></asp:literal></td>
								<td align="right"><%=Gui.Button(Translate.translate("Luk"), "location='/Admin/Module/Modules.aspx'", 0)%></td>
								<td width="5">&nbsp;</td>
								<%=Gui.HelpButton("Weblog", "modules.weblog.general.blogs.list")%>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colSpan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
				</TABLE></div>
			<div id="Tab2" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" width="598" border="0">
					<tr>
						<td vAlign="top"><asp:repeater id="BanList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" width="598">
										<tr valign="top">
											<td colspan="3"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="450"><strong>&nbsp;<%=Translate.translate("Adresse")%></strong></td>
											<td align="center" width="98"><strong><%=Translate.translate("Aktiv")%></strong></td>
											<td align="center"><strong><%=Translate.translate("Slet")%>&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Ban_Edit.aspx?ID=<%# DataBinder.Eval(Container.DataItem, "ID") %>'><%# DataBinder.Eval(Container.DataItem, "Address") %></a></td>
										<td align="center">
											<asp:ImageButton AlternateText="Change activity" ID="btnActive" Runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="ChangeActive" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ActiveImage") %>'>
											</asp:ImageButton>
										</td>
										<td align="center"><a runat="server" OnServerClick="OnBanDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmDelete(this);' ClientCommandArgument='<%# HttpUtility.HtmlDecode(DataBinder.Eval(Container.DataItem, "Address"))%>'>
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.translate("Slet")%>" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:repeater></td>
					</tr>
					<tr>
						<td vAlign="top">&nbsp;<dw:translatelabel id="BanNotFound" runat="server" Text="Ingen adresser fundet"></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR><tr>
					<td valign="bottom" align="right" colspan="3">
						<table cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td><%=Gui.Button(Translate.translate("Ny IP"), "location='Ban_Edit.aspx'", 0)%></td>
								<td width="5">&nbsp;</td>
								<%=Gui.HelpButton("Weblog", "modules.weblog.general.ban.list")%>
								<td width="5">&nbsp;</td>
								<td><%=Gui.Button(Translate.translate("Luk"), "location='/Admin/Module/Modules.aspx'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colSpan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
				</TABLE></div>
			<div id="Tab3" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" width="598" border="0">
					<tr>
						<td vAlign="top"><asp:repeater id="CategoryList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" width="598">
										<tr valign="top">
											<td colspan="2"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="100%"><strong>&nbsp;<%=Translate.translate("Navn")%></strong></td>
											<td align="center"><strong><%=Translate.translate("Slet")%>&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Category_Edit.aspx?CategoryID=<%# DataBinder.Eval(Container.DataItem, "ID") %>'><%# DataBinder.Eval(Container.DataItem, "Name") %></a></td>
										<td align="center">
											<a runat="server" OnServerClick="OnCategoryDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmDelete(this);' ClientCommandArgument='<%# HttpUtility.HtmlDecode(DataBinder.Eval(Container.DataItem, "Name"))%>' ID="A1">
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.translate("Slet")%>" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:repeater></td>
					</tr>
					<tr>
						<td vAlign="top">&nbsp;<dw:translatelabel id="CategoryNotFound" runat="server" Text="Ikke fundet"></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR><tr>
					<td valign="bottom" align="right" colspan="2">
						<table cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td><%=Gui.Button(Translate.translate("New category"), "location='Category_Edit.aspx'", 0)%></td>
								<td width="5">&nbsp;</td>
								<%=Gui.HelpButton("Weblog", "modules.weblog.general.categories.list")%>
								<td width="5">&nbsp;</td>
								<td><%=Gui.Button(Translate.translate("Luk"), "location='/Admin/Module/Modules.aspx'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colSpan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
				</TABLE>	
			</div>
			<div id="Tab4" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" width="598" border="0">
					<tr>
						<td vAlign="top">
							<table cellPadding="0" width="598" border="0">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td vAlign="top"><dw:groupboxstart id="SubscribeStart" title="Abonner" runat="server"></dw:groupboxstart>
										<table width="100%">
											<tr>
												<td width="200"><%=Translate.translate("Abonner")%>&nbsp;</td>
												<td><asp:checkbox id="chkSubscribe" Runat="server" Checked="False"></asp:checkbox></td>
											</tr>
											<tr>
												<td width="200"><%=Translate.translate("Fast tidspunkt")%>&nbsp;</td>
												<td><asp:checkbox id="chkMailTask" Runat="server" Checked="False"></asp:checkbox></td>
											</tr>
											<tr>
												<td><%=Translate.translate("Side")%></td>
												<td><%=Gui.LinkManager(Server.HtmlEncode(_page), "lnkPage", "")%></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td><dw:groupboxstart id="EmailStart" title="Email" runat="server"></dw:groupboxstart>
										<table width="100%">
											<tr>
												<td width="200"><%=Translate.translate("Fra_adresse")%></td>
												<td><asp:textbox id="txFrom" MaxLength="50" Runat="server" CssClass="std"></asp:textbox></td>
											</tr>
											<tr>
												<td width="200">"<%=Translate.translate("Glemt kodeord e-mail emne")%></td>
												<td><asp:textbox id="txLPSubject" MaxLength="50" Runat="server" CssClass="std"></asp:textbox></td>
											</tr>
											<tr>
												<td width="200"><%=Translate.translate("Ny artikel e-mail emne")%></td>
												<td><asp:textbox id="txBUSubject" MaxLength="50" Runat="server" CssClass="std"></asp:textbox></td>
											</tr>
											<tr>
												<td width="200"><%=Translate.translate("Template")%></td>
												<td><%=Gui.FileManager(_newPostTemplate, "Templates\Weblog\Settings", "fmNewPostTemplate") %></td>
											</tr>
											<tr>
												<td width="200"><%=Translate.translate("Element template")%></td>
												<td><%=Gui.FileManager(_newPostRowTemplate, "Templates\Weblog\Settings", "fmNewPostRowTemplate") %></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td><dw:groupboxstart id="FeaturesStart" title="Indstillinger" runat="server"></dw:groupboxstart>
										<table width="100%">
											<tr>
												<td width="200"><%=Translate.translate("Kladde")%></td>
												<td><asp:checkbox id="chkAllowDrafts" Runat="server" Checked="False"></asp:checkbox></td>
											</tr>
											<tr>
												<td width="200"><%=Translate.translate("Publicering")%></td>
												<td><asp:CheckBox ID="chkAllowPostpone" Checked="False" Runat="server"></asp:CheckBox></td>
											</tr>
											<tr>
												<td width="200"><%=Translate.translate("Frontend categories")%></td>
												<td><asp:CheckBox ID="chkFrontendCategory" Checked="False" Runat="server"></asp:CheckBox></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><asp:Button ID="cmdOK" CssClass="ButtonSubmit" Text="OK" Runat="server"></asp:Button></td>
									<td width="5">&nbsp;</td>
									<%=Gui.HelpButton("Weblog", "modules.weblog.general.settings")%>
								    <td width="5">&nbsp;</td>
									<td><%=Gui.Button(Translate.translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
									<td width="10">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2" height="5"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<%=Gui.SelectTab()%>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>