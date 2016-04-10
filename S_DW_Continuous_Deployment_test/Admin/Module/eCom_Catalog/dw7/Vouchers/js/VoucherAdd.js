var voucherAdd = {
    PostbackForm: function (listID) {
        $('voucherAddFrom').request({
            onComplete: function (transport) {
                var result = JSON.parse(transport.responseText);
                if (result.message) {
                    alert(result.message);
                }
                if (result.reload) {
                    var voucherCodeTextBox = $('voucherCode');
                    if (voucherCodeTextBox != null)
                        voucherCodeTextBox.value = '';
                    window.parent.vouchersManagerMain.hideDialog('vouchersGeneratorDialog');
                    window.parent.vouchersManagerMain.showVouchersList(listID);
                }
            }
        })
    }


}
