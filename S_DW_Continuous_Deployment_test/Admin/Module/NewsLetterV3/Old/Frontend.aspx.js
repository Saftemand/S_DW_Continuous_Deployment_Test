function Preview(fpath)
{
    window.open(fpath,'preview', 'displayWindow,width=200,height=200,scrollbars=yes');
}

function DisplayControl(controlID)
{
    var control = document.getElementById(controlID);
    control.style.display = control.style.display == "none" ? "" : "none";
}
	
function CheckSearchWord()
{
    return true;
}
	

