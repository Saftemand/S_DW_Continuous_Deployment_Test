
var _dialogState;
var _parameterValues;
var _urlScheme;

var orderListPageNumber;
var _deleteQuestion;
var _helpMessage;
var shipQuestion;
var _cancelRecurringConfirmation;



var OrderEditTabs = {
    tab: function(aciveID) {
        for (var i = 1; i < 15; i++) {
            if ($("OrderEditTab" + i)) {
                $("OrderEditTab" + i).style.display = "none";
            }
        }
        if ($("OrderEditTab" + aciveID)) {
            $("OrderEditTab" + aciveID).style.display = "";
        }
    }
}

function changeView(num) {
    OrderEditTabs.tab(num);
}

function openOrderDialog(dialogId) {
    makeSnapshot(dialogId);
    dialog.show(dialogId);
}

function updateOrderDialog(dialogId) {
    dialog.hide(dialogId);
}

function cancelOrderDialog(dialogId) {
    restoreSnapshot(dialogId);
    dialog.hide(dialogId);
}

function openTNTDialog(dialogId, parentID) {
    if ($(parentID + '_otntParameters').value) {
        _parameterValues = $(parentID + '_otntParameters').value.split(',');
    }
    otntSelectBox_selectedIndexChanged($(parentID + '_otntSelectBox').value, _parameterValues ? true : false);
    makeSnapshot(dialogId);
    dialog.show(dialogId);
}

function updateTNTDialog(dialogId, parentID) {
    var parameterArr = '';
    var inputs = $$('#' + dialogId + " table#otntTable input");
    inputs.each(function (input) {
        parameterArr += input.value + ',';
    });
    $(parentID + '_otntParameters').value = parameterArr;

    dialog.hide(dialogId);
}

function showHistory()
{
    dialog.show('ShowHistoryDialog');
    document.getElementById("ShowHistoryDialogFrame").src = "/Admin/Module/eCom_Catalog/dw7/Edit/EcomOrder_History.aspx?OrderID=" + _orderId + "&VersionID=" + _versionId;
}

function makeSnapshot(dialogId) {
    _dialogState = new Hash();

    var inputs = $$('#' + dialogId + " input");
    inputs.each(function (input) {
        _dialogState.set(input.id, input.value);
    });

    var inputs2 = $$('#' + dialogId + " select");
    inputs2.each(function (input) {
        _dialogState.set(input.id, input.value);
    });
}

function restoreSnapshot(dialogId) {
    if (!_dialogState) {
        return;
    }

    _dialogState.each(function (pair) {
        if ($(pair.key)) {
            $(pair.key).value = pair.value;
        }
    });
}

function cancel() {
    if (_versionId > 0) {
        theForm.action = "/Admin/Module/eCom_Catalog/dw7/edit/EcomOrder_Edit.aspx?ID=" + _orderId;
        $$('input[id!=orderIds]').each(function (input) { input.disable(); });
        var a = new Element("input", { 'type': 'hidden', 'name': 'action', value: "orderchange" });
        theForm.insert(a);
        theForm.submit();
    }
    else {
        $('Cancel').value = "true";
        $('Cancel').value = orderListPageNumber;
        document.Form1.submit();
    }
}

function navigateOrder(orderId) {
    theForm.action = "/Admin/Module/eCom_Catalog/dw7/edit/EcomOrder_Edit.aspx?ID=" + orderId;
    var a = new Element("input", { 'type': 'hidden', 'name': 'action', value: "orderchange" });
    theForm.insert(a);
    theForm.submit();
}

function openHistoryOrder(orderId, versionId) {
    theForm.action = "/Admin/Module/eCom_Catalog/dw7/edit/EcomOrder_Edit.aspx?ID=" + orderId + "&VersionID=" + versionId;
    $$('input[id!=orderIds]').each(function (input) { input.disable(); });
    var a = new Element("input", { 'type': 'hidden', 'name': 'action', value: "orderchange" });
    theForm.insert(a);
    theForm.submit();
}

function openCompareOrder(orderId, versionId) {
    dialog.show('ShowCompareDialog');
    document.getElementById("ShowCompareDialogFrame").src = "/Admin/Module/eCom_Catalog/dw7/Edit/EcomOrder_Compare.aspx?OrderID=" + orderId + "&VersionID=" + versionId;
}

function closeCompareOrder() {
    dialog.hide('ShowCompareDialog');
}

function ReSendOrderMail() {

}

function printOrder() {
    //msgWindow = window.open("/Admin/Module/eCom_Catalog/Edit/EcomOrder_Popup.aspx?id=" + _orderId + "&Command=PRINT", "displayWindow", "width=700,height=600,scrollbars=no");
    window.location.href = "/Admin/Module/eCom_Catalog/dw7/OrderList.aspx?PageNumber=" + orderListPageNumber + "&print=true&printOrderId=" + _orderId;
}

function ShowBOMOrderLines(code) {
    if (document.getElementById('DWRowLineTRBOM' + code).style.display == '') {
        document.getElementById('DWRowLineTRBOM' + code).style.display = 'none';
        document.getElementById('BOMOrderLinesImg' + code).setAttribute("src", "/Admin/Module/eCom_Catalog/images/foldout.gif");
    } else {
        document.getElementById('DWRowLineTRBOM' + code).style.display = '';
        document.getElementById('BOMOrderLinesImg' + code).setAttribute("src", "/Admin/Module/eCom_Catalog/images/foldin.gif");
    }
}

function showProduct() {

    var line = getOrderLineData();
    if (!line) {
        return;
    }
    if (!line[3]) {
        alert($("ProductWasDeletedAlert").innerHTML);
    }
    else {
        var url = "EcomProduct_Edit.aspx?ID=" + line[2] + "&backUrl=" + escape(location.href + "&orderIds=" + $("orderIds").value);
        document.location.href = url;
    }
}

function showPage() {
    var line = getOrderLineData();
    if (!line) {
        return;
    }

    var url = "/Admin/Default.aspx?accordionAction=showparagraphs(" + line[1] + ")";
    window.parent.location = url;
}

function getOrderLineData() {
    var res = null;
    var lineId = ContextMenu.callingItemID;
    _orderLines.each(function(line) {
        if (line[0] == lineId) {
            res = line;
        }
    });
    return res;
}

function CloseAllMenu() {
    CloseMenu('OrderLineMenu');
    CloseMenu('GatewayResultMsg');
}

function CloseMenu(divNum) {
    try {
        var tmpDiv = eval(divNum);
        if (tmpDiv != null) {
            tmpDiv.style.display = "none"
        }
    } catch (e) {
        //Nothing
    }
}

function mouseoutBox(element) {
    element.cells.item(0).style.height = '20px';
    element.style.backgroundColor = '#FFFFFF';
    element.style.border = 'none';
    element.cells.item(0).style.width = '20px';
    element.cells.item(1).style.paddingLeft = '5px';
    element.cells.item(0).style.backgroundColor = '#D4D0C8';
}

function mouseoverBox(element, pix) {
    element.style.width = pix + 'px';
    element.cells.item(1).style.paddingLeft = '5px';
    element.cells.item(0).style.width = '19px';
    element.cells.item(0).style.height = '18px';
    element.style.backgroundColor = '#C1D2EE';
    element.style.border = 'solid 1px #316AC5';
    element.cells.item(0).style.backgroundColor = '#99B7E3';
}

function GetGatewayResult() {
    CloseAllMenu();

    CloseRightMenu.style.width = '100%';
    CloseRightMenu.style.height = document.body.clientHeight + 'px';

    document.getElementById('GatewayResultMsg').style.pixelLeft = event.clientX + document.body.scrollLeft;
    document.getElementById('GatewayResultMsg').style.pixelTop = event.clientY + document.body.scrollTop;

    document.getElementById('GatewayResultMsg').style.display = "";
}

strHelpTopic = 'ecom.ordersNEW.edit';
function TabHelpTopic(tabName) {
    switch (tabName) {
        case 'OVERVIEW':
            strHelpTopic = 'ecom.ordersNEW.edit.overview';
            break;
        case 'CUSTOMER':
            strHelpTopic = 'ecom.orders.edit.customer';
            break;
        case 'DELIVERY':
            strHelpTopic = 'ecom.orders.edit.delivery';
            break;
        case 'MISC':
            strHelpTopic = 'ecom.orders.edit.misc';
            break;
        case 'ORDERFIELDS':
            strHelpTopic = 'ecom.orders.edit.orderfields';
            break;
        default:
            strHelpTopic = 'ecom.ordersNEW.edit';
    }
}

function openCaptureDialog() {
    var url = '/Admin/Module/eCom_Catalog/dw7/OrderCapture.aspx?ID=' + _orderId;
    var popup = dlgCapture_wnd;
    popup.set_contentUrl(url);
    popup.set_width(450);
    popup.show();
}

function checkStatus() {
    $('trnLoadingDiv').show();

    new Ajax.Request('/Admin/Module/eCom_Catalog/dw7/edit/EcomOrder_Edit.aspx?AJAX=CheckPaymentStatus', {
        parameters: {
            OrderID: _orderId
        },
        onSuccess: function (response) {
            $("orderGatewayPaymentStatus").innerHTML = response.responseText;
        },
        onFailure: function () {
            alert('Something went wrong!');
        },
        onComplete: function () {
            $('trnLoadingDiv').hide();
        }
    });
}

function checkTNT() {
    var urlValue = _urlScheme;
    var urlParamLen = _parameterValues ? _parameterValues.length : 0;

    for (var i = 0; i < urlParamLen; i++) {
        var param = $('otntParameterValue' + i);
        if (param) {
            urlValue = String(urlValue).replace('{' + i + '}', param.value);
        }
    }

    window.open(urlValue);
}


function showTNTUrlScheme() {
    //alert(msgTitle + ': ' + _urlScheme);
    dialog.show('TNTUrlSchemeDialog');
    $('TNTUrlSchemeDialog').style.top = parseInt($('TNTUrlSchemeDialog').style.top) + 60 + 'px';
    $('otntURLDiv').innerHTML = _urlScheme;
}


function otntSelectBox_selectedIndexChanged(id, isReload) {
    // Show loading gif
    $('otntLoadingDiv').style.display = 'block';

    new Ajax.Request('/Admin/Module/eCom_Catalog/dw7/edit/EcomOrder_Edit.aspx?AJAX=TrackTrace&TNTID=' + id, {
        onSuccess: function (response) {
            // Get values from response
            var jsonObj = response.responseText.evalJSON();
            var urlValue = jsonObj.urlValue;
            _urlScheme = urlValue;
            //$('otntURLDiv').innerHTML = "<img src='/Admin/Images/eCom/information.png'>" + urlValue + "</img>";
            //$('otntCheckDiv').innerHTML = "<input type='button' value='Look up' onclick='checkTNT(" + '"' + urlValue + '", ' + jsonObj.parametersLength + ")' style='width: 60px' class='NewUIinput' />";
            var html = "";
            if (jsonObj.parametersLength > 0) {
                var parameterNames = jsonObj.parameterNames;
                var parameterValues = isReload ? _parameterValues : jsonObj.parameterValues;
                var parameterDescrns = jsonObj.parameterDescriptions;
                html += "<table id='otntTable'>";
                for (var i = 0; i < parameterNames.length; i++) {
                    html += "<tr><td>" + parameterNames[i] + "</td><td><input type='text' id='otntParameterValue" + i + "' value='" + parameterValues[i] + "' style='width: 170px' class='NewUIinput'></input></td></tr>";
                    html += "<tr><td></td><td><small>*" + parameterDescrns[i] + "</small></td></tr>";
                }
                html += "</table>";
            }
            $('otntParametersDiv').innerHTML = html;
        },

        onFailure: function () {
            alert('Something went wrong!');
        },

        onComplete: function () {
            // Hide the loading div again
            $('otntLoadingDiv').style.display = 'none';
        }

    });

}


function help(){
    _helpMessage()
}

function registerNewRMA() {
    location.href = "/Admin/Module/eCom_Catalog/dw7/edit/EcomRma_Edit.aspx?OrderID=" + _orderId;
}

function showRMA(id) {
    location.href = "/Admin/Module/eCom_Catalog/dw7/edit/EcomRma_Edit.aspx?RmaID=" + id;
}
function changeViewToEdit() {
    changeView(1);
    $("orderInfoEdit").style.display = "";
    $("orderInfoShow").style.display = "none";

    $$("div.editControls").each(function(e) {

        e.style.display = "";
    });
    $$("div.showOrderInfo").each(function(e) {

        e.style.display = "none";
    });
    $$("div.editOrderInfo").each(function(e) {

        e.style.display = "";
    });

    $$("input[id^='OlQuantity']").each(function(e) 
    {
        e.removeAttribute('readonly');
        e.style.borderStyle = 'solid';
    });

    $$("input[id^='OlUnitPrice']").each(function (e) {
        e.removeAttribute('readonly');
        e.style.borderStyle = 'solid';
    });

    $$("input[id^='OlFieldValue']").each(function(e) 
    {
        e.removeAttribute('readonly');
        e.style.borderStyle = 'solid';
    });

    $$("input[id^='OlBOMQuantity']").each(function(e) 
    {
        e.removeAttribute('readonly');
        e.style.borderStyle = 'solid';
    });
    $('showEdit').value=true;
    showEdit=true;
}
function changeViewToDetails() {
    changeView(1);
    $('orderInfoEdit').style.display = 'none';
    $('orderInfoShow').style.display = '';
    $$("div.editControls").each(function(e) {
        e.style.display = "none";
    });
    $$("div.showOrderInfo").each(function(e) {
        e.style.display = "";
    });
    $$("div.editOrderInfo").each(function(e) {
        e.style.display = "none";
    });

    $$("input[id^='OlQuantity']").each(function(e) 
    {
        e.setAttribute('readonly', 'readonly');
        e.style.borderStyle = 'none';
    });

    $$("input[id^='OlFieldValue']").each(function(e) 
    {
        e.setAttribute('readonly', 'readonly');
        e.style.borderStyle = 'none';
    });

    $$("input[id^='OlBOMQuantity']").each(function(e) 
    {
        e.setAttribute('readonly', 'readonly');
        e.style.borderStyle = 'none';
    });

    $$("input[id^='OlUnitPrice']").each(function (e) {
        e.setAttribute('readonly', 'readonly');
        e.style.borderStyle = 'none';
    });

    $('showEdit').value=false;
    showEdit=false;
}

function AddProductOrDiscount() {
    $("AddingProductOrDiscount").value = "true";
    document.Form1.submit();
}

function UpdateLabel(textFieldId,labelId,containerDivClass)
{
    $(labelId).update($(textFieldId).value);
    if ($(textFieldId).value.length>0)
        $$("div."+containerDivClass).each(function(e) { e.style.display = ''; });
    else {
        $$("div."+containerDivClass).each(function(e) { e.style.display = 'none'; });
  
    }
    askConfirmation = true;
}
function UpdateName(prefixid, nameid, surnameid, firstnameid, initialId, custAttId, divId) {
    var title = ($(firstnameid).value.length > 0 ? $(firstnameid).value : $(nameid).value) + $(surnameid).value;
    if ($(initialId).value.length > 0) {
        $(custAttId).update($(prefixid).value + ' ' + title + ' (' + $(initialId).value + ')');
    } else {
        $(custAttId).update($(prefixid).value + ' ' + title);
    }
    if ($(initialId).value.length>0||$(prefixid).value.length>0||$(nameid).value.length>0||$(surnameid).value.length>0) {
        $$("div." + divId).each(function(e) { e.style.display = ''; });
    } else {
        $$("div."+divId).each(function(e) { e.style.display = 'none'; });
    }
}

function deleteOrderline(orderlineId) {
    $('deleteOrderlineId').value= orderlineId;
    document.Form1.submit();
}

function deletePartItem(OrderLineId) {
    $('deletePartItemId').value= OrderLineId;
    document.Form1.submit();
}

function updateCurrencyLabel(currencyTextId,currencyLabelId,currencySymbolId) {
    $(currencyLabelId).update($(currencySymbolId).value+" "+$(currencyTextId).value);
}
function AddNewProduct() {
    $("Name_ProductID").disabled = false;
			
    dialog.show('EditProductDialog');
}

function editOrderLine(productName, productLineId, discountLineId) {
    $("Name_ProductID").disabled = true;
    $("Name_ProductID").value = productName;
    $("DiscountParentOrderlineId").value = productLineId;
    $("DiscountOrderLineId").value = discountLineId;
}

function downloadOrderLineAttachment(fileName) {
    if (!fileName)
        return;

    if (fileName.indexOf('://') != -1)
        return;

    if (!fileName.indexOf("/") == 0)
        fileName = "/" + fileName;

    location.href = "/Admin/Public/Download.aspx?File=" + fileName + "&ForceDownload=True";
}

function createShippingDocuments() {
    if (confirm(shipQuestion)) {
        window.open("/Admin/Module/eCom_Catalog/dw7/CreateShippingDocuments.aspx?orderIDs=" + _orderId, "PrintShippingDocuments");
    }
}

function ValidateQuantity(event){
    var key = event.keyCode || event.which;

    if (key != 35 && key != 36 && key != 37 && key != 38 && key != 39 && key != 40 && key != 46 && key != 8) 
    {
        key = String.fromCharCode(key);
        var regex = /[0-9]|\.\,/;

        if (!regex.test(key)) 
        {
            event.returnValue = false;

            if (event.preventDefault) 
                event.preventDefault();
        }
    }
}

window.onload = function ()
{
    if (typeof showEdit != "undefined") {
        if (showEdit == true) {
            changeViewToEdit();
        }
    }

    $$("input[id^='OlQuantity']").each(function(e) 
    {
        e.observe('keypress', function(event) 
        {
            ValidateQuantity(event);
        });
    });

    $$("input[id^='OlUnitPrice']").each(function (e) {
        e.observe('keypress', function (event) {
            ValidateQuantity(event);
        });
    });
}

function showVisitorInfo(dialog, visitorID, orderID) {
    /// <summary>Shows the visitors popup dialog.</summary>
    /// <param name="visitorID">visitiorID</param>
    /// <param name="isLead">indicates if isLead</param>
    /// <param name="orderID">orderID</param>

    var d = eval(dialog);

    d.set_contentUrl('/Admin/Module/OMC/Leads/Details/Default.aspx?ID=' + visitorID + '&orderID=' + orderID);

    d.show();
}

function showTransactoinsList(giftCardID, giftCardCurrencyCode) {
    var url = '/Admin/Module/eCom_Catalog/dw7/GiftCards/GiftCardTransactionsList.aspx?GiftCardID=' + giftCardID + '&GiftCardCurrencyCode=' + giftCardCurrencyCode + '&FromEcom=true';
    var popup = giftCardTransactions_wnd;
    popup.set_contentUrl(url);
    popup.show();
}

function showFutureDeliveries(recurringId) {
    var url = '/Admin/Module/RecurringOrders/RecurringOrderDetails.aspx?RecurringOrderId=' + recurringId;
    var popup = pwFutureDeliveries_wnd;
    popup.set_contentUrl(url);
    popup.show();
}

function showPreviousDeliveries(recurringId) {
    var url = '/Admin/Module/Usermanagement/UserOrdersList.aspx?RecurringOrderId=' + recurringId + '&dialogMode=true';
    var popup = pwPreviousDeliveries_wnd;
    popup.set_contentUrl(url);
    popup.show();
}

function cancelRecurring(recurringId) {
    if (confirm(_cancelRecurringConfirmation)) {
        new Ajax.Request('/Admin/Module/RecurringOrders/RecurringOrderDetails.aspx', {
            method: 'post',
            parameters: {
                IsAjax : true,
                Cmd: 'Delete',
                RecurringOrderId: recurringId
            },
            onSuccess: function (transport) {
                window.location.reload()
            },
            onFailure: function () {
                alert('Cannot cancel recurring. Refresh and try again.');
            },
        });
    }
}