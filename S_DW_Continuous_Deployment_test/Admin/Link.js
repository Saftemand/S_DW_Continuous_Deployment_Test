function browseLink(strCaller, strFolder, strFile) {
	PageHasChanged = true;

	DW_browse_window = window.open("/Admin/FileManager/Browser/Default.aspx?Mode=browselink&Caller=" + strCaller + "&Folder=/" + strFolder + "&strChosenFile=" + strFile, "DW_browse_window", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=1024,height=768,left=200,top=120");
	DW_browse_window.focus();
}

var actionStrUrl = "Internal";
var resize = "yes";
function internal(ID, AreaID, Name, strShowParagraphsOption, advancedSettings) {
    var url = '';

	if (AreaID.length < 1) {
		if (top.left) {
			AreaID = top.left.AreaID;
		}
		else if (window.opener && window.opener.top.left) {
			AreaID = window.opener.top.left.AreaID;
		}
	}

	url =
        "/Admin/Menu.aspx?ID=" + ID +
        "&Action=" + actionStrUrl +
        "&Caller=" + Name +
        "&AreaID=" + AreaID +
        "&strShowParagraphsOption=" + strShowParagraphsOption;

	if (advancedSettings) {
	    url += '&';

	    for (var p in advancedSettings) {
	        if (typeof (advancedSettings[p]) != 'function' && advancedSettings[p] != null) {
	            url += ('Advanced.' + p + '=' + encodeURIComponent(advancedSettings[p].toString()) + '&');
	        }
	    }

	    url = url.substr(0, url.length - 1);
	}

	movepageWindow = window.open(url, "_new", "resizable=" + resize + ",scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=375,top=155,left=202");
}

function internalEcom(ID, AreaID, Name, strShowParagraphsOption) {
	actionStrUrl = "InternalEcom";
	resize = "no";
	internal(ID, AreaID, Name, strShowParagraphsOption);
}

function linkManagerToggleSettings(Name) {
	var objHwnd = document.getElementById(Name);
	if (objHwnd.style.display == "none") {
		objHwnd.style.display = "";
	}
	else {
		objHwnd.style.display = "none";
	}
}
