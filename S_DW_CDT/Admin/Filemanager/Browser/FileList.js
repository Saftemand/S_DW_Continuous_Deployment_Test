// Fires when a row is selected or deselected
function rowSelected(writeAccess) {
    // Use enable or disable
    var enable = getSelectedRows().length > 0;
    var toggle = enable ? Ribbon.enableButton : Ribbon.disableButton;
    if (writeAccess == 'True') {
        toggle('btnCopy');
        toggle('btnMove');
        toggle('btnDelete');
        toggle('btnMetatags');
        toggle('btnRestore');
    }
}

function getSelectedRows() {
    var rows = new Array;
    var selectedRows = List.getSelectedRows('Files');
    if (selectedRows.length > 0) {
        for (var i = 0; i < selectedRows.length; i++) {
            rows[i] = selectedRows[i].getAttribute('itemID');
        }
        ContextMenu.callingID = selectedRows[0].getAttribute('id');
        ContextMenu.callingItemID = rows[0];
    }
    return rows;
}