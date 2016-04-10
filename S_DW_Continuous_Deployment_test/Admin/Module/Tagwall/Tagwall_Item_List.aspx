<%@ Page CodeBehind="Tagwall_Item_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Tagwall_Item_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<script language="VB" runat="Server">

Dim sql As String
Dim ActiveImage As String
Dim CategoryName As Object

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

Dim strCategoryID As String = Cstr(request.QueryString.Item("CategoryID"))

Dim strSQL = "SELECT TagwallCategoryName FROM TagwallCategory WHERE TagwallCategoryID=" & strCategoryID

Dim cnTagwallItem	As System.Data.IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect		As IDbCommand					= cnTagwallItem.CreateCommand
cmdSelect.CommandText								= strSQL 
Dim drTagwallItem	as IDataReader					= cmdSelect.ExecuteReader()

If drTagwallItem.Read() Then
	CategoryName = drTagwallItem("TagwallCategoryName").ToString
End If
drTagwallItem.Close()


If request.QueryString.Item("SetActiveInactive") = "Active" Then
	cmdSelect.CommandText = "Update TagwallItem SET TagwallItemActive = 0 where TagwallItemID = " & request.QueryString.Item("TagwallID")
	cmdSelect.ExecuteNonQuery()
ElseIf request.QueryString.Item("SetActiveInactive") = "Inactive" Then 
	cmdSelect.CommandText = "Update TagwallItem SET TagwallItemActive = -1 where TagwallItemID = " & request.QueryString.Item("TagwallID")
	cmdSelect.ExecuteNonQuery()
End If

'Cleanup
drTagwallItem.Dispose()
cmdSelect.Dispose()
cnTagwallItem.Dispose()
%>
<html>
<head>
<script language="JavaScript">
function DeleteTagwall(TagwallID,TagwallName,CategoryID){
	if (confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("indlæg"))%>\n(" + TagwallName +")")){
		location = "Tagwall_Item_Del.aspx?TagwallID=" + TagwallID + "&CategoryID=" + CategoryID;
	}
}
</script>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<%=Gui.MakeHeaders(Translate.Translate("%m% kategori - %c%", "%m%", translate.translate("Opslagstavle",9), "%c%", CategoryName), Translate.Translate("Indlæg",1), "all")
%>
<table border="0" cellpadding="2" cellspacing="0" class="TabTable">
	<tr>
		<td valign="top">
			<br>
			<div ID="Tab1" STYLE="display:;">
				<table border="0" cellpadding="0" width="590">
					<tr>
						<td><strong><%=Translate.Translate("Indlæg")%></strong></td>
						<td width="30"><strong><%=Translate.Translate("Aktiv")%></strong></td>
						<td width="73" align="center"><strong><%=Translate.Translate("Dato")%></strong></td>
						<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>		
					</tr><%

Dim cnItems		As System.Data.IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdItems	As IDbCommand					= cnItems.CreateCommand
cmdItems.CommandText = "SELECT * FROM TagwallItem WHERE TagwallItemCategoryID = " & strCategoryID & " ORDER BY TagwallItemDate DESC"
Dim drItems		as IDataReader					= cmdItems.ExecuteReader()

Dim blnHasRow = false

Do While drItems.Read()
	If Not blnHasRow Then blnHasRow = True
	If drItems("TagwallItemActive").ToString = "-1" Or drItems("TagwallItemActive").ToString().ToLower() = "true"  Then
		If Base.HasAccess("TagwallEdit", "") Then
			ActiveImage = "<a href=""Tagwall_Item_List.aspx?TagwallID=" & drItems("TagwallItemID").ToString & "&SetActiveInactive=Active&CategoryID=" & drItems("TagwallItemCategoryID").ToString & """><img src=""../../images/Check.gif"" border=0></a>"
		Else
			ActiveImage = "<img src=""../../images/Check.gif"" border=0>"
		End If
	Else
		If Base.HasAccess("TagwallEdit", "") Then
			ActiveImage = "<a href=""Tagwall_Item_List.aspx?TagwallID=" & drItems("TagwallItemID").ToString & "&SetActiveInactive=Inactive&CategoryID=" & drItems("TagwallItemCategoryID").ToString & """><img src=""../../images/Minus.gif"" border=0></a>"
		Else
			ActiveImage = "<img src=""../../images/Minus.gif"" border=0>"
		End If
	End If
	
	
	%>
				    <tr>
				      	<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<tr>
						<%If Base.HasAccess("TagwallEdit", "") Then%>
							<td title="" OnClick="Javascript:self.location='Tagwall_Item_Edit.asp?CategoryID=<%=strCategoryID%>&TagwallID=<%=drItems("TagwallItemID").ToString%>'"><a href="Tagwall_Item_Edit.aspx?CategoryID=<%=strCategoryID%>&TagwallID=<%=drItems("TagwallItemID").ToString%>"><%=Server.HtmlEncode(Base.ChkString(drItems("TagwallItemSender")))%></a></td>	
						<%	Else%>
							<td><%=Server.HtmlEncode(Base.ChkString(drItems("TagwallItemSender")))%></td>	
						<%	End If%>
						<td align="center"><%=ActiveImage%></td>
						<td align="center"><%=Dates.ShowDate(CDate(drItems("TagwallItemDate")), Dates.Dateformat.Short, False)%></td>
						<td align="center">
							<%If Base.HasAccess("TagwallDelete", "") Then%>
							<a href="JavaScript:DeleteTagwall('<%=drItems("TagwallItemID").ToString%>','<%=Base.JSEnable(Server.HtmlEncode(Base.ChkString(drItems("TagwallItemSender"))))%>','<%=strCategoryID%>')"><img src="../../images/Delete.gif" alt="<%=Translate.Translate("Slet %%", "%%", Translate.Translate("indlæg"))%>" border=0></a>		
							<%End If%>
						</td>
					</tr>
					<%	

Loop%>
				    <tr>
				      	<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<tr>
						<td colspan="6">&nbsp;</td>
					</tr>
					<%If Not blnHasRow Then%>
					<tr>
						<td colspan="6"><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("indlæg"))%></strong></td>
					</tr>
					<%End If%>
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<table>
				<tr>
					<%If Base.HasAccess("TagwallCreate", "") Then%>
					<td><%=Gui.Button(Translate.Translate("Nyt indlæg"), "location='Tagwall_Item_Edit.aspx?CategoryID=" & strCategoryID & "'", 100)%></td>
					<%End If%>
					<%If Base.HasAccess("TagwallEdit", "") Then%>
					<td><%=Gui.Button(Translate.Translate("Rediger %%", "%%", Translate.Translate("kategori")), "location='Tagwall_Category_Edit.aspx?CategoryName=" & Base.JSEnable(Server.URLEncode(CategoryName)) & "&CategoryID=" & strCategoryID & "'", 0)%></td>
					<%End If%>
					<td><%=Gui.Button(Translate.Translate("Luk"), "location='Tagwall_Category_List.aspx'", 0)%></td>
					<%=Gui.HelpButton("Tagwall", "modules.tagwall.general.list.item")%>
				</tr>
			</table>
		</td>
	</tr>
</table>
</html>
<%
'Cleanup
drItems.Close()
drItems.Dispose()
cmdItems.Dispose()
cnItems.Dispose()

Translate.GetEditOnlineScript()
%>