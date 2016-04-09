var pageID = 0;
var pageParentID = 0;
var areaID = 0;
var AllowParagraphOperations = true;

var ShowParagraphSortingConfirmation = false;
var ParagraphSortingWarningMsg = '';

if (!Dynamicweb) {
    Dynamicweb = {};
}

if (!Dynamicweb.ParagraphList) {
    Dynamicweb.ParagraphList = {};
}

Dynamicweb.ParagraphList.Translations = {};

if (top.left) {
	areaID = top.left.areaid;
}

if (parent.AreaID) {
    areaID = parent.AreaID;
}

function init(PageID) {
    pageID = PageID;

	if (top.left) {
		top.left.MakeBoldMenuEntry(pageID);
	}
	if (document.getElementById("AllowParagraphOperations").value == "false") {
		AllowParagraphOperations = false;
	}
	pageParentID = document.getElementById("PageParentID").value;
	InitParagraphList();
	InitModuleList();
	LayoutList();
	//validatePage(); //Disabled to optimize paragraphlist load.
}

function insertParagraphBefore() {
    insertParagraph(ContextMenu.callingID, "before");
}

function insertParagraphAfter() {
    insertParagraph(ContextMenu.callingID, "after");
}

function getParagraphContainer(paragraphID) {
    var container = '',
        paragraph,
        criteria = paragraphID.toString();

    if (criteria.indexOf("Paragraph_") == -1) {
        criteria = "Paragraph_" + criteria;
    }

    paragraph = $$('ul.paragraph-container li.paragraph[id="' + criteria + '"]')[0];

    if (paragraph) {
        container = paragraph.parentElement.readAttribute('id').replace('Container_', '');
    }

    return container;
}

// Executed after context-menu is shown
function initializeContextMenu(paragraphID, menu) {
	var globalIDs = $('GlobalIDs');
	var cmdDetachGlobal = $(menu.menuElement).select('span[id^="cmdDetachGlobal"]');

	// retrieving a 'Detach global element' button from the current context menu object.
	if (cmdDetachGlobal && cmdDetachGlobal.length > 0) {
		cmdDetachGlobal = $(cmdDetachGlobal[0]);

		// current paragraph is a global element - showing the button, otherwise - hiding it.
		if (globalIDs && globalIDs.value.indexOf(paragraphID + ',') >= 0) {
			cmdDetachGlobal.show();
		} else {
			cmdDetachGlobal.hide();
		}
	}
}

function suggest() {
	dialog.show("MetaDialog");
	if (document.getElementById('SuggestedTitleB')) {
		document.getElementById('PageDublincoreTitle').value = document.getElementById('SuggestedTitleB').innerHTML;
	}
	if (document.getElementById('SuggestedKeywordsB')) {
		document.getElementById('PageKeywords').value = document.getElementById('SuggestedKeywordsB').innerHTML;
	}
}

function suggestSave() {
	dialog.hide("MetaDialog");
	var title = encodeURI(document.getElementById('PageDublincoreTitle').value);
	var keywords = encodeURI(document.getElementById('PageKeywords').value);
	var description = encodeURI(document.getElementById('PageDescription').value);
	location = '/Admin/Content/ParagraphList.aspx?PageID=' + pageID + '&cmd=SaveMeta&PageMetaTitle=' + title + '&PageMetaKeywords=' + keywords + '&PageMetaDescription=' + description;
}

function ShowVersions() {
	dialog.show('VersionsDialog');
	document.getElementById("VersionsFrame").src = VersionUrl;
}

function report(report) {
	//window.open("Reports/Page.aspx", '_blank', 'resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=823,height=450,top=155,left=202');
	dialog.show("ReportsDialog");
	document.getElementById("ReportsFrame").src = "/Admin/Content/Reports/Page.aspx?Report=" + report + "&PageID=" + pageID;
}

function insertModule() {
	dialog.show("insertModuleDialog");
}

// Detaches specified global element from its original source.
function detachGlobalElement(paragraphID) {
	if (!AllowParagraphOperations) { return false }
	location = '/Admin/Content/ParagraphList.aspx?cmd=DetachGlobal&DetachGlobal=' + paragraphID + '&PageID=' + pageID;
}

function addFrontendEditingStateToUrl(url, state) {
	state || (state = 'disable');
	if (url) {
		url = url.replace(/[?&]FrontendEditingState=[a-z]+/gi, '');
		url += (url.indexOf('?') > -1 ? '&' : '?') + 'FrontendEditingState='+encodeURIComponent(state);
	}
	return url;
}

function openFrontendEditing() {
	var url = "/Admin/Content/FrontendEditing.aspx?PageID=" + pageID;
	url = addFrontendEditingStateToUrl(url, 'edit');
	window.open(url);
}

function showPage() {
	var showUrl = document.getElementById("showUrl").value;
	window.open(showUrl);
}

function previewPage() {
	var previewUrl = document.getElementById("previewUrl").value;
	window.open(previewUrl);
}

function previewComparePage() {
	var originalUrl = document.getElementById("showUrl").value;
	var draftUrl = document.getElementById("previewUrl").value;
	// Disable frontend editing
	originalUrl = addFrontendEditingStateToUrl(originalUrl);
	draftUrl = addFrontendEditingStateToUrl(draftUrl);
	window.open("PageCompare.aspx?PageID=" + pageID + "&original=" + encodeURIComponent(originalUrl) + "&draft=" + encodeURIComponent(draftUrl));
}

function masterComparePage(masterid, languageid) {
	window.open("PageCompare.aspx?lang=True&original=/Default.aspx?ID=" + masterid + "&draft=/Default.aspx?ID=" + languageid);
}

function startWorkflow(publish) {
	startWorkflowCmd(publish, "");
}

function startWorkflowCmd(publish, cmd) {
	location = '/Admin/Module/Workflow/WorkflowApprove.aspx?VCP=v2&cmd=' + cmd + '&PageID=' + pageID + '&publish=' + publish;
}

function QuitDraftCancel() {
	dialog.hide("QuitDraftDialog");
	Ribbon.checkBox("cmdUseDraft");
}

function QuitDraftOk() {
	if (document.getElementById("QuitDraftPublish").checked) {
		startWorkflowCmd(true, "ToggleDraft");
	}
	if (document.getElementById("QuitDraftDiscard").checked) {
		discardChangesAndToggleDraft();
	}
}

function useDraft() {
	var unpublished = eval(document.getElementById("hasUnpublishedContent").value)
	if (unpublished) {
		dialog.show("QuitDraftDialog");
	}
	else {
		toggleDraft();
	}
}

function toggleDraft() {
    location = '/Admin/Content/ParagraphList.aspx?cmd=ToggleDraft&PageID=' + pageID;
    if (top.left) {
        top.left.UpdateMenuEntry(pageParentID);
        top.left.MakeBoldMenuEntry(pageID);
    }
}

function discardChanges() {
	if (confirm($('confirmDiscard').innerHTML)) {
		location = '/Admin/Content/ParagraphList.aspx?cmd=discardchanges&PageID=' + pageID;
	}
}

function discardChangesAndToggleDraft() {
	location = '/Admin/Content/ParagraphList.aspx?cmd=discardchanges&cmd2=ToggleDraft&PageID=' + pageID;
}

function pageProperties() {
	location = "/Admin/Page_Edit.aspx?ID=" + pageID;
}

function pageProperties2() {
	location = "/Admin/Content/PageEdit.aspx?ID=" + pageID;
}

function newSubpage() {
	location = "/Admin/Content/PageEdit.aspx?ParentPageID=" + pageID + "&AreaID=" + areaID;
}

function newParagraph() {
	location = '/Admin/Content/ParagraphEdit.aspx?PageID=' + pageID;
}

function newParagraphToContainer() {
	if (!AllowParagraphOperations) { return false }
	var container = ContextMenu.callingID;
	location = '/Admin/Content/ParagraphEdit.aspx?PageID=' + pageID + '&container=' + container;
}

function saveAsTemplate() {
	dialog.show("SaveAsTemplateDialog");
}

function SaveAsTemplateOk() {
	var isTemplate = "true";
	if (document.getElementById("isTemplate")) {
		isTemplate = document.getElementById("isTemplate").checked.toString();
	}
	url = "/Admin/Content/ParagraphList.aspx?cmd=saveastemplate&PageID=" + pageID + "&TemplateName=" + encodeURI(document.getElementById("TemplateName").value) + "&TemplateDescription=" + encodeURI(document.getElementById("TemplateDescription").value + "&isTemplate=" + isTemplate);
	location = url;
}

function SaveAsTemplateCancel() {
	dialog.hide("SaveAsTemplateDialog");
}

function publish() {
	if ($("cmdValidate")) {
		$("cmdValidate").removeClassName("disabled");
	}
setPublish('published');
}

function unPublish() {
	if ($("cmdValidate")) {
		$("cmdValidate").addClassName("disabled");
	}
	setPublish('unpublished');
}

function unPublishHide() {
	if ($("cmdValidate")) {
		$("cmdValidate").removeClassName("disabled");
	}
	setPublish('hideInMenu');
}

function previewBydateShow() {
	dialog.show('PreviewByDateDialog');
}

function previewBydate() {
	//alert(document.getElementById("DateSelector1_calendar").value);
	var theDate = Date.parseDate(document.getElementById("DateSelector1_calendar").value, '%Y-%m-%d %H:%M:%S');
	var ms = theDate.getTime() + (theDate.getTimezoneOffset() * 60 * 1000) * -1;
	window.open(document.getElementById("previewUrl").value + "&ts=" + ms);
}

function viewByDate(date) {
	//var theDate = Date.parseDate(date, '%Y-%m-%d %H:%M');
	//var ms = (theDate.getTime()-1000) + (theDate.getTimezoneOffset() * 60 * 1000) * -1;
	window.open(document.getElementById("previewUrl").value + "&ts=" + date);
}

function CompareByDate(date) {
	window.open("PageCompare.aspx?PageID=" + pageID + "&VersionCompare=True&Date=" + encodeURIComponent(date) + "&original=" + encodeURIComponent(document.getElementById("showUrl").value) + "&draft=" + encodeURIComponent(document.getElementById("previewUrl").value + "&ts=" + date));
}

function setPublish(publishState) {
    //Set NewPageName if is cmd = copy
    if ($("NewPageName") !== null) {
        url = '/Admin/Content/ParagraphList.aspx?cmd=publish&state=' + publishState + '&PageID=' + pageID + '&NewPageName=' + encodeURI($("NewPageName").value);
        $("NewPageName").value = '';
    } else {
        url= '/Admin/Content/ParagraphList.aspx?cmd=publish&state=' + publishState + '&PageID=' + pageID
    }
	new Ajax.Request(url, {
		method: 'get'
	});
	if (top.left) {
		top.left.UpdateMenuEntry(pageParentID);
		top.left.MakeBoldMenuEntry(pageID);
	}
}

var GlobalUrl = '';
function insertGlobalElement() {
	dialog.show('GlobalsDialog');
	document.getElementById("GlobalsFrame").src = GlobalUrl;
}

var InsertGlobalWindow = null;
function insertNewGlobalElement() {
	//dialog.hide('GlobalsDialog');
	InsertGlobalWindow = window.open('/Admin/menu.aspx?Action=Internal&ShowTrashBin=no&showparagraphs=on&caller=GlobalElement&AreaID=' + areaID, 'InsertGlobalWindow', 'resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=908,height=450,top=155,left=202');
}

function insertMultiSelectGlobal(List) {
    var ParagraphID = "";
    var rows = List.getSelectedRows('insertGlobalElementList');
    if(rows.length > 0) {
        for (var i = 0; i < rows.length; i++) {
            if (i == 0) {
                ParagraphID = rows[i].id.substr(3);
            } else {
                ParagraphID += "," + rows[i].id.substr(3);
            }
        }
        AddGlobal(ParagraphID);
    }
}

function AddGlobal(ParagraphID) {
    var containers = "";
    $$('div.Container').each(function (element, index) {
        if (index == 0) {
            containers += element.id;
        } else {
            containers += "," + element.id;
        }
    });

    if (InsertGlobalWindow) {
		InsertGlobalWindow.close();
	}
	if (document.getElementById("GlobalsDialog")) {
		dialog.hide('GlobalsDialog');
	}
	location = '/Admin/Paragraph/Paragraph_AddGlobal.aspx?mode=viewparagraphs&ParagraphPageID=' + pageID + '&ParagraphGlobalID=' + ParagraphID + '&Containers=' + containers;

}

function SelectParagraphID(ParagraphID) {
	top.opener.AddGlobal(ParagraphID);
}

function SelectParagraph(ParagraphID, PageID, ParagraphHeader, ParagraphItemType) {
    var wnd = window.opener,
        selfWnd = window,
        callerEl,
        storageEl,
        callbackFunc,
        callbackResponse;

	if (!wnd && window.parent) {
		wnd = window.parent.opener;
		selfWnd = window.parent;
	}

    callerEl = wnd.document.getElementById("Link_" + InternalAllID);
    storageEl = wnd.document.getElementById(InternalAllID);

    if (callerEl && storageEl) {
        callerEl.value = ParagraphHeader;
        storageEl.value = "Default.aspx?ID=" + PageID + "#" + ParagraphID;
    }
    if (storageEl) {
        callbackFunc = _readAttribute(storageEl, 'data-opener-callback');

        if (callbackFunc && wnd[callbackFunc] && typeof(wnd[callbackFunc]) === 'function') {
            wnd[callbackFunc]({
                areaID: areaID,
                pageID: PageID,
                paragraphID: ParagraphID,
                paragraphName: ParagraphHeader
            });
        } else {
            _writeAttribute(storageEl, 'data-area-id', areaID);
            _writeAttribute(storageEl, 'data-page-id', PageID);
            _writeAttribute(storageEl, 'data-paragraph-id', ParagraphID);
            _writeAttribute(storageEl, 'data-paragraph-name', ParagraphHeader);
            _writeAttribute(storageEl, 'data-paragraph-itemtype', ParagraphItemType);

            if (storageEl.onchange) {
                callbackResponse = storageEl.onchange.apply(storageEl);
            }
        }
    }

    if (callbackResponse == null || callbackResponse.closeMenu == null || callbackResponse.closeMenu == true) {
	    selfWnd.close();
    }
}

function SelectParagraphInDialog(ParagraphID, PageID) {
    dialog.show('editParagraphDialog');
    document.getElementById("editParagraphIframe").src = "ParagraphEdit.aspx?ID=" + ParagraphID + "&PageID=" + pageID;
}

function optimizeExpress() {
	dialog.show('DialogOptimize');
	document.getElementById("OptimizeFrame").src = "Optimize/PhraseSelection.aspx?ID=" + pageID;
}

function PersonalizationShow() {
    var dialogInstance = OMCPersonalizationDialog_wnd;

    if (dialogInstance) {
        dialogInstance.hide();
        dialogInstance.set_contentUrl("/Admin/Module/OMC/Emails/EmailPersonalization.aspx?pageID=" + pageID);
        dialogInstance.show();
    }
}

function EmailPreviewShow() {
    window.open("/Admin/Content/PreviewCombined.aspx?PageID=" + pageID + "&original=" + encodeURIComponent(document.getElementById("showUrl").value) + "&emailPrewiew=true", "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no");
}

function optimizeExpressHide() {
	dialog.hide('DialogOptimize');
}

function optimize() {
	top.left.Optimize(pageID);
}

function deletePage() {
	top.left.deletepage(pageID);
}

/* Validates page markup and displays an infobar if validation is failed */
function validatePage() {
	new Ajax.Request('/Admin/Content/ParagraphList.aspx?cmd=ValidateMarkup&PageID=' + pageID, {
		method: 'get',
		onComplete: function (response) {
			var html = response.responseText;
			if (html.length > 0) {
				$('markupWarning').update(html);

				if (typeof (Effect.SlideDown) == 'function')
					Effect.SlideDown('markupWarning', { duration: 0.5 });
				else
					$('markupWarning').show();
			}
		}
	});
}

/* Shows 'Validate page' dialog */
function showValidationResults() {
	var processImg = null;

	dialog.show('PageValidateDialog');
	$('frmResults').writeAttribute('src', '/Admin/Content/PageValidate.aspx?ID=' + pageID);
	toggleValidationInProgress(true);
}

/* Switches the 'Processing' icon and 'Validation details' frame visibility */
function toggleValidationInProgress(show) {
	if (show) {
		$('imgProcessing').show();
		$('validateContent').hide();
	} else {
		$('imgProcessing').hide();
		$('validateContent').show();
	}
}

function toggleActiveR() {
	var paragraphID = ContextMenu.callingID;
	if (isSelected(paragraphID)) {
		toggleActiveAll();
		return;
	}
	var currentState = "True";
	if ($('PI_' + paragraphID).hasClassName("ShowFalse")) {
		currentState = "False";
	}
	toggleActive(paragraphID, currentState, "");
}
function toggleActive(paragraphID, currentState, caller) {
    var url = "/Admin/Paragraph/Paragraph_Toggle_Active.aspx?mode=viewparagraphs&ID=" + paragraphID + "&active=" + (currentState == 'False' ? "1" : "0") + "&caller=" + caller;
	location = url;
}
function toggleActiveAll() {
	var SelectedIDList = getSelectedParagraphIds();
	if (SelectedIDList == "") { return }
	var url = "/Admin/Paragraph/Paragraph_Toggle_Active.aspx?mode=viewparagraphs&ID=" + SelectedIDList + "&active=" + (inActives ? "1" : "0");
	location = url;
}

function deleteParagraph() {
	if (!AllowParagraphOperations) { return false }
	var paragraphID = ContextMenu.callingID;
	if (isSelected(paragraphID)) {
		deleteParagraphs();
		return;
	}
	deleteParagraphs(paragraphID);
}
function deleteParagraphs() {
	if (!AllowParagraphOperations) { return false }
	var SelectedIDList = "";
	if (arguments.length == 0) {
		SelectedIDList = getSelectedParagraphIds();
	}
	else {
		SelectedIDList = arguments[0];
	}
	if (document.getElementById("PageApprovalType")) {
		if (document.getElementById("PageApprovalType").value != "0") {
		    var url = "ParagraphList.aspx?mode=viewparagraphs&PageID=" + pageID + "&ID=" + SelectedIDList + "&cmd=deleteparagraphs";
			location = url;
			return;
		}
	}
	if (SelectedIDList == "") { return }
	if (confirm(deleteMsg)) {
	    var url = "/Admin/Paragraph/Paragraph_Delete.aspx?mode=viewparagraphs&ID=" + SelectedIDList + "&PageID=" + pageID;
		location = url;
	}
}

function moveParagraph() {
	if (!AllowParagraphOperations) { return false }
	var paragraphID = ContextMenu.callingID;
	if (isSelected(paragraphID)) {
		moveParagraphs();
		return;
	}
	moveParagraphs(paragraphID);
}
function moveParagraphs() {
	if (!AllowParagraphOperations) { return false }
	var SelectedIDList = "";
	if (arguments.length == 0) {
		SelectedIDList = getSelectedParagraphIds();
	}
	else {
		SelectedIDList = arguments[0];
	}
	if (SelectedIDList == "") { return }
	window.open("/Admin/Menu.aspx?MoveID=" + SelectedIDList + "&Action=MoveParagraph&MoveFromPageID=<%=PageID%>&AreaID=" + areaID, "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
}

var experimentTesting = false;
function experimentTestParagraph() {
	experimentTesting = true;
	copyParagraphsHere();
}

function copyParagraphHere() {
	if (!AllowParagraphOperations) { return false }
	var paragraphID = ContextMenu.callingID;
	if (isSelected(paragraphID))
    {
		copyParagraphsHere();
		return;
    }
    var __o = new overlay('__ribbonOverlay');
    __o.message('');
    __o.show();
    copyParagraphsHere(paragraphID);
}
function copyParagraphsHere() {
	if (!AllowParagraphOperations) { return false }
	var SelectedIDList = "";
	if (arguments.length == 0) {
		SelectedIDList = getSelectedParagraphIds();
	}
	else {
		SelectedIDList = arguments[0];
	}
	if (SelectedIDList == "") { return }
	var __o = new overlay('__ribbonOverlay');
	__o.message('');
	__o.show();

	var dt = new Date;
	var url = "/Admin/Paragraph/Paragraph_Copy.aspx?mode=viewparagraphs&copyHere=true&paragraphid=" + SelectedIDList + "&topage=" + pageID + "&AreaID=" + areaID + "&omcExp=" + experimentTesting + "&dt=" + dt;
    location = url;
}

function copyParagraph() {
	if (!AllowParagraphOperations) { return false }
	var paragraphID = ContextMenu.callingID;
	if (isSelected(paragraphID)) {
		copyParagraphs();
		return;
	}
	copyParagraphs(paragraphID);
}
function copyParagraphs() {
	if (!AllowParagraphOperations) { return false }
	var SelectedIDList = "";
	if (arguments.length == 0) {
		SelectedIDList = getSelectedParagraphIds();
	}
	else {
		SelectedIDList = arguments[0];
	}
	if (SelectedIDList == "") { return }
	window.open("../Menu.aspx?CopyID=" + SelectedIDList + "&Action=CopyParagraph&AreaID=" + areaID, "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
}

function editParagraph(caller) {
    location = "ParagraphEdit.aspx?ID=" + ContextMenu.callingID + "&PageID=" + pageID;
}

function insertParagraph(paragraphSortID, sortDirection) {
    if (!AllowParagraphOperations) { return false }

    var container = getParagraphContainer(paragraphSortID);

    location = "ParagraphEdit.aspx?PageID=" + pageID + '&ParagraphSortID=' + paragraphSortID + '&ParagraphSortDirection=' + sortDirection + '&container=' + container;
}

var contextParagraphID = 0;
function mouseoverParagraph(ParagraphID) {
	contextParagraphID = ParagraphID;
	$('Paragraph_' + ParagraphID).addClassName("ShowActive")
}

var inActives = false;
function getSelectedParagraphIds() {
	inActives = false;
	var SelectedIDList = "";
	$('form1').getInputs('checkbox').each(function (s) {
		if (s.id != 'chkAll' && s.checked) {
			if ($('PI_' + s.value).hasClassName("ShowFalse")) {
				inActives = true;
			}
			if (SelectedIDList == "") {
				SelectedIDList = s.value;
			} else {
				SelectedIDList = SelectedIDList + "," + s.value;
			}
		}
	});
	return SelectedIDList;
}

function isSelected(ParagraphID) {
	var found = false;
	$('form1').getInputs('checkbox').each(function (s) {
		if ((s.checked) && (parseInt(s.value) == parseInt(ParagraphID))) {
			found = true;
		}
	});

	return found;
}

function toggleAllSelected() {
	setAllSelected($('chkAll').checked);
}

function setAllSelected(isSelected) {
	$('form1').getInputs('checkbox').each(function (s) {
		if (!s.disabled)
			s.checked = isSelected;
	});

	handleCheckboxes();
}

function handleCheckboxes() {
	var checked = false;
	var checkedCount = 0;
	var checkboxes = $('form1').getInputs('checkbox');

	checkboxes.each(function (s) {
		if (s.disabled && s.id != 'chkAll') {
			checkedCount++;
		}
		if (s.checked && s.id != 'chkAll') {
			checked = true;
			checkedCount++;
		}
});
    var allCheckedAreExperiments = true;
    checkboxes.each(function (s) {
        if (s.checked && s.id != 'chkAll') {
            if (experimentParagraphs.indexOf(s.id) == -1) {
                allCheckedAreExperiments = false;
            }
        }
    });
    $('chkAll').checked = !(checkedCount < (checkboxes.length - 1));

    var omcTab = document.getElementById("tabitem3");

	if (checked) {
		if (!AllowParagraphOperations) { return false }
		Ribbon.enableButton('CopyParagraphs');
		Ribbon.enableButton('CopyParagraphsHere');
		Ribbon.enableButton('MoveParagraphs');
		Ribbon.enableButton('DeleteParagraphs');
		Ribbon.enableButton('IncludeParagraphs');
	    if (!allCheckedAreExperiments)
	        Ribbon.enableButton('ExperimentTestBtn');
	    else
	        Ribbon.disableButton('ExperimentTestBtn');

	    if (omcTab === null || omcTab.className !== 'activeitem') {
	        Ribbon.tab(2, "myribbon");
	    }
	} else {
		Ribbon.disableButton('CopyParagraphs');
		Ribbon.disableButton('CopyParagraphsHere');
		Ribbon.disableButton('MoveParagraphs');
		Ribbon.disableButton('DeleteParagraphs');
		Ribbon.disableButton('IncludeParagraphs');
		if (!allCheckedAreExperiments)
		    Ribbon.enableButton('ExperimentTestBtn');
		else
		    Ribbon.disableButton('ExperimentTestBtn');

		if (omcTab === null || omcTab.className !== 'activeitem') {
		    Ribbon.tab(1, "myribbon");
		}
	}
}

function LayoutList() {
	$$('div.pd').each(function (d) {
	    new Draggable(d.id, {
			revert: true
		});
	});

	$$('div.pd').each(function (d) {
		Droppables.add(d.id, {
			accept: 'pd',
			hoverclass: 'hover',
			onDrop: function (drag, drop, e) {
				drop.highlight();
			}
		});
	});
}

function InitModuleList() {
	//Sortable.create("modules",
    //{
    //	containment: "items",
    //	ghosting: false,
    //	dropOnEmpty: true,
    //	constraint: ""
    //});
}

/* Fired when two list elements needs to be swapped in the list */
function onSorting(element, dropOn) {
	var dragObj = $(element), dropObj = $(dropOn);
	var temp = null;

	// Sorting items without touching separators

	if (element && dropOn) {
		if (dropObj.hasClassName('separator')) {
			// direction - "Up"
			temp = dropObj.previous();

			// ensure that these are two siblings
			if (temp != null && dropObj.next() == element) {
				this._insertBefore(element, temp);
				this._insertBefore(dropOn, temp);
			}
		} else {
			// direction - "Down"
			temp = dragObj.next();
			if (temp != null) {

				// ensure that these are two siblings
				if (temp.hasClassName('separator') && temp.next() == dropOn) {
					this._insertBefore(dropOn, element);
					this._insertBefore(temp, element);
				}
			}
		}
	}
}

function InitParagraphList() {
    var list = $('items'),
        containers = new Dynamicweb.Utilities.Dictionary(),
        positions = {},
        contains = function (parent, element) {
            var result = false;

            if (parent && element) {
                result = parent.contains(element);
            }

            return result;
        },
        setPosition = function (element) {
            var id = element.readAttribute('id');

            if (id) {
                positions[id] = currentPosition(element);
                return positions[id];
            }
            else {
                return null;
            }
        },
        getPosition = function (element) {
            var id = element.readAttribute('id'),
                result;

            if (id) {
                result = positions[id];
            }

            return result;
        },
        currentPosition = function (element) {
            var id = element.readAttribute('id'),
                currentPosition;

            if (id) {
                currentPosition = {};
                currentPosition.parent = element.parentElement;
                currentPosition.nextSibling = element.nextElementSibling;
                currentPosition.previousSibling = element.previousElementSibling;
            }
            return currentPosition;
        },
        canMove = function (element) {
            var result = true,
                itemType = element.readAttribute('data-item-type'),
                newParent = element.parentElement.readAttribute('id'),
                previousParent = getPosition(element).parent.readAttribute('id'),
                container;
                
            if (previousParent !== newParent) {
                container = containers.get(newParent);
                if (container && container.itemsAllowed.length > 0) {
                    if (itemType) {
                        result = container.itemsAllowed.indexOf(itemType) > -1;
                    } else {
                        result = false;
                    }
                }
            }

            return result;
        },
        revert = function (element) {
            var position = getPosition(element),
                currentParent = element.parentElement,
                previousParent,
                insertAfter = function (parent, target, source) {
                    var result = false;

                    if (contains(parent, source)) {
                        sibling = source.nextElementSibling;

                        if (sibling) {
                            parent.insertBefore(target, sibling);
                        }
                    }

                    if (!result) {
                        parent.appendChild(target);
                    }
                },
                insertBefore = function (parent, target, source) {
                    if (contains(parent, source)) {
                        parent.insertBefore(element, source);
                    } else {
                        parent.appendChild(target);
                    }
                };

            if (position && currentParent) {
                previousParent = position.parent;
                currentParent.removeChild(element);

                if (position.previousSibling && position.nextSibling) {
                    // check whether siblings still exist in parent
                    if (contains(previousParent, position.nextSibling)) {
                        insertBefore(previousParent, element, position.nextSibling);
                    } else if (contains(previousParent, position.previousSibling)) {
                        insertAfter(previousParent, element, position.previousSibling);
                    } else {
                        previousParent.appendChild(element);
                    }
                } else if (position.previousSibling) {
                    insertAfter(previousParent, element, position.previousSibling);
                } else if (position.nextSibling) {
                    insertBefore(previousParent, element, position.nextSibling);
                } else {
                    previousParent.appendChild(element);
                }
            }
        };

	if (!AllowParagraphOperations) {
		return false;
	}

    // collect restrictions of all containers
	$$('ul.paragraph-container').each(function (element) {
	    var id = element.readAttribute('id'),
	        itemsAllowed = element.readAttribute('data-items-allowed');

	    if (id) {
	        containers.add(id, { itemsAllowed: [] });

	        if (itemsAllowed) {
	            itemsAllowed.split(',').each(function (item) {
	                containers.get(id).itemsAllowed.push(item.trim());
	            });
	        }
	    }
	});

	containers.forEach(function (value, key) {
	    Sortable.create(key, { tag: 'li', containment: containers.keys(), dropOnEmpty: true });
	});

	var oldPosition = {};
	Draggables.addObserver({
	    onStart: function (eventName, draggable, event) {
	        oldPosition = setPosition(draggable.element);
	    },
        onEnd: function (eventName, draggable, event) {
            var el = draggable.element;
            var newPosition = currentPosition(el);

            if (!!(oldPosition) && !!(newPosition) && (
                oldPosition.parent != newPosition.parent ||
                oldPosition.nextSibling != newPosition.nextSibling ||
                oldPosition.previousSibling != newPosition.previousSibling))
            {
                if (!canMove(el)) {
                    revert(el);
                    alert(Dynamicweb.ParagraphList.Translations['ContainerRestriction']);
                } else {
                    SortDone();
                }
            }
        }
    });

    // Fix: Prototype includes scroll offsets 
	Position.includeScrollOffsets = true;

    // If there are moved or copied paragraphs and not omcExperiment - show options dialog
    if ($("NewParagraphsIDs").value !== "" && $("isOmcExp").value !== "True") {
        dialog.show("ParagraphOptionsDialog");
    }

    // If there are moved or copied pages - show options dialog
    if ($("NewPageID").value !== "") {
        dialog.show("PageOptionsDialog");
    }
}

var ListHasTemplateModule = false;
function SortDone() {
    var data = {};

    $$('ul.paragraph-container').each(function (element) {
        var id = element.readAttribute('id').replace('Container_', '');

        data[id] = [];
        element.select('li').each(function (element) {
            data[id].push(element.readAttribute('id').replace('Paragraph_', ''));
        });
    });

    if (ShowParagraphSortingConfirmation && ParagraphSortingWarningMsg != null && ParagraphSortingWarningMsg != '' && !confirm(ParagraphSortingWarningMsg)) {
        location.replace(location);
    } else {
        var dt = new Date;
        var url = "/Admin/Paragraph/Paragraph_SortAll_Save.aspx?mode=viewparagraphs";
        new Ajax.Request(url, {
            method: 'post',
            parameters: {
                PageID: pageID,
                Containers: JSON.stringify(data),
                dt: dt
            },
            onComplete: function (transport) {
                if (ListHasTemplateModule) {
                    location.replace(location);
                }
            }
        });
    }
}

/* Opens the 'Edit module' window */
function openModuleSettings(paragraphID) {
    var pid = paragraphID, url = '';
    var wnd = null;

    if (!pid)
        pid = ContextMenu.callingID;

    if ($('GlobalElementsIDs')) {
        var globalIDs = $('GlobalElementsIDs').value.split(',');
        for (var i = 0; i < globalIDs.length; i++) {
            var gid = "_" + globalIDs[i];
            if (gid.indexOf("_" + pid + '-') >= 0) {
                pid = globalIDs[i].split('-')[1];
                break;
            }
        }
    }

    if (pid > 0) {
        url = '/Admin/Content/ParagraphEditModule.aspx?ID=' + pid + '&PageID=' + pageID + '&AreaID=' + areaID + '&OnCompleteCallback=editModule&OnRemoveCallback=editModule';
        wnd = window.open(url, 'EditModuleWnd', 'resizable=no,scrollbars=yes,toolbar=no,location=no,directories=no,status=yes,width=670,height=600,modal=yes');

        if (wnd)
            wnd.focus();
    }
}

/* Fires when module settings are applied (or when module is removed) */
function editModule(paragraphID, moduleSystemName, moduleSettings) {
	setTimeout(function () {
		new Ajax.Request('/Admin/Content/FrontendEdit.aspx', {
			method: 'post',
			parameters: {
				cmd: 'SetModuleSettings',
				ID: paragraphID,
				moduleName: moduleSystemName,
				moduleSettings: moduleSettings
			},

			onComplete: function (response) {
			    var url = removeURLParameter(location.href, 'CopiedParagraphIDs');
			    if (url.indexOf("cmd=copypage") != -1) {
			        url = removeURLParameter(location.href, 'cmd');
			    };
			    location.href = url;
			}
		});
	}, 150);

	return true;
}

function removeURLParameter(url, parameter) {
    var urlparts = url.split('?');
    if (urlparts.length >= 2) {

        var prefix = encodeURIComponent(parameter) + '=';
        var pars = urlparts[1].split(/[&;]/g);

        for (var i = pars.length; i-- > 0;) {
            if (pars[i].lastIndexOf(prefix, 0) !== -1) {
                pars.splice(i, 1);
            }
        }

        url = urlparts[0] + '?' + pars.join('&');
        return url;
    } else {
        return url;
    }
}

function switchToItem() {
    location = '/Admin/Content/Items/Editing/ItemEdit.aspx?PageID=' + pageID;
}

function switchToNamedItemList() {
    location = '/Admin/Content/Items/Editing/NamedItemListEdit.aspx?PageID=' + pageID;
}

function updateParagraphOptions() {
    dialog.hide('ParagraphOptionsDialog');
    if ($("NewParagraphsIDs").value != '') {
        var IDs = $("NewParagraphsIDs").value;
        if ($("ParagraphOptionsActive").checked) {
            var url = "/Admin/Paragraph/Paragraph_Toggle_Active.aspx?mode=viewparagraphs&ID=" + IDs + "&active=1";
            location = url;
        }
        if ($("ParagraphOptionsNotActive").checked) {
            var url = "/Admin/Paragraph/Paragraph_Toggle_Active.aspx?mode=viewparagraphs&ID=" + IDs + "&active=0";
            location = url;
        }
    }
}

//Update page options according to popup options window
function updatePageOptions() {
    dialog.hide("PageOptionsDialog");
    var PageID = $("NewPageID").value;
    $("NewPageID").value = "";
    var OldPageState = $("OldPageState").value;
    if (PageID !== '' && OldPageState !== '') {
        if ($("PageOptionsAsTheyAre").checked) {
            switch (OldPageState) {
                case "published":
                    publish();
                    if (!$("cmdPublished").hasClassName('active')) {
                        $("cmdPublished").addClassName('active')
                        $("cmdHidden").removeClassName('active')
                        $("cmdHideInNavigation").removeClassName('active')
                    }
                    break;
                case "unpublished":
                    unPublish();
                    if (!$("cmdHidden").hasClassName('active')) {
                        $("cmdPublished").removeClassName('active')
                        $("cmdHidden").addClassName('active')
                        $("cmdHideInNavigation").removeClassName('active')
                    }
                    break;
                case "hideinmenu":
                    unPublishHide();
                    if (!$("cmdHideInNavigation").hasClassName('active')) {
                        $("cmdPublished").removeClassName('active')
                        $("cmdHidden").removeClassName('active')
                        $("cmdHideInNavigation").addClassName('active')
                    }
                    break;
                default:
                    break;
            }
        }
        if ($("PageOptionsPublished").checked) {
            publish();
            if (!$("cmdPublished").hasClassName('active')) {
                $("cmdPublished").addClassName('active')
                $("cmdHidden").removeClassName('active')
                $("cmdHideInNavigation").removeClassName('active')
            }
        }
        if ($("PageOptionsUnpublished").checked) {
            unPublish();
            if (!$("cmdHidden").hasClassName('active')) {
                $("cmdPublished").removeClassName('active')
                $("cmdHidden").addClassName('active')
                $("cmdHideInNavigation").removeClassName('active')
            }
        }
        if ($("PageOptionsHideInMenu").checked) {
            unPublishHide();
            if (!$("cmdHideInNavigation").hasClassName('active')) {
                $("cmdPublished").removeClassName('active')
                $("cmdHidden").removeClassName('active')
                $("cmdHideInNavigation").addClassName('active')
            }
        }
    }
}

function _writeAttribute(element, name, value) {
    element.setAttribute(name, value);
}

function _readAttribute(element, name) {
    return (!element.attributes || !element.attributes[name]) ? '' :
             element.attributes[name].value;
}

Dynamicweb.ParagraphList.ItemEdit = function () {
    this._terminology = {};
    this._item = {};
}

Dynamicweb.ParagraphList.ItemEdit._instance = null;

Dynamicweb.ParagraphList.ItemEdit.get_current = function () {
    if (!Dynamicweb.ParagraphList.ItemEdit._instance) {
        Dynamicweb.ParagraphList.ItemEdit._instance = new Dynamicweb.ParagraphList.ItemEdit();
    }

    return Dynamicweb.ParagraphList.ItemEdit._instance;
}

Dynamicweb.ParagraphList.ItemEdit.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.ParagraphList.ItemEdit.prototype.get_item = function () {
    return this._item;
}

Dynamicweb.ParagraphList.ItemEdit.prototype.set_item = function (value) {
    this._item = value;
}