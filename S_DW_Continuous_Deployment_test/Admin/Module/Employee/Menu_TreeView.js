PreviousOpenedFolder = "";
PreviousOpened = new Array(25);
for(i = 0 ; i < PreviousOpened.length ; i++)
	PreviousOpened[i] = "";

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
		    if (document.getElementById(ToggleID).style.display == "none") {
		        document.getElementById(ToggleID).style.display = "";
		        document.images["img_" + ToggleID].src = "/Admin/Images/Expand_off.gif";
			}else{
			    document.getElementById(ToggleID).style.display = "none";
			    document.images["img_" + ToggleID].src = "/Admin/Images/Expand.gif";
			}
		}else{
		    document.getElementById(ToggleID).style.display = "";
		    document.images["img_" + ToggleID].src = "/Admin/Images/Expand_off.gif";
		}
	}

	if (!imgObject.src && document.getElementById(PreviousOpened[Level])) {
		
		if(PreviousOpened[Level].length > 0 && PreviousOpened[Level] != ToggleID){
		    document.getElementById(PreviousOpened[Level]).style.display = "none";
		    document.images["img_" + PreviousOpened[Level]].src = "/Admin/Images/Expand.gif";
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

function n(DepID){ //Navigate
    var currentNode = document.getElementById('s' + DepID);
    var contentFrame = document.getElementById('DepartmentList');
    
    if(Prev){
		Prev.style.fontWeight = "";
	}
	cellObject = "";

	if (currentNode) {
	    currentNode.style.fontWeight = 'bold';
	    Prev = currentNode;
	}
	
	/*if(document.all.item("s" + DepID))
	{
		document.all.item("s" + DepID).style.fontWeight = "bold";
		Prev = document.all.item("s" + DepID);
	}*/
	
	if (contentFrame)
        contentFrame.src = 'Department_List.aspx?ID=' + DepID;
}
