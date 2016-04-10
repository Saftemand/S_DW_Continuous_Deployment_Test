<%@ Page CodeBehind="Calender_event_setactive.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Calender_event_setactive" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

'**************************************************************************************************
'	Current version:	1.1
'	Created:			26-02-2002
'	Last modfied:		14-06-2004
'
'	Purpose: To Disable/Enable a CalenderEvent 
'
'	Revision history:
'		1.0 - 026-02-2002 - Michael Skarum
'		First version.
'		1.1 - 14-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************

Dim CalenderEventInclude	As String
Dim CalenderEventID			As String
Dim CalenderCategoryID		As String
Dim CalenderCategory		As String

CalenderEventInclude	= request.QueryString.Item("CalenderEventInclude")
CalenderEventID			= request.QueryString.Item("CalenderEventID")
CalenderCategory		= request.QueryString.Item("CalenderCategory")
CalenderCategoryID		= request.QueryString.Item("CalenderCategoryID")

If IsNumeric(CalenderEventID) And CalenderEventID <> 0 Then
	Dim cnQuestion	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmd			As IDbCommand		= cnQuestion.CreateCommand
	cmd.CommandText = "SELECT CalenderEventInclude FROM CalenderEvent WHERE CalenderEventID = " & CalenderEventID
	Dim drQuestion	As IDataReader		= cmd.ExecuteReader()
		
	If drQuestion.Read() Then
		drQuestion.Close()
		If CalenderEventInclude = "1" Then
			cmd.CommandText = "UPDATE [CalenderEvent] SET [CalenderEventInclude]= '0' WHERE [CalenderEventID] =" & CalenderEventID 
		Else
			cmd.CommandText = "UPDATE [CalenderEvent] SET [CalenderEventInclude]= '1' WHERE [CalenderEventID] =" & CalenderEventID 
		End If
		cmd.ExecuteNonQuery()
	End If
	
	drQuestion.Dispose()
	cmd.Dispose()
	cnQuestion.Close()
	cnQuestion.Dispose()

End If

response.Redirect("Calender_event_list.aspx?CalenderCategoryID=" & CalenderCategoryID & "&CalenderCategory=" & CalenderCategory)
%>
