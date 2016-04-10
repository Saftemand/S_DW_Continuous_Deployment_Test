/* ++++++ Registering namespace ++++++ */

if (typeof (OMC) == 'undefined') {
    var OMC = new Object();
}

/* ++++++ End: Registering namespace ++++++ */

OMC.EditTopFolder = function () {
    /// <summary>Represents a profile edit page.</summary>
    this._initialized = false;
    this._terminology = {};
    this._emailFolderId = 0;
}

OMC.EditTopFolder.prototype.get_terminology = function () {
    /// <summary>Gets the terminology object that holds all localized strings.</summary>

    if (!this._terminology) {
        this._terminology = {};
    }

    return this._terminology;
}

OMC.EditTopFolder.prototype.set_emailFolderId = function (value) {
    this._emailFolderId = value;
}

OMC.EditTopFolder.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>
    var name = null;
    var self = this;
    var binder = null;

    if (!this._initialized) {
        setTimeout(function () {
            name = $$('input.field-name')[0];
            if (name) {
                try {
                    name.focus();
                } catch (ex) { }
            }
        }, 200);

        this._initialized = true;
    }

    parent.OMC.MasterPage.get_current().add_ready(function (sender, args) {
        self.safeCall(function () {
        });
    });
}

OMC.EditTopFolder.prototype.validateName = function (onComplete, isValidateVariation) {
    /// <summary>Validates the form.</summary>
    /// <param name="onComplete">Callback that is executed when the form is validated.</param>

    var self = this;
    var callback = onComplete || function () { }

    if ($('txtFolderName') && !$('txtFolderName').value) {
        alert(this.get_terminology()['EmptyName']);

        try {
            $('txtFolderName').focus();
        } catch (ex) { }

        callback(false);
    } else {
        callback(true);
    }
}

OMC.EditTopFolder.prototype.saveAsDraft = function (closeWindow) {
    var self = this;
    parent.Toolbar.setButtonIsDisabled('cmdSave', true);
    /* Validating input */
    this.validateName(function (isValid) {
        if (isValid) {

            /* Show spinning wheel*/
            var o = new overlay('saveForward');
            o.show();

            var form = self._getPostbackForm();
            document.getElementById('CloseOnSave').value = (!!closeWindow).toString();

            if (form) {
                /* Submitting a form to a hidden frame */
                form.target = 'frmPostback';
            }
            document.getElementById('cmdSubmit').click();
        }
        parent.Toolbar.setButtonIsDisabled('cmdSave', false);
    });
}

OMC.EditTopFolder.prototype.saveAndClose = function () {
    /// <summary>Saves the profile and closes the form.</summary>

    this.saveAsDraft(true);
}

OMC.EditTopFolder.prototype.cancel = function () {
    /// <summary>Discards any changes and closes the form.</summary>
    parent.OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Dashboard.aspx');
}

OMC.EditTopFolder.prototype._getPostbackForm = function () {
    /// <summary>Returns a postback form.</summary>

    var ret = null;
    var form = null;
    var forms = document.getElementsByTagName('form');

    if (forms && forms.length) {
        if (forms.length == 1) {
            ret = forms[0];
        } else {
            for (var i = 0; i < forms.length; i++) {
                form = $(forms[i]);

                if (form.readAttribute('action') == 'post' && form.readAttribute('name') == 'aspnetForm') {
                    ret = forms[i];
                    break;
                }
            }
        }
    }

    return ret;
}

OMC.EditTopFolder.prototype.onAfterSave = function (response) {
    /// <summary>Occurs when the postback frame gets loaded.</summary>
    /// <param name="response">Response.</param>

    var self = this;
    var form = this._getPostbackForm();

    if (form) {
        /* Clearing the target, just in case */
        form.target = '';
    }

    var self = parent.OMC.MasterPage.get_current();

    if (response) {
        if (response.Saved == true) {
            var n = self.get_tree().getNodeByItemID(response.ID);

            if (n != null)
                self.get_tree().get_dynamic().removeNode(n);

            if (response.Close == true) {
                if (response.isSMP == true) {
                    self.reloadSMPTopFolders();
                    parent.OMC.MasterPage.get_current().showSMPList(null, response.ID, true);
                } else {
                    self.reloadTopFolders();
                   parent.OMC.MasterPage.get_current().showEmailsList(null, response.ID, true);
                }
            } else {
                if (response.isSMP == true) {
                    self.reloadSMPTopFolders(response.ID);
                } else {
                    self.reloadTopFolders(response.ID);
                }
            }
        }
    }

    /* Changing the text back shortly */
    setTimeout(function () {
        parent.Toolbar.setButtonIsDisabled('cmdSave', false);
    }, 3000);
}

OMC.EditTopFolder.prototype.safeCall = function (code) {
    /// <summary>Executes the given code with a fallback in case of the exception - the execution will be postponed.</summary>
    /// <param name="code">Code to execute.</param>

    this._safeCallRecursive(code, 10, 1);
}

OMC.EditTopFolder.prototype._safeCallRecursive = function (code, maxIterations, currentIteration) {
    /// <summary>Executes the given code with a fallback in case of the exception - the execution will be postponed.</summary>
    /// <param name="code">Code to execute.</param>
    /// <param name="maxIterations">The maximum number of iterations.</param>
    /// <param name="currentIteration">Current iteration number.</param>
    /// <private />

    var self = this;

    if (code) {
        try {
            if (typeof (code) == 'function') {
                code.apply(window);
            } else if (typeof (code) == 'string') {
                eval(code);
            }
        } catch (ex) {
            if (currentIteration < maxIterations) {
                setTimeout(function () {
                    self._safeCallRecursive(code, maxIterations, currentIteration + 1);
                }, 50);
            }
        }
    }
}
