//*********** FileManager WebControl ************

function morefiles(selected, strCaller, strFolder, strFile) {
    if (selected == 'more') {
        browse(strCaller, strFolder, strFile)
    } 
}

function preview(objFile, Folder){
	if(objFile.selectedIndex == 0){
		return;
	}
    File = encodeURIComponent(objFile.value);

	//window.open("/Admin/FileManager/FileManager_preview.aspx?File=" + File + "&Folder=" + Folder, "", "status:no;dialogWidth:606px;dialogHeight:312px;scroll:no;help:no");
	window.open("/Admin/FileManager/FileManager_preview.aspx?File=" + File + "&Folder=" + Folder, "", "status=no,width=608,height=315,scroll=auto,help=no");
}

function browse(strCaller, strFolder, strFile, allowedExtensions){
    if (strFile != "") {
		//strFolder += "/" + strFile.substring(0, strFile.lastIndexOf("/"));
	}
	if (strFolder.toString().substring(0, 1) == "/") {
		strFolder = strFolder.toString().substring(1, strFolder.length);
    }
    var exts = "";
    if (allowedExtensions && allowedExtensions.length > 0) {
        exts = "&FileManagerAllowedExtensions=" + allowedExtensions;
    }

    var Width = window.screen.width - 200;
    var Height = window.screen.height - 200;
    DW_browse_window = window.open("/Admin/FileManager/Browser/Default.aspx?Mode=browse&Caller=" + strCaller + "&Folder=/" + strFolder + "&strChosenFile=" + strFile + exts, "DW_browse_window", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=" + Width + ",height=" + Height + ",left=200,top=120");
	DW_browse_window.focus();
}

function browseMWMediaDatabase(strCaller) {
    DW_browse_window = window.open("/Admin/Module/MwMediaDatabase/mwMediaDatabase_popup.aspx?Control=" + strCaller, "DW_browse_window", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=800,height=600,left=200,top=120");
    DW_browse_window.focus();
}

function browseExternalMediaDatabase(strCaller, browserUrl) {
    DW_browse_window = window.open(browserUrl + "?Control=" + strCaller, "DW_browse_window", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=800,height=600,left=200,top=120");
    DW_browse_window.focus();
}

function browseFullPath(strCaller, strFolder, strFile, allowedExtensions) {
    var exts = "";
    if (allowedExtensions && allowedExtensions.length > 0) {
        exts = "&FileManagerAllowedExtensions=" + allowedExtensions;
    }    
    DW_browse_window = window.open("/Admin/FileManager/Browser/Default.aspx?Mode=browseFullPath&Caller=" + strCaller + "&Folder=/" + strFolder + "&strChosenFile=" + strFile + exts, "DW_browse_window", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=1024,height=700,left=200,top=120");
	DW_browse_window.focus();
}

function browseArchive(strCaller, strFolder, strFile, allowedExtensions) {
    var exts = "";
    if (allowedExtensions && allowedExtensions.length > 0) {
        exts = "&FileManagerAllowedExtensions=" + allowedExtensions;
    }    
    DW_browse_window = window.open("/Admin/FileManager/Browser/Default.aspx?Mode=browseArchive&Caller=" + strCaller + "&Folder=/" + strFolder + "&strChosenFile=" + strFile + exts, "DW_browse_window", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=1024,height=700,left=200,top=120");
    DW_browse_window.focus();
}

function browseByMode(strCaller, strFolder, strFile, strMode, allowedExtensions) {
    var exts = "";
    if (allowedExtensions && allowedExtensions.length > 0) {
        exts = "&FileManagerAllowedExtensions=" + allowedExtensions;
    }    
    DW_browse_window = window.open("/Admin/FileManager/Browser/Default.aspx?Mode=" + strMode + "&Caller=" + strCaller + "&Folder=/" + strFolder + "&strChosenFile=" + strFile + exts, "DW_browse_window", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=1024,height=700,left=200,top=120");
	DW_browse_window.focus();
}

function WriteWindow(){
	if(top.right.document.body){
		if(!parent.right.document.all.FileWindow){
			top.right.document.body.insertAdjacentHTML("beforeEnd", "<span ID=FileMangerWindowHolder></span>");
			top.right.document.all.FileMangerWindowHolder.innerHTML = CreateWindow();
			return true;
		}else{
			top.right.document.all.FileMangerWindowHolder.style.display = "";
		}
	}
}

function CreateWindow(){
	popup = "";
	popup = popup + '<DIV ID=FileWindow style="display:;position:absolute;top:50px;Left:10px;width:600px;height:280px;">';
	popup = popup + '<iframe src="about:blank" border=0 width=100% height=100% name="FileManagerWindow" frameborder=0></iframe>';
	popup = popup + '</DIV>';
	return popup;
}

function templateActions(action, controlID, folder, useNewEditor, caller, showFullPath) {
    var originalID = null,
        origFolder = folder,
        templatesRoot = 'templates/',
        file = document.getElementById(controlID).value,
        lastSlash = -1,
        params = {},
        url,
        genUrl = function(_url, _params) {
            var prop,
                pair,
                result = _url;
            
            for (prop in _params) {
                if (_params[prop] && _params.hasOwnProperty(prop)) {
                    pair = prop + "=" + _params[prop];
                    if (result.indexOf('?') !== -1) {
                        result += '&' + pair;
                    } else {
                        result += '?' + pair;
                    }
                }
            }

            return result;
        };
    
    if (controlID) {
        originalID = controlID.replace('FM_', '');


        if (origFolder.toLowerCase().indexOf(templatesRoot) >= 0) {
            var hidden = document.getElementById(originalID + '_path');
            if (hidden && hidden.value) {
                var templatesIndex = hidden.value.toLowerCase().indexOf(templatesRoot);
                if (templatesIndex > 0) {
                    file = hidden.value.substring(templatesIndex, hidden.value.length);
                }
            }
        }
    }

    lastSlash = file.lastIndexOf('/');
    if (canExecuteAction(action, originalID)) {
        if (lastSlash >= 0 && lastSlash < (file.length - 1)) {
            folder = file.substring(0, lastSlash);
            folder = folder.replace('../', '');

            if (origFolder.toLowerCase().indexOf(templatesRoot) >= 0 &&
                folder.toLowerCase().indexOf(templatesRoot) < 0) {
                
                folder = templatesRoot + folder;
            }
            
            file = file.substring(lastSlash, file.length).replace('/', '');
        }

        if (action == 'translate') {
            params['File'] = (folder + '/' + file);
            url = genUrl('/Admin/FileManager/Translation/Translation_TranslateTemplate.aspx', params);
        } else {
            params['File'] = file;
            params['Folder'] = folder;
            params['CallerOriginalID'] = originalID;
            params['CallerCallback'] = caller.attributes['data-caller-callback'] ? caller.attributes['data-caller-callback'].value : '';
            params['CallerReload'] = caller.attributes['data-caller-reload'] ? caller.attributes['data-caller-reload'].value : '';
            params['ShowFullPath'] = showFullPath;
            
            url = genUrl('/Admin/FileManager/FileEditor/FileManager_FileEditorV2.aspx', params);
        }

        var wnd = window.open(url, '', 'scrollbars=no,toolbar=no,location=no,directories=no,status=no,resizable=yes');
        wnd.focus();
    }
}

function canExecuteAction(action, controlID) {
    var img = null;
    var ret = true;
    var imgID = 'editImage_' + controlID;
    
    if (action == 'translate') {
       imgID = 'translateImage_' + controlID;
    }

    img = document.getElementById(imgID);

    if (img && _attr(img, '_enabled')) {
        ret = (_attr(img, '_enabled') == 'true');
    }

    return ret;
}

function _attr(obj, attributeName, attributeValue) {
    var ret = null;

    if (obj) {
        if (attributeName) {
            if (!attributeValue) {
                if (typeof (obj.readAttribute) != 'undefined') {
                    ret = obj.readAttribute(attributeName);
                } else if (typeof (obj.getAttribute) != 'undefined') {
                    ret = obj.getAttribute(attributeName);
                }
            } else {
            if (typeof (obj.writeAttribute) != 'undefined') {
                    obj.writeAttribute(attributeName, attributeValue);
                } else if (typeof (obj.setAttribute) != 'undefined') {
                    obj.setAttribute(attributeName, attributeValue);
                }
            }
        }
    }

    return ret;
}

function updateHiddenPath(inputName) {
    var dropDown = document.getElementById('FM_' + inputName)
    var hidden = document.getElementById(inputName + '_path');

    if(dropDown && hidden)
    {
        var selectedOption = dropDown[dropDown.selectedIndex];

        if (selectedOption.attributes['fullPath'])
            hidden.value = selectedOption.attributes['fullPath'].nodeValue;
        else
            hidden.value = '';

        
        if (hidden.onchange) {
            hidden.onchange();
        }

        //hidden.fire('FileManager:HiddenPathChanged');
    }
}

function browseFolder(strCaller, strFolder, strFile) {
    DW_browseFolder_window = window.open("/Admin/Filemanager/Browser/MoveCopy.aspx?Mode=browse&Caller=" + strCaller + "&Folder=" + strFolder, "DW_browsefolder_window", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=320,height=412,left=200,top=120");
    DW_browseFolder_window.focus();
}


//*********** FileArchive WebControl ************

function previewImgFile(objFile) {
    var sFile = encodeURIComponent(objFile.value);
    
    if (sFile.length > 0) {
        window.open('/Admin/FileManager/FileManager_preview.aspx?File=' + sFile, '', 'resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,help=no,width=608,height=315,left=200,top=120').focus();
    }
}