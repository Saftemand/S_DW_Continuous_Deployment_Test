<%@ Page CodeBehind="NewsletterExtended_Category_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Category_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
Dim Description As String
Dim strID As String
Dim Sql As String
Dim Name As Object

strID = Request.QueryString.Item("ID")

If strID <> "" And Not strID = "0" Then
	Dim cnNewsletter		As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
	Dim cmdSelect			As IDbCommand	 = cnNewsletter.CreateCommand
	cmdSelect.CommandText = "SELECT * FROM NewsletterExtendedCategory WHERE NewsletterCategoryID = " & strID
	Dim drNewsletter		As IDataReader	 = cmdSelect.ExecuteReader()
	
	If drNewsletter.Read() Then
		Name = drNewsletter("NewsletterCategoryName").ToString
		Description = drNewsletter("NewsletterCategoryDescription").ToString
	End If
	
	drNewsletter.Dispose()
	cmdSelect.Dispose()
	cnNewsletter.Dispose()
End If

Response.Expires = -100
%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Calender Category List</title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function Send(){
	if (document.getElementById('NewsletterExtendedCategory').NewsletterCategoryName.value.length < 1)
	{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		return false;
	}
	if(document.getElementById('NewsletterExtendedCategory').NewsletterCategoryName.value.length > 75)
	{
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","75")%><%=Translate.JSTranslate("Kategori")%>");
		return false;
	}
	if(document.getElementById('NewsletterExtendedCategory').NewsletterCategoryDescription.value.length > 2000)
	{
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","2000")%><%=Translate.JSTranslate("Beskrivelse")%>");
		return false;
	}
	else
	{
		document.getElementById('NewsletterExtendedCategory').action = 'NewsletterExtended_category_save.aspx';
		document.getElementById('NewsletterExtendedCategory').submit();
	}
}

</script>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%", "%%", Translate.Translate("nyhedsbrevsliste")), Translate.Translate("Liste"), "javascript")%>
<body LEFTMARGIN="20" TOPMARGIN="16">
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%", "%%", Translate.Translate("nyhedsbrevsliste")), Translate.Translate("Liste"), "html")%>

<table border="0" cellpadding="0" cellspacing="0" width="600" class="tabTable">
	<form name="NewsletterExtendedCategory" id="NewsletterExtendedCategory" method="post" action="NewsletterExtended_category_save.aspx">
	<tr>
		<td valign="top"><br>
			<div id="Tab1">
			
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			<table cellspacing="0" border="0" cellpadding="0" width="100%">
				<tr>
					<td width=170>&nbsp;<%=Translate.Translate("Navn")%><input type="hidden" Name="CategoryID" value="<%=strID%>"></td>
					<td><input name="NewsletterCategoryName" class="std" type="Text" value="<%=Server.HtmlEncode(Name)%>"></td>
				</tr>
				<tr>
					<td valign="top">&nbsp;<%=Translate.Translate("Beskrivelse")%></td>
					<td><textarea class="std" name="NewsletterCategoryDescription" rows="3" cols="50"><%=Description%></textarea></td>
				</tr></form>
				<tr>
					<td colspan="2" height="5"></td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
			
			</div>
		</td>
	</tr>
	<tr valign="bottom">
		<td colspan="4" align="right">
			<%=Gui.MakeOkCancelHelp("javascript:Send();", "location='NewsletterExtended_ListList.aspx'", True, "modules.newsletterextended.general.list.edit", "newsletterV2")%>
		</td>
	</tr>
</table>
</body>
<% 
	Translate.GetEditOnlineScript()
%>