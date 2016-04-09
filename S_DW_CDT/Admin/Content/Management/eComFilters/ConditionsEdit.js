var FieldConditionsEdit = new Object();

FieldConditionsEdit.deleteRow = function (link) {
    var optionName = '';
    var row = dwGrid_conditionsGrid.findContainingRow(link);

    if (row) {
        if (confirm(document.getElementById('spDeleteCondition').innerHTML)) {
            dwGrid_conditionsGrid.deleteRows([row]);
        }
    }
}

FieldConditionsEdit.validate = function () {
    var ret = false;

    if (document.getElementById('VisibilityRule1').checked) {
        if (parseInt(document.getElementById('fConditionsOriginal').value) > 0 && dwGrid_conditionsGrid.rows.getAll().length > 0) {
            ret = confirm(document.getElementById('spResetConditions').innerHTML);
        } else {
            ret = true;
        }
    } else {
        if (dwGrid_conditionsGrid.rows.getAll().length == 0) {
            alert(document.getElementById('spSpecifyConditions').innerHTML);
        } else {
            ret = true;
        }
    }

    return ret;
}

FieldConditionsEdit.setConditionsEditingIsEnabled = function (isEnabled) {
    var offset = null;
    var overlay = $('divGridDisabled');

    if (isEnabled) {
        overlay.hide();
    } else {
        overlay.show();
    }
}