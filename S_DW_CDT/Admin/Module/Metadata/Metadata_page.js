var _dropdown;
var arrValidate = new Array();
var xmlHttp;

function AddValidator(name)
{
	arrValidate[arrValidate.length] = name;
}

function IsValidMetadata()
{
	var ret = true;
	for(c = 0; c < arrValidate.length; c++) 
	{
		var elem = document.getElementById(arrValidate[c]);
		var id = elem.id.split("_")[1];
		var alert = false;
		if (elem.tagName == "TEXTAREA")
		{
			if (elem.value == "") 
			{
				ret = false;
				alert = true;
			}
		}
		else if (elem.tagName == "SELECT")
		{
			if (elem.value == "0") 
			{
				ret = false;
				alert = true;
			}
		}
		else if (elem.tagName == "INPUT")
		{								
			var custElem = document.getElementById("MultiCustom_" + id)
			if (elem.value == "" && custElem.value == "") 
			{
				ret = false;
				alert = true;
			}
		}
		if (alert) document.getElementById("validator_" + id).style.display = "";
		else document.getElementById("validator_" + id).style.display = "none";
	}
	return ret;
}

function ChangeCategory(dropdown)
{
	_dropdown = dropdown;
	if(dropdown.value > 0)
	{
		var url = "/Admin/Module/Metadata/ChangeCategory.aspx?cid=" + dropdown.value;
		__SendXmlHttpRequest(url);	
	}
	else
	{
		var id  = _dropdown.id.replace("c", "");
		var divsel = document.getElementById("div_sel_" + id);
		var divall = document.getElementById("div_all_" + id);
		divsel.innerHTML = CreateSelect("selected_", id, "");
		divall.innerHTML = CreateSelect("all_", id, "");
		document.getElementById("MultiSelectIDs_" + id).value = "";
		document.getElementById("MultiCustom_" + id).value = "";	
	}
}

function MultiAdd(id, fbox, tbox)
{
	if(fbox.value != "")
	{
		var no = new Option();									
		no.value = -1;						
		no.text = fbox.value;			
		tbox[tbox.options.length] = no;	
		fbox.value = "";
		MultiSelectUpdateIds(id, fbox, tbox);
	}
}

function MultiSelectMove(id, fbox, tbox, bAll) {									
	var arrFbox = new Array();									
	var arrTbox = new Array();									
	var arrLookup = new Array();								
	var i;														
	for (i = 0; i < tbox.options.length; i++) {					
		arrLookup[tbox.options[i].text] = tbox.options[i].value;
		arrTbox[i] = tbox.options[i].text;						
	}															
	var fLength = 0;											
	var tLength = arrTbox.length;	
	for(i = 0; i < fbox.options.length; i++) {					
		arrLookup[fbox.options[i].text] = fbox.options[i].value;
		if (bAll || (fbox.options[i].selected && fbox.options[i].value != '')) {
			arrTbox[tLength] = fbox.options[i].text;			
			tLength++;											
		}else{													
			arrFbox[fLength] = fbox.options[i].text;			
			fLength++;											
		}														
	}															
	arrFbox.sort();												
	arrTbox.sort();												
	fbox.length = 0;											
	tbox.length = 0;											
	var c;														
	for(c = 0; c < arrFbox.length; c++) {						
		var no = new Option();									
		no.value = arrLookup[arrFbox[c]];						
		no.text = arrFbox[c];									
		fbox[c] = no;											
	}	
	var n = 0;														
	for(c = 0; c < arrTbox.length; c++) {						
		var vdt = arrLookup[arrTbox[c]];
		if(vdt > 0 || tbox.id.indexOf("all_") < 0)
		{
			var no = new Option();									
			no.value = vdt;						
			no.text = arrTbox[c];									
			tbox[n] = no;											
			n++;
		}		
	}
	MultiSelectUpdateIds(id, fbox, tbox);
}																

function MultiSelectUpdateIds(id, fbox, tbox)
{
    var box = fbox;
    if (box.id.indexOf("selected_") < 0)
        box = tbox;
  	var arrIds = new Array();
	var arrCust = new Array();
	var n = 0;
	var k = 0;
	for(i = 0; i < box.options.length; i++) 
	{                                 
		if(box.options[i].value > 0)  
		{
			arrIds[n] = box.options[i].value;			
			n++;
		}		
		else
		{                                    
			arrCust[k] = encodeURI(box.options[i].text);			
			k++;
		}
	}
	document.getElementById("MultiSelectIDs_" + id).value = arrIds.join(",");
	document.getElementById("MultiCustom_" + id).value = arrCust.join("^");
}

function MultiSelectGetAllControl(id)
{
    return MultiSelectGetControl("all_" + id);
}

function MultiSelectGetSelectedControl(id)
{
    return MultiSelectGetControl("selected_" + id);
}

function MultiSelectGetControl(id)
{
    return document.all[id];
}

function IsSelected(source, arguments)
{
    arguments.IsValid = document.all.MultiSelectIDs.value.length > 0;
}

function __GetXmlHttpObject()
{ 
	var objXMLHttp = null;
	if(window.XMLHttpRequest)
		objXMLHttp=new XMLHttpRequest();
	else if(window.ActiveXObject)
	  objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	return objXMLHttp;
}

function __StateChanged() 
{
	if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete")
	{  
			var id  = _dropdown.id.replace("c", "");
			var divsel = document.getElementById("div_sel_" + id);
			var divall = document.getElementById("div_all_" + id);
			divsel.innerHTML = CreateSelect("selected_", id, "");
			divall.innerHTML = CreateSelect("all_", id, xmlHttp.responseText);
			return true;
	}
} 

function CreateSelect(name, id, options)
{
	var ondblclick = "";
	if(name == "selected_")
	{
		ondblclick = "ondblclick='MultiSelectMove(" + id + ",MultiSelectGetSelectedControl(" + id + "), MultiSelectGetAllControl(" + id + "))'"
	}
	else
	{ 
		if(name == "all_")
		{
			ondblclick = "ondblclick='MultiSelectMove(" + id + ",MultiSelectGetAllControl(" + id + "),MultiSelectGetSelectedControl(" + id + "))'"			
		}
	}
	return "<SELECT size='8' id='" + name + id + "' Class='std' " + ondblclick + " >" + options + "</SELECT>"
}

function __SendXmlHttpRequest(url)
{
	if (!xmlHttp){
		xmlHttp = new __GetXmlHttpObject();
	}
	if(!xmlHttp)
		return false;
		
	xmlHttp.open("GET", url, true);
	xmlHttp.onreadystatechange = function() {
		__StateChanged();
	}
	xmlHttp.send(null);	
}
