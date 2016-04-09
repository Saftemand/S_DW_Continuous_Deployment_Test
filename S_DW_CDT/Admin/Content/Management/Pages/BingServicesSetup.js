function cancel() {
    window.location = "/Admin/Content/Management/Start.aspx";
}

function bingTest() {
    var __o = new overlay('__ribbonOverlay');
    __o.show();
    $('TestResult').update("");
    var testWord = $('textTest').value;
    $('bingSetupForm').request({
        method: 'post',
        parameters: {
            cmd: 'testBing',
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