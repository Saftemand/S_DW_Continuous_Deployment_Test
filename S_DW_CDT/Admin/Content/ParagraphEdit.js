var pageID = 0;

var areaID = top.left != null ? top.left.areaid : top.areaid;

var loaded = false;
var templatesInitialized = false;

/* Indicates whether to wait for module settings to be retrieved
before to process saving of the paragraph */
var __wait_module_settings = false;

window.onresize = resize;

var btnNavigation = false;
window.onbeforeunload = function (evt) {
    if (!btnNavigation && paragraphCancelWarn) {
        return paragraphCancelWarnText;
    }
    btnNavigation = false;
}

function getClientHeight(height) {

	var h = document.documentElement.clientHeight - $("myribbon").getHeight() - $("formTable").getHeight() - $("breadcrumb").getHeight();
	if (h < 0) h = 0;
	if (h >= 20) h -= 20;
	return h;
}
function myInit(PageID) {
	pageID = PageID;
	if (typeof editor != 'undefined' && typeof editor.init != 'undefined') {
		editor.init();
	}
	setHeight();
	loaded = true;
	$('ParagraphHeader').focus();
}

function SaveOk() {
	if (!loaded) {
		return false;
	}

	if (typeof editor != 'undefined' && typeof editor.save != 'undefined') {
		editor.save();
	}

	if (document.getElementById("ParagraphHeader").value.length < 1) {
		alert($('mSpecifyName').innerHTML);

		Ribbon.radioButton('cmdViewText', 'cmdViewText', 'GroupView');
		ParagraphView.switchMode(ParagraphView.mode.text);

		$('ParagraphHeader').focus();

		return false;
	}

    //itembased paragraph name
	if (Dynamicweb.Paragraph.ItemEdit.get_current().get_itemType() && $('ParagraphHeader2') && $('ParagraphHeader2').value.length < 1) {
	    alert($('mSpecifyName').innerHTML);
	    $('ParagraphHeader2').focus();
	    return false;
	}

	if (imageRequireAltAndTitle && !imageSettingsValid()) {

		dialog.show("ImageSettingsDialog");
		alert($('imageSettingsValidationMessage').value);

		return false;
	}
	if ($('ParagraphModule__Frame').contentWindow.paragraphEvents != null
        && $('ParagraphModule__Frame').contentWindow.paragraphEvents != 'undefined') {
		return $('ParagraphModule__Frame').contentWindow.paragraphEvents.validateInvoke();
	}
	return true;
}

function updateBreadCrumb() {
	if (document.getElementById("ParagraphHeader").value.length > 0) {
		document.getElementById("BreadcrumbParagraphHeader").innerText = document.getElementById("ParagraphHeader").value;
	}
}

var GlobalUrl = '';
function ShowGlobals() {
	dialog.show('GlobalsDialog');
	document.getElementById("GlobalsFrame").src = GlobalUrl;
}

function ShowVersions() {
	dialog.show('VersionsDialog');
	document.getElementById("VersionsFrame").src = VersionUrl;
}

function ShowLanguages() {
	dialog.show('LanguageDialog');
	document.getElementById("LanguageFrame").src = LanguageUrl;
}

function compareToMaster() {
	var loc = "ParagraphCompare.aspx?ID=" + document.getElementById("ID").value + "&PageID=" + parent.pageID + "&MasterID=" + document.getElementById("MasterID").value;
		window.open(loc, "", "width=855,height=550,toolbar=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");

}

function SaveAndClose(caller) {
    Save(true, caller);
}

function Save(close, caller) {
	if (!SaveOk()) {
		__cancelOverlay = true;
		return false;
	}

	/* Deactivating saving buttons */
	toggleSavingButtons(false);
	btnNavigation = true;

	/* Retrieving module settings first, then - saving paragraph */
	retrieveModuleSettings(function () {
	    document.getElementById("onSave").value = close ? "Close" : "Nothing"
		if (caller == 'newsletterpage') {
		    document.getElementById("caller").value = "newsletterpage";
		}
	    // Fire event to handle saving
		window.document.fire("General:DocumentOnSave");

		var form = document.getElementById("ParagraphForm");
		form.target = "SaveFrame";
		if(typeof form.onsubmit=='function')
		{
            form.onsubmit();
		};
		form.submit();

		/* Activating saving buttons back */
		if (!close) {
		    toggleSavingButtons(true);
		    btnNavigation = false;
		}
	});
}

/* Retrieves module settings from the 'Edit module' iframe */
function retrieveModuleSettings(onRetrieved) {
    var frame = $('ParagraphModule__Frame'),
        itemEdit = Dynamicweb.Paragraph.ItemEdit.get_current(),
        getSettings = function () {
            if (typeof (frame.contentWindow['submitForm']) == 'function' &&
            frame.contentWindow.document.getElementById('innerContent')) {
                __wait_module_settings = true;

                /* Submitting module settings */
                frame.contentWindow['submitForm']();

                /* Waiting for settings to be received by hosting window */
                waitModule(onRetrieved);
            } else {
                if (typeof (onRetrieved) == 'function')
                    onRetrieved();
            }
        };

    if (itemEdit.get_itemType()) {
	    itemEdit.validate(function (result) {
	        if (result.isValid && typeof (onRetrieved) == 'function') {
	            var beadCrumb = $("BreadcrumbParagraphHeader");
	            if ($("ParagraphHeader2") != null) {
	                if (beadCrumb != null)
	                    beadCrumb.innerText = $("ParagraphHeader2").value;
	                $("footerParagraphHeader").innerText = $("ParagraphHeader2").value;
	            } else {
	                if (beadCrumb != null)
	                    beadCrumb.innerText = $("itemParagraphTitle").value;
	                $("footerParagraphHeader").innerText = $("itemParagraphTitle").value;
	            }

	            getSettings();
	        }
	        else {
	            toggleSavingButtons(true);
	            btnNavigation = false;
	            Ribbon.radioButton('cmdViewItem', 'cmdViewItem', 'GroupView');
	            ParagraphView.switchMode(ParagraphView.mode.item);
	        }
	    });
	}
	else if (frame) {
	    getSettings();
	}
}

/* Toggles saving buttons activity state */
function toggleSavingButtons(enable) {
	if (enable) {
		Ribbon.enableButton('Save');
		Ribbon.enableButton('SaveAndClose');
	} else {
		Ribbon.disableButton('Save');
		Ribbon.disableButton('SaveAndClose');
	}
}

/* Waits for the module settings to be received from the 'Edit module' iframe */
function waitModule(onComplete) {
	/* Still needs to wait ? */
	if (__wait_module_settings) {
		setTimeout(function () { waitModule(onComplete); }, 50);
	} else {
		/* Settings retrieved - executing 'onComplete' callback */
		if (typeof (onComplete) == 'function')
			onComplete();
	}
}

function showPage() {
	if (!loaded) {
		return false;
	}
	//window.open("/Default.aspx?ID=" + pageID + "&Purge=True");
	window.open(document.getElementById("previewUrl").value);
}

function pageResizePreview() {
    window.open("/Admin/Content/PreviewResizable.aspx?original=" + encodeURIComponent(document.getElementById("previewUrl").value), "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no");
}

function Cancel(caller) {
	if (!loaded) {
		return false;
    }
    btnNavigation = true;
    if (caller == 'newsletterpage' ) {
        window.parent.dialog.hide('editParagraphDialog');
        window.parent.parent.document.getElementById('ContentTabDiv').src = '/Admin/Content/ParagraphList.aspx?PageID='+ pageID +'&mode=browse&caller=NewsletterPage';
    } else if (document.location.search.indexOf('openedFromFrontend=True') > -1) {
			close();
		} else {
        location = "ParagraphList.aspx?mode=viewparagraphs&PageID=" + pageID + "&unlock=" + document.getElementById('ID').value;
    }
}

function setHeight() {
	var h = (document.documentElement.clientHeight - $("myribbon").getHeight() - $("formTable").getHeight() - $("breadcrumb").getHeight());
	var pText = $('ParagraphText___Frame');
	var pModule = $('ParagraphModule__Frame');

	if (h >= 65) {
		if (pText)
			pText.setStyle({ height: (h - 65) + 'px' });
		if (pModule)
			pModule.setStyle({ height: (h - 65) + 'px' });
	}
}

function resize() {
	//alert(loaded);
	if (loaded) {
		setHeight();
	}
}

/*function onTemplateSelected(templateID) {
$('ParagraphTemplateID').value = templateID;

tmplScrollable_scrollable.hidePopUp();
__preview_large_show = false;
ParagraphTemplateZoom.hide();
}*/

function onTemplateSelected(sender, args) {
	$('ParagraphTemplateID').value = args.selectedTemplateID;
}



/* ++++++ Represents paragraph view type ++++++ */

var ParagraphView = new Object();

/* View mode - paragraph text or module settings */
ParagraphView.mode = { text: 0, module: 1, item: 2 };

/* Current view mode */
ParagraphView.currentMode = ParagraphView.mode.text;

/* Switches to the specified view mode */
ParagraphView.switchMode = function (mode) {
    var areas = ['textContent', 'moduleContent', 'itemContent'];
    var ribbonButtons = ['cmdViewText', 'cmdViewModule', 'cmdViewItem'];

    /* Current mode has been changed ? */
    if (ParagraphView.currentMode != mode) {
        for (var i = 0; i < areas.length; i++) {
            if (mode == i) {
                $(areas[i]).show();
                document.getElementById(ribbonButtons[i]).className += " active";
            }
            else {
                $(areas[i]).hide();
                if (document.getElementById(ribbonButtons[i])) {
                    document.getElementById(ribbonButtons[i]).className = "ribbon-section-button";
                }
            }
        }

        ParagraphView.currentMode = mode;

        setTimeout(function () { setHeight(); }, 15);

        /* Loading module settings if current mode is 'Module settings' */
        if (mode == ParagraphView.mode.module)
            ParagraphModule.loadModule();
    }
}

/* ++++++ Handles module-specified operations on the paragraph ++++++ */

var ParagraphModule = new Object();

/* Loads module settings */
ParagraphModule.loadModule = function () {
	var frame = null;
	var paragraphID = parseInt($('ID').value);
	pageID = parseInt($('ParagraphPageID') ? $('ParagraphPageID').value : pageID);

	if ($('moduleContent').getStyle('display') != 'none') {
		frame = $('ParagraphModule__Frame');

		/* Settings hasn't been loaded yet */
		if (frame.readAttribute('src').length == 0) {
			ParagraphModule.toggleLoading(true);

			/* Loading settings into the iframe */
			frame.writeAttribute('src', '/Admin/Content/ParagraphEditModule.aspx?ID=' + paragraphID +
                '&PageID=' + pageID + '&AreaID=' + areaID +
			    '&ShowToolbar=False&OnLoadCallback=ParagraphModule_toggleLoading' +
                '&OnCompleteCallback=ParagraphModule_onSettingsChanged&OnRemoveCallback=ParagraphModule_onModuleRemoved');
		}
	}
}

/* Applies module settings to the paragraph */
ParagraphModule.onSettingsChanged = function (pid, moduleName, moduleSettings) {
	$('ParagraphModuleSystemName').value = moduleName;
	$('ParagraphModuleSettings').value = moduleSettings;

	/* Reset waiting flag (indicates that we can process with other operations) */
	__wait_module_settings = false;
}

/* Removes module from the paragraph */
ParagraphModule.onModuleRemoved = function (pid) {
	ParagraphModule.onSettingsChanged(pid, '', '');
}

/* Toggles 'Loading' image visibility */
ParagraphModule.toggleLoading = function (show) {
	if ($('moduleContent').getStyle('display') != 'none') {
		if (show) {
			$('imgProcessing').show();
			$('modueInnerContent').hide();
		} else {
			$('imgProcessing').hide();
			$('modueInnerContent').show();

			ParagraphModule.initializeSettingsPage();
		}
	}
}

/* Initializes module settings page when it's loaded */
ParagraphModule.initializeSettingsPage = function () {
    var frame = $('ParagraphModule__Frame');
    var wnd = null;
    var content = null;

    if (frame) {
        wnd = frame.contentWindow;

        try {
            $(wnd.document.body).setStyle({
                border: '0px solid black',
                backgroundColor: '#ffffff',
                marginTop: '0px'
            });
        } catch (ex) { }

        content = wnd.document.getElementById('mainContent');

        if (!content)
            content = wnd.document.getElementById('innerContent');

        if (content) {
            try {
                $(content).setStyle({
                    border: '0px solid black'
                });
            } catch (ex) { }
        }
    }
}

/* ++++++ Event wrappers for module settings page ++++++ */

/* Fires when module settings page is loaded */
function ParagraphModule_toggleLoading() {
	ParagraphModule.toggleLoading(false);
}

/* Fires when module settings has been retrieved */
function ParagraphModule_onSettingsChanged(pid, moduleName, moduleSettings) {
	ParagraphModule.onSettingsChanged(pid, moduleName, moduleSettings);

}

/* Fires when module has been removed */
function ParagraphModule_onModuleRemoved() {
	ParagraphModule.onModuleRemoved();
	return false;
}

function openEditPermissions() {
	if ($F('ID') == "0") {
		alert(paragraphNotSavedText);
		return false;
	}
	document.getElementById("ParagraphPermissionDialogIFrame").src = "/Admin/Content/ParagraphPermissionEdit.aspx?ParagraphID=" + $F('ID') + "&DialogID=ParagraphPermissionDialog";
	dialog.show("ParagraphPermissionDialog");
}

function imageSettingsValid() {

	var images = document.getElementById("FM_ParagraphImage");
	if (images && images[images.selectedIndex].value == "") {
		return true;
	}

	var caption = $('ParagraphImageCaption');
	var alt = $('ParagraphImageMouseOver');

	return caption.value.length > 0 && alt.value.length > 0;
}

function saveImageSettings() {
	if (!imageSettingsValid()) {
		alert($('imageSettingsValidationMessage').value);
	}
	else {
		dialog.hide("ImageSettingsDialog");
	}
}


function setMasterValue(strFieldName, NewValue) {
	var form = document.getElementById("ParagraphForm");
	if (strFieldName == "ParagraphImage" && NewValue.indexOf("/") > 0) {
		selObj = form.elements[strFieldName];
		selObj.options.length = selObj.options.length + 1;
		selObj.options[selObj.options.length - 1].value = NewValue;
		selObj.options[selObj.options.length - 1].text = NewValue;
		selObj.selectedIndex = selObj.options.length - 1;
	}
	else {
		if (strFieldName == "ParagraphText") {
			var TextDiv = document.getElementById(strFieldName);
			TextDiv.value = NewValue;
			ParagraphText___Frame.document.location.reload();
			if (typeof editor != 'undefined' && typeof editor.init != 'undefined') {
				editor.init();
			}
		} else {
			form.elements[strFieldName].value = NewValue;
		}
	}
}

var ParagraphEdit = {
    Marketing: null,

     openContentRestrictionDialog: function () {
         this.Marketing.openSettings('ContentRestriction', { data: { ItemType: 'Paragraph', ItemID: $F('ID')} });
     },

     openProfileDynamicsDialog: function () {
         this.Marketing.openSettings('ProfileDynamics', { data: { ItemType: 'Paragraph', ItemID: $F('ID')} });
     }
}

 if (typeof (Dynamicweb) == 'undefined') {
     var Dynamicweb = new Object();
 }

 if (typeof (Dynamicweb.Paragraph) == 'undefined') {
     Dynamicweb.Paragraph = new Object();
 }

 Dynamicweb.Paragraph.ItemEdit = function () {
     this._terminology = {};
     this._cancelUrl = '';
     this._paragraph = '';
     this._itemType = '';
     this._validation = null;
     this._validationPopup = null;
 }

 Dynamicweb.Paragraph.ItemEdit._instance = null;

 Dynamicweb.Paragraph.ItemEdit.get_current = function () {
     if (!Dynamicweb.Paragraph.ItemEdit._instance) {
         Dynamicweb.Paragraph.ItemEdit._instance = new Dynamicweb.Paragraph.ItemEdit();
     }

     return Dynamicweb.Paragraph.ItemEdit._instance;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.get_validation = function () {
     if (!this._validation) {
         this._validation = new Dynamicweb.Validation.ValidationManager();
     }

     return this._validation;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.get_terminology = function () {
     return this._terminology;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.get_validationPopup = function () {
     if (this._validationPopup && typeof (this._validationPopup) == 'string') {
         this._validationPopup = eval(this._validationPopup);
     }

     return this._validationPopup;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.set_validationPopup = function (value) {
     this._validationPopup = value;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.get_paragraph = function () {
     return this._paragraph;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.set_paragraph = function (value) {
     this._paragraph = value;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.get_itemType = function () {
     return this._itemType;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.set_itemType = function (value) {
     this._itemType = value;
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.initialize = function () {
     ParagraphView.switchMode(ParagraphView.mode.item);

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
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.validate = function (onComplete) {
     if (Dynamicweb.Items.GroupVisibilityRule) {
         Dynamicweb.Items.GroupVisibilityRule.get_current().filterValidators(this.get_validation()).beginValidate(onComplete);
     } else {
         this.get_validation().beginValidate(onComplete);
     };
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.showWait = function () {
     new overlay('PleaseWait').show();
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.openItemType = function () {
     dialog.show("ChangeItemTypeDialog");
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.changeItemType = function () {
     var systemName;
     var moduleConfirm = "";
     
     if ($("ParagraphModuleSystemName").value != "") {
         moduleConfirm = " " + $('moduleConfirmText').value;
     }
     systemName = $("ItemTypeSelect").value;
     if (this.get_itemType() != systemName) {
         if (confirm($('changeItemTypeConfirm').value + moduleConfirm || !this.get_itemType())) {
             this.showWait();
             $("cmd").value = "changeItemType";
             $("ParagraphForm").submit();
         }
         else {
             return;
         }
     }

     dialog.hide("ChangeItemTypeDialog");
 }

 Dynamicweb.Paragraph.ItemEdit.prototype.cancelChangeItemType = function () {
     var ItemTypeSelect = null;

     if (this.get_itemType())
         ItemTypeSelect = "ItemTypeSelect" + this.get_itemType();
     else
         ItemTypeSelect = "ItemTypeSelectdwrichselectitem";

     ItemTypeSelect = $(ItemTypeSelect);
     if (ItemTypeSelect) RichSelect.setselected(ItemTypeSelect.down("a"), "ItemTypeSelect");

     dialog.hide("ChangeItemTypeDialog");
 }
