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

/// <summary>Represents a control display mode.</summary>
Dynamicweb.Controls.OMC.LeadsListDisplayMode = {
    
    /// <summary>Normal display mode.</summary>
    Normal: 0,

    /// <summary>Compact display mode.</summary>
    Compact: 1
}

Dynamicweb.Controls.OMC.LeadsListCulture = function (params) {
    /// <summary>Provides culture-sensitive information for the LeadsList control.</summary>
    /// <param name="params">Initialization parameters.</param>

    this._dateFormat = 'dd-MM-yyyy';
    this._thousandSeparator = ',';
    this._dateFormatter = null;
    this._clockFormat = '24h';

    if (params) {
        if (typeof (params.dateFormat) != 'undefined') {
            this.set_dateFormat(params.dateFormat);
        }

        if (typeof (params.thousandSeparator) != 'undefined') {
            this.set_thousandSeparator(params.thousandSeparator);
        }

        if (typeof (params.clockFormat) != 'undefined') {
            this.set_clockFormat(params.clockFormat);
        }
    }
}

Dynamicweb.Controls.OMC.LeadsListCulture.prototype.get_dateFormat = function () {
    /// <summary>Gets the date format.</summary>

    return this._dateFormat;
}

Dynamicweb.Controls.OMC.LeadsListCulture.prototype.set_dateFormat = function (value) {
    /// <summary>Sets the date format.</summary>
    /// <param name="value">Date format.</param>

    this._dateFormat = value;
    this._dateFormatter = null;
}

Dynamicweb.Controls.OMC.LeadsListCulture.prototype.get_thousandSeparator = function () {
    /// <summary>Gets the thousand separator.</summary>

    return this._thousandSeparator;
}

Dynamicweb.Controls.OMC.LeadsListCulture.prototype.set_thousandSeparator = function (value) {
    /// <summary>Sets the thousand separator.</summary>
    /// <param name="value">Thousand separator.</param>

    this._thousandSeparator = value;
}

Dynamicweb.Controls.OMC.LeadsListCulture.prototype.get_clockFormat = function () {
    /// <summary>Gets the clock format.</summary>

    return this._clockFormat;
}

Dynamicweb.Controls.OMC.LeadsListCulture.prototype.set_clockFormat = function (value) {
    /// <summary>Sets the clock format.</summary>
    /// <param name="value">Clock format.</param>

    this._clockFormat = value;
}

Dynamicweb.Controls.OMC.LeadsListCulture.prototype.get_dateFormatter = function () {
    /// <summary>Sets the date formatter.</summary>

    if (!this._dateFormatter) {
        this._dateFormatter = new Dynamicweb.Controls.OMC.DateSelector.DateFormatter(this.get_dateFormat());
    }

    return this._dateFormatter;
}

Dynamicweb.Controls.OMC.LeadsListCulture.prototype.localize = function (data) {
    /// <summary>Localizes the given data.</summary>
    /// <param name="data">Data to localize.</param>

    var ret = data;

    if (typeof (data) != 'undefined') {
        if (typeof (data.getTime) != 'undefined') {
            ret = this.get_dateFormatter().format(data);
        } else if (typeof (data) == 'number') {
            ret = data.toString();

            if (ret.length > 3) {
                if (ret.length <= 6) {
                    ret = ret.substr(0, ret.length - 3) + this.get_thousandSeparator() + ret.substr(ret.length - 3);
                } else if (ret.length <= 9) {
                    ret = ret.substr(0, ret.length - 6) + this.get_thousandSeparator() + ret.substr(ret.length - 6, 3) + this.get_thousandSeparator() + ret.substr(ret.length - 3);
                }
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList = function (controlID) {
    /// <summary>Represents a list of visitors with an ability to mark certain visitors as leads/not leads.</summary>
    /// <param name="controlID">The unique identifier of the ASP.NET control that is associated with this client object.</param>

    this._associatedControlID = controlID;
    this._container = null;
    this._containerID = this._container;
    this._pageSize = 20;
    this._cache = {};
    this._visitors = null;
    this._binder = null;
    this._isLoading = null;
    this._totalVisitors = 0;
    this._totalServerVisitors = -1;
    this._totalServerVisitorsLoaded = -1;
    this._countryCode = '';
    this._countryName = '';
    this._enableTrace = false;
    this._leadMessage = '';
    this._notLeadMessage = '';
    this._pendingMessage = '';
    this._viewLocationMessage = '';
    this._isTrackingMessage = [];
    this._noneMessage = '';
    this._showVisitsMessage = '';
    this._isEnabled = true;
    this._currentPageIndex = 1;
    this._queue = null;
    this._locationTimeouts = [];
    this._namespace = '';
    this._preloadQueue = null;
    this._isPopulating = false;
    this._removedVisitorsCount = 0;
    this._addedVisitorsCount = 0;
    this._culture = null;
    this._displayMode = 0;
    this._editMode = 0;
    this._visitorStates = [];
    this._visitorStatesBalloon = null;
    this._knownProviders = {};
    this._ignoreISPMessage = '';
    this._searchedForMessage = '';
    this._seeMoreDetailsMessage = '';
    this._leadStatesMessage = '';
    this._otherStatesMessage = '';
    this._sendLeadEmailMessage = '';
    this._sortBy = { field: 'engagement', direction: 'descending' };
    this._sortByIsDirty = false;

    this._handlers = {
        beforeLoad: [],
        afterLoad: [],
        rowPopulated: [],
        afterPopulate: [],
        selectionChanged: [],
        rowClick: [],
        pageIndexChanged: [],
        beforeQueryLocation: [],
        afterQueryLocation: [],
        locationAssigned: [],
        stateChanged: [],
        visitorMarked: [],
        visitorAdded: [],
        visitorRemoved: [],
        totalVisitorsChanged: []
    };
}

/* Represents a global utility object.</summary> */
Dynamicweb.Controls.OMC.LeadsList.Global = new Object();

Dynamicweb.Controls.OMC.LeadsList.Global._locationServiceInitialized = false;
Dynamicweb.Controls.OMC.LeadsList.Global._dateIntervals = null;
Dynamicweb.Controls.OMC.LeadsList.Global._terminology = null;
Dynamicweb.Controls.OMC.LeadsList.Global._elementsCache = {};
Dynamicweb.Controls.OMC.LeadsList.Global._namespaces = {};

Dynamicweb.Controls.OMC.LeadsList.Global.get_locationServiceInitialized = function () {
    /// <summary>Gets value indicating whether geo-location service has been initialized.</summary>

    return Dynamicweb.Controls.OMC.LeadsList.Global._locationServiceInitialized;
}

Dynamicweb.Controls.OMC.LeadsList.Global.set_locationServiceInitialized = function (value) {
    /// <summary>Sets value indicating whether geo-location service has been initialized.</summary>
    /// <param name="value">Value indicating whether geo-location service has been initialized.</param>

    Dynamicweb.Controls.OMC.LeadsList.Global._locationServiceInitialized = !!value;
}

Dynamicweb.Controls.OMC.LeadsList.Global.get_dateIntervals = function () {
    /// <summary>Gets the dictionary containing labels for specific date intervals.</summary>

    if (!Dynamicweb.Controls.OMC.LeadsList.Global._dateIntervals) {
        Dynamicweb.Controls.OMC.LeadsList.Global._dateIntervals = new Hash();
    }

    return Dynamicweb.Controls.OMC.LeadsList.Global._dateIntervals;
}

Dynamicweb.Controls.OMC.LeadsList.Global.get_terminology = function () {
    /// <summary>Gets the dictionary containing translated labels for various UI components.</summary>

    if (!Dynamicweb.Controls.OMC.LeadsList.Global._terminology) {
        Dynamicweb.Controls.OMC.LeadsList.Global._terminology = new Hash();
    }

    return Dynamicweb.Controls.OMC.LeadsList.Global._terminology;
}

Dynamicweb.Controls.OMC.LeadsList.Global.createNamespace = function (associatedControlID) {
    /// <summary>Returns a unique namespace for a given control.</summary>
    /// <param name="associatedControlID">the unique identifier of the ASP.NET control that is associated with this client object.</param>

    var ret = '';
    var count = 0;

    if (associatedControlID) {
        if (Dynamicweb.Controls.OMC.LeadsList.Global._namespaces[associatedControlID]) {
            ret = Dynamicweb.Controls.OMC.LeadsList.Global._namespaces[associatedControlID];
        } else {
            for (var ctrl in Dynamicweb.Controls.OMC.LeadsList.Global._namespaces) {
                count += 1;
            }

            if (count == 0) {
                count = 1;
            }

            ret = 'list' + count + ':';
            Dynamicweb.Controls.OMC.LeadsList.Global._namespaces[associatedControlID] = ret;
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.Global.removeFromArray = function (array, from, to) {
    /// <summary>Removes the given range of elements from the given array.</summary>
    /// <param name="array">Target array.</param>
    /// <param name="from">Start index.</param>
    /// <param name="to">End index.</param>

    var rest = array.slice((to || from) + 1 || array.length);

    array.length = from < 0 ? array.length + from : from;
    array.push.apply(array, rest);

    return array;
}

_DWLeadsListInfoBoxMapCallback = function () {
    /// <summary>Occurs when the Google Maps API finished loading.</summary>
    /// <private />

    Dynamicweb.Controls.OMC.LeadsList.InfoBox.get_current()._mapCallback();
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue = function (owner) {
    /// <summary>Provides methods and properties for queueing of "reload" requests.</summary>

    this._current = null;
    this._owner = owner;
    this._data = [];
    this._completed = [];
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.get_owner = function () {
    /// <summary>Gets the owning list.</summary>

    return this._owner;
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.get_isEmpty = function () {
    /// <summary>Gets value indicating whether queue is empty.</summary>

    return !this._data.length && !this._current;
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.get_onComplete = function () {
    /// <summary>Gets a callback that is executed when all queued requests has been processed.</summary>

    return this._onComplete;
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.set_onComplete = function (value) {
    /// <summary>Sets a new callback that is executed when all queued requests has been processed.</summary>
    /// <param name="value">Callback to set.</param>

    this._onComplete = value;
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.clear = function () {
    /// <summary>Clears the queue.</summary>

    this._data = [];
    this._completed = [];
    this._current = null;
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.enqueue = function (request) {
    /// <summary>Puts the new request into the queue.</summary>
    /// <param name="request">Request to queue.</param>

    if (request) {
        if (this._data.length == 0) {
            this.invoke(request);
        } else if (!this.contains(request)) {
            this._data[this._data.length] = request;

            if (this.get_owner()) {
                this.get_owner().trace('Queued request: page <b>' + request.page + '</b>', 'orange');
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.contains = function (request) {
    /// <summary>Returns value indicating whether the given request is queued already.</summary>
    /// <param name="request">Request to examine.</param>

    var ret = false;

    if (request) {
        if (this._current) {
            ret = this._current.page == request.page;
        }

        if (!ret && this._data.length) {
            for (var i = 0; i < this._data.length; i++) {
                if (this._data[i].page == request.page) {
                    ret = true;
                    break;
                }
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.isCompleted = function (request) {
    /// <summary>Returns value indicating whether the given request was processed before.</summary>
    /// <param name="request">Request to examine.</param>

    var ret = false;

    if (request && this._completed.length) {
        for (var i = 0; i < this._completed.length; i++) {
            if (this._completed[i].page == request.page) {
                ret = true;
                break;
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.dequeue = function () {
    /// <summary>Returns the next queued item and removes it from the queue. By default the queued request will be invoked (asynchronously).</summary>

    var ret = null;

    if (this._data.length > 0) {
        ret = this._data[0];
        this._data = Dynamicweb.Controls.OMC.LeadsList.Global.removeFromArray(this._data, 0);
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.PreloadQueue.prototype.invoke = function (request) {
    /// <summary>Invokes the given request as well as all other queued requests.</summary>
    /// <param name="request">Request to invoke.</param>

    var self = this;

    if (request && this.get_owner()) {
        this.get_owner().trace('Executing queued request: page <b>' + request.page + '</b>', 'green');

        this._current = request;

        this.get_owner().reload({ page: request.page, populate: false, resetPageIndex: false, onComplete: function () {
            self._completed[self._completed.length] = self._current;

            self._current = null;

            if (self._data.length == 0) {
                setTimeout(function () {
                    if (self._data.length == 0) {
                        if (self.get_onComplete()) {
                            self.get_onComplete()(self, {});
                        }
                    } else {
                        self.invoke(self.dequeue());
                    }
                }, 25);
            } else {
                self.invoke(self.dequeue());
            }
        }
        });
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox = function () {
    /// <summary>Represents an information box displaying visitor details.</summary>

    this._container = null;
    this._visitor = null;
    this._layoutCreated = false;
    this._selectorsCache = null;
    this._mapInitialized = false;
    this._mapInitializedCallbacks = [];
    this._hideDelay = null;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox._instance = null;

Dynamicweb.Controls.OMC.LeadsList.InfoBox.get_current = function () {
    /// <summary>Gets the current instance of the info-box.</summary>

    if (!Dynamicweb.Controls.OMC.LeadsList.InfoBox._instance) {
        Dynamicweb.Controls.OMC.LeadsList.InfoBox._instance = new Dynamicweb.Controls.OMC.LeadsList.InfoBox();
    }

    return Dynamicweb.Controls.OMC.LeadsList.InfoBox._instance;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.get_container = function () {
    /// <summary>Gets the DOM element representing outer container of the visitor information box.</summary>

    if (!this._container) {
        this._container = new Element('div', {
            'id': this._generateID('container'),
            'class': 'omc-leads-list-visitor-info'
        });

        this._container.setStyle({ 'display': 'none' });

        Event.observe(document.body, 'mousedown', function (e) {
            var elm = $(Event.element(e));

            if (!elm.hasClassName('omc-leads-list-visitor-info') && !elm.up('.omc-leads-list-visitor-info')) {
                Dynamicweb.Controls.OMC.LeadsList.InfoBox.get_current().hide();
            }
        });

        document.body.appendChild(this._container);
    }

    return this._container;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.get_mapInitialized = function () {
    /// <summary>Gets value indicating whether map component has been initialized.</summary>

    return this._mapInitialized;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.get_visitor = function () {
    /// <summary>Gets the visitor whose information to display.</summary>

    return this._visitor;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.set_visitor = function (value) {
    /// <summary>Sets the visitor whose information to display.</summary>
    /// <param value="value">The visitor whose information to display.</param>

    if (value && value.get_id) {
        this._visitor = value;
    } else {
        this._visitor = null;
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.get_isVisible = function () {
    /// <summary>Gets value indicating whether information box is visible.</summary>

    var ret = false;

    if (this.get_container()) {
        ret = this.get_container().getStyle('display') != 'none';
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.add_mapInitialized = function (callback) {
    /// <summary>Registers a new callback that is executed after map component has been initialized.</summary>
    /// <param value="callback">Callback to register.</param>

    callback = callback || function () { }

    if (this.get_mapInitialized()) {
        callback(this, {});
    } else {
        this._mapInitializedCallbacks[this._mapInitializedCallbacks.length] = callback;
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.update = function (displayContainer) {
    /// <summary>Update information box contents.</summary>
    // <param name="displayContainer">Value indicating whether to display information box container automatically.</param>

    var location = {};

    if (this.get_visitor()) {
        location = this.get_visitor().get_location();

        if (!location) {
            location = {};
        }
    }

    if (this.get_container()) {
        this._mapState('empty');

        this._setField('IPAddress', this._nonEmpty(location.ipAddress));
        this._setField('ISP', this._nonEmpty(location.isp));
        this._setField('Region', this._nonEmpty(location.region));
        this._setField('Domain', this._nonEmpty(location.domain));

        if (displayContainer) {
            this._cancelDelayedHide();
            this.get_container().show();
        }

        if ((location.latitude != null && location.latitude != 0) || (location.longitude != null && location.longitude != 0)) {
            this._loadMap({ marker: { latitude: location.latitude, longitude: location.longitude} });
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.show = function (params) {
    /// <summary>Show the information box.</summary>
    /// <param value="params">Display parameters.</param>
    
    params = params || {};

    this.hide();

    if (!params.position) {
        params.position = { top: 0, left: 0 };
    } else if (typeof (params.position.top) == 'undefined') {
        params.position.top = 0;
    } else if (typeof (params.position.left) == 'undefined') {
        params.position.left = 0;
    }

    this.update(true);

    if (this.get_container()) {
        this.move(params.position.top, params.position.left);
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.move = function (top, left) {
    /// <summary>Moves the information box to the given coordinates.</summary>
    /// <param value="top">"Top" coordinate component (in pixels).</param>
    /// <param value="left">"Left" coordinate component (in pixels).</param>

    var scrollOffset = null;
    var boxDimensions = null;
    var screenDimensions = null;

    if (this.get_container()) {
        if (this.get_isVisible()) {
            this._cancelDelayedHide();
        }

        top = parseInt(top) || 0;
        left = parseInt(left) || 0;

        boxDimensions = this.get_container().getDimensions();
        screenDimensions = $(document.viewport).getDimensions();
        scrollOffset = $(document.body).cumulativeScrollOffset();

        if ((top + boxDimensions.height) > (screenDimensions.height + scrollOffset.top - 5)) {
            top -= boxDimensions.height;
        }

        if ((left + boxDimensions.width) > (screenDimensions.width + scrollOffset.left)) {
            left -= boxDimensions.width;
        }

        if (top < 0) top = 0;
        if (left < 0) left = 0;

        this.get_container().setStyle({ 'left': (left + 1) + 'px', 'top': (top + 1) + 'px' });
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype.hide = function (delay) {
    /// <summary>Hides the information box.</summary>
    /// <param name="delay">Optional delay (in milliseconds) after which to hide the box.</param>

    var self = this;

    this._cancelDelayedHide();    

    if (typeof (delay) == 'undefined' || delay == null) {
        if (this.get_container()) {
            this.get_container().hide();
        }
    } else {
        delay = parseInt(delay) || 0;

        if (delay > 0) {
            this._hideDelay = setTimeout(function () {
                self.hide();
            }, delay);
        } else {
            this.hide();
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._cancelDelayedHide = function () {
    /// <summary>Cancels delayed "hide" operation.</summary>
    /// <private />

    if (this._hideDelay) {
        clearTimeout(this._hideDelay);
    }

    this._hideDelay = null;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._mapCallback = function () {
    /// <summary>Occurs when the map component has been initialized.</summary>
    /// <private />

    if (!this._mapInitialized) {
        this._mapInitialized = true;

        for (var i = 0; i < this._mapInitializedCallbacks.length; i++) {
            this._mapInitializedCallbacks[i](this, {});
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._setField = function (label, value) {
    /// <summary>Sets the value of the given field.</summary>
    /// <param name="label">Field label.</param>
    /// <param name="value">Field value.</param>
    /// <private />

    var originalLabel = label;
    var labelElement = null, valueElement = null;

    if (label && label.length && this._ensureLayout()) {
        label = label.toLowerCase();

        labelElement = this._selectCached('.omc-leads-list-visitor-info-field-' + label + '-label');
        valueElement = this._selectCached('.omc-leads-list-visitor-info-field-' + label + '-value');

        if (labelElement && labelElement.length && valueElement && valueElement.length) {
            labelElement[0].innerHTML = Dynamicweb.Controls.OMC.LeadsList.Global.get_terminology().get(originalLabel);
            valueElement[0].innerHTML = value;
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._nonEmpty = function (value) {
    /// <summary>Ensures that the given value is not empty and if so, inserts a corresponding message.</summary>
    /// <param name="value">Value to examine.</param>
    /// <private />

    var ret = value;

    if (!ret || !ret.length) {
        ret = '<span class="omc-leads-list-visitor-info-notavailable">' + 
            Dynamicweb.Controls.OMC.LeadsList.Global.get_terminology().get('NotAvailable') + '</span>';
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._ensureLayout = function () {
    /// <summary>Ensures that the layout of the information box has been created.</summary>
    /// <private />

    var html = '';
    var ret = false;

    if (!this._layoutCreated) {
        if (this.get_container()) {
            html = '<div class="omc-leads-list-visitor-info-content">';
            html += '<a href="javascript:void(0)" onclick="Dynamicweb.Controls.OMC.LeadsList.InfoBox.get_current().hide();" class="omc-leads-list-visitor-info-close">&nbsp;</a>';
            html += '<table cellspacing="0" cellpadding="0" border="0">';
            html += '<tr class="mc-leads-list-visitor-info-heading">';
            html += '<td valign="top" class="omc-leads-list-visitor-info-field-ipaddress-label">&nbsp;</td>';
            html += '<td valign="top" class="omc-leads-list-visitor-info-field-isp-label">&nbsp;</td>';
            html += '</tr>';
            html += '<tr>';
            html += '<td valign="top" class="omc-leads-list-visitor-info-field-ipaddress-value">&nbsp;</td>';
            html += '<td valign="top" class="omc-leads-list-visitor-info-field-isp-value">&nbsp;</td>';
            html += '</tr>';
            html += '<tr class="mc-leads-list-visitor-info-separator"><td colspan="2">&nbsp;</td></tr>';
            html += '<tr class="mc-leads-list-visitor-info-heading">';
            html += '<td valign="top" class="omc-leads-list-visitor-info-field-region-label">&nbsp;</td>';
            html += '<td valign="top" class="omc-leads-list-visitor-info-field-domain-label">&nbsp;</td>';
            html += '</tr>';
            html += '<tr>';
            html += '<td valign="top" class="omc-leads-list-visitor-info-field-region-value">&nbsp;</td>';
            html += '<td valign="top" class="omc-leads-list-visitor-info-field-domain-value">&nbsp;</td>';
            html += '</tr>';
            html += '<tr class="mc-leads-list-visitor-info-separator"><td colspan="2">&nbsp;</td></tr>';
            html += '<tr><td colspan="2" valign="top"><div id="' + this._generateID('map') + '" class="omc-leads-list-visitor-info-map">&nbsp;</div></td></tr>';
            html += '</table>';
            html += '</div>';

            this.get_container().innerHTML = html;

            ret = true;
            this._layoutCreated = true;
        }
    } else {
        ret = true;
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._mapState = function (state) {
    /// <summary>Toggles map container into the given state.</summary>
    /// <param name="state">New map state.</param>
    /// <private />

    var mapContainer = null;

    if (state && state.length) {
        this._ensureLayout();

        mapContainer = document.getElementById(this._generateID('map'));

        if (mapContainer) {
            mapContainer.innerHTML = '';
            mapContainer.style.backgroundColor = '#ffffff';

            if (state == 'empty') {
                mapContainer.innerHTML = ('<div class="omc-leads-list-visitor-info-map-padding"><i>' +
                    Dynamicweb.Controls.OMC.LeadsList.Global.get_terminology().get('MapNotAvailable') + '</i></div>');
            } else if (state == 'loading') {
                mapContainer.innerHTML = ('<div class="omc-leads-list-visitor-info-map-padding">' +
                    '<img src="/Admin/Module/Seo/Dynamicweb_Wait.gif" alt="" title="" border="0" />' + '</div>');
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._loadMap = function (params) {
    /// <summary>Loads the map.</summary>
    /// <param name="params">Map parameters.</param>
    /// <private />

    var self = this;
    var script = null;

    var componentInitialized = function () {
        var map = null;
        var marker = null;
        var mapOptions = null;
        var coordinates = null;

        self._mapState('none');

        if (typeof (google) != 'undefined' && typeof (google.maps) != 'undefined') {
            mapOptions = {
                zoom: 8,
                disableDefaultUI: true,
                zoomControl: true,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }

            if (params.marker) {
                coordinates = new google.maps.LatLng(params.marker.latitude, params.marker.longitude);
                mapOptions.center = coordinates;
            }

            map = new google.maps.Map(document.getElementById(self._generateID('map')), mapOptions);

            if (coordinates) {
                marker = new google.maps.Marker({
                    position: coordinates,
                    map: map,
                    title: self.get_visitor().get_location().ipAddress
                });
            }
        } else {
            self._mapState('empty');
        }
    }

    params = params || {};

    if (this.get_mapInitialized()) {
        componentInitialized();
    } else {
        this._mapState('loading');
        this.add_mapInitialized(componentInitialized);

        script = document.createElement("script");

        script.type = "text/javascript";
        script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=_DWLeadsListInfoBoxMapCallback";

        document.getElementsByTagName('head')[0].appendChild(script);
    }
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._selectCached = function (selector) {
    /// <summary>Selects all DOM elements within the current information box matching the given CSS selector. Results are cached for the given selector.</summary>
    /// <param name="selector">CSS selector.</param>
    /// <private />

    var ret = null;

    if (!this._selectorsCache) {
        this._selectorsCache = new Hash();
    }

    if (selector && selector.length) {
        ret = this._selectorsCache.get(selector);
    }

    if (!ret) {
        ret = this.get_container().select(selector);
        this._selectorsCache.set(selector, ret);
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.InfoBox.prototype._generateID = function (suffix) {
    /// <summary>Generates the unique identifier for the element.</summary>
    /// <param name="suffix">ID suffix.</param>
    /// <private />

    return 'LeadsListInfoBox_' + suffix;
}

Dynamicweb.Controls.OMC.LeadsList.GeoLocationQueue = function () {
    /// <summary>Represents a geolocation request queue.</summary>

    this._data = [];
}

Dynamicweb.Controls.OMC.LeadsList.GeoLocationQueue.prototype.get_count = function () {
    /// <summary>Gets the total number of items within the queue.</summary>

    return this._data.length;
}

Dynamicweb.Controls.OMC.LeadsList.GeoLocationQueue.prototype.enqueue = function (request) {
    /// <summary>Places new request into the queue.</summary>
    /// <param name="request">Request to queue.</param>

    var item = this._item(request);

    if (item && item.ipAddress && item.ipAddress.length) {
        this._data[this._data.length] = item;
    }
}

Dynamicweb.Controls.OMC.LeadsList.GeoLocationQueue.prototype.dequeue = function () {
    /// <summary>Returns the next request and removes it from the queue.</summary>

    var ret = null;

    if (this._data.length > 0) {
        ret = this._data[0];
        this._data = Dynamicweb.Controls.OMC.LeadsList.Global.removeFromArray(this._data, 0);
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.GeoLocationQueue.prototype.contains = function (request) {
    /// <summary>Returns value indicating whether queue contains the given request.</summary>
    /// <param name="request">Request to examine.</param>

    var ret = false;
    var item = this._item(request);

    if (item) {
        for (var i = 0; i < this._data.length; i++) {
            if (this._data[i].ipAddress == item.ipAddress) {
                ret = true;
                break;
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.GeoLocationQueue.prototype.empty = function () {
    /// <summary>Empties the queue and returns all current queued requests.</summary>

    var ret = [];

    if (this._data.length) {
        ret = this._data;
    }

    this._data = [];

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.GeoLocationQueue.prototype._item = function (data) {
    /// <summary>Returns the proper request object.</summary>
    /// <param name="data">Request data.</param>

    var ret = null;

    if (data) {
        if (typeof (data.ipAddress) == 'string') {
            ret = data;
        } else if (typeof (data) == 'string') {
            ret = { ipAddress: data };
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit = function (data) {
    /// <summary>Represents the information about the visitor's last visit.</summary>
    /// <param name="data">Object to copy data from.</param>

    this._timestamp = new Date(1970, 0, 1);
    this._pageviews = 0;
    this._referrer = '';
    this._searchKeywords = [];

    if (typeof (data) != 'undefined' && data != null) {
        if (typeof (data.get_timestamp) == 'function') {
            this.set_timestamp(data.get_timestamp());
            this.set_pageviews(data.get_pageviews());
            this.set_referrer(data.get_referrer());
            this.set_searchKeywords(data.get_searchKeywords());
        } else {
            this.set_timestamp(data.timestamp);
            this.set_pageviews(data.pageviews);
            this.set_referrer(data.referrer);
            this.set_searchKeywords(data.searchKeywords);
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit.prototype.get_timestamp = function () {
    /// <summary>Gets the date of the last visit.</summary>

    return this._timestamp;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit.prototype.set_timestamp = function (value) {
    /// <summary>Sets the date of the last visit.</summary>
    /// <param name="value">The date of the last visit.</param>

    this._timestamp = value;

    if (this._timestamp == null || typeof (this._timestamp.getTime) != 'function') {
        this._timestamp = new Date(1970, 0, 1);
    }
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit.prototype.get_pageviews = function () {
    /// <summary>Gets the number of pageviews occured during the last visit.</summary>

    return this._pageviews;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit.prototype.set_pageviews = function (value) {
    /// <summary>Sets the number of pageviews occured during the last visit.</summary>
    /// <param name="value">The number of pageviews occured during the last visit.</param>

    this._pageviews = parseInt(value);

    if (this._pageviews == null || isNaN(this._pageviews) || this._pageviews < 0) {
        this._pageviews = 0;
    }
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit.prototype.get_referrer = function () {
    /// <summary>Gets the referrer URL.</summary>

    return this._referrer;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit.prototype.set_referrer = function (value) {
    /// <summary>Sets the referrer URL.</summary>
    /// <param name="value">The referrer URL.</param>

    this._referrer = value;

    if (this._referrer == null || typeof (this._referrer) != 'string') {
        this._referrer = '';
    }
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit.prototype.get_searchKeywords = function () {
    /// <summary>Gets the search keywords.</summary>

    return this._searchKeywords;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit.prototype.set_searchKeywords = function (value) {
    /// <summary>Sets the search keywords.</summary>
    /// <param name="value">Search keywords.</param>

    this._searchKeywords = value;

    if (this._searchKeywords == null || typeof (this._searchKeywords.length) == 'undefined') {
        this._searchKeywords = [];
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor = function (data) {
    /// <summary>Represents a visitor within the leads list.</summary>
    /// <param name="data">Object to copy data from.</param>

    this._id = 0;
    this._visitorID = '';
    this._ipAddress = '';
    this._isp = '';
    this._company = '';
    this._lastVisit = null;
    this._isLead = null;
    this._engagement = 0;
    this._cartReference = null;
    this._orderID = '';
    this._showOrdersAndUsers = false;
    this._countryCode = '';
    this._countryName = '';
    this._isSelected = false;
    this._isActive = true;
    this._owner = null;
    this._location = null;
    this._userName = '';
    this._userCompany = '';
    this._visitsCount = 0;
    this._state = '';

    if (typeof (data) != 'undefined' && data != null) {
        if (typeof (data.get_id) == 'function') {
            this.set_owner(data.get_owner());
            this.set_id(data.get_id());
            this.set_visitorID(data.get_visitorID());
            this.set_ipAddress(data.get_ipAddress());
            this.set_countryCode(data.get_countryCode());
            this.set_countryName(data.get_countryName());
            this.set_isp(data.get_isp());
            this.set_company(data.get_company());
            this.set_lastVisit(data.get_lastVisit());
            this.set_isLead(data.get_isLead());
            this.set_engagement(data.get_engagement());
            this.set_cartReference(data.get_cartReference());
            this.set_orderID(data.get_orderID());
            this.set_showOrdersAndUsers(data.get_showOrdersAndUsers());
            this.set_isSelected(data.get_isSelected());
            this.set_isActive(data.get_isActive());
            this.set_location(data.get_location());
            this.set_userName(data.get_userName());
            this.set_userCompany(data.get_userCompany());
            this.set_visitsCount(data.get_visitsCount());
            this.set_state(data.get_state());
        } else {
            this.set_owner(data.owner);
            this.set_id(data.id);
            this.set_visitorID(data.visitorID);
            this.set_ipAddress(data.ipAddress);
            this.set_countryCode(data.countryCode);
            this.set_countryName(data.countryName);
            this.set_isp(data.isp);
            this.set_company(data.company);
            this.set_lastVisit(data.lastVisit);
            this.set_isLead(data.isLead);
            this.set_engagement(data.engagement);
            this.set_cartReference(data.cartReference);
            this.set_orderID(data.orderID);
            this.set_showOrdersAndUsers(data.showOrdersAndUsers);
            this.set_isSelected(data.isSelected);
            this.set_isActive(data.isActive);
            this.set_location(data.location);
            this.set_userName(data.userName);
            this.set_userCompany(data.userCompany);
            this.set_visitsCount(data.visitsCount);
            this.set_state(data.state);
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_isTracking = function () {
    /// <summary>Gets value indicating whether this visitor is being tracked.</summary>

    return this.get_visitorID() && this.get_visitorID().length;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_owner = function () {
    /// <summary>Gets the owning collection.</summary>

    return this._owner;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_owner = function (value) {
    /// <summary>Sets the owning collection.</summary>
    /// <param name="value">The owning collection.</param>

    this._owner = null;

    if (value && typeof (value.addRange) != 'undefined') {
        this._owner = value;
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_location = function () {
    /// <summary>Gets the location information.</summary>

    return this._location;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_location = function (value) {
    /// <summary>Sets the location information.</summary>
    /// <param name="value">The location information.</param>

    this._location = value;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_userName = function () {
    /// <summary>Gets the visitor userName</summary>

    return this._userName;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_userName = function (value) {
    /// <summary>Sets the visitor userName</summary>
    /// <param name="value">The visitor userName</param>

    this._userName = value;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_userCompany = function () {
    /// <summary>Gets the visitor userName</summary>

    return this._userCompany;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_userCompany = function (value) {
    /// <summary>Sets the visitor userName</summary>
    /// <param name="value">The visitor userName</param>

    this._userCompany = value;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_visitsCount = function () {
    /// <summary>Gets the total number of visits for this visitor.</summary>

    return this._visitsCount;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_visitsCount = function (value) {
    /// <summary>Sets the total number of visits for this visitor.</summary>
    /// <param name="value">The total number of visits for this visitor.</param>

    this._visitsCount = value;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_isKnownLocation = function () {
    /// <summary>Gets value indicating whether location of this visitor is known.</summary>

    return this.get_location() || (this.get_countryCode() && this.get_countryCode().length) || (this.get_isp() && this.get_isp().length);
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_id = function () {
    /// <summary>Gets the visitor database row ID.</summary>

    return this._id;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_id = function (value) {
    /// <summary>Sets the visitor database row ID.</summary>
    /// <param name="value">Visitor database row ID.</param>

    this._id = parseInt(value) || 0;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_isSelected = function () {
    /// <summary>Gets value indicating whether visitor is selected.</summary>

    return this._isSelected;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_isSelected = function (value, silentMode) {
    /// <summary>Sets value indicating whether visitor is selected.</summary>
    /// <param name="value">Value indicating whether visitor is selected.</param>
    /// <param name="silentMode">Value indicating whether cancel propagation of any notifications to the controller object.</param>

    this._isSelected = !!value;

    if (this.get_owner()) {
        this.get_owner().onSelectionChanged(this, this._isSelected, !!silentMode);
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_isActive = function () {
    /// <summary>Gets value indicating whether visitor is active (matches search criteria).</summary>

    return this._isActive;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_isActive = function (value, silentMode) {
    /// <summary>Sets value indicating whether visitor is active (matches search criteria).</summary>
    /// <param name="value">Value indicating whether visitor is active (matches search criteria).</param>
    /// <param name="silentMode">Value indicating whether cancel propagation of any notifications to the controller object.</param>

    this._isActive = !!value;

    if (this.get_owner()) {
        this.get_owner().onActiveChanged(this, this._isActive, !!silentMode);
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_visitorID = function () {
    /// <summary>Gets the visitor ID.</summary>

    return this._visitorID;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_visitorID = function (value) {
    /// <summary>Sets the visitor ID.</summary>
    /// <param name="value">Visitor ID.</param>

    this._visitorID = value + '';
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_ipAddress = function () {
    /// <summary>Gets the visitor IP-address.</summary>

    return this._ipAddress || ((this.get_location() && this.get_location().ipAddress) ? this.get_location().ipAddress : '');
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_ipAddress = function (value) {
    /// <summary>Sets the visitor IP-address.</summary>
    /// <param name="value">Visitor IP-address.</param>

    this._ipAddress = value || '';

    if (this.get_location()) {
        this.get_location().ipAddress = this._ipAddress;
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_countryCode = function () {
    /// <summary>Gets the country code of the visitor's country.</summary>

    return this._countryCode || ((this.get_location() && this.get_location().countryCode) ? this.get_location().countryCode : '');
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_countryCode = function (value) {
    /// <summary>Sets the country code of the visitor's country.</summary>
    /// <param name="value">The country code of the visitor's country.</param>

    this._countryCode = value || '';

    if (this.get_location()) {
        this.get_location().countryCode = this._countryCode;
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_countryName = function () {
    /// <summary>Gets the visitor's country name.</summary>

    return this._countryName || ((this.get_location() && this.get_location().countryName) ? this.get_location().countryName : '');
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_countryName = function (value) {
    /// <summary>Sets the visitor's country name.</summary>
    /// <param name="value">The visitor's country name.</param>

    this._countryName = value || '';

    if (this.get_location()) {
        this.get_location().countryName = this._countryName;
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_isp = function () {
    /// <summary>Gets the visitor Internet Service Provider name.</summary>

    return this._isp || ((this.get_location() && this.get_location().isp) ? this.get_location().isp : '');
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_isp = function (value) {
    /// <summary>Sets the visitor Internet Service Provider name.</summary>
    /// <param name="value">Visitor Internet Service Provider name.</param>

    this._isp = value || '';

    if (this.get_location()) {
        this.get_location().isp = this._isp;
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_company = function () {
    /// <summary>Gets the visitor's company name.</summary>

    return this._company || ((this.get_location() && this.get_location().company) ? this.get_location().company : '');
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_company = function (value) {
    /// <summary>Sets the visitor's company name.</summary>
    /// <param name="value">Visitor's company name.</param>

    this._company = value || '';

    if (this.get_location()) {
        this.get_location().company = this._company;
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_lastVisit = function () {
    /// <summary>Gets the visitor's last visit information.</summary>

    if (this._lastVisit == null) {
        this._lastVisit = new Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit();
    }

    return this._lastVisit;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_lastVisit = function (value) {
    /// <summary>Sets the visitor's last visit information.</summary>
    /// <param name="value">Visitor's last visit information.</param>

    this._lastVisit = null;

    if (value) {
        if (typeof (value.timestamp) != 'undefined') {
            this._lastVisit = new Dynamicweb.Controls.OMC.LeadsList.VisitorLastVisit(value);
        } else if (typeof (value.get_timestamp) == 'function') {
            this._lastVisit = value;
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_isLead = function () {
    /// <summary>Gets value indicating whether visitor is either sure lead, not lead or possible lead (null).</summary>

    return this._isLead;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_isLead = function (value) {
    /// <summary>Sets value indicating whether visitor is either sure lead, not lead or possible lead (null).</summary>
    /// <param name="value">value indicating whether visitor is either sure lead, not lead or possible lead (null).</param>

    this._isLead = !!value;

    if (value == null) {
        this._isLead = null;
    }
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_state = function () {
    /// <summary>Gets lead state.</summary>

    return this._state;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_state = function (value) {
    /// <summary>Sets lead state.</summary>
    /// <param name="value">Lead state.</param>

    this._state = value;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_engagement = function () {
    /// <summary>Gets the visitor engagement index.</summary>

    return this._engagement;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_engagement = function (value) {
    /// <summary>Sets the visitor engagement index.</summary>
    /// <param name="value">The visitor engagement index.</param>

    this._engagement = parseFloat(value) || 0;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_cartReference = function () {
    /// <summary>Gets the visitor cartReference</summary>

    return this._cartReference;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_cartReference = function (value) {
    /// <summary>Sets the visitor cartReference</summary>
    /// <param name="value">The visitor cartReference</param>

    this._cartReference = value;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_orderID = function () {
    /// <summary>Gets the visitor orderID</summary>

    return this._orderID;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_orderID = function (value) {
    /// <summary>Sets the visitor orderID</summary>
    /// <param name="value">The visitor orderID</param>

    this._orderID = value;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.get_showOrdersAndUsers = function () {
    /// <summary>Gets condition for show visitor order information</summary>

    return this._showOrdersAndUsers;
}

Dynamicweb.Controls.OMC.LeadsList.Visitor.prototype.set_showOrdersAndUsers = function (value) {
    /// <summary>Sets condition for show visitor order information</summary>
    /// <param name="value">Bool value indicates if to show order information</param>

    this._showOrdersAndUsers = value;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection = function () {
    /// <summary>Represents a collection of visitors.</summary>

    this._indexes = [];
    this._data = [];
    this._selectedIndexes = [];
    this._activeIndexes = [];
    this._identityIndexes = [];
    this._owner = null;

    this._bulkOperation = { isBulk: false, selectionChangedCount: 0, activeChangedCount: 0 };
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.get_owner = function () {
    /// <summary>Gets the owning object.</summary>

    return this._owner;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.set_owner = function (value) {
    /// <summary>Sets the owning object.</summary>
    /// <param name="value">The owning object.</param>

    this._owner = null;

    if (value && typeof (value.get_container) != 'undefined') {
        this._owner = value;
    }
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.get_values = function () {
    /// <summary>Returns a list of collection values.</summary>

    return this._data;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.get_selection = function () {
    /// <summary>Returns a list of all selected visitors mapped to their indexes.</summary>

    var index = -1;
    var ret = new Hash();

    for (var prop in this._selectedIndexes) {
        if (prop && typeof (this._selectedIndexes[prop]) != 'undefined') {
            if (prop.toString().toLowerCase().indexOf('id_') == 0) {
                index = parseInt(this._selectedIndexes[prop]);

                if (index >= 0 && index < this._data.length) {
                    ret.set(index, this._data[index]);
                }
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.get_active = function () {
    /// <summary>Returns a list of all active visitors mapped to their indexes.</summary>

    var index = -1;
    var ret = new Hash();

    for (var prop in this._activeIndexes) {
        if (prop && typeof (this._activeIndexes[prop]) != 'undefined') {
            if (prop.toString().toLowerCase().indexOf('id_') == 0) {
                index = parseInt(this._activeIndexes[prop]);

                if (index >= 0 && index < this._data.length) {
                    ret.set(index, this._data[index]);
                }
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.get_count = function () {
    /// <summary>Returns the total number of elements in the list.</summary>

    return this._data.length;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.clear = function () {
    /// <summary>Removes all elements from the list.</summary>

    this._data = [];
    this._indexes = [];
    this._selectedIndexes = [];
    this._activeIndexes = [];
    this._identityIndexes = [];
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.get_item = function (index) {
    /// <summary>Gets the item at the specified index.</summary>
    /// <param name="index">Zero-based index of an item.</param>

    var ret = null;

    index = parseInt(index);

    if (index >= 0 && index < this.get_count()) {
        ret = this._data[index];
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.set_item = function (index, v) {
    /// <summary>Sets the item at the specified index.</summary>
    /// <param name="index">Zero-based index of an item.</param>
    /// <param name="v">Item to set.</param>

    var ret = null;
    var item = null;
    var itemID = '';

    index = parseInt(index);

    if (index >= 0 && index < this.get_count()) {
        item = this._item(v, true);
        if (item) {
            itemID = this._itemIndexID(item);


            this._data[index] = item;
            this._indexes[itemID] = index;

            if (item.get_isSelected()) {
                this._selectedIndexes[itemID] = index;
            } else if (this._selectedIndexes[itemID] != null) {
                delete this._selectedIndexes[itemID];
            }

            if (item.get_isActive()) {
                this._activeIndexes[itemID] = index;
            } else if (this._activeIndexes[itemID] != null) {
                delete this._activeIndexes[itemID];
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.indexOf = function (v) {
    /// <summary>Returns a zero-based index of the given visitor.</summary>
    /// <param name="v">Either visitor ID or a visitor object.</param>
    /// <returns>A zero-based index of the given visitor or -1 if the visitor has not been found.</returns>

    var key = '';
    var ret = -1;
    var item = null;

    if (v) {
        if (typeof (v) == 'string') {
            key = v;
        } else {
            item = this._item(v, false);

            if (item) {
                key = this._itemIndexID(item);
            }
        }

        if (key && key.length) {
            ret = this._indexes[key] != null ? this._indexes[key] : -1;
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.add = function (v) {
    /// <summary>Adds new item at the end of the collection.</summary>
    /// <param name="v">Visitor to add.</param>
    /// <returns>Value indicating whether item has been successfully added.</returns>

    var item = null;
    var ret = false;
    var itemID = '';
    var itemIndex = 0;

    if (v && this.indexOf(this._item(v, false)) < 0) {
        item = this._item(v, true);

        if (item) {
            itemID = this._itemIndexID(item);

            this._data[this._data.length] = item;
            itemIndex = this._data.length - 1;

            this._indexes[itemID] = itemIndex;

            if (typeof (v.get_visitorID) == 'function') {
                this._identityIndexes[v.get_visitorID()] = itemID;
            } else if (typeof (v.visitorID) != 'undefined') {
                this._identityIndexes[v.visitorID] = itemID;
            }

            if (item.get_isSelected()) {
                this._selectedIndexes[itemID] = itemIndex;
            }

            if (item.get_isActive()) {
                this._activeIndexes[itemID] = itemIndex;
            }

            ret = true;
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.addAt = function (index, v) {
    /// <summary>Inserts new item at the specified position within the collection.</summary>
    /// <param name="index">Zero-based index to insert item at.</param>
    /// <param name="v">Visitor to insert.</param>
    /// <returns>Value indicating whether item has been successfully inserted.</returns>

    var itemID = '';
    var item = null;
    var ret = false;
    var newData = [];

    if ((index == 0 && this.get_count() == 0) || index >= this.get_count()) {
        ret = this.add(v);
    } else if (index >= 0 && index < this.get_count() && this.indexOf(this._item(v, false)) < 0) {
        item = this._item(v, true);

        if (item) {
            itemID = this._itemIndexID(item);

            this._indexes[itemID] = index;

            if (item.get_isSelected()) {
                this._selectedIndexes[itemID] = index;
            }

            if (item.get_isActive()) {
                this._activeIndexes[itemID] = index;
            }

            for (var i = 0; i < index; i++) {
                newData[newData.length] = this._data[i];
            }

            newData[index] = item;

            for (var i = index; i < this._data.length; i++) {
                newData[newData.length] = this._data[i];
            }

            this._data = newData;

            for (var i = (index + 1); i < this._data.length; i++) {
                itemID = this._itemIndexID(this._data[i]);

                if (typeof (this._indexes[itemID]) != 'undefined') {
                    this._indexes[itemID] += 1;
                }

                if (typeof (this._selectedIndexes[itemID]) != 'undefined') {
                    this._selectedIndexes[itemID] += 1;
                }

                if (typeof (this._activeIndexes[itemID]) != 'undefined') {
                    this._activeIndexes[itemID] += 1;
                }
            }

            ret = true;
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.addRange = function (visitors) {
    /// <summary>Adds the given list of visitors at the end of the current collection.</summary>
    /// <param name="visitors">Visitors to add.</param>

    this._bulkOperation.isBulk = true;

    if (visitors && visitors.length) {
        for (var i = 0; i < visitors.length; i++) {
            this.add(visitors[i]);
        }
    }

    this._bulkOperation.isBulk = false;

    if (this.get_owner()) {
        if (this._bulkOperation.selectionChangedCount > 0) {
            this.get_owner().onSelectionChanged({ });
        }

        if (this._bulkOperation.activeChangedCount > 0) {
            this.get_owner().onActiveChanged({ });
        }
    }

    this._bulkOperation.selectionChangedCount = 0;
    this._bulkOperation.activeChangedCount = 0;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.remove = function (v) {
    /// <summary>Removes existing item from the collection.</summary>
    /// <param name="v">Visitor to remove.</param>
    /// <returns>Value indicating whether item has been successfully removed.</returns>

    var item = null;
    var ret = false;
    var itemIndex = -1;

    if (v) {
        item = this._item(v, false);

        if (item) {
            itemIndex = this.indexOf(item);

            if (itemIndex >= 0 && itemIndex < this.get_count()) {
                ret = this.removeAt(itemIndex);
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.removeAt = function (index) {
    /// <summary>Removes existing item at the specified position from the collection.</summary>
    /// <param name="index">Zero-based index to remove item from.</param>
    /// <returns>Value indicating whether item has been successfully removed.</returns>

    var item = null;
    var ret = false;
    var itemID = '';
    var visitorID = '';

    if (index >= 0 && index < this._data.length) {
        item = this.get_item(index);

        if (item) {
            itemID = this._itemIndexID(item);

            if (typeof (item.get_visitorID) == 'function') {
                visitorID = item.get_visitorID();
            } else if (typeof (item.visitorID) != 'undefined') {
                visitorID = item.visitorID;
            }

            this._data = Dynamicweb.Controls.OMC.LeadsList.Global.removeFromArray(this._data, index);

            delete this._indexes[itemID];
            delete this._selectedIndexes[itemID];
            delete this._activeIndexes[itemID];
            delete this._identityIndexes[visitorID];

            for (var i = 0; i < this._data.length; i++) {
                itemID = this._itemIndexID(this._data[i]);

                if (typeof (this._indexes[itemID]) != 'undefined' && this._indexes[itemID] > index) {
                    this._indexes[itemID] -= 1;
                }

                if (typeof (this._selectedIndexes[itemID]) != 'undefined' && this._selectedIndexes[itemID] > index) {
                    this._selectedIndexes[itemID] -= 1;
                }

                if (typeof (this._activeIndexes[itemID]) != 'undefined' && this._activeIndexes[itemID] > index) {
                    this._activeIndexes[itemID] -= 1;
                }
            }

            ret = true;
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.find = function (qualifider) {
    /// <summary>Finds the given visitor by the given criteria.</summary>
    /// <param name="qualifier">Search criteria.</param>

    var ret = null;
    var itemIndex = -1;

    if (qualifider && typeof (qualifider.key) == 'string') {
        if (qualifider.key.toLowerCase() == 'visitorid' && qualifider.value && qualifider.value.length) {
            if (typeof (qualifider.value) != 'undefined') {
                itemIndex = this._indexes['id_'+qualifider.value];
            }
        }

        if (itemIndex >= 0 && itemIndex < this._data.length) {
            ret = this._data[itemIndex];
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.onSelectionChanged = function (v, isSelected, silentMode) {
    /// <summary>Handles the change of the "Selected" state of the given visitor.</summary>
    /// <param name="v">Referencing visitor.</param>
    /// <param name="isSelected">Value indicating whether visitor is selected or not.</param>
    /// <param name="silentMode">Value indicating whether cancel propagation of any notifications to the controller object.</param>

    var indexID = '';
    var item = this._item(v, false);

    isSelected = !!isSelected;

    if (item) {
        indexID = this._itemIndexID(item);

        if (isSelected && this._indexes[indexID] >= 0) {
            this._selectedIndexes[indexID] = this._indexes[indexID];
        } else if (this._selectedIndexes[indexID] != null) {
            delete this._selectedIndexes[indexID];
        }

        if (this._bulkOperation.isBulk) {
            this._bulkOperation.selectionChangedCount += 1;
        } else {
            if (this.get_owner() && !silentMode) {
                this.get_owner().onSelectionChanged({ visitor: v, selected: isSelected });
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype.onActiveChanged = function (v, isActive, silentMode) {
    /// <summary>Handles the change of the "Active" state of the given visitor.</summary>
    /// <param name="v">Referencing visitor.</param>
    /// <param name="isActive">Value indicating whether visitor is active or not.</param>
    /// <param name="silentMode">Value indicating whether cancel propagation of any notifications to the controller object.</param>

    var indexID = '';
    var item = this._item(v, false);

    isActive = !!isActive;

    if (item) {
        indexID = this._itemIndexID(item);

        if (isActive && this._indexes[indexID] >= 0) {
            this._activeIndexes[indexID] = this._indexes[indexID];
        } else if (this._activeIndexes[indexID] != null) {
            delete this._activeIndexes[indexID];
        }

        if (this._bulkOperation.isBulk) {
            this._bulkOperation.activeChangedCount += 1;
        } else {
            if (this.get_owner() && !silentMode) {
                this.get_owner().onActiveChanged({ visitor: v, active: isActive });
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype._itemIndexID = function (v) {
    /// <summary>Returns a string suitable for identifying the given item in an index dicitionary.</summary>
    /// <param name="v">Visitor information.</param>
    /// <returns>A string suitable for identifying the given item in an index dicitionary.</returns>
    /// <private />

    var ret = '';
    var item = null;

    if (v) {
        item = this._item(v, false);
        if (item) {
            ret = 'id_' + v.get_id();
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.VisitorCollection.prototype._item = function (v, setOnwer) {
    /// <summary>Returns an instance of the visitor based on the given information.</summary>
    /// <param name="v">Visitor information.</param>
    /// <param name="setOwner">Indicates whether to automatically assign current collection as a new owner of the given visitor.</param>
    /// <returns>Visitor instance or null if the visitor instance cannot be created.</returns>
    /// <private />

    var ret = null;

    if (v) {
        if (typeof (v.get_visitorID) == 'function') {
            if (setOnwer) {
                v.set_owner(this);
            }

            ret = v;
        } else if (typeof (v.visitorID) != 'undefined') {
            if (setOnwer) {
                v.owner = this;
            }

            ret = new Dynamicweb.Controls.OMC.LeadsList.Visitor(v);
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsListBeforeLoadEventArgs = function () {
    /// <summary>Provides information for "beforeLoad" event.</summary>

    this._parameters = new Hash();
}

Dynamicweb.Controls.OMC.LeadsListBeforeLoadEventArgs.prototype.get_parameters = function () {
    /// <summary>Gets the request parameters.</summary>

    return this._parameters;
}

Dynamicweb.Controls.OMC.LeadsListBeforeLoadEventArgs.prototype.set_parameters = function (value) {
    /// <summary>Sets the request parameters.</summary>
    /// <param name="value">Request parameters.</param>

    this._parameters = value;
}

Dynamicweb.Controls.OMC.LeadsListAfterLoadEventArgs = function (response) {
    /// <summary>Provides information for "afterLoad" event.</summary>
    /// <param name="response">The response returned from the web-server.</param>
    this._response = response;
}

Dynamicweb.Controls.OMC.LeadsListAfterLoadEventArgs.prototype.get_response = function () {
    /// <summary>Gets the response returned from the web-server.</summary>

    return this._response;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_visitors = function () {
    /// <summary>Gets the collection of loaded visitors.</summary>

    if (!this._visitors) {
        this._visitors = new Dynamicweb.Controls.OMC.LeadsList.VisitorCollection();
        this._visitors.set_owner(this);
    }

    return this._visitors;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_sortBy = function () {
    /// <summary>Gets the object that represents how the list records must be sorted.</summary>

    return this._sortBy;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_sortBy = function (value) {
    /// <summary>Sets the object that represents how the list records must be sorted.</summary>
    /// <param name="value">The object that represents how the list records must be sorted.</param>

    var self = this;

    this._sortBy = value;
    this._sortByIsDirty = true;

    this.onSortOrderChanged({ sortBy: value });

    setTimeout(function () {
        self.reloadWithDefaults();
    }, 25);
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_isEnabled = function () {
    /// <summary>Gets value indicating whether user can interact with list content.</summary>

    return this._isEnabled;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_isEnabled = function (value) {
    /// <summary>Sets value indicating whether user can interact with list content.</summary>
    /// <param name="value">Value indicating whether user can interact with list content.</param>

    this._isEnabled = !!value;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_currentPageIndex = function () {
    /// <summary>Gets the current page index (1-based).</summary>

    return this._currentPageIndex;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_currentPageIndex = function (value) {
    /// <summary>Sets the current page index (1-based).</summary>
    /// <param name="value">The current page index (1-based).</param>

    var newValue = parseInt(value);
    var pageSize = this.get_pageSize();
    var total = this.get_totalVisitors();
    var originalValue = this._currentPageIndex;

    if (!this.get_isLoading()) {
        if (newValue <= 1 || isNaN(newValue)) {
            newValue = 1;
        }

        if (((newValue - 1) * pageSize) < total) {
            if (newValue != originalValue) {
                this._currentPageIndex = newValue;

                this.reloadPage({ page: newValue });

                this.onPageIndexChanged({
                    from: originalValue,
                    to: newValue,
                    direction: (newValue > originalValue ? 'forward' : 'backward')
                });
            } else {
                this.onPageIndexChanged({ from: originalValue, to: originalValue, direction: 'none' });
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_leadMessage = function () {
    /// <summary>Gets the message that is used for marking records as sure leads.</summary>

    return this._leadMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_leadMessage = function (value) {
    /// <summary>Sets the message that is used for marking records as sure leads.</summary>
    /// <param name="value">The message that is used for marking records as sure leads.</param>

    this._leadMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_notLeadMessage = function () {
    /// <summary>Gets the message that is used for marking records as non-leads.</summary>

    return this._notLeadMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_notLeadMessage = function (value) {
    /// <summary>Sets the message that is used for marking records as non-leads.</summary>
    /// <param name="value">The message that is used for marking records as non-leads.</param>

    this._notLeadMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_ignoreISPMessage = function () {
    /// <summary>Gets the message that is used for ignoring specific Internet Service Providers.</summary>

    return this._ignoreISPMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_ignoreISPMessage = function (value) {
    /// <summary>Sets the message that is used for ignoring specific Internet Service Providers.</summary>
    /// <param name="value">The message that is used for ignoring specific Internet Service Providers.</param>

    this._ignoreISPMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_searchedForMessage = function () {
    /// <summary>Gets the message that is used for marking last visit that contains search engine referrer.</summary>

    return this._searchedForMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_searchedForMessage = function (value) {
    /// <summary>Sets the message that is used for marking last visit that contains search engine referrer.</summary>
    /// <param name="value">The message that is used for marking last visit that contains search engine referrer.</param>

    this._searchedForMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_seeMoreDetailsMessage = function () {
    /// <summary>Gets the message that is used for displaying hint for "Information" icon.</summary>

    return this._seeMoreDetailsMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_seeMoreDetailsMessage = function (value) {
    /// <summary>Sets the message that is used for displaying hint for "Information" icon.</summary>
    /// <param name="value">The message that is used for displaying hint for "Information" icon.</param>

    this._seeMoreDetailsMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_sendLeadEmailMessage = function () {
    /// <summary>Gets the message that is used for displaying hint for "Information" icon.</summary>

    return this._sendLeadEmailMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_sendLeadEmailMessage = function (value) {
    /// <summary>Sets the message that is used for displaying hint for "Information" icon.</summary>
    /// <param name="value">The message that is used for displaying hint for "Information" icon.</param>

    this._sendLeadEmailMessage = value || '';
}


Dynamicweb.Controls.OMC.LeadsList.prototype.get_potentialLeadState = function () {
    /// <summary>Gets the lead state value that indicates that the given lead must be returned to "Potential leads" list.</summary>

    return 'DW_POTENTIALLEAD'; // Must be the same value as in server-side implementation
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_leadStatesMessage = function () {
    /// <summary>Gets the message that is used for groupping lead staets ("Lead states" group).</summary>

    return this._leadStatesMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_leadStatesMessage = function (value) {
    /// <summary>Sets the message that is used for groupping lead staets ("Lead states" group).</summary>
    /// <param name="value">The message that is used for groupping lead staets ("Lead states" group)</param>

    this._leadStatesMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_otherStatesMessage = function () {
    /// <summary>Gets the message that is used for groupping lead staets ("Other states" group).</summary>

    return this._otherStatesMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_otherStatesMessage = function (value) {
    /// <summary>Sets the message that is used for groupping lead staets ("Other states" group).</summary>
    /// <param name="value">The message that is used for groupping lead staets ("Other states" group)</param>

    this._otherStatesMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_pendingMessage = function () {
    /// <summary>Gets the message that is used for displaying "Pending" status in location-dependent columns.</summary>

    return this._pendingMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_pendingMessage = function (value) {
    /// <summary>Sets the message that is used for displaying "Pending" status in location-dependent columns.</summary>
    /// <param name="value">The message that is used for displaying "Pending" status in location-dependent columns.</param>

    this._pendingMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_viewLocationMessage = function () {
    /// <summary>Gets the message that is displayed as a title to "View location" link.</summary>

    return this._viewLocationMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_viewLocationMessage = function (value) {
    /// <summary>Sets the message that is displayed as a title to "View location" link.</summary>
    /// <param name="value">The message that is displayed as a title to "View location" link.</param>

    this._viewLocationMessage = value || '';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_isTrackingMessage = function () {
    /// <summary>Gets the message that is displayed whether visit is being tracked or not.</summary>

    return this._isTrackingMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_isTrackingMessage = function (value) {
    /// <summary>Sets the message that is displayed whether visit is being tracked or not.</summary>
    /// <param name="value">The message that is displayed whether visit is being tracked or not.</param>

    this._isTrackingMessage = value || ['', ''];
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_noneMessage = function () {
    /// <summary>Gets the "None" message.</summary>

    return this._noneMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_noneMessage = function (value) {
    /// <summary>Sets the "None" message.</summary>
    /// <param name="value">The "None" message.</param>

    this._noneMessage = value;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_showVisitsMessage = function () {
    /// <summary>Gets the "Show visits" message.</summary>

    return this._showVisitsMessage;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_showVisitsMessage = function (value) {
    /// <summary>Sets the "Show visits" message.</summary>
    /// <param name="value">The "Show visits" message.</param>

    this._showVisitsMessage = value;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_totalVisitors = function () {
    /// <summary>Gets the total amount of visitors available (not only those once that are currently loaded).</summary>

    return this._totalVisitors;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_totalPages = function () {
    /// <summary>Gets the total amount pages available based on the total amount of visitors.</summary>

    var ret = 1;
    var pageSize = this.get_pageSize();
    var total = this.get_totalVisitors();

    if (pageSize > 0 && total > 0) {
        ret = parseInt(total / pageSize) || 1;
        if (total - (ret * pageSize) > 0) {
            ret += 1;
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_totalVisitors = function (value) {
    /// <summary>Sets the total amount of visitors available (not only those once that are currently loaded).</summary>
    /// <param name="value">The total amount of visitors available (not only those once that are currently loaded).</param>

    var newValue = parseInt(value);
    var originalVaue = this._totalVisitors;

    this._totalVisitors = newValue;

    this.onTotalVisitorsChanged({ from: originalVaue, to: newValue });
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_enableTrace = function () {
    /// <summary>Gets value indicating whether to enable trace messages.</summary>

    return this._enableTrace;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_enableTrace = function (value) {
    /// <summary>Sets value indicating whether to enable trace messages.</summary>
    /// <param name="value">Value indicating whether to enable trace messages.</param>

    this._enableTrace = !!value;
}


Dynamicweb.Controls.OMC.LeadsList.prototype.get_isLoading = function () {
    /// <summary>Gets value indicating whether list is currently loading visitors.</summary>

    return this._isLoading;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_isLoading = function (value) {
    /// <summary>Sets value indicating whether list is currently loading visitors.</summary>
    /// <param name="value">Value indicating whether list is currently loading visitors.</param>

    this._isLoading = !!value;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_namespace = function () {
    /// <summary>Gets the globally unique namespace for the control.</summary>

    if (!this._namespace) {
        this._namespace = Dynamicweb.Controls.OMC.LeadsList.Global.createNamespace(this.get_associatedControlID());
    }

    return this._namespace;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_associatedControlID = function () {
    /// <summary>Gets the unique identifier of the ASP.NET control that is associated with this client object.</summary>

    return this._associatedControlID;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_associatedControlID = function (value) {
    /// <summary>Sets the unique identifier of the ASP.NET control that is associated with this client object.</summary>
    /// <param name="value">The unique identifier of the ASP.NET control that is associated with this client object.</param>

    this._associatedControlID = value;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_container = function () {
    /// <summary>Gets the reference to DOM element holding control's contents.</summary>

    if (this._container == null || typeof (this._container) == 'string') {
        this._container = $(this._containerID);
    }

    return this._container;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_container = function (value) {
    /// <summary>Sets the reference to DOM element holding control's contents.</summary>
    /// <param name="value">The reference to DOM element holding control's contents.</param>

    this._container = value;

    if (typeof (value) == 'string') {
        this._containerID = value;
    } else {
        this._containerID = '';
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_culture = function () {
    /// <summary>Gets the current culture.</summary>

    if (!this._culture) {
        this._culture = new Dynamicweb.Controls.OMC.LeadsListCulture();
    }

    return this._culture;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_culture = function (value) {
    /// <summary>Sets the current culture.</summary>
    /// <param name="value">Current culture.</param>

    this._culture = value != null && typeof (value.get_dateFormat) == 'function' ? value : null;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_displayMode = function () {
    /// <summary>Gets the display mode.</summary>

    return this._displayMode;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_displayMode = function (value) {
    /// <summary>Sets the display mode.</summary>
    /// <param name="value">The display mode.</param>

    this._displayMode = parseInt(value) || 0;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_editMode = function () {
    /// <summary>Gets the edit mode.</summary>

    return this._editMode;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_editMode = function (value) {
    /// <summary>Sets the edit mode.</summary>
    /// <param name="value">The edit mode.</param>

    this._editMode = parseInt(value) || 0;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_visitorStates = function () {
    /// <summary>Gets the list of all available visitor states.</summary>

    return this._visitorStates;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_visitorStates = function (value) {
    /// <summary>Sets the list of all available visitor states.</summary>
    /// <param name="value">The list of all available visitor states.</param>

    this._visitorStates = value || [];
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_knownProviders = function () {
    /// <summary>Gets the list of ISPs configured in the Management Center under the "Leads -> Ignore providers" section.</summary>

    var ret = [];

    for (var prop in this._knownProviders) {
        if (typeof (this._knownProviders[prop]) == 'string') {
            ret[ret.length] = this._knownProviders[prop];
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_knownProviders = function (value) {
    /// <summary>Sets the list of ISPs configured in the Management Center under the "Leads -> Ignore providers" section.</summary>
    /// <param name="value">The list of ISPs configured in the Management Center under the "Leads -> Ignore providers" section.</param>

    this._knownProviders = {};

    if (value && value.length) {
        for (var i = 0; i < value.length; i++) {
            this._knownProviders[value[i].toLowerCase()] = value[i];
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_visitorStatesPresentationType = function () {
    /// <summary>Gets the value that identifies the presentation type of lead states.</summary>

    return this.get_visitorStates().length <= 6 ? 'balloon' : 'dropdown';
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_visitorStatesBalloon = function () {
    /// <summary>Gets visitor states balloon.</summary>

    var ret = null;

    if (this._visitorStatesBalloon) {
        if (typeof (this._visitorStatesBalloon) == 'string') {
            try {
                ret = eval(this._visitorStatesBalloon);
            } catch (ex) { }

            if (ret) {
                this._visitorStatesBalloon = ret;
            }
        } else {
            ret = this._visitorStatesBalloon;
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_visitorStatesBalloon = function (value) {
    /// <summary>Sets visitor states balloon.</summary>
    /// <param name="value">Visitor states balloon.</param>

    this._visitorStatesBalloon = value;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_isEmpty = function () {
    /// <summary>Gets value indicating whether list is empty.</summary>

    return this._cache.contentContainer.getElementsByTagName('ul').length == 0;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_selection = function () {
    /// <summary>Gets the list containing visitors that are currently selected by the user. The visitors are mapped to their positions in the underlying collection.</summary>

    return this.get_visitors().get_selection();
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_queue = function () {
    /// <summary>Gets the queue object containing geolocation requests.</summary>

    if (!this._queue) {
        this._queue = new Dynamicweb.Controls.OMC.LeadsList.GeoLocationQueue();
    }

    return this._queue;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_pageSize = function () {
    /// <summary>Gets the number of rows to show on each page.</summary>

    return this._pageSize;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.set_pageSize = function (value) {
    /// <summary>Sets the number of rows to show on each page.</summary>
    /// <param name="value">The number of rows to show on each page.</summary>

    var v = parseInt(value);

    if (v <= 0 || isNaN(v)) {
        v = 20;
    }

    this._pageSize = v;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_preloadAmount = function () {
    /// <summary>Gets the amount of records to preload for eliminating the delays when navigating from one page to another.</summary>

    return this.get_pageSize() * 2;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_isPreloading = function () {
    /// <summary>Gets the value indicating whether list is currently preloading additional data.</summary>

    return !this.get_preloadQueue().get_isEmpty();
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_preloadQueue = function () {
    /// <summary>Gets the data preload queue.</summary>

    if (!this._preloadQueue) {
        this._preloadQueue = new Dynamicweb.Controls.OMC.LeadsList.PreloadQueue(this);
    }

    return this._preloadQueue;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.get_isPopulating = function () {
    /// <summary>Gets the value indicating whether list contents is being populated.</summary>

    return this._isPopulating;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_ready = function (callback) {
    /// <summary>Registers new callback which is executed when the page is loaded.</summary>
    /// <param name="callback">Callback to register.</param>

    var self = this;

    callback = callback || function () { }

    Event.observe(document, 'dom:loaded', function () {
        self.onReady({ callback: callback });
    });
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_sortOrderChanged = function (callback) {
    /// <summary>Registers new callback which is executed when sort order is changed.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.sortOrderChanged[this._handlers.sortOrderChanged.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_beforeLoad = function (callback) {
    /// <summary>Registers new callback which is executed before visitors are loaded.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.beforeLoad[this._handlers.beforeLoad.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_afterLoad = function (callback) {
    /// <summary>Registers new callback which is executed after visitors are loaded.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.afterLoad[this._handlers.afterLoad.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_rowPopulated = function (callback) {
    /// <summary>Registers new callback which is executed after the new row is presented to the user.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.rowPopulated[this._handlers.rowPopulated.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_rowClick = function (callback) {
    /// <summary>Registers new callback which is executed when the user clicks the row.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.rowClick[this._handlers.rowClick.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_pageIndexChanged = function (callback) {
    /// <summary>Registers new callback which is executed when the user navigates to another page within the list.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.pageIndexChanged[this._handlers.pageIndexChanged.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_beforeQueryLocation = function (callback) {
    /// <summary>Registers new callback which is executed before the location information is to be queried.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.beforeQueryLocation[this._handlers.beforeQueryLocation.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_afterQueryLocation = function (callback) {
    /// <summary>Registers new callback which is executed after the location information has been returned.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.afterQueryLocation[this._handlers.afterQueryLocation.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_locationAssigned = function (callback) {
    /// <summary>Registers new callback which is executed after the location information has been assigned to the user.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.locationAssigned[this._handlers.locationAssigned.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_stateChanged = function (callback) {
    /// <summary>Registers new callback which is executed after the state of the given visitor changes.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.stateChanged[this._handlers.stateChanged.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_visitorMarked = function (callback) {
    /// <summary>Registers new callback which is executed when the user marks the given visitor as either lead or not lead.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.visitorMarked[this._handlers.visitorMarked.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_visitorAdded = function (callback) {
    /// <summary>Registers new callback which is executed after the given visitor is added to the list.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.visitorAdded[this._handlers.visitorAdded.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_visitorRemoved = function (callback) {
    /// <summary>Registers new callback which is executed after the given visitor is removed from the list.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.visitorRemoved[this._handlers.visitorRemoved.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_totalVisitorsChanged = function (callback) {
    /// <summary>Registers new callback which is executed when the total number of available visitors changes.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.totalVisitorsChanged[this._handlers.totalVisitorsChanged.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_afterPopulate = function (callback) {
    /// <summary>Registers new callback which is executed after visitors are presented to the user.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.afterPopulate[this._handlers.afterPopulate.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.add_selectionChanged = function (callback) {
    /// <summary>Registers new callback which is executed after the amount of selected visitors is changed.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._handlers.selectionChanged[this._handlers.selectionChanged.length] = callback;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.isKnownProvider = function (provider) {
    /// <summary>Gets value indicating whether the given provider is a known provider.</summary>
    /// <param name="provider">Provider to check.</param>
    /// <returns>Value indicating whether the given provider is a known provider.</returns>

    var ret = false;

    if (provider && provider.length) {
        ret = typeof (this._knownProviders[provider.toLowerCase()]) != 'undefined';
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.addKnownProvider = function (provider) {
    /// <summary>Registers new known provider.</summary>
    /// <param name="provider">New provider to register.</param>
    /// <returns>Value indicating whether provider has been successfully registered.</returns>

    var ret = false;

    if (provider && provider.length && !this.isKnownProvider(provider)) {
        this._knownProviders[provider.toLowerCase()] = provider;
        ret = true;
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>

    var self = this;

    var onLeadStateActivated = function (e) {
        var info = null;
        var visitor = null;
        var element = $(Event.element(e));

        if (element.hasClassName('omc-lead-list-leadstate-current') && self.get_visitorStatesBalloon()) {
            info = self._rowInfo(element);

            self.get_visitorStatesBalloon().set_target(element);
            visitor = self.get_visitors().get_item(info.position);

            self.get_visitorStatesBalloon().show();

            if (visitor) {
                setCurrentLeadState(self.get_visitorStatesBalloon().get_content(), visitor.get_state(), info.position);
            }
        }
    }

    var setCurrentLeadState = function (content, state, position) {
        var radioButton = null;
        var states = $(content).select('li.omc-leads-list-leadstates-choice');

        for (var i = 0; i < states.length; i++) {
            radioButton = $(states[i]).select('input');
            if (radioButton && radioButton.length) {
                radioButton = radioButton[0];

                radioButton.checked = state.toLowerCase() == radioButton.value.toLowerCase();

                (function (rb, pos) {
                    Event.stopObserving(rb, 'click');
                    Event.observe(rb, 'click', function (e) {
                        var element = Event.element(e);

                        if (!element.disabled) {
                            setTimeout(function () {
                                self.get_visitorStatesBalloon().hide();
                                self.onVisitorMarked({ position: pos, state: element.value, visitor: self.get_visitors().get_item(pos) });
                            }, 50);
                        }
                    });
                })(radioButton, position);
            }
        }
    }

    this._initializeCache();
    this._bindToUI();

    Event.observe(this._cache.contentContainer, 'mouseover', function (e) { onLeadStateActivated(e); });
    Event.observe(this._cache.contentContainer, 'click', function (e) { onLeadStateActivated(e); });

    if (Prototype.Browser.Gecko) {
        this.get_container().addClassName('omc-leads-list-firefox');
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.reloadWithDefaults = function (onComplete) {
    /// <summary>Reloads the entire list by using the default parameters.</summary>
    /// <param name="onComplete">A function that is called when list is reloaded.</param>

    var self = this;

    onComplete = onComplete || function () { };

    this.reset(true);

    this.reload({ geolocation: { queue: true, query: false }, onComplete: function () {
            self.queryLocation({ onComplete: onComplete });
        }
    });
}

Dynamicweb.Controls.OMC.LeadsList.prototype.reload = function (params) {
    /// <summary>Reloads the list.</summary>
    /// <param name="params">Load parameters.</param>

    var amount = 0;
    var self = this;
    var args = null;
    var callback = null;
    var onComplete = null;
    var loadingTimeoutID = null;
    var originalVisitorsCount = 0;
    var modifiedVisitorsCount = 0;
    var requestParams = new Hash();

    params = params || {};
    onComplete = params.onComplete || function () { }

    /* Default action is to populate results upon the completion of the AJAX request */
    if (typeof (params.populate) == 'undefined' || params.populate == null) {
        params.populate = true;
    }

    /* Callback that is executed when the response from the server becomes available */
    callback = function (response) {
        var offset = 0, count = 0;

        /* Preventing the progress indicator to appear by the timeout */
        if (loadingTimeoutID) {
            clearTimeout(loadingTimeoutID);
            loadingTimeoutID = null;
        }

        originalVisitorsCount = self.get_visitors().get_count();

        /* Adding new visitors to the collection */
        self.get_visitors().addRange(response.visitors);

        modifiedVisitorsCount = self.get_visitors().get_count();

        if (self._totalServerVisitors < 0) {
            /* Setting the total amount of visitors available */
            self.set_totalVisitors(response.total);
            self._totalServerVisitors = response.total;
        }

        if (self._totalServerVisitorsLoaded < 0) {
            self._totalServerVisitorsLoaded = 0;
        }

        /* The actual number of loaded visitors is increased by delta between the original size the collection and the final size */
        self._totalServerVisitorsLoaded += Math.abs(modifiedVisitorsCount - originalVisitorsCount);

        /* Firing "afterLoad" event allowing clients to perform their tasks (e.g. updating the UI) */
        self.onAfterLoad(new Dynamicweb.Controls.OMC.LeadsListAfterLoadEventArgs(response));

        self.trace('Loaded visitors: ' + response.visitors.length + ', total available: ' + response.total);

        if (params.populate) {
            count = self.get_pageSize();
            offset = ((parseInt(params.page) || 1) - 1) * count;

            /* Populating the given page in the list */
            self.populate({ range: { start: offset, count: count }, geolocation: params.geolocation });

            /* Hiding the progress indicator */
            self.set_isLoading(false);
        }

        if (typeof (params.resetPageIndex) == 'undefined' || params.resetPageIndex == null || !!params.resetPageIndex) {
            /* Reseting the current page index (using the private field in order not to cause side effects and unnesesary UI updates) */
            self._currentPageIndex = 1;

            /* Firing "pageIndexChange" (direction is "none" which indicates that the pager gets initialized) */
            self.onPageIndexChanged({ from: 1, to: 1, direction: 'none' });
        }

        /* Finally, calling "onComplete" handler declared by the caller of this method */
        onComplete();
    }

    /* Firing "beforeLoad" event allowing clients for example to add request parameters */
    args = new Dynamicweb.Controls.OMC.LeadsListBeforeLoadEventArgs();
    this.onBeforeLoad(args);

    /* Merging request parameters */
    requestParams = requestParams.merge(args.get_parameters());

    amount = this.get_preloadAmount();
    if (typeof (params.amount) != 'undefined' && params.amount > 0) {
        amount = params.amount;
    }

    if (params.page < 1) {
        params.page = 1;
    }

    /* Adding system request parameters (how much to return and the offset) */
    requestParams.set('System:Offset', (this.get_pageSize() * (params.page - 1)) + this._removedVisitorsCount);
    requestParams.set('System:Amount', amount);

    /* Is sort order has been changed, reflecting this on request parameters */
    if (this._sortByIsDirty) {
        requestParams.set('SortByField', this.get_sortBy().field);
        requestParams.set('SortByDirection', this.get_sortBy().direction);
    }

    if (params.populate) {
        /* Progress indicator will be displayed by timeout (prevents flicker effects when the latency is low) */
        loadingTimeoutID = setTimeout(function () {
            self.set_isLoading(true);
        }, 750);
    }

    /* Getting data */
    Dynamicweb.Ajax.DataLoader.load({
        target: this.get_associatedControlID(),
        parameters: requestParams.toObject(),
        argument: '',
        onComplete: callback,
        onError: function (data) { alert(data.message); callback({ visitors: [], total: 0 }); }
    });
}

Dynamicweb.Controls.OMC.LeadsList.prototype.reloadPage = function (params) {
    /// <summary>Reloads the given page.</summary>
    /// <param name="params">Load parameters.</param>

    var count = 0;
    var offset = 0;
    var self = this;
    var nextPage = 0;
    var totalLoaded = 0;
    var onComplete = null;

    params = params || {};
    onComplete = params.onComplete || function () { }

    /* Validating required parameters */
    if (typeof (params.page) != 'undefined' && params.page > 0 && params.page <= this.get_totalPages()) {
        totalLoaded = this._totalServerVisitorsLoaded;

        this.trace('Getting new page: ' + params.page + ', total loaded: ' + totalLoaded);

        /* No visitors is loaded - simply loading the desired page */
        if (totalLoaded < 0) {
            this.reload({ page: params.page });
        } else {
            count = this.get_pageSize();
            offset = (params.page - 1) * count;

            /* There are still some visitors available on the client for this page so there is no need to make new request */
            if ((offset < totalLoaded && (offset + count) <= totalLoaded) || totalLoaded == this._totalServerVisitors) {
                this.trace('Rendering from cache (offset: ' + offset + ', count: ' + count + ')');

                /* We also need to preload some more records in a background for avoiding delays when navigating to the next page */
                if (this._totalServerVisitors > totalLoaded && ((params.page + 1) <= this.get_totalPages() && ((params.page + 1) * count > (totalLoaded - this._removedVisitorsCount)))) {
                    nextPage = params.page + 1;

                    this.trace('Preloading page ' + nextPage + ', with ' + this.get_preloadAmount() + ' records');

                    setTimeout(function () {
                        /* Loading visitors without populating them (user is not on this page yet) */
                        self.get_preloadQueue().enqueue({ page: nextPage });
                    }, 25);
                }

                /* Populating the given page from cache */
                this.populate({ range: { start: offset, count: count} });
            } else {
                this.trace('Loading from the server (offset: ' + offset + ', count: ' + count + ')');

                if (!this.get_preloadQueue().contains({ page: params.page })) {
                    this.get_preloadQueue().enqueue({ page: params.page });
                }

                /* Populating the given page (will display a "Loading" message if the data is still being preloaded) */
                this.populate({ range: { start: offset, count: count} });
            }
        }
    } else {
        onComplete();
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.reset = function (reserveSpace) {
    /// <summary>Resets the state of the control.</summary>
    /// <param name="reserveSpace">Value indicating whether simply clear the content area without performing the default action (e.g. showing "Nothing found" message).</param>

    this.get_visitors().clear();
    this.get_preloadQueue().clear();

    this.set_totalVisitors(0);

    this._totalServerVisitors = -1;
    this._totalServerVisitorsLoaded = -1;
    this._removedVisitorsCount = 0;
    this._addedVisitorsCount = 0;

    this.clear(reserveSpace);

    this._clearLocationTimeout();
}

Dynamicweb.Controls.OMC.LeadsList.prototype.populate = function (params) {
    /// <summary>Presents the given range of visitors to the user.</summary>
    /// <param name="params">Populate parameters.</param>

    var range = {};
    var self = this;
    var mode = 'default';
    var hasRecords = false;

    this._isPopulating = true;

    params = params || {};

    range = params.range;

    if (typeof (params.mode) != 'undefined' && params.mode.length) {
        mode = params.mode.toString().toLowerCase();
    }

    /* Default action is to perform IP to location lookup right after the list is populated */
    if (typeof (params.geolocation) == 'undefined' || params.geolocation == null) {
        params.geolocation = { queue: true, query: true };
    }

    if (!range) range = { start: 0, count: this.get_pageSize() };
    if (range.start < 0) range.start = 0;
    if (range.count <= 0) range.count = this.get_pageSize();

    if (mode != 'append' && mode != 'prepend') {
        this.clear(true);
    }

    if (range.start >= 0 && range.count > 0) {
        if (range.start + range.count >= this.get_visitors().get_count()) {
            range.count = this.get_visitors().get_count() - range.start;
        }

        if (range.count > 0) {
            hasRecords = true;

            if (params.reverse) {
                for (var i = (range.start + range.count - 1); i >= range.start; i--) {
                    this.populateVisitor(this.get_visitors().get_item(i), i, (mode == 'prepend'));
                }
            } else {
                for (var i = range.start; i <= (range.start + range.count - 1); i++) {
                    this.populateVisitor(this.get_visitors().get_item(i), i, (mode == 'prepend'));
                }
            }

            /* Clearing the geolocation queue if specified by caller */
            if (!params.geolocation.queue) {
                this.get_queue().empty();
            }

            /* Notifying subscribers that the list has been populated */
            this.onAfterPopulate({ range: range });

            /* Restoring the selection */
            this.onSelectionChanged();

            /* Filling out location information */
            if (params.geolocation.query && this.get_queue().get_count() > 0) {
                this.queryLocation();
            }
        }
    }

    if (!hasRecords) {
        if (this.get_isPreloading()) {
            this.set_isLoading(true);

            this.get_preloadQueue().set_onComplete(function () {
                self.get_preloadQueue().set_onComplete(null);

                self.populate(params);
                self.set_isLoading(false);
            });
        } else {
            this.clear();
            this._isPopulating = false;

            this.trace('No data to populate, range: <b>' + range.start + ', ' + range.count + '</b>', 'red');
        }
    } else {
        this._isPopulating = false;
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.populateVisitor = function (v, position, bubbleUp) {
    /// <summary>Populates the given visitor.</summary>
    /// <param name="v">Visitor to populate.</param>
    /// <param name="position">Zero-based position of the visitor in the overall list.</param>
    /// <param name="bubbleUp">Value indicating whether to render the given visitor as the first row in the list.</param>

    /* Placing new geolocation request if the user has no location information associated with him/her */
    if (v && !v.get_isKnownLocation()) {
        this.get_queue().enqueue({ position: position, ipAddress: v.get_ipAddress(), id: v.get_id() });
    }

    this.onRowPopulated({ visitor: v, position: position });
}

Dynamicweb.Controls.OMC.LeadsList.prototype.queryLocation = function (params) {
    /// <summary>Queries geo-location service to get location information for currently queued visitors.</summary>
    /// <param name="geo">Location information.</param>

    var p = null;
    var self = this;
    var requests = [];
    var requestData = {};
    var positionMap = [];
    var onComplete = null;
    var hasPosition = false;
    var ipAddressString = '';
    var ipAddressCollector = {};

    params = params || {};
    onComplete = params.onComplete || function () { }

    /* Determining what to query web-service for */
    if (typeof (params.data) != 'undefined' && typeof (params.data.length) != 'undefined') {
        requests = params.data;
    } else {
        requests = this.get_queue().empty();
    }

    if (requests && requests.length > 0) {
        /* Initializing request parameters */
        for (var i = 0; i < requests.length; i++) {
            if (requests[i] && requests[i].ipAddress && requests[i].ipAddress.length) {
                if (!ipAddressCollector[requests[i].ipAddress]) {
                    ipAddressCollector[requests[i].ipAddress] = requests[i].ipAddress;
                    ipAddressString += requests[i].ipAddress;
                }

                if (!positionMap[requests[i].ipAddress]) {
                    positionMap[requests[i].ipAddress] = [];
                }

                hasPosition = false;
                for (var j = 0; j < positionMap[requests[i].ipAddress].length; j++) {
                    if (positionMap[requests[i].ipAddress][j] == requests[i].position) {
                        hasPosition = true;
                        break;
                    }
                }

                if (!hasPosition) {
                    positionMap[requests[i].ipAddress][positionMap[requests[i].ipAddress].length] = {
                        position: requests[i].position,
                        id: requests[i].id
                    };
                }
            }

            if (i < (requests.length - 1)) {
                ipAddressString += ',';
            }
        }

        if (ipAddressString.length) {
            p = this.get_currentPageIndex();
            requestData = { IP: ipAddressString };


            this.onBeforeQueryLocation({ requests: requests, page: p });

            /* Making a request */
            parent.OMC.MasterPage.get_current().executeTask('GetLocation', requestData, function (response) {
                var ip = '';
                var data = null;

                if (response && response.length) {
                    /* Parsing response */
                    try {
                        data = response.evalJSON();
                    } catch (ex) { }

                    self.onAfterQueryLocation({ requests: requests, data: data, page: p });

                    if (data && data.location && data.location.length) {
                        for (var i = 0; i < data.location.length; i++) {
                            /* Matching the resulting IP-address with the position map created earlier */
                            ip = data.location[i].IPAddress || data.location[i].ipAddress;

                            /* Assigning location to the visitor */
                            if (ip && positionMap[ip] != null && positionMap[ip].length) {
                                for (var j = 0; j < positionMap[ip].length; j++) {
                                    self.setVisitorLocation(data.location[i], positionMap[ip][j].position, positionMap[ip][j].id);
                                }
                            }
                        }
                    }
                } else {
                    self.onAfterQueryLocation({ requests: requests, data: null });
                }

                onComplete();
            }, true);
        } else {
            onComplete();
        }
    } else {
        onComplete();
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.setVisitorLocation = function (geo, position, vid) {
    /// <summary>Assigns location information to the given visitor.</summary>
    /// <param name="geo">Location information.</param>
    /// <param name="position">Zero-based position of the visitor in the overall list.</param>

    var v = null;
    var data = {};

    if (geo) {
        data = {
            isp: geo.ISP || geo.isp,
            countryCode: geo.CountryCode || geo.countryCode,
            countryName: geo.CountryName || geo.countryName,
            ipAddress: geo.IPAddress || geo.ipAddress,
            domain: geo.Domain || geo.domain,
            latitude: geo.Latitude || geo.latitude,
            longitude: geo.Longitude || geo.longitude,
            region: geo.Region || geo.region,
            city: geo.City || geo.city,
            zip: geo.Zip || geo.zip,
            company: geo.Company || geo.company
        }

        if (position >= 0 && position < this.get_visitors().get_count()) {
            if (vid) {
                var vel = $$("[data-id=" + vid + "]");
                if (vel && vel.length > 0) {
                    position = parseInt(vel[0].readAttribute("data-position"))
                }
            }
            v = this.get_visitors().get_item(position);

            v.set_isp(data.isp);
            v.set_company(data.company);
            v.set_countryCode(data.countryCode);
            v.set_countryName(data.countryName);
            v.set_location(data);

            this.get_visitors().set_item(position, v);

            this.onLocationAssigned({ position: position, data: data });
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.clear = function (reserveSpace) {
    /// <summary>Clears the list (but no the underlying collection).</summary>
    /// <param name="reserveSpace">Value indicating whether simply clear the content area without performing the default action (e.g. showing "Nothing found" message).</param>

    this.onSelectionChanged({ selection: new Hash() });
}

Dynamicweb.Controls.OMC.LeadsList.prototype.clearSelection = function () {
    /// <summary>Deselects all currently selected rows.</summary>

    var indexes = [];
    var selection = this.get_selection();

    if (selection != null && selection.keys().length > 0) {
        indexes = selection.keys();

        for (var i = 0; i < indexes.length; i++) {
            selection.get(indexes[i]).set_isSelected(false);
        }

        this.onSelectionChanged();
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onReady = function (args) {
    /// <summary>Raises "ready" event.</summary>
    /// <param name="args">Event arguments.</param>

    if (args && args.callback) {
        args.callback(this, {});
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onSortOrderChanged = function (args) {
    /// <summary>Raises "sortOrderChanged" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('sortOrderChanged', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onBeforeLoad = function (args) {
    /// <summary>Raises "beforeLoad" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('beforeLoad', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onAfterLoad = function (args) {
    /// <summary>Raises "afterLoad" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('afterLoad', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onRowPopulated = function (args) {
    /// <summary>Raises "rowPopulated" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('rowPopulated', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onBeforeQueryLocation = function (args) {
    /// <summary>Raises "beforeQueryLocation" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('beforeQueryLocation', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onAfterQueryLocation = function (args) {
    /// <summary>Raises "afterQueryLocation" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('afterQueryLocation', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onLocationAssigned = function (args) {
    /// <summary>Raises "locationAssigned" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('locationAssigned', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onRowClick = function (args) {
    /// <summary>Raises "rowClick" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('rowClick', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onPageIndexChanged = function (args) {
    /// <summary>Raises "pageIndexChanged" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('pageIndexChanged', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onAfterPopulate = function (args) {
    /// <summary>Raises "afterPopulate" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('afterPopulate', args || {});
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onSelectionChanged = function (args) {
    /// <summary>Raises "selectionChanged" event.</summary>
    /// <param name="args">Event arguments.</param>

    var e = {}

    if (args && args.selection) {
        e = { selection: args.selection }
    } else {
        e = { selection: this.get_selection() }
    }

    this.notify('selectionChanged', e);
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onActiveChanged = function (args) {
    /// <summary>Raises "stateChanged" event with state set to "active".</summary>
    /// <param name="args">Event arguments.</param>

    this.onStateChanged({ visitor: args.visitor, state: 'active', value: args.active });
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onStateChanged = function (args) {
    /// <summary>Raises "stateChanged" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('stateChanged', args);
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onVisitorMarked = function (args) {
    /// <summary>Raises "visitorMarked" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('visitorMarked', args);
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onVisitorAdded = function (args) {
    /// <summary>Raises "visitorAdded" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('visitorAdded', args);
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onVisitorRemoved = function (args) {
    /// <summary>Raises "visitorRemoved" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('visitorRemoved', args);
}

Dynamicweb.Controls.OMC.LeadsList.prototype.onTotalVisitorsChanged = function (args) {
    /// <summary>Raises "totalVisitorsChanged" event.</summary>
    /// <param name="args">Event arguments.</param>

    this.notify('totalVisitorsChanged', args);
}

Dynamicweb.Controls.OMC.LeadsList.prototype.notify = function (eventName, args) {
    /// <summary>Notifies clients about the specified event.</summary>
    /// <param name="eventName">Event name.</param>
    /// <param name="args">Event arguments.</param>

    var callbacks = [];
    var callbackException = null;

    if (eventName && eventName.length) {
        callbacks = this._handlers[eventName];

        if (callbacks && callbacks.length) {
            if (typeof (args) == 'undefined' || args == null) {
                args = {};
            }

            for (var i = 0; i < callbacks.length; i++) {
                callbackException = null;

                try {
                    callbacks[i](this, args);
                } catch (ex) {
                    callbackException = ex;
                }

                /* Preventing "Unable to execute code from freed script" errors to raise */
                if (callbackException && callbackException.number != -2146823277) {
                    this.error(callbackException.message);
                }
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.addMultipleVisitors = function (visitors) {
    /// <summary>Adds the given visitors to the end of the list.</summary>
    /// <param name="visitors">Visitors to add.</param>

    var addedVisitorsCount = 0;
    var visitorsToPositions = [];
    var orignalEmpty = this.get_isEmpty();
    var originalTotalPages = this.get_totalPages();

    if (visitors && visitors.length) {
        for (var i = 0; i < visitors.length; i++) {
            if (visitors[i] && typeof (visitors[i].get_id) == 'function') {
                if (this.get_visitors().indexOf(visitors[i]) < 0) {
                    this.get_visitors().addAt(addedVisitorsCount, visitors[i]);
                    addedVisitorsCount += 1;

                    visitorsToPositions[visitorsToPositions.length] = { position: addedVisitorsCount, visitor: visitors[i] };
                }
            }
        }

        this._addedVisitorsCount += addedVisitorsCount;
        this._removedVisitorsCount -= addedVisitorsCount;
        if (this._removedVisitorsCount < 0) {
            this._removedVisitorsCount = 0;
        }

        /* Changing the total available amount of visitors (doesn't affect the ability of the list to preload items that hasn't been discovered yet) */
        this.set_totalVisitors(this.get_totalVisitors() + addedVisitorsCount);

        if (addedVisitorsCount > 0) {
            /* Firing event (reflecting the change on the UI) */
            this.onVisitorAdded({ range: visitorsToPositions });

            /* Firing "selectionChanged" if needed */
            this.onSelectionChanged();
        }

        /* Initializing pager */
        if (orignalEmpty || originalTotalPages == 1 && this.get_totalPages() > 1) {
            this.set_isLoading(false);

            if (this.get_totalPages() > 1) {
                this.set_currentPageIndex(1);
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.tryUpdateLeadState = function (v) {
    /// <summary>Tries to reflect the update state change of the given visitor within the list UI.</summary>
    /// <param name="v">Visitor whose state has been updated.</param>

    var state = '';
    var states = null;
    var dropDown = null;
    var reference = null;

    if (v && typeof (v.get_id) == 'function') {
        state = v.get_state();

        if (typeof (state) == 'undefined' || state == null) {
            state = '';
        }

        state = state.toLowerCase();
        reference = this._generateID('row' + v.get_id());

        dropDown = document.getElementById(reference + '_leadstate');
        if (dropDown) {
            if (this.get_visitorStatesPresentationType() == 'dropdown') {
                for (var i = 0; i < dropDown.options.length; i++) {
                    if (dropDown.options[i].value.toLowerCase() == state) {
                        dropDown.selectedIndex = i;
                        break;
                    }
                }
            } else if (this.get_visitorStatesPresentationType() == 'balloon') {
                states = this.get_visitorStates();

                if (state.length == 0) {
                    state = states[1].toLowerCase();
                } else if (state == this.get_potentialLeadState().toLowerCase()) {
                    state = states[0].toLowerCase();
                }

                for (var i = 0; i < states.length; i++) {
                    if (states[i].toLowerCase() == state) {
                        dropDown.innerHTML = states[i];
                        break;
                    }
                }
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.addVisitor = function (v) {
    /// <summary>Adds the given visitor to the end of the list.</summary>
    /// <param name="v">Visitor to add.</param>

    var position = 0;
    var wasAdded = false;
    var orignalEmpty = this.get_isEmpty();
    var originalTotalPages = this.get_totalPages();

    if (v && typeof (v.get_id) == 'function') {
        position = this.get_visitors().indexOf(v);

        if (position < 0) {
            position = 0;
            wasAdded = true;

            /* Adding visitor to the collection */
            this.get_visitors().addAt(position, v);

            this._addedVisitorsCount += 1;
            if (this._removedVisitorsCount > 0) {
                this._removedVisitorsCount -= 1;
            }

            /* Encreasing the total available amount of visitors (doesn't affect the ability of the list to preload items that hasn't been discovered yet) */
            this.set_totalVisitors(this.get_totalVisitors() + 1);
        }

        if (wasAdded) {
            /* Firing event (reflecting the change on the UI) */
            this.onVisitorAdded({ position: position, visitor: v });

            /* Firing "selectionChanged" if needed */
            this.onSelectionChanged();
        }

        /* Initializing pager */
        if (orignalEmpty || originalTotalPages == 1 && this.get_totalPages() > 1) {
            this.set_isLoading(false);

            if (this.get_totalPages() > 1) {
                this.set_currentPageIndex(1);
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.removeMultipleVisitors = function (visitors) {
    /// <summary>Removes the given visitors from the list.</summary>
    /// <param name="visitors">Visitors to remove.</param>
    /// <remarks>Target visitors must reside on a same page. Otherwise, the exception is thrown.</remarks>

    var page = 0;
    var self = this;
    var remaining = 0;
    var position = -1;
    var preloadPage = 0;
    var minPosition = null;
    var maxPosition = null;
    var preloadRequest = {};
    var removedVisitorsCount = 0;
    var visitorsToPositions = [];
    var appendVisitorPosition = 0;
    var originalTotalPages = this.get_totalPages();

    if (visitors && visitors.length) {
        for (var i = 0; i < visitors.length; i++) {

            if (visitors[i] && typeof (visitors[i].get_visitorID) != 'undefined') {
                position = this.getVisitorPosition(visitors[i]);

                if (position >= 0 && position < this.get_visitors().get_count()) {
                    /* Associating positions with visitors */
                    visitorsToPositions[visitorsToPositions.length] = { visitor: visitors[i], position: position }
                }

                if (minPosition == null || minPosition > position) {
                    minPosition = position;
                }

                if (maxPosition == null || maxPosition < position) {
                    maxPosition = position;
                }
            }
        }

        /* Validating target range */
        if (this.getVisitorPage(maxPosition) != this.getVisitorPage(minPosition)) {
            this.error('Removing visitors from multiple pages at once is not allowed.');
        } else {
            page = parseInt((minPosition + 1) / this.get_pageSize());
            if ((page * this.get_pageSize()) < (minPosition + 1)) {
                page += 1;
            }

            if (page <= 0) {
                page = 1;
            }

            for (var i = 0; i < visitorsToPositions.length; i++) {
                /* Removing visitor from the collection */
                this.get_visitors().removeAt(visitorsToPositions[i].position - removedVisitorsCount);
                removedVisitorsCount += 1;
            }

            this._removedVisitorsCount += removedVisitorsCount;
            this._addedVisitorsCount -= removedVisitorsCount;

            if (this._addedVisitorsCount < 0) {
                this._addedVisitorsCount = 0;
            }

            /* Changing the total available amount of visitors (doesn't affect the ability of the list to preload items that hasn't been discovered yet) */
            if ((this.get_totalVisitors() - removedVisitorsCount) > 0) {
                this.set_totalVisitors(this.get_totalVisitors() - removedVisitorsCount);
            } else {
                this.set_totalVisitors(0);
            }

            /* Firing event (reflecting the change on the UI) */
            this.onVisitorRemoved({ range: visitorsToPositions });

            /* Firing "selectionChanged" if needed */
            this.onSelectionChanged();

            /* Were there more than one page originally? */
            if (originalTotalPages > 1) {
                if (page < originalTotalPages) {
                    appendVisitorPosition = (this.get_pageSize() * page) - removedVisitorsCount;

                    if (appendVisitorPosition < this.get_visitors().get_count()) {
                        this.populate({ range: { start: appendVisitorPosition, count: removedVisitorsCount }, mode: 'append' });

                        if (this._totalServerVisitorsLoaded < this._totalServerVisitors) {
                            remaining = this.get_visitors().get_count() - appendVisitorPosition;

                            this.trace('Remaining available visitors: ' + remaining);

                            if (remaining < (this.get_pageSize() + 1)) {
                                preloadPage = parseInt(this._totalServerVisitorsLoaded / this.get_pageSize());
                                preloadRequest = { page: preloadPage };

                                if (!this.get_preloadQueue().contains(preloadRequest) && !this.get_preloadQueue().isCompleted(preloadRequest)) {
                                    setTimeout(function () {
                                        /* Preloading some more visitors without populating them */
                                        self.get_preloadQueue().enqueue(preloadRequest);
                                    }, 25);
                                }
                            }
                        }
                    } else {
                        /* Invalidating the entire area */
                        this.set_isLoading(false);
                    }
                } else if (this.get_totalPages() < originalTotalPages) {
                    /* Visitor was removed from the last page - checking whether this was the last row on the last page */
                    if (this.get_currentPageIndex() > 1) {
                        /* Nothing to display on the last page - loading previos page */
                        this.set_currentPageIndex(this.get_currentPageIndex() - 1);
                    } else {
                        this.reset();
                    }
                }

                /* Invalidating the entire area (hiding paging bar) */
                if (this.get_totalPages() == 1 && originalTotalPages > 1) {
                    this.set_isLoading(false);
                }
            } else {
                /* Invalidating the entire area (hiding paging bar) */
                this.set_isLoading(false);
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.removeVisitor = function (position) {
    /// <summary>Removes the visitor at the given position.</summary>
    /// <param name="position">Zero-based index of the visitor.</param>

    var v = null;
    var self = this;
    var remaining = 0;
    var visitorPage = 0;
    var preloadPage = 0;
    var preloadRequest = {};
    var appendVisitorPosition = 0;
    var originalTotalPages = this.get_totalPages();

    if (position >= 0 && position < this.get_visitors().get_count()) {
        if (this.get_visitors().get_count() == 1) {
            this.reset();
        } else {
            /* Getting the target visitor */
            v = this.get_visitors().get_item(position);

            visitorPage = parseInt((position + 1) / this.get_pageSize());
            if ((visitorPage * this.get_pageSize()) < (position + 1)) {
                visitorPage += 1;
            }

            if (visitorPage <= 0) {
                visitorPage = 1;
            }

            this.trace('Removing visitor (position: ' + position + ', page: ' + visitorPage + ')');

            /* Removing visitor from the collection */
            this.get_visitors().removeAt(position);
            this._removedVisitorsCount += 1;
            if (this._addedVisitorsCount > 0) {
                this._addedVisitorsCount -= 1;
            }

            /* Decreasing the total available amount of visitors (doesn't affect the ability of the list to preload items that hasn't been discovered yet) */
            if (this.get_totalVisitors() > 0) {
                this.set_totalVisitors(this.get_totalVisitors() - 1);
            }

            /* Firing event (reflecting the change on the UI) */
            this.onVisitorRemoved({ position: position, visitor: v });

            /* Firing "selectionChanged" if needed */
            this.onSelectionChanged();

            /* Were there more than one page originally? */
            if (originalTotalPages > 1) {
                if (visitorPage < originalTotalPages) {
                    appendVisitorPosition = (this.get_pageSize() * visitorPage) - 1;

                    if (appendVisitorPosition < this.get_visitors().get_count()) {
                        this.populate({ range: { start: appendVisitorPosition, count: 1 }, mode: 'append' });

                        if (this._totalServerVisitorsLoaded < this._totalServerVisitors) {
                            remaining = this.get_visitors().get_count() - appendVisitorPosition;

                            this.trace('Remaining available visitors: ' + remaining);

                            if (remaining < (this.get_pageSize() + 1)) {
                                preloadPage = parseInt(this._totalServerVisitorsLoaded / this.get_pageSize());
                                preloadRequest = { page: preloadPage };

                                if (!this.get_preloadQueue().contains(preloadRequest) && !this.get_preloadQueue().isCompleted(preloadRequest)) {
                                    setTimeout(function () {
                                        /* Preloading some more visitors without populating them */
                                        self.get_preloadQueue().enqueue(preloadRequest);
                                    }, 25);
                                }
                            }
                        }
                    } else {
                        /* Invalidating the entire area */
                        this.set_isLoading(false);
                    }
                } else if (this.get_totalPages() < originalTotalPages) {
                    /* Visitor was removed from the last page - checking whether this was the last row on the last page */
                    if (this.get_currentPageIndex() > 1) {
                        /* Nothing to display on the last page - loading previos page */
                        this.set_currentPageIndex(this.get_currentPageIndex() - 1);
                    } else {
                        this.reset();
                    }
                }

                /* Invalidating the entire area (hiding paging bar) */
                if (this.get_totalPages() == 1 && originalTotalPages > 1) {
                    this.set_isLoading(false);
                }
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.error = function (message) {
    /// <summary>Displays an error message.</summary>
    /// <param name="message">Error message.</param>

    var er = null;

    if (typeof (Error) != 'undefined') {
        er = new Error();

        er.message = message;
        er.description = message;

        throw (er);
    } else {
        throw (message);
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.trace = function (message, color) {
    /// <summary>Writes trace message to the screen.</summary>
    /// <param name="message">Message to write.</param>
    /// <param name="color">Color for the new message.</param>

    var c = null;
    var containerID = '';
    var containerHeight = 200;
    var existingContainers = 0;

    if (this.get_enableTrace()) {
        containerID = this.get_container().id + '_debug';

        c = this._cache.document.getElementById(containerID);

        if (!c) {
            existingContainers = $(this._cache.documentBody).select('.omc-leads-list-debug').length;

            c = new Element('div', { 'class': 'omc-leads-list-debug' });

            c.id = containerID;
            c.setStyle({ 'right': '0px', 'height': containerHeight + 'px', 'top': (containerHeight * existingContainers) + 'px' });

            this._cache.documentBody.appendChild(c);

            c.innerHTML = ('<strong>' + this.get_associatedControlID() + '</strong>');
        }

        if (typeof (color) == 'undefined' || color == null || !color.length) {
            c.innerHTML += ('<span>' + message + '</span>');
        } else {
            c.innerHTML += ('<span style="color: ' + color + '">' + message + '</span>');
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype.getVisitorPosition = function (v) {
    /// <summary>Returns the position of the given visitor in the list.</summary>
    /// <param name="v">Visitor reference.</param>

    var id = '';
    var ret = -1;
    var row = null;
    var info = null;

    if (v) {
        if (v.get_id) {
            id = v.get_id();
        } else if (typeof (v) == 'string' || typeof (v) == 'number') {
            id = v.toString();
        }

        if (id) {
            id = this._generateID('row' + id);
            row = document.getElementById(id);

            if (row) {
                ret = parseInt($(row).readAttribute('data-position'));
                if (isNaN(ret) || ret == null) {
                    ret = -1;
                }
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.getVisitorPage = function (v) {
    /// <summary>Returns a page number that the given visitor resides on.</summary>
    /// <param name="v">Visitor reference.</param>

    var ret = -1;
    var position = -1;

    if (typeof (v) != 'undefined') {
        if (typeof (v) == 'number') {
            position = v;
        } else if (typeof (v.get_visitorID) != 'undefined') {
            position = this.getVisitorPosition(v);
        }

        if (position >= 0 && position < this.get_visitors().get_count()) {
            ret = parseInt((position + 1) / this.get_pageSize());
            if ((ret * this.get_pageSize()) < (position + 1)) {
                ret += 1;
            }

            if (ret <= 0) {
                ret = 1;
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype.getVisitorByVisitorID = function (visitorID) {
    /// <summary>Finds the given visitor by its visitor ID.</summary>
    /// <param name="visitorID">Visitor ID.</param>

    return this.get_visitors().find({ key: 'visitorID', value: visitorID });
}

Dynamicweb.Controls.OMC.LeadsList.prototype._bindToUI = function () {
    /// <summary>Binds the object to UI.</summary>

    var self = this;

    this._binder = new Dynamicweb.UIBinder(this);

    this._binder.bindProperty('isLoading', [{ elements: [], action: function (sender, args) {
            var v = !!args.value;

            self._cache.contentContainer.hide();
            self._cache.emptyContainer.hide();
            self._cache.footer.setStyle({ 'visibility': 'hidden' });

            if (v) {
                self._cache.contentProgress.show();
            } else {
                self._cache.contentProgress.hide();

                if (self.get_isEmpty()) {
                    self._cache.emptyContainer.show();
                } else {
                    self._cache.contentContainer.show();

                    if (self.get_totalVisitors() > self.get_pageSize()) {
                        self._cache.footer.setStyle({ 'visibility': 'visible' });
                    }
                }
            }
        }
    }]);

    this._binder.bindProperty('isEnabled', [{ elements: [this._cache.disabledOverlay], action: new Dynamicweb.UIBinder.Actions.ToggleVisibility(true)}]);

    this._binder.bindMethod('clear', [{ elements: [], action: function (sender, args) {
            var showMessage = !!args.parameters[0];
            self._cache.contentContainer.innerHTML = '';

            if (!self.get_isLoading() && !showMessage) {
                if (self.get_isEmpty()) {
                    self._cache.emptyContainer.show();

                    self._cache.contentContainer.hide();
                    self._cache.contentProgress.hide();
                    self._cache.footer.setStyle({ 'visibility': 'hidden' });
                }
            }
        }
    }]);

    this._binder.bindMethod('populateVisitor', [{ elements: [], action: function (sender, args) {
            var p = null;
            var reference = '';
            var checkbox = null;
            var container = null;
            var markColumn = null;
            var totalVisits = null;
            var markLeadLink = null;
            var markInfoLink = null;
            var detailsColumn = null;
            var innerFragment = null;
            var outerFragment = null;
            var countryColumn = null;
            var markIgnoreLink = null;
            var checkboxColumn = null;
            var detailsInfoLink = null;
            var v = args.parameters[0];
            var markNotLeadLink = null;
            var leadStatesDropDown = null;
            var bubbleUp = !!args.parameters[2];
            var position = (parseInt(args.parameters[1]) || 0);
            var markLeadEmail = null;

            var markLinkCreator = function (cssClass, text, state, isLead, isTracking, isp) {
                var lnk = null;

                if (state != 'ignored') {
                    if (!isTracking) {
                        cssClass = 'omc-leads-list-mark-disabled ' + (cssClass + '-disabled');
                    } else {
                        if (isLead != null) {
                            if ((state == 'approved' && isLead) || (state == 'discarded' && !isLead)) {
                                cssClass = 'omc-leads-list-mark-disabled ' + (cssClass + '-disabled');
                            }
                        }
                    }
                }

                lnk = self._createElement('a', { 'class': cssClass, 'href': 'javascript:void(0);', 'content': '', 'title': text, 'reference': reference, 'click': function (e) {
                        var targetVisitor = null;
                        var elm = $(Event.element(e));
                        var info = self._rowInfo(elm);

                        if (!elm.hasClassName('omc-leads-list-mark-disabled') && info.reference) {
                            targetVisitor = self.get_visitors().get_item(info.position);

                            if (state == 'explained') {
                                self.onRowClick({
                                    rowType: 'row',
                                    visitor: targetVisitor,
                                    position: info.position,
                                    element: elm
                                });
                            } else {
                                if (state == 'ignored') {
                                    self.addKnownProvider(targetVisitor.get_isp());
                                }

                                self.onVisitorMarked({ position: info.position, state: state, visitor: targetVisitor });
                            }
                        }
                    }
                });

                return lnk;
            }

            if (v && v.get_id()) {
                outerFragment = self._cache.document.createDocumentFragment();
                innerFragment = self._cache.document.createDocumentFragment();

                container = self._createElement('ul', { 'class': 'omc-leads-list-row', 'click': function (e) {
                        var elm = Event.element(e);
                        var info = self._rowInfo(elm);

                        self.onRowClick({
                            rowType: 'row',
                            visitor: self.get_visitors().get_item(info.position),
                            position: info.position,
                            element: Event.element(e)
                        });
                    }
                });

                p = self.get_currentPageIndex();
                reference = self._generateID('row' + v.get_id());

                /* Setting attributes for a new row */
                container.id = reference;
                container.writeAttribute('data-position', position);
                container.writeAttribute('data-page', p);
                container.writeAttribute('data-id', v.get_id());

                /* Inactive (dimmed) row */
                if (!v.get_isActive()) {
                    container.addClassName('omc-leads-list-row-inactive');
                }

                /* Adding a column that contains row number (1-based) */
                innerFragment.appendChild(self._createElement('li', { 'class': 'omc-leads-list-field-number', id: reference + '_number', 'reference': reference, 'content': self._nonEmpty(position + 1) }));

                /* Adding a column with a checkbox field */
                checkboxColumn = self._createElement('li', { 'class': 'omc-leads-list-field-checkbox', id: reference + '_checkbox', 'reference': reference });
                checkbox = self._createElement('input', { 'type': 'checkbox', 'value': position, id: reference + '_checkbox_field', 'reference': reference, 'click': function (e) {
                        var elm = Event.element(e);
                        var v = self.get_visitors().get_item(parseInt(elm.value));

                        if (!elm.checked) {
                            self._cache.headerCheckbox.checked = false;
                        }

                        if (v) {
                            v.set_isSelected(elm.checked);
                        }
                    }
                });

                checkboxColumn.appendChild(checkbox);
                innerFragment.appendChild(checkboxColumn);

                /* "Total visits" column */
                totalVisits = self._createElement('li', { 'class': 'omc-leads-list-field-totalvisits', id: reference + '_totalvisits', 'reference': reference });
                totalVisits.appendChild(self._createTotalVisitsElement(position, v.get_visitsCount()));
                innerFragment.appendChild(totalVisits);

                /* "Last visit" column */
                innerFragment.appendChild(self._createElement('li', { 'class': 'omc-leads-list-field-lastvisit', id: reference + '_lastvisit', 'reference': reference, 'content': self._nonEmpty(self._formatLastVisit(v.get_lastVisit().get_timestamp(), v.get_isTracking())) }));

                /* "Pageviews" column */
                innerFragment.appendChild(self._createElement('li', { 'class': 'omc-leads-list-field-lastvisitpageviews', id: reference + '_lastvisitpageviews', 'reference': reference, 'content': self._nonEmpty(self._formatLastPageviews(v.get_lastVisit().get_pageviews(), v.get_lastVisit().get_searchKeywords())) }));

                /* "Engagement" column */
                innerFragment.appendChild(self._createElement('li', { 'class': 'omc-leads-list-field-engagement', id: reference + '_engagement', 'reference': reference, 'content': self._nonEmpty(self._formatEngagement(v.get_engagement())) }));

                /* "CartReference" column */
                if (v.get_showOrdersAndUsers()) {
                    innerFragment.appendChild(self._createElement('li', { 'class': 'omc-leads-list-field-cartReference', id: reference + '_cartReference', 'reference': reference, 'content': self._nonEmpty(self._formatCartReference(v.get_cartReference())) }));
                };

                /* "UserName" column */
                if (v.get_showOrdersAndUsers()) {
                innerFragment.appendChild(self._createElement('li', { 'class': 'omc-leads-list-field-userName', id: reference + '_username', 'reference': reference, 'content': self._nonEmpty(self._formatUserName(v.get_userName())) }));
                };

                /* "Country" column */
                var changeState = "";
                if (self.get_editMode() == 1) {
                    changeState = "-change-state";
                }
                if (v.get_userCompany() && v.get_showOrdersAndUsers()) {
                    countryColumn = self._createElement('li', { 'class': 'omc-leads-list-field-userCompany' + changeState, id: reference + '_company', 'reference': reference, 'content': self._nonEmpty(self._formatUserCompany(v.get_userCompany())) });
                }
                else {
                    countryColumn = self._createElement('li', { 'class': 'omc-leads-list-field-country' + changeState, id: reference + '_country', 'reference': reference });
                    countryColumn.appendChild(self._createCountryElement(v.get_countryCode(), v.get_company(), reference));
                }
                innerFragment.appendChild(countryColumn);

                /* Adding "Actions" column when changing states (contains only "Details" icon) */
                if (self.get_editMode() == 1) {
                    if (self.get_displayMode() == 1) {
                        detailsColumn = self._createElement('li', { 'class': 'omc-leads-list-field-details omc-leads-list-compact', id: reference + '_details', 'reference': reference });
                    } else {
                        detailsColumn = self._createElement('li', { 'class': 'omc-leads-list-field-details', id: reference + '_details', 'reference': reference });
                    }

                    detailsInfoLink = markLinkCreator('omc-leads-list-mark-info', self.get_seeMoreDetailsMessage(), 'explained', v.get_isLead(), v.get_isTracking(), v.get_isp());
                    detailsInfoLink.appendChild(self._createElement('span', { 'class': 'omc-leads-list-clear', 'reference': reference, 'content': '' }));

                    detailsColumn.appendChild(detailsInfoLink);
                }

                /* Adding "Mark" column and its contents (two links and a separator) */
                markColumn = self._createElement('li', { 'class': 'omc-leads-list-field-mark', id: reference + '_mark', 'reference': reference });

                if (self.get_editMode() == 0) { /* "Mark visitors" */
                    markInfoLink = markLinkCreator('omc-leads-list-mark-info', self.get_seeMoreDetailsMessage(), 'explained', v.get_isLead(), v.get_isTracking(), v.get_isp());
                    markIgnoreLink = markLinkCreator('omc-leads-list-mark-ignore', self.get_ignoreISPMessage(), 'ignored', v.get_isLead(), v.get_isTracking(), v.get_isp());
                    markNotLeadLink = markLinkCreator('omc-leads-list-mark-notlead', self.get_notLeadMessage(), 'discarded', v.get_isLead(), v.get_isTracking(), v.get_isp());
                    markLeadLink = markLinkCreator('omc-leads-list-mark-lead', self.get_leadMessage(), 'approved', v.get_isLead(), v.get_isTracking(), v.get_isp());
                    markLeadEmail = markLinkCreator('omc-leads-list-mark-email', self.get_sendLeadEmailMessage(), 'sent', v.get_isLead(), v.get_isTracking(), v.get_isp());

                    markIgnoreLink.id = reference + '_ignoreisp';

                    markColumn.appendChild(markInfoLink);
                    markColumn.appendChild(self._createElement('span', { 'class': 'omc-leads-list-mark-separator', 'reference': reference, 'content': '&nbsp;' }));
                    markColumn.appendChild(markIgnoreLink);
                    markColumn.appendChild(self._createElement('span', { 'class': 'omc-leads-list-mark-separator', 'reference': reference, 'content': '&nbsp;' }));
                    markColumn.appendChild(markNotLeadLink);
                    markColumn.appendChild(self._createElement('span', { 'class': 'omc-leads-list-mark-separator', 'reference': reference, 'content': '&nbsp;' }));
                    markColumn.appendChild(markLeadLink);
                    markColumn.appendChild(self._createElement('span', { 'class': 'omc-leads-list-mark-separator', 'reference': reference, 'content': '&nbsp;' }));
                    markColumn.appendChild(markLeadEmail);
                    markColumn.appendChild(self._createElement('span', { 'class': 'omc-leads-list-clear', 'reference': reference, 'content': '' }));

                } else if (self.get_editMode() == 1) { /* "Change visitor state" */
                    leadStatesDropDown = $(self._createLeadStatesElement(v.get_state()));

                    leadStatesDropDown.writeAttribute('id', reference + '_leadstate');
                    leadStatesDropDown.writeAttribute('reference', reference);

                    if (self.get_visitorStatesPresentationType() == 'dropdown') {
                        Event.observe(leadStatesDropDown, 'change', function (e) {
                            var elm = $(Event.element(e));
                            var info = self._rowInfo(elm);

                            if (!elm.disabled && info.reference) {
                                self.onVisitorMarked({ position: info.position, state: elm.options[elm.selectedIndex].value, visitor: self.get_visitors().get_item(info.position) });
                            }
                        });
                    }

                    markColumn.appendChild(leadStatesDropDown);

                    if (self.get_visitorStatesPresentationType() == 'dropdown') {
                        markColumn.appendChild(self._createElement('span', { 'class': 'omc-leads-list-clear', 'reference': reference, 'content': '' }));
                    }
                }

                if (detailsColumn != null) {
                    innerFragment.appendChild(detailsColumn);
                }

                innerFragment.appendChild(markColumn);

                /* Adding one more column that will fix the issue with scrollbars making column values shift on next line */
                innerFragment.appendChild(self._createElement('li', { 'class': 'omc-leads-list-field-rest', 'reference': reference, 'content': self._nonEmpty('') }));

                container.appendChild(innerFragment);
                outerFragment.appendChild(container);

                /* Adding the newly created row */
                if (!bubbleUp) {
                    self._cache.contentContainer.appendChild(outerFragment);
                } else {
                    if (self._cache.contentContainer.firstChild) {
                        self._cache.contentContainer.insertBefore(outerFragment, self._cache.contentContainer.firstChild);
                    } else {
                        self._cache.contentContainer.appendChild(outerFragment);
                    }
                }
            }
        }
    }]);

    this._binder.bindMethod('onSortOrderChanged', [{ elements: [], action: function (sender, args) {
            var cell = null;
            var e = args.parameters[0];
            var field = '', direction = '';
            var cellField = '', cellDirection = '';
            var headerCells = self._cache.headerCells;

            if (e && e.sortBy && e.sortBy.field) {
                field = e.sortBy.field.toLowerCase();
                direction = e.sortBy.direction || 'ascending';

                for (var i = 0; i < headerCells.length; i++) {
                    cell = $(headerCells[i]);
                    cellField = cell.readAttribute('data-sort-field');

                    if (cellField && cellField.length) {
                        cellField = cellField.toLowerCase();

                        if (cellField == field) {
                            cell.addClassName('omc-leads-list-field-sorted');

                            if (direction == 'descending') {
                                cell.addClassName('omc-leads-list-field-sorted-desc');
                            } else {
                                cell.removeClassName('omc-leads-list-field-sorted-desc');
                            }
                        } else {
                            cell.addClassName('omc-leads-list-field-sorted-desc');
                        }
                    }
                }
            }
        }
    }]);

    this._binder.bindMethod('onPageIndexChanged', [{ elements: [], action: function (sender, args) {
            var e = args.parameters[0];
            var className = 'omc-leads-list-paging-disabled';
            var backContainer = $(self._cache.pagingBack.up());
            var forwardContainer = $(self._cache.pagingForward.up());

            if (e.to == 1) {
                backContainer.addClassName(className);
                forwardContainer.removeClassName(className);
            } else if (e.to == self.get_totalPages()) {
                backContainer.removeClassName(className);
                forwardContainer.addClassName(className);
            } else {
                backContainer.removeClassName(className);
                forwardContainer.removeClassName(className);
            }
        }
    }]);

    this._binder.bindMethod('onStateChanged', [{ elements: [], action: function (sender, args) {
            var row = null;
            var info = null;
            var position = -1;
            var isActive = false;
            var e = args.parameters[0];

            if (e && e.state == 'active') {
                isActive = !!e.value;

                if (e.visitor && e.visitor.get_id) {
                    position = self.get_visitors().indexOf(e.visitor);
                }

                if (position >= 0) {
                    info = self._rowInfoByPosition(position);
                    if (info) {
                        row = self._cache.document.getElementById(info.reference);
                        if (row) {
                            row = $(row);

                            if (isActive) {
                                row.removeClassName('omc-leads-list-row-inactive');
                            } else {
                                row.addClassName('omc-leads-list-row-inactive');
                            }
                        }
                    }
                }
            }
        }
    }]);

    this._binder.bindMethod('onLocationAssigned', [{ elements: [], action: function (sender, args) {
            var info = null;
            var e = args.parameters[0];
            var countryContainer = null;

            info = self._rowInfoByPosition(e.position);

            if (info) {
                countryContainer = self._cache.document.getElementById(info.reference + '_country');
                if (countryContainer) {
                    countryContainer.innerHTML = '';
                    countryContainer.appendChild(self._createCountryElement(e.data.countryCode, e.data.company, info.reference));
                }
            }
        }
    }]);

    var getRowElemId = function (id, name) {
        var xid = self._generateID("row" + id + "_" + name);
        return xid;
    };

    this._binder.bindMethod('onBeforeQueryLocation', [{ elements: [], action: function (sender, args) {
            var p = -1;
            var rows = null;
            var reference = null;
            var countryContainer = null;
            var message = self.get_pendingMessage();

            var elementCreator = function () {
                return self._update(new Element('span', { 'class': 'omc-leads-list-location-pending' }), message);
            }

            if (args.parameters.length && args.parameters[0] && args.parameters[0].page) {
                p = args.parameters[0].page;
                for (var i = 0; i < args.parameters[0].requests.length; i++) {
                    countryContainer = $(getRowElemId(args.parameters[0].requests[i].id, "country"));
                    if (countryContainer) {
                        countryContainer.innerHTML = '';
                        countryContainer.appendChild(elementCreator());
                    }
                }
            }
        }
    }]);

    this._binder.bindMethod('onAfterQueryLocation', [{
        elements: [], action: function (sender, args) {
            var p = -1;
            if (args.parameters.length && args.parameters[0] && args.parameters[0].page) {
                p = args.parameters[0].page;
                for (var i = 0; i < args.parameters[0].requests.length; i++) {
                    var selector = "#" + getRowElemId(args.parameters[0].requests[i].id, "country");
                    selector += "> span.omc-leads-list-location-pending";
                    $$(selector).each(function (elm) {
                        Element.remove(elm);
                    });
                }
            }
        }
    }]);


    this._binder.bindMethod('onVisitorAdded', { elements: [], action: function (sender, args) {
            var siblings = [];
            var container = null;
            var chkSelect = null;
            var numberCell = null;
            var visitorsCount = 0;
            var e = args.parameters[0];

            var modifyRow = function (r) {
                var rowCells = [];
                var elementsModified = 0;
                var chkMarkVisitor = null;
                var pageSize = self.get_pageSize();
                var pos = parseInt(r.readAttribute ? r.readAttribute('data-position') : r.getAttribute('data-position'));

                // Determining whether the given row is still in scope (is visible according new position)
                if ((pos + visitorsCount + 1) >= pageSize) {
                    // Row is not visible - removing it
                    $(r).remove();
                } else {
                    // Row is visible - updating meta-data (position)
                    if (r.writeAttribute) {
                        r.writeAttribute('data-position', pos + visitorsCount);
                    } else if (r.setAttribute) {
                        r.setAttribute('data-position', pos + visitorsCount);
                    }

                    rowCells = r.getElementsByTagName('li');
                    if (rowCells != null && rowCells.length > 0) {
                        for (var i = 0; i < rowCells.length; i++) {
                            if (elementsModified >= 2) {
                                break;
                            } else {
                                if (rowCells[i].className && rowCells[i].className.toLowerCase().indexOf('omc-leads-list-field-number') >= 0) {
                                    // Updating "Counter" cell value
                                    rowCells[i].innerHTML = parseInt(rowCells[i].innerHTML) + visitorsCount;
                                    elementsModified += 1;
                                } else if (rowCells[i].className && rowCells[i].className.toLowerCase().indexOf('omc-leads-list-field-checkbox') >= 0) {
                                    // Updating "Select" checkbox value
                                    chkMarkVisitor = rowCells[i].firstChild;
                                    if (chkMarkVisitor && chkMarkVisitor.type && chkMarkVisitor.type.toLowerCase() == 'checkbox') {
                                        chkMarkVisitor.value = parseInt(chkMarkVisitor.value) + visitorsCount;
                                        elementsModified += 1;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (e && (e.position != null || e.range != null)) {
                if (e.range && e.range.length) {
                    visitorsCount = e.range.length;

                    if (visitorsCount > self.get_pageSize()) {
                        visitorsCount = self.get_pageSize();
                    }

                    e.position = 0;
                } else {
                    visitorsCount = 1;
                }

                container = self._cache.contentContainer.select('ul[data-position="' + e.position + '"]');
                if (container && container.length) {
                    container = $(container[0]);
                    siblings = container.nextSiblings();

                    modifyRow(container);

                    if (siblings && siblings.length) {
                        for (var i = 0; i < siblings.length; i++) {
                            modifyRow(siblings[i]);
                        }
                    }
                }

                self.populate({ range: { start: e.position, count: visitorsCount }, mode: 'prepend', reverse: visitorsCount > 0 });
            }
        }
    });

    this._binder.bindMethod('onVisitorRemoved', [{ elements: [], action: function (sender, args) {
            var ranges = [];
            var offsetStart = 0;
            var e = args.parameters[0];

            var processRange = function (position, count) {
                var siblings = [];
                var chkSelect = null;
                var numberCell = null;
                var container = self._cache.contentContainer.select('ul[data-position="' + position + '"]');

                if (container && container.length) {
                    container = $(container[0]);
                    siblings = container.nextSiblings();

                    if (siblings && siblings.length) {
                        for (var i = 0; i < siblings.length; i++) {
                            if (i >= (count - 1)) {
                                if (siblings[i].writeAttribute) {
                                    siblings[i].writeAttribute('data-position', parseInt(siblings[i].readAttribute('data-position')) - count);
                                } else if (siblings[i].setAttribute) {
                                    siblings[i].setAttribute('data-position', parseInt(siblings[i].getAttribute('data-position')) - count);
                                }

                                numberCell = $(siblings[i]).select('li.omc-leads-list-field-number');
                                if (numberCell && numberCell.length) {
                                    numberCell[0].innerHTML = parseInt(numberCell[0].innerHTML) - count;
                                }

                                chkSelect = $(siblings[i]).select('li.omc-leads-list-field-checkbox input');
                                if (chkSelect && chkSelect.length) {
                                    chkSelect[0].value = parseInt(chkSelect[0].value) - count;
                                }
                            }
                        }
                    }

                    container.remove();

                    if (count > 1) {
                        for (var i = 0; i < siblings.length; i++) {
                            if (i < (count - 1)) {
                                $(siblings[i]).remove();
                            }
                        }
                    }
                }
            }

            var sortVisitorsByPosition = function (visitors) {
                var ret = [];

                var swap = function (data, i, j) {
                    var tmp = data[i];
                    data[i] = data[j];
                    data[j] = tmp;
                }

                var partition = function (data, begin, end, pivot) {
                    var ix = 0;
                    var ret = begin;
                    var piv = data[pivot].position;

                    swap(data, pivot, end - 1);

                    for (var i = begin; i < end - 1; i++) {
                        if (data[i].position <= piv) {
                            swap(data, ret, i);
                            ret++;
                        }
                    }

                    swap(data, end - 1, ret);

                    return ret;
                }

                var qsort = function (data, begin, end) {
                    var pivot = 0;

                    if ((end - 1) > begin) {
                        var pivot = begin + Math.floor(Math.random() * (end - begin));

                        pivot = partition(data, begin, end, pivot);

                        qsort(data, begin, pivot);
                        qsort(data, pivot + 1, end);
                    }
                }

                if (visitors && visitors.length) {
                    ret = visitors;
                    qsort(visitors, 0, visitors.length);
                }

                return ret;
            }

            var getRanges = function (visitors) {
                var ret = [];
                var curRange = null;
                var curPosition = -1;

                if (visitors && visitors.length) {
                    visitors = sortVisitorsByPosition(visitors);

                    for (var i = 0; i < visitors.length; i++) {
                        if (curRange == null) {
                            curRange = { start: visitors[i].position, count: 1 };
                            curPosition = curRange.start;
                        } else if ((curPosition + 1) != visitors[i].position) {
                            ret[ret.length] = curRange;
                            curRange = { start: visitors[i].position, count: 1 };
                        } else {
                            curRange.count += 1;
                        }
                    }

                    if (curRange) {
                        ret[ret.length] = curRange;
                    }
                }

                return ret;
            }

            if (e && (e.position != null || e.range != null)) {
                if (e.position != null) {
                    processRange(e.position, 1);
                } else {
                    ranges = getRanges(e.range);
                    for (var i = 0; i < ranges.length; i++) {
                        processRange(ranges[i].start - offsetStart, ranges[i].count);
                        offsetStart += ranges[i].count;
                    }
                }
            }
        }
    }]);

    this._binder.bindMethod('onSelectionChanged', [{ elements: [], action: function (sender, args) {
            var selection = [];
            var checkboxes = [];
            var checkedCount = 0;
            var e = args.parameters[0];

            var markRowSelected = function (checkbox, isSelected) {
                var row = self._cache.document.getElementById(self._rowReference(checkbox));

                checkbox.checked = isSelected;

                if (row) {
                    row = $(row);

                    if (isSelected) {
                        row.addClassName('omc-leads-list-row-selected');
                    } else {
                        row.removeClassName('omc-leads-list-row-selected');
                    }
                }
            }

            self._cache.headerCheckbox.disabled = self.get_isEmpty();

            if (!self._cache.headerCheckbox.disabled) {
                checkboxes = self._cache.contentContainer.select('input[type="checkbox"]');

                if (checkboxes && checkboxes.length) {
                    if (e && e.selection) {
                        selection = e.selection;
                    } else {
                        selection = self.get_selection();
                    }

                    if (selection && selection.keys().length > 0) {
                        for (var i = 0; i < checkboxes.length; i++) {
                            if (selection.get(checkboxes[i].value) != null) {
                                markRowSelected(checkboxes[i], true);
                                checkedCount += 1;
                            } else {
                                markRowSelected(checkboxes[i], false);
                            }
                        }

                        self._cache.headerCheckbox.checked = (checkedCount == checkboxes.length);
                    } else {
                        for (var i = 0; i < checkboxes.length; i++) {
                            markRowSelected(checkboxes[i], false);
                        }

                        self._cache.headerCheckbox.checked = false;
                    }
                }
            } else {
                self._cache.headerCheckbox.checked = false;
            }
        }
    }]);

    Event.observe(this._cache.headerCheckbox, 'click', function (e) {
        var v = null;
        var checkboxes = [];
        var elm = Event.element(e);

        if (!self.get_isEmpty() && !elm.disabled) {
            checkboxes = self._cache.contentContainer.select('input[type="checkbox"]');
            if (checkboxes && checkboxes.length) {
                for (var i = 0; i < checkboxes.length; i++) {
                    v = self.get_visitors().get_item(parseInt(checkboxes[i].value));

                    if (v) {
                        v.set_isSelected(elm.checked, true);
                    }
                }

                self.onSelectionChanged({});
            }
        }
    });

    Event.observe(this._cache.header, 'click', function (e) {
        self.onRowClick({ rowType: 'header', element: Event.element(e) });
    });

    Event.observe(this._cache.footer, 'click', function (e) {
        self.onRowClick({ rowType: 'footer', element: Event.element(e) });
    });

    Event.observe(this._cache.pagingBack, 'click', function (e) {
        var newIndex = 0;
        var parent = $(Event.element(e)).up();

        if (!parent.hasClassName('omc-leads-list-paging-disabled') && !self.get_isPopulating()) {
            newIndex = self.get_currentPageIndex() - 1;

            self.clearSelection();

            self.trace('Page index changed: ' + newIndex);
            self.set_currentPageIndex(newIndex);
        }
    });

    Event.observe(this._cache.pagingForward, 'click', function (e) {
        var newIndex = 0;
        var parent = $(Event.element(e)).up();

        if (!parent.hasClassName('omc-leads-list-paging-disabled') && !self.get_isPopulating()) {
            newIndex = self.get_currentPageIndex() + 1;

            self.clearSelection();

            self.trace('Page index changed: ' + newIndex);
            self.set_currentPageIndex(newIndex);
        }
    });

    if (this.get_container().hasClassName('omc-leads-list-sortable')) {
        for (var i = 0; i < this._cache.headerCells.length; i++) {
            Event.observe(this._cache.headerCells[i], 'click', function (e) {
                var c = $(Event.element(e));
                var field = '', direction = '';
                var tag = (c.tagName || c.nodeName).toLowerCase();

                if (tag != 'li') {
                    c = c.up('li');
                }

                if (c) {
                    c = $(c);
                    field = c.readAttribute('data-sort-field');

                    if (field && field.length) {
                        field = field.toLowerCase();
                        direction = 'ascending';

                        if (c.hasClassName('omc-leads-list-field-sorted') && !c.hasClassName('omc-leads-list-field-sorted-desc')) {
                            direction = 'descending';
                        }

                        self.set_sortBy({ field: field, direction: direction });
                    }
                }

            });
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype._initializeCache = function () {
    /// <summary>Initializes object cache.</summary>

    var c = $(this.get_container());

    this._cache = {};


    this._cache.container = c;
    this._cache.document = document;
    this._cache.documentBody = document.body;
    this._cache.disabledOverlay = $(c.select('.omc-leads-list-disabled-overlay')[0]);
    this._cache.header = $(c.select('.omc-leads-list-header-container .omc-leads-list-header')[0]);
    this._cache.headerCells = c.select('.omc-leads-list-header-container .omc-leads-list-header li');
    this._cache.headerCheckbox = $(c.select('.omc-leads-list-header-container .omc-leads-list-field-checkbox input')[0]);
    this._cache.contentProgress = $(c.select('.omc-leads-list-content-container .omc-leads-list-content-loading')[0]);
    this._cache.contentContainer = $(c.select('.omc-leads-list-content-container .omc-leads-list-content')[0]);
    this._cache.footer = $(c.select('.omc-leads-list-footer-container')[0]);
    this._cache.contentPaging = $(c.select('.omc-leads-list-footer-container .omc-leads-list-paging')[0]);
    this._cache.pagingBack = $(c.select('.omc-leads-list-footer-container .omc-leads-list-paging .omc-leads-list-paging-back a')[0]);
    this._cache.pagingForward = $(c.select('.omc-leads-list-footer-container .omc-leads-list-paging .omc-leads-list-paging-forward a')[0]);
    this._cache.emptyContainer = $(c.select('.omc-leads-list-content-container .omc-leads-list-content-empty')[0]);
}

Dynamicweb.Controls.OMC.LeadsList.prototype._formatEngagement = function (engagement) {
    /// <summary>Formats visitor engagement.</summary>
    /// <param name="engagement">Visitor engagement.</param>
    /// <private />

    var ret = '';
    var fillWidth = 0;
    var totalWidth = 35;

    engagement = parseInt(engagement);

    if (isNaN(engagement) || engagement < 0) {
        engagement = 0;
    } else if (engagement > 100) {
        engagement = 100;
    }

    fillWidth = parseInt(Math.floor((totalWidth * engagement) / 100));

    if (fillWidth < 0) {
        fillWidth = 0;
    } else if (fillWidth > totalWidth) {
        fillWidth = totalWidth;
    }

    if (engagement > 0) {
        ret = '<span class="omc-leads-list-engagement-bar" title="' + engagement + '" style="width: ' + totalWidth +
            'px;"><span class="omc-leads-list-engagement-bar-value" style="width: ' + fillWidth + 'px"></span></span>';
    } else {
        ret = this.get_noneMessage();
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._formatCartReference = function (cartReference) {
    /// <summary>Formats visitor cartReference</summary>
    /// <param name="engagement">Visitor cartReference</param>
    /// <private />

    var ret = '';
    if (cartReference) {       
        ret = (cartReference == "true") ? '<span class="omc-leads-list-cartReference-icon"><img src="/Admin/Module/OMC/img/cart_order_completed.png" alt="Order" height="16" width="16"></span>' : '<span class="omc-leads-list-cartReference-icon"><img src="/Admin/Module/OMC/img/cart_order_not_completed.png" alt="Cart" height="16" width="16"></span>';
    }
    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._formatUserName = function (userName) {
    /// <summary>Formats visitor userName</summary>
    /// <param name="engagement">Visitor userName</param>
    /// <private />

    var ret = '';

    ret = '<span class="omc-leads-list-userName">'+userName+'</span>';

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._formatUserCompany = function (userCompany) {
    /// <summary>Formats visitor Company</summary>
    /// <param name="engagement">Visitor Company</param>
    /// <private />

    var ret = '';

    ret = '<span class="omc-leads-list-userCompany">' + userCompany + '</span>';

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._createTotalVisitsElement = function (position, totalVisits) {
    /// <summary>Creates the total visits element.</summary>
    /// <param name="position">Zero-based position of the visitor.</param>
    /// <param name="totalVisits">Total number of visits.</param>
    /// <private />

    var ret = '';
    var self = this;

    ret = this._createElement('a', {
        'class': 'omc-leads-list-totalvisits-explore',
        'href': 'javascript:void(0);',
        'title': this.get_showVisitsMessage(),
        'content': totalVisits.toString() 
    });

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._formatLastPageviews = function (pageviews, keywords) {
    /// <summary>Formats the last visit pageviews.</summary>
    /// <param name="pageviews">Pageviews.</param>
    /// <param name="keywords">An array of search keywords.</param>
    /// <private />

    var offset = 0;
    var ret = pageviews;
    var columnWidth = 80;
    var keywordsTitle = '';

    ret = '<span class="omc-leads-list-lastpageviews-container">';

    if (pageviews > 999) {
        offset = 26;
    } else if (pageviews > 99) {
        offset = 29;
    } else if (pageviews > 9) {
        offset = 32;
    } else {
        offset = 35;
    }

    /* Number of pagevies (last visit) */
    ret += '<span class="omc-leads-list-lastpageviews-value" style="margin-left: ' + offset + 'px">' + pageviews + '</span>';

    if (keywords != null && keywords.length > 0) {
        keywordsTitle = this.get_searchedForMessage() + ' &quot;';

        for (var i = 0; i < keywords.length; i++) {
            keywordsTitle += keywords[i].replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

            if (i < (keywords.length - 1)) {
                keywordsTitle += ' ';
            }
        }

        keywordsTitle += '&quot;';

        ret += '<span class="omc-leads-list-lastpageviews-haskeywords" title="' + keywordsTitle + '"></span>';
    }

    ret += '</span>';

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._formatLastVisit = function (lastVisit, isTracking) {
    /// <summary>Formats the last visit date.</summary>
    /// <param name="lastVisit">Last visit date.</param>
    /// <param name="isTracking">Value indicating whether visit is being tracked.</param>
    /// <private />

    var ret = '';
    var self = this;
    var daysPassed = 0;
    var container = null;
    var now = new Date();
    var containerTitle = '';
    var trackingElement = '';
    var neverVisited = false;
    var createContainer = false;
    var isTrackingMessage = this.get_isTrackingMessage();
    var dayReference = ['Today', 'Yesterday', 'TwoDaysAgo', 'ThreeDaysAgo', 'FourDaysAgo', 'FiveDaysAgo'];

    var padLeft = function (num) {
        var result = num.toString();

        if (result.length < 2) {
            if (result.length == 0) {
                result = '00';
            } else {
                result = '0' + result;
            }
        }

        return result;
    }

    var dayTime = function (dt) {
        var hours = 0;
        var result = '';
        var isPM = false;

        if (self.get_culture().get_clockFormat() == '24h') {
            result = padLeft(dt.getHours()) + ':' + padLeft(dt.getMinutes());
        } else if (self.get_culture().get_clockFormat() == '12h') {
            hours = dt.getHours();
            if (hours == 0) {
                hours = 12;
            } else if (hours >= 12) {
                if (hours > 12) {
                    hours -= 12;
                }

                isPM = true;
            }

            result = hours + ':' + padLeft(dt.getMinutes()) + ' ' + (isPM ? 'PM' : 'AM');
        }

        return result;
    }

    if (!lastVisit || typeof (lastVisit.getTime) == 'undefined') {
        lastVisit = new Date(1970, 0, 1);
    }

    if (lastVisit.getFullYear() <= 1970) {
        neverVisited = true;
        ret = Dynamicweb.Controls.OMC.LeadsList.Global.get_dateIntervals().get('Never');
        createContainer = true;
    } else {
        ret = this.get_culture().localize(lastVisit) + ', ' + dayTime(lastVisit);

        if (now.getFullYear() == lastVisit.getFullYear() &&
            now.getMonth() == lastVisit.getMonth() &&
            (daysPassed = now.getDate() - lastVisit.getDate()) <= 5) {

            if (daysPassed >= 0) {
                createContainer = true;
                containerTitle = ret;
                ret = Dynamicweb.Controls.OMC.LeadsList.Global.get_dateIntervals().get(dayReference[daysPassed]) + ', ' + dayTime(lastVisit);
            }
        }
    }

    if (!isTracking && !neverVisited) {
        trackingElement = '<span class="omc-leads-list-lastvisit-notracking" title="' + isTrackingMessage[1] + '">&nbsp;</span>';
    }

    if (createContainer) {
        ret = '<span class="omc-leads-list-lastvisit-explained omc-help" title="' +
            containerTitle + '">' + ret + '</span>';
    }

    ret = '<span class="omc-leads-list-lastvisit-container"><span class="omc-leads-list-lastvitit-value">' +
        ret + '</span>' + trackingElement + '</span>';

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._createCountryElement = function (code, name) {
    /// <summary>Formats the given country and returns the DOM element that contains country information.</summary>
    /// <param name="code">Country code.</param>
    /// <param name="name">Company name.</param>
    /// <private />

    var ret = null;
    var img = null;
    var self = this;
    var container = null;
    var nameContainer = null;

    if (code != null || name != null) {
        if (name && name.length) {
            ret = this._update(new Element('span'), this._nonEmpty(code.toString()));

            if (code && code.length) {
                container = new Element('div', { 'class': 'omc-leads-list-country' });

                img = new Element('span', { 'class': 'omc-leads-list-country-code' });
                img.setStyle({ 'backgroundImage': 'url(\'/Admin/Images/Flags/Small/flag_' + code + '.png\')' });

                container.appendChild(img);

                nameContainer = this._update(new Element('a', {
                    'class': 'omc-leads-list-country-name',
                    'title': this.get_viewLocationMessage(),
                    'href': 'javascript:void(0);'
                }), this._nonEmpty(name));

                container.appendChild(nameContainer);

                Event.observe(nameContainer, 'click', function (e) {
                    var elm = $(Event.element(e));
                    var info = self._rowInfo(elm);
                    var v = self.get_visitors().get_item(info.position);
                    var position = { top: Event.pointerY(e), left: Event.pointerX(e) }

                    Dynamicweb.Controls.OMC.LeadsList.InfoBox.get_current().set_visitor(v);
                    Dynamicweb.Controls.OMC.LeadsList.InfoBox.get_current().show({ position: position });
                });

                ret = container;
            }
            else
            {
                container = new Element('div', { 'class': 'omc-leads-list-country' });

                img = new Element('span', { 'class': 'omc-leads-list-country-code' });
                img.setStyle({ 'backgroundImage': 'url(\'/Admin/Images/Icons/Help_small.gif\')' });

                container.appendChild(img);

                nameContainer = this._update(new Element('a', {
                    'class': 'omc-leads-list-country-name',
                    'title': this.get_viewLocationMessage(),
                    'href': 'javascript:void(0);'
                }), this._nonEmpty(name));

                container.appendChild(nameContainer);

                Event.observe(nameContainer, 'click', function (e) {
                    var elm = $(Event.element(e));
                    var info = self._rowInfo(elm);
                    var v = self.get_visitors().get_item(info.position);
                    var position = { top: Event.pointerY(e), left: Event.pointerX(e) }

                    Dynamicweb.Controls.OMC.LeadsList.InfoBox.get_current().set_visitor(v);
                    Dynamicweb.Controls.OMC.LeadsList.InfoBox.get_current().show({ position: position });
                });

                ret = container;
            }
        } else if (code && code.length) 
        {
            container = new Element('div', { 'class': 'omc-leads-list-country' });

            img = new Element('span', { 'class': 'omc-leads-list-country-code' });
            img.setStyle({ 'backgroundImage': 'url(\'/Admin/Images/Flags/Small/flag_' + code + '.png\')' });

            container.appendChild(img);

            ret = container;
        } else {
            ret = this._update(new Element('span'), this._nonEmpty(code.toString()));
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._createLeadStatesElement = function (state) {
    /// <summary>Creates new "Lead states" drop-down list.</summary>
    /// <param name="state">Visitor state.</param>

    var ret = null;
    var container = null;
    var selectedState = '';
    var states = this.get_visitorStates();

    if (!this._cache.leadStatesDropDown) {
        if (this.get_visitorStatesPresentationType() == 'dropdown') {
            ret = this._createElement('select', { 'class': 'std omc-leads-list-leadstates' });

            container = this._createElement('optgroup', { 'label': this.get_leadStatesMessage() });
            ret.appendChild(container);

            if (states && states.length) {
                for (var i = 1; i < states.length; i++) {
                    /* The first state must always be the default one, without the value! */
                    container.appendChild(this._createElement('option', { 'content': states[i], 'value': i == 1 ? '' : states[i] }));
                }
            }

            container = this._createElement('optgroup', { 'label': this.get_otherStatesMessage() });
            ret.appendChild(container);

            /* Appending "Clear lead state" option */
            container.appendChild(this._createElement('option', { 'content': states[0], 'value': this.get_potentialLeadState() }));
        }

        this._cache.leadStatesDropDown = ret;
    }

    if (this.get_visitorStatesPresentationType() == 'dropdown') {
        ret = this._cache.leadStatesDropDown.cloneNode(true);

        if (states && states.length) {
            if (state && state.length) {
                for (var i = 0; i < states.length; i++) {
                    if (states[i].toLowerCase() == state.toLowerCase()) {
                        ret.selectedIndex = i-1;
                        break;
                    }
                }
            } else {
                ret.selectedIndex = 0;
            }
        } else {
            ret.disabled = true;
        }
    } else if (this.get_visitorStatesPresentationType() == 'balloon') {
        if (state && state.length) {
            for (var i = 0; i < states.length; i++) {
                if (states[i].toLowerCase() == state.toLowerCase()) {
                    selectedState = states[i];
                    break;
                }
            }
        }

        if (!selectedState || !selectedState.length) {
            /* Empty value means default state */
            selectedState = states[1];
        }

        ret = this._createElement('a', { 'href': 'javascript:void(0);', 'class': 'omc-lead-list-leadstate-current', 'content': selectedState });
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._nonEmpty = function (v) {
    /// <summary>Ensures that the given value is not empty. Otherwise returns a whitespace HTML entity.</summary>
    /// <param name="v">Value to examine.</param>

    var ret = v;

    if (v == null || v.toString().length == 0) {
        ret = '&nbsp;';
    } 

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._getLocationTimeout = function (page, callback, delay) {
    /// <summary>Either gets or sets location timeout for a given page.</summary>
    /// <param name="page">1-based index of the page.</param>
    /// <param name="callback">Callback to be registered for the given page. Existing timeout will be cleared.</param>
    /// <param name="delay">Callback delay.</param>
    /// <private />

    var ret = null;
    var originalLength = 0;

    if (!this._locationTimeouts) {
        this._locationTimeouts = [];
    }

    page = parseInt(page);

    if (typeof (page) != 'undefined' && page != null && !isNaN(page)) {
        page = (page - 1);

        if (page >= 0 && page < this.get_totalPages()) {
            if (typeof (callback) == 'undefined' || callback == null) {
                if (page < this._locationTimeouts.length && this._locationTimeouts[page]) {
                    ret = this._locationTimeouts[page];
                }
            } else {
                if (typeof (delay) == 'undefined' || delay == null || delay < 0) {
                    delay = 0;
                }

                originalLength = this._locationTimeouts.length;

                if (originalLength < (page + 1)) {
                    for (var i = originalLength; i <= page; i++) {
                        this._locationTimeouts[i] = null;
                    }
                }

                this._clearLocationTimeout(page);
                this._locationTimeouts[page] = setTimeout(callback, delay);
            }
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._clearLocationTimeout = function (page) {
    /// <summary>Clears location timeout for a given page. If the page index is ommitted clears timeouts for all pages.</summary>
    /// <param name="page">1-based index of the page.</param>
    /// <private />

    if (!this._locationTimeouts) {
        this._locationTimeouts = [];
    }

    page = parseInt(page);

    if (this._locationTimeouts.length) {
        if (typeof (page) != 'undefined' && page != null && !isNaN(page)) {
            page = (page - 1);

            if (page >= 0 && page < this._locationTimeouts.length) {
                if (this._locationTimeouts[page]) {
                    clearTimeout(this._locationTimeouts[page]);
                    this._locationTimeouts[page] = null;
                }
            }
        } else {
            for (var i = 0; i < this._locationTimeouts.length; i++) {
                if (this._locationTimeouts[i]) {
                    clearTimeout(this._locationTimeouts[i]);
                    this._locationTimeouts[i] = null;
                }
            }
        }
    }
}

Dynamicweb.Controls.OMC.LeadsList.prototype._locationServiceInitialize = function (onComplete) {
    /// <summary>Initializes the geo-location service.</summary>
    /// <param name="onComplete">Callback to be executed upon service initialization complete.</param>
    /// <private />

    onComplete = onComplete || function () { }

    if (!Dynamicweb.Controls.OMC.LeadsList.Global.get_locationServiceInitialized()) {
        Dynamicweb.Controls.OMC.LeadsList.Global.set_locationServiceInitialized(true);

        parent.OMC.MasterPage.get_current().executeTask('GetLocationInitialize', {}, function (response) {
            onComplete(response);
        }, true);
    } else {
        onComplete();
    }

    onComplete();
}

Dynamicweb.Controls.OMC.LeadsList.prototype._update = function (elm, content) {
    /// <summary>Updates element content.</summary>
    /// <param name="elm">DOM element whose content to update.</param>
    /// <param name="content">New element content.</param>
    /// <private />

    if (elm) {
        elm.innerHTML = content;
    }

    return elm;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._rowInfo = function (elm) {
    /// <summary>Returns row information.</summary>
    /// <param name="elm">DOM element representing either a row itself or any child element.</param>
    /// <private />

    var row = null;
    var rowReference = '';
    var searchClass = 'omc-leads-list-row';
    var ret = { reference: '', id: 0, position: 0, page: 1 };

    if (elm) {
        if (elm.className && (elm.className == searchClass ||
            elm.className.indexOf(searchClass + ' ') == 0 ||
            elm.className.indexOf(' ' + searchClass) == (elm.className.length - searchClass.length - 2) ||
            elm.className.indexOf(' ' + searchClass + ' ') > 0)) {

            row = elm;
        } else {
            rowReference = this._rowReference(elm);
            if (rowReference) {
                row = this._cache.document.getElementById(rowReference);
            } else {
                row = $(elm).up('.omc-leads-list-row');
            }
        }

        if (row) {
            row = $(row);

            ret.reference = row.id;
            ret.id = parseInt(row.readAttribute('data-id'));
            ret.position = parseInt(row.readAttribute('data-position'));
            ret.page = parseInt(row.readAttribute('data-page'));
        }
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._rowInfoByPosition = function (position) {
    /// <summary>Returns row information by its position.</summary>
    /// <param name="position">Zero-based row position.</param>
    /// <private />

    var ret = null;
    var row = this._cache.container.select('ul[data-position="' + position + '"]');

    if (row && row.length) {
        ret = this._rowInfo(row[0]);
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._rowReference = function (elm) {
    /// <summary>Returns a reference to a containing row.</summary>
    /// <param name="elm">Element to examine for having a row reference.</param>
    /// <private />

    var ret = '';

    if (elm) {
        if (!elm.hasClassName) {
            elm = $(elm);
        }

        ret = elm.readAttribute('data-row');
    }

    return ret;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._generateID = function (suffix) {
    /// <summary>Generates the unique identifier for the element.</summary>
    /// <param name="suffix">ID suffix.</param>
    /// <private />

    return this.get_namespace() + suffix;
}

Dynamicweb.Controls.OMC.LeadsList.prototype._createElement = function (tagName, attributes) {
    /// <summary>Creates new DOM element.</summary>
    /// <param name="tagName">Tag name of the new DOM element.</param>
    /// <param name="attributes">An object representing a list of attributes to be applied to newly created element.</param>
    /// <private />

    var ret = null;
    var cached = null;
    var attrLower = '';
    var name = '', value = '';

    var attrSetter = function (n, v) {
        if (ret.setAttribute) {
            ret.setAttribute(n, v);
        } else if (ret.writeAttribute) {
            ret.writeAttribute(n, v);
        }
    }

    var addEvent = function (n, c) {
        if (ret.addEventListener) {
            ret.addEventListener(n, c, false);
        } else if (ret.attachEvent) {
            ret.attachEvent('on' + n, c);
        }
    }

    var clearEvents = function () {
        var eventNames = ['onclick', 'onmouseover', 'onmousedown', 'onmousemove',
            'onkeydown', 'onkeyup', 'onkeypress', 'ondragstart', 'ondragend'];

        for (var i = 0; i < eventNames.length; i++) {
            ret[eventNames[i]] = null;
        }
    }

    ret = this._cache.document.createElement(tagName);

    /*cached = Dynamicweb.Controls.OMC.LeadsList.Global._elementsCache[tagName];

    if (cached) {
        ret = cached.cloneNode(false);
    } else {
        ret = document.createElement(tagName);
        Dynamicweb.Controls.OMC.LeadsList.Global._elementsCache[tagName] = ret;
    }*/

    if (attributes && typeof (attributes) == 'object') {
        for (var attr in attributes) {
            name = attr;
            value = attributes[attr];
            attrLower = name.toLowerCase();

            if (value != null) {
                if (typeof (value) != 'function') {
                    if (attrLower == 'id') {
                        ret.id = value;
                    } else if (attrLower == 'class' || attrLower == 'classname') {
                        ret.className = value;
                    } else if (attrLower == 'content' || attrLower == 'html' || attrLower == 'innerhtml') {
                        ret.innerHTML = value;
                    } else if (attrLower == 'type' && typeof (ret.type) != 'undefined') {
                        ret.type = value;
                    } else if (attrLower == 'value' && typeof (ret.value) != 'undefined') {
                        ret.value = value;
                    } else if (attrLower == 'reference') {
                        attrSetter('data-row', value);
                    } else {
                        attrSetter(name, value);
                    }
                } else {
                    addEvent(name, value);
                }
            }
        }
    }

    return ret;
}
