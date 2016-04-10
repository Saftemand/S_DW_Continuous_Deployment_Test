<%@ Page CodeBehind="NewsletterExtended_ListLetters.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_ListLetters" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
Dim SearchStr As String
Dim NLRowNumbers As String
Dim PositionCount As Integer
Dim StatusText As String
Dim strLocalUrl As String
Dim Sql As String
Dim PositionNext As String
Dim varLocation As String
Dim Position As String
Dim AllCategoryField As String
Dim SortColumn As String
Dim CategoryID As String
Dim SortOrder As String
Dim j As Integer

CategoryID = Request.Item("ID")
SortColumn = Request.Item("SortColumn")
SortOrder = Request.Item("SortOrder")
Position = Request.Item("Position")
SearchStr = Request.Item("SearchStr")
AllCategoryField = ""

PositionCount = 0

If NLRowNumbers = "" Then
	NLRowNumbers = 20
End If
PositionNext = Base.ChkNumber(Position) + CShort(NLRowNumbers)

If Position = "" Then
	Position = 0
End If
If SortColumn = "" Then
	SortColumn = "NewsletterName"
End If
If SortOrder = "" Then
	SortOrder = "ASC"
End If

Sql = " SELECT * FROM NewsletterExtended WHERE NewsletterLevel <= 2 "
If SearchStr <> "" Then
	Sql = Sql & " AND ( NewsletterName LIKE '%" & SearchStr & "%' OR NewsletterDescription LIKE '%" & SearchStr & "%')"
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

varLocation = "location='NewsletterExtended_ListLetters.aspx?ID=" & CategoryID & "&SortOrder=" & SortOrder & "&SearchStr=" & Server.URLEncode(SearchStr) & "&SortColumn="

StatusText = categoryView.Count & " " & Translate.Translate("modtager") & ", " & Position & " - "
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

function MyLink(RecipientID)
{
parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
parent.updateinfo('');
location="NewsletterExtended_letter_body.aspx?ID=" + RecipientID + "&Tab=Tab1"
}

function DeleteRecipient(ID, Type)
{	
	if(confirm("<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("nyhedsbrev"))%>"))
		location="NewsletterExtended_Letter_del.aspx?ID=" + ID + "&CategoryID=<%=CategoryID%>&SortOrder=<%=SortOrder%>&SortColumn=<%=SortColumn%>&Path=<%=strLocalUrl%>";
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
		<td class='H' onclick="<%=varLocation%>NewsletterName';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Navn")%></strong></td>
		<td class='H' onclick="<%=varLocation%>NewsletterSendCreated';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Oprettet")%></strong></td>
		<td background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Slet")%></strong></td>
	</tr>
	<%
	For j = 0 To categoryView.count - 1
		If CShort(PositionCount) >= CShort(Position) And CShort(PositionCount) < CShort(PositionNext) Then
			response.Write("<tr onmouseout='ccb(this);' onmouseover='cc(this);' height='20px'>" & vbNewLine & "<td class='H' onclick='Javascript:MyLink(" & categoryView(j)("NewsletterID").ToString & ");'>&nbsp;" & vbNewLine)
			response.Write("<img alt src='../../Images/Icons/Module_Newsletter_LetterDraft_Small.gif' border='0'>" & vbNewLine)
			response.Write("</td>" & vbNewLine & "<td class='H' onclick='Javascript:MyLink(" & categoryView(j)("NewsletterID").ToString & ");'>" & vbNewLine & categoryView(j)("NewsletterName").ToString & vbNewLine & "</td>" & vbNewLine & "<td class='H' onclick='Javascript:MyLink(" & categoryView(j)("NewsletterID").ToString & ");'>" & vbNewLine)
			If IsDate(categoryView(j)("NewsletterSendCreated").ToString) Then
				response.Write(Dates.ShowDate(CDate(categoryView(j)("NewsletterSendCreated").ToString), Dates.Dateformat.Short, False) & vbNewLine)
			Else
				response.Write("" & vbNewLine)
			End If
			response.Write("</td>")
			response.Write("<td valign='middle'><a href=""JavaScript:DeleteRecipient('" & categoryView(j)("NewsletterID").ToString & "')"">" & vbNewLine & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=""../../images/Delete.gif"" border=""0"" width=""15"" height=""17"" alt=""" & Translate.Translate("Slet %%", "%%", Translate.Translate("nyhedsbrev")) & """></a>" & vbNewLine & "</td>" & vbNewLine & "</tr>")
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

response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & "<!--" & vbNewLine & "parent.document.getElementById(""StatusFrame"").setAttribute(""src"", ""NewsletterExtended_Paging_search.aspx?TypeID=" & CategoryID & "&Position=" & Position & "&SearchStr=" & Server.URLEncode(SearchStr) & "&Amount=" & categoryView.Count & "&SortOrder=" & SortOrder & "&AllCategoryField=" & AllCategoryField & "&Type=NewsletterExtended_ListLetters" & """);" & vbNewLine & "//-->" & vbNewLine & "</SCRIPT>")
Translate.GetEditOnlineScript()
dsNewsletter.Dispose()
cmdNewsletter.Dispose()
newsletterConn.Dispose()
%>
