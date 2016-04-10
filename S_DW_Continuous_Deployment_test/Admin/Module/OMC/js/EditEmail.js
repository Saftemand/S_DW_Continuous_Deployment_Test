/* ++++++ Registering namespace ++++++ */

if(typeof (OMC) == 'undefined') {
    var OMC = new Object();
}

/* ++++++ End: Registering namespace ++++++ */

OMC.EditEmail = function () {
    /// <summary>Represents a profile edit page.</summary>
    this._initialized = false;
    this._newsletterID = 0;
    this._pageID = 0;
    this._variantpageID = 0;
    this._terminology = {};
    this._emailSent = false;
    this._emailFolderId = 0;
    this._emailTopFolderId = 0;
    this._accessUserProvider = false;
    this._emailSaved = false;
    this._isTemplate = false;
}

OMC.EditEmail.prototype.get_terminology = function () {
    /// <summary>Gets the terminology object that holds all localized strings.</summary>

    if (!this._terminology) {
        this._terminology = {};
    }

    return this._terminology;
}

OMC.EditEmail.prototype.set_isTemplate = function (value) {
    this._isTemplate = value;
}

OMC.EditEmail.prototype.set_emailTopFolderId = function (value) {
    this._emailTopFolderId = value;
}

OMC.EditEmail.prototype.set_emailFolderId = function (value) {
    this._emailFolderId = value;
}

OMC.EditEmail.prototype.set_newsletterId = function (value) {
     this._newsletterID = value;
}

OMC.EditEmail.prototype.set_pageId = function (value) {
    this._pageID = value;
}

OMC.EditEmail.prototype.set_variantpageId = function (value) {
    this._variantpageID = value;
}

OMC.EditEmail.prototype.set_emailSent = function (value) {
     this._emailSent = value;
 }

 OMC.EditEmail.prototype.set_accessUserProvider = function (value) {
     this._accessUserProvider = value;
 }

 OMC.EditEmail.prototype.set_emailSaved = function (value) {
     this._emailSaved = value;
 }

 OMC.EditEmail.prototype.get_emailSaved = function () {
     return this._emailSaved;
 }

OMC.EditEmail.prototype.initialize = function () {
    /// <summary>Initializes the object.</summary>
    var name = null;
    var self = this;
    var binder = null;

    if (!this._initialized) {
        setTimeout(function () {
            try {
                $('txSubject').focus();
            } catch (ex) { }
        }, 200);

        this._initialized = true;
    }

    parent.OMC.MasterPage.get_current().add_ready(function (sender, args) {
        self.safeCall(function () {
            var buttons = parent.Ribbon;
            if (self._newsletterID == undefined || self._newsletterID == 0) {
                buttons.disableButton('cmdStart_split_test');
            }
            if ($('cbCreateSplitTestVariation').checked){
                buttons.enableButton('cmdStart_split_test');
            }
            if (!document.getElementById("lmEmailPage").value) {
                buttons.disableButton('cmdSend_Mail');
                buttons.disableButton('cmdEdit_content');
                buttons.disableButton('cmdPreview');
                buttons.disableButton('cmdTemplate');
            }

            if (self._emailSent) {
                buttons.disableButton('cmdSend_Mail');
                buttons.disableButton('cmdStart_split_test');
                buttons.disableButton('cmdEdit_content');
                buttons.disableButton('cmdSave');
                buttons.disableButton('cmdSave_and_close');
                buttons.disableButton('cmdSave_2');
                buttons.disableButton('cmdSave_and_close_2');
                buttons.disableButton('cmdRecipient_provider');
            }

            if (buttons.buttonIsEnabled('cmdSend_Mail') && $('cbCreateSplitTestVariation').checked) {
                buttons.disableButton('cmdSend_Mail');
            }

            if (buttons.buttonIsEnabled('cmdValidate_e-mails') && !self._accessUserProvider) {
                buttons.disableButton('cmdValidate_e-mails');
            }

            if (self._isTemplate) {
                buttons.disableButton('cmdSend_Mail');
                buttons.disableButton('cmdStart_split_test');
                buttons.disableButton('cmdSave_as_template');
                $('cbCreateSplitTestVariation').disable();
             }
         });
    });
}

OMC.EditEmail.prototype.PreviewEmail = function () {
    dialog.setTitle('preview', '<%=Backend.Translate.JsTranslate("Preview Mail") %>: ');
    dialog.show('PreviewMailDialog');
}

OMC.EditEmail.prototype.SheduledEmail = function () {
    var self = this;
    this.validate(function (isValid) {
        if (isValid) {
            var form = self._getPostbackForm();
            if (form) {
                /* Submitting a form to a hidden frame */
                form.target = 'frmPostback';
            }
            dialog.setTitle('preview', '<%=Backend.Translate.JsTranslate("Scheduling") %>: ');
            dialog.show('SchedulingDialog');
        } 
    });
}

OMC.EditEmail.prototype.ScheduledEmailHide = function () {
    dialog.hide('SchedulingDialog');
}

OMC.EditEmail.prototype.SendMail = function () {

    var newsletterName = "";
    var self = this;
    this.validate(function (isValid)
    {
        if(isValid)
        {
            newsletterName = $('txSubject').value;

            var confirmMsg = self.get_terminology()['ConfirmationMsgSend'];
            confirmMsg = confirmMsg.replace('%%', newsletterName);

            if(confirm(confirmMsg))
            {
                var o = new overlay('saveForward');
                o.message(self.get_terminology()['PrepareRecipients']);
                o.show();
                var form = self._getPostbackForm();
                if(form)
                {
                    /* Submitting a form to a hidden frame */
                    form.target = 'frmPostback';
                }
                document.getElementById('cmdSend').click();
            }
        }
    });
}

OMC.EditEmail.prototype.validate = function (onComplete, isValidateVariation) {
    /// <summary>Validates the form.</summary>
    /// <param name="onComplete">Callback that is executed when the form is validated.</param>

    var url = '';
    var inputField = null;
    var self = this;
    var callback = onComplete || function () { }
    var isAlertShown = false;
    var pattern = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;

    for (var i = 0; i < $$('input.std').length; i++) {
        inputField = $$('input.std')[i];

        if (inputField.name.include('txSenderName') && !inputField.value) {
            alert(this.get_terminology()['EmptySenderName']);

            try {
                inputField.focus();
            } catch (ex) { }
            isAlertShown = true;
            callback(false);
            break;
        } else if (inputField.name.include('txSenderEmail') && !inputField.value) {
            alert(this.get_terminology()['EmptySendeEmail']);

            try {
                inputField.focus();
            } catch (ex) { }
            isAlertShown = true;
            callback(false);
            break;
        } else if (inputField.name.include('txSenderEmail') && !(inputField.value).match(pattern)) {
            alert(this.get_terminology()['IncorrectSendeEmail']);

            try {
                inputField.focus();
            } catch (ex) { }
            isAlertShown = true;
            callback(false);
            break;
        } else if (inputField.name.include('txSubject') && !inputField.value) {
            alert(this.get_terminology()['EmptySubject']);

            try {
                inputField.focus();
            } catch (ex) { }
            isAlertShown = true;
            callback(false);
            break;
        } else if (inputField.name.include('lmEmailPage') && !inputField.value) {
            alert(this.get_terminology()['EmptyEmailPage']);

            try {
                inputField.focus();
            } catch (ex) { }
            isAlertShown = true;
            callback(false);
            break;
        } 

        if(isValidateVariation){
            if (inputField.name.include('txtVariantSenderName') && !inputField.value) {
                alert(this.get_terminology()['EmptyVariationSenderName']);

                try {
                    inputField.focus();
                } catch (ex) { }
                isAlertShown = true;
                callback(false);
                break;
            } else if (inputField.name.include('txtVariantSenderEmail') && !inputField.value) {
                alert(this.get_terminology()['EmptyVariationSenderEmail']);

                try {
                    inputField.focus();
                } catch (ex) { }
                isAlertShown = true;
                callback(false);
                break;
            } else if (inputField.name.include('txtVariantSenderEmail') && !(inputField.value).match(pattern)) {
                alert(this.get_terminology()['IncorrectVariationSenderEmail']);

                try {
                    inputField.focus();
                } catch (ex) { }
                isAlertShown = true;
                callback(false);
                break;
            } else if (inputField.name.include('txtVariantSubject') && !inputField.value) {
                alert(this.get_terminology()['EmptyVariationSubject']);

                try {
                    inputField.focus();
                } catch (ex) { }
                isAlertShown = true;
                callback(false);
                break;
            } else if (inputField.name.include('Link_lmVariantEmailPage') && !inputField.value) {
                alert(this.get_terminology()['EmptyVariationEmailPage']);

                try {
                    inputField.focus();
                } catch (ex) { }
                isAlertShown = true;
                callback(false);
                break;
            }
        }
    }

    //if (!isAlertShown && $('RecipientSelectorhidden') != null && !$('RecipientSelectorhidden').value) {
    //    alert(this.get_terminology()['EmptyRecipientsList']);
    //    callback(false);
    //} else
        if (!isAlertShown) {
            callback(true);
        }
}

OMC.EditEmail.prototype.validateSubject = function (onComplete, isValidateVariation) {
    /// <summary>Validates the form.</summary>
    /// <param name="onComplete">Callback that is executed when the form is validated.</param>

    var self = this;
    var callback = onComplete || function () { }
    var pattern = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;

    if ($('txSubject') && !$('txSubject').value) {
        alert(this.get_terminology()['EmptySubject']);

        try {
            $('txSubject').focus();
        } catch (ex) { }

        callback(false);
    }else {
        callback(true);
    }
}

OMC.EditEmail.prototype.saveWithValidation= function (closeWindow) {

    var self = this;
    if (document.getElementById('EmailScheduled').value == 'true') {
        if (!confirm(this.get_terminology()['ConfirmScheduledEmail']))
            return;
    }

    /* First, disabling the "Save" button indicating that the operating is being performed */
    parent.Ribbon.disableButton('cmdSave');

    /* Validating input */
    this.validate(function (isValid) {
        if (isValid) {

            /* Show spinning wheel*/
            var o = new overlay('saveForward');
            o.show();

            var form = self._getPostbackForm();
            document.getElementById('CloseOnSave').value = (!!closeWindow).toString();

            if (form) {
                /* Submitting a form to a hidden frame */
                form.target = 'frmPostback';
            }

            document.getElementById('cmdSubmit').click();
        }
        parent.Ribbon.enableButton('cmdSave');
    });
}

OMC.EditEmail.prototype.saveAsDraft = function (closeWindow) {
        var self = this;
        parent.Ribbon.disableButton('cmdSave');
        /* Validating input */
        this.validateSubject(function (isValid) {
            if (isValid) {

                /* Show spinning wheel*/
                var o = new overlay('saveForward');
                o.show();

                var form = self._getPostbackForm();
                document.getElementById('CloseOnSave').value = (!!closeWindow).toString();

                if (form) {
                    /* Submitting a form to a hidden frame */
                    form.target = 'frmPostback';
                }
                document.getElementById('cmdSubmit').click();
        }
        parent.Ribbon.enableButton('cmdSave');
    });
}

OMC.EditEmail.prototype.saveAsTemplate = function () {
    var self = this;
    parent.Ribbon.disableButton('cmdSave_as_template');
    /* Validating input */
    this.validateSubject(function (isValid) {
        if (isValid) {

            /* Show spinning wheel*/
            var o = new overlay('saveForward');
            o.show();

            var form = self._getPostbackForm();
            document.getElementById('CloseOnSave').value = 'False';

            if (form) {
                /* Submitting a form to a hidden frame */
                form.target = 'frmPostback';
            }
            document.getElementById('cmdSaveAsTemplate').click();
        }
        parent.Ribbon.enableButton('cmdSave_as_template');
    });
}

OMC.EditEmail.prototype.splitTestExpired = function (newsletterId, name) {
    alert(this.get_terminology()['SplitTestExpired']);
    try {
        inputField.focus();
    } catch (ex) { }

    parent.OMC.MasterPage.get_current().showDialog("/Admin/Module/OMC/Emails/SetupSplitTest.aspx?newsletterID=" + newsletterId + "&showAsSettings=true&name=" + name, 515, 580, { title: 'Start split test', hideCancelButton: true });
}

OMC.EditEmail.prototype.CheckLinkedPage = function (closeWindow, linkedPageId) {

    var self = this;
    var form = self._getPostbackForm();

    var buttons = parent.Ribbon;
    if (!buttons.buttonIsEnabled('cmdSend_Mail') && !$('cbCreateSplitTestVariation').checked) { buttons.enableButton('cmdSend_Mail'); }
    if (!buttons.buttonIsEnabled('cmdEdit_content')) { buttons.enableButton('cmdEdit_content'); }
    if (!buttons.buttonIsEnabled('cmdPreview') && self.get_emailSaved()) { buttons.enableButton('cmdPreview'); }
    if (!buttons.buttonIsEnabled('cmdTemplate')) { buttons.enableButton('cmdTemplate'); }

    if (!buttons.buttonIsEnabled('cmdSave_as_template')) {
        buttons.disableButton('cmdSend_Mail');
        buttons.disableButton('cmdStart_split_test');
        buttons.disableButton('cmdSave_as_template');
        $('cbCreateSplitTestVariation').disable();
    }

    document.getElementById('CloseOnSave').value = (!!closeWindow).toString();

    if (form) {
        /* Submitting a form to a hidden frame */
        form.target = 'frmPostback';
    }

    if (linkedPageId == 'lmVariantEmailPage') {
        document.getElementById('cmdCheckVariationLinkedPage').click();
    } else if (linkedPageId == 'lmEmailPage') {
        self.CheckPrimaryDomain();
        document.getElementById('cmdCheckLinkedPage').click();
    }
}

OMC.EditEmail.prototype.CheckPrimaryDomain = function () {

    var pageId = parseInt($('lmEmailPage').value.split("=")[1]);
    var selectedDomain = $('DomainSelector')[$('DomainSelector').selectedIndex].value;

    if (pageId > 0) {
        new Ajax.Request("EditEmail.aspx?CMD=CheckPrimaryDomain&SelectedDomain=" + selectedDomain + "&PageId=" + pageId, {
            onSuccess: function (response) {
                var div = $('divDomainErrorContainer');
                var row = $('rowDomainErrorContainer');
                if (response.responseText.length > 0) {
                    div.innerHTML = response.responseText;
                    row.show();
                } else {
                    row.hide();
                }
            }
        });
    }
}

OMC.EditEmail.prototype._getPostbackForm = function() {
    /// <summary>Returns a postback form.</summary>

    var ret = null;
    var form = null;
    var forms = document.getElementsByTagName('form');

    if(forms && forms.length) {
        if(forms.length == 1) {
            ret = forms[0];
        } else {
            for(var i = 0; i < forms.length; i++) {
                form = $(forms[i]);

                if(form.readAttribute('action') == 'post' && form.readAttribute('name') == 'aspnetForm') {
                    ret = forms[i];
                    break;
                }
            }
        }
    }

    return ret;
}

OMC.EditEmail.prototype.onAfterSave = function(response) {
    /// <summary>Occurs when the postback frame gets loaded.</summary>
    /// <param name="response">Response.</param>

    var self = this;
    var form = this._getPostbackForm();
    var nodeItemID = '/EmailMarketing/top-sys:' + response.TopFolderID;

    if(form) {
        /* Clearing the target, just in case */
        form.target = '';
    }

    var self = parent.OMC.MasterPage.get_current();

    if (response) {
        if (response.Saved == true) {
            self.reload('/EmailMarketing');

            if (response.Close == true) {
                self.reload(nodeItemID, null);
                if (response.FolderID && response.FolderID != -1 && response.FolderID != -2) {
                    self.navigate('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + response.FolderID + '&topFolderId=' + response.TopFolderID);
                } else if (this._emailFolderId == -1 || response.FolderID == -1) {
                    self.navigate('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + this._emailFolderId + "&AllEmails=true" + '&topFolderId=' + response.TopFolderID);
                } else if (this._emailFolderId == -2 || response.FolderID == -2 || response.TopFolderID == -2) {
                    self.navigate('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + this._emailFolderId + "&AllEmailTemplates=true" + '&topFolderId=' + response.TopFolderID);
                } else {
                    self.navigate('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + this._emailFolderId + '&topFolderId=' + response.TopFolderID);
                }
            }
            else
                self.reloadNewsletters(response.ID, nodeItemID);
        }
    }

    if (!parent.Ribbon.buttonIsEnabled('cmdPreview') && response.HasMessage) { parent.Ribbon.enableButton('cmdPreview'); }

    /* Changing the text back shortly */
    setTimeout(function() {
        parent.Ribbon.enableButton('cmdSave');
    }, 3000);
}

OMC.EditEmail.prototype.ReloadAfterSend = function (response) {
    var self = parent.OMC.MasterPage.get_current();
    var nodeItemID = '/EmailMarketing/top-sys:' + response.TopFolderID;

    if (response) {
        if (response.Saved == true) {
            self.reload('/EmailMarketing');

            if (response.Close == true) {
                self.reload(nodeItemID, null);
                if (self._emailFolderId === -1) {
                    self.navigate('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + self._emailFolderId + "&AllEmails=true" + '&topFolderId=' + response.TopFolderID);
                } else if (this._emailFolderId == -2) {
                    self.navigate('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + self._emailFolderId + "&AllEmailTemplates=true" + '&topFolderId=' + response.TopFolderID);
                } else {
                    self.navigate('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + self._emailFolderId + '&topFolderId=' + response.TopFolderID);
                }
            }
            else
                self.reloadNewsletters(response.ID, nodeItemID);
        }
    }

    /* Changing the text back shortly */
    setTimeout(function () {
        "";
    }, 3000);

}

OMC.EditEmail.prototype.EditContent = function(Name) {
    var actionStrUrl = "InternalEditContent";
    var resize = "yes";
    var AreaID = null;
    var pageID = document.getElementById("lmEmailPage").value;

    if (isNaN(pageID)) {
        pageID = document.getElementById("lmEmailPage").value.split('=')[1]
    }

    if(top.left) {
        AreaID = top.left.AreaID;
    }
    else if(window.opener && window.opener.top.left) {
        AreaID = window.opener.top.left.AreaID;
    }

    movepageWindow = window.open("/Admin/Menu.aspx?Action=" + actionStrUrl + "&Caller=editor&id=" + pageID + "&AreaID=" + AreaID + "&showparagraphs=on", "_new", "resizable=" + resize + ",scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=1024,height=600,top=155,left=202");
}

OMC.EditEmail.prototype.saveAndClose = function () {
    /// <summary>Saves the profile and closes the form.</summary>

    this.saveAsDraft(true);
}

OMC.EditEmail.prototype.cancel = function(ReturnId)
{
    /// <summary>Discards any changes and closes the form.</summary>
    if(ReturnId != null)
        parent.OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Emails/Statistics.aspx?newsletterId=' + ReturnId);
    else if(this._emailFolderId === -1)
        parent.OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + this._emailFolderId + "&AllEmails=true" + '&topFolderId=' + this._emailTopFolderId);
    else if(this._emailFolderId == -2)
        parent.OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + this._emailFolderId + "&AllEmailTemplates=true" + '&topFolderId=' + this._emailTopFolderId);
    else
        parent.OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Emails/EmailsList.aspx?folderId=' + this._emailFolderId + '&topFolderId=' + this._emailTopFolderId);
}

OMC.EditEmail.prototype.cancelSchedule = function() {
    var self = this;

    var confirmMsg = self.get_terminology()['ConfirmationCancelSchedule'];

    if(confirm(confirmMsg)) {
        var form = self._getPostbackForm();

        if(form)
            form.target = 'frmPostback';

        document.getElementById('cmdCancelSchedule').click();
    }
}

OMC.EditEmail.prototype.splitTestSetup = function (showAsSettings, newsletterId, name, clientInstance, recipientsCount) {
    var self = this;
    this.validate(function (isValid) {
        if (isValid) {
            if (!showAsSettings) {
                parent.OMC.MasterPage.get_current().showDialog("/Admin/Module/OMC/Emails/SetupSplitTest.aspx?newsletterID=" + newsletterId + "&name=" + name + "&clientInstance=" + clientInstance + "&recipientsCount=" + recipientsCount, 584, 580, { title: 'Setup split test', hideCancelButton: true });
            } else {
                parent.OMC.MasterPage.get_current().showDialog("/Admin/Module/OMC/Emails/SetupSplitTest.aspx?newsletterID=" + newsletterId + "&showAsSettings=true&name=" + name + "&clientInstance=" + clientInstance + "&recipientsCount=" + recipientsCount, 584, 580, { title: 'Settings', hideCancelButton: true });
            }
        }
    }, true);
}

OMC.EditEmail.prototype.ShowAttachments = function() {
    dialog.show('CMAttachDialog');
}

OMC.EditEmail.prototype.showTemplate = function () {

    dialog.show('EmailTemplateDialog');
}

OMC.EditEmail.prototype.showEncoding = function () {

    dialog.show('EmailEncodingDialog');
}

OMC.EditEmail.prototype.showTracking = function () {

    dialog.show('EmailTrackingDialog');
}

OMC.EditEmail.prototype.showRecipientProvider = function() {

    dialog.show('RecipientProviderDialog');
}

OMC.EditEmail.prototype.showDeliveryProvider = function () {

    dialog.show('DeliveryProviderDialog');
}

OMC.EditEmail.prototype.showUnsubscribe = function () {

    dialog.show('UnsubscribeDialog');
}

OMC.EditEmail.prototype.showContentSettings = function () {
    dialog.show('ContentSettingsDialog');
}

OMC.EditEmail.prototype.showRecipientSettings = function () {
    dialog.show('RecipientSettingsDialog');
}

OMC.EditEmail.prototype.showEngagementIndex = function () {
    var variationCheckbox = $('cbCreateSplitTestVariation');
    if (variationCheckbox) {
        if (variationCheckbox.checked) {
            parent.OMC.MasterPage.get_current().showDialog('/Admin/Module/OMC/Emails/EngagementDetails.aspx?newsletterId=' + this._newsletterID + '&pageId=' + this._pageID + '&variantpageId=' + this._variantpageID, 588, 590, { title: 'Engagement index', hideCancelButton: true });
        } else {
            parent.OMC.MasterPage.get_current().showDialog('/Admin/Module/OMC/Emails/EngagementDetails.aspx?newsletterId=' + this._newsletterID + '&pageId=' + this._pageID + '&variantpageId=' + this._variantpageID, 588, 410, { title: 'Engagement index', hideCancelButton: true });
        }
    }
 }

OMC.EditEmail.prototype.safeCall = function(code) {
    /// <summary>Executes the given code with a fallback in case of the exception - the execution will be postponed.</summary>
    /// <param name="code">Code to execute.</param>

    this._safeCallRecursive(code, 10, 1);
}

OMC.EditEmail.prototype.validateEmails = function (onComplete)
{
    //    ValidationEmailsList_wnd.add_hide(OnRecipientsPopupClosed);
    //    ValidationEmailsList_wnd.show();
    //    ValidationEmailsList_wnd.showList();
        var self = this;
        var callback = onComplete || function () { }

        this._isBusy = true;

        Dynamicweb.Ajax.doPostBack({
            eventTarget: "<%=UniqueID%>",
            eventArgument: 'Discover:',
            onComplete: function (transport)
            {
                parent.OMC.MasterPage.get_current().showDialog(
                    '/Admin/Module/OMC/Emails/ValidateEmail.aspx',
                    800,
                    420,
                    { title: self.get_terminology()['NonValidEmailsAddress'], hideCancelButton: true },
                    OnRecipientsPopupClosed);
            }
        });

    //    var recipients = document.getElementById('RecipientSelectorhidden').value;
    //    InvalidEmailsListDialog_wnd.set_contentUrl('/Admin/Module/OMC/Emails/NonValidEmailsList.aspx?recipients=' + recipients + '&emailId=' + this._newsletterID);
    //    InvalidEmailsListDialog_wnd.show();
}

OMC.EditEmail.prototype.showSaveAsTemplate = function () {
    dialog.show('dlgSaveAsTemplate');
}

OMC.EditEmail.prototype._safeCallRecursive = function(code, maxIterations, currentIteration) {
    /// <summary>Executes the given code with a fallback in case of the exception - the execution will be postponed.</summary>
    /// <param name="code">Code to execute.</param>
    /// <param name="maxIterations">The maximum number of iterations.</param>
    /// <param name="currentIteration">Current iteration number.</param>
    /// <private />

    var self = this;

    if(code) {
        try {
            if(typeof (code) == 'function') {
                code.apply(window);
            } else if(typeof (code) == 'string') {
                eval(code);
            }
        } catch(ex) {
            if(currentIteration < maxIterations) {
                setTimeout(function() {
                    self._safeCallRecursive(code, maxIterations, currentIteration + 1);
                }, 50);
            }
        }
    }
}
