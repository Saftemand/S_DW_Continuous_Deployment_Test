var GroupFiltersEdit = function () {
    /// <summary>Represents a group filter edit controller.</summary>

    this._initialized = false;
    this._visibility = null;
    this._visibilityRemove = null;
}

GroupFiltersEdit.get_current = function () {
    /// <summary>Returns the current instance of the group filter edit controller.</summary>

    if (!window._groupFiltersEdit) {
        window._groupFiltersEdit = new GroupFiltersEdit();
    }

    return window._groupFiltersEdit;
}

GroupFiltersEdit.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>

    var self = this;
    var popUp = null;

    if (!this._initialized) {
        this._visibility = $('stateVisibility');
        this._visibilityRemove = $('stateVisibilityRemove');

        $$('select.filter-visibility').each(function (dropDown) {
            Event.observe(dropDown, 'change', function (e) {
                var elm = Event.element(e);
                var row = $(elm).up('.listRow');
                var config = self.unidentify(elm.id.replace('v', ''));
                var visibility = elm.options[elm.selectedIndex].value;

                if (self.setVisibility(config, visibility)) {
                    row.addClassName('selected');
                } else {
                    row.removeClassName('selected');
                }
            });
        });

        if (parent && parent.Dynamicweb) {
            popUp = parent.Dynamicweb.Controls.PopUpWindow.current(window);
            if (popUp != null) {
                popUp.add_ok(function (sender, args) {
                    sender.get_okButton().disabled = true;
                    sender.get_operationIndicator().show();

                    args.set_cancel(true);

                    document.getElementById('cmdSubmit').click();
                });
            }
        }

        this._initialized = true;
    }
}

GroupFiltersEdit.prototype.setVisibility = function (config, visibility) {
    /// <summary>Assigns new visibility configuration to the original visibility configuration.</summary>
    /// <param name="config">Default visibility configuration.</param>
    /// <param name="visibility">New visibility.</param>

    var id = '';
    var value = '';
    var found = false;
    var newValues = [];
    var components = [];
    var markRemoved = false;
    var existingItem = null;
    var values = this._visibility.value.split(',');

    if (!values) {
        values = [];
    }

    if (config) {
        visibility = parseInt(visibility) || 0;
        id = this.identify(config.settingID, config.definitionID, config.visibility);

        if (config.visibility == visibility) {
            markRemoved = true;

            for (var i = 0; i < values.length; i++) {
                if (values[i] && values[i].length) {
                    if (values[i].indexOf(id + ':') < 0) {
                        newValues[newValues.length] = values[i];
                    }
                }
            }
        } else {
            for (var i = 0; i < values.length; i++) {
                if (values[i] && values[i].length) {
                    components = values[i].split(':');
                    if (components && components.length > 1) {
                        existingItem = this.unidentify(components[0]);
                        if (existingItem.settingID != config.settingID || existingItem.definitionID != config.definitionID) {
                            newValues[newValues.length] = components[0] + ':' + components[1];
                        }
                    }
                }
            }
        }

        if (!markRemoved && !found) {
            newValues[newValues.length] = id + ':' + visibility;
        }

        this.markVisibilityRemoved(config, markRemoved);

        for (var i = 0; i < newValues.length; i++) {
            value += newValues[i];
            if (i < (newValues.length - 1)) {
                value += ',';
            }
        }

        this._visibility.value = value;
    }

    return !markRemoved;
}

GroupFiltersEdit.prototype.markVisibilityRemoved = function (config, isRemoved) {
    /// <summary>Marks the given visibility as to be removed from the page state.</summary>
    /// <param name="config">Visibility configuration.</param>
    /// <param name="isRemoved">Value indicating whether visibility must be removed from the page state.</param>

    var id = '';
    var value = '';
    var values = [];
    var found = false;
    var newValues = [];

    if (config && config.definitionID) {
        id = this.identify(config.settingID, config.definitionID, config.visibility);

        values = this._visibilityRemove.value.split(',');
        if (values) {
            for (var i = 0; i < values.length; i++) {
                if (values[i] && values[i].length) {
                    if (values[i] == id) {
                        found = true;

                        if (isRemoved) {
                            newValues[newValues.length] = values[i];
                        }
                    } else {
                        newValues[newValues.length] = values[i];
                    }
                }
            }
        }

        if (isRemoved && !found) {
            newValues[newValues.length] = id;
        }

        for (var i = 0; i < newValues.length; i++) {
            value += newValues[i];
            if (i < (newValues.length - 1)) {
                value += ',';
            }
        }

        this._visibilityRemove.value = value;
    }
}

GroupFiltersEdit.prototype.identify = function (settingID, definitionID, visibility) {
    /// <summary>Makes a unique identity for the given group filter setting.</summary>
    /// <param name="settingID">Group filter setting ID.</param>
    /// <param name="definitionID">Filter definition ID.</param>
    /// <param name="visibility">Visibility mode.</param>
    /// <returns>Unique identity.</returns>
    
    settingID = parseInt(settingID) || -1;
    definitionID = parseInt(definitionID) || -1;
    visibility = parseInt(visibility) || 0;

    return settingID + '_' + definitionID + '_' + visibility;
}

GroupFiltersEdit.prototype.unidentify = function (input) {
    /// <summary>Decomposes unique identity and returns its components.</summary>
    /// <param name="input">String representation of the unique identity.</param>
    /// <returns>Object representing identity components.</returns>
    
    var components = [];
    var ret = { settingID: -1, definitionID: -1, visibility: 0 };

    if (input && typeof (input) == 'string') {
        components = input.split('_');
        if (components && components.length > 0) {
            ret.settingID = parseInt(components[0]) || -1;
            if (components.length > 1) {
                ret.definitionID = parseInt(components[1]) || -1;
                if (components.length > 2) {
                    ret.visibility = parseInt(components[2]) || 0;
                }
            }
        }
    }

    return ret;
}

