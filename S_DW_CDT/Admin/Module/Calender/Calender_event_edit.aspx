<%@ Page CodeBehind="Calender_event_edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Calender_event_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim CalenderEventLayout As String
Dim CalenderEventBookPage As String
Dim CalenderEventPlace As String
Dim CalenderEventImage As String
Dim CalenderEventWorkflowID As Integer
Dim CalenderEventCategoryID As String
Dim CalenderEventTitle As String = ""
Dim CalenderEventID As String
Dim CalenderEventCreated As String
Dim CalenderEventDate As String
Dim CalenderEventDateTo As String
Dim CalenderEventImageAlign As String
Dim CalenderEventLayoutValue As String
Dim CalenderEventImagePosition As String
Dim CalenderEventWorkflowState As String
Dim CalenderEventVersionComments As String
Dim CalenderEventModified As String
Dim CalenderCategoryID As String
Dim CalenderEventTextSpan As String
Dim CalenderEventValidFrom As String
Dim CalenderEventTextColSpan As String
Dim CalenderEventDescription As String
Dim CalenderEventInclude As String
Dim CalenderEventImageColSpan As String
Dim CalenderEventValidTo As String
Dim CalenderEventImageSpan As String

Dim strAuditData As String
Dim LinkManagerDisableFileArchive As Boolean
Dim strHeaders As String
Dim Sql As String
Dim StrSQL As String
Dim StrSQLTop As String
Dim DWWorkflow_MaxList As Byte
Dim dato as New Dates

Dim CalenderEventApprovalState As Integer 
Dim CalenderEventApprovalType As Integer

CalenderCategoryID = Base.ChkNumber(CInt(request.QueryString.Item("CalenderCategoryID")))
CalenderEventID = Base.ChkNumber(CInt(request.QueryString.Item("CalenderEventID")))

Dim cnCalenderEvent			As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdCalenderEventSelect	As IDbCommand		= cnCalenderEvent.CreateCommand

Response.Expires = -100

If Not IsNothing(request.QueryString.GetValues("CalenderEventID")) Then
	strSql = "SELECT * FROM CalenderEvent WHERE CalenderEventID = " & request.QueryString.Item("CalenderEventID")
	Dim drCalenderEvent		as IDataReader

'	If Base.IsModuleInstalled("VersionControl") Then
'	    Dim cmdSelectVersion As IDbCommand	 = cnCalenderEvent.CreateCommand
'		
'		cmdSelectVersion.CommandText = " SELECT TOP 1 * FROM CalenderEventVersion WHERE CalenderEventID = " & CalenderEventID & " ORDER BY VersionNumber DESC"'
'		drCalenderEvent = cmdSelectVersion.ExecuteReader()'
'		If drCalenderEvent.read Then
'			If Base.ChkNumber(drCalenderEvent("CalenderEventApprovalType")) <> -1 AND Base.ChkNumber(drCalenderEvent("CalenderEventApprovalType")) <> -3 Then
'				strSql = " SELECT TOP 1 CalenderEventVersion.* FROM CalenderEventVersion WHERE CalenderEventID = " & CalenderEventID & _
'						" ORDER BY VersionNumber DESC"
'			End If
'		End If
'		'If Base.chkNumber(cmdSelectVersion.ExecuteScalar) > 0 Then
'		'End If
'		drCalenderEvent.Close
'		drCalenderEvent.Dispose
'		cmdSelectVersion.Dispose()
'	End If

	cmdCalenderEventSelect.CommandText = strSql
	drCalenderEvent	= cmdCalenderEventSelect.ExecuteReader()
	drCalenderEvent.Read()
	CalenderEventDate				= Cstr(drCalenderEvent("CalenderEventDate").ToString)
	CalenderEventDateTo				= Cstr(drCalenderEvent("CalenderEventDateTo").ToString)
	CalenderEventTitle				= Cstr(drCalenderEvent("CalenderEventTitle").ToString)
	CalenderEventPlace				= Cstr(drCalenderEvent("CalenderEventPlace").ToString)
	CalenderEventDescription		= Cstr(drCalenderEvent("CalenderEventDescription").ToString)
	CalenderEventImage				= Cstr(drCalenderEvent("CalenderEventImage").ToString)
	CalenderEventCreated			= Cstr(drCalenderEvent("CalenderEventCreated").ToString)
	CalenderEventModified			= Cstr(drCalenderEvent("CalenderEventModified").ToString)
	CalenderEventValidFrom			= Cstr(drCalenderEvent("CalenderEventValidFrom").ToString)
	CalenderEventValidTo			= Cstr(drCalenderEvent("CalenderEventValidTo").ToString)
	CalenderEventLayoutValue		= Cstr(drCalenderEvent("CalenderEventLayoutValue").ToString)
	CalenderEventImageSpan			= Cstr(drCalenderEvent("CalenderEventImageSpan").ToString) 	
	CalenderEventTextSpan			= Cstr(drCalenderEvent("CalenderEventTextSpan").ToString)
	CalenderEventImageAlign			= Cstr(drCalenderEvent("CalenderEventImageAlign").ToString)
	CalenderEventInclude			= Cstr(drCalenderEvent("CalenderEventInclude").ToString)
	CalenderEventCategoryID			= Cstr(drCalenderEvent("CalenderEventCategoryID").ToString)
	CalenderEventID					= Cstr(drCalenderEvent("CalenderEventID").ToString)
	CalenderEventBookPage			= Cstr(drCalenderEvent("CalenderEventBookPage").ToString)
	
	'CalenderEventWorkflowID			= Cstr(drCalenderEvent("CalenderEventWorkflowID").ToString)
	'CalenderEventWorkflowState		= Cstr(drCalenderEvent("CalenderEventWorkflowState").ToString)
	'CalenderEventVersionComments	= Cstr(drCalenderEvent("CalenderEventVersionComments").ToString)
	
	CalenderEventApprovalState = Base.chkNumber(drCalenderEvent("CalenderEventApprovalState"))
	CalenderEventApprovalType = Base.chkNumber(drCalenderEvent("CalenderEventApprovalType"))
	If CalenderEventApprovalType > 0 AND CalenderEventApprovalState = 0 Then
		CalenderEventApprovalState = -1
	End If 

	drCalenderEvent.Dispose()
'Todo Calender_event_edit - Call CheckOut(CInt(request.QueryString.Item("CalenderEventID")), "Event")
Else
	CalenderEventLayout				= "T11-B11.gif"
	CalenderEventImagePosition		= "Under"
	CalenderEventImageColSpan		= "11"
	CalenderEventTextColSpan		= "11"
	CalenderEventCategoryID			= request.QueryString.Item("CalenderCategoryID")
	CalenderEventDate				= Date.Now()
	CalenderEventDateTo				= Date.Now()
	CalenderEventValidFrom			= Date.Now()
	CalenderEventValidTo			= Date.Parse("01-01-2999")
	'CalenderEventWorkflowID			= 0
	'CalenderEventWorkflowState		= ""
	CalenderEventBookPage			= ""
	
	
	'cmdCalenderEventSelect.CommandText = "SELECT CalenderCategoryWorkflowID FROM CalenderCategory WHERE CalenderCategoryID = " & Base.ChkNumber(CalenderCategoryID)
	'Dim drCalenderEvent as IDataReader = cmdCalenderEventSelect.ExecuteReader()
	
	'If drCalenderEvent.Read() Then
	'	CalenderEventWorkflowID = drCalenderEvent("CalenderCategoryWorkflowID")
	'End If
	'drCalenderEvent.Dispose()
End If

%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<title>Calender Event Edit</title>
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
	if (document.forms.CalenderEvent.CalenderEventTitle.value.length < 1) {
		alert("<%=Translate.Translate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		document.forms.CalenderEvent.CalenderEventTitle.focus();
	}
	else if (document.forms.CalenderEvent.CalenderEventTitle.value.length > 250) {
		alert("<%=Translate.JSTranslate("Max %% tegn i: ґ%f%ґ","%%","250", "ґ%f%ґ", Translate.JSTranslate("Navn"))%>");
		document.forms.CalenderEvent.CalenderEventTitle.focus();
	}
	else if (document.forms.CalenderEvent.CalenderEventPlace.value.length > 250) {
		alert("<%=Translate.JSTranslate("Max %% tegn i: ґ%f%ґ","%%","250", "ґ%f%ґ", Translate.JSTranslate("Navn"))%>");
		document.forms.CalenderEvent.CalenderEventPlace.focus();
	}
	else {
		document.forms.CalenderEvent.submit();
	}
}

</script>


<%
strHeaders = Translate.Translate("Begivenhed")

%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("begivenhed")), strHeaders, "all")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
	<form name="CalenderEvent" action="Calender_event_save.aspx" method="post">
	<input name="CalenderEventId" value="<%=CalenderEventID%>" type="Hidden">
	<input name="CalenderEventCategoryID" value="<%=CalenderEventCategoryID%>" type="Hidden">
	<input type="hidden" name="Audit" value="<%=request.Item("Audit")%>" ID="Audit">
	<input type="hidden" name="AuditUserID" value="<%=request.Item("AuditUserID")%>" ID="AuditUserID">
	<input type="hidden" name="AuditDateTimeFrom" value="<%=request.Item("AuditDateTimeFrom")%>" ID="AuditDateTimeFrom">
	<input type="hidden" name="AuditDateTimeTo" value="<%=request.Item("AuditDateTimeTo")%>" ID="AuditDateTimeTo">
	<input type="hidden" name="AuditType" value="<%=request.Item("AuditType")%>" ID="AuditType">
	<input type="hidden" name="SortOrder" value="<%=request.Item("SortOrder")%>" ID="SortOrder">
	<input type="hidden" name="SortField" value="<%=request.Item("SortField")%>" ID="SortField">
	<tr>
		<td valign=top>
			<div id="Tab1" style="display:;">
			<BR>
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table border="0" cellpadding="0" width="100%">
					<tr>
						<td width="170"><%=Translate.Translate("Navn")%></td>
						<td><input type="text" maxlength="255" class="std" name="CalenderEventTitle" value="<%=Server.HtmlEncode(CalenderEventTitle)%>" class="std"></td>
					</tr>
					<tr>
						<td width=170><%=Translate.Translate("Sted")%></td>
						<td><input class="std" maxlength="255" type="text" name="CalenderEventPlace" value="<%=Server.HtmlEncode(CalenderEventPlace)%>"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Billede")%></td>
						<td><%= Gui.FileManager(CalenderEventImage, Dynamicweb.Content.Management.Installation.ImagesFolderName, "CalenderEventImage")%></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Start dato")%></td>
						<td><%=dato.DateSelect(CDate(CalenderEventDate), True, False, False, "CalenderEventDate")%></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Slut dato")%></td>
						<td><%=dato.DateSelect(CDate(CalenderEventDateTo), True, False, False, "CalenderEventDateTo")%></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
				<table border="0" cellpadding="0" width="100%">
					<tr>
						<td>&nbsp;<%=Gui.Editor("CalenderEventDescription", 500, 200, CalenderEventDescription)%></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%If Base.HasAccess("Form", "") Then%>
				<%=Gui.GroupBoxStart(Translate.Translate("Tilmelding"))%>
				<table border="0" cellpadding="0" width="100%">
					<tr>
						<td width="170"><%=Translate.Translate("Bestillingsside")%></td>
						<td><%LinkManagerDisableFileArchive = True%><%=Gui.LinkManager(CalenderEventBookPage, "CalenderEventBookPage", "")%><%	LinkManagerDisableFileArchive = False%></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				<%End If%>
				<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
				<table border="0" cellpadding="0" width="100%">
					<tr>
						<td width="170"><%=Translate.Translate("Gyldig fra")%></td>
						<td><%=dato.DateSelect(CalenderEventValidFrom, True, False, False, "CalenderEventValidFrom")%></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Gyldig til")%></td>
						<td><%=dato.DateSelect(CalenderEventValidTo, True, True, True, "CalenderEventValidTo")%></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
			</div>
		</td>
	</tr>
	<tr valign="bottom">
		<td colspan="4" align="right">
		
		<table cellpadding="0" cellspacing="0">
			<tr>
				<TD colspan="6"><br></TD>
			</tr>
			<tr>
				<TD align="right"><%=Gui.Button(Translate.Translate("OK"), "javascript:html();Send();", 0)%></TD>
				<TD width="5"></TD>
				<TD align="right">
						<%
If request.Item("Audit") = "true" Then
	strAuditData = "Audit&=true&AuditUserID=" & request.Item("AuditUserID") & "&AuditDateTimeFrom=" & request.Item("AuditDateTimeFrom") & "&AuditDateTimeTo=" & request.Item("AuditDateTimeTo") & "&AuditType=" & request.Item("AuditType") & "&SortOrder=" & request.Item("SortOrder") & "&SortField=" & request.Item("SortField")

	Response.Write(Gui.Button(Translate.Translate("Annuller"), "location='/Admin/module/Audit/Audit_list.aspx?" & strAuditData & "';", 0))
Else
	Response.Write(Gui.Button(Translate.Translate("Annuller"), "history.back();", 0))
End If
%>
						</TD>
				<TD width="10"></TD>
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
'Cleanup
cmdCalenderEventSelect.Dispose()
cnCalenderEvent.Dispose()

Translate.GetEditOnlineScript()
%>