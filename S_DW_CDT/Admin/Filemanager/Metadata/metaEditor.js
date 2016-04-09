
var metaEditor = {

    save: function (closeAfterSave, validate) {
        
        if (!closeAfterSave && $('Save').hasClassName("toolbarButtonDisabled") || closeAfterSave && $('ToolbarButton1').hasClassName("toolbarButtonDisabled")) {
            return;
        }

        if (validate && !validate()) return;

        $('cmd').value = closeAfterSave ? "saveAndClose" : "save";
        $('form1').submit();
        setTimeout("metaEditor.refresh();", 10);
    },

    close: function () {
        this.refresh();
        window.close();
    },

    refresh: function () {
        var win;
        if (opener.opener)
            win = opener.opener;
        else
            win = opener;

        var src = win.location.href;
        if (src.endsWith('#')) {
            src = src.substr(0, src.length - 1);
        }
        win.location.href = src;
    },

    makeSystemName: function (name) {
        var ret = name;

        if (ret && ret.length) {
            ret = ret.replace(/[^0-9a-zA-Z_\s]/gi, '_'); // Replacing non alphanumeric characters with underscores
            while (ret.indexOf('_') == 0) ret = ret.substr(1); // Removing leading underscores

            ret = ret.replace(/\s+/g, ' '); // Replacing multiple spaces with single ones
            ret = ret.replace(/\s/g, '_'); // Removing spaces
        }

        return ret;
    }
}