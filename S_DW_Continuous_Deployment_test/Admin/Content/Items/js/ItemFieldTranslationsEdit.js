if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.Items) == 'undefined') {
    Dynamicweb.Items = new Object();
}

Dynamicweb.Items.ItemFieldTranslationsEdit = function () {
    this._terminology = {};
    this._initialized = false;
}

Dynamicweb.Items.ItemFieldTranslationsEdit._instance = null;

Dynamicweb.Items.ItemFieldTranslationsEdit.get_current = function () {
    if (!Dynamicweb.Items.ItemFieldTranslationsEdit._instance) {
        Dynamicweb.Items.ItemFieldTranslationsEdit._instance = new Dynamicweb.Items.ItemFieldTranslationsEdit();
    }

    return Dynamicweb.Items.ItemFieldTranslationsEdit._instance;
}

Dynamicweb.Items.ItemFieldTranslationsEdit.prototype.get_terminology = function () {
    return this._terminology;
}

Dynamicweb.Items.ItemFieldTranslationsEdit.prototype.initialize = function () {
    if (!this._initialized) {
        this._initialized = true;
    }
}

Dynamicweb.Items.ItemFieldTranslationsEdit.prototype.itemTypeChange = function () {
    var itemList = $("dItemList");
    var itemSelectedSystemName = itemList.options[itemList.selectedIndex].value;

    if (itemSelectedSystemName.length == 0) {
        location.href = "/Admin/Content/Items/ItemTypes/ItemFieldTranslationsEdit.aspx";
    } else {
        location.href = "/Admin/Content/Items/ItemTypes/ItemFieldTranslationsEdit.aspx?ItemType=" + itemSelectedSystemName;
    }
}

Dynamicweb.Items.ItemFieldTranslationsEdit.prototype.addMissedTranslations = function () {
    var itemList = $("dItemList");
    var itemSelectedSystemName = itemList.options[itemList.selectedIndex].value;

    if (itemSelectedSystemName.length == 0) {
        location.href = "/Admin/Content/Items/ItemTypes/ItemFieldTranslationsEdit.aspx";
    } else {
        location.href = "/Admin/Content/Items/ItemTypes/ItemFieldTranslationsEdit.aspx?ItemType=" + itemSelectedSystemName;
    }
}

Dynamicweb.Items.ItemFieldTranslationsEdit.prototype.addNewTranslation = function () {
    var itemList = $("dItemList");
    var itemSelectedSystemName = itemList.options[itemList.selectedIndex].value;

    // Screen center
    var x = screen.width / 2 - 800 / 2;
    var y = screen.height / 2 - 600 / 2;

    if (itemSelectedSystemName.length == 0) {
        window.open('/Admin/Content/Management/Dictionary/TranslationKey_Edit.aspx?&IsNew=true&IsItem=true', '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
    } else {
        window.open('/Admin/Content/Management/Dictionary/TranslationKey_Edit.aspx?ItemName=' + itemSelectedSystemName + '&IsNew=true&IsItem=true', '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
    }
}