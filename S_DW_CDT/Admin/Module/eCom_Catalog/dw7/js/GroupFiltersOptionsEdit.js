var GroupFiltersOptionsEdit = function () {
    /// <summary>Represents a group filter options edit controller.</summary>

    this._cache = {};
    this._initialized = false;
    this._isDirty = false;
    this._terminology = {};
    this._groupID = '';
    this._languageID = '';
    this._definitionID = '';
    this._grid = null;
    this._currentDefinitionIndex = 0;
}

GroupFiltersOptionsEdit.get_current = function () {
    /// <summary>Returns the current instance of the group filter edit controller.</summary>

    if (!window._groupFiltersOptionsEdit) {
        window._groupFiltersOptionsEdit = new GroupFiltersOptionsEdit();
    }

    return window._groupFiltersOptionsEdit;
}

GroupFiltersOptionsEdit.prototype.get_groupID = function () {
    /// <summary>Gets the ID of the selected group.</summary>

    return this._groupID;
}

GroupFiltersOptionsEdit.prototype.set_groupID = function (value) {
    /// <summary>Sets the ID of the selected group.</summary>
    /// <param name="value">The ID of the selected group.</param>

    this._groupID = value;
}

GroupFiltersOptionsEdit.prototype.get_languageID = function () {
    /// <summary>Gets the ID of the selected language.</summary>

    return this._languageID;
}

GroupFiltersOptionsEdit.prototype.set_languageID = function (value) {
    /// <summary>Sets the ID of the selected language.</summary>
    /// <param name="value">The ID of the selected language.</param>

    this._languageID = value;
}

GroupFiltersOptionsEdit.prototype.get_definitionID = function () {
    /// <summary>Gets the ID of the selected definition.</summary>
    
    return this._definitionID;
}

GroupFiltersOptionsEdit.prototype.set_definitionID = function (value) {
    /// <summary>Sets the ID of the selected definition.</summary>
    /// <param name="value">The ID of the selected definition.</param>

    this._definitionID = value;
}

GroupFiltersOptionsEdit.prototype.get_grid = function () {
    /// <summary>Gets the reference to an EditableGrid control representing an options grid.</summary>

    return this._grid;
}

GroupFiltersOptionsEdit.prototype.set_grid = function (value) {
    /// <summary>Sets the reference to an EditableGrid control representing an options grid.</summary>
    /// <param name="value">The reference to an EditableGrid control representing an options grid.</param>

    this._grid = value;
}

GroupFiltersOptionsEdit.prototype.get_isDirty = function () {
    /// <summary>Gets value indicating whether the given set of filter options has been edited by a user.</summary>

    return this._isDirty;
}

GroupFiltersOptionsEdit.prototype.set_isDirty = function (value) {
    /// <summary>Sets value indicating whether the given set of filter options has been edited by a user.</summary>
    /// <param name="value">Value indicating whether the given set of filter options has been edited by a user.</param>

    this._isDirty = !!value;
}

GroupFiltersOptionsEdit.prototype.get_terminology = function () {
    /// <summary>Gets the terminology object.</summary>

    return this._terminology;
}

GroupFiltersOptionsEdit.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>

    var self = this;
    var inputs = [];
    var button = null;
    var deleteLinks = [];
    var undoButton = null;
    var gridScreen = null;
    var mergeModes = null;
    var defaultsScreen = null;
    var filterSelector = null;
    var optionsContainer = null;
    var chkMergeModeContainer = null;

    var fieldValueChanged = function (e) {
        if (typeof (e.keyCode) != 'undefined') {
            if (e.keyCode == 13) {
                Event.stop(e);
            } else {
                self.set_isDirty(true);
            }
        } else {
            self.set_isDirty(true);
        }
    }

    var showOptions = function () {
        gridScreen = $($(document.body).select('.filter-options-grid')[0]);
        defaultsScreen = $(document.body).select('.filter-options-defaults')[0];
        undoButtonContainer = $(document.body).select('.filter-undo-button')[0];
        optionsContainer = $($(document.body).select('.filter-options-container')[0]);

        $('optionsCustomized').value = 'True';

        gridScreen.style.display = 'block';
        undoButtonContainer.style.display = 'block';
        defaultsScreen.style.display = 'none';

        $(chkMergeModeContainer).select('input').each(function (radio) {
            radio.disabled = false;
        });

        $(chkMergeModeContainer).removeClassName('checkbox-field-disabled');

        self._updateLimitOptionsState();
    }

    if (!this._initialized) {
        filterSelector = $(document.body).select('select')[0];
        undoButton = $(document.body).select('.filter-undo-button input')[0];
        chkMergeModeContainer = $(document.body).select('.check-merge-mode')[0];

        this._currentDefinitionIndex = filterSelector.selectedIndex;

        Event.observe(filterSelector, 'change', function (e) {
            var allowContinue = true;
            var elm = Event.element(e);

            if (self.get_isDirty()) {
                allowContinue = confirm(self.get_terminology()['UnsavedChangesConfirm']);
            }

            if (allowContinue) {
                location.href = self._url({ definitionID: elm.options[elm.selectedIndex].value });
            } else {
                elm.selectedIndex = self._currentDefinitionIndex;
            }
        });

        deleteLinks = $(document.body).select('.filter-options-noselect');
        if (deleteLinks && deleteLinks.length) {
            for (var i = 0; i < deleteLinks.length; i++) {
                Event.observe(deleteLinks[i], 'click', function (e) {
                    self.confirmDeleteOption(Event.element(e));
                });
            }
        }

        inputs = $(document.body).select('.filter-options-grid input.std');
        if (inputs && inputs.length) {
            for (var i = 0; i < inputs.length; i++) {
                Event.observe(inputs[i], 'keydown', fieldValueChanged);
                Event.observe(inputs[i], 'paste', fieldValueChanged);

                Event.observe(inputs[i], 'contextmenu', function (e) {
                    Event.stop(e);
                });
            }
        }

        mergeModes = $(chkMergeModeContainer).select('input');
        if (mergeModes && mergeModes.length) {
            for (var i = 0; i < mergeModes.length; i++) {
                Event.observe(mergeModes[i], 'click', function (e) {
                    self._updateLimitOptionsState();
                });

                Event.observe(mergeModes[i], 'keydown', function (e) {
                    Event.stop(e);
                });
            }
        }

        button = $(document.body).select('.button-container input')[0];
        Event.observe(button, 'click', function (e) {
            showOptions();
            Event.stop(e);
        });

        Event.observe(undoButton, 'click', function (e) {
            Event.stop(e);

            if (confirm(self.get_terminology()['RestoreDefaults'])) {
                location.href = self._url({ undo: true });
            }
        });

        if (parent && parent.Dynamicweb) {
            popUp = parent.Dynamicweb.Controls.PopUpWindow.current(window);
            if (popUp != null) {
                popUp.add_ok(function (sender, args) {
                    var editor = GroupFiltersOptionsEdit.get_current();

                    args.set_cancel(true);

                    if (editor.get_definitionID() > 0) {
                        sender.get_okButton().disabled = true;
                        sender.get_operationIndicator().show();

                        editor.save();
                    } else {
                        sender.hide();
                    }
                });
            }
        }

        this._updateLimitOptionsState();

        setTimeout(function () {
            gridScreen = $($(document.body).select('.filter-options-grid')[0]);

            if (gridScreen.style.display != 'none') {
                $('optionsCustomized').value = 'True';
            }
        }, 50);

        this._initialized = true;
    }
}

GroupFiltersOptionsEdit.prototype.confirmDeleteOption = function (link) {
    /// <summary>Display a dialog asking whether use wants to delete the given filter option and deletes it if the user's answer is "Yes".</summary>
    /// <param name="link">Reference to a DOM element representing a link that the user has clicked.</param>

    var row = null;
    var txName = null;
    var optionName = '';
    var msg = this.get_terminology()['DeleteOption'];

    if (link) {
        row = this.get_grid().findContainingRow(link);
        if (row) {
            txName = row.findControl('txLabel');
            if (txName) {
                optionName = txName.value;
                if (!optionName || !optionName.length) {
                    optionName = '[none]';
                }

                msg = msg.replace('%%', optionName).replace(/&quot;/gi, '"');

                if (confirm(msg)) {
                    this.get_grid().deleteRows([row]);
                    this.set_isDirty(true);
                }
            }
        }
    }
}

GroupFiltersOptionsEdit.prototype.save = function () {
    /// <summary>Saves the options.</summary>

    this._setEnablePostbackControls(false);

    document.getElementById('cmdSubmit').click();
}

GroupFiltersOptionsEdit.prototype._setEnablePostbackControls = function (enabled) {
    /// <summary>Changes the "enabled" state of all post-back controls on the form.</summary>
    /// <param name="enabled">Indicates whether to enable controls.</param>
    /// <private />

    var filterSelector = $(document.body).select('select')[0];
    var undoButton = $(document.body).select('.filter-undo-button input')[0];

    filterSelector.disabled = !!!enabled;
    undoButton.disabled = !!!enabled;
}

GroupFiltersOptionsEdit.prototype._updateLimitOptionsState = function () {
    /// <summary>Updates the state of the "Limit options" setting.</summary>
    /// <private />

    var enabled = true;
    var buttons = null;
    var chkLimitOptions = null;
    var chkLimitOptionsContainer = null;

    if (this.get_definitionID() <= 0) {
        enabled = false;
    } else {
        buttons = $(document.body).select('.check-merge-mode input');
        if (buttons && buttons.length) {
            for (var i = 0; i < buttons.length; i++) {
                if (buttons[i].checked && !buttons[i].disabled && $(buttons[i]).hasClassName('merge-mode-none')) {
                    enabled = false;
                    break;
                }
            }
        }
    }

    chkLimitOptionsContainer = $($(document.body).select('.check-limit-options')[0]);
    chkLimitOptions = chkLimitOptionsContainer.select('input')[0];

    if (enabled) {
        enabled = !$(chkLimitOptions).hasClassName('not-supported');
    }

    chkLimitOptions.disabled = !enabled;

    if (enabled) {
        chkLimitOptionsContainer.removeClassName('checkbox-field-disabled');
    } else {
        chkLimitOptionsContainer.addClassName('checkbox-field-disabled');
    }
}

GroupFiltersOptionsEdit.prototype._url = function (params) {
    /// <summary>Returns the URL that corresponds to the current page state.</summary>
    /// <param name="params">Parameters that allows overriding current state.</param>
    /// <private />

    var queryString = [];
    var ret = 'GroupFiltersOptionsEdit.aspx';

    if (!params) {
        params = {};
    }

    if (params.groupID) {
        queryString[queryString.length] = ('GroupID=' + encodeURIComponent(params.groupID));
    } else if (this.get_groupID() && this.get_groupID().length) {
        queryString[queryString.length] = ('GroupID=' + encodeURIComponent(this.get_groupID()));
    }

    if (params.languageID) {
        queryString[queryString.length] = ('LanguageID=' + encodeURIComponent(params.languageID));
    } else if (this.get_languageID() && this.get_languageID().length) {
        queryString[queryString.length] = ('LanguageID=' + encodeURIComponent(this.get_languageID()));
    }

    if (params.definitionID) {
        queryString[queryString.length] = ('DefinitionID=' + encodeURIComponent(params.definitionID));
    } else if (this.get_definitionID() && this.get_definitionID().length) {
        queryString[queryString.length] = ('DefinitionID=' + encodeURIComponent(this.get_definitionID()));
    }

    if (typeof (params.undo) != 'undefined') {
        queryString[queryString.length] = ('Undo=' + ((!!params.undo) ? 'True' : 'False'));
    }

    // To prevent any caching on the client
    queryString[queryString.length] = 't=' + (new Date()).getTime();

    if (queryString.length > 0) {
        ret += '?';
        for (var i = 0; i < queryString.length; i++) {
            ret += queryString[i];
            if (i < (queryString.length - 1)) {
                ret += '&';
            }
        }
    }

    return ret;
}