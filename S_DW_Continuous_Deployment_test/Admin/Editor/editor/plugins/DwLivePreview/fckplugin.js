var DwLivePreview = function () {
    this._subscribers = [];
}

DwLivePreview.updatePreview = function (containerID) {
    var container = null;

    if (!containerID) {
        containerID = FCKConfig.DwLivePreviewContainer;
    }

    if (containerID) {
        container = parent.document.getElementById(containerID);
        if (container) {
            container.innerHTML = FCK.GetData();

            if (typeof (parent.SyntaxHighlighter) != 'undefined') {
                try {
                    parent.SyntaxHighlighter.highlight();
                } catch (ex) { }
            }

            if (this._subscribers != null && this._subscribers.length > 0) {
                for (var i = 0; i < this._subscribers.length; i++) {
                    if (typeof (this._subscribers[i]) != 'undefined') {
                        try {
                            this._subscribers[i](this, {});
                        } catch (ex) { }
                    }
                }
            }
        }
    }
}

DwLivePreview.add_onUpdatePreview = function (callback) {
    if (this._subscribers == null) {
        this._subscribers = [];
    }

    this._subscribers[this._subscribers.length] = callback;
}

FCK.AttachToOnSelectionChange(function () {
    DwLivePreview.updatePreview();
});

if (FCKBrowserInfo.IsIE) {
    FCK.Events.AttachEvent('OnAfterSetHTML', function () {
        if (!(FCK.EditMode != FCK_EDITMODE_WYSIWYG)) {
            FCK.EditorDocument.attachEvent('onkeyup', function () {
                DwLivePreview.updatePreview();
            });
        }
    });
}

FCK.Events.AttachEvent('OnStatusChange', function (sender, status) {
    if (status == FCK_STATUS_COMPLETE) {
        DwLivePreview.updatePreview();
    }
});

if (typeof (parent["FCK"]) == 'undefined') {
    parent["FCK"] = new Object();
}

if (typeof (parent["FCK"].Plugins) == 'undefined') {
    parent["FCK"].Plugins = new Object();
}

parent["FCK"].Plugins.DwLivePreview = DwLivePreview;