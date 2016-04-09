var vouchersGenerator = {
    PostbackForm: function (listID) {
        if (!(!isNaN(parseInt($(numberOfVouchersClientID).value)) && isFinite($(numberOfVouchersClientID).value)))
        {
            alert("Only numbers are accepted");
            return false;
        }
        if(parseInt($(numberOfVouchersClientID).value) > 50000){
            alert(maxNumberOfVouchersExceededWarning);  //Not possible to generate more than 50000 vouchers at a time
            return false;
        }
        
        $('formmode').value = 'GenerateVouchers';
        $('vouchersGeneratorForm').request(
            {
                onComplete: function(transport) {
                    alert('Vouchers have been generated.');
                    window.parent.vouchersManagerMain.hideDialog('vouchersGeneratorDialog');
                    window.parent.vouchersManagerMain.showVouchersList(listID);
                }
            });
        return true;
    },

    GetNumberOfUsers: function () {
        $('formmode').value = 'CalculateNumberOfUsers';
        $('vouchersGeneratorForm').request(
        {
            onComplete: function (transport) {
                $(numberOfVouchersClientID).value = transport.responseText;
                vouchersGenerator.CloseDialog();
            }
        })
    },

    CloseDialog: function() {
            dialog.hide('GenerateVouchersUsersDialog');;
        },

    ShowDialogVouchersGenerateUsers: function () {
        var d;
        if (typeof (dialog) == 'undefined') {
            d = window.parent.dialog;
        }
        else {
            d = dialog;
        }
        d.show('GenerateVouchersUsersDialog');
    },



}
