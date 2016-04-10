<%@ Page CodeBehind="FAQ_Category_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Category_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim CategoryName As String
Dim CategoryID As integer
Dim FAQCategoryApprovalType As Integer

CategoryName = request.QueryString.Item("CategoryName")
CategoryID = Base.ChkNumber(request.QueryString.Item("CategoryID"))

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<script>
function checkinput(){
	if(document.all.CategoryName.value.length < 1)
	{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>.');
		document.all.CategoryName.focus();
		return false;
	}
	else if(document.all.CategoryName.value.length > 50)
	{
		alert('<%=Translate.JsTranslate("Max %% tegn i: ", "%%", "50") & Translate.JsTranslate("Navn")%>');
		document.all.CategoryName.focus();
		return false;
	}
	else
	{
	    document.getElementById('CategoryForm').submit()
	}
	return true
}
</script>

<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%", Translate.Translate("FAQ",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori"), "all")%>
	<table border="0" cellpadding="0" cellspacing="0" class="TabTable" style="height:180px;">
		<form action="FAQ_Category_Save.aspx" method="post" name="CategoryForm">
		<input type="Hidden" name="CategoryID" value="<%=CategoryID%>">
		<tr>
			<td valign="top"><br>
				<div id="Tab1" style="display:;">
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table border="0" cellpadding="0" cellspacing="0"  width="100%">
					<tr>
						<td width=170><%=Translate.Translate("Navn")%></td>
						<td><input type="text" name="CategoryName" value="<%=Server.HtmlEncode(CategoryName)%>" maxlength="255" class="std"></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				</div>
			</td>
		</tr>
		<tr>
			<td align="right" valign="bottom">
				<%=Gui.MakeOkCancelHelp("checkinput();", "javascript:history.back(1)", True, "modules.faq.general.list.edit", "faq")%>
			</td>
		</tr>
		</form>
	</table>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
