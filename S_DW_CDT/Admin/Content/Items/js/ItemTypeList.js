if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = {};
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = {};
}

Dynamicweb.Items.ItemTypeList = function () {
    this._terminology = {};
    this._selectedItems = null;
    this._targetItemType = null;
    this._elements = {};
};

Dynamicweb.Items.ItemTypeList._instance = null;

Dynamicweb.Items.ItemTypeList.get_current = function () {
    if (!Dynamicweb.Items.ItemTypeList._instance) {
        Dynamicweb.Items.ItemTypeList._instance = new Dynamicweb.Items.ItemTypeList();
    }

    return Dynamicweb.Items.ItemTypeList._instance;
};

Dynamicweb.Items.ItemTypeList.onContextMenuView = function (sender, arg) {
    var view = "common";

    var row = List.getRowByID('lstItemTypes', arg.callingID);
    var rows = Dynamicweb.Items.ItemTypeList.get_current().getSelectedItems();

    if (rows.indexOf(',') >= 0) {
        if (row && row.hasClassName("selected")) {
            view = "selection";
        }
        else {
            view = "mixed";
        }
    }

    return view;
};

Dynamicweb.Items.ItemTypeList.treeReload = function () {
    // reload content tree
    top.left.location.reload(true);

    // reload MC tree
    var src = top.right.location.href;
    if (src.endsWith('#')) {
        src = src.substr(0, src.length - 1);
    }

    var params = src.toQueryParams();
    if (params.OpenTo) {
        src = src.replace("OpenTo=" + encodeURIComponent(params.OpenTo), "OpenTo=" + encodeURIComponent("ContentTypes"));
        src = src.replace("OpenTo=" + params.OpenTo, "OpenTo=" + encodeURIComponent("ContentTypes"));
    }
    else
        src = src + "?OpenTo=" + encodeURIComponent("ContentTypes");
    top.right.location.href = src;
};

Dynamicweb.Items.ItemTypeList.prototype.get_terminology = function () {
    return this._terminology;
};

Dynamicweb.Items.ItemTypeList.prototype.openEditDialog = function (systemName) {
    var params = [
        'SystemName=' + encodeURIComponent(systemName || '')
    ];

    location.href = '/Admin/Content/Items/ItemTypes/ItemTypeEdit.aspx?' + params.join('&');
};

Dynamicweb.Items.ItemTypeList.prototype.copy = function (systemName) {
    location.href = '/Admin/Content/Items/ItemTypes/ItemTypeEdit.aspx?Mode=copy&SystemName=' + encodeURIComponent(systemName || '');
};

Dynamicweb.Items.ItemTypeList.prototype.tryDeleteItem = function (systemName) {
    this._targetItemType = systemName;
    var self = this;

    if (!(!!systemName)) {
        var rows = this.getSelectedItems();
        systemName = rows;
    }

    new Ajax.Request("/Admin/Content/Items/ItemTypes/ItemTypeList.aspx?AJAX=ValidateDeletion", {
        method: 'get',
        parameters: {
            ItemSystemNames: systemName
        },
        onSuccess: function (transport) {
            try {
                var itemListErr = "";
                var itemInheritanceErr = "";
                var itemHasItemRelatedListErr = "";
                var jsonObj = !!transport.responseText ? transport.responseText.evalJSON() : null;
                var error = !!jsonObj ? (jsonObj.error || jsonObj.Error) : null;
                if (!error) {
                    dialog.show('dlgDeleteItemTypes');
                } else {
                    var errMsg;
                    if (error.ItemListReference != undefined) {
                        itemListErr += self.get_terminology()['ItemListReference']
                        itemListErr += "\n" + self.get_terminology()['ItemListMessage'] + " ";
                        error.ItemListReference.forEach(function (name) {
                            itemListErr += "\n" + name;
                        });
                        itemListErr += "\n\n";
                    }
                    if (error.ItemInheritanceReference != undefined) {
                        itemInheritanceErr += self.get_terminology()['ItemInheritanceReference'];
                        if (systemName.split(",").length > 1) {
                            itemInheritanceErr += "\n" + self.get_terminology()['ItemListMessage'] + " ";
                            error.ItemInheritanceReference.forEach(function (name) {
                                itemInheritanceErr += "\n" + name;
                            });
                        }
                        itemInheritanceErr += "\n\n";
                    }
                    if (error.itemHasItemRelatedList != undefined) {
                        itemHasItemRelatedListErr += self.get_terminology()['itemHasItemRelatedList'];
                        itemHasItemRelatedListErr += "\n" + self.get_terminology()['ItemListMessage'] + " ";
                        error.itemHasItemRelatedList.forEach(function (name) {
                            itemHasItemRelatedListErr += "\n" + name;
                        });
                    }
                    alert(itemListErr + itemInheritanceErr + itemHasItemRelatedListErr);
                }
                
            }
            catch (e) {
                alert(e);
            }
        },
        onFailure: function () {
            alert('Something went wrong!');
        }
    });
};

Dynamicweb.Items.ItemTypeList.prototype.deleteItem = function () {
    var systemName = this._targetItemType;

    if (typeof (systemName) == 'undefined' || systemName == null) {
        systemName = this._selectedItems; // this.getSelectedItems();
    }

    this._targetItemType = null;

    dialog.hide('dlgDeleteItemTypes');
    new overlay('PleaseWait').show();

    this.initiatePostBack('DeleteItemTypes', systemName,
        document.getElementById('DeleteModePreservePages').checked ? 'PreservePages' : 'DeletePages');
};

Dynamicweb.Items.ItemTypeList.prototype.getSelectedItems = function () {
    var ret = '';
    var prevstr = $('SelectedItems').value;
    var allitems = eval("[" + prevstr + "]");

    for (var i = 0; i < allitems.length; i++) {
        var row = List.getRowByID('lstItemTypes', allitems[i].id.toString());
        if (!row.readAttribute) {
            ret += allitems[i].itemid + ',';
        }
    }

    var rows = List.getSelectedRows('lstItemTypes');
    if (rows != null && rows.length > 0) {
        for (var i = 0; i < rows.length; i++) {
            ret += rows[i].readAttribute("itemid") + ',';     //id.replace(/row/gi, '');
        }
    } else if (!ret) {
        ret = ContextMenu.callingItemID;
    }

    ret = ret.replace(/,+$/, '');
    this._selectedItems = ret;

    return ret;
};

Dynamicweb.Items.ItemTypeList.prototype.clearSelectedItems = function () {
    $('SelectedItems').value = "";
    var rows = List.getSelectedRows('lstItemTypes');
    if (rows != null && rows.length > 0) {
        for (var i = 0; i < rows.length; i++) {
            List.setRowSelected("lstItemTypes", rows[i], false);
        }
    }
};

Dynamicweb.Items.ItemTypeList.prototype.initiatePostBack = function (action, id, argument) {
    var f = document.getElementById('MainForm');
    var postBackField = document.getElementById('PostBackAction');
    var postBackArgument = document.getElementById('PostBackArgument');
    var itemSystemNames = document.getElementById('ItemSystemNames');

    if (!f && document.forms.length > 0) {
        f = document.forms[0];
    }

    if (postBackField)
        postBackField.value = action;

    if (postBackArgument) {
        postBackArgument.value = argument || '';
    }

    if (itemSystemNames && typeof (id) != 'undefined')
        itemSystemNames.value = id;

    f.submit();
};

Dynamicweb.Items.ItemTypeList.prototype.initialize = function () {
    var self = this,
        list = $$('div.list');

    if (list != null && list.length > 0) {
        this._elements.list = $(list[0]);

        this._elements.list.observe('click', function (e) {
            var itemSystemName = '';
            var elm = Event.element(e);
            var row = elm.up('tr.listRow');

            if (row != null) {
                itemSystemName = $(row).readAttribute('itemID');
            }

            if (itemSystemName) {
                if (elm.tagName.toLowerCase() == 'img' && $(elm).hasClassName('cmd-delete')) {
                    Dynamicweb.Items.ItemTypeList.get_current().tryDeleteItem(itemSystemName);
                } else {
                    Dynamicweb.Items.ItemTypeList.get_current().openEditDialog(itemSystemName);
                }
            }

        });
    }
};
