var DwPageLink = function() { }

DwPageLink.PluginExistsOnToolbar = function() {
	var items = FCK.ToolbarSet.Items;
	var ret = false;
	
	if(items) {
		for(var i = 0; i < items.length; i++) { 
			if(items[i].CommandName == 'DwPageLink') {
				ret = true;
				break;
			}
		}
	}
	
	return ret;
}

DwPageLink.InsertLink = function(url) {
    if (url && url.length > 0) {
        var link = FCK.Selection.MoveToAncestorNode('A');

        if (url.toLowerCase().indexOf('default.aspx?id=') < 0) {
            if (url.indexOf('/') != 0)
                url = '/' + url;
            if (url.toLowerCase().indexOf('/files/') != 0)
                url = '/Files' + url;
        }

        FCKUndo.SaveUndoStep();

        if (link) {
            FCK.Selection.SelectNode(link);
            link.href = url;
        } else {
            FCK.CreateLink(url, true);
        }

        FCKUndo.SaveUndoStep();
        FCK.Focus();
        FCK.Events.FireEvent('OnSelectionChange');
    }
}

DwPageLink.UpdateButtonState = function() {
	var state = FCK_TRISTATE_DISABLED;
	
	if(FCK.EditorDocument) {
		var selectedText = '';
		try {
		if(FCK.EditorWindow.getSelection)
			selectedText = FCK.EditorWindow.getSelection().toString();
		else if(FCK.EditorDocument.selection)
			selectedText = FCK.EditorDocument.selection.createRange().text + '';
		} catch(ex) { }

		state = selectedText.length > 0 ? FCK_TRISTATE_OFF : FCK_TRISTATE_DISABLED;
	}
	
	return state
}

FCKCommands.RegisterCommand('DwPageLink', new FCKDialogCommand('DwPageLink', FCKLang.DwPageLinkTitle, 
	'/Admin/Editor/EditorLinker.aspx', 350, 160, DwPageLink.UpdateButtonState)); 

var item = new FCKToolbarButton('DwPageLink', FCKLang.DwPageLinkTitle);
item.IconPath = FCKPlugins.Items['DwPageLink'].Path + 'toolbaricon.gif';

FCKToolbarItems.RegisterItem('DwPageLink', item);

FCK.Events.AttachEvent('OnSelectionChange', function() {
	if(DwPageLink.PluginExistsOnToolbar()) {
		var item = FCKToolbarItems.LoadedItems['DwPageLink'];
		if(item) {
		    try {
			    item.RefreshState();
			} catch(ex) { }
	    }
	}
});

