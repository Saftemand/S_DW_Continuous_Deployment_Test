<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

Dim MediaDBFieldID As String
Dim MediaDBFieldLocked As String
Dim MediaDBFieldSystemName As String
Dim MediaDBFieldName As String
Dim MediaDBFieldType As String
Dim MediaDBFieldTemplateName As String
Dim MediaDBFieldTypeID As String
Dim sql As String

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script>
function checkfield(){
	var x=document.getElementById('MediaDBField').MediaDBFieldSystemName.value
	var anum=/[A-Z0-9\_]+$/gi

	if (anum.test(x))
		testresult=true
	else{
		testresult=false
	}
	return (testresult)
}

function Send(FileToHandle){
	if (document.getElementById('MediaDBField').MediaDBFieldName.value.length < 1 && document.getElementById('MediaDBField').MediaDBFieldSystemName.value.length < 1){
		alert("<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JSTranslate("Navn"))%>");}
	else if (!checkfield()){
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JSTranslate("Systemnavn"))%>");}
	else{
		document.getElementById('MediaDBField').action = FileToHandle;
		document.getElementById('MediaDBField').submit();
	}
}
</script>
</HEAD>
<%
If IsNothing(Request.QueryString("ID")) Then
	MediaDBFieldID = 0
	MediaDBFieldName = ""
	MediaDBFieldType = "Text"
Else

	Dim MediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
	Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

	MediaDBFieldID = Request.QueryString("ID")
	sql = "SELECT * FROM MediaDBField WHERE MediaDBFieldID = " & MediaDBFieldID

	cmdMedia.CommandText = SQL
	Dim drFieldReader As IDataReader = cmdMedia.ExecuteReader

	If drFieldReader.Read Then
		MediaDBFieldName = drFieldReader("MediaDBFieldName")
		MediaDBFieldTypeID = drFieldReader("MediaDBFieldTypeID").ToString
		MediaDBFieldTemplateName = drFieldReader("MediaDBFieldTemplateName")
		MediaDBFieldSystemName = drFieldReader("MediaDBFieldSystemName")
		MediaDBFieldLocked = drFieldReader("MediaDBFieldLocked")
	End If
End If
%>
<%=Gui.MakeHeaders(Translate.Translate("Felter"), Translate.Translate("Felt"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top">
		<form name="MediaDBField" method="post" id="MediaDBField">
		<input type="hidden" name="MediaDBFieldID" value="<%=MediaDBFieldID%>">
		<div id="Tab1">
		<br>
		<table border="0" cellpadding="0" width=598>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
					<table cellpadding=2 cellspacing=0>
						<tr>
							<td width=170><%=Translate.Translate("Navn")%></td>
							<td><input type="text" name="MediaDBFieldName" size="30" maxlength="255" value="<%=MediaDBFieldName%>" class=std></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Systemnavn")%></td>
							<td>
							<%If MediaDBFieldSystemName <> "" Then%>
								<input type="text" name="MediaDBFieldSystemName_NIU" size="30" maxlength="255" value="<%=MediaDBFieldSystemName%>" class=std DISABLED>
								<input type="hidden" name="MediaDBFieldSystemName" size="30" maxlength="255" value="<%=MediaDBFieldSystemName%>" class=std>
							<%Else%>
								<input type="text" name="MediaDBFieldSystemName" size="30" maxlength="255" value="<%=MediaDBFieldSystemName%>" class=std>
							<%End If%>
							</td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Type")%></td>
							<td>
							<%
							If MediaDBFieldTypeID <> "" Then
								Response.Write(Gui.TableSelect("DWMedia.mdb", "MediaDBFieldType", "MediaDBFieldTypeID", "MediaDBFieldTypeName", "MediaDBFieldTypeID", MediaDBFieldTypeID, "MediaDBFieldTypeID", "", True))
								Response.Write("<input type=hidden name=MediaDBFieldTypeID value=""" & MediaDBFieldTypeID & """>")
							Else
								Response.Write(Gui.TableSelect("DWMedia.mdb", "MediaDBFieldType", "MediaDBFieldTypeID", "MediaDBFieldTypeName", "MediaDBFieldTypeID", MediaDBFieldTypeID, "MediaDBFieldTypeID", "", False))
							End If
							%>
							</td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Template tag")%></td>
							<td><input type="text" name="MediaDBFieldTemplateName" size="30" maxlength="255" value="<%=MediaDBFieldTemplateName%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Lås felt")%></td>
							<td><%=Gui.CheckBox(MediaDBFieldLocked, "MediaDBFieldLocked")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right">
			<table cellpadding=0 cellspacing=0>
				<tr>
					<td><%=Gui.Button(Translate.Translate("OK"), "Send('Media_Field_save.aspx');", 0)%> </td>
					<td width=5></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Media_Field_List.aspx';", 0)%></td>
					<td width=7></td>
				</tr>
				<tr height=5>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<%=Gui.SelectTab()%>
</BODY>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>