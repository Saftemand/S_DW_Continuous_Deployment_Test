<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>




<%
Dim MediaDBThumbnailsActive As String
Dim MediaDBThumbnailsMaxwidth As String
Dim MediaDBThumbnailsName As String
Dim i As Integer
Dim MediaDBThumbnailsID As String
Dim MediaDBThumbnailsBackgroundcolor As String
Dim Sql As String
Dim MediaDBThumbnailsMaxheight As String
Dim OptionNames() As String
Dim MediaDBThumbnailsTemplateName As String
Dim MediaDBThumbnailsResizePatern As String
Dim MediaDBThumbnailsQuality As String
Dim MediaDBThumbnailsBordercolor As String

If Not IsNothing(Request.QueryString("ID")) Then
	
	Dim MediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

	Sql = "SELECT * FROM MediaDBThumbnails WHERE MediaDBThumbnailsID = " & Request.QueryString("ID")
	cmdMedia.CommandText = SQL
	Dim drThumbnailsReader As IDataReader = cmdMedia.ExecuteReader

	If drThumbnailsReader.Read Then
		MediaDBThumbnailsID = drThumbnailsReader("MediaDBThumbnailsID")
		MediaDBThumbnailsName = drThumbnailsReader("MediaDBThumbnailsName")
		MediaDBThumbnailsTemplateName = drThumbnailsReader("MediaDBThumbnailsTemplateName")
		MediaDBThumbnailsMaxwidth = drThumbnailsReader("MediaDBThumbnailsMaxwidth")
		MediaDBThumbnailsMaxheight = drThumbnailsReader("MediaDBThumbnailsMaxheight")
		MediaDBThumbnailsResizePatern = drThumbnailsReader("MediaDBThumbnailsResizePatern")
		MediaDBThumbnailsQuality = drThumbnailsReader("MediaDBThumbnailsQuality")
		MediaDBThumbnailsBackgroundcolor = Base.ChkString(drThumbnailsReader("MediaDBThumbnailsBackgroundcolor"))
		MediaDBThumbnailsBordercolor = Base.ChkString(drThumbnailsReader("MediaDBThumbnailsBordercolor"))
		MediaDBThumbnailsActive = drThumbnailsReader("MediaDBThumbnailsActive")
	Else
		Response.Write("<strong>" & translate.translate("%% blev ikke fundet!", "%%", Translate.Translate("Indstillinger")) & "</strong>")
		Response.End()
	End If
	
	drThumbnailsReader.Dispose
	MediaConn.Dispose
Else
	MediaDBThumbnailsMaxwidth = 100
	MediaDBThumbnailsMaxheight = 100
	MediaDBThumbnailsResizePatern = 1
	MediaDBThumbnailsQuality = 50
	MediaDBThumbnailsBackgroundcolor = "#FFFFFF"
	MediaDBThumbnailsBordercolor = "#000000"
	MediaDBThumbnailsActive = 1
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="JavaScript">
	function Send(){
		if (document.getElementById('Thumbnail').MediaDBThumbnailsName.value.length < 1){
			document.getElementById('Thumbnail').MediaDBThumbnailsName.focus();
			alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		}
		else {
			document.getElementById('Thumbnail').submit();
		}
	}
	
	</script>
</head>
<form action="Files_Thumbnails_save.aspx" method="post" name="Thumbnail">
<input type="Hidden" value="<%=MediaDBThumbnailsID%>" name="MediaDBThumbnailsID">
<%= Gui.MakeHeaders(MediaDBThumbnailsName, Translate.Translate("Indstillinger"), "HTML")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top">
			<div id="Tab1">
			<br>
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table cellpadding=2 cellspacing=0 border=0>
					<tr>
						<td width=170><%=Translate.Translate("Navn")%></td>
						<td><INPUT TYPE="TEXT" NAME="MediaDBThumbnailsName" VALUE="<%=MediaDBThumbnailsName%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Template tag")%></td>
						<td><INPUT TYPE="TEXT" NAME="MediaDBThumbnailsTemplateName" VALUE="<%=MediaDBThumbnailsTemplateName%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Max bredde")%></td>
						<td><INPUT TYPE="TEXT" maxlength=4 NAME="MediaDBThumbnailsMaxwidth" VALUE="<%=MediaDBThumbnailsMaxwidth%>" class="std"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Max højde")%></td>
						<td><INPUT TYPE="TEXT" maxlength=4 NAME="MediaDBThumbnailsMaxheight" VALUE="<%=MediaDBThumbnailsMaxheight%>" class="std"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Kvalitet")%></td>
						<td><%=Gui.SpacListExt(MediaDBThumbnailsQuality, "MediaDBThumbnailsQuality", 20, 100, 2, "")%></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Type")%></td>
				      	<td><select name="MediaDBThumbnailsResizePatern" class=std>
						<%
						OptionNames = New String(){Translate.Translate("Max bredde og højde"), Translate.Translate("Samme bredde"), Translate.Translate("Samme højde"), Translate.Translate("Stræk")}
						For i = 1 To UBound(OptionNames) + 1
							If MediaDBThumbnailsResizePatern = i Then
								Response.Write("<option value=""" & i & """ SELECTED>" & OptionNames(i - 1) & "</option>")
							Else
								Response.Write("<option value=""" & i & """>" & OptionNames(i - 1) & "</option>")
							End If
						Next 
						%>
						</select>
						</td>
				    </tr>
					<tr>
						<td><%=Translate.Translate("Aktiv")%></td>
				      	<td><%=Gui.CheckBox(MediaDBThumbnailsActive, "MediaDBThumbnailsActive")%></td>
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
					<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='Files_Thumbnails_list.aspx'", 0)%></td>
					<td width="5"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>			
			</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%
	Translate.GetEditOnlineScript()
%>