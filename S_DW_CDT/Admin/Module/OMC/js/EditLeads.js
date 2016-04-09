/* ++++++ Registering namespace ++++++ */

if (typeof (OMC) == 'undefined') {
    var OMC = new Object();
}

/* ++++++ End: Registering namespace ++++++ */

OMC.LeadTool = function () {
    /// <summary>Represents a lead tool page controller.</summary>

    this._binder = null;
    this._bound = false;
    this._initialized = false;
    this._autoSynchronize = false;
    this._isSynchronizing = false;
    this._isReloading = false;
    this._synchronizeTimeoutID = null;
    this._sendEmailDialog = null;
    this._terminology = {};
    this._triggerUnsavedConfirmation = true;
    this._confirmationReceived = false;
    this._keepTemporarilyApproved = false;

    this._filters = null;
    this._filterApplyTimeoutID = null;
    this._syncData = null;
    this._onAfterSynchronize = null;
    this._addProvidersTimeoutID = null;
    this._addProvidersQueue = [];
    this._anchorClicked = false;
    this._anchorClickedResetTimer = null;

    this._discardedLeads = { frame: '', control: '' };
    this._potentialLeads = { frame: '', control: '' };
    this._approvedLeads = { frame: '', control: '' };

    this._dialogState = { attach: { eventsCreated: false }, manager: {} };
    this._knownProviders = {};
    this._currentLeadState = '';

    this._events = {
        selectionChanged: []
    }
}

OMC.LeadTool.prototype.add_selectionChanged = function (callback) {
    /// <summary>Registers a new callback that is executed whnever the list of selected visitors changes.</summary>
    /// <param name="callback">Callback to register.</param>

    callback = callback || function () { }

    this._events.selectionChanged[this._events.selectionChanged.length] = callback;
}

OMC.LeadTool.prototype.get_terminology = function () {
    /// <summary>Gets the terminology object.</summary>

    return this._terminology;
}

OMC.LeadTool.prototype.get_keepTemporarilyApproved = function () {
    /// <summary>Gets value indicating whether to not apply filtering to temporarily approved leads ("Potential leads" section).</summary>

    return this._keepTemporarilyApproved;
}

OMC.LeadTool.prototype.set_keepTemporarilyApproved = function (value) {
    /// <summary>Sets value indicating whether to not apply filtering to temporarily approved leads ("Potential leads" section).</summary>
    /// <param name="value">Value indicating whether to not apply filtering to temporarily approved leads ("Potential leads" section).</param>

    this._keepTemporarilyApproved = !!value;
}

OMC.LeadTool.prototype.get_sendEmailDialog = function () {
    /// <summary>Gets the instance to the "Send Email" dialog.</summary>

    var ret = null;

    if (typeof (this._sendEmailDialog) != 'undefined') {
        if (typeof (this._sendEmailDialog) == 'string') {
            try {
                ret = eval(this._sendEmailDialog);
            } catch (ex) { }

            if (ret) {
                this._sendEmailDialog = ret;
            }
        } else {
            ret = this._sendEmailDialog;
        }
    }

    return ret;
}

OMC.LeadTool.prototype.set_sendEmailDialog = function (value) {
    /// <summary>Sets the instance to the "Send Email" dialog.</summary>
    /// <param name="value">Dialog instance.</param>

    this._sendEmailDialog = value;
}

OMC.LeadTool.prototype.get_hasSyncData = function () {
    /// <summary>Gets value indicating whether synchronization data is available.</summary>

    return this.get_syncData().keys().length > 0;
}

OMC.LeadTool.prototype.get_syncData = function () {
    /// <summary>Gets the synchronization data.</summary>

    if (!this._syncData) {
        this._syncData = new Hash();
    }

    return this._syncData;
}

OMC.LeadTool.prototype.get_autoSynchronize = function () {
    /// <summary>Gets value indicating whether auto-synchronization is allowed.</summary>

    return this._autoSynchronize;
}

OMC.LeadTool.prototype.set_autoSynchronize = function (value) {
    /// <summary>Sets value indicating whether auto-synchronization is allowed.</summary>
    /// <param name="value">Value indicating whether auto-synchronization is allowed.</param>

    this._autoSynchronize = !!value;
}

OMC.LeadTool.prototype.get_currentLeadState = function () {
    /// <summary>Gets the current lead state.</summary>

    return this._currentLeadState;
}

OMC.LeadTool.prototype.set_currentLeadState = function (value) {
    /// <summary>Sets the current lead state.</summary>
    /// <param name="value">The current lead state.</param>

    this._currentLeadState = value;
}

OMC.LeadTool.prototype.get_isSynchronizing = function () {
    /// <summary>Gets value indicating whether object performs synchronization.</summary>

    return this._isSynchronizing;
}

OMC.LeadTool.prototype.set_isSynchronizing = function (value) {
    /// <summary>Sets value indicating whether object performs synchronization.</summary>
    /// <param name="value">Value indicating whether object performs synchronization.</param>

    this._isSynchronizing = value;
}

OMC.LeadTool.prototype.get_isReloading = function () {
    /// <summary>Gets value indicating whether object performs synchronization.</summary>

    return this._isReloading;
}

OMC.LeadTool.prototype.set_isReloading = function (value) {
    /// <summary>Sets value indicating whether leads lists are being reloaded.</summary>
    /// <param name="value">Value indicating whether leads lists are being reloaded.</param>

    this._isReloading = value;
}

OMC.LeadTool.prototype.get_knownProviders = function () {
    /// <summary>Gets the list of ISPs configured in the Management Center under the "Leads -> Ignore providers" section.</summary>

    var ret = [];

    for (var prop in this._knownProviders) {
        if (typeof (this._knownProviders[prop]) == 'string') {
            ret[ret.length] = this._knownProviders[prop];
        }
    }

    return ret;
}

OMC.LeadTool.prototype.set_knownProviders = function (value) {
    /// <summary>Sets the list of ISPs configured in the Management Center under the "Leads -> Ignore providers" section.</summary>
    /// <param name="value">The list of ISPs configured in the Management Center under the "Leads -> Ignore providers" section.</param>

    this._knownProviders = {};

    if (value && value.length) {
        for (var i = 0; i < value.length; i++) {
            this._knownProviders[value[i].toLowerCase()] = value[i];
        }
    }
}

OMC.LeadTool.prototype.get_selection = function () {
    /// <summary>Gets the list of currently selected visitors.</summary>

    var ret = [];
    var values = [];
    var controls = [this.get_discardedLeads().control, this.get_potentialLeads().control, this.get_approvedLeads().control];

    for (var i = 0; i < controls.length; i++) {
        if (controls[i]) {
            values = controls[i].get_selection().values();

            if (values && values.length) {
                for (var j = 0; j < values.length; j++) {
                    ret[ret.length] = values[j];
                }
            }
        }
    }

    return ret;
}

OMC.LeadTool.prototype.get_filters = function () {
    /// <summary>Gets the object representing currently submitted filters' values.</summary>
    var range = [];
    var field = null;
    var context = parent ? parent.document.body : document.body;
    var ret = { AreaID: '', PageID: '', PeriodFrom: '', PeriodTo: '', Country: '', PageViewsFrom: '', PageViewsTo: '', ExtranetUsers: '0', SourceType: '', ExcludeKnownProviders: false, Profile: '' };

    if (context) {
        context = $(context);
        if (context) {
            field = context.select('select.leads-filter-area');
            if (field && field.length > 0) {
                ret.AreaID = field[0].options[field[0].selectedIndex].value;
            }

            field = context.select('input.leads-filter-page');
            if (field && field.length > 0) {
                // control id which stores value
                field = context.select('#' + field[0].identify().replace('Link_', ''));

                if (field && field[0]) {
                    ret.PageID = field[0].value.replace('Default.aspx?ID=', '');
                }
            }

            field = context.select('input.leads-filter-date-from');
            if (field && field.length > 0) {
                ret.PeriodFrom = field[0].value;
            }

            field = context.select('input.leads-filter-date-to');
            if (field && field.length > 0) {
                ret.PeriodTo = field[0].value;
            }

            field = context.select('select.leads-filter-country');
            if (field && field.length > 0) {
                ret.Country = field[0].options[field[0].selectedIndex].value;
            }

            field = context.select('select.leads-filter-pageviews');
            if (field && field.length > 0) {
                if (field[0].options[field[0].selectedIndex].value.indexOf('-') > 0) {
                    range = field[0].options[field[0].selectedIndex].value.split('-');
                    if (range.length > 0) {
                        ret.PageViewsFrom = range[0];

                        if (range.length > 1) {
                            if (range[1] == '*' || !range[1].length) {
                                ret.PageViewsTo = '';
                            } else {
                                ret.PageViewsTo = range[1];
                            }
                        }
                    }
                } else {
                    ret.PageViewsFrom = field[0].options[field[0].selectedIndex].value;
                    ret.PageViewsTo = '';
                }
            }

            field = context.select('select.leads-filter-extranet');
            if (field && field.length > 0) {
                ret.ExtranetUsers = field[0].options[field[0].selectedIndex].value;
            }

            field = context.select('select.leads-filter-source');
            if (field && field.length > 0) {
                ret.SourceType = field[0].options[field[0].selectedIndex].value;
            }

            field = context.select('input.leads-filter-excludeisps');
            if (field && field.length > 0 && !field[0].disabled) {
                ret.ExcludeKnownProviders = !!field[0].checked;
            }

            field = context.select('select.leads-filter-profile');
            if (field && field.length > 0) {
                ret.Profile = field[0].options[field[0].selectedIndex].value;
            }
        }
    }

    return ret;
}

OMC.LeadTool.prototype.set_filters = function(values) {
    var field = null;
    var context = parent ? parent.document.body : document.body;

    if (context && values) {
        if (typeof(values.AreaID) !== 'undefined') {
            field = context.select('select.leads-filter-area');
            if (field && field.length > 0) {
                field[0].value = values.AreaID;
            }
        }

        if (typeof (values.PageID) !== 'undefined' && typeof (values.PageName) !== 'undefined') {
            field = context.select('input.leads-filter-page');
            if (field && field.length > 0) {

                if (values.PageName === '') {
                    values.PageName = 'All';
                }

                field[0].value = values.PageName;

                // control id which stores value
                field = context.select('#' + field[0].identify().replace('Link_', ''));

                if (field && field[0]) {
                    field[0].value = values.PageID;
                }
            }
        }
    }
}

OMC.LeadTool.prototype.get_discardedLeads = function () {
    /// <summary>Gets the reference to the object representing a list of discarded leads.</summary>

    var o = null;

    if (typeof (this._discardedLeads.frame) == 'string') {
        o = this._tryEval(this._discardedLeads.frame);
        if (o) {
            this._discardedLeads.frame = o;
        }
    }

    if (typeof (this._discardedLeads.control) == 'string') {
        o = this._tryEval(this._discardedLeads.control);
        if (o) {
            this._discardedLeads.control = o;
        }
    }

    return this._discardedLeads;
}

OMC.LeadTool.prototype.set_discardedLeads = function (value) {
    /// <summary>Sets the reference to the object representing a list of discarded leads.</summary>
    /// <param name="value">The reference to the object representing a list of discarded leads.</param>

    if (value) {
        if (typeof (value) == 'string') {
            this._discardedLeads.control = value;
        } else if (typeof (value.frame) != 'undefined' && typeof (value.control) != 'undefined') {
            this._discardedLeads = value;
        }
    }
}

OMC.LeadTool.prototype.get_potentialLeads = function () {
    /// <summary>Gets the reference to the object representing a list of potential leads.</summary>

    var o = null;

    if (typeof (this._potentialLeads.frame) == 'string') {
        o = this._tryEval(this._potentialLeads.frame);
        if (o) {
            this._potentialLeads.frame = o;
        }
    }

    if (typeof (this._potentialLeads.control) == 'string') {
        o = this._tryEval(this._potentialLeads.control);
        if (o) {
            this._potentialLeads.control = o;
        }
    }

    return this._potentialLeads;
}

OMC.LeadTool.prototype.set_potentialLeads = function (value) {
    /// <summary>Sets the reference to the object representing a list of potential leads.</summary>
    /// <param name="value">The reference to the object representing a list of potential leads.</param>

    if (value) {
        if (typeof (value) == 'string') {
            this._potentialLeads.control = value;
        } else if (typeof (value.frame) != 'undefined' && typeof (value.control) != 'undefined') {
            this._potentialLeads = value;
        }
    }
}

OMC.LeadTool.prototype.get_approvedLeads = function () {
    /// <summary>Gets the reference to the object representing a list of approved leads.</summary>

    var o = null;

    if (typeof (this._approvedLeads.frame) == 'string') {
        o = this._tryEval(this._approvedLeads.frame);
        if (o) {
            this._approvedLeads.frame = o;
        }
    }

    if (typeof (this._approvedLeads.control) == 'string') {
        o = this._tryEval(this._approvedLeads.control);
        if (o) {
            this._approvedLeads.control = o;
        }
    }

    return this._approvedLeads;
}

OMC.LeadTool.prototype.set_approvedLeads = function (value) {
    /// <summary>Sets the reference to the object representing a list of approved leads.</summary>
    /// <param name="value">The reference to the object representing a list of approved leads.</param>

    if (value) {
        if (typeof (value) == 'string') {
            this._approvedLeads.control = value;
        } else if (typeof (value.frame) != 'undefined' && typeof (value.control) != 'undefined') {
            this._approvedLeads = value;
        }
    }
}

OMC.LeadTool.prototype.get_isManagingLeadStates = function () {
    /// <summary>Gets value indicating whether this is a page for managing lead states rather than a page for marking leads.</summary>

    return !this.get_discardedLeads().control &&
        !this.get_potentialLeads().control &&
        this.get_approvedLeads().control;
}

OMC.LeadTool.prototype.notify = function (eventName, args) {
    /// <summary>Notifies the clients about the specified event.</summary>
    /// <param name="eventName">Event name.</param>
    /// <param name="args">Event arguments.</param>

    var callbacks = [];

    if (eventName && eventName.length) {
        if (!args) {
            args = {};
        }

        callbacks = this._events[eventName];
        if (callbacks && callbacks.length) {
            for (var i = 0; i < callbacks.length; i++) {
                try {
                    callbacks[i](this, args);
                } catch (ex) { }
            }
        }
    }
}

OMC.LeadTool.prototype.isKnownProvider = function (provider) {
    /// <summary>Gets value indicating whether the given provider is a known provider.</summary>
    /// <param name="provider">Provider to check.</param>
    /// <returns>Value indicating whether the given provider is a known provider.</returns>

    var ret = false;

    if (provider && provider.length) {
        ret = typeof (this._knownProviders[provider.toLowerCase()]) != 'undefined';
    }

    return ret;
}

OMC.LeadTool.prototype.addKnownProvider = function (provider) {
    /// <summary>Registers new known provider.</summary>
    /// <param name="provider">New provider to register.</param>
    /// <returns>Value indicating whether provider has been successfully registered.</returns>

    var ret = false;



    return ret;
}

OMC.LeadTool.prototype.queueUpdateVisitor = function (id, state, previousState, visitorID) {
    /// <summary>Puts the given visitor to synchronization queue.</summary>
    /// <param name="id">Visitor identifier.</param>
    /// <param name="state">"Lead" state. Possible values are "approved", "discarded" or "unknown".</param>
    /// <param name="previousState">Original "Lead" state. Possible values are "approved", "discarded" or "unknown".</param>

    var self = this;
    var item = null;
    var canQueue = true;

    var registerSynchronize = function () {
        self._synchronizeTimeoutID = setTimeout(function () {
            self.synchronize();
        }, 1000);
    }

    if (id) {
        if (typeof (state) == 'undefined') {
            state = '';
        }

        state = state.toLowerCase();

        if (typeof (previousState) != 'undefined') {
            previousState = previousState.toLowerCase();
        } else {
            if (!this.get_isManagingLeadStates()) {
                previousState = 'unknown';
            } else {
                previousState = '';
            }
        }

        if (this.get_isManagingLeadStates()) {
            canQueue = state != this.get_currentLeadState().toLowerCase();
        }

        if (canQueue) {
            item = this.get_syncData().get(id);
            if (item == null) {
                item = { state: state, originalState: previousState, visitorID: visitorID };
            } else {
                item.state = state;
            }

            this.get_syncData().set(id, item);

            if (this.get_autoSynchronize()) {
                if (this._synchronizeTimeoutID) {
                    clearTimeout(this._synchronizeTimeoutID);
                    this._synchronizeTimeoutID = null;
                }

                if (this.get_isSynchronizing()) {
                    this._onAfterSynchronize = function (sender, args) {
                        registerSynchronize();
                    }
                } else {
                    this._onAfterSynchronize = null;
                    registerSynchronize();
                }
            }
        } else {
            this.get_syncData().unset(id);
        }
    }
}

OMC.LeadTool.prototype.reload = function (onComplete) {
    /// <summary>Reloads all lists.</summary>
    /// <param name="onComplete">Callback to be executed after all lists has finished reloading.</param>

    var self = this;
    var reloadTimeoutID = null;
    var geolocation = { queue: true, query: false };

    var listsLoadedCallback = function () {
        if (reloadTimeoutID) {
            clearTimeout(reloadTimeoutID);
            reloadTimeoutID = null;
        } else {
            self.set_isReloading(false);
        }

        setTimeout(function () {
            self.get_potentialLeads().control.queryLocation({ onComplete: function () {
                    self.get_discardedLeads().control.queryLocation({ onComplete: function () {
                            self.get_approvedLeads().control.queryLocation();
                        }
                    });
                }
            });
        }, 5);

        onComplete();
    }

    reloadTimeoutID = setTimeout(function () {
        self.set_isReloading(true);
        reloadTimeoutID = null;
    }, 750);

    onComplete = onComplete || function () { }

    if (!this.get_isManagingLeadStates()) {
        this.get_discardedLeads().control.reset(true);
        this.get_potentialLeads().control.reset(true);
    }

    if (!this.get_keepTemporarilyApproved()) {
        this.get_approvedLeads().control.reset(true);
    }

    if (!this.get_isManagingLeadStates()) {
        this.get_potentialLeads().control.reload({ geolocation: geolocation, onComplete: function () {
                self.get_discardedLeads().control.reload({ geolocation: geolocation, onComplete: function () {
                        if (!self.get_keepTemporarilyApproved()) {
                            self.get_approvedLeads().control.reload({ geolocation: geolocation, onComplete: function () {
                                    listsLoadedCallback();
                                }
                            });
                        } else {
                            listsLoadedCallback();
                        }
                    }
                });
            }
        });
    } else {
        this.get_approvedLeads().control.reload({ geolocation: geolocation, onComplete: function () {
                if (reloadTimeoutID) {
                    clearTimeout(reloadTimeoutID);
                    reloadTimeoutID = null;
                } else {
                    self.set_isReloading(false);
                }

                setTimeout(function () {
                    self.get_approvedLeads().control.queryLocation();
                }, 5);

                onComplete();
            }
        });
    }
}

OMC.LeadTool.prototype.applyFilters = function () {
    /// <summary>Applies all filters.</summary>

    var self = this;

    if (this._filterApplyTimeoutID) {
        clearTimeout(this._filterApplyTimeoutID);
        this._filterApplyTimeoutID = null;
    }

    parent.OMC.MasterPage.get_current().hideDialog();

    this._filterApplyTimeoutID = setTimeout(function () {
        self.reload();
    }, 100);
}

OMC.LeadTool.prototype.markSelected = function () {
    /// <summary>Marks the currently selected visitors as approved leads.</summary>

    this.markMultipleVisitors(this.get_selection(), 'approved');
}

OMC.LeadTool.prototype.unmarkSelected = function () {
    /// <summary>Marks the currently selected visitors as discarded leads.</summary>

    this.markMultipleVisitors(this.get_selection(), 'discarded');
}

OMC.LeadTool.prototype.ignoreSelected = function () {
    /// <summary>Ignores selected Internet Service Providers (ISP).</summary>

    this.markMultipleVisitors(this.get_selection(), 'ignored');
}

OMC.LeadTool.prototype.sendLeadsAsEmail = function () {
    /// <summary>Bulk send emails.</summary>
    var selection = this.get_selection();
    var visitorsIDs = '';
    var isLeads = '';
    var rowIds = '';
    for (var i = 0; i < selection.length; i++) {
        visitorsIDs += ((selection[i].get_isTracking() ? selection[i].get_visitorID() : selection[i].get_id()) + ',');
        isLeads += (selection[i].get_isLead() + ',');
        rowIds += (selection[i].get_id() + ',');
    }
    if (this.get_approvedLeads() && this.get_approvedLeads().control) this.get_approvedLeads().control.clearSelection();
    if (this.get_potentialLeads() && this.get_potentialLeads().control) this.get_potentialLeads().control.clearSelection();
    if (this.get_discardedLeads() && this.get_discardedLeads().control) this.get_discardedLeads().control.clearSelection();

    this.openSendLeadAsEmail(null, visitorsIDs.substr(0, visitorsIDs.length - 1), isLeads.substr(0, isLeads.length - 1), false, rowIds.substr(0, rowIds.length - 1));

}


OMC.LeadTool.prototype.changeLeadState = function (state) {
    /// <summary>Changes the lead state of all selected visitors.</summary>
    /// <param name="state">New lead state.</param>

    this.markMultipleVisitors(this.get_selection(), state);
}

OMC.LeadTool.prototype.markMultipleVisitors = function (visitors, state) {
    /// <summary>Marks the given list of visitor.</summary>
    /// <param name="visitors">Visitors to mark.</param>
    /// <param name="state">Visitors state.</param>

    var queue = [];
    var target = [];
    var isLead = null;
    var prevState = '';
    var states = ['unknown', 'approved', 'discarded'];

    var visitorsByLists = {
        unknown: {
            control: this.get_potentialLeads().control,
            visitors: []
        },

        approved: {
            control: this.get_approvedLeads().control,
            visitors: []
        },

        discarded: {
            control: this.get_discardedLeads().control,
            visitors: []
        }
    }

    var getState = function (leadState) {
        var result = 'unknown';

        if (leadState != null) {
            result = leadState ? 'approved' : 'discarded';
        }

        return result;
    }

    if (!this.get_isManagingLeadStates()) {
        if (visitors && visitors.length) {
            if (state == 'ignored') {
                for (var i = 0; i < visitors.length; i++) {
                    if (visitors[i] && typeof (visitors[i].get_isLead) != 'undefined') {
                        this.addKnownProvider(visitors[i].get_company());

                        if (this.get_approvedLeads() && this.get_approvedLeads().control) this.get_approvedLeads().control.addKnownProvider(visitors[i].get_company());
                        if (this.get_potentialLeads() && this.get_potentialLeads().control) this.get_potentialLeads().control.addKnownProvider(visitors[i].get_company());
                        if (this.get_discardedLeads() && this.get_discardedLeads().control) this.get_discardedLeads().control.addKnownProvider(visitors[i].get_company());
                    }
                }
            } else {
                for (var i = 0; i < visitors.length; i++) {
                    if (visitors[i] && typeof (visitors[i].get_isLead) != 'undefined') {
                        if (visitors[i].get_isTracking()) {
                            isLead = visitors[i].get_isLead();

                            if (isLead == null) {
                                visitorsByLists.unknown.visitors[visitorsByLists.unknown.visitors.length] = visitors[i];
                            } else if (isLead) {
                                visitorsByLists.approved.visitors[visitorsByLists.approved.visitors.length] = visitors[i];
                            } else {
                                visitorsByLists.discarded.visitors[visitorsByLists.discarded.visitors.length] = visitors[i];
                            }
                        }
                    }
                }

                if (state == 'unknown') {
                    target = this._mergeArrays(visitorsByLists.approved.visitors, visitorsByLists.discarded.visitors);
                    for (var i = 0; i < target.length; i++) {
                        queue[queue.length] = { id: target[i].get_id(), state: 'unknown', previousState: getState(target[i].get_isLead()), visitorID: target[i].get_visitorID() };
                        target[i].set_isLead(null);
                    }
                } else if (state == 'approved') {
                    target = this._mergeArrays(visitorsByLists.discarded.visitors, visitorsByLists.unknown.visitors);
                    for (var i = 0; i < target.length; i++) {
                        queue[queue.length] = { id: target[i].get_id(), state: 'approved', previousState: getState(target[i].get_isLead()), visitorID: target[i].get_visitorID() };
                        target[i].set_isLead(true);
                    }
                } else if (state == 'discarded') {
                    target = this._mergeArrays(visitorsByLists.approved.visitors, visitorsByLists.unknown.visitors);
                    for (var i = 0; i < target.length; i++) {
                        queue[queue.length] = { id: target[i].get_id(), state: 'discarded', previousState: getState(target[i].get_isLead()), visitorID: target[i].get_visitorID() };
                        target[i].set_isLead(false);
                    }
                }

                for (var i = 0; i < states.length; i++) {
                    if (states[i] != state) {
                        visitorsByLists[states[i]].control.removeMultipleVisitors(visitorsByLists[states[i]].visitors);
                    }
                }

                visitorsByLists[state].control.addMultipleVisitors(target);

                if (this.get_keepTemporarilyApproved() && state == 'discarded') {
                    for (var i = 0; i < target.length; i++) {
                        if (!target[i].get_isActive()) {
                            target[i].set_isActive(true);
                        }
                    }

                    visitorsByLists.approved.control.removeMultipleVisitors(target);
                }

                for (var i = 0; i < queue.length; i++) {
                    this.queueUpdateVisitor(queue[i].id, queue[i].state, queue[i].previousState, queue[i].visitorID);
                }
            }

            if (this.get_approvedLeads() && this.get_approvedLeads().control) this.get_approvedLeads().control.clearSelection();
            if (this.get_potentialLeads() && this.get_potentialLeads().control) this.get_potentialLeads().control.clearSelection();
            if (this.get_discardedLeads() && this.get_discardedLeads().control) this.get_discardedLeads().control.clearSelection();
        }
    } else {
        if (visitors && visitors.length) {
            for (var i = 0; i < visitors.length; i++) {
                if (visitors[i] && typeof (visitors[i].set_state) == 'function') {
                    prevState = visitors[i].get_state();
                    visitors[i].set_state(state);

                    this.queueUpdateVisitor(visitors[i].get_id(), state, prevState, visitors[i].get_visitorID());
                    if (this.get_approvedLeads() && this.get_approvedLeads().control) {
                        this.get_approvedLeads().control.tryUpdateLeadState(visitors[i]);
                    }
                }
            }
        }

        if (this.get_approvedLeads() && this.get_approvedLeads().control) this.get_approvedLeads().control.clearSelection();
    }
}

OMC.LeadTool.prototype.markVisitor = function (v, state, position) {
    /// <summary>Marks the given visitor.</summary>
    /// <param name="v">Visitor to mark.</param>
    /// <param name="state">Visitor state.</param>
    /// <param name="position">Visitor position in the list.</param>

    var addTo = null;
    var isLead = null;
    var prevState = '';
    var removeFrom = null;
    var unapprove = false;

    if (!this.get_isManagingLeadStates()) {
        if (v && typeof (v.get_isLead) != 'undefined') {
            if (state == 'ignored') {
                this.addKnownProvider(v.get_company());
            } else {
                isLead = v.get_isLead();

                if (v.get_isTracking()) {
                    if (isLead == null) {
                        prevState = 'unknown';
                    } else if (!isLead) {
                        prevState = 'discarded';
                    } else {
                        prevState = 'approved';
                    }

                    if (isLead == null && state != 'unknown') {
                        removeFrom = this.get_potentialLeads().control;

                        if (state == 'approved') {
                            v.set_isLead(true);
                            addTo = this.get_approvedLeads().control;
                        } else if (state == 'discarded') {
                            v.set_isLead(false);
                            addTo = this.get_discardedLeads().control;
                            unapprove = true;
                        }
                    } else if (isLead) {
                        removeFrom = this.get_approvedLeads().control;

                        if (state == 'discarded') {
                            v.set_isLead(false);
                            addTo = this.get_discardedLeads().control;
                        } else if (state == 'unknown' || state == 'DW_POTENTIALLEAD') {
                            v.set_isLead(null);
                            addTo = this.get_potentialLeads().control;
                        } else {
                            v.set_state(state);
                            if (this.get_approvedLeads() && this.get_approvedLeads().control) {
                                this.get_approvedLeads().control.tryUpdateLeadState(v);
                            }
                        }
                    } else {
                        removeFrom = this.get_discardedLeads().control;

                        if (state == 'approved') {
                            v.set_isLead(true);
                            addTo = this.get_approvedLeads().control;
                        } else if (state == 'unknown' || state == 'DW_POTENTIALLEAD') {
                            v.set_isLead(null);
                            addTo = this.get_potentialLeads().control;
                        }
                    }

                    if (removeFrom != null) {
                        this.queueUpdateVisitor(v.get_id(), state, prevState, v.get_visitorID());
                        if (addTo != null) {
                            if (typeof (position) == 'undefined' || position == null) {
                                position = removeFrom.getVisitorPosition(v);
                            }

                            if (position >= 0) {
                                removeFrom.removeVisitor(position);
                            }

                            addTo.addVisitor(v);

                            if (this.get_keepTemporarilyApproved() && unapprove) {
                                if (!v.get_isActive()) {
                                    v.set_isActive(true);
                                }

                                this.get_approvedLeads().control.removeVisitor(this.get_approvedLeads().control.getVisitorPosition(v));
                            }
                        }
                    }
                }
            }

            if (this.get_approvedLeads() && this.get_approvedLeads().control) this.get_approvedLeads().control.clearSelection();
            if (this.get_potentialLeads() && this.get_potentialLeads().control) this.get_potentialLeads().control.clearSelection();
            if (this.get_discardedLeads() && this.get_discardedLeads().control) this.get_discardedLeads().control.clearSelection();
        }
    } else {
        if (v && typeof (v.set_state) == 'function') {
            prevState = v.get_state();
            v.set_state(state);

            this.queueUpdateVisitor(v.get_id(), state, prevState, v.get_visitorID());
            if (this.get_approvedLeads() && this.get_approvedLeads().control) {
                this.get_approvedLeads().control.tryUpdateLeadState(v);
            }
        }

        if (this.get_approvedLeads() && this.get_approvedLeads().control) this.get_approvedLeads().control.clearSelection();
    }
}

OMC.LeadTool.prototype.addKnownProvider = function (provider) {
    /// <summary>Adds new known provider.</summary>
    /// <param name="provider">Provider to add.</param>

    var self = this;
    var providersData = '';
    var providerFound = false;

    if (provider && provider.length) {
        providerFound = this.isKnownProvider(provider);

        if (!providerFound) {
            /* Updating the list of known providers */
            this._knownProviders[provider.toLowerCase()] = provider;

            /* Next, updating the list of providers to be added to server-side configuration file */
            if (!this._addProvidersQueue || !this._addProvidersQueue.length) {
                this._addProvidersQueue = [provider];
            } else {
                /* The queue is not empty - trying to find the provider in it */
                for (var i = 0; i < this._addProvidersQueue.length; i++) {
                    if (this._addProvidersQueue[i].toLowerCase() == provider.toLowerCase()) {
                        providerFound = true;
                        break;
                    }
                }

                if (!providerFound) {
                    this._addProvidersQueue[this._addProvidersQueue.length] = provider;
                }
            }
        }

        /* Building a string containing all providers to be added to configuration file */
        for (var i = 0; i < this._addProvidersQueue.length; i++) {
            providersData += this._addProvidersQueue[i];
            if (i < (this._addProvidersQueue.length - 1)) {
                providersData += '$';
            }
        }

        /* Canceling previous async task */
        if (this._addProvidersTimeoutID) {
            clearTimeout(this._addProvidersTimeoutID);
            this._addProvidersTimeoutID = null;
        }

        /* Registering new async task */
        this._addProvidersTimeoutID = setTimeout(function () {
            /* The queue is empty from now */
            self._addProvidersQueue = [];

            /* Posting the list of providers to the server - this will add them to OMC configuration */
            parent.OMC.MasterPage.get_current().executeTask('AddKnownProviders', { Providers: providersData }, function (response) {
                var context = parent ? parent.document.body : document.body;
                var field = $(context).select('input.leads-filter-excludeisps');

                /* Auto-applying "Exclude generic providers" filter */
                if (field && field.length) {
                    if (field[0].disabled) field[0].disabled = false;
                    if (!field[0].checked) field[0].checked = true;

                    /* Reloading lists */
                    self.applyFilters();
                }
            });
        }, 350);
    }
}

OMC.LeadTool.prototype.save = function (onComplete) {
    /// <summary>Saves current changes.</summary>
    /// <param name="onComplete">Callback that is executed when changes are saved.</param>

    var self = this;
    var hideTimeoutID = null;
    var buttons = ['cmdSave', 'cmdSave_2', 'cmdSave_3'];

    onComplete = onComplete || function () { }

    this.synchronize({ onComplete: function (sender, args) {
            if (hideTimeoutID) {
                clearTimeout(hideTimeoutID);
                hideTimeoutID = null;
            }

            for (var i = 0; i < buttons.length; i++) {
                parent.Ribbon.disableButton(buttons[i]);
                parent.Ribbon.set_buttonText(buttons[i], self.get_terminology()['Saved']);
            }

            setTimeout(function () {
                for (var i = 0; i < buttons.length; i++) {
                    parent.Ribbon.set_buttonText(buttons[i], self.get_terminology()['Save']);
                    parent.Ribbon.enableButton(buttons[i]);
                }
            }, 3000);

            onComplete();
        }
    });
}

OMC.LeadTool.prototype.saveAndClose = function () {
    /// <summarySaves current changes and closes the form.</summary>

    var self = this;

    this.save(function () {
        self.cancel();
    });
}

OMC.LeadTool.prototype.cancel = function () {
    /// <summary>Discards all changes and closes the form.</summary>

    this._triggerUnsavedConfirmation = false;

    parent.OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Dashboard.aspx');
}

OMC.LeadTool.prototype.synchronize = function (params) {
    /// <summary>Commits current changes to the server.</summary>
    /// <param name="params">Commit parameters.</param>

    var v = null;
    var keys = [];
    var self = this;
    var clonedData = null;
    var data = new Hash();
    var onComplete = null;
    var visitorsToRemove = [];

    params = params || {};
    onComplete = params.onComplete || function () { }

    this.set_isSynchronizing(true);

    if (params.data) {
        if (typeof (params.data.keys) == 'function') {
            data = params.data;
        } else {
            data = new Hash(params.data);
        }
    } else {
        clonedData = this.get_syncData().clone();        
        this._syncData = null;

        keys = clonedData.keys();
        for (var i = 0; i < keys.length; i++) {
            data.set(clonedData.get(keys[i]).visitorID, clonedData.get(keys[i]).state);
        }
    }

    if (data.keys().length) {
        data.set('IDs', data.keys());

        parent.OMC.MasterPage.get_current().executeTask(!this.get_isManagingLeadStates() ? 'SaveLeads' : 'ChangeLeadState', data.toObject(), function (result) {
            self.set_isSynchronizing(false);

            if (self.get_approvedLeads() && self.get_approvedLeads().control) {
                for (var i = 0; i < keys.length; i++) {
                    v = self.get_approvedLeads().control.getVisitorByVisitorID(keys[i]);                    
                    if (v) {
                        visitorsToRemove[visitorsToRemove.length] = v;
                    }
                }

                self.get_approvedLeads().control.removeMultipleVisitors(visitorsToRemove);
            }

            onComplete(self, { response: result });
        }, true);
    } else {
        this.set_isSynchronizing(false);
        onComplete(this, {});
    }
}

OMC.LeadTool.prototype.initialize = function (onComplete) {
    /// <summary>Initializes an object.</summary>
    /// <param name="onComplete">Callback to be executed upon the completion of the initialization process.</param>

    var self = this;

    var onBeforeLoad = function (sender, args) {
        args.set_parameters(args.get_parameters().merge(new Hash(self.get_filters())));
    }

    var onAfterLoad = function (frame, visitorsCount, list) {
        var str = '';

        if (frame) {
            if (visitorsCount > 0) {
                str = list.get_culture().localize(visitorsCount);
            }

            frame.set_hint(str);
        }
    }

    var onSelectionChanged = function (sender, args) {
        self.onSelectionChanged(sender, args);
    }

    var onRowClick = function (sender, args) {
        var elm = null;
        var switchTab = false;

        if (args.rowType == 'row' || args.rowType == 'header') {
            /* Switching tab only if user clicked on a checkbox (either header or row item) */
            switchTab = (args.element.tagName || args.element.nodeName).toLowerCase() == 'input';
            if (switchTab) {
                switchTab = !args.element.disabled;
            } else {
                /* Displaying the information about visits */
                elm = $(args.element);
                if (elm.hasClassName('omc-leads-list-totalvisits-explore') || elm.hasClassName('omc-leads-list-mark-info')) {
                    self.openVisitsList(null, (args.visitor.get_isTracking() ? args.visitor.get_visitorID() : args.visitor.get_id()), args.visitor.get_isLead(), elm.hasClassName('omc-leads-list-totalvisits-explore'), args.visitor.get_orderID());
                }else if (elm.hasClassName('omc-leads-list-totalvisits-explore') || elm.hasClassName('omc-leads-list-mark-email')) {
                    self.openSendLeadAsEmail(null, (args.visitor.get_isTracking() ? args.visitor.get_visitorID() : args.visitor.get_id()), args.visitor.get_isLead(), elm.hasClassName('omc-leads-list-totalvisits-explore'), args.visitor.get_id());
                }
            }
        }

        if (switchTab) {
            parent.Ribbon.tab(2, 'mainMenu');
        }
    }

    var onVisitorMarked = function (sender, args) {
        self.markVisitor(args.visitor, args.state, args.position);
    }

    /* A safe wrapper around the below callback */
    var onLinkTouchedWrapper = function (e) {
        try {
            onLinkTouched(e || window.event);
        } catch (ex) { }
    }

    /* Occurs when any element on a page is clicked */
    var onLinkTouched = function (e) {
        var elm = Event.element(e);

        /* Returns the name of the DOM element tag */
        var getTag = function (t) {
            return t ? ((t.tagName || t.nodeName) + '').toString().toLowerCase() : '';
        }

        /* If this is not a link, trying to find it by traversing DOM tree up */
        if (getTag(elm) != 'a') {
            elm = elm.up('a');
        }

        /* Checking whether link doesn't point to an actual page but rather invokes JavaScript code */
        if (getTag(elm) == 'a') {
            self._anchorClicked = elm.href.indexOf('javascript:') >= 0;
        } else {
            self._anchorClicked = true;
        }

        if (self._anchorClickedResetTimer) {
            clearTimeout(self._anchorClickedResetTimer);
            self._anchorClickedResetTimer = null;
        }

        /* Resetting the flag */
        self._anchorClickedResetTimer = setTimeout(function () {
            self._anchorClicked = false;
        }, 500);
    }

    if (!this._initialized) {
        this._bindToUI();

        this.set_autoSynchronize(false);

        if (!this.get_isManagingLeadStates()) {
            this.get_discardedLeads().control.add_beforeLoad(onBeforeLoad);
            this.get_potentialLeads().control.add_beforeLoad(onBeforeLoad);
        }

        this.get_approvedLeads().control.add_beforeLoad(onBeforeLoad);

        if (!this.get_isManagingLeadStates()) {
            this.get_discardedLeads().control.add_totalVisitorsChanged(function (sender, args) { onAfterLoad(self.get_discardedLeads().frame, args.to, self.get_discardedLeads().control); });
            this.get_potentialLeads().control.add_totalVisitorsChanged(function (sender, args) { onAfterLoad(self.get_potentialLeads().frame, args.to, self.get_potentialLeads().control); });
        }

        this.get_approvedLeads().control.add_totalVisitorsChanged(function (sender, args) { onAfterLoad(self.get_approvedLeads().frame, args.to, self.get_approvedLeads().control); });

        if (!this.get_isManagingLeadStates()) {
            this.get_discardedLeads().control.add_selectionChanged(onSelectionChanged);
            this.get_potentialLeads().control.add_selectionChanged(onSelectionChanged);
        }

        this.get_approvedLeads().control.add_selectionChanged(onSelectionChanged);

        if (!this.get_isManagingLeadStates()) {
            this.get_discardedLeads().control.add_rowClick(onRowClick);
            this.get_potentialLeads().control.add_rowClick(onRowClick);
        }

        this.get_approvedLeads().control.add_rowClick(onRowClick);

        if (!this.get_isManagingLeadStates()) {
            this.get_discardedLeads().control.add_visitorMarked(onVisitorMarked);
            this.get_potentialLeads().control.add_visitorMarked(onVisitorMarked);
        }

        this.get_approvedLeads().control.add_visitorMarked(onVisitorMarked);

        if (!this.get_isManagingLeadStates() && this.get_keepTemporarilyApproved()) {
            this.get_potentialLeads().control.add_rowPopulated(function (sender, args) {
                if (args.visitor.get_isActive() && self.get_approvedLeads().control.get_visitors().indexOf(args.visitor) >= 0) {
                    args.visitor.set_isActive(false);
                }
            });
        }

        if (parent && parent.OMC && parent.OMC.MasterPage) {
            parent.OMC.MasterPage.get_current().add_beforeUnload(function (sender, args) {
                var msg = self.get_terminology()['UnsavedChangesConfirm'];

                self._confirmationReceived = false;

                if (self._triggerUnsavedConfirmation && self.get_hasSyncData()) {
                    args.set_message(msg);
                    args.set_cancel(!confirm(msg));

                    if (!args.get_cancel()) {
                        self._confirmationReceived = true;
                    }
                }
            });
        }

        document.body.onbeforeunload = function () {
            if (!self._anchorClicked && !self._confirmationReceived && self._triggerUnsavedConfirmation && self.get_hasSyncData())
                return self.get_terminology()['UnsavedChangesConfirm'];
        }

        if (Prototype.Browser.IE) {
            $(document.body).observe('mouseup', onLinkTouchedWrapper);

            if (parent) {
                $(parent.document.body).observe('mouseup', onLinkTouchedWrapper);
            }

            document.body.onunload = function () {
                /* Unregistering event handlers preventing "Can't execute code from freed script" error */
                $(document.body).stopObserving('mouseup', onLinkTouchedWrapper);

                if (parent) {
                    $(parent.document.body).stopObserving('mouseup', onLinkTouchedWrapper);
                }
            }
        }

        this.set_filters({ PageID: '', PageName: '' });

        this._initialized = true;

        if (typeof (onComplete) == 'function') {
            onComplete();
        }
    }
}

OMC.LeadTool.prototype.openSendLeadAsEmail = function (dialog, visitorID, isLead, navigateToVisits, rowId) {
    /// <summary>Brings up "Visits" dialog.</summary>
    /// <param name="dialog">Dialog instance.</param>
    /// <param name="visitorID">A unique identifier of the visitor.</param>
    /// <param name="isLead">Value indicating whether visitor is lead.</param>
    /// <param name="navigateToVisits">Value indicating whether to open "Visits" section.</param>


    if (!dialog) {
        dialog = this.get_sendEmailDialog();
    }
    if (dialog) {
        var query = null;
        var vIDs = visitorID.split(',');
        var resultIsLead = '';

        var splitIsLeadArray;
        if (isLead == null || isLead == undefined || !isLead)
            splitIsLeadArray = [null];
        else
            splitIsLeadArray = isLead.split(',');

        var isLeadValue;
        for (var i = 0; i < vIDs.length; i++) {
            var data = this.get_syncData();
            var keys = data.keys();
            var item = null;
            for (var j = 0; j < keys.length; j++) {
                var current = data.get(keys[j]);
                if (current.visitorID == vIDs[i])
                {
                    item = current;
                    break;
                }
            }
            if (dialog) {
                isLeadValue = splitIsLeadArray[i];
                if (item) {
                    if (item.originalState == 'approved') {
                        isLeadValue = true;
                    } else if (item.originalState == 'discarded') {
                        isLeadValue = false;
                    } else {
                        isLeadValue = null;
                    }
                }
                resultIsLead += (isLeadValue + ',');
            }
        }

        query = this.get_filters()
        query.ID = visitorID;
        query.IsLead = resultIsLead.substr(0, resultIsLead.length - 1);
        if (!!navigateToVisits) {
            query.Section = navigateToVisits;
        }
        query.rowId = rowId;


        dialog.set_contentUrl('/Admin/Module/OMC/Leads/EmailLeadEdit.aspx?' + Object.toQueryString(query));

        dialog.show();
    }
}

OMC.LeadTool.prototype.openVisitsList = function (dialog, visitorID, isLead, navigateToVisits, orderID) {
    /// <summary>Brings up "Visits" dialog.</summary>
    /// <param name="dialog">Dialog instance.</param>
    /// <param name="visitorID">A unique identifier of the visitor.</param>
    /// <param name="isLead">Value indicating whether visitor is lead.</param>
    /// <param name="navigateToVisits">Value indicating whether to open "Visits" section.</param>

    var url = '';
    var query = null;
    var width = 1020, height = 510;
    var data = this.get_syncData();
    var keys = data.keys();
    var item = null;
    for (var j = 0; j < keys.length; j++) {
        var current = data.get(keys[j]);
        if (current.visitorID == vIDs[i]) {
            item = current;
            break;
        }
    }

    query = Object.toQueryString(this.get_filters());

    if (item) {
        if (item.originalState == 'approved') {
            isLead = true;
        } else if (item.originalState == 'discarded') {
            isLead = false;
        } else {
            isLead = null;
        }
    }

    if (isLead != null) {
        query += ('&IsLead=' + isLead.toString());
    }

    if (orderID) {
        query += ('&orderID=' + orderID.toString());
    }

    url = '/Admin/Module/OMC/Leads/Details/Default.aspx?ID=' + encodeURIComponent(visitorID) +
        (!!navigateToVisits ? '&Section=Visits' : '') + '&' + query;

    parent.OMC.MasterPage.get_current().showDialog(url, width, height, {
        title: this.get_terminology()['VisitorDetails']
    });
}

OMC.LeadTool.prototype.createEmailNotification = function (dialog) {
    /// <summary>Brings up "Attach to notification" dialog.</summary>
    /// <param name="dialog">Dialog instance.</param>

    var self = this;
    var isAttaching = function () {
        return dialog.get_contentUrl().indexOf('EmailNotificationAttach.aspx') > 0;
    }

    if (typeof (dialog) == 'string') {
        dialog = eval(dialog);
    }

    if (dialog) {
        dialog.set_contentUrl('/Admin/Module/OMC/Leads/EmailNotificationAttach.aspx');

        if (!this._dialogState.attach.eventsCreated) {
            dialog.add_load(function (sender, args) {
                var frame = sender.get_contentFrame();
                var w = frame.contentWindow ? frame.contentWindow : frame.window;

                w.OMC.ReturningVisitorNotificationManager.get_current().add_ready(function (sender, args) {
                    if (isAttaching()) {
                        sender.set_visitors(self._getVisitorIDs());
                        sender.set_hostingWindow(dialog);
                    }
                });

                self.add_selectionChanged(function (sender, args) {
                    if (isAttaching()) {
                        if (w && w.OMC && w.OMC.ReturningVisitorNotificationManager) {
                            w.OMC.ReturningVisitorNotificationManager.get_current().set_visitors(self._getVisitorIDs());
                        }
                    }
                });
            });

            this._dialogState.attach.eventsCreated = true;
        }

        dialog.show();
    }
}

OMC.LeadTool.prototype.manageEmailNotifications = function (dialog) {
    /// <summary>Brings up "Manage notifications" dialog.</summary>
    /// <param name="dialog">Dialog instance.</param>

    if (typeof (dialog) == 'string') {
        dialog = eval(dialog);
    }

    if (dialog) {
        dialog.set_contentUrl('/Admin/Module/OMC/Leads/EmailNotificationList.aspx');
        dialog.show();
    }
}

OMC.LeadTool.prototype._mergeArrays = function (ar1, ar2) {
    /// <summary>Merges two arrays.</summary>
    /// <param name="ar1">First array to merge.</param>
    /// <param name="ar2">Second array to merge.</param>
    /// <private />

    var ret = [];

    if (ar1 && ar1.length) {
        for (var i = 0; i < ar1.length; i++) {
            ret[ret.length] = ar1[i];
        }
    }

    if (ar2 && ar2.length) {
        for (var i = 0; i < ar2.length; i++) {
            ret[ret.length] = ar2[i];
        }
    }

    return ret;
}

OMC.LeadTool.prototype._getVisitorIDs = function () {
    /// <summary>Gets the list of selected visitor IDs.</summary>
    /// <private />

    var ret = [];
    var selection = this.get_selection();

    if (selection && selection.length) {
        for (var i = 0; i < selection.length; i++) {
            if (selection[i].get_isTracking()) {
                ret[ret.length] = selection[i].get_visitorID();
            }
        }
    }

    return ret;
}

OMC.LeadTool.prototype.onSelectionChanged = function (sender, args) {
    /// <summary>Handles list "selectionChanged" event.</summary>
    /// <param name="sender">Event sender.</param>
    /// <param name="args">Event arguments.</param>
    /// <private />

    this.notify('selectionChanged', args);
}

OMC.LeadTool.prototype.onAreaSelect = function(el) {
    this.set_filters({ PageID: '', PageName: '' });
    this.applyFilters();
}

OMC.LeadTool.prototype.onPageSelect = function (options) {
    var filters = this.get_filters();

    if (filters.AreaID && filters.AreaID !== options.AreaID) {
        this.set_filters(options);
    }

    this.applyFilters();
};

OMC.LeadTool.prototype._tryEval = function (str) {
    /// <summary>Evaluates the given content if it's a string. Otherwise, returns the original object.</summary>
    /// <param name="str">Content to evaluate.</param>
    /// <private />

    var ret = null;

    if (str) {
        if (typeof (str) == 'string') {
            try {
                ret = eval(str);
            } catch (ex) { }
        } else {
            ret = str;
        }
    }

    return ret;
}

OMC.LeadTool.prototype._bindToUI = function () {
    /// <summary>Binds properties of the current object to UI elements.</summary>
    /// <private />

    var self = this;
    var synchronizeButtons = [];

    if (!this._bound) {
        this._binder = new Dynamicweb.UIBinder(this);

        /* "Synchronize" dependent UI elements */
        synchronizeButtons = [
            'cmdSave',
            'cmdSave_and_close',
            'cmdCancel',
            'cmdSynchronize',
            'cmdSave_2',
            'cmdSave_and_close_2',
            'cmdCancel_2',
            'cmdSave_3',
            'cmdSave_and_close_3',
            'cmdCancel_3'
        ];

        this._binder.bindProperty('autoSynchronize', [{ action: new Dynamicweb.UIBinder.Actions.ToggleRibbonChecked(), elements: ['cmdSynchronize']}]);
        this._binder.bindProperty('isSynchronizing', [{ action: new Dynamicweb.UIBinder.Actions.ToggleRibbonEnabled(true), elements: synchronizeButtons}]);
        this._binder.bindProperty('isReloading', [{ elements: [], action: function (sender, args) {
                var ribbonID = 'mainMenu';
                var instance = parent.Ribbon;
                var isLoading = Dynamicweb.UIBinder.Helpers.isTrue(args.value);

                if (instance) {
                    if (isLoading) {
                        instance.disableEditing(ribbonID);
                    } else {
                        instance.enableEditing(ribbonID);
                    }
                }
            }
        }]);

        this._binder.bindMethod('onSelectionChanged', [{ elements: [], action: function (sender, args) {
                var v = null;
                var leadsCount = 0;
                var notLeadsCount = 0;
                var knownProvidersCount = 0;
                var potentialLeadsCount = 0;
                var instance = parent.Ribbon;
                var hasTrackingVisitors = false;
                var selection = self.get_selection();

                if (!selection || !selection.length) {
                    if (instance) {
                        instance.disableButton('cmdMark_as_leads');
                        instance.disableButton('cmdMark_as_not_leads');
                        instance.disableButton('cmdIgnore_companies');
                        instance.disableButton('cmdCreate_notification');
                        instance.disableButton('cmdSend_in_mail');
                    }                           
                } else {
                    for (var i = 0; i < selection.length; i++) {
                        v = selection[i];
                        if (v && typeof (v.get_isLead) == 'function') {
                            if (v.get_company() && v.get_company().length) {
                                if (self.isKnownProvider(v.get_company())) {
                                    knownProvidersCount += 1;
                                }
                            } else {
                                knownProvidersCount += 1;
                            }

                            if (v.get_isLead() == null) {
                                potentialLeadsCount += 1;
                            } else if (!v.get_isLead()) {
                                notLeadsCount += 1;
                            } else {
                                leadsCount += 1;
                            }

                            if (v.get_isTracking()) {
                                hasTrackingVisitors = true;
                            }
                        }
                    }
                    instance.enableButton('cmdSend_in_mail');
                    if (hasTrackingVisitors) {
                        instance.enableButton('cmdCreate_notification');
                    } else {
                        instance.disableButton('cmdCreate_notification');
                    }

                    if (!hasTrackingVisitors) {
                        instance.disableButton('cmdMark_as_leads');
                        instance.disableButton('cmdMark_as_not_leads');
                    } else {
                        if (potentialLeadsCount > 0) {
                            instance.enableButton('cmdMark_as_leads');
                            instance.enableButton('cmdMark_as_not_leads');
                            instance.enableButton('cmdIgnore_companies');
                        } else {
                            if (notLeadsCount > 0) {
                                instance.enableButton('cmdMark_as_leads');
                            } else {
                                instance.disableButton('cmdMark_as_leads');
                            }

                            if (leadsCount > 0) {
                                instance.enableButton('cmdMark_as_not_leads');
                            } else {
                                instance.disableButton('cmdMark_as_not_leads');
                            }
                        }
                    }

                    if (knownProvidersCount == selection.length) {
                        instance.disableButton('cmdIgnore_companies');
                    } else {
                        instance.enableButton('cmdIgnore_companies');
                    }
                }

                if (parent.OMC && parent.OMC.LeadTool && parent.OMC.LeadTool.Toolbar) {
                    parent.OMC.LeadTool.Toolbar.get_current().onSelectionChanged(selection);
                }
            }
        }]);

        Event.observe(document.body, 'mousedown', function (e) {
            if (parent && parent.OMC && parent.OMC.LeadTool && parent.OMC.LeadTool.Toolbar) {
                parent.OMC.LeadTool.Toolbar.get_current().invalidate();
            }
        });

        this._bound = true;
    }
}