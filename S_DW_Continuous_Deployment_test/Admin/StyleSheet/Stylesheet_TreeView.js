PreviousOpenedFolder = ""
PreviousOpened = new Array(25);
for(i = 0 ; i < PreviousOpened.length ; i++){
	PreviousOpened[i] = "";
}

ActualFolder = ""
function toggle(ToggleID, imgObject, Level, GroupID){ //Handle the foldertree
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
				document.images["img_" + ToggleID].src = "../images/Expand_off.gif";
			}else{
				document.getElementById(ToggleID).style.display = "none";
				document.images["img_" + ToggleID].src = "../images/Expand.gif";
			}
		}else{
			document.getElementById(ToggleID).style.display = "";
			document.images["img_" + ToggleID].src = "../images/Expand_off.gif";
		}
	}
	
	if(!imgObject.src && document.getElementById(PreviousOpened[Level])){
		if(PreviousOpened[Level].length > 0 && PreviousOpened[Level] != ToggleID){
			document.getElementById(PreviousOpened[Level]).style.display = "none";
			document.images["img_" + PreviousOpened[Level]].src = "../images/Expand.gif";
		}
	}
	
	if(!imgObject.src){
		if(document.images["fol_" + PreviousOpenedFolder]){
			document.images["fol_" + PreviousOpenedFolder].src = closedIcon;
		}
		document.images["fol_" + ToggleID].src = openIcon;
		PreviousOpenedFolder = ToggleID;
//		window.frames.AccessStylesheetTree.location = "stylesheet_edit.asp?GroupID=" + GroupID;
		ActualFolder = GroupID;
	}
	
	PreviousOpened[Level] = ToggleID;
}


var intPrevID
intPrevID = 0;
function MakeBold(ToggleID) {
	if(document.getElementById("SPAN_" + intPrevID))
		document.getElementById("SPAN_" + intPrevID).style.fontWeight="";
	
	if(document.getElementById("A_" + intPrevID))
		document.getElementById("A_" + intPrevID).style.fontWeight="";
	
	if(document.getElementById("SPAN_" + ToggleID))
		document.getElementById("SPAN_" + ToggleID).style.fontWeight="bold";

	if(document.getElementById("A_" + ToggleID))
		document.getElementById("A_" + ToggleID).style.fontWeight="bold";

	intPrevID = ToggleID;
}

function hl_off(cellObject){ //Remove underline from name of folder when mouse is out
	cellObject.style.textDecoration = "";
}

function hl(cellObject){ //Underline name of folder when mouse is over
	cellObject.style.textDecoration = "underline";
}

function cc(objRow){ //Change color of row when mouse is over... (ChangeColor)
	objRow.style.backgroundColor='#ECE9D8';
}

function ccb(objRow){ //Remove color of row when mouse is out... (ChangeColorBack)
	objRow.style.backgroundColor='';
}

function pv(file, fileSize, extension){ //Preview image or file
	ext = file.substring(file.length-3, file.length);
	if(ext.toLowerCase() == 'gif' || ext.toLowerCase() == 'jpg'){
		document.getElementById('preview').innerHTML = '<span class=preview><a href="../dynamicweb 2001' + ActualFolder.replace("\\", "/") + '/' + file + '" target="_blank"><img src="../dynamicweb 2001' + ActualFolder.replace("\\", "/") + '/' + file + '" width=100 height=100 border=0></a></span>'
	}else{
		document.getElementById('preview').innerHTML = '<span class=preview><a href="../dynamicweb 2001' + ActualFolder.replace("\\", "/") + '/' + file + '" target="_blank"><img src="ext/' + extension + '.gif" align="absmiddle" border=0>' + file + '</a> (' + fileSize + ')</span>'
	}
}
