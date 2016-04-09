<%@ Page CodeBehind="Tagwall_Category_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Tagwall_Category_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<script language="VB" runat="Server">

Dim strCategoryName As String
Dim strCategoryID As String

</script>


<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			12-07-2002
'	Last modfied:		10-06-2004
'
'	Purpose: File to edit items
'
'	Revision history:
'		1.0 - 12-07-2002 - Nicolai Pedersen
'		First version.
'		1.1 - 10-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************

strCategoryName = request.QueryString.Item("CategoryName")
strCategoryID = request.QueryString.Item("CategoryID")

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
	<script>
		function ValidateThisForm()
		{
			var form = document.forms["CategoryForm"];
			var controlToValidate = form.elements["CategoryName"];
			ValidateForm(form, controlToValidate,
				"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		}
	</script>
<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Opslagstavle",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori"), "all")%>
<table border="0" cellpadding="2" cellspacing="0" class="TabTable" style="height:180px;">
	<form action="Tagwall_Category_Save.aspx" method="post" name="CategoryForm">
	<input type="Hidden" name="CategoryID" value="<%=strCategoryID%>">
		<tr>
			<td valign="top"><br />
				<div ID="Tab1" STYLE="display:;">
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="170"><%=Translate.Translate("Navn")%></td>
							<td><input type="text" name="CategoryName" value="<%=Server.HtmlEncode(strCategoryName)%>" class="std" maxLength = "255"></td>
						</tr>
					</table>
				<%=Gui.GroupBoxend%>
				</div>
			</td>
		</tr>
		<tr>
			<td align="right" valign="bottom">
				<%=Gui.MakeOkCancelHelp("ValidateThisForm();", "javascript:history.back(1)", True, "modules.tagwall.general.list.edit", "Tagwall")%>
			</td>
		</tr>
	</form>
</table>	
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>