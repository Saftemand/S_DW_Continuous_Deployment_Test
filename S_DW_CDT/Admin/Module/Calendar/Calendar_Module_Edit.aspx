<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Calendar_Module_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Calendar_Module_Edit" codePage="65001" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			10-12-2005
'	Last modfied:		2-02-2006
'
'	Purpose: List categories for the calender module
'**************************************************************************************************
Dim Sql As String
Response.Expires = -100

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function DeleteCalenderCategory(lclCalenderCategoryID,lclCalenderCategory){
	if (confirm('<%=Translate.Translate("Slet %%?", "%%", Translate.JSTranslate("kategori"))%>\n(' +  lclCalenderCategory + ')\n\n<%=Translate.Translate("ADVARSEL!")%>\n<%=Translate.Translate("Alle begivenheder i kategorien vil blive slettet!")%>')){
			location = "Calender_Category_Delete.aspx?CalenderCategoryID=" + lclCalenderCategoryID;
	}
}
</script>
<%=Gui.MakeHeaders(Translate.Translate("Aktivitetskalender",9), Translate.Translate("Kategorier"), "all")%>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<tr>
					<td valign="top">
						<div ID="Tab1" STYLE="display:;height:251px;width:598;">
							<table border="0" cellpadding="0" width="598">
								<tr valign="top">
									<td colspan="4"><br>
									</td>
								</tr>
								<tr>
									<td width="450" align="left">&nbsp;<strong><%=Translate.Translate("Kategori")%></strong></td>
									<td width="50" align="center"><strong><%=Translate.Translate("Antal")%></strong></td>
									<td width="48" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
								</tr>
								<tr>
									<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width="1" height="1" alt="" border="0"></td>
								</tr>
								<%
						Dim cnCategory	As IDbConnection	= Database.GetConn("Dynamic.mdb")
						Dim cmdSelect	As IDbCommand		= cnCategory.CreateCommand
						cmdSelect.CommandText = "SELECT * FROM CalenderCategory ORDER BY CalenderCategory"
						Dim drCategory	as IDataReader		= cmdSelect.ExecuteReader()
		
						Dim blnDrCategoryHasRows = False

						Do While drCategory.Read()
							If Not blnDrCategoryHasRows Then blnDrCategoryHasRows = True
							Dim cnCount		As IDbConnection	= Database.GetConn("Dynamic.mdb")
							Dim cmdCount	As IDbCommand		= cnCount.CreateCommand
							cmdCount.CommandText = "SELECT Count(CalenderEventCategoryID) AS Amount FROM CalenderEvent WHERE CalenderEventInclude = " & Database.SqlBool(1) & " AND CalenderEventCategoryID=" & drCategory("CalenderCategoryID")
							Dim drCount		As IDataReader		= cmdCount.ExecuteReader()
							If drCount.Read() Then
		
								If Base.HasAccess("CalenderCategories", drCategory("CalenderCategoryID")) Then
								%>
									<tr>
										<td height="17" width="450" align="left">&nbsp;<a <%If Base.HasAccess("CalenderEdit", "") Then%> href="Calender_event_list.aspx?CalenderCategoryID=<%=drCategory("CalenderCategoryID").ToString%>&CalenderCategory=<%=Base.JSEnable(drCategory("CalenderCategory").ToString)%>" <%			End If%>><%=drCategory("CalenderCategory").ToString%></a></td>
										<td width="50" align="center"><%=drCount("Amount").ToString%></td>
										<%If Base.HasAccess("CalenderDelete", "") Then%>
										<td width="48" align="center"><a href="javascript:DeleteCalenderCategory('<%=drCategory("CalenderCategoryID").ToString%>','<%=Base.JSEnable(drCategory("CalenderCategory").ToString)%>');"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.JsTranslate("Slet %%", "%%", Translate.JSTranslate("kategori"))%>"</a></td>
										<%			Else%>
										<td width="48" align="center"><img style="filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)" src="../../images/Delete.gif" border="0" alt="<%=Translate.JsTranslate("Slet %%", "%%", Translate.JSTranslate("kategori"))%>"></td>
										<%			End If%>
									</tr>
									<tr>
										<td colspan="4" bgcolor="#C4C4C4"><img src="../images/nothing.gif" width="1" height="1" alt="" border="0"></td>
									</tr>
									<%			
								End If
							End If
							drCount.Close()
							drCount.Dispose()
							cmdCount.Dispose()
							cnCount.Dispose()
						Loop 
						If Not blnDrCategoryHasRows Then%>
								<tr>
									<td colspan="4"><br /><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier"))%></strong></td>
								</tr>
						<%End If%>
							</table>
						</div>
					</td>
				</tr>
				<tr valign="bottom">
					<td colspan="4" align="right">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<%If Base.HasAccess("CalenderCreate", "") Then%>
								<td align="right"><%=Gui.Button(Translate.Translate("Ny kategori"), "window.open('Calender_category_edit.aspx','_self');", 90)%></td>
								<td width="5"></td>
								<%End If%>
								<td align="right"><%=Gui.Button(Translate.Translate("Luk"), "location='../modules.aspx'", 0)%></td>
								<%=Gui.HelpButton("calendar", "modules.calender.general.list",,5)%>
								<td width="10"></td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</body>

<%
'Cleanup
drCategory.Close()
drCategory.Dispose()
cmdSelect.Dispose()
cnCategory.Close()
cnCategory.Dispose()

Translate.GetEditOnlineScript()
%>
