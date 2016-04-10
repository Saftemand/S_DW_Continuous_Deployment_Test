<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.BrowserDefault" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Content.Files" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="Accordion" TagName="Accordion" Src="/Admin/Content/Accordion/Accordion.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title></title>
	<dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
	<asp:Literal runat="server" ID="folderscript" EnableViewState="false"></asp:Literal>
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <script type="text/javascript"> var ImagesFolderName = '<%=Dynamicweb.Content.Management.Installation.ImagesFolderName%>';</script>
    <script type="text/javascript" src="EntryContent.js"></script>
    <script type="text/javascript" src="/Admin/Content/JsLib/dw/Collapse.js"></script>
    <script type="text/javascript" src="/Admin/Filemanager/Upload/js/EventsManager.js"></script>
	<script type="text/javascript">
        _keycache = "TreeBrowserIsCollapsed";
        var _isLinkManager = <%=Base.IIF(Base.HasAccess("LinkSearch", ""), "true", "false") %>;

		function getFolder() {
			var id = ContextMenu.callingID;
			return document.getElementById("rootFolder").value + f[id];
		}

        function showNewFolderDialog() {
            dialog.show("NewFolderDialog");

            document.getElementById("NewFolderName").value = "NewFolder";
            document.getElementById("NewFolderName").focus();
        }
		function createNewFolder() {
			var folderName = ContextMenu.callingItemID;
            var newFolderName = "";
            var changedName = "";
            newFolderName = document.getElementById("NewFolderName").value;
            changedName = replaceCharacters(newFolderName);
            document.getElementById("NewFolderName").value = changedName;

           if (changedName != newFolderName)
                newFolderName = "";

            if(newFolderName.length > 0){
                url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=create&folder=" + encodeURIComponent(folderName) + "&newfolder=" + encodeURIComponent(newFolderName);
		        new Ajax.Request(url, {
		            method: 'post',
		            onSuccess: function (transport) {
		                if (transport.responseText.truncate().length > 0) {
		                    alert(transport.responseText);
		                }
		                else {
		                    reloadWindow(folderName + '/' + newFolderName);
		                }
		            }
		        });
                dialog.hide('NewFolderDialog');
            }
            document.getElementById("NewFolderName").focus();
		}
        function showRenameFolderDialog() {
            var folderName = ContextMenu.callingItemID;
            dialog.show("RenameFolderDialog");
            
            var lastIndex = (folderName.lastIndexOf('/') > -1) ? folderName.lastIndexOf('/') + 1 : 0;
            folderName = folderName.substring(lastIndex);
            document.getElementById("RenamedFolder").value = folderName;
            document.getElementById("RenamedFolder").focus();
        }
		function renameFolder() {
            var folderName = ContextMenu.callingItemID;
		    var newFolderName = "";
            var changedName = "";
            newFolderName = document.getElementById("RenamedFolder").value;
            changedName = replaceCharacters(newFolderName);
            document.getElementById("RenamedFolder").value = changedName;

            if (changedName != newFolderName)
                newFolderName = "";

            var lastIndex = (folderName.lastIndexOf('/') > -1) ? folderName.lastIndexOf('/') + 1 : folderName.length - 1;
            if (folderName.replace(folderName.substring(0, lastIndex), "") == newFolderName)
                newFolderName = "";
            
            if (newFolderName.length > 0) {
                newFolderName = folderName.substring(0, lastIndex) + newFolderName;
		        DoRename(folderName, newFolderName);
                dialog.hide('RenameFolderDialog');
            }
            document.getElementById("RenamedFolder").focus();
		}

		function showRenameFileDialog() 
		{
		    var fileName = ContextMenu.callingItemID;
		    dialog.show("RenameFileDialog");

		    var lastIndex = (fileName.lastIndexOf('/') > -1) ? fileName.lastIndexOf('/') + 1 : 0;
		    var el = document.getElementById("RenamedFile");
            
		    fileName = fileName.substring(lastIndex);
		    el.value = fileName;
		    el.focus();

		    var lastExtIndex = (fileName.lastIndexOf('.') > -1) ? fileName.lastIndexOf('.') : fileName.length;

		    el.setSelectionRange(0, lastExtIndex);

		    Event.observe(document.getElementById("RenameFileDialog"), 'keydown', OnRenameFileDlgOKClicked);
		}

        function OnRenameFileDlgOKClicked(e)
        {
            if (e.keyCode == 13 || e.which == 13 || e.charCode == 13) 
                renameFile();
        }

        function DoRenameWithLinkManagement (sourceFolder, file, newFile, folderName, newFolderName) {
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
                        DoRename(folderName, newFolderName);
                    }
                    else 
                    {
                        FileManagerPage.CheckFileReferences(sourceFolder, file, "rename", refCnt,
                            function (result)
                            {
                                if (result == "move_rename") 
                                    DoRename(folderName, newFolderName);                                
                                else if (result == "update_move_rename")
                                    DoUpdateRenameWithLinkManagement (sourceFolder, file, newFile, folderName, newFolderName);                                
                            });                        
                    }
                }
            });
        }

        function DoUpdateRenameWithLinkManagement (sourceFolder, file, newFile, folderName, newFolderName) {
            var url = "/Admin/Module/LinkSearch/FileLinkManager.aspx?Action=update_rename";

            new Ajax.Request(FileManagerPage.makeUrlUnique(url), {
                method: 'get',
                parameters: {
                    ActualFolder: sourceFolder,
                    ActualFile: file,
                    newFile: newFile
                },
                onSuccess: function (transport) {
                    var updateRslt = transport.responseText.evalJSON();
                    if (updateRslt.UpdateResult == 'True') {
                        DoRename(folderName, newFolderName);
                    }
                }
            });
        }

        function DoRename(folderName, newFolderName) {
                var url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=renameFolder&folder=" + encodeURIComponent(folderName) + "&newfolder=" + encodeURIComponent(newFolderName);
		        new Ajax.Request(url, {
		            method: 'post',
		            onSuccess: function (transport) {
		                if (transport.responseText.truncate().length > 0) {
		                    alert(transport.responseText);
		                }
		                else {
		                    reloadWindow(folderName.substring(0, folderName.lastIndexOf('/')));
		                }
		            }
		        });    
        }

        function renameFile() {
            var fileName = ContextMenu.callingItemID;
            var newFileName = "";
            var changedName = "";
            newFileName = document.getElementById("RenamedFile").value;
            changedName = replaceCharacters(newFileName);
            document.getElementById("RenamedFile").value = changedName;

            if (changedName != newFileName)
                newFileName = "";

            var lastIndex = (fileName.lastIndexOf('/') > -1) ? fileName.lastIndexOf('/') + 1 : fileName.length - 1;
            if (fileName.replace(fileName.substring(0, lastIndex), "") == newFileName)
                newFileName = "";

            if (newFileName.length > 0) {
                var fullNewFileName = fileName.substring(0, lastIndex) + newFileName;
                if (_isLinkManager)
                    DoRenameWithLinkManagement(fileName.substring(0, lastIndex), fileName.substring(lastIndex), newFileName, fileName, fullNewFileName);
                else
                    DoRename(fileName, fullNewFileName);
                dialog.hide('RenameFileDialog');
            }
            document.getElementById("RenamedFile").focus();
        }

        function replaceCharacters(fileName) {
            var msgText = '';
            var dstFileName = fileName;
            //do trim
            dstFileName = dstFileName.replace(/(^\s+)|(\s+$)/g, "");

            if ($('replaceSpace').value == 'true') {
                if (dstFileName.indexOf(' ') > -1) {
                    dstFileName = dstFileName.replace(/ /g, '-');
                    msgText += document.getElementById('Message_FileWarning_4').innerHTML.replace('%%', fileName) + '\n\r';
                }
            }
            if ($('replaceSpecial').value == 'true') {
                var re = new RegExp('[^a-zA-Z0-9._\w\-]', 'g');
                if (dstFileName.match(re)) {
//                    dstFileName = dstFileName.replace("æ", "ae");
//                    dstFileName = dstFileName.replace("ä", "ae");
//                    dstFileName = dstFileName.replace("ø", "oe");
//                    dstFileName = dstFileName.replace("ö", "oe");
//                    dstFileName = dstFileName.replace("å", "aa");
//                    dstFileName = dstFileName.replace(re, '');
                        new Ajax.Request("AJAX_Handler.ashx?arg="+encodeURIComponent(dstFileName), {
                            method: 'get',
                            asynchronous: false,
                            onSuccess: function (transport) {
                                dstFileName = transport.responseText
                                }
                        });
                    msgText += document.getElementById('Message_FileWarning_5').innerHTML.replace('%%', fileName);
                }
            }
            else {
                var re = new RegExp('[/*?:|"<>]', 'g');
                if (dstFileName.match(re) || dstFileName.indexOf('\\') > -1) {
                    dstFileName = fileName.replace(re, '');
                    dstFileName = dstFileName.replace(/\\/g, "")
                    msgText = document.getElementById('Message_FileWarning_6').innerHTML.replace('%%', fileName) + '\n\r';
                }
            }
            if (fileName.indexOf(',') > -1) {
                dstFileName = fileName.replace(/,/g, '_');
                msgText = document.getElementById('Message_FileWarning_1').innerHTML.replace('%%', fileName) + '\n\r';
            }
            if (dstFileName.indexOf(';') > -1) {
                dstFileName = dstFileName.replace(/;/g, '_');
                msgText += document.getElementById('Message_FileWarning_2').innerHTML.replace('%%', fileName) + '\n\r';
            }
            if (dstFileName.indexOf('+') > -1) {
                dstFileName = dstFileName.replace(/\+/g, '_');
                msgText += document.getElementById('Message_FileWarning_3').innerHTML.replace('%%', fileName) + '\n\r';
            }
            if (dstFileName.indexOf('\'') > -1) {
                dstFileName = dstFileName.replace(/'/g, '_');
                msgText += document.getElementById('Message_FileWarning_7').innerHTML.replace('%%', fileName) + '\n\r';
            }
            if (dstFileName.indexOf('#') > -1) {
                dstFileName = dstFileName.replace(/#/g, '_');
                msgText += document.getElementById('Message_FileWarning_8').innerHTML.replace('%%', fileName) + '\n\r';
            }
            // chars -- are raise error when file name is passed trought url parameters and checked by SQLEscapeInjection function
            dstFileName = dstFileName.replace(/\-{2,}/g, '-');

            if (msgText != '') {
                alert(msgText);
            }
            return dstFileName;
        }

		function deleteFolder(systemFolder) {
		    var folderName = ContextMenu.callingItemID;

            if (systemFolder) {
                var message = "<%=Translate.JSTranslate("ADVARSEL!")%>" + "\n<%=Translate.JSTranslate("You are about to delete a system folder!")%>" + "\n\n<%=Translate.JSTranslate("Alle %% vil blive slettet!", "%%", Translate.Translate("undermapper"))%>"    + "\n<%=Translate.JSTranslate("Referencer til filer i mappen bliver ikke opdateret!")%>"  + "\n\n<%=Translate.JSTranslate("Fortsæt?")%>";
            } else {
                var message = "<%=Translate.JSTranslate("ADVARSEL!")%>" + "\n<%=Translate.JSTranslate("Alle %% vil blive slettet!", "%%", Translate.Translate("undermapper"))%>"    + "\n<%=Translate.JSTranslate("Referencer til filer i mappen bliver ikke opdateret!")%>"  + "\n\n<%=Translate.JSTranslate("Fortsæt?")%>";
            }
		    if (confirm(message)) {
		        url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=delete&folder=" + encodeURIComponent(folderName);
		        new Ajax.Request(url, {
		            method: 'post',
		            onSuccess: function (transport) {
		                if (transport.responseText.truncate().length > 0) {
		                    alert(transport.responseText);
                            reloadWindow();
		                }
		                else {
		                    reloadWindow(folderName.substring(0, folderName.lastIndexOf('/')));
		                }
		            }
		        });
		    }
        }
		function moveFolder() {
		    var folderName = ContextMenu.callingItemID;
		    var page = new FileManagerPage();
            if (confirm("<%=Translate.JSTranslate("ADVARSEL!")%>" + "\n<%=Translate.JSTranslate("Referencer til filer i mappen bliver ikke opdateret!")%>"  + "\n\n<%=Translate.JSTranslate("Fortsæt?")%>")) {
                var returnValue = page.openWindow("/Admin/Filemanager/Browser/MoveCopy.aspx?Folder=" + folderName, "DW_browsefolder_window", 250, 400,
                    function(returnValue){
                        if (returnValue) {
                            url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=move&folder=" + encodeURIComponent(folderName) + "&newfolder=" + encodeURIComponent(returnValue.folder);
                            new Ajax.Request(url, {
                                method: 'post',
                                onSuccess: function (transport) {
                                    if (transport.responseText.truncate().length > 0) {
                                        alert(transport.responseText);
                                    }
                                    else {
                                        var lastIndex = (folderName.lastIndexOf('/') > -1) ? folderName.lastIndexOf('/') : 0
                                        folderName = folderName.substring(lastIndex);
                                        reloadWindow(returnValue.folder + folderName);
                                    }
                                }
                            });
                        }
                    });		        
            }
		}

		function copyFolder() {
            var folderName = ContextMenu.callingItemID;
		    var page = new FileManagerPage();
		    var returnValue = page.openWindow("/Admin/Filemanager/Browser/MoveCopy.aspx?Folder=" + folderName, "DW_browsefolder_window", 250, 400,
                function(returnValue){
                    if (returnValue) {
                        url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=copy&folder=" + encodeURIComponent(folderName) + "&newfolder=" + encodeURIComponent(returnValue.folder);
                        new Ajax.Request(url, {
                            method: 'post',
                            onSuccess: function (transport) {
                                if (transport.responseText.truncate().length > 0) {
                                    alert(transport.responseText);
                                }
                                else {
                                    reloadWindow(returnValue.folder);
                                }
                            }
                        });
                    }
                });		
        }
        
		var uploadRefresh = false;
        function upload() {
		    var page = new FileManagerPage();
		    page.folder = ContextMenu.callingItemID;
		    var contentDocument = ($("ContentFrame").contentDocument) ? $("ContentFrame").contentDocument : $("ContentFrame").Document;
		    var params = contentDocument.location.href.toQueryParams();
		    uploadRefresh = params.Folder == page.folder;
            page.upload();
		}

		function refreshContent() {
		    if (uploadRefresh) {
		        var contentDocument = ($("ContentFrame").contentDocument) ? $("ContentFrame").contentDocument : $("ContentFrame").Document;
                frames["ContentFrame"].showLoading();
		        var src = contentDocument.location.href;
		        if (src.endsWith('#'))
		            src = src.substr(0, src.length - 1);
		        contentDocument.location.href = src;
		    }
		}

		function onContextMenuView(sender, arg) {
            var folderName = arg.callingItemID;

            var itemId = arg.callingID;
            if (folderName == "/Papirkurv") { itemId -= 100001; }
            else if (folderName.toLowerCase() == "/cache.net") { itemId -= 100000; }

            t.s(itemId, true);

            if (folderName.replace(/\//g, '') == "<%=_secureFolderName %>") {
                return "security";
            } else if (folderName == '/' + '<%=Dynamicweb.Content.Management.Installation.ImagesFolderName%>' || folderName == '/' + '<%=Dynamicweb.Content.Management.Installation.FilesFolderName%>' || folderName == '/ForumV2' || folderName == '/HTML' || folderName == '/Navigation'  || folderName == '/System') {
		        return "system";
            } else if (folderName.startsWith('/ForumV2/') || folderName.startsWith('/HTML/') || folderName.startsWith('/Navigation/')  || folderName.startsWith('/System/')) {
		        return "systemitems";
            } else if (folderName.startsWith('/Templates/Designs/')) {
		        return "design";
            } else if (folderName.startsWith('/Templates/Designs')) {
		        return "system";
            } else if (folderName.startsWith('/Templates/')) {
		        return "systemitems";
		    } else if (folderName.startsWith('/Templates')) {
		        return "templates";
		    } else if (folderName.startsWith('/Papirkurv')) {
		        return "recycle";
            } else if (folderName.toLowerCase().startsWith('/cache.net')) {
		        return "cache";
            }

            return "common";
        }

        var newFileExt = "";

        function showNewFileDialog(ext) {
            dialog.show("NewFileDialog");

            newFileExt = ext;

            document.getElementById("NewFileName").value = "NewFile" + ext;
            document.getElementById("NewFileName").focus();
        }


        function createNewFile() {
            var changedName = "";
            var fileName = document.getElementById('NewFileName').value;
            changedName = replaceCharacters(fileName);
            document.getElementById('NewFileName').value = changedName;

            if (changedName != fileName)
                fileName = "";

            if (fileName.length > 0) {
                var ext = getExtension(fileName);

                if (ext.length == 0 || (ext != ".cshtml" && ext != ".cshtm" && ext != ".vbhtml" && ext != ".vbhtm" && ext != ".html" && ext != ".htm" && ext != ".xslt" && ext != ".xsl")) {
                    fileName = fileName + newFileExt;
                }

                var folderName = ContextMenu.callingItemID;
                var path = folderName + '/' + fileName;

                url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=create&file=" + encodeURIComponent(path);
                new Ajax.Request(url, {
                    method: 'post',
                    onSuccess: function (transport) {
                        if (transport.responseText.truncate().length > 0) {
                            alert(transport.responseText);
                        }
                        else {
                            var width = window.screen.width - 200;
                            var height = window.screen.height - 200;

                            var script = '/Admin/FileManager/FileEditor/FileManager_FileEditorV2.aspx?File=' + encodeURIComponent(fileName) + '&Folder=' + encodeURIComponent(folderName) + '&width=' + width + '&height=' + height;
                            var wnd = window.open(script, '', 'resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=' + width + ',height=' + height + ',left=100,top=100');
                            wnd.focus();

                            reloadWindow(folderName);
                        }
                    }
                });
                dialog.hide('NewFileDialog');
            }
            document.getElementById('NewFileName').focus();
        }

        function reloadWindow(folderName) {
            var id = ContextMenu.callingID;
            
            if (folderName == "/Papirkurv" && id > 100000) { id -= 100001; folderName = undefined; }
            else if (folderName.toLowerCase() == "/cache.net" && id > 100000) { id -= 100000; folderName = undefined; }

            var src = document.location.href;
            if (src.endsWith('#'))
                src = src.substr(0, src.length - 1);

            var params = src.toQueryParams();
            
            if (folderName) {
                if (params.Folder) {
                    src = src.replace("Folder=" + encodeURIComponent(params.Folder), "Folder=" + encodeURIComponent(folderName));
                    src = src.replace("Folder=" + params.Folder, "Folder=" + encodeURIComponent(folderName));
                }
                else 
                    src = src + "?Folder=" + encodeURIComponent(folderName);
                document.location.href = src;
            } else {
                if (params.NodeID)
                    src = src.replace("NodeID=" + params.NodeID, "NodeID=" + id);
                else 
                    src = src + "?NodeID=" + id;
                document.location.href = src;
            }
        }

        /* show image settings for selected folder*/
        function showImageSettings() {
            var id = ContextMenu.callingID;
            var folderName = f[id].replace("\\", "/");
            var dialogInstance = imageSettingsPopUp_wnd;
            
            if (dialogInstance) {
                dialogInstance.hide();
                dialogInstance.set_contentUrl('/Admin/Filemanager/Browser/ImageSettings.aspx?Path=' + encodeURIComponent(folderName));
                dialogInstance.set_width("650");
                dialogInstance.set_height("480");
                dialogInstance.show();
            }
        }

        /* apply image settings for selected folder*/
        function applyImageSettings(reload) {
            var dialogInstance = imageSettingsPopUp_wnd;
            if (dialogInstance) dialogInstance.hide();

            if (reload) {
                uploadRefresh = true;
                refreshContent();
            }
        }



        /* Gets file extension */
        getExtension = function (file) {
            var ext = '';
            var separatorIndex = 0;

            separatorIndex = file.lastIndexOf('.');
            if (separatorIndex >= 0 && separatorIndex < file.length - 1) {
                ext = file.substr(separatorIndex, file.length - separatorIndex);
            }

            return ext.toLowerCase();
        }

        /* Accordion */
        function onAccordionContextMenuView(sender, arg) {
            return arg.callingID;
        }

        function onAccordionContextMenu(sender, arg) {
            window.open('/Admin/Default.aspx?accordionAction=' + arg);
            return false;
        }

        function emptyTrashbinOrCache(name) {
            if (name=="trash") {
                if (confirm('<%=Translate.JSTranslate("Tøm %%?", "%%", Translate.Translate("papirkurv"))%>\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.JSTranslate("Alle %% vil blive slettet permanent!", "%%", Translate.Translate("elementer"))%>')) {
		            url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=emptyTrashOrCache&folder=trash";
		            new Ajax.Request(url, {
		                method: 'post',
		                onSuccess: function (transport) {
		                    if (transport.responseText.truncate().length > 0) {
		                        alert(transport.responseText);
		                    }
		                    reloadWindow("/Papirkurv");
		                }
		            });
		        }
            } else {
                if (confirm('<%=Translate.JSTranslate("Tøm %%?", "%%", Translate.Translate("cache"))%>\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.JSTranslate("Alle %% vil blive slettet permanent!", "%%", Translate.Translate("elementer"))%>')) {
		            url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=emptyTrashOrCache&folder=cache";
		            new Ajax.Request(url, {
		                method: 'post',
		                onSuccess: function (transport) {
		                    if (transport.responseText.truncate().length > 0) {
		                        alert(transport.responseText);
                            }
		                    reloadWindow("/cache.net");
		                }
		            });
		        }
            }
        }

        function resizeTree() {
            var accHeight = $("accordion1") ? $("accordion1").offsetHeight : 0;
            $("ContentFrame").style.height = "100%";
            $("tree1").style.height = ($("tree1").offsetHeight - accHeight) + "px";
        }

        function permissions(securityFolder) {
            var folder = ContextMenu.callingItemID;

            dialog.setTitle('permissionEditDialog', '<%=Backend.Translate.JsTranslate("Edit permissions") %>: ' + folder);

            document.getElementById('permissionEditDialogIFrame').src = '/Admin/FastLoadRedirect.aspx?redirect=/Admin/Filemanager/Browser/FileManagerPermissionEdit.aspx?ID=1%26AccessElementType=folder%26Element=' + ContextMenu.callingItemID + '%26CloseOnExit=True%26DialogID=permissionEditDialog%26SecurityFolder=' + securityFolder;
            dialog.show('permissionEditDialog');
        }

        
    </script>

    <style type="text/css">
	#accordion1
	{
		position: fixed;
		bottom: 0px;
		left: 0px;
		z-index: 1000;
		<%If Request.ServerVariables("HTTP_USER_AGENT").contains("Firefox") Then%>
        border-left:solid 1px #9FAEC2;
        <%end if %>
		border-right:solid 1px #9FAEC2;
	}
	#cellTreeCollapsed
    {
        background-color: #dae8f7;
        border-right: 1px solid #9faec2;
    }
    #ContentFrame
    {
        height:100%;
        width: 100%;
    }
	.LayoutTable .TreeContainer
    {
	    width:249px;
	    max-width:249px;
	    height:100%;
    }
	
	.nav
    {
	    width: 247px;
    }
    
    .nav .tree
    {
	    width: 246px;
    }
    
    .nav .title
    {
	    width:246px;
    }
    
    .nav .subtitle
    {
	    width:246px;
    }
    .titleRow
	{
		background-color: <%=Gui.NewUIbgColor()%>;
		background: url('/Admin/Images/Ribbon/UI/List/PipeL.gif' ) top left repeat-x;
	}
    .title
	{
		height:26px;
		line-height:25px;
		vertical-align:baseline;		
	}
    </style>

</head>
<body id="body" runat="server">
	<form id="form1" runat="server" enableviewstate="false" style="height:100%; width:100%;">
		<input type="hidden" id="rootFolder" runat="server" />
		<table id="Container" style="height:100%; width:100%;" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td id="cellTreeCollapsed" style="width: 24px; display: none;">
                    <img id="imgShowNav" class="tree-toolbar-button" style="cursor: pointer" src="/Admin/images/OpenTreeView_off.gif"
                        runat="server" />
                </td>
                <td style="height:100%; width:100%;">
                    <dw:ModuleAdmin runat="server" ContentFrameSrc="about:blank" ID="ModuleAdmin" EnableViewState="false">
                            <dw:Tree ID="Tree1" runat="server" SubTitle="Mapper" Title="Filarkiv" ShowRoot="false" OpenAll="false" UseSelection="true" UseCookies="false" UseLines="true" AutoID="false" LoadOnDemand="false" CloseSameLevel="false" UseStatusText="false" InOrder="true" EnableViewState="false">
				                <dw:TreeNode ID="TreeNode1" NodeID="0" runat="server" Name="Root" ParentID="-1">
				                </dw:TreeNode>
			                </dw:Tree>
                    </dw:ModuleAdmin>
                </td>
            </tr>
        </table>

		<dw:ContextMenu runat="server" ID="fc" Translate="true"  OnClientSelectView="onContextMenuView">
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton4" Views="common,system,systemitems,design,security" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_up.png" Text="Upload" OnClientClick="upload();"/>
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton1" Views="common,templates,design,system,systemitems,security" DoTranslate="True" Image="FolderAdd" Text="New subfolder" OnClientClick="showNewFolderDialog();" Divide="Before" />

            <dw:ContextMenuButton runat="server" ID="ContextMenuButton6" Views="common,system,systemitems,security,design" DoTranslate="True" Image="TextCode_Add" Text="New file" >
                <dw:ContextMenuButton runat="server" ID="ContextMenuButton8" Views="design" DoTranslate="True" Image="TextCode_Colored" Text="HTML" OnClientClick="showNewFileDialog('.html');" />
                <dw:ContextMenuButton runat="server" ID="ContextMenuButton9" Views="design" DoTranslate="True" Image="Tree" Text="XSLT" OnClientClick="showNewFileDialog('.xslt');" />
                <dw:ContextMenuButton runat="server" ID="ContextMenuButton16" Views="design" DoTranslate="True" Image="TextCode_CSharp" Text="Razor" OnClientClick="showNewFileDialog('.cshtml');" />
            </dw:ContextMenuButton>
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton2" Views="common,design" DoTranslate="True" Image="FolderEdit" Text="Omdøb" OnClientClick="showRenameFolderDialog();" />
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton7" Views="common,design" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_out.png" Text="Flyt" OnClientClick="moveFolder();" />
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton15" Views="common,design,systemitems" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_into.png" Text="Copy" OnClientClick="copyFolder();" />
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton3" Views="common,design" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" Text="Slet" OnClientClick="deleteFolder();" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton14" Views="systemitems" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" Text="Slet" OnClientClick="deleteFolder('systemFolder');" />

			<dw:ContextMenuButton runat="server" ID="ContextMenuButton11" Views="common,design,system,systemitems,security" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/image_settings.png" Text="Image settings" OnClientClick="showImageSettings();" Divide="before"/>
            <%If Base.HasAccess("UserManagementFrontend") OrElse Base.HasAccess("UserManagementBackend") Then%>
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton5" Views="common,templates,design,system,systemitems" DoTranslate="True" ImagePath="/admin/module/ecom_catalog/dw7/images/content/ecom_user_permission_small.gif" Text="Rettigheder" OnClientClick="permissions('false');" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton21" Views="security" DoTranslate="True" ImagePath="/admin/module/ecom_catalog/dw7/images/content/ecom_user_permission_small.gif" Text="Rettigheder" OnClientClick="permissions('true');" />
            <%End If%>
		</dw:ContextMenu>
        		<dw:ContextMenu runat="server" ID="fcReadOnly" Translate="true"  OnClientSelectView="onContextMenuView">
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton17" Views="common,system,systemitems,design,security" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_up.png" Text="Upload" OnClientClick="upload();" Disabled="true"/>
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton19" Views="common,templates,design,system,systemitems,security" DoTranslate="True" Image="FolderAdd" Text="New subfolder" OnClientClick="showNewFolderDialog();" Divide="Before" Disabled="true" />

            <dw:ContextMenuButton runat="server" ID="ContextMenuButton20" Views="common,system,systemitems,security,design" DoTranslate="True" Image="TextCode_Add" Text="New file" Disabled="true">
                <dw:ContextMenuButton runat="server" ID="ContextMenuButton22" Views="design" DoTranslate="True" Image="TextCode_Colored" Text="HTML" OnClientClick="showNewFileDialog('.html');" />
                <dw:ContextMenuButton runat="server" ID="ContextMenuButton23" Views="design" DoTranslate="True" Image="Tree" Text="XSLT" OnClientClick="showNewFileDialog('.xslt');" />
                <dw:ContextMenuButton runat="server" ID="ContextMenuButton24" Views="design" DoTranslate="True" Image="TextCode_CSharp" Text="Razor" OnClientClick="showNewFileDialog('.cshtml');" />
            </dw:ContextMenuButton>
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton25" Views="common,design" DoTranslate="True" Image="FolderEdit" Text="Omdøb" OnClientClick="showRenameFolderDialog();" Disabled="true" />
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton26" Views="common,design" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_out.png" Text="Flyt" OnClientClick="moveFolder();" Disabled="true" />
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton27" Views="common,design,systemitems" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_into.png" Text="Copy" OnClientClick="copyFolder();" Disabled="true" />
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton28" Views="common,design" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" Text="Slet" OnClientClick="deleteFolder();" Disabled="true" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton29" Views="systemitems" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" Text="Slet" OnClientClick="deleteFolder('systemFolder');" Disabled="true" />

			<dw:ContextMenuButton runat="server" ID="ContextMenuButton30" Views="common,design,system,systemitems,security" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/image_settings.png" Text="Image settings" OnClientClick="showImageSettings();" Divide="before"/>
            <%If Base.HasAccess("UserManagementFrontend") OrElse Base.HasAccess("UserManagementBackend") Then%>
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton31" Views="common,templates,design,system,systemitems" DoTranslate="True" ImagePath="/admin/module/ecom_catalog/dw7/images/content/ecom_user_permission_small.gif" Text="Rettigheder" OnClientClick="permissions('false');" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton32" Views="security" DoTranslate="True" ImagePath="/admin/module/ecom_catalog/dw7/images/content/ecom_user_permission_small.gif" Text="Rettigheder" OnClientClick="permissions('true');" />
            <%End If%>
		</dw:ContextMenu>
		<dw:ContextMenu runat="server" ID="recycleOrCache" Translate="true"  OnClientSelectView="onContextMenuView">
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton10" Views="recycle" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/garbage.png" Text="Empty trashbin" OnClientClick="emptyTrashbinOrCache('trash');" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton18" Views="cache" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/garbage.png" Text="Empty cache" OnClientClick="emptyTrashbinOrCache('cache');" />
		</dw:ContextMenu>

        <dw:ContextMenu runat="server" ID="recycleOrCacheItems" Translate="true"  OnClientSelectView="onContextMenuView">
			<dw:ContextMenuButton runat="server" ID="ContextMenuButton12" Views="recycle,cache" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_out.png" Text="Flyt" OnClientClick="moveFolder();" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton13" Views="recycle,cache" DoTranslate="True" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" Text="Slet" OnClientClick="deleteFolder();" />
		</dw:ContextMenu>


	    <Accordion:Accordion SelectedButton="filemanager" id="Accordion" runat="server" ContextMenuID="AccordionMenu" />
        <dw:ContextMenu ID="AccordionMenu" runat="server" OnClientSelectView="onAccordionContextMenuView">
            <dw:ContextMenuButton runat="server" ID="cmdPages" Views="page" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'page()');" />
            <dw:ContextMenuButton runat="server" ID="cmdFiles" Views="filemanager" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'filemanager()');" />
            <dw:ContextMenuButton runat="server" ID="cmdUserManagement" Views="usermanagement" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'userManagement()');" />
            <dw:ContextMenuButton runat="server" ID="cmdEcom" Views="ecom" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'ecom()');" />
            <dw:ContextMenuButton runat="server" ID="cmdOMC" Views="omc" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'omc()');" />
            <dw:ContextMenuButton runat="server" ID="cmdModules" Views="modules" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'modules()');" />
            <dw:ContextMenuButton runat="server" ID="cmdManagementCenter" Views="managementcenter" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'mgmtcenter()');" />
        </dw:ContextMenu>
		
		<script type="text/javascript">
		    t.old_s = t.s;
		    t.s = function (id, isContextMenu) {
		        if (t.old_s != null) {
		            t.old_s(id);
		        }
		    }

		    // if FM is opened inside MainFrame, don't  show accordion
		    if (!top.document.getElementById("MainFrame") && $("accordion1")) $("accordion1").style.display = "none";
		    resizeTree();
		    parent.frames.left.hidePageFrame();
		</script>

	</form>

    <dw:PopUpWindow ID="imageSettingsPopUp" Title="Image settings" UseTabularLayout="true" ShowOkButton="false" ShowCancelButton="false"  AllowDrag="true" ShowClose="true" 
          AllowContentTransparency="true" TranslateTitle="true" AutoReload="true" runat="server" Width="650" Height="500" />

    <dw:Dialog runat="server" ID="permissionEditDialog" Width="316" Title="Edit permissions" ShowClose="true" HidePadding="true">
	    <iframe id="permissionEditDialogIFrame" style="width:300px; height: 510px;"></iframe>
	</dw:Dialog>

    <dw:Dialog ID="RenameFolderDialog" Width="345" runat="server" Title="Rename folder" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="dialog.hide('RenameFolderDialog');" OkAction="renameFolder();">
		<table cellpadding="1" cellspacing="1">
			<tr>
				<td colspan="2">
                    <strong><dw:TranslateLabel  ID="TranslateLabel4" runat="server" Text="WARNING!" /></strong>
                </td>
            </tr>
			<tr>
				<td colspan="2">
                    <dw:TranslateLabel  ID="TranslateLabel3" runat="server" Text="References to files in the folder will not be updated!" />
                </td>
            </tr>
			<tr><td colspan="2">&nbsp;</td></tr>
            <tr>
				<td width="90" valign="top">
					<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Name of folder" />
				</td>
				<td>
					<input type="text" id="RenamedFolder" name="RenamedFolder" size="30" class="NewUIinput" runat="server" style="width: 220px; margin-bottom:1px;" />
				</td>
            </tr>
		</table>
	</dw:Dialog>

    <dw:Dialog ID="RenameFileDialog" Width="345" runat="server" Title="Rename file" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="dialog.hide('RenameFileDialog');" OkAction="renameFile();">
		<table cellpadding="1" cellspacing="1">
			<tr>
				<td width="90" valign="top">
					<dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Name of file" />
				</td>
				<td>
					<input type="text" id="RenamedFile" name="RenamedFile" size="30" class="NewUIinput" runat="server" style="width: 220px; margin-bottom:1px;" />
				</td>
            </tr>
		</table>
	</dw:Dialog>

    <dw:Dialog ID="NewFileDialog" Width="345" runat="server" Title="Create new file" ShowOkButton="true" OkOnEnter="true" ShowCancelButton="true" ShowClose="false" CancelAction="dialog.hide('NewFileDialog');" OkAction="createNewFile();">
		<table cellpadding="1" cellspacing="1">
			<tr>
				<td width="90" valign="top">
					<dw:TranslateLabel ID="NewFileDialogLabel" runat="server" Text="Name of file" />
				</td>
				<td>
					<input type="text" id="NewFileName" name="NewFileName" size="30" class="NewUIinput" runat="server" style="width: 220px; margin-bottom:1px;" />
				</td>
            </tr>
		</table>
	</dw:Dialog>

    <dw:Dialog ID="NewFolderDialog" Width="345" runat="server" Title="Create new folder" ShowOkButton="true" OkOnEnter="true" ShowCancelButton="true" ShowClose="false" CancelAction="dialog.hide('NewFolderDialog');" OkAction="createNewFolder();">
		<table cellpadding="1" cellspacing="1">
			<tr>
				<td width="90" valign="top">
					<dw:TranslateLabel ID="NewFolderNameLabel" runat="server" Text="Name of folder" />
				</td>
				<td>
					<input  type="text" id="NewFolderName" name="NewFolderName" size="30" class="NewUIinput" runat="server" style="width: 220px; margin-bottom:1px;" />
				</td>
            </tr>
		</table>
	</dw:Dialog>

        <span id="Message_FileWarning_1" style="display: none"><dw:TranslateLabel id="lbFileWarning1" Text="Warning! The file '%%' containing ',' character. You can't move or rename such files through the file manager. This file will be renamed." runat="server"/></span>
	    <span id="Message_FileWarning_2" style="display: none"><dw:TranslateLabel id="lbFileWarning2" Text="Warning! The file '%%' containing ';' character. You can't move or rename such files through the file manager. This file will be renamed." runat="server"/></span>
        <span id="Message_FileWarning_3" style="display: none"><dw:TranslateLabel id="lbFileWarning3" Text="Warning! The file '%%' containing '+' character. This file will be renamed." runat="server"/></span>
        <span id="Message_FileWarning_4" style="display: none"><dw:TranslateLabel id="lbFileWarning4" Text="Warning! The option {Replace spaces with '-'} set 'on'.The '%%' file will be renamed." runat="server"/></span>
        <span id="Message_FileWarning_5" style="display: none"><dw:TranslateLabel id="lbFileWarning5" Text="Warning! The option {Normalize latin characters} set 'on'.The '%%' file will be renamed." runat="server"/></span>
        <span id="Message_FileWarning_6" style="display: none"><dw:TranslateLabel id="lbFileWarning6" Text="Warning! The file '%%' can not contain any of these characters / \ * ? : | &Prime; &lt; &gt;. This file will be renamed." runat="server"/></span>
        <span id="Message_FileWarning_7" style="display: none"><dw:TranslateLabel id="lbFileWarning7" Text="Warning! The file '%%' containing ' character. This file will be renamed." runat="server"/></span>
        <span id="Message_FileWarning_8" style="display: none"><dw:TranslateLabel id="lbFileWarning8" Text="Warning! The file '%%' containing '#' character. This file will be renamed." runat="server"/></span>

        <input type="hidden" id="replaceSpace" value="<%=Base.IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/Upload/ReplaceSpace").ToLower() = "true", "true", String.Empty) %>" />
        <input type="hidden" id="replaceSpecial" value="<%=Base.IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/Upload/LatinNormalize").ToLower() = "true", "true", String.Empty) %>" />
</body>
<dw:PopUpWindow ID="pwDialog" ContentUrl="" AutoReload="true" ShowClose="true" ShowCancelButton="false" ShowOkButton="False" runat="server"
    Width="360" Height="80" TranslateTitle="true" UseTabularLayout="true" HidePadding="true" SnapToScreen="true" IsModal="true" />

<dw:PopUpWindow ID="FilesWithReferences" ContentUrl="" Title="Warning" UseTabularLayout="true" TranslateTitle="true"
    ShowClose="false" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="false" IsModal="true"
    ShowHelpButton="false" SnapToScreen="false" Width="500" AutoCenterProgress="true" Height="300" runat="server" />

<%  Translate.GetEditOnlineScript()%>
</html>
