if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = new Object();
}

Dynamicweb.Items.ItemFieldOptionsEdit = function () {
    this._terminology = {};
    this._initialized = false;
    this._itemType = '';
    this._forms = [];
    this._sourceType = $('SourceTypeValue');
    this._parent = '';
    this._isTranslateOnly = false;
};

if (typeof (Dynamicweb.Items.ItemFieldOptionsEdit.Forms) == 'undefined') {
    Dynamicweb.Items.ItemFieldOptionsEdit.Forms = new Object();
}

/* Maybe a spelling error (dropdawn) */

Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn = function(dropdawn, values, callback) {
    dropdawn.length = 0;
    var method = function (e) { return new Option(e.Text, e.Value); };
    values.each(function (e) {
        dropdawn.options.add(method(e));
    });

    if (typeof (callback) !== 'undefined') {
        callback(dropdawn.value);
    }
};
/* Maybe a spelling error (dropdawn) */

Dynamicweb.Items.ItemFieldOptionsEdit._instance = null;

Dynamicweb.Items.ItemFieldOptionsEdit.get_current = function () {
    if (!Dynamicweb.Items.ItemFieldOptionsEdit._instance) {
        Dynamicweb.Items.ItemFieldOptionsEdit._instance = new Dynamicweb.Items.ItemFieldOptionsEdit();
    }

    return Dynamicweb.Items.ItemFieldOptionsEdit._instance;
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.isValidStrParam = function (param) {
    return ((typeof (param) !== 'undefined') && param.toString().trim() !== '');
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.get_terminology = function () {
    return this._terminology;
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.deleteRow = function (link) {
    var row = dwGrid_StaticSourceGrid.findContainingRow(link);

    if (row) {
        if (!this.get_isTranslateOnly()) {
            if (confirm(this.get_terminology()['DeleteOption'])) {
                dwGrid_StaticSourceGrid.deleteRows([row]);
            }
        }
    }
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.request = function (params, callback, hide) {
    if (typeof (params) === 'undefined') {
        return;
    }

    var that = this;

    params['IsAjax'] = true;
    params['ItemType'] = this._itemType;
    params['EditForm'] = this.get_sourceType();

    new Ajax.Request('/Admin/Content/Items/ItemTypes/ItemFieldOptionsEdit.aspx', {
        method: 'post',
        parameters: params,
        onCreate: function () {
            if (!hide) {
                that.parent.get_operationIndicator().show();
            } else {
                that.parent.get_progressContainer().show();
            }
        },
        onSuccess: function(response) {
            if (typeof (callback) !== 'undefined') {
                callback(response);
            }
        },
        onFailure: function() {
            alert(this.get_terminology()['RequestFailure']);
        },
        onComplete: function () {
            var f;

            if (!hide) {
                f = function () { that.parent.get_operationIndicator().hide(); };
            } else {
                f = function () { that.parent.get_progressContainer().hide(); };
            }

            setTimeout(f, 500);
        }
    });
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.get_isTranslateOnly = function () {
    return this._isTranslateOnly;
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.set_isTranslateOnly = function (value) {
    if (!typeof value === 'boolean') {
        return;
    }

    this._isTranslateOnly = value;
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.get_sourceType = function() {
    return this._sourceType.value;
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.set_sourceType = function (value) {
    this._sourceType.value = value;
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.get_form = function (id) {
    var form = this._forms[id];

    if (typeof (form) === 'undefined') {
        if (id === '0') {
            form = new Dynamicweb.Items.ItemFieldOptionsEdit.Forms.StaticSourceForm(id, this);
        } else if (id === '1') {
            form = new Dynamicweb.Items.ItemFieldOptionsEdit.Forms.SqlSourceForm(id, this, 'SqlSourceModel');
        } else if (id === '2') {
            form = new Dynamicweb.Items.ItemFieldOptionsEdit.Forms.ItemTypeSourceForm(id, this, 'ItemTypeSourceModel');
        }

        this.set_form(id, form);
    }

    return form;
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.set_form = function (id, form) {
    this._forms[id] = form;
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.toggleForm = function () {
    this.get_form(this.get_sourceType()).toggle();
};

Dynamicweb.Items.ItemFieldOptionsEdit.prototype.initialize = function(itemType) {
    if (!this._initialized) {
        if (parent) {
            this.parent = parent.Dynamicweb.Controls.PopUpWindow.current(window);

            if (this.parent) {
                this.parent.get_progressContainer().setStyle('position: absolute; width: 95%;');
                this.parent._okButton.writeAttribute('onclick', '');
                this.parent._okButton.on('click', (function (sender, e) {
                    this.get_form(this.get_sourceType()).save(function () {
                        document.getElementById('MainForm').submit();
                    });
                }).bind(this));
            }
        }
             
        this._itemType = itemType;
        this._initialized = true;
        this.toggleForm();

        $$('#SourceTypeList input[type="radio"][value="' + this.get_sourceType() + '"]')[0].checked = true;

        $('SourceTypeList').on('change', 'input', (function (event, element) {
            this.set_sourceType(element.value);
            this.toggleForm();
        }).bind(this));

        if (this.get_isTranslateOnly()) {
            Dynamicweb.Utilities.CollectionHelper.forEach($$('input, select'), function (el) {
                el.writeAttribute('disabled', 'disabled');
            });
            Dynamicweb.Utilities.CollectionHelper.forEach($$('input.static-label'), function (el) {
                el.removeAttribute('disabled');
            });
        }
    }
};

Dynamicweb.Items.ItemFieldOptionsEdit.Forms.BaseForm = Class.create({
    initialize: function (id, parent, modelId) {
        this.id = 'edit-form-' + id;
        this.el = $(this.id);
        this.initialized = false;
        this.visible = false;
        this.parent = parent;
        this.isModelNew = true;
        this.modelSource = $(modelId);
        this.preloadData = $('PreloadData').value.trim();
        
        if (typeof (this.modelSource) !== "undefined") {
            this.model = this.modelSource.value.evalJSON();
        }

        this.parent.parent.get_progressContainer().show();
    },
    
    completeInitialize: function () {
        this.parent.parent.get_progressContainer().hide();
        this.initialized = true;
        this.toggle();
    },
    
    canChangeValue: function () {
        return this.initialized || this.isModelNew;
    },

    toggle: function () {
        $$('.source-edit-form').each(function (item) { item.hide(); });
        if (this.initialized) {
            this.el.show();
            this.visible = true;
        }
    },
    
    validate: function(callback) {
        var success = function(response) {
            var isValid = true;
            if (response.responseText.trim() !== '') {
                alert(response.responseText);
                isValid = false;
            }
            
            if (typeof (callback) !== 'undefined') {
                callback(isValid);
            }
        };

        this.request({ Action: 'Validate', Source: this.modelSource.value }, success.bind(this), true);
    },
    
    save: function (callback) {
        if (typeof (this.modelSource) !== "undefined") {
            this.modelSource.value = Object.toJSON(this.model);
        }
        
        this.validate((function (isValid) {
            if (!isValid) {
                return;
            }

            if (typeof (callback) !== 'undefined') {
                callback();
            }
        }).bind(this));
    },
    
    request: function (parameters, callback, hide) {
        if (typeof parameters === "undefined" || parameters === null) {
            return;
        }
        
        this.parent.request(parameters, callback, hide);
    }
});

Dynamicweb.Items.ItemFieldOptionsEdit.Forms.StaticSourceForm = Class.create(Dynamicweb.Items.ItemFieldOptionsEdit.Forms.BaseForm, {
    initialize: function ($super, id, parent) {
        $super(id, parent);
        this.model = {};
        this.completeInitialize();
    },
    validate: function ($super, callback) {
        var isValid = true;
        var rowsCount = this.el.select('input[type="text"]').length;
        var filledRowsCount = this.el.select('input[type="text"][value]').length;

        if (rowsCount === 0) {
            isValid = false;
            alert("Create at least one row!");
        } else if (rowsCount !== filledRowsCount) {
            isValid = false;
            alert("All fields must be filled!");
        }

        if (typeof (callback) !== 'undefined') {
            callback(isValid);
        }
    }
});

Dynamicweb.Items.ItemFieldOptionsEdit.Forms.SqlSourceForm = Class.create(Dynamicweb.Items.ItemFieldOptionsEdit.Forms.BaseForm, {
    initialize: function ($super, id, parent, model) {
        $super(id, parent, model);
        this.nameFields = this.el.select('select.sql-name-fields')[0];
        this.valueFields = this.el.select('select.sql-value-fields')[0];
        this.queryString = this.el.select('textarea.sql-query-string')[0];
        this.btnValidate = this.el.select('input.sql-execute-btn')[0];
        this.accessDbList = this.el.select('select.sql-accessdb-list')[0];

        this.isAccess = this.accessDbList.visible();
        this.isModelNew = this.model.QueryString === null || this.model.QueryString.trim() === '';

        this.queryString.on('blur', this.onQueryStringFocusLeave.bind(this));

        this.nameFields.on('change', (function (event, element) {
            this.onNameFieldsChange(element.value);
        }).bind(this));
        
        this.valueFields.on('change', (function(event, element) {
            this.onValueFieldsChange(element.value);
        }).bind(this));

        this.btnValidate.on('click', (function() {
            this.execute();
        }).bind(this));

        this.accessDbList.on('change', (function (event, element) {
            this.onAccessDbListChange(element.value);
        }).bind(this));

        this.el.on('keydown', this.onKeyDown.bind(this));

        this.load(this.bind.bind(this));
    },
    
    load: function (callback) {

        if (!this.isModelNew) {
            var data = JSON.parse(this.preloadData.replace(/\'/g, '"'));
            var queryFields = JSON.parse(data.QueryFields.replace(/\'/g, '"'));
            var accessList = JSON.parse(data.AccessDbList.replace(/\'/g, '"'));

            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.nameFields, queryFields);
            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.valueFields, queryFields);
            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.accessDbList, accessList);

            if (typeof(callback) !== "undefined") {
                callback();
            }
        } else {
            this.getAccessDbList(callback);
        }
    },
    
    getAccessDbList: function (callback) {
        if (!this.isAccess) {
            if (typeof (callback) !== "undefined") {
                callback();
            }

            return;
        }

        var onSuccess = function (response) {
            var data = JSON.parse(response.responseText.replace(/\'/g, '"'));
            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.accessDbList, data);

            if (typeof (callback) !== "undefined") {
                callback();
            }
        };
        
        this.parent.request({ Action: 'GetAccessDbList' }, onSuccess.bind(this));
    },

    bind: function () {

        this.queryString.value = this.model.QueryString || '';
        this.nameFields.value = this.model.NameField || '';
        this.valueFields.value = this.model.ValueField || '';
        this.accessDbList.value = this.model.AccessDb || '';
                
        this.completeInitialize();
    },
          
    onNameFieldsChange: function (value) {
        if (this.canChangeValue()) {
            this.model.NameField = value.trim();
        }
    },

    onValueFieldsChange: function (value) {
        if (this.canChangeValue()) {
            this.model.ValueField = value.trim();
        }
    },
    
    onQueryStringChange: function (value) {
        if (this.canChangeValue()) {
            this.model.QueryString = value.trim();
        }
    },
    
    onAccessDbListChange: function (value) {
        if (this.canChangeValue()) {
            this.model.AccessDb = value.trim();
        }
    },
    
    onQueryStringFocusLeave: function (event, element) {
        if (this.isAccess && this.accessDbList.value === '') {
            return;
        }

        var newText = element.value.replace(/\s+/g, '').toLowerCase();
        var original = this.model.QueryString.replace(/\s+/g, '').toLowerCase();

        if ((newText === original)) {
            return;
        }

        if (!this.isModelNew) {
            if (!confirm(this.parent.get_terminology()['ExecuteQuery'])) {
                element.value = this.model.QueryString;
                return;
            }
        }

        if (this.queryString.value.trim() !== '') {
            this.execute();
        }
    },
    
    onKeyDown: function(event, element) {
        if (!this.visible) {
            return;
        }

        if (event.keyCode === 13 && event.ctrlKey) {
            this.execute();
        }
    },

    execute: function (callback) {
        if (this.isAccess && this.accessDbList.value === '') {
            alert(this.parent.get_terminology()['EmptyAccessDb']);
            return;
        }

        this.onQueryStringChange(this.queryString.value);
        this.onNameFieldsChange('');
        this.onValueFieldsChange('');
        
        this.nameFields.length = 1;
        this.valueFields.length = 1;

        var onSuccess = function (response) {
            var onError = (function() {
                alert(this.parent.get_terminology()['InvalidQuery']);
                this.queryString.focus();
            }).bind(this);

            if (response.responseText === '') {
                onError();
                return;
            }
            
            var fields = JSON.parse(response.responseText.replace(/\'/g, '"'));

            if (typeof (fields) === "undefined" || fields.length <= 1) {
                onError();
                return;
            }

            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.nameFields, fields);
            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.valueFields, fields);

            if (typeof (callback) !== 'undefined') {
                callback();
            }
        };

        this.request({ Action: 'GetQueryFields', QueryString: this.queryString.value, QueryDatabase: this.accessDbList.value }, onSuccess.bind(this), true);
    }
});

Dynamicweb.Items.ItemFieldOptionsEdit.Forms.ItemTypeSourceForm = Class.create(Dynamicweb.Items.ItemFieldOptionsEdit.Forms.BaseForm, {
    initialize: function ($super, id, parent, model) {
        $super(id, parent, model);

        this.nameFields = this.el.select('select.item-name-fields')[0];
        this.valueFields = this.el.select('select.item-value-fields')[0];
        this.itemTypes = this.el.select('select.item-item-types')[0];
        this.areas = this.el.select('select.item-source-areas')[0];
        this.page = $('ItemTypeSourcePage');
        this.pageInput = $('Link_ItemTypeSourcePage');
        this.pageInput.readOnly = true;
        this.pageLink = $('Href_ItemTypeSourcePage');
        this.pageLinkValue = this.pageLink.href;
        this.includeParagrpahItems = this.el.select('input.item-source-paragraphs')[0];
        this.includeChildItems = this.el.select('input.item-source-childs')[0];

        this.isModelNew = this.model.ItemSystemName === null || this.model.ItemSystemName.trim() === '';

        this.nameFields.on('change', (function(event, element) {
            this.onNameFieldsChange(element.value);
        }).bind(this));
        
        this.valueFields.on('change', (function(event, element) {
            this.onValueFieldsChange(element.value);
        }).bind(this));

        this.itemTypes.on('change', (function (event, element) {
            this.onItemTypeChange(element.value);
        }).bind(this));
        
        this.areas.on('change', (function (event, element) {
            this.onAreasChange(element.value);
        }).bind(this));
        
        this.includeParagrpahItems.on('change', (function(event, element) {
            this.onParagraphsChange(element.checked);
        }).bind(this));
        
        this.includeChildItems.on('change', (function (event, element) {
            this.onChildItemsChange(element.checked);
        }).bind(this));
        
        this.el.on('change', 'input[type="radio"][name="item-source-type"]', (function (event, element) {
            this.onItemSourceTypeChange(element.value);
        }).bind(this));

        this.load(this.bind.bind(this));
    },
    
    load: function (callback) {
        if (!this.isModelNew) {
            var data = JSON.parse(this.preloadData.replace(/\'/g, '"'));
            var areas = JSON.parse(data.Areas.replace(/\'/g, '"'));
            var itemTypes = JSON.parse(data.ItemTypes.replace(/\'/g, '"'));
            var itemFields = JSON.parse(data.ItemFields.replace(/\'/g, '"'));

            if (data.Page) {
                var page = JSON.parse(data.Page.replace(/\'/g, '"'));
                this.page.value = page.Id;
                this.pageInput.value = page.Name;
            }

            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.areas, areas, this.onAreasChange.bind(this));
            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.itemTypes, itemTypes, this.onAreasChange.bind(this));
            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.nameFields, itemFields, this.onNameFieldsChange.bind(this));
            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.valueFields, itemFields, this.onValueFieldsChange.bind(this));

            if (typeof(callback) !== "undefined") {
                callback();
            }

        } else {
            this.getItemTypes((function () {
                this.getAreas(callback.bind(this));
            }).bind(this));
        }
    },

    getItemTypes: function (callback) {
        var onSuccess = function (response) {
            var data = JSON.parse(response.responseText.replace(/\'/g, '"'));

            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.itemTypes, data);

            if (typeof (callback) !== "undefined") {
                callback();
            }
        };

        this.parent.request({ Action: 'GetItemTypes' }, onSuccess.bind(this));
    },

    getAreas: function (callback) {
        var onSuccess = function (response) {
            var data = JSON.parse(response.responseText.replace(/\'/g, '"'));

            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.areas, data);

            if (typeof (callback) !== "undefined") {
                callback();
            }
        };

        this.parent.request({ Action: 'GetAreas' }, onSuccess.bind(this));
    },

    bind: function () {
        var itemSourceSelector;
        this.includeParagrpahItems.checked = this.model.IncludeParagrpahs || false;
        this.includeChildItems.checked = this.model.IncludeChilds || false;
        this.itemTypes.value = this.model.ItemSystemName || '';
        this.nameFields.value = this.model.NameField || '';
        this.valueFields.value = this.model.ValueField || '';
        this.areas.value = this.model.ItemSourceType === 1 ? this.model.ItemSourceId : '';

        var sourceType = this.model.ItemSourceType > 0 ? this.model.ItemSourceType : 1;
        itemSourceSelector = this.el.select('input[type="radio"][name="item-source-type"][value="' + sourceType + '"]')[0];
        itemSourceSelector.checked = true;
        this.onItemSourceTypeChange(itemSourceSelector.value);
        this.completeInitialize();
    },
    
    save: function ($super, callback) {
        if (this.model.ItemSourceType === 2) {
            var sourceId = parseInt(this.page.value.replace('Default.aspx?ID=', ''));
            if (!isNaN(sourceId)) {
                this.model.ItemSourceId = sourceId;   
            }
        }
        
        $super(callback);
    },

    onItemSourceTypeChange: function (value) {
        if (value === '1') {
            this.pageLinkValue = this.pageLink.href;
            this.pageLink.href = '#';
            this.pageInput.disable();
            this.areas.enable();
            this.onChildItemsChange(false);
            this.includeChildItems.checked = false;
            this.includeChildItems.disable();
        }
        else if (value === '2') {
            this.pageLink.href = this.pageLinkValue;
            this.areas.disable();
            this.pageInput.enable();
            this.includeChildItems.enable();
        }
        else if (value === '3') {
            this.pageLinkValue = this.pageLink.href;
            this.pageLink.href = '#';
            this.pageInput.disable();
            this.areas.disable();
            this.onChildItemsChange(false);
            this.includeChildItems.checked = false;
            this.includeChildItems.disable();
        }
        else if (value === '4') {
            this.pageLink.href = this.pageLinkValue;
            this.areas.disable();
            this.pageInput.disable();
            this.includeChildItems.enable();
        }

        if (this.canChangeValue()) {
            this.model.ItemSourceType = parseInt(value);
        }
    },

    onItemTypeChange: function (value, callback) {
        if (this.canChangeValue()) {
            this.model.ItemSystemName = value;
        }

        var onSuccess = function (response) {
            var fields = JSON.parse(response.responseText.replace(/\'/g, '"'));

            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.nameFields, fields, this.onNameFieldsChange.bind(this));
            Dynamicweb.Items.ItemFieldOptionsEdit.FillDropdawn(this.valueFields, fields, this.onValueFieldsChange.bind(this));

            if (typeof(callback) !== 'undefined') {
                callback(value);
            }
        };

        this.parent.request({ Action: 'GetItemFields', SelectedItemType: value }, onSuccess.bind(this));
    },
    
    onNameFieldsChange: function (value) {
        if (this.canChangeValue()) {
            this.model.NameField = value;
        }
    },

    onValueFieldsChange: function (value) {
        if (this.canChangeValue()) {
            this.model.ValueField = value;
        }
    },
    
    onAreasChange: function (value) {
        if (this.canChangeValue()) {
            this.model.ItemSourceId = parseInt(value);
        }
    },

    onParagraphsChange: function (value) {
        if (this.canChangeValue()) {
            this.model.IncludeParagrpahs = value;
        }
    },
    
    onChildItemsChange: function (value) {
        if (this.canChangeValue()) {
            this.model.IncludeChilds = value;
        }
    }
});