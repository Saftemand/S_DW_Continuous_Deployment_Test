var DwInsertCode = function () { }

DwInsertCode._focus = {
    node: null,
    offset: 0
}

DwInsertCode.insertCode = function (code, language) {
    var range = null;
    var insert = null;
    var nodeName = '';
    var elm = document.createElement('PRE');
    var outer = document.createElement('DIV');
    var inner = document.createElement('DIV');

    outer.className = 'code-outer';
    inner.className = 'code-inner';

    if (code && language) {
        elm.appendChild(document.createTextNode(code));
        elm.setAttribute('class', 'ruler: true; brush: ' + language);

        inner.appendChild(elm);
        outer.appendChild(inner);

        if (!DwInsertCode._focus || !DwInsertCode._focus.node) {
            FCK.Focus();

            FCKUndo.SaveUndoStep();
            FCK.InsertElement(outer);

            FCK.Events.FireEvent('OnSelectionChange');
        } else {
            setTimeout(function () {
                nodeName = (DwInsertCode._focus.node.tagName || DwInsertCode._focus.node.nodeName).toLowerCase();

                range = new FCKDomRange(FCK.EditingArea.Window);

                if (!range._Range) {
                    range._Range = range.CreateRange();
                }

                if (nodeName == 'body') {
                    range._Range.setStart(DwInsertCode._focus.node, DwInsertCode._focus.offset);
                } else {
                    range._Range.setStartAfter(DwInsertCode.leaveCodeBlock(DwInsertCode._focus.node));
                }

                range.Select();

                range.InsertNode(outer);

                FCK.Events.FireEvent('OnSelectionChange');
            }, 100);
        }
    }
}

DwInsertCode.leaveCodeBlock = function (node) {
    var n = null;
    var ret = node;
    var outerClassName = 'code-outer';
    var classNames = ['code-inner', 'ruler:'];

    var matches = function (name) {
        var result = false;

        if (name && name.length) {
            for (var i = 0; i < classNames.length; i++) {
                if (classNames[i].toLowerCase() == name.toLowerCase() ||
                    name.toLowerCase().indexOf(classNames[i].toLowerCase()) >= 0) {

                    result = true;
                    break;
                }
            }
        }

        return result;
    }

    if (node) {
        n = node.parentNode;

        if (n && matches(n.className)) {
            do {
                n = n.parentNode;

                if (!n || !n.className) {
                    ret = n;
                } else if (n.className.toLowerCase() == outerClassName.toLowerCase()) {
                    ret = n;
                } else if (!matches(n.className)) {
                    break;
                }
            } while (true);
        }
    }

    return ret;
}

FCKCommands.RegisterCommand('DwInsertCode', new FCKDialogCommand('DwInsertCode', FCKLang.DwInsertCodeTitle,
	FCKPlugins.Items['DwInsertCode'].Path + 'fck_DwInsertCode.html', 550, 400));

var item = new FCKToolbarButton('DwInsertCode', FCKLang.DwInsertCodeTitle);
item.IconPath = FCKPlugins.Items['DwInsertCode'].Path + 'DwInsertCode.gif';

FCKToolbarItems.RegisterItem('DwInsertCode', item);

if (FCKBrowserInfo.IsIE) {
    FCK.Events.AttachEvent('OnSelectionChange', function (sender, status) {
        var selection = null;

        // getSelection is supported by IE >= 9 (which is our case)
        if (FCK.EditorWindow.getSelection) {
            selection = FCK.EditorWindow.getSelection();
        }

        if (selection) {
            DwInsertCode._focus.node = selection.focusNode;
            DwInsertCode._focus.offset = selection.focusOffset;
        }
    });
}