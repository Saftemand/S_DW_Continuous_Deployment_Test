<%@ Page CodeBehind="Tagwall_Item_Save.aspx.vb" Language="vb" validateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Tagwall_Item_Save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<script language="VB" runat="Server">
Dim strTagwallID As String
Dim sql As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			12-07-2002
'	Last modfied:		12-07-2002
'
'	Purpose: File to edit items
'
'	Revision history:
'		1.0 - 12-07-2002 - Nicolai Pedersen
'		First version.
'**************************************************************************************************

Dim cnTagwallItem As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect As IDbCommand = cnTagwallItem.CreateCommand
Dim cmdUpdate As IDbCommand = cnTagwallItem.CreateCommand
Dim dsTagwallItem As DataSet = New DataSet
Dim daTagwallItem As IDbDataAdapter = Database.CreateAdapter()
daTagwallItem.SelectCommand = cmdSelect
Dim dtTagwallItem As DataTable
Dim row as DataRow

strTagwallID = request.Form.Item("TagwallID")
If Not strTagwallID = "" Then
	cmdSelect.CommandText = "SELECT * FROM TagwallItem WHERE TagwallItemID = " & strTagwallID
	daTagwallItem.SelectCommand = cmdSelect
	daTagwallItem.Fill(dsTagwallItem)
	dtTagwallItem = dsTagwallItem.Tables(0)
	row = dtTagwallItem.Rows(0)
	Database.CreateCommandBuilder(daTagwallItem)
Else
	Dim intAutoIndex as Integer = 0
	cmdSelect.CommandText = "SELECT MAX(TagwallItemID) AS AutoIndex FROM TagwallItem"
	daTagwallItem.SelectCommand = cmdSelect
	daTagwallItem.Fill(dsTagwallItem)

	If Not IsDBNull(dsTagwallItem.Tables(0).Rows(0).Item(0)) Then
		If IsNumeric(Cint(dsTagwallItem.Tables(0).Rows(0).Item(0))) Then
			intAutoIndex = Cint(dsTagwallItem.Tables(0).Rows(0).Item(0)) + 1
		Else
			intAutoIndex = 1
		End If
	Else
		intAutoIndex = 1
	End If

	dsTagwallItem = New DataSet
	cmdSelect.CommandText = "SELECT TOP 1 * FROM TagwallItem"
	daTagwallItem.Fill(dsTagwallItem)
	dtTagwallItem = dsTagwallItem.Tables(0)
	row = dtTagwallItem.NewRow()
	dtTagwallItem.Rows.Add(row)
	row.Item("TagwallItemID") = intAutoIndex
	row.Item("TagwallItemCategoryID") = request.Form.Item("CategoryID")
	
	Database.CreateCommandBuilder(daTagwallItem)
End If
		
'row.Item("TagwallItemCategoryID")	= Base.ChkValue(Request.form("TagwallItemCategoryID"))
row.Item("TagwallItemSender") = Base.ChkValue(request.Form.Item("TagwallItemSender"))

If Not IsNothing(request.Form.GetValues("TagwallItemFrontendID")) Then
	row.Item("TagwallItemDate") = request.Form.Item("TagwallItemDate")
Else
	Dim dato as new Dates()
	row.Item("TagwallItemDate") = dato.ParseDate("TagwallItemDate")
End If

If Not IsNothing(request.Form.GetValues("TagwallItemFrontendID")) And Not IsNothing(request.Form.GetValues("TagwallItemText")) Then
	row.Item("TagwallItemText") = Replace(Base.ChkValue(CInt(request.Form.Item("TagwallItemText"))), vbCrLf, "<br>")
Else
	row.Item("TagwallItemText") = Base.ChkValueNoStrip(CStr(request.Form.Item("TagwallItemText")))
End If

row.Item("TagwallItemActive") = Base.ChkBoolean(CStr(request.Form.Item("TagwallItemActive")) & "")

'Updates Database
daTagwallItem.Update(dsTagwallItem)

'Disposes all objects with reference to the connection.
dtTagwallItem.Dispose()
dsTagwallItem.Dispose()
cmdSelect.Dispose()
cnTagwallItem.Dispose()

If Not IsNothing(request.Form.GetValues("TagwallItemFrontendID")) Then
	response.Redirect("/Default.aspx?ID=" & request.Form.Item("TagwallItemFrontendID"))
Else
	response.Redirect("Tagwall_Item_List.aspx?CategoryID=" & request.Form.Item("CategoryID"))
End If

%>
