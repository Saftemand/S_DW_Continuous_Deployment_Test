//
// Frontend editing
//
// News frontend edit


function FrontendNews_Mouseover(Hwnd) {
	var MouseoverStyle	= "cursor: hand";
	Hwnd.style.cssText	= MouseoverStyle;
	//window.status		= "Rediger nyhed...";

	Hwnd.parentElement.style.position	= "relative";
	Hwnd.parentElement.appendChild(document.getElementById('FrontendNewsEditMenu'))
	objNewsEditMenu = document.getElementById('FrontendNewsEditMenu')
	objNewsEditMenu.style.position	= "absolute";
	objNewsEditMenu.style.top		= "8px";
	objNewsEditMenu.style.left		= "8px";
	objNewsEditMenu.style.display	= "";

	FrontendMenuActive = false;
	Frontend_Mouseout();
		
}
//function FrontendNews_Mouseout(Hwnd) {
function FrontendNews_Mouseout() {
	if (!FrontendNewsMenuActive) {
		var MouseoutStyle	= "cursor: default";
		//Hwnd.style.cssText	= MouseoutStyle;
		window.status		= "";

		document.getElementById('FrontendNewsEditMenu').style.display	= "none";
	}
}

function Frontend_NewNews(pageid) {
    if(_newsContext == 'news')
	    window.open("/admin/Module/News/News_Module_Edit.aspx?CategoryID=" + FrontendNewsGroupIDs + "&source=frontend","_blank",Frontend_NewsWindowFeatures);
	else 
	    window.open("/Admin/Module/NewsV2/News_edit.aspx?categoryID=" + FrontendNewsGroupIDs + "&frontend=true","_blank", Frontend_NewsWindowFeatures);
}

function Frontend_EditNews(CurrentID, GroupID) {
    if(_newsContext == 'news')
	    window.open("/admin/Module/News/News_Module_Edit.aspx?CategoryID=" + FrontendNewsGroupID + "&NewsID=" + FrontendNewsCurrentID + "&source=frontend","_blank",Frontend_NewsWindowFeatures);
	else 
	    window.open("/Admin/Module/NewsV2/News_edit.aspx?categoryID=" + FrontendNewsGroupID + "&ID=" + FrontendNewsCurrentID + "&frontend=true","_blank", Frontend_NewsWindowFeatures);
}

function Frontend_DelNews(paragraphid, text) {
	if (confirm(text) == true) {
	    if(_newsContext == 'news')
		    window.open("/admin/Module/News/News_Module_Del.aspx?CategoryID=" + FrontendNewsGroupID + "&NewsID=" + FrontendNewsCurrentID + "&source=frontend","_blank","location=no, menubar=no, status=yes, resizable=no, toolbar=no, width=10, height=10");
		else 
		    window.open("/admin/Module/NewsV2/News_delete.aspx?ID=" + FrontendNewsCurrentID + "&frontend=true","_blank","location=no, menubar=no, status=yes, resizable=no, toolbar=no, width=10, height=10");
	}
}

// Default frontend edit
function Frontend_Mouseover(Hwnd) {

	var MouseoverStyle	= "cursor: hand";
	Hwnd.style.cssText	= MouseoverStyle;
	//window.status		= "Rediger afsnit...";

	Hwnd.parentElement.style.position	= "relative";
	Hwnd.parentElement.appendChild(document.getElementById('FrontendEditMenu'))
	document.getElementById('FrontendEditMenu').style.position	= "absolute";
	document.getElementById('FrontendEditMenu').style.top		= "8px";
	document.getElementById('FrontendEditMenu').style.left		= "8px";
	document.getElementById('FrontendEditMenu').style.display	= "";
	
	FrontendNewsMenuActive = false;
	FrontendNews_Mouseout();
}

//function Frontend_Mouseout(Hwnd) {
function Frontend_Mouseout() {
	if (!FrontendMenuActive) {
		var MouseoutStyle	= "cursor: default";
		//Hwnd.style.cssText	= MouseoutStyle;
		window.status		= "";

		document.getElementById('FrontendEditMenu').style.display	= "none";
	}
}

function Frontend_NewParagraph(pageid) {
	window.open("/admin/paragraph/paragraph_edit.aspx?source=frontend&pageid=" + pageid,"_blank",Frontend_WindowFeatures);
}

function Frontend_EditParagraph(paragraphid, pageid) {
	window.open("/admin/paragraph/paragraph_edit.aspx?source=frontend&id=" + paragraphid + "&pageid=" + pageid,"_blank",Frontend_WindowFeatures);
}

function Frontend_DelParagraph(paragraphid, text) {
	if (confirm(text) == true) {
		window.open("/admin/paragraph/paragraph_delete.aspx?source=frontend&id=" + paragraphid,"_blank","location=no, menubar=no, status=yes, resizable=no, toolbar=no, width=10, height=10");
	}
}

function Frontend_Help() {
	window.open('http://manual.net.dynamicweb.dk/Default.aspx?ID=1&m=keywordfinder&keyword=frontendedit', '_blank', 'location=no,directories=no,menubar=no,toolbar=yes,width=950,height=700');
}

function UnHighlight(Hwnd) {
	Hwnd.style.cssText = "margin: 2px; padding: 2px; background-color: ; border: 1px solid white; cursor: ";
}

function Highlight(Hwnd) {
	Hwnd.style.cssText = "margin: 2px; padding: 2px; background-color:#C1D2EE; border: 1px solid #316AC5; cursor: hand";
}

var _newsContext = 'news';
var FrontendNewsCurrentID = 0;
var FrontendNewsGroupIDs = '';
var FrontendNewsGroupID = '';
var FrontendNewsMenuActive = false;
var FrontendMenuActive = false;
var FrontendMenuHwd, FrontendNewsMenuHwd
var Frontend_WindowFeatures = "location=no, menubar=no, status=yes, resizable=no, toolbar=no, width=650, height=660, scrollbars=yes";
var Frontend_NewsWindowFeatures = "scrollbars=yes, location=no, menubar=no, status=yes, resizable=no, toolbar=no, width=630, height=560";
var CurrentParagraphID = 0;