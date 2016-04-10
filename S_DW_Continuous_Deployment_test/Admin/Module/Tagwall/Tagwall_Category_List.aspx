<%@ Page CodeBehind="Tagwall_Category_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Tagwall_Category_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<script language="VB" runat="Server">
Dim NumberOfArticles As Integer

</script>

<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			12-07-2002
'	Last modfied:		09-06-2004
'
'	Purpose: File to edit items
'
'	Revision history:
'		1.0 - 12-07-2002 - Nicolai Pedersen
'		First version.
'		1.1 - 09-06-2004 - David Frandsen
'		First version.
'**************************************************************************************************

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<script language="JavaScript">
function DeleteCategory(CategoryID,CategoryName){
	if (confirm("<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("kategori"))%>\n(" + CategoryName +")\n\n<%=Translate.Translate("ADVARSEL!")%>\n<%=Translate.Translate("Alle indlæg i kategorien vil blive slettet!")%>")){
		location = "Tagwall_Category_Del.aspx?CategoryID=" + CategoryID;
	}
}
</script>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<%=Gui.MakeHeaders(Translate.Translate("Opslagstavle",9), Translate.Translate("Kategorier"), "all")%>
<table border="0" cellpadding="2" cellspacing="0" class="TabTable">
	<tr>
		<td valign="top">
			<br>
			<div ID="Tab1" STYLE="display:;">
			<table border="0" cellpadding="0" width="100%">
				<tr>
					<td><strong><%=Translate.Translate("Kategori")%></strong></td>
					<td width="40" align="center"><strong><%=Translate.Translate("Indlæg",1)%></strong></td>
					<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
				</tr>
			<%
			
Dim cnTagwallCategory As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect As IDbCommand = cnTagwallCategory.CreateCommand
cmdSelect.CommandText = "SELECT * FROM TagwallCategory ORDER BY TagwallCategoryName"
Dim drTagwallCategory as IDataReader = cmdSelect.ExecuteReader()


Dim blnHasRow as Boolean = false

Do While drTagwallCategory.Read()
	If Not blnHasRow Then blnHasRow = True
	If Base.HasAccess("TagwallCategories", drTagwallCategory("TagwallCategoryID").ToString) Then
		'Finder antal nyheder i kategorien
		Dim cnNumberOfArticles As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
		Dim cmd As IDbCommand = cnNumberOfArticles.CreateCommand
		cmd.CommandText = "SELECT COUNT(*) as NumberOfArticles FROM TagwallItem WHERE TagwallItemActive = " & Database.SqlBool(1) & " AND TagwallItemCategoryID =" & drTagwallCategory("TagwallCategoryID").ToString
		Dim drNumberOfArticles as IDataReader = cmd.ExecuteReader()
		If drNumberOfArticles.Read() then
			NumberOfArticles = Cint(drNumberOfArticles("NumberOfArticles").ToString)
		Else
			NumberOfArticles = 0
		End if
		drNumberOfArticles.Close()
		drNumberOfArticles.Dispose()
		cmd.Dispose()
		cnNumberOfArticles.Dispose()
		%>
				    <tr>
				      <td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<tr>
						<td>
							<a href="Tagwall_Item_List.aspx?CategoryID=<%=drTagwallCategory("TagwallCategoryID").ToString%>&CategoryName=<%=Server.UrlEncode(drTagwallCategory("TagwallCategoryName").ToString())%>"><%=drTagwallCategory("TagwallCategoryName").ToString%></a>
						</td>
						<td align=center>
							<%=NumberOfArticles%>
						</td>
						<td>
							<%If Base.HasAccess("TagwallDelete", "") Then%>
							<a href="JavaScript:DeleteCategory('<%=drTagwallCategory("TagwallCategoryID").ToString%>','<%=Base.JSEnable(Server.HtmlEncode(drTagwallCategory("TagwallCategoryName").ToString()))%>')"><img src="../../images/Delete.gif" alt="<%=Translate.Translate("Slet %%", "%%", Translate.Translate("kategori"))%>" border=0></a>		
							<%End If%>
						</td>
					</tr>
					<%		
	End If
Loop 

%>
			    <tr>
			      <td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			    </tr>
				<%If Not blnHasRow Then%>
				<tr>
					<td colspan="4"><br /><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier"))%></strong></td>
				</tr>
				<%End If%>
				<tr>
				  <td colspan="4">&nbsp;</td>
				</tr>	
			</table>	
			</div>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
		  	<table>
				<tr>
					<td><%=Gui.Button(Translate.Translate("Ny kategori"), "location='Tagwall_Category_Edit.aspx'", 90)%></td>
					<td><%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
					<%=Gui.HelpButton("Tagwall", "modules.tagwall.general.list")%>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
<%
'Cleanup
drTagwallCategory.Close()
drTagwallCategory.Dispose()
cmdSelect.Dispose()
cnTagwallCategory.Dispose()

	Translate.GetEditOnlineScript()
%>