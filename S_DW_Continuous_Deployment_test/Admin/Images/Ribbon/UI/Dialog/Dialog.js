var dialog = function() {
	this.tmpDialog = "";
}
var dialog = {
    screen: {
        document: null,
        body: null,
        dimensions: { top: 0, left: 0 },
        scroll: { top: 0, left: 0 },
        update: function (what) {
            if (!dialog.screen.document) {
                dialog.screen.document = $(document);
            }

            if (!dialog.screen.body) {
                dialog.screen.body = $(document.body);
            }

            if (!what || what == 'dimensions') {
                dialog.screen.dimensions = dialog.screen.document.viewport.getDimensions();
            }

            if (!what || what == 'scroll') {
                dialog.screen.scroll = dialog.screen.body.cumulativeScrollOffset();
            }
        }
    },

    hide: function (dialogId) {
        document.getElementById(dialogId).style.display = "none";

        if (dialog.getIsModal(dialogId)) {
            dialog._getModalOverlay().hide();
        }
    },
    show: function (dialogId) {
        dialog.showAt(dialogId, 0, 0);
    },
    showAt: function (dialogId, topPos, leftPos) {
        document.getElementById(dialogId).style.display = "block";
        var OkButton = document.getElementById("OKButton" + dialogId)
        if (OkButton != null) 
            OkButton.focus();

        var bodyHeight;
        var bodyWidth;

        //        if (document.body.scrollHeight > document.body.offsetHeight) {
        //            // IE. 
        //            bodyHeight = document.body.scrollHeight;
        //            bodyWidth = document.body.scrollWidth
        //        } else {
        // Firefox. 
        bodyHeight = document.body.offsetHeight;
        bodyWidth = document.body.offsetWidth;
        //        }

        if (leftPos == 0) {
            leftPos = (parseInt((bodyWidth - document.getElementById(dialogId).offsetWidth) / 2));
        }
        if (topPos == 0) {
            topPos = (parseInt((bodyHeight - document.getElementById(dialogId).offsetHeight) / 2));
            if (bodyHeight < document.body.scrollHeight) topPos += (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop;
            if (topPos < 0) {
                topPos = 100;
            }
        }
        document.getElementById(dialogId).style.top = topPos + 'px';
        document.getElementById(dialogId).style.left = leftPos + 'px';

        dialog.floatTop(dialogId);
        dialog.dragable(dialogId);

        if (dialog.getIsModal(dialogId)) {
            dialog._getModalOverlay().show();
        }
    },
    dragable: function (dialogId) {
        var parameters = {};
        var dimensions = null;
        var snapToScreen = false;
        var cancelSelect = function (e) {
            Event.stop(e);
            e.cancelBubble = true;
            return false;
        }

        if (typeof (Draggable) != 'undefined') {
            var handleId = 'H_' + dialogId;

            if (document.getElementById(handleId)) {
                snapToScreen = $(handleId).readAttribute('data-snap');

                parameters.handle = handleId;
                parameters.onStart = function () { Event.observe(document.body, 'selectstart', cancelSelect); }
                parameters.onEnd = function () { Event.stopObserving(document.body, 'selectstart', cancelSelect); }

                if (snapToScreen == 'true') {
                    dimensions = $(dialogId).getDimensions();

                    parameters.snap = function (x, y, d) {
                        var ret = [x, y];

                        if (!dialog.screen.dimensions.width || !dialog.screen.dimensions.height) {
                            dialog.screen.dimensions = $(document).viewport.getDimensions();
                        }

                        if ((ret[0] + dimensions.width) > (dialog.screen.dimensions.width + dialog.screen.scroll.left)) {
                            ret[0] = dialog.screen.dimensions.width - dimensions.width + dialog.screen.scroll.left;
                        } else if (ret[0] < 0) {
                            ret[0] = 0;
                        } else if (dialog.screen.scroll.left && ret[0] < dialog.screen.scroll.left) {
                            ret[0] = dialog.screen.scroll.left;
                        }

                        if ((ret[1] + dimensions.height) > (dialog.screen.dimensions.height + dialog.screen.scroll.top)) {
                            ret[1] = dialog.screen.dimensions.height - dimensions.height + dialog.screen.scroll.top;
                        } else if (ret[1] < 0) {
                            ret[1] = 0;
                        } else if (dialog.screen.scroll.top && ret[1] < dialog.screen.scroll.top) {
                            ret[1] = dialog.screen.scroll.top;
                        }

                        return ret;
                    }
                }

                new Draggable(dialogId, parameters);
            }
        }
    },
    floatTop: function (dialogId) {
        if (document.getElementById(dialog.tmpDialog)) {
            document.getElementById(dialog.tmpDialog).style.zIndex = 900;
        }
        dialog.tmpDialog = dialogId;
        document.getElementById(dialogId).style.zIndex = 1000;
    },
    setTitle: function (dialogId, newTitle) {
        if (document.getElementById('T_' + dialogId))
            document.getElementById('T_' + dialogId).innerHTML = newTitle;
    },
    getTitle: function (dialogId) {
        var ret = '';
        var o = document.getElementById('T_' + dialogId);

        if (o) {
            ret = o.innerHTML;
        }

        return ret;
    },

    getIsModal: function (dialogId) {
        /// <summary>Gets value indicating whether dialog has a modal behavior.</summary>

        var f = null;
        var ret = false;

        if (dialogId) {
            f = document.getElementById('IsModal_' + dialogId);
            if (f && f.value) {
                ret = f.value.toLowerCase() == 'true';
            }
        }

        return ret;
    },

    _getModalOverlay: function () {
        /// <summary>Gets the modal overlay.</summary>

        var ret = null;
        var overlayId = 'DW_Dialog_ModalOverlay';

        ret = $(overlayId);

        if (ret == null) {
            ret = new Element('div', { 'id': overlayId, 'class': 'dialog-modal-overlay' });
            ret.setStyle({ 'dislpay': 'none' });
            document.body.insertBefore(ret, document.body.firstChild);
            //document.body.appendChild(ret);
        }

        return ret;
    }
}

Event.observe(window, 'resize', function (e) {
    dialog.screen.update();
});

Event.observe(document, 'dom:loaded', function (e) {
    dialog.screen.update();
});

Event.observe(window, 'scroll', function (e) {
    dialog.screen.update('scroll');
});