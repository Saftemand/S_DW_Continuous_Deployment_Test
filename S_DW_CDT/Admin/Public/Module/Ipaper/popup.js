var originalDocumentWidth;
var currentPaperID = 0;

function showIpaper(paperID)
{
	showPopup('iPaper', paperID);
}

function showPopup(title, paperID)
{
	// Set current paperID
	currentPaperID = paperID;
	
	// Get source HTML structure
	var elSource = document.getElementById('popupSource' + paperID);
	var el = document.getElementById('popupMask' + paperID);
	var elContent = document.getElementById('popupContent' + paperID);
	
	// Safari?
	var isSafari = navigator.appVersion.indexOf('Safari') != -1;
	
	// Store input dimensions
	originalDocumentWidth = document.documentElement.scrollWidth;
	
	if(!isSafari)
	{
		// Copy source html into elContent
		elContent.innerHTML = elSource.innerHTML.split("<!--@Title-->").join(title);
	}
	
	// Load SWF
	var so = new SWFObject("/Admin/Public/Module/Ipaper/ipaper.swf", "ipaper", "100%", "100%", "8", "#555555");
	so.addParam("allowscriptaccess", "always");
	so.addVariable("theSettingsXmlPath", "/Files/System/Module/Ipaper/Ipapers/" + paperID + "/data.xml");
	so.write("flashContent" + paperID);
	
	if(isSafari)
	{
		// Copy source html into elContent
		elContent.innerHTML = elSource.innerHTML.split("<!--@Title-->").join(title);
	}
	
	// Set dimensions
	setPopupDimensions(el, elContent);
	
	// Set visibility
	el.style.display = '';
	elContent.style.display = '';
	
	// Detect resizes
	window.onresize = setPopupDimensions;
	window.onscroll = setPopupDimensions;
}

function setPopupDimensions(el, elContent)
{
	var elSource = document.getElementById('popupSource' + currentPaperID);
	var el = document.getElementById('popupMask' + currentPaperID);
	var elContent = document.getElementById('popupContent' + currentPaperID);
	
	// Get scroll position
	var scrollY = document.documentElement.scrollTop;
	var scrollX = document.documentElement.scrollLeft;
	
	// Get document dimensions
	var documentHeight = document.body.clientHeight > document.documentElement.clientHeight ? document.body.clientHeight : document.documentElement.clientHeight;
	var documentWidth = originalDocumentWidth < document.documentElement.scrollWidth ? originalDocumentWidth : document.documentElement.scrollWidth;
	
	// Get browser dimensions
	if(typeof(window.innerWidth) == 'number')
	{
		//Non-IE
		myInnerWidth = window.innerWidth;
		myInnerHeight = window.innerHeight;
	}
	else if(document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight))
	{
		//IE 6+ in 'standards compliant mode'
		myInnerWidth = document.documentElement.clientWidth;
		myInnerHeight = document.documentElement.clientHeight;
	}
	else if(document.body && (document.body.clientWidth || document.body.clientHeight))
	{
		//IE 4 compatible
		myInnerWidth = document.body.clientWidth;
		myInnerHeight = document.body.clientHeight;
	}
	
	if(documentWidth < myInnerWidth)
		documentWidth = myInnerWidth;
	
	// Set dimensions of background mask
	el.style.width = myInnerWidth + 'px';
	el.style.height = myInnerHeight + 'px';
	el.style.top = 0;
	el.style.left = 0;
	
	// Set dimensions of content
	height = myInnerHeight - 30;
	width = myInnerWidth - 30;
	elContent.style.width = width + 'px';
	elContent.style.height = height + 'px';
	elContent.style.top = (scrollY + myInnerHeight / 2 - height / 2 - 20 / 2) + 'px';
	elContent.style.left = (scrollX + myInnerWidth / 2 - width / 2) + 'px';
	
	// Set dimension of flash content table
	var elFlash = document.getElementById('flashContent' + currentPaperID);
	if(document.compatMode == 'BackCompat')
	{
		elFlash.style.width = '100%';
		elFlash.style.height = '100%';
	}
	else
	{
		elFlash.style.width = (width - 10) + 'px';
		elFlash.style.height = (height - 5) + 'px';
	}
}

function cancelPopup()
{
	// Hide view
	document.getElementById('popupMask' + currentPaperID).style.display = 'none';
	document.getElementById('popupContent' + currentPaperID).style.display = 'none';
	
	// Don't handle resizes
	window.onresize = null;
	window.onscroll = null;
	
	// Clear current popup
	currentPaperID = 0;
}

function ipaperClose()
{
	cancelPopup();
}

function printImg(imageID, pageID, paperID)
{
	var el = document.getElementById('ipPrintFrame' + paperID);
	el.imageToLoad = '/Files/System/Module/Ipaper/Ipapers/' + paperID + '/Pages/' + pageID + '/1.jpg';
	el.src = '/Admin/Public/Module/Ipaper/print.html?paperID=' + paperID;
}

/*  This is just a stub. Reason - the function probably called from 
    SWF but its implementation apparently has been removed.
*/
function onPaperLoad() { }