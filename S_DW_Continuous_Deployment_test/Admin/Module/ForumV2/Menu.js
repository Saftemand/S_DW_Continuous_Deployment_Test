
function QuickSearch()
{
	var field = document.getElementById("SearchField");
	if (typeof field != "undefined" && field != null)
	{
		frames["ForumV2Main"].location.href = "Search.aspx?qsearch=" + field.value;
	}
}

function IsEnter(evt) 
{   
    var charCode = evt.keyCode;
    if (charCode == 13 || charCode == 3) {
		QuickSearch();
        return false;
    } else {
        return true;
    }  	
}