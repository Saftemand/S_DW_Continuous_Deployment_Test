<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CategoryList.aspx.vb" Inherits="Dynamicweb.Admin.DealerSearch.Backend.CategoryList" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
			<script language="javascript">
		function delCat(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%" , Translate.JSTranslate("kategori"))%>\n('+strName+')')){
				location = "CategoryDelete.aspx?ID=" + ID;
			}
		}
		function delType(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%" , Translate.JSTranslate("forhandlertype"))%>\n('+strName+')')){
				location = "TypeDealerDelete.aspx?ID=" + ID;
			}
		}
		function delField(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%" , Translate.JSTranslate("felt"))%>\n('+strName+')')){
				location = "UserFieldDelete.aspx?ID=" + ID;
			}
		}
		function delView(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%" , Translate.JSTranslate("visning"))%>\n('+strName+')')){
				location = "ViewDelete.aspx?ID=" + ID;
			}
		}
			</script>
	</head>
	<body>
		<%
		Dim catsTxt as string = Translate.Translate("Kategorier")
		Dim TabsTxt as string = catsTxt &","& Translate.Translate("Forhandlertyper") &","& Translate.Translate("Brugerdefinerede felter") &","& Translate.Translate("Visninger")
		%>
		<%=Gui.MakeHeaders(Translate.Translate("Forhandlersøgning",9), TabsTxt, "All", false, "")%>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<tr>
					<td valign="top">
						<div id="Tab1">
							<table height="100%" cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top"><br />
										<table border="0" cellpadding="0" width="598">
											<tr>
												<td width="568"><strong><%=Translate.Translate("Kategori")%></strong></td>
												<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
											</tr>
											<tr>
												<td colspan="2" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
											</tr>
											<asp:literal id="Literal1" runat="server"></asp:literal>
										</table>
									</td>
								</tr>
								<tr>
									<td align="right" colspan="2" valign="bottom">
										<table>
											<tr>
												<td><%=Gui.Button(Translate.JSTranslate("Ny %%", "%%", Translate.JSTranslate("kategori")), "location = 'CategoryEdit.aspx';", 0)%></td>
												<td><%= Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("", "modules.DealerSearch.general.category")%>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
						<div id="Tab2" style="display: none;">
							<table height="100%" cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top"><br />
										<table border="0" cellpadding="0" width="598">
											<tr>
												<td width="568"><strong><%=Translate.Translate("Forhandlertype")%></strong></td>
												<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
											</tr>
											<tr>
												<td colspan="2" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
											</tr>
											<asp:literal id="Literal2" runat="server"></asp:literal>
										</table>
									</td>
								</tr>
								<tr>
									<td align="right" colspan="2" valign="bottom">
										<table>
											<tr>
												<td><%=Gui.Button(Translate.JSTranslate("Ny %%", "%%", Translate.JSTranslate("forhandlertype")), "location = 'TypeDealerEdit.aspx';", 0)%></td>
												<td><%= Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("", "modules.DealerSearch.general.type")%>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
						<div id="Tab3" style="display: none;">
							<table height="100%" cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top"><br />
										<table border="0" cellpadding="0" width="598">
											<tr>
												<td width="468"><strong><%=Translate.Translate("Felt")%></strong></td>
												<td width="70" align="center"><strong><%=Translate.Translate("Sorter")%></strong></td>
												<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
											</tr>
											<tr>
												<td colspan="3" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
											</tr>
											<asp:literal id="Literal3" runat="server"></asp:literal>
										</table>
									</td>
								</tr>
								<tr>
									<td align="right" colspan="3" valign="bottom">
										<table>
											<tr>
												<td><%=Gui.Button(Translate.JSTranslate("Nyt %%", "%%", Translate.JSTranslate("felt")), "location = 'UserFieldEdit.aspx';", 0)%></td>
												<td><%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("", "modules.DealerSearch.general.field")%>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
						<div id="Tab4" style="display: none;">
							<table height="100%" cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top"><br />
										<table border="0" cellpadding="0" width="598">
											<tr>
												<td width="568"><strong><%=Translate.Translate("Visning",1)%></strong></td>
												<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
											</tr>
											<tr>
												<td colspan="2" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
											</tr>
											<asp:literal id="Literal4" runat="server"></asp:literal>
										</table>
									</td>
								</tr>
								<tr>
									<td align="right" colspan="3" valign="bottom">
										<table>
											<tr>
												<td><%=Gui.Button(Translate.JSTranslate("Ny %%", "%%", Translate.JSTranslate("visning",1)), "location = 'ViewEdit.aspx';", 0)%></td>
												<td><%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("", "modules.DealerSearch.general.view")%>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
	</body>
</html>
<%=Gui.SelectTab()%>
<%Translate.GetEditOnlineScript()%>