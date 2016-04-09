<%@ Page CodeBehind="NewsletterExtended_Archive.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Archive" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
Dim Sql As String
Dim varLocation As String
Dim StatusText As String
Dim SearchStr As String
Dim Position As Integer
Dim SQLSearchStr As String
Dim PositionNext As Integer
Dim PositionCount As Integer
Dim recordCount As Integer
Dim SortOrder As String
Dim CategoryID As String
Dim SortColumn As String
Dim NLRowNumbers As String
Dim strLocalUrl as String

CategoryID = Request.Item("ID")
SortColumn = Request.Item("SortColumn")
SortOrder = Request.Item("SortOrder")
Position = Base.ChkNumber(Request.Item("Position"))
SearchStr = Request.Item("SearchStr")

NLRowNumbers = Base.GetGS("/Globalsettings/Modules/NewsletterExtended/Lists/NumberOfRowsInLists")

recordCount = 0
PositionCount = 0
If NLRowNumbers = "" Then
	NLRowNumbers = 20
End If
PositionNext = Base.ChkNumber(Position) + CInt(NLRowNumbers)

If isNothing(Position) Then
	Position = 0
End If
If SortColumn = "" Then
	SortColumn = "NewsletterName"
End If
If SortOrder = "" Then
	SortOrder = "ASC"
End If

Sql = " SELECT 	[NewsLetterCategoryLetterID], " & " [NewsLetterCategoryLetterCategoryID],  " & " [NewsLetterCategoryLetterLetterID], " & " [NewsletterExtended].* " & " FROM 	[NewsLetterExtendedCategoryLetter] " & " INNER JOIN [NewsletterExtended] ON [NewsLetterExtendedCategoryLetter].[NewsLetterCategoryLetterLetterID] = [NewsletterExtended].[NewsletterID] " & " WHERE [NewsLetterCategoryLetterCategoryID] = " & CategoryID
If SearchStr <> "" Then
	SQLSearchStr = Replace(SearchStr, "'", "''")
	Sql = Sql & " AND ( NewsletterName LIKE '%" & SQLSearchStr & "%' OR NewsletterDescription LIKE '%" & SQLSearchStr & "%' OR NewsletterMailSubject LIKE '%" & SQLSearchStr & "%' OR NewsletterMailSenderName LIKE '%" & SQLSearchStr & "%' OR NewsletterMailSenderEmail LIKE '%" & SQLSearchStr & "%' )"
End If

Dim newsletterConn As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletter As IDbCommand = newsletterConn.CreateCommand

Dim adNewsletterAdapter As IDbDataAdapter = Database.CreateAdapter()
Database.CreateCommandBuilder(adNewsletterAdapter)
Dim dsNewsletter As DataSet = New DataSet

cmdNewsletter.CommandText = SQL
adNewsletterAdapter.SelectCommand = cmdNewsletter
adNewsletterAdapter.Fill(dsNewsletter)

Dim dvNewsletterExtended As DataView = New DataView(dsNewsletter.Tables(0))

If dvNewsletterExtended.Count > 0 Then
	dvNewsletterExtended.Sort = SortColumn & " " & SortOrder
End If

varLocation = "location='NewsletterExtended_archive.aspx?ID=" & CategoryID & "&SortOrder=" & SortOrder & "&SearchStr=" & Server.URLEncode(SearchStr) & "&SortColumn="

If SortOrder = "ASC" Then
	SortOrder = "DESC"
Else
	SortOrder = "ASC"
End If

StatusText = dvNewsletterExtended.Count & " " & Translate.Translate("breve") & ", " & Position & " - "
If PositionNext > dvNewsletterExtended.Count Then
	StatusText = StatusText & dvNewsletterExtended.Count
Else
	StatusText = StatusText & PositionNext
End If

strLocalUrl = Mid(Request.ServerVariables.Item("URL"), InStrRev(Request.ServerVariables.Item("URL"), "/") + 1) & "?" & Request.ServerVariables.Item("QUERY_STRING")
strLocalUrl = Server.HtmlEncode(strLocalUrl)

%>

<SCRIPT LANGUAGE="JavaScript">
<!--
parent.updateinfo('<%=StatusText%>');

function MyLink(varMyLink)
{
	parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
	parent.updateinfo('');
	location=varMyLink
}

function NewsletterStats(NewsletterID)
{
	parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
	parent.updateinfo('');
	top.right.location="/admin/module/newsletterextended/statisticsv2/menu.aspx";
}

function DeleteMail(NewsletterID)
{	
	if(confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("nyhedsbrev"))%>"))
		location="NewsletterExtended_letter_del.aspx?ID=" + NewsletterID + "&CategoryID=<%=CategoryID%>&SortOrder=<%=SortOrder%>&SortColumn=<%=SortColumn%>&Path=<%=strLocalUrl%>";
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
		<td width='16' background="../../images/HeaderBG.gif"></td>
		<td width='16' background="../../images/HeaderBG.gif"></td>
		<td class='H' onclick="<%=varLocation%>NewsletterName';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Navn")%></strong></td>
		<td class='H' onclick="<%=varLocation%>NewsletterMailSubject';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Subject")%></strong></td>
		<td class='H' onclick="<%=varLocation%>NewsletterMailSenderName';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Afsenders Navn")%></strong></td>
		<td class='H' onclick="<%=varLocation%>NewsletterSendCreated';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Afsendt dato")%></strong></td>
		<td background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Slet")%></strong></td>
	</tr>
	<%
For j As Integer = 0 To dvNewsletterExtended.Count - 1
	If CInt(PositionCount) >= CInt(Position) And CInt(PositionCount) < CInt(PositionNext) Then
		response.Write("<tr onmouseout='ccb(this);' onmouseover='cc(this);'>" & vbNewLine & _ 
		"<td width='25' onclick=""location='NewsletterExtended_Letter_Body.aspx?ID=" & dvNewsletterExtended(j)("NewsletterID") & "&Tab=Tab1';"" class='H'>&nbsp;" & vbNewLine & _
		"<img alt src='../../Images/Icons/Module_Newsletter_Archive_Small.gif' border='0'>" & vbNewLine & _
		"</td>" & vbNewLine & _
		"<td onClick='Javascript:NewsletterStats(" & dvNewsletterExtended(j)("NewsletterID") & ");' class='H' width='30'>&nbsp;" & vbNewLine & _
		"<img alt src='../../Images/Icons/Module_Newsletter_Stat_Small.gif' border='0'>" & vbNewLine & _
		"</td>" & vbNewLine & _
		"<td onclick=""location='NewsletterExtended_Letter_Body.aspx?ID=" & dvNewsletterExtended(j)("NewsletterID") & "&Tab=Tab1';"" class='H'>" & vbNewLine & _
		dvNewsletterExtended(j)("NewsletterName") & vbNewLine & _
		"</td>" & vbNewLine & _
		"<td onclick=""location='NewsletterExtended_Letter_Body.aspx?ID=" & dvNewsletterExtended(j)("NewsletterID") & "&Tab=Tab1';"" class='H'>" & vbNewLine & _
		dvNewsletterExtended(j)("NewsletterMailSubject") & vbNewLine & "</td>" & vbNewLine & _
		"<td onclick=""location='NewsletterExtended_Letter_Body.aspx?ID=" & dvNewsletterExtended(j)("NewsletterID") & "&Tab=Tab1';"" class='H'>" & vbNewLine & _
		dvNewsletterExtended(j)("NewsletterMailSenderName") & vbNewLine & _
		"</td>" & vbNewLine & _
		"<td onclick=""location='NewsletterExtended_Letter_Body.aspx?ID=" & dvNewsletterExtended(j)("NewsletterID") & "&Tab=Tab1';"" class='H'>")
		
		If dvNewsletterExtended(j)("NewsletterSendCreated").ToString() <> "" Then
			response.Write(Dates.ShowDate(CDate(dvNewsletterExtended(j)("NewsletterSendCreated").ToString()), Dates.Dateformat.Short, False))
		End If
		response.Write("</td>" & vbNewLine & _
		"<td valign='middle'><a href=""JavaScript:DeleteMail('" & dvNewsletterExtended(j)("NewsletterID") & "')"">" & vbNewLine & _
		"&nbsp;&nbsp;<img src=""../../images/Delete.gif"" border=""0"" width=""15"" height=""17""></a>" & vbNewLine & _
		"</td>" & vbNewLine & _
		"</tr>")
	End If
	PositionCount = PositionCount + 1
Next j
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

response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & _
			   "<!--" & vbNewLine & _
			   "parent.document.getElementById(""StatusFrame"").setAttribute(""src"", ""NewsletterExtended_Paging_search.aspx?TypeID=" & CategoryID & "&Position=" & Position & "&SearchStr=" & Server.URLEncode(SearchStr) & "&Amount=" & dvNewsletterExtended.Count & "&SortOrder=" & SortOrder & "&Type=NewsletterExtended_archive" & """);" & vbNewLine & _
			   "//-->" & vbNewLine & _
			   "</SCRIPT>")

Translate.GetEditOnlineScript()

dsNewsletter.Dispose()
cmdNewsletter.Dispose() 
newsletterConn.Dispose()

%>

