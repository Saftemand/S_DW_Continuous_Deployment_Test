<%@ Page CodeBehind="Calender_event_del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Calender_event_del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim CalenderEventCategoryID As Integer
Dim sql As String
Dim CalenderEventID As Integer

CalenderEventCategoryID = Base.ChkNumber(request.QueryString("CalenderEventCategoryID"))
CalenderEventID = Base.ChkNumber(request.QueryString("CalenderEventID"))

If CalenderEventCategoryID <> 0 And CalenderEventID <> 0 Then
	Dim cnCalenderDel	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdCalenderDel	As IDbCommand		= cnCalenderDel.CreateCommand()
	cmdCalenderDel.CommandText = "DELETE FROM CalenderEvent WHERE CalenderEventID = " & CalenderEventID
	cmdCalenderDel.ExecuteNonQuery()
	'Cleanup
	cmdCalenderDel.Dispose()
	cnCalenderDel.Dispose()
End if

Response.Redirect("Calender_Event_list.aspx?CalenderCategoryID=" & CalenderEventCategoryID)
%>



