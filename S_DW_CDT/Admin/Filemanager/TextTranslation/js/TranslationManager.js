/* Represents a manager that handles actual translation */
var TranslationManager = function() {
    this.timeout = 5000;
    
    this._timedOut = false;
    this._timeoutID = -1;
}

/*
    Description: 
        Performs translation according to the given parameters 
               
    Available parameters:
        1. fromLanguage: language code of the source language.
        2. toLanguage: language code of the target language.
        3. text: text to translate.
        4. onSuccess: a callback which is fired when translation successes.
        5. onError: a callback which is fired when translation fails.
        6. onComplete: a callback which is fired when translation completes.
*/
TranslationManager.prototype.translate = function(params) {
    var fromLanguage = '', toLanguage = '', sourceText = '';
    var obj = this;

    if (params) {
        if (params.fromLanguage)
            fromLanguage = params.fromLanguage;

        if (params.toLanguage)
            toLanguage = params.toLanguage;

        if (params.text)
            sourceText = params.text;

        if (toLanguage.length > 0 && sourceText.length > 0) {

            this._setTimeout(function() {
                obj.evalCallback(params.onTimeout);
                obj.evalCallback(params.onComplete, { error: null });
            });

            google.language.translate(sourceText, fromLanguage, toLanguage, function(result) {
                if (!obj._timedOut) {
                    obj._clearTimeout();

                    if (result.error) {
                        obj.evalCallback(params.onError, { message: result.error.message });
                    } else {
                        obj.evalCallback(params.onSuccess, { translation: result.translation });
                    }

                    obj.evalCallback(params.onComplete, { error: result.error });
                }
            });
        } else {
            this.evalCallback(params.onComplete, { error: null });
        }
    }
}

/* 
    Description:
        Evaluates given callback (if it's a function) and passes it a given argument.
*/
TranslationManager.prototype.evalCallback = function(callback, arg) {
    if (typeof (callback) == 'function') {
        callback(arg);
    }
}

/*
    Description:
        Gets value indicating whether translation can be performed from the given language.
*/
TranslationManager.prototype.canTranslate = function(languageCode) {
    return google.language.isTranslatable(languageCode);
}

/*
    Description:
        Gets an array of language names for all supported languages.
*/
TranslationManager.prototype.get_languageNames = function() {
    var languages = null;
    var ret = [];

    languages = google.language.Languages;

    if (languages) {
        for (var lang in languages) {
            if (typeof (languages[lang]) == 'string') {
                ret[ret.length] = this.formatName(lang);
            }
        }
    }

    return ret;
}

/*
    Description:
        Gets an array of language codes (two-letter) for all supported languages.
*/
TranslationManager.prototype.get_languageCodes = function() {
    var languages = null;
    var ret = [];

    languages = google.language.Languages;

    if (languages) {
        for (var lang in languages) {
            if (typeof (languages[lang]) == 'string') {
                ret[ret.length] = languages[lang];
            }
        }
    }

    return ret;
}

/*
    Description:
        Converts a given language name to a human readable form.
*/
TranslationManager.prototype.formatName = function(languageName) {
    var ret = '';

    if (languageName) {
        ret = languageName;
        if (languageName.length > 1) {
            ret = ret.substr(0, 1).toUpperCase() + ret.substr(1, ret.length - 1).toLowerCase();
            ret = ret.replace(/_/g, ' ');
        }
    }

    return ret;
}

TranslationManager.prototype._setTimeout = function(onTimeout) {
    var obj = this;

    this._clearTimeout();
    
    this._timeoutID = setTimeout(function() {
        obj._timedOut = true;
        obj.evalCallback(onTimeout, null);
    }, this.timeout);

}

TranslationManager.prototype._clearTimeout = function() {
    this._timedOut = false;
    
    if (this._timeoutID > 0) {
        try {
            clearTimeout(this._timeoutID);
        } catch (ex) { }
    }
}
