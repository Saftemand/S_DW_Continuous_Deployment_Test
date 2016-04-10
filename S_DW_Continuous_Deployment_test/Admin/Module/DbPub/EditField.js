
var isVisibleHelp = false;

function ShowHelp(mode)
{
	isVisibleHelp = isVisibleHelp ? false : true;
	var stl = isVisibleHelp ? '' : 'none';
	document.getElementById(mode).style.display = stl;
}

function ChangeParent(defaultValue)
{
    var value = defaultValue;
    var label = document.getElementById("FieldLabel");
    if(label != "undefined" && label != null && label.value != "") 
    {
        value = label.value
    } 
    
    var num = document.getElementById("fieldnum").value;
    var item = window.opener.document.getElementById("field_num_" + num); 
    if(item != "undefined" && item != null)
    {
        item.innerHTML = value;
    } 
}