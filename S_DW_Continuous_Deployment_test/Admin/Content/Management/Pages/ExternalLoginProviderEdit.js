if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.ExternalLogin) == 'undefined') {
    Dynamicweb.ExternalLogin = new Object();
}

Dynamicweb.ExternalLogin.ProviderEdit = {
    terminology: {},

    save: function (close) {
        this.removeUnloadEvent();
        if (!Toolbar.buttonIsDisabled('cmdSave') && this.validate()) {
            document.getElementById('Cmd').value = 'Save' + (close ? ',Close' : '');

            this.progress();
            this.submit();
        }
    },

    progress: function (cmd) {
        var o = new overlay('WaitSpinner');

        if (cmd == 'hide') {
            o.hide();
        } else {
            o.show();
        }
    },

    submit: function () {
        this.removeUnloadEvent();
        document.getElementById('ProviderForm').submit();
    },

    saveAndClose: function () {
        this.removeUnloadEvent();
        this.save(true);
    },

    cancel: function () {
        this.removeUnloadEvent();
        location.href = '/Admin/Content/Management/Pages/ExternalLoginProvidersList.aspx';
    },

    deleteProvider: function () {
        this.removeUnloadEvent();
        if (confirm(this.terminology.DeleteConfirm)) {
            document.getElementById('Cmd').value = 'Delete,Close';
            ProviderForm.submit();
        }
    },

    validate: function () {
        var providerSelected = function (msg) {
            var result = true;
            var e = document.getElementById('Dynamicweb.Modules.UserManagement.ExternalAuthentication.ExternalLoginProvider_AddInTypes');

            if (!e.options[e.selectedIndex].value) {
                alert(msg);
                result = false;
            }

            return result;
        }

        return IsControlValid(document.getElementById('txtProviderName'), this.terminology.ProviderNameRequired) &&
            providerSelected(this.terminology.ProviderRequired);
    },    

    showLeaveConfirmation: function () {
        window.onbeforeunload = function () {
            return "This page is asking you to confirm that you want to leave - data you have entered may not be saved.";
        };
    },

    removeUnloadEvent: function () {
        window.onbeforeunload = null;
    }
};


