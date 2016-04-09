<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim MediaDBMediaDescription As String
Dim MediaDBMediaActiveFrom As String
Dim Path As String
Dim MediaDBMediaActive As Integer
Dim File As String
Dim i As Integer
Dim SelectedFiles() As String
Dim MediaDBMediaCopyright As String
Dim MediaDBMediaActiveTo As String
Dim getOrientationArray As String
Dim MediaDBMediaKeywords As String
Dim MediaDBMediaBlackWhite As Integer
Dim extList As String
Dim MediaDBGroupListGetGroups As String
Dim Root As String
Dim ImportDeleteOriginal As Integer

Base.MediaSettings(Path, extList)

MediaDBMediaActiveTo = "2999-12-31 23:59"
MediaDBMediaActive = 1
MediaDBMediaBlackWhite = 0
ImportDeleteOriginal = 0
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script>
	function Send(){
		if(document.getElementById('selectform').MediaDBMediaGroupID.selectedIndex < 1){
			alert("<%=Translate.JSTranslate("Vælg hvilken gruppe der skal importeres til")%>");
			document.getElementById('selectform').MediaDBMediaGroupID.focus();
		}
		else{
			document.getElementById('selectform').submit();
		}
	}
	</script>
	<%=Gui.MakeHeaders(Translate.Translate("Importer"), Translate.Translate("Egenskaber") & "," & Translate.Translate("Filer"), "JavaScript")%>
</head>
<body>
	<form name="selectform" id="selectform" method="post" action="Files_ImportExe.aspx">
	<%=Gui.MakeHeaders(Translate.Translate("Importer"), Translate.Translate("Egenskaber") & "," & Translate.Translate("Filer"), "HTML")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top">
			<div ID="Tab1" STYLE="display:;">
				<%=Gui.GroupBoxStart(Translate.Translate("Fil"))%>
				<table cellspacing="0" border="0" cellpadding="0" width="100%">
					<tr>
						<td valign=top width=170><%=Translate.Translate("Søgeord")%></td>
						<td><textarea class=std name="MediaDBMediaKeywords"><%=MediaDBMediaKeywords%></textarea></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Copyright")%></td>
						<td><INPUT TYPE="TEXT" NAME="MediaDBMediaCopyright" VALUE="<%=MediaDBMediaCopyright%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td valign=top><%=Translate.Translate("Gruppe")%></td>
						<td>
						<select name="MediaDBMediaGroupID" class=std>
						<option value=""><%=Translate.Translate("Vælg gruppe")%>
							<%=Gui.MediaDBGroupListGetGroups("", 0, 0)%>
						</select>
						</td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Sort/hvid")%></td>
				      	<td><%=Gui.CheckBox(MediaDBMediaBlackWhite, "MediaDBMediaBlackWhite")%></td>
				    </tr>
					<tr>
						<td><%=Translate.Translate("Aktiv")%></td>
				      	<td><%=Gui.CheckBox(MediaDBMediaActive, "MediaDBMediaActive")%></td>
				    </tr>
					<tr>
						<td><%=Translate.Translate("Slet %%", "%%", Translate.Translate("original"))%></td>
				      	<td><%=Gui.CheckBox(ImportDeleteOriginal, "ImportDeleteOriginal")%></td>
				    </tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				
				<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
                    <%=Gui.Editor("MediaDBMediaDescription", 0, 0, "")%>
    			<%=Gui.GroupBoxEnd%>
    			<%If Base.HasAccess("Publish", "") Then%>
					<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								<td width=170><%=Translate.Translate("Gyldig fra")%></td>
								<td><%=Dates.DateSelect(MediaDBMediaActiveFrom, True, False, False, "MediaDBMediaActiveFrom")%></td>
							</tr>
							<tr>
								<td width=170><%=Translate.Translate("Gyldig til")%></td>
								<td><%=Dates.DateSelect(MediaDBMediaActiveTo, True, true, True, "MediaDBMediaActiveTo")%></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
				<%
				End If
				%>
			</div>
			<DIV ID="Tab2" STYLE="display:none;">
			<table cellspacing="0" border="0" cellpadding="0" width="100%">
				<tr>
					<td>
					<%
	                    SelectedFiles = Split(Request.Form.Item("SelectedFiles"), ",")
	                    For i = 0 To UBound(SelectedFiles)
		                    Response.Write("<input type=""Hidden"" name=""MediaDBMediaFileName"" value=""" & SelectedFiles(i) & """>" & vbCrLf)
	                    Next 
	                    %>
					<%=Gui.GroupBoxStart(Translate.Translate("Filer"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<%
							For i = 0 To UBound(SelectedFiles)
								Response.Write("<tr><td width=170></td><td>" & SelectedFiles(i) & "</td></tr>" & vbCrLf)
							Next 
							%>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
			</div>
		</td>
	</tr>
	<tr>
		<td height=5></td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td align="right"><%=Gui.Button(Translate.Translate("OK"), "if(html()){Send();}", 0)%></td>
					<td width="5"></td>
					<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='Files_Inbox.aspx';", 0)%></td>
					<td width="10"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>			
			</table>
		</td>
	</tr>
	</table>
	<input type="hidden" name="InboxFolder" value="<%=Request.Form.Item("InboxFolder")%>">
	</form>

<script>

</script>
</body>
</html>
<%
	Translate.GetEditOnlineScript()
%>