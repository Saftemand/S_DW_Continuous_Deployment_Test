if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = {};
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = {};
}

Dynamicweb.Items.ParagraphSettings = Class.create({
    initialize: function(params) {
        var self = this, parameters, methods, controls, validators, modelHandlers, eventHandlers, eventRouter;

        if (!params || !params.areaId || !params.pageId || !params.paragraphId) {
            throw 'Invalid initialization parameters!';
        }

        parameters = { areaId: params.areaId, pageId: params.pageId, paragraphId: params.paragraphId, translations: params.translations || {} };

        methods = {
            fillDropdown: function (control, elements) {
                var option,
                    prop,
                    add = function (v, t) {
                        option = document.createElement('option');
                        option.innerHTML = t;
                        option.value = v;
                        control.options.add(option);
                    };

                control.options.length = 0;
                add('', self.get_translation('NothingSelected'));

                if (Array.isArray(elements)) {
                    elements.each(function (val) {
                        add(val, val);
                    });
                } else if (typeof (elements) === 'object') {
                    for (prop in elements) {
                        if (elements[prop] && elements.hasOwnProperty(prop)) {
                            add(prop, elements[prop]);
                        }
                    }
                }
            },
            request: function (options) {
                var params, data;

                if (!options) {
                    throw 'Parameters are required!';
                }

                if (!options.action) {
                    throw 'Action name is required!';
                }

                options.data = options.data || {};
                options.data.AreaId = parameters.areaId;
                options.data.PageId = parameters.pageId;
                options.data.Id = parameters.paragraphId;

                new Ajax.Request('/Admin/Module/ItemCreator/ItemCreator_Edit.aspx', {
                    method: 'POST',
                    parameters: {
                        AjaxAction: options.action,
                        AjaxData: JSON.stringify(options.data)
                    },
                    onCreate: function () {
                        if (controls.overlay) {
                            controls.overlay.show();
                        }
                    },
                    onSuccess: function (transport) {
                        var json;

                        if (transport.responseText.isJSON()) {
                            json = transport.responseText.evalJSON();
                        }

                        if (options.callback) {
                            options.callback(transport.responseText, json);
                        }
                    },
                    onFailure: function () {
                        alert(self.get_translation('Error'));
                    },
                    onComplete: function () {
                        if (controls.overlay) {
                            setTimeout(function () {
                                controls.overlay.hide();
                            }, 500);
                        }
                    }
                });
            },
            getAllowedItems: function (callback) {
                methods.request({
                    action: 'GetAllowedItemTypes',
                    data: {
                        ItemType: controls.itemList.value(),
                        ContentStructure: controls.contentStructure.value(),
                        TargetPageAreaId: controls.targetPage.value().areaId,
                        TargetPageId: controls.targetPage.value().id,
                        TargetPagePlaceholder: controls.targetPagePlaceholder.value()
                    },
                    callback: function (response, json) {
                        if (!json) {
                            alert(parameters.get_translation('Error'));
                        }

                        if (json.Error) {
                            alert(json.Error);
                        }

                        if (callback) {
                            callback(json.Result);
                        }
                    }
                });


            },
            getItemFields: function (callback) {
                methods.request({
                    action: 'GetItemFields',
                    data: {
                        ItemType: controls.itemList.value()
                    },
                    callback: function (response, json) {
                        if (!json) {
                            alert(parameters.get_translation('Error'));
                        }

                        if (json.Error) {
                            alert(json.Error);
                        }

                        if (callback) {
                            callback(json.Result);
                        }
                    }
                });
            },
            getPlaceHolders: function (callback) {
                var targetPageId = 0;

                if (controls.targetPage.value()) {
                    targetPageId = controls.targetPage.value().id;
                }

                methods.request({
                    action: 'GetPagePlaceholders',
                    data: {
                        TargetPageId: targetPageId
                    },
                    callback: function (response, json) {
                        if (!json) {
                            alert(parameters.get_translation('Error'));
                        }

                        if (json.Error) {
                            alert(json.Error);
                        }

                        if (callback) {
                            callback(json.Result);
                        }
                    }
                });
            },
            getNamedLists: function (callback) {
                var targetPageId = 0;

                if (controls.targetPage.value()) {
                    targetPageId = controls.targetPage.value().id;
                }

                methods.request({
                    action: 'GetNamedLists',
                    data: {
                        TargetPageId: targetPageId,
                        ItemType: controls.itemList.value()
                    },
                    callback: function (response, json) {
                        if (!json) {
                            alert(parameters.get_translation('Error'));
                        }

                        if (json.Error) {
                            alert(json.Error);
                        }

                        if (callback) {
                            callback(json.Result);
                        }
                    }
                });
            }
        };

        controls = {
            itemList: {
                el: $('ItemType'),
                value: function (val) {
                    if (typeof(val) !== 'undefined') {
                        this.el.value = val;
                    }

                    return this.el.value;
                },
                find: function (val) {
                    return this.el.select('option[value="' + val + '"]')[0];
                },
                options: function (opt) {
                    if (typeof (opt) !== 'undefined') {
                        methods.fillDropdown(this.el, opt);
                    }

                    return this;
                },
                validation: function (doValidation) {
                    var index, that = this;
                    if (validators || validators.manager) {
                        index = -1;
                        validators.manager.get_validators().forEach(function (e, i) {
                            if (e._target === that.el.identify()) {
                                index = i;
                            }
                        });

                        if (doValidation) {
                            if (index === -1) {
                                validators.manager.get_validators().push(validators.itemListValidator);
                            }
                        } else {
                            if (index >= 0) {
                                validators.manager.get_validators().splice(index, 1);
                            }
                        }
                    }

                    return this;
                }
            },
            // el: represents an array of all MailProvider ItemField selectors
            // options: sets options for each ItemField selector
            mailProviderItemFieldLists: {
                el: $$('.MailProviderItemFieldList'),
                setOptions: function (opt) {
                    if (typeof (opt) !== 'undefined') {
                        this.el.forEach(function (element) { methods.fillDropdown(element, opt) });
                    } else {
                        this.el.forEach(function (element) { methods.fillDropdown(element, {'': ''}) });
                    }
                },
            },
            mailSaveProviderItemType: {
                el: $('MailSaveProvider.ItemType'),
                value: function (val) {
                    if (typeof (val) !== 'undefined') {
                        this.el.value = val;
                    }

                    return this.el.value;
                },
            },
            mailReceiptSaveProviderItemType: {
                el: $('MailReceiptSaveProvider.ItemType'),
                value: function (val) {
                    if (typeof (val) !== 'undefined') {
                        this.el.value = val;
                    }

                    return this.el.value;
                },
            },
            targetPage: {
                el: new Dynamicweb.Items.ParagraphSettings.LinkManager({ id: 'TargetPageID', areaId: parameters.areaId }),
                value: function (areaId, id, structureType, title) {
                    return this.el.value(areaId, id, structureType, title);
                }
            },
            targetPagePlaceholder: {
                el: $('TargetPagePlaceholder'),
                value: function(val) {
                    if (typeof(val) !== 'undefined') {
                        this.el.value = val;
                    }

                    return this.el.value;
                },
                find: function (val) {
                    return this.el.select('option[value="' + val + '"]')[0];
                },
                options: function(opt) {
                    if (typeof(opt) !== 'undefined') {
                        methods.fillDropdown(this.el, opt);
                    }

                    return this.el.options;
                },
                validation: function (doValidation) {
                    var index, that = this;
                    if (validators || validators.manager) {
                        index = -1;
                        validators.manager.get_validators().forEach(function (e, i) {
                            if (e._target === that.el.identify()) {
                                index = i;
                            }
                        });

                        if (doValidation) {
                            if (index === -1) {
                                validators.manager.get_validators().push(validators.targetPagePlaceholderValidator);
                            }
                        } else {
                            if (index >= 0) {
                                validators.manager.get_validators().splice(index, 1);
                            }
                        }
                    }

                    return this;
                }
            },
            targetNamedList:{
                el: $('TargetNamedList'),
                options: function (opt) {
                    if (typeof (opt) !== 'undefined') {
                        methods.fillDropdown(this.el, opt);
                    }

                    return this.el.options;
                },
                validation: function (doValidation) {
                    var index, that = this;
                    if (validators || validators.manager) {
                        index = -1;
                        validators.manager.get_validators().forEach(function (e, i) {
                            if (e._target === that.el.identify()) {
                                index = i;
                            }
                        });

                        if (doValidation) {
                            if (index === -1) {
                                validators.manager.get_validators().push(validators.targetNamedListValidator);
                            }
                        } else {
                            if (index >= 0) {
                                validators.manager.get_validators().splice(index, 1);
                            }
                        }
                    }

                    return this;
                }
            },
            confirmPage: {
                el: new Dynamicweb.Items.ParagraphSettings.LinkManager({ id: 'ConfirmPageID', areaId: parameters.areaId }),
                value: function (areaId, id, structureType, title) {
                    return this.el.value(areaId, id, structureType, title);
                }
            },
            contentStructure: {
                el: $$('input[name="ContentStructure"]'),
                value: function() {
                    return this.el.find(function(c) { return c.checked; }).value;
                }
            },
            contentCreationStatus: {
                el: $$('input[name="ContentCreationStatus"]'),
                optionUnpublished: $$('input[name="ContentCreationStatus"][value="1"]')[0],
                optionHidden: $$('input[name="ContentCreationStatus"][value="2"]')[0],
                value: function (val) {
                    if (typeof(val) !== 'undefined') {
                        this.el.each(function (c) { c.checked = false; });
                        this.el.find(function (c) { return c.value === val; }).checked = true;
                    }

                    return this.el.find(function (c) { return c.checked; }).value;
                }
            },
            providers: function() {
                var el = $('Providers');
                
                return {                    
                    el: el,
                    array: el.value.split(';'),
                    value: function (val) {
                    
                        if (typeof(val) !== 'undefined') {
                            this.el.value = val;
                        }

                        return this.el.value;
                    }
                };
            }(),
            overlay: new overlay('ParagraphEditModuleOverlay'),
            btnSave: {
                el: (function() {
                    var ret = null;
                    if (top && top.right) {
                        ret = top.right.$('Save');
                    }

                    return ret;
                })()
            },
            btnSaveAndClose: {
                el: (function() {
                    var ret;
                    if (top && top.right) {
                        ret = top.right.$('Save');
                    } else {
                        ret = $$('#cmdSaveAndClose a')[0];
                    }

                    return ret;
                })()
            },
        };

        validators = {
            manager: new Dynamicweb.Validation.ValidationManager(),
            targetPagePlaceholderValidator: function () {
                var el, message, id;
                el = controls.targetPagePlaceholder.el;
                message = el.readAttribute('data-validation-message');
                id = el.identify();

                return new Dynamicweb.Validation.RequiredFieldValidator(id, message);
            }(),
            targetNamedListValidator: function () {
                var el, message, id;
                el = controls.targetNamedList.el;
                message = el.readAttribute('data-validation-message');
                id = el.identify();

                return new Dynamicweb.Validation.RequiredFieldValidator(id, message);
            }(),
            itemListValidator: function () {
                var el, message, id;
                el = controls.itemList.el;
                message = el.readAttribute('data-validation-message');
                id = el.identify();

                return new Dynamicweb.Validation.RequiredFieldValidator(id, message);
            }(),
            checkItemRestrictions: function (callback) {
                if (controls.itemList.value() !== '') {
                    methods.getAllowedItems(function (result) {
                        var isValid = true;

                        if (!result[controls.itemList.value()]) {
                            isValid = false;
                        }

                        if (callback) {
                            callback({ isValid: isValid });
                        }
                    });
                } else {
                    if (callback) {
                        callback({ isValid: true });
                    }
                }
            },
            checkForm: function (callback) {
                this.manager.beginValidate(callback);
            }
        };

        $$('[data-validation]').each(function (el) {
            var message = el.readAttribute('data-validation-message');

            if (el.hasAttribute('data-validation-required')) {
                validators.manager.addValidator(new Dynamicweb.Validation.RequiredFieldValidator(el.identify(), message));
            }

            if (el.hasAttribute('data-validation-minLength') || el.hasAttribute('data-validation-maxLength')) {
                validators.manager.addValidator(new Dynamicweb.Validation.LengthValidator(el.identify(), message, el.readAttribute('data-validation-minLength'), el.readAttribute('data-validation-maxLength'), true));
            }
        });

        // paragraphs
        if (controls.contentStructure.value() === '1') {
            controls.targetPagePlaceholder.validation(true);
        }
        
        if (params.targetPage) {
            controls.targetPage.value(params.targetPage.areaId, params.targetPage.id, params.targetPage.structureType, params.targetPage.title);
        }
        
        if (params.confirmPage) {
            controls.confirmPage.value(params.confirmPage.areaId, params.confirmPage.id, params.confirmPage.structureType, params.confirmPage.title);
        }
        
        eventHandlers = {
            onSave: function (callback) {
                return function () {
                    validators.checkForm(function (result) {
                        if (result.isValid) {
                            controls.providers.value(controls.providers.array.join(';'));

                            if (result.isValid && callback) {
                                validators.checkItemRestrictions(function (result) {
                                    if (result.isValid && callback) {
                                        callback();
                                    }
                                });
                            }
                        }

                    });
                };
            },
            onItemTypeChange: function () {
                //update fields if item type changed
                var updateFields = function () {
                    controls.mailProviderItemFieldLists.el.forEach(function (element) {
                        var mainControl = $(element.name.substring(0, element.name.length - 'ItemField'.length))
                        mainControl.removeAttribute('readOnly');
                        mainControl.setStyle({
                            backgroundColor: 'white'
                        });
                    })
                };
                if (controls.itemList.value() !== '') {
                    methods.getItemFields(function (result) {
                        controls.mailProviderItemFieldLists.setOptions(result);
                        controls.mailSaveProviderItemType.value(controls.itemList.value());
                        controls.mailReceiptSaveProviderItemType.value(controls.itemList.value());
                        updateFields();
                    });
                } else {
                    controls.mailProviderItemFieldLists.setOptions();
                    controls.mailSaveProviderItemType.value('');
                    controls.mailReceiptSaveProviderItemType.value('');
                    updateFields();
                }
            },
            // action on changing ItemField for MailProviders
            onMailProviderItemFieldChange: function () {
                controls.mailProviderItemFieldLists.el.forEach(function (element) {
                    var mainControl = $(element.name.substring(0, element.name.length - 'ItemField'.length))
                    if (element.selectedIndex > 0) {
                        mainControl.setAttribute('readOnly', 'readOnly');
                        mainControl.setStyle({
                            backgroundColor: '#EBEBE4'
                        });
                    } else {
                        mainControl.removeAttribute('readOnly');
                        mainControl.setStyle({
                            backgroundColor: 'white'
                        });
                    }
                })
            },
            onStructureTypeChange: function () {
                var val = controls.contentStructure.value();
                methods.getAllowedItems(function (result) {
                    var val, option;
                    val = controls.itemList.value()
                    controls.itemList.options(result);

                    // restore previous value
                    if (result[val]) {
                        controls.itemList.value(val);
                    } else {
                        eventHandlers.onItemTypeChange();
                    }
                });


                if (val === '0') {
                    controls.targetPagePlaceholder.validation(false);
                    controls.targetPagePlaceholder.el.up('tr').hide();
                    controls.targetNamedList.validation(false);
                    controls.targetNamedList.el.up('tr').hide();
                    controls.itemList.validation(true);
                    controls.itemList.el.up('tr').show();
                    controls.contentCreationStatus.optionUnpublished.up('tr').show();
                    controls.contentCreationStatus.optionHidden.up('tr').show();
                } else if (val === '1') {
                    controls.targetPagePlaceholder.validation(true);
                    controls.targetPagePlaceholder.el.up('tr').show();
                    controls.targetNamedList.validation(false);
                    controls.targetNamedList.el.up('tr').hide();
                    controls.itemList.validation(true);
                    controls.itemList.el.up('tr').show();
                    controls.contentCreationStatus.optionUnpublished.up('tr').show();
                    controls.contentCreationStatus.optionHidden.up('tr').hide();

                    if (controls.contentCreationStatus.value() === '2') {
                        controls.contentCreationStatus.value('1');
                    }
                } else if (val === '2') {
                    controls.targetPagePlaceholder.validation(false);
                    controls.targetPagePlaceholder.el.up('tr').hide();
                    controls.targetNamedList.validation(true);
                    controls.targetNamedList.el.up('tr').show();
                    controls.itemList.validation(false);
                    controls.itemList.el.up('tr').hide();
                    controls.contentCreationStatus.optionUnpublished.up('tr').hide();
                    controls.contentCreationStatus.optionHidden.up('tr').hide();

                    controls.contentCreationStatus.value('0');
                    methods.getNamedLists(function (result) {
                        controls.targetNamedList.options(result);
                    });
                }

            },
            onProviderChange: function (model) {
                var control = this;
                if (!model) {
                    if (control.checked) {
                        if (!controls.providers.array.any(function (v) { return v === control.value; })) {
                            controls.providers.array.push(control.value);
                        }
                    } else {
                        controls.providers.array = controls.providers.array.reject(function (v) { return v === control.value; });
                    }
                } else {
                    if (model.checked) {
                        control.show();
                    } else {
                        control.hide();
                    }
                }
            },
            onTargetPageChange: function () {
                methods.getAllowedItems(function (result) {
                    var val = controls.itemList.value();
                    controls.itemList.options(result);

                    // restore previous value
                    if (result[val]) {
                        controls.itemList.value(val);
                    } else {
                        eventHandlers.onItemTypeChange();
                    }
                });

                methods.getPlaceHolders(function (result) {
                    controls.targetPagePlaceholder.options(result);
                });
                if (controls.contentStructure.value() === '2') {
                    methods.getNamedLists(function (result) {
                        controls.targetNamedList.options(result);
                    });
                }
            },
            onTargetPlaceholderChange: function () {
                methods.getAllowedItems(function (result) {
                    var val = controls.itemList.value();
                    controls.itemList.options(result);

                    // restore previous value
                    if (result[val]) {
                        controls.itemList.value(val);
                    } else {
                        eventHandlers.onItemTypeChange();
                    }
                });
            }
        };

        eventRouter = function (event, element) {
            var id = element.identify(),
                action = eventHandlers[element.readAttribute('data-' + event.type + '-action')],
                isModel = element.hasAttribute('data-model'),
                modelId = element.readAttribute('data-model') || id;

            if (action) {
                action.apply(element);
            }

            if (isModel && modelHandlers[modelId] && modelHandlers[modelId][event.type]) {
                if (Array.isArray(modelHandlers[modelId][event.type])) {
                    modelHandlers[modelId][event.type].each(function (subscriber) {
                        if (typeof (subscriber.handler) === 'function') {
                            subscriber.handler.apply(subscriber.element, [element]);
                        }
                    });
                }
            }
        };
        
        // overrides on click event handler
        if (controls.btnSave.el) {
            controls.btnSave.el.onclick = eventHandlers.onSave(controls.btnSave.el.onclick);
        }
        
        // overrides on click event handler
        if (controls.btnSaveAndClose.el) {
            controls.btnSaveAndClose.el.onclick = eventHandlers.onSave(controls.btnSaveAndClose.el.onclick);
        }

        if (controls.targetPage.el) {
            controls.targetPage.el.onValueSelected(eventHandlers.onTargetPageChange);
            controls.targetPage.el.onValueCleared(eventHandlers.onTargetPageChange);
        }

        // defines MailProvider ItemField selectors
        if ((controls.mailSaveProviderItemType.el.value === '' || controls.mailReceiptSaveProviderItemType.el.value === '') && controls.itemList.el.selectedIndex > 0) {
            eventHandlers.onItemTypeChange();
        };
        controls.mailProviderItemFieldLists.el.forEach(function (element) {
            element.setAttribute('data-change-action', 'onMailProviderItemFieldChange');
            if (element.selectedIndex > 0) {
                var mainControl = $(element.name.substring(0, element.name.length - 'ItemField'.length))
                mainControl.setAttribute('readOnly', 'readOnly');
                mainControl.setStyle({
                    backgroundColor: '#EBEBE4'
                });
            };
        }); 

        document.on('click', '[data-click-action]', eventRouter);
        document.on('change', '[data-change-action], [data-model]', eventRouter);

        $$('[data-bind-model]').each(function (element) {
            var models = [],
                clickHandlers = [],
                changeHandlers = [],
                subscribe = function (id, eventName, handlerName) {
                    var handler;
                    if (!id || !eventName || !handlerName) {
                        return;
                    }

                    id = id.strip();
                    handlerName = handlerName.strip();

                    handler = eventHandlers[handlerName];
                    
                    if (!handler) {
                        handler = methods[handlerName];
                        
                        if (!handler) {
                            return;
                        }
                    }

                    if (!modelHandlers) {
                        modelHandlers = {};
                    }

                    if (!modelHandlers[id]) {
                        modelHandlers[id] = {};
                    }

                    if (!modelHandlers[id][eventName] || !Array.isArray(modelHandlers[id][eventName])) {
                        modelHandlers[id][eventName] = [];
                    }

                    modelHandlers[id][eventName].push({
                        element: element,
                        handler: handler
                    });
                };
            
            if (element.hasAttribute('data-bind-model')) {
                models = element.readAttribute('data-bind-model').split(',');
            }
            
            if (element.hasAttribute('data-click-model')) {
                clickHandlers = element.readAttribute('data-click-model').split(',');
            }
            
            if (element.hasAttribute('data-change-model')) {
                changeHandlers = element.readAttribute('data-change-model').split(',');
            }

            models.each(function (model, index) {
                subscribe(model, 'change', changeHandlers[index]);
                subscribe(model, 'click', clickHandlers[index]);
            });
        });

        self.get_translation = function(key) {
            return parameters.translations[key] || '';
        };
    }
});

Dynamicweb.Items.ParagraphSettings._instance = null;

Dynamicweb.Items.ParagraphSettings.get_current = function () {
    return Dynamicweb.Items.ParagraphSettings._instance;
};

Dynamicweb.Items.ParagraphSettings.LinkManager = Class.create({
    initialize: function(options) {
        var self = this, parameters, value, 
            controls, methods, subscribers, 
            eventHandlers, eventRouter, isEnabled = true;
        
        if (!options || !options.id || !options.areaId) {
            throw 'Invalid initialization parameters!';
        }

        parameters = { id: options.id, areaId: options.areaId };
        
        value = { title: '', areaId: '', id: '', structureType: '' };

        controls = {
            wrapper: {
                el: $(parameters.id + '_Control')
            },
            view: {
                el: $$('#' + parameters.id + '_Control input[type="text"]')[0],
                value: function(val) {
                    if (typeof(val) !== 'undefined') {
                        this.el.value = val;
                    }
                    
                    return this.el.value;
                },
                enabled: function(val) {
                    if (typeof(val) === 'boolean') {
                        if (val) {
                            this.el.removeAttribute('disabled');
                        } else {
                            this.el.writeAttribute('disabled', 'disabled');
                        }
                    }

                    return !this.el.hasAttribute('disabled');
                }
            },
            storage: {
                el: $(parameters.id),
                value: function(val) {
                    if (typeof(val) !== 'undefined') {
                        this.el.value = val;
                    }

                    return this.el.value;
                }
            },
            selector: {
                el: $(parameters.id + '_Selector'),
                getValue: function () {
                    var res = {},
                        getValue = function(element, field) {
                            var ret = '',
                                paragraph = 'data-paragraph-' + field,
                                page = 'data-page-' + field;
                    
                            if (element.readAttribute(paragraph)) {
                                ret = element.readAttribute(paragraph);
                            } else if (element.readAttribute(page)) {
                                ret = element.readAttribute(page);
                            }

                            return ret;
                        };

                    res.areaId = this.el.readAttribute('data-area-id');
                    res.id = getValue(this.el, 'id');
                    res.title = getValue(this.el, 'name');
                    
                    if (this.el.hasAttribute('data-paragraph-id')) {
                        res.structureType = 'paragraph';
                    } else {
                        res.structureType = 'page';
                    }

                    return res;
                },
                clearValue: function() {
                    this.el.writeAttribute('data-area-id', '');
                    this.el.writeAttribute('data-area-name', '');
                    this.el.writeAttribute('data-page-id', '');
                    this.el.writeAttribute('data-page-name', '');
                    this.el.writeAttribute('data-paragraph-id', '');
                    this.el.writeAttribute('data-paragraph-name', '');
                }
            }
        };

        subscribers = {};

        methods = {
            select: function(showParagraphs) {
                var url, width, height;

                width = showParagraphs ? 908 : 250;
                height = showParagraphs ? 375 : 450;

                url =
                    "/Admin/Menu.aspx?ID=0&Action=Internal" +
                        "&strShowParagraphsOption=" + (showParagraphs ? 'on' : 'off') +
                        "&showparagraphs=" + (showParagraphs ? 'on' : 'off') +
                        "&Caller=" + controls.selector.el.identify() +
                        "&AreaID=" + parameters.areaId;

                window.open(url, '_new', 'resizable=true,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=' + width + ',height=' + height + ',top=155,left=202');
            },
            value: function (areaId, id, structureType, title) {
                if (typeof(areaId) !== 'undefined'
                    && typeof(id) !== 'undefined'
                    && typeof(structureType) !== 'undefined'
                    && typeof(title) !== 'undefined') {

                    value.areaId = areaId;
                    value.id = id;
                    value.structureType = structureType;
                    value.title = title;

                    // update controls
                    controls.view.value(title);
                    controls.storage.value(id);

                    methods.fire('change', value);
                }

                return value;
            },
            on: function (eventName, eventHandler) {
                eventName = eventName || 'any';
                if (!subscribers[eventName]) {
                    subscribers[eventName] = [];
                }

                subscribers[eventName].push(eventHandler);
            },
            off: function(eventName, eventHandler) {
                var i, max, subs;
                eventName = eventName || 'any';

                if (!subscribers[eventName]) {
                    return;
                }

                subs = subscribers[eventName];
                max = subs.length;

                for (i = 0; i < max; i += 1) {
                    if (subs[i] === eventHandler) {
                        subs.pull(i);
                    }
                }
            },
            fire: function(eventName, args) {
                var i, max, subs;
                eventName = eventName || 'any';

                if (!subscribers[eventName]) {
                    return;
                }

                subs = subscribers[eventName];
                max = subs.length;

                for (i = 0; i < max; i += 1) {
                    subs[i](eventName, args);
                }
            },
            enabled: function(val) {
                if (typeof (val) === 'boolean') {
                    isEnabled = val;
                    controls.view.enabled(val);

                    // on disable clear value
                    if (!val) {
                        methods.value('', '', '', '');
                    }
                }

                return isEnabled;
            },
            initValues: function() {
                var val = controls.selector.getValue();
                methods.value(val.areaId, val.id, val.structureType, val.title);
                controls.selector.clearValue();
            }
        };

        eventHandlers = {
            selectPage: function() {
                methods.select(false);
            },
            selectParagraph: function() {
                methods.select(true);
            },
            clear: function() {
                methods.value('', '', '', '');
                methods.fire('clear');
            },
            onSelect: function () {
                methods.initValues();
                methods.fire('select', methods.value());
            }
        };
        
        eventRouter = function (event, element) {
            var action;

            if (!self.enabled()) {
                return;
            }

            action = eventHandlers[element.readAttribute('data-action')];

            if (action) {
                action.apply(element);
            }
        };

        controls.wrapper.el.on('click', '[data-action]', eventRouter);
        controls.selector.el.on('link-manager:changed', eventHandlers.onSelect);

        /// public methods
        self.value = function(areaId, id, structureType, title) {
            return methods.value(areaId, id, structureType, title);
        };

        self.onValueChanged = function(eventHandler) {
            methods.on('change', eventHandler);
        };

        self.offValueChanged = function (eventHandler) {
            methods.off('change', eventHandler);
        };

        self.onValueSelected = function(eventHandler) {
            methods.on('select', eventHandler);
        };
        
        self.offValueSelected = function (eventHandler) {
            methods.off('select', eventHandler);
        };
        
        self.onValueCleared = function (eventHandler) {
            methods.on('clear', eventHandler);
        };

        self.offValueCleared = function (eventHandler) {
            methods.off('clear', eventHandler);
        };

        self.enabled = function(val) {
            return methods.enabled(val);
        };
    }
});