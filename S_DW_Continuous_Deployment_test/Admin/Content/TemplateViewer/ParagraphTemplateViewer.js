var __show_timeoutID = -1;
var __preview_width = 0;
var __preview_category = '';
var __preview_largeID = '';
var __preview_large_show = true;
var __contentInitialized = false;
var __current_templateID = -1;

var ParagraphTemplateViewer = function(settings) {
    if(settings) {
        this.settings = settings;
    } else {
        this.settings = [];
    }
}

/* Fires when user clicks on the template icon */
ParagraphTemplateViewer.prototype.selectTemplate = function(templateID, div) {
    var callback = $(this.settings.callbackID);
    
     if(callback) {
        if(callback.value.length > 0) {
            try {
                this.markSelected($(div));
                $(this.settings.selectedID).value = templateID;
                
                eval(callback.value + '(' + templateID + ');');
            } catch(ex) { }
        }
    }
}

/* Marks given item as selected */
ParagraphTemplateViewer.prototype.markSelected = function(div) {
    var previousSelected = $$('div.chooserItemSelected');
    var wrapped = $(div);
    
    if(previousSelected && previousSelected.length > 0) {
        for(var i = 0; i < previousSelected.length; i++) {
            var elm = previousSelected[i];
            if(elm.readAttribute('controlID') == this.settings.controlID) {   
                elm.removeClassName('chooserItemSelected');
                elm.addClassName('chooserItemNormal');
                
                wrapped.removeClassName('chooserItemNormal');
                wrapped.removeClassName('chooserItemOver');
                wrapped.addClassName('chooserItemSelected');
                
                break;
            }
        }
    }
}

/* Fires when mouse is over an item */
ParagraphTemplateViewer.prototype.itemOver = function(div) {
    var wrapped = $(div);
    
    if(!wrapped.hasClassName('chooserItemSelected')) {
        wrapped.removeClassName('chooserItemNormal');
        wrapped.addClassName('chooserItemOver');
    }
}

/* Fires when mouse is out an item */
ParagraphTemplateViewer.prototype.itemOut = function(div) {
    var wrapped = $(div);
    
    if(!wrapped.hasClassName('chooserItemSelected')) {
        wrapped.removeClassName('chooserItemOver');
        wrapped.addClassName('chooserItemNormal');
    }
}

/* Implements 'Large preview' functionality */
var ParagraphTemplateZoom = function() { }

/* Initializes functionality */
ParagraphTemplateZoom.initialize = function(controlID, previewWidth, templateCategory) {
    __preview_width = previewWidth;
    __preview_largeID = controlID + '_previewLarge';
    __preview_category = templateCategory;
    
    setTimeout(function() {
        ParagraphTemplateZoom.createPlaceholder();
    }, 250);
    
    var items = $$('div[controlID="' + controlID + '"]');
    var childs = null, wrapped;
    
    if(items && items.length > 0) {
        for(var i = 0; i < items.length; i++) {
            childs = items[i].childNodes;
            
            if(childs && childs.length > 0) {
                for(var j = 0; j < childs.length; j++) {
                    var tagName = childs[j].tagName;
                    
                    if(childs[j].nodeName)
                        tagName = childs[j].nodeName;
                    
                    if(tagName && (tagName.toLowerCase() == 'div' || tagName.toLowerCase() == 'img')) {
                        wrapped = $(childs[j]);
                        
                        wrapped.observe('mouseover', function(e) { ParagraphTemplateZoom.mouseOver(e); });
                        wrapped.observe('mousemove', function(e) { ParagraphTemplateZoom.mouseMove(e); });
                        wrapped.observe('mouseout', function(e) { ParagraphTemplateZoom.mouseOut(e); });
                    }
                }
            }
            
        }
    }
}

/* Creates a 'Large preview' layer */
ParagraphTemplateZoom.createPlaceholder = function() {
    var outer = new Element('div', {
        'id': __preview_largeID    
    });
    
    outer.addClassName('chooserPreviewLargeOuter');
    outer.setStyle({ 'display': 'none' });
    
    var inner = new Element('div', {
        'id': __preview_largeID + '_Content'
    });
    
    inner.addClassName('chooserPreviewLargeInner');
    
    outer.insert(inner);
    document.body.appendChild(outer);
}

/* Fires when mouse is over small preview icon */
ParagraphTemplateZoom.mouseOver = function(e) {
    var elm = Event.element(e);
    var x = e.pointerX(), y = e.pointerY();
    var content = '';
    
    var siblings = elm.nextSiblings();
    var contentHolder = null;
    
    if(siblings && siblings.length > 0) {
        for(var i = 0; i < siblings.length; i++) {
            var tagName = siblings[i].tagName;
            
            if(siblings[i].nodeName)
                tagName = siblings[i].nodeName;
                
            if(tagName && tagName.toLowerCase() == 'input') {
                contentHolder = siblings[i];
                content = ParagraphTemplateZoom.htmlDecode(contentHolder.value);
                break;
            }
        }
        
        if(content.length == 0) {
            content = ParagraphTemplateZoom.getProcessHtml();
            ParagraphTemplateZoom.loadPreview(elm, contentHolder);
        }
        
        if(content != 'DISABLE') {
            __current_templateID = $(elm).readAttribute('templateID');
            ParagraphTemplateZoom.show(x, y, content);
            
            __show_timeoutID = setTimeout(function() {
                if(__preview_large_show)
                    ParagraphTemplateZoom.makeVisible();
                else
                    __preview_large_show = true;
            }, 500);
        }    
    }
}

/* Fires when mouse is moving across small preview icon */
ParagraphTemplateZoom.mouseMove = function(e) {
    ParagraphTemplateZoom.move(e.pointerX(), e.pointerY());    
}

/* Fires when mouse is out small preview icon */
ParagraphTemplateZoom.mouseOut = function(e) {
    try {
        clearTimeout(__show_timeoutID);
    } catch(ex) { }
    
    __current_templateID = -1;
    ParagraphTemplateZoom.hide();    
}

ParagraphTemplateZoom.getProcessHtml = function() {
    var elm = $('__paragraphViewer_process');
    var img = null;
    var ret = '';
    
    if(!elm) {
        elm = new Element('span', { id: '__paragraphViewer_process' });
        img = new Element('img', {
            border: 0,
            src: '/Admin/Module/Seo/Dynamicweb_wait.gif'
        });
        
        elm.insert(img);
        elm.setStyle( {display: 'none'} );
        
        document.body.appendChild(elm);
    } 
 
    if(elm)
        ret = elm.innerHTML;
        
    return ret;
}

/* Loads large preview  */
ParagraphTemplateZoom.loadPreview = function(sender, holder) {
    var tmplID = $(sender).readAttribute('templateID');
    
    new Ajax.Request('/Admin/Content/ParagraphEdit.aspx', {
        method: 'post',
        parameters: { 
            cmd: 'GetTemplatePreview', 
            templateID: tmplID,
            width: __preview_width,
            category: __preview_category
        },
	    
        onComplete: function(response) {
            holder.value = response.responseText;
            if(__current_templateID > 0 && __current_templateID == tmplID) {
                ParagraphTemplateZoom.updateContent(holder.value);   
            }
        }
    });
}

/* Decodes HTML content */
ParagraphTemplateZoom.htmlDecode = function(html) {
    var ret = html;
    
    ret = ret.replace(/&lt;/g, '<');
    ret = ret.replace(/&gt;/g, '>');
    ret = ret.replace(/&amp;/g, '&');
    
    return ret;
}

/* Shows large preview in a given position */
ParagraphTemplateZoom.show = function(x, y, content) {
    var container = $(__preview_largeID + '_Content');
    
    if(container) {
        ParagraphTemplateZoom.updateContent(content);
        ParagraphTemplateZoom.move(x, y);
    }
}

/* Updates large preview content */
ParagraphTemplateZoom.updateContent = function(content) {
    var container = $(__preview_largeID + '_Content');
    
    if(container)
         container.update(content);   
}

/* Moves large preview to the given position */
ParagraphTemplateZoom.move = function(x, y) {
    var padding = 10;
    var elmX = x + padding, elmY = y + padding;
    var elm = $(__preview_largeID);
    
    var elmWidth = __preview_width + 25, elmHeight = 380;
    
    if(elm) {
        if((elmX + elmWidth) > document.body.scrollWidth - padding)
            elmX = document.body.scrollWidth - elmWidth - padding;
        
        if((elmY + elmHeight) > document.body.scrollHeight - padding)
            elmY = document.body.scrollHeight - elmHeight - padding;
        
        elm.setStyle( {top: elmY + 'px', left: elmX + 'px' } );
        
        if(!__contentInitialized) {
            var content = $(__preview_largeID + '_Content');
            elm.setStyle( { width: elmWidth, height: elmHeight } );
            content.setStyle( { height: elmHeight - 12 } );
            
            __contentInitialized = true;
        }
    }
}

/* Makes large preview layer visible */
ParagraphTemplateZoom.makeVisible = function() {
    var elm = $(__preview_largeID);
    if(elm) 
        elm.show();
}

/* Hides large preview */
ParagraphTemplateZoom.hide = function() {
    $(__preview_largeID).hide();
}
