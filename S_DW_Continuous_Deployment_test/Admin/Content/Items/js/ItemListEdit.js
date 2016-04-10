if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = new Object();
}

Dynamicweb.Items.ItemListEdit = function () {
    this._terminology = {};
    this._validation = null;
    this._validationPopup = null;
    this._editPopup = null;
    this._listId = null;
    this._rowId = null;
    this._isNewRow = false;
}

Dynamicweb.Items.ItemListEdit._instance = null;

Dynamicweb.Items.ItemListEdit.get_current = function () {
    if (!Dynamicweb.Items.ItemListEdit._instance) {
        Dynamicweb.Items.ItemListEdit._instance = new Dynamicweb.Items.ItemListEdit();
    }

    return Dynamicweb.Items.ItemListEdit._instance;
}

Dynamicweb.Items.ItemListEdit.prototype.get_validation = function () {
    if (!this._validation) {
        this._validation = new Dynamicweb.Validation.ValidationManager();
    }

    return this._validation;
}

Dynamicweb.Items.ItemListEdit.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Items.ItemListEdit.prototype.get_validationPopup = function () {
    if (this._validationPopup && typeof (this._validationPopup) == 'string') {
        this._validationPopup = eval(this._validationPopup);
    }

    return this._validationPopup;
}

Dynamicweb.Items.ItemListEdit.prototype.set_validationPopup = function (value) {
    this._validationPopup = value;
}

Dynamicweb.Items.ItemListEdit.prototype.set_listId = function (value) {
    this._listId = value;
}

Dynamicweb.Items.ItemListEdit.prototype.set_rowId = function (value) {
    this._rowId = value;
}

Dynamicweb.Items.ItemListEdit.prototype.set_isNewRow = function (value) {
    this._isNewRow = value;
}

Dynamicweb.Items.ItemListEdit.prototype.get_isNewRow = function () {
    return this._isNewRow;
}

Dynamicweb.Items.ItemListEdit.prototype.initialize = function () {
    var self = this;
    setTimeout(function () {
        if (typeof (Dynamicweb.Controls) != 'undefined' && typeof (Dynamicweb.Controls.OMC) != 'undefined' && typeof (Dynamicweb.Controls.OMC.DateSelector) != 'undefined') {
            Dynamicweb.Controls.OMC.DateSelector.Global.set_offset({ top: -26, left: Prototype.Browser.IE ? 1 : 0}); // Since the content area is fixed to screen at 138px from top (Edititem.css)
        }
    }, 500);
    
    $('MainForm').on("submit", function (evt) {
        self.save(true);
        Event.stop(evt);
    });

    this._editPopup = parent.Dynamicweb.Controls.PopUpWindow.current(window);

    var buttons = $$('.item-edit-field-group-button-collapse');
    for (var i = 0; i < buttons.length; i++) {
        Event.observe(buttons[i], 'click', function (e) {
            var elm = this;
            elm.up().next('.item-edit-field-group-content').toggleClassName('collapsed');
        });
    }
}

Dynamicweb.Items.ItemListEdit.prototype.showValidationResults = function () {
    this.get_validationPopup().set_contentUrl('/Admin/Content/PageValidate.aspx?ID=' + this.get_page().id);
    this.get_validationPopup().show();
}

Dynamicweb.Items.ItemListEdit.prototype.validate = function (onComplete) {
    if (Dynamicweb.Items.GroupVisibilityRule) {
        Dynamicweb.Items.GroupVisibilityRule.get_current().filterValidators(this.get_validation()).beginValidate(onComplete);
    } else {
        this.get_validation().beginValidate(onComplete);
    };
}

Dynamicweb.Items.ItemListEdit.prototype.save = function (close) {
    var self = this;

    this.validate(function (result) {
        if (result.isValid) {
            // Fire event to handle saving
            window.document.fire("General:DocumentOnSave");

            self._editPopup.get_operationIndicator().show();
            self.prepareRichEditors();
            $('hClose').value = (!!close).toString();
            var submit = $('MainForm').onsubmit || function () { }; // Force richeditors saving
            submit(); 

            $('MainForm').request({
                onComplete: function (transport) {
                    var jsonObj = transport.responseText.evalJSON();

                    var list = parent.document.getElementById(self._listId + '_body');
                    if (self.get_isNewRow()) {
                        list.ListItem.addRow(self._rowId, jsonObj); // JSON.parse(json)
                    }
                    else {
                        list.ListItem.editRow(self._rowId, jsonObj);
                    }
                    self.set_isNewRow(false);

                    if (close) self._editPopup.hide();
                },
                onFailure: function () { alert('Something went wrong!'); }
            })
        }
    });
}

Dynamicweb.Items.ItemListEdit.prototype.prepareRichEditors = function () {
    if (typeof (CKEDITOR) != 'undefined') {
        for (var i in CKEDITOR.instances) {
            CKEDITOR.instances[i].updateElement();
        }
    } else if (typeof (FCKeditorAPI) != 'undefined') {
        for (var i in FCKeditorAPI.Instances) {
            FCKeditorAPI.Instances[i].UpdateLinkedField();
        }
    }

}

Dynamicweb.Items.ItemListEdit.prototype.saveAndClose = function () {
    this.save(true);
}

Dynamicweb.Items.ItemListEdit.prototype.cancel = function () {
    if (this._editPopup) {
        this._editPopup.hide();
    }
}
