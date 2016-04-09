/* Base class for handling paragraph items (images, modules) */
var ParagraphItemHandler = function(idContext, classContext) {
    this.idContext = idContext;
    this.classContext = classContext;
    this.pageID = this.getPageID();
}

/* Retrieves page ID */
ParagraphItemHandler.prototype.getPageID = function() {
    var pattern = /(\?|&)ID=([0-9]+)/
    var href = document.location.href;
    var ret = '0';
    
    if(parent && parent.document) {
        href = parent.document.location.href;
        pattern = /(\?|&)PageID=([0-9]+)/
    }
    
    if(href.length > 0) {
        ret = href.match(pattern);
        if(ret && ret.length > 2)
            ret = ret[2];
    }
    
    return ret;
}

/* Checks whether any of the collection items was changed */
ParagraphItemHandler.prototype.isDirty = function(itemCollection) {
    var ret = false;
    
    for(var i = 0; i < itemCollection.count(); i++) {
        ret = itemCollection.items[i].settings.isDirty;
        if(ret)
            break;
    }
    
    return ret;
}

/*  Initializes paragraph items 
    parameters:
        onItemSelected(pid, e): function to be called when new item is selected.
        onMouseOverItem(e): function to be called when mouse is over item area.
        onMouseOutItem(e): function to be called when mouse is out item area.
*/
ParagraphItemHandler.prototype.initialize = function(params) {
    if(params && params.onItemSelected) {
        var items = $$('span[class="' + this.classContext + '"]');
        
        if(items && items.length > 0) {
            for(var i = 0; i < items.length; i++) {
                var e = items[i];
                var pid = this.getPID(e.readAttribute('id'));
                
                if(pid.length > 0) {
                    if(typeof(params.onItemSelected) == 'function')
                        params.onItemSelected(pid, e);
                    
                    if(params.onMouseOverItem && typeof(params.onMouseOverItem) == 'function')
                        e.observe('mouseover', params.onMouseOverItem);
                        
                    if(params.onMouseOutItem && typeof(params.onMouseOutItem) == 'function')
                        e.observe('mouseout', params.onMouseOutItem);
                }
            }
            
            if(typeof(params.onInitialized) == 'function')
                params.onInitialized();
        }
    } 
}

/* Saves all items */
ParagraphItemHandler.prototype.saveAll = function(itemCollection, checkIsDirty, onComplete) {
    if (typeof (RequestQueue) != 'undefined') {
        this._saveAllQueue(itemCollection, checkIsDirty, onComplete);
    } else {
        this._saveAllNormal(itemCollection, checkIsDirty, onComplete);
    }
}

/*ParagraphItemHandler.prototype._saveItem = function(item, checkIsDirty, onComplete) {
    if (typeof (checkIsDirty) != 'undefined' && checkIsDirty) {
        if (item.settings.isDirty) {
            item.save(onComplete);
        }
    } else {
        item.save(onComplete);
    }
}*/

ParagraphItemHandler.prototype._saveAllQueue = function(itemCollection, checkIsDirty, onComplete) {
    var itemsToSave = [];
    //var func = this._saveItem;
    var queue = new RequestQueue();

    if (itemCollection && itemCollection.count() > 0) {
        for (var i = 0; i < itemCollection.count(); i++) {
            if (typeof (checkIsDirty) != 'undefined' && checkIsDirty) {
                if (itemCollection.items[i].settings.isDirty)
                    itemsToSave[itemsToSave.length] = itemCollection.items[i];
            } else {
                itemsToSave[itemsToSave.length] = itemCollection.items[i];
            }
        }
    }

    if (itemsToSave.length > 0) {
        for (var i = 0; i < itemsToSave.length; i++) {
            queue.add(this, function(item, onComplete) { item.save(onComplete); }, [itemsToSave[i], function() {
                if (queue.capacity == 0) {
                    if (typeof (onComplete) == 'function') {
                        onComplete();
                    }
                } else {
                    queue.next();
                }
            } ]);
        }
    } else {
        if (typeof (onComplete) == 'function') {
            onComplete();
        }
    }

    /*if (itemCollection && itemCollection.count() > 0) {
        queue.capacity = itemCollection.count();

        for (var i = 0; i < itemCollection.count(); i++) {
            queue.add(this, func, [itemCollection.items[i], checkIsDirty, function() {
                if (queue.capacity == 0) {
                    if (typeof (onComplete) == 'function') {
                        onComplete();
                    }
                } else {
                    queue.next();
                }
            } ]);
        }
    } else {
        if (typeof (onComplete) == 'function') {
            onComplete();
        }
    }*/
}

ParagraphItemHandler.prototype._saveAllNormal = function(itemCollection, checkIsDirty, onComplete) {
    var item = null;

    for (var i = 0; i < itemCollection.count(); i++) {
        item = itemCollection.items[i];
        if (typeof (checkIsDirty) != 'undefined' && checkIsDirty) {
            if (item.settings.isDirty)
                item.save();
        } else {
            item.save();
        }
    }

    if (typeof (onComplete) == 'function')
        onComplete();
}

/*  Removes current item contents from the page 
    parameters:
        pid: item PID.
        onAfterDelete(containter): function to be called after item contents are removed.
*/
ParagraphItemHandler.prototype.deleteItem = function(params) {
    if(params && params.pid) {
        var containter = $$('span[id="' + this.idContext + params.pid + '"]')[0];
        
        if(containter) {
            while(containter.firstChild)
                containter.removeChild(containter.firstChild);
            containter.addClassName(this.classContext + '_NoItem');
            
            if(params.onAfterDelete && typeof(params.onAfterDelete) == 'function') {
                params.onAfterDelete(containter);
            }
        }
    }
}

/* Determines whether specified paragraph contains item */
ParagraphItemHandler.prototype.hasItem = function(pid) {
    var obj = $$('span[id="' + this.idContext + pid + '"]')[0];
    return obj.firstChild != null;
}

/* Retrieves paragraph ID from SPAN tag 'ID' attribute */
ParagraphItemHandler.prototype.getPID = function(spanID) {
    return spanID.replace(this.idContext, '');
}

/* Retrieves SPAN tag 'ID' attribute when 'onmouseover' or 'onmouseout' event is occured */
ParagraphItemHandler.prototype.getPIDFromEvent = function(e) {
    var elm = Event.element(e);
    var pid = '';
    var parents = 0;
    
    while(pid.length == 0 && elm) {
        if((elm.readAttribute('id') + '').indexOf(this.idContext) >= 0) {
            pid = this.getPID(elm.readAttribute('id'));
            break;
        }
        else
            /* the sender is not a SPAN tag (bubbling) - traversing up */
            elm = elm.up();
    }
    
    return pid;
}

/* Represents the collection of items */
var ParagraphItemCollection = function() {
    this.items = [];
    this.locked = false;
}

/* Retrieves an item from collection by paragraph ID */
ParagraphItemCollection.prototype.getItem = function(pid) {
    var ret = null;
    var index = this.indexOf(pid);
    
    if(index >= 0)
        ret = this.items[index];
    
    return ret;
}

/* Adds (or updates) a collection item according to its paragraph ID */
ParagraphItemCollection.prototype.setItem = function(obj) {
    var index = -1;
    var clone = null;
    
    if(this.locked) {
        clone = this;
        setTimeout(function() {
            clone.setItem(obj);
        }, 50);
    } 
    else {
        /* critical section start */
        this.locked = true;
                
        index = this.indexOf(obj);
        if(index >= 0)
            this.items[index] = obj;
        else 
            this.items[this.items.length] = obj;
                
        /* critical section end */
        this.locked = false;
    }
}

/* Retrieves the 0-based index of item in the collection */
ParagraphItemCollection.prototype.indexOf = function(obj) {
    var pid = -1, ret = -1;
    
    /* object passed - retrieving property value */
    if(typeof(obj) == 'object')
        pid = obj.settings.pid;
    else
        pid = obj;
        
    for(var i = 0; i < this.items.length; i++) {
        if(this.items[i].settings.pid == pid) {
            ret = i;
            break;
        }
    }
    
    return ret;
}

/* Retrieves the collection size */
ParagraphItemCollection.prototype.count = function() {
    return this.items.length;
}

/* Represents paragraph menu item */
var ParagraphItemMenuButton = function(icon, action, alt, text) {
    this.icon = icon;
    this.action = action;
    this.alt = alt;
    this.text = text;
}

ParagraphItemMenuButton.prototype.get_width = function() {
    var ret = 0;
    var elm = new Element('span');

    elm.setStyle({'display': 'none'});
    elm.update('<img src="' + this.icon + '" border="0" />' + this.text);
    document.body.appendChild(elm);
    ret = elm.getWidth() + 30;
    elm.remove();

    return ret;
}

/* Represents paragraph menu */
var ParagraphItemMenu = function(context, css, menuID) {
    this.context = context;
    this.id = context + 'Menu';

    if (menuID)
        this.id = menuID;

    this.currentPID = -1;
    //this.cssClass = 'Toolbar DWFrontendEditorItemMenu';
    this.cssClass = 'Toolbar DWFrontendEditorItemMenu';

    if (css)
        this.cssClass = css + ' DWFrontendEditorItemMenu';
}

/* Shows the menu on the given paragraph placeholder */
ParagraphItemMenu.prototype.show = function(pid, menuItems, isActive) {
    var cmd = null;
    var totalWidth = 0;
    var menu = $(this.id);
    var container = null;
    var outerContainer = null;
    var spanObj = $$('span[id="' + this.context + pid + '"]')[0];
    var spanPosition = spanObj.cumulativeOffset();
    var ie7Compliance = $$('meta[content="IE=7"]');
    var forceCompatible = false;
    
    if (ie7Compliance && ie7Compliance.length > 0) {
        forceCompatible = true;
    }

    if (!menu) {
        menu = new Element('div', {
            'id': this.id
        });

        document.body.appendChild(menu);
    }

    this.clear(menu);

    outerContainer = new Element('div', { 'class': 'innerContainer' });
    container = new Element('ul');

    outerContainer.insert(container);
    menu.insert(outerContainer);

    menu.writeAttribute('class', this.cssClass);
    /*if (!forceCompatible) {
        menu.writeAttribute('style', '*width: 1px;');
    }*/

    if (menuItems && menuItems.length > 0) {
        for (var i = 0; i < menuItems.length; i++) {
            totalWidth += menuItems[i].get_width();
            container.insert(this.createButton(menuItems[i]));
        }

        ParagraphItemMenu.hideAll();
        menu.show();

        menu.setStyle({
            'top': spanPosition.top + 2 + 'px',
            'left': spanPosition.left + 2 + 'px'
        });

        this.currentPID = pid;
        this.setActive(isActive);
    }
}

/* Hides all visible menus */
ParagraphItemMenu.hideAll = function() {
    $$('div.DWFrontendEditorItemMenu').each(function(elm) {
        $(elm).hide();
    });
}

/* Removes all buttons from the menu */
ParagraphItemMenu.prototype.clear = function(menuObj) {
    var elm = null;
    while((elm = menuObj.down()))
        elm.remove();   
}

/* Adds new button to the menu */
ParagraphItemMenu.prototype.createButton = function(button) {
    var container = new Element('li');
    var alt = '', text = '';

    if (button.alt && typeof (button.alt) != 'undefined')
        alt = button.alt;

    if (button.text != null && typeof (button.text) != 'undefined')
        text = button.text;

    var sp = new Element('span', {
        'class': 'toolbar-button-container'
    });

    var img = new Element('img', {
        'src': button.icon,
        'alt': alt
    });

    var link = new Element('a', {
        'href': 'javascript:void(0);',
        'title': alt,
        'class': 'toolbar-button'
    });

    if (button.action)
        sp.observe('click', button.action);

    container.insert(link);
    link.insert(sp);
    sp.insert(img);
    
    sp.innerHTML += ('&nbsp;' + text);

    return container;
}

/* Hides the menu */    
ParagraphItemMenu.prototype.hide = function(pid, e) {
    var obj = $(this.id);
    
    if(pid && e) {
        if(obj && this.pointerIsOutside(pid, e)) {
            obj.hide();
            this.currentPID = -1;
        }
    } else {
        obj.hide();
        this.currentPID = -1;
    }
}

/* Determines whether mouse pointer is outside paragraph placeholder */    
ParagraphItemMenu.prototype.pointerIsOutside = function(pid, e) {
    var x = e.pointerX(), y = e.pointerY();
    var imgObj = $$('span[id="' + this.context + pid + '"]')[0];
    var objPosition = imgObj.cumulativeOffset();
    
    return ((x <= objPosition.left || x >= (objPosition.left + imgObj.getWidth())) || 
        (y <= objPosition.top || y >= (objPosition.top + imgObj.getHeight())));
}

/* Updates menu active state */    
ParagraphItemMenu.prototype.setActive = function(active) {
    var obj = $(this.id);
    var styles = {
        'opacity': (active ? '1.0' : '0.4'),
        'filter': 'alpha(opacity = ' + (active ? '100' : '40') + ')'
    };
    
    if(obj)
        obj.setStyle(styles);
}

/* Determines whether menu is active */
ParagraphItemMenu.prototype.isActive = function() {
    var obj = $(this.id);
    var ret = false;
    
    if(obj && obj.getStyle('display') != 'none') {
        ret = ((obj.getStyle('filter') + '').indexOf('40') < 0 ||
            obj.getStyle('opacity') != '0.4');
    }
    
    return ret;
}

/* Determines whether menu is shown on the specified paragraph */    
ParagraphItemMenu.prototype.isShownOnParagraph = function(pid) {
    return (pid == this.currentPID);
}

/* Represents item progress - indication that item is being processed */
var ParagraphItemProgress = function(context, pid) {
    this.context = context;
    this.pid = pid;
    this.menu = new ParagraphItemMenu(this.context, 'DWFrontendEditorItemProgress', 
        'DWFrontendEditorProgress' + pid);
}

/* Shows progress */
ParagraphItemProgress.prototype.show = function() {
    this.menu.show(this.pid, [ new ParagraphItemMenuButton('/Admin/Module/Seo/Dynamicweb_wait.gif', 
        function() { return false; }) ], true);
}

/* Hides progress */
ParagraphItemProgress.prototype.hide = function() {
    this.menu.hide();
}

/* Determines whether progress is visible */
ParagraphItemProgress.prototype.isVisible = function() {
    return this.menu.isShownOnParagraph(this.pid);
}

/* Represents helper object for loading JSON data  */
var ParagraphItemJSONLoader = function() { }

ParagraphItemJSONLoader.load = function(url, params, onLoaded) {
    new Ajax.Request(url, {
        method: 'post',
        parameters: params,
	    
        onComplete: function(response) {
            if(typeof(onLoaded) == 'function')
                onLoaded(response.responseText.evalJSON());
        }
    });
}
