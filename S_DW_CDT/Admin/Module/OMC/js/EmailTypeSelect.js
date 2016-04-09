var EmailTypeSelect = new Object();

EmailTypeSelect.topFolderSubject = "";

EmailTypeSelect.onRowOver = function (row) {
    row.className = 'over';
}

EmailTypeSelect.onRowOut = function (row) {
    row.className = '';
}

EmailTypeSelect.newBlankEmail = function () {
    $('templateId').value = '';
    $('subject').value = EmailTypeSelect.topFolderSubject;
    $('subject').focus();
    EmailTypeSelect.showDialog();
}

EmailTypeSelect.newTemplateBasedEmail = function (templateId, subject) {
    $('templateId').value = templateId;
    $('subject').value = subject;
    $('subject').focus();
    EmailTypeSelect.showDialog();
}

EmailTypeSelect.showDialog = function () {
    dialog.show('NewEmailDialog');
    $('subject').focus();
}

EmailTypeSelect.newEmailOk = function () {
    $('cmdSubmit').click();
    dialog.hide('NewEmailDialog');
    var __o = new overlay('ribbonOverlay');
    __o.message('');
    __o.show();
}
