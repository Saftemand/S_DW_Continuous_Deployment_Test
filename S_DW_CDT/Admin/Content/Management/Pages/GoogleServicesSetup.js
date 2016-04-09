function cancel() {
    window.location = "/Admin/Content/Management/Start.aspx";
}

function googleTest() {
    var __o = new overlay('__ribbonOverlay');
    __o.show();
    var testWord = $('textTest').value;
    $('googleSetupForm').request({
        method: 'post',
        parameters: {
            cmd: 'testGoogle',
            word: testWord
        },

        onSuccess: function (response) {
            $('TestResult').update(response.responseText);
        },
        onComplete: function (response) {
            var __o = new overlay('__ribbonOverlay');
            __o.hide();
        }

    });
}