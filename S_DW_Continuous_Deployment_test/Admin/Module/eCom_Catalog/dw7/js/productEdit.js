/// <reference path="queryString.js" />
/// <reference path="hotkeys.js" />

Hotkeys.excludeInputsAndTextArea = false;
Hotkeys.bind("ctrl+s", function () {
    $("btnSaveProduct").onclick();
});


var Tabs = {
    tab: function (aciveID) {
        for (var i = 1; i < 16; i++) {
            if ($("Tab" + i)) {
                $("Tab" + i).style.display = "none";
            }
        }
        if ($("Tab" + aciveID)) {
            $("Tab" + aciveID).style.display = "";
        }
    }
}

var _tabNum = null;
var _tabName = null;
var _onloaded = null;

function ribbonTab(name, num, onloaded) {
    _onloaded = onloaded;
    _tabNum = num;
    _tabName = name;

    Tabs.tab(num);
    TabLoader(name);

    $('Tab').value = num;
    $('TabName').value = name;
}

function checkTab(name, num, onloaded) {
    if (_tabNum != num) {
        ribbonTab(name, num, onloaded);
    }
    else {
        onloaded();
    }
}

function submitCurrentTab() {
    ProductEdit.save();
}

function cancel() {
    ProductEdit.cancel();
}

function isVariantProduct() {
    queryString.init(location.href);
    var variantId = queryString.get("VariantID");

    return variantId && variantId.length > 0
}

function startProductWizard() {
    StartWizard('PRODUCT', _groupId);
}

function help() {
}

function addVariantGroup(event) {
    ContextMenu.show(event, 'VariantsContext', '', '', 'BottomRight');
}

function addRelatedGroup(event) {
    ContextMenu.show(event, 'GroupsContext', '', '', 'BottomRight');
}

function addPartsList(event) {
    ContextMenu.show(event, 'PartsListContext', '', '', 'BottomRight');
}

var _invalidControls = new Hash();

function checkRequired(sender, args) {
    var ctrl = sender.controltovalidate;
    var val = args.Value;
    if (!val || val.trim().length == 0) {
        _invalidControls.set(ctrl, false);
        args.IsValid = false;
    }
    else {
        _invalidControls.unset(ctrl);
        args.IsValid = true;
    }

    showInfobar(sender);
}

function showInfobar(sender) {
    var ctrl = $("validationSummaryInfo");
    if (_invalidControls.size() == 0) {
        ctrl.addClassName("pe-hidden");
    }
    else {
        ctrl.removeClassName("pe-hidden");
    }
}

function productTypeChanged(item) {

    Ribbon.enableButton('RibbonPartsListsButton');
    Ribbon.enableButton('RibbonVariantsButton');
    Ribbon.enableButton('RibbonUnitButton');
    Ribbon.enableButton('RibbonStockButton');
    Ribbon.enableButton('RibbonVATGroupsButton');
    Ribbon.enableButton('RibbonDiscountsButton');
    Ribbon.enableButton('RibbonPricesButton');

    var val = item.value;

    if (val == "0") {
        Ribbon.disableButton('RibbonPartsListsButton');
    }
    else if (val == "1") {
        Ribbon.disableButton('RibbonPartsListsButton');
        Ribbon.disableButton('RibbonVariantsButton');
        Ribbon.disableButton('RibbonUnitButton');
        Ribbon.disableButton('RibbonStockButton');
    }
    else if (val == "2") {
        //Ribbon.disableButton('RibbonVariantsButton');
        Ribbon.disableButton('RibbonUnitButton');
    }
    else if (val == "3") {
        Ribbon.disableButton('RibbonPartsListsButton');
        Ribbon.disableButton('RibbonVariantsButton');
        Ribbon.disableButton('RibbonUnitButton');
        Ribbon.disableButton('RibbonStockButton');
        Ribbon.disableButton('RibbonVATGroupsButton');
        Ribbon.disableButton('RibbonDiscountsButton');
        Ribbon.disableButton('RibbonPricesButton');
    }
}

String.prototype.trim = function () {
    return this.replace(/^\s+|\s+$/g, "");
}

var alwaysDisabledButtons = null;

/* Toggles saving buttons activity state */
function toggleRibbonButtons(enable) {

    var init = false;
    if (!alwaysDisabledButtons) {
        alwaysDisabledButtons = new Hash();
        init = true;
    }

    toggleRibbonButton('btnSaveProduct', enable, init);
    toggleRibbonButton('btnSaveAndCloseProduct', enable, init);
    toggleRibbonButton('btnCancel', enable, init);
    toggleRibbonButton('RibbonBarButton1', enable, init);
    toggleRibbonButton('RibbonBarButton2', enable, init);
    toggleRibbonButton('cmdOptimize', enable, init);

    toggleRibbonButton('btnMarketingSaveProduct', enable, init);
    toggleRibbonButton('btnMarketingSaveAndCloseProduct', enable, init);
    toggleRibbonButton('btnMarketingCancel', enable, init);
    toggleRibbonButton('btnMarketingDelete', enable, init);
    toggleRibbonButton('cmdMarketingComments', enable, init);
    toggleRibbonButton('cmdMarketingOptimize', enable, init);

    toggleRibbonButton('btnPeriodSaveProduct', enable, init);
    toggleRibbonButton('btnPeriodSaveAndCloseProduct', enable, init);
    toggleRibbonButton('btnPeriodCancel', enable, init);
    toggleRibbonButton('btnPeriodDelete', enable, init);
    toggleRibbonButton('cmdPeriodComments', enable, init);
    toggleRibbonButton('cmdPeriodOptimize', enable, init);

    toggleRibbonButton('RibbonBasicButton', enable, init);
    toggleRibbonButton('RibbonDescrButton', enable, init);
    toggleRibbonButton('RibbonMediaButton', enable, init);

    toggleRibbonButton('RibbonRelatedGroupsButton', enable, init);
    toggleRibbonButton('RibbonRelatedProdButton', enable, init);
    toggleRibbonButton('RibbonRelatedSearchesButton', enable, init);
    toggleRibbonButton('RibbonVariantsButton', enable, init);
    toggleRibbonButton('RibbonFieldsButton', enable, init);
    toggleRibbonButton('RibbonPartsListsButton', enable, init);
    toggleRibbonButton('RibbonMwButton', enable, init);
    toggleRibbonButton('RibbonPricesButton', enable, init);
    toggleRibbonButton('RibbonUnitButton', enable, init);
    toggleRibbonButton('RibbonStockButton', enable, init);
    toggleRibbonButton('RibbonDiscountsButton', enable, init);
    toggleRibbonButton('RibbonDelocalizeButton', enable, init);
    toggleRibbonButton('cmdlangSelector', enable, init);
}

function toggleRibbonButton(buttonId, enable, init) {

    if (init) {
        if (!Ribbon.buttonIsEnabled(buttonId)) {

            if (buttonId != 'btnSaveProduct' && buttonId != 'btnSaveAndCloseProduct' && buttonId != 'btnMarketingSaveProduct' && buttonId != 'btnMarketingSaveAndCloseProduct' && buttonId != 'btnPeriodSaveProduct' && buttonId != 'btnPeriodSaveAndCloseProduct')
            {
                alwaysDisabledButtons.set(buttonId, true);
            }
        }
    }

    if (alwaysDisabledButtons.get(buttonId)) {
        return;
    }

    if (enable) {
        Ribbon.enableButton(buttonId);
    }
    else {
        Ribbon.disableButton(buttonId);
    }
}

var fckEditors = new Hash(); //all avalable fck editors
var fckTimer;

function FCKeditor_OnComplete(editorInstance) {
    fckEditors.set(editorInstance.Name, true); //editor has been loaded
}

function waitForFCK() {

    fckTimer = setInterval(function () {

        var values = fckEditors.values();
        var loaded = true;
        for (i = 0; i < values.length; i++) {
            loaded = loaded && values[i];
        }

        if (loaded) {
            toggleRibbonButtons(true);

            if (fckTimer) {
                clearInterval(fckTimer);
            }
        }

    }, 1000);
}

var descrTimer;

function loadDescriptionTab() {

	if (useProviderBasedEditors) {
		toggleRibbonButtons(true);
	} else if (typeof (InitFckEditorDescription) == 'function' && typeof (InitFckEditorProductFields) == 'function') {
        //html already loaded
        toggleRibbonButtons(false);
        InitFckEditorDescription();
        InitFckEditorProductFields();
        waitForFCK();
    } else {
        //wait
        descrTimer = setInterval(function () {

            if (typeof (InitFckEditorDescription) == 'function' && typeof (InitFckEditorProductFields) == 'function') {
                //html loaded
                if (descrTimer) {
                    clearInterval(descrTimer);
                }
                toggleRibbonButtons(false);
                InitFckEditorDescription();
                InitFckEditorProductFields();
                waitForFCK();
            }

        }, 1000);
    }
}

function getFieldByID (field) {
    var ret = document.getElementById(field);

    if (!ret) {
        var elements = document.getElementsByName(field);

        if (elements != null && elements.length) {
            ret = elements[0];
        }
    }
    return ret;
}


var ProductEdit = {
    isDirty: false,

    suppressBeforeUnload: false,

    terminology: {},

    Marketing: null,

    RelatedLimitationPopup: null,

    RelatedLimitationRow: null,

    validation_result: null,

    get_validation: function () {
        if (!this._validation) {
            this._validation = new Dynamicweb.Validation.ValidationManager();
        }
        return this._validation;
    },

    validate: function (validateID) {
        var context = { manager: this.get_validation() };
        var validators = this.get_validation().get_validators();
        var validationErrors = "";
        if (validators && validators.length) {
            for (var i = 0; i < validators.length; i++) {
                if (validators[i].get_target() == validateID || !validateID) {
                    Dynamicweb.Validation.setFocusToValidateField = (validationErrors.length == 0);
                    var res = validators[i].beginValidate(context, ProductEdit.field_validation_error)
                    if (!res.isValid)
                    {
                        if (validationErrors == "") {
                            validationErrors += res.errorMessage;
                        }
                    }
                    var elem = document.getElementById("asterisk_"+validators[i].get_target().replace("ctl00_ContentHolder_", ""))
                    if (elem)
                        elem.attributes["class"].value = (res.isValid ? "hide-error " : "validation-error ");
                }
            }
        }
        if (!validateID && validationErrors != "")
            alert(validationErrors);
        return (validationErrors.length == 0);
    },

    field_validation_error: function(result)
    {
        return result;
    },

    initialization: function () {
        var self = this;
        document.observe("RelatedLimitations:changed", this.onRelatedLimitations_changed.bind(this));

        window.onbeforeunload = function (e) {
            if (self.isDirty && !self.suppressBeforeUnload) {
                (e || window.event).returnValue = self.terminology.unsavedChanges;
                return self.terminology.unsavedChanges;
            }
        };
        this.initProductCategoryFields();
    },

    openContentRestrictionDialog: function (productID, variantID, languageID) {
        this.Marketing.openSettings('ContentRestriction', { data: { ItemType: 'Product', ItemID: productID + '.' + variantID + '.' + languageID, Type: 'Reorder'} });
    },

    openProfileDynamicsDialog: function (productID, variantID, languageID) {
        this.Marketing.openSettings('ProfileDynamics', { data: { ItemType: 'Product', ItemID: productID + '.' + variantID + '.' + languageID } });
    },

    openRelatedLimitationDialog: function (rowID, productID, relatedProductID, relatedVariantID, relatedGroupID) {
        this.RelatedLimitationRow = rowID;

        var popup = this.RelatedLimitationPopup;
        var url = '/Admin/Module/eCom_Catalog/dw7/edit/EcomProductRelatedLimitations_Edit.aspx?';
        url += 'productID=' + encodeURIComponent(productID);
        url += '&relatedProductID=' + encodeURIComponent(relatedProductID);
        url += '&relatedVariantID=' + encodeURIComponent(relatedVariantID);
        url += '&relatedGroupID=' + encodeURIComponent(relatedGroupID);

        popup.set_contentUrl(url);
        popup.show();
    },

    onRelatedLimitations_changed: function(event) {
        var limits = event.memo;
        if (!!limits) {
            var cells = $(this.RelatedLimitationRow).childElements();

            if (cells[1].hasClassName("filter")) {
                if (!limits.variant) { cells[1].removeClassName("filter"); }
            } else if (limits.variant) { cells[1].addClassName("filter"); }

            if (cells[2].hasClassName("filter")) {
                if (!limits.lang) { cells[2].removeClassName("filter"); }
            } else if (limits.lang) { cells[2].addClassName("filter"); }

            if (cells[3].hasClassName("filter")) {
                if (!limits.country) { cells[3].removeClassName("filter"); }
            } else if (limits.country) { cells[3].addClassName("filter"); }

            if (cells[4].hasClassName("filter")) {
                if (!limits.shop) { cells[4].removeClassName("filter"); }
            } else if (limits.shop) { cells[4].addClassName("filter"); }            
        }
    },

    save: function (close) {
        this.suppressBeforeUnload = true;
        queryString.init(location.href);
        queryString.remove("Tab");
        queryString.remove("TabName");
        aspForm.action = queryString.toString();
    },

    cancel: function () {
        var back = $("backUrl").value;
        if (back.length > 0) {
            window.location.href = back;
        }
        else if (isVariantProduct()) {
            top.close();
        }
        else {
            window.location.href = "../ProductList.aspx?GROUPID=" + _groupId + "&restore=true";
        }
    },

    initProductCategoryFields: function () {
        RteElementObserver = Class.create(Abstract.TimedObserver, {
            initialize: function ($super, fieldName, element, frequency, callback) {
                var self = this;
                this._tryListenRte = function () {
                    if (!self._rte) {
                        if (typeof (CKEDITOR) != 'undefined') {
                            self._rte = CKEDITOR.instances[fieldName];
                            if (self._rte) {
                                self._getVal = function () {
                                    return self._rte.getData();
                                };
                                self._rte.on("change", function () {
                                    self.val = self._getVal();
                                });
                            }
                        } else if (typeof (FCKeditorAPI) != 'undefined') {
                            self._rte = FCKeditorAPI.Instances[fieldName];
                            if (self._rte) {
                                self._getVal = function () {
                                    return self._rte.GetData();
                                };
                                self._rte.Events.AttachEvent("OnSelectionChange", function () {
                                    self.val = self._getVal();
                                });
                            }
                        }
                    }
                };
                $super(element, frequency, callback);
                this.fieldName = fieldName;
                this.element = $(element);
                
                self.val = null;
                this.lastValue = this.getValue();
            },
            getValue: function () {
                this._tryListenRte();
                if (!this.timer && this._getVal) {
                    return this._getVal();
                }
                return this.val;
            }
        });


        var fieldObservers = {}; // => <fieldname: [<observers>]>
        var localValRefreshUrl = "/Admin/Images/Ribbon/Icons/Small/refresh.png";
        var defaultValRefreshUrl = "/Admin/Images/Ribbon/Icons/Small/refresh_disabled.png";
        $$(".cat-field-row > .editor.type-1 .NewUIinput, .cat-field-row > .editor.type-10 .NewUIinput, .cat-field-row > .editor.type-11 .NewUIinput, .cat-field-row > .editor.type-12 .NewUIinput, .cat-field-row > .editor.type-13 .NewUIinput,\
            .cat-field-row > .editor.type-2 textarea, .cat-field-row > .editor.type-4 select, .cat-field-row > .editor.type-5 select, .cat-field-row > .editor.type-6 input, \
            .cat-field-row > .editor.type-7 input[type=text], .cat-field-row > .editor.type-8 input[type=text], .cat-field-row > .editor.type-9 select, .cat-field-row > .editor.type-3 input[type=checkbox], \
            .cat-field-row > .editor.type-15.pt-RadioButtonList input[type=radio], .cat-field-row > .editor.type-15.pt-CheckBoxList input[type=checkbox], .cat-field-row > .editor.type-15.pt-DropDownList select, \
            .cat-field-row > .editor.type-15.pt-MultiSelectList select, .cat-field-row > .editor.type-10 .NewUIinput, .cat-field-row > .editor.type-14 textarea").each(function (el) {
                var editor = el;
                var editorCnt = editor.up(".editor");
                var row = editorCnt.up(".cat-field-row");
                var iiEl = editorCnt.select(".is-inherited")[0];
                var rivEl = editorCnt.select(".restore-inherited-val")[0];
                var fieldName = row.readAttribute("data-field-name");
                var markAsLocal = function () {
                    if (!row.hasClassName("inherited-val")) {
                        return;
                    }
                    row.removeClassName("inherited-val");
                    iiEl.value = "false";
                    rivEl.src = localValRefreshUrl;
                };
                var o = null;
                if (editorCnt.hasClassName("type-14")) { // rte
                    o = new RteElementObserver(fieldName, el, 0.3, markAsLocal);
                }
                else {
                    var o = new Form.Element.Observer(el, 0.3, markAsLocal);
                }
                if (o) {
                    var arr = fieldObservers[fieldName];
                    if (!arr) {
                        arr = [];
                        fieldObservers[fieldName] = arr;
                    }
                    arr.push(o);
                }
                if (!editorCnt.hasClassName("rivevt")) {
                    rivEl.on("click", function (e) {
                        fieldObservers[fieldName].invoke("stop");
                        var defVal = rivEl.readAttribute("data-inherited-val");
                        if (editorCnt.hasClassName("type-3")) {
                            editor.checked = defVal.toLowerCase() == "true";
                        }
                        else if (editorCnt.hasClassName("type-4") || editorCnt.hasClassName("type-5")) {
                            Calendar.onUpdateDW({
                                date: Date.parseDate(defVal, "%Y-%m-%d %H:%M"),
                                showsTime: editorCnt.hasClassName("type-5")
                            }, fieldName, true);
                            Calendar.onUpdateDW(null, fieldName, false);
                        }
                        else if (editorCnt.hasClassName("type-15") && editorCnt.hasClassName("pt-CheckBoxList")) {
                            var dvals = defVal.split(",");
                            editorCnt.select("input[name=" + fieldName + "]").each(function (chbEl) {
                                chbEl.checked = dvals.indexOf(chbEl.value) > -1;
                            });
                        }
                        else if (editorCnt.hasClassName("type-15") && editorCnt.hasClassName("pt-RadioButtonList")) {
                            var arr = editorCnt.select("input[name=" + fieldName + "][value=" + defVal + "]");
                            if (arr && arr.length > 0) {
                                arr[0].checked = true;
                            }
                        }
                        else if (editorCnt.hasClassName("type-14")) { // rte
                            if (typeof (CKEDITOR) != 'undefined') {
                                var rte = CKEDITOR.instances[fieldName];
                                if (rte) {
                                    rte.setData(defVal);
                                }
                            } else if (typeof (FCKeditorAPI) != 'undefined') {
                                var rte = FCKeditorAPI.Instances[fieldName];
                                if (rte) {
                                    rte.SetData(defVal);
                                }
                            }
                        }
                        else {
                            editor.value = defVal;
                        }
                        iiEl.value = "true"
                        row.addClassName("inherited-val");
                        rivEl.src = defaultValRefreshUrl;
                        fieldObservers[fieldName].each(function (obr) {
                            obr.lastValue = obr.getValue();
                            obr.registerCallback();
                        });
                    });
                    editorCnt.addClassName("rivevt");
                }
            });
    }
}
