<%@ Page Language="vb" AutoEventWireup="false" validateRequest="false" Codebehind="CalendarEventEdit.aspx.vb" Inherits="Dynamicweb.Admin.CalendarEventEdit" codePage="65001" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
	</HEAD>
	<body>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
<script type="text/javascript">function html() { return true; }</script>
<script language="JavaScript">
function show(i) {
	if (document.all) {
		if (document.all[i].style.display=='none') {
			document.all[i].style.display='';
			hideEditor();
		} 
		else {
		document.all[i].style.display='none';
		unHideEditor();
		}
	}
}
function Send(){
	if (document.forms.CalendarEvent.CalendarEventTitle.value.length < 1) {
		alert("<%=Translate.Translate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		document.forms.CalendarEvent.CalendarEventTitle.focus();
	}
	else if (document.forms.CalendarEvent.CalendarEventTitle.value.length > 250) {
		alert("<%=Translate.JSTranslate("Max %% tegn i '%f%'","%%","250", "%f%", Translate.JSTranslate("Navn"))%>");
		document.forms.CalendarEvent.CalendarEventTitle.focus();
	}
	else if (document.forms.CalendarEvent.CalendarEventPlace.value.length > 250) {
		alert("<%=Translate.JSTranslate("Max %% tegn i '%f%'","%%","250", "%f%", Translate.JSTranslate("Sted"))%>");
		document.forms.CalendarEvent.CalendarEventPlace.focus();
	}
	else {
		document.forms.CalendarEvent.submit();
	}
}

function ValidateThisForm()
{
	var form = document.forms["CalendarEvent"];
	var controlToValidate = form.elements["CalendarEventTitle"];
	ValidateForm(form, controlToValidate,
		"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>",
		function(){html();});
}

			</script>
<form name="CalendarEvent" action="CalendarEventEdit.aspx?Action=Save" method="post">
<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%", Translate.Translate("Aktivitetskalender V2",9), "%c%", Translate.Translate("begivenhed")), Translate.Translate("Begivenhed"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
					<input type="hidden" name="CalendarCategoryID" value="<%=CalendarCategoryID%>"> <input type="hidden" name="CalendarEventID" value="<%=CalendarEventID%>">
					<tr>
						<td valign="top">
							<div id="Tab1">
								<BR>
								<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
								<table border="0" cellpadding="0" width="100%">
									<tr>
										<td width="170"><%=Translate.Translate("Navn")%></td>
										<td><input type="text" maxlength="255" class="std" style="width:278px;" name="CalendarEventTitle" value="<%=CeTitle()%>" ></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Sted")%></td>
										<td><input class="std" maxlength="255" type="text" style="width:278px;" name="CalendarEventPlace" value="<%=CePlace()%>"></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Sted")%></td>
										<td><asp:literal id="Literal1" runat="server" /></td>
									</tr>
									<tr>
										<td><%=Translate.Translate("Billede")%></td>
										<td><%= Replace(Gui.FileManager(CeImage(), Dynamicweb.Content.Management.Installation.ImagesFolderName, "CalendarEventImage"), "class=""std"" ", "class=""std"" style=""width: 278px;""")%></td>
									</tr>
									<tr>
										<td><%=Translate.Translate("Start dato")%></td>
										<td><%= Dates.DateSelect(CeDate(), True, False, False, "CalendarEventDate")%></td>
									</tr>
									<tr>
										<td><%=Translate.Translate("Slut dato")%></td>
										<td><%= Dates.DateSelect(CeDateTo(), True, False, False, "CalendarEventDateTo")%></td>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
								<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
								<table border="0" cellpadding="0" width="100%">
									<tr>
										<td>&nbsp;<%= Gui.Editor("CalendarEventDescription", 0, 0, CeDescription())%></td>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
								<%If Base.HasAccess("Form", "") Then%>
								<%=Gui.GroupBoxStart(Translate.Translate("Registrering"))%>
								<table border="0" cellpadding="0" width="100%">
									<tr>
										<td width="170"><%=Translate.Translate("Registreringsside")%></td>
										<td><%Dim LinkManagerDisableFileArchive as boolean = True%><%= Gui.LinkManager(CeBookPage(), "CalendarEventBookPage", "")%><%	LinkManagerDisableFileArchive = False%></td>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
								<%End If%>
								<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
								<table border="0" cellpadding="0" width="100%">
									<tr>
										<td width="170"><%=Translate.Translate("Gyldig fra")%></td>
										<td><%= Dates.DateSelect(CeValidFrom(), True, False, False, "CalendarEventValidFrom")%></td>
									</tr>
									<tr>
										<td><%=Translate.Translate("Gyldig til")%></td>
										<td><%= Dates.DateSelect(CeValidTo(), True, True, True, "CalendarEventValidTo")%></td>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
							</div>
						</td>
					</tr>
					<tr valign="bottom">
						<td colspan="4" align="right">
							<%=GUI.MakeOkCancelHelp("ValidateThisForm();", "history.back();", True, "modules.calendar.general.list.category.edit.event.edit")%>						</td>
					</tr>
			</table></FORM>
<%
'Cleanup

Translate.GetEditOnlineScript()
%>
	</body>
</HTML>
