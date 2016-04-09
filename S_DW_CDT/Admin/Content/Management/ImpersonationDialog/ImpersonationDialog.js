var ImpersonationDialog = function(containerID, dialogID) {
    this.containerID = containerID;
    this.dialogID = dialogID.replace(containerID + '_', '');
}

ImpersonationDialog.prototype.show = function() {
    dialog.show(this.dialogID);
}

ImpersonationDialog.prototype.hide = function() {
    dialog.hide(this.dialogID);
}

ImpersonationDialog.prototype.submit = function() {
    var frm = null;
    var doImpersonation = $(this.dialogID).select('input.impersonate');

    if (document.forms.length > 0)
        frm = document.forms[0];

    if (doImpersonation && doImpersonation.length > 0)
        doImpersonation[0].value = 'true';

    if (frm)
        frm.submit();
}

ImpersonationDialog.prototype.setCredentialsAreVisible = function(areVisible) {
    var row = $(this.dialogID).select('tr.customCredentials');

    if (row && row.length > 0) {
        if (areVisible)
            $(row[0]).show();
        else
            $(row[0]).hide();
    }
}
