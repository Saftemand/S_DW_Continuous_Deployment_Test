<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Response.ContentType = "application/x-javascript"

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
				document.images["img_" + ToggleID].src = "images/Expand_off.gif";
			}else{
				document.getElementById(ToggleID).style.display = "none";
				document.images["img_" + ToggleID].src = "images/Expand.gif";
			}
		}else{
			document.getElementById(ToggleID).style.display = "";
			document.images["img_" + ToggleID].src = "images/Expand_off.gif";
		}
	}
	
	if(!imgObject.src && document.getElementById(PreviousOpened[Level])){
		//alert(PreviousOpened[Level]);
		if(PreviousOpened[Level].length > 0 && PreviousOpened[Level] != ToggleID){
			document.getElementById(PreviousOpened[Level]).style.display = "none";
			document.images["img_" + PreviousOpened[Level]].src = "images/Expand.gif";
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
	window.parent.right.location = "Paragraph/Paragraph_List.aspx?ID="+PageID;
}

function paragraphlist(PageID, Caller){ //Navigate
	if(Prev){
		Prev.style.fontWeight = "";
	}
	cellObject = "";
	if(document.getElementById("s"+PageID)){
		document.getElementById("s"+PageID).style.fontWeight = "bold";
		Prev = document.getElementById("s"+PageID);
	}
	window.ParagraphList.location.href = "Paragraph/Paragraph_List.aspx?Caller="+Caller+"&Mode=browse&ID="+PageID;
}

function SortPages(ParentPageID){ //Sort pages
	if(Prev){
		Prev.style.fontWeight = "";
	}
	cellObject = "";
	//alert(document.getElementById("sort"+ParentPageID).length);
	
	if(document.getElementById("sort"+ParentPageID).style){
		document.getElementById("sort"+ParentPageID).style.fontWeight = "bold";
		Prev = document.getElementById("sort"+ParentPageID);
	}
	window.parent.right.location = "Menu_Sort.aspx?ParentPageID="+ParentPageID+"&AreaID="+AreaID;
}

