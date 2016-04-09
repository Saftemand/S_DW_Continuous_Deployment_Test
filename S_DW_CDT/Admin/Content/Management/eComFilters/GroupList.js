/* Registering namespace */

if (typeof (eComFilters) == 'undefined') {
    var eComFilters = new Object();
}

/* End: registering namespace */

eComFilters.GroupList = function () {
    /// <summary>Provides supply functionality for eCommerce filter group list page.</summary>
}

// Used when validating a from so "Please wait" message will not blink if the Internet connection is good.
eComFilters.GroupList._waitTimeotID = null;

eComFilters.GroupList.help = function () {
    /// <summary>Opens the pop-up window with the help topic.</summary>

    eval(document.getElementById('jsHelp').innerHTML);
}

eComFilters.GroupList.initialize = function () {
    /// <summary>Performs initialization work.</summary>

    var name = $('GroupName');
    var list = $$('div.list');

    if (list != null && list.length > 0) {
        list = $(list[0]);

        list.observe('click', function (e) {
            var groupID = '';
            var elm = Event.element(e);
            var row = elm.up('tr.listRow');

            if (row != null) {
                groupID = row.id.replace(/row/gi, '');
            }

            if (elm.tagName.toLowerCase() == 'img') {
                eComFilters.GroupList.tryDeleteGroups(groupID);
            } else if (groupID) {
                location.href = '/Admin/Content/Management/eComFilters/FilterList.aspx?GroupID=' + groupID;
            }
        });
    }

    name.observe('keyup', function (e) {
        eComFilters.GroupList.onNameChanged();
    });

    name.observe('keydown', function (e) {
        if (e.keyCode == 13) {
            Event.stop(e);
            eComFilters.GroupList.trySaveGroup();
        }
    });

}

eComFilters.GroupList.openEditDialog = function (id, name) {
    /// <summary>Shows the "Edit group" dialog.</summary>
    /// <param name="id">An ID of the current group. Specify '-1' for new group.</param>
    /// <param name="name">The name of the group.</param>

    var row = null;
    var nameField = null;
    var groupID = document.getElementById('GroupID');
    var groupName = document.getElementById('GroupName');

    if (groupID && groupName) {
        if (id <= 0) {
            groupID.value = '-1';
            groupName.value = '';
        } else {
            groupID.value = id;
            if (!name) {
                row = List.getRowByID('lstGroups', id);
                if (row) {
                    nameField = $(row).select('input.group-name');
                    if (nameField != null && nameField.length > 0) {
                        groupName.value = nameField[0].value;
                    }
                }
            }
        }

        dialog.show('dlgEditGroup');

        eComFilters.GroupList.setValidatorIsVisible('valUnique', false);
        eComFilters.GroupList.setValidatorIsVisible('valUniqueStatus', false);

        eComFilters.GroupList.onNameChanged();

        setTimeout(function () {
            try {
                groupName.focus();
            } catch (ex) { }
        }, 50);
    }
}

eComFilters.GroupList.tryDeleteGroups = function (id) {
    /// <summary>Tries to delete specified group(s).</summary>
    /// <param name="id">Either a single group ID or comma-separated list of group IDs. Can be null as well.</param>

    var msg = document.getElementById('confirmDelete').innerHTML;

    ContextMenu.hide();

    if (typeof (id) == 'undefined') {
        id = eComFilters.GroupList.getSelectedGroups();
    }

    if (id && confirm(msg)) {
        eComFilters.GroupList.initiatePostBack('DeleteGroups', id);
    }
}

eComFilters.GroupList.trySaveGroup = function () {
    /// <summary>Tries to save current group.</summary>

    var id = document.getElementById('GroupID');
    var name = document.getElementById('GroupName');

    eComFilters.GroupList.setValidatorIsVisible('valUnique', false);
    eComFilters.GroupList.setValidatorIsVisible('valUniqueStatus', false);

    if (id && name && name.value.length > 0) {
        if (eComFilters.GroupList._waitTimeotID) {
            clearTimeout(eComFilters.GroupList._waitTimeotID);
            eComFilters.GroupList._waitTimeotID = null;
        }

        eComFilters.GroupList.setEnableFormChanges(false);

        eComFilters.GroupList._waitTimeotID = setTimeout(function () {
            eComFilters.GroupList.setValidatorIsVisible('valUniqueStatus', true);
            eComFilters.GroupList._waitTimeotID = null;
        }, 500);

        eComFilters.GroupList.validateName(id.value, name.value, function (result) {
            if (eComFilters.GroupList._waitTimeotID) {
                clearTimeout(eComFilters.GroupList._waitTimeotID);
                eComFilters.GroupList._waitTimeotID = null;
            }

            eComFilters.GroupList.setValidatorIsVisible('valUniqueStatus', false);
            eComFilters.GroupList.setEnableFormChanges(true);

            if (result.isValid) {
                dialog.hide('dlgEditGroup');
                eComFilters.GroupList.initiatePostBack('EditGroup', id.value);
            } else {
                eComFilters.GroupList.setValidatorIsVisible('valUnique', true);

                try {
                    setTimeout(function () { name.focus(); }, 50);
                } catch (ex) { }
            }
        });
    }
}

eComFilters.GroupList.setEnableFormChanges = function (areEnabled) {
    var name = document.getElementById('GroupName');
    var cmdOk = $('dlgEditGroup').select('button.dialog-button-ok');

    if (cmdOk) {
        cmdOk = cmdOk[0];
    }

    if (name) {
        name.disabled = !areEnabled;
    }

    if (cmdOk) {
        cmdOk.disabled = !areEnabled;
    }
}

eComFilters.GroupList.setValidatorIsVisible = function (id, isVisible) {
    /// <summary>Switches "unique" validator visibility state.</summary>
    /// <param name="id">Validator ID.</param>
    /// <param name="isVisible">Value indicating whether validator is visible.</param>

    var validator = document.getElementById(id);

    if (validator) {
        validator.style.display = (isVisible ? 'block' : 'none');
    }
}

eComFilters.GroupList.onNameChanged = function () {
    /// <summary>Occurs when the name of the group has changed.</summary>
    /// <param name="e">Event object (can be null).</param>

    var name = document.getElementById('GroupName');
    var cmdOk = $('dlgEditGroup').select('button.dialog-button-ok');

    if (name != null && cmdOk != null && cmdOk.length > 0) {
        cmdOk[0].disabled = (name.value.length == 0);
    }
}

eComFilters.GroupList.validateName = function (id, name, onComplete) {
    /// <summary>Performs group name validation.</summary>
    /// <param name="id">An ID of the group.</param>
    /// <param name="name">Group name.</param>
    /// <param name="onComplete">Function to be called when validation is complete.</param>

    var callback = onComplete || function () { }

    if (name) {
        new Ajax.Request('/Admin/Content/Management/eComFilters/GroupList.aspx?PostBackAction=CheckGroupName&GroupName=' +
            encodeURIComponent(name) + '&GroupID=' + encodeURIComponent(id), {
                method: 'get',
                onComplete: function (transport) {
                    callback({ isValid: transport.responseText != 'true' });
                }
            });
    } else {
        callback({ isValid: false });
    }
}

eComFilters.GroupList.onSelectGroupContextMenuView = function (sender, args) {
    /// <summary>Determines the contents of the context-menu.</summary>
    /// <param name="sender">Event sender.</param>
    /// <param name="args">Event arguments.</param>

    var ret = '';
    var rows = List.getSelectedRows('lstGroups');

    if (rows == null || rows.length < 2) {
        ret = 'SingleItem';
    } else {
        ret = 'MultipleItems';
    }

    return ret;
}

eComFilters.GroupList.getSelectedGroups = function () {
    /// <summary>Retrieves a comma-separated list of group IDs representing currently selected groups.</summary>

    var ret = '';
    var rows = List.getSelectedRows('lstGroups');

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
}

eComFilters.GroupList.initiatePostBack = function (action, id) {
    /// <summary>Causes a postback process to start.</summary>
    /// <param name="action">Name of the postback action.</param>
    /// <param name="id">Either a single group ID or comma-separated list of group IDs to be submitted.</param>

    var f = document.getElementById('MainForm');
    var groupID = document.getElementById('GroupID');
    var postBackField = document.getElementById('PostBackAction');

    if (!f && document.forms.length > 0) {
        f = document.forms[0];
    }

    if (postBackField)
        postBackField.value = action;

    if (groupID && typeof(id) != 'undefined')
        groupID.value = id;

    f.submit();
}



