/* Represents an upload manager settings */
var UploadManagerSettings = function () {
    this.allSettings = [];
}

/* Sets the value for specified setting */
UploadManagerSettings.prototype.set_item = function (name, value) {
    var field = $('setting' + name);

    if (!this.allSettings)
        this.allSettings = [];

    this.allSettings[name] = value;

    if (field) {
        field.value = value;
    } else {
        $$('form').each(function (item) {
            $(item).appendChild(new Element('input', {
                'id': 'setting' + name,
                'name': 'setting' + name,
                'type': 'hidden',
                'value': value
            }));
        });
    }
}

/* Gets the value for specified setting */
UploadManagerSettings.prototype.get_item = function (name) {
    var ret = '';

    if (!this.allSettings)
        this.allSettings = [];

    ret = this.allSettings[name];

    return ret;
}

/* Represents an upload manager */
var UploadManager = function () {
    this.settings = new UploadManagerSettings();
    this.uploadControl = null;
    this.events = new EventsManager();
    this._isEnabled = null;

    /* Occurs when new file(s) have been selected using "Select file" dialog */
    this.events.registerEvent('fileSelected');

    /* Occurs when file has been added to upload queue */
    this.events.registerEvent('fileAdded');

    /* Occurs when there was an error during adding a file to upload queue */
    this.events.registerEvent('fileError');

    /* Occurs when file has been removed from the upload queue (or when uploading of the file has been canceled) */
    this.events.registerEvent('fileRemoved');

    /* Occurs when upload location has been changed */
    this.events.registerEvent('locationChanged');

    /* Occurs before the whole upload process begins */
    this.events.registerEvent('beforeUpload');

    /* Occurs when next file is about to be uploaded */
    this.events.registerEvent('uploadStart');

    /* Occurs when upload progress of the specified file is updated */
    this.events.registerEvent('uploadProgress');

    /* Occurs when there was an error during uploading */
    this.events.registerEvent('uploadError');

    /* Occurs when file has been successfully uploaded */
    this.events.registerEvent('uploadSuccess');

    /* Occurs when the whole upload process is finished */
    this.events.registerEvent('afterUpload');

    this.settings.set_item('TargetLocation', '');
    this.settings.set_item('AllowOverwrite', 'false');
    this.settings.set_item('ArchiveExtract', 'false');
    this.settings.set_item('ArchiveCreateFolders', 'false');
    this.settings.set_item('ImageQuality', '100');
    this.settings.set_item('ImageResize', 'false');
    this.settings.set_item('ImageResizeWidth', '');
    this.settings.set_item('ImageResizeHeight', '');

    this.onAfterUpload = null;
}

/* Registers a new event handler for 'fileSelected' event */
UploadManager.prototype.add_fileSelected = function (hanlder) {
    this.events.addHandler('fileSelected', hanlder);
}

/* Registers a new event handler for 'fileAdded' event */
UploadManager.prototype.add_fileAdded = function (hanlder) {
    this.events.addHandler('fileAdded', hanlder);
}

/* Registers a new event handler for 'fileError' event */
UploadManager.prototype.add_fileError = function (hanlder) {
    this.events.addHandler('fileError', hanlder);
}

/* Registers a new event handler for 'fileRemoved' event */
UploadManager.prototype.add_fileRemoved = function (hanlder) {
    this.events.addHandler('fileRemoved', hanlder);
}

/* Registers a new event handler for 'locationChanged' event */
UploadManager.prototype.add_locationChanged = function (hanlder) {
    this.events.addHandler('locationChanged', hanlder);
}

/* Registers a new event handler for 'beforeUpload' event */
UploadManager.prototype.add_beforeUpload = function (hanlder) {
    this.events.addHandler('beforeUpload', hanlder);
}

/* Registers a new event handler for 'uploadStart' event */
UploadManager.prototype.add_uploadStart = function (hanlder) {
    this.events.addHandler('uploadStart', hanlder);
}

/* Registers a new event handler for 'uploadProgress' event */
UploadManager.prototype.add_uploadProgress = function (hanlder) {
    this.events.addHandler('uploadProgress', hanlder);
}

/* Registers a new event handler for 'uploadError' event */
UploadManager.prototype.add_uploadError = function (hanlder) {
    this.events.addHandler('uploadError', hanlder);
}

/* Registers a new event handler for 'uploadSuccess' event */
UploadManager.prototype.add_uploadSuccess = function (hanlder) {
    this.events.addHandler('uploadSuccess', hanlder);
}

/* Registers a new event handler for 'afterUpload' event */
UploadManager.prototype.add_afterUpload = function (hanlder) {
    this.events.addHandler('afterUpload', hanlder);
}

/* Notifies all subscribers about specified event */
UploadManager.prototype.notify = function (eventName, args) {
    this.events.notify(eventName, this, args);
}

/* Gets upload location */
UploadManager.prototype.get_targetLocation = function () {
    return this.settings.get_item('TargetLocation');
}

/* Sets upload location */
UploadManager.prototype.set_targetLocation = function (value) {
    this.settings.set_item('TargetLocation', value);
    this.notify('locationChanged', { newLocation: value });
}

/* Appends all currently set settings to the next post-back request */
UploadManager.prototype.commitSettings = function () {
    var uploadCtrl = this.get_uploadControl();

    try {
        for (var settingName in this.settings.allSettings) {
            if (typeof (this.settings.allSettings[settingName]) != 'function') {
                uploadCtrl.removePostParam(settingName);
                uploadCtrl.addPostParam(settingName, this.settings.get_item(settingName));
            }
        }
    } catch (ex) { }
}

/* Starts upload process */
UploadManager.prototype.startUpload = function () {
    this.commitSettings();
    this.notify('beforeUpload', null);
    this.get_uploadControl().startUpload();
}

/* Cancels upload for specified file */
UploadManager.prototype.cancelUpload = function (fileID) {
    var file = this.get_uploadControl().getFile(fileID);

    this.get_uploadControl().cancelUpload(fileID, false);
    this.notify('fileRemoved', { file: file });
}

/* Gets value indicating whether UploadManager's upload functionality is enabled */
UploadManager.prototype.get_canUpload = function () {
    if (this._isEnabled == null && typeof (swfobject) == 'object') {
        try {
            this._isEnabled = swfobject.hasFlashPlayerVersion('9.0.28');
        } catch (ex) {
            this._isEnabled = false;
        }
    }

    return this._isEnabled;
}

/* Gets file count currently added to upload queue */
UploadManager.prototype.get_filesCount = function () {
    return this.get_uploadControl().getStats().files_queued;
}

/* Gets value indicating whether specified file is an image-file */
UploadManager.prototype.isImageFile = function (file) {
    return this.checkExtension(file, ['jpg', 'jpeg', 'png', 'gif', 'bmp']);
}

/* Gets value indicating whether specified file is an archive-file */
UploadManager.prototype.isArchiveFile = function (file) {
    return this.checkExtension(file, ['zip', 'rar']);
}

/* Checks whether specified file's extension matches provided extensions array */
UploadManager.prototype.checkExtension = function (file, extensions) {
    var ext = this.getExtension(file);
    var ret = false;

    if (!extensions || extensions.length == 0)
        ret = true;
    else {
        if (ext.length > 0) {
            for (var i = 0; i < extensions.length; i++) {
                if (extensions[i].toLowerCase() == ext) {
                    ret = true;
                    break;
                }
            }
        }
    }

    return ret;
}

/* Gets file extension */
UploadManager.prototype.getExtension = function (file) {
    var ext = '';
    var separatorIndex = 0;

    if (typeof (file) == 'string') {
        separatorIndex = file.lastIndexOf('.');
        if (separatorIndex >= 0 && separatorIndex < file.length - 1) {
            ext = file.substr(separatorIndex, file.length - separatorIndex);
        }
    } else {
        if (!file.type.length) {
            ext = this.getExtension(file.name);
        } else {
            ext = file.type;
        }
    }

    ext = ext.replace(/\./gi, '');

    return ext.toLowerCase();
}

/* Gets a reference to an instance of underlying SWFUpload control */
UploadManager.prototype.get_uploadControl = function () {
    if (this.uploadControl == null) {
        this.initializeUploadControl();
    }

    return this.uploadControl;
}

/* Gets the file ID */
UploadManager.prototype.getFileID = function (file) {
    var ret = '';

    if (typeof (file) == 'string')
        ret = file;
    else
        ret = file.id;

    return ret;
}

/* Initializes underlying SWFUpload control */
UploadManager.prototype.initializeUploadControl = function (controlSettings) {
    var buttonID = '', buttonImageUrl = '', buttonText = '', buttonTextStyle = '';
    var obj = this;

    if (controlSettings) {
        buttonID = controlSettings.buttonID;
        buttonImageUrl = controlSettings.buttonImageUrl;
        buttonText = controlSettings.buttonText;
        buttonTextStyle = controlSettings.buttonTextStyle;
    }

    var settings = {
        flash_url: "js/swfupload/swfupload.swf",
        upload_url: "/Admin/Filemanager/Upload/Store.aspx",
        file_size_limit: document.getElementById('fileSizeLimit').value + " MB",
        file_types: "*.*",
        file_types_description: "All Files",
        file_upload_limit: 100,
        file_queue_limit: 100,

        button_image_url: buttonImageUrl,
        button_placeholder_id: buttonID,
        button_text_top_padding: 33,
        button_width: 86,
        button_height: 68,
        button_text: buttonText,
        button_text_style: buttonTextStyle,
        debug: false,

        file_dialog_start_handler: function () {
            obj.notify('fileSelected', {});
        },

        file_queued_handler: function (file) {
            obj.notify('fileAdded', { file: file });
        },

        file_queue_error_handler: function (file, errorCode, message) {
            obj.notify('fileError', { file: file, errorCode: errorCode, message: message });
        },

        upload_start_handler: function (file) {
            obj.notify('uploadStart', { file: file });
            return true;
        },

        upload_progress_handler: function (file, bytesLoaded, bytesTotal) {
            obj.notify('uploadProgress', { file: file, bytesLoaded: bytesLoaded, bytesTotal: bytesTotal });
        },

        upload_error_handler: function (file, errorCode, message) {
            obj.notify('uploadError', { file: file, errorCode: errorCode, message: message });
        },

        upload_success_handler: function (file, serverData) {
            var isSucceeded = false;
            var message = '';
            var sepIndex = -1;

            if (serverData.length > 1) {
                sepIndex = serverData.indexOf(':');
                isSucceeded = serverData.substr(0, 2) == '1:';

                if (sepIndex > 0 && sepIndex < serverData.length - 1) {
                    message = serverData.substr(sepIndex + 1, serverData.length - sepIndex);
                }
            }

            obj.notify('uploadSuccess', { file: file, isSucceeded: isSucceeded, message: message });
        },

        queue_complete_handler: function () {
            obj.notify('afterUpload', {});
        }
    };

    if (typeof SWFUploadSettings !== 'undefined') {
        for (var p in SWFUploadSettings) {
            settings[p] = SWFUploadSettings[p];
        }
    }

    this.uploadControl = new SWFUpload(settings);
}

