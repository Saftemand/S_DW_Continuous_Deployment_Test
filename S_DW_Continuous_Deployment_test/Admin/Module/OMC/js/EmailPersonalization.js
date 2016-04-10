if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Page) == 'undefined') {
    Dynamicweb.Page = new Object();
}

Dynamicweb.Page.Personalization = function () {
    this._pageId = 0;
    this._terminology = {};
    this._segmentSections = [];
}

Dynamicweb.Page.Personalization._instance = null;

Dynamicweb.Page.Personalization.get_current = function () {
    if (!Dynamicweb.Page.Personalization._instance) {
        Dynamicweb.Page.Personalization._instance = new Dynamicweb.Page.Personalization();
    }

    return Dynamicweb.Page.Personalization._instance;
}

Dynamicweb.Page.Personalization.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Page.Personalization.prototype.set_pageID = function (pageID) {
    this._pageId = pageID;
}

Dynamicweb.Page.Personalization.prototype.initialize = function () {
    var self = this;

    var cells = $$('td.cell-show-as');
    for (var i = 0; i < cells.length; i++) {
        Event.observe(cells[i], 'click', function (e) {
            self.clickShowAsCell(this);
        });
    }

    cells = $$('td.cell-segment');
    for (var i = 0; i < cells.length; i++) {
        Event.observe(cells[i], 'click', function (e) {
            self.clickSegmentCell(this);
        });
    }

    var tblHeadObj = $("ListTable").tHead;
    for (var h = 0; h < tblHeadObj.rows.length; h++) {
        var row = tblHeadObj.rows[h];
        if (row.cells.length > this._segmentSections.length + 2) {
            for (var i = 0; i < this._segmentSections.length; i++) {
                var segmentID = self._segmentSections[i];
                var menuCell = row.cells[i + 2].down("tr").insertCell(-1);
                menuCell.innerHTML = '<a href="javascript:void(0);" class="columnMenu"><img style="margin-bottom: -3px" src="/Admin/Images/Ribbon/UI/List/column_menu.png" border="0"></a>';
                Event.observe(menuCell, 'click', self.showSegmentContextMenu.curry(segmentID));
            }
        }
    }
}

Dynamicweb.Page.Personalization.prototype.clickShowAsCell = function (elm) {
    var tr = elm.up("tr");
    tr.toggleClassName("show");
    elm.toggleClassName("show");

    for (var i = 2; i < tr.cells.length; i++) {
        var cell = tr.cells[i];
        if (cell.hasClassName('selected')) {
            cell.removeClassName('selected');
        }
        if (cell.down()) {
            if ((elm.hasClassName('show') && cell.hasClassName('selected')) ||
                (!elm.hasClassName('show') && !cell.hasClassName('selected'))) {
                cell.down().className = "default";
            } else {
                cell.down().className = "";
            }
        }
    }
}

Dynamicweb.Page.Personalization.prototype.clickSegmentCell = function (elm) {    
    elm.toggleClassName("selected");
    var tr = elm.up("tr");
    if (tr.cells.length > 1) {        
        if ((elm.hasClassName('selected') && tr.cells[1].hasClassName('show')) ||
            (!elm.hasClassName('selected') && !tr.cells[1].hasClassName('show'))) {
            elm.down().className = "default";
        } else {
            elm.down().className = "";
        }
    }
}

Dynamicweb.Page.Personalization.prototype.openWindow = function (url, windowName, width, height, onPopupClose) {
    if (window.showModalDialog) {
        var returnValue = window.showModalDialog(url, windowName, 'dialogHeight:' + height + 'px; dialogWidth:' + width + 'px;');
        if (onPopupClose) {
            onPopupClose(returnValue);
        }
        return returnValue;
    }
    else {
        if (onPopupClose) {
            var self = this;
            window[windowName + "_modalDialogOk"] = function () {
                onPopupClose.apply(self, arguments);
            }
        }
        var popupWnd = window.open(url, windowName, 'status=0,toolbar=0,menubar=0,resizable=0,directories=0,titlebar=0,modal=yes,width=' + width + ',height=' + height);
    }

}

Dynamicweb.Page.Personalization.prototype.addSegment = function () {
    var providerParams = 'popup=on&frameLevel=4&providerType=Dynamicweb.Modules.Searching.SmartSearch.UserProviderSmartSearch';
    var self = this;
    this.openWindow('/Admin/Content/Management/Smartsearches/Default.aspx?' + providerParams, 'AddSegmentPopup', 1000, 600,  function (returnValue) {
        if (returnValue && returnValue.listID && returnValue.listName) {
            var segmentID = returnValue.listID;
            var segmentName = returnValue.listName;
            self.addSegmentWithID(segmentID, segmentName);
        }
    });
}

Dynamicweb.Page.Personalization.prototype.addSegmentWithID = function (segmentID, segmentName) {
    var self = this;

    if (this._segmentSections.indexOf(segmentID) > -1) {
        return;
    }
    this._segmentSections.push(segmentID);
    var cellIndex = this._segmentSections.length + 1;

    var tblHeadObj = $("ListTable").tHead;
    for (var h = 0; h < tblHeadObj.rows.length; h++) {
        var newCell = tblHeadObj.rows[h].insertCell(cellIndex);
        newCell.className = 'columnCell';
        newCell.style.cssText = 'white-space: nowrap;min-width: 40px;';
        newCell.innerHTML = '<table cellspacing="0" cellpadding="0" border="0" style="width: 100%; height: 18px;"><tbody><tr><td><span class="pipe" style="float:left;"><img src="/Admin/Images/x.gif"></span>&nbsp;' + segmentName + '</td></tr></tbody></table>';

        var menuCell = newCell.down("tr").insertCell(-1);
        menuCell.innerHTML = '<a href="javascript:void(0);" class="columnMenu"><img style="margin-bottom: -3px" src="/Admin/Images/Ribbon/UI/List/column_menu.png" border="0"></a>';
        Event.observe(menuCell, 'click', function (e) {
            self.showSegmentContextMenu(segmentID, e);
        });
    }

    var tblBodyObj = $("ListTable").tBodies[0];
    for (var i = 0; i < tblBodyObj.rows.length; i++) {
        var newCell = tblBodyObj.rows[i].insertCell(cellIndex);
        newCell.className = 'cell-segment';
        var defaultElm = tblBodyObj.rows[i].down(1);
        if (defaultElm && !defaultElm.hasClassName('show')) {
            newCell.innerHTML = '<span class="default" />';
        } else {
            newCell.innerHTML = '<span />';
        }        
        Event.observe(newCell, 'click', function (e) {
            self.clickSegmentCell(this);
        });
    }
}

Dynamicweb.Page.Personalization.prototype.delSegment = function (segmentID) {
    var cellIndex = this._segmentSections.indexOf(segmentID);
    if (cellIndex > -1) {
        this._segmentSections.splice(cellIndex, 1);

        cellIndex += 2;
        var allRows = $("ListTable").rows;
        for (var i = 0; i < allRows.length; i++) {
            if (allRows[i].cells.length > cellIndex) {
                allRows[i].deleteCell(cellIndex);
            }
        }
    }
}

Dynamicweb.Page.Personalization.prototype.showSegmentContextMenu = function (segmentID, e) {
    return ContextMenu.show(e, 'SegmentContextMenu', segmentID, '', 'BottomRight');
}

Dynamicweb.Page.Personalization.prototype.selectSegment = function (segmentID) {
    var cellIndex = this._segmentSections.indexOf(segmentID);
    if (cellIndex > -1) {
        cellIndex += 2;

        var allRows = $("ListTable").rows;
        for (var i = 0; i < allRows.length; i++) {
            var cell = allRows[i].cells[cellIndex];
            if (!allRows[i].hasClassName('show')) {
                if (!cell.hasClassName('selected')) {
                    cell.addClassName('selected');
                }
            }
            else {
                if (cell.hasClassName('selected')) {
                    cell.removeClassName('selected');
                }
            }
        }
    }
}

Dynamicweb.Page.Personalization.prototype.deselectSegment = function (segmentID) {
    var cellIndex = this._segmentSections.indexOf(segmentID);
    if (cellIndex > -1) {
        cellIndex += 2;

        var allRows = $("ListTable").rows;
        for (var i = 0; i < allRows.length; i++) {
            var cell = allRows[i].cells[cellIndex];
            if (allRows[i].hasClassName('show')) {
                if (!cell.hasClassName('selected')) {
                    cell.addClassName('selected');
                }
            }
            else {
                if (cell.hasClassName('selected')) {
                    cell.removeClassName('selected');
                }
            }
        }
    }
}

Dynamicweb.Page.Personalization.prototype.saveSegments = function () {
    var self = this;
    var segments = [];

    var tblBodyObj = $("ListTable").tBodies[0];
    for (var i = 0; i < tblBodyObj.rows.length; i++) {
        var segment = {};
        var row = tblBodyObj.rows[i];

        segment.Id = row.readAttribute("itemid");
        segment.Show = row.hasClassName("show");
        segment.Sections = [];
        for (var j = 0; j < this._segmentSections.length; j++) {
            segment.Sections.push(row.cells[j + 2].hasClassName("selected"));
        }

        segments.push(segment);
    }

    new Ajax.Request("/Admin/Module/OMC/Emails/EmailPersonalization.aspx", {
        method: 'post',
        parameters: {
            AJAX: 'SaveSegments',
            PageID: this._pageId,
            Segments: JSON.stringify(segments),
            Sections: JSON.stringify(this._segmentSections)
        },
        onSuccess: function (response) {
            self.close();
        }
    });

}

Dynamicweb.Page.Personalization.prototype.close = function () {
    parent.OMCPersonalizationDialog_wnd.hide();
}