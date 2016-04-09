<%@ Page CodeBehind="FAQ_Category_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Category_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			12-07-2002
'	Last modfied:		17-06-2004
'
'	Purpose: List FAQ Categories
'
'	Revision history:
'		1.1 - 17-06-2004 - David Frandsen
'		Converted to .NET
'		1.0 - 12-07-2002 - Nicolai Pedersen
'		First version.
'**************************************************************************************************

Dim NumberOfArticles As Integer

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script language="JavaScript">
function DeleteCategory(CategoryID,CategoryName){
	if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("kategori"))%>\n(' + CategoryName + ')\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.JSTranslate("Alle indlæg i kategorien vil blive slettet!")%>')){
		location = "FAQ_Category_Del.aspx?CategoryID=" + CategoryID;
	}
}
</script>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<%=Gui.MakeHeaders(Translate.Translate("FAQ",9), Translate.Translate("Kategorier"), "all")
%>
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
	<tr>
		<td valign="top">
			<br>
			<div ID="Tab1" STYLE="display:;">
			<table border="0" cellpadding="0" width="598">
				<tr>
					<td width="425"><strong><%=Translate.Translate("Kategori")%></strong></td>
					<td width="80" align="center"><strong><%=Translate.Translate("Antal")%></strong></td>
					<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
				</tr>
			<%
			
Dim cnFAQ		As IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect	As IDbCommand	 = cnFAQ.CreateCommand
cmdSelect.CommandText = "SELECT * FROM FAQCategory ORDER BY FAQCategoryName"
Dim drFAQ		As IDataReader	 = cmdSelect.ExecuteReader()

Dim blnDrFaqHasRows = False

Do While drFAQ.Read()
	If Not blnDrFaqHasRows Then blnDrFaqHasRows = True
	If Base.HasAccess("FAQCategories", drFAQ("FAQCategoryID").ToString) Then
		'Finder antal nyheder i kategorien
		Dim cnNumberOfArticles	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
		Dim cmd					As IDbCommand		= cnNumberOfArticles.CreateCommand
		'cmd.CommandText = "SELECT COUNT(*) as NumberOfArticles FROM " & "(Select FAQItemVersionParentID From FAQItem " & " WHERE FAQItemActive = " & Database.SqlBool(1) & " AND FAQItemCategoryID =" & CStr(drFAQ("FAQCategoryID")) & " Group By FAQItemVersionParentID) AS FAQItem2"
		cmd.CommandText = "SELECT COUNT(*) as NumberOfArticles FROM FAQItem " & " WHERE FAQItemActive = " & Database.SqlBool(1) & " AND FAQItemCategoryID =" & CStr(drFAQ("FAQCategoryID"))
		Dim drNumberOfArticles	As IDataReader		= cmd.ExecuteReader()
		
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
							<a href="FAQ_Item_List.aspx?CategoryID=<%=drFAQ("FAQCategoryID").ToString%>&CategoryName=<%=Server.UrlEncode(drFAQ("FAQCategoryName").ToString())%>"><%=Server.HtmlEncode(drFAQ("FAQCategoryName").ToString())%></a>
						</td>
						<td align=center>
							<%=NumberOfArticles%>
						</td>
						<td>
							<%If Base.HasAccess("FAQDelete", "") Then%>
							<a href="JavaScript:DeleteCategory('<%=drFAQ("FAQCategoryID").ToString%>','<%=Base.JSEnable(Server.HtmlEncode(drFAQ("FAQCategoryName").ToString()))%>')"><img src="../../images/Delete.gif" alt="<%=Translate.JsTranslate("Slet %%", "%%", Translate.JSTranslate("kategori"))%>" border=0></a>		
							<%		End If%>
						</td>
					</tr>
					<%		
	End If
Loop 

drFAQ.Close()
drFAQ.Dispose()
cmdSelect.Dispose()
cnFAQ.Dispose()
%>
			    <tr>
			      <td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			    </tr>
				<tr>
				  <td colspan="4">&nbsp;</td>
				</tr>
				<%If Not blnDrFaqHasRows Then%>
				<tr>
					<td colspan="4">
						<%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier"))%>
					</td>
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
					<td><%=Gui.Button(Translate.Translate("Ny kategori"), "location='FAQ_Category_Edit.aspx'", 90)%></td>
					<td><%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
					<%=Gui.HelpButton("faq", "modules.faq.general.list")%>
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
