<%@ Page CodeBehind="Calender_category_delete.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Calender_category_delete" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>

<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			06-12-2001
'	Last modfied:		14-06-2004
'
'	Purpose: Delete categories for the calender module
'
'	Revision history:
'		1.0 - 17-12-2001 - Michael Skarum
'		First version.
'		1.1 - 14-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************
Dim intCalenderCategoryID As Integer
intCalenderCategoryID = request.QueryString.Item("CalenderCategoryID")

If Not isNothing(intCalenderCategoryID) And intCalenderCategoryID <> 0
	Dim cnCalenderDel	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdCalenderDel	As IDbCommand		= cnCalenderDel.CreateCommand()
	cmdCalenderDel.CommandText = "Delete FROM CalenderCategory WHERE CalenderCategoryID = " & intCalenderCategoryID
	cmdCalenderDel.ExecuteNonQuery()
	'Cleanup
	cmdCalenderDel.Dispose()
	cnCalenderDel.Dispose()
End if

response.Redirect("Calender_category_list.aspx")

%>
