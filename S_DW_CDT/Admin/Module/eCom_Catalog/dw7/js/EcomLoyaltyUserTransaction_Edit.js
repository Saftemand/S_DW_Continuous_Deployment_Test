if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.eCommerce) == 'undefined') {
    Dynamicweb.eCommerce = new Object();
}

if (typeof (Dynamicweb.eCommerce.Loyalty) == 'undefined') {
    Dynamicweb.eCommerce.Loyalty = new Object();
}

Dynamicweb.eCommerce.Loyalty.Transactions = function () { };


Dynamicweb.eCommerce.Loyalty.Transactions.closeWindow = function (reloadParent) {
    parent.pupNewTransaction_wnd.hide();
    parent.parent.pupUserTransactions_wnd.reload();
}

Dynamicweb.eCommerce.Loyalty.Transactions.createTransaction = function (customerID) {
    var pointsNum = $('pointsNum').value;
    var isvalid = (pointsNum != 0);
    $('containerED').className = isvalid ? 'hidden' : '';
    if (isvalid) {
        var commentText = $('transactionComment').value;
        new Ajax.Request("/Admin/Module/eCom_Catalog/dw7/edit/EcomLoyaltyUserTransaction_Edit.aspx", {
            asynchronous: false,
            method: 'post',
            parameters: { AjaxCmd: 'create', userID: customerID, points: pointsNum, comment: commentText },
            onSuccess: function (request) {
                if (request.responseText == 'ok') {
                    $('containerED').className = 'hidden';
                    $('containerNP').className = '';
                    Dynamicweb.eCommerce.Loyalty.Transactions.closeWindow()
                }
                else if (request.responseText == 'empty_points') {
                    $('containerED').className = ' ';
                }
                else if (request.responseText == 'points_error') {
                    $('containerNP').className = '';
                }
                document.getElementById("ddGroup").innerHTML = request.responseText;
                this.clearFields('shop');
            }
        });
    }
    else
    {
        return;
    }
}