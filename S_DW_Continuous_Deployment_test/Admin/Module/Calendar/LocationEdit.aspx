<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Calendar" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LocationEdit.aspx.vb" Inherits="Dynamicweb.Admin.LocationEdit" validateRequest="false" codePage="65001" %>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
	</HEAD>
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
			if (document.forms.CalendarLocation.CalendarLocationTitle.value.length < 1) {
				alert("<%=Translate.Translate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
				document.forms.CalendarLocation.CalendarLocationTitle.focus();
			}
			else if (document.forms.CalendarLocation.CalendarLocationTitle.value.length > 250) {
		alert("<%=Translate.JSTranslate("Max %% tegn i: ´%f%´", "%%", "250", "´%f%´", Translate.JSTranslate("Navn"))%>");
				document.forms.CalendarLocation.CalendarLocationTitle.focus();
			}
			else {
				/*if (dw_HTMLMode==false) {
					document.forms.CalendarLocation.CalendarLocationDescription.value = DWEditor.DOM.body.innerHTML;
				}*/
				document.forms.CalendarLocation.submit();
			}
		}
		
		function ValidateThisForm()
		{
			var form = document.forms["CalendarLocation"];
			var controlToValidate = form.elements["CalendarLocationTitle"];
			ValidateForm(form, controlToValidate,
				"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		}

	</script>
	<body>
<%= Gui.MakeHeaders(Translate.Translate("% m% - Rediger %c%", "%m%", Translate.Translate("Aktivitetskalender V2", 9), "%c%", Translate.Translate("lokalitet")), Translate.Translate("Lokalitet"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<form name="CalendarLocation" action="LocationEdit.aspx?Action=Save" method="post">
					<input type="hidden" name="CalendarLocationID" value="<%=CalendarLocationID%>">
					<tr>
						<td valign="top">
							<div id="Tab1">
								<BR>
								<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
								<table border="0" cellpadding="0" width="100%">
									<tr>
										<td width="170"><%=Translate.Translate("Navn")%></td>
										<td><input type="text" maxlength="255" class="std" name="CalendarLocationTitle" value="<%=GetName()%>" ></td>
									</tr>
									<tr>
										<td><%=Translate.Translate("Billede")%></td>
										<td><%= Gui.FileManager(GetImage(), Dynamicweb.Content.Management.Installation.ImagesFolderName, "CalendarLocationImage")%></td>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
								<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
								<table border="0" cellpadding="0" width="100%">
									<tr>
										<td>&nbsp;<%=Gui.Editor("CalendarLocationDescription", 0, 0, GetDescription())%></td>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
							</div>
						</td>
					</tr>
					<tr valign="bottom">
						<td colspan="4" align="right">
							<%=GUI.MakeOkCancelHelp("ValidateThisForm();", "location = 'Calendar_List.aspx?Tab=2';", True, "modules.calendar.general.list.location.edit")%>						</td>
					</tr>
			</table></FORM>
<%
'Cleanup
Translate.GetEditOnlineScript()
%>
	</body>
</HTML>
