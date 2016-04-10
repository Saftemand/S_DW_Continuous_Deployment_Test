function save(doClose) {
    $("form1").action = "EditItem.aspx?Save=True&ID=" + itemID + "&Type=" + itemType + "&doClose=" + doClose;
    $("form1").submit();
}

function showReservations() {
    if (!itemID | itemID == 0) {
        parent.resetContentFrameLocation();
    } else {
        parent.showItem(itemType, itemID);
    }
}

function getServices(id) {
    ajaxUpdater("EditItem.aspx?AJAXCMD=GETSERVICES&CategoryID=" + id + "&ID=" + itemID + "&Type=" + itemType, "ServicesView");
}

function getResources(id) {
    var item = "";
    if (itemID.length > 0) {
        item = "&ID=" + itemID;
    }
    ajaxUpdater("EditItem.aspx?AJAXCMD=GETRESOURCES&CategoryID=" + id + "&ID=" + itemID + "&Type=" + itemType, "ResourcesView");
}

function ajaxUpdater(url, div) {
    new Ajax.Updater(div, url, {
    });
}