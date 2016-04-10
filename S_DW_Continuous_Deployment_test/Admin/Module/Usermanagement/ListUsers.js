/* Represents user row context menu */
var RowContextMenu = function (params) {
    this.context = [];
    this._everyOneGroupID = -1000;

    this.parameters = { menuID: '', onSelectContext: null, groupID: -1 }

    if (params)
        this.parameters = params;
}

/* Registers new context */
RowContextMenu.prototype.registerContext = function (name, buttons) {
    if (!this.context)
        this.context = [];

    this.context[name] = buttons;
}

/* Switches current context menu according to specified context */
RowContextMenu.prototype.enableContext = function (name) {
    var buttons = null;
    var menuItems = null, item = null;
    var visibleItems = [];
    var itemIsDivider = false;
    var isVirtualGroup = false;
    var canShow = true;

    if (this.parameters.groupID) {
        isVirtualGroup = this.parameters.groupID ==
            this._everyOneGroupID;
    }

    if (this.context) {
        /* Retrieving buttons to be shown in the context menu */
        buttons = this.context[name];

        if (buttons) {
            menuItems = $$('div[id="' + this.parameters.menuID +
                '"] > span[class~="container"] > span');

            if (menuItems && menuItems.length > 0) {
                for (var i = 0; i < menuItems.length; i++) {
                    item = menuItems[i];
                    itemIsDivider = item.select('a[class="divider"]').length > 0;

                    if (isVirtualGroup)
                        canShow = (item.id != 'cmdDetachFromGroup' && item.id != 'cmdNewUser');

                    /* Showing button */
                    if ((this._findIndex(buttons, item.id) >= 0 || itemIsDivider) && canShow) {
                        /* Tracking all visible items (buttons & dividers) */
                        visibleItems[visibleItems.length] = { element: item, isDivider: itemIsDivider }
                        item.show();
                    }
                    else {
                        item.hide();
                    }
                }

                /* Hiding unnecessary dividers */
                this._hideDividers(visibleItems);
            }
        }
    }
}

/* Shows context menu */
RowContextMenu.prototype.show = function (row, eventObject) {
    var context = null;
    var itemID = '';
    if (row) {
        /* Retrieving user ID */
        itemID = row.id;
        if (itemID == null || itemID.length == 0)
            itemID = row.readAttribute('rowid');

        if (itemID)
            itemID = itemID.replace(/row/gi, '');

        /* Showing context menu */
        ContextMenu.show(eventObject, this.parameters.menuID, itemID);

        /* Switching context */
        if (typeof (this.parameters.onSelectContext) == 'function') {
            context = this.parameters.onSelectContext(row, itemID);
            this.enableContext(context);
        }
    }

    return false;
}

/* Hides unnecessary dividers */
RowContextMenu.prototype._hideDividers = function (visibleItems) {
    var item = null;

    for (var i = 0; i < visibleItems.length; i++) {
        item = visibleItems[i];

        if (item.isDivider) {
            if (i == visibleItems.length - 1)
                item.element.hide();
            else {
                if (i == 0)
                    item.element.hide();

                item = visibleItems[++i];
                while (i < visibleItems.length && item.isDivider) {
                    item.element.hide();
                    item = visibleItems[++i];
                }
            }
        }
    }
}

/* Searches for specified element in the specified array */
RowContextMenu.prototype._findIndex = function (list, element) {
    var ret = -1;

    if (list && typeof (list) != 'undefined') {
        for (var i = 0; i < list.length; i++) {
            if (list[i] == element) {
                ret = i;
                break;
            }
        }
    }

    return ret;
}

/* Represents user context menu actions */
var UserContext = function(groupID, smartSearchID)
{
    this.groupID = groupID;
    this.smartSearchID = smartSearchID;
}

/* 'Edit user' action */
UserContext.prototype.editUser = function (id) {
    var userID = ContextMenu.callingID;

    if (id != null)
        userID = id;

    this.openEditForm('?UserID=' + userID + '&GroupID=' + this.groupID + '&SmartSearchID=' + this.smartSearchID);
}

/* 'Delete' | 'Delete selected' action */
UserContext.prototype.deleteUser = function () {
    var message = $('spDeleteUser').innerHTML;
    var ids = this._getTargetIDs();

    ContextMenu.hide();

    if (typeof (ids) != 'undefined' && ids.indexOf(',') >= 0)
        message = $('spDeleteUsers').innerHTML;

    if (confirm(message)) {
        parent.navigateContent('ListUsers.aspx?cmd=Delete&GroupID=' +
            this.groupID + '&SmartSearchID=' + this.smartSearchID + '&UserID=' + ids);
    }
}

/* 'Activate' | 'Deactivate' | 'Activate selected' | 'Deactivate selected' action */
UserContext.prototype.setActive = function (isActive) {
    parent.navigateContent('ListUsers.aspx?cmd=SetActive&Active=' +
        isActive.toString() + '&GroupID=' + this.groupID + '&SmartSearchID=' + this.smartSearchID + '&UserID=' + this._getTargetIDs());
}

/* 'New user' action */
UserContext.prototype.newUser = function (copyFromExisting) {
    var params = '?GroupID=' + this.groupID + '&SmartSearchID=' + this.smartSearchID;

    if (copyFromExisting)
        params += '&CopyFrom=' + ContextMenu.callingID;

    this.openEditForm(params);
}

/* Shows group selection dialog */
UserContext.prototype.showGroupsDialog = function () {
    /* Showing dialog */
    dialog.show('AttachGroupsDialog');
}

/* Shows group selection dialog with all groups for the selected user */
UserContext.prototype.showAllGroupsDialog = function () {
    parent.navigateContent('ListUsers.aspx?cmd=showAllGroups&GroupID=' + this.groupID + '&SmartSearchID=' + this.smartSearchID +
        '&UserID=' + this._getTargetIDs());
}

/* Fired when groups are selected */
UserContext.prototype.attachToGroups = function () {
    var userIDs = getVarValueFromURL(window.location.search, "UserID");

    parent.navigateContent('ListUsers.aspx?cmd=Attach&GroupID=' + this.groupID + '&SmartSearchID=' + this.smartSearchID +
        '&UserID=' + userIDs + '&AttachTo=' + $('GroupsSelectorhidden').value);
}

/* 'Detach from group' action */
UserContext.prototype.detachFromGroup = function () {
    parent.navigateContent('ListUsers.aspx?cmd=Detach&GroupID=' + this.groupID + '&SmartSearchID=' + this.smartSearchID +
        '&UserID=' + this._getTargetIDs());
}

/* Opens user edit form */
UserContext.prototype.openEditForm = function (params) {
    document.location = 'EditUser.aspx' + params;
}

/* Retrieves action IDs */
UserContext.prototype._getTargetIDs = function () {
    var row = List.getRowByID('UserList', ContextMenu.callingID);
    var ret = ContextMenu.callingID;

    if (row) {
        if (List.rowIsSelected(row)) {
            ret = this._getSelectedIDs();
        }
    }

    return ret;
}

/* Retrieves IDs selected by the 'Multi-select' method */
UserContext.prototype._getSelectedIDs = function () {
    var rows = List.getSelectedRows('UserList');
    var ret = '', userID = '';

    if (rows && rows.length > 0) {
        for (var i = 0; i < rows.length; i++) {
            userID = rows[i].id;
            if (userID != null && userID.length > 0) {
                ret += (userID.replace(/row/gi, '') + ',')
            }
        }
    }

    if (ret.length > 0) {
        ret = ret.substring(0, ret.length - 1);
    }

    return ret;
}

function getVarValueFromURL(url, varName) {
    var query = url.substring(url.indexOf('?') + 1);
    var vars = query.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] === varName) {
            return pair[1];
        }
    }
    return "";
}