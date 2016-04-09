var _reportFilter = "";
var _reportScript = "reports/IFSummary.aspx?SummaryID=1";

function changeReportSrc(changeGuiParam)
{
	var delim = "";
	if(_reportFilter != "")
	{
		if(_reportScript.indexOf("?") > 0) delim = "&";
		else delim = "?";
	}
	var rpt = window.document.getElementById("_ifreport");
	rpt.src = _reportScript + delim + _reportFilter;
	changeMenuGui(changeGuiParam);
}

function changeMenuGui(changeGuiParam)
{
	if (changeGuiParam != null)
	{
		if (changeGuiParam == "trigger")
		{			
			window.document.getElementById("labelLanguage").style.display = "none";
			window.document.getElementById("Statv2Area").style.display = "none";
			if (window.document.getElementById("labelIPAddress")) {
			    window.document.getElementById("labelIPAddress").style.display = "none";
			}
			if (window.document.getElementById("Statv2IpSearch")) {
			    window.document.getElementById("Statv2IpSearch").style.display = "none";
			}
			window.document.getElementById("trApplyStatSetting").style.display = "none";
			window.document.getElementById("trApplyTriggerFilter").style.display = "";
		}
	}
	else
	{
		window.document.getElementById("labelLanguage").style.display = "";
		window.document.getElementById("Statv2Area").style.display = "";
		if (window.document.getElementById("labelIPAddress")) {
		    window.document.getElementById("labelIPAddress").style.display = "";
		}
		if (window.document.getElementById("Statv2IpSearch")) {
		    window.document.getElementById("Statv2IpSearch").style.display = "";
		}
		window.document.getElementById("trApplyStatSetting").style.display = "";
		window.document.getElementById("trApplyTriggerFilter").style.display = "none";
	}	
}

function changeReportSrcPath(path)
{
	var rpt = window.document.getElementById("_ifreport");
	rpt.src = path;
}

function reloadTreeFrame()
{
	var tree = window.document.getElementById("_iftree");
	tree.src = "IFTree.aspx";
}