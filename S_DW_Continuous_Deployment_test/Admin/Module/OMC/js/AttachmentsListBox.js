
Dynamicweb.Controls.OMC.EditableListBox.prototype.ShowManager = function(cliId) {
    window.open('/Admin/FileManager/Browser/Default.aspx?Mode=browseArchive&Caller=AttachListBox' + cliId + '&Folder=/Files', 'CMAttachmentsFilemanager', 'resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=1024,height=700,left=200,top=120').focus();
}

Dynamicweb.Controls.OMC.EditableListBox.prototype.OnAttachSelected = function(cliId) {
    var attchFile = document.getElementById(cliId);
    this.add(attchFile.value);
}