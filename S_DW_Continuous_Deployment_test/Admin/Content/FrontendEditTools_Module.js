/* Page modules collection */
var __page_modules = new ParagraphItemCollection();  

/* Module item menu instance */
var __page_modules_menu = new ParagraphItemMenu('DWEditorModule');

/* Page modules handler */
var __page_modules_handler = new ParagraphItemHandler('DWEditorModule', 'DWFrontendEditorModule');

/*  Stores module menu title for each button type 
    Recognizable items are:
        .add - 'Add' button title.
        .edit - 'Edit' button title.
        .remove - 'Remove' button title.
*/
var __page_modules_menuTitles = [];

/* Represents paragraph module */
var ParagraphModule = function(pid) {
    this.settings = [];
    
    this.settings.pid = pid;
    this.settings.moduleName = '';
    this.settings.moduleSettings = '';
    this.settings.hasModule = false;
    this.progress = new ParagraphItemProgress('DWEditorModule', this.settings.pid);
}

/* Resets all object settings to their defaults */
ParagraphModule.prototype.clear = function() {
    var obj = new ParagraphModule(this.settings.pid);
    this.settings = obj.settings;    
}

/* Loads object settings and saves object in the collection */
ParagraphModule.prototype.load = function(onLoaded) {
    new Ajax.Request('/Admin/Content/FrontendEdit.aspx', {
        method: 'post',
        parameters: { 
            cmd: 'GetModuleSettings', 
            ID: this.settings.pid
        },
	    
        onComplete: function(response) {
            var newObj = new ParagraphModule(response.request.parameters.ID);
            var jsonObj = response.responseText.evalJSON();
	        
	        for(var field in jsonObj)
	            newObj.settings[field] = jsonObj[field];
	            
	        newObj.settings.hasModule = newObj.settings.moduleName.length > 0;
		   
		    __page_modules.setItem(newObj);
		    if(__page_modules_menu.isShownOnParagraph(newObj.settings.pid))
		        __page_modules_menu.setActive(true);
		        
		    if(typeof(onLoaded) == 'function')
                onLoaded(newObj);
        }
    });
}

/* Saves object on the server */
ParagraphModule.prototype.save = function(onSaved) {
    var params = this.settings;
        
    params.cmd = 'SetModuleSettings';
    params.ID = this.settings.pid;
    
    new Ajax.Request('/Admin/Content/FrontendEdit.aspx', {
        method: 'post',
        parameters: params,
        
        onComplete: function(response) {
            if(typeof(onSaved) == 'function')
                onSaved(this);
        }
    });
}

/* Main class for handling page modules */
var ParagraphModuleHandler = function() { }

/* Initializes module editing process */
ParagraphModuleHandler.initialize = function() {
     __page_modules_handler.initialize({
        onItemSelected: function(pid, e) {
            var modObj = new ParagraphModule(pid);
            
            modObj.load(function(loadedObj) {
                e.addClassName('DWFrontendEditorModule_Default');
                
                if(!loadedObj.settings.hasModule)
                    e.addClassName('DWFrontendEditorModule_NoItem');
                else
                    ParagraphModuleHandler.adjustHeight(e);    
            });
        },
        
        onMouseOverItem: ParagraphModuleHandler.mouseOverModule,
        onMouseOutItem: ParagraphModuleHandler.mouseOutModule,
        onInitialized: ParagraphModuleHandler.loadMenuTitles
     });
}

/* Loads menu buttons titles */
ParagraphModuleHandler.loadMenuTitles = function() {
    ParagraphItemJSONLoader.load('/Admin/Content/FrontendEdit.aspx', 
        { cmd: 'GetMenuTitles', target: 'Module' }, function(jsonObj) {
            for(var item in jsonObj)
                __page_modules_menuTitles[item] = jsonObj[item];
        });
}

/* Fires when 'onmouseover' event is occured on module placeholder */
ParagraphModuleHandler.mouseOverModule = function(e) {
    var pid = __page_modules_handler.getPIDFromEvent(e);
    var hasModule = __page_modules_handler.hasItem(pid);
    var isActive = __page_modules.indexOf(pid) >= 0;
    var obj = __page_modules.getItem(pid);
    var items = [];
    var canShow = true;
    
    if(obj)
        hasModule = obj.settings.hasModule;
    
    if(hasModule) {
        items[0] = new ParagraphItemMenuButton('/Admin/Images/Icons/Delete.png', function() {
            ParagraphModuleHandler.confirmDeleteModule(pid);
        }, __page_modules_menuTitles.remove, __page_modules_menuTitles.remove);
        
        items[1] = new ParagraphItemMenuButton('/Admin/Images/context_document_edit.png', function() {
            ParagraphModuleHandler.openSettings(pid);
        }, __page_modules_menuTitles.edit, __page_modules_menuTitles.edit);
    } else {
        items[0] = new ParagraphItemMenuButton('/Admin/Images/Ribbon/Icons/Small/AddGear.png', function() {
            ParagraphModuleHandler.openSettings(pid);
        }, __page_modules_menuTitles.add, __page_modules_menuTitles.add);
    }
    
    if(obj && obj.progress.isVisible())
        canShow = false;
    
    if(canShow)
        __page_modules_menu.show(pid, items, isActive);
}

/* Opens the popup window with module settings */
ParagraphModuleHandler.openSettings = function(pid) {
    var wnd = null;
    var item = __page_modules.getItem(pid);
    
    __page_modules_menu.hide();
    
    if(item) {
        wnd = window.open('/Admin/Content/ParagraphEditModule.aspx?ID=' + pid + '&PageID=' + __page_modules_handler.pageID + 
            '&OnRemoveCallback=ParagraphModuleHandler.deleteModule', 'EditModuleWnd', 'resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=yes,width=650,height=600');
        
        if(wnd)
            wnd.focus();
    }
}

/* Fires when 'onmouseout' event is occured on module placeholder */
ParagraphModuleHandler.mouseOutModule = function(e) {
    var pid = __page_modules_handler.getPIDFromEvent(e);
    __page_modules_menu.hide(pid, e); 
}

/* Displays confirmation message of deleting module */
ParagraphModuleHandler.confirmDeleteModule = function(pid) {
    if(confirm($('FrontendEditingRemoveModule').innerHTML))
        ParagraphModuleHandler.deleteModule(pid);
}

/* Removes specified module content from the page */
ParagraphModuleHandler.deleteModule = function(pid) {
    var obj = __page_modules.getItem(pid);
    var moduleName = obj.settings.moduleName.toLowerCase();
    var params = [];
    
    __page_modules_menu.hide();
    
    if(obj) {
        obj.clear();
        obj.progress.show();
        
        params = obj.settings;
        params.cmd = 'SetModuleSettings';
        params.ID = obj.settings.pid;
        
        new Ajax.Request('/Admin/Content/FrontendEdit.aspx', {
            method: 'post',
            parameters: params,
    		    
            onComplete: function(response) {
                __page_modules_handler.deleteItem({
                    pid: pid,
                    onAfterDelete: function(span) {
                        if(moduleName != 'template' && moduleName != 'templatecolumn') {
                            obj.progress.hide();
                            __page_modules.setItem(obj);
                        }
                        else
                            ParagraphModuleHandler.reloadPage();
                    }
                });
            }
        });
    }
}

/* Sets placeholder height to fixed value if it's tool narrow to hold the menu */
ParagraphModuleHandler.adjustHeight = function(spanObj) {
    if(spanObj.getHeight() < 32)
        spanObj.setStyle({ height: 32 });
    else
        spanObj.writeAttribute('style', '');
}

/* Updates module placeholder */
ParagraphModuleHandler.updateModule = function(pid) {
    var obj = __page_modules.getItem(pid);
    
    if(obj) {
        obj.save(function(savedObj) {
            var url = '/Default.aspx?ID=' +  __page_modules_handler.pageID +
                '&MarkModule=' + pid;
            
            /* Requesting to 'Default.aspx' */
            new Ajax.Request(url, {
                method: 'get',
                
                onComplete: function(response) {
                    var spanObj = $$('span[id="DWEditorModule' + pid + '"]')[0];
                    var moduleName = obj.settings.moduleName.toLowerCase();
                    
                    if(moduleName != 'template' && moduleName != 'templatecolumn') {
                        /* Retrieving only module output from the whole page output */
                        var moduleOutput = ParagraphModuleHandler.getModuleOutput(response.responseText);
                            
	                    if(spanObj) {
	                        spanObj.update(moduleOutput);
        	                
    	                    if(obj.settings.hasModule)
	                            spanObj.removeClassName('DWFrontendEditorModule_NoItem');
	                        else
	                            spanObj.addClassName('DWFrontendEditorModule_NoItem');
    	                        
	                        ParagraphModuleHandler.adjustHeight(spanObj);
	                    }
    	                
	                    obj.progress.hide();
	                } 
	                else 
                        ParagraphModuleHandler.reloadPage();       
                }
            });
        });
    }
}

/* Retrieves module output from page output */
ParagraphModuleHandler.getModuleOutput = function(output) {
    var ret = '';
    var startTag = '<!--ModuleOutputStart-->';
    var endTag = '<!--ModuleOutputEnd-->';
    var startPos = output.indexOf(startTag), endPos = output.indexOf(endTag);
        
    if(startPos >= 0 && endPos >= 0)
        ret = output.substring(startPos + startTag.length, endPos);
    
    return ret;
}

/* Reloads current page */
ParagraphModuleHandler.reloadPage = function() {
    if(PageIsDirty()) {
        if(ConfirmSaveChanges())
            Save(function() {
                setTimeout(function() {
                    window.location.reload(true);
                }, 200);
            });
        else
            window.location.reload(true);
    }
    else
        window.location.reload(true);
}

/* Fired by 'Module settings' window when settings are saved */
function moduleSaved(pid, moduleName, moduleSettings) {
    var obj = __page_modules.getItem(pid);
    
    if(obj) {
        obj.settings.moduleName = moduleName;
        obj.settings.moduleSettings = moduleSettings;
        obj.settings.hasModule = moduleName.length > 0;
        
        __page_modules.setItem(obj);
        __page_modules_menu.hide();
        obj.progress.show();
        
        ParagraphModuleHandler.updateModule(pid);
    }
}

