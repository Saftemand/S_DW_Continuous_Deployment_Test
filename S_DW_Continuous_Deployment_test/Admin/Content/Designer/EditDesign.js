var submitted = false;
var initialized = false;

function init() {
	for (i = 0; i < document.getElementById("LayoutForm").elements.length; i++) {
		if (document.getElementById("LayoutForm").elements[i].id) {
			var value = elementValue(document.getElementById("LayoutForm").elements[i]);
			window[document.getElementById("LayoutForm").elements[i].id] = value;
			//Event.observe(document.getElementById("LayoutForm").elements[i], 'change', changed);
		}
	}
	initialized = true;
}

function changed() {
	alert("changed...");
}

function checkSubmit(variable) {
    
	if (!submitted) {
	    var value = elementValue(document.getElementById(variable));
		if (window[variable] != value) {
		    //alert(variable + ': ' + window[variable] + ': ' + value);
		    submitAndReload();
		    if (variable == 'ColorSets') {
		        setTimeout("window.location.reload();", 300);
            }
		}
	}
    window[variable] = elementValue(document.getElementById(variable));
    }

function elementValue(element) {
	if (element.type == "checkbox") {
		return element.checked;
	}
	else {
		return element.value;
	}
}

function apply(force) {
	
	if (!initialized) { init(); }
	submitted = false;
	if (force) {
		submitAndReload()
	}
	//alert('!');
	for (i = 0; i < document.getElementById("LayoutForm").elements.length; i++) {
	    if (document.getElementById("LayoutForm").elements[i].id) {
			checkSubmit(document.getElementById("LayoutForm").elements[i].id);
		}
	}

	//colorFrame
	refreshColors();
	//window.parent.document.getElementById('basicColor').value
	//setTimeout("basicColor = document.getElementById('basicColor').value;", 1000);
	if (document.getElementById('previewFrame').src.indexOf('efault.aspx') == -1 && force == true) {
		setTimeout("document.getElementById('previewFrame').src = '/default.aspx?dt=12';", 100);
	}

}

function submitAndReload() {
	//alert(document.getElementById('previewFrame').document.location);
	submitted = true;
	document.LayoutForm.submit();
	var src = document.getElementById('previewFrame').contentWindow.location.href;
	if (src.indexOf("?dt") > 0) {
		src = src.substring(0, src.indexOf("?dt"));
	}
	if (src.indexOf("&dt") > 0) {
		src = src.substring(0, src.indexOf("&dt"));
	}
	//src = src + "?dt=" & new Date().getTime();
	//alert(document.getElementById('previewFrame').contentWindow.location.href + ': ' + src);
	//setTimeout("document.getElementById('previewFrame').src = document.getElementById('previewFrame').src;", 500);
	document.getElementById('previewFrame').contentWindow.location.reload();
	//alert();
}

function close() {
	window.close();
}

function setSelected(color, item) {
	document.getElementById('RichColorSelect').value = color;
	item.parentNode.parentNode.id = color;
}

function refreshColors() {
	refreshColor('LogoBackgroundColor');
	refreshColor('LogoPrimaryColor');
	refreshColor('LogoSecondaryColor');
	refreshColor('NavigationBackgroundColor');
	refreshColor('FormBackgroundColor');
	refreshColor('BodyBackgroundColor');
	refreshColor('CallToActionColor');
	refreshColor('NavigationFontColor');
	refreshColor('H1FontColor');
	refreshColor('H2FontColor');
	refreshColor('H3FontColor');
	refreshColor('TextFontColor');

}

function refreshColor(selectName) {
	var key = 'colorgroups';
	var regex = new RegExp("[\\?&]" + key + "=([^&#]*)");
	var qs = '';
	qs = regex.exec(document.getElementById(selectName + 'Frame').src);
	if (qs == null) {
		qs = new Array('', '');
	}
	document.getElementById(selectName + 'Frame').src = 'ColorGen.aspx?colorgroups=' + qs[1] + '&parent=' + selectName + '&hex=' + document.getElementById('basicColor').value.replace("#", "");
}
