var DwSimpleImage = function () { }

DwSimpleImage.get_activeImage = function () {
    var ret = { url: '', width: '', height: '' };
    var image = FCKSelection.GetSelectedElement();

    if (image && (tag = image.tagName || image.nodeName).toLowerCase() == 'img') {
        ret.url = image.getAttribute('src');

        if (image.style) {
            ret.width = image.style.width || '';
            ret.height = image.style.height || '';

            if (ret.width) ret.width = ret.width.replace(/[^0-9]+/gi, '');
            if (ret.height) ret.height = ret.height.replace(/[^0-9]+/gi, '');
        }
    }

    return ret;
}

DwSimpleImage.editImage = function (url, width, height) {
    var isRelative = false;
    var image = FCK.Selection.GetSelectedElement();
    var checkPaths = ['Admin/', 'Files/', 'CustomModules/'];

    if (image) {
        if ((tag = image.tagName || image.nodeName).toLowerCase() != 'img') {
            image = null;
        }
    }

    if (!width) width = '';
    if (!height) height = '';

    width = width.replace(/[^0-9]+/gi, '');
    height = height.replace(/[^0-9]+/gi, '');

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

        if (image) {
            FCK.Selection.SelectNode(image);
        }
        image = document.createElement('IMG');

        if (image && image.length) image = image[0];
        if (image) {
            image.setAttribute('src', url);

            if (width) {
                image.setAttribute('width', width);
            } else {
                image.removeAttribute('width');
            }

            if (height) {
                image.setAttribute('height', height);
            } else {
                image.removeAttribute('height');
            }
        }

        FCK.InsertElement(image);

        FCKUndo.SaveUndoStep();

        FCK.Focus();
        FCK.Events.FireEvent('OnSelectionChange');
    }
}

FCKCommands.RegisterCommand('DwSimpleImage', new FCKDialogCommand('DwSimpleImage', FCKLang.DwSimpleImageTitle,
	FCKPlugins.Items['DwSimpleImage'].Path + 'fck_DwSimpleImage.html', 350, 175));

var item = new FCKToolbarButton('DwSimpleImage', FCKLang.DwSimpleImageTitle);
item.IconPath = FCKPlugins.Items['DwSimpleImage'].Path + 'DwSimpleImage.gif';

FCKToolbarItems.RegisterItem('DwSimpleImage', item);