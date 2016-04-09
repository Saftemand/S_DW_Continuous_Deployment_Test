<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IpaperList.aspx.vb" Inherits="Dynamicweb.Admin.Ipaper.Backend.IpaperList" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />

		<script language="javascript" src="functions.js"></script>

</head>
<body>
	<form runat="server">
<%=Gui.MakeHeaders(Translate.Translate("%m% kategori", "%m%", Translate.Translate("Ipaper",9)), Translate.Translate("Ipapers"), "Html", false, "")%>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
					<br>
					<table border="0" cellpadding="0" width="598">
						<tr>
							<td>
								<b>
									<%=Translate.Translate("Navn")%>
								</b>
							</td>
							<td width="30" align="center">
								<b>
									<%=Translate.Translate("Slet")%>
								</b>
							</td>
						</tr>
						<tr>
							<td colspan="2" bgcolor="#C4C4C4" style="height: 1px"></td>
						</tr>
					<asp:Repeater ID="rptPapers" runat="server">
						<ItemTemplate>
							<tr>
									<td>
										<a href="IpaperEdit.aspx?ID=<%# DataBinder.Eval(Container.DataItem, "PaperID") %>&CategoryID=<%= Request.QueryString("ID") %>">
											<%#DataBinder.Eval(Container.DataItem, "Name")%>
										</a>
									</td>
									<td style="text-align: center">
										<asp:LinkButton runat="server" ID="btnDelete" OnClick="btnDelete_Click" OnClientClick='<%# "return confirm(""" & Translate.Translate("Slet") & "?\n\n(" + Base.JSEnable(DataBinder.Eval(Container.DataItem, "Name")) + ")"")" %>' CommandArgument='<%# DataBinder.Eval(Container.DataItem, "PaperID") %>'><img src="/Admin/images/Delete.gif" style="border: 0" /></asp:LinkButton></td>
							</tr>
							<tr>
									<td colspan="2" style="background-color: #C4C4C4">
										<img src="/Admin/images/nothing.gif" style="width: 1px; height: 1px" /></td>
							</tr>
						</ItemTemplate>
					</asp:Repeater>
					</table>
				</td>
			</tr>
			<tr valign="bottom">
				<td align="right" colspan="6">
					<table>
						<tr>
							<% 	If Base.HasAccess("IpaperExtended", "") Or paperCount < 1 Then%>
							<td>
								<%=Gui.Button(Translate.JsTranslate("Opret %%", "%%", Translate.JSTranslate("Ipaper")), "location = 'IpaperEdit.aspx?ID=0&CategoryID=" & Request.QueryString("ID") & "';", 0)%>
							</td>
							<% End If %>
							<td>
								<%=Gui.Button(Translate.JSTranslate("Rediger %%", "%%", Translate.JSTranslate("kategori")), "location = 'IpaperCategoryEdit.aspx?ID=" & Request.QueryString("ID") & "';", 0)%>
							</td>
							<td>
								<%=Gui.Button(Translate.JSTranslate("Luk"), "location = 'IpaperCategoryList.aspx';", 0)%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%	Translate.GetEditOnlineScript()%>
	</form>
	</body>
</html>