<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%
Dim MediaDBThumbnailsName As String
Dim MediaDBOrientationName As String
Dim MediaDBOrientationMinratio As Double
Dim MediaDBOrientationID As String
Dim Sql As String
Dim MediaDBOrientationMaxratio As Double


If Not IsNothing(Request.QueryString.GetValues("ID")) Then
	
	Dim connMedia As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = connMedia.CreateCommand

	Sql = "SELECT * FROM MediaDBOrientation WHERE MediaDBOrientationID = " & Request.QueryString.Item("ID")
	
	cmdMedia.CommandText = SQL

	Dim drOrientationReader As IDataReader = cmdMedia.ExecuteReader

	If drOrientationReader.Read Then
		MediaDBOrientationID = drOrientationReader("MediaDBOrientationID")
		MediaDBOrientationName = drOrientationReader("MediaDBOrientationName")
		MediaDBOrientationMinratio = drOrientationReader("MediaDBOrientationMinratio")
		MediaDBOrientationMaxratio = drOrientationReader("MediaDBOrientationMaxratio")
	Else
		Response.Write("<strong>" & translate.translate("%% blev ikke fundet!", "%%", Translate.Translate("Indstillinger")) & "</strong>")
		Response.End()
	End If
Else
	MediaDBOrientationMinratio = 0
	MediaDBOrientationMaxratio = 0
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="JavaScript">
	function Send(){
		if (document.getElementById('MediaDBOrientation').MediaDBOrientationName.value.length < 1){
			document.getElementById('MediaDBOrientation').MediaDBOrientationName.focus();
			alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JSTranslate("Navn"))%>');
		}
		else {
			document.getElementById('MediaDBOrientation').submit();
		}
	}
	
	</script>
</head>
<%= Gui.MakeHeaders(MediaDBThumbnailsName, Translate.Translate("Indstillinger"), "HTML")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
<form action="Media_Orientation_save.aspx" method="post" name="MediaDBOrientation" id="MediaDBOrientation">
<input type="hidden" value="<%=MediaDBOrientationID%>" name="MediaDBOrientationID">
	<tr>
		<td valign="top">
			<div id="Tab1">
			<br>
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width=170><%=Translate.Translate("Navn")%></td>
						<td><INPUT TYPE="TEXT" NAME="MediaDBOrientationName" VALUE="<%=MediaDBOrientationName%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Min. ratio")%></td>
						<td><INPUT TYPE="TEXT" maxlength=5 NAME="MediaDBOrientationMinratio" VALUE="<%=MediaDBOrientationMinratio%>" class="std"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Maks. ratio")%></td>
						<td><INPUT TYPE="TEXT" maxlength=5 NAME="MediaDBOrientationMaxratio" VALUE="<%=MediaDBOrientationMaxratio%>" class="std"></td>
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
					<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='Media_Orientation_list.aspx'", 0)%></td>
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