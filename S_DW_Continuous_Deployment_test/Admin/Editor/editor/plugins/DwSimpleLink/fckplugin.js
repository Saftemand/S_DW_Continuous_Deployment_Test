var DwSimpleLink = function () { }

DwSimpleLink.get_isVisible = function () {
    var items = FCK.ToolbarSet.Items;
    var ret = false;

    if (items) {
        for (var i = 0; i < items.length; i++) {
            if (items[i].CommandName == 'DwSimpleLink') {
                ret = true;
                break;
            }
        }
    }

    return ret;
}

DwSimpleLink.get_activeLink = function () {
    var ret = { url: '', newWindow: false };
    var link = FCKSelection.MoveToAncestorNode('A');

    if (link && link.href) {
        ret.url = link.getAttribute('href');
        ret.newWindow = (link.getAttribute('target') == '_blank');
    }

    return ret;
}

DwSimpleLink.UpdateButtonState = function () {
    var link = null;
    var state = FCK_TRISTATE_DISABLED;

    if (FCK.EditorDocument) {
        var selectedText = '';

        if (FCK.EditMode == FCK_EDITMODE_WYSIWYG) {
            link = FCKSelection.MoveToAncestorNode('A');

            if (link && link.href && link.href.length > 0) {
                state = FCK_TRISTATE_OFF;
            } else {
                try {
                    if (FCK.EditorWindow.getSelection)
                        selectedText = FCK.EditorWindow.getSelection().toString();
                    else if (FCK.EditorDocument.selection)
                        selectedText = FCK.EditorDocument.selection.createRange().text + '';
                } catch (ex) { }

                state = selectedText.length > 0 ? FCK_TRISTATE_OFF : FCK_TRISTATE_DISABLED;
            }
        }
    }

    return state
}

DwSimpleLink.editLink = function (url, newWindow) {
    var isRelative = false;
    var link = FCK.Selection.MoveToAncestorNode('A');
    var checkPaths = ['Admin/', 'Files/', 'CustomModules/'];
    
    if (url && url.length > 0) {
        if (url.indexOf('://') < 0) {
            for (var i = 0; i < checkPaths.length; i++) {
                if (url.indexOf(checkPaths[i].toLowerCase()) == 0 ||
                    url.indexOf('/' + checkPaths[i].toLowerCase()) == 0) {

                    isRelative = true;
                    break;
                }
            }

            if (!isRelative) {
                url = 'http://' + url;
            }
        }

        FCKUndo.SaveUndoStep();

        if (link) {
            FCK.Selection.SelectNode(link);

            link.setAttribute('href', url);
        } else {
            link = FCK.CreateLink(url, true);
        }

        if (link && link.length) {
            link = link[0];
        }

        if (link) {
            link.setAttribute('target', (newWindow ? '_blank' : '_self'));
        }

        FCKUndo.SaveUndoStep();

        FCK.Focus();
        FCK.Events.FireEvent('OnSelectionChange');
    }
}

FCKCommands.RegisterCommand('DwSimpleLink', new FCKDialogCommand('DwSimpleLink', FCKLang.DwSimpleLinkTitle,
	FCKPlugins.Items['DwSimpleLink'].Path + 'fck_DwSimpleLink.html', 350, 160, DwSimpleLink.UpdateButtonState));

var item = new FCKToolbarButton('DwSimpleLink', FCKLang.DwSimpleLinkTitle);
item.IconPath = FCKPlugins.Items['DwSimpleLink'].Path + 'DwSimpleLink.gif';

FCKToolbarItems.RegisterItem('DwSimpleLink', item);

FCK.Events.AttachEvent('OnSelectionChange', function () {
    if (DwSimpleLink.get_isVisible()) {
        var item = FCKToolbarItems.LoadedItems['DwSimpleLink'];
        if (item) {
            try {
                item.RefreshState();
            } catch (ex) { }
        }
    }
});