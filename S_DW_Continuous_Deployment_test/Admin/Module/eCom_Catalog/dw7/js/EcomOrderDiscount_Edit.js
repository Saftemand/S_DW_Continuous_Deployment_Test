if (typeof (Dynamicweb) == 'undefined') {
    var Dynamicweb = new Object();
}

if (typeof (Dynamicweb.eCommerce) == 'undefined') {
    Dynamicweb.eCommerce = new Object();
}

Dynamicweb.eCommerce.OrderDiscounts = function () { }

Dynamicweb.eCommerce.OrderDiscounts.AddProduct = function(fieldName) {
    if (fieldName != "") {
        var caller = 'opener.document.forms.formOrderDiscount_edit.' + fieldName;
        window.open("/Admin/Module/eCom_Catalog/dw7/Edit/EcomGroupTree.aspx?CMD=ShowProd&AddCaller=1&caller=" + caller, "", "displayWindow,width=460,height=400,scrollbars=no");
    }
}

Dynamicweb.eCommerce.OrderDiscounts.RemoveProduct = function(fieldName) {
    if (fieldName != "") {
        document.getElementById("ID_" + fieldName).value = '';
        document.getElementById("VariantID_" + fieldName).value = '';
        document.getElementById('Name_' + fieldName).value = '';
    }
}


Dynamicweb.eCommerce.OrderDiscounts.showDiscountType = function(discountType) {
    var sd = $("shopDiv");
    if (discountType == 1) {
        $("amountDiv").style.display = "";
        $("currencyDiv").style.display = "";
        $("percentageDiv").style.display = "none";
        $("productDiv").style.display = "none";
        if (sd) {
            sd.style.display = "none";
        }
    } else if (discountType == 2) {
        $("amountDiv").style.display = "none";
        $("currencyDiv").style.display = "none";
        $("percentageDiv").style.display = "";
        $("productDiv").style.display = "none";
        if (sd) {
            sd.style.display = "none";
        }
    } else if (discountType == 3) {
    	$("amountDiv").style.display = "none";
    	$("currencyDiv").style.display = "none";
    	$("percentageDiv").style.display = "none";
    	$("productDiv").style.display = "";
    	if (sd) {
    		sd.style.display = "none";
    	}
    } else {
        $("amountDiv").style.display = "none";
        $("currencyDiv").style.display = "none";
        $("percentageDiv").style.display = "none";
        $("productDiv").style.display = "none";
        if (sd) {
            sd.style.display = ""
        }
    }
}
        
Dynamicweb.eCommerce.OrderDiscounts.showOrderFieldType = function(orderFieldType) {
    if (orderFieldType == 1) {
        $("txRadioOrderFieldValue").style.display = "";
        $("orderDiscountVoucherList").style.display = "none";
    } else {
        $("txRadioOrderFieldValue").style.display = "none";
        $("orderDiscountVoucherList").style.display = "";
    }
}

Dynamicweb.eCommerce.OrderDiscounts.showOrderFieldsOption = function() {
    var orderFieldSelect = $("orderFields");
    var index = orderFieldSelect.selectedIndex;
    if (index == 0) {
        $("OrderFieldValueDiv").style.display = "none";
        $("rbOrderFieldValueDiv").style.display = "none";
        $("VoucherListsDiv").style.display = "none";
    } else if (index == 1) {
        if ($("OrderFieldType1").checked) {
            $("OrderFieldValueDiv").style.display = "none";
            $("rbOrderFieldValueDiv").style.display = "";
            $("VoucherListsDiv").style.display = "";
            $("OrderFieldType1").checked = true;
            $("OrderFieldType2").checked = false;
            Dynamicweb.eCommerce.OrderDiscounts.showOrderFieldType(1);
        } else {
            $("OrderFieldValueDiv").style.display = "none";
            $("rbOrderFieldValueDiv").style.display = "";
            $("VoucherListsDiv").style.display = "";
            $("OrderFieldType1").checked = false;
            $("OrderFieldType2").checked = true;
            Dynamicweb.eCommerce.OrderDiscounts.showOrderFieldType(2)
        }
    } else {
        $("OrderFieldValueDiv").style.display = "";
        $("rbOrderFieldValueDiv").style.display = "none";
        $("VoucherListsDiv").style.display = "none";
    }
}

Dynamicweb.eCommerce.OrderDiscounts.checkName = function() {
    var name = $("txName").value;
    if (name.length == 0) {
        alert("Name of discount can't be empty. Please specify name of discount");
        $("txName").focus();
        return false;
    } else {
        return true;
    }
}

Dynamicweb.eCommerce.OrderDiscounts.submit = function (close) {
    if (Dynamicweb.eCommerce.OrderDiscounts.checkName()) {
        document.getElementById("Close").value = close ? 1 : 0;
        __doPostBack();
    }
}

Dynamicweb.eCommerce.OrderDiscounts.redirectToList = function () {
    document.location.href = '/Admin/Module/eCom_Catalog/dw7/lists/EcomOrderDiscount_List.aspx';
}

Dynamicweb.eCommerce.OrderDiscounts.CheckApplyAsState = function () {
    var fsCnt = $("free-shiping-chb-cnt");
    var flag = $("ApplyAs2").checked;
    if (flag && $("DiscountType4").checked) {
        $("DiscountType1").checked = true;
        Dynamicweb.eCommerce.OrderDiscounts.showDiscountType(1);
    }
    if (flag) {
        fsCnt.hide();
    } else {
        fsCnt.show();
    }
}

Dynamicweb.eCommerce.OrderDiscounts.init = function () {
    Dynamicweb.eCommerce.OrderDiscounts.CheckApplyAsState();
    document.getElementById('txName').focus();
    $("DiscountType1").style.marginLeft = "2px";
    $("DiscountType2").style.marginLeft = "2px";
    $("DiscountType3").style.marginLeft = "2px";
    $("DiscountType4").style.marginLeft = "2px";
    if ($("DiscountType1").checked) {
        Dynamicweb.eCommerce.OrderDiscounts.showDiscountType(1);
    } else if ($("DiscountType2").checked) {
        Dynamicweb.eCommerce.OrderDiscounts.showDiscountType(2);
    } else if ($("DiscountType3").checked) {
        Dynamicweb.eCommerce.OrderDiscounts.showDiscountType(3);
    }
    Dynamicweb.eCommerce.OrderDiscounts.showOrderFieldsOption();
    $$("input[name='ApplyAs']").invoke("on", "click", function (e, el) {
        Dynamicweb.eCommerce.OrderDiscounts.CheckApplyAsState();
    });
}