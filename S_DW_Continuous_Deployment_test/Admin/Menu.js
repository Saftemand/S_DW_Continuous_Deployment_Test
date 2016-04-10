var MenuTexts = [], gVars = {};
var useMozilla = document.getElementById && !document.all;
var my=0, mx=0, fEvent;
var NewSelectedPageID = 0, PreviousPageID, CopyMoveInProcess;

function initGlobalData() {
    MenuTexts['Warning'] = '';
    MenuTexts['Notice'] = '';
    MenuTexts['AllPagesWillDeleted'] = '';
    MenuTexts['NewPage'] = '';
    MenuTexts['OpenNewWnd'] = '';
    MenuTexts['NewSubSite'] = '';
    MenuTexts['NewName'] = '';
    MenuTexts['Properties'] = '';
    MenuTexts['ViewPage'] = '';
    MenuTexts['ViewJournal'] = '';
    MenuTexts['ShowAsProfile'] = '';
    MenuTexts['CopyPage'] = '';
    MenuTexts['CopyTemplate'] = '';
    MenuTexts['CopyHere'] = '';
    MenuTexts['DeletePage'] = '';
    MenuTexts['DeleteTemplate'] = '';
    MenuTexts['Refresh'] = '';
    MenuTexts['CreatePageStructure'] = '';
    MenuTexts['EditPage'] = '';
    MenuTexts['Preview'] = '';
    MenuTexts['Optimize'] = '';
    MenuTexts['MovePage'] = '';
    MenuTexts['MoveTemplate'] = '';
    MenuTexts['MoveHere'] = '';
    MenuTexts['RestoreTo'] = '';
    MenuTexts['Sort'] = '';
    MenuTexts['NewFolder'] = '';
    MenuTexts['NewSubFolder'] = '';
    MenuTexts['RenameFolder'] = '';
    MenuTexts['DeleteFolder'] = '';

    gVars.AreaID = 0;
    gVars.MasterAreaID = 0;
    gVars.NumberOfPages = 0;
    gVars.SelectedPageID = 0;
    gVars.MoveFromPageID = 0;
    gVars.LeftHeight = 0;
    
    gVars.Action = '';
    gVars.UserID = '';
    gVars.AreaName = '';
    gVars.CopyID = '';
    gVars.MoveID = '';
    gVars.InternalAllID = '';
    gVars.InternalCallback = false;
    gVars.ShowParagraphs = '';
    gVars.ShowTrashBin = '';
    gVars.ShowParagraphsOption = '';
    gVars.InternalItemType = ''

    gVars.IsFirefox = false;
    gVars.IsNewGUI = true;
    gVars.IsShowParagraphs = true;
    gVars.IsMasterArea = false;
    gVars.IsCreateLightVersionPages = false;
    gVars.IsNotAllowNewPages = false;
    gVars.IsAllowNewPages = false;
    gVars.IsAllowNewParagraphs =  false;
    gVars.IsInstalledOMC = false;
    gVars.IsInstalledWorkflow = false;
    gVars.IsAccessSeo = false;
    gVars.IsEditor =  false;    
    gVars.ShowSortingWarning = false;
    gVars.SortingWarning = '';
    gVars.LinkManagerSettings = null;
}

function getCookie(name) {
    var c = window.opener ? window.opener.document.cookie : null;
    if (c) {
        var matches = c.match(new RegExp(
            "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
        ));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }
    return undefined;
}
initGlobalData();

function getOuterHTML(el){ 
     var element=document.getElementById(el) 

     if (typeof(element.outerHTML) != 'undefined'){
	    return element.outerHTML; 
     }
     else {
	     var pelement = element.parentNode;

	     var tname = element.tagName;

	     var fhtm = pelement.innerHTML;

	     var ehtm = element.innerHTML;
	     var i = fhtm.indexOf(el);
	     var fphtm = fhtm.substr(0,i);
	     var b = fphtm.lastIndexOf("<");

	     var e = fhtm.indexOf(">", i);
	     var ret = fhtm.substr(b, (e-b)+1)+ehtm;
	     if (tname.toLowerCase()!="img")
            ret+="</"+tname.toLowerCase()+">";
         return ret;
     }
}

function setOuterHTML(el, toValue) { 
   element=document.getElementById(el) 

     if (typeof(element.outerHTML) != 'undefined'){
        element.outerHTML = toValue; 
     }
     else { 
	    var repl = getOuterHTML(el);
	    var pelement = element.parentNode;
	    var reg = new RegExp(repl, "g");
	    pelement.innerHTML = pelement.innerHTML.replace(reg,toValue);
     } 
}

function SetTreeContainerHeight() {
	var accordionName = gVars.IsFirefox ? "accordion1" : "Div1";
	accordionName = "accordion1";
	var accHeight = document.getElementById(accordionName) && document.getElementById(accordionName).offsetHeight || 0;
	        
	var treeStartHeight = document.getElementById("TreeStart") && document.getElementById("TreeStart").offsetHeight || 0;
	var selfHeight = self.innerHeight || document.documentElement.offsetHeight;
	
    if (!gVars.IsNewGUI) accHeight += 150;

	var treeContainerHeight = (selfHeight - treeStartHeight - accHeight);
	if(treeContainerHeight < 0) treeContainerHeight = 1;
	document.getElementById("TreeContainer").style.height = treeContainerHeight + "px";
	document.getElementById("SearchBox").style.height = selfHeight - accHeight + "px";
	return false;
}

function addResizeEvent(func) {
	if (window.addEventListener) window.addEventListener('resize', func, false);
	else if (window.attachEvent) window.attachEvent('onresize', func);
}

function PageSearchID_OnChange(id) {
	if (isNaN(parseInt(document.getElementById(id).value))) {
		if (id == "PageSearchID") document.getElementById("PageSearchParagraphID").disabled = false;
		if (id == "PageSearchParagraphID") document.getElementById("PageSearchID").disabled = false;
		document.getElementById("PageSearchText").disabled = false;
		document.getElementById("PageSearchIn_Page").disabled = false;
		document.getElementById("PageSearchIn_Paragraph").disabled	= false;
		document.getElementById("PageSearch_Modules").disabled = false;
		document.getElementById("PageSearchIn_WebsiteOnly").disabled = false;
	}
	else {
		if (id == "PageSearchID") document.getElementById("PageSearchParagraphID").disabled = true;
		if (id == "PageSearchParagraphID") document.getElementById("PageSearchID").disabled = true;
		document.getElementById("PageSearchText").disabled = true;
		document.getElementById("PageSearchIn_Page").disabled	= true;
		document.getElementById("PageSearchIn_Paragraph").disabled	= true;
		document.getElementById("PageSearch_Modules").disabled = true;
		document.getElementById("PageSearchIn_WebsiteOnly").disabled = true;
		document.getElementById("PageSearchIn_WebsiteOnly").checked = false;
	}
}

function AreaSelected(AreaID) {
	for (var i = 0; i < document.getElementById('AreaDropDown').length; i++) {
		if (AreaID == document.getElementById('AreaDropDown')[i].value) {
			document.getElementById('AreaDropDown').selectedIndex = i;
			document.forms.area.submit();
			break;
		}
	}
}

function AddPageUserManagement(ID){
    if (gVars.UserID != "")
	    window.top.opener.window.frames.AccessListUsers.location = "Access/Access_Page_add.aspx?ID="+ gVars.UserID +"&PageID=" + ID;
}

function editArea(AreaID) {
	if (gVars.IsNewGUI)
		top.right.location = '/Admin/Content/Area/Edit.aspx?AreaID=' + AreaID;
	else
		top.right.location = '/Admin/Area_Edit.aspx?AreaID=' + AreaID;
}

function translationKeyReference(AreaID) {
    // Screen center
    var x = screen.width / 2 - 800 / 2;
    var y = screen.height / 2 - 600 / 2;

    window.open('/Admin/Content/Management/Dictionary/TranslationKey_Reference.aspx?AreaID=' + AreaID, '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
}

function manageareas(AreaID){
	top.right.location = '/Admin/Content/Area/List.aspx?AreaID=' + AreaID;
}

function updatedPages(AreaID) {
	top.right.location = '/Admin/Content/Area/LanguageUpdates.aspx?AreaID=' + AreaID;
}

function mclick(event){
	if (typeof(event)=='undefined') 
        return;
	my = event.pageY;
	mx = event.pageX;
}

//get fired on body.onLoad and loads the menu
function MenuStart(){
	var MenuEntry = getMenu(MenuEntry);
	document.getElementById('mySpan').innerHtml = MenuEntry;
}

//Sets the Area Dropdownlist to the correct selection in connection with a move or copy of a page og paragraph. 
//It gets called from the pages that copies or moves paragraphs og pages
function setAreaID(varAreaID){
    gVars.AreaID = varAreaID;
}

//Sets the Area Dropdownlist to the correct selection in connection with a move or copy of a page og paragraph. 
//It gets called from the pages that copies or moves paragraphs og pages.
function setAreaDropDown(varAreaID){
	if(document.getElementById("AreaDropDown")){
		for (var i = 0; i < document.getElementById("AreaDropDown").length; i++){
			if(document.getElementById("AreaDropDown").options[i].value == varAreaID){
				document.getElementById("AreaName").innerHTML = document.getElementById("AreaDropDown").options[i].text;
                document.getElementById("AreaDropDown").selectedIndex = i;
                document.forms.area.submit();
			}
		}
	}
}

//updates the menu-entry (the hole current level) to the correct view after creating or editing a page
function UpdateMenuEntry(PageParentPageID){	
	toggleNode(PageParentPageID, 3);
}

function MakeBoldMenuEntry(PageParentPageID){	
	NewSelectedPageID = PageParentPageID;
	MakeBold(document.getElementById('text_' + NewSelectedPageID));
}

// CPK: Substracts 'pagecount' from the 'numberofpage' span seen at the top of the menu
function UpdatePageCount_Delete(pagecount) {
  var i;
  
  i = document.getElementById("numberofpages").innerHTML - pagecount;
  document.getElementById("numberofpages").innerHTML = i;
}

function SetPageCount(pagecount){
	document.getElementById("numberofpages").innerHTML = pagecount;
}

// CPK: Adds 'pagecount' to the 'numberofpage' span seen at the top of the menu
function UpdatePageCount_Add(pagecount){
  var i;
  
  i = Number(document.getElementById("numberofpages").innerHTML) + Number(pagecount);
  document.getElementById("numberofpages").innerHTML = i;
}

function Refresh(PageParentPageID){
	NewSelectedPageID = 0;
	document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?ParentPageID=" + PageParentPageID + "&update=3" + "&AreaID=" + gVars.AreaID);
}

//reset the menu and folds it out to the correct (Page and Area) view in connection with a move or copy of a page og paragraph. 
//It gets called from the pages that copies or moves paragraphs og pages and from MenuData.asp
function MoveMenuEntry(PageParentPageID){
    document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?ParentPageID=" + PageParentPageID + "&AreaID=" + gVars.AreaID + "&update=1&MoveID=" + PageParentPageID);
}

//A public Array holding information on the submenu path (The PageID's from the top-level down to the selected page)
var newArray = new Array();
//A varialble holding the position in "newArray"
var position;

//function called when a move or copy has occurred. The caller is MenuData.asp
//It receives an array holding information on the menu-path from the top-level down to the selected page.
//It also starts the sequence of events that gathers each menu-level.
function EndMoveMenuEntry(){
	newArray = document.getElementById("MenuData").contentWindow.MenuJSArray;
	document.getElementById('mySpan').innerHTML = "";
	position= newArray[0].length - 1;
	document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?ParentPageID=" + newArray[1][position] + "&AreaID=" + gVars.AreaID + "&update=3");
}

//function that mostly gets called when a menu + is clicked. It calls the IFRAME with specific parameters, so the MenuData returns
//an array containing a menu-sublevel
var dragging = false;
function toggleNode(PageParentPageID, update) {
	CopyMoveInProcess = 0
	NewSelectedPageID = 0;
	if(!dragging){
		document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?Action=" + gVars.Action + "&ParentPageID=" + PageParentPageID + "&AreaID=" + gVars.AreaID + "&update=" + update);
	}
}

// togle node and save selected page to top.opener
function toggleEditContent(PageParentPageID, update, ID, Name) {
	toggleNode(PageParentPageID, update);
}

//function that gets called by the returning MenuData.asp file when a menu + is clicked.
//Then function gets menu a menu-entry and adds it in the right position in the menu.
//If is a rebuild of the menu (in case of a move or copy action) it also calls the MenuData.asp with data on the next level.
function endToggle(PageParentPageID, update) {
	var MenuEntry;
	if (PageParentPageID > 0){
		//Added for single opening. CPK: Added or update==3 so it will work with page delete and new page
		if (PageParentPageID != PreviousPageID || update==3 || CopyMoveInProcess == 1) { // check for multiple clicks on same menuitem - "flyt hertil" is shown multiple times
			MenuEntry = getMenu(MenuEntry, PageParentPageID);

			if(update == 1 || update == 3 || PageParentPageID != PreviousPageID){
				document.getElementById(PageParentPageID + '_Childs').innerHTML="";
				document.getElementById(PageParentPageID + '_Childs').innerHTML =MenuEntry;		
			}
			else{
				document.getElementById(PageParentPageID + '_Childs').innerHTML +=MenuEntry;
			}
		}
	}
	else
	{
		MenuEntry = getMenu(MenuEntry, PageParentPageID);
		if(update == 3) {
			document.getElementById('mySpan').innerHTML = MenuEntry;
            PreviousPageID = 0;
        }
	}

	if(newArray && position > 0){
		position = position - 1;
		document.getElementById("MenuData").setAttribute("src", "MenuData.aspx?ParentPageID=" + newArray[1][position] + "&AreaID=" + gVars.AreaID + "&update=");
	}

	//Make Bold/Unbold depending on CopyMoveInProcess
	if(CopyMoveInProcess == 1){
		var newParentID;
		newParentID = newArray[0][1].toString();   //ID of the new parent created - copy/move
		intPrevID = newParentID    //Make new item the previous item - to do unbold 
		
		if(newParentID) {
			if(document.getElementById(newParentID)) {
				document.getElementById(newParentID).style.fontWeight="bold";
			}
		}
	}

	if(CopyMoveInProcess == 0){
		//Make sure previous selected item remains bold if not copying or moving item
		if(intPrevID) {
			if(document.getElementById(intPrevID)) {
				document.getElementById(intPrevID).style.fontWeight = "bold";
			}
		}
	}
	if (NewSelectedPageID > 0){
	    MakeBold(document.getElementById('text_' + NewSelectedPageID));
	}

	document.fire('menu:endToggle', { PageID: PageParentPageID });
}

//Hides a menu level (including all its sublevels). It hide the SPAN ([ParentID]_Childs) containing the submenus and changes the
//Image and onclick events on the Expand/Expand_Off button so it can Unhide the span again when clicked.
function hideSpan(PageParentPageID){
	if(PageParentPageID > 0){
		document.getElementById(PageParentPageID + "_Childs").style.display= 'none';
		document.getElementById("toggle_" + PageParentPageID).setAttribute("src", "images/Expand.gif");
		document.getElementById("toggle_" + PageParentPageID).setAttribute("onclick", "unhideSpan(" + PageParentPageID + ");");
		document.getElementById("toggle_" + PageParentPageID).outerHTML = document.getElementById("toggle_" + PageParentPageID).outerHTML;
	}
}

//Unhides a menu level (including all its sublevels). It Unhide the SPAN ([ParentID]_Childs) containing the submenus and changes the
//Image and onclick events on the Expand/Expand_Off button so it can hide the span again when clicked.
function unhideSpan(PageParentPageID){
	if(PageParentPageID > 0){
		document.getElementById(PageParentPageID + "_Childs").style.display= ''
		document.getElementById("toggle_" + PageParentPageID).setAttribute("src", "images/Expand_off.gif")
		document.getElementById("toggle_" + PageParentPageID).setAttribute("onclick", "hideSpan(" + PageParentPageID + ");")
		document.getElementById("toggle_" + PageParentPageID).outerHTML = document.getElementById("toggle_" + PageParentPageID).outerHTML
	}
}

//this function returns the correct Icon for the different pages in the menu
function setupPageIcon(objPage, i) {
    var MenuJSArray = document.getElementById("MenuData").contentWindow.MenuJSArray;
    var copyID = parseInt(gVars.CopyID);
    var pageID = MenuJSArray[0][i];

    var dimIcon = (gVars.Action == 'Copy' && pageID == copyID) ||
                  (gVars.Action == 'Internal' && gVars.ShowParagraphs != "on" && gVars.InternalItemType != "" && gVars.InternalItemType != MenuJSArray[19][i]);
    var styleImg = " STYLE='filter:progid:DXImageTransform.Microsoft.Alpha(opacity=70)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);'";

    if (MenuJSArray[18][i] != "0") {											// 18 = Page has experiment
        objPage.PageImg = "document_chart";
    }

    if (MenuJSArray[17][i] != "0") {											// 17 = Page is profiled
		objPage.PageImg = "document_profiled";
    }

	if(MenuJSArray[6][i] != ""){										// 6 = PageRotation
		if (gVars.IsNewGUI) objPage.PageImg = "document_refresh";
		else objPage.PageImg = "Page_rotate";
    }

	if(Date.parse(MenuJSArray[7][i]) < Date.parse("01/01/2999 00:01:00 PM")){	// 7 = PageActiveTo - test= alert(Date.parse(MenuJSArray[7][i]) + " > " + Date.parse("01/01/2999 00:01:00 PM"));
	    if (gVars.IsNewGUI) objPage.PageImg = "document_time";
		else objPage.PageImg = "Page_publice";
	}

	if (Date.parse(MenuJSArray[22][i]) > Date.parse(Date())) {                  // 22 = PageActiveFrom
        if (gVars.IsNewGUI) {
            objPage.style = " style='color:#BB7F7F;'";
            objPage.PageImg = "document_time";
        } 
        else objPage.PageImg = "Page_publice";
	}
    
    if(MenuJSArray[8][i].length > 0 || MenuJSArray[9][i] == "True"){	// Len(Trim(PagePermission)) > 0 OR PageProtect Then
		if (gVars.IsNewGUI) objPage.PageImg = "document_lock";
		else objPage.PageImg = "Page_pass";
    }

	if(MenuJSArray[10][i].length > 0){											// 10 = PageShortCut     Len(Trim(PageShortCut)) > 0 Then
		if(MenuJSArray[11][i]==1){													// 11 = internal link or not     Len(Trim(PageShortCut)) > 0 Then
			if (gVars.IsNewGUI) objPage.PageImg = "document_into";
			else objPage.PageImg = "Page_int";
        }
		else {
			if (gVars.IsNewGUI) objPage.PageImg = "document_out";
			else objPage.PageImg = "Page_ext";
		}
     }

   if (MenuJSArray[12][i] != "1") {												                                                // 12 = PageAllowclick
		if (gVars.IsNewGUI) objPage.PageImg = "document_plain_yellow";
		else objPage.PageImg = "Page_folder";
	}

    if (MenuJSArray[14][i] != "0") {											                                                // 14 = Pagehidden
		objPage.PageImg = "document_forbidden";
    }

    if (MenuJSArray[16][i] != "0") {											                                                // 16 = PageIsTemplate
		if(MenuJSArray[16][i] == "2") objPage.PageImg = "FolderComponents";
        else objPage.PageImg = "document_new";
	}
    else {
        if (MenuJSArray[13][i] != "1") {												// 13 = PageActive
			objPage.style = " style='color:#BB7F7F;'";
			objPage.styleImg = styleImg;
		}

		if(dimIcon) {
			objPage.style = " style='color:#C1C1C1;'";
			objPage.styleImg = styleImg;
		}
    }

    // Fill image with address and extension
    if (objPage.PageImg != MenuJSArray[21][i])
        objPage.PageImg = "images/icons/" + objPage.PageImg + ".gif";

    if (MenuJSArray[19][i] != "") {                                            // 19 - Page is item
        if (MenuJSArray[21][i] != "")                                            // 21 - Item type icon
            objPage.PageImg = MenuJSArray[21][i];
        else
            objPage.PageImg = "Images/Ribbon/Icons/Small/cube_blue.png";
    }

    if (MenuJSArray[23][i] == "-2") {                  // 23 = PageApprovalType
        if (gVars.IsNewGUI) {
            objPage.PageImg = "Images/Ribbon/Icons/Small/document_notebook.png";
        }         
        else objPage.PageImg = "Page_publice";
    }
    if (MenuJSArray[24][i] != "0") {											// 24 = Page is folder
        objPage.PageImg = "Images/Ribbon/Icons/Small/Folder.png";
    }
}

//Underline name of folder when mouse is over and clear when mouseout
function hl(menuObject, ID){ 
	if(ID){
		menuObject.style.textDecoration = "underline";
		self.status = "ID: " + ID;
		if(document.getElementById("_statusPageId"))
			document.getElementById("_statusPageId").innerHTML = "ID: " + ID;
	}
	else{
		menuObject.style.textDecoration = "";
		window.self.status = "";
		if(document.getElementById("_statusPageId"))
            document.getElementById("_statusPageId").innerHTML = "";
	}
}

// Open page to add page structure
function AddMenuStructure(parentPageID) {
	if (parentPageID == "NO_ID_MENU") parentPageID = "";
	window.parent.right.location = "Page_Structure.aspx?parentPageID=" + parentPageID +"&AreaID=" + gVars.AreaID;
}

// Activate the MenuID for contextmenu
var MenuID, MenuMode, MenuCo, MenuIsPageTemplatesRoot;
function MenuActivator(thisID, thisMode, co, isPageTemplatesRoot) {
	MenuID = thisID;
	MenuMode = thisMode;
	MenuCo = co;
	MenuIsPageTemplatesRoot = isPageTemplatesRoot;
}

var AccordionAction;
function setAccordionRightClick(ev) {
    AccordionAction = "";
	if (ev){
		mx = ev.pageX;
		my = ev.pageY;
		fEvent = ev;
	    
	    fEvent.returnValue = false;	
		if(useMozilla) fEvent.preventDefault();
	    if (this && this.attributes && this.attributes.length > 0)
            AccordionAction = this.attributes["onclick"].value;
	}
    else if (window.event && window.event.srcElement && window.event.srcElement.parentElement) {
       AccordionAction = window.event.srcElement.parentElement.attributes["onclick"].value;
    }

	hideNow();

    if (AccordionAction.length > 0) showMenu("ACCORDION_MENU");

	return false;
}

// Made for diff. rightclick menues, changing the contextmenu on the document.
function setRightClick(ev) {
    if (ev){
		mx = ev.pageX;
		my = ev.pageY;
		fEvent = ev;
	    
	    fEvent.returnValue = false;	
		if(useMozilla) fEvent.preventDefault();
	}

	hideNow();

	if (MenuID && !MenuIsPageTemplatesRoot) {
		if (parseInt(MenuID) > 0) {
			rightClick(MenuID, MenuCo, null);
		}
	} else if(!MenuIsPageTemplatesRoot) {
		rightClick("NO_ID_MENU", null, null);
	}
	
	return false;
}

//a variable holding the current clicked object
var menuObject = "";

//the function is called when right-clicking a menuitem. calls the function that shows the contexts-menu
function rightClick(PageID, co, rightClicked) {
	if (menuObject) {
		menuObject.style.fontWeight = "";
	}	

	if (co) {
	    menuObject = co; 
	    MakeBold(co);
	}
	
	var ev = (window.event)?window.event:fEvent;

	if (PageID && PageID != "" && PageID != "NO_ID_MENU") {	
   	    showMenu(PageID);
	    if (ev) {
	        ev.returnValue=false;
	    }
	    return false;
	} else {	

		//if this is called when right-clicking in empty menu, "white area :-)"
		if (ev){
		    if (ev.ctrlKey == false) {
			    showMenu("NO_ID_MENU");
			    ev.returnValue = false;
			    return false;
		    }	
		}
	}
}

//function that hides the context-menu and removes the "bold"-style on the menuitem.
function hideNow(){
   
	if (document.getElementById("Rmenu")){
	document.getElementById("Rmenu").style.display = 'none';
	}
//	if(menuObject.style)
//		menuObject.style.fontWeight = "";
}

//function that builds the context-menu and shows it at the right position.
function showMenu(ID, menuobject, documentObj, Ey, Ex) {
    var createPages = getNumberOfPages();
    
    // Allow the user to move, delete, or copy a page only if he has permission to all subpages
    var allowMoveDeleteCopy = umPermissions.length == 0 || umPermissions[ID];
    var allowCopy = copyPermissions.length==0||copyPermissions[ID];
    var isItemBased = relatedItemIds[ID] && relatedItemIds[ID].length;

    var isNotTemplate;

    if (isNotATemplate.length==0) isNotTemplate=true;
    else isNotTemplate = isNotATemplate[ID]=="True";

    var isFolder = folderIds[ID];    

    var objJsdoc = new Object(); 
	objJsdoc = "window.parent.left.";
	var MenuHTML;

	MenuHTML = "<span class=altMenuLeftPane id=altMenuLeftPane></span>";
	MenuHTML += '<table cellpadding=0 name="altMenuTable" id="altMenuTable" cellspacing=0 border=0 width="100%" style="position:relative;top:0px;left:0px;">';
	
    if (gVars.IsNewGUI) {
        if (gVars.IsMasterArea) createPagestructure = 0;
        else createPagestructure = 1;
    
        if (gVars.IsNotAllowNewPages) {
            createPages = 0;
            allowMoveDeleteCopy = false;
         }

	    if (ID == "NO_ID_MENU" ) {
	        if (createPages == 1 && backendAllowed)
	            MenuHTML += '<tr><td onClick="' + objJsdoc + 'NewPage();" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/Images/Ribbon/Icons/Small/Paragraph.png" align=absmiddle class=altMenuImg>' + MenuTexts['NewPage'] + '</td></tr>';
	        MenuHTML += '<tr><td onClick="' + objJsdoc + 'NewFolder();" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/Images/Ribbon/Icons/Small/Folder.png" align=absmiddle class=altMenuImg>' + MenuTexts['NewFolder'] + '</td></tr>';
        }
        else if (ID == "ACCORDION_MENU") {
            MenuHTML += '<tr><td onClick="' + objJsdoc + 'toggleAccordion(\'' + AccordionAction + '\');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/Images/Ribbon/Icons/Small/Paragraph.png" align=absmiddle class=altMenuImg>'+ MenuTexts['OpenNewWnd'] +'</td></tr>';
	    } 
        else {
            if (isFolder) {
                //New subfolder
                MenuHTML += '<tr><td onClick="' + objJsdoc + 'NewSubFolder(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/Images/Ribbon/Icons/Small/Folder.png" align=absmiddle class=altMenuImg>' + MenuTexts['NewSubFolder'] + '</td></tr>';

                // New subpage
                if (createPages == 1 && isNotTemplate)
                    MenuHTML += '<tr><td onClick="' + objJsdoc + 'newsubpage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/Paragraph.png" align=absmiddle class=altMenuImg>' + MenuTexts['NewPage'] + '</td></tr>';

                // Edit folder
                MenuHTML += '<tr><td onClick="' + objJsdoc + 'RenameFolder(' + ID + ', true);" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/DocumentProperties.png" align=absmiddle class=altMenuImg>' + MenuTexts['RenameFolder'] + '</td></tr>';

                // Delete folder                
                MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';                    
                MenuHTML += '<tr><td onClick="' + objJsdoc + 'deletepage(' + ID + ', true);" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/DeleteDocument.png" align=absmiddle class="altMenuImg" />' + MenuTexts['DeleteFolder'] + '</td></tr>';                                    
            } else {
                // New subpage
                if (createPages == 1 && isNotTemplate)
                    MenuHTML += '<tr><td onClick="' + objJsdoc + 'newsubpage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/Paragraph.png" align=absmiddle class=altMenuImg>' + MenuTexts['NewSubSite'] + '</td></tr>';

                if (gVars.IsAllowNewParagraphs) {
                    // New paragraph
                    if (!isItemBased)
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'newparagraph(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class="mout" nowrap><img src="/Admin/Images/Ribbon/Icons/Small/AddDocument.png" align="absmiddle" class="altMenuImg">' + MenuTexts['NewName'] + '</td></tr>';
                }

                // View page
                MenuHTML += '<tr><td onClick="' + objJsdoc + 'previewpage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/Preview.png" align=absmiddle class=altMenuImg>' + MenuTexts['ViewPage'] + '</td></tr>';

                // Preview
                if (!isItemBased) {
                    MenuHTML += '<tr><td onClick="' + objJsdoc + 'preview(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/document_zoom_in.png" align=absmiddle class=altMenuImg>' + MenuTexts['ViewJournal'] + '</td></tr>';
                }

                if (gVars.IsInstalledOMC) {
                    MenuHTML += '<tr><td onClick="' + objJsdoc + 'previewProfile(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/icons/document_profiled.gif" align=absmiddle class=altMenuImg>' + MenuTexts['ShowAsProfile'] + '</td></tr>';
                }

                // Optimize
                if (isNotTemplate) {
                    if (gVars.IsAccessSeo) {
                        MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'Optimize(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/Seo.png" align=absmiddle class=altMenuImg>' + MenuTexts['Optimize'] + '</td></tr>';
                    }
                }

                // Move page
                if (allowMoveDeleteCopy) {
                    MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';
                    if (isNotTemplate)
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'movepage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/MoveDocument.png" align=absmiddle class=altMenuImg>' + MenuTexts['MovePage'] + '</td></tr>';
                    else
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'movepage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/MoveDocument.png" align=absmiddle class=altMenuImg>' + MenuTexts['MoveTemplate'] + '</td></tr>';
                }

                // Copy page
                if (createPages == 1 && allowMoveDeleteCopy && allowCopy) {
                    if (isNotTemplate) {
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'copypage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/Copy.png" align=absmiddle class=altMenuImg>' + MenuTexts['CopyPage'] + '</td></tr>';
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'copyPageTo(' + ID + ', true);" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Icons/Page_MoveTo.gif" align=absmiddle class=altMenuImg>' + MenuTexts['CopyHere'] + '</td></tr>';
                    }
                    else
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'copypage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/Copy.png" align=absmiddle class=altMenuImg>' + MenuTexts['CopyTemplate'] + '</td></tr>';
                }

                // Delete page
                if (allowMoveDeleteCopy) {
                    MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';

                    if (isNotTemplate)
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'deletepage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/DeleteDocument.png" align=absmiddle class="altMenuImg" />' + MenuTexts['DeletePage'] + '</td></tr>';
                    else
                        MenuHTML += '<tr><td onClick="' + objJsdoc + 'deletepage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/DeleteDocument.png" align=absmiddle class="altMenuImg" />' + MenuTexts['DeleteTemplate'] + '</td></tr>';
                }
            }	        
        }
        
         if (ID != "ACCORDION_MENU") {
             // Refresh
            if (backendAllowed) MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';
            MenuHTML += '<tr><td onClick="' + objJsdoc + 'Refresh(0);" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu();" class="mout"><img src="/Admin/Images/Ribbon/Icons/Small/refresh.png" align="absmiddle" class="altMenuImg" />' + MenuTexts['Refresh'] + '</td></tr>';
		
		    // Add menu structure
    	    if (createPages == 1 && createPagestructure == 1 && backendAllowed && !isFolder)
    	        MenuHTML += '<tr><td onClick="' + objJsdoc + 'AddMenuStructure(\'' + ID + '\');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class="mout" nowrap><img src="/Admin/Images/Ribbon/Icons/Small/Tree.png" align="absmiddle" class="altMenuImg">' + MenuTexts['CreatePageStructure'] + '</td></tr>';

             // Edit page
    	    MenuHTML += '<tr><td onClick="' + objJsdoc + 'editpage(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/Images/Ribbon/Icons/Small/DocumentProperties.png" align=absmiddle class=altMenuImg>' + MenuTexts['Properties'] + '</td></tr>';
         }
 }
 else {
	if (ID == "NO_ID_MENU") {
		if (createPages == 1) // New page
		    MenuHTML += '<tr><td onClick="' + objJsdoc + 'NewPage();" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Page_open.gif" align=absmiddle class=altMenuImg>' + MenuTexts['NewPage'] + '</td></tr>';
		MenuHTML += '<tr><td onClick="' + objJsdoc + 'NewFolder();" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/Images/Ribbon/Icons/Small/Folder.png" align=absmiddle class=altMenuImg>' + MenuTexts['NewFolder'] + '</td></tr>';
	} 
    else {
		//<%'UPGRADE_WARNING: Use of Null/IsNull() detected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1049"'%>
		
        if (createPages == 1) // New subpage
			MenuHTML += '<tr><td onClick="' + objJsdoc + 'newsubpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_open.gif" align=absmiddle class=altMenuImg>'+ MenuTexts['NewSubSite'] +'</td></tr>';

	    //New subfolder
        if(isFolder)
            MenuHTML += '<tr><td onClick="' + objJsdoc + 'NewSubFolder('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/Images/Ribbon/Icons/Small/Folder.png" align=absmiddle class=altMenuImg>' + MenuTexts['NewSubFolder'] + '</td></tr>';

		// New paragraph
		MenuHTML += '<tr><td onClick="' + objJsdoc + 'newparagraph('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class="mout" nowrap><img src="/Admin/images/Icons/Paragraph.gif" align="absmiddle" class="altMenuImg">'+ MenuTexts['NewName'] +'</td></tr>';
		
		// Edit page
		MenuHTML += '<tr><td onClick="' + objJsdoc + 'editpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_edit.gif" align=absmiddle class=altMenuImg>'+ MenuTexts['EditPage'] +'</td></tr>';
		
		// Preview
		MenuHTML += '<tr><td onClick="' + objJsdoc + 'previewpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_preview.gif" align=absmiddle class=altMenuImg>'+ MenuTexts['ViewPage'] +'</td></tr>';
		
        if (gVars.IsInstalledWorkflow)
		    MenuHTML += '<tr><td onClick="' + objJsdoc + 'preview('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_open.gif" align=absmiddle class=altMenuImg>'+ MenuTexts['Preview'] +'</td></tr>';
		
		// Optimize
		if (gVars.IsAccessSeo) {
		    MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';
		    MenuHTML += '<tr><td onClick="' + objJsdoc + 'Optimize('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_open.gif" align=absmiddle class=altMenuImg>'+ MenuTexts['Optimize'] +'</td></tr>';
		}
		
		// Move page
		if (allowMoveDeleteCopy) {
		    MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';
		    MenuHTML += '<tr><td onClick="' + objJsdoc + 'movepage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_Move.gif" align=absmiddle class=altMenuImg>'+ MenuTexts['MovePage'] +'</td></tr>';
		}
		
		// Copy page
        if (createPages == 1 && allowMoveDeleteCopy)
		    MenuHTML += '<tr><td onClick="' + objJsdoc + 'copypage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_Copy.gif" align=absmiddle class=altMenuImg>'+ MenuTexts['CopyPage'] +'</td></tr>';
        
        // Delete page
   		if (allowMoveDeleteCopy) {
		    MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';
		    MenuHTML += '<tr><td onClick="' + objJsdoc + 'deletepage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_Delete.gif" align=absmiddle class="altMenuImg" />'+ MenuTexts['DeletePage'] +'</td></tr>';
		}
	}

	// Refresh
	MenuHTML += '<tr><td onmouseover="doNotHide();" onmouseout="hideMenu();" align="right"><img src="/Admin/images/nothing.gif" class="altMenuDivider" /></td></tr>';
	MenuHTML += '<tr><td onClick="' + objJsdoc + 'Refresh(0);" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu();" class="mout"><img src="/Admin/images/Icons/Page_rotate.gif" align="absmiddle" class="altMenuImg" />'+ MenuTexts['Refresh'] +'</td></tr>';
		
	// Add menu structure
    if (createPages == 1)
	    MenuHTML += '<tr><td onClick="' + objJsdoc + 'AddMenuStructure(\''+ID+'\');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class="mout" nowrap><img src="/Admin/images/Icons/Page_structure.gif" align="absmiddle" class="altMenuImg">'+ MenuTexts['CreatePageStructure'] +'</td></tr>';
  }

	MenuHTML += '</table>';
	if (!menuobject) menuobject = document.getElementById("Rmenu");
	if (!documentObj) documentObj = document;
	menuobject.innerHTML = MenuHTML;

	if (!Ey) {
		var ev;
		if (typeof(event)=='undefined') {
			ev = Event;
			Ey = my;
			Ex = mx;
		} else {
			ev = event;
			Ey = ev.clientY;
			Ex = ev.clientX;
		}
		menuobject.style.top = Ey + 'px';

		if (Ex + 160 < gVars.LeftHeight) menuobject.style.left = Ex + 'px';
		else menuobject.style.left = (gVars.LeftHeight - 160) + 'px';
	} else { //Called from paragraph_list.asp
        menuobject.style.top = Ey + 'px';
        menuobject.style.left = Ex + 'px';
	}

	menuobject.style.display = "block";

	if (!useMozilla) {
	    menuobject.style.height = '0px';
	    var tab = document.getElementById('altMenuTable');
	    if(tab){
	        menuobject.style.height = tab.offsetHeight + 'px';
	        tab.style.width = (menuobject.offsetWidth - 4) + 'px';
        }
    }

    ReplaceMenuPosition(menuobject);
   
    return false;
}

function getIntSize(val) {
    var result = (val && val != "") ? parseInt(val.toString().replace(/px/g, '')) : 0;
    if (isNaN(result)) result = 0;
    return result;
}
    
function ReplaceMenuPosition(menuObj){
    var frameHeight = getIntSize(document.body.clientHeight);
    if ((getIntSize(menuObj.style.top) + getIntSize(menuObj.style.height)) > (frameHeight - 5))
        menuObj.style.top = (frameHeight - getIntSize(menuObj.style.height) - 10) + 'px';
}

//A variable holding the information whether the context-menu is hidden or not.
hide = true;

//Set the hide variable to false so the context-menu doesn't get hidden.
function doNotHide(){
	hide = false;
}

//Set a timeout that calls a function that hide the context-menu.
//This is done so the context-menu doesn't get hidden right a way.
function hideMenu(){
	hide = true;
	setTimeout("doTheHide()", 2000);
}

//Function that does the actual hiding of the context-menu.
function doTheHide(){
	if(hide){
		document.getElementById("Rmenu").style.display = 'none';
//		if(menuObject.style)
//			menuObject.style.fontWeight = "";
		hide = false;
	}
}

//The menu Navigation. Opens the clicked page in the right frame.
function n(PageID) {
    var url = '';

	if(gVars.ShowParagraphs == "on"){
        var mode;
        if (gVars.InternalAllID == "editor") mode = '';
        else mode = 'browse';

        if (gVars.IsNewGUI) {
            if (gVars.LinkManagerSettings) {
                for (var p in gVars.LinkManagerSettings) {
                    if (typeof (gVars.LinkManagerSettings[p]) != 'function' && gVars.LinkManagerSettings[p] != null) {
                        url += ('Advanced.' + p + '=' + encodeURIComponent(gVars.LinkManagerSettings[p].toString()) + '&');
                    }
                }

                url = '&' + url.substr(0, url.length - 1);
            }
            if (gVars.InternalItemType) {
                url = '&itemtype=' + gVars.InternalItemType;
            }

            document.getElementById("ParagraphList").src = "Content/ParagraphList.aspx?PageID=" + PageID + "&mode=" + mode + "&caller=" + gVars.InternalAllID + url;
        } else {
            document.getElementById("ParagraphList").src = "Paragraph/Paragraph_List.aspx?ID=" + PageID + "&mode=" + mode + "&caller=" + gVars.InternalAllID;
        }
	}
    else{
        if (gVars.IsNewGUI)
		   window.parent.right.location = "/Admin/Content/ParagraphList.aspx?PageID="+PageID;
		else
		   window.parent.right.location = "Paragraph/Paragraph_List.aspx?ID="+PageID;
	}
}

function restoreLastSelectedPage(){
    n(NewSelectedPageID);
}

//Submits the form when the Area-dropdown is changed
function Area(){
	document.forms.area.submit();
	//location = "menu.aspx"
}

//Closes the menu (or rather hides it) to save space
function closeMenu(value){
    parent.document.getElementById("MainFrame").cols ='22,*';
	//window.cols='22,*';
	document.getElementById("MenuTable").style.display='none';
	document.getElementById("MenuOpen").style.display='';

	if (value == "Search") {
		document.getElementById('SearchClosed').style.display='';
		document.getElementById('NavigationClosed').style.display='none';
	} else {
		document.getElementById('NavigationClosed').style.display='';
		document.getElementById('SearchClosed').style.display='none';
	}
}

//opens the menu (or rather unhides it)
function openMenu(){
    if (gVars.IsNewGUI) parent.document.getElementById("MainFrame").cols ='250,*';
    else parent.document.getElementById("MainFrame").cols ='200,*';

    //window.cols='200,*';
	document.getElementById("MenuTable").style.display='';
	document.getElementById("MenuOpen").style.display='none';
}

//dunno??
function setContentCell(){
	TreeStartHeight = 0;
	if(document.getElementById("TreeStart"))
		TreeStartHeight = document.getElementById("TreeStart").offsetHeight;
	
	TreeEndHeight = 0;
	if(document.getElementById("TreeEnd"))
		TreeEndHeight = document.getElementById("TreeEnd").offsetHeight;
	
	if(document.getElementById("ContentCell")){
		height = document.body.clientHeight;
		document.getElementById("ContentCell").style.height = height - TreeEndHeight - TreeStartHeight-1;
			document.getElementById("SearchBox").style.height = height; // - TreeEndHeight - TreeStartHeight-1;
	}
}


//Shows (unhide) and hides the Searchbox (and does the opposite for the menu)
function ShowSearchBox(){
	if (document.getElementById("SearchBox").style.display != "none") {
		document.getElementById("SearchBox").style.display = "none";
		document.getElementById("TreeBox").style.display = "block";
	}
	else {
		document.getElementById("SearchBox").style.display = "block";
		document.getElementById("TreeBox").style.display = "none";
	}
	setContentCell();
	SetTreeContainerHeight();
}

//Submits the Search-form
function DoSearch(){
	//document.SearchForm.submit();
	document.getElementById('SearchForm').submit();
}

//Dunno
function ToggleShowParagraphs(){
	if (ShowParagraphs){
		window.resizeTo(210, 425);
		window.location.href = 'menu.aspx?ID=' + gVars.SelectedPageID + '&Action=' + gVars.Action + '&Caller=' + gVars.InternalAllID + '&AreaID=' + gVars.AreaID;
		ShowParagraphs = false;
	}
	else{
		window.resizeTo(850, 425);
		window.location.href = 'menu.aspx?ID=' + gVars.SelectedPageID + '&Action=' + gVars.Action + '&Caller=' + gVars.InternalAllID + '&showparagraphs=on&AreaID=' + gVars.AreaID;
		ShowParagraphs = true;
	}
}

//calls the page that moves a paragraph
function MoveParagraph_Exec(DestID){
	window.top.opener.location.href = "Paragraph/Paragraph_Move.aspx?paragraphid=" + gVars.MoveID + "&topage=" + DestID + "&AreaID=" + gVars.AreaID;
	self.close();
}

//calls the page that copies a paragraph
function CopyParagraph_Exec(DestID){
	window.top.opener.location.href = "Paragraph/Paragraph_Copy.aspx?paragraphid=" + gVars.CopyID + "&topage=" + DestID + "&AreaID=" + gVars.AreaID;
	window.self.close();
}

// Opens area in a new window
function previewArea(id) {
    window.open('/Default.aspx?AreaID=' + id, 'PreviewAreaWindow');
}


//Calls page_edit.asp to create at page on the top-menu-level
function NewPage(){
	window.parent.right.location="Page_Edit.aspx?AreaID=" + gVars.AreaID;
}

function PopupWorkflow(title, url)
{
    var dialog = parent.right.pwDialog_wnd;

    if(dialog)
    {
        dialog.set_contentUrl(url);
        dialog.set_title(title);
        dialog.set_width(800);
        dialog.set_height(400);
        dialog.show();
    }
}

function showFolderDialog(url, title) {
    if (parent.right.location.href.indexOf('/Admin/MyPage/default.aspx') == -1) {
        parent.right.location = '/Admin/MyPage/default.aspx';
        setTimeout(function () {
            var dialog = parent.right.getPopUpWindow();
            if (dialog) {
                dialog.set_contentUrl(url);
                dialog.set_title(title);
                dialog.show();
            }
        }, 500);
    } else {
        var dialog = parent.right.getPopUpWindow();
        if (dialog) {
            dialog.set_contentUrl(url);
            dialog.set_title(title);
            dialog.show();
        }
    }            
}

function NewFolder() {
    showFolderDialog("/Admin/Content/FolderEdit.aspx?AreaID=" + gVars.AreaID, MenuTexts['NewFolder']);    
}

//called from the Context-menu. Opens the Page_Edit.asp page in the right frame to add a new Folder as a sub-folder to the selected folder.
function NewSubFolder(ID) {
    showFolderDialog("/Admin/Content/FolderEdit.aspx?AreaID=" + gVars.AreaID + "&ParentFolderID=" + ID, MenuTexts['NewFolder']);    
}

function RenameFolder(id) {
    showFolderDialog("/Admin/Content/FolderEdit.aspx?AreaID=" + gVars.AreaID + "&ID=" + id, MenuTexts['RenameFolder']);    
}

function HideFolderDialog() {
    var dialog = parent.right.getPopUpWindow();
    if (dialog) {
        dialog.hide();
    }
}

function toggleAccordion(accordionAction) {
    window.open('/Admin/Default.aspx?accordionAction=' + accordionAction);
}

//function is used to transfer pageID's from the menu to the Page Rotation module
function AddPage(ID){
	window.top.opener.location = "Page_Rotation_add.aspx?ID=" + gVars.SelectedPageID + "&RotateID=" + ID;
    window.self.close();
}

//called from the Context-menu. pops up a new menu to select the location where to move the selected page.
function movepage(ID) {
	CopyMoveInProcess = 1;
	movepageWindow = window.open("/Admin/menu.aspx?ShowTrashBin=no&MoveID=" + ID + "&Action=Move&AreaID=" + gVars.AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
	hideNow();
}

//Calls the Page_move.asp which actually moves the page.
//Is called from the move->Menu-popup
function movePageTo(ID) {
    var __o = new overlay('wait');
    __o.message('');
    __o.show();
    $('menucontainerdiv').hide();
    $('wait').setStyle("{background-color: white}");
    $('wait').setStyle("{height: 100%}");
    $('wait').visible();
	location = "/Admin/Page_move.aspx?ID=" + ID + "&AreaID=" + gVars.AreaID + "&MoveID=" + gVars.MoveID;
}

//Calls the Page_RestoreTo.aspx which actually restores the page to a new place
//Is called on behalf of TrashBin
function restorePageTo(ID){
	location = "/Admin/Page_RestoreTo.aspx?ID=" + ID + "&AreaID=" + gVars.AreaID + "&MoveID=" + gVars.MoveID;
}

//Calls the Paragraph_RestoreTo.aspx which actually restores the paragraph to a new place
//Is called on behalf of TrashBin
function restoreParagraphTo(ID){
	location = "/Admin/Paragraph/Paragraph_RestoreTo.aspx?topage=" + ID + "&AreaID=" + gVars.AreaID + "&paragraphid="+gVars.MoveID;
}


//called from the Context-menu. pops up a new menu to select the location where to copy the selected page.
function copypage(ID) {
	CopyMoveInProcess = 1

	CopypageWindow = window.open("/Admin/menu.aspx?ShowTrashBin=no&CopyID=" + ID + "&Action=Copy&AreaID=" + gVars.AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
	hideNow();
}

//Calls the Page_copy.asp which actually copies the page.
//Is called from the Copy->Menu-popup
function copyPageTo(ID, copyHere)
{
    if(copyHere)
    {
        var self = this;

        new Ajax.Request('/Admin/Page_Copy.aspx?ID=' + ID + '&AreaID=' + gVars.AreaID + "&CopyID=" + gVars.CopyID + '&CopyHere=true',
            {
                method: 'get',
                parameters: {},
                onComplete: function (response)
                {
                    var vals, obj;
                    
                    try {
                        obj = JSON.parse(response.responseText);

                        if (obj.error) {
                            alert(obj.error);
                            return;
                        }
                    } catch (e) {
                        vals = response.responseText.split(',');
                    }

                    self.setAreaID(vals[0]);
                    self.setAreaDropDown(vals[0])
                    self.MoveMenuEntry(vals[1]);
                    self.SetPageCount(vals[2]);
                    self.pageOptionsControl(vals[1], vals[3], vals[4]);
                    self.location = '/Admin/Menu.aspx?ID=' + vals[1] + '&AreaID=' + vals[0];
                }
            });
    }
    else
    {
        var __o = new overlay('wait');
        __o.message('');
        __o.show();
        $('menucontainerdiv').hide();
        $('wait').setStyle("{background-color: white}");
        $('wait').setStyle("{height: 100%}");
        $('wait').visible();

        location = "/Admin/Page_Copy.aspx?ID=" + ID + "&AreaID=" + gVars.AreaID + "&CopyID=" + gVars.CopyID;
    }
}

//dunno??
function showparagraphs(ID){
	window.parent.right.location = "/Admin/Paragraph/Paragraph_List.aspx?ID="+ID;
	hideNow();
}

//called from the Context-menu. pops up the select page in a new window to preview it.
function previewpage(ID) {
    window.open("/Default.aspx?ID=" + ID + "&Purge=True");
    
	hideNow();
}

function preview(ID){
	window.open("/Default.aspx?ID=" + ID + "&Preview=" + ID, "_blank", "");
	hideNow();
}

function previewProfile(pageID){
    var URL = "/Admin/Module/Omc/Profiles/PreviewProfile.aspx?PageID=" + pageID + "&original=%2FDefault.aspx%3FID%3D" + pageID + "%26Purge%3DTrue";
	window.open(URL, "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no");
}

//called from the Context-menu. opens the Page_edit in the right frame to edit the select page.
function editpage(ID){
	window.parent.right.location = "/Admin/Page_Edit.aspx?ID="+ID;
	hideNow();
}

//called from the Context-menu. Opens the Paragraph_Edit.asp page in the right frame to add a new Paragraph to the selected page.
function newparagraph(ID){
	window.parent.right.location = "/Admin/Paragraph/Paragraph_Edit.aspx?PageID="+ID;
	hideNow();
}

//called from the Context-menu. Opens the Page_Edit.asp page in the right frame to add a new Page as a sub-page to the selected page.
function newsubpage(ID){
	window.parent.right.location = "/Admin/Page_Edit.aspx?AreaID=" + gVars.AreaID + "&uID=" + ID;
	hideNow();
}

//popup a Confirm box. On "Yes" it deletes the page and all subpages via the Page_delete.asp file.
//The function gets called from the Context-menu
function deletepage(ID, isFolder){
	var PageName = "";
	if(document.getElementById("text_"+ID)){
		PageName = document.getElementById("text_"+ID).innerHTML;
		var tr = /<[^>]+>/ig;
		PageName = PageName.replace(tr, "");
	}
	hideNow();

	var msg = MenuTexts['DeletePage'] + "\n(" + PageName + ")\n\n" + MenuTexts['Warning'] + "\n" + MenuTexts['AllPagesWillDeleted'];
	if (isFolder){
	    msg = MenuTexts['DeleteFolder'] + "\n(" + PageName + ")\n\n" + MenuTexts['Warning'] + "\n" + MenuTexts['AllPagesWillDeleted'];
	}

    var url = "/Admin/Page_Delete.aspx";

        new Ajax.Request(url, {
            method: 'get',
            parameters: {
                ID: ID,
                AreaID: gVars.AreaID,
                PageName: PageName,
                IsFolder: isFolder,
                ValidationNeeded: true,
                Nocache: new Date().getTime()
            },
            onSuccess: function (transport) {
                var responseJSON = transport.responseJSON; 
                if (responseJSON) {
                    if (responseJSON.globalParagraphFlag) {
                        msg += "\n\n" + MenuTexts['Notice'] + "\n" + responseJSON.msg;
                    }
                    else {
                        msg = "\n" + MenuTexts['Warning'] + "\n" + responseJSON.msg;
                    }
                    if (confirm(msg)) {
                        window.parent.right.location = "/Admin/Page_Delete.aspx?ID=" + ID + "&AreaID=" + gVars.AreaID + "&PageName=" + encodeURIComponent(PageName) + "&DeletePage=" + true + (responseJSON.removeEmailFlag ? "&RemoveEmailForignKeys=true" : "");
                    }
                }
                else{
                    if(confirm(msg)){
                        window.parent.right.location = "/Admin/Page_Delete.aspx?ID=" + ID + "&AreaID=" + gVars.AreaID + "&PageName=" + encodeURIComponent(PageName) + "&DeletePage=" + true;
                    }
                }
            } 
        });
}

//called from the Context-menu. Opens the Menu_sort.asp page in the right frame to enable the user to sort the select menu-level 
//(in which the current select page exists).
function SortPages(ParentPageID){ 
    var allowSorting = true;
    if(gVars.ShowSortingWarning && gVars.SortingWarning != null && gVars.SortingWarning != '' && !confirm(gVars.SortingWarning))        
        allowSorting = false;

    if(allowSorting){
	    if(intPrevID) {
		    if(document.getElementById(intPrevID)) 
                document.getElementById(intPrevID).style.fontWeight="";
	    }

	    document.getElementById("Sort_"+ParentPageID).style.fontWeight = "bold";
	    intPrevID = document.getElementById("Sort_" + ParentPageID).id;  // make "sorter" the previd for later unbold

	    var returnTo = PreviousPageID;
	    if (returnTo === 0) {
	        returnTo = NewSelectedPageID;
	    }

	    window.parent.right.location = "Menu_Sort.aspx?ParentPageID=" + ParentPageID + "&AreaID=" + gVars.AreaID + "&SelectedPageID=" + returnTo;
    }
}

function ShowTrashBin(){
  window.parent.right.location = "TrashBin/TrashBinForm.aspx";
}

function Optimize(ID){
	window.open("/Admin/Module/Seo/AnalyzePage.aspx?ID=" + ID, "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,width=900,height=700,top=55,left=55");
}

function internal(ID, Name, ItemType) {
    var callerEl, storageEl, op, opLoc, opId, obj, attr, setValue, getValue, callbackFunc, callbackResponse;
    op = window.top.opener;

    if (($$(gVars.InternalCallback) && $$(gVars.InternalCallback).length > 0) || 
        (gVars.InternalCallback != null && (gVars.InternalCallback == true || gVars.InternalCallback.toString().toLowerCase() == "true"))) {
        // RunCallbackFunction should be defined by the caller:
        // var win = window.open('/Admin/Menu.aspx?Action=Internal&Callback=True');
        // win.RunCallbackFunction = function() {...};  
        RunCallbackFunction("Default.aspx?ID=" + ID, Name);
    }
    else {
        callerEl = window.top.opener.document.getElementById("Link_" + gVars.InternalAllID);
        storageEl = op.document.getElementById(gVars.InternalAllID);

        if (callerEl && storageEl) {
            callerEl.value = Name;
            storageEl.value = "Default.aspx?ID=" + ID;

            //Raise onchange event only for smart search link selector ctrl
            try {

                attr = callerEl.getAttributeNode("smartsearchctrl");
                if (attr && attr.value == "true" && callerEl.onchange) {
                    callerEl.onchange();
                }
            } catch(e) {
            }
            ;

            if (gVars.InternalAllID == 'lmEmailPage' || gVars.InternalAllID == 'lmVariantEmailPage') {
                window.top.opener.OMC.EditEmail.prototype.CheckLinkedPage(null, gVars.InternalAllID);
            }

            if (gVars.InternalAllID == 'DefaultLink') {
                window.top.opener.OMC.MessageEdit.prototype.CheckInternalLink(storageEl.value);
            }

            opLoc = _readAttribute(callerEl, 'data-opener-location');

            if (opLoc && opLoc === 'omc-leads') {
                opId = _readAttribute(callerEl, 'data-opener-id');
                obj = op.OMC.MasterPage.get_current().get_contentWindow();
                if (opId && obj && obj[opId]) {
                    obj[opId].onPageSelect({ el: callerEl, AreaID: gVars.AreaID, PageID: ID });
                }
            }
            // for manually opening
        }
        if (storageEl) {
            callbackFunc = _readAttribute(storageEl, 'data-opener-callback');
            if (callbackFunc && op[callbackFunc] && typeof (op[callbackFunc]) === 'function') {
                op[callbackFunc]({
                    pageID: ID,
                    pageName: Name,
                    areaID: gVars.AreaID,
                    areaName: gVars.AreaName
                });
            } else if (storageEl.onchange) {
                _writeAttribute(storageEl, 'data-page-id', ID);
                _writeAttribute(storageEl, 'data-page-name', Name);
                _writeAttribute(storageEl, 'data-page-itemtype', ItemType);
                _writeAttribute(storageEl, 'data-area-id', gVars.AreaID);
                _writeAttribute(storageEl, 'data-area-name', gVars.AreaName);

                callbackResponse = storageEl.onchange.apply(storageEl);
            }
        }
    }

    if (callbackResponse == null || callbackResponse.closeMenu == null || callbackResponse.closeMenu == true) {
        window.self.close();
    }
}

function internalNewEditor(ID, Name){
	if(window.top.opener.document.getElementById("txtLnkUrl")){
		window.top.opener.document.getElementById("txtLnkUrl").value = "Default.aspx?ID=" + ID;
		window.self.close();
	}else{
		window.top.opener.document.getElementById("txtUrl").value = "Default.aspx?ID=" + ID;
		window.top.opener.document.getElementById("cmbLinkProtocol").selectedIndex = 4;
		window.self.close();
	}
}

var intPrevID;
function MakeBold(objText) {
	if(intPrevID) {
		if(document.getElementById(intPrevID))
            document.getElementById(intPrevID).style.fontWeight="";
	}

	if(objText){
		objText.style.fontWeight="bold";
		intPrevID = objText.id
	}
}

//Generate the actual menu-entry/menu-level
function getMenu(MenuEntry, PageParentPageID, move){
	var ImgWidth = 0;
	var objPage = new Object();
	var imgWidth = 0;
	var copyID = parseInt(gVars.CopyID);
	var menuActivatorCallback = '';
	var mouseUpHandler = '';
	var templatesRoot = false;
	var hasTemplateNode = false;
    var hasAccessToArea = document.getElementById("MenuData").contentWindow.hasAccessToArea;
	MenuEntry = "";

	CopyMoveAllowed = true;
	
	if(document.getElementById(PageParentPageID)) {
		strCurrentName = document.getElementById(PageParentPageID).Name + ", ";
        if (gVars.Action == "MoveParagraph" && gVars.MoveFromPageID == PageParentPageID) {
			CopyMoveAllowed = false
		} else {
			strMoveName = ", " + gVars.CopyID + ", " + gVars.MoveID + ", ";
			if(strCurrentName.search(strMoveName) > -1 && gVars.Action != "MoveParagraph")
				CopyMoveAllowed = false
		}
	}
	
	varSortAccess = false;	

	for (i=0; i < document.getElementById("MenuData").contentWindow.MenuJSArray[0].length - 1; i++) { 
		if ((document.getElementById("MenuData").contentWindow.MenuJSArray[15][i] == "True") || (document.getElementById("MenuData").contentWindow.MenuJSArray[15][i] == "true") || (document.getElementById("MenuData").contentWindow.MenuJSArray[15][i] == 1) || (document.getElementById("MenuData").contentWindow.MenuJSArray[15][i] == "1")) {
		    varSortAccess = true;
		}		
		MenuEntry +="<div nowrap class='myMenu' ID='" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "'";
		if(document.getElementById(PageParentPageID)) {
			MenuEntry += ' Name="' + document.getElementById(PageParentPageID).Name + ', ' + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + '" ';
		} else {
			MenuEntry += ' Name=", ' + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + '" ';
		}
		MenuEntry += ">";
		if (PageParentPageID > 0) {
			var objSpaceImg;
			if (document.getElementById) objSpaceImg = document.getElementById("spaceIMG_" + PageParentPageID);
			else objSpaceImg = document.images["spaceIMG_" + PageParentPageID];

			if(objSpaceImg) imgWidth = parseInt(objSpaceImg.getAttribute("width"))+15;
			else imgWidth = 0;

			document.getElementById("toggle_" + PageParentPageID).setAttribute("src", "images/Expand_off.gif")
			document.getElementById("toggle_" + PageParentPageID).setAttribute("onclick", "hideSpan(" + PageParentPageID + ");")
			document.getElementById("toggle_" + PageParentPageID).setAttribute("class", "H")
			document.getElementById("toggle_" + PageParentPageID).outerHTML = document.getElementById("toggle_" + PageParentPageID).outerHTML
			strHtml = getOuterHTML("text_" + PageParentPageID);
			
			if(gVars.Action == "")	{
				if(strHtml.search('oncontextmenu="setRightClick') > -1)
					document.getElementById("text_" + PageParentPageID).setAttribute("onclick", "n(" + PageParentPageID + ");MakeBold(this);");
			}
			else if(gVars.Action != "AddPageUserManagement" && gVars.Action != "Internal") {
				document.getElementById("text_" + PageParentPageID).setAttribute("onclick", "");
			}
			document.getElementById("text_" + PageParentPageID).outerHTML = document.getElementById("text_" + PageParentPageID).outerHTML;
		}
		MenuEntry +="<img name='spaceIMG_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' src='images/nothing.gif' ID='spaceIMG_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' width='" + imgWidth + "' height='13'> ";
        
		if (document.getElementById("MenuData").contentWindow.MenuJSArray[4][i] > 0 || (gVars.Action == "Move"  && CopyMoveAllowed)
		    || (gVars.Action == "Copy" && copyID != document.getElementById("MenuData").contentWindow.MenuJSArray[0][i]) 
            || gVars.Action == "MoveParagraph" || gVars.Action == "CopyParagraph" || gVars.Action == "RestoreTo" || gVars.Action == "RestoreParagraphTo"){		    
		    MenuEntry += "<img class='H' onclick='toggleNode(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ",0);' src='images/Expand.gif' ID='toggle_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' width='9' height='13'> ";		    
		}
		else{
		    MenuEntry += "<img ID='toggle_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "'src='images/nothing.gif' name='img_1' width='9' height='13'> ";
		}
		//'*** Find Icon and style ****
        if (gVars.IsNewGUI) objPage.PageImg = "Page_closedNew";
        else objPage.PageImg = "Page_closed"

		//objPage.PageImg		= "Page_closed";
		objPage.style		= "";
		objPage.styleImg	= "";
		setupPageIcon(objPage, i);
		//'*** End Icon and style ***
		if (gVars.Action == "AddPageUserManagement") {
		    MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='AddPageUserManagement(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			MenuEntry +=document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}
        else if (gVars.Action == "AddPage") {
            MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='AddPage(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
            MenuEntry += document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}
        else if (gVars.Action == "InternalEditContent") {
            var MenuName = document.getElementById("MenuData").contentWindow.MenuJSArray[5][i];
			var re = /\'/g;
			MenuName = MenuName.replace(re,"");
            var MenuNameEscaped=MenuName;
            
            while( MenuNameEscaped!=MenuNameEscaped.replace("&quot;","\\\"")){
                MenuNameEscaped=MenuNameEscaped.replace("&quot;","\\\"");
            }

            MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='toggleEditContent(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ",0," + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ", " + '"' + MenuNameEscaped + '"' + ");MakeBold(this);n(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			MenuEntry +=document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}
		else if (gVars.ShowParagraphs == "on") {
		    MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='toggleNode(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ",0);MakeBold(this);n(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			MenuEntry +=document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}
		else if (gVars.Action == "Internal") {
			var MenuName = document.getElementById("MenuData").contentWindow.MenuJSArray[5][i];
			var re = /\'/g;
			MenuName = MenuName.replace(re,"");
            var MenuNameEscaped=MenuName;
            while( MenuNameEscaped!=MenuNameEscaped.replace("&quot;","\\\"")){
                MenuNameEscaped=MenuNameEscaped.replace("&quot;","\\\"");
            }

            if (gVars.LinkManagerSettings == null || !gVars.LinkManagerSettings.ItemsOnly || document.getElementById("MenuData").contentWindow.MenuJSArray[19][i] != "") {
                MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='internal(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ", " + '"' + MenuNameEscaped + '","' + document.getElementById("MenuData").contentWindow.MenuJSArray[19][i] + '"' + ");'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
            } else {
                MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H'  style='color:#aaaaaa;'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
            }

            MenuEntry += document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
        }
		else if (gVars.Action == "InternalEcom") {
			var MenuName = MenuData.MenuJSArray[5][i];
			var re = /\'/g;
			MenuName = MenuName.replace(re,"");

			MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='internalEcom(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ", " + '"' + MenuName + '"' + ");'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			MenuEntry +=document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}		
		else if (gVars.Action == "InternalNewEditor") {
			var MenuName = document.getElementById("MenuData").contentWindow.MenuJSArray[5][i];
			var re = /\'/g;
			MenuName = MenuName.replace(re,"");

			MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='internalNewEditor(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ", " + '"' + MenuName + '"' + ");'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			MenuEntry +=document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}
		else if (gVars.Action != "") {
            if ((document.getElementById("MenuData").contentWindow.MenuJSArray[15][i] == "False") && (["Move", "Copy", "MoveParagraph", "CopyParagraph", "RestoreTo", "RestoreParagraphTo"].indexOf(gVars.Action) > -1))
                MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H'  style='color:#aaaaaa;'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			else
			    MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onclick='toggleNode(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ",0);MakeBold(this);'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			MenuEntry +=document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}

		/*
		else if ((document.getElementById("MenuData").contentWindow.MenuJSArray[14][i] == "False")) {
			MenuEntry +="<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H'  style='color:#aaaaaa;'>"  + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			MenuEntry +=document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}*/
		else if ((document.getElementById("MenuData").contentWindow.MenuJSArray[15][i] == "False") || (document.getElementById("MenuData").contentWindow.MenuJSArray[15][i] == "false")) {
		    MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H'  style='color:#aaaaaa;'>" + "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1'>";
			MenuEntry +=document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span>";
		}
		else {
		    
		    templatesRoot = isPageTemplatesRoot(i);
		    menuActivatorCallback = 'MenuActivator(' + document.getElementById('MenuData').contentWindow.MenuJSArray[0][i] + ',null,this,' + templatesRoot.toString().toLowerCase() + ');';
		    
		    if(!templatesRoot) {
		        mouseUpHandler = 'this.style.fontWeight="bold";';
		        if(!hasTemplateNode) {
		            hasTemplateNode = isPageTemplate(i);
		        }
		    } else {
		        mouseUpHandler = '';
		    }

		    //check if it is Folder
		    if ((document.getElementById("MenuData").contentWindow.MenuJSArray[24][i] == "True") || (document.getElementById("MenuData").contentWindow.MenuJSArray[24][i] == "true") || (document.getElementById("MenuData").contentWindow.MenuJSArray[24][i] == 1) || (document.getElementById("MenuData").contentWindow.MenuJSArray[24][i] == "1")) {
		        MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H mnuDrag' onMouseUp='" + mouseUpHandler + "' onmouseout='hl(this);MenuActivator(null,null,null);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");" + menuActivatorCallback + "' " + objPage.style + " onclick='toggleNode(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ",0);MakeBold(this);'>";
		    }
		    else {
		        MenuEntry += "<span ID='text_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H mnuDrag' onMouseUp='" + mouseUpHandler + "' onmouseout='hl(this);MenuActivator(null,null,null);' onmouseover='hl(this, " + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");" + menuActivatorCallback + "' " + objPage.style + " onclick='toggleNode(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ",0);MakeBold(this);n(" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");'>";
		    }		    			
			MenuEntry += "<img " + objPage.styleImg + " src='" + objPage.PageImg + "' align='absMiddle' name='fol_1' class=\"dragHandler\">";
			MenuEntry += "<span class=\"\">" + document.getElementById("MenuData").contentWindow.MenuJSArray[5][i] + "</span></span>";
		}
		MenuEntry +="</div><span style='' ID='" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "_Childs'></span>";
	}

	if((document.getElementById("MenuData").contentWindow.MenuJSArray[0].length- 1 == 0) && (document.getElementById("toggle_" + PageParentPageID)) 
        && ((gVars.Action == "Move"  && CopyMoveAllowed) || (gVars.Action == "Copy" && copyID != PageParentPageID) 
            || gVars.Action == "MoveParagraph" || gVars.Action == "CopyParagraph" || gVars.Action == "RestoreTo" || gVars.Action == "RestoreParagraphTo")) {

	    var objSpaceImg;
	    if (document.getElementById) objSpaceImg = document.getElementById("spaceIMG_" + PageParentPageID);
		else objSpaceImg = document.images["spaceIMG_" + PageParentPageID];

		if(objSpaceImg) imgWidth = parseInt(objSpaceImg.getAttribute("width"))+15;
		else imgWidth = 0

		//imgWidth = document.getElementById("spaceIMG_" + PageParentPageID).getAttribute("width") + 15;
		document.getElementById("toggle_" + PageParentPageID).setAttribute("src", "images/Expand_off.gif");
		document.getElementById("toggle_" + PageParentPageID).setAttribute("onclick", "hideSpan(" + PageParentPageID + ");");
		document.getElementById("toggle_" + PageParentPageID).outerHTML = document.getElementById("toggle_" + PageParentPageID).outerHTML;
		if(gVars.Action == "AddPageUserManagement") document.getElementById("text_" + PageParentPageID).setAttribute("onclick", "n(" + PageParentPageID + ");");
		document.getElementById("text_" + PageParentPageID).outerHTML = document.getElementById("text_" + PageParentPageID).outerHTML;
	}
	
	if(!hasTemplateNode) {
        if ((gVars.Action == "" && gVars.IsCreateLightVersionPages && gVars.IsAllowNewPages)
            && (hasAccessToArea && (document.getElementById("MenuData").contentWindow.MenuJSArray[0].length>1 || PageParentPageID==0))) {
			    objPage.style		= "";
			    MenuEntry +="<div nowrap class='myMenu' ID='" + PageParentPageID + "'>";
			    MenuEntry +="<img src='images/nothing.gif' ID='spaceIMG_" + PageParentPageID + "' width='" + imgWidth + "' height='13'> "
			    MenuEntry +="<img src='images/nothing.gif' name='img_1' width='9' height='13'> "
			    MenuEntry +="<span ID='Newpage_" + PageParentPageID + "' class='H pagef' onmouseout='MenuActivator(null,null,null);this.style.textDecoration=" + '""' + ";' onmouseover='this.style.textDecoration=" + '" underline"' + ";MenuActivator(0,null,null);' " + objPage.style + " onClick='newsubpage(" + '"' + PageParentPageID + '"' + ");'>"
			    MenuEntry +="<img src='/Admin/Images/Ribbon/Icons/Small/AddDocument.png' align='absMiddle' name='fol_1'>"
			    MenuEntry += MenuTexts['NewPage'] + "</span>"
        }
	}

    var allowSorting = false;
    if (!hasAccessToArea){
        // don't add any modification command to tree if we don't have access
        allowSorting = true;
    }
    else if(gVars.Action == "Move" && CopyMoveAllowed) {
		if(!PageParentPageID) {
			PageParentPageID = 0;
		}
				
		MenuEntry +="<div nowrap class='myMenu' ID='" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "'>";
		MenuEntry +="<span ID='move_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='movePageTo(" + PageParentPageID + ");'>";
		MenuEntry +="<img src='images/nothing.gif' ID='spaceIMG_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' width='" + (imgWidth - 2) + "' height='13'> ";
		MenuEntry +="<img src='Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'> ";
		MenuEntry += MenuTexts['MoveHere'] + "</span>";
	}
	else if(gVars.Action == "Copy") {
		if(!PageParentPageID) {
			PageParentPageID = 0;
		}
		
		if(copyID != PageParentPageID) {
		    MenuEntry +="<div nowrap class='myMenu' ID='" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "'>";
		    MenuEntry +="<span ID='move_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='copyPageTo(" + '"' + PageParentPageID + '"' + ");'>";
		    MenuEntry +="<img src='images/nothing.gif' ID='spaceIMG_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' width='" + (imgWidth - 2) + "' height='13'> ";
		    MenuEntry +="<img src='Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'> ";
		    MenuEntry += MenuTexts['CopyHere'] + "</span>";
		}
	}
	else if(gVars.Action == "RestoreTo") {
		if(!PageParentPageID) {
			PageParentPageID = 0;
		}
		MenuEntry +="<div nowrap class='myMenu' ID='" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "'>";
		MenuEntry +="<span ID='move_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='restorePageTo(" + '"' + PageParentPageID + '"' + ");'>";
		MenuEntry +="<img src='images/nothing.gif' ID='spaceIMG_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' width='" + (imgWidth - 2) + "' height='13'> ";
		MenuEntry +="<img src='Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'> ";
		MenuEntry += MenuTexts['RestoreTo'] + "</span>";
	}
	else if(gVars.Action == "RestoreParagraphTo") {
		if (PageParentPageID > 0) {
		    MenuEntry +="<div nowrap class='myMenu' ID='" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "'>";
		    MenuEntry +="<span ID='move_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='restoreParagraphTo(" + '"' + PageParentPageID + '"' + ");'>";
		    MenuEntry +="<img src='images/nothing.gif' ID='spaceIMG_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' width='" + (imgWidth - 2) + "' height='13'> ";
		    MenuEntry +="<img src='Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'> ";
		    MenuEntry += MenuTexts['RestoreTo'] + "</span>";
	    }
	}
	else if(gVars.Action == "MoveParagraph" && CopyMoveAllowed) {
		if (PageParentPageID > 0) {
			MenuEntry +="<div nowrap class='myMenu' ID='" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "'>";
			MenuEntry +="<span ID='move_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='MoveParagraph_Exec(" + '"' + PageParentPageID + '"' + ");'>";
			MenuEntry +="<img src='images/nothing.gif' ID='spaceIMG_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' width='" + (imgWidth - 2) + "' height='13'> ";
			MenuEntry +="<img src='Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'>";
			MenuEntry += MenuTexts['MoveHere'] + "</span>";
		}
	}
	else if(gVars.Action == "CopyParagraph") {
		if (PageParentPageID > 0) {
			MenuEntry +="<div nowrap class='myMenu' ID='" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "'>";
			MenuEntry +="<span ID='move_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' class='H' onmouseout='hl(this);' onmouseover='hl(this, 0" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + ");' " + objPage.style + " onClick='CopyParagraph_Exec(" + '"' + PageParentPageID + '"' + ");'>";
			MenuEntry +="<img src='images/nothing.gif' ID='spaceIMG_" + document.getElementById("MenuData").contentWindow.MenuJSArray[0][i] + "' width='" + (imgWidth - 2) + "' height='13'> ";
			MenuEntry +="<img src='Images/Icons/Page_MoveTo.gif' align='absMiddle' name='fol_1'>";
			MenuEntry += MenuTexts['CopyHere'] + "</span>";
			}
		}
	else if(gVars.Action == "AddPageUserManagement" || gVars.Action == "AddPage" || gVars.Action == "Internal"  || CopyMoveAllowed == false)	{
	}
	else {
        allowSorting = true;
    }
    
    if(varSortAccess && allowSorting){
		if(!PageParentPageID) PageParentPageID = 0;
        objPage.style	= "";

		if(document.getElementById("MenuData").contentWindow.MenuJSArray[0].length > 2 
            && (gVars.Action != "InternalEcom" && gVars.IsAllowNewPages)) {
			MenuEntry +="<div nowrap class='myMenu' ID='" + PageParentPageID + "'>";
			MenuEntry +="<img src='images/nothing.gif' ID='spaceIMG_" + PageParentPageID + "' width='" + imgWidth + "' height='13'> "
			MenuEntry +="<img src='images/nothing.gif' name='img_1' width='9' height='13'> "
			MenuEntry +="<span ID='Sort_" + PageParentPageID + "' class='H pagef' onmouseout='MenuActivator(null,null,null);this.style.textDecoration=" + '""' + ";' onmouseover='this.style.textDecoration=" + '" underline"' + ";MenuActivator(0,null,null);' " + objPage.style + " onClick='SortPages(" + '"' + PageParentPageID + '"' + ");'>"
			MenuEntry +="<img src='Images/Icons/Page_Sort.gif' align='absMiddle' name='fol_1'>"
			MenuEntry += MenuTexts['Sort'] + "</span>"
		}
	}
	
	return MenuEntry;
}

function isPageTemplatesRoot(i) {
    var ret = false;
    var data = null;
    var frame = document.getElementById('MenuData');
    
    if(frame) {
        data = frame.contentWindow.MenuJSArray;
        if(data) ret = data[16][i] == '2';
    }
    
    return ret;
}

function isPageTemplate(i) {
    var ret = false;
    var data = null;
    var frame = document.getElementById('MenuData');
    
    if(frame) {
        data = frame.contentWindow.MenuJSArray;
        if(data) ret = data[16][i] != '0' && data[16][i] != '2';
    }
    
    return ret;
}

var xhttp = false;
function getXHTTPObject() {     
	if (window.ActiveXObject) {  
        try {  
			// IE 6 and higher 
			xhttp = new ActiveXObject("MSXML2.XMLHTTP"); 
			xhttp.onreadystatechange=getParameters_callback; 
        } catch (e) { 
            try { 
                // IE 5 
                xhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
				xhttp.onreadystatechange=getParameters_callback; 
            } catch (e) { 
                xhttp=false; 
            } 
        } 
	} 
    else if (window.XMLHttpRequest) { 
        try { 
            // Mozilla, Opera, Safari ... 
            xhttp = new XMLHttpRequest();
            /* little hack */
            xhttp.onreadystatechange = function () {
				getParameters_callback();
			};

        } catch (e) { 
            xhttp=false;
        } 
    } 
}

function getParameters_callback() {
    var value;                 
    if (xhttp.readyState == 4) {
		if(xhttp.status==200) {
			try {
				value = xhttp.responseText
				execScripts(parameterdiv.innerHTML);
			} catch(e) {
				/*alert('exception' + e);*/
				/*parameterdiv.innerHTML = "Error in AJAX" + e.Message;*/
			}
		}
    }

    return value;
}		
		
function getAjaxPage(url) {
	getXHTTPObject();
	
	if (!xhttp) { 
        return; 
    } 
	
	/* lets get data */
	xhttp.open("GET", url, false);
	xhttp.setRequestHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    xhttp.send(null);
    
    return xhttp.responseText;
}


function getNumberOfPages(){
    var xmlHttp;
     
    try{
        xmlHttp=new XMLHttpRequest();
    }catch (e){
        try{
            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e){
            try{
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e){
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }

    // needs an absolute URL (Firefox problems with relative URL);
    var url = window.location.protocol + "//" + window.location.hostname + ":" + window.location.port + "/Admin/MenuData.aspx?GetPageCount=true&CacheKiller=" + new Date().getTime();
    
    xmlHttp.open("GET", url, false);
    xmlHttp.setRequestHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    xmlHttp.send(null);
   
    // Doesn't need a callback function when using sync requests
    if (xmlHttp.readyState == 4)
        return xmlHttp.responseText;
    else
        return 0;
}

function pageOptionsControl(pageID, cmd, oldPageState)
{
    if(oldPageState === "")
        top.right.location = '/Admin/Content/ParagraphList.aspx?PageID=' + pageID + '&cmd=' + cmd;
    else
        top.right.location = '/Admin/Content/ParagraphList.aspx?PageID=' + pageID + '&cmd=' + cmd + '&oldPageState=' + oldPageState;
}

function _writeAttribute(element, name, value) {
    element.setAttribute(name, value);
}

function _readAttribute(element, name) { 
    return (!element.attributes || !element.attributes[name]) ? '' :
             element.attributes[name].value;
}