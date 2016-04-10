var vouchersList = {

    contentFrame: function () {
        return document.getElementById("ContentFrame");
    },

    showDialogVoucherAdd: function (listId) {
        vouchersManagerMain.showDialogVoucherAdd(listId)
    },

    showDialogSendMails: function (listId) {
        vouchersManagerMain.showDialogVouchersSendMails(listId)
    },

    downloadVouchersCSV: function (listId) {
        window.location = "VouchersList.aspx?cmd=ExportToCSV&ListID=" + listId;
    },

    showDialogGenerateVouchers: function (listId) {
        vouchersManagerMain.showDialogVouchersGenerate(listId)
    },

    deleteVouchers: function (listId) {
        var selectedVouchersArr = List.getSelectedRows("vouchersList")

        if (selectedVouchersArr.length == 0) {
            alert("No vouchers are selected!");
            return;
        }

        var confirmMessage = "Delete selected vouchers?";
        if (confirm(confirmMessage)) {

            // string with selected vouchers IDs in the format: '1','2','3'
            var selectedVouchersStr = ""
            for (var i = 0; i < selectedVouchersArr.length; i++) {
                if (i != 0) {
                    selectedVouchersStr += ",";
                }
                selectedVouchersStr += "'" + selectedVouchersArr[i].attributes.itemid.value + "'";
            }

            window.parent.open("VouchersActions.ashx?cmd=DeleteVouchers&listId=" + listId + "&Vouchers=" + selectedVouchersStr, "ContentFrame");
        }
    },

    deleteListRibbon: function (ListId) {
        var confirmMessage = "Delete current List?\n \nWARNING!\nAll posts in the list will be deleted!";

        if (confirm(confirmMessage)) {
            window.parent.open("VoucherList.ashx?cmd=DeleteList&ListID=" + ListId, "ContentFrame");
        }
    },

    activateList: function (ListId) {
        if (ListId == 0 || ListId == null) {
            ListId = ContextMenu.callingItemID;
        }
        window.location = "VouchersList.aspx?cmd=ActivateList&ListID=" + ListId + "&State=true";
    },

    deactivateList: function (ListId) {
        if (ListId == 0 || ListId == null) {
            ListId = ContextMenu.callingItemID;
        }
        window.location = "VouchersList.aspx?cmd=ActivateList&ListID=" + ListId + "&State=false";
    },

    viewOrder: function (orderID) {
        top.right.location = '/Admin/Module/eCom_Catalog/dw7/Edit/EcomOrder_Edit.aspx?ID=' + orderID;
    },

    callingItem: function () {
        var item = ContextMenu.callingItemID;
        return eval("(" + item + ")");
    },

    contextMenuView: function (sender, args) {
        /// <summary>Determines the contents of the context-menu.</summary>
        /// <param name="sender">Event sender.</param>
        /// <param name="args">Event arguments.</param>

        var ret = '';
        //            var row = null;
        //            var activeRows = 0;

        //            row = List.getRowByID('categoriesList', args.callingID);

        //            if (row.readAttribute('__active') == 'true') {
        //                ret = 'deactivate_cat';
        //            } else {
        ret = 'activate_cat';
        //            }
        return ret;
    },

    openInContentFrame: function (url) {
        url = this.makeUrlUnique(url);
        var cf = window.parent.document.getElementById("ContentFrame");
        if (cf) {
            cf.src = url;
        }
        else if (window.opener) {
            window.opener.location.href = url; //open in opener window
        }
        else {
            window.location.href = url; //reload current window
        }

    }
}
