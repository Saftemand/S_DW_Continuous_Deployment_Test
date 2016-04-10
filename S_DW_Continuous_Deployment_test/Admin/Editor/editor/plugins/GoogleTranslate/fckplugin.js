/* Represents a GoogleTranslate plug-in */
var GoogleTranslate = new Object();

GoogleTranslate.windowWidth = 750;
GoogleTranslate.windowHeight = 500;

GoogleTranslate.instanceWindow = null;


GoogleTranslate.instantiateInto = function(wnd) {
    GoogleTranslate.instanceWindow = wnd;
}

GoogleTranslate.mainWindowLoaded = function() {
    if (GoogleTranslate.instanceWindow) {
        GoogleTranslate.hideParentElement('PopupTitle');
        GoogleTranslate.hideParentElement('PopupButtons');
        GoogleTranslate.stretchContent();
    }
}

GoogleTranslate.hideParentElement = function(className) {
    var doc = null;

    if (GoogleTranslate.instanceWindow) {
        if (GoogleTranslate.instanceWindow.parent) {
            if (GoogleTranslate.instanceWindow.parent.document) {
                doc = GoogleTranslate.instanceWindow.parent.document;
                elm = GoogleTranslate.getElementsByClassName('td', className, doc.body);

                if (elm.length > 0) {
                    elm[0].style.display = 'none';
                }
            }
        }
    }
}

GoogleTranslate.stretchContent = function() {
    var frame = null;
    var frames = null;
    var selfFrame = null;
    var contentWidth = '100%';
    var contentHeight = GoogleTranslate.windowHeight;



    if (GoogleTranslate.instanceWindow) {
        if (GoogleTranslate.instanceWindow.parent) {
            if (GoogleTranslate.instanceWindow.parent.document) {
                frames = GoogleTranslate.instanceWindow.parent.document.getElementsByTagName('iframe');
                selfFrame = GoogleTranslate.instanceWindow.document.getElementById('frmTranslate');

                if (frames && frames.length > 0) {
                    frame = frames[0];

                    if (!FCKBrowserInfo.IsIE)
                        contentHeight -= 85;

                    frame.style.width = contentWidth;
                    frame.style.height = contentHeight + 'px';

                    selfFrame.style.width = contentWidth;
                    selfFrame.style.height = contentHeight + 'px';
                }
            }
        }
    }
}

GoogleTranslate.contentWindowLoaded = function() {
    var frame = null;
    var progress = null;
    var controller = null;

    if (GoogleTranslate.instanceWindow) {
        if (GoogleTranslate.instanceWindow.document) {
            frame = GoogleTranslate.instanceWindow.document.getElementById('frmTranslate');
            progress = GoogleTranslate.instanceWindow.document.getElementById('divProgress');
            controller = frame.contentWindow.TranslationController.getInstance();

            frame.style.display = '';
            progress.style.display = 'none';

            if (controller) {
                controller.set_textFrom(GoogleTranslate.getData());

                controller.add_apply(function(sender, args) {
                    GoogleTranslate.setData(sender.get_textTo().replace(/\n/gi, '<br />'));
                    GoogleTranslate.close();
                });

                controller.add_cancel(function(sender, args) {
                    GoogleTranslate.close();
                });
            }
        }
    }
}

GoogleTranslate.getElementsByClassName = function(tagName, className, context) {
    var ret = [];
    var rx = null;
    var innerElements = null;
    
    if (context) {
        rx = new RegExp('\\b' + className + '\\b');
        innerElements = context.getElementsByTagName(tagName);

        for (var i = 0; i < innerElements.length; i++) {
            if (rx.test(innerElements[i].className)) {
                ret[ret.length] = innerElements[i];
            }
        }
    }

    return ret;
}

GoogleTranslate.close = function() {
    if (GoogleTranslate.instanceWindow) {
        if (GoogleTranslate.instanceWindow.parent) {
            if (typeof (GoogleTranslate.instanceWindow.parent.Cancel) == 'function') {
                GoogleTranslate.instanceWindow.parent.Cancel();
            }
        }
    }
}

/*
    Description:
        Gets editor HTML.
*/
GoogleTranslate.getData = function() {
    return FCK.GetData();
}

/*
    Description:
        Sets editor HTML.
*/
GoogleTranslate.setData = function(data) {
    FCK.SetData(data);
}

FCKCommands.RegisterCommand('GoogleTranslate', new FCKDialogCommand('GoogleTranslate', FCKLang.GoogleTranslateTitle,
    FCKPlugins.Items['GoogleTranslate'].Path + 'fck_googletranslate.html', GoogleTranslate.windowWidth, GoogleTranslate.windowHeight));


var toobarItem = new FCKToolbarButton('GoogleTranslate', FCKLang.GoogleTranslateCmd);
toobarItem.IconPath = FCKPlugins.Items['GoogleTranslate'].Path + 'googletranslate.gif';

FCKToolbarItems.RegisterItem('GoogleTranslate', toobarItem);