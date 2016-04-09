//Factbox script
fb = new Array();

FactboxSettingMovebox = true;
FactboxSettingDontKeepOnmouseover = false;
FactboxSettingBordercolor = "#000000";
FactboxSettingWidth = 250;
FactboxSettingHeight = 0;
FactboxSettingShowheading = true;
FactboxSettingDelay = 500;
FactboxSettingImagePos = "right";

FactboxSettingHbgColor = "#CCCCCC";
FactboxSettingHFont = "Verdana, Helvetica, Arial";
FactboxSettingHColor = "#000000";
FactboxSettingHsize = "10px";
FactboxSettingTbgColor = "#E1E1E1";
FactboxSettingTFont = "Verdana, Helvetica, Arial";
FactboxSettingTColor = "#000000";
FactboxSettingTsize = "10px";

fbhideok = true;
fbDivID = "Factbox";
function FB(WordID, event){
	WordID = parseInt(WordID);
	for(var i = 0;i < fb.length;i++){
		if(fb[i][0] == WordID){
			showbox(i, event);
		}
	}
}

function FBC(WordID){ //Click on word
	WordID = parseInt(WordID);
	for(var i = 0;i < fb.length;i++){
		if(fb[i][0] == WordID && fb[i][4] != ""){
			//NP 02-08-2006
			var link = fb[i][4]
			if(link.substring(0,12).toLowerCase() == "default.aspx"){
				link = "/" + link;
			}
			if(fb[i][5]){
				window.open(link);
			}
			else{
				location = link;
			}
		}
	}
}

function mmfb(event){ //Mousemove
	if(FactboxSettingMovebox){
		fb_reposition(event);
	}
}

function fb_reposition(event){
	if(document.getElementById(fbDivID)){
		//prefer document.documentElement or else use document.body
		iScrollTop = document.documentElement && document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;
		iScrollLeft = document.documentElement && document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft;
		x = (event.clientX + iScrollLeft + 10);
		y = (event.clientY + iScrollTop);
		
		document.getElementById(fbDivID).style.top = y + 'px';
		document.getElementById(fbDivID).style.left = x + 'px';
	}
}

function mofb(){ //Mouseout
	if(document.getElementById(fbDivID)){
		fbhideok = true;
		if(FactboxSettingDontKeepOnmouseover){
			fbhide();
		}
		else{
			setTimeout('fbhide()', FactboxSettingDelay);
		}
	}
}

function fbhide(){ //Do the actual hide of the box
	if(fbhideok){
		document.getElementById(fbDivID).style.display = "none";
	}
}

function showbox(ArrayIndex, event){ //write the boks
	fbhideok = false;
	tmp = "";
	tmp += "<table width=100% cellpadding=2 cellspacing=0 style=\"border:1px solid " + FactboxSettingBordercolor + "\">";
	if(FactboxSettingShowheading){
		tmp += "<tr bgcolor=\"" + FactboxSettingHbgColor + "\"><td colspan=2><span style=\"color:" + FactboxSettingHColor + ";font-weight:bold;font-size:" + FactboxSettingHsize + ";font-family:" + FactboxSettingHFont + "\">" + fb[ArrayIndex][1] + "</td></tr>";
	}
	img = "";
	if(fb[ArrayIndex][3].length > 1){
		img = "<img src=\"" + fb[ArrayIndex][3] + "\">";
	}
	if(FactboxSettingImagePos == "left"){
		tmp += "<tr bgcolor=\"" + FactboxSettingTbgColor + "\"><td valign=top>" + img + "</td><td valign=top><span style=\"color:" + FactboxSettingTColor + ";font-weight:norma;font-size:" + FactboxSettingTsize + ";font-family:" + FactboxSettingTFont + "\">" + fb[ArrayIndex][2] + "</td></tr>";
	}
	else if(FactboxSettingImagePos == "right"){
		tmp += "<tr bgcolor=\"" + FactboxSettingTbgColor + "\"><td valign=top><span style=\"color:" + FactboxSettingTColor + ";font-weight:norma;font-size:" + FactboxSettingTsize + ";font-family:" + FactboxSettingTFont + "\">" + fb[ArrayIndex][2] + "</td><td valign=top>" + img + "</td></tr>";
	}
	else{
		tmp += "<tr bgcolor=\"" + FactboxSettingTbgColor + "\"><td valign=top><span style=\"color:" + FactboxSettingTColor + ";font-weight:norma;font-size:" + FactboxSettingTsize + ";font-family:" + FactboxSettingTFont + "\">" + fb[ArrayIndex][2] + "</td></tr>";
	}
	tmp += "</table>";
	

	if(!document.getElementById(fbDivID)){
		document.body.appendChild(CreateFactBox(fbDivID, FactboxSettingWidth, FactboxSettingHeight, event.clientX, event.clientY, FactboxSettingDontKeepOnmouseover));
	}
	
	if(document.getElementById(fbDivID)){
		document.getElementById(fbDivID).innerHTML = tmp;
		fb_reposition(event);
		//div is display block naturally
		document.getElementById(fbDivID).style.display = "block";
	}
	
}

function CreateFactBox(id, width, height, left, top, over)
{		
    var elm = document.createElement("div");
    elm.setAttribute("id", id);
    elm.style.position = "absolute";
    elm.style.width = width+'px';
    if(height>0){
			//only set height when > 0 and set overflow to hidden
			elm.style.height = height+'px';
			elm.style.overflow = 'hidden';
		}
    elm.style.left = left+'px';
    elm.style.top = top+'px';
    elm.style.backgroundColor = "#FFFFFF";
    elm.setAttribute("onmouseover", "fbhideok=" + over + ";");
    elm.setAttribute("onmouseout", "mofb();");
    return elm;
}