var FileManagerPage = function () {
    this.onHelp = null;
    this.pageContentID = "ContentFrame";
    this.folder = "";
    this.folderID = 0;
    this.deleteMsg = "";
    this.deleteSeveralFilesMsg = "Delete selected files";
    this.restoreMsg = "";
    this.restoreSeveralFilesMsg = "Restore selected files";
    this.imageExtensions = new Array();
    this.editableExtensions = new Array();
    this.thumbnailView = null;
    this.isLinkManager = true;
}

FileManagerPage.prototype.initialize = function () {
    this.stretchContent();
    if (window.attachEvent) {
        window.attachEvent('onresize', function () { __page.stretchContent(); });
    } else if (window.addEventListener) {
        window.addEventListener('resize', function (e) { __page.stretchContent(); }, false);
    }
}

FileManagerPage.prototype.stretchContent = function () {
    var toolbarHeight = 0;
    var content = $(this.pageContentID);
    if (content) {
        toolbarHeight = $('divToolbar').getHeight();
        content.setStyle({ 'height': (document.body.clientHeight - toolbarHeight) + 'px' });
    }
}

FileManagerPage.prototype.metadata = function () {
    var width = window.screen.width - 300;
    var height = window.screen.height - 300;

    var qs = Object.toQueryString({
        'folder': encodeURIComponent(this.folder)
    });

    metadata_window = window.open("/Admin/Filemanager/Metadata/BulkEdit.aspx?" + qs, "", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=100 ,top=100");
    metadata_window.focus();
}

FileManagerPage.prototype.metafields = function () {
    var width = 650;
    var height = 492;

    var qs = Object.toQueryString({
        'folder': encodeURIComponent(this.folder)
    });

    metadata_window = window.open("/Admin/Filemanager/Metadata/ConfigurationEdit.aspx?" + qs, "", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=100 ,top=100");
    metadata_window.focus();
}

FileManagerPage.prototype.help = function () {
    if (typeof (this.onHelp) == 'function') {
        this.onHelp();
    }
}

FileManagerPage.prototype.setListMode = function (mode) {

    //take previous view settings
    var searchPhrase = document.getElementById("Files:TextFilter");
    var searchInSubfolder = document.getElementById("Files:SearchInSubfoldersFilter");
    var selectedPageNumber = document.getElementById("FilesCurentPage");
    var selectedPageSize = document.getElementById("Files:PageSizeFilter");
    var selectedSortBy = document.getElementById("FilesSortBy");
    var selectedSortDir = document.getElementById("FilesSortDir");

    //copy view settings to URL 
    var contextParams = "";
    if (searchPhrase && searchPhrase.value.length > 0)
        contextParams += "&searchPhrase=" + encodeURIComponent(searchPhrase.value);
    if (searchInSubfolder && searchInSubfolder.checked)
        contextParams += "&SearchInSubfoldersFilter=true";
    if (selectedPageNumber && selectedPageNumber.value.length > 0)
        contextParams += "&selectedPageNumber=" + selectedPageNumber.value;
    if (selectedPageSize)
        contextParams += "&selectedPageSize=" + selectedPageSize.options[selectedPageSize.selectedIndex].value;
    if (selectedSortBy)
        contextParams += "&selectedSortBy=" + selectedSortBy.value;
    if (selectedSortDir)
        contextParams += "&selectedSortDir=" + selectedSortDir.value;


    var src = document.location.href;
    if (src.endsWith('#'))
        src = src.substr(0, src.length - 1);

    //clear duplicates of view settings
    var params = src.toQueryParams();
    if (params.ListMode)
        src = src.replace("&ListMode=" + params.ListMode, "");
    if (params.searchPhrase)
        src = src.replace("&searchPhrase=" + encodeURIComponent(params.searchPhrase), "");
    src = src.replace("&searchPhrase=" + params.searchPhrase, "");
    if (params.SearchInSubfoldersFilter)
        src = src.replace("&SearchInSubfoldersFilter=" + params.SearchInSubfoldersFilter, "");
    if (params.selectedPageNumber)
        src = src.replace("&selectedPageNumber=" + params.selectedPageNumber, "");
    if (params.selectedPageSize)
        src = src.replace("&selectedPageSize=" + params.selectedPageSize, "");
    if (params.selectedSortBy)
        src = src.replace("&selectedSortBy=" + params.selectedSortBy, "");
    if (params.selectedSortDir)
        src = src.replace("&selectedSortDir=" + params.selectedSortDir, "");

    // reload
    document.location.href = src + contextParams + "&ListMode=" + mode;
}

FileManagerPage.prototype.upload = function () {
    url = '/Admin/Filemanager/Upload/Upload.aspx?Folder=' + encodeURIComponent(this.folder) +
        '&AllowChangeLocation=false&AllowOverwriteFiles=false';

    return window.open(url, 'fmUploadWnd', 'status=false,toolbar=false,location=false,menubar=false,' +
        'directories=false,scrollbars=false,width=950,height=600');
}

FileManagerPage.changeColumn = function (columnId) {
    if (typeof (__doPostBack) == 'function') {
        __doPostBack('Files', 'ColumnSelectorMenu:' + columnId);
    }
}

FileManagerPage.uploadWindowLoaded = function (sender, args) {
    var manager = sender.UploadManager.getInstance();
    var folder = "/" + ImagesFolderName;
    var params = sender.location.href.toQueryParams();
    if (params.Folder)
        folder = params.Folder;

    if (manager.get_canUpload()) {
        manager.add_afterUpload(function (sender, args) {
            FileManagerPage.refresh(folder);
        });
    }
}

FileManagerPage.refresh = function (folder) {    
    var src = parent.location.href;
    if (src.endsWith('#')) {
        src = src.substr(0, src.length - 1);
    }

    var params = src.toQueryParams();
    if (params.Folder) {
        src = src.replace("Folder=" + encodeURIComponent(params.Folder), "Folder=" + encodeURIComponent(folder));
        src = src.replace("Folder=" + params.Folder, "Folder=" + encodeURIComponent(folder));
    }
    else
        src = src + "?Folder=" + encodeURIComponent(folder);
    parent.location.href = src;
}

FileManagerPage.prototype.preview = function (file) {
    if (file == 'contextmenu') {
        file = ContextMenu.callingItemID;
    }
    if (this.isImage(file) || file.toLowerCase().endsWith(".swf") || file.toLowerCase().endsWith(".pdf")) {
        window.open("/Admin/FileManager/FileManager_preview.aspx?File=" + encodeURIComponent(file), "", "resizable=yes,status=no,help=no");
    } else {
        FileManagerPage.open(file);
    }
}

FileManagerPage.prototype.edit = function () {
    var width = window.screen.width - 300;
    var height = window.screen.height - 300;
    var parts = ContextMenu.callingItemID.split("/");
    var file = parts[parts.length - 1];
    var filesDir = ContextMenu.callingItemID.substr(0, ContextMenu.callingItemID.length - file.length);
    var editorScript = "/Admin/Filemanager/FileEditor/FileManager_FileEditorV2.aspx";
    DW_FileEditor_window = window.open(editorScript + "?File=" + encodeURIComponent(file) + "&Folder=" + encodeURIComponent(filesDir) + "&width=" + width + "&height=" + height, "", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=100 ,top=100");
    DW_FileEditor_window.focus();
}

FileManagerPage.editImage = function () {
    var width = window.screen.width - 300;
    var height = window.screen.height - 300;
    DW_imageeditor_window = window.open("/Admin/Filemanager/ImageEditor/Edit.aspx?File=/Files" + encodeURIComponent(ContextMenu.callingItemID), "DW_imageeditor_window", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=150,top=150");
    DW_imageeditor_window.focus();
}

FileManagerPage.prototype.move = function () {    
    var files = this.GetSelectedFilesRow();
    var isLinkManager = this.isLinkManager;
    var linkManagementFolder = this.folder;

    this.openWindow("/Admin/Filemanager/Browser/MoveCopy.aspx", "DW_browsefolder_window", 250, 400,
        function (returnValue) {
            if (returnValue) {
                if (isLinkManager && (files.lastIndexOf('|') < 0))
                    FileManagerPage.DoMoveWithLinkManagement(linkManagementFolder, returnValue.folder, files);
                else
                    FileManagerPage.DoMove(returnValue.folder, files);
            }
        });        
}

FileManagerPage.DoMoveWithLinkManagement = function (sourceFolder, destinationFolder, file) {
    var url = "/Admin/Module/LinkSearch/FileLinkManager.aspx?Action=CheckFiles";

    new Ajax.Request(FileManagerPage.makeUrlUnique(url), {
        method: 'get',
        parameters: {
            ActualFolder: sourceFolder,
            ActualFile: file
        },
        onSuccess: function (transport) {
            var refCnt = transport.responseText.evalJSON();
            if (refCnt == '0') {
                FileManagerPage.DoMove(destinationFolder, file);
            }
            else {
                FileManagerPage.CheckFileReferences(sourceFolder, file, "move", refCnt, function (result) {
                    if (result == "move_rename")
                        FileManagerPage.DoMove(destinationFolder, file);
                    else if (result == "update_move_rename")
                        FileManagerPage.DoUpdateMoveWithLinkManagement(sourceFolder, destinationFolder, file);
                });
            }
        }
    });
}

FileManagerPage.DoUpdateMoveWithLinkManagement = function(sourceFolder, destinationFolder, file) {
    var url = "/Admin/Module/LinkSearch/FileLinkManager.aspx?Action=update_move";

    new Ajax.Request(FileManagerPage.makeUrlUnique(url), {
        method: 'get',
        parameters: {
            ActualFolder: sourceFolder,
            ActualFile: file.substring(file.lastIndexOf('/') + 1), 
            newFolder: destinationFolder
        },
        onSuccess: function (transport) {
            var updateRslt = transport.responseText.evalJSON();
            if (updateRslt.UpdateResult == 'True') {
                FileManagerPage.DoMove(destinationFolder, file);
            }
        }
    });
}

FileManagerPage.DoMove = function (destinationFolder, file) {    
    FileManagerPage.CallFileSystem("move", destinationFolder, file);
}
FileManagerPage.DoCopy = function (destinationFolder, file) {
    FileManagerPage.CallFileSystem("copy", destinationFolder, file);
}

/* Check the existance of references on specified files */
FileManagerPage.CheckFileReferences = function (folder, file, action, referencesCount, callback) {
    var width = 350;
    var height = 170;
    var url = "/Admin/Module/LinkSearch/FileLinkManager.aspx?Action=" + action + "&ActualFolder=" + folder + "&ActualFile=" + file + "&ReferencesCount=" + referencesCount;
    var fn = function (returnValue) {
        if (!returnValue)
            return;
        if (returnValue.action == "properties")
            FileManagerPage.properties();

        if (callback)
            callback(returnValue.action);
    };
    var dlg = window.FilesWithReferences_wnd || parent.FilesWithReferences_wnd;
    if (dlg) {
        dlg.set_contentUrl(url);
        dlg.add_ok(function (e) {
            fn(dlg.returnValue);
        });
        dlg.show();
    } else {
        var fmp = new FileManagerPage();
        fmp.openWindow(url, "FileLinkManager", width, height, fn);
    }
}

FileManagerPage.CallFileSystem = function (action, folder, files) {
    var filesArr = files.split('|');
    for (var i = 0; i < filesArr.length; i++) {
        url = FileManagerPage.makeUrlUnique("/Admin/Filemanager/Browser/FileSystem.aspx?action=" + action + "&file=" + encodeURIComponent(filesArr[i]) + "&folder=" + encodeURIComponent(folder));
        if (i < filesArr.length - 1) {
            new Ajax.Request(url, {
                method: 'get',
                asynchronous: false,
                onSuccess: function (transport) {
                    if (transport.responseText.truncate().length > 0)
                        alert(transport.responseText);
                }
            });
        }
        else {
            //process last file 
            new Ajax.Request(url, {
                method: 'get',
                asynchronous: false,
                onSuccess: function (transport) {
                    if (transport.responseText.truncate().length > 0)
                        alert(transport.responseText);
                    else {
                        var file = files.split('|')[0];
                        var lastIndex = (file.lastIndexOf('/') > -1) ? file.lastIndexOf('/') : file.length - 1
                        var folderFromFiles = file.substring(0, lastIndex);
                        FileManagerPage.refresh((folder) ? folder : folderFromFiles);
                    }
                }
            });
        }
    }
}

FileManagerPage.makeUrlUnique = function (url) {
    var s = "?";
    if (url.indexOf("?") > 0) {
        s = "&";
    }
    return url + s + "zzz=" + Math.random();
}


FileManagerPage.prototype.copy = function () {
    var files = this.GetSelectedFilesRow();
    this.openWindow("/Admin/Filemanager/Browser/MoveCopy.aspx", "DW_browsefolder_window", 250, 400, 
        function (returnValue) {
            if (returnValue) {
                FileManagerPage.DoCopy(returnValue.folder, files);
            }
        });    
}

FileManagerPage.prototype.copyHere = function () {
    var files = this.GetSelectedFilesRow();
    var tmpFile = files.split('|')[0];
    var path = tmpFile.substring(0, tmpFile.lastIndexOf('/'));
    FileManagerPage.DoCopy(path, files);
}

FileManagerPage.prototype.restoreFile = function (name) {
    var file = name;
    if (name)
        file = this.folder + "/" + name;
    else
        file = ContextMenu.callingItemID;

    var filesArr = this.GetSelectedFilesRow();
    if (filesArr.indexOf('|') >= 0) {
        if (confirm(this.restoreSeveralFilesMsg + '?'))
            FileManagerPage.CallFileSystem("restoreFromTrashbin", '', filesArr);
    }
    else {
        if (confirm(this.restoreMsg + ': ' + file + '?'))
            FileManagerPage.CallFileSystem("restoreFromTrashbin", '', file);
    }
}

FileManagerPage.prototype.deleteFile = function (name) {
    var file = name;
    if (name)
        file = this.folder + "/" + name;
    else
        file = ContextMenu.callingItemID;
    var rows;
    if (this.thumbnailView.enabled)
        rows = this.thumbnailView.getSelectedRows();
    else
        rows = List.getSelectedRows('Files');


    if (rows != null && rows.length > 1) {
        if (confirm(this.deleteSeveralFilesMsg + '?'))
            FileManagerPage.CallFileSystem("delete", '', this.GetSelectedFilesRow());
    }
    else {
        if (this.isLinkManager)
            FileManagerPage.DoDeleteWithLinkManagement(this.folder, file, this.deleteMsg);
        else {
            if (confirm(this.deleteMsg + ': ' + file + '?'))
                FileManagerPage.CallFileSystem("delete", '', file);
        }
    }
}

FileManagerPage.DoDeleteWithLinkManagement = function (folder, file, deleteMsg) {
    var url = "/Admin/Module/LinkSearch/FileLinkManager.aspx?Action=CheckFiles";

    new Ajax.Request(url, {
        method: 'get',
        parameters: {
            ActualFolder: folder,
            ActualFile: file
        },
        onSuccess: function (transport) {
            var refCnt = transport.responseText.evalJSON();
            if (refCnt == '0') {
                if (confirm(deleteMsg + ': ' + file + '?'))
                    FileManagerPage.CallFileSystem("delete", '', file);
            }
            else
            {
                FileManagerPage.CheckFileReferences(folder, file, "delete", refCnt,
                function (result)
                {
                    if(result == "delete")
                        FileManagerPage.CallFileSystem("delete", '', file);
                });
            }
        }
    });
}

FileManagerPage.prototype.translateTemplate = function () {
    var wnd = null;
    var module = '';
    var design = '';
    var isGlobal = false;
    var isDesignGlobal = false;

    if (this.folder.toLowerCase() == '/templates') {
        isGlobal = true;
    } else if (this.folder.toLowerCase() == '/templates/designs') {
        isDesignGlobal = true;
    } else if (this.folder.toLowerCase().indexOf('templates/designs/') > 0) {
        design = this.folder.toLowerCase().substring('/templates/designs/'.length);
        if (design.indexOf("/") >= 0) {
            design = design.substring(0, module.indexOf("/"));
        }
    } else {
        module = this.folder.toLowerCase().substring('/templates/'.length);
        if (module.indexOf("/") >= 0) {
            module = module.substring(0, module.indexOf("/"));
        }
    }

    // Screen center
    var x = screen.width / 2 - 800 / 2;
    var y = screen.height / 2 - 600 / 2;

    if (isDesignGlobal == true) {
        wnd = window.open('/Admin/Content/Management/Dictionary/TranslationKey_List.aspx?IsGlobal=true',
            'dwEditTranslateWnd',
            'width=800,height=600,scrollbars=no,toolbar=no,location=no,directories=no,status=no,resizable=yes,left=' + x + ',top=' + y)
    } else if (design != '') {
        wnd = window.open('/Admin/Content/Management/Dictionary/TranslationKey_List.aspx?designName=' + design,
            'dwEditTranslateWnd',
            'width=800,height=600,scrollbars=no,toolbar=no,location=no,directories=no,status=no,resizable=yes,left=' + x + ',top=' + y)
    } else {
        wnd = window.open('/Admin/FileManager/Translation/Translation_TranslateTemplate.aspx?file=' + this.folder + (isGlobal ? '&global=' + isGlobal : '&module=' + module), 'dwEditTranslateWnd',
        'scrollbars=no,toolbar=no,location=no,directories=no,status=no,resizable=yes');
    }

    if (wnd) wnd.focus();
}

FileManagerPage.open = function (file) {
    if (file) {
        window.open('/Files' + file);
    }
    else {
        window.open('/Files' + ContextMenu.callingItemID);
    }
}

FileManagerPage.download = function () {
    document.location.href = "/Admin/Public/download.aspx?Filarchive=true&File=Files" + encodeURIComponent(ContextMenu.callingItemID), "FileManagerAction", "";
    return false;
}

FileManagerPage.prototype.isImage = function (file) {
    var res = false;
    if (file) {
        file = file.toLowerCase();
        this.imageExtensions.each(function (item) {
            if (file.endsWith(item))
                res = true;
        });
    }
    return res;
}

FileManagerPage.prototype.isEditable = function (file) {
    var res = false;
    if (file) {
        file = file.toLowerCase();
        this.editableExtensions.each(function (item) {
            if (file.endsWith(item))
                res = true;
        });
    }
    return res;
}

FileManagerPage.prototype.GetSelectedFilesRow = function () {
    var ret = ContextMenu.callingItemID;
    var severalFiles = false;
    var checkedRows;
    if (this.thumbnailView.enabled) {
        checkedRows = this.thumbnailView.getSelectedRows();
        severalFiles = this.thumbnailView.rowIsSelected(ContextMenu.callingID) && checkedRows.length > 1;
    }
    else {
        checkedRows = List.getSelectedRows('Files');
        var selectedRow = List.getRowByID('Files', ContextMenu.callingID);
        severalFiles = List.rowIsSelected(selectedRow) && checkedRows.length > 1;
    }
    if (severalFiles) {
        ret = '';
        for (var i = 0; i < checkedRows.length; i++) {
            ret += checkedRows[i].readAttribute('itemID') + "|";
        }
        ret = ret.substring(0, ret.length - 1);
    }
    return ret;
}

FileManagerPage.prototype.openWindow = function (url, windowName, width, height, callback)
{
    var returnValue;

    if(window.showModalDialog)
    {
        returnValue = window.showModalDialog(url, windowName, "dialogWidth:" + width + "px; dialogHeight:" + height + "px");

        if(callback)
            callback(returnValue);
    }
    else
    {
        var popupWnd = window.open(url, windowName, 'status=0,toolbar=0,menubar=0,resizable=0,directories=0,titlebar=0,modal=yes,width=' + width + ',height=' + height);

        if(callback)
        {
            popupWnd.onunload = function ()
            {
                callback(popupWnd.returnValue);
                returnValue = popupWnd.returnValue;
            }
        }
    }

    return returnValue;
}

FileManagerPage.properties = function () {
    var filePath = encodeURIComponent(ContextMenu.callingItemID);
    var width = 650;
    var height = 492;
    var editorScript = "/Admin/Filemanager/Browser/Properties.aspx";
    DW_FileProperties_window = window.open(editorScript + "?FilePath=" + filePath + "&width=" + width + "&height=" + height, "", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=100 ,top=100");
    DW_FileProperties_window.focus();
}