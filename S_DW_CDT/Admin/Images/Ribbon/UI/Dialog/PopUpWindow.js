/* Namespace definition */

if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Controls) == 'undefined') {
    Dynamicweb.Controls = new Object();
}

/* End: Namespace definition */

Dynamicweb.Controls.PopUpWindowEventArgs = function() {
    /// <summary>Initializes the new instance of an object.</summary>

    this._cancel = false;
}

Dynamicweb.Controls.PopUpWindowEventArgs.prototype.get_cancel = function() {
    /// <summary>Gets value indicating whether to cancel futher execution.</summary>

    return this._cancel;
}

Dynamicweb.Controls.PopUpWindowEventArgs.prototype.set_cancel = function(value) {
    /// <summary>Sets value indicating whether to cancel futher execution.</summary>
    /// <param name="value">Value indicating whether to cancel futher execution.</param>

    this._cancel = value;
}

Dynamicweb.Controls.PopUpWindow = function (containerID) {
    /// <summary>Initializes the new instance of an object.</summary>
    /// <param name="containerID">An ID of the container.</param>

    this._cache = {};

    this._dialogID = '';
    this._containerID = containerID;
    this._parentUnloadTracking = false;
    this._parentUnloading = false;

    this._onLoadSkip = false;
    this._contentUrl = '';
    this._autoReload = false;
    this._autoCenterProgress = false;
    this._isLoading = false;
    this._isModal = false;
    this._showClose = true;
    this._modalOverlay = null;
    this._okButton = null;
    this._cancelButton = null;
    this._helpButton = null;
    this._closeButton = null;
    this._operationIndicator = null;

    if (!this._containerID) {
        this.error('Container ID has to be specified. Parameter name: "containerID".');
    }

    this._events = new EventsManager();

    // Occurs when pop-up window finishes loading.
    this._events.registerEvent('load');

    // Occurs when user hits "Ok" button.
    this._events.registerEvent('ok');

    // Occurs when user hits "Cancel" button.
    this._events.registerEvent('cancel');

    // Occurs when user hits "Help" button.
    this._events.registerEvent('help');

    // Occurs when pop-up window becomes visible.
    this._events.registerEvent('show');

    // Occurs when pop-up window becomes invisible.
    this._events.registerEvent('hide');
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator = function (window) {
    /// <summary>Initializes the new instance of an object.</summary>
    /// <param name="window">A reference to existing pop-up window.</param>

    this._window = window;
    this._message = '';
    this._cache = {};
    this._imageUrl = '';
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator.prototype.get_text = function () {
    /// <summary>Gets the text to be displayed.</summary>

    return this._text;
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator.prototype.set_text = function (value) {
    /// <summary>Sets the text to be displayed.</summary>
    /// <param name="value">Text to be displayed.</param>

    this._text = value;
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator.prototype.get_window = function () {
    /// <summary>Gets a reference to associated pop-up window.</summary>

    return this._window;
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator.prototype.get_imageUrl = function () {
    /// <summary>Gets the URL of the image to be displayed with the text.</summary>

    return this._imageUrl;
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator.prototype.set_imageUrl = function (value) {
    /// <summary>Sets the URL of the image to be displayed with the text.</summary>
    /// <param name="value">The URL of the image to be displayed with the text.</param>

    this._imageUrl = value;
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator.prototype.get_container = function () {
    /// <summary>Gets the reference to a DOM element representing operation progress container.</summary>

    var indicators = [];

    if (!this._cache.container && this.get_window()) {
        indicators = $(this.get_window().get_dialogID()).select('div.popup-operation-indicator');
        if (indicators && indicators.length) {
            this._cache.container = $(indicators[0]);
        }
    }

    return this._cache.container;
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator.prototype.show = function () {
    /// <summary>Shows an indicator.</summary>

    var img = null, span = null;
    var c = this.get_container();

    if (c) {
        c = $(c);
        img = c.select('img');
        span = c.select('span');

        if (img && img.length) {
            img = img[0];
        }

        if (span && span.length) {
            span = span[0];
        }

        if (img) {
            img.src = this.get_imageUrl();
            img.style.display = (this.get_imageUrl() && this.get_imageUrl().length ? '' : 'none');
        }

        if (span) {
            span.innerHTML = this.get_text();
            span.style.display = (this.get_text() && this.get_text().length ? '' : 'none');
        }

        c.style.display = '';
    }
}

Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator.prototype.hide = function () {
    /// <summary>Hides an indicator.</summary>

    var c = this.get_container();

    if (c) {
        c.style.display = 'none';
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.get_container = function() {
    /// <summary>Gets the reference to a DOM element representing pop-up window container.</summary>
    
    if (!this._cache.container) {
        this._cache.container = $(this._containerID);
    }

    return this._cache.container;
}


Dynamicweb.Controls.PopUpWindow.prototype.get_operationIndicator = function () {
    /// <summary>Gets the reference to operation progress indicator.</summary>

    if (!this._operationIndicator) {
        this._operationIndicator = new Dynamicweb.Controls.PopUpWindow.OperationProgressIndicator(this);
    }

    return this._operationIndicator;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_progressContainer = function() {
    /// <summary>Gets the reference to a DOM element representing pop-up window progress container.</summary>

    if (!this._cache.progressContainer) {
        this._cache.progressContainer = this._selectSingleComponent('div.popup-progress');
    }

    return this._cache.progressContainer;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_contentContainer = function() {
    /// <summary>Gets the reference to a DOM element representing pop-up window content container.</summary>

    if (!this._cache.contentContainer) {
        this._cache.contentContainer = this._selectSingleComponent('div.popup-content');
    }

    return this._cache.contentContainer;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_contentFrame = function() {
    /// <summary>Gets the reference to a DOM element representing pop-up window content frame.</summary>

    if (!this._cache.contentFrame) {
        this._cache.contentFrame = this._selectSingleComponent('iframe.popup-content-frame');
    }

    return this._cache.contentFrame;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_contentDocument = function() {
    /// <summary>Gets the reference to a DOM element representing pop-up window content document.</summary>

    var w = null;
    var ret = null;
    var frame = this.get_contentFrame();

    if (frame) {
        w = frame.contentWindow ? frame.contentWindow : frame.window;
        if (w && w.document) {
            ret = w.document;
        }
    }

    return ret;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_okButton = function() {
    /// <summary>Gets the reference to a DOM element representing an "OK" button.</summary>

    if (!this._okButton) {
        this._okButton = $(this.get_dialogID()).select('button.dialog-button-ok');
        if (this._okButton != null && this._okButton.length > 0) {
            this._okButton = $(this._okButton[0]);
        }
    }
    
    return this._okButton;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_cancelButton = function() {
    /// <summary>Gets the reference to a DOM element representing an "Cancel" button.</summary>

    if (!this._cancelButton) {
        this._cancelButton = $(this.get_dialogID()).select('button.dialog-button-cancel');
        if (this._cancelButton != null && this._cancelButton.length > 0) {
            this._cancelButton = $(this._cancelButton[0]);
        }
    }

    return this._cancelButton;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_helpButton = function() {
    /// <summary>Gets the reference to a DOM element representing an "Help" button.</summary>

    if (!this._helpButton) {
        this._helpButton = $(this.get_dialogID()).select('button.dialog-button-help');
        if (this._helpButton != null && this._helpButton.length > 0) {
            this._helpButton = $(this._helpButton[0]);
        }
    }

    return this._helpButton;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_closeButton = function () {
    /// <summary>Gets the reference to a DOM element representing an "Close" button.</summary>

    if (!this._closeButton) {
        this._closeButton = $(this.get_dialogID()).select('a.popup-dialog-close');
        if (this._closeButton != null && this._closeButton.length > 0) {
            this._closeButton = $(this._closeButton[0]);
        }
    }

    return this._closeButton;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_dialogID = function() {
    /// <summary>Gets an ID of the underlying Dialog control.</summary>

    var index = -1;

    if (!this._dialogID) {
        index = this._containerID.lastIndexOf('_container');
        if (index > 0) {
            this._dialogID = this._containerID.substr(0, index);
        }
    }

    return this._dialogID;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_dialogID = function(value) {
    /// <summary>Sets an ID of the underlying Dialog control.</summary>
    /// <param name="value">An ID of the underlying Dialog control.</param>

    this._dialogID = value;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_isVisible = function() {
    /// <summary>Gets value indicating whether window is visible.</summary>

    var ret = false;
    var attr = null;
    var box = $(this.get_dialogID());

    if (box) {
        attr = box.getStyle('display');
        if (attr != null) {
            ret = attr.toLowerCase() != 'none';
        }
    }

    return ret;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_contentUrl = function() {
    /// <summary>Gets the URL of the page which should be displayed within the pop-up window.</summary>

    return this._contentUrl;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_contentUrl = function(value) {
    /// <summary>Sets the URL of the page which should be displayed within the pop-up window.</summary>
    /// <param name="value">The URL of the page which should be displayed within the pop-up window.</param>
    
    this._contentUrl = value;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_autoReload = function() {
    /// <summary>Gets value indicating whether to automatically reload the content of the pop-up window.</summary>

    return this._autoReload;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_autoReload = function(value) {
    /// <summary>Sets value indicating whether to automatically reload the content of the pop-up window.</summary>
    /// <param name="value">Value indicating whether to automatically reload the content of the pop-up window.</param>

    this._autoReload = value;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_autoCenterProgress = function () {
    /// <summary>Gets value indicating whether to automatically adjust the position of the "Please wait" message so it placed at the middle of dialog content area.</summary>

    return this._autoCenterProgress;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_autoCenterProgress = function (value) {
    /// <summary>Gets value indicating whether to automatically adjust the position of the "Please wait" message so it placed at the middle of dialog content area.</summary>
    /// <param name="value">Value indicating whether to automatically adjust the position of the "Please wait" message so it placed at the middle of dialog content area.</param>

    this._autoCenterProgress = value;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_isModal = function() {
    /// <summary>Gets value indicating whether window should get a modal behaviour.</summary>

    return this._isModal;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_isModal = function(value) {
    /// <summary>Sets value indicating whether window should get a modal behaviour.</summary>
    /// <param name="value">Value indicating whether window should get a modal behaviour.</param>

    this._isModal = value;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_showClose = function () {
    /// <summary>Gets value indicating whether window should show close button.</summary>

    return this._showClose;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_showClose = function (value) {
    /// <summary>Sets value indicating whether window should show a close button.</summary>
    /// <param name="value">Value indicating whether window should show a clsoe button.</param>

    this._showClose = value;
}

Dynamicweb.Controls.PopUpWindow.prototype.get_isLoading = function() {
    /// <summary>Gets value indicating whether pop-up window's content is being loaded.</summary>

    return this._isLoading;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_isLoading = function (value) {
    /// <summary>Sets value indicating whether pop-up window's content is being loaded.</summary>
    /// <param name="value">Value indicating whether pop-up window's content is being loaded.</param>

    this._isLoading = value;

    if (this._isLoading) {
        this.get_contentContainer().hide();
        this.get_progressContainer().show();

        if (this.get_autoCenterProgress()) {
            this.centerProgress();
        }
    } else {
        this.get_contentContainer().show();
        this.get_progressContainer().hide();
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.get_title = function() {
    /// <summary>Gets the title of the window.</summary>
    
    return dialog.getTitle(this.get_dialogID());
}

Dynamicweb.Controls.PopUpWindow.prototype.set_title = function(value) {
    /// <summary>Sets the title of the window.</summary>
    /// <param name="value">Window title.</param>
    
    dialog.setTitle(this.get_dialogID(), value);
}

Dynamicweb.Controls.PopUpWindow.prototype.get_width = function() {
    /// <summary>Gets the width of the window.</summary>

    var ret = 0;
    var box = $(this.get_dialogID());

    if (box) {
        ret = box.getStyle('width');
        if (ret) {
            ret = parseInt(ret.replace(/px|pt|%/gi, ''));
        }
    }

    return ret;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_width = function(value) {
    /// <summary>Sets the width of the window.</summary>
    /// <param name="value">The width of the window.</param>

    var box = $(this.get_dialogID());
        
    if (value && box) {
        value = parseInt(value);
        if (!isNaN(value) && value >= 0) {
            box.setStyle({ width: value + 'px' });
        }
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.get_height = function() {
    /// <summary>Gets the height of the window content.</summary>
    
    var ret = 0;
    var frame = this.get_contentFrame();

    if (frame) {
        ret = frame.getStyle('height');
        if (ret) {
            ret = parseInt(ret.replace(/px|pt|%/gi, ''));
        }
    }

    return ret;
}

Dynamicweb.Controls.PopUpWindow.prototype.set_height = function(value) {
    /// <summary>Sets the height of the window content.</summary>
    /// <param name="value">The height of the window content (in pixels).</param>

    var frame = this.get_contentFrame();
    var progress = this.get_progressContainer();

    if (value && frame) {
        value = parseInt(value);
        if (!isNaN(value) && value >= 0) {
            frame.setStyle({ height: value + 'px' });
            if (progress && value - 20 > 0) {
                progress.setStyle({ height: value - 20 + 'px' });
            }
        }
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.add_load = function(handler) {
    /// <summary>Registers new event handler for "load" event.</summary>
    /// <param name="handler">Event handler.</param>

    this._events.addHandler('load', handler);
}

Dynamicweb.Controls.PopUpWindow.prototype.add_ok = function(handler) {
    /// <summary>Registers new event handler for "ok" event.</summary>
    /// <param name="handler">Event handler.</param>

    this._events.addHandler('ok', handler);
}

Dynamicweb.Controls.PopUpWindow.prototype.add_cancel = function(handler) {
    /// <summary>Registers new event handler for "cancel" event.</summary>
    /// <param name="handler">Event handler.</param>

    this._events.addHandler('cancel', handler);
}

Dynamicweb.Controls.PopUpWindow.prototype.add_help = function(handler) {
    /// <summary>Registers new event handler for "help" event.</summary>
    /// <param name="handler">Event handler.</param>

    this._events.addHandler('help', handler);
}

Dynamicweb.Controls.PopUpWindow.prototype.add_show = function(handler) {
    /// <summary>Registers new event handler for "show" event.</summary>
    /// <param name="handler">Event handler.</param>

    this._events.addHandler('show', handler);
}

Dynamicweb.Controls.PopUpWindow.prototype.add_hide = function(handler) {
    /// <summary>Registers new event handler for "hide" event.</summary>
    /// <param name="handler">Event handler.</param>

    this._events.addHandler('hide', handler);
}

Dynamicweb.Controls.PopUpWindow.prototype.notify = function(eventName, args) {
    /// <summary>Notifies all subscribers about the specified event.</summary>
    /// <param name="eventName">Name of the event.</param>
    /// <param name="args">Event arguments.</param>

    this._events.notify(eventName, this, args);
}

Dynamicweb.Controls.PopUpWindow.prototype.centerProgress = function () {
    /// <summary>Centers the progress indicator according to the current dialog height.</summary>

    var totalHeight = 0;
    var imageContainer = null;
    var height = this.get_height();
    var container = this.get_progressContainer();


    if (height && container) {
        imageContainer = container.select('.popup-progress-image');

        totalHeight = height - 20;
        container.setStyle({ height: totalHeight + 'px' });

        if (imageContainer && imageContainer.length) {
            $(imageContainer[0]).setStyle({ paddingTop: (height / 2 - 32) + 'px' });
        }
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.error = function(message) {
    /// <summary>Sends an error to the client.</summary>
    /// <param name="message">Error message.</param>

    var er = null;

    if (typeof (Error) != 'undefined') {
        er = new Error();

        er.message = message;
        er.description = message;

        throw er;
    } else {
        throw message;
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.show = function () {
    /// <summary>Displays the pop-up window.</summary>

    this.showAt(0, 0);
}

Dynamicweb.Controls.PopUpWindow.prototype.showAt = function (topPos, leftPos) {
    /// <summary>Displays the pop-up window.</summary>

    var frame = this.get_contentFrame();
    var args = new Dynamicweb.Controls.PopUpWindowEventArgs();

    this.resetControls();

    this.notify('show', args);

    if (!args.get_cancel()) {
        if (this.get_isModal()) {
            this._getModalOverlay().show();
        }
        if (!this.get_showClose()) {
            var closeBtn = this.get_closeButton();
            if (closeBtn != null)
                closeBtn.hide();
        }

        this.reload();

        dialog.showAt(this.get_dialogID(), topPos, leftPos);

        if (typeof (dialog._getModalOverlay) == 'function' && dialog._getModalOverlay()) {
            dialog._getModalOverlay().hide();
        }
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.resetControls = function () {
    /// <summary>Brings all dialog controls to their initial state.</summary>

    if (this.get_okButton()) this.get_okButton().disabled = false;
    if (this.get_cancelButton()) this.get_cancelButton().disabled = false;
    if (this.get_helpButton()) this.get_helpButton().disabled = false;

    this.get_operationIndicator().hide();
}

Dynamicweb.Controls.PopUpWindow.prototype.center = function() {
    /// <summary>Centers the dialog.</summary>

    if (this.get_isVisible()) {
        dialog.showAt(this.get_dialogID(), 0, 0);
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.moveTo = function(x, y) {
    /// <summary>Moves dialog to the specified position.</summary>

    if (this.get_isVisible()) {
        dialog.showAt(this.get_dialogID(), x, y);
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.hide = function() {
    /// <summary>Hides the pop-up window.</summary>

    var frame = this.get_contentFrame();
    var args = new Dynamicweb.Controls.PopUpWindowEventArgs();

    this.notify('hide', args);

    if (!args.get_cancel()) {
        this._onLoadSkip = true;
        if (this.get_autoReload()) {
            /* "ok", "cancel" and "help" event handlers are not persisted across dialog loadings */
            this._events.removeAllHandlers('ok');
            this._events.removeAllHandlers('cancel');
            this._events.removeAllHandlers('help');

            frame.writeAttribute('src', 'about:blank');
        }

        dialog.hide(this.get_dialogID());
        this._getModalOverlay().hide();
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.ok = function () {
    /// <summary>Handles "Ok" button click.</summary>

    var args = new Dynamicweb.Controls.PopUpWindowEventArgs();

    this.notify('ok', args);

    if (!args.get_cancel()) {
        this.hide();
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.cancel = function() {
    /// <summary>Handles "Cancel" button click.</summary>

    var args = new Dynamicweb.Controls.PopUpWindowEventArgs();

    this.notify('cancel', args);

    if (!args.get_cancel()) {
        this.hide();
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.help = function() {
    /// <summary>Handles "Cancel" button click.</summary>

    var message = '';
    var helpContainer = null;
    var args = new Dynamicweb.Controls.PopUpWindowEventArgs();

    this.notify('help', args);

    if (!args.get_cancel()) {
        helpContainer = this._selectSingleComponent('input.popup-help');
        if (helpContainer && helpContainer.value.length > 0) {
            message = helpContainer.value.replace(/\\n/gi, '\n');
            alert(message);
        }
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.contentLoaded = function () {
    /// <summary>Signals PopUpWindow control that the content within the iframe has finished loading.</summary>

    var f = null;
    var self = this;
    var onParentUnload = null;
    var frame = this.get_contentFrame();
    var args = new Dynamicweb.Controls.PopUpWindowEventArgs();
    var w = frame.contentWindow ? frame.contentWindow : frame.window;

    if (!this._onLoadSkip) {
        this.notify('load', args);

        if (!args.get_cancel()) {
            this.set_isLoading(false);

            if (w) {
                if (this._isIE()) {
                    f = function () {
                        self._onContentReadyStateChange(f);
                    }

                    frame.onreadystatechange = f;
                } else {
                    f = function () {
                        self._onBeforeUnload(f);
                    }

                    onParentUnload = function () {
                        self._parentUnloading = true;
                    }

                    w.addEventListener('beforeunload', f, false);

                    if (!this._parentUnloadTracking) {
                        window.addEventListener('beforeunload', onParentUnload, false);
                    }

                    this._parentUnloadTracking = true;
                }
            }
        }
    } else {
        this._onLoadSkip = false;
    }
}

Dynamicweb.Controls.PopUpWindow.prototype.reload = function() {
    /// <summary>Reloads content within the pop-up window.</summary>

    var obj = this;
    var currentUrl = '';
    var toggleLoading = false;
    var frame = this.get_contentFrame();
    var w = frame.contentWindow ? frame.contentWindow : frame.window;

    if (w) {
        currentUrl = w.location.href;
    }

    if (!this._urlMatch(currentUrl, this.get_contentUrl())) {
        toggleLoading = true;
        frame.writeAttribute('src', this.get_contentUrl());
    } else {
        if (this.get_autoReload()) {
            toggleLoading = true;

            if (w) {
                w.location.href = w.location.href;
            } else {
                frame.writeAttribute('src', this.get_contentUrl());
            }
        }
    }

    if (toggleLoading) {
        this._onLoadSkip = false;
        obj.set_isLoading(true);
    }
}

Dynamicweb.Controls.PopUpWindow.prototype._onContentReadyStateChange = function (f) {
    /// <summary>Signals PopUpWindow control that the content within the iframe is about to be unloaded.</summary>
    /// <param name="f">Pointer to the function registered as "onbeforeunload" handler.</param>
    /// <private />

    var frame = this.get_contentFrame();

    if (frame.readyState == 'loading') {
        this._onLoadSkip = false;
        this.set_isLoading(true);
    }
}

Dynamicweb.Controls.PopUpWindow.prototype._onBeforeUnload = function (f) {
    /// <summary>Signals PopUpWindow control that the content within the iframe is about to be unloaded.</summary>
    /// <param name="f">Pointer to the function registered as "onbeforeunload" handler.</param>
    /// <private />

    var frame = this.get_contentFrame();
    var w = frame.contentWindow ? frame.contentWindow : frame.window;
    
    if (!this._parentUnloading) {
        this._onLoadSkip = false;
        this.set_isLoading(true);

        if (w) {
            if (w.removeEventListener) {
                w.removeEventListener('beforeunload', f);
            } else if (w.detachEvent) {
                w.detachEvent('onbeforeunload', f);
            }
        }
    } else {
        this._parentUnloading = false;
    }
}

Dynamicweb.Controls.PopUpWindow.prototype._selectSingleComponent = function(selector) {
    /// <summary>Selectes single component within the current control by the given CSS selector.</summary>
    /// <param name="selector">CSS selector to use.</param>
    /// <private />

    var ret = null;

    if (selector) {
        ret = this.get_container().select(selector);
        if (ret != null && ret.length > 0) {
            ret = $(ret[0]);
        }
    }

    return ret;
}

Dynamicweb.Controls.PopUpWindow.prototype._isIE = function() {
    /// <summary>Determines whether script executes under Microsoft Internet Explorer.</summary>
    /// <private />
    
    return typeof(document.all) != 'undefined' && typeof(window.attachEvent) != 'undefined';
}

Dynamicweb.Controls.PopUpWindow.prototype._urlMatch = function(url1, url2) {
    /// <summary>Determines whether two resource locators represents the same resource.</summary>
    /// <param name="url1">First URL.</param>
    /// <param name="url2">Second URL.</param>
    /// <private />
    
    var ret = false;

    if (!url1) url1 = '';
    if (!url2) url2 = '';

    ret = (url1.toLowerCase() == url2.toLowerCase());

    if (!ret) {
        ret = this._absolutePath(url1).toLowerCase() ==
            this._absolutePath(url2).toLowerCase();
    }

    return ret;
}

Dynamicweb.Controls.PopUpWindow.prototype._absolutePath = function(url) {
    /// <summary>Retrieves an absolute path of the given URL.</summary>
    /// <param name="url">URL to process.</param>
    /// <private />

    var ret = '';
    var sepIndex = -1;

    if (url) {
        ret = url;
        ret = ret.replace(/:\/\//g, '');
        sepIndex = ret.indexOf('/');

        if (sepIndex == 0) {
            ret = url;
        } else if (sepIndex < 0 || sepIndex == ret.length - 1) {
            ret = '/';
        } else {
            ret = ret.substr(sepIndex);
        }
    }

    return ret;
}

Dynamicweb.Controls.PopUpWindow.prototype._getModalOverlay = function() {
    /// <summary>Gets the modal overlay.</summary>
    /// <private />
    
    var overlayId = 'DW_PopupWindow_ModalOverlay';

    if (!this._modalOverlay) {
        this._modalOverlay = $(overlayId);
        if (this._modalOverlay == null) {
            this._modalOverlay = new Element('div', { 'id': overlayId, 'class': 'popup-window-modal-overlay' });
            this._modalOverlay.setStyle({ 'dislpay': 'none' });
            document.body.appendChild(this._modalOverlay);            
        }
    }

    return this._modalOverlay;
}

Dynamicweb.Controls.PopUpWindow.getInstance = function(ctrl) {
    /// <summary>Gets a reference to a specific pop-up window.</summary>
    /// <param name="ctrl">An ID (or ClientID) of the container. A reference to a container element is also accepted.</param>

    var ret = null;
    var hidden = null;
    var element = null;
    var objName = null;
    var body = $(document.body);

    if (ctrl) {
        if (typeof (ctrl) != 'string') {
            element = ctrl;
        } else {
            ctrl += '_container';

            element = $(ctrl);

            if (!element) {
                element = body.select('*[id$="' + ctrl + '"]');
                if (element && element.length > 0) {
                    element = element[0];
                }
            }
        }
        
        if (element) {
            hidden = $(element).select('input.popup-client-instance');
            if (hidden != null && hidden.length > 0) {
                objName = hidden[0].value;

                ret = window[objName];

                if (!ret) {
                    ret = new Dynamicweb.Controls.PopUpWindow(element.id);
                    window[objName] = ret;
                }
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.PopUpWindow.current = function(wnd) {
    /// <summary>Retrieves an instance of pop-up window control for provided content window instance.</summary>
    /// <param name="wnd">An instance of Window object to retrieve control instance for.</param>

    var ret = null;
    var frame = null;
    var container = null;

    if (wnd && wnd.frameElement) {
        frame = wnd.frameElement;
        if (frame) {
            container = $(frame).up('div.popup-window');
            if (container) {
                ret = Dynamicweb.Controls.PopUpWindow.getInstance(container);
            }
        }
    }

    return ret;
}
