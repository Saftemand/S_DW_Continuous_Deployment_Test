/* Represents a translate window */
var TranslationController = function() {
    this.dependenciesLoaded = false;
    this.events = new EventsManager();

    /* Occurs after the object has been pre-loaded */
    this.events.registerEvent('preLoad');

    /* Occurs after the object has been loaded */
    this.events.registerEvent('load');

    /* Occurs before translation is performed */
    this.events.registerEvent('beforeTranslate');

    /* Occurs after translation is performed */
    this.events.registerEvent('afterTranslate');

    /* Occurs after translation has been submitted */
    this.events.registerEvent('apply');

    /* Occurs after translation has been canceled */
    this.events.registerEvent('cancel');

    /* Occurs after translation languages has been swapped */
    this.events.registerEvent('swap');
    
}

/* Registers a new event handler for 'preLoad' event */
TranslationController.prototype.add_preLoad = function(handler) {
    this.events.addHandler('preLoad', handler);
}

/* Registers a new event handler for 'load' event */
TranslationController.prototype.add_load = function(handler) {
    this.events.addHandler('load', handler);
}

/* Registers a new event handler for 'beforeTranslate' event */
TranslationController.prototype.add_beforeTranslate = function(handler) {
    this.events.addHandler('beforeTranslate', handler);
}

/* Registers a new event handler for 'afterTranslate' event */
TranslationController.prototype.add_afterTranslate = function(handler) {
    this.events.addHandler('afterTranslate', handler);
}

/* Registers a new event handler for 'apply' event */
TranslationController.prototype.add_apply = function(handler) {
    this.events.addHandler('apply', handler);
}

/* Registers a new event handler for 'cancel' event */
TranslationController.prototype.add_cancel = function(handler) {
    this.events.addHandler('cancel', handler);
}

/* Registers a new event handler for 'swap' event */
TranslationController.prototype.add_swap = function(handler) {
    this.events.addHandler('swap', handler);
}

/* Notifies all subscribers about specified event */
TranslationController.prototype.notify = function(eventName, args) {
    this.events.notify(eventName, this, args);
}

/* Performs "preload" phase */
TranslationController.prototype.preLoad = function() {
    var obj = this;
    
    google.load('language', '1');
    google.setOnLoadCallback(function() {
        obj.dependenciesLoaded = true;
    });

    this.notify('preLoad', null);
}

/* Performs "load" phase */
TranslationController.prototype.load = function() {
    var obj = this;
    
    this.set_isBusy(true);

    if (!this.dependenciesLoaded) {
        setTimeout(function() { obj.load(); }, 50);
    } else {
        setTimeout(function() { obj.loadInner(); }, 150);
    }
}

/* Performs "load" phase (actual loading) */
TranslationController.prototype.loadInner = function() {
    var obj = this;
    var toLang = 'da';

    this.manager = TranslationManager.getInstance();

    google.language.getBranding('divBranding');

    this._fillLanguageList('ddFrom', '', true);
    this._fillLanguageList('ddTo');

    this.set_languageFrom('');
    this.set_languageTo(toLang);

    this._event(window, 'resize', function() { obj._stretchTextFields(); });
    this._event(document.getElementById('ddFrom'), 'change', function() { obj._fromLanguageChanged(); });

    this._stretchTextFields();

    this.set_isBusy(false);
    this._set_swapIsEnabled(false);

    this.notify('load', null);
}

/* Gets window's "Busy" state */
TranslationController.prototype.get_isBusy = function() {
    var dd = document.getElementById('ddFrom');
    var ret = false;

    if (dd)
        ret = dd.disabled;

    return ret;
}

/* Sets window's "Busy" state */
TranslationController.prototype.set_isBusy = function(isBusy) {
    this._set_isEnabled(!isBusy);
}

TranslationController.prototype.apply = function() {
    this.notify('apply', null);
}

TranslationController.prototype.cancel = function() {
    this.notify('cancel', null);
    this.close();
}

TranslationController.prototype.swap = function() {
    var ddFrom = this.get_languageFrom();
    var ddTo = this.get_languageTo();

    this.set_languageFrom(ddTo);
    this.set_languageTo(ddFrom);

    this.notify('swap', null);
}

TranslationController.prototype.close = function() {
    window.open('', '_parent', '');
    window.close();
}

/* Translates current content */
TranslationController.prototype.translate = function() {
    var obj = this;
    var fromLanguage = null, toLanguage = null, text = null;

    this.set_isBusy(true);

    fromLanguage = this.get_languageFrom();
    toLanguage = this.get_languageTo();
    text = this.get_textFrom();

    this.notify('beforeTranslate', {
        fromLanguage: fromLanguage,
        toLanguage: toLanguage,
        text: text
    });

    this.manager.translate({
        fromLanguage: fromLanguage,
        toLanguage: toLanguage,
        text: text.replace(/\n/gi, '<br />'),
        onSuccess: function(result) {
            obj.set_textTo(result.translation);
        },
        onError: function(result) {
            alert(obj._formatError(result.message));
        },
        onComplete: function(result) {
            obj.set_isBusy(false);
            obj.notify('afterTranslate', { error: result.error });
        },
        onTimeout: function() {
            alert(obj._formatError('Operation timed out'));
        }
    });
}

TranslationController.prototype._formatError = function(message) {
    var ret = message;
    var msg = document.getElementById('TranslationFailed');
    
    if(msg) {
        ret = msg.innerHTML + '\n\n"' + message + '"';
    }
    
    return ret;
}

TranslationController.prototype._stretchTextFields = function() {
    this._stretchField('txTextFrom');
    this._stretchField('txTextTo');
}

TranslationController.prototype._stretchField = function(id) {
    var obj = $(id);
    var bottom = $('divBottom');

    //var ribbonHeight = 114;
    //var headingHeight = 24;
    
    if (obj) {
        obj.style.height = (bottom.cumulativeOffset().top -
            obj.cumulativeOffset().top + (bottom.getHeight() - 4)) + 'px';

        /*obj.style.height = (document.body.clientHeight - ribbonHeight -
        headingHeight - 7) + 'px';*/
    }
}

/* Gets language code for 'From' language */
TranslationController.prototype.get_languageFrom = function() {
    return this._getLanguage('ddFrom');
}

/* Sets language code for 'From' language */
TranslationController.prototype.set_languageFrom = function(languageCode) {
    this._setLanguage('ddFrom', languageCode);
}

/* Gets language code for 'To' language */
TranslationController.prototype.get_languageTo = function() {
    return this._getLanguage('ddTo');
}

/* Sets language code for 'To' language */
TranslationController.prototype.set_languageTo = function(languageCode) {
    this._setLanguage('ddTo', languageCode);
}

/* Gets the text from the 'Source' text-area */
TranslationController.prototype.get_textTo = function() {
    return this._getText('txTextTo');
}

/* Sets the text for the 'Source' text-area */
TranslationController.prototype.set_textTo = function(text) {
    this._setText('txTextTo', text);
}

/* Gets the text from the 'Translation' text-area */
TranslationController.prototype.get_textFrom = function() {
    return this._getText('txTextFrom');
}

/* Sets the text for the 'Translation' text-area */
TranslationController.prototype.set_textFrom = function(text) {
    this._setText('txTextFrom', text);
}

/* Strips all HTML tags from the given text */
TranslationController.prototype.stripHTML = function(html) {
    var ret = html;

    if (ret) {
        ret = this._markLineBreaks(ret);
        
        ret = ret.replace(/(<([^>]+)>)/gi, '');
        ret = ret.replace(/&nbsp;/gi, ' ');
        ret = ret.replace(/(\s){1,}/g, ' ');

        ret = this._replaceLineBreakMarks(ret);
    }

    return ret;
}

/* Gets value indicating whether Internet Explorer is used */
TranslationController.prototype.isIE = function() {
    return typeof (document.attachEvent) != 'undefined';
}

/* End: public members */

/* Private members */

/* Switches all form controls (buttons, text-areas, drop-down lists) to the given "enabled" state */
TranslationController.prototype._set_isEnabled = function(isEnabled) {
    var controlIDs = [ 'ddFrom', 'ddTo', 'txTextFrom', 'txTextTo' ];
    var ribbonButtonIDs = [ 'cmdApply', 'cmdCancel', 'cmdTranslate', 'cmdSwap' ];
    var control = null;

    for (var i = 0; i < controlIDs.length; i++) {
        control = document.getElementById(controlIDs[i]);
        if (control) {
            control.disabled = !isEnabled;
        }
    }

    for (var i = 0; i < ribbonButtonIDs.length; i++) {
        if (isEnabled)
            Ribbon.enableButton(ribbonButtonIDs[i]);
        else
            Ribbon.disableButton(ribbonButtonIDs[i]);
    }
}

/* Sets the 'Enabled' state of the 'Swap' button */
TranslationController.prototype._set_swapIsEnabled = function(isEnabled) {
    if (isEnabled) {
        Ribbon.enableButton('cmdSwap');
    } else {
        Ribbon.disableButton('cmdSwap');
    }
}

/* Gets the currently selected language code from the given drop-down list */
TranslationController.prototype._getLanguage = function(id) {
    var dd = document.getElementById(id);
    var ret = '';

    if (dd) {
        for (var i = 0; i < dd.options.length; i++) {
            if (dd.options[i].selected) {
                ret = dd.options[i].value;
                break;
            }
        }
    }

    return ret;
}

/* Sets the selected language code in the given drop-down list */
TranslationController.prototype._setLanguage = function(id, languageCode) {
    var dd = document.getElementById(id);

    if (dd) {
        for (var i = 0; i < dd.options.length; i++) {
            dd.options[i].selected = (dd.options[i].value == languageCode);
        }
    }
}

/* Gets the text from the specified text-area */
TranslationController.prototype._getText = function(id) {
    var ret = '';
    var tx = document.getElementById(id);
    var hiddenText = document.getElementById(id + 'Hidden');

    if (hiddenText && tx) {
        if (typeof (hiddenText.innerText) != 'undefined')
            hiddenText.innerText = tx.value;
        else if (typeof (hiddenText.textContent) != 'undefined')
            hiddenText.textContent = tx.value;

        ret = hiddenText.innerHTML;

        ret = this._markLineBreaks(ret);
        ret = this._replaceLineBreakMarks(ret, '\n');
    }

    return ret;
}

/* Sets the text of the specified text-area */
TranslationController.prototype._setText = function(id, text) {
    var tx = document.getElementById(id);
    var hiddenText = document.getElementById(id + 'Hidden');

    if (hiddenText && tx) {
        text = this.stripHTML(text);
        
        hiddenText.innerHTML = text;

        if (typeof (hiddenText.innerText) != 'undefined')
            tx.value = hiddenText.innerText;
        else if (typeof (hiddenText.textContent) != 'undefined')
            tx.value = hiddenText.textContent;
    }
}

/*
Fills given drop-down list with all supported languages and selectes specified language.
Also the '[Auto]' (value - empty string) option can be inserted.
*/
TranslationController.prototype._fillLanguageList = function(id, selectedLanguage, includeAuto) {
    var ddItem = null;
    var dd = document.getElementById(id);
    var languageNames = this.manager.get_languageNames();
    var languageCodes = this.manager.get_languageCodes();
    var autoDetectLabel = document.getElementById('AutoDetectLabel').innerHTML;

    if (dd) {
        if (includeAuto)
            this._addDropDownItem(dd, '[' + autoDetectLabel + ']', '', (selectedLanguage == ''));

        for (var i = 0; i < languageNames.length; i++) {
            if (languageNames[i].toLowerCase() != 'unknown') {
                this._addDropDownItem(dd, languageNames[i],
                    languageCodes[i], (languageCodes[i] == selectedLanguage));
            }
        }
    }
}

/* Creates new drop-down list item with specified parameters and adds it to the given drop-down list */
TranslationController.prototype._addDropDownItem = function(dd, label, value, isSelected) {
    var ddItem = document.createElement('option');

    ddItem.value = value;
    ddItem.innerHTML = label;
    dd.selected = isSelected;

    dd.appendChild(ddItem);
}

/* Marks all line breaks with '#break#' sequence. */
TranslationController.prototype._markLineBreaks = function(text) {
    var ret = text;

    if (ret) {
        ret = ret.replace(/<br>/gi, '#break#');
        ret = ret.replace(/<br \/>/gi, '#break#');
        ret = ret.replace(/<\/p>/gi, '#break#');
        ret = ret.replace(/\n/gi, '#break#');
    }

    return ret;
}

/* Replases all line break marks with a corresponding line breaks according to the browser used. */
TranslationController.prototype._replaceLineBreakMarks = function(text, replacement) {
    var ret = text;
    var rep = replacement;

    if (!rep) {
        rep = (this.isIE() ? '<br />' : '\n');
    }

    if (ret) {
        ret = ret.replace(/#break#/gi, rep);
    }

    return ret;
}

/* Fixes like breaks */
TranslationController.prototype._fixLineBreaks = function(text) {
    var ret = text;

    if (ret) {
        ret = this._markLineBreaks(ret);
        ret = this._replaceLineBreakMarks(ret);
    }

    return ret;
}

/* Registers new event */
TranslationController.prototype._event = function(obj, name, f) {
    if (obj) {
        if (window.attachEvent) {
            obj.attachEvent('on' + name, f);
        } else if (window.addEventListener) {
            obj.addEventListener(name, f, false);
        }
    }
}

/* Fired when 'From' language has been changed */
TranslationController.prototype._fromLanguageChanged = function() {
    var val = this.get_languageFrom();
    this._set_swapIsEnabled(val.length > 0);
}

/* End:Private members */
