<%@ Page CodeBehind="NewsletterExtended_Filter_Options.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Filter_Options" %>
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
	cmdSelect.CommandText = "SELECT * FROM NewsletterExtendedFilter WHERE NewsletterFilterID = " & strID
	Dim drNewsletter		As IDataReader	 = cmdSelect.ExecuteReader()
	
	If drNewsletter.Read() Then
		Name = drNewsletter("NewsletterFilterName").ToString
		Description = drNewsletter("NewsletterFilterDescription").ToString
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
<title>Newsletter Filter List</title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function Send(){
	if (document.getElementById('NewsletterExtendedCategory').NewsletterCategoryName.value.length < 1)
	{
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		return false;
	}
	if(document.getElementById('NewsletterExtendedCategory').NewsletterCategoryName.value.length > 75)
	{
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","75")%><%=Translate.JSTranslate("Navn")%>");
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
<%=Gui.MakeHeaders(Translate.Translate("Filter indstilling"), Translate.Translate("Indstillinger"), "javascript")%>
<body LEFTMARGIN="20" TOPMARGIN="16">
<%=Gui.MakeHeaders(Translate.Translate("Filter indstilling"), Translate.Translate("Indstillinger"), "html")%>

<table border="0" cellpadding="0" cellspacing="0" width="600" class="tabTable">
	<form name="NewsletterExtendedCategory" id="NewsletterExtendedCategory" method="post" action="NewsletterExtended_category_save.aspx">
	<tr>
		<td valign="top"><br>
			<div id="Tab1">
			
			<%=Gui.GroupBoxStart(Translate.Translate("Filter"))%>
			<table cellspacing="0" border="0" cellpadding="0" width="100%">
				<tr>
					<td width=170>&nbsp;<%=Translate.Translate("Navn")%><input type="hidden" Name="CategoryID" value="<%=strID%>"></td>
					<td><input name="NewsletterCategoryName" class="std" type="Text" value="<%=Name%>"></td>
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
			
			<%=Gui.GroupBoxStart(Translate.Translate("Parameter"))%>
			<table cellspacing="0" border="0" cellpadding="3" width="100%">
				<tr>
					<td><%=Translate.Translate("Type")%></td>
					<td><%=Translate.Translate("Felt")%></td>
					<td><%=Translate.Translate("Operator")%></td>
					<td><%=Translate.Translate("VГ¦rdi")%></td>
				</tr>
				<TR>
								<td>
								<Select name="Target" ID=LinkTarget class=std>
									<option value=""><%=Translate.Translate("VГ¦lg type")%>
									<option value="_blank"><%=Translate.Translate("UserField")%>
									<option value="_top"><%=Translate.Translate("Samme vindue (_top)")%>
									<option value="_self"><%=Translate.Translate("Samme ramme (_self)")%>
								</Select>
								</td>
								<td>
								<Select name="Target" ID=LinkTarget class=std>
									<option value=""><%=Translate.Translate("PostNr")%>
									<option value="_blank"><%=Translate.Translate("Nyt vindue (_blank)")%>
									<option value="_top"><%=Translate.Translate("Samme vindue (_top)")%>
									<option value="_self"><%=Translate.Translate("Samme ramme (_self)")%>
								</Select>
								</td>
								<td>
								<div id=operator style="display:">
								<Select name="Target" ID=LinkTarget class=std>
									<option value="">=
									<option value="_blank"><%=Translate.Translate("Nyt vindue (_blank)")%>
									<option value="_top"><%=Translate.Translate("Samme vindue (_top)")%>
									<option value="_self"><%=Translate.Translate("Samme ramme (_self)")%>
								</Select>
								</td>
								</div>
								<td><input name="NewsletterCategoryName" class="std" type="Text" value="<%=Name%>"></td>
								<td width="100"><%=Gui.Button(Translate.Translate("TilfГёj"), "", 0)%> </td>
							</TR>
			</table>
			<%=Gui.GroupBoxEnd%>
			
			</div>
		</td>
	</tr>
	
	<tr valign="bottom">
		<td colspan="4" align="right">
			<%=Gui.MakeOkCancelHelp("javascript:Send();", "javascript:history.back(1);", True, "modules.newsletterextended.general.list.edit.filter.options", "newsletterV2")%>
		</td>
	</tr>
</table>
</body>
<%
Translate.GetEditOnlineScript()
%>
