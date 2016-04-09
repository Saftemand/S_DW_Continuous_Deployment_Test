<%@ Page CodeBehind="NewsletterExtended_ListList.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_ListList" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

Dim NLRowNumbers As String
Dim Position As String
Dim varLocation As String
Dim StatusText As String
Dim PositionCount As Integer
Dim NLShowAllOnList As String
Dim PositionNext As String
Dim Sql As String
Dim SearchStr As String
Dim strLocalUrl As String
Dim AllCategoryField As String
Dim recordCount As Integer
Dim CategoryID As String
Dim SortColumn As String
Dim SortOrder As String
Dim j As Integer
CategoryID = Request.Item("ID")
SortColumn = Request.Item("SortColumn")
SortOrder = Request.Item("SortOrder")
Position = Request.Item("Position")
SearchStr = Request.Item("SearchStr")
AllCategoryField = ""

recordCount = 0
PositionCount = 0
If NLRowNumbers = "" Then
	NLRowNumbers = 20
End If
If NLShowAllOnList = "1" Then
	NLRowNumbers = 32000
End If

PositionNext = Base.ChkNumber(Position) + CInt(NLRowNumbers)

If Position = "" Then
	Position = 0
End If
If SortColumn = "" Then
	SortColumn = "Name"
End If
If SortOrder = "" Then
	SortOrder = "ASC"
End If
If CategoryID = "" Then
	Sql = " SELECT '0' AS Type, NewsletterCategoryID AS ID, NewsletterCategoryName AS Name, '' AS Created, 0 as RType FROM NewsletterExtendedCategory " & " WHERE NewsletterCategoryName LIKE '%" & SearchStr & "%'"
Else
	Sql = " SELECT distinct '1' AS Type, NewsletterExtendedRecipient.NewsletterRecipientID AS ID, " & " NewsletterExtendedRecipient.NewsletterRecipientName AS Name, NewsletterExtendedRecipient.NewsletterRecipientCreated AS Created, NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientType as RType " & " FROM (NewsletterExtendedRecipient INNER JOIN NewsletterExtendedCategoryRecipient ON NewsletterExtendedRecipient.NewsletterRecipientID = NewsLetterExtendedCategoryRecipient.NewsLetterCategoryRecipientRecipientID) LEFT JOIN NewsletterExtendedEmailCheck ON NewsletterExtendedRecipient.NewsletterRecipientID = NewsletterExtendedEmailCheck.NewsletterEmailCheckRecipientID " & " WHERE NewsLetterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID = " & CategoryID & " AND NewsletterExtendedRecipient.NewsletterRecipientName LIKE '%" & SearchStr & "%'" & " UNION " & " SELECT '2' AS Type, [NewsLetterCategoryLetterLetterID] AS ID, " & " [NewsletterExtended].NewsletterName AS Name, " & " [NewsletterExtended].NewsletterSendCreated AS Created, 0 as RType " & " FROM 	[NewsLetterExtendedCategoryLetter] " & " INNER JOIN [NewsletterExtended] ON [NewsLetterExtendedCategoryLetter].[NewsLetterCategoryLetterLetterID] = [NewsletterExtended].[NewsletterID] " & " WHERE [NewsLetterCategoryLetterCategoryID] = " & CategoryID & " AND [NewsletterExtended].NewsletterName LIKE '%" & SearchStr & "%'"
End If


Dim newsletterConn As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletter As IDbCommand = newsletterConn.CreateCommand

Dim adNewsletterAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adNewsletterAdapter)
Dim dsNewsletter As DataSet = New DataSet

cmdNewsletter.CommandText = SQL
adNewsletterAdapter.SelectCommand = cmdNewsletter
adNewsletterAdapter.Fill(dsNewsletter)

Dim categoryView As DataView = New DataView(dsNewsletter.Tables(0))

If categoryView.count > 0 Then
	categoryView.Sort = SortColumn & " " & SortOrder
End If

If SortOrder = "ASC" Then
	SortOrder = "DESC"
Else
	SortOrder = "ASC"
End If

varLocation = "location='NewsletterExtended_ListList.aspx?ID=" & CategoryID & "&SortOrder=" & SortOrder & "&SearchStr=" & Server.URLEncode(SearchStr) & "&SortColumn="

StatusText = categoryView.Count & " " & Translate.JSTranslate("modtagere") & ", " & Position & " - "
If PositionNext > categoryView.Count Then
	StatusText = StatusText & categoryView.Count
Else
	StatusText = StatusText & PositionNext
End If

strLocalUrl = Mid(Request.ServerVariables.Item("URL"), InStrRev(Request.ServerVariables.Item("URL"), "/") + 1) & "?" & Request.ServerVariables.Item("QUERY_STRING")
strLocalUrl = Server.HtmlEncode(strLocalUrl)
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
parent.updateinfo('<%=StatusText%>');

function MyLink(ID, Type, Rtype)
{
parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
parent.updateinfo('');
if(Type == "1")
	location="NewsletterExtended_recipient_edit.aspx?RecipientID=" + ID + "&RecipientType=" + Rtype
else
	location="NewsletterExtended_letter_body.aspx?ID=" + ID + "&Tab=Tab1&RecipientType=" + Rtype
}

function DeleteRecipient(ID, Type)
{	
	if(Type=="0") 
	{
		if(confirm("<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JsTranslate("liste"))%>")) 
		{
			location="NewsletterExtended_Category_del.aspx?ID=" + ID + "&Type=" + Type + "&SortOrder=<%=SortOrder%>&SortColumn=<%=SortColumn%>&Path=<%=strLocalUrl%>";
		}
	} 
	else if(Type=="1") 
	{
		if(confirm("<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("modtager"))%>")) 
		{
			location="NewsletterExtended_recipient_del.aspx?RecipientID=" + ID + "&Type=" + Type + "&CategoryID=<%=CategoryID%>&SortOrder=<%=SortOrder%>&SortColumn=<%=SortColumn%>&Path=<%=strLocalUrl%>";
		}
	} 
	else if(Type=="2") 
	{
		if(confirm("<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("nyhedsbrev"))%>")) 
		{
			location="NewsletterExtended_letter_del.aspx?ID=" + ID + "&Type=" + Type + "&CategoryID=<%=CategoryID%>&SortOrder=<%=SortOrder%>&SortColumn=<%=SortColumn%>&Path=<%=strLocalUrl%>";
		}
	}
}

function cc(objRow){ //Change color of row when mouse is over... (ChangeColor)
	objRow.style.backgroundColor='#E1DED8';
}

function ccb(objRow){ //Remove color of row when mouse is out... (ChangeColorBack)
	objRow.style.backgroundColor='';
}

//-->
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

</HEAD>
<BODY>
<table cellpadding=0 cellspacing=0 border=0 class=cleantable  style="margin:0px;" width="100%">
	<tr bgColor="#E1DED8" height=20 width="100%">
		<td background="../../images/HeaderBG.gif"></td>
		<td class='H' onclick="<%=varLocation%>Name';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Navn")%></strong></td>
		<td class='H' onclick="<%=varLocation%>Created';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Oprettet")%></strong></td>
		<td background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Slet")%></strong></td>
	</tr>
	<%
	For j = 0 To categoryView.count - 1
		If CInt(PositionCount) >= CInt(Position) And CInt(PositionCount) < CInt(PositionNext) Then
			response.Write("<tr onmouseout='ccb(this);' onmouseover='cc(this);' height='20px'>" & vbNewLine & "<td class='H' onclick='Javascript:MyLink(" & categoryView(j)("ID").ToString & ", " & categoryView(j)("Type").ToString & ", " & categoryView(j)("RType").ToString & ");'>&nbsp;" & vbNewLine)
			If categoryView(j)("Type").ToString = "0" Then response.Write("<img alt src='../../Images/Icons/Module_Newsletter_Lists_Small.gif' border='0'>" & vbNewLine)
			If categoryView(j)("Type").ToString = "1" Then response.Write("<img alt src='../../Images/Icons/Module_Newsletter_User_Small.gif' border='0'>" & vbNewLine)
			If categoryView(j)("Type").ToString = "2" Then response.Write("<img alt src='../../Images/Icons/Module_Newsletter_Archive_Small.gif' border='0'>" & vbnewline)

			response.Write("</td>" & vbNewLine & "<td class='H' onclick='Javascript:MyLink(" & categoryView(j)("ID").ToString & ", " & categoryView(j)("Type").ToString & ", " & categoryView(j)("RType").ToString & ");'>" & vbNewLine & categoryView(j)("Name").ToString & vbNewLine & "</td>" & vbNewLine & "<td class='H' onclick='Javascript:MyLink(" & categoryView(j)("ID").ToString & ", " & categoryView(j)("Type").ToString & ", " & categoryView(j)("RType").ToString & ");'>" & vbNewLine)

			If IsDate(categoryView(j)("Created").ToString) Then
				response.Write(Dates.ShowDate(CDate(categoryView(j)("Created").ToString), Dates.Dateformat.Short, False) & vbNewLine)
			Else
				response.Write("" & vbNewLine)
			End If
			response.Write("</td>")
			response.Write("<td valign='middle'><a href=""JavaScript:DeleteRecipient(" & categoryView(j)("ID").ToString & ", " & categoryView(j)("Type").ToString & ");"">" & vbNewLine & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=""../../images/Delete.gif"" border=""0"" width=""15"" height=""17"" alt=""" & Translate.Translate("Slet") & """></a>" & vbNewLine & "</td>" & vbNewLine & "</tr>")
		End If
		PositionCount = PositionCount + 1
	Next
%>
</table>

</BODY>
</HTML>
<%
If SortOrder = "ASC" Then
	SortOrder = "DESC"
Else
	SortOrder = "ASC"
End If

response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & "<!--" & vbNewLine & "parent.document.getElementById(""StatusFrame"").setAttribute(""src"", ""NewsletterExtended_Paging_search.aspx?TypeID=" & CategoryID & "&Position=" & Position & "&SearchStr=" & Server.URLEncode(SearchStr) & "&Amount=" & categoryView.count & "&SortOrder=" & SortOrder & "&AllCategoryField=" & AllCategoryField & "&Type=NewsletterExtended_ListList" & """);" & vbNewLine & "//-->" & vbNewLine & "</SCRIPT>")
dsNewsletter.Dispose()
cmdNewsletter.Dispose()
newsletterConn.Dispose()
Translate.GetEditOnlineScript()
%>
