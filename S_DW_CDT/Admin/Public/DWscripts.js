function cp(imgID){
	try{
		if (document.images["img" + imgID] && eval("img" + imgID + "Over.src")){
			document.images["img" + imgID].src=eval("img" + imgID + "Over.src");
		}
	}catch(er) {
	}
}

function cp2(imgID){
	try{
		if (document.images["img" + imgID] && eval("img" + imgID + ".src")){
			document.images["img" + imgID].src=eval("img" + imgID + ".src");
		}
	}catch(er) {
	}
}

function CP(imgID, Level){
	try{
		if (document.images["img" + imgID] && eval("imgL" + Level + "Over.src")){
			document.images["img" + imgID].src=eval("imgL" + Level + "Over.src");
		}
	}catch(er) {
	}
}

function CP2(imgID, Level){
	try{
		if (document.images["img" + imgID] && eval("imgL" + Level + ".src")){
			document.images["img" + imgID].src=eval("imgL" + Level + ".src");
		}
	}catch(er) {
	}
}

function SetContentHeight(){ //Enables
	DwTopGraphicHeight = 0;
	if(document.getElementById("DwTopGraphic")){
		if(document.getElementById("DwTopGraphic").length){
			for(var iDT = 0; iDT < document.getElementById("DwTopGraphic").length; iDT++){
				DwTopGraphicHeight += document.getElementById("DwTopGraphic")[iDT].offsetHeight;
			}
		}
		else{
			DwTopGraphicHeight += document.getElementById("DwTopGraphic").offsetHeight;
		}
	}

	DwFooterHeight = 0;
	if(document.getElementById("DwFooter")){
		if(document.getElementById("DwFooter").length){
			for(var iDT = 0; iDT < document.getElementById("DwFooter").length; iDT++){
				DwFooterHeight += document.getElementById("DwFooter")[iDT].offsetHeight;
			}
		}
		else{
			DwFooterHeight += document.getElementById("DwFooter").offsetHeight;
		}
	}

	if(document.getElementById("DwContentCell")){
		document.getElementById("DwContentCell").style.overflow = "auto";
		height = document.body.clientHeight - DwFooterHeight - DwTopGraphicHeight; //- 15
		document.getElementById("DwContentCell").style.height = height;
	}
}

function isRadioButtonChecked(theOption, theForm){ 
	if (theForm.elements[theOption].checked){
		return true;
	}
	else{
		for (i=0;i < theForm.elements[theOption].length;i++) {
			if (theForm.elements[theOption][i].checked) {
				return true;
			}
		}
	}
	return false;
}

function validateEmail( email ){
  var regExp = /^[\w\-_]+(\.[\w\-_]+)*@[\w\-_]+(\.[\w\-_]+)*\.[a-z]{2,4}$/i;
  return regExp.test( email );
}


function changeCardImage(dir){
	//document.EcardForm.ECardImage.src = dir + '/' + document.EcardForm.AttachImage.value;
	//Changed for both Forefox and IE7 compatibility
	document.getElementsByName('ECardImage')[0].src = dir + '/' + document.getElementsByName('AttachImage')[0].value;
}

function CookieTest() {
	document.cookie = 'test';
	if(document.getElementById('favorites')){
		if (document.cookie == "") {
			document.getElementById('favorites').style.display = 'none';
		}
		else {
			document.getElementById('favorites').style.display = 'block';
		}
	}
}

//Ecom
function popUp(url, name, w, h, extra){
	str="height="+h+",width="+w+","+extra;
	if(parseInt(navigator.appVersion)>3){
		str+=",left="+(screen.width -w)/2+",top="+parseInt((screen.height -h)/2);
	}

	window.open(url,name,str);
}

function Zoom(pic){ 
	if (document.images) {
		popUp('/admin/public/ShowTemplate.aspx?Template=ecom/ViewImage.html&Image='+pic, '_blank',450,350,'resizable=1,scrollbars=1');
	}
}

window.fCopyToClipboard = function(value){
	if(window.clipboardData){ 
		var r=clipboardData.setData('Text',value);
		alert(value + ' now in clipboard.')
	}
	return false;
}

function __ajaxGetXHTTPObject(readyStateFunc) {  
	var xhttp = false;
	if (window.ActiveXObject) {  
        try {  
			// IE 6 and higher 
			xhttp = new ActiveXObject("MSXML2.XMLHTTP"); 
			xhttp.onreadystatechange=readyStateFunc; 
        } catch (e) { 
            try { 
                // IE 5 
                xhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
				xhttp.onreadystatechange=readyStateFunc; 
            } catch (e) { 
                xhttp=false; 
            } 
        } 
	} 
    else if (window.XMLHttpRequest) { 
        try { 
            // Mozilla, Opera, Safari ... 
            xhttp = new XMLHttpRequest();
            /* little hack */
            xhttp.onreadystatechange = function () {
				readyStateFunc();
			};

        } catch (e) { 
            xhttp=false;
        } 
    }

	return xhttp;
}

function __ajaxGetPage(url, readyStateFunc) {
	var xhttp = __ajaxGetXHTTPObject(readyStateFunc);
	if (!xhttp) { 
        return; 
    } 
	
	/* lets get data */
	xhttp.open("GET", url, false);
	xhttp.setRequestHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    xhttp.send(null);
    
    return xhttp.responseText;
}

// ModuleHeader - Gallery
function openSaveGallery(SaveAlertMessage) {
    openGalleryWindow('/Admin/Content/Gallery/MakeGallery.aspx', SaveAlertMessage);
}
function openLoadGallery(SaveAlertMessage) {
    openGalleryWindow('/Admin/Content/Gallery/LoadGallery.aspx', SaveAlertMessage);
}
function openGalleryWindow(url, SaveAlertMessage, doRefresh) {
    if (confirm(SaveAlertMessage)) {
        
        // This can be called on either the 'normal' paragraph edit page or the new edit module settings popup

        if (window["paragraphEvents"] != null && window["paragraphEvents"] != 'undefined') {
            window["paragraphEvents"].beforeSaveInvoke();
        }

        if (parent.Save) {
            // Normal page
            parent.retrieveModuleSettings(function() {
                parent.$('ParagraphForm').request({
                    method: 'post',
                    parameters: {
                        action: 'AjaxSave'
                    },

                    onComplete: function(response) {
                        var paragraphID = response.responseText;
                        parent.$('ID').value = paragraphID;
                        openModalWindow(url + '?ParagraphID=' + paragraphID);
                    }
                });
            });
        }
        else {
            // Popup - Save just the module settings, and then open the window
            $('paragraph_edit').request({
                method: 'post',
                parameters: {
                    action: 'SaveModuleSettings'
                },

                onComplete: function(response) {
                    var paragraphID = parent.document.getElementById('ParagraphID').value;
                    openModalWindow(url + '?ParagraphID=' + paragraphID);
                }
            });
        }
    }
}
function openModalWindow(url) {
    // Changed to not use modal window
    window.open(url, '_blank', 'height=800, width=1024, location=no, menubar=no, status=no, toolbar=no, directories=no, scrollbars=yes');
}

/* ++++++ Registering namespace ++++++ */
if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.eCom) == 'undefined') {
    Dynamicweb.eCom = new Object();
}

Dynamicweb.eCom.PriceHelper = function (intDelimiter, decDelimiter) {
    /// <summary>intDelimiter, decDelimiter.</summary>

    var n = 1.1;
    
    this._localDecDelimiter = n.toLocaleString().substring(1, 2);
    this._localIntDelimiter = this._localDecDelimiter == "." ? "," : ".";
    this._intDelimiter = intDelimiter;
    this._decDelimiter = decDelimiter;
}

Dynamicweb.eCom.PriceHelper.prototype.Format = function (price) {
    var result = "";

    if (!isNaN(price)) {
        var intPart = "", decPart = "";
        var localPrice = price.toString(), digitCount = 0, isDelimiterFound = false;

        if (localPrice.indexOf(this._localDecDelimiter) < 0)
            localPrice = localPrice + this._localDecDelimiter + "00";

        for (var i = localPrice.length - 1; i >= 0; i--) {
            if (isDelimiterFound) {
                digitCount++;
                intPart = ((digitCount == 3 && i > 0) ? this._intDelimiter : "") + localPrice[i] + intPart;
                if (digitCount == 3) digitCount = 0;
            }
            else if (localPrice[i] == this._localDecDelimiter) {
                isDelimiterFound = true;
            }
            else {
                decPart = localPrice[i] + decPart;
            }
        }

        if (decPart != "" || intPart != "") {
            if (intPart == "") intPart = "0";

            if (decPart.length > 2) {
                var n = parseFloat(("0"+this._localDecDelimiter+decPart));
                decPart = n.toFixed(2).substr(2, 2);
            }
            else {
                while (decPart.length < 2) {
                    decPart = decPart + "0";
                }
            }

            result = intPart + this._decDelimiter + decPart;
        }
    }

    return result;
}

Dynamicweb.eCom.PriceHelper.prototype.Parse = function (val) {
    var result = NaN;

    if (val && val != null && val.length > 0) {
        var intPart = "", decPart = "";
        var isDelimiter, isDecDelimiterFound = false;

        if (val.indexOf(this._decDelimiter) < 0)
            val = val + this._decDelimiter + "00";

        for (var i = val.length - 1; i >= 0; i--) {
            isDelimiter = (val[i] == this._intDelimiter || val[i] == this._decDelimiter);

            if (!isDecDelimiterFound && val[i] == this._decDelimiter)
                isDecDelimiterFound = true;

            if (isFinite(val[i])) {
                if (isDecDelimiterFound) intPart = val[i] + intPart;
                else decPart = val[i] + decPart;
            }
            else if ((isDelimiter && !isDecDelimiterFound) || !isDelimiter) {
                intPart = decPart = "";
                break;
            }
        }

        if (intPart != "" || decPart != "") {
            if (!isDecDelimiterFound && decPart != "") {
                intPart = decPart;
                decPart = "";
            }
            else if (isDecDelimiterFound && intPart == "" && decPart != "") {
                intPart = "0";
            }

            var clearedPrice = intPart + this._localDecDelimiter + decPart;
            result = parseFloat(clearedPrice);
        }
    }

    return result;
}