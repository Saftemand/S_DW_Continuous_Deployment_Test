var DirectPaths = {
    _canShowDialog: true,
    _cachedPaths: {},

    addPath: function (params) {
        var ret = false;
        var itemName = '';

        if (params && typeof (params.id) != 'undefined') {
            itemName = 'path' + params.id;
            if (!DirectPaths._cachedPaths[itemName]) {
                ret = true;
                this._cachedPaths[itemName] = params;
            }
        }
        return ret;
    },

    getPath: function (id) {
        var ret = null;
        var itemName = 'path' + id;

        if (this._cachedPaths && this._cachedPaths[itemName]) {
            ret = this._cachedPaths[itemName];
        }

        return ret;
    },

    help: function () {
        eval(document.getElementById('jsHelp').innerHTML);
    },

    initiatePostBack: function (action, target) {
        var f = document.getElementById('MainForm');
        var postBackField = document.getElementById('PostBackAction');

        if (typeof (WaterMark) != 'undefined') {
            WaterMark.hideAll();
        }

        if (!f && document.forms.length > 0) {
            f = document.forms[0];
        }

        if (postBackField)
            postBackField.value = action + ':' + target;

        f.submit();
    },

    deleteItems: function (itemID) {
        var msg = document.getElementById('confirmDelete').innerHTML;

        if (typeof (itemID) == 'undefined') {
            itemID = this.getTargetIDs();
        }

        ContextMenu.hide();

        if (confirm(msg)) {
            this.initiatePostBack('ItemDelete', itemID);
        }

        if (window.event) {
            window.event.cancelBubble = true;
            if (window.event.stopPropagation) {
                window.event.stopPropagation();
            }
        }

        if (!document.attachEvent)
            this._canShowDialog = false;

        return false;
    },

    activateItems: function () {
        this.initiatePostBack('ItemActivate', this.getTargetIDs());
    },

    deactivateItems: function () {
        this.initiatePostBack('ItemDeactivate', this.getTargetIDs());
    },

    setItemsStatus: function (status) {
        this.initiatePostBack('ItemStatus_' + status, this.getTargetIDs());
    },

    isPathExists: function () {
        var dpId = document.getElementById('ItemID').value;
        var dd = document.getElementById('rowAreaID').getElementsByTagName('select')[0];
        var areaId = dd.value;
        var path = document.getElementById('ItemPath').value;
        var arr = Dynamicweb.Utilities.CollectionHelper.toArray(this._cachedPaths);
        var res = Dynamicweb.Utilities.CollectionHelper.any(arr, function (obj) {
            if (obj.id != dpId && obj.path == path.trim() && (areaId == 0 || obj.areaID == 0 || obj.areaID == areaId)) {
                return true;
            }
            return false;
        });
        return res;
    },

    validateForm: function (onComplete, cmd) {
        var requestForCheck = false;

        this.clearValidationResults();

        onComplete = onComplete || function () { };

        if (document.getElementById('ItemPath').value.length == 0) {
            this.showValidator('errorPathRequired');
        } else if (document.getElementById('ItemRedirect').value.length == 0) {
            this.showValidator('errorLinkRequired');
        } else if (this.isPathExists()) {
            this.showValidator('errorPathAlreadyExists');
        } else {
            requestForCheck = true;
            if (cmd) {
                cmd.disabled = true;
            }
            var self = this;
            new Ajax.Request('/Admin/Content/Management/DirectPaths/List.aspx?CheckPath=' +
                encodeURIComponent(document.getElementById('ItemPath').value), {
                    method: 'get',
                    onComplete: function (transport) {
                        var isValid = transport.responseText != 'true';
                        if (!isValid) {
                            self.showValidator('errorPathIsPhysical');
                        }
                        if (cmd) {
                            cmd.disabled = false;
                        }
                        onComplete(isValid);
                    }
                });
        }

        if (!requestForCheck) {
            onComplete(false);
        }
    },

    showValidator: function (errorID) {
        if (errorID) {
            document.getElementById(errorID).style.display = 'block';
        }
    },

    clearValidationResults: function () {
        var errorContainers = ['errorPathRequired', 'errorLinkRequired', 'errorPathIsPhysical'];

        for (var i = 0; i < errorContainers.length; i++) {
            document.getElementById(errorContainers[i]).style.display = 'none';
        }
    },

    editItem: function (id) {
        var item = this.getPath(id);
        var dd = document.getElementById('rowAreaID').getElementsByTagName('select')[0];

        if (this._canShowDialog) {
            if (item) {
                document.getElementById('ItemID').value = item.id;
                document.getElementById('ItemPath').value = item.path;
                document.getElementById('Link_ItemRedirect').value = item.redirectName;
                document.getElementById('ItemRedirect').value = item.redirectLink;

                for (var i = 0; i < dd.options.length; i++) {
                    if (dd.options[i].value == item.areaID.toString()) {
                        dd.selectedIndex = i;
                        break;
                    }
                }

                document.getElementById('rd200').checked = (item.redirectStatus == 200);
                document.getElementById('rd301').checked = (item.redirectStatus == 301);
                document.getElementById('rd302').checked = (item.redirectStatus == 302);
                document.getElementById('ItemActive').checked = item.isActive;
            }

            this.clearValidationResults();

            dialog.show('dlgEditPath');

            setTimeout(function () {
                try {
                    document.getElementById('ItemPath').focus();
                } catch (ex) { }
            }, 50);
        } else {
            this._canShowDialog = true;
        }
    },

    saveItem: function (cmd) {
        var self = this;
        this.validateForm(function (isValid) {
            if (isValid) {
                dialog.hide('dlgEditPath');
                self.initiatePostBack('ItemEdit', document.getElementById('ItemID').value);
            }
        }, cmd);
    },

    getTargetIDs: function () {
        var ret = '';
        var rows = List.getSelectedRows('lstPaths');

        if (rows != null && rows.length > 1) {
            for (var i = 0; i < rows.length; i++) {
                ret += rows[i].id.replace(/row/gi, '');
                if (i < rows.length - 1) {
                    ret += ',';
                }
            }
        } else {
            ret = ContextMenu.callingID;
        }

        return ret;
    },

    onSelectItemContextMenuView: function (sender, args) {
        var ret = '';
        var row = null;
        var activeRows = 0;
        var rows = List.getSelectedRows('lstPaths');

        if (rows == null || rows.length < 2) {
            if (rows.length > 0) {
                row = rows[0];
            } else {
                row = List.getRowByID('lstPaths', args.callingID);
            }

            if (row.readAttribute('__active') == 'true') {
                ret = 'SingleActiveItem';
            } else {
                ret = 'SingleInactiveItem';
            }
        } else {
            for (var i = 0; i < rows.length; i++) {
                row = rows[i];
                if (row.readAttribute('__active') == 'true') {
                    activeRows += 1;
                }
            }

            if (activeRows == rows.length) {
                ret = 'MultipleActiveItems';
            } else if (activeRows == 0) {
                ret = 'MultipleInactiveItems';
            } else {
                ret = 'MixedItems';
            }
        }

        return ret;
    }
};