<%@ Page language="vb" autoeventwireup="false" codebehind="IpaperSettingEdit.aspx.vb" inherits="Dynamicweb.Admin.Ipaper.Backend.IpaperSettingEdit" %>
<%@ IMPORT namespace="Dynamicweb" %>
<%@ IMPORT namespace="Dynamicweb.Backend" %>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html;charset=utf-8">
		<link rel="stylesheet" type="text/css" href="/admin/stylesheet.css">
		<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
		
		<script language = "javascript">
			function ValidateThisForm()
			{
				var form = document.forms[0];
				var controlToValidate = form.elements["txtName"];
				ValidateForm(form, controlToValidate, 
					"<%=Translate.JsTranslate("Der skal angives en vrdi i: %%", "%%", Translate.JsTranslate("Navn"))%>")
			}
		</script>
		
	</head>
	<body>
		<%=Gui.MakeHeaders(Translate.Translate("%m% - rediger %c%", "%m%", Translate.Translate("ipaper", 9), "%c%", Translate.Translate("Indstillinger")), Translate.Translate("Indstillinger"), "html", False, "")%>
		<table border="0" cellpadding="0" cellspacing="0" class="tabtable" height="100%">
			<form id="MainForm" runat="server">
				<input type="hidden" name="_id" id="_id" runat="server">
					<tr>
						<td valign="top"><br>
							<%=Gui.GroupBoxStart(Translate.Translate("Navn"))%>
							<table>
								<tr>
									<td style="width: 195px"><%=Translate.Translate("Navn")%></td>
									<td><asp:TextBox ID="txtName" runat="server" CssClass="std" maxLength = "50" /></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd() %>
							<br />
							<asp:Repeater ID="rptGroups" runat="server">
								<ItemTemplate>
									<%#Gui.GroupBoxStart(Translate.Translate(DataBinder.Eval(Container.DataItem, "Name")))%>
									<table>
										<asp:Repeater ID="rptSettings" runat="server" DataSource='<%# getSettings(DataBinder.Eval(Container.DataItem, "GroupID")) %>'>
											<ItemTemplate>
												<tr style="display: <%# getSettingDisplay(Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Hidden"))) %>">
													<td style="width: 195px"><%#Translate.Translate(DataBinder.Eval(Container.DataItem, "Description").ToString())%></td>
													<td>
														<%# getInputField(Container.DataItem) %>
													</td>
												</tr>
											</ItemTemplate>
										</asp:Repeater>
									</table>
									<%#Gui.GroupBoxEnd()%>
									<br />
								</ItemTemplate>
							</asp:Repeater>
						</td>
					</tr>
					<tr valign="bottom">
						<td align="right" colspan="2">
							<table>
								<tr>
									<td>
										<%=gui.button("ok", "ValidateThisForm();", 0)%>
									</td>
									<td>
										<%=gui.button(translate.translate("annuller"), "location = 'ipapercategorylist.aspx?tab=2';", 0)%>
                                        <%=Gui.HelpButton("form", "modules.ipaper.general.setting.edit")%>
									</td>
								</tr>
							</table>
						</td>
					</tr>
			</form>
			
		</table>
		<%translate.geteditonlinescript()%>
	</body>
</html>
