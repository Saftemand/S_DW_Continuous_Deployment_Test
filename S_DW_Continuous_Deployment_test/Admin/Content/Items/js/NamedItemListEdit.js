if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = new Object();
}

Dynamicweb.Items.NamedListItemEdit = function () {
    this._terminology = {};
    this._page = [];
    this._list = null;
    this._sort = null;
}

Dynamicweb.Items.NamedListItemEdit._instance = null;

Dynamicweb.Items.NamedListItemEdit.get_current = function () {
    if (!Dynamicweb.Items.NamedListItemEdit._instance) {
        Dynamicweb.Items.NamedListItemEdit._instance = new Dynamicweb.Items.NamedListItemEdit();
    }

    return Dynamicweb.Items.NamedListItemEdit._instance;
}

Dynamicweb.Items.NamedListItemEdit.prototype.initialize = function () {
    var self = this;

    // Set List height
    window.onload = window.onresize = function () {
        var ribbonHeight = 0;
        if ($('Ribbon')) {
            ribbonHeight = $('Ribbon').offsetHeight;
        }

        if ($('content')) {
            var contentPaneHeight = (document.body.clientHeight - ribbonHeight - 3);
            if (contentPaneHeight < 0) {
                contentPaneHeight = 1;
            }

            $('content').style.height = contentPaneHeight + 'px';
        }
    }

    if (this._list) {
        var controlid = this._list + "_body";
        var tblHeadObj = $(controlid).up("table").tHead;
        var row = tblHeadObj.rows[0];
        var sortIndex = this._sort ? parseInt(this._sort.by) : -1;

        for (var i = 0; i < row.cells.length - 2; i++) {
            var menuCell = row.cells[i].down("tr").insertCell(-1);
            menuCell.setAttribute("align", "right");
            menuCell.innerHTML = '<a href="javascript:void(0);" class="columnMenu">';
            if (sortIndex == i) {
                if (this._sort.order == "asc")
                    menuCell.innerHTML += '<img src="/Admin/Images/Ribbon/UI/List/column_menu_up.png" border="0" />';
                else
                    menuCell.innerHTML += '<img src="/Admin/Images/Ribbon/UI/List/column_menu_down.png" border="0" />';
            }
            else {
                menuCell.innerHTML += '<img style="margin-bottom: -3px" src="/Admin/Images/Ribbon/UI/List/column_menu.png" border="0">';
            }
            menuCell.innerHTML += '</a>';

            Event.observe(menuCell, 'click', self.showSortContextMenu.curry(i));
        }
    }
    parent.ItemListsPopup_wnd.add_hide(function () {
        self.saveSorting();
    });
}

Dynamicweb.Items.NamedListItemEdit.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Items.NamedListItemEdit.prototype.get_page = function () {
    return this._page;
}

Dynamicweb.Items.NamedListItemEdit.prototype.set_page = function (value) {
    this._page = value;
}

Dynamicweb.Items.NamedListItemEdit.prototype.set_list = function (value) {
    this._list = value;
}

Dynamicweb.Items.NamedListItemEdit.prototype.set_sort = function (value) {
    this._sort = value;
}

Dynamicweb.Items.NamedListItemEdit.prototype.showAddNamedItemListDialog = function () {
    dialog.show('AddNamedItemListDialog');
}

Dynamicweb.Items.NamedListItemEdit.prototype.addNamedItemList = function () {
    var name = $('NamedListName');
    var itemType = $('NamedListItemType');
    if (!name.value || !name.value.length) {
        try {
            name.focus();
        } catch (ex) { }
        alert(this.get_terminology()['EmptyName']);
        return;
    } else if (!itemType.value || !itemType.value.length) {
        try {
            itemType.focus();
        } catch (ex) { }
        alert(this.get_terminology()['EmptyItemType']);
        return;
    }
    for (var i = 0; i < $('lstNamedItemLists').length; i++) {
        if ($('lstNamedItemLists').options[i].text == name.value) {
            alert(this.get_terminology()['NameShouldBeUnique']);
            return;
        }
    }

    dialog.hide('AddNamedItemListDialog');

    this.executeCommand("CreateNewList");
}

Dynamicweb.Items.NamedListItemEdit.prototype.loadNamedList = function () {
    this.saveSorting();

    this.executeCommand("Load");
}

Dynamicweb.Items.NamedListItemEdit.prototype.showPage = function () {
    window.open('/Default.aspx?ID=' + this.get_page().id + '&Purge=True', 'ItemWindow');
}

Dynamicweb.Items.NamedListItemEdit.prototype.switchToItem = function () {
    location = '/Admin/Content/Items/Editing/ItemEdit.aspx?PageID=' + this.get_page().id;
}

Dynamicweb.Items.NamedListItemEdit.prototype.switchToParagraphs = function () {
    location = '/Admin/Content/ParagraphList.aspx?PageID=' + this.get_page().id + '&mode=viewParagraphs';
}

Dynamicweb.Items.NamedListItemEdit.prototype.showSortContextMenu = function (segmentID, e) {
    return ContextMenu.show(e, 'SortingContextMenu', segmentID, '', 'BottomRight');
}

Dynamicweb.Items.NamedListItemEdit.prototype.sortAscending = function () {
    $('SortIndex').value = ContextMenu.callingID;
    $('SortOrder').value = "asc";
    this.executeCommand("SortList");
}

Dynamicweb.Items.NamedListItemEdit.prototype.sortDescending = function () {
    $('SortIndex').value = ContextMenu.callingID;
    $('SortOrder').value = "desc";
    this.executeCommand("SortList");
}

Dynamicweb.Items.NamedListItemEdit.prototype.executeCommand = function (cmd) {
    $('cmd').value = cmd;
    $('MainForm').submit();
}

Dynamicweb.Items.NamedListItemEdit.prototype.deleteItemList = function (cmd) {
    if (confirm(this.get_terminology()['ConfirmDeleteList'])) {
        this.executeCommand("DeleteList");
    }
}

Dynamicweb.Items.NamedListItemEdit.prototype.saveSorting = function () {
    var self = this;

    // Fire event to handle save sorting
    window.document.fire("General:DocumentOnSave");

    var hidden = null;
    var hiddens = document.getElementsByName(this._list);
    if (hiddens.length > 0) {
        hidden = hiddens[0];
    }
    if (hidden && hidden.value) {
        var params = {
            IsAjax: true,
            AjaxAction: 'UpdateSortIndexes',
            lstNamedItemLists: JSON.parse(hidden.value).Id
        }
        params[this._list] = hidden.value;
        new parent.Ajax.Request('/Admin/Content/Items/Editing/NamedItemListEdit.aspx', {
            method: 'POST',
            parameters: params
        });
    }
}
