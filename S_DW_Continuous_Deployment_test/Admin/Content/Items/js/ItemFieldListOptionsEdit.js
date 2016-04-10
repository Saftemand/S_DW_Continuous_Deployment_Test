if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = new Object();
}

Dynamicweb.Items.ItemFieldListOptionsEdit = function () {
    this._terminology = {};
    this._initialized = false;
}

Dynamicweb.Items.ItemFieldListOptionsEdit._instance = null;

Dynamicweb.Items.ItemFieldListOptionsEdit.get_current = function () {
    if (!Dynamicweb.Items.ItemFieldListOptionsEdit._instance) {
        Dynamicweb.Items.ItemFieldListOptionsEdit._instance = new Dynamicweb.Items.ItemFieldListOptionsEdit();
    }

    return Dynamicweb.Items.ItemFieldListOptionsEdit._instance;
}

Dynamicweb.Items.ItemFieldListOptionsEdit.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Items.ItemFieldListOptionsEdit.prototype.initialize = function () {
    var w = null;

    if (!this._initialized) {
        if (parent) {
            w = parent.Dynamicweb.Controls.PopUpWindow.current(window);

            if (w) {
                w.add_ok(function (sender, e) {
                    e.set_cancel(true);
                    sender.get_operationIndicator().show();

                    document.getElementById('MainForm').submit();
                });
            }
        }

        this._initialized = true;
    }
}
