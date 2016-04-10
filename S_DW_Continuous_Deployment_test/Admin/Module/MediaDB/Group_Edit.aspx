<%@ Page Language="vb" AutoEventWireup="false" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%

Dim MediaDBGroupName As String
Dim sql As String
Dim MediaDBGroupActiveTo As Date
Dim Tabs As String
Dim MediaDBGroupParentID As String
Dim MediaDBGroupDescription As String
Dim MediaDBGroupNumber As String
Dim MediaDBGroupKeywords As String
Dim MediaDBGroupActiveFrom As Date
Dim MediaDBGroupID As String
Dim MediaDBGroupActive As String

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function Send(FileToHandle){
	if (document.getElementById('MediaDBGroup').MediaDBGroupName.value.length < 1){
		alert("<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JSTranslate("Navn"))%>");
	}else{
		document.getElementById('MediaDBGroup').action = FileToHandle;
		document.getElementById('MediaDBGroup').submit();
	}
}

function catchThatEnter(){
	if(event.keyCode == 13){
		//document.login.Password.focus();
		Send("Group_save.aspx");
	}
}

function AddPage(ID, AreaID, Name){
	movepageWindow = window.open(Home + "Menu.aspx?ID=" + ID + "&Action=AddPage&Caller="+ Name + "&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,top=155,left=402");
}
</script>
</HEAD>
<%

Dim mediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As IDbCommand = mediaConn.CreateCommand

If IsNothing(request.QueryString("ID")) Then
	MediaDBGroupID = 0
	MediaDBGroupName = ""
	MediaDBGroupActive = 1
	MediaDBGroupActiveFrom = Dates.DWnow()
	MediaDBGroupActiveTo = "2999-12-31 23:59"
	
	If Not IsNothing(request.QueryString("Uid")) Then
		MediaDBGroupParentID = request.QueryString("Uid")
	Else
		MediaDBGroupParentID = "0"
	End If
Else

	MediaDBGroupID = request.QueryString("ID")
	sql = "SELECT * FROM MediaDBGroup WHERE MediaDBGroupID = " & MediaDBGroupID

	cmdMedia.CommandText = sql

	Dim drGroupReader As IDataReader = cmdMedia.ExecuteReader()

	If drGroupReader.Read Then
		MediaDBGroupID = drGroupReader("MediaDBGroupID").ToString
		MediaDBGroupParentID = drGroupReader("MediaDBGroupParentID").ToString
		MediaDBGroupName = drGroupReader("MediaDBGroupName").ToString
		MediaDBGroupKeywords = drGroupReader("MediaDBGroupKeywords").ToString
		MediaDBGroupDescription = drGroupReader("MediaDBGroupDescription").ToString
		MediaDBGroupActive = drGroupReader("MediaDBGroupActive").ToString
		MediaDBGroupActiveFrom = drGroupReader("MediaDBGroupActiveFrom").ToString
		MediaDBGroupActiveTo = drGroupReader("MediaDBGroupActiveTo").ToString
		MediaDBGroupNumber = drGroupReader("MediaDBGroupNumber").ToString
	End If
End If

If Not IsNothing(request.QueryString("Tab")) Then
	%>
<BODY>
<%Else%>
<BODY onLoad="document.getElementById('MediaDBGroup').MediaDBGroupName.focus();">
<%End If%>
<span class="body">
<%
Tabs = Translate.Translate("Gruppe")
%>
<%=Gui.MakeHeaders(MediaDBGroupName & "&nbsp;", Tabs, "all")%>

<table border="0" cellpadding="0" cellspacing=0 class=tabTable>
<tr><td valign=top>
	<form name="MediaDBGroup" id="MediaDBGroup" method="Post">
	<input type="hidden" name="MediaDBGroupID" value="<%=MediaDBGroupID%>">
	<input type="hidden" name="MediaDBGroupParentID" value="<%=MediaDBGroupParentID%>">
		<div ID="Tab1" STYLE="display:;">
		<br>
		<table border="0" cellpadding="0" width=598>
		<tr>
			<td colspan=2>
				<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
				<table cellpadding=2 cellspacing=0>
					<tr>
						<td width=170><%=Translate.Translate("Navn")%></td>
						<td><input type="text" name="MediaDBGroupName" size="30" maxlength="255" value="<%=MediaDBGroupName%>" onKeydown="catchThatEnter();" class=std></td>
					</tr>
					<tr>
						<td valign=top><%=Translate.Translate("Søgeord",1)%></td>
						<td><textarea class=std name="MediaDBGroupKeywords"><%=MediaDBGroupKeywords%></textarea></td>
					</tr>
					<tr>
						<td valign=top><%=Translate.Translate("Beskrivelse")%></td>
						<td><textarea class=std name="MediaDBGroupDescription"><%=MediaDBGroupDescription%></textarea></td>
					</tr>
					<!--tr>
						<td width=170><%=Translate.Translate("Varegruppenummer")%></td>
						<td><input type="text" name="MediaDBGroupNumber" size="30" maxlength="255" value="<%=MediaDBGroupNumber%>" class=std></td>
					</tr-->
					<tr>
						<td width=170><%=Translate.Translate("Aktiv")%></td>
				      	<td><%=Gui.CheckBox(MediaDBGroupActive, "MediaDBGroupActive")%></td>
				    </tr>
				</table>
				<%=Gui.GroupBoxEnd%>
			</td>
		</tr>
		<tr<%=Base.HasAccessHIDE("Publish", "")%>>
			<td colspan=2>
			<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
				<table cellpadding=2 cellspacing=0 border=0>
					<tr>
						<td width=170><%=Translate.Translate("Gyldig fra")%></td>
						<td><%Response.Write(Dates.DateSelect(MediaDBGroupActiveFrom, True, False, False, "MediaDBGroupActiveFrom"))%></td>
					</tr>
					<tr>
						<td valign=top><%=Translate.Translate("Gyldig til")%></td>
						<td><%Response.Write(Dates.DateSelect(MediaDBGroupActiveTo, True, False, True, "MediaDBGroupActiveTo"))%></td>
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
					<td><%=Gui.Button(Translate.Translate("OK"), "Send('Group_save.aspx');", 0)%> </td>
					<td width=5></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Media_List.aspx?ID=" & request.QueryString("ID") & "';", 0)%></td>
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
cmdMedia.Dispose
mediaConn.Dispose

	Translate.GetEditOnlineScript()
%>