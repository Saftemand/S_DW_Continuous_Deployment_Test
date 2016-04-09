/* ++++++ Registering namespace ++++++ */

if (typeof (OMC) == 'undefined') {
    var OMC = new Object();
}

/* ++++++ End: Registering namespace ++++++ */

OMC.EditProfile = function () {
    /// <summary>Represents a profile edit page.</summary>

    this._terminology = {};
    this._initialized = false;
    this._expression = null;
}

OMC.EditProfile.prototype.get_terminology = function () {
    /// <summary>Gets the terminology object that holds all localized strings.</summary>

    if (!this._terminology) {
        this._terminology = {};
    }

    return this._terminology;
}

OMC.EditProfile.prototype.get_expression = function () {
    /// <summary>Gets the reference to expression editor control.</summary>

    var obj = null;
    var ret = this._expression;

    if (ret) {
        if (typeof (ret) == 'string') {
            try {
                obj = eval(ret);
            } catch (ex) { }

            if (obj) {
                ret = obj;
                this._expression = obj;
            }
        }
    }

    return ret;
}

OMC.EditProfile.prototype.set_expression = function (value) {
    /// <summary>Sets the reference to expression editor control.</summary>
    /// <param name="value">The reference to expression editor control.</param>

    this._expression = value;
}

OMC.EditProfile.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>

    var name = null;
    var self = this;
    var binder = null;

    if (!this._initialized) {
        binder = new Dynamicweb.UIBinder(this.get_expression());

        binder.bindMethod('onSelectionChanged', [{ elements: [], action: function (sender, args) {
            self.safeCall(function () {
                var buttons = parent.Ribbon;
                var hasCombinationComponentsSelected = false;
                var selection = args.parameters[0] ? args.parameters[0].selection : null;

                var canGroup = function () {
                    var result = false;
                    var combination = null;
                    var combinationIDs = [];
                    var hasRootCombination = false;
                    var combinationsInvolved = new Hash();

                    for (var i = 0; i < selection.length; i++) {
                        combination = self.get_expression().get_tree().owningCombination(selection[i].node.get_id());
                        if (combination) {
                            combinationsInvolved.set(combination.get_id(), combination);
                        } else {
                            hasRootCombination = true;
                        }
                    }

                    combinationIDs = combinationsInvolved.keys();

                    if (combinationIDs.length <= 1) {
                        if (combinationIDs.length == 0) {
                            result = true;
                        } else if (!hasRootCombination) {
                            if (combinationsInvolved.get(combinationIDs[0]).get_components().length == selection.length) {
                                result = true;
                            } else {
                                result = self.get_expression().get_tree().combinationDepth(combinationIDs[0]) <= 3;
                            }
                        }
                    }

                    return result;
                }

                if (selection && selection.length) {
                    buttons.enableButton('cmdRemove_selected');

                    if (selection.length > 1 && canGroup()) {
                        buttons.enableButton('cmdAll_must_apply');
                        buttons.enableButton('cmdAny_must_apply');
                    } else {
                        buttons.disableButton('cmdAll_must_apply');
                        buttons.disableButton('cmdAny_must_apply');
                    }

                    for (var i = 0; i < selection.length; i++) {
                        if (self.get_expression().get_tree().owningCombination(selection[i].node.get_id())) {
                            hasCombinationComponentsSelected += true;
                            break;
                        }
                    }

                    if (hasCombinationComponentsSelected) {
                        buttons.enableButton('cmdUngroup');
                    } else {
                        buttons.disableButton('cmdUngroup');
                    }
                } else {
                    buttons.disableButton('cmdRemove_selected');
                    buttons.disableButton('cmdAll_must_apply');
                    buttons.disableButton('cmdAny_must_apply');
                    buttons.disableButton('cmdUngroup');
                }
            });
        }
        }]);

        parent.OMC.MasterPage.get_current().add_ready(function (sender, args) {
            self.safeCall(function () {
                var buttons = parent.Ribbon;

                buttons.disableButton('cmdRemove_selected');
                buttons.disableButton('cmdAll_must_apply');
                buttons.disableButton('cmdAny_must_apply');
                buttons.disableButton('cmdUngroup');
            });
        });

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
}

OMC.EditProfile.prototype.removeSelected = function () {
    /// <summary>Removes the currently selected nodes from the tree.</summary>

    var ids = [];
    var selection = [];

    if (this.get_expression()) {
        selection = this.get_expression().get_tree().selection();

        if (selection && selection.length) {
            for (var i = 0; i < selection.length; i++) {
                ids[ids.length] = selection[i].node.get_id();
            }

            this.get_expression().get_tree().removeRange(ids);
        }
    }
}

OMC.EditProfile.prototype.groupSelected = function (operator) {
    /// <summary>Groups the currently selected nodes with the specified combine operator.</summary>
    /// <param name="operator">Combine operator.</param>

    var ids = [];
    var selection = [];

    if (this.get_expression()) {
        selection = this.get_expression().get_tree().selection();

        for (var i = 0; i < selection.length; i++) {
            ids[ids.length] = selection[i].node.get_id();
        }

        operator = parseInt(operator);

        if (operator == null || isNaN(operator) || operator < 0) {
            operator = 2; /* AND */
        }

        operator = Dynamicweb.Controls.OMC.RecognitionExpressionEditor.CombineMethod.parse(operator);

        this.get_expression().get_tree().combine(ids, operator);
        this.get_expression().clearSelection();
    }
}

OMC.EditProfile.prototype.ungroupSelected = function () {
    /// <summary>Removes the grouping from the currently selected nodes.</summary>

    this.groupSelected(0);
}

OMC.EditProfile.prototype.validate = function (onComplete) {
    /// <summary>Validates the form.</summary>
    /// <param name="onComplete">Callback that is executed when the form is validated.</param>

    var url = '';
    var name = null;
    var self = this;
    var callback = onComplete || function () { }

    name = $$('input.field-name')[0];

    if (!name.value) {
        alert(this.get_terminology()['EmptyName']);

        try {
            name.focus();
        } catch (ex) { }

        callback(false);
    } else if (parent.OMC.MasterPage.get_current().containsInvalidNameCharacters(name.value)) {
        alert(this.get_terminology()['InvalidNameCharacters'].replace('%%', '\'' + parent.OMC.MasterPage.get_current().get_invalidNameCharacters().join(' ') + '\''));

        try {
            name.focus();
            name.select();
        } catch (ex) { }

        callback(false);

    // Need possibility to just save a profile with no rule (and maybe just 1 point if 0 is impossible) (TFS#8569)
    //    } else if (!this.get_expression().get_expressionRows().length) {
    //        alert(this.get_terminology()['EmptyExpression']);
    //        callback(false);

    }else if (!this.get_expression().get_totalPoints() && this.get_expression().get_expressionRows().length) {
        alert(this.get_terminology()['EmptyExpressionPoints']);

        callback(false);
    } else {
        url = '/Admin/Module/OMC/Profiles/EditProfile.aspx?CheckExistance=' + encodeURIComponent(name.value) + '&OriginalProfileID=' +
            encodeURIComponent(document.getElementById('OriginalProfileID').value);

        new Ajax.Request(url, {
            method: 'get',
            onComplete: function (transport) {
                var isValid = transport.responseText.toLowerCase() == 'false';

                if (!isValid) {
                    alert(self.get_terminology()['ExistingName']);

                    try {
                        name.focus();
                        name.select();
                    } catch (ex) { }
                }

                callback(isValid);
            }
        });
    }
}

OMC.EditProfile.prototype.save = function (closeWindow) {
    /// <summary>Saves the profile.</summary>
    /// <param name="closeWindow">Value indicating whether to close the form after profile has been saved.</param>

    var self = this;
    var profileName = null;
    var expressionXml = null;
    var originalProfileID = null;
    var profileDescription = null;

    /* First, disabling the "Save" button indicating that the operating is being performed */
    parent.Ribbon.disableButton('cmdSave');

    /* Validating input */
    this.validate(function (isValid) {
        if (isValid) {
            profileName = $$('input.field-name')[0].value;
            expressionXml = self.get_expression().toXml();
            profileDescription = $$('textarea.field-description')[0].value;
            originalProfileID = document.getElementById('OriginalProfileID');

            /* Saving the profily by sending an async request to the server */
            parent.OMC.MasterPage.get_current().executeTask('SaveProfile', { ID: originalProfileID.value, Profile: profileName, Description: profileDescription, Expression: expressionXml }, function (result) {
                var response = null;
                var parentNodeUniqueID = '';
                var waitForNodeUpdated = false;

                /* Opens the dashboard page */
                var openDashboard = function () {
                    parent.OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Dashboard.aspx');
                }

                if (result && result.length) {
                    try {
                        response = result.evalJSON();
                    } catch (ex) { }

                    /* Examining the server response */
                    if (response) {
                        originalProfileID.value = response.id;

                        /* Do we need to update the tree? */
                        if (response.uniqueID != response.originalUniqueID || response.points != response.originalPoints) {
                            /* Getting the unique ID of the parent node ("Profiles") */
                            parentNodeUniqueID = parent.OMC.MasterPage.get_current().get_tree().get_dynamic().reducePath(response.uniqueID);

                            /* Do we need to remove the original profile node? */
                            if (response.originalUniqueID && response.originalUniqueID.length) {
                                parent.OMC.MasterPage.get_current().get_tree().get_dynamic().removeNode(response.originalUniqueID);
                            }

                            /* Reloading tree level ("Profiles") */
                            parent.OMC.MasterPage.get_current().reload(parentNodeUniqueID, {
                                highlight: response.uniqueID,
                                onComplete: function () {
                                    if (closeWindow) {
                                        openDashboard();
                                    }
                                }
                            });

                            /* Indicates that if the user pressed "Save and close" we will wait until the tree is reloaded and only after that - close (otherwise, tree state won't be up-to-date) */
                            waitForNodeUpdated = true;
                        }
                    }
                }

                /* Did the user request to close the window? */
                if (closeWindow) {
                    /* Should we wait until tree is reloaded? */
                    if (!waitForNodeUpdated) {
                        openDashboard();
                    }
                } else {
                    /* Changing the text of a Ribbon button (from "Save" to "Saved") - indicates that changes are committed */
                    parent.Ribbon.set_buttonText('cmdSave', self.get_terminology()['Saved']);

                    /* Changing the text back shortly */
                    setTimeout(function () {
                        parent.Ribbon.set_buttonText('cmdSave', self.get_terminology()['Save']);
                        parent.Ribbon.enableButton('cmdSave');
                    }, 3000);
                }
            });
        } else {
            parent.Ribbon.enableButton('cmdSave');
        }
    });
}

OMC.EditProfile.prototype.saveAndClose = function () {
    /// <summary>Saves the profile and closes the form.</summary>

    this.save(true);
}

OMC.EditProfile.prototype.cancel = function () {
    /// <summary>Discards any changes and closes the form.</summary>

    parent.OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Dashboard.aspx');
}

OMC.EditProfile.prototype.safeCall = function (code) {
    /// <summary>Executes the given code with a fallback in case of the exception - the execution will be postponed.</summary>
    /// <param name="code">Code to execute.</param>
    
    this._safeCallRecursive(code, 10, 1);
}

OMC.EditProfile.prototype._safeCallRecursive = function (code, maxIterations, currentIteration) {
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