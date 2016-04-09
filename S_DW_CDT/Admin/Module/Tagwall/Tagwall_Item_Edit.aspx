<%@ Page CodeBehind="Tagwall_Item_Edit.aspx.vb" Language="vb" validateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Tagwall_Item_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<script language="VB" runat="Server">
Dim dato as New Dates
Dim strSQL As String
Dim strTagwallItemCategoryID As String
Dim strLinkToArchive As String
Dim strTagwallItemActive As String
Dim strTagwallItemText As String
Dim strTagwallItemSender As String
Dim strTagwallItemDate As String

</script>
<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			12-07-2002
'	Last modfied:		12-07-2002
'
'	Purpose: File to edit items
'
'	Revision history:
'		1.0 - 12-07-2002 - Nicolai Pedersen
'		First version.
'**************************************************************************************************
Dim strCategoryID As String
Dim strTagwallID As String

strCategoryID = Request.QueryString.Item("CategoryID")
strTagwallID = Request.QueryString.Item("TagwallID")

If Not strTagwallID = "" Then
	strSQL = "SELECT * FROM TagwallItem WHERE TagwallItemID = " & strTagwallID
	Dim cnTagwallItem	As System.Data.IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdSelect		As IDbCommand					= cnTagwallItem.CreateCommand
	cmdSelect.CommandText								= strSQL 
	Dim drTagwallItem	as IDataReader					= cmdSelect.ExecuteReader()	
	If drTagwallItem.Read() Then
		strTagwallItemCategoryID	= drTagwallItem("TagwallItemCategoryID").ToString
		strTagwallItemSender		= drTagwallItem("TagwallItemSender").ToString
		strTagwallItemDate			= drTagwallItem("TagwallItemDate").ToString
		strTagwallItemText			= drTagwallItem("TagwallItemText").ToString
		If drTagwallItem("TagwallItemActive").ToString = "-1" Or drTagwallItem("TagwallItemActive").ToString().ToLower() = "true" Then
			strTagwallItemActive		= "Checked"
		End If
	End If
	
	drTagwallItem.Close()
	drTagwallItem.Dispose()
	cmdSelect.Dispose()
	cnTagwallItem.Dispose()
Else
	strTagwallItemActive		= ""
End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<script>
function show(i) {
	hideEditor();
	if (document.all[i].style.display=='none') {
		document.all[i].style.display='';
	}else{
		document.all[i].style.display='none';
	}
}

function CheckInput() {
	if (document.getElementById('TagwallForm').TagwallItemSender.value.length < 1)	{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>.');
		return false;
	} 
	else if (document.getElementById('TagwallForm').TagwallItemSender.value.length > 255) {
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","255")%><%=Translate.JSTranslate("Afsender navn")%>");
		return false;
	}
	else {
		if(html())
		{
			document.getElementById('TagwallForm').submit();
	}
	}
}
</script>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<style>
.Settings{
	top:120px;
}
</style>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%", "%%", Translate.Translate("indlæg")), Translate.Translate("Indlæg"), "all")
%>
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
	<form action="Tagwall_Item_Save.aspx" method="post" name="TagwallForm" id="TagwallForm">
	<input type="hidden" name="CategoryID" value="<%=strCategoryID%>">
	<input type="hidden" name="TagwallID" value="<%=strTagwallID%>">
	<tr>
		<td valign="top"><br>
			<table border="0" cellpadding="0" width="100%">
				<tr>
					<td colspan=2>
						<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<table cellpadding=0>
							<tr>
								<td width=170><%=Translate.Translate("Afsender navn")%></td>	
								<td><input type="text" name="TagwallItemSender" value="<%=Server.HtmlEncode(strTagwallItemSender)%>" class="std" style="width:358px;"></td>
							</tr>
							<tr>
								<td width=170><%=Translate.Translate("Afsender dato")%></td>
								<td><%=dato.DateSelect(strTagwallItemDate, False, False, False, "TagwallItemDate")%></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Aktiv")%></td>
								<td><input type="checkbox" name="TagwallItemActive" <%=strTagwallItemActive%>  class="clean"></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
						<%=Gui.GroupBoxStart(Translate.Translate("Tekst"))%>
						<table cellpadding=0 width="100%">
							<tr>
								<td><%=Gui.Editor("TagwallItemText", 0, 0, strTagwallItemText)%></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</form>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<table>
				<tr>
					<td><%=Gui.Button(Translate.Translate("OK"), "CheckInput();", 0)%></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Tagwall_Item_List.aspx?categoryID=" & strCategoryID & strLinkToArchive & "'", 0)%></td>
					<%=Gui.HelpButton("Tagwall", "modules.tagwall.general.list.item.edit")%>
				</tr>
			</table>
		</td>
	</tr>
</table>	
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>