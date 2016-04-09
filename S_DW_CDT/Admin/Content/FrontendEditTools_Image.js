/* Page images collection */
var __page_images = new ParagraphItemCollection();  

/* Image item menu instance */
var __page_images_menu = new ParagraphItemMenu('DWEditorImage');

/* Page images handler */
var __page_images_handler = new ParagraphItemHandler('DWEditorImage', 'DWFrontendEditorImage');

/*  Stores image menu title for each button type 
    Recognizable items are:
        .add - 'Add' button title.
        .edit - 'Edit' button title.
        .remove - 'Remove' button title.
*/
var __page_images_menuTitles = [];

/* Represents paragraph image */
var ParagraphImage = function(pid) {
    this.settings = [];
    
    this.settings.pid = pid;
    this.settings.fileName = '';
    this.settings.url = '';
    this.settings.target = '';
    this.settings.alt = '';
    this.settings.caption = '';
    this.settings.resize = false;
    this.settings.verticalAlign = 'left';
    this.settings.verticalSpace = 0;
    this.settings.horizontalAlign = 'top';
    this.settings.horizontalSpace = 0;
    this.settings.hasImage = false;
    this.settings.isDirty = false;
    this.progress = new ParagraphItemProgress('DWEditorImage', this.settings.pid);
}

/* Returns a new instance of the class - used from outside */
ParagraphImage.create = function(pid) {
    var obj = new ParagraphImage(pid);
    return obj;
}

/* Updates collection item with passed object - used from outside */
ParagraphImage.modifyCollection = function(obj) {
    __page_images.setItem(obj);
    ParagraphImageHandler.setIsDirty(obj, true);
}

/* Resets all object settings to their defaults */
ParagraphImage.prototype.clear = function() {
    var obj = new ParagraphImage(this.settings.pid);
    this.settings = obj.settings;    
}

/* Loads object settings and saves object in the collection */
ParagraphImage.prototype.load = function() {
    if(this.settings.hasImage) {
        new Ajax.Request('/Admin/Content/FrontendEdit.aspx', {
	        method: 'post',
	        parameters: { 
	            cmd: 'GetImageSettings', 
	            ID: this.settings.pid
	        },
		    
	        onComplete: function(response) {
	            var newObj = new ParagraphImage(response.request.parameters.ID);
	            var jsonObj = response.responseText.evalJSON();
		        
		        for(var field in jsonObj)
		            newObj.settings[field] = jsonObj[field];
		            
		        newObj.settings.hasImage = newObj.settings.fileName.length > 0;
			   
			    __page_images.setItem(newObj);
			    if(__page_images_menu.isShownOnParagraph(newObj.settings.pid))
			        __page_images_menu.setActive(true);
	        }
        });
    }
    else
        __page_images.setItem(this);
}

/* Saves image */
ParagraphImage.prototype.save = function(onComplete) {
    var params = this.settings;

    params.cmd = 'SetImageSettings';
    params.ID = this.settings.pid;

    ParagraphImageHandler.setIsDirty(this, false);

    new Ajax.Request('/Admin/Content/FrontendEdit.aspx', {
        method: 'post',
        parameters: params,
        onComplete: function() {
            if (typeof (onComplete) == 'function')
                onComplete();
        }
    });
}

/* Retrieves all object settings as query string URI part */
ParagraphImage.prototype.toQueryString = function() {
    return 'ParagraphImage=' + encodeURIComponent(this.settings.fileName) +
        '&ParagraphImageURL=' + encodeURIComponent(this.settings.url) + 
        '&ParagraphImageTarget=' + encodeURIComponent(this.settings.target) + 
        '&ParagraphImageMouseOver=' + encodeURIComponent(this.settings.alt) + 
        '&ParagraphImageCaption=' + encodeURIComponent(this.settings.caption) + 
        '&ParagraphImageResize=' + this.settings.resize.toString() +
        '&ParagraphImageVAlign=' + this.settings.verticalAlign + 
        '&ParagraphImageVSpace=' + this.settings.verticalSpace + 
        '&ParagraphImageHAlign=' + this.settings.horizontalAlign + 
        '&ParagraphImageHSpace=' + this.settings.horizontalSpace;
}

/* Main class for handling paragraph image manipulations */
var ParagraphImageHandler = function() { }

/* Initializes image editing process */
ParagraphImageHandler.initialize = function() {
    __page_images_handler.initialize({
        onItemSelected: function(pid, e) {
            var imgObj = new ParagraphImage(pid);
            imgObj.settings.hasImage = __page_images_handler.hasItem(pid);

            imgObj.load();

            e.addClassName('DWFrontendEditorImage_Default');
            if (!imgObj.settings.hasImage)
                e.addClassName('DWFrontendEditorImage_NoItem');
        },

        onMouseOverItem: ParagraphImageHandler.mouseOverImage,
        onMouseOutItem: ParagraphImageHandler.mouseOutImage,
        onInitialized: ParagraphImageHandler.loadMenuTitles

    });
}

/* Loads menu buttons titles */
ParagraphImageHandler.loadMenuTitles = function() {
    ParagraphItemJSONLoader.load('/Admin/Content/FrontendEdit.aspx', 
        { cmd: 'GetMenuTitles', target: 'Image' }, function(jsonObj) {
            for(var item in jsonObj)
                __page_images_menuTitles[item] = jsonObj[item];
        });
}

/* Saves all page images */
ParagraphImageHandler.saveAll = function(onComplete) {
    __page_images_handler.saveAll(__page_images, true, onComplete);
}

/* Retrieves value indicating whether any of the images was changed */
ParagraphImageHandler.isDirty = function() {
    return __page_images_handler.isDirty(__page_images);
}

/* Sets image 'isDirty' property */
ParagraphImageHandler.setIsDirty = function(obj, isDirty) {
    obj.settings.isDirty = isDirty;
    __page_images.setItem(obj);
}

/* Fires when 'onmouseover' event is occured on image placeholder */
ParagraphImageHandler.mouseOverImage = function(e) {
    var pid = __page_images_handler.getPIDFromEvent(e);
    var hasImage = __page_images_handler.hasItem(pid);
    var isActive = __page_images.indexOf(pid) >= 0;
    var items = [];
    var imgObj = __page_images.getItem(pid);
    var canShow = true;
    
    if(hasImage) {
        items[0] = new ParagraphItemMenuButton('/Admin/Images/Icons/Delete.png', function() {
            ParagraphImageHandler.deleteImage(pid);
        }, __page_images_menuTitles.remove, __page_images_menuTitles.remove);
        
        items[1] = new ParagraphItemMenuButton('/Admin/Images/context_document_edit.png', function() {
            ParagraphImageHandler.openSettings(pid);
        }, __page_images_menuTitles.edit, __page_images_menuTitles.edit);
    } else {
        items[0] = new ParagraphItemMenuButton('/Admin/Images/Icons/Image_Edit.gif', function() {
            ParagraphImageHandler.openSettings(pid);
        }, __page_images_menuTitles.add, __page_images_menuTitles.add);
    }
    
    if(imgObj && imgObj.progress.isVisible())
        canShow = false;
    
    if(canShow)
        __page_images_menu.show(pid, items, isActive);
}

/* Opens the popup window with image settings */
ParagraphImageHandler.openSettings = function(pid) {
    var wnd = null;
    var item = __page_images.getItem(pid);
    
    __page_images_menu.hide();
    if(item) {
        wnd = window.open('/Admin/Content/ParagraphImageSettings.aspx?FrontendPID=' + pid + '&' + item.toQueryString(), 'EditImageWnd',  
            'resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=520,height=450');
        
        if(wnd)
            wnd.focus();
    }
}

/* Fires when 'onmouseout' event is occured on image placeholder */
ParagraphImageHandler.mouseOutImage = function(e) {
    var pid = __page_images_handler.getPIDFromEvent(e);
    __page_images_menu.hide(pid, e); 
}

/* Updates paragraph image by loading the new content from the server */
ParagraphImageHandler.updateImage = function(pid) {
    var imgObj = __page_images.getItem(pid);
    var params = [];
    var spanObj = null;
    
    if(imgObj) {
        params = imgObj.settings;
        params.cmd = 'UpdateImage';
        params.ID = pid;
        
        imgObj.progress.show();
        
        ParagraphImageHandler.setIsDirty(imgObj, true);
        
        new Ajax.Request('/Admin/Content/FrontendEdit.aspx', {
	        method: 'post',
	        parameters: params,
		    
	        onComplete: function(response) {
	            spanObj = $$('span[id="DWEditorImage' + pid + '"]')[0];
	            if(spanObj) {
	                spanObj.update(response.responseText);
	                
	                if(imgObj.settings.hasImage)
	                    spanObj.removeClassName('DWFrontendEditorImage_NoItem');
	                else
	                    spanObj.addClassName('DWFrontendEditorImage_NoItem');
	                    
	                imgObj.progress.hide();
	            }
	        }
        });
    }
}

/* Removes image from current paragraph */
ParagraphImageHandler.deleteImage = function(pid) {
    if(confirm($('FrontendEditingRemoveImage').innerHTML)) {
        __page_images_handler.deleteItem({
            pid: pid,
            onAfterDelete: function(span) {
                var imgObj = __page_images.getItem(pid);
                if(imgObj) {
                    imgObj.clear();
                    __page_images.setItem(imgObj);
            
                    ParagraphImageHandler.setIsDirty(imgObj, true);
                    __page_images_menu.hide();
                }    
            }
        });
    }
}













