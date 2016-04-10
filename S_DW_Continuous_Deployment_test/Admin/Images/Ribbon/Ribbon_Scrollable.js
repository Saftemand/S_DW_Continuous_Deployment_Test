/* Implements scrollable content inside ribbonbar */
var RibbonbarScrollable = function(instanceName, scrollableID, expression) {
    this.instance = instanceName;
    this.id = scrollableID;
    this.expression = expression;
    this.current = 0;
    this.rows = [];
    this.contentInitialized = false;
}

/* Enables scrollable functionality */
RibbonbarScrollable.prototype.initialize = function()  {
    var name = this.instance;
    
    if(window.attachEvent)
        window.attachEvent('onload', function() { eval(name + '.initializeRows();'); });
    else if(window.addEventListener)
        window.addEventListener('DOMContentLoaded', function(e) { eval(name + '.initializeRows();'); }, false);
}

/* Initializes scrollable area */
RibbonbarScrollable.prototype.initializeRows = function() {
    var contentWidth = '';
    var scrollContent = $(this.id + '_scrollContent');
    
    if(this.expression && this.expression.length > 0) {
        if(scrollContent.getStyle('width').length > 0)
            contentWidth = parseInt(scrollContent.getStyle('width').replace('px', ''));
        else
            contentWidth = scrollContent.getWidth();
        
        this.rows = $$('#' + this.id + '_scrollContent ' + this.expression);
        this.current = 0;
        
        if(!this.rows)
            this.rows = [];
            
        this.initializeButton('ScrollUp');
        this.initializeButton('ScrollDown');
        this.initializeButton('More');
        
        $(this.id + '_scrollMain').setStyle({
            width: contentWidth + 15 + 'px'
        });
        
        $(this.id + '_contentColumn').setStyle({
            width: contentWidth + 'px'
        });
            
        RibbonbarScrollable.updateButtonState($(this.id + '_ScrollUp'),
            RibbonbarScrollable.buttonState.disabled);
            
        if(this.rows.length == 0) {
            RibbonbarScrollable.updateButtonState($(this.id + '_ScrollDown'),
                RibbonbarScrollable.buttonState.disabled);
                
            RibbonbarScrollable.updateButtonState($(this.id + '_More'),
                RibbonbarScrollable.buttonState.disabled);
        }
    }
}

/* Fires when 'scroll up' button is pressed */
RibbonbarScrollable.prototype.actionScrollUp = function(button) {
    if(!RibbonbarScrollable.buttonIsDisabled(button))
        this.scrollTo(this.current - 1);
}

/* Fires when 'scroll down' button is pressed */
RibbonbarScrollable.prototype.actionScrollDown = function(button) {
    if(!RibbonbarScrollable.buttonIsDisabled(button))
        this.scrollTo(this.current + 1);
}

/* Fires when 'More' button is pressed */
RibbonbarScrollable.prototype.actionMore = function(button) {
    var container = $(this.id + '_scrollContentLarge');
    
    if(container && !RibbonbarScrollable.buttonIsDisabled(button)) {
        if(this.popUpIsActive()) {
            this.hidePopUp();
        } else {
            this.showPopUp();
        }
    }
}

/* Determines whether 'More' pop-up is active */
RibbonbarScrollable.prototype.popUpIsActive = function() {
    var container = $(this.id + '_scrollContentLarge');
    return (container.getStyle('display') != 'none');
}

/* Shows 'More' pop-up */
RibbonbarScrollable.prototype.showPopUp = function() {
    var offset = $(this.id + '_scrollMain').cumulativeOffset();
    var container = $(this.id + '_scrollContentLarge');
    var innerContainer = $(this.id + '_scrollContentLargeInner');
    var content = $(this.id + '_scrollContent');
    
    if(!this.popUpIsActive()) {
        this.replaceContent(content, innerContainer);
        container.show();
        
        container.setStyle({ 
            left: offset.left + 'px',
            top: offset.top + 'px'
        });
        
        if(!this.contentInitialized) {
            container.setStyle({ 
                width: content.getWidth() + 20 + 'px'
            });
            
            this.contentInitialized = true;
        }
    }
}

/* Hides 'More' pop-up */
RibbonbarScrollable.prototype.hidePopUp = function() {
    var container = $(this.id + '_scrollContentLarge');
    var innerContainer = $(this.id + '_scrollContentLargeInner');
    var content = $(this.id + '_scrollContent');
    
    if(this.popUpIsActive()) {
        container.hide();
        this.replaceContent(innerContainer, content);
        this.resetState();
    }
}

/* Moves child nodes from one node to another node */
RibbonbarScrollable.prototype.replaceContent = function(fromContent, toContent) {
    while(fromContent.firstChild)
        toContent.appendChild(fromContent.firstChild);
}

/* Resets scrolling state */
RibbonbarScrollable.prototype.resetState = function() {
    this.scrollTo(0);
}

/* Scrolls content to specified row */
RibbonbarScrollable.prototype.scrollTo = function(index) {
    var factor = 1;
    var content = null;
    
    var upButton = $(this.id + '_ScrollUp');
    var downButton = $(this.id + '_ScrollDown');
    var button = null, anotherButton = null;
    
    var rowStart = index, rowEnd = this.current,
        scrollPosition = 0;
    
    if(index <= this.current) {
        button = upButton;
        anotherButton = downButton;
    } else {
        button = downButton;
        anotherButton = upButton;
    }
    
    if(index >= 0 && index < this.rows.length) {
        if(index > this.current) {
            rowStart = this.current;
            rowEnd = index;
        }
    
        if(index < this.current)
            factor = -1;
        
        content = $(this.id + '_scrollContent');
    
        /* Disable animation in non-IE - can't change offsetTop when node is hidden (FF issue) */
        if(RibbonbarScrollable.isIE())
            content.hide();
        
        if(content.scrollTop < 0)
            content.scrollTop = 0;
        
        for(var i = rowStart; i < rowEnd; i++)
            scrollPosition += parseInt($(this.rows[i]).getHeight());
            
        content.scrollTop += (factor * scrollPosition);
        
        if(RibbonbarScrollable.isIE()) {
            /* No animation if 'scriptaculous' library is not included */
            if(Effect)
                Effect.Appear(content, { duration: 0.2 });
            else
                content.show();
        }
        
        this.current = index;
        
        if(this.current == 0 || this.current == this.rows.length - 1) {
            RibbonbarScrollable.updateButtonState(button, RibbonbarScrollable.buttonState.disabled);
        }
        if(this.rows.length > 1) {
            RibbonbarScrollable.updateButtonState(anotherButton, RibbonbarScrollable.buttonState.normal);    
        }
    }
}

/* Initializes single navigation button */
RibbonbarScrollable.prototype.initializeButton = function(action) {
    var button = $(this.id + '_' + action);
    if(button) {
        button.observe('mouseover', function(e) { RibbonbarScrollable.buttonMouseOver(e); });
        button.observe('mouseout', function(e) { RibbonbarScrollable.buttonMouseOut(e); });
    }
}

/* Determines whether navigation button is disabled */
RibbonbarScrollable.buttonIsDisabled = function(button) {
    return (RibbonbarScrollable.getButtonState(button) == 
        RibbonbarScrollable.buttonState.disabled);
}

/* Fires when mouse is over the navigation button */
RibbonbarScrollable.buttonMouseOver = function(e) {
    var button = Event.element(e);
    
    if(button) {
        if(!RibbonbarScrollable.buttonIsDisabled(button)) {
            RibbonbarScrollable.updateButtonState(button, RibbonbarScrollable.buttonState.active);
        }
    }
}

/* Fires when mouse is out the navigation button */
RibbonbarScrollable.buttonMouseOut = function(e) {
    var button = Event.element(e);
    
    if(button) {
        if(!RibbonbarScrollable.buttonIsDisabled(button)) {
            RibbonbarScrollable.updateButtonState(button, RibbonbarScrollable.buttonState.normal);
        }
    }
}

/* Updates navigation button state */
RibbonbarScrollable.updateButtonState = function(button, state) {
    button.src = button.src.replace(/_active\.gif/, '.gif');
    button.src = button.src.replace(/_disabled\.gif/, '.gif');
    
    if(state == RibbonbarScrollable.buttonState.active)
        button.src = button.src.replace(/\.gif/, '_active.gif');
    else if(state == RibbonbarScrollable.buttonState.disabled)
        button.src = button.src.replace(/\.gif/, '_disabled.gif');    
}

/* Retrieves navigation button state */
RibbonbarScrollable.getButtonState = function(button) {
    var ret = RibbonbarScrollable.buttonState.normal;
    
    if(button.src.indexOf('_active.gif') >= 0)
        ret = RibbonbarScrollable.buttonState.active;
    else if(button.src.indexOf('_disabled.gif') >= 0)
        ret = RibbonbarScrollable.buttonState.disabled;
    
    return ret;
}

RibbonbarScrollable.isIE = function() {
    return (typeof(document.addEventListener) == 'undefined');
}

/* Navigation button states */
RibbonbarScrollable.buttonState = {
    normal: 1,
    active: 2,
    disabled: 3
}