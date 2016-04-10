<%@ Page CodeBehind="Calender_category_edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Calender_category_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			06-12-2001
'	Last modfied:		14-06-2004
'
'	Purpose: List categories for the calender module
'
'	Revision history:
'		1.0 - 17-12-2001 - Michael Skarum
'		First version.
'		1.0 - 14-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************

Response.Expires = -100
%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Calender Category List</title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function DeleteCalenderCategory(lclCalenderCategoryID,lclCalenderCategory){
	//if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("kategori"))%>\n(' + lclCalenderCategory +  '')\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.JSTranslate("Alle begivenheder i kategorien vil blive slettet!")%>')){
//			location = "Calender_Category_Del.aspx?CalenderCategoryID=" + lclCalenderCategoryID;
//	}

}

function Send(FileToHandle){
	if (document.getElementById('CalenderCategory').CalenderCategory.value.length < 1){
		alert('<%=Translate.Translate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		return false;
	}
	else if (document.getElementById('CalenderCategory').CalenderCategory.value.length > 250){
		alert("<%=Translate.JSTranslate("Max %% tegn i: ґ%f%ґ","%%","250", "ґ%f%ґ", Translate.JSTranslate("Navn"))%>");
		return false;
	}
	else{
		document.getElementById('CalenderCategory').action = FileToHandle;
		document.getElementById('CalenderCategory').submit();
	}
}
</script>
<%

Dim CalenderCategory As String

Dim cnCategory	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect	As IDbCommand		= cnCategory.CreateCommand
cmdSelect.CommandText = "SELECT * FROM CalenderCategory WHERE CalenderCategoryID = " & Base.ChkNumber(request.QueryString.Item("CalenderCategoryID"))
Dim drCategory	As IDataReader		= cmdSelect.ExecuteReader()

If drCategory.Read() Then
	CalenderCategory = drCategory("CalenderCategory")
Else
	CalenderCategory = Translate.Translate("Kategori")
End If

%>
<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Aktivitetskalender",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
	<form name="CalenderCategory" method="post" action="Calender_category_save.aspx">
	<input type="Hidden" name="CalenderCategoryID" value="<%=request.QueryString.Item("CalenderCategoryID")%>">
	<tr>
		<td valign=top><br />
			<div id="Tab1" style="display:;">
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			<table border="0" cellpadding="0" width="100%">
				<tr>
					<td width=170><%=Translate.Translate("Navn")%></td>
					<td><input type="text" name="CalenderCategory" value="<%=Server.HtmlEncode(CalenderCategory)%>" maxlength="255" class="std"></td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
			</div>
		</td>
	</tr>
	<tr valign="bottom">
		<td align="right" valign="bottom">
			<%=Gui.MakeOkCancelHelp("javascript:Send('Calender_category_save.aspx');", "javascript:history.back(1)", True, "modules.calender.general.list.edit", "calendar")%>
		</td>
	</tr>
	</form>
</table>
<%
'Cleanup
cmdSelect.Dispose()
drCategory.Dispose()
cnCategory.Dispose()
%>
</body>
<%
Translate.GetEditOnlineScript()
%>