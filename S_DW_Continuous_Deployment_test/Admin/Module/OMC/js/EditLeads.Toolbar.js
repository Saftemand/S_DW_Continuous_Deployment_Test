/* ++++++ Registering namespace ++++++ */

if (typeof (OMC) == 'undefined') {
    var OMC = new Object();
}

if (typeof (OMC.LeadTool) == 'undefined') {
    OMC.LeadTool = new Object();
}

/* ++++++ End: Registering namespace ++++++ */

OMC.LeadTool.Toolbar = function () {
    /// <summary>Represents a toolbar within the OMC Lead tool.</summary>

    this._weekOverview = null;
    this._dateFrom = null;
    this._dateTo = null;
    this._weekMenuID = null;
    this._weekButtonID = '';
    this._todayButtonID = '';
    this._leadStatesDropDownID = '';
    this._initialized = false;
    this._terminology = {};
    this._currentLeadState = '';
    this._isManagingLeadStates = false;

    this._dateFromSync = 'none';
    this._dateToSync = 'none';
}

OMC.LeadTool.Toolbar._instance = null;

OMC.LeadTool.Toolbar.get_current = function () {
    /// <summary>Gets the current instance of the toolbar.</summary>

    if (!OMC.LeadTool.Toolbar._instance) {
        OMC.LeadTool.Toolbar._instance = new OMC.LeadTool.Toolbar();
    }

    return OMC.LeadTool.Toolbar._instance;
}

OMC.LeadTool.Toolbar.prototype.get_weekOverview = function () {
    /// <summary>Gets the reference to week overview control.</summary>

    var ret = null;

    if (this._weekOverview) {
        if (typeof (this._weekOverview) == 'string') {
            try {
                ret = eval(this._weekOverview);
            } catch (ex) { }

            if (ret) {
                this._weekOverview = ret;
            }
        } else {
            ret = this._weekOverview;
        }
    }

    return ret;
}

OMC.LeadTool.Toolbar.prototype.set_weekOverview = function (value) {
    /// <summary>Sets the reference to week overview control.</summary>
    /// <param name="value">The reference to week overview control.</param>

    this._weekOverview = value;
}

OMC.LeadTool.Toolbar.prototype.get_dateFrom = function () {
    /// <summary>Gets the reference to "From date" date selector control.</summary>

    var ret = null;

    if (this._dateFrom) {
        if (typeof (this._dateFrom) == 'string') {
            try {
                ret = eval(this._dateFrom);
            } catch (ex) { }

            if (ret) {
                this._dateFrom = ret;
            }
        } else {
            ret = this._dateFrom;
        }
    }

    return ret;
}

OMC.LeadTool.Toolbar.prototype.set_dateFrom = function (value) {
    /// <summary>Sets the reference to "From date" date selector control.</summary>
    /// <param name="value">The reference to "From date" date selector control.</param>

    this._dateFrom = value;
}

OMC.LeadTool.Toolbar.prototype.get_dateTo = function () {
    /// <summary>Gets the reference to "To date" date selector control.</summary>

    var ret = null;

    if (this._dateTo) {
        if (typeof (this._dateTo) == 'string') {
            try {
                ret = eval(this._dateTo);
            } catch (ex) { }

            if (ret) {
                this._dateTo = ret;
            }
        } else {
            ret = this._dateTo;
        }
    }

    return ret;
}

OMC.LeadTool.Toolbar.prototype.set_dateTo = function (value) {
    /// <summary>Sets the reference to "To date" date selector control.</summary>
    /// <param name="value">The reference to "To date" date selector control.</param>

    this._dateTo = value;
}

OMC.LeadTool.Toolbar.prototype.get_terminology = function () {
    /// <summary>Gets the terminology object.</summary>

    return this._terminology;
}

OMC.LeadTool.Toolbar.prototype.set_weekMenuID = function (value) {
    /// <summary>Sets the ID of the "Week" context-menu.</summary>
    /// <param name="value">The ID of the "Week" context-menu.</param>

    this._weekMenuID = value;
}

OMC.LeadTool.Toolbar.prototype.get_weekMenuID = function () {
    /// <summary>Gets the ID of the "Week" context-menu.</summary>

    return this._weekMenuID;
}

OMC.LeadTool.Toolbar.prototype.set_weekMenuID = function (value) {
    /// <summary>Sets the ID of the "Week" context-menu.</summary>
    /// <param name="value">The ID of the "Week" context-menu.</param>

    this._weekMenuID = value;
}

OMC.LeadTool.Toolbar.prototype.get_weekButtonID = function () {
    /// <summary>Gets the ID of the "Week" Ribbon button.</summary>

    return this._weekButtonID;
}

OMC.LeadTool.Toolbar.prototype.set_weekButtonID = function (value) {
    /// <summary>Sets the ID of the "Week" Ribbon button.</summary>
    /// <param name="value">The ID of the "Week" Ribbon button.</param>

    this._weekButtonID = value;
}

OMC.LeadTool.Toolbar.prototype.get_todayButtonID = function () {
    /// <summary>Gets the ID of the "Today" Ribbon button.</summary>

    return this._todayButtonID;
}

OMC.LeadTool.Toolbar.prototype.set_todayButtonID = function (value) {
    /// <summary>Sets the ID of the "Today" Ribbon button.</summary>
    /// <param name="value">The ID of the "Today" Ribbon button.</param>

    this._todayButtonID = value;
}

OMC.LeadTool.Toolbar.prototype.get_leadStatesID = function () {
    /// <summary>Gets the ID of the "Lead states" drop-down/buttons.</summary>

    return this._leadStatesID;
}

OMC.LeadTool.Toolbar.prototype.set_leadStatesID = function (value) {
    /// <summary>Sets the ID of the "Lead states" drop-down/buttons.</summary>
    /// <param name="value">The ID of the "Lead states" drop-down/buttons.</param>

    this._leadStatesID = value;
}

OMC.LeadTool.Toolbar.prototype.get_currentLeadState = function () {
    /// <summary>Gets the current lead state.</summary>

    return this._currentLeadState;
}

OMC.LeadTool.Toolbar.prototype.set_currentLeadState = function (value) {
    /// <summary>Sets the current lead state.</summary>
    /// <param name="value">The current lead state.</param>

    this._currentLeadState = value;
}

OMC.LeadTool.Toolbar.prototype.get_isManagingLeadStates = function () {
    /// <summary>Gets value indicating whether this is a page for managing lead states rather than a page for marking leads.</summary>

    return this._isManagingLeadStates;
}

OMC.LeadTool.Toolbar.prototype.set_isManagingLeadStates = function (value) {
    /// <summary>Sets value indicating whether this is a page for managing lead states rather than a page for marking leads.</summary>

    this._isManagingLeadStates = !!value;
}

OMC.LeadTool.Toolbar.prototype.onWeekChanged = function (selectedButton) {
    /// <summary>Occurs when the week changes.</summary>
    /// <param name="selectedButton">DOM element that corresponds to selected week.</param>

    var selectedWeek = 1;
    var buttons = ContextMenu.get_buttons(this.get_weekMenuID());

    for (var i = 0; i < buttons.length; i++) {
        if ($(buttons[i]).select('a')[0] == selectedButton) {
            ContextMenu.set_isChecked(this.get_weekMenuID(), buttons[i].id, true);
            selectedWeek = i + 1;
        } else {
            ContextMenu.set_isChecked(this.get_weekMenuID(), buttons[i].id, false);
        }
    }

    if (selectedWeek > 0) {
        this.get_weekOverview().set_selection(Dynamicweb.Controls.OMC.WeekOverviewSelection.firstDayOfWeek(selectedWeek, this.get_weekOverview().get_culture()));
    }
}

OMC.LeadTool.Toolbar.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>

    var self = this;
    var buttonText = '';

    var selectWeek = function (week) {
        var buttons = ContextMenu.get_buttons(self.get_weekMenuID());

        if (week > 0 && week <= buttons.length) {
            week -= 1;

            for (var i = 0; i < buttons.length; i++) {
                if (i == week) {
                    buttonText = typeof (buttons[i].innerText) != 'undefined' ? buttons[i].innerText : buttons[i].textContent;
                    if (typeof (buttonText) == 'undefined') buttonText = typeof (buttons[i].nodeValue) != 'undefined' ? buttons[i].nodeValue : buttons[i].data;

                    ContextMenu.set_isChecked(self.get_weekMenuID(), buttons[i].id, true);
                    Ribbon.set_buttonText(self.get_weekButtonID(), buttonText);
                } else {
                    ContextMenu.set_isChecked(self.get_weekMenuID(), buttons[i].id, false);
                }
            }
        } else {
            Ribbon.set_buttonText(self.get_weekButtonID(), self.get_terminology()['Week']);
            for (var i = 0; i < buttons.length; i++) {
                ContextMenu.set_isChecked(self.get_weekMenuID(), buttons[i].id, false);
            }
        }
    }

    var updateSelection = function (fromDate, toDate) {
        var tmp = null;

        if (fromDate && toDate && typeof (fromDate.getTime) == 'function' && typeof (toDate.getTime) == 'function') {
            if (fromDate.getTime() > toDate.getTime()) {
                tmp = fromDate;
                fromDate = toDate;
                toDate = tmp;
            }

            if (toDate.getTime() > new Date().getTime() || fromDate.getFullYear() != toDate.getFullYear() ||
                (fromDate.getFullYear() == toDate.getFullYear() && fromDate.getMonth() != toDate.getMonth()) ||
                (fromDate.getFullYear() == toDate.getFullYear() && fromDate.getMonth() == toDate.getMonth() &&
                    Dynamicweb.Controls.OMC.WeekOverviewSelection.getWeekOfYear(fromDate, self.get_weekOverview().get_culture()) !=
                    Dynamicweb.Controls.OMC.WeekOverviewSelection.getWeekOfYear(toDate, self.get_weekOverview().get_culture()))) {

                self.get_weekOverview().set_selection(null);
            } else {
                self.get_weekOverview().set_selection(new Dynamicweb.Controls.OMC.WeekOverviewSelection(fromDate, toDate, self.get_weekOverview().get_culture()));
            }
        }
    }

    this.get_weekOverview().add_selectionChanged(function (sender, args) {
        selectWeek(args.selection != null ? args.selection.get_week() : -1);

        if (args.selection) {
            if (self._dateFromSync != 'overview') {
                self._dateFromSync = 'calendar';
                self.get_dateFrom().set_selectedDate(args.selection.get_startDate());
            } else {
                self._dateFromSync = 'none';
            }

            if (self._dateToSync != 'overview') {
                self._dateToSync = 'calendar';
                self.get_dateTo().set_selectedDate(args.selection.get_endDate());
            } else {
                self._dateToSync = 'none';
            }
        } else {
            self._dateFromSync = 'none';
            self._dateToSync = 'none';
        }
    });

    this.get_dateFrom().add_dateChanged(function (sender, args) {
        if (self._dateFromSync != 'calendar') {
            self._dateFromSync = 'overview';
            updateSelection(args.selectedDate, self.get_dateTo().get_selectedDate());
        } else {
            self._dateFromSync = 'none';
        }
    });

    this.get_dateTo().add_dateChanged(function (sender, args) {
        if (self._dateToSync != 'calendar') {
            self._dateToSync = 'overview';
            updateSelection(self.get_dateFrom().get_selectedDate(), args.selectedDate);
        } else {
            self._dateToSync = 'none';
        }
    });
}

OMC.LeadTool.Toolbar.prototype.invalidate = function () {
    /// <summary>Invalidates toolbar controls.</summary>

    ContextMenu.hide(this.get_weekMenuID());
    Ribbon.unhoverButton(this.get_weekButtonID());
    Dynamicweb.Controls.OMC.DateSelector.Calendar.hideAll()
}

OMC.LeadTool.Toolbar.prototype.onSelectionChanged = function (selection) {
    /// <summary>Occurs when lead list selection changes.</summary>
    /// <param name="selection">Selection.</param>

    var buttons = [];
    var hasSelection = false;
    var leadStatesDropDown = null;
    var selectionStates = new Hash();

    if (this.get_isManagingLeadStates()) {
        hasSelection = selection && selection.length;

        if (hasSelection) {
            for (var i = 0; i < selection.length; i++) {
                if (selection[i]) {
                    if (typeof (selection[i].get_state) == 'function') {
                        selectionStates.set(selection[i].get_state(), true);
                    } else if (typeof (selection[i].state) != 'undefined') {
                        selectionStates.set(selection[i].state, true);
                    }
                }
            }
        }

        if (typeof (this.get_leadStatesID()) == 'string') {
            leadStatesDropDown = document.getElementById(this.get_leadStatesID());
            if (leadStatesDropDown) {
                leadStatesDropDown.disabled = !hasSelection;
            }
        } else {
            buttons = this.get_leadStatesID();
            if (buttons && buttons.length) {
                for (var i = 0; i < buttons.length; i++) {
                    if (hasSelection) {
                        Ribbon.enableButton(buttons[i]);
                    } else {
                        Ribbon.disableButton(buttons[i]);
                    }
                }
            }
        }
    }
}