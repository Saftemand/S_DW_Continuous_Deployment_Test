<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%

Dim MediaDBThumbnailsName As String
Dim MediaDBGroupListGetGroups As Object

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="JavaScript">
	function Send(){
		if(document.getElementById('selectform').MediaDBMediaGroupID.selectedIndex < 1){
			alert("<%=Translate.JSTranslate("Vælg gruppe")%>");
			document.getElementById('selectform').MediaDBMediaGroupID.focus();
		}
		else{
			document.getElementById('selectform').submit();
		}
	}
	
	</script>
</head>
<%
If Request.QueryString("Action") = "copy" Then%>
	<%=Gui.MakeHeaders("<br>&nbsp;" & MediaDBThumbnailsName, Translate.Translate("Kopier"), "HTML")%>
<%Else%>
	<%=Gui.MakeHeaders("<br>&nbsp;" & MediaDBThumbnailsName, Translate.Translate("Flyt"), "HTML")%>
<%End If%>

<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
<form action="Media_Media_MoveCopyExe.aspx" method="get" name="selectform id="selectform">
<input type="hidden" value="<%=Request.QueryString("Action")%>" name="Action">
<input type="hidden" value="<%=Request.QueryString("MediaID")%>" name="MediaID">
	<tr>
		<td valign="top">
			<DIV ID="Tab1" STYLE="display:;">
			<br>
			<%
			If Request.QueryString("Action") = "copy" Then
				Response.Write(Gui.GroupBoxStart(Translate.Translate("Kopier til")))
			Else
				Response.Write(Gui.GroupBoxStart(Translate.Translate("Flyt til")))
			End If
			%>
				<table cellpadding=2 cellspacing=0 border=0>
					<tr>
						<td valign=top width=170><%=Translate.Translate("Gruppe")%></td>
						<td>
						<select name="MediaDBMediaGroupID" class=std>
						<option value=""><%=Translate.Translate("Vælg gruppe")%>
						<%=Gui.MediaDBGroupListGetGroups("", 0, 0)%>
						</select>
						</td>
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
					<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "history.go(-1);", 0)%></td>
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