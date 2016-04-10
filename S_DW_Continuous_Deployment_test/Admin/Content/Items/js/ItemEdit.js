if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = new Object();
}

Dynamicweb.Items.ItemEdit = function () {
    this._terminology = {};
    this._cancelUrl = '';
    this._page = {};
    this._item = {};
    this._validation = null;
    this._validationPopup = null;
}

Dynamicweb.Items.ItemEdit._instance = null;

Dynamicweb.Items.ItemEdit.get_current = function () {
    if (!Dynamicweb.Items.ItemEdit._instance) {
        Dynamicweb.Items.ItemEdit._instance = new Dynamicweb.Items.ItemEdit();
    }

    return Dynamicweb.Items.ItemEdit._instance;
}

Dynamicweb.Items.ItemEdit.prototype.get_validation = function () {
    if (!this._validation) {
        this._validation = new Dynamicweb.Validation.ValidationManager();
    }

    return this._validation;
}

Dynamicweb.Items.ItemEdit.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Items.ItemEdit.prototype.get_validationPopup = function () {
    if (this._validationPopup && typeof (this._validationPopup) == 'string') {
        this._validationPopup = eval(this._validationPopup);
    }

    return this._validationPopup;
}

Dynamicweb.Items.ItemEdit.prototype.set_validationPopup = function (value) {
    this._validationPopup = value;
}

Dynamicweb.Items.ItemEdit.prototype.get_cancelUrl = function () {
    return this._cancelUrl;
}

Dynamicweb.Items.ItemEdit.prototype.set_cancelUrl = function (value) {
    this._cancelUrl = value;
}

Dynamicweb.Items.ItemEdit.prototype.get_page = function () {
    return this._page;
}

Dynamicweb.Items.ItemEdit.prototype.set_page = function (value) {
    this._page = value;
}

Dynamicweb.Items.ItemEdit.prototype.get_item = function () {
    return this._item;
}

Dynamicweb.Items.ItemEdit.prototype.set_item = function (value) {
    this._item = value;
}

Dynamicweb.Items.ItemEdit.prototype.initialize = function () {
    setTimeout(function () {
        if (typeof (Dynamicweb.Controls) != 'undefined' && typeof (Dynamicweb.Controls.OMC) != 'undefined' && typeof (Dynamicweb.Controls.OMC.DateSelector) != 'undefined') {
            Dynamicweb.Controls.OMC.DateSelector.Global.set_offset({ top: -138, left: Prototype.Browser.IE ? 1 : 0 }); // Since the content area is fixed to screen at 138px from top (Edititem.css)
        }
    }, 500);

    var buttons = $$('.item-edit-field-group-button-collapse');
    for (var i = 0; i < buttons.length; i++) {
        Event.observe(buttons[i], 'click', function (e) {
            var elm = this;
            var collapsedContent = elm.up().next('.item-edit-field-group-content');
            collapsedContent.toggleClassName('collapsed');
            if (!collapsedContent.hasClassName('collapsed') && Dynamicweb.Controls.StretchedContainer) {
                Dynamicweb.Controls.StretchedContainer.stretchAll();
                Dynamicweb.Controls.StretchedContainer.Cache.updatePreviousDocumentSize();
            }
        });
    }

    var div = $$('.item-type-container');
    if (div.length > 0) {
        div[0].up().setStyle({ paddingLeft: '0px' });
    }
}

Dynamicweb.Items.ItemEdit.prototype.showItem = function () {
    window.open('/Default.aspx?ID=' + this.get_page().id + '&Purge=True', 'ItemWindow');
}

Dynamicweb.Items.ItemEdit.prototype.newSubPage = function () {
    this.showWait();

    location = '/Admin/Content/PageEdit.aspx?ParentPageID=' + this.get_page().id + '&AreaID=' + this.get_page().areaId;
}

Dynamicweb.Items.ItemEdit.prototype.pageProperties = function () {
    this.showWait();

    location = '/Admin/Content/PageEdit.aspx?ID=' + this.get_page().id;
}

Dynamicweb.Items.ItemEdit.prototype.deletePage = function () {
    top.left.deletepage(this.get_page().id);
}

Dynamicweb.Items.ItemEdit.prototype.setPagePublished = function (state) {
    if (!state || !state.length) state = 'published';

    new Ajax.Request('/Admin/Content/ParagraphList.aspx?cmd=publish&state=' + state + '&PageID=' + this.get_page().id, {
        method: 'get'
    });

    if (top.left) {
        top.left.UpdateMenuEntry(this.get_page().parentId);
        top.left.MakeBoldMenuEntry(this.get_page().id);
    }
}

Dynamicweb.Items.ItemEdit.prototype.report = function (name) {
    dialog.show('ReportsDialog');

    document.getElementById('ReportsFrame').src = '/Admin/Content/Reports/Page.aspx?Report=' + name + '&PageID=' + this.get_page().id;
}

Dynamicweb.Items.ItemEdit.prototype.pageMetadata = function () {
    dialog.show('MetaDialog');
}

Dynamicweb.Items.ItemEdit.prototype.saveAsTemplate = function () {
    dialog.show("SaveAsTemplateDialog");
}

Dynamicweb.Items.ItemEdit.prototype.SaveAsTemplateOk = function () {
    var isTemplate = "true";
    if (document.getElementById("isTemplate")) {
        isTemplate = document.getElementById("isTemplate").checked.toString();
    }
    location = '/Admin/Content/Items/Editing/ItemEdit.aspx?PageID=' + this.get_page().id + '&ItemID' + this.get_item().id +
        '&cmd=saveastemplate&TemplateName=' + encodeURI(document.getElementById("TemplateName").value) + '&TemplateDescription=' + encodeURI(document.getElementById("TemplateDescription").value + "&isTemplate=" + isTemplate);
}

Dynamicweb.Items.ItemEdit.prototype.SaveAsTemplateCancel = function () {
    dialog.hide("SaveAsTemplateDialog");
}

Dynamicweb.Items.ItemEdit.prototype.showValidationResults = function () {
    this.get_validationPopup().set_contentUrl('/Admin/Content/PageValidate.aspx?ID=' + this.get_page().id);
    this.get_validationPopup().show();
}

Dynamicweb.Items.ItemEdit.prototype.validate = function (onComplete) {
    Dynamicweb.Items.GroupVisibilityRule.get_current().filterValidators(this.get_validation()).beginValidate(onComplete);
}

Dynamicweb.Items.ItemEdit.prototype.save = function (close) {
    var self = this;
    self.showWait();

    this.validate(function (result) {
        if (result.isValid) {
            // Fire event to handle saving
            window.document.fire("General:DocumentOnSave");

            $('hClose').value = (!!close).toString();
            var form = $("MainForm");
            if (typeof form.onsubmit == 'function') {
                 form.onsubmit();
            };
            form.submit();
        }
        new overlay('PleaseWait').hide();
    });
}

Dynamicweb.Items.ItemEdit.prototype.saveAndClose = function () {
    this.save(true);
}

Dynamicweb.Items.ItemEdit.prototype.cancel = function () {
    location.href = this.get_cancelUrl();
}

Dynamicweb.Items.ItemEdit.prototype.showWait = function () {
    new overlay('PleaseWait').show();
}

Dynamicweb.Items.ItemEdit.prototype.masterComparePage = function (masterid, languageid) {
    window.open("/Admin/Content/PageCompare.aspx?lang=True&original=/Default.aspx?ID=" + masterid + "&draft=/Default.aspx?ID=" + languageid);
}

Dynamicweb.Items.ItemEdit.prototype.pageMetadataClose = function () {
    HideCounter();

    dialog.hide('MetaDialog');
}

Dynamicweb.Items.ItemEdit.prototype.pageMetadataSave = function () {
    var keywords = encodeURIComponent(document.getElementById('PageKeywords').value);
    var title = encodeURIComponent(document.getElementById('PageDublincoreTitle').value);
    var description = encodeURIComponent(document.getElementById('PageDescription').value);

    dialog.hide('MetaDialog');

    location = '/Admin/Content/Items/Editing/ItemEdit.aspx?PageID=' + this.get_page().id + '&ItemID' + this.get_item().id + 
        '&cmd=SaveMeta&PageMetaTitle=' + title + '&PageMetaKeywords=' + keywords + '&PageMetaDescription=' + description;
}


Dynamicweb.Items.ItemEdit.prototype.switchToParagraphs = function () {
    location = '/Admin/Content/ParagraphList.aspx?PageID=' + this.get_page().id + '&mode=viewParagraphs';
}

Dynamicweb.Items.ItemEdit.prototype.openFrontendEditing = function () {
    window.open("/Admin/Content/FrontendEditing.aspx?PageID=" + this.get_page().id);
}

function toggleValidationInProgress(show) { /* Legacy declaration */ }

/* Version control */

Dynamicweb.Items.VersionControl = function () {
    this._hasUnpublishedContent = false;
    this._page = {};
    this._terminology = {};
}

Dynamicweb.Items.VersionControl._instance = null;

Dynamicweb.Items.VersionControl.get_current = function () {
    if (!Dynamicweb.Items.VersionControl._instance) {
        Dynamicweb.Items.VersionControl._instance = new Dynamicweb.Items.VersionControl();
    }

    return Dynamicweb.Items.VersionControl._instance;
}

Dynamicweb.Items.VersionControl.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Items.VersionControl.prototype.get_page = function () {
    return this._page;
}

Dynamicweb.Items.VersionControl.prototype.set_page = function (value) {
    this._page = value;
}

Dynamicweb.Items.VersionControl.prototype.useDraft = function () {
    if (this._hasUnpublishedContent) {
        dialog.show("QuitDraftDialog");
    }
    else {
        this.toggleDraft();
    }
}

Dynamicweb.Items.VersionControl.prototype.toggleDraft = function () {
    location = '/Admin/Content/Items/Editing/ItemEdit.aspx?cmd=ToggleDraft&PageID=' + this.get_page().id;
}

Dynamicweb.Items.VersionControl.prototype.quitDraftCancel = function () {
    dialog.hide("QuitDraftDialog");
    Ribbon.checkBox("cmdUseDraft");
}

Dynamicweb.Items.VersionControl.prototype.quitDraftOk = function () {
    if (document.getElementById("QuitDraftPublish").checked) {
        this.startWorkflowCmd(true, "ToggleDraft");
    }
    else if (document.getElementById("QuitDraftDiscard").checked) {
        this.discardChangesAndToggleDraft();
    }
}

Dynamicweb.Items.VersionControl.prototype.discardChangesAndToggleDraft = function () {
    location = '/Admin/Content/Items/Editing/ItemEdit.aspx?cmd=discardChangesAndToggleDraft&PageID=' + this.get_page().id;
}

Dynamicweb.Items.VersionControl.prototype.previewPage = function () {
    var previewUrl = "/Default.aspx?ID=" + this.get_page().id + "&Preview=" + this.get_page().id;
    window.open(previewUrl);
}

Dynamicweb.Items.VersionControl.prototype.previewComparePage = function (theDate) {
    var originalUrl = "/Default.aspx?ID=" + this.get_page().id; 
    var draftUrl = "/Default.aspx?ID=" + this.get_page().id + "&Preview=" + this.get_page().id; 
    // Disable frontend editing
    originalUrl = this.addFrontendEditingStateToUrl(originalUrl);
    draftUrl = this.addFrontendEditingStateToUrl(draftUrl);

    if (!theDate) {
        window.open("/Admin/Content/PageCompare.aspx?PageID=" + this.get_page().id + "&original=" + encodeURIComponent(originalUrl) + "&draft=" + encodeURIComponent(draftUrl));
    }
    else {
        window.open("/Admin/Content/PageCompare.aspx?PageID=" + this.get_page().id + "&VersionCompare=True&Date=" + encodeURIComponent(theDate) + "&original=" + encodeURIComponent(originalUrl) + "&draft=" + encodeURIComponent(draftUrl + "&ts=" + theDate));
    }
}

Dynamicweb.Items.VersionControl.prototype.addFrontendEditingStateToUrl = function (url, state) {
    state || (state = 'disable');
    if (url) {
        url = url.replace(/[?&]FrontendEditingState=[a-z]+/gi, '');
        url += (url.indexOf('?') > -1 ? '&' : '?') + 'FrontendEditingState=' + encodeURIComponent(state);
    }
    return url;
}

Dynamicweb.Items.VersionControl.prototype.startWorkflow = function (publish) {
    this.startWorkflowCmd(publish, "");
}

Dynamicweb.Items.VersionControl.prototype.startWorkflowCmd = function (publish, cmd) {
    location = '/Admin/Module/Workflow/WorkflowApprove.aspx?VCP=v2&cmd=' + cmd + '&PageID=' + this.get_page().id + '&publish=' + publish;
}

Dynamicweb.Items.VersionControl.prototype.discardChanges = function () {
    if (confirm(this.get_terminology()['ConfirmDiscard'])) {
        location = '/Admin/Content/Items/Editing/ItemEdit.aspx?cmd=discardchanges&PageID=' + this.get_page().id;
    }
}

Dynamicweb.Items.VersionControl.prototype.previewBydateShow = function () {
    dialog.show('PreviewByDateDialog');
}

Dynamicweb.Items.VersionControl.prototype.previewBydate = function (theDate) {
    var previewUrl = "/Default.aspx?ID=" + this.get_page().id + "&Preview=" + this.get_page().id;
    if (!theDate) {
        theDate = Date.parseDate($("DateSelector1_calendar").value, '%Y-%m-%d %H:%M:%S');
        theDate = theDate.getTime() + (theDate.getTimezoneOffset() * 60 * 1000) * -1;
    }
    window.open(previewUrl + "&ts=" + theDate);
}

Dynamicweb.Items.VersionControl.prototype.ShowVersions = function () {
    dialog.show('VersionsDialog');
}

// Called from ParagraphVersions.aspx
function viewByDate(date) {
    Dynamicweb.Items.VersionControl.get_current().previewBydate(date);
}

// Called from ParagraphVersions.aspx
function CompareByDate(date) {
    Dynamicweb.Items.VersionControl.get_current().previewComparePage(date);
}