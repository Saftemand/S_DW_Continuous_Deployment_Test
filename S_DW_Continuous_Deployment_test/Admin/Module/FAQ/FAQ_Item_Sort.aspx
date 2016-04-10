<%@ Page CodeBehind="FAQ_Item_Sort.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Item_Sort" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim strCategoryID As String
Dim strFAQItemVersionParentID As Object
Dim strStrParentIDSQL As String
Dim strMoveDirection As String
Dim strFAQItemID As String
Dim SortListByRecordSet As Object
Dim i As Integer

strFAQItemID = request.QueryString.Item("FAQItemID")
strMoveDirection = request.QueryString.Item("MoveDirection")
strCategoryID = request.QueryString.Item("CategoryID")

Dim cn		As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmd		As IDbCommand		= cn.CreateCommand
Dim ds		As DataSet			= New DataSet
Dim da		As IDbDataAdapter	= Database.CreateAdapter()
da.SelectCommand				= cmd
Dim dt		As DataTable
Dim row		As DataRow
cmd.CommandText = "SELECT * FROM [FAQItem] WHERE [FAQItemCategoryID] = " & strCategoryID & " ORDER BY [FAQItemSort] ASC"
da.Fill(ds)
dt = ds.Tables(0)
row = dt.Rows(0)

i = 1
For intRowNumber As Integer = 0 To dt.Rows.Count - 1
	row = dt.Rows(intRowNumber)
	If CInt(row("FAQItemID")) = CInt(strFAQItemID) Then
		If strMoveDirection.ToLower() = "up" Then
			row("FAQItemSort") = i - 3
		Else
			row("FAQItemSort") = i + 3
		End If
	Else
		row("FAQItemSort") = i
	End If
	i = i + 2
Next intRowNumber

Database.CreateCommandBuilder(da)
da.Update(ds)

ds.Dispose()
cmd.Dispose()
cn.Dispose()


response.Redirect("FAQ_Item_List.aspx?CategoryID=" & strCategoryID)
%>
