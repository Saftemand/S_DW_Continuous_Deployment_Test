if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = {};
}

if (typeof (Dynamicweb.Managment) == 'undefined') {
    Dynamicweb.Managment = {};
}

if (typeof (Dynamicweb.Managment.Ecom) == 'undefined') {
    Dynamicweb.Managment.Ecom = {};
}

if (typeof (Dynamicweb.Managment.Ecom.AdvConfig) == 'undefined') {
    Dynamicweb.Managment.Ecom.AdvConfig = {};
}

if (typeof (Dynamicweb.Managment.Ecom.AdvConfig.Prices) == 'undefined') {
    Dynamicweb.Managment.Ecom.AdvConfig.Prices = {};
    Dynamicweb.Managment.Ecom.AdvConfig.Prices.Forms = {};

    Dynamicweb.Managment.Ecom.AdvConfig.Prices.Forms.SelectColumnsDialog = Class.create({
        initialize: function (settings) {
            this.id = 'ColumnsSelector';
            this.el = $(this.id);
            this.isOpened = false;
            this.toggler = this.el.select('.list-header input')[0];
            this.source = settings.items;
            this.list = this.el.select('.list-content ul')[0];
            this.settings = settings || {};
            this.callback = function() { };

            var that = this;
            this.el.on('click', '.dialog-button-ok', function () {
                var values = {};
                that.list.select('input:checked').each(function (i) {
                    values[i.readAttribute('data-value')] = i.readAttribute('data-text');
                });

                that.callback(values);
                that.close();
            });
            this.el.on('click', '.dialog-button-cancel, .close', this.close.bind(this));
            if (Prototype.Browser.IE) {
                this.toggler.on('click', this.toggle.bind(this));
            } else {
                this.toggler.on('change', this.toggle.bind(this));
            }
        },
        
        bind: function (values, selected) {
            if (!values) {
                return;
            }
            
            var that = this,
                childCount = that.list.childNodes.length - 1;
            for (var i = childCount; i >= 0; i--) {
                that.list.childNodes[i].remove(0);
            }
            
            var method = function (value, text) {
                var check = new Element('input');
                check.writeAttribute('data-value', value);
                check.writeAttribute('data-text', text);
                check.type = 'checkbox';
                
                var span = new Element('span');
                span.innerHTML = text;
                
                var item = new Element('li');
                item.appendChild(check);
                item.appendChild(span);

                return item;
            };

            for (var field in values) {
                var exists = selected && selected[field];

                if (!exists) {
                    that.list.appendChild(method(field, values[field]));
                }
            }
        },
        
        toggle: function () {
            var that = this;
            this.list.select('input').each(function (e) {
                e.checked = that.toggler.checked;
            });
        },
        
        open: function (selected, callback) {
            if (!this.isOpened) {
                this.isOpened = true;
                this.bind(this.source, selected);
                this.callback = callback;

                dialog.show(this.id);
            }
        },
        
        close: function (event) {
            if (!event) {
                dialog.hide(this.id);
            }
            this.isOpened = false;
        }
    });

    Dynamicweb.Managment.Ecom.AdvConfig.Prices.Forms.Main = Class.create({
        initialize: function (settings) {
            var that = this;
            var toolbar = SettingsPage.getInstance();
            toolbar.onSave = function () {
                that.save(toolbar.submit);
            };
            toolbar.onHelp = settings.help;

            this.initilized = false;
            this.translations = settings.translations;
            that.overlay = new overlay('__ribbonOverlay');

            this.allColumns = [];
            this.displayedColumns = [];
            this.orderColumns = [];
            
            //hack due to there is no possibility to remove overlay if form doesn't valid
            var btnSave = $('cmdSave').select('.toolbar-button')[0];
            btnSave.removeAttribute('onclick');
            btnSave.on('click', function() {
                toolbar.save();
            });

            var btnSaveAndClose = $('cmdSaveAndClose').select('.toolbar-button')[0];
            btnSaveAndClose.removeAttribute('onclick');
            btnSaveAndClose.on('click', function() {
                toolbar.saveAndClose();
            });
            
            that.customColumnsHidden = $('/Globalsettings/Ecom/Price/List/CustomColumns');
            that.customColumnsCheck = $('/Globalsettings/Ecom/Price/List/UseCustomColumns');
            that.customColumnsList = $('custom-columns');
            that.toggleList(that.customColumnsCheck, that.customColumnsList);

            that.customOrderHidden = $('/Globalsettings/Ecom/Price/List/CustomOrder');
            that.customOrderCheck = $('/Globalsettings/Ecom/Price/List/UseCustomOrder');
            that.customOrderList = $('custom-order');
            that.toggleList(that.customOrderCheck, that.customOrderList);

            // add event listeners            
            document.on('click', 'td.list-content ul li', that.selectItem);
            document.on('click', '[data-action*=]', function (event, element) {
                var action = that[element.readAttribute('data-action')];
                var source = that[element.readAttribute('data-source')];

                if (action) {
                    action.apply(that, [element, source]);
                }
            });

            var callback = function() {           
                that.dialog = new Dynamicweb.Managment.Ecom.AdvConfig.Prices.Forms.SelectColumnsDialog({ items: that.allColumns });
                that.addItem(that.customColumnsList, that.displayedColumns);
                that.addItem(that.customOrderList, that.orderColumns);
                that.initilized = true;
            };

            this.bind(callback);
        },
        
        request: function (params, callback) {
            var that = this;
            if (!params) {
                params = {};
            }

            params['IsAjax'] = 'True';

            new Ajax.Request('/Admin/Module/eCom_Catalog/dw7/edit/EcomAdvConfigPrices_Edit.aspx', {
                method: 'POST',
                parameters: params,
                onCreate: function() {
                    that.overlay.show();
                },
                onSuccess: function(response) {
                    if (callback) {
                        callback(response.responseText);
                    }
                },
                onFailure: function() {
                    alert(that.translations['RequestError']);
                },
                onComplete: function () {
                    that.overlay.hide();
                }
            });
        },

        bind: function (callback) {
            var that = this;
            var onSuccess = function(text) {
                if (!text.isJSON()) {
                    return;
                }

                var wrapper = text.evalJSON();

                if (!wrapper.Error) {
                    that.displayedColumns = wrapper.Displayed;
                    that.orderColumns = wrapper.Order;
                    that.allColumns = wrapper.All;

                    if (callback) {
                        callback();
                    }
                } else {
                    alert(that.translations['RequestError']);
                }
            };

            this.request({ Action: 'GetColumns' }, onSuccess);
        },
        
        updateList: function (list) {
            if (!list.hasAttribute('disabled')) {
                Sortable.destroy(list);
                Sortable.create(list);
            }
        },

        toggleList: function (check, list) {
            if (check.checked) {
                list.removeAttribute('disabled');
                list.addClassName('enabled');
                
                Position.includeScrollOffsets = true;
                Sortable.create(list);
            } else {
                list.writeAttribute('disabled');
                list.removeClassName('enabled');
                Sortable.destroy(list);
            }
        },
        
        selectItem: function (event, item) {
            var list = item.parentElement;
            if (list.readAttribute('disabled')) {
                return;
            }

            list.select('li').each(function(i) {
                i.removeClassName('selected');
            });

            item.addClassName('selected');
        },
        
        removeItem: function (caller, list) {
            if (list.readAttribute('disabled')) {
                return;
            }
            
            var item = list.select('.selected')[0];
            if (item) {
                item.remove();   
            }
        },
        
        addItem: function (list, values) {
            for (var field in values) {
                var item = new Element('li');
                item.writeAttribute('data-value', field);
                //take value from general collection due to it contains translated field titles.
                item.innerHTML = this.allColumns[field];

                list.appendChild(item);
            }

            this.updateList(list);
        },
        
        openDialog: function (caller, list) {
            if (list.readAttribute('disabled')) {
                return;
            }

            var that = this;
            var items = this.listContentAsObject(list);
            
            that.dialog.open(items, function (values) {
                that.addItem(list, values);
            });
        },
        
        listContentAsArray: function(list) {
            var items = [],
                childCount = list.children.length;

                for (var i = 0; i < childCount; i++) {
                    var item = list.children[i];
                    items.push(item.readAttribute('data-value'));
                }
            
            return items;
        },

        listContentAsObject: function (list) {
            var items = {},
                childCount = list.children.length;

            for (var i = 0; i < childCount; i++) {
                var item = list.children[i];

                    items[item.readAttribute('data-value')] = item.innerHTML;
            }

            return items;
        },
        
        validate: function (onValid, onInvalid) {
            var isValid = true;
            var customColumns = this.listContentAsArray(this.customColumnsList);
            var customOrder = this.listContentAsArray(this.customOrderList);

            if (this.customColumnsCheck.checked && customColumns.length === 0) {
                alert(this.translations['CustomColumnsEmpty']);
                isValid = false;
            }

            if (this.customOrderCheck.checked && customOrder.length === 0) {
                alert(this.translations['CustomOrderEmpty']);
                isValid = false;
            }

            if (isValid) {
                if (onValid) {
                    onValid({ customColumns: customColumns, customOrder: customOrder });
                }
            } else {
                if (onInvalid) {
                    onInvalid();
                }
            }
        },
        
        save: function (callback) {
            var that = this;
            that.overlay.show();

            var onValid = function(parameters) {
                if (that.customColumnsCheck.checked) {
                    that.customColumnsHidden.value = parameters.customColumns.join();
                }

                if (that.customOrderCheck.checked) {
                    that.customOrderHidden.value = parameters.customOrder.join();
                }

                if (callback) {
                    callback();
                }
            },
                onInvalid = function() {
                    that.overlay.hide();
                };

            this.validate(onValid, onInvalid);
        }
    });
}