var previousURL;

function setReferrerURL() {
    if ($("ContentFrame").src != "")
        previousURL = $("ContentFrame").src;
}

function newItem(type, itemID) {
    setReferrerURL();

	if (type == "Category") {
		$("ContentFrame").src = "/Admin/module/Booking/Category/EditCategory.aspx?AreaID=" + itemID;
	} else if (type == "Resource" || type == "Service" || type == "Calendar") {
	    $("ContentFrame").src = "/Admin/module/Booking/Item/EditItem.aspx?Type=" + type + "&CategoryID=" + itemID;
	}
}

function editItem(type, itemID) {
    setReferrerURL();

    if (type == "Category") {
		$("ContentFrame").src = "/Admin/module/Booking/Category/EditCategory.aspx?ID=" + itemID + "&Type=" + type;
	} else if (type == "Resource" || type == "Service" || type == "Calendar") {
	    $("ContentFrame").src = "/Admin/module/Booking/Item/EditItem.aspx?ID=" + itemID + "&Type=" + type;
	}
}

function deleteItem(type, itemID) {
    setReferrerURL();

    var confirmText = eval('deleteText_' + type);
    var itemName = ajax('Get' + type + 'Name', 'ItemID=' + itemID);
    var text = confirmText.replace('%%', itemName);

    if (confirm(text))
        $("ContentFrame").src = "/Admin/module/Booking/DeleteItem.aspx?ID=" + itemID + "&Type=" + type;
}

function showItem(type, itemID) {
    setReferrerURL();

    $("ContentFrame").src = "/Admin/module/Booking/BookingList.aspx?Type=" + type + "&ID=" + itemID;
}

function showItems(type, itemID) {
    setReferrerURL();

    $("ContentFrame").src = "/Admin/module/Booking/BookingList.aspx?Type=" + type + "&CategoryID=" + itemID;
}

function newReservation(reservationType, itemID, startTime, endTime, allDay) {
    setReferrerURL();

    var url = "/Admin/module/Booking/Reservation/EditReservation.aspx?ItemID=" + itemID;

	if (reservationType)
	    url += "&ReservationType=" + reservationType;

	if (startTime)
	    url += "&StartTime=" + startTime.getFullYear() + "-" + (startTime.getMonth() + 1) + "-" + startTime.getDate() + " " + startTime.getHours() + ":" + startTime.getMinutes() + ":00";

	if (endTime)
	    url += "&EndTime=" + endTime.getFullYear() + "-" + (endTime.getMonth() + 1) + "-" + endTime.getDate() + " " + endTime.getHours() + ":" + endTime.getMinutes() + ":00";

	url += "&AllDay=" + (allDay == true);

	$("ContentFrame").src = url;    
}

function editReservation(id) {
    setReferrerURL();

    $("ContentFrame").src = "/Admin/module/Booking/Reservation/EditReservation.aspx?ID=" + id;
}

function deleteReservation(id) {
    setReferrerURL();

    deleteItem("Reservation", id);
}

function resetContentFrameLocation() {
    $("ContentFrame").src = previousURL;
}

function reloadTreeItem(ID) {
	location = "/Admin/module/Booking/Default.aspx?ItemID=" + ID;
}

function reloadTreeCategory(ID) {
	location = "/Admin/module/Booking/Default.aspx?CategoryID=" + ID;
}

function reloadTreeArea(ID) {
	location = "/Admin/module/Booking/Default.aspx?AreaID=" + ID;
}

function navigateToItem(itemid) {
	t.select(itemid + itemOffset);
    //t.openToItemID(itemid + itemOffset, true);
}
function navigateToCategory(categoryid) {
    t.select(categoryid + categoryOffset);
    //t.openToItemID(categoryid + categoryOffset, true);
}
function navigateToArea(itemid) {
    t.select(itemid + areaIDOffset);
    //t.openToItemID(itemid + areaIDOffset, true);
}

function ajax(cmd, params) {
    var result = "";
    new Ajax.Request("/Admin/Module/Booking/Default.aspx?AjaxCmd=" + cmd + "&" + params, {
        asynchronous: false,
        onSuccess: function (transport) {
            result = transport.responseText;
        }
    });
    return result;
}