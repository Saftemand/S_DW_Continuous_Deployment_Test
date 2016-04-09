var timTheTimer;
var cnt = 0;
var isLoadedData = false;
var origText;

function GetFilter()
{
	if (window.parent._reportFilter != null)
	    return window.parent._reportFilter;
	return null;
}

function RedirectLink(link, linkWithOutUID){
	window.parent._reportScript = link;
	window.parent.changeReportSrc();
	window.parent._reportScript = linkWithOutUID;
	}
	
function showUserReport(strLocation){
	window.open(strLocation, "newWind", "resizable=no,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=600,height=700");
	}

function OpenNewWindow(strLocation){
	window.open(strLocation, "newWind");
	}
	
function append(){
       	if(isLoadedData)
		{
			stopTimer();			
		}
		else
		{
			var ifReportTitle = window.frames["_ifReportTitle"];
			var stText = ifReportTitle.document.getElementById("statusText");
			if (typeof stText != "undefined" && stText != null)
			{
				if(cnt == 0) origText = stText.innerText; 
				if(cnt < 90) stText.innerText = stText.innerText + '.';
				else 
				{
					stText.innerText = origText;
					cnt = 0;					
				}
				cnt += 1;
				wait();
			}
		}
}

function wait(){
	timTheTimer = setTimeout("append();", 300);
}

function stopTimer() 
{
	clearTimeout(timTheTimer);
	var ifReportTitle = window.frames["_ifReportTitle"]; 
	if (ifReportTitle.document.getElementById("SettingsAreaLabel").innerHTML == "" && location.search.indexOf('Export=True') < 0) ifReportTitle.frameElement.height = 85;
	var stText = ifReportTitle.document.getElementById("statusText");
	if(typeof stText != "undefined" && stText != null) 	stText.style.display = 'none';
}

function downloadXLSExport(filePath){
	if(location.search.indexOf('Export=True') > 0){
		download(filePath);
	}
}

function ReloadReport(path)
{
	window.parent.changeReportSrcPath(path);
}

function changeDataFrame(path)
{
	window.parent._reportScript = path;
	window.parent.changeReportSrc();
}

function exportPDF()
{
	var ifReportTitle = window.frames["_ifReportTitle"];
	var ifReportData = window.frames["_ifReportData"]; 		
	var reportHtml = ifReportTitle.document.getElementById("reportHtml");
	var reportTitle = ifReportTitle.document.getElementById("reportTitle")
	if (typeof reportHtml != "undefined" && reportHtml != null)
	{
		if(typeof reportTitle != "undefined" && reportTitle != null)
		{
			reportHtml.value =	ifReportData.document.getElementById("htmlToPDF").innerHTML;
			reportTitle.value = ifReportTitle.document.getElementById("title_content").innerHTML;
			ifReportTitle.document.getElementById('Form1').submit();
		}
	}
}

function download(filePath)
{
	var ifReportTitle = window.frames["_ifReportTitle"]; 
	ifReportTitle.frameElement.height = 105;
	//window.frames["_ifDownl"].location = '/Admin/Public/download.aspx?File=' + filePath;
}

var browser_name = navigator.appName;

function printReport()
{ 
	window.frames["_ifReportData"].focus();
    window.frames["_ifReportData"].print();
}

function Init()
{  
	document.body.scroll = 'no';
}
