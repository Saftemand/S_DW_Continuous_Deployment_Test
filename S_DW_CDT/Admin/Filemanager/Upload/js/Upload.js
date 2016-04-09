/* Represents an upload status */
var UploadStatus = {
    /* Upload is not started yet */
    NotStarted: 1,
    
    /* Upload is in progress */
    Uploading: 2,
    
    /* Upload succeeded */
    Succeeded: 3,
    
    /* Upload failed */
    Failed: 4
};

/* Represents an upload controller */
var UploadController = function() {
    this.manager = null;
    this.events = new EventsManager();

    /* Occurs after the object has been initialized */
    this.events.registerEvent('initialize');

    this._fileAddedTimeoutID = -1;
    this._fileRemovedTimeoutID = -1;
}

/* Registers a new event handler for 'initialize' event */
UploadController.prototype.add_initialize = function(handler) {
    this.events.addHandler('initialize', handler);
}

/* Notifies all subscribers about specified event */
UploadController.prototype.notify = function(eventName, args) {
    this.events.notify(eventName, this, args);
}

/* Initializes a new instance of an object */
UploadController.prototype.initialize = function() {
    var obj = this;
    var onLoadCallback = $('stateOnLoad').value;

    /* Firing 'onLoad' event */
    if (onLoadCallback.length > 0) {
        try {
            eval(onLoadCallback + '(window, {});');
        } catch (ex) { }
    }

    /* Retrieving an instance of UploadManager object */
    this.manager = UploadManager.getInstance();

    /* Configuring 'Choose file' button */
    this.manager.initializeUploadControl({ buttonID: 'ctrlUpload', buttonImageUrl: '/Admin/Filemanager/Upload/images/select.png',
        buttonText: this.get_selectButtonText(), buttonTextStyle: this.get_selectButtonTextStyle(false)
    });

    /* Setting up initial state */
    this.set_isAllowedToOverwriteFiles($('stateIsAllowedToOverwriteFiles').value == 'true');
    this.set_targetLocation($$('div.fileLocation')[0].innerHTML);

    this.set_imageSettingIsEnabled(false);
    this.set_archiveSettingIsEnabled(false);
    this.set_groupIsEnabled('rowDimensions', false);
    this.set_groupIsEnabled('rowCreateFolders', false);

    if (this.manager.get_canUpload()) {
        /* Events handling */

        this.manager.add_fileAdded(function(sender, args) {
            obj.handleFileAdded(args.file);
        });

        this.manager.add_fileError(function(sender, args) {
            var fileName = null;
            var errorCode = Math.abs(args.errorCode);
            
            if (errorCode != 100)
                fileName = args.file.name;

            obj.displayMessage('Error', errorCode, fileName);
        });

        this.manager.add_fileRemoved(function(sender, args) {
            obj.handleFileRemoved(args.file);
        });

        this.manager.add_beforeUpload(function(sender, args) {
            obj.set_currentlyMaximumToUpload(obj.manager.get_filesCount());
            obj.set_currentlyUploaded(0);
        });

        this.manager.add_uploadStart(function(sender, args) {
            obj.set_customStatus(args.file, '');
            obj.set_progressIsVisible(args.file, true);
        });

        this.manager.add_uploadProgress(function(sender, args) {
            var percentage = Math.floor(args.bytesLoaded * 100 / args.bytesTotal);

            if (args.bytesLoaded < 0)
                percentage = 100;

            obj.set_uploadProgress(args.file, percentage);
        });

        this.manager.add_uploadSuccess(function(sender, args) {
            obj.set_uploadProgress(args.file, 100);
            obj.handleFileUploaded(args.file, (args.isSucceeded ? UploadStatus.Succeeded : UploadStatus.Failed), args.message);
        });

        this.manager.add_uploadError(function(sender, args) {
            obj.handleFileUploaded(args.file, UploadStatus.Failed);
        });

        this.manager.add_afterUpload(function(sender, args) {
            obj.handleUploadFinished();
        });

        /* End: Events handling */
    } else {
        Ribbon.showButton('cmdSelectFile');

        this.set_imageSettingIsEnabled(true);
        this.set_archiveSettingIsEnabled(true);
    }

    $(document.body).observe('click', function(event) {
        var elm = Event.element(event);

        if (!elm.hasClassName('fileLocation') && !elm.hasClassName('locationInput'))
            obj.set_locationEditing(false);
    });

    this.notify('initialize', {});
}

/* Displays a popup dialog with a message specified by type and code */
UploadController.prototype.displayMessage = function(type, messageCode, fileName) {
    var container = $('Message_' + type + '_' + messageCode);
    var msg = null;

    if (container) {
        msg = container.innerHTML;
        if (fileName) {
            msg += (': ' + fileName);
        }

        alert(msg);
    }
}

/* Sets specified upload status on a specified file */
UploadController.prototype.set_uploadStatus = function(file, status, message) {
    var row = $(this.manager.getFileID(file));
    var statusImageContainer = null;
    var statusImage = '';
    var totalUploaded = 0;

    if (status == UploadStatus.Succeeded)
        statusImage = '/Admin/Images/Ribbon/Icons/Small/check.png';
    else if (status == UploadStatus.Failed)
        statusImage = '/Admin/Images/Ribbon/Icons/Small/error.png';

    if (row) {
        statusImageContainer = $(row.down('span.C5 span.uploadStatus'));

        row.writeAttribute('__status', status);

        if (status == UploadStatus.NotStarted || status == UploadStatus.Uploading) {
            row.removeClassName('uploadLogEntry');
        } else {
            row.addClassName('uploadLogEntry');

            totalUploaded = this.get_totalUploaded() + 1;
            this.set_totalUploaded(totalUploaded);

            this.set_rowIDs(row, row.id + ('_' + totalUploaded));

            statusImageContainer.setStyle({ backgroundImage: 'url(' + statusImage + ')' });
            statusImageContainer.writeAttribute('alt', message);
            statusImageContainer.writeAttribute('title', message);
        }
    }
}

/* Gets upload status for specified file */
UploadController.prototype.get_uploadStatus = function(file) {
    var row = $(this.manager.getFileID(file));
    var ret = UploadStatus.NotStarted;

    if (row) {
        ret = parseInt(row.readAttribute('__status'));
        if (ret <= 0 && isNaN(ret)) {
            ret = UploadStatus.NotStarted;
        }
    }

    return ret;
}

/* Sets a custom status message on a specified file */
UploadController.prototype.set_customStatus = function(file, statusMessage) {
    $(this.manager.getFileID(file)).down('span.C5 span.uploadStatusCustom').innerHTML = statusMessage;
}

/* Gets custom status message for specified file */
UploadController.prototype.get_customStatus = function(file) {
    return $(this.manager.getFileID(file)).down('span.C5 span.uploadStatusCustom').innerHTML;
}

/* Sets progress bar visibility for specified file */
UploadController.prototype.set_progressIsVisible = function(file, isVisible) {
    var fileID = this.manager.getFileID(file);
    var progress = null;

    progress = $($$('li[id="' + fileID + '"] span.C5 span.progressBackground')[0]);

    if (isVisible)
        progress.show();
    else
        progress.hide();
}

/* Sets upload progress percentage for specified file */
UploadController.prototype.set_uploadProgress = function(file, percentage) {
    var progress = $($$('li[id="' + this.manager.getFileID(file) + '"] span.C5 span.progressFill')[0]); ;

    percentage = parseInt(percentage);
    
    if (percentage > 100)
        percentage = 100;

    progress.setStyle({'width': percentage + 'px'});
}

/* Sets global upload progress percentage */
UploadController.prototype.set_uploadProgressGlobal = function(percentage) {
    var progress = $($('progressGlobal').down('span.progressFill'));

    percentage = parseInt(percentage);

    if (percentage > 100)
        percentage = 100;

    progress.setStyle({ 'width': percentage + 'px' });
}

/* Starts upload process */
UploadController.prototype.startUpload = function() {
    if ($('chkResize').checked) {
        if (isNaN(parseInt($('txImageWidth').value)) && isNaN(parseInt($('txImageHeight').value))) {
            alert(document.getElementById('Message_Validate_1').innerHTML);
            return;
        }
    }

    var arg = $('__EVENTARGUMENT');
    var frm = $('MainForm');

    this.set_isUploading(true);

    this.set_uploadIsEnabled(false);
    this.saveArchiveSettings();
    this.saveImageSettings();

    if (this.manager.get_canUpload()) {
        this.manager.startUpload();
    } else {
        this.manager.commitSettings();
        if (typeof (__doPostBack) == 'function') {
            __doPostBack('', 'SingleUpload');
        } else {
            if (arg) {
                arg.value = 'SingleUpload';
                frm.submit();
            }
        }
    }
}

/* Gets value indicating whether upload process has been started */
UploadController.prototype.get_isUploading = function() {
    return $('stateIsUploading').value == 'true';
}

/* Sets value indicating whether upload process has been started */
UploadController.prototype.set_isUploading = function(value) {
    $('stateIsUploading').value = (value ? 'true' : 'false');

    this.set_uploadIsEnabled(false);
    this.set_simpleUploadDialogIsVisible(false);
    
    if (!value) {
        this.resetTotalSize();
        this.resetFilesCount();
        this.set_uploadProgressGlobal(0);
    }

    this.set_selectFileIsEnabled(!value);
    this.set_overwriteIsEnabled(!value);
    this.set_locationEditingIsEnabled(!value && this.get_isAllowedToChangeDirectory());
    this.set_archiveSettingIsEnabled(!value);
    this.set_imageSettingIsEnabled(!value);
}

/* Sets value indicating whether specified file is an image */
UploadController.prototype.set_isImage = function(file) {
    var row = $(this.manager.getFileID(file));

    if (row) {
        row.writeAttribute('__isImage', 'true');
    }
}

/* Sets value indicating whether specified file is an archive */
UploadController.prototype.set_isArchive = function(file) {
    var row = $(this.manager.getFileID(file));

    if (row) {
        row.writeAttribute('__isArchive', 'true');
    }
}

/* Gets a total amount of image files currently added to upload queue */
UploadController.prototype.get_imagesCount = function () {
    // Negate selector .not() doesnt work in IE 6 - 9 ((
    //var rows = $$('ul[id="items"] li[__isImage]:not([class~="uploadLogEntry"])');
    var rows = $$('ul[id="items"] li[__isImage]');
    var rowsLog = $$('ul[id="items"] li[__isImage].uploadLogEntry');
    var ret = 0;

    if (rows && rowsLog) {
        ret = rows.length - rowsLog.length;
    }

    return ret;
}

/* Gets a total amount of archive files currently added to upload queue */
UploadController.prototype.get_archivesCount = function() {
    //var rows = $$('ul[id="items"] li[__isArchive]:not([class~="uploadLogEntry"])');
    var rows = $$('ul[id="items"] li[__isArchive]');
    var rowsLog = $$('ul[id="items"] li[__isArchive].uploadLogEntry');
    var ret = 0;

    if (rows) {
        ret = rows.length - rowsLog.length;
    }

    return ret;
}

/* Gets an amount of files that are currently waiting to be uploaded */
UploadController.prototype.get_currentlyMaximumToUpload = function() {
    return parseInt($('stateCurrentlyMaximumToUpload').value);
}

/* Sets an amount of files that are currently waiting to be uploaded */
UploadController.prototype.set_currentlyMaximumToUpload = function(value) {
    $('stateCurrentlyMaximumToUpload').value = value;
}

/* Gets an amount of files that has been uploaded during the last upload session */
UploadController.prototype.get_currentlyUploaded = function() {
    return parseInt($('stateCurrentlyUploaded').value);
}

/* Sets an amount of files that has been uploaded during the last upload session */
UploadController.prototype.set_currentlyUploaded = function(value) {
    $('stateCurrentlyUploaded').value = value;
}

/* Gets the amount of files that has been uploaded (in total) */
UploadController.prototype.get_totalUploaded = function() {
    return parseInt($('stateTotalUploaded').value);
}

/* Sets the amount of files that has been uploaded (in total) */
UploadController.prototype.set_totalUploaded = function(value) {
    $('stateTotalUploaded').value = value;
}

/* Handles 'fileAdded' event */
UploadController.prototype.handleFileAdded = function(file) {
    var obj = this;

    this.increaseTotalSize(file.size);
    this.increaseFilesCount(1);

    this.set_listIsEmpty(false);
    this.addFile(file);

    if (this._fileAddedTimeoutID > 0)
        clearTimeout(this._fileAddedTimeoutID);

    this._fileAddedTimeoutID = setTimeout(function() {
        obj.removeUploadedFiles();
        obj.checkAddedFiles();
        obj.handleFilesCountChanged();
    }, 75);
}

/* Handles 'uploadSuccess' and 'uploadError' events */
UploadController.prototype.handleFileUploaded = function(file, status, message) {
    var currentlyUploaded = this.get_currentlyUploaded() + 1;

    this.increaseFilesCount(-1);
    this.increaseTotalSize(file.size * -1);
    
    this.set_uploadStatus(file, status, message);
    this.set_uploadProgressGlobal(Math.floor(currentlyUploaded * 100 / this.get_currentlyMaximumToUpload()));
    this.set_currentlyUploaded(currentlyUploaded);
}

/* Handles 'fileRemoved' event */
UploadController.prototype.handleFileRemoved = function(file) {
    var obj = this;

    if (file) {
        this.increaseTotalSize(file.size * -1);
        this.increaseFilesCount(-1);
    }

    if (this.get_rowsCount() == 0) {
        this.set_listIsEmpty(true);
    }

    if (this._fileRemovedTimeoutID > 0)
        clearTimeout(this._fileRemovedTimeoutID);

    this._fileRemovedTimeoutID = setTimeout(function() {
        obj.handleFilesCountChanged();
    }, 75);
}

/* Handles 'afterUpload' event */
UploadController.prototype.handleUploadFinished = function() {
    this.set_isUploading(false);
    
    this.handleFilesCountChanged();
    this.set_uploadIsEnabled(false);
}

/* Gets the number of rows in a files list */
UploadController.prototype.get_rowsCount = function() {
    return $$('ul[id="items"] li').length - 1;
}

/* Handles the situation when the files selection has been changed */
UploadController.prototype.handleSelectionChanged = function(allFiles, selectedFiles) {
    var chkAll = $('chkAll');

    if (!allFiles)
        allFiles = this.get_allFiles();

    if (!selectedFiles)
        selectedFiles = this.get_selectedFiles();

    this.set_removeSelectedIsEnabled(selectedFiles.length > 0);

    chkAll.disabled = allFiles.length == 0;
    if (!chkAll.disabled)
        chkAll.checked = allFiles.length == selectedFiles.length;
    else
        chkAll.checked = false;

}

/* Gets value indicating whether file that has been checked for existance passed this check */
UploadController.prototype.get_fileExistanceState = function(fileID) {
    return $(fileID).hasClassName('fileExists');
}

/* Sets value indicating whether file that has been checked for existance passed this check */
UploadController.prototype.set_fileExistanceState = function(fileID, value) {
    var row = $(fileID);

    if (value) {
        row.addClassName('fileExists');
        this.set_customStatus(fileID, $('alreadyExistsLabel').innerHTML);
    } else {
        row.removeClassName('fileExists');
        this.set_customStatus(fileID, '');
    }
}

/* Checks newly added files for existance */
UploadController.prototype.checkAddedFiles = function() {
    var files = this.get_allFiles();
    var obj = this;

    this.checkFilesExistance(files, function(sender, args) {
        for (var i = 0; i < files.length; i++) {
            obj.set_fileExistanceState(files[i], args.result[files[i]]);
        }
    });
}

/* Check the existance of specified files */
UploadController.prototype.checkFilesExistance = function(fileIDs, onChecked) {
    var obj = this;
    var uploadDirectory = this.manager.get_targetLocation();
    var files = '', ids = '';
    var url = this.get_pageUrl() + '?Action=CheckFiles&Folder=' + encodeURIComponent(uploadDirectory);

    if (fileIDs && fileIDs.length > 0) {
        for (var i = 0; i < fileIDs.length; i++) {
            ids += fileIDs[i] + '&';
            files += (encodeURIComponent($(fileIDs[i]).down('span.C2').readAttribute('__fileName')) + '&');
        }
        
        new Ajax.Request(url, {
            method: 'post',
            parameters: {
                FileIDs: ids,
                FileNames: files
            },
            onSuccess: function(transport) {
                if (typeof (onChecked) == 'function') {
                    onChecked(obj, { result: transport.responseText.evalJSON() });
                }
            }
        });
    }
}

/* Gets value indicating whether it's allowed to overwrite existing files */
UploadController.prototype.get_isAllowedToOverwriteFiles = function() {
    return this.manager.settings.get_item('AllowOverwrite');
}

/* Sets value indicating whether it's allowed to overwrite existing files */
UploadController.prototype.set_isAllowedToOverwriteFiles = function(value) {
    this.manager.settings.set_item('AllowOverwrite', value);
}

/* Gets value indicating whether upload directory is valid */
UploadController.prototype.get_isValidUploadDirectory = function() {
    return $($$('div.fileLocation')[0]).hasClassName('fileLocationConfirmed');
}

/* Gets value indicating whether it's allowed to change upload directory */
UploadController.prototype.get_isAllowedToChangeDirectory = function() {
    return $('stateIsAllowedToChangeLocation').value == 'true';
}

/* Handles the situation when the files count is changed */
UploadController.prototype.handleFilesCountChanged = function() {
    var files = this.get_allFiles();

    if (!this.get_isUploading()) {
        this.set_uploadIsEnabled(files.length > 0 && this.get_isValidUploadDirectory());
        this.set_archiveSettingIsEnabled(this.get_archivesCount() > 0);
        this.set_imageSettingIsEnabled(this.get_imagesCount() > 0);
    }

    this.set_removeAllIsEnabled(files.length > 0);
    this.set_selectAllIsEnabled(files.length > 0);

    this.handleSelectionChanged(files, null);
}

/* Sets value indicating whether 'Simple upload' dialog is visible */
UploadController.prototype.set_simpleUploadDialogIsVisible = function(isVisible) {
    this.set_dialogIsVisible('dlgSimpleUpload', isVisible);
}


/* Sets value indicating whether specified group is enabled */
UploadController.prototype.set_groupIsEnabled = function (groupID, isEnabled) {
    var group = $(groupID);
    var fields = null;
    var parentDisabled = null;

    if (group) {
        if (isEnabled) {
            group.removeClassName('groupDisabled');
        } else {
            group.addClassName('groupDisabled');
        }

        fields = group.select('input');
        if (fields && fields.length > 0) {
            for (var i = 0; i < fields.length; i++) {
                if (!isEnabled)
                    fields[i].disabled = true;
                else {
                    parentDisabled = $(fields[i]).up('*.groupDisabled');

                    if (parentDisabled == null || parentDisabled.id == groupID) {
                        fields[i].disabled = false;
                    }
                }
            }
        }
    }
}

/* Gets a CSS styles that is applied for 'Choose file' button */
UploadController.prototype.get_selectButtonTextStyle = function(isDisabled) {
    return '.selectButton { ' + 
        'text-align: center; ' + 
        'width: 84px; ' +
        'color: ' + (isDisabled ? '#8da5cb;' : '#15428b;') + 
        'font-size: 11pt; ' + 
        'font-family: Arial, Microsoft JhengHei;' + 
    '}';
}

/* Gets a text for 'Choose file' button */
UploadController.prototype.get_selectButtonText = function() {
    return '<span class="selectButton">' + $('selectButtonLabel').innerHTML + '</span>';
}

/* Adds specified file to the files list */
UploadController.prototype.addFile = function (file) {
    var templateItem = $('templateItem');
    var listItem = $(templateItem.clone());
    var modifiedDate = file.modificationdate;
    var checkbox = null;
    var fileName = null;
    var obj = this;

    try {
        modifiedDate = (new Date(Date.parse(file.modificationdate))).toLocaleString();
    } catch (ex) { }

    listItem.removeClassName('templatedItemMarker');

    listItem.show();
    listItem.update(templateItem.innerHTML);

    this.set_rowIDs(listItem, file.id);

    checkbox = listItem.down('span.C1 input');

    checkbox.checked = false;
    checkbox.observe('click', function (event) {
        var element = Event.element(event);
        var fileID = element.up('li').id;

        if (!element.disabled)
            obj.set_fileIsSelected(fileID, element.checked);
    });

    fileName = listItem.down('span.C2');

    fileName.innerHTML = this.formatFileName(file.name);
    fileName.writeAttribute('__fileName', file.name);

    listItem.down('span.C3').innerHTML = this.formatFileSize(file.size);
    listItem.down('span.C4').innerHTML = modifiedDate;
    listItem.down('span.C6 img').observe('click', function (event) {
        obj.removeFile($(Event.element(event)).up('li').id);
        obj.handleFilesCountChanged();
    });


    $('items').appendChild(listItem);

    var msgText = '';
    var dstFileName = file.name;
    if (file.name.indexOf(',') > -1) {
        dstFileName = file.name.replace(/,/g, '_');
        msgText = document.getElementById('Message_FileWarning_1').innerHTML.replace('%%', file.name) + '\n\r';
    }
    if (dstFileName.indexOf(';') > -1) {
        dstFileName = dstFileName.replace(/;/g, '_');
        msgText += document.getElementById('Message_FileWarning_2').innerHTML.replace('%%', file.name) + '\n\r';
    }
    if (dstFileName.indexOf('+') > -1) {
        dstFileName = dstFileName.replace(/\+/g, '_');
        msgText += document.getElementById('Message_FileWarning_3').innerHTML.replace('%%', file.name) + '\n\r';
    }
    if (dstFileName.indexOf('\'') > -1) {
        dstFileName = dstFileName.replace(/'/g, '_');
        msgText += document.getElementById('Message_FileWarning_6').innerHTML.replace('%%', file.name) + '\n\r';
    }
    if (dstFileName.indexOf('#') > -1) {
        dstFileName = dstFileName.replace(/#/g, '_');
        msgText += document.getElementById('Message_FileWarning_7').innerHTML.replace('%%', file.name) + '\n\r';
    }
    if ($('replaceSpace').value == 'true') {
        if (dstFileName.indexOf(' ') > -1) {
            dstFileName = dstFileName.replace(/ /g, '-');
            msgText += document.getElementById('Message_FileWarning_4').innerHTML.replace('%%', file.name) + '\n\r';
        }
    }
    // chars -- are raise error when file name is passed trought url parameters and checked by SQLEscapeInjection function
    dstFileName = dstFileName.replace(/\-{2,}/g, '-');

    var flag = false;
    if ($('replaceSpecial').value == 'true') {
        var re = new RegExp('[^a-zA-Z0-9._\w\-]', 'g');
        if (dstFileName.match(re)) {
            flag = true;
            //                    dstFileName = dstFileName.replace("æ", "ae");
            //                    dstFileName = dstFileName.replace("ä", "ae");
            //                    dstFileName = dstFileName.replace("ø", "oe");
            //                    dstFileName = dstFileName.replace("ö", "oe");
            //                    dstFileName = dstFileName.replace("å", "aa");
            //                    dstFileName = dstFileName.replace(re, '');
            new Ajax.Request("AJAX_Handler.ashx?arg=" + encodeURIComponent(dstFileName), {
                method: 'get',
                asynchronous: true,
                onSuccess: function (transport) {
                    if (msgText != '') {
                        alert(msgText);
                        fileName.innerHTML = transport.responseText;
                    }

                    if (this.manager.isArchiveFile(file)) {
                        this.set_isArchive(file);
                    } else if (this.manager.isImageFile(file)) {
                        this.set_isImage(file);
                    }
                }
            });
            msgText += document.getElementById('Message_FileWarning_5').innerHTML.replace('%%', file.name);
        }
    }
    if (!flag) {
        if (msgText != '') {
            alert(msgText);
            fileName.innerHTML = dstFileName;
        }

        if (this.manager.isArchiveFile(file)) {
            this.set_isArchive(file);
        } else if (this.manager.isImageFile(file)) {
            this.set_isImage(file);
        }
    }
}

/* Configures row children IDs according to specified row ID */
UploadController.prototype.set_rowIDs = function(row, rowID) {
    row = $(row);

    row.id = rowID;
    row.down('span.C1 input').id = rowID + '_chk';
}

/* Save 'Archive settings' dialog settings */
UploadController.prototype.saveArchiveSettings = function() {
    this.manager.settings.set_item('ArchiveExtract', $('chkExtractArchives').checked);
    this.manager.settings.set_item('ArchiveCreateFolders', $('chkCreateFolders').checked);
}

/* Save 'Image settings' dialog settings */
UploadController.prototype.saveImageSettings = function() {
    this.manager.settings.set_item('ImageQuality', parseInt($('ddQuality').getValue()));
    this.manager.settings.set_item('ImageResize', $('chkResize').checked);
    this.manager.settings.set_item('ImageResizeWidth', parseInt($('txImageWidth').value));
    this.manager.settings.set_item('ImageResizeHeight', parseInt($('txImageHeight').value));
}

/* Sets value indicating whether upload location editing is enabled */
UploadController.prototype.set_locationEditingIsEnabled = function(isEnabled) {
    var locationContainer = $($$('div.fileLocation')[0]);

    this.set_locationEditing(false);

    if (isEnabled)
        locationContainer.removeClassName('fileLocationDisabled');
    else
        locationContainer.addClassName('fileLocationDisabled');
}

/* Sets value indicating whether 'Select all' checkbox is enabled */
UploadController.prototype.set_selectAllIsEnabled = function(isEnabled) {
    document.getElementById('chkAll').disabled = !isEnabled;
}

/* Sets value indicating whether 'Remove selected' button is enabled */
UploadController.prototype.set_removeSelectedIsEnabled = function(isEnabled) {
    this.set_ribbonButtonIsEnabled('cmdRemoveSelected', isEnabled);
}

/* Sets value indicating whether 'Remove all' button is enabled */
UploadController.prototype.set_removeAllIsEnabled = function(isEnabled) {
    this.set_ribbonButtonIsEnabled('cmdRemoveAll', isEnabled);
}

/* Sets value indicating whether 'Images' group is enabled */
UploadController.prototype.set_imageSettingIsEnabled = function(isEnabled) {
    this.set_groupIsEnabled('groupImageSettings', isEnabled);
}

/* Sets value indicating whether 'File archives' group is enabled */
UploadController.prototype.set_archiveSettingIsEnabled = function(isEnabled) {
    this.set_groupIsEnabled('groupArchiveSettings', isEnabled);
}

/* Sets value indicating whether 'Upload' button is enabled */
UploadController.prototype.set_uploadIsEnabled = function(isEnabled) {
    this.set_ribbonButtonIsEnabled('cmdUpload', isEnabled);
}

/* Sets value indicating whether 'Overwrite' button is enabled */
UploadController.prototype.set_overwriteIsEnabled = function(isEnabled) {
    this.set_ribbonButtonIsEnabled('chkOverwriteFiles', isEnabled);
}

/* Sets value indicating whether 'Choose file' button is visible */
UploadController.prototype.set_selectFileIsVisible = function(isVisible) {
    if (this.manager.get_canUpload()) {
        if (isVisible)
            $('ctrlUpload').show();
        else
            $('ctrlUpload').hide();
    } else {
        if (isVisible)
            Ribbon.showButton('cmdSelectFile');
        else
            Ribbon.hideButton('cmdSelectFile');
    }
}

/* Sets value indicating whether 'Choose file' button is enabled */
UploadController.prototype.set_selectFileIsEnabled = function(isEnabled) {
    var uploadCtrl = null;

    if (this.manager.get_canUpload()) {
        uploadCtrl = this.manager.get_uploadControl();

        try {
            uploadCtrl.setButtonDisabled(!isEnabled);
            uploadCtrl.setButtonTextStyle(this.get_selectButtonTextStyle(!isEnabled));
        } catch (ex) { }
    } else {
        if (isEnabled)
            Ribbon.enableButton('cmdSelectFile');
        else
            Ribbon.disableButton('cmdSelectFile');
    }
}

/* Sets value indicating whether specified Ribbon button is enabled */
UploadController.prototype.set_ribbonButtonIsEnabled = function(buttonID, isEnabled) {
    if (isEnabled) {
        Ribbon.enableButton(buttonID);
    } else {
        Ribbon.disableButton(buttonID);
    }
}

/* Sets value indicating whether specified dialog is visible */
UploadController.prototype.set_dialogIsVisible = function(dialogID, isVisible) {
    if (isVisible) {
        dialog.show(dialogID);
    } else {
        dialog.hide(dialogID);
    }
}

/* Removes specified file */
UploadController.prototype.removeFile = function(fileID, removeFromListOnly) {
    $(fileID).remove();
    
    if(!removeFromListOnly)
        this.manager.cancelUpload(fileID);
}

/* Removes specified files list */
UploadController.prototype.removeFiles = function(files, removeFromListOnly) {
    if (files && files.length > 0) {
        for (var i = 0; i < files.length; i++) {
            this.removeFile(files[i], removeFromListOnly);
        }
    }

    this.handleFilesCountChanged();
}

/* Removes all uploaded files from the list */
UploadController.prototype.removeUploadedFiles = function() {
    this.removeFiles(this.get_uploadedFiles(), true);
}

/* Removes all files from the list */
UploadController.prototype.removeAllFiles = function() {
    this.removeFiles(this.get_allFiles());
}

/* Removes selected files from the list */
UploadController.prototype.removeSelectedFiles = function() {
    this.removeFiles(this.get_selectedFiles());
}

/* Gets value indicatng whether all files are selected */
UploadController.prototype.get_allFilesAreSelected = function() {
    return $('chkAll').checked;
}

/* Sets value indicatng whether all files are selected */
UploadController.prototype.set_allFilesAreSelected = function(selected) {
    var files = this.get_allFiles();

    for (var i = 0; i < files.length; i++) {
        this.set_fileIsSelected(files[i], selected);
    }
}

/* Sets value indicating whether specified file is selected */
UploadController.prototype.set_fileIsSelected = function(fileID, isSelected) {
    document.getElementById(fileID + '_chk').checked = isSelected;

    this.handleSelectionChanged();
}

/* Gets value indicating whether specified file is selected */
UploadController.prototype.get_fileIsSelected = function(fileID) {
    return document.getElementById(fileID + '_chk').checked;
}

/* Get the list of uploaded files (an array of list rows) */
UploadController.prototype.get_uploadedFiles = function() {
    var ret = [];
    var rows = $$('ul[id="items"] li.uploadLogEntry');

    if (rows && rows.length > 0) {
        for (var i = 0; i < rows.length; i++) {
            ret[ret.length] = rows[i].id;
        }
    }

    return ret;
}

/* Get the list of selected files (an array of list rows) */
UploadController.prototype.get_selectedFiles = function() {
    var ret = [];
    var checkboxes = $$('ul[id="items"] span.C1 input');

    if (checkboxes && checkboxes.length > 0) {
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                ret[ret.length] = checkboxes[i].id.replace(/_chk/gi, '');
            }
        }
    }

    return ret;
}

/* Get the list of all files (an array of list rows) */
UploadController.prototype.get_allFiles = function() {
    var ret = [];
    var rows = $$('ul[id="items"] li');

    if (rows && rows.length > 0) {
        for (var i = 0; i < rows.length; i++) {
            if (rows[i].id.length > 0 && !$(rows[i]).hasClassName('templatedItemMarker')) {
                ret[ret.length] = rows[i].id;
            }
        }
    }

    return ret;
}

/* Resets the total upload size */
UploadController.prototype.resetTotalSize = function() {
    var label = $('uploadstatus-label');
    var size = $('uploadstatus-size');

    size.value = 0;
    label.innerHTML = this.formatFileSize(size.value);
}

/* Resets the total files count */
UploadController.prototype.resetFilesCount = function() {
    var count = $('uploadstatus-filecount');
    count.innerHTML = '0';
}

/* Increases the total upload size */
UploadController.prototype.increaseTotalSize = function(sizeDifference) {
    var label = $('uploadstatus-label');
    var size = $('uploadstatus-size');
    var newSize = parseInt(size.value) + parseInt(sizeDifference);

    if (newSize < 0)
        newSize = 0;

    size.value = newSize;
    label.innerHTML = this.formatFileSize(newSize);
}

/* Formats file name (truncates if needed) */
UploadController.prototype.formatFileName = function(fileName) {
    var ret = fileName;

    if (ret.length > 50) {
        ret = ret.substr(0, 50) + '...';
    }

    return ret;
}

/* Formats file size (adds 'B', 'KB', 'MB', 'GB' suffixes) */
UploadController.prototype.formatFileSize = function(fileSize) {
    var ret = '';

    fileSize = parseInt(fileSize);

    if (fileSize > 1000000000) {
        ret = (Math.round(fileSize / 100000000) / 10).toString() + '&nbsp;GB';
    } else if (fileSize > 1000000) {
        ret = (Math.round(fileSize / 100000) / 10).toString() + '&nbsp;MB';
    } else if (fileSize > 1000) {
        ret = (Math.round(fileSize / 100) / 10).toString() + '&nbsp;KB';
    } else {
        ret = fileSize.toString() + '&nbsp;B';
    }

    return ret;
}

/* Increases files count */
UploadController.prototype.increaseFilesCount = function(countDifference) {
    var count = $('uploadstatus-filecount');
    var newCount = parseInt(count.innerHTML) + parseInt(countDifference);

    if (newCount < 0)
        newCount = 0;

    count.innerHTML = newCount;
}

/* Sets upload location */
UploadController.prototype.set_targetLocation = function(newLocation) {
    this.manager.set_targetLocation(newLocation);
    $('statePreviousLocation').value = newLocation;
}

/* Sets upload location AND checks whether it's valid */
UploadController.prototype.changeLocation = function(newLocation, onChanged) {
    var obj = this;
    var locationContainer = $($$('div.fileLocation')[0]);
    var url = this.get_pageUrl() + '?action=ValidateLocation&Location=' +
        encodeURIComponent(newLocation)

    if (newLocation.toLowerCase() != $('statePreviousLocation').value.toLowerCase()) {
        this.set_targetLocation(newLocation);

        new Ajax.Request(url, {
            method: 'get',
            onSuccess: function(transport) {
                var isValid = transport.responseText == '1';
                var files = obj.get_allFiles();
                var items = $('items');

                if (typeof (onChanged) == 'function')
                    onChanged(this, { isValid: isValid });

                locationContainer.addClassName(isValid ? 'fileLocationConfirmed' : 'fileLocationUnknown');
                locationContainer.removeClassName(isValid ? 'fileLocationUnknown' : 'fileLocationConfirmed');

                obj.set_uploadIsEnabled(files.length > 0 && isValid);

                if (isValid) {
                    items.removeClassName('listDisabled');
                } else {
                    items.addClassName('listDisabled');
                }

                if (isValid) {
                    setTimeout(function() {
                        obj.checkAddedFiles();
                    }, 150);
                }
            }
        });
    }
}

/* Gets an upload location */
UploadController.prototype.get_locationEditing = function() {
    return $($$('div.fileLocation')[0]).down('input') != null;
}

/* Sets value indicating whether upload location field must become editable */
UploadController.prototype.set_locationEditing = function(value) {
    var locationContainer = $($$('div.fileLocation')[0]);
    var locationInput = locationContainer.down('input');
    var currentLocation = '';
    var obj = this;

    if (value) {
        if (!locationContainer.hasClassName('fileLocationDisabled') && (locationInput == null || locationInput.length == 0)) {
            currentLocation = locationContainer.innerHTML;
            locationInput = new Element('input', { 'type': 'text', 'class': 'locationInput', 'value': currentLocation });

            locationContainer.innerHTML = '';
            locationContainer.appendChild(locationInput);

            locationInput.observe('keypress', function(event) {
                if (event.keyCode == 13 || event.keyCode == 27)
                    obj.set_locationEditing(false);
            });

            locationInput.focus();
            locationInput.select();
        }
    } else {
        if (locationInput) {
            currentLocation = this.absolutizeLocation(locationInput.value);

            this.changeLocation(currentLocation);

            locationInput.remove();
            locationContainer.innerHTML = currentLocation;
        }
    }
}

/* Adds '/Files/' prefix to specified location (if needed) */
UploadController.prototype.absolutizeLocation = function(location) {
    var ret = location;

    if (ret.indexOf('/') != 0)
        ret = '/' + ret;

    if (ret.lastIndexOf('/') != ret.length - 1)
        ret += '/';

    if (ret.toLowerCase().indexOf('/files/') != 0)
        ret = '/Files' + ret;

    return ret;
}

/* Gets value indicating whether files list is empty */
UploadController.prototype.get_listIsEmpty = function() {
    return $('files-emptylist').getStyle('display') != 'none';
}

/* Sets value indicating whether files list is empty */
UploadController.prototype.set_listIsEmpty = function(value) {
    var label = $('files-emptylist');
    var itemsContainer = $('itemsContainer');

    if (value) {
        label.show();
        itemsContainer.hide();
    } else {
        label.hide();
        itemsContainer.show();
    }
}

/* Gets the URL of the page that is suitable for AJAX requests */
UploadController.prototype.get_pageUrl = function() {
    var ret = location.href;

    if (ret.indexOf('#') >= 0) {
        ret = ret.substr(0, ret.indexOf('#'));
    }

    if (ret.indexOf('?') >= 0) {
        ret = ret.substr(0, ret.indexOf('?'));
    }

    return ret;
}
