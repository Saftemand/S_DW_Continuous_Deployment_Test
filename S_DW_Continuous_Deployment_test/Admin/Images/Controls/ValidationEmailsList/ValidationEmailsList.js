/* Namespace definition */
this._uniqueID = '';

Dynamicweb.Controls.PopUpWindow.prototype.showList = function (onComplete) {
    /// <summary>Loads additional users/groups that are not displayed by default into the list.</summary>
    /// <param name="params">Method parameters.</param>

    var self = this;
    var callback = onComplete || function () { }

    this._isBusy = true;

        Dynamicweb.Ajax.doPostBack({
            eventTarget: self.get_uniqueID(),
            eventArgument: 'Discover:',
            onComplete: function (transport) {
                self._isBusy = false;
                $('validationEmailDiv_container').innerHTML = transport.responseText;
                callback([]);
            }
        });
    }

Dynamicweb.Controls.PopUpWindow.prototype.saveEmail = function (onComplete, recipientId) {
    /// <summary>Loads additional users/groups that are not displayed by default into the list.</summary>
    /// <param name="params">Method parameters.</param>
    var emailAddress = $('emailInput_' + recipientId).value;
    var self = this;
    var callback = onComplete || function () { }

    this._isBusy = true;

    Dynamicweb.Ajax.doPostBack({
        eventTarget: self.get_uniqueID(),
        eventArgument: 'SaveEmail:' + emailAddress +",ID:"+recipientId,
        onComplete: function (transport) {
            self._isBusy = false;
            $('validationEmailDiv_container').innerHTML = transport.responseText;
            callback([]);
        }
    });
}

Dynamicweb.Controls.PopUpWindow.prototype.clearEmail = function (onComplete, recipientId) {
    /// <summary>Loads additional users/groups that are not displayed by default into the list.</summary>
    /// <param name="params">Method parameters.</param>
    var self = this;
    var callback = onComplete || function () { }

    this._isBusy = true;

    if ($('RecipientsExcluded')) {
        var excluded = $('RecipientsExcluded').value;
        if (excluded.indexOf(',') != -1 || excluded.length != 0 ) {
            excluded += "," + recipientId;
        } else if (excluded.length == 0) {
            excluded = recipientId;
        }
        $('RecipientsExcluded').value = excluded;
    }

    Dynamicweb.Ajax.doPostBack({
        eventTarget: self.get_uniqueID(),
        eventArgument: 'ClearEmail:' + recipientId,
        onComplete: function (transport) {
            self._isBusy = false;
            $('validationEmailDiv_container').innerHTML = transport.responseText;
            callback([]);
        }
    });
}

Dynamicweb.Controls.PopUpWindow.prototype.removePermission = function (onComplete, recipientId) {
    /// <summary>Loads additional users/groups that are not displayed by default into the list.</summary>
    /// <param name="params">Method parameters.</param>
    var self = this;
    var callback = onComplete || function () { }

    this._isBusy = true;

    if ($('RecipientsExcluded')) {
        var excluded = $('RecipientsExcluded').value;
        if (excluded.indexOf(',') != -1 || excluded.length != 0) {
            excluded += "," + recipientId;
        } else if (excluded.length == 0) {
            excluded = recipientId;
        }
        $('RecipientsExcluded').value = excluded;
    }

    Dynamicweb.Ajax.doPostBack({
        eventTarget: self.get_uniqueID(),
        eventArgument: 'RemovePermission:' + recipientId,
        onComplete: function (transport) {
            self._isBusy = false;
            $('validationEmailDiv_container').innerHTML = transport.responseText;
            callback([]);
        }
    });
}

Dynamicweb.Controls.PopUpWindow.prototype.get_uniqueID = function () {
    /// <summary>Gets the unique identifier of this control.</summary>

    return this._uniqueID || '';
}

Dynamicweb.Controls.PopUpWindow.prototype.set_uniqueID = function (value) {
    /// <summary>Sets the unique identifier of this control.</summary>
    /// <param name="value">Unique identifier of this control.</param>
    this._uniqueID = value;
}
