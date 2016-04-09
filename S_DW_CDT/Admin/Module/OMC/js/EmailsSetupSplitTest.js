/* ++++++ Registering namespace ++++++ */

if (typeof (OMC) == 'undefined') {
    var OMC = new Object();
}

/* ++++++ End: Registering namespace ++++++ */

OMC.EmailsSetupSplitTest = function () {
    /// <summary>Represents a report theme edit page.</summary>
    this._terminology = {};
    this._initialized = false;

}

OMC.EmailsSetupSplitTest.prototype.get_terminology = function () {
    /// <summary>Gets the terminology object that holds all localized strings.</summary>

    if (!this._terminology) {
        this._terminology = [];
    }

    return this._terminology;
}

OMC.EmailsSetupSplitTest.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>

    var self = this;

    if (!this._initialized) {
        this._initialized = true;
    }
}
