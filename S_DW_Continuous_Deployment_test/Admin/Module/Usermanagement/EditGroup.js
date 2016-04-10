var __form_posting = false;
var confirmationMsgSelect = "";
var confirmationMsgUnSelect = "";

function request(params, callback) {
    if (!params) {
        return;
    }

    var over = new overlay('UpdatingOverlay');

    params.ID = $('GroupID').value;
    params.ParentID = $('ParentGroupID').value;
    params.IsAjax = true;

    new Ajax.Request('/Admin/module/UserManagement/EditGroup.aspx?', {
        method: 'post',
        parameters: params,
        onCreate: function () {
            over.show();
        },
        onSuccess: function(response) {
            if (callback) {
                callback(response.responseText);
            }
        },
        onFailure: function () { },
        onComplete: function () {
            setTimeout(function() {
                over.hide();
            }, 500);
        }
    });
}

/* Fires when user clicks 'Save' button */
function save(onSaved, suppresItemValidation) {
    if (buttonIsEnabled('cmdSave')) {
        Dynamicweb.UserManagement.ItemEditors.validateItemFields(suppresItemValidation, function (result) {
            if (result.isValid) {
                toggleToolsGroup(false);

                /* posting a form using AJAX */
                __form_posting = true;

                // Fire event to handle saving
                window.document.fire("General:DocumentOnSave");
                prepareRichEditors();
                var form = $('EditGroupForm');
                (form.onsubmit || function () { })(); // Force richeditors saving

                form.request({
                    parameters: { cmd: 'save' },
                    onComplete: function (response) {
                        var prevGroupId = $('GroupID').value;
                        var parentID = parseInt($('ParentGroupID').value);
                        var isRootGroup = (($('IsRootGroup').value + '').toLowerCase() == 'true');
                        var groupID = parseInt(response.responseText);
                        var parentOfParent = null;
                        var tree = parent.GroupTree.getTree();
                        var sf = function () {
                            prevGroupId = prevGroupId || "0";
                            if (prevGroupId == 0) {
                                var refreshUrl = window.location.href;
                                var idx = refreshUrl.lastIndexOf("#");
                                if (idx > -1) {
                                    refreshUrl = refreshUrl.substring(0, idx);
                                }
                                refreshUrl += (refreshUrl.indexOf("?") > -1 ? "&" : "?") + "ID=" + groupID;
                                console.log(refreshUrl);
                                window.location.href = refreshUrl;
                            }

                            savingFinished(groupID, onSaved);
                        }

                        __form_posting = false;

                        /* Updating group ID */
                        $('GroupID').value = groupID;

                        if (isRootGroup)
                            parentID = 0;

                        /* is this a root group? */
                        if (parentID == 0) {
                            if (tree) {
                                tree.loadedNodes = [];
                            }

                            parent.GroupTree.reloadGroups(0, function () {
                                sf();
                            });
                        } else {
                            /* Is this a first sub group? */
                            if (parent.GroupTree.getNodesByParentGroupID(parentID).length == 0) {
                                parentOfParent = parent.GroupTree.getNodeByGroupID(parentID);

                                /* Reloading parent level, then group level */
                                if (parentOfParent) {
                                    parent.GroupTree.reloadGroups(parentOfParent.pid, function () {
                                        parent.GroupTree.reloadGroups(parentID, function () {
                                            sf();
                                        });
                                    });
                                }
                            } else {
                                /* Reloading level and selecting group */
                                parent.GroupTree.reloadGroups(parentID, function () {
                                    sf();
                                });
                            }
                        }
                    }
                });
            }
        });
    }    
}

function prepareRichEditors() {
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

/* Fires when saving is finished */
function savingFinished(groupID, onSaved) {
    parent.GroupTree.selectGroup(groupID);
    toggleToolsGroup(true);
    
    $('GroupID').value = groupID;
    
    if(typeof(onSaved) == 'function')
        onSaved(groupID);
}

/* Fires when user clicks 'Save and close' button */
function saveAndClose() {
    if(buttonIsEnabled('cmdSaveAndClose')) {
        save(function(groupID) {
            closeForm(groupID)    
        });
    }    
}

/* Fires when user clicks 'Close' button */
function closeForm(groupID) {
    var n = null;
    var id = groupID;
    var tree = parent.GroupTree.getTree();
    var nodeID = -1;
    
    if(buttonIsEnabled('cmdClose')) {
        if(!groupID)
            id = parseInt($('GroupID').value);
        
        /* User has canceled a creating of new group - selecting the first group in the tree */
        if(id <= 0 && tree && tree.aNodes.length > 1) {
            id = tree.aNodes[1].id;
        }
        
        /* User can collapse the node while editing - trying to expand */
        nodeID = parent.GroupTree.getNodeIDByGroupID(id);
        if (nodeID > 0) {
            n = parent.GroupTree.getTree().getNodeByID(nodeID);
            if (n && n._hc) {
                try {
                    if (!tree.ajax_nodesLoaded(nodeID)) {
                        tree.ajax_loadNodes(nodeID);
                    } else {
                        tree.openTo(nodeID);
                    }
                } catch (ex) { }
            }
        }
        
        parent.GroupTree.click(id);    
    }    
}

/* Fired when "Name" field value has been changed */
function groupNameChanged(field) {
    if (!__form_posting) {
        if (field) {
            toggleToolsGroup(field.value.length > 0, true);
        }
    }
}

/* Fires when user clicks 'Help' button */
function help() {
    eval($('jsHelp').innerHTML);
}

/* Determines whether specified button is enabled */
function buttonIsEnabled(buttonID) {
    var ret = true;
    
    if(typeof(Ribbon) != 'undefined') {
        ret = Ribbon.buttonIsEnabled(buttonID);
    }
    
    return ret;
}

/* Toggles 'Enabled' state of all buttons in 'Tools' group */
function toggleToolsGroup(enable, onlySaveActions) {
    var buttons = ['cmdSave', 'cmdSaveAndClose', 'cmdClose', 'cmdSave2', 'cmdSaveAndClose2', 'cmdClose2'];
    
    if(typeof(Ribbon) != 'undefined') {
        for (var i = 0; i < buttons.length; i++) {
            if (!onlySaveActions || (buttons[i] != 'cmdClose' && buttons[i] != 'cmdClose2')) {
                if(enable)
                    Ribbon.enableButton(buttons[i]);
                else
                    Ribbon.disableButton(buttons[i]);
            }
        }
    }
}

/* Editor configuration */
function popupEditorConfiguration() {
    // Set selected value
    // Have to do this everytime the dialog opens, because the user might have opened it before and hit cancel.
    var dropdown = $('ConfigurationSelector');
    var hidden = $('ConfigurationSelectorValue');
    for (i = 0; i < dropdown.length; i++)
        if (dropdown[i].value == hidden.value) {
        dropdown.selectedIndex = i;
        break;
    }

    // Show dialog
    dialog.show("EditorConfigurationDialog");
}

function setEditorConfiguration() {
    $('ConfigurationSelectorValue').value = $('ConfigurationSelector').value;
    dialog.hide('EditorConfigurationDialog');
}

function popupAllowBackend() {
    var checkbox = $('AllowBackendCheckbox');
    var hidden = $('AllowBackendValue');
    checkbox.checked = hidden.value == 'true' ? true : false;
    dialog.show('AllowBackendDialog');
}

function setAllowBackend() {
    $('AllowBackendValue').value = $('AllowBackendCheckbox').checked ? 'true' : 'false';
    if ($('AllowBackendCheckbox').checked)
        $('AllowBackendLoginButton').addClassName('active');
    else
        $('AllowBackendLoginButton').removeClassName('active');
    dialog.hide('AllowBackendDialog');
}

function SetMainDiv(div) {
    if (div == 'EditGroup') {
        document.getElementById('EditGroupDiv').style.display = '';
        document.getElementById('ViewPermissionsDiv').style.display = 'none';
    }
    else if (div == 'ViewPermissions') {
        document.getElementById('EditGroupDiv').style.display = 'none';
        document.getElementById('ViewPermissionsDiv').style.display = '';
    }
}

// AjaxLoading for permissions
function loadAjaxPermissions() {
    // Load module permissions
    new Ajax.Updater('ModulePermissionDiv', 'AjaxLoadPermission.aspx?GroupOrUser=Group&ID=' + id + '&time=' + new Date().getTime(), {
        asynchronous: true,
        evalScripts: true,
        method: 'get',

        onLoading: function(request) { },
        onFailure: function(request) {
            document.getElementById('ModulePermissionDiv').innerHtml = '<%=Backend.Translate.JsTranslate("Error loading permissions") %>';
        },
        onComplete: function(request) { },
        onSuccess: function(request) {
            document.getElementById('ModulePermissionDiv').innerHtml = request.responseText;
        },
        onException: function(request) { }
    });
    
}

function popupStartPageDialog() {
    $('StartPage').value = $('StartPageValue').value;
    dialog.show('StartPageDialog');
}

function saveStartPageDialog() {
    $('StartPageValue').value = $('StartPage').value;
    dialog.hide('StartPageDialog');
}

function popupCommPermissions(show) {
    if (show) {
        dialog.show('CommPermissionsDialog');
    } else {
        dialog.hide('CommPermissionsDialog');
    }
}

function updateCommPermissions() {
    updateCommunicationEmail(function () {
        popupCommPermissions(false);
    });
}

function revertCommPermissions() {
    revertCommunicationEmail(function () {
        popupCommPermissions(false);
    });
}

function updateCommunicationEmail(callback) {
    if (checkCommunicationEmail()) {
        request({ AjaxAction: 'ApplyCommunicationEmail', CommunicationEmailValue: $('CommunicationEmail').checked }, function() {
            $('CommunicationEmailValue').value = $('CommunicationEmail').checked;

            if (callback) {
                callback();
            }
        });
    } else {
        callback();
    }
}

function revertCommunicationEmail(callback) {
    var input = $('CommunicationEmail'),
    hidden = $('CommunicationEmailValue');
    
    input.checked = hidden.value === 'true';

    if (callback) {
        callback();
    }
}

function checkCommunicationEmail() {
    var result = false, msg,
    input = $('CommunicationEmail'),
    hidden = $('CommunicationEmailValue');

    // if it's empty, we didn't change anything
    if (input.checked.toString() === hidden.value) {
        return result;
    }

    msg = input.checked ? confirmationMsgSelect : confirmationMsgUnSelect;
    result = confirm(msg);

    if (!result) {
        revertCommunicationEmail();
    }

    return result;
}

function validateEmails(onComplete) {
    //ValidationEmailsList_wnd.add_hide(OnCloseValidationEmailPopUp);
    //ValidationEmailsList_wnd.show();
    //ValidationEmailsList_wnd.showList();
    var self = this;
    var callback = onComplete || function () { }

    this._isBusy = true;

    Dynamicweb.Ajax.doPostBack({
        eventTarget: "<%=UniqueID%>",
        eventArgument: 'Discover:',
        onComplete: function (transport) {
            self._isBusy = false;
            ValidationEmailPopUp_wnd.add_hide(OnCloseValidationEmailPopUp);
            ValidationEmailPopUp_wnd.set_contentUrl('/Admin/Module/OMC/Emails/ValidateEmail.aspx?UserGroupEditMode=True');
            ValidationEmailPopUp_wnd.show();
        }
    });
 }

function OnCloseValidationEmailPopUp(sender, args) {
    validationPopUpClose();
}

function validationPopUpClose() {
    var url = '/Admin/Module/Usermanagement/EditGroup.aspx';
    var groupId = $('GroupID').value;
    var groupParentId = $('ParentGroupID').value;
    new Ajax.Request(url,
    {
        method: 'get',
        parameters: {
            ID: groupId,
            ParentID: groupParentId,
            OnPopUpClose: true
        }
    });
}

//Impersonation functionality
var ImpersonationContext = function (id, parentID) {
    this.ID = id;
    this.parentID = parentID;
}

ImpersonationContext.prototype.saveImpersonationDialog = function () {
    document.getElementById('EditGroupForm').action = 'EditGroup.aspx?ID=' + this.ID + '&ParentID=' + this.parentID + '&SaveImpersonationDialog=true';
    document.getElementById('EditGroupForm').submit();
    dialog.hide('ImpersonationDialog');
}

function handleUserSelectorTableVisibility(sender) {
    if (sender.value == "0") {
        $('UserSelectorTable').show();
        $('UsersProviderChangedWarning').hide();
    } else {
        $('UsersProviderChangedWarning').show();
        $('UserSelectorTable').hide();
    }
}

function changeItemType() {
    var ge = Dynamicweb.UserManagement.Group.Editors.current();
    ge.saveChanges();
}

function closeChangeItemTypeDialog() {
    var ge = Dynamicweb.UserManagement.Group.Editors.current();
    ge.cancelChanges();
}

(function (ns) {
    var editor = {
        init: function (opts) {
            this.options = opts;
            this.options.ids = this.options.ids || {
                dialog: "ItemTypeDialog",
                form: "EditGroupForm",
                waitOverlay: "UpdatingOverlay",
                itemType: "ItemTypeSelect",
                defaultUserItemType: "ItemTypeUserDefaultSelect",
            };
        },

        _showWait: function () {
            new overlay(this.options.ids.waitOverlay).show();
        },
        
        _hideWait: function () {
            new overlay(this.options.ids.waitOverlay).hide();
        },

        currentItemType: function() {
            return RichSelect.getSelectedValue(this.options.ids.itemType);
        },

        currentDefaultUserItemType: function () {
            return RichSelect.getSelectedValue(this.options.ids.defaultUserItemType);
        },
    
        saveChanges: function () {
            var systemName = this.currentItemType();

            if (this.options.data.itemType != systemName) {
                if (this.options.data.itemType && !confirm(this.options.titles.changeItemConfirm)) {
                    return;
                }
            }
            window.dialog.hide(this.options.ids.dialog);
            if (this.options.data.itemType != systemName) {
                var fn = $('GroupID').value != 0 ? function () {
                    window.location.reload(true);
                } : null;
                window.save(fn, true);
            }
        },

        cancelChanges: function () {
            var fnSetDefaultForRichSelect = function (richSelectName, defaultVal) {
                var rsId = richSelectName + (defaultVal ? defaultVal : "dwrichselectitem");
                var rsEl = $(rsId);
                if (rsEl) {
                    RichSelect.setselected(rsEl.down("a"), richSelectName);
                }
            };

            fnSetDefaultForRichSelect(this.options.ids.itemType, this.options.data.itemType);
            fnSetDefaultForRichSelect(this.options.ids.defaultUserItemType, this.options.data.defaultUserItemType);
            window.dialog.hide(this.options.ids.dialog);
        }
    };

    ns.createEditor = function (opts) {
        editor.init(opts);
        return editor;
    };

    ns.current = function (newEditor) {
        if (!Dynamicweb.Utilities.TypeHelper.isUndefined(newEditor)) {
            ns._editor = newEditor;
        }
        return ns._editor;
    };
})(Dynamicweb.Utilities.defineNamespace("Dynamicweb.UserManagement.Group.Editors"));