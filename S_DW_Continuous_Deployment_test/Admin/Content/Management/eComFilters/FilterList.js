/* Registering namespace */

if (typeof (eComFilters) == 'undefined') {
    var eComFilters = new Object();
}

/* End: registering namespace */

eComFilters.FilterList = function () {
    /// <summary>Provides supply functionality for eCommerce filters list page.</summary>
}

eComFilters.FilterList.initialize = function () {
    /// <summary>Performs initialization work.</summary>

    var list = $$('div.list');

    if (list != null && list.length > 0) {
        list = $(list[0]);

        list.observe('click', function (e) {
            var filterID = '';
            var elm = Event.element(e);
            var row = elm.up('tr.listRow');

            if (row != null) {
                filterID = row.id.replace(/row/gi, '');
            }

            GroupID = 0;

            if (elm.tagName.toLowerCase() == 'img') {
                eComFilters.FilterList.tryDeleteFilters(filterID);
            } else if (filterID) {
                eComFilters.FilterList.openEditDialog(filterID, GroupID);
            }
        });
    }
}

eComFilters.FilterList.help = function () {
    /// <summary>Opens the pop-up window with the help topic.</summary>

    eval(document.getElementById('jsHelp').innerHTML);
}

eComFilters.FilterList.openEditDialog = function (id, groupid) {
    /// <summary>Shows the "Edit filter" dialog.</summary>
    /// <param name="id">An ID of the current filter. Specify '-1' for new filter.</param>

    var dialog = null;
    var languageField = document.getElementById("selectedLangID");
    var language = null;

    if (languageField != null && languageField != 'undefined') {
        if (languageField.value != "") {
            language = "&selectedLangID=" + languageField.value;
        } else {
            language = "";
        }
    }

    if (typeof (dlgEditFilter_wnd) != 'undefined') {
        dialog = dlgEditFilter_wnd;

        dialog.set_contentUrl('/Admin/Content/Management/eComFilters/FilterEdit.aspx?ID=' + id + '&GroupID=' + groupid + language);
        dialog.show();
    }
}

eComFilters.FilterList.openVisibilityOptionsDialog = function (id) {
    /// <summary>Shows the "Edit visibility options" dialog.</summary>
    /// <param name="id">An ID of the current definition.</param>

    var dialog = null;

    if (typeof (dlgEditFilter_wnd) != 'undefined') {
        dialog = dlgEditFilter_wnd;

        dialog.set_contentUrl('/Admin/Content/Management/eComFilters/ConditionsEdit.aspx?ID=' + id);
        dialog.show();
    }
}

eComFilters.FilterList.tryDeleteFilters = function (id) {
    /// <summary>Tries to delete specified filter(s).</summary>
    /// <param name="id">Either a single filter ID or comma-separated list of filter IDs. Can be null as well.</param>

    var msg = document.getElementById('confirmDelete').innerHTML;

    ContextMenu.hide();

    if (typeof (id) == 'undefined') {
        id = eComFilters.FilterList.getSelectedFilters();
    }

    if (id && confirm(msg)) {
        eComFilters.FilterList.initiatePostBack('DeleteFilters', id);
    }
}

eComFilters.FilterList.setFiltersActive = function (active, id) {
    /// <summary>Switches specified filter(s) into the specified "Active" state.</summary>
    /// <param name="active">Value indicating whether filter(s) are active.</param>
    /// <param name="id">Either a single filter ID or comma-separated list of filter IDs. Can be null as well.</param>

    ContextMenu.hide();

    if (typeof (id) == 'undefined') {
        id = eComFilters.FilterList.getSelectedFilters();
    }

    if (id) {
        if (active) {
            eComFilters.FilterList.initiatePostBack('ToggleFiltersActive', id);
        } else {
            eComFilters.FilterList.initiatePostBack('ToggleFiltersInactive', id);
        }
    }
}

eComFilters.FilterList.getSelectedFilters = function () {
    /// <summary>Retrieves a comma-separated list of filter IDs representing currently selected filters.</summary>

    var ret = '';
    var rows = List.getSelectedRows('lstFilters');

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

eComFilters.FilterList.onSelectFilterContextMenuView = function (sender, args) {
    /// <summary>Determines the contents of the context-menu.</summary>
    /// <param name="sender">Event sender.</param>
    /// <param name="args">Event arguments.</param>

    var ret = '';
    var row = null;
    var activeRows = 0;
    var rows = List.getSelectedRows('lstFilters');

    if (rows == null || rows.length < 2) {
        if (rows.length > 0) {
            row = rows[0];
        } else {
            row = List.getRowByID('lstFilters', args.callingID);
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

eComFilters.FilterList.initiatePostBack = function (action, id) {
    /// <summary>Causes a postback process to start.</summary>
    /// <param name="action">Name of the postback action.</param>
    /// <param name="id">Either a single filter ID or comma-separated list of filter IDs to be submitted.</param>

    var dialog = null;
    var f = document.getElementById('MainForm');
    var filterID = document.getElementById('FilterID');
    var postBackField = document.getElementById('PostBackAction');


    if (typeof (dlgEditFilter_wnd) != 'undefined') {
        dialog = dlgEditFilter_wnd;

        dialog.hide();
    }

    if (!f && document.forms.length > 0) {
        f = document.forms[0];
    }

    if (postBackField)
        postBackField.value = action;

    if (filterID && typeof (id) != 'undefined')
        filterID.value = id;

    f.submit();
}