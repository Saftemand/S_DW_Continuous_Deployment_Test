<%@ Page CodeBehind="NewsletterExtended_Treeview.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Treeview" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>



<%
Dim Sql As String
Dim Home As Object
Dim NLShowAllUsersCategory As String

''' get translated default words
Dim varArchive As String
Dim varReceiver As String

Dim strNewsletterID As String
Dim strNewsletterName As String
Dim strNewsletterCategoryID As String
Dim strNewsletterCategoryName As String

Dim NewsletterExtConn As System.Data.IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletterExt As IDbCommand = NewsletterExtConn.CreateCommand

varArchive = Translate.Translate("Sendte breve")
varReceiver = Translate.Translate("Modtager")
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function hideSpan(Type, ID)
{
	var strType
	if(Type == 1) {
		strType = "List_"
	}
	else if(Type == 2){
		strType = "Letters_"
	}
	else {
		strType = "Filter_"
	}

	document.getElementById(strType + ID).style.display= 'none'
	document.getElementById("img" + strType + ID).setAttribute("src", "/Admin/images/Expand.gif")
	document.getElementById("img" + strType + ID).setAttribute("onclick", "unhideSpan(" + Type + ", " + ID + ");")
	document.getElementById("img" + strType + ID).outerHTML = document.getElementById("img" + strType + ID).outerHTML
}

//Unhides a menu level (including all its sublevels). It Unhide the SPAN ([ParentID]_Childs) containing the submenus and changes the
//Image and onclick events on the Expand/Expand_Off button so it can hide the span again when clicked.
function unhideSpan(Type, ID)
{
	var strType
	if(Type == 1) {
		strType = "List_"
	}
	else if(Type == 2){
		strType = "Letters_"
	}
	else {
		strType = "Filter_"
	}

	document.getElementById(strType + ID).style.display= ''
	document.getElementById("img" + strType + ID).setAttribute("src", "/Admin/images/Expand_off.gif")
	document.getElementById("img" + strType + ID).setAttribute("onclick", "hideSpan(" + Type + ", " + ID + ");")
	document.getElementById("img" + strType + ID).outerHTML = document.getElementById("img" + strType + ID).outerHTML
}

function Link(ID, Type) 
{
//alert(ID + ":-:" + Type)
var Page
var strRecipientID
var strTab
strTab = ""
strRecipientID = ""
Page = "NewsletterExtended_Blank.html"
if(Type == 3)
	Page = "NewsletterExtended_Archive.aspx"
else if(Type == 2)
	Page = "NewsletterExtended_Recipient.aspx"
else if(Type == 1)
	Page = "NewsletterExtended_Draft.aspx"
else if(Type == 4){
	Page = "NewsletterExtended_Letter_body.aspx"
	strTab = "&Tab=Tab1"
}
else if(Type == 5) {
	if(confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("nyhedsbrev"))%>")) {
		Page = "NewsletterExtended_letter_del.aspx"
		parent.document.getElementById('ListRight').setAttribute("src", Page + "?ID=" + ID);
		return false;
		}
	}
else if(Type == 6) {
	Page = "NewsletterExtended_letter_body.aspx"
	strTab = "&Tab=Tab1"
	}
else if(Type == 7) {
	Page = "NewsletterExtended_letter_body_Send.aspx"
	strTab = "&Tab=Tab1"
	}
else if(Type == 8)
	Page = "NewsletterExtended_category_edit.aspx"
else if(Type == 9) {
	if(confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("liste"))%>"))
		Page = "NewsletterExtended_category_del.aspx"
	}
else if(Type == 10) {
	Page = "NewsletterExtended_Recipient_Edit.aspx"
	strRecipientID = "&CategoryID=" + ID
	}
else if(Type == 11) {
	window.open("NewsletterExtended_ArchiveTreeview.aspx", "Mail_archive", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
	}
else if(Type == 12){
	Page = "NewsletterExtended_Letter_Edit.aspx"
	strTab = "&Tab=Tab1"
}
else if(Type == 13){
	Page = "NewsletterExtended_UserFilter_Edit.aspx"
	strTab = "&Tab=Tab1"
}
else if(Type == 14){
	Page = "NewsletterExtended_Recipient.aspx"
	ID += "&InActive=true"
}

parent.document.getElementById('ListRight').setAttribute("src", Page + "?ID=" + ID + strRecipientID + strTab);
hideMenu();
}


function hl(menuObject, ID)																
{ 
	if(ID)
	{
		menuObject.style.textDecoration = "underline";
		self.status = "ID: " + ID;
	}
	else
	{
		menuObject.style.textDecoration = "";
		self.status = "";
	}
}

//a variable holding the current clicked object
menuObject = ""

//the function is called when right-clicking a menuitem. calls the function that shows the contexts-menu
hide = true;

//Set the hide variable to false so the context-menu doesn't get hidden.
function doNotHide()
{
	hide = false;
}

//Set a timeout that calls a function that hide the context-menu.
//This is done so the context-menu doesn't get hidden right a way.
function hideMenu()
{
	hide = true;
	setTimeout("doTheHide()", 2000);
}

//Function that does the actual hiding of the context-menu.
function doTheHide()
{
	if(hide)
	{
		document.getElementById('Rmenu').style.display = 'none';
		if(menuObject.style)
			menuObject.style.fontWeight = "";
		hide = false;
	}
}

document.oncontextmenu= function(){return false}
var my=0;
var mx=0;
function rightClick(ev, TypeID, EntityID, co, rightClicked)
{
	var evt = (window.event)? window.event:ev;
	if (!window.event){
		mx = evt.pageX;
		my = evt.pageY;
	}
	if(menuObject)
		menuObject.style.fontWeight = "";
	menuObject = co; 
	showMenu(TypeID, EntityID);
	evt.returnValue=false;
	return false;
}

//function that hides the context-menu and removes the "bold"-style on the menuitem.
function hideNow(){
	document.getElementById('Rmenu').style.display = 'none';
	if(menuObject.style)
		menuObject.style.fontWeight = "";
}

function nothing()
{
}

function showMenu(ID, EntityID, menuobject, documentObj, Ey, Ex){
		var objJsdoc = new Object(); 
		var MenuHTML


		objJsdoc = "top.left.";
		MenuHTML = "<span class=altMenuLeftPane></span>";
		MenuHTML += '<table cellpadding=0 cellspacing=0 border=0 style="width:100%">';
		if(ID==4)
			{
			MenuHTML += '<tr><td nowrap onClick="Link(' + EntityID + ', ' + 12 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_LetterDraft_edit_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Rediger %%","%%",Translate.JsTranslate("stamdata"))%></td></tr>';
			MenuHTML += '<tr><td nowrap onClick="Link(' + EntityID + ', ' + 6 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_LetterDraft_edit_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Rediger body")%></td></tr>';
			MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
			MenuHTML += '<tr><td onClick="Link(' + EntityID + ', ' + 7 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_NewsletterExtended_Send_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Send brev")%></td></tr>';
			MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
			MenuHTML += '<tr><td nowrap onClick="Link(' + EntityID + ', ' + 5 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_Delete.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Slet %%", "%%", Translate.JSTranslate("nyhedsbrev"))%></td></tr>';
			}
		else if(ID==1)
			{
			MenuHTML += '<tr><td onClick="Link(' + EntityID + ', ' + 8 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_Edit_Lists_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Ret liste")%></td></tr>';
			MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
			MenuHTML += '<tr><td onClick="Link(' + EntityID + ', ' + 10 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_User_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Ny modtager")%></td></tr>';
			MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
			MenuHTML += '<tr><td onClick="Link(' + EntityID + ', ' + 9 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_Delete.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Slet %%", "%%", Translate.JSTranslate("liste"))%></td></tr>';
			}
		else if(ID==2)
			{
			MenuHTML += '<tr><td onClick="Link(0, ' + 8 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_Lists_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Ny liste")%></td></tr>';
			}
		else if(ID==3)
		{
		MenuHTML += '<tr><td onClick="Link(0, ' + 8 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_Edit_Lists_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Nyt filter")%></td></tr>';
		}
		else if(ID==11)
			{
			MenuHTML += '<tr><td onClick="Link(' + EntityID + ', ' + 10 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_User_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Ny modtager")%></td></tr>';
			}
		else if(ID==12)
			{
			MenuHTML += '<tr><td onClick="Link(' + EntityID + ', ' + 12 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_Letter_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Nyt brev")%></td></tr>';
			MenuHTML += '<tr><td onClick="Link(' + EntityID + ', ' + 11 +');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Module_Newsletter_Letter_Small.gif" align=absmiddle class=altMenuImg><%=Translate.JsTranslate("Nyt brev fra arkiv")%></td></tr>';
			}

		MenuHTML += '</table>';
		if(!menuobject){
			menuobject = document.getElementById('Rmenu');
		}
		if(!documentObj){
			documentObj = document;
		}
		menuobject.innerHTML = MenuHTML;
		menuobject.style.display = "";
		menuobject.style.display = "none";

		if(!Ey){ //Called from leftmenu
                       	if (!window.event){
				Ey = my;
				Ex = mx
			}else{
			Ey = event.clientY;
			Ex = event.clientX;
				divX = document.getElementById('Rmenu').clientHeight
			if((window.screenTop + document.body.clientHeight) < (window.screenTop + event.clientY + 100))
			{
			Ey = Ey - divX	
			}
				Ey = Ey + documentObj.body.scrollTop;
			}
			menuobject.style.top=Ey;
			if (Ex+160<195){
				menuobject.style.left=Ex + 0;
			}
			else{
				menuobject.style.left=195-160;
			}
		}
		menuobject.style.display = "";
		//setTimeout("hideMenu()",2000)
	}

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
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<HEAD>
</HEAD>

<BODY style="background-color:#ffffff;">

<div id="MySpan" nowrap height="100%">
	<div id="List">
	<img src="../../images/nothing.gif" width="9" height="13">
	<img class="H" oncontextmenu='return false;' id="imgList_0" onclick="unhideSpan(1,0);" src="../../images/Expand.gif" width="9" height="13">
	<img class='H' oncontextmenu='rightClick(event, 2, "", this);' onclick="unhideSpan(1,0); MakeBold(document.getElementById('TEXT_List_0')); parent.document.getElementById('ListRight').setAttribute('src', 'NewsletterExtended_ListList.aspx');" align="absMiddle" src='../../images/icons/Module_Newsletter_Lists_Small.gif'>
	<a class='H' ID="TEXT_List_0" onmouseout='hl_off(this);' onmouseover='hl(this);' oncontextmenu='rightClick(event, 2, "", this);' onclick="unhideSpan(1,0);MakeBold(this); parent.document.getElementById('ListRight').setAttribute('src', 'NewsletterExtended_ListList.aspx');"><%=Translate.Translate("Lister")%></a>
		<div style='display:none' id="List_0">
			<%
			sql = "SELECT * FROM NewsletterExtendedCategory ORDER BY NewsletterCategoryName"
			cmdNewsletterExt.CommandText = sql

			Dim drCategoryReader As IDataReader = cmdNewsletterExt.ExecuteReader()

			Do While drCategoryReader.Read
				strNewsletterCategoryID = drCategoryReader("NewsletterCategoryID")
				strNewsletterCategoryName = drCategoryReader("NewsletterCategoryName")
			        Response.Write("<div nowrap>" & vbNewLine & "<img src='../../images/nothing.gif' width='23' height='13'>" & vbNewLine & _
			        "<img oncontextmenu='return false;' class='H' id='imgList_" & strNewsletterCategoryID & _
			        "' onclick='unhideSpan(1," & strNewsletterCategoryID & ");' src='../../images/Expand.gif' width='9' height='13'> " & _
			        vbNewLine & "<img class='H' oncontextmenu='rightClick(event, 1, """ & strNewsletterCategoryID & _
			        """, this);' align='absMiddle' onclick='MakeBold(document.getElementById(""TEXT_ListCat_" & strNewsletterCategoryID & _
			        """));unhideSpan(1," & strNewsletterCategoryID & ");' src='../../images/icons/Module_Newsletter_Lists_Small.gif'>" & _
			        vbNewLine & "<a class='H' onmouseout='hl_off(this);' onmouseover='hl(this);' ID='TEXT_ListCat_" & strNewsletterCategoryID & _
			        "' oncontextmenu='rightClick(event, 1, """ & strNewsletterCategoryID & """, this);' onclick='MakeBold(this);unhideSpan(1," & _
			        strNewsletterCategoryID & "); parent.document.getElementById(""ListRight"").setAttribute(""src"", ""NewsletterExtended_ListList.aspx?ID=" & _
			        strNewsletterCategoryID & """);'>" & strNewsletterCategoryName & "</a>" & vbNewLine & "<div nowrap style='display:none' id='List_" & _
			        strNewsletterCategoryID & "'>" & vbNewLine & "<div nowrap id='List_" & strNewsletterCategoryID & "_Receiver'>" & vbNewLine & _
			       "<img src='../../images/nothing.gif' width='38' height='13'>" & vbNewLine & _
			       "<img class='H' oncontextmenu='return false;' onclick='Link(" & strNewsletterCategoryID & _
			       ", 2);' src='../../images/Expand_dot.gif' width='9' height='13'> " & vbNewLine & _
			       "<img class='H' oncontextmenu='rightClick(event, 11, """ & strNewsletterCategoryID & _
			       """, this);' onclick='MakeBold(document.getElementById(""TEXT_ListUser_" & strNewsletterCategoryID & _
			       """));Link(" & strNewsletterCategoryID & ", 2);' align='absMiddle' src='../../images/icons/Module_Newsletter_User_Small.gif'>" & _
			       vbNewLine & "<a class='H' onmouseout='hl_off(this);' onmouseover='hl(this);' ID='TEXT_ListUser_" & strNewsletterCategoryID & _
			       "' oncontextmenu='rightClick(event, 11, """ & strNewsletterCategoryID & """, this);' onclick='MakeBold(this); Link(" & _
			       strNewsletterCategoryID & ", 2);'>" & Translate.Translate("Modtagere") & vbNewLine & "</a>" & "</div>" & _
			       "<div nowrap style='display:' id='List2_" & _
			        strNewsletterCategoryID & "'>" & vbNewLine & "<div nowrap id='List_" & strNewsletterCategoryID & "_Receiver'>" & vbNewLine & _
			       "<img src='../../images/nothing.gif' width='38' height='13'>" & vbNewLine & _
			       "<img class='H' oncontextmenu='return false;' onclick='Link(" & strNewsletterCategoryID & _
			       ", 14);' src='../../images/Expand_dot.gif' width='9' height='13'> " & vbNewLine & _
			       "<img class='H' oncontextmenu='rightClick(event, 11, """ & strNewsletterCategoryID & _
			       """, this);' onclick='MakeBold(document.getElementById(""TEXT_ListUser_" & strNewsletterCategoryID & _
			       """));Link(" & strNewsletterCategoryID & ", 14);' align='absMiddle' src='../../images/icons/Module_Newsletter_User_Small.gif'>" & _
			       vbNewLine & "<a class='H' onmouseout='hl_off(this);' onmouseover='hl(this);' ID='TEXT_ListUser_" & strNewsletterCategoryID & _
			       "' oncontextmenu='rightClick(event, 11, """ & strNewsletterCategoryID & """, this);' onclick='MakeBold(this); Link(" & _
			       strNewsletterCategoryID & ", 14);'>" & Translate.Translate("Inaktive Modtagere") & vbNewLine & "</a>" & "</div>" & _
			       "<div nowrap id='List_" & _
			       strNewsletterCategoryID & "'_Archive>" & vbNewLine & "<img src='../../images/nothing.gif' width='38' height='13'>" & vbNewLine & _
			       "<img class='H' oncontextmenu='return false;' onclick='Link(" & strNewsletterCategoryID & _
			       ", 3);' src='../../images/Expand_dot.gif' width='9' height='13'> " & vbNewLine & _
			       "<img class='H' oncontextmenu='return false;' onclick='MakeBold(document.getElementById(""TEXT_ListMail_" & _
			       strNewsletterCategoryID & """));Link(" & strNewsletterCategoryID & _
			       ", 3);'align='absMiddle' src='../../images/icons/Module_Newsletter_Archive_Small.gif'>" & vbNewLine & _
			       "<a class='H' onmouseout='hl_off(this);' onmouseover='hl(this);' ID='TEXT_ListMail_" & strNewsletterCategoryID & _
			       "' oncontextmenu='return false;' onclick='MakeBold(this); Link(" & strNewsletterCategoryID & ", 3);'>" & varArchive & _
			                vbNewLine & "</a>" & "</div>" & "</div>" & "</div>")
			Loop 

			drCategoryReader.Dispose
			%>
		</div>
	</div>

		</div>
	</div>
	<div nowrap id="Letters">
	<img src="../../images/nothing.gif" width="9" height="13">
	<img class="H" oncontextmenu='return false;' id="imgLetters_0" onclick="unhideSpan(2,0);" src="../../images/Expand.gif" width="9" height="13">
	<img class='H' oncontextmenu='rightClick(event, 12, "0", this);' onclick="MakeBold(document.getElementById('TEXT_Letter_0')); unhideSpan(2,0);" align='absMiddle' src='../../images/icons/Module_Newsletter_Letter_Small.gif'>
	<A CLASS='H' ID="TEXT_Letter_0" oncontextmenu='rightClick(event, 12, "0", this);' onmouseout='hl_off(this);' onmouseover='hl(this);' onclick='MakeBold(this); unhideSpan(2,0); parent.document.getElementById("ListRight").setAttribute("src", "NewsletterExtended_ListLetters.aspx");'><%=Translate.Translate("Nyhedsbreve")%></A>
		<div nowrap style='display:none' id="Letters_0">
			<%
			Sql = "SELECT * FROM NewsletterExtended WHERE NewsletterLevel IN (1,2) ORDER BY NewsletterName"
			cmdNewsletterExt.CommandText = sql

			Dim drNewsletterReader As IDataReader = cmdNewsletterExt.ExecuteReader()
			
			Do While drNewsletterReader.Read
				strNewsletterID = drNewsletterReader("NewsletterID")
				strNewsletterName = drNewsletterReader("NewsletterName")
			        Response.Write("<div nowrap>" & vbNewLine & "<img src='../../images/nothing.gif' width='23' height='13'>" & vbNewLine & _
			        "<img oncontextmenu='return false;' id='imgLetters_" & strNewsletterID & _
			       "' src='../../images/Expand_dot.gif' width='9' height='13'> " & vbNewLine & _
			       "<img class='H' onclick='MakeBold(document.getElementById(""TEXT_Letter_" & strNewsletterID & _
			       """));Link(" & strNewsletterID & ", 4);' oncontextmenu='rightClick(event, 4, """ & strNewsletterID & _
			       """, this);' align='absMiddle' src='../../images/icons/Module_Newsletter_LetterDraft_Small.gif'>" & vbNewLine & _
			       "<a class='H' ID='TEXT_Letter_" & strNewsletterID & "' oncontextmenu='rightClick(event, 4, """ & strNewsletterID & _
			       """, this);' onmouseout='hl_off(this);' onmouseover='hl(this);' onclick='MakeBold(this);Link(" & strNewsletterID & _
			       ", 4);'>" & strNewsletterName & "</a>" & vbNewLine & "<div nowrap style='display:none' id='Letters_" & strNewsletterID & "'>" & _
          vbNewLine & "</div>" & "</div>")
			Loop 

			drNewsletterReader.Dispose
			%>
		</div>
	</div>
<%If NLShowAllUsersCategory <> "" Then%>
	<div nowrap id="AllUsers">
	<img src="../../images/nothing.gif" width="9" height="13">
	<img src="../../images/nothing.gif" width="9" height="13">
	<img class='H' onclick="MakeBold(document.getElementById('TEXT_AllUsers_0'));" align='absMiddle' src='../../images/icons/Module_Newsletter_User_Small.gif'>
	<A CLASS='H' ID="TEXT_AllUsers_0" onmouseout='hl_off(this);' onmouseover='hl(this);' onclick='MakeBold(this); parent.document.getElementById("ListRight").setAttribute("src", "NewsletterExtended_Recipient.aspx?AllCategoryField=1");'><%=Translate.Translate("Alle brugere")%></A>
	</div>
<%End If%>	
</div>

<!--
	<div id="Filter">
	<img src="../../images/nothing.gif" width="9" height="13">
	<img class="H" oncontextmenu='return false;' id="imgFilter_0" onclick="unhideSpan(3,0);" src="../../images/Expand.gif" width="9" height="13">
	<img class='H' oncontextmenu='rightClick(event, 2, "", this);' onclick="unhideSpan(3,0); MakeBold(document.getElementById('Filter_List_0')); parent.document.getElementById('ListRight').setAttribute('src', 'NewsletterExtended_ListList.aspx');" align="absMiddle" src='../../images/icons/Module_Sitemap_small.gif'>
	<a class='H' ID="Filter_List_0" onmouseout='hl_off(this);' onmouseover='hl(this);' oncontextmenu='rightClick(event, 3, "", this);' onclick="unhideSpan(3,0);MakeBold(this); parent.document.getElementById('ListRight').setAttribute('src', 'NewsletterExtended_ListFilters.aspx');"><%=Translate.Translate("Filter")%></a>
		<div style='display:none' id="Filter_0">
			<%
			
			%>
		</div>
	</div>
-->

<div nowrap id="AllUsers">
	<img src="../../images/nothing.gif" width="9" height="13">
	<img src="../../images/nothing.gif" width="9" height="13">
	<img class='H' onclick="MakeBold(document.getElementById('TEXT_AllUsers_0'));" align='absMiddle' src='../../images/icons/Module_Newsletter_User_Small.gif'>
	<A CLASS='H' ID="TEXT_AllUsers_0" onmouseout='hl_off(this);' onmouseover='hl(this);' onclick='MakeBold(this); parent.document.getElementById("ListRight").setAttribute("src", "NewsletterExtended_Recipient.aspx?AllCategoryField=1");'><%=Translate.Translate("Alle Modtagere")%></A>
	</div>
	
</td>
</tr>
</table>
<div id="Rmenu" class="altMenu" style="display:none;"></div>

</BODY>

</HTML>
<SCRIPT LANGUAGE="JavaScript">
<!--
if("<%=Request.Item("OpenWhat")%>" == "List")
	unhideSpan(1, 0)
else if("<%=Request.Item("OpenWhat")%>" == "Letters")
	unhideSpan(2, 0)

//-->
</SCRIPT>
<%
cmdNewsletterExt.Dispose()
NewsletterExtConn.Dispose()
Translate.GetEditOnlineScript()
%>