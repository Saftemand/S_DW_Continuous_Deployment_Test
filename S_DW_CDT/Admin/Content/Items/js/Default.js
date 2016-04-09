if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = new Object();
}

Dynamicweb.Items.Global = function () { }

Dynamicweb.Items.Global.isValidSystemName = function (name) {
    var ret = false;

    if (name && name.length) {
        ret = !!name.test(/^[0-9a-zA-Z_]$/gi); // Checking for allowed characters

        if (ret) {
            ret = name.indexOf('_') != 0; // Checking for leading underscores
        }
    }

    return ret;
}

Dynamicweb.Items.Global.makeSystemName = function (name) {
    var ret = name;

    if (ret && ret.length) {
        ret = ret.replace(/[^0-9a-zA-Z_\s]/gi, '_'); // Replacing non alphanumeric characters with underscores
        while (ret.indexOf('_') == 0) ret = ret.substr(1); // Removing leading underscores

        ret = ret.replace(/\s+/g, ' '); // Replacing multiple spaces with single ones
        ret = ret.replace(/\s([a-z])/g, function (str, g1) { return g1.toUpperCase(); }); // Camel Casing
        ret = ret.replace(/\s/g, '_'); // Removing spaces

        if (ret.length > 1) ret = ret.substr(0, 1).toUpperCase() + ret.substr(1); else ret = ret.toUpperCase();
    }

    return ret;
}

/* Item list editor */

Dynamicweb.Items.ListItem = function () {
    this._el = null;
    this._listId = '';
    this._pageId = '';
    this._areaId = '';
    this._popup = null;
    this._itemType = '';
    this._fields = [];
    this._newRowCounter = 0;
    this._terminology = {};
    this._sortIndexes = [];
    this._updateSortIndexes = false;
    this._sortBy = '';
    this._sortOrderAscending = true;
    this._askConfirmation = false;
    this._minNumber = 0;
    this._maxNumber = 0;
}

Dynamicweb.Items.ListItem.initialize = function (parameters) {
    var listItem = new Dynamicweb.Items.ListItem();
    listItem._el = $(parameters.listId + '_body_stretch');
    listItem._popup = parameters.popup;
    listItem._itemType = parameters.itemType;
    listItem._instantSave = parameters.instantSave;
    listItem._itemListId = parameters.itemListId;
    listItem._isDraft = parameters.isDraft;
    listItem._listId = parameters.listId;
    listItem._pageId = parameters.pageId;
    listItem._areaId = parameters.areaId;
    listItem._fields = parameters.fields;
    listItem._sortBy = parameters.sortBy;
    listItem._sortOrderAscending = parameters.sortOrderAscending;
    listItem._minNumber = parseInt(parameters.minNumber) || 0;
    listItem._maxNumber = parseInt(parameters.maxNumber) || 0;
    listItem._sortIndexes = $$('#' + parameters.listId + '_body_stretch tr[itemid]').collect(function (e) {
        e.writeAttribute('ID', parameters.listId + '_' + e.identify()); //fix sorting http://madrobby.github.io/scriptaculous/sortable-serialize/
        return e.readAttribute('itemID');
    });

    var list = $(parameters.listId + '_body');

    if (list) {
        list.observe('click', function (e) {
            var itemId = '';
            var elm = Event.element(e);
            var row = elm.up('tr.listRow');

            if (row != null) {
                if (row.hasClassName('been_dragged')) {
                    row.removeClassName('been_dragged');
                    if (row.hasClassName('hover')) return;
                }
                itemId = $(row).readAttribute('itemID');
            }

            if (elm.tagName.toLowerCase() == 'img') {
                if ($(elm).hasClassName('delete')) {
                    listItem.delRow(row);
                } else {
                    listItem.editClick(itemId);
                }
            } else if (itemId) {
                listItem.editClick(itemId);
            }
        });
    }

    var ctrlAddButton = $(parameters.listId + '_addButton');
    if (ctrlAddButton) {
        ctrlAddButton.observe('click', function (e) {
            listItem.addClick("List");
        });
    }
    ctrlAddButton = $(parameters.listId + '_addPageButton');
    if (ctrlAddButton) {
        ctrlAddButton.observe('click', function (e) {
            listItem.addClick("Page");
        });
    }
    ctrlAddButton = $(parameters.listId + '_addParagraphButton');
    if (ctrlAddButton) {
        ctrlAddButton.observe('click', function (e) {
            listItem.addClick("Paragraph");
        });
    }

    var ctrlSelector = $(parameters.listId + '_Selector');
    if (ctrlSelector) {
        ctrlSelector.onchange = (function (e) {
            return listItem.onItemEntrySelect(this);
        }).bind();
    }

    if (!listItem._sortBy) {
        /* Droppables patch - includes scroll offsets */
        Droppables.isAffected = function (point, element, drop) {
            return (
              (drop.element != element) &&
              ((!drop._containers) ||
                this.isContained(element, drop)) &&
              ((!drop.accept) ||
                (Element.classNames(element).detect(
                  function (v) { return drop.accept.include(v) }))) &&
              Position.withinIncludingScrolloffsets(drop.element, point[0], point[1]));
        }

        Position.includeScrollOffsets = true;

        Sortable.create(parameters.listId + '_body_stretch', {
            tag: 'tr',
            only: 'listRow',
            onUpdate: function () {
                listItem.onListChanged();
            }
        });

        Draggables.addObserver({
            onEnd: function (eventName, draggable, event) {
                var a = $(draggable.element);
                if (a && a.hasClassName('hover')) a.addClassName('been_dragged');
            }
        });

        list.select("tr.listRow").each(function (a) {
            Event.observe(a, 'mouseover', function (event) {
                this.addClassName('hover');
            });
            Event.observe(a, 'mouseout', function (event) {
                this.removeClassName('hover');
            });
        });
    }

    var form = $('MainForm') || $('ParagraphForm') || $('EditGroupForm') || $('EditUserForm');

    window.document.observe('General:DocumentOnSave', (function (event) {
        listItem._askConfirmation = false;

        // parameters.itemListId is NaN for old ItemListEditor
        if (listItem._updateSortIndexes && isNaN(parameters.itemListId)) {
            listItem.request({
                params: {
                    AjaxAction: 'UpdateSortIndexes',
                    Caller: parameters.listId,
                    ItemID: listItem._sortIndexes.join(',')
                }
            })
        }
        listItem.commitChanges(form, listItem._sortIndexes);
    }));

    window.onbeforeunload = (function () {
        if (listItem._askConfirmation && !listItem._instantSave) {
            listItem._askConfirmation = false;
            return listItem.get_terminology()['NotSavedWarningMessage'];
        }
    });

    return listItem;
}

Dynamicweb.Items.ListItem.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Items.ListItem.prototype.commitChanges = function (form, itemIds) {
    var hidden = null;
    var hiddens = document.getElementsByName(this._listId);
    if (hiddens.length > 0) {
        hidden = hiddens[0];
    }
    else {
        hidden = document.createElement('input');
        hidden.type = 'hidden';
        hidden.name = this._listId;
        form.appendChild(hidden);
    }

    if (isNaN(this._itemListId)) {
        hidden.value = itemIds.join(',');
    }
    else {
        var itemList = {
            Id: this._itemListId,
            ItemIds: itemIds
        }
        hidden.value = Object.toJSON(itemList);
    }
}

Dynamicweb.Items.ListItem.prototype.addClick = function (itemSourse) {
    if (this._maxNumber > 0 && this._maxNumber <= this._el.select('tr[itemid]').length) {
        alert(this.get_terminology()['MaximumNumberMessage']);
        return;
    }

    this._newRowCounter++;

    if (itemSourse == "Page")
        this.addStructureItem(false);
    else if (itemSourse == "Paragraph")
        this.addStructureItem(true);
    else
        this.addListItem();
}

Dynamicweb.Items.ListItem.prototype.addListItem = function () {
    var url = '/Admin/Content/Items/Editing/ItemListEdit.aspx?';
    url += 'ItemID=new_' + this._newRowCounter;
    url += '&new=true';
    url += '&Sort=' + this._sortIndexes.length;

    this.showPopup(url);
}

Dynamicweb.Items.ListItem.prototype.addStructureItem = function (showParagraphs) {
    var url, width, height;
    var selector = $(this._listId + '_Selector');

    width = showParagraphs ? 908 : 250;
    height = showParagraphs ? 375 : 450;

    url =
        "/Admin/Menu.aspx?ID=0&Action=Internal" +
        "&strShowParagraphsOption=" + (showParagraphs ? 'on' : 'off') +
        "&showparagraphs=" + (showParagraphs ? 'on' : 'off') +
        "&Caller=" + selector.identify() +
        "&ItemType=" + this._itemType +
        "&AreaID=" + this._areaId;

    window.open(url, '_new', 'resizable=true,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=' + width + ',height=' + height + ',top=155,left=202');
}

Dynamicweb.Items.ListItem.prototype.editClick = function (itemId) {
    var url = '/Admin/Content/Items/Editing/ItemListEdit.aspx?';
    url += 'ItemID=' + itemId;
    url += '&Sort=' + this._sortIndexes.indexOf(itemId);

    this.showPopup(url);
}

Dynamicweb.Items.ListItem.prototype.getScrollTopSum = function () {
    var top = 0;
    var elem = $(this._listId + '_body');

    while (elem) {
        top = top + elem.scrollTop;
        elem = elem.offsetParent;
    }

    return top;
}

Dynamicweb.Items.ListItem.prototype.showPopup = function (url) {
    url += '&PageId=' + this._pageId;
    url += '&Caller=' + this._listId;
    url += '&ItemType=' + this._itemType;
    url += '&IsDraft=' + this._isDraft;
    if (this._sortBy) {
        url += '&SortBy=' + this._sortBy;
        url += '&SortOrderAscending=' + this._sortOrderAscending;
    }
    if (this._instantSave && !isNaN(this._itemListId)) {
        url += '&InstantSave=true';
        url += '&ItemListID=' + this._itemListId;
    }

    this._popup.set_contentUrl(url);
    this._popup.set_width(800);
    this._popup.set_height(500);

    var bodyHeight = this.getScrollTopSum();
    bodyHeight += document.body.offsetHeight > 600 ? parseInt((document.body.offsetHeight - 700) / 2) : 10;
    this._popup.showAt(bodyHeight, 0);
}


Dynamicweb.Items.ListItem.prototype.request = function (options) {
    var self = this;

    if (!options || !options.params || !options.params.AjaxAction) {
        return;
    }

    options.params.ItemType = self._itemType;
    options.params.IsAjax = true;

    new Ajax.Request('/Admin/Content/Items/Editing/ItemListEdit.aspx', {
        method: 'POST',
        parameters: options.params,
        onCreate: function () {
            if (self._overlay) {
                self._overlay.show();
            }
        },
        onSuccess: function (transport) {
            var json;

            if (transport.responseText.isJSON()) {
                json = transport.responseText.evalJSON();
            }

            if (options.callback) {
                options.callback(transport.responseText, json);
            }
        },
        onFailure: function () {
            alert(self.get_translation('Error'));
        },
        onComplete: function () {
            if (self._overlay) {
                setTimeout(function () { self._overlay.hide(); }, 250);
            }
        }
    });
}


Dynamicweb.Items.ListItem.prototype.onItemEntrySelect = function (element) {
    var self = this, el = element;
    var itemType = el.readAttribute('data-page-itemtype') || el.readAttribute('data-paragraph-itemtype');
    if (this._itemType != itemType) {
        return { closeMenu: false };
    }

    if (el) {
        self.request({
            params: {
                AjaxAction: 'SaveStructureItem',
                ItemEntryPageId: el.readAttribute('data-page-id'),
                ItemEntryParagraphId: el.readAttribute('data-paragraph-id'),
                Caller: self._listId,
                SortBy: self._sortBy,
                SortOrderAscending: self._sortOrderAscending
            },
            callback: function (responseText, json) {
                var error = '';

                if (json) {
                    error = json.Error || '';
                } else {
                    error = self.get_translation['Error'];
                }

                if (!error) {
                    // clear data for further transferring
                    el.writeAttribute('data-page-id', '');
                    el.writeAttribute('data-page-name', '');
                    el.writeAttribute('data-page-itemtype', '');
                    el.writeAttribute('data-paragraph-id', '');
                    el.writeAttribute('data-paragraph-name', '');

                    self.addRow(json["Id"].Value, json);
                } else {
                    alert(error);
                }
            }
        });
    }
}

Dynamicweb.Items.ListItem.prototype.addRow = function (itemId, itemEntry) {
    var caller = this._listId + '_body'; // FldList_body
    var cellsCount = 0;
    var maxColWidth = 0;
    var doc = Dynamicweb.Ajax.Document.get_current();
    var collHelper = Dynamicweb.Utilities.CollectionHelper;
    var stringHelper = Dynamicweb.Utilities.StringHelper;
    var imageExtensions = ['.bmp', '.emf', '.exif', '.gif', '.guid', '.icon', '.jpeg', '.jpg', '.png', '.tiff', '.wmf'];

    var tbl = $(caller).down('table.main_stretcher') || $(caller).up('table');
    var rowCount = tbl.rows.length;
    var row = tbl.insertRow(rowCount);
    if (this._instantSave && !isNaN(this._itemListId)) {
        itemId = itemEntry.Id.Value;
    }
    row.id = itemId;
    row.setAttribute("itemID", itemId);
    row.setAttribute("style", "cursor:pointer;");
    row.setAttribute("class", "listRow");

    if (this._sortIndexes.indexOf(itemId) >= 0) {
        alert(this.get_terminology()['ItemAlreadyPresentMessage']);
        return;
    }

    this._sortIndexes.push(itemId);

    maxColWidth = Math.max(80, Math.floor((600) / this._fields.length) - 10);
    this._fields.forEach(function (field) {
        var fieldText = "";
        var output = "";
        var image = '';

        if (itemEntry[field]) {
            if (itemEntry[field].Type === 'Dynamicweb.Content.Items.Editors.FileEditor, Dynamicweb' && collHelper.any(imageExtensions, function (extension) { return itemEntry[field].Value.indexOf(extension) > -1; })) {
                image = itemEntry[field].Value;
                output = '<div class="item-list-editor-list-cell img" style="max-width:' + maxColWidth + 'px;"><img src="/Admin/Public/GetImage.ashx?fmImage_path=' + image + '&Format=jpg&Width=32&Height=32&Crop=5" title="' + stringHelper.fileName(image) + '" /></div>';
            } else if (itemEntry[field].Type === 'Dynamicweb.Content.Items.Editors.ProductEditor, Dynamicweb') {
                output = '<div class="item-list-editor-list-cell" style="max-width:' + maxColWidth + 'px;">' + itemEntry[field].Value + '</div>';
            } else {
                output = '<div class="item-list-editor-list-cell" style="max-width:' + maxColWidth + 'px;">' + doc.htmlEncode(doc.decodeTags(itemEntry[field].Value)) + '</div>';
            }
        //} else if (itemEntry[field + "_pageName"]) {
        //    output = '<div class="item-list-editor-list-cell" style="max-width:' + maxColWidth + 'px;">' + itemEntry[field + "_pageName"].Value + '</div>';
        }

        var cell = row.insertCell(cellsCount++);
        cell.update(output);
        cell.setAttribute("style", "width: auto");
    });
    var cell = row.insertCell(cellsCount++);
    cell.update('<img class="delete" src="/Admin/Images/Icons/Delete.png" alt="Delete" title="Delete" style="cursor:pointer;">');
    cell.setAttribute("style", "width: auto");

    cell = row.insertCell(cellsCount++);

    var infobar = $('InfoBar_' + this._listId);
    if (infobar) {
        var row = infobar.up('tr');
        if (row) row.parentNode.removeChild(row);

        // realign headers
        var stretcherId = this._listId + '_stretcher';
        var stretchers = List.get_stretchers();
        stretchers.forEach(function (s) {
            if (s._stretcherID == stretcherId) {
                s._initializeCache();
                s._alignHeaderCells();
            }
        });
    }

    if (this._sortBy) {
        var currentPosition = tbl.rows.length - 1;
        var rowPosition = parseInt(itemEntry["Sort"].Value);
        if (currentPosition != rowPosition) {
            this.moveRow(tbl, row, rowPosition);
        }
    }
    else {
        Sortable.create(this._listId + '_body_stretch', { tag: 'tr', only: 'listRow' });
    }
    this.onListChanged();
}

Dynamicweb.Items.ListItem.prototype.editRow = function (itemId, itemEntry) {
    var caller = this._listId + '_body';
    var cellsCount = 0;
    var maxColWidth = 0;
    var doc = Dynamicweb.Ajax.Document.get_current();
    var collHelper = Dynamicweb.Utilities.CollectionHelper;
    var stringHelper = Dynamicweb.Utilities.StringHelper;
    var imageExtensions = ['.bmp', '.emf', '.exif', '.gif', '.guid', '.icon', '.jpeg', '.jpg', '.png', '.tiff', '.wmf'];

    var tbl = $(caller).down('table.main_stretcher') || $(caller).up('table');
    var row = tbl.down('tr[itemID=' + itemId + ']');
    if (row) {
        var cells = row.select('td');
        maxColWidth = Math.max(80, Math.floor((600) / this._fields.length) - 10);
        this._fields.forEach(function (field) {
            var fieldText = "",
                prop,
                image;

            if (itemEntry[field]) {
                if (itemEntry[field].Type === 'Dynamicweb.Content.Items.Editors.FileEditor, Dynamicweb' && collHelper.any(imageExtensions, function (extension) { return itemEntry[field].Value.indexOf(extension) > -1; })) {
                    image = itemEntry[field].Value;
                    output = '<div class="item-list-editor-list-cell img" style="max-width:' + maxColWidth + 'px;"><img src="/Admin/Public/GetImage.ashx?fmImage_path=' + image + '&Format=jpg&Width=32&Height=32&Crop=5" title="' + stringHelper.fileName(image) + '" /></div>';
                } else {
                    output = '<div class="item-list-editor-list-cell" style="max-width:' + maxColWidth + 'px;">' + doc.htmlEncode(doc.decodeTags(itemEntry[field].Value)) + '</div>';
                }
            //} else if (itemEntry[field + "_pageName"]) {
            //    output = '<div class="item-list-editor-list-cell" style="max-width:' + maxColWidth + 'px;">' + itemEntry[field + "_pageName"].Value + '</div>';
            }

            var cell = cells[cellsCount++];
            //cell.update(fieldText);
            cell.update(output);
        });

        if (this._sortBy) {
            var currentPosition = this._sortIndexes.indexOf(itemId) + 1;
            var rowPosition = parseInt(itemEntry["Sort"].Value);
            if (currentPosition != rowPosition) {
                this.moveRow(tbl, row, rowPosition);
            }
        }
        this._askConfirmation = true;
    }
}

Dynamicweb.Items.ListItem.prototype.moveRow = function (tbl, row, index) {
    var rowCount = tbl.rows.length - 1;
    if (index <= rowCount) {
        row.remove();
        if (index == rowCount) {
            tbl.rows[index - 1].insert({ after: row });
        }
        else {
            tbl.rows[index].insert({ before: row });
        }
    }

    this.onListChanged();
}

Dynamicweb.Items.ListItem.prototype.delRow = function (row) {
    if (confirm(this.get_terminology()['DeleteFieldConfirm'])) {
        if (row) {
            row.parentNode.removeChild(row);
            this.onRowDeleted(row.readAttribute("itemid"));

            if (this._instantSave && !isNaN(this._itemListId)) {
                this.request({
                    params: {
                        AjaxAction: 'SaveDeletedItem',
                        ItemListID: this._itemListId,
                        ItemID: row.readAttribute("itemID")
                    }
                })
            }
        }
    }
}

Dynamicweb.Items.ListItem.prototype.onRowDeleted = function (itemId) {
    if (itemId.startsWith('new_')) {
        this.onListChanged();
    }
    else {
        var index = this._sortIndexes.indexOf(itemId);
        this._sortIndexes[index] = "delete_" + this._sortIndexes[index];
        this.onListChanged();
    }
}

Dynamicweb.Items.ListItem.prototype.onListChanged = function () {
    this._askConfirmation = true;
    this._updateSortIndexes = true;
    var deletedIndexes = [];
    for (var i = 0; i < this._sortIndexes.length; i++) {
        if (this._sortIndexes[i].startsWith('delete_')) {
            deletedIndexes.push(this._sortIndexes[i]);
        }
    }
    this._sortIndexes = this._el.select('tr[itemid]').collect(function (e) { return e.readAttribute('itemid'); });
    $(this._listId).value = this._sortIndexes && this._sortIndexes.length > 0 ? this._sortIndexes.length : '';
    for (var i = 0; i < deletedIndexes.length; i++) {
        this._sortIndexes.push(deletedIndexes[i]);
    }
}