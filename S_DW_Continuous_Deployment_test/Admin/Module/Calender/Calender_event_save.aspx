<%@ Page CodeBehind="Calender_event_save.aspx.vb" validateRequest="false" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Calender_event_save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim dato as New Dates
Dim CalenderEventTemplateID As Integer
Dim CalenderEventBookPage As String

Dim strAuditData As String
Dim CalenderEventDescription As String

Dim CalenderEventDateTo As String
Dim CalenderEventVersionParentID As Integer
Dim CalenderEventPlace As String

Dim CalenderEventValidTo As String
Dim CalenderEventVersionComments As String
Dim CalenderEventCategoryID As String
Dim CalenderEventValidFrom As String
Dim CalenderEventVersionNumber As Byte
Dim CalenderEventDate As String

Dim CalenderEventImage As String

Dim CalenderEventTitle As String
Dim CalenderEventID As Integer
Dim sql As String
Dim blnNewRow = false
Dim VersionParent As Integer


VersionParent					= Base.ChkNumber(request.QueryString.Item("version")) ' As Integer
CalenderEventID					= Base.ChkNumber(request.Form.Item("CalenderEventID"))
CalenderEventDate				= Dates.ParseDate("CalenderEventDate")
CalenderEventDateTo				= Dates.ParseDate("CalenderEventDateTo")
CalenderEventTitle				= request.Form.Item("CalenderEventTitle")
CalenderEventPlace				= request.Form.Item("CalenderEventPlace")
CalenderEventDescription		= request.Form.Item("CalenderEventDescription") & ""
CalenderEventImage				= request.Form.Item("CalenderEventImage")
CalenderEventValidFrom			= Dates.ParseDate("CalenderEventValidFrom")
CalenderEventValidTo			= Dates.ParseDate("CalenderEventValidTo")
CalenderEventTemplateID			= request.Form.Item("CalenderEventTemplateID")
CalenderEventCategoryID			= request.Form.Item("CalenderEventCategoryID")
CalenderEventVersionComments	= request.Form.Item("CalenderEventVersionComments")
CalenderEventBookPage			= request.Form.Item("CalenderEventBookPage")

'Todo Calender_event_save - CheckIn
'If IsNumeric(request.Form.Item("CalenderEventID")) Then
'	Call CheckIn(CInt(CalenderEventID), "Event")
'End If
If CalenderEventDescription = "" Then
	CalenderEventDescription =" "
End If
    'CalenderEventTitle = Replace(CalenderEventTitle, "'", "''")

If Len(CalenderEventDescription) > 0 Then
	'CalenderEventDescription = Replace(CalenderEventDescription, "'", "''")
	CalenderEventDescription = CalenderEventDescription
Else
	CalenderEventDescription = ""
End If

If Len(CalenderEventPlace) > 0 Then
	'CalenderEventPlace = Replace(CalenderEventPlace, "'", "''")
	CalenderEventPlace = CalenderEventPlace
Else
	CalenderEventPlace = ""
End If

Dim cnCalenderEvent As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect		As IDbCommand		= cnCalenderEvent.CreateCommand
Dim dsCalenderEvent As DataSet			= New DataSet
Dim daCalenderEvent As IDbDataAdapter	= Database.CreateAdapter()
daCalenderEvent.SelectCommand = cmdSelect
Dim dtCalenderEvent As DataTable
Dim row				as DataRow


Dim strVersionWhere As String = ""

If Not isNothing(CalenderEventID) And CalenderEventID > 0 Then 
	' save changes
	cmdSelect.CommandText = "SELECT * FROM CalenderEvent WHERE CalenderEventID = " & CalenderEventID & strVersionWhere
	daCalenderEvent.SelectCommand = cmdSelect
	daCalenderEvent.Fill(dsCalenderEvent)
	dtCalenderEvent = dsCalenderEvent.Tables(0)
	row = dtCalenderEvent.Rows(0)
Else
	' New item
	cmdSelect.CommandText = "SELECT TOP 1 * FROM CalenderEvent"
	daCalenderEvent.Fill(dsCalenderEvent)
	dtCalenderEvent = dsCalenderEvent.Tables(0)
	row = dtCalenderEvent.NewRow()
	dtCalenderEvent.Rows.Add(row)
	row("CalenderEventCategoryID")		= CalenderEventCategoryID
	row("CalenderEventCreated")			= dato.DWNow()
	row("CalenderEventInclude")			= 1
	row("CalenderEventUserCreate")		= Session("DW_Admin_UserID")
	row("CalenderEventLayoutValue")		= "T11-B11"
	blnNewRow = true
End If

row("CalenderEventModified")			= dato.DWNow()
row("CalenderEventUserEdit")			= Session("DW_Admin_UserID")

row("CalenderEventBookPage")			= CalenderEventBookPage
row("CalenderEventDate")				= CalenderEventDate
row("CalenderEventDateTo")				= CalenderEventDateTo
row("CalenderEventTitle")				= CalenderEventTitle

If Len(CalenderEventPlace) > 0 Then
	row("CalenderEventPlace")				= CalenderEventPlace
Else
	row("CalenderEventPlace")				= DBNull.Value
End If

row("CalenderEventDescription")			= CalenderEventDescription
row("CalenderEventImage")				= CalenderEventImage
row("CalenderEventValidFrom")			= CalenderEventValidFrom
row("CalenderEventValidTo")				= CalenderEventValidTo
row("CalenderEventTemplateID")			= CalenderEventTemplateID

Database.CreateCommandBuilder(daCalenderEvent)

'Updates Database
daCalenderEvent.Update(dsCalenderEvent)
If CalenderEventID = 0 Then
	CalenderEventID = Database.GetAddedIdentityKey(cnCalenderEvent)
End If 

dsCalenderEvent.Dispose()
cmdSelect.Dispose()
cnCalenderEvent.Dispose()

If request.Item("Audit") = "true" Then
	strAuditData = "Audit&=true&AuditUserID=" & request.Item("AuditUserID") & "&AuditDateTimeFrom=" & request.Item("AuditDateTimeFrom") & "&AuditDateTimeTo=" & request.Item("AuditDateTimeTo") & "&AuditType=" & request.Item("AuditType") & "&SortOrder=" & request.Item("SortOrder") & "&SortField=" & request.Item("SortField")
	response.Redirect("/Admin/module/Audit/Audit_list.aspx?" & strAuditData)
Else
	response.Redirect("Calender_event_list.aspx?CalenderCategoryID=" & request.Form.Item("CalenderEventCategoryID"))
End If
%>
