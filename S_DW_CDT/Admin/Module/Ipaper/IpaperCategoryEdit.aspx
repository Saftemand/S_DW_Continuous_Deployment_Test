<%@ IMPORT namespace="Dynamicweb.Backend" %>
<%@ IMPORT namespace="Dynamicweb" %>
<%@ Page language="vb" autoeventwireup="false" codebehind="IpaperCategoryEdit.aspx.vb" inherits="Dynamicweb.Admin.Ipaper.Backend.IpaperCategoryEdit" %>
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
		<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Ipaper",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori"), "Html", false, "")%>
		<form action="IpaperCategoryEdit.aspx" method="post" style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" runat="server">
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable" height="100%">
				<tr>
					<td valign="top">
						<br />
						<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<table>
							<tr>
								<td width="170" style="height: 21px"><%=Translate.Translate("Navn")%></td>
								<td style="height: 21px"><asp:TextBox runat="server" ID="txtName" CssClass="std" maxLength = "50" /></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
					</td>
				</tr>
				<tr valign="bottom">
					<td align="right" colspan="2">
						<table>
							<tr>
								<td><%=Gui.Button("OK", "ValidateThisForm();", 0)%></td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "location = 'IpaperCategoryList.aspx?Tab=1';", 0)%>
                                <%=Gui.HelpButton("form", "modules.ipaper.general.category.edit")%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<%TRANSLATE.GETEDITONLINESCRIPT()%>
	</body>
</HTML>
