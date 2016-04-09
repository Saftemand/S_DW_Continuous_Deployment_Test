var pageID = 0;
var areaID = 0;

var PageEdit = {

    init: function (PageID) {
        pageID = PageID;
        if (top.left) {
            areaID = top.left.areaid;
        }
        if (parent.AreaID) {
            areaID = parent.AreaID;
        }

        if (groupSorting) {
            this.enableSorting();
            document.observe('EcomGroupTree:GroupsComplete', (function (event) { this.enableSorting(); }).bind(this));
        }

        $('NavigationGroupSelector_list_shop').style.marginLeft = '104px';
        var navMainDiv = $('NavigationGroupSelector_some_main_div');
        navMainDiv.style.marginLeft = '17px';
        navMainDiv.style.marginTop = '10px';

        document.getElementById("PageMenuText").focus();

        this._contentTypeList = $('PageContentType');
        this._newContentType = $$('input.page-content-type')[0];
    },

    enableSorting: function () {
        var groupValues = $('NavigationGroupSelector_some_value');
        Sortable.create("NavigationGroupSelector_some_div", {
            tag: 'div',
            onUpdate: (function (container) {
                var newValue = '',
                    children = container.childNodes;

                for (var i = 0; i < children.length; i++) {
                    newValue += '[g:' + children[i].id.replace('g_', '') + ']';
                }

                groupValues.value = newValue;
                groupValues.onchange();
            }).bind(this)
        });
    },

    showPage: function () {
        window.open(document.getElementById("previewUrl").value);
    },

    profileVisitPreview: function () {
        window.open("/Admin/Module/Omc/Profiles/PreviewProfile.aspx?PageID=" + pageID + "&original=" + encodeURIComponent(document.getElementById("previewUrl").value), "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no");
    },

    SetPublish: function () {
        if (!document.getElementById("chk_PageActive").checked) {
            document.getElementById("chk_PageActive").checked = true;
        }
    },

    SetUnPublish: function () {
        document.getElementById("chk_PageActive").checked = false;
    },

    SetPublishHide: function () {
        document.getElementById("chk_PageActive").checked = false;
    },

    SaveOk: function () {
        var pageNameEl = document.getElementById("PageMenuText");
        var val = Dynamicweb.Utilities.StringHelper.removeLineTerminators(pageNameEl.value);
        if (val.length < 1) {
            alert($('NoNameText').innerHTML);
            document.getElementById("PageMenuText").focus();
            return false;
        }
        pageNameEl.value = val;
        if (document.getElementById('PagePermission')) {
            if (document.getElementById('PagePermission').options) {
                for (i = 0; i < document.getElementById('PagePermission').options.length; i++) {
                    document.getElementById('PagePermission').options[i].selected = true;
                }
            }
        }
        if (document.getElementById('PageUrlName')) {
            var text = $("PageUrlName").value;
            if (/[\+\?\#\%\:\;\|\<\>\*]|\s{2}|\"{2}/.match(text)) {
                alert(NotAllowedURLCharacters);
                $("PageUrlName").focus();
                return false;
            }
        }
        if (document.getElementById('PageExactUrl')) {
        	var text = $("PageExactUrl").value;
        	if (/[\+\?\#\%\:\;\|\<\>\*\&]|\s{2}|\"{2}/.match(text)) {
        		alert(NotAllowedURLCharacters);
        		$("PageExactUrl").focus();
        		return false;
        	}
        }

        return true;
    },

    updateBreadCrumb: function () {
        var val = Dynamicweb.Utilities.StringHelper.removeLineTerminators(document.getElementById("PageMenuText").value);
        if (val.length > 0) {
            document.getElementById("BreadcrumbActive").innerText = val;
        }
    },

    SaveAndClose: function () {
        this.Save(true);
    },

    Save: function (close) {
        if (!PageEdit.SaveOk()) {
            __cancelOverlay = true;
            return false;
        }

        var itemEdit = Dynamicweb.Page.ItemEdit.get_current();
        itemEdit.validate(function (result) {
            if (result.isValid) {
                // Fire event to handle saving
                window.document.fire("General:DocumentOnSave");

                document.getElementById("onSave").value = close ? "Close" : "Nothing"
                var form = document.getElementById("MainForm");
                form.target = "SaveFrame";
                if (typeof form.onsubmit == 'function') {
                    form.onsubmit();
                };
                form.submit();
            }
            __cancelOverlay = true;
        });
        return false;
    },

    Suggest: function (type)
    {
        var divEl;
        
        if(type == 'title')
            divEl = document.getElementById('SuggestedTitleDiv');
        else if(type == 'keywords')
            divEl = document.getElementById('SuggestedKeywordsDiv');
        else
            return;

        var loadStr = Dynamicweb.Page.ItemEdit.get_current().get_terminology()['SuggestLoading'];

        divEl.removeAttribute('style');

        if(type == 'title')
            document.getElementById('SuggestedTitleB').innerText = loadStr;
        else if(type == 'keywords')
            document.getElementById('SuggestedKeywordsB').innerText = loadStr;

        new Ajax.Request('PageEdit.aspx?ID=' + pageID + "&suggest=" + type,
            {
                method: 'get',
                onSuccess: function (transport)
                {
                    var obj = transport.responseText.evalJSON();

                    if(type == 'title')
                        document.getElementById('SuggestedTitleB').innerText = obj;
                    else if(type == 'keywords')
                        document.getElementById('SuggestedKeywordsB').innerText = obj;
                },
            });
    },

    Cancel: function () {
        var redirectTo = location = "ParagraphList.aspx?PageID=" + pageID;
        var parentPageID = parseInt(document.getElementById("ParentPageID").value);

        if (pageID <= 0) {
            redirectTo = location = "ParagraphList.aspx?PageID=" + parentPageID;
            if (parentPageID <= 0) {
                redirectTo = '/Admin/MyPage/Default.aspx';
            }
        }

        if (document.location.search.indexOf('openedFromFrontend=True') > -1) {
        	close();
        	return;
        }

        location = redirectTo;
    },

    AddPage: function (Name) {
        movepageWindow = window.open("/Admin/Menu.aspx?ID=" + pageID + "&Action=AddPage&Caller=" + Name + "&AreaID=" + areaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,top=155,left=402");
    },

    Marketing: null,

    openContentRestrictionDialog: function (params) {
        var p = pageID;

        if (params && params.pageID) {
            p = params.pageID;
        }

        this.Marketing.openSettings('ContentRestriction', { data: { ItemType: 'Page', ItemID: p} });
    },

    openProfileDynamicsDialog: function () {
        this.Marketing.openSettings('ProfileDynamics', { data: { ItemType: 'Page', ItemID: pageID} });
    },
    
    openContentTypeDialog: function() {
        dialog.show('ContentTypeDialog');
        this._newContentType.focus();
    },

    addContentType: function () {
        var i, max, value, option, options, add = true;

        if (!this._contentTypeList && !this._newContentType) {
            return;
        }
        
        if (!this._newContentType.value) {
            return;
        }

        options = this._contentTypeList.options;
        max = options.length;
        value = this._newContentType.value.strip().stripTags().stripScripts().toLowerCase();
        
        for (i = 0; i < max; i += 1) {
            option = options[i];
            
            if (value === option.value) {
                add = false;
                this._contentTypeList.value = option.value;
                break;
            }
        }
        
        if (add) {
            option = document.createElement('option');
            option.value = value;
            option.innerHTML = value;

            options.add(option);
            this._contentTypeList.value = value;
        }
        
        this._newContentType.value = '';
        dialog.hide('ContentTypeDialog');
    },
    showRestrictionRules: function () {
        dialog.show('dlgEditRestrictionRules');
    },
    hideRestrictionRules: function () {
        dialog.hide('dlgEditRestrictionRules');
    }
}

function setVisibility(elementID, isVisible) {
    var elm = document.getElementById(elementID);

    if (elm) {
        elm.style.display = (isVisible ? '' : 'none');
    }
}

function devicelayouts() {
	dialog.show("DeviceLayoutDialog");
}

function ShowLanguages() {
	dialog.show('LanguageDialog');
	document.getElementById("LanguageFrame").src = LanguageUrl;
}

function showOrHide(box) {
	if (!box.checked) {
		document.getElementById("pwd").style.display = "none";
		document.getElementById("PagePassword").value = "";
	} else {
		document.getElementById("pwd").style.display = "";
	}
}

function openEditPermission() {
    //frame = window.frames['PagePermissionDialogIFrame'];
    //frame.document.body.innerHTML = '';
    //alert("'" + pageID + "'");
    if (pageID == "0") {
        alert(pageNotSavedText);
        return false;
    }
    document.getElementById('PagePermissionDialogIFrame').src = '/Admin/Content/PagePermission.aspx?PageID=' + pageID + '&DialogID=PagePermissionDialog';
    dialog.show('PagePermissionDialog');
    //    window.open('/Admin/Content/PagePermission.aspx?PageID=' + pageID + '&CloseOnExit=True',
//		        'PagePermissions_' + pageID,
//		        'resizable = no, scrollbars = auto, toolbar = no, location = no, directories = no, status = no, width = 250, height = 550, left = 200, top = 120');
}

function changeSSLMode(sslMode) {
    var previousSSLMode = "";

    if (useSSLOption == "0") {
        previousSSLMode = "cmdSSLStandard";
    } else if (useSSLOption == "1") {
        previousSSLMode = "cmdSSLForce";
    } else if (useSSLOption == "2") {
        previousSSLMode = "cmdSSLUnforce";
    }

    if (sslMode != previousSSLMode) {
        var sslOptionConfirmed = confirm(sslConfirmation1 + "'" + document.getElementById(previousSSLMode).title + "'" + sslConfirmation2 + "'" + document.getElementById(sslMode).title + "' ?");
        if (sslOptionConfirmed != true) {
            document.getElementById("cmdSSLStandard").className = "";
            document.getElementById("cmdSSLForce").className = "";
            document.getElementById("cmdSSLUnforce").className = "";
            document.getElementById(previousSSLMode).className = "active";
            document.getElementById("radio_SSLMode_selected").value = previousSSLMode;
            if (document.getElementById("SSLMode") != null) {
                document.getElementById("SSLMode").value = useSSLOption;
            } else {
                document.getElementById("radio_SSLMode").value = useSSLOption;
            }
        } else {
            document.getElementById("cmdSSLStandard").className = "";
            document.getElementById("cmdSSLForce").className = "";
            document.getElementById("cmdSSLUnforce").className = "";
            document.getElementById(sslMode).className = "active";
        }
    }
} 

var ElemCounter;

function ShowCounters(field, counter, counterMax) {

	HideCounter();

	if (field == 'undefined') return;

	var elemCounter = document.getElementById(counter);
	if (elemCounter == 'undefined') return;

	var elemCounterMax = document.getElementById(counterMax);
	if (elemCounterMax == 'undefined') return;

	ShowCounter(elemCounter, elemCounterMax.value, field.value.length);
	ElemCounter = elemCounter;

}

function HideCounter() {
	if (ElemCounter) {
		setTextContent(ElemCounter, '');
	}
}


function CheckAndHideCounter(field, counter, counterMax) {

	if (CheckCounter(field, counter, counterMax) == true) {

		HideCounter();
	}
}

function CheckCounter(field, counter, counterMax) {

	if (field == 'undefined') return false;

	var elemCounter = document.getElementById(counter);
	if (elemCounter == 'undefined') return false;

	var elemCounterMax = document.getElementById(counterMax);
	if (elemCounterMax == 'undefined') return false;

	ShowCounter(elemCounter, elemCounterMax.value, field.value.length);
	return true;
}

function ShowCounter(elemCounter, maxSize, currentSize) {

	if (currentSize < maxSize) {
		setTextContent(elemCounter, (maxSize - currentSize) + ' ' + remainingText);
	}
	else {
		setTextContent(elemCounter, recommendedText);
	}

	var sizeInPercentage = 100;

	if (maxSize > 0) {
		sizeInPercentage = currentSize * 100 / maxSize;
	}

	if (sizeInPercentage < 80) {
		elemCounter.style.color = '#7F7F7F';
	}
	else if (sizeInPercentage < 90) {
		elemCounter.style.color = '#000000';
	}
	else {
		elemCounter.style.color = '#FF0000';
	}
}

function setTextContent(element, text) {
	while (element.firstChild !== null) {
		element.removeChild(element.firstChild); // remove all existing content 
	}
	element.appendChild(document.createTextNode(text));
}

function comments() {
	commentsUrl = '/Admin/Content/Comments/List.aspx?Type=page&ItemID=' + pageID;
	dialog.show('CommentsDialog');
	document.getElementById("CommentsFrame").src = commentsUrl;
}

/* Page property item */
if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Page) == 'undefined') {
    Dynamicweb.Page = new Object();
}

Dynamicweb.Page.ItemEdit = function () {
    this._terminology = {};
    this._cancelUrl = '';
    this._page = '';
    this._itemType = '';
    this._validation = null;
    this._validationPopup = null;
}

Dynamicweb.Page.ItemEdit._instance = null;

Dynamicweb.Page.ItemEdit.get_current = function () {
    if (!Dynamicweb.Page.ItemEdit._instance) {
        Dynamicweb.Page.ItemEdit._instance = new Dynamicweb.Page.ItemEdit();
    }

    return Dynamicweb.Page.ItemEdit._instance;
}

Dynamicweb.Page.ItemEdit.prototype.get_validation = function () {
    if (!this._validation) {
        this._validation = new Dynamicweb.Validation.ValidationManager();
    }

    return this._validation;
}

Dynamicweb.Page.ItemEdit.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Page.ItemEdit.prototype.get_page = function () {
    return this._page;
}

Dynamicweb.Page.ItemEdit.prototype.set_page = function (value) {
    this._page = value;
}

Dynamicweb.Page.ItemEdit.prototype.get_itemType = function () {
    return this._itemType;
}

Dynamicweb.Page.ItemEdit.prototype.set_itemType = function (value) {
    this._itemType = value;
}

Dynamicweb.Page.ItemEdit.prototype.initialize = function () {
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

Dynamicweb.Page.ItemEdit.prototype.validate = function (onComplete) {
    if (Dynamicweb.Items.GroupVisibilityRule) {
        Dynamicweb.Items.GroupVisibilityRule.get_current().filterValidators(this.get_validation()).beginValidate(onComplete);
    } else {
        this.get_validation().beginValidate(onComplete);
    };
}

Dynamicweb.Page.ItemEdit.prototype.openItemType = function () {
    dialog.show("ChangeItemTypeDialog");
}

Dynamicweb.Page.ItemEdit.prototype.changeItemType = function () {
    var systemName;

    systemName = $("ItemTypeSelect").value;
    if (this.get_itemType() != systemName) {
        if (confirm(this.get_terminology()['ChangeItemTypeConfirm'])) {
            //this.showWait();
            location = '/Admin/Content/Items/Editing/ItemEdit.aspx?PageID=' + pageID + '&cmd=changeItemType&ItemTypeSelect=' + systemName;
        }
        else {
            return;
        }
    }

    dialog.hide("ChangeItemTypeDialog");
}

Dynamicweb.Page.ItemEdit.prototype.cancelChangeItemType = function () {
    var ItemTypeSelect = null;

    if (this.get_itemType())
        ItemTypeSelect = "ItemTypeSelect" + this.get_itemType();
    else
        ItemTypeSelect = "ItemTypeSelectdwrichselectitem";

    ItemTypeSelect = $(ItemTypeSelect);
    if (ItemTypeSelect) RichSelect.setselected(ItemTypeSelect.down("a"), "ItemTypeSelect");

    dialog.hide("ChangeItemTypeDialog");
}