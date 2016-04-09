if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.ManagementTree) == 'undefined') {
    Dynamicweb.ManagementTree = new Object();
}

Dynamicweb.ManagementTree = function () {
    this._terminology = {};
    this._targetItemID = null;
}

Dynamicweb.ManagementTree._instance = null;

Dynamicweb.ManagementTree.get_current = function () {
    if (!Dynamicweb.ManagementTree._instance) {
        Dynamicweb.ManagementTree._instance = new Dynamicweb.ManagementTree();
    }

    return Dynamicweb.ManagementTree._instance;
}

Dynamicweb.ManagementTree.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.ManagementTree.prototype.initiatePostBack = function (action, id, argument) {
    var f = document.getElementById('ManagementTreeForm');
    var postBackField = document.getElementById('PostBackAction');
    var postBackArgument = document.getElementById('PostBackArgument');
    var itemSystemNames = document.getElementById('NodeSystemName');
    var openTo = document.getElementById('OpenTo');

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

    if (openTo)
        openTo.value = "ContentTypes";

    f.submit();
}

Dynamicweb.ManagementTree.treeReload = function () {
    // reload content tree
    top.left.location.reload(true);
}

Dynamicweb.ManagementTree.prototype.tryDeleteItem = function () {
    var itemID = ContextMenu.callingItemID;
    this._targetItemID = itemID;
    var self = this;
    var itemHasItemList = false;

    var url = "/Admin/Content/Management/Default.aspx?AJAX=ValidateDeletion&random=" + Math.random();
    new Ajax.Request(url, {
        method: 'post',
        parameters: {
            NodeSystemName: itemID
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
                    if (error.ItemListReference != undefined) {
                        itemListErr += self.get_terminology()['ItemListReference']
                        if (itemID.indexOf('ctCat') > -1) {
                            itemListErr += "\n" + self.get_terminology()['ItemListMessage'] + " ";
                            error.ItemListReference.forEach(function (name) {
                                itemListErr += "\n" + name;
                            });
                            itemListErr += "\n\n";
                        }
                        itemListErr += "\n\n";
                    }
                    if (error.ItemInheritanceReference != undefined) {
                        itemInheritanceErr += self.get_terminology()['ItemInheritanceReference'];
                        if (itemID.indexOf('ctCat') > -1) {
                            itemInheritanceErr += "\n" + self.get_terminology()['ItemListMessage'] + " ";
                            error.ItemInheritanceReference.forEach(function (name) {
                                itemInheritanceErr += "\n" + name;
                            });
                            itemInheritanceErr += "\n\n";
                        }
                        itemInheritanceErr += "\n\n";
                    }
                    if (error.itemHasItemRelatedList != undefined) {
                        itemHasItemRelatedListErr += self.get_terminology()['itemHasItemRelatedList'];
                        if (itemID.indexOf('ctCat') > -1) {
                            itemHasItemRelatedListErr += "\n" + self.get_terminology()['ItemListMessage'] + " ";
                            error.itemHasItemRelatedList.forEach(function (name) {
                                itemHasItemRelatedListErr += "\n" + name;
                            });
                        }
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
}

Dynamicweb.ManagementTree.prototype.deleteItem = function () {
    var systemName = this._targetItemID;
    this._targetItemID = null;

    dialog.hide('dlgDeleteItemTypes');
    new overlay('PleaseWait').show();

    this.initiatePostBack('DeleteItemTypes', systemName, document.getElementById('DeleteModePreservePages').checked ? 'PreservePages' : 'DeletePages');
}

Dynamicweb.ManagementTree.onItemTypeMenuView = function() {
    var view = "item";
    var itemID = ContextMenu.callingItemID;

    if (itemID == "ContentTypes") {
        view = "root";
    }
    else if (itemID.startsWith("ctCat_")) {
        view = "category";
    }

    return view;
}

Dynamicweb.ManagementTree.onRepositoriesMenuView = function () {
    var view = "repository";
    var itemID = ContextMenu.callingItemID;

    if (itemID == "Repositories") {
        view = "root";
    }

    return view;
}

Dynamicweb.ManagementTree.prototype.addItemType = function () {
    var itemID = ContextMenu.callingItemID;

    if (itemID == "ContentTypes") {
        this.setContent('/Admin/Content/Items/ItemTypes/ItemTypeEdit.aspx?Category=');
    }
    else if (itemID.startsWith("ctCat_")) {
        var category = itemID.substring("ctCat_".length);
        this.setContent('/Admin/Content/Items/ItemTypes/ItemTypeEdit.aspx?Category=' + category);
    }
}

Dynamicweb.ManagementTree.prototype.editItemType = function () {
    var n = t.getNodeByID(ContextMenu.callingID);
    this.setContent(n.url);
}

Dynamicweb.ManagementTree.prototype.copyItemType = function () {
    var n = t.getNodeByID(ContextMenu.callingID);
    this.setContent(n.url + '&Mode=copy');
}

Dynamicweb.ManagementTree.prototype.setContent = function (link) {
    var frame = document.getElementById('ContentFrame');

    if (frame) {
        frame.contentWindow.document.location = link;
    }
}