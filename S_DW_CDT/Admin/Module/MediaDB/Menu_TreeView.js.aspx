<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%
response.ContentType = "application/x-javascript"
%>

PreviousOpenedFolder = ""
PreviousOpened = new Array(25);

for(i = 0 ; i < PreviousOpened.length ; i++){
	PreviousOpened[i] = "";
}

ActualFolder = ""
function toggle(ToggleID, imgObject, Level){ //Handle the foldertree
	if(imgObject.src){
		e = true;
	}else{
		if(PreviousOpened[Level] != ToggleID){
			e = true;
		}else{
			e = false;
		}
	}
	if(e && document.getElementById(ToggleID)){
		if(imgObject.src){
			if(document.getElementById(ToggleID).style.display == "none"){
				document.getElementById(ToggleID).style.display = "";
				document.images["img_" + ToggleID].src = "../../images/Expand_off.gif";
			}else{
				document.getElementById(ToggleID).style.display = "none";
				document.images["img_" + ToggleID].src = "../../images/Expand.gif";
			}
		}else{
			document.getElementById(ToggleID).style.display = "";
			document.images["img_" + ToggleID].src = "../../images/Expand_off.gif";
		}
	}
	//if(e && document.getElementById(ToggleID)){
	//	document.getElementById(ToggleID).style.display = "";
	//	document.images["img_" + ToggleID].src = "../../images/Expand_off.gif";
	//}
	
	if(!imgObject.src && document.getElementById(PreviousOpened[Level])){
		//alert(PreviousOpened[Level]);
		if(PreviousOpened[Level].length > 0 && PreviousOpened[Level] != ToggleID){
			document.getElementById(PreviousOpened[Level]).style.display = "none";
			document.images["img_" + PreviousOpened[Level]].src = "../../images/Expand.gif";
		}
	}
	if(!imgObject.src){
		PreviousOpenedFolder = ToggleID;
		ActualFolder = ToggleID;
	}
	PreviousOpened[Level] = ToggleID;
}

function hl_off(cellObject){ //Remove underline from name of folder when mouse is out
	cellObject.style.textDecoration = "";
	self.status = "";
}

function hl(cellObject, ID){ //Underline name of folder when mouse is over
	cellObject.style.textDecoration = "underline";
	self.status = "ID: " + ID;
}

Prev = ""
function n(PageID){ //Navigate
	if(Prev){
		Prev.style.fontWeight = "";
	}
	cellObject = "";
	if(document.getElementById("s"+PageID)){
		document.getElementById("s"+PageID).style.fontWeight = "bold";
		Prev = document.getElementById("s"+PageID);
	}
	window.ShopRight.location = "Media_List.aspx?ID="+PageID;
}

function SortPages(ParentID){ //Sort pages
	if(Prev){
		Prev.style.fontWeight = "";
	}
	cellObject = "";
	//alert(document.getElementById("sort"+ShopGroupParentID).length);
	
	if(document.getElementById("sort"+ParentID).style){
		document.getElementById("sort"+ParentID).style.fontWeight = "bold";
		Prev = document.getElementById("sort"+ParentID);
	}
	window.ShopRight.location = "Menu_Sort.aspx?ParentID="+ParentID;
}

