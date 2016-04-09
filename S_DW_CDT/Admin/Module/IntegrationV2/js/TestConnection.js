var SettingsPage = function (pageContentID) {    
    this.onCancel = null;
    this.pageContentID = pageContentID;
}

SettingsPage.prototype.initialize = function () {
    this.stretchContent();

    if (window.attachEvent) {
        window.attachEvent('onresize', function () { SettingsPage.getInstance().stretchContent(); });
    } else if (window.addEventListener) {
        window.addEventListener('resize', function (e) { SettingsPage.getInstance().stretchContent(); }, false);
    }
}

SettingsPage.prototype.stretchContent = function () {
    var toolbarHeight = 0;
    var content = $(this.pageContentID);

    if (content) {
        toolbarHeight = $('divToolbar').getHeight();
        content.setStyle({ 'height': (document.body.clientHeight - toolbarHeight) + 'px' });
    }
}

SettingsPage.prototype.cancel = function () {
    if (!Toolbar.buttonIsDisabled('cmdCancel')) {
        this._evalCallback(this.onCancel, null);            
    }
}

SettingsPage.prototype.submit = function () {
    document.getElementById('MainForm').submit();
}

SettingsPage.prototype._evalCallback = function (callback, args) {
    var ret = true;

    if (typeof (callback) == 'function') {
        ret = callback(this, args);
    }

    return ret;
}