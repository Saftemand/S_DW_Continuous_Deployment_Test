/*  Copyright Mihai Bazon, 2002, 2003  |  http://dynarch.com/mishoo/
 * ---------------------------------------------------------------------------
 *
 * The DHTML Calendar
 *
 * Details and latest version at:
 * http://dynarch.com/mishoo/calendar.epl
 *
  */
if (typeof(Calendar) != "undefined" && typeof(Calendar.setup) == "undefined"){


    Calendar.DWClearDate = function(prefix) {
        var fLabel = document.getElementById(prefix + '_label');
        var fYear = document.getElementById(prefix + "_year");
        var fHidden = document.getElementById(prefix + "_calendar");
        var fNotSet = document.getElementById(prefix + "_notSet");

        // Set label
        if (fLabel) fLabel.innerHTML = document.getElementById(prefix + '_NotSetString').value;

        // Set year
        if (fYear && fYear[fYear.length - 1].value == 2999) // Means that the year select control has an option that says 'never'
            fYear.value = 2999;

        // Set hidden
        var date = new Date();
        if (fYear)
            // If the select box is present, set the year to 2999, else leave it at the current date
            date.setFullYear(2999);
        fHidden.value = date.print("%Y-%m-%d %H:%M");

        // Set 'not set' value
        fNotSet.value = 'True';
    }

    Calendar.updateDWLabel = function (prefix, date, updateHidden, showsTime) {
        var fLabel = document.getElementById(prefix + '_label');
        if (fLabel) {
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            var hours = date.getHours();
            var minutes = date.getMinutes();

            var url = '/Admin/Public/DateSelector/calendar-lang.js.aspx' +
                      '?AJAX=GetFormatedDate' +
                      '&Year=' + year +
                      '&Month=' + month +
                      '&Day=' + day +
                      '&time=' + new Date().getTime();

            if (showsTime) {
                url += '&Hours=' + hours + '&Minutes=' + minutes;
            }

            new Ajax.Request(url, {
                onSuccess: function (response) {
                    fLabel.innerHTML = response.responseText;
                }
            });
        }

        if (updateHidden) {
            var fHidden = document.getElementById(prefix + "_calendar");
            fHidden.value = date.print("%Y-%m-%d %H:%M");
            var fNotSet = document.getElementById(prefix + "_notSet");
            fNotSet.value = 'False';
        }
    }
    /**
     * Updates calendar fields.
     * @calendar - calendar object
     * @prefix - prefix for calendar fields
     * @direction - direction for update (true = calendar -> fields, false = fields->calendar)
     * @returns nothing
     */
    Calendar.onUpdateDW = function (calendar, prefix, direction) {
        // selects
        var fDay = document.getElementById(prefix + "_day");
        var fMonth = document.getElementById(prefix + "_month");
        var fYear = document.getElementById(prefix + "_year");
        var fHour = document.getElementById(prefix + "_hour");
        var fMinute = document.getElementById(prefix + "_minute");
        var fFullDate = document.getElementById(prefix + "_fulldate");
        // hidden field
        var fHidden = document.getElementById(prefix + "_calendar");
        var fNotSet = document.getElementById(prefix + "_notSet");
        if (fNotSet) {
            fNotSet.value = 'False';
        }

        if (direction) { // calendar -> fields
            var date = calendar.date;
            if (fYear) fYear.value = date.getFullYear();
            if (fMonth) fMonth.value = date.getMonth() + 1;
            if (fDay) fDay.value = date.getDate();
            if (fHour) fHour.value = date.getHours();
            if (fMinute) fMinute.value = date.getMinutes() - date.getMinutes() % 5;
            if (fFullDate) {
                fFullDate.value = date.print("%m/%d/%Y %H:%M");
                fFullDate.onchange();
            }
            Calendar.updateDWLabel(prefix, date, false, calendar.showsTime);
        }
        else { // fields -> calendar
            var date = new Date();
            if (fYear) date.setFullYear(fYear.value);
            if (fMonth) date.setMonth(fMonth.value - 1);
            if (fDay) date.setDate(fDay.value);
            if (fHour) date.setHours(fHour.value);
            if (fMinute) date.setMinutes(fMinute.value);
            if (fFullDate) {
                var parts = fFullDate.value.split(/[\W]+/);
                if (parts.length >= 3) {
                    date.setMonth(parts[0] - 1);
                    date.setDate(parts[1]);
                    date.setFullYear(parts[2]);
                }
                try {
                    date.setHours(parts[3]);
                    date.setMinutes(parts[4]);
                }
                catch (e) { }
            }
            if (fHidden) {
                fHidden.value = date.print("%Y-%m-%d %H:%M");
            }
        }
    }


    Calendar.setup = function (params, suppressAlert) {
        function param_default(pname, def) { if (typeof params[pname] == "undefined") { params[pname] = def; } };

        param_default("inputField",     null);
        param_default("displayArea",    null);
        param_default("button",         null);
        param_default("eventName",      "click");
        param_default("ifFormat",       "%Y/%m/%d");
        param_default("daFormat",       "%Y/%m/%d");
        param_default("singleClick",    true);
        param_default("disableFunc",    null);
        param_default("dateStatusFunc", params["disableFunc"]);	// takes precedence if both are defined
        param_default("dateText",       null);
        param_default("firstDay",       null);
        param_default("align",          "Br");
        param_default("range",          [1900, 2999]);
        param_default("weekNumbers",    true);
        param_default("flat",           null);
        param_default("flatCallback",   null);
        param_default("onSelect",       null);
        param_default("onClose",        null);
        param_default("onUpdate",       null);
        param_default("date",           null);
        param_default("showsTime",      false);
        param_default("timeFormat",     "24");
        param_default("electric",       true);
        param_default("step",           2);
        param_default("position",       null);
        param_default("cache",          false);
        param_default("showOthers",     false);
        param_default("multiple",       null);

        var tmp = ["inputField", "displayArea", "button"];
        for (var i in tmp) {
            if (typeof params[tmp[i]] == "string") {
                params[tmp[i]] = document.getElementById(params[tmp[i]]);
            }
        }
        if (!(params.flat || params.multiple || params.inputField || params.displayArea || params.button)) {
            if (!suppressAlert) alert("Calendar.setup:\n  Nothing to setup (no fields found).  Please check your code");
            return false;
        }

        function onSelect(cal) {
            var p = cal.params;
            var update = (cal.dateClicked || p.electric);
            if (update && p.inputField) {
                p.inputField.value = cal.date.print(p.ifFormat);
                if (typeof p.inputField.onchange == "function")
                    p.inputField.onchange();
            }
            if (update && p.displayArea)
                p.displayArea.innerHTML = cal.date.print(p.daFormat);
            if (update && typeof p.onUpdate == "function")
                p.onUpdate(cal);
            if (update && p.flat) {
                if (typeof p.flatCallback == "function")
                    p.flatCallback(cal);
            }
            if (update && p.singleClick && cal.dateClicked)
                cal.callCloseHandler();
        };

        if (params.flat != null) {
            if (typeof params.flat == "string")
                params.flat = document.getElementById(params.flat);
            if (!params.flat) {
                if (!suppressAlert) alert("Calendar.setup:\n  Flat specified but can't find parent.");
                return false;
            }
            var cal = new Calendar(params.firstDay, params.date, params.onSelect || onSelect);
            cal.showsOtherMonths = params.showOthers;
            cal.showsTime = params.showsTime;
            cal.time24 = (params.timeFormat == "24");
            cal.params = params;
            cal.weekNumbers = params.weekNumbers;
            cal.setRange(params.range[0], params.range[1]);
            cal.setDateStatusHandler(params.dateStatusFunc);
            cal.getDateText = params.dateText;
            if (params.ifFormat) {
                cal.setDateFormat(params.ifFormat);
            }
            if (params.inputField && typeof params.inputField.value == "string") {
                cal.parseDate(params.inputField.value);
            }
            cal.create(params.flat);
            cal.show();
            return false;
        }

        var triggerEl = params.button || params.displayArea || params.inputField;
        triggerEl["on" + params.eventName] = function() {
            var dateEl = params.inputField || params.displayArea;
            var dateFmt = params.inputField ? params.ifFormat : params.daFormat;
            var mustCreate = false;
            var cal = window.calendar;
            if (dateEl)
                params.date = Date.parseDate(dateEl.value || dateEl.innerHTML, dateFmt);
            if (!(cal && params.cache)) {
                window.calendar = cal = new Calendar(params.firstDay,
                                     params.date,
                                     params.onSelect || onSelect,
                                     params.onClose || function(cal) { cal.hide(); });
                cal.showsTime = params.showsTime;
                cal.time24 = (params.timeFormat == "24");
                cal.weekNumbers = params.weekNumbers;
                mustCreate = true;
            } else {
                if (params.date)
                    cal.setDate(params.date);
                cal.hide();
            }
            if (params.multiple) {
                cal.multiple = {};
                for (var i = params.multiple.length; --i >= 0;) {
                    var d = params.multiple[i];
                    var ds = d.print("%Y%m%d");
                    cal.multiple[ds] = d;
                }
            }
            cal.showsOtherMonths = params.showOthers;
            cal.yearStep = params.step;
            cal.setRange(params.range[0], params.range[1]);
            cal.params = params;
            cal.setDateStatusHandler(params.dateStatusFunc);
            cal.getDateText = params.dateText;
            cal.setDateFormat(dateFmt);
            if (mustCreate)
                cal.create();
            cal.refresh();
            if (!params.position)
                cal.showAtElement(params.button || params.displayArea || params.inputField, params.align);
            else
                cal.showAt(params.position[0], params.position[1]);
            return false;
        };

        return cal;
    };
}// if (typeof(Calendar) != "undefined" && typeof(Calendar.setup) == "undefined")
