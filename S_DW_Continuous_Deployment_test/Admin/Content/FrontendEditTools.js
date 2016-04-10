var cssList = new Array();
var editorAreas = new Array();
var counter = 0;

if(window.attachEvent)
    window.attachEvent('onload', function() { StartEditing(); });
else if(window.addEventListener)
    window.addEventListener('load', function(e) { StartEditing(); }, false);

function StartEditing() {
	if(parent && parent.document.getElementById('xToolbar')) {
	    parent.document.getElementById("xToolbar").innerHTML = "";
	    var i = 0;
	    $$('link[rel="stylesheet"]').each(function(e) {
		    cssList[i] = e.readAttribute("href");
		    i++;
	    });
	    $$('link[rel="Stylesheet"]').each(function(e) {
		    cssList[i] = e.readAttribute("href");
		    i++;
	    });
    	
	    i=0;
	    $$('span.DWFrontendEditor').each(function(e) {
		    editorAreas[i] = e.readAttribute("id");
		    i++;
	    });
	    //<span id="DWEditor1" class="DWFrontendEditor">

	    for (var i = 0; i < editorAreas.length; i++) {
	        MakeSpanTextarea(editorAreas[i]);
	    }

	    ParagraphImageHandler.initialize();
	    ParagraphModuleHandler.initialize();
	    
	    waitForEditor(function() {
	        for (var i = 0; i < editorAreas.length; i++) {
	            initializeEditor(FCKeditorAPI.GetInstance(editorAreas[i]));
	        }
	    });
	}
}

function Save() {
    var oEditor;
    var editorsToSave = [];
    var queue = new RequestQueue();
    var paragraphID = '', paragraphText = '';

    if (editorAreas && editorAreas.length > 0) {
        window.parent.Ribbon.disableButton('Save');

        for (var i = 0; i < editorAreas.length; i++) {
            oEditor = FCKeditorAPI.GetInstance(editorAreas[i]);

            if (oEditor.IsDirty()) {
                editorsToSave[editorsToSave.length] = oEditor;
            }
        }

        if (editorsToSave.length > 0) {
            queue.capacity = editorsToSave.length;

            for (var i = 0; i < editorsToSave.length; i++) {
                paragraphID = editorsToSave[i].Name.replace('DWEditor', '');
                paragraphText = editorsToSave[i].GetXHTML(false);

                queue.add(this, SaveHTML, [paragraphID, paragraphText, function() {
                    if (queue.capacity == 0) {
                        ParagraphImageHandler.saveAll(function() {
                            window.parent.Ribbon.enableButton('Save');
                        });
                    } else {
                        queue.next();
                    }
                } ]);
            }
                setTimeout("window.parent.Ribbon.enableButton('Save')", 1250);
        } else {
            ParagraphImageHandler.saveAll(function() {
                window.parent.Ribbon.enableButton('Save');
            });
        }
    }
}

function waitForEditor(onSuccess) {
    if (typeof (FCKeditorAPI) != 'undefined') {
        if (typeof (onSuccess) == 'function') {
            onSuccess();
        }
    } else {
        setTimeout(function() { waitForEditor(onSuccess); }, 200);
    }
}

function ConfirmSaveChanges() {
    var msg = window.parent.document.getElementById('mSaveChanges').innerHTML;
    return confirm(msg);
}

function PageIsDirty() {
    var ret = false;
    var oEditor = null;
    
    ret = ParagraphImageHandler.isDirty();
    
    if(!ret) {
        for(var i = 0; i < editorAreas.length; i++) {
            ret = FCKeditorAPI.GetInstance(editorAreas[i]).IsDirty();
            if(ret)
                break;
        }
    }
    
    return ret;
}

function SaveHTML(ParagraphID, Paragraphtext, onSaved) {
    new Ajax.Request('/Admin/Content/FrontendEdit.aspx', {
        method: 'post',
        parameters: { cmd: 'save', ID: ParagraphID, ParagraphText: Paragraphtext },
        onComplete: function(transport) {
            if (typeof (onSaved) == 'function')
                onSaved();
        }
    });
}

function MakeSpanTextarea(name) {
	if (document.getElementById(name)) {
		var sHeight = document.getElementById(name).offsetHeight + 10 + "px";
		var sWidth = document.getElementById(name).offsetWidth + 2 + "px";
		var sHtml = '<textarea scrolling="no" name="' + name + '" style="width:' + sWidth + ';height:' + sHeight + '">' + FCKeditor.prototype._HTMLEncode(document.getElementById(name).innerHTML) + '<\/textarea>';
		document.getElementById(name).innerHTML = sHtml;

		var sBasePath = "/Admin/Editor/"
		var oFCKeditor = new FCKeditor(name);
		
		oFCKeditor.MinHeight = sHeight;
		oFCKeditor.MinWidth = sWidth;
		oFCKeditor.Width = sWidth;
		oFCKeditor.Height = sHeight;
		oFCKeditor.BasePath = sBasePath;
		
		oFCKeditor.Config['SkinPath'] = "/admin/editor/editor/skins/Office2007Real/";
		oFCKeditor.Config['EditorAreaCSS'] = cssList;
		oFCKeditor.Config['EditorAreaStyles'] = 'body { margin: 0px;overflow:hidden; } #xEditingArea{border: #696969 0px solid;}';
		oFCKeditor.Config['ToolbarCanCollapse'] = "false";
		oFCKeditor.Config['ToolbarLocation'] = 'Out:parent(xToolbar)';
		oFCKeditor.Config['CustomConfigurationsPath'] = "/Admin/Editor/fckconfig.js";
				
		oFCKeditor.ToolbarSet = 'DwFrontendEditing';
		oFCKeditor.ReplaceTextarea();
	}
}

function setToolbarTransparency() {
    var nodeName = '';
    var container = parent.document.getElementById('xToolbar');
    
    if (container && container.setAttribute) {
        for (var i = 0; i < container.childNodes.length; i++) {
            if (container.childNodes[i].nodeName) {
                nodeName = container.childNodes[i].nodeName.toLowerCase();
                if (nodeName == 'iframe') {
                    container.childNodes[i].allowTransparency = true;
                }
            }
        }
    }
}

function initializeEditor(editorInstance) {
    editorInstance.Events.AttachEvent('OnSelectionChange', EditorChanged);
    setToolbarTransparency();
}

function EditorChanged(editorInstance) {
	counter++;
	SetEditorSize(editorInstance);
}

function SetEditorSize(editorInstance) {
    var height = editorInstance.EditorDocument.body.scrollHeight;
	
	if (height < 20) {
		height = 20;
	}
	document.getElementById(editorInstance.Name + "___Frame").height = ((height + 5) + "px");
}