var ResourceSelector = {
    ListID: 'ResourceList',
    DialogID: 'AvailableResources',
    SelectedItemsContainerID: '',
    AvailableItemsContainerID: '',
    SelectedItemsHidden: '',
    IFrameID: 'ListFrame',
    IFrameBaseURL: '/Admin/Module/Booking/Controls/ResourceSelectorListFrame.aspx',
    IFrameType: -1,
    IFrameItems: '',
    RemoveIconID: null
};

var hasUpdatedList = false;
var contentIsLoaded = false;

ResourceSelector.showItems = function (showAll) {
    ResourceSelector.loadIFrameContent(showAll, ResourceSelector.showDialog);
}

ResourceSelector.loadIFrameContent = function (showAll, onLoaded) {
    var checkIsLoaded = function () {
        if (contentIsLoaded) {
            onLoaded();
        } else {
            setTimeout(checkIsLoaded, 50);
        }
    }

    if (contentIsLoaded)
        onLoaded();
    else {
        if (showAll)
            $(ResourceSelector.IFrameID).contentDocument.location.href = ResourceSelector.IFrameBaseURL + "?Type=" + ResourceSelector.IFrameType;
        else
            $(ResourceSelector.IFrameID).contentDocument.location.href = ResourceSelector.IFrameBaseURL + "?Type=" + ResourceSelector.IFrameType + "&AvailableItems=" + ResourceSelector.IFrameItems;

        checkIsLoaded();
    }
}

ResourceSelector.showDialog = function () {
    if (!hasUpdatedList)
        ResourceSelector.updateList();

    dialog.show(ResourceSelector.DialogID);
}

ResourceSelector.addItem = function (item) {
    var from = $(ResourceSelector.AvailableItemsContainerID);
    var to = $(ResourceSelector.SelectedItemsContainerID);

    to.options.add(new Option(item.Name, item.ID));

    ResourceSelector.updateList();
}

ResourceSelector.removeItem = function () {
    if (!contentIsLoaded) {
        ResourceSelector.loadIFrameContent(true, ResourceSelector.removeItem);
        return;
    }

    var to = $(ResourceSelector.AvailableItemsContainerID);
    var from = $(ResourceSelector.SelectedItemsContainerID);

    if (from.selectedIndex == null) return;

    var option = from.options[from.selectedIndex];
    $(ResourceSelector.IFrameID).contentWindow.List.getRowByID(ResourceSelector.ListID, option.value).show();
    from.options.remove(from.selectedIndex);

    ResourceSelector.updateList();
}

ResourceSelector.updateList = function () {
    var list = $(ResourceSelector.SelectedItemsContainerID);
    var resources = $(ResourceSelector.SelectedItemsHidden);

    var values = "";
    var updateListFailed = false;
    for (var i = 0; i < list.options.length; i++) {
        var option = list.options[i];

        if (i > 0)
            values += ", ";

        values += option.value;

        try {
            $(ResourceSelector.IFrameID).contentWindow.List.getRowByID(ResourceSelector.ListID, option.value).hide();
        } catch (e) {
            updateListFailed = true;
        }
    }

    resources.value = values;

    hasUpdatedList = !updateListFailed;
}

ResourceSelector.toggleRemoveEnabled = function () {
    var icon = $(ResourceSelector.RemoveIconID);
    var list = $(ResourceSelector.SelectedItemsContainerID);
    if (list.selectedIndex > -1)
        icon.style.visibility = "visible";
    else
        icon.style.visibility = "hidden";
}