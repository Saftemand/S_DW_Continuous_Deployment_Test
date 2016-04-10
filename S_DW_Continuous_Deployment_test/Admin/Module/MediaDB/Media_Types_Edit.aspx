<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim MediaDBThumbnailsName As String
Dim MediaDBFiletypesExtensions As String
Dim MediaDBFiletypesID As String
Dim Sql As String
Dim MediaDBFiletypesName As String

If Not IsNothing(Request.QueryString("ID")) Then
	
	Dim MediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

	Sql = "SELECT * FROM MediaDBFiletypes WHERE MediaDBFiletypesID = " & Request.QueryString("ID")
	cmdMedia.CommandText = SQL
	Dim drFiletypeReader As IDataReader = cmdMedia.ExecuteReader

	If drFiletypeReader.Read Then
		MediaDBFiletypesID = drFiletypeReader("MediaDBFiletypesID")
		MediaDBFiletypesName = drFiletypeReader("MediaDBFiletypesName")
		MediaDBFiletypesExtensions = drFiletypeReader("MediaDBFiletypesExtensions")
	Else
		Response.Write("<strong>" & translate.translate("%% blev ikke fundet!", "%%", Translate.Translate("Indstillinger")) & "</strong>")
		Response.End()
	End If
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="JavaScript">
	function Send(){
		if (document.getElementById('MediaDBFiletypes').MediaDBFiletypesName.value.length < 1){
			document.getElementById('MediaDBFiletypes').MediaDBFiletypesName.focus();
			alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		}
		else {
			document.getElementById('MediaDBFiletypes').submit();
		}
	}
	
	</script>
</head>
<%= Gui.MakeHeaders(MediaDBThumbnailsName, Translate.Translate("Indstillinger"), "HTML")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
<form action="Media_Types_save.aspx" method="post" name="MediaDBFiletypes" id="MediaDBFiletypes">
<input type="hidden" value="<%=MediaDBFiletypesID%>" name="MediaDBFiletypesID">
	<tr>
		<td valign="top">
			<div id="Tab1">
			<br>
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table cellpadding=2 cellspacing=0 border=0>
					<tr>
						<td width=170><%=Translate.Translate("Navn")%></td>
						<td><INPUT TYPE="TEXT" NAME="MediaDBFiletypesName" VALUE="<%=MediaDBFiletypesName%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td valign=top><%=Translate.Translate("Filtyper")%></td>
						<td><TEXTAREA NAME="MediaDBFiletypesExtensions" class="std" rows=4><%=MediaDBFiletypesExtensions%></TEXTAREA></td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd%>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td align="right"><%=Gui.Button(Translate.Translate("OK"), "Send();", 0)%></td>
					<td width="5"></td>
					<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='Media_Types_list.aspx'", 0)%></td>
					<td width="5"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>			
			</table>
		</td>
	</tr>
	</form>
</table>
</body>
</html>
<%
	Translate.GetEditOnlineScript()
%>