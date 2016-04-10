function ShowLinks() {
    var position = window.location.search.indexOf('showLinks=true');
    if (position > 0) {
        document.getElementById('showLinks').style.display = 'block';
    }
};

window.onload = function () {
    ShowLinks();
};

function SendProposalByEmail() {
    new Ajax.Request('/default.aspx?CatalogPublishingcmd=createAttachment', {
        onSuccess: function (response) {
            $('FM_Attachments').value = response.responseText;
            setDialogVisibility(true);
        }
    });
};
function OnLoad() {
    //code for prototype 
    try {
        ShowLinks();
        //set default value for each "cost" input
        $$('input.cost').each(
				    function (n)
				    { n.setValue(n.defaultValue) })
        //set default value for each "quantity" input
        $$('input.quantity').each(
				    function (n)
				    { n.setValue(n.defaultValue) })
        //set default value
        $('TotalCost').value = $('TotalCost').defaultValue;
    }
    //code for jQuery
    catch (err) {
        //set default value for each "cost" input
        $('input.cost').each(
				    function (n) {
				        $(this)[0].value = $(this)[0].defaultValue;
				    })
        //set default value for each "quantity" input
        $('input.quantity').each(
				    function (n) {
				        $(this)[0].value = $(this)[0].defaultValue;
				    })
        //set default value
        $('input#TotalCost')[0].value = $('input#TotalCost')[0].defaultValue;
    }
}
//recalculate 
function Recalc() {
    try {
        var total = 0;
        $$('input.cost').each(
				        function (n) {
				            if (!isNaN(parseFloat(n.value)) && isFinite(n.value))
				                total += parseFloat(n.value)
				            else alert("wrong number " + n.value);
				        }
                    )
        $('TotalCost').value = total;
    }
    catch (err) {
        var total = 0;
        $('input.cost').each(
				    function (n) {
				        if (!isNaN(parseFloat($(this)[0].value)) && isFinite($(this)[0].value))
				            total += parseFloat($(this)[0].value)
				        else alert("wrong number " + $(this)[0].value)
				    })
        $('input#TotalCost')[0].value = total;
    }
}