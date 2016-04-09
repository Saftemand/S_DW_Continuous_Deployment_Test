<%@ Page Language="vb" AutoEventWireup="true" Codebehind="IpaperCategoryList.aspx.vb" Inherits="Dynamicweb.Admin.Ipaper.Backend.IpaperCategoryList" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script language="javascript" src="functions.js"></script>
	</head>
	<body>
		<%
			Dim catsTxt As String = Translate.Translate("Kategorier")
			Dim TabsTxt As String = catsTxt & "," & Translate.Translate("Settings") & "," & Translate.Translate("Sprog")
		%>
		<script type="text/javascript">
			<%# script %>
		</script>
		<%=Gui.MakeHeaders(Translate.Translate("Ipaper",9), TabsTxt, "All", false, "")%>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
					<form runat="server">
					<div id="Tab1">
						<table height="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td valign="top"><br>
									<table border="0" cellpadding="0" width="598">
										<tr>
											<td width="568"><strong><%=Translate.Translate("Kategori")%></strong></td>
											<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
										</tr>
										<tr>
											<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
										<asp:Repeater ID="rptCategories" runat="server">
											<ItemTemplate>
												<tr>
													<td><a href="IpaperList.aspx?ID=<%# DataBinder.Eval(Container.DataItem, "CategoryID") %>"><%#DataBinder.Eval(Container.DataItem, "Name")%></a></td>
														<td style="text-align: center"><asp:LinkButton runat="server" ID="btnCategoryDelete" OnClick="btnCategoryDelete_Click" OnClientClick='<%# "return confirm(""" & Translate.Translate("Slet") & "?\n\n(" + Base.JSEnable(DataBinder.Eval(Container.DataItem, "Name")) + ")"")" %>' CommandArgument='<%# DataBinder.Eval(Container.DataItem, "CategoryID") %>'><img src="/Admin/images/Delete.gif" style="border: 0" /></asp:LinkButton></td>
												</tr>
												<tr>
													<td colspan="2" style="background-color: #C4C4C4"><img src="/Admin/images/nothing.gif" style="width: 1px; height: 1px" /></td>
												</tr>
											</ItemTemplate>
										</asp:Repeater>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right" colspan="2" valign="bottom">
									<table>
										<tr>
												<% 	If Base.HasAccess("IpaperExtended", "") Or categoriesCount < 1 Then%><td><%=Gui.Button(Translate.JsTranslate("Ny %%", "%%", Translate.JsTranslate("kategori")), "location = 'IpaperCategoryEdit.aspx?ID=0';", 0)%></td><% End If %>
											<td><%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("", "modules.Ipaper.general.category")%>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					<div id="Tab2" style="DISPLAY: none">
						<table height="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td valign="top"><br>
									<table border="0" cellpadding="0" width="598">
										<tr>
											<td width="568"><strong><%=Translate.Translate("Navn")%></strong></td>
											<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
										</tr>
										<tr>
											<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
										<asp:Repeater ID="rptSettings" runat="server">
											<ItemTemplate>
												<tr>
													<td><a href="IpaperSettingEdit.aspx?ID=<%# DataBinder.Eval(Container.DataItem, "SetID") %>"><%#DataBinder.Eval(Container.DataItem, "Name")%></a></td>
														<td style="text-align: center"><asp:LinkButton runat="server" ID="btnSettingDelete" OnClick="btnSettingDelete_Click" OnClientClick='<%# "return confirm(""" & Translate.Translate("Slet") & "?\n\n(" + Base.JSEnable(DataBinder.Eval(Container.DataItem, "Name")) + ")"")" %>' CommandArgument='<%# DataBinder.Eval(Container.DataItem, "SetID") %>'><img src="/Admin/images/Delete.gif" style="border: 0" /></asp:LinkButton></td>
												</tr>
												<tr>
													<td colspan="2" style="background-color: #C4C4C4"><img src="/Admin/images/nothing.gif" style="width: 1px; height: 1px" /></td>
												</tr>
											</ItemTemplate>
										</asp:Repeater>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right" colspan="2" valign="bottom">
									<table>
										<tr>
												<% 	If Base.HasAccess("IpaperExtended", "") Or settingsCount < 1 Then%><td><%=Gui.Button(Translate.JsTranslate("Ny %%", "%%", Translate.JsTranslate("setting")), "location = 'IpaperSettingEdit.aspx?ID=0';", 0)%></td><% End If %>
											<td><%= Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("", "modules.Ipaper.general.type")%>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					<div id="Tab3" style="DISPLAY: none">
						<table height="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td valign="top"><br>
									<table border="0" cellpadding="0" width="598">
										<tr>
											<td width="468"><strong><%=Translate.Translate("Sprog")%></strong></td>
											<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
										<asp:Repeater ID="rptLanguages" runat="server">
											<ItemTemplate>
												<tr>
													<td><a href="IpaperLanguageEdit.aspx?ID=<%# DataBinder.Eval(Container.DataItem, "LanguageID") %>"><%#DataBinder.Eval(Container.DataItem, "Name")%></a></td>
														<td style="text-align: center"><asp:LinkButton runat="server" ID="btnLanguageDelete" OnClick="btnLanguageDelete_Click" OnClientClick='<%# "return confirm(""" & Translate.Translate("Slet") & "?\n\n(" + Base.JSEnable(DataBinder.Eval(Container.DataItem, "Name")) + ")"")" %>' CommandArgument='<%# DataBinder.Eval(Container.DataItem, "LanguageID") %>'><img src="/Admin/images/Delete.gif" style="border: 0" /></asp:LinkButton></td>
												</tr>
												<tr>
													<td colspan="2" style="background-color: #C4C4C4"><img src="/Admin/images/nothing.gif" style="width: 1px; height: 1px" /></td>
												</tr>
											</ItemTemplate>
										</asp:Repeater>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right" colspan="3" valign="bottom">
									<table>
										<tr>
												<% 	If Base.HasAccess("IpaperExtended", "") Or languagesCount < 1 Then%><td><%=Gui.Button(Translate.JsTranslate("Nyt %%", "%%", Translate.JsTranslate("sprog")), "location = 'IpaperLanguageEdit.aspx?ID=0';", 0)%></td><% End If %>
											<td><%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("", "modules.Ipaper.general.field")%>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					<%=Gui.SelectTab()%>
					<%Translate.GetEditOnlineScript()%>
					</form>
				</td>
			</tr>
		</table>
	</body>
</html>
