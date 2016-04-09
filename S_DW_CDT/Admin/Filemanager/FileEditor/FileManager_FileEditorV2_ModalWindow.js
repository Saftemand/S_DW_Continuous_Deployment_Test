if (typeof (Editor) == 'undefined') {
    Editor = new Object();
}

Editor.__mw_windows = [];
Editor.__mw_current = null;
Editor.__mw_popup = null;

Editor.ModalWindowArgs = function() {
    this._cancel = false;
}

Editor.ModalWindowArgs.prototype.get_cancel = function() {
    return this._cancel;
}

Editor.ModalWindowArgs.prototype.set_cancel = function(value) {
    this._cancel = value;
}

Editor.ModalWindow = new Object();

Editor.ModalWindow.initialize = function(instance) {
    Editor.__mw_popup = instance;

    if (Editor.__mw_popup) {
        Editor.__mw_popup.add_load(Editor.ModalWindow.onLoad);
        Editor.__mw_popup.add_ok(Editor.ModalWindow.onOK);
        Editor.__mw_popup.add_cancel(Editor.ModalWindow.onCancel);
    }
}

Editor.ModalWindow.windowInstance = function() {
    return Editor.__mw_popup;
}

Editor.ModalWindow.register = function(name, params) {
    if (!params) {
        params = {};
    }

    if (name || params.name) {
        if (name) {
            params.name = name;
        }
        
        if (params.name && !Editor.ModalWindow.isRegistered(name)) {
            Editor.__mw_windows[params.name] = params;
        }
    }
}

Editor.ModalWindow.isRegistered = function(name) {
    var ret = false;

    if (!Editor.__mw_windows) {
        Editor.__mw_windows = [];
    }

    if (name) {
        for (var existingWindow in Editor.__mw_windows) {
            if (existingWindow.toLowerCase() == name.toLowerCase()) {
                ret = true;
                break;
            }
        }
    }

    return ret;
}

Editor.ModalWindow.isVisible = function() {
    var ret = false;

    if (Editor.__mw_popup) {
        ret = Editor.__mw_popup.get_isVisible();
    }

    return ret;
}

Editor.ModalWindow.contentDocument = function() {
    var ret = null;

    if (Editor.__mw_popup) {
        ret = Editor.__mw_popup.get_contentDocument();
    }

    return ret;
}

Editor.ModalWindow.show = function(name, args) {
    var current = null;
    var paramQuery = '';
    var oldContent = null;
    var dialogTypeParam = '';
    var updateContent = false;
    var handler = '/Admin/Filemanager/FileEditor/dialogs/FileManager_DialogContent.aspx?';

    

    if (!args) {
        args = {};
    }

    if (args.parameters) {
        for (var key in args.parameters) {
            paramQuery += (key + '=' + encodeURIComponent(args.parameters[key]) + '&');
        }
    }
    
    
    
    if (Editor.__mw_popup) {
        if (Editor.__mw_popup.get_isVisible() && Editor.__mw_current) {
            Editor.ModalWindow.hide(Editor.__mw_current);
        }

        if (Editor.ModalWindow.isRegistered(name)) {
            Editor.__mw_current = name;
            current = Editor.ModalWindow.current();

            if (current) {
                dialogTypeParam = 'DialogType=' + current.name;
                oldContent = Editor.__mw_popup.get_contentUrl();
                updateContent = oldContent.indexOf(dialogTypeParam) < 0;
                
                Editor.__mw_popup.set_contentUrl(handler + paramQuery + dialogTypeParam);

                if (current) {
                    if (current.width) Editor.__mw_popup.set_width(current.width);
                    if (current.height) Editor.__mw_popup.set_height(current.height);
                    if (current.title) Editor.__mw_popup.set_title(current.title);
                }

                Editor.__mw_popup.show();

                if (!updateContent && current && current.onInitialize) {
                    current.onInitialize(this, {});
                }

                if (updateContent) {
                    Editor.__mw_popup.reload();
                }
            }

        }
    }
}

Editor.ModalWindow.find = function(selector) {
    var ret = null;
    var doc = Editor.ModalWindow.contentDocument();

    try {
        if (doc && doc.body && selector && selector.length > 1) {
            if (selector.indexOf('#') == 0) {
                ret = $(doc.getElementById(selector.substr(1)));
            } else {
                ret = Element.select(doc.body, selector);
                if (ret && ret.length > 0) {
                    ret = $(ret[0]);
                }
            }
        }
    } catch (ex) { }

    return ret;
}

Editor.ModalWindow.hide = function(name) {
    var args = new Editor.ModalWindowArgs();
    var current = Editor.ModalWindow.current();

    if (Editor.__mw_popup && current) {
        if (current.onFinalize) {
            current.onFinalize(this, args);
        }

        if (!args.get_cancel()) {
            Editor.__mw_popup.hide();
            Editor.__mw_current = '';
        }
    }
}

Editor.ModalWindow.center = function() {
    if (Editor.__mw_popup && Editor.__mw_popup.get_isVisible()) {
        Editor.__mw_popup.center();
    }
}

Editor.ModalWindow.isContentOf = function(name) {
    var ret = false;
    var current = Editor.ModalWindow.current();

    if (name) {
        if (current && Editor.__mw_popup && Editor.__mw_popup.get_isVisible()) {
            if (current.name) {
                ret = current.name.toLowerCase() == name.toLowerCase();
            }
        }
    }

    return ret;
}

Editor.ModalWindow.moveTo = function(x, y) {
    if (Editor.__mw_popup && Editor.__mw_popup.get_isVisible()) {
        Editor.__mw_popup.moveTo(x, y);
    }
}

Editor.ModalWindow.current = function() {
    var ret = null;

    if (Editor.ModalWindow.isRegistered(Editor.__mw_current)) {
        ret = Editor.__mw_windows[Editor.__mw_current];
    }

    return ret;
}

Editor.ModalWindow.onLoad = function(sender, args) {
    var w = null
    var frame = null;
    var current = Editor.ModalWindow.current();
    
    if (Editor.__mw_popup && current) {
        if (current.objectLink) {
            frame = Editor.__mw_popup.get_contentFrame();
            w = frame.contentWindow ? frame.contentWindow : frame.window;
            w[current.objectLink.child] = window[current.objectLink.parent];
        }

        if (Editor.__mw_popup.get_isVisible()) {
            if (current.onInitialize) {
                current.onInitialize(this, args);
            }
        }
    }
}

Editor.ModalWindow.onOK = function(sender, args) {
    var e = new Editor.ModalWindowArgs();
    var current = Editor.ModalWindow.current();
    
    if (Editor.__mw_popup && current) {
        if (current.onOK) {
            current.onOK(this, e);
        }

        args.set_cancel(e.get_cancel());
    }
}

Editor.ModalWindow.onCancel = function(sender, args) {
    var e = new Editor.ModalWindowArgs();
    var current = Editor.ModalWindow.current();

    if (Editor.__mw_popup && current) {
        if (current.onCancel) {
            current.onCancel(this, e);
        }

        args.set_cancel(e.get_cancel());
    }
}

/*************  "Save as"  dialog implementation *************/

var SaveAsDialog = new Object();

SaveAsDialog.initialize = function (sender, args) {
    SaveAsDialog.setOkButtonText('OK');
    SaveAsDialog.updateOkState();
}

SaveAsDialog.show = function(fileConvertedRazor, fileConvertedXslt) {
    var initialFile = $("InitialFileName");
    var initialFolder = $("InitialFileDir");
    var file;
    var folder;
    
    if (initialFile.value == '') {
        file = 'NewFile.html';
    } else {
        file = initialFile.value;
    }
    
    if (initialFolder.value == '') {
        folder = '/Folder/';
    } else {
        folder = initialFolder.value;
    }

    if (fileConvertedRazor == true) {
        file = file.replace(/\.(?:html)$/i, '');
        file += '.cshtml';
    }

    if (fileConvertedXslt == true) {
        file = file.replace(/\.(?:html)$/i, '');
        file += '.xslt';
    }
    
    Editor.ModalWindow.show('SaveAsDialog', {
        parameters: { FileName: file, FolderName: folder }
    });
}

SaveAsDialog.ok = function(sender, args) {
    SaveAsDialog.execute();
    args.set_cancel(true);
}

SaveAsDialog.cancel = function(sender, args) {
    __snc_state_wait = false;
    SaveAsDialog.close();
}

/* Centers dialog */
SaveAsDialog.center = function() {
    Editor.ModalWindow.center();
}

/* Determines whether dialog is opened */
SaveAsDialog.isActive = function() {
    return Editor.ModalWindow.isVisible() &&
        Editor.ModalWindow.isContentOf('SaveAsDialog');
}

/* Closes dialog */
SaveAsDialog.close = function() {
    Editor.ModalWindow.hide('SaveAsDialog');
}

/* Updates the state of the "OK" button */
SaveAsDialog.updateOkState = function() {
    var ok = Editor.ModalWindow.windowInstance().get_okButton();

    if (ok) {
        ok.disabled = !SaveAsDialog.validate();
    }
}

/* Fires when the response from 'CheckFile' operation has come */
SaveAsDialog.onFileChecked = function (data) {

    var fileName = Editor.ModalWindow.find('input.saveas-filename').value;
    var dropdownControlId = "FM_" + $('WindowCallerOriginalID').value;
    var templatePathControlId = $('WindowCallerOriginalID').value + "_path";
    var templatePath = "/Files/" + $('InitialFileDir').value + "/" + fileName;
    var showFullPath = $('InitialFileFullPath').value.toLowerCase() === "true";

    var ret = true;
    var onSave = function () {
        toggleProcessing(false);

        if (window.opener) {
            if (window.opener.frames && window.opener.frames.FileManagerListFolder) {
                window.opener.frames.FileManagerListFolder.location.reload();
            }
            window.opener.focus();

            /* Add NewFile to Select menu and bind templatePath */
            window.opener.$(templatePathControlId).value = templatePath;
            var optionName = fileName;
            if (showFullPath) {
                if (templatePath.indexOf("/Files/Templates/Designs/") === 0)
                    optionName = templatePath.substring(templatePath.indexOf("/", "/Files/Templates/Designs/".length + 1) + 1);
                else
                    optionName = templatePath.replace("/Files/Templates/", "");
            }
            window.opener.selectNewOption(optionName, dropdownControlId, data);
        }
        window.close();
    }

    toggleProcessing(false, Editor.ModalWindow.find('#pSaveAsLoading'));
    
    /* File with given name already exists */
    if (data == "1")
        ret = showMessage('mFileExists', true);

    if (ret) {
        Editor.doSave(onSave, true);
        SaveAsDialog.close();
    }
}

/* Fires when the response from 'CheckDirectory' operation has come */
SaveAsDialog.onDirectoryChecked = function(data) {
    var ret = true;

    toggleProcessing(false, Editor.ModalWindow.find('#pSaveAsLoading'));
    
    /* Directory with given name doesn't exist */
    if (data == "1")
        ret = showMessage('mDirectoryDoesNotExist', true);

    if (ret)
        SaveAsDialog.checkFile();
}

/* Fires when user clicks on the folder in a folder manager */
SaveAsDialog.onSelectFolder = function(node) {
    var val = node.Value;
    var staticDirectory = Editor.ModalWindow.find('span.saveas-static-directory');
    
    if (val.length > 35) {
        val = val.substring(0, 35) + '...';
        staticDirectory.writeAttribute('title', node.Value);
    }
    else
        staticDirectory.writeAttribute('title', '');

    staticDirectory.innerHTML = val;
}

/* Validates form */
SaveAsDialog.validate = function() {
    var ret = true;

    ret = Editor.ModalWindow.find('input.saveas-filename').value.length > 0;

    return ret;
}

/* 'Enter' key handler */
SaveAsDialog.onTextChange = function(code) {
    var ret = true;

    if (code == 13) {
       SaveAsDialog.execute();
       ret = false;
    }

    return ret;
}

/* Performs a checking operation on the specified file name */
SaveAsDialog.checkFile = function() {
    var self = this;
    var dir = this.getDirectory()[0];

    var params = {
        Action: 'CheckFile',
        FileName: Editor.ModalWindow.find('input.saveas-filename').value,
        FileDirectory: dir,
        InitialFileName: $$('input.initial-filename')[0].value,
        InitialFileDirectory: $$('input.initial-directory')[0].value
    }

    toggleProcessing(true, Editor.ModalWindow.find('#pSaveAsLoading'));

    new Ajax.Request('FileManager_FileEditorV2.aspx', {
        method: 'post',
        parameters: params,
        onComplete: function(response) { self.onFileChecked(response.responseText); }
    });
}

/* Performs a checking operation on the specified directory */
SaveAsDialog.checkDirectory = function(dir) {
    var self = this;

    var params = {
        Action: 'CheckDirectory',
        FileDirectory: dir
    }

    toggleProcessing(true, Editor.ModalWindow.find('#pSaveAsLoading'));

    new Ajax.Request('FileManager_FileEditorV2.aspx', {
        method: 'post',
        parameters: params,
        onComplete: function(response) { self.onDirectoryChecked(response.responseText); }
    });
}

/* Fires when dialog form is submited */
SaveAsDialog.execute = function(autoClose) {
    var ret = true;
    var needsToCheckDirectory = false;
    var dirArgs = this.getDirectory();
    var dir = dirArgs[0];

    if (this.validate()) {
        if (dirArgs[1])
            this.checkDirectory(dir);
        else
            this.checkFile();
    } else {
        ret = false;
    }

    return ret;
}

/* Retrieves file directory (first array element) and value indicating that directory needs to be checked (second array element) */
SaveAsDialog.getDirectory = function () {
    var val = null;
    var dir = new Array('', false);
    var staticDirectory = Editor.ModalWindow.find('span.saveas-static-directory');
    
    if (staticDirectory.innerHTML) {
        dir[0] = staticDirectory.innerHTML;
    } else {
        val = Editor.ModalWindow.find('#FLDM_txDirectory');

        if (val) {
            dir[0] = val.value;
        } else {
            dir[0] = '/Files/Templates';
        }

        dir[1] = true;
    }

    return dir;
}

/* Sets an "OK" button text */
SaveAsDialog.setOkButtonText = function (value) {
    var cmd = null;
    var popup = Editor.ModalWindow.windowInstance();

    if (popup) {
        cmd = popup.get_okButton();
        if (cmd) {
            cmd.innerHTML = value;
        }
    }
}

/*************  "XSLT transform" dialog routines *************/

var XsltDialog = new Object();

/* Gets or sets callback function that will be called when user click "Save anyway" */
XsltDialog.SaveCallback = null;

/* Gets or sets callback function that will be called when dialog is shown */
XsltDialog.ShowCallback = null;

/* Gets or sets fields that needs to be initialized inside the dialog */
XsltDialog.Fields = {};

/* Performs initialization */
XsltDialog.initialize = function() {
    var field = null;
    
    XsltDialog.setOkButtonText($('mSaveAnyway').innerHTML);

    if (typeof (XsltDialog.ShowCallback) != 'undefined') {
        XsltDialog.ShowCallback();
    }

    if (XsltDialog.Fields) {
        for (var id in XsltDialog.Fields) {
            field = Editor.ModalWindow.find('#' + id);
            if (field) {
                field.value = XsltDialog.Fields[id];
            }
        }
    }
}

/* Performs finalization */
XsltDialog.finalize = function() {
    XsltDialog.setOkButtonText($('mSaveOK').innerHTML);

    XsltDialog.ShowCallback = null;
    XsltDialog.SaveCallback = null;
    XsltDialog.Fields = {};
}

/* Handles "OK" action */
XsltDialog.ok = function(sender, args) {
    if (typeof (XsltDialog.SaveCallback) != 'undefined') {
        XsltDialog.SaveCallback();
    }

    XsltDialog.finalize();
}

/* Handles "Cancel" action */
XsltDialog.cancel = function(sender, args) {
    __snc_state_wait = false;
    XsltDialog.close();
}

/* Show dialog */
XsltDialog.show = function(params) {
    if (!params) {
        params = {};
    }

    if (params.onShow) {
        XsltDialog.ShowCallback = params.onShow;
    }

    if (params.onSave) {
        XsltDialog.SaveCallback = params.onSave;
    }

    if (params.fields) {
        XsltDialog.Fields = params.fields;
    }

    Editor.ModalWindow.show('XsltDialog');
}

/* Called when user accepts parse erorrs and clicks "Save anyway" button */
XsltDialog.errorsAccepted = function() {
    Editor.doSave(null, true, true);
    Page.closeAllDialogs();
}

/* Sets an "OK" button text */
XsltDialog.setOkButtonText = function(value) {
    var cmd = null;
    var popup = Editor.ModalWindow.windowInstance();
    
    if (popup) {
        cmd = popup.get_okButton();
        if (cmd) {
            cmd.innerHTML = value;
        }
    }
}

/* Centers dialog */
XsltDialog.center = function() {
    Editor.ModalWindow.center();
}

/* Determines whether dialog is opened */
XsltDialog.isActive = function() {
    return Editor.ModalWindow.isVisible() &&
        Editor.ModalWindow.isContentOf('XsltDialog');
}

/* Closes dialog */
XsltDialog.close = function() {
    Editor.ModalWindow.hide('XsltDialog');
}

/* Sets an error message for the dialog */
XsltDialog.setError = function(error) {
    Editor.ModalWindow.find('#dErrorDescription').innerHTML = error;
}

/*************  "Tree" supply object *************/

var TagsTree = function(name) {
    this.name = '__tree_' + name;
    this.innerName = name;
    this.obj = null;
    this.currentID = 0;
    this.source = null;
    this.links = [];
}

/* Creates a tree */
TagsTree.prototype.buildTree = function(containerID, source) {
    this.obj = new dTree(this.name);
    this.obj.config.showRoot = false;
    this.links = [];

    this.source = source;

    if (this.source) {
        this.obj.add(0, -1, $('mTags').innerHTML, this.getOnClick(false));

        if (this.hasTags()) {
            this.createTreeNodes(0, this.source.selectSingleNode('/' + $('TemplateTagsPath').value));

            eval(this.name + ' = __trees[\'' + this.innerName + '\'].obj;');
            $(containerID).innerHTML = this.obj.toString();

            /* attaching events to all 'tag' nodes */
            for (var i = 0; i < this.links.length; i++) {
                var link = $('s' + this.name + this.links[i][0]);

                createEvent(link, 'mouseover', function(e) {
                    e.__source = source;
                    TemplateTagsDialog.showTooltip(e);
                });

                createEvent(link, 'mouseout', function(e) { TemplateTagsDialog.hideTooltip(); });
                createEvent(link, 'mousemove', function(e) { TemplateTagsDialog.moveTooltip(e); });
                createEvent(link, 'click', function(e) { TemplateTagsDialog.insertTag(e); });
            }
        } else {
            $(containerID).innerHTML = $('mNoTagsFound').innerHTML;
        }
    } else {
        $(containerID).innerHTML = $('mNoTagsFound').innerHTML;
    }
}

/* Determines whether loaded xml file contains any tags information */
TagsTree.prototype.hasTags = function() {
    var ret = false;
    var root = null;

    if (this.source) {
        root = this.source.selectNodes('/' + $('TemplateTagsPath').value);

        if (root && root.length > 0)
            ret = root[0].childNodes.length > 0;
    }

    return ret;
}

/* Creates tree nodes from the specified node and down (deep)  */
TagsTree.prototype.createTreeNodes = function(parentID, node) {
    /* ommiting CDATA sections */
    if (node.nodeType != 4) {
        var name = attr(node, 'name');
        var isGroup = node.nodeName == 'group' ? true : false;
        var onClick = '';

        if (name) {
            this.currentID++;
            onClick = isGroup ? this.getOnClick(this.currentID, false) :
			    this.getOnClick(this.currentID, true, name, attr(node, 'id'));
            this.obj.add(this.currentID, parentID, name, onClick);
        }

        if (node.childNodes.length > 0) {
            parentID = this.currentID;
            for (var i = 0; i < node.childNodes.length; i++)
                this.createTreeNodes(parentID, node.childNodes[i]);
        }
    }
}

/* Returns the 'onclick' event for specified tree node */
TagsTree.prototype.getOnClick = function(nodeID, eventForTag, tagName, tagID) {
    var ret = 'javascript:void(0);';

    if (eventForTag && typeof (tagName) != 'undefined') {
        this.links[this.links.length] = [nodeID, tagName];

        ret = [];
        ret['tagID'] = tagID;
    }
    else if (nodeID > 0)
        ret = 'javascript:' + this.name + '.o(' + nodeID + ');';

    return ret;
}

/*************  "Template tags" dialog routines *************/

var TemplateTagsDialog = new Object();

var __trees = [];
var __tagsLoaded = false;
var __canHideTooltip = true;
var __tooltipInitialized = false;
var __tooltipHideTimeout = -1;

/* Tree wrappers */
__trees['general'] = new TagsTree('general');
__trees['module'] = new TagsTree('module');

/* dTree objects */
var __tree_general = null;
var __tree_module = null;


/* Loads the tags containing xml file */
TemplateTagsDialog.loadTags = function(e) {
    var self = this;

    this.show(e);
    
    var data = {
        Action: 'GetTemplateTags',
        TagsPath: $('TemplateTagsPath').value
    }

    new Ajax.Request('FileManager_FileEditorV2.aspx', {
        method: 'post',
        parameters: data,
        onComplete: function(response) { self.onTagsLoaded(response); }
    });
}

/* Fires when tags containing xml file is loaded */
TemplateTagsDialog.onTagsLoaded = function(data) {
    var moduleTagsSource = null, generalTagsSource = null;
    var dataXml = '';
    var serializer = null;
    var generalGroup = null;
    var root = null;

    if (data) {
        dataXml = data.responseText;

        /* Creating separate XmlDocument objects to manipulate with */
        moduleTagsSource = TemplateTagsDialog.createXmlDocument(dataXml);
        generalTagsSource = TemplateTagsDialog.createXmlDocument(dataXml);

        /* Removing 'General tags' node from the 'Module' tags data source */
        generalGroup = moduleTagsSource.selectSingleNode('/' + $('TemplateTagsPath').value + '/group[@type="general"]');
        if (generalGroup)
            generalGroup.parentNode.removeChild(generalGroup);

        root = generalTagsSource.documentElement;

        /* Clearing 'General tags' document */
        while (root.firstChild)
            root.removeChild(root.firstChild);

        /* Appending only 'General tags' section to the clean document */
        while (generalGroup.firstChild)
            root.appendChild(generalGroup.firstChild);

        __trees['general'].buildTree('TagsTreeGeneral', generalTagsSource);
        __trees['module'].buildTree('TagsTree', moduleTagsSource);
        
        TemplateTagsDialog.initializeTooltipElement();

        __tagsLoaded = true;
    }
}

TemplateTagsDialog.initializeTooltipElement = function() {
    var tooltip = $('TagTooltip');

    if (!__tooltipInitialized) {
        createEvent(tooltip, 'mouseover', function(e) {
            __canHideTooltip = false;
        });

        createEvent(tooltip, 'mouseout', function(e) {
            __canHideTooltip = true;
            TemplateTagsDialog.hideTooltip();
        });

        __tooltipInitialized = true;
    }
}

/* Retrieves an XmlDocument object according to provided xml string */
TemplateTagsDialog.createXmlDocument = function(xmlString) {
    var doc = null;
    var parser = null;

    if (window.ActiveXObject) {
        doc = new ActiveXObject("Microsoft.XMLDOM")
        doc.async = "false"
        doc.loadXML(xmlString)
    } else if (document.implementation.createDocument) {
        parser = new DOMParser()
        doc = parser.parseFromString(xmlString, "text/xml")
    } 

    return doc;
}

/* Shows tag tooltip on the given tag */
TemplateTagsDialog.showTooltip = function(e) {
    var evt = e ? e : window.event;
    var target = eventTarget(evt);
    var tooltipContent = '';
    var source = e.__source;

    TemplateTagsDialog.hideTooltip(true);

    if (source) {
        var t = source.selectSingleNode('//tag[@id="' + attr(target, 'tagID') + '"]');

        if (t)
            tooltipContent = t.childNodes[0].nodeValue;
    }

    if (tooltipContent.length > 0) {
        var tooltip = $('TagTooltip');

        tooltip.show();
        this.moveTooltip(evt);
        tooltip.innerHTML = tooltipContent;
    }
}

/* Moves tag tooltip according to mouse position */
TemplateTagsDialog.moveTooltip = function(e) {
    var evt = e ? e : window.event;
    var tooltip = $('TagTooltip');
    var padding = 10;
    var x = evt.clientX + padding;
    var y = evt.clientY + padding;

    if ((x + tooltip.getWidth()) > document.body.clientWidth - padding)
        x = document.body.clientWidth - tooltip.getWidth() - padding;

    if ((y + tooltip.getHeight()) > document.body.clientHeight - padding)
        y = document.body.clientHeight - tooltip.getHeight() - padding;

    if (tooltip.getStyle('display') != 'none') {
        tooltip.setStyle({ top: y + 'px', left: x + 'px' });
    }
}

/* Hides tag tooltip */
TemplateTagsDialog.hideTooltip = function(noDelay) {
    var f = function() {
        if (__canHideTooltip) {
            $('TagTooltip').hide();
        }
    }

    if (__tooltipHideTimeout) {
        clearTimeout(__tooltipHideTimeout);
    }

    if (noDelay) {
        f();
    } else {
        __tooltipHideTimeout = setTimeout(f, 100);
    }
}

/* Inserts specified tag into current caret position */
TemplateTagsDialog.insertTag = function(e) {
    var code = Editor.getCode();
    var evt = e ? e : window.event;
    var target = eventTarget(evt);
    var tag = '<!--@' + $(target).innerHTML + '-->';

    if (code.indexOf('xsl:stylesheet') >= 0)
        tag = '<xsl:value-of select="' + $(target).innerHTML + '" disable-output-escaping="yes" />';

    //Editor.InternalObject.instance.focus();
    Editor.InternalObject.instance.editor.cursorActivity(false);
    Editor.InternalObject.instance.replaceSelection(tag);
    //txText.editor.insertCode(tag, false);

    Editor.updateUndoRedoStates();
}

/* Toggles the tags dialog visibility */
TemplateTagsDialog.toggle = function(e) {
    var active = false;
    var container = $('pTemplateTags');

    if (container) {
        active = container.getStyle('display') != 'none';
    }

    if (active)
        this.close();
    else {
        if (!__tagsLoaded)
            this.loadTags(e);
        else
            this.show(e);
    }
}

/* Shows the tags dialog */
TemplateTagsDialog.show = function(e) {
    var style = { right: '251px' };
    var container = $('pTemplateTags');

    if (container) {
        container.show();
    }

    Page.toggleRibbonbarButton('cmdToggleTemplateTags', true);

    $('rowEditingArea').setStyle(style);
    $($$('div.CodeMirror-wrapping')[0]).setStyle(style);
    TemplateTagsSlider.reset();
}

/* Closes the tags dialog */
TemplateTagsDialog.close = function() {
    var style = { right: '0px' };
    var container = $('pTemplateTags');

    Page.toggleRibbonbarButton('cmdToggleTemplateTags', false);
    if (container) {
        container.hide();
    }

    $('rowEditingArea').setStyle(style);
    $($$('div.CodeMirror-wrapping')[0]).setStyle(style);
}

/*************  "Find/Replace" dialog routines *************/

var FindDialog = new Object();

var __find_cursor = null;
var __find_isVisible = false;
var __find_eventsInitialized = false;
var __find_menu = null;
var __find_skipClick = false;

FindDialog.initialize = function() {
    var menu = $('pSearch');
    var findField = $('txFind');

    FindDialog.hideReplace();
    FindDialog.updateFindState();

    __find_cursor = null;

    try {
        findField.focus();
    } catch (ex) { }

    __find_isVisible = true;
    FindDialog.fadeIn();

    if (!__find_eventsInitialized) {
        if (menu) {
            menu.observe('focus', FindDialog.fadeIn);
            menu.observe('click', function() {
                //if(!isIE()) {
                    if(__find_skipClick) {
                        __find_skipClick = false;
                    } else {
                        FindDialog.fadeIn()
                    }
                //} else {
                //    FindDialog.fadeIn();
                //}
            });
        }

        __find_eventsInitialized = true;
    }
}

FindDialog.close = function() {
    ContextMenu.hide('cmFind');
    Ribbon.unhoverButton('cmdFindReplace');
}

FindDialog.finalize = function() {
    __find_isVisible = false;
}

FindDialog.isVisible = function() {
    return __find_isVisible;
}

FindDialog.getMenuElement = function() {
    if (!__find_menu) {
        __find_menu = $('cmFind') || $('pSearch').up('.contextmenu');
    }

    return __find_menu;
}

FindDialog.showReplace = function() {
    var replaceField = $('txReplace');

    $('pReplaceText').hide();
    $('pReplace').show();

    try {
        replaceField.focus();
    } catch (ex) { }
}

FindDialog.hideReplace = function() {
    $('pReplaceText').show();
    $('pReplace').hide();
}

FindDialog.reset = function() {
    var pos = Editor.InternalObject.instance.getCursor();

    __find_cursor = null;
    Editor.InternalObject.instance.setSelection(pos);
}

FindDialog.updateFindState = function() {
    var enabled = $('txFind').value.length > 0;

    $$('.button-find button')[0].disabled = !enabled;
    $$('.button-replace button')[0].disabled = !enabled;
    $$('.button-replace-all button')[0].disabled = !enabled;
}

FindDialog.searchTextChanged = function(code) {
    var ret = true;

    if (code == 13) {
        FindDialog.executeFindNext();
        ret = false;
    } else {
        __find_cursor = null;
    }

    return ret;
}

FindDialog.replaceTextChanged = function(code) {
    var ret = true;

    if (code == 13) {
        FindDialog.executeReplace();
        ret = false;
    } else {
        __find_cursor = null;
    }

    return ret;
}

FindDialog.canExecute = function() {
    return !$('txFind').disabled;
}

FindDialog.executeFindNext = function(fromButton) {
    if (fromButton) {
        __find_skipClick = true;
    }

    if (FindDialog.canExecute()) {
        if (!FindDialog.findNext()) {
            alert($('mSearchingDone').innerHTML);
            FindDialog.reset();
        }
    }
}

FindDialog.executeReplace = function(fromButton) {
    if (fromButton) {
        __find_skipClick = true;
    }

    if (FindDialog.canExecute()) {
        if (FindDialog.selectionMatches())
            FindDialog.replaceSelection();
        else if (FindDialog.findNext())
            FindDialog.replaceSelection();
        else {
            alert($('mSearchingDone').innerHTML);
            FindDialog.reset();
        }
    }
}

FindDialog.executeReplaceAll = function(fromButton) {
    var replacedCount = 0;

    if (fromButton) {
        __find_skipClick = true;
    }

    if (FindDialog.canExecute()) {
        while (FindDialog.findNext()) {
            FindDialog.replaceSelection();
            replacedCount++;
        }

        alert($('mReplaced').innerHTML.replace('%%', replacedCount));
    }
}

/* Finds and highlights next match */
FindDialog.findNext = function () {
    var ret = false;
    var text = $('txFind').value;
    var matchCase = $('chkMatchCase').checked;

    if (__find_cursor == null) {
        var start = Editor.InternalObject.instance.firstLine();
        __find_cursor = Editor.InternalObject.instance.getSearchCursor(text, start, !matchCase);
    }

    if (__find_cursor) {
        if (__find_cursor.findNext()) {
            ret = true;
            Editor.InternalObject.instance.setSelection(__find_cursor.from(), __find_cursor.to());

            FindDialog.fadeOut();
        }
    }

    return ret;
}

FindDialog.fadeIn = function() {
    var c = $('pSearch');
    var contextMenu = $('cmFind');

    if (!contextMenu) {
        contextMenu = c.up('.contextmenu');
    }

    if (contextMenu) {
        contextMenu.removeClassName('search-panel-fade-out');
    }
}

FindDialog.fadeOut = function() {
    var c = $('pSearch');
    var contextMenu = $('cmFind');

    if (!contextMenu) {
        contextMenu = c.up('.contextmenu');
    }

    if (contextMenu) {
        contextMenu.addClassName('search-panel-fade-out');
    }
}

/* Replaces current match with value from 'Replace' text field */
FindDialog.replaceSelection = function() {
    var replacement = $('txReplace').value;

    if (__find_cursor) {
        __find_cursor.replace(replacement);
    }
}

/* Retrieves selected text */
FindDialog.getSelection = function() {
    return Editor.InternalObject.instance.getSelection();
}

/* Determines whether currently selected text matches value in 'Find' text field */
FindDialog.selectionMatches = function() {
    var selection = FindDialog.getSelection();
    var ret = false;

    if (selection && selection.length > 0)
        ret = (selection == $('txFind').value);

    return ret;
}

/* Set search text value in 'Find' text field */
FindDialog.setSearchText = function (searchText) {
    if (searchText !== undefined)
        $('txFind').value = searchText;
    else
        $('txFind').value = FindDialog.getSelection();
}



