<SCRIPT LANGUAGE="JAVASCRIPT">
var intPrevID
//get fired on body.onLoad and loads the menu
function MenuStart()
{
	var MenuEntry
	MenuEntry = getMenu(MenuEntry);
	document.getElementById('mySpan').innerHTML =MenuEntry;
}


//updates the menu-entry (the hole current level) to the correct view after creating or editing a page
function UpdateMenuEntry(PageParentPageID)
{	
toggle(PageParentPageID, 3);
}

//reset the menu and folds it out to the correct (Page and Area) view in connection with a move or copy of a page og paragraph. 
//It gets called from the pages that copies or moves paragraphs og pages and from MenuData.asp
var CopyMoveInProcess;

function MoveMenuEntry(PageParentPageID)
{
	document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?ParentPageID=" + PageParentPageID.toString() + "&update=1&MoveID=" + PageParentPageID.toString());
}

//A public Array holding information on the submenu path (The PageID's from the top-level down to the selected page)
var newArray = new Array();
//A varialble holding the position in "newArray"
var position;

//function called when a move or copy has occurred. The caller is MenuData.asp
//It receives an array holding information on the menu-path from the top-level down to the selected page.
//It also starts the sequence of events that gathers each menu-level.
function EndMoveMenuEntry()
{
	var MenuData = document.getElementById("MenuData").contentWindow;
	newArray = MenuData.MenuJSArray;
	document.getElementById('mySpan').innerHTML = "";
	position=newArray[0].length-1;
	document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?ParentPageID=" + newArray[1][position].toString() + "&update=3");

}

//function that mostly gets called when a menu + is clicked. It calls the IFRAME with specific parameters, so the MenuData returns
//an array containing a menu-sublevel
function toggle(PageParentPageID, update) {
	CopyMoveInProcess = 0
	document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?Action=<%=Request.Item("Action")%>&ParentPageID=" + PageParentPageID.toString() + "&update=" + update.toString());
}

//function that gets called by the returning MenuData.asp file when a menu + is clicked.
//Then function gets menu a menu-entry and adds it in the right position in the menu.
//If is a rebuild of the menu (in case of a move or copy action) it also calls the MenuData.asp with data on the next level.
function endToggle(PageParentPageID, update)
{
	if (PageParentPageID > 0)
	{
		var MenuEntry
		MenuEntry = getMenu(MenuEntry, PageParentPageID);

		if(update == 1 || update == 3)
			document.getElementById(PageParentPageID.toString() + '_Childs').innerHTML =MenuEntry;		
		else
			document.getElementById(PageParentPageID.toString() + '_Childs').innerHTML +=MenuEntry;
	}
	else
	{
		var MenuEntry
		MenuEntry = getMenu(MenuEntry, PageParentPageID);
		if(update == 3)
			document.getElementById('mySpan').innerHTML =MenuEntry;
	}
	if(newArray && position > 0)
		{
			position=position - 1;
			document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?ParentPageID=" + newArray[1][position].toString() + "&update=");
		}




	//Make Bold/Unbold depending on CopyMoveInProcess
	if(CopyMoveInProcess == 1)
	{
		var newParentID;
		newParentID = newArray[0][1].toString();   //ID of the new parent created - copy/move
		intPrevID = newParentID    //Make new item the previous item - to do unbold 
		
		if(newParentID) {
			if(document.getElementById(newParentID)) {
				document.getElementById(newParentID).style.fontWeight="bold";
			}
		}
	}


	if(CopyMoveInProcess == 0)
	{
		//Make sure previous selected item remains bold if not copying or moving item
		if(intPrevID) {
			if(document.getElementById(intPrevID)) {
				document.getElementById(intPrevID).style.fontWeight="bold";
			}
		}
	}


}

//Hides a menu level (including all its sublevels). It hide the SPAN ([ParentID]_Childs) containing the submenus and changes the
//Image and onclick events on the Expand/Expand_Off button so it can Unhide the span again when clicked.
function hideSpan(PageParentPageID)
{
	if(PageParentPageID > 0)
	{
		document.getElementById(PageParentPageID + "_Childs").style.display= 'none'
		document.getElementById("toggle_" + PageParentPageID).setAttribute("src", "/Admin/images/Expand.gif")
		document.getElementById("toggle_" + PageParentPageID).setAttribute("onclick", "unhideSpan(" + PageParentPageID + ");")
		document.getElementById("toggle_" + PageParentPageID).outerHTML = document.getElementById("toggle_" + PageParentPageID).outerHTML
	}
}

//Unhides a menu level (including all its sublevels). It Unhide the SPAN ([ParentID]_Childs) containing the submenus and changes the
//Image and onclick events on the Expand/Expand_Off button so it can hide the span again when clicked.
function unhideSpan(PageParentPageID)
{
	if(PageParentPageID > 0)
	{
		document.getElementById(PageParentPageID + "_Childs").style.display= ''
		document.getElementById("toggle_" + PageParentPageID).setAttribute("src", "/Admin/images/Expand_off.gif")
		document.getElementById("toggle_" + PageParentPageID).setAttribute("onclick", "hideSpan(" + PageParentPageID + ");")
		document.getElementById("toggle_" + PageParentPageID).outerHTML = document.getElementById("toggle_" + PageParentPageID).outerHTML
	}
}

//this function returns the correct Icon for the different pages in the menu
function setupPageIcon(objPage, i)
{
	var MenuData = document.getElementById("MenuData").contentWindow;
	if(Date.parse(MenuData.MenuJSArray[4][i]) < Date.parse("01/01/2999 00:01:00 PM"))	// 4 = PageActiveTo - test= alert(Date.parse(MenuData.MenuJSArray[4][i]) + " > " + Date.parse("01/01/2999 00:01:00 PM"));
		objPage.PageImg = "Page_publice";
	if(MenuData.MenuJSArray[5][i].length > 0)	// Len(PagePermission) > 0 Then
		objPage.PageImg = "Page_pass";
	if (MenuData.MenuJSArray[6][i]!="1") {												// 6 = PageActive
		objPage.style = " style='color:#BB7F7F;'";
		objPage.styleImg = " STYLE='filter:progid:DXImageTransform.Microsoft.Alpha(opacity=70)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);'";
	}
}

//Underline name of folder when mouse is over and clear when mouseout
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

document.oncontextmenu= function(){return false}
var my=0;
var mx=0;
var mevent
//the function is called when right-clicking a menuitem. calls the function that shows the contexts-menu
function rightClick(ev,PageID, co)
{
	if (!window.event){
		mx = ev.pageX;
		my = ev.pageY;
		mevent = ev;
	}else{
		mevent = window.event
	}

	if(menuObject)
		menuObject.style.fontWeight = "";
	menuObject = co; 
	MakeBold(co);
	showMenu(PageID);
	mevent.returnValue=false;
	return false;
}

//function that hides the context-menu and removes the "bold"-style on the menuitem.
function hideNow(){
	document.getElementById("Rmenu").style.display = 'none';
}

//function that builds the context-menu and shows it at the right position.
function showMenu(ID, menuobject, documentObj, Ey, Ex){
		var objJsdoc = new Object(); 
		var MenuHTML

		MenuHTML = "<span class=altMenuLeftPane></span>";
		MenuHTML += '<table cellpadding=0 cellspacing=0 border=0 style="width:100%">';
		MenuHTML += '<tr><td onClick="newsubpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Page_open.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ny gruppe")%></td></tr>';
		MenuHTML += '<tr><td onClick="newProduct('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Paragraph.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ny vare")%></td></tr>';
		MenuHTML += '<tr><td onClick="editpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Page_edit.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ret gruppe")%></td></tr>';
		MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
		MenuHTML += '<tr><td onClick="movepage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Page_Move.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Flyt gruppe")%></td></tr>';
		MenuHTML += '<tr><td onClick="copypage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Page_Copy.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Kopier gruppe")%></td></tr>';
		MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
		MenuHTML += '<tr><td onClick="deleteProduct('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Page_Delete.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Slet %%", "%%", Translate.Translate("gruppe"))%></td></tr>';

		MenuHTML += '</table>';
		if (!menuobject) {
			menuobject = document.all.Rmenu;
		}
		if (!documentObj) {
			documentObj = document;
		}
		menuobject.innerHTML = MenuHTML;
		
		if (!Ey) { //Called from leftmenu
	               	if (!window.event){
				Ey = my;
				Ex = mx
			}else{
				Ey = event.clientY+ documentObj.body.scrollTop;
			Ex = event.clientX;
			}
			menuobject.style.top=Ey;
			if (Ex+160<195){
				menuobject.style.left=Ex;
			} else {
				menuobject.style.left=195-160;
			}
		}
		else{ //Called from paragraph_list.asp
			menuobject.style.top=Ey;
			menuobject.style.left=Ex-50;
		}

		menuobject.style.display = "";
	}

//A variable holding the information whether the context-menu is hidden or not.
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
		document.getElementById("Rmenu").style.display = 'none';
		hide = false;
	}
}

//The menu Navigation. Opens the clicked page in the right frame.
function n(PageID)
{ 
	window.ShopRight.location = "Product_List.aspx?ID="+PageID;
}


//Closes the menu (or rather hides it) to save space
function closeMenu()
{
	top.MainFrame.cols='20,*';
	document.getElementById('MenuTable').style.display='none';
	document.getElementById('MenuOpen').style.display='';
}

//opens the menu (or rather unhides it)
function openMenu()
{
	document.getElementById('TreeView').style.display='';
	document.getElementById('TreeEnd').style.display='';
	document.getElementById('MenuOpen').style.display='none';
}

//dunno?
function setContentCell()
{
	TreeStartHeight = 0;
	if(document.getElementById('TreeStart')){
		TreeStartHeight = document.getElementById('TreeStart').offsetHeight;
	}
	
	TreeEndHeight = 0;
	if(document.getElementById('TreeEnd')){
		TreeEndHeight = document.getElementById('TreeEnd').offsetHeight;
	}
	
	if(document.all.ContentCell){
		height = document.body.clientHeight;
		document.getElementById('ContentCell').style.height = height - TreeEndHeight - TreeStartHeight-1;
			document.getElementById('SearchBox').style.height = height; // - TreeEndHeight - TreeStartHeight-1;
	}
}




//Calls page_edit.asp to create at page on the top-menu-level
function NewPage()
{
	parent.right.location="Page_Edit.aspx?AreaID=" + AreaID;
}


//called from the Context-menu. pops up a new menu to select the location where to move the selected page.
function movepage(ID)
{
	CopyMoveInProcess = 1
	
	movepageWindow = window.open("menu.aspx?MoveID=" + ID + "&Action=Move", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
	hideNow();
}

//Calls the Page_move.asp which actually moves the page.
//Is called from the move->Menu-popup
function movePageTo(ID)
{
	location = "Group_move.aspx?ID=" + ID + "&MoveID=<%=MoveID%>";
}

//called from the Context-menu. pops up a new menu to select the location where to copy the selected page.
function copypage(ID)
{
	CopyMoveInProcess = 1
	
	CopypageWindow = window.open("menu.aspx?CopyID=" + ID + "&Action=Copy", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
	hideNow();
}

//Calls the Page_copy.asp which actually copies the page.
//Is called from the Copy->Menu-popup
function copyPageTo(ID)
{
	location = "Group_Copy.aspx?ID=" + ID + "&CopyID=<%=CopyID%>";
}

function moveProductTo(ID){
	location = "Product_move.aspx?ID=" + ID + "&MoveID=<%=MoveID%>";
}

function copyProductTo(ID){
	location = "Product_Copy.aspx?ID=" + ID + "&CopyID=<%=CopyID%>";
}

function newProduct(ID)
{
	window.ShopRight.location = "Product_Edit.aspx?ShopProductGroupID="+ID;
	hideNow();
}


//called from the Context-menu. opens the Page_edit in the right frame to edit the select page.

function editpage(ID){
	window.ShopRight.location = "Group_Edit.aspx?ID=" + ID;
	hideNow();
}


//called from the Context-menu. Opens the Page_Edit.asp page in the right frame to add a new Page as a sub-page to the selected page.
function newsubpage(ID){
	window.ShopRight.location = "Group_Edit.aspx?uID="+ID;
	hideNow();
}

//popup a Confirm box. On "Yes" it deletes the page and all subpages via the Page_delete.asp file.
//The function gets called from the Context-menu

function deleteProduct(ID)
{
	if(document.getElementById("text_"+ID)){
		PageName = document.getElementById("text_"+ID).innerHTML;
		var tr = /<[^>]+>/ig;
		PageName = PageName.replace(tr, "");
	}
	
	hideNow();
	
	if(confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("gruppe"))%>\n(" + PageName + ")\n\n<%=Translate.Translate("Alle undergrupper vil blive slettet!")%>"))
		window.ShopRight.location = "Group_Delete.aspx?ID=" + ID;
}


//called from the Context-menu. Opens the Menu_sort.asp page in the right frame to enable the user to sort the select menu-level 
//(in which the current select page exists).
function SortPages(ParentPageID)
{ 
	if(intPrevID) {
		if(document.getElementById(intPrevID)) {
			document.getElementById(intPrevID).style.fontWeight="";
		}
	}

	document.getElementById("Sort_"+ParentPageID).style.fontWeight = "bold";
	intPrevID = document.getElementById("Sort_"+ParentPageID).id  // make "sorter" the previd for later unbold

	window.ShopRight.location = "Menu_Sort.aspx?ShopGroupParentID="+ParentPageID;
}



function MakeBold(objText) {
	if(intPrevID) {
		if(document.getElementById(intPrevID)) {
			document.getElementById(intPrevID).style.fontWeight="";
		}
	}
	objText.style.fontWeight="bold";
	intPrevID = objText.id
}

//Generate the actual menu-entry/menu-level
function getMenu(MenuEntry, PageParentPageID, move)
{
	var ImgWidth = 0;
	var objPage = new Object();
	var imgWidth = 0;
	var varSortAccess = true;
	
	MenuEntry = "";

	CopyMoveAllowed = true

	var MenuData = document.getElementById("MenuData").contentWindow;

	if(document.getElementById(PageParentPageID)) {
		strCurrentName = document.getElementById(PageParentPageID).Name + ", "
		if('<%=Request.Item("Action")%>' == 'MoveParagraph' && "<%= Base.ChkNumber(Request.QueryString.GetValues("MoveFromPageID"))%>" == PageParentPageID) {
			CopyMoveAllowed = false
		} else {
			strMoveName = ", " + "<%=Base.ChkNumber(CopyID) + Base.ChkNumber(MoveID)%>" + ", "
			if( strCurrentName.search(strMoveName) > -1 ) {
				CopyMoveAllowed = false
			}
		}
	}

	for (i=0; i < MenuData.MenuJSArray[0].length- 1; i++) { 
		MenuEntry +="<div nowrap class='myMenu' ID='" + MenuData.MenuJSArray[0][i] + "'"
		if(document.getElementById(PageParentPageID)) {
			MenuEntry += ' Name="' + document.getElementById(PageParentPageID).Name + ', ' + MenuData.MenuJSArray[0][i] + '" '
		} else {
			MenuEntry += ' Name=", ' + MenuData.MenuJSArray[0][i] + '" '
		}
		MenuEntry += ">";
		if (PageParentPageID > 0) {
			var objSpaceImg 
			objSpaceImg = document.getElementById("spaceIMG_" + PageParentPageID)
			if(objSpaceImg) {
				imgWidth = objSpaceImg.getAttribute("width") + 15;
			} else {
				imgWidth = 0
			}
			document.getElementById("toggle_" + PageParentPageID).setAttribute("src", "/Admin/images/Expand_off.gif")
			document.getElementById("toggle_" + PageParentPageID).setAttribute("onclick", "hideSpan(" + PageParentPageID + ");")
			document.getElementById("toggle_" + PageParentPageID).setAttribute("class", "H")
			document.getElementById("toggle_" + PageParentPageID).outerHTML = document.getElementById("toggle_" + PageParentPageID).outerHTML
			strHtml = document.getElementById("text_" + PageParentPageID).outerHTML
			if("<%=Action%>" == "")	{
				if(strHtml.search('oncontextmenu="rightClick') > -1) {
					document.getElementById("text_" + PageParentPageID).setAttribute("onclick", "n(" + PageParentPageID + ");MakeBold(this);");
				}
			}
			else if("<%=Action%>" != "AddPageUserManagement" && "<%=Action%>" != "Internal") {
				document.getElementById("text_" + PageParentPageID).setAttribute("onclick", "");
			}
			document.getElementById("text_" + PageParentPageID).outerHTML = document.getElementById("text_" + PageParentPageID).outerHTML;
		}
		MenuEntry +="<img src='/Admin/images/nothing.gif' ID='spaceIMG_" + MenuData.MenuJSArray[0][i] + "' width='" + imgWidth + "' height='13'> ";
		if (MenuData.MenuJSArray[2][i] > 0 || ("<%=Action%>" == "Move" && CopyMoveAllowed) || "<%=Action%>" == "Copy" || "<%=Action%>" == "MoveProduct" || "<%=Action%>" == "CopyProduct") {
			MenuEntry +="<img class='H' onclick='toggle(" + MenuData.MenuJSArray[0][i] + ",0);' src='/Admin/images/Expand.gif' ID='toggle_" + MenuData.MenuJSArray[0][i] + "' width='9' height='13'> ";
		}
		else {
			MenuEntry +="<img ID='toggle_" + MenuData.MenuJSArray[0][i] + "'src='/Admin/images/nothing.gif' name='img_1' width='9' height='13'> ";
		}
		
		//'*** Find Icon and style ****
		objPage.PageImg		= "Page_closed";
		objPage.style		= "";
		objPage.styleImg	= "";
		setupPageIcon(objPage, i);
		//'*** End Icon and style ***
		
		if ("<%=Action%>" != "") {
			MenuEntry +="<span ID='text_" + MenuData.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + MenuData.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='toggle(" + MenuData.MenuJSArray[0][i] + ",0);MakeBold(this);'>"  + "<img " + objPage.styleImg + " src='/Admin/images/icons/" + objPage.PageImg + ".gif' align='absMiddle' name='fol_1'>";
			MenuEntry +=MenuData.MenuJSArray[3][i] + "</span>";
		}
		else {
			MenuEntry +="<span ID='text_" + MenuData.MenuJSArray[0][i] + "' class='H' oncontextmenu='rightClick(event," + MenuData.MenuJSArray[0][i] + ", this);this.style.fontWeight=" + '"bold"' + ";' onmouseout='hl(this);' onmouseover='hl(this, " + MenuData.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='toggle(" + MenuData.MenuJSArray[0][i] + ",0);MakeBold(this);n(" + MenuData.MenuJSArray[0][i] + ");'>"  + "<img oncontextmenu='rightClick(event," + MenuData.MenuJSArray[0][i] + ", this);' " + objPage.styleImg + " src='/Admin/images/icons/" + objPage.PageImg + ".gif' align='absMiddle' name='fol_1'>";
			MenuEntry +=MenuData.MenuJSArray[3][i] + "</span>";
		}
		MenuEntry +="</div><span style='' ID='" + MenuData.MenuJSArray[0][i] + "_Childs'></span>";
	}
	if((MenuData.MenuJSArray[0].length- 1 == 0) && (document.getElementById("toggle_" + PageParentPageID)) && (("<%=Action%>" == "Move"  && CopyMoveAllowed ) || "<%=Action%>" == "Copy" || "<%=Action%>" == "MoveParagraph" || "<%=Action%>" == "CopyParagraph")) {
			var objSpaceImg 
			objSpaceImg = document.getElementById("spaceIMG_" + PageParentPageID)
			if(objSpaceImg) {
				imgWidth = objSpaceImg.getAttribute("width") + 15;
			} else {
				imgWidth = 0
			}
		//imgWidth = document.getElementById("spaceIMG_" + PageParentPageID).getAttribute("width") + 15;
		document.getElementById("toggle_" + PageParentPageID).setAttribute("src", "/Admin/images/Expand_off.gif");
		document.getElementById("toggle_" + PageParentPageID).setAttribute("onclick", "hideSpan(" + PageParentPageID + ");");
		document.getElementById("toggle_" + PageParentPageID).outerHTML = document.getElementById("toggle_" + PageParentPageID).outerHTML;

		document.getElementById("text_" + PageParentPageID).outerHTML = document.getElementById("text_" + PageParentPageID).outerHTML;
	}

	if("<%=Action%>" == "Move" && CopyMoveAllowed) {
		if(!PageParentPageID) {
			PageParentPageID = 0;
		}
		MenuEntry +="<div nowrap class='myMenu' ID='" + MenuData.MenuJSArray[0][i] + "'>";
		MenuEntry +="<img src='/Admin/images/nothing.gif' ID='spaceIMG_" + MenuData.MenuJSArray[0][i] + "' width='" + imgWidth + "' height='13'> "
		MenuEntry +="<img src='/Admin/images/nothing.gif' name='img_1' width='9' height='13'> "
		MenuEntry +="<img src='/Admin/Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'>"
		MenuEntry +="<span ID='move_" + MenuData.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + MenuData.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='movePageTo(" + PageParentPageID + ");'> <%=Translate.Translate("Flyt hertil")%></span>";
	}
	else if("<%=Action%>" == "Copy") {
		if(!PageParentPageID) {
			PageParentPageID = 0;
		}
		MenuEntry +="<div nowrap class='myMenu' ID='" + MenuData.MenuJSArray[0][i] + "'>";
		MenuEntry +="<img src='/Admin/images/nothing.gif' ID='spaceIMG_" + MenuData.MenuJSArray[0][i] + "' width='" + imgWidth + "' height='13'> "
		MenuEntry +="<img src='/Admin/images/nothing.gif' name='img_1' width='9' height='13'> "
		MenuEntry +="<img src='/Admin/Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'>"
		MenuEntry +="<span ID='move_" + MenuData.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + MenuData.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='copyPageTo(" + '"' + PageParentPageID + '"' + ");'> <%=Translate.JsTranslate("Kopier hertil")%></span>";
	}
	else if("<%=Action%>" == "MoveProduct" && CopyMoveAllowed) {
		if (PageParentPageID > 0) {
			MenuEntry +="<div nowrap class='myMenu' ID='" + MenuData.MenuJSArray[0][i] + "'>";
			MenuEntry +="<img src='/Admin/images/nothing.gif' ID='spaceIMG_" + MenuData.MenuJSArray[0][i] + "' width='" + imgWidth + "' height='13'> ";
			MenuEntry +="<img src='/Admin/images/nothing.gif' name='img_1' width='9' height='13'> ";
			MenuEntry +="<img src='/Admin/Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'>";
			MenuEntry +="<span ID='move_" + MenuData.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + MenuData.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='moveProductTo(" + '"' + PageParentPageID + '"' + ");'> <%=Translate.JsTranslate("Flyt hertil")%></span>";
		}
	}
	else if("<%=Action%>" == "CopyProduct") {
		if (PageParentPageID > 0) {
			MenuEntry +="<div nowrap class='myMenu' ID='" + MenuData.MenuJSArray[0][i] + "'>";
			MenuEntry +="<img src='/Admin/images/nothing.gif' ID='spaceIMG_" + MenuData.MenuJSArray[0][i] + "' width='" + imgWidth + "' height='13'> "
			MenuEntry +="<img src='/Admin/images/nothing.gif' name='img_1' width='9' height='13'> "
			MenuEntry +="<img src='/Admin/Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'>"
			MenuEntry +="<span ID='move_" + MenuData.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + MenuData.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='copyProductTo(" + '"' + PageParentPageID + '"' + ");'> <%=Translate.JsTranslate("Kopier hertil")%></span>";
			}
		}
	else if("<%=Action%>" == "AddPage" || CopyMoveAllowed == false)	{
	}
	else if(varSortAccess == true){
		if(MenuData.MenuJSArray[0].length > 2) {
			if(!PageParentPageID) {
				PageParentPageID = 0;
			}
			objPage.style		= "";
			MenuEntry +="<div nowrap class='myMenu' ID='" + PageParentPageID + "'>";
			MenuEntry +="<img src='/Admin/images/nothing.gif' ID='spaceIMG_" + PageParentPageID + "' width='" + imgWidth + "' height='13'> "
			MenuEntry +="<img src='/Admin/images/nothing.gif' name='img_1' width='9' height='13'> "
			MenuEntry +="<img src='/Admin/Images/Icons/Page_Sort.gif' align='absMiddle' name='fol_1'>"
			MenuEntry +=" <span ID='Sort_" + PageParentPageID + "' class='H' onmouseout='this.style.textDecoration=" + '""' + ";' onmouseover='this.style.textDecoration=" + '" underline"' + ";' " + objPage.style + " onClick='SortPages(" + '"' + PageParentPageID + '"' + ");'><%=Translate.Translate("Sorter")%></span>"
		}
	}
	return MenuEntry;
}
</script>
