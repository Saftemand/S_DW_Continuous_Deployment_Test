/*MenuMZ5.js
* by Nicolai Pedersen
* Copyright © 2002 - 2003 Dynamic Systems A/S.
*/

Filter = false;
if(navigator.appVersion.indexOf("MSIE 5.5") > 0 || navigator.appVersion.indexOf("MSIE 6") > 0){
	Filter = true;
}

oldID = 0
TopPos = 0;
LeftPos = 0;
OverMenuLeftPos = 0;
LeftPosCorrection = 0;
TopPosCorrection = 0;
DwLeftDropdown = false;
myLevel = 0;
preLevel = 0;
preID = 0;

function showSubMenu(menuID){
	if(window.innerWidth){
		BodyWidth = window.innerWidth-15;
	}
	else{
		BodyWidth = document.body.offsetWidth-15;
	}
	elm2.className = "inactive";
	elm.className = "active";

	if(menuID != oldID){
		hide = true;
		DoTheHide(oldID);
		oldID = menuID;
	}
	DontHide();

	if(document.getElementById){

		TopPos = TopPosCorrection;
		LeftPos = LeftPosCorrection;
		if(document.getElementById("DWMain")) {
			TopPos += document.getElementById("DWMain").offsetTop;
			LeftPos += document.getElementById("DWMain").offsetLeft;
		}
		if (document.getElementById("DwTopGraphic")) {
			//alert(document.getElementsByName("DwTopGraphic").items());
			if(document.getElementsByName("DwTopGraphic").length) {
				for(var iDT = 0; iDT < document.getElementsByName("DwTopGraphic").length; iDT++){
					TopPos += document.getElementsByName("DwTopGraphic")[iDT].offsetHeight;
				}
			}
			else {
				TopPos += document.getElementById("DwTopGraphic").offsetHeight;
			}
		}
		
		if (document.getElementById("DWLeft")) {
			if(document.getElementsByName("DWLeft").length) {
				for(var iDT = 0; iDT < document.getElementsByName("DWLeft").length; iDT++){
					LeftPos += document.getElementsByName("DWLeft")[iDT].offsetWidth;
				}
			}
			else {
				LeftPos += document.getElementById("DWLeft").offsetWidth;
			}
		}

		if(document.getElementById("MM" + menuID)){
			objIEm = document.getElementById("MM" + menuID);
			if(DwLeftDropdown){
				//TopPos += objIEm.offsetHeight;
				TopPos += objIEm.offsetTop;
				LeftPos += objIEm.offsetLeft + objIEm.offsetWidth;
			}
			else{
				LeftPos += objIEm.offsetLeft;
			}
		}
		if(document.getElementById("submenu" + menuID)){
			objUm = document.getElementById("submenu" + menuID);
			objUm.className = "dropdownshow";
			if((objUm.offsetWidth + LeftPos) > BodyWidth){
				LeftPos -= (objUm.offsetWidth + LeftPos) - BodyWidth+6;
			}
			objUm.style.top = TopPos + "px";
			objUm.style.left = LeftPos + "px";
			OverMenuLeftPos = LeftPos;
		}
	}
	showHideSelects(true);
}

oldSubID = 0
function showSubSubMenu(menuID){
	BodyWidth = document.body.offsetWidth-15;
	if(menuID != oldSubID){
		hide_sub = true;
		DoTheSubHide(oldSubID);
		oldSubID = menuID;
	}
	if(document.getElementById) {
		SubTopPos = TopPos;
		SubLeftPos = LeftPos;
		if(document.getElementById("" + menuID) && document.getElementById("submenu" + oldID)){
			objIEm = document.getElementById("" + menuID);
			SubTopPos += objIEm.offsetTop-1;
			SubLeftPos += document.getElementById("submenu" + oldID).offsetWidth-1;
		}
		if(document.getElementById("submenu" + menuID)){
			objUm = document.getElementById("submenu" + menuID);
			
			objUm.className = "dropdownshow";
			if((objUm.offsetWidth + SubLeftPos) > BodyWidth){
				SubLeftPos -= (objUm.offsetWidth*2)-1;
			}
			objUm.style.top = SubTopPos + "px";
			objUm.style.left = SubLeftPos + "px";
			objUm.className = "dropdownshow";
		}
	}
	showHideSelects(true);
}

oldSubSubID = 0
function showSubSubSubMenu(menuID){
	BodyWidth = document.body.offsetWidth-15;
	if(menuID != oldSubSubID){
		hide_sub = true;
		DoTheSubHide(oldSubSubID);
		oldSubSubID = menuID;
	}
	if(document.getElementById){
		SubTopPos = TopPos;
		SubLeftPos = LeftPos;
		if(document.getElementById("" + menuID) && document.getElementById("submenu" + oldSubID)){
			objIEm = document.getElementById("" + menuID);
			SubTopPos += objIEm.offsetTop-2 + document.getElementById(oldSubID).offsetTop;
			
			document.getElementById("submenu" + oldSubID).className = "dropdownshow";
			myoffsetWidth = document.getElementById("submenu" + oldSubID).offsetWidth;
//			document.getElementById("submenu" + oldSubID).className = "dropdownhide";
			
			SubLeftPos += document.getElementById("submenu" + oldID).offsetWidth - 1 + myoffsetWidth - 1;
			//alert(oldSubID)
		}
		if(document.getElementById("submenu" + menuID)){
			objUm = document.getElementById("submenu" + menuID);
			
			objUm.className = "dropdownshow";
			if((objUm.offsetWidth + SubLeftPos) > BodyWidth){
				SubLeftPos -= (objUm.offsetWidth*2)-1;
			}
			objUm.style.top = SubTopPos + "px";
			objUm.style.left = SubLeftPos + "px";

			objUm.className = "dropdownshow";
		}
	}
	showHideSelects(true);
}

hide = true;
hide_sub = true;
PrevMenuID = 0
/* Over subs */
function HideDropdown(objID){
	hide = true;
	setTimeout("DoTheHide("+objID+")", 100);
	setTimeout("DoTheSubHide("+oldSubID+")", 100);
}

function HideDropdown2(objID){
	hide = true;
	setTimeout("DoTheHide("+objID+")", 1000);
}

function DoTheHide(objID){
	objID = objID.toString();

	if(hide && objID != 0 && document.getElementById("submenu" + objID)){
		var objUm = document.getElementById("submenu" + objID);
		objUm.className = "dropdownhide";
		//objUm.visibility = "hide";
		//objUm.style.display = "none";
		if(objUm) {
			objUm.visibility = "hide";
		}
		showHideSelects(false);
		hide_sub = true;
		setTimeout("DoTheSubHide(oldSubID)", 210);;
	}
}

function DontHide(){
	if(document.getElementById("submenu" + oldSubSubID))
		document.getElementById("submenu" + oldSubSubID).className = "dropdownhide";
	hide = false;
}

/* Undersubs */
function HideSubSub(objID){
	hide_sub = true;
	hide = true;
	setTimeout("DoTheSubHide("+objID+")", 100);
	setTimeout("DoTheHide("+oldID+")", 100);
}

function DoTheSubHide(objID){
	objID = objID.toString();
	if(hide_sub && objID != 0 && document.getElementById("submenu" + objID)){
		if(document.getElementById("submenu" + oldSubSubID))
			document.getElementById("submenu" + oldSubSubID).className = "dropdownhide";
		objUm = document.getElementById("submenu" + objID);
		objUm.className = "dropdownhide";
		showHideSelects(false);
	}
}

function DoTheSubSubHide(objID){
	objID = objID.toString();
	if(hide_sub && objID != 0 && document.getElementById("submenu" + objID)){
		objUm = document.all.item("submenu" + objID);
		objUm.className = "dropdownhide";
		showHideSelects(false);
	}
}

function DontHideSub(){
	hide_sub = false;
	hide = false;
}

/* Nye funktioner */
elm = ""
function mover(elm){
	if(preLevel != 0)
		if(preLevel == myLevel)
			if(document.getElementById("submenu" + preID))
				document.getElementById("submenu" + preID).className = "dropdownhide";

	preLevel = myLevel; 
	preID = elm.id

	if(document.getElementById("submenu" + elm.id)){
		hide_sub = false;
		showSubSubMenu(elm.id);
	}else{
		hide_sub = true;
		DoTheSubHide(oldSubID);
	}
	elm2.className = "inactive";
	elm.className = "active";
}

function moversub(elm){
	if(preLevel != 0)
		if(preLevel == myLevel)
			if(document.getElementById("submenu" + preID))
				document.getElementById("submenu" + preID).className = "dropdownhide";

	preLevel = myLevel; 
	preID = elm.id

	if(document.getElementById("submenu" + elm.id)){
		hide_sub = false;
		showSubSubSubMenu(elm.id);
	}else{
		hide_sub = true;
		DoTheSubHide(oldSubID);
	}
	elm2.className = "inactive";
	elm.className = "active";
}


elm2 = ""
function moout(elm){
	if(document.getElementById("submenu" + elm.id)){
		DontHideSub();
	}else{
		hide_sub = true;
	}
	elm2 = elm;
}

 /* sub */
function mover_sub(elm){
	if(preLevel != 0)
		if(preLevel == myLevel)
			if(document.getElementById("submenu" + preID))
				document.getElementById("submenu" + preID).className = "dropdownhide";

	preLevel = myLevel; 
	preID = elm.id

	DontHideSub()
	elm.className = "active";

}

function moout_sub(elm){
	elm.className = "inactive";
}

 
function doclick(ID){
	location = "Default.aspx?ID=" + ID;
}

function doclck(strLocation){
	location = strLocation;
}

function highlightParent(ID){
	if(document.getElementById("" + ID))
		document.getElementById("" + ID).className = "active";
}

SelectShow = true;
function showHideSelects(hide){
	return;
	if (document.all && document.getElementById) {
		for( i=0; i<document.forms.length; i++ ) {
			for( r=0; r<document.forms[i].elements.length; r++ ) {
				if( document.forms[i].elements[r].type=='select-one' || document.forms[i].elements[r].type=='select-multiple'){
					if(hide){
						document.forms[i].elements[r].style.display='none';;
						SelectShow = false;
					}else{
						setTimeout("doSelectShow(document.forms["+i+"].elements["+r+"]);", 250);
						
					}
				}
			}
		}
	}
}

function doSelectShow(obj){
	if(SelectShow){
		obj.style.display='inline';
	}
	SelectShow = true;
}