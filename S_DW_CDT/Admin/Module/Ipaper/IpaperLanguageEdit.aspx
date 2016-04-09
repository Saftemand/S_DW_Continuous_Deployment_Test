<%@ Page language="vb" autoeventwireup="false" codebehind="IpaperLanguageEdit.aspx.vb" inherits="Dynamicweb.Admin.Ipaper.Backend.IpaperLanguageEdit" %>
<%@ IMPORT namespace="Dynamicweb.Backend" %>
<%@ IMPORT namespace="Dynamicweb" %>

<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css">
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
		
	</HEAD>
	<body>
		<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("ipaper",9),"%c%",Translate.Translate("sprog")), Translate.Translate("Sprog"), "Html", false, "")%>
		<form id="MainForm" runat="server">
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable" height="100%">
				<tr>
					<td valign="top">
						<%=Gui.GroupBoxStart(Translate.Translate("Sprog"))%>
						<table>
							<tr>
								<td style="width: 170px"><%=Translate.Translate("Navn")%></td>
								<td><asp:TextBox runat="server" ID="txtName" CssClass="std" maxLength = "50" /></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd() %>
						<br />
						<%=Gui.GroupBoxStart(Translate.Translate("Titler")) %>
						<table>
							<asp:Repeater runat="server" ID="rptLanguageKeys">
								<ItemTemplate>
									<tr>
										<td width="170"><%#Translate.Translate(DataBinder.Eval(Container.DataItem, "FriendlyName"))%></td>
										<td><input type="text" class="std" style="width: 350px" name="key_<%# DataBinder.Eval(Container.DataItem, "LanguageKeyID") %>" value="<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Value")) %>" maxLength = "255" /></td>
									</tr>
								</ItemTemplate>
							</asp:Repeater>
						</table>
						<%=Gui.GroupBoxEnd()%>
					</td>
				</tr>
				<tr valign="bottom">
					<td align="right" colspan="2">
						<table>
							<tr>
								<td><%=Gui.Button("OK", "ValidateThisForm();", 0)%></td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "location = 'IpaperCategoryList.aspx?Tab=3';", 0)%>
                                <%=Gui.HelpButton("form", "modules.ipaper.general.language.edit")%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<%TRANSLATE.GETEDITONLINESCRIPT()%>
	</body>
</HTML>
