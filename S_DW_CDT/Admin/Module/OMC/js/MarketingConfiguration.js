/* ++++++ Registering namespace ++++++ */

if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Controls) == 'undefined') {
    Dynamicweb.Controls = new Object();
}

if (typeof (Dynamicweb.Controls.OMC) == 'undefined') {
    Dynamicweb.Controls.OMC = new Object();
}

/* ++++++ End: Registering namespace ++++++ */

Dynamicweb.Controls.OMC.MarketingConfiguration = function () {
    /// <summary>Represents a marketing configuration.</summary>

    this._hostingWindow = '';
    this._container = '';

    this._settings = [
        { type: 'ContentRestriction', baseUrl: '/Admin/Module/OMC/Profiles/ContentRestrictionEdit.aspx', width: 600, height: 465 },
        { type: 'ProfileDynamics', baseUrl: '/Admin/Module/OMC/Profiles/ProfileDynamicsEdit.aspx', width: 600, height: 415 }
    ]
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.get_container = function () {
    /// <summary>Gets the identifier of the DOM element associated with this control.</summary>

    return this._container;
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.set_container = function (value) {
    /// <summary>Sets the identifier of the DOM element associated with this control.</summary>
    /// <param name="value">The identifier of the DOM element associated with this control.</param>

    this._container = value;
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.get_hostingWindow = function () {
    /// <summary>Gets the reference to PopUpWindow control that should hold the UI for the settings.</summary>

    var ret = null;

    if (this._hostingWindow) {
        if (typeof (this._hostingWindow) == 'string') {
            try {
                ret = eval(this._hostingWindow);
            } catch (ex) { }

            if (ret) {
                this._hostingWindow = ret;
            }
        } else {
            ret = this._hostingWindow;
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.set_hostingWindow = function (value) {
    /// <summary>Sets the reference to PopUpWindow control that should hold the UI for the settings.</summary>
    /// <param name="value">The reference to PopUpWindow control that should hold the UI for the settings.</param>

    this._hostingWindow = value;
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.add_ready = function (callback) {
    /// <summary>Registers new callback which is executed when the page is loaded.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }
    Event.observe(document, 'dom:loaded', function () {
        callback(this, {});
    });
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.registerSettings = function (settings) {
    /// <summary>Registers a new settings type.</summary>
    /// <param name="settings">Settings object.</param>

    if (settings && settings.type && settings.type.length) {
        this.unregisterSettings(settings.type);
        this._settings[this._settings.length] = settings;
    }
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.unregisterSettings = function (type) {
    /// <summary>Unregisters the existing settings.</summary>
    /// <param name="type">Settings type.</param>

    var newSettings = [];

    if (type && type.length) {
        for (var i = 0; i < this._settings.length; i++) {
            if (this._settings[i].type.toLowerCase() != type.toLowerCase()) {
                newSettings[newSettings.length] = this._settings[i];
            }
        }

        this._settings = newSettings;
    }
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.getSettings = function (type) {
    /// <summary>Returns settings of the given type.</summary>
    /// <param name="type">Settings type.</param>

    var ret = null;

    if (type && type.length) {
        for (var i = 0; i < this._settings.length; i++) {
            if (this._settings[i].type.toLowerCase() == type.toLowerCase()) {
                ret = this._settings[i];
                break;
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.openSettings = function (type, params) {
    /// <summary>Opens the settings dialog.</summary>
    /// <param name="type">Settings type.</param>
    /// <param name="params">Additional parameters.</param>
    
    var url = '';
    var queryParams = [];
    var settings = this.getSettings(type);
    var dialog = this.get_hostingWindow();

    params = params || {};

    if (settings && dialog) {
        url = settings.baseUrl || '';

        if (params.baseUrl) {
            url = params.baseUrl;
        }

        if (params.data) {
            for (var prop in params.data) {
                if (typeof (params.data[prop]) != 'function') {
                    queryParams[queryParams.length] = prop + '=' + encodeURIComponent(params.data[prop]);
                }
            }

            if (queryParams.length) {
                if (url.indexOf('?') < 0) {
                    url += '?';
                }

                for (var i = 0; i < queryParams.length; i++) {
                    url += queryParams[i];
                    if (i < (queryParams.length - 1)) {
                        url += '&';
                    }
                }
            }
        }

        if (params.width) {
            dialog.set_width(parseInt(params.width));
        } else if (settings.width) {
            dialog.set_width(parseInt(settings.width));
        }

        if (params.height) {
            dialog.set_height(parseInt(params.height));
        } else if (settings.height) {
            dialog.set_height(parseInt(settings.height));
        }

        dialog.set_contentUrl(url);
        dialog.get_operationIndicator().hide();
        dialog.show();
    }
}

Dynamicweb.Controls.OMC.MarketingConfiguration.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>

    if (!this._initialized) {
        this._initialized = true;
    }
}