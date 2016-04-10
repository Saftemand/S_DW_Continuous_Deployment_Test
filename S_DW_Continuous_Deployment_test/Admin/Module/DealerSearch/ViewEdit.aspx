<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ViewEdit.aspx.vb" Inherits="Dynamicweb.Admin.DealerSearch.Backend.ViewEdit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
		<%=Gui.MakeHeaders(Translate.JSTranslate("%m% - Rediger %c%","%m%",Translate.JSTranslate("Forhandlersøgning",9),"%c%",Translate.JSTranslate("visning")), Translate.JSTranslate("Visning"), "Javascript", false, "")%>

		<SCRIPT language="javascript">
		<!--
			function Show(item) {
				document.all[item].style.display = '';
			}
			function Hide(item) {
				document.all[item].style.display = 'none';
			}
			function ValidateThisForm()
			{
				var form = document.forms[0];
				var controlToValidate = form.elements["Name"];
				ValidateForm(form, controlToValidate,
					"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
			}
		//-->
		</SCRIPT>

	</head>
	<body>
	
	<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Forhandlersøgning",9),"%c%",Translate.Translate("visning",1)), Translate.Translate("Visning",1), "Html", false, "")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="height:180px;">
		<form action="ViewSave.aspx" method="post">
		<input type="hidden" name="_ID" id="_ID" value="" runat="server">
		<tr>
			<td valign="top">
				<br>
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table>
					<tr>
						<td width="170"><%=Translate.Translate("Navn")%></td>
						<td><input type="text" name="Name" id="Name" value="" class="std" runat="server"></td>
					</tr>										
				</table>
				<%=Gui.GroupBoxEnd()%>
					<table border=0 cellpadding=0 cellspacing=0 width=100%>
					<tr>
						<td id=fields style="display: none;">
							<%=Gui.GroupBoxStart(Translate.Translate("Felter"))%>				
								<table border=0 cellpadding=0 cellspacing=0 width=100%>
									<%=GetFields()%>
								</table>
							<%=Gui.GroupBoxEnd()%>
						</td>
					</tr>
				</table>								
			</td>
		</tr>
		<tr>
			<td align="right" colspan="2">
				<table>
					<tr>
						<td><%=Gui.Button(Translate.Translate("OK"), "ValidateThisForm();", 0)%></td>
						<td><%=Gui.Button(Translate.Translate("Luk"), "location = 'CategoryList.aspx?Tab=4';", 0)%></td>
					</tr>
				</table>
			</td>
		</tr>
		</form>
	</table>
  </body>
</html>
<%ShowFields()%>
<%Translate.GetEditOnlineScript()%>