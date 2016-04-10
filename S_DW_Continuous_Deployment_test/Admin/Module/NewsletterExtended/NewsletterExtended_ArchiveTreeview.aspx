<%@ Page CodeBehind="NewsletterExtended_ArchiveTreeview.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_ArchiveTreeview" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<%

Dim strImgSource As String
Dim strOnclickwBold2 As String
Dim strOnclickwBold1 As String
Dim strOnclick As String
Dim Sql As String

''' get translated default words
Dim varArchive As String
Dim varReceiver As String

Dim cnCategory As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdCategory As IDbCommand = cnCategory.CreateCommand()
cmdCategory.CommandText = "SELECT * FROM NewsletterExtendedCategory"
Dim drCategory As IDataReader = cmdCategory.ExecuteReader

varArchive = Translate.Translate("Sendte breve")
varReceiver = Translate.Translate("Modtager")
%>
<SCRIPT LANGUAGE="JavaScript">
<!--

function hideSpan(Type, ID)
{
	var strType
	if(Type == 1)
		strType = "List_"
	else
		strType = "Letters_"

	document.getElementById(strType + ID).style.display= 'none'
	document.getElementById("img" + strType + ID).setAttribute("src", "../../images/Expand.gif")
	document.getElementById("img" + strType + ID).setAttribute("onclick", "unhideSpan(" + Type + ", " + ID + ");")
	document.getElementById("img" + strType + ID).outerHTML = document.getElementById("img" + strType + ID).outerHTML
}

//Unhides a menu level (including all its sublevels). It Unhide the SPAN ([ParentID]_Childs) containing the submenus and changes the
//Image and onclick events on the Expand/Expand_Off button so it can hide the span again when clicked.
function unhideSpan(Type, ID) {
	var strType
	if(Type == 1)
		strType = "List_"
	else
		strType = "Letters_"
		
	document.getElementById(strType + ID).style.display= ''
	document.getElementById("img" + strType + ID).setAttribute("src", "../../images/Expand_off.gif")
	document.getElementById("img" + strType + ID).setAttribute("onclick", "hideSpan(" + Type + ", " + ID + ");")
	document.getElementById("img" + strType + ID).outerHTML = document.getElementById("img" + strType + ID).outerHTML
}

function hl(menuObject, ID) { 
	if(ID)	{
		menuObject.style.textDecoration = "underline";
		self.status = "ID: " + ID;
	} else {
		menuObject.style.textDecoration = "";
		self.status = "";
	}
}

//a variable holding the current clicked object
menuObject = ""

//the function is called when right-clicking a menuitem. calls the function that shows the contexts-menu
hide = true;

var objPrev
function MakeBold(objCur) {
	if(objPrev)
		objPrev.style.fontWeight="";
	
	if(objCur)
		objCur.style.fontWeight="bold";

	objPrev = objCur;
}


function hl_off(cellObject){ //Remove underline from name of folder when mouse is out
	cellObject.style.textDecoration = "";
}

function hl(cellObject){ //Underline name of folder when mouse is over
	cellObject.style.textDecoration = "underline";
}

//-->
</SCRIPT>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<title><%Translate.Translate("Mail-arkiv")%></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<HEAD>
</HEAD>

<body onMouseover="this.style.cursor = 'default'" style="background-color:#ECE9D8;margin:0px;">

<table cellspacing=0 cellpadding="0" border="0" ID="MenuOpen" style="display:none;" width="100%">
	<tr height=17>
		<td align=center><img src="/Admin/Images/OpenTreeView_off.gif" onmouseover="this.src='/Admin/Images/OpenTreeView_on.gif'" onmouseout="this.src='/Admin/Images/OpenTreeView_off.gif'" onmousedown="this.src='/Admin/Images/OpenTreeView_press.gif'" onmouseup="this.src='/Admin/Images/OpenTreeView_on.gif'" onClick="openMenu();"></td>
	</tr>
	<tr>
		<td><DIV STYLE="writing-mode:tb-rl">&nbsp;<strong>Navigation</strong></div></td>
	</td>
</table>

<table cellspacing=0 cellpadding=0 border=0 height=100% width=245 ID="MenuTable" style="display:">
	<tr bgColor="#FFFFFF">
		<td width="5" bgColor="#ECE9D8" rowspan="3"><img src="/Admin/Images/Nothing.gif" width="5"></td>
		<td valign="top">
			<table cellspacing="0" height="100%" cellpadding="0" border="0" id="TreeBox" width="190">
				<tr height="23" bgColor="#ECE9D8" ID="TreeStart">
					<td colspan="3">
						<table cellspacing=0 cellpadding=0 border=0 width="100%" ID="Table1">
							<tr>
								<td>&nbsp;<strong>Navigation (36)</strong></td>
								
								<td align="right" width="20"><img style="cursor: pointer" src="/Admin/images/CloseTreeView_off.gif" onmouseover="this.src='/Admin/images/CloseTreeView_on.gif'" onmouseout="this.src='/Admin/Images/CloseTreeView_off.gif'" onmousedown="this.src='/Admin/Images/CloseTreeView_press.gif'" onmouseup="this.src='/Admin/Images/CloseTreeView_on.gif'" onClick="self.close();"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr bgColor="#ACA899" height=1>
					<td colspan="3"></td>
				</tr>
				<tr  align="left" valign="top" height="100%" nowrap>
					<td align="left" valign="top" nowrap colspan="3">
						<div height="100%" style="height:100%;width:240px;overflow:auto;">
							<div id="List">
							<img src="../../images/nothing.gif" width="9" height="13">
							<img class="H" id="imgList_0" onclick="unhideSpan(1,0);" src="../../images/Expand.gif" width="9" height="13">
							<img class='H' onclick="unhideSpan(1,0); MakeBold(document.getElementById('TEXT_List_0')); parent.document.getElementById('ListRight').setAttribute('src', 'NewsletterExtended_ListList.asp');" align="absMiddle" src='../../images/icons/Module_Newsletter_Lists_Small.gif'>
							<a class='H' ID="TEXT_List_0" onmouseout='hl_off(this);' onmouseover='hl(this);' onclick="unhideSpan(1,0);MakeBold(this); parent.document.getElementById('ListRight').setAttribute('src', 'NewsletterExtended_ListList.asp');"><%=Translate.Translate("Lister")%></a>
								<div style='display:none' id="List_0">
									<%
									
Dim cnNewsletter As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletter As IDbCommand = cnNewsletter.CreateCommand()
Dim drNewsletter As IDataReader 

Do While drCategory.Read()
	'''''''''''''''''''''''''''' Arkiv ''''''''''''''''''''''''''''''''''''''''
	cmdNewsletter.CommandText = "	SELECT NewsletterExtendedCategoryLetter.NewsLetterCategoryLetterCategoryID, NewsletterExtended.NewsletterName, NewsletterExtended.NewsletterID " & "	FROM NewsletterExtended INNER JOIN NewsletterExtendedCategoryLetter ON NewsletterExtended.NewsletterID = NewsletterExtendedCategoryLetter.NewsLetterCategoryLetterLetterID " & "	WHERE NewsletterExtendedCategoryLetter.NewsLetterCategoryLetterCategoryID = " & drCategory("NewsletterCategoryID").ToString & " AND NewsletterExtended.NewsletterLevel = 3 "
	drNewsletter = cmdNewsletter.ExecuteReader						
	Dim blnDrNewsletterHasRows As Boolean = false		
	If drNewsletter.Read() Then
		blnDrNewsletterHasRows = true
		strOnclick = "onclick='unhideSpan(1," & drCategory("NewsletterCategoryID").ToString & ");'"
		strOnclickwBold1 = "onclick='MakeBold(document.getElementById(""TEXT_ListCat_" & drCategory("NewsletterCategoryID").ToString & """));unhideSpan(1," & drCategory("NewsletterCategoryID").ToString & ");'"
		strOnclickwBold2 = "onclick='MakeBold(this);unhideSpan(1," & drCategory("NewsletterCategoryID").ToString & ");'"
		strImgSource = "src='../../images/Expand.gif'"
	Else
		strOnclick = ""
		strOnclickwBold1 = ""
		strOnclickwBold2 = ""
		strImgSource = "src='../../images/Expand_dot.gif'"
	End If
	Response.Write("<div nowrap>" & vbNewLine & "<img src='../../images/nothing.gif' width='23' height='13'>" & vbNewLine & "<img class='H' id='imgList_" & drCategory("NewsletterCategoryID").ToString & "' " & strOnclick & " " & strImgSource & " width='9' height='13'> " & vbNewLine & "<img class='H' align='absMiddle' " & strOnclickwBold1 & " src='../../images/icons/Module_Newsletter_Lists_Small.gif'>" & vbNewLine & "<a class='H' onmouseout='hl_off(this);' onmouseover='hl(this);' ID='TEXT_ListCat_" & drCategory("NewsletterCategoryID").ToString & "' " & strOnclickwBold2 & ">" & drCategory("NewsletterCategoryName").ToString & "</a>" & vbNewLine)
	
	drNewsletter.Close()
		
	If blnDrNewsletterHasRows Then
		Response.Write("<div nowrap style='display:none' id='List_" & drCategory("NewsletterCategoryID").ToString & "'>" & vbNewLine)
		drNewsletter = cmdNewsletter.ExecuteReader
		Do While drNewsletter.Read()
			Response.Write("<div nowrap id='List_" & drNewsletter("NewsletterID").ToString & "'_Archive>" & vbNewLine & "<img src='../../images/nothing.gif' width='38' height='13'>" & vbNewLine & "<img class='H' src='../../images/Expand_dot.gif' width='9' height='13'> " & vbNewLine & "<img class='H' onclick=""location = 'NewsletterExtended_letter_copy.aspx?NewsletterID=" & drNewsletter("NewsletterID").ToString & "';"" align='absMiddle' src='../../images/icons/Module_Newsletter_Archive_Small.gif'>" & vbNewLine & "<a class='H' onmouseout='hl_off(this);' onmouseover='hl(this);' ID='TEXT_ListMail_" & drNewsletter("NewsletterID").ToString & "' onclick=""location = 'NewsletterExtended_letter_copy.aspx?NewsletterID=" & drNewsletter("NewsletterID").ToString & "';"">" & drNewsletter("NewsletterName").ToString & vbNewLine & "</a>" & "</div>")
		Loop 
		Response.Write("</div>")
	End If
	'Response.Write	"</div>"
	'''''''''''''''''''''''''''' Arkiv Slut''''''''''''''''''''''''''''''''''''''''										
	Response.Write("</div>")
	'w rsCategory(1)
	drNewsletter.Close()
Loop 

'''''''''''''''''''''''''''' Ikke sendte ''''''''''''''''''''''''''''''''''''''''										
cmdNewsletter.CommandText = "	SELECT NewsletterExtended.NewsletterName, NewsletterExtended.NewsletterID " & "	FROM NewsletterExtended  " & "	WHERE NewsletterExtended.NewsletterLevel IN (1,2) "
drNewsletter = cmdNewsletter.ExecuteReader					
Dim blnDrNewsletterHasRow As Boolean = false		

If drNewsletter.Read() Then
	blnDrNewsletterHasRow = true
	strOnclick = "onclick='unhideSpan(1,999999);'"
	strOnclickwBold1 = "onclick='MakeBold(document.getElementById(""TEXT_ListCat_999999""));unhideSpan(1,999999);'"
	strOnclickwBold2 = "onclick='MakeBold(this);unhideSpan(1,999999);'"
	strImgSource = "src='../../images/Expand.gif'"
Else
	strOnclick = ""
	strOnclickwBold1 = ""
	strOnclickwBold2 = ""
	strImgSource = "src='../../images/Expand_dot.gif'"
End If
Response.Write("<div nowrap>" & vbNewLine & "<img src='../../images/nothing.gif' width='23' height='13'>" & vbNewLine & "<img class='H' id='imgList_999999' " & strOnclick & " " & strImgSource & " width='9' height='13'> " & vbNewLine & "<img class='H' align='absMiddle' " & strOnclickwBold1 & " src='../../images/icons/Module_Newsletter_Letter_Small.gif'>" & vbNewLine & "<a class='H' onmouseout='hl_off(this);' onmouseover='hl(this);' ID='TEXT_ListCat_999999' " & strOnclickwBold2 & ">" & Translate.Translate("Nyhedsbreve") & "</a>" & vbNewLine)

drNewsletter.Close()
If blnDrNewsletterHasRow Then
	Response.Write("<div nowrap style='display:none' id='List_999999'>" & vbNewLine)
	
	drNewsletter = cmdNewsletter.ExecuteReader
	
	Do While drNewsletter.Read()
		Response.Write("<div nowrap id='List_" & drNewsletter("NewsletterID").ToString & "'_Archive>" & vbNewLine & "<img src='../../images/nothing.gif' width='38' height='13'>" & vbNewLine & "<img class='H' src='../../images/Expand_dot.gif' width='9' height='13'> " & vbNewLine & "<img class='H' onclick=""location = 'NewsletterExtended_letter_copy.aspx?NewsletterID=" & drNewsletter("NewsletterID").ToString & "';"" align='absMiddle' src='../../images/icons/Module_Newsletter_LetterDraft_Small.gif'>" & vbNewLine & "<a class='H' onmouseout='hl_off(this);' onmouseover='hl(this);' ID='TEXT_ListMail_" & drNewsletter("NewsletterID").ToString & "' onclick=""location = 'NewsletterExtended_letter_copy.aspx?NewsletterID=" & drNewsletter("NewsletterID").ToString & "';"">" & drNewsletter("NewsletterName").ToString & vbNewLine & "</a>" & "</div>")
	Loop 
	Response.Write("</div>")
End If

drNewsletter.Dispose()
cmdNewsletter.Dispose()
cnNewsletter.Dispose()

drCategory.Dispose()
cmdCategory.Dispose()
cnCategory.Dispose()


'''''''''''''''''''''''''''' Ikke slut ''''''''''''''''''''''''''''''''''''''''	
%>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</BODY>

</HTML>
<SCRIPT LANGUAGE="JavaScript">
<!--
	unhideSpan(1, 0)
//-->
</SCRIPT>
<%
Translate.GetEditOnlineScript()

%>
