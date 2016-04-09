function setNone(id) {
    document.getElementById(id).value = "";
    var el = document.getElementById(id + '_some_main_div');
    if (el) {
        el.style.display = 'none';
    }
    el = document.getElementById(id + '_list_shop');
    if (el) {
        el.setAttribute('disabled', 'disabled');
    }
}

function setAll(id) {
    document.getElementById(id).value = '[all]' + '[s:' + document.getElementById(id + '_list_shop').value + ']';
    var el = document.getElementById(id + '_some_main_div');
    if (el) {
        el.style.display = 'none';
    }
    el = document.getElementById(id + '_list_shop');
    if (el) {
        el.removeAttribute('disabled');
    }
}

function setSome(id) {
    var isSubgroups = document.getElementById(id + '_checkbox_subgroups');
    var value = (isSubgroups && isSubgroups.checked) ? '[someincluded]' : '[some]';
    value += document.getElementById(id + '_some_value').value;
    document.getElementById(id).value = value;
    var el = document.getElementById(id + '_some_main_div');
    if (el) {
        el.style.display = 'block';
    }
    el = document.getElementById(id + '_list_shop');
    if (el) {
        el.setAttribute('disabled', 'disabled');
    }
}

function setSubItems(id) {
    document.getElementById(id).value = '[subitems]';
    var el = document.getElementById(id + '_some_main_div');
    if (el) {
        el.style.display = 'none';
    }
    el = document.getElementById(id + '_list_shop');
    if (el) {
        el.setAttribute('disabled', 'disabled');
    }
}

function deleteSelectedProductsAndGroups(valueFieldID) {
    // Copy-paste from deleteSelectedProducts
    // Only changed the method removing the products and groups from the hidden value
    var selectedItems = getElementsByClass("osselecteditem", document, "div");
    var valueObject = document.getElementById(valueFieldID);

    for(var i = 0; i < selectedItems.length; i++) {
        var selectedItem = selectedItems[i];

        // Regex
        var productRegex = /imgp_([\S]+)/;
        var groupRegex = /imgg_([\S]+)/;
        var searchRegex = /imgss_([\S]+)/;
        var inner = selectedItem.innerHTML;
        var productResult = inner.match(productRegex);
        var groupResult = inner.match(groupRegex);
        var searchResult = inner.match(searchRegex);

        // String to remove from value
        var stringToRemove = "";
        if(productResult != 'undefined' && productResult != null)
            stringToRemove = "p:" + productResult[1];
        else if(groupResult != 'undefined' && groupResult != null)
            stringToRemove = "g:" + groupResult[1];
        else if (searchResult != 'undefined' && searchResult != null)
            stringToRemove = "ss:" + searchResult[1];

        if(stringToRemove != "") {
            // Remove from box
            selectedItem.innerHTML = '';
            selectedItem.outerHTML = '';
            //Remove the last character of the stringToRemove in firefox, since IE removes " from standard attributes, and firefox does not.
            if (stringToRemove.charAt(stringToRemove.length - 1) == '"'){
                stringToRemove = stringToRemove.slice(0, -1);
            }
            // Remove from hidden value
            var newValue = valueObject.value;
            newValue = replaceSubstring(newValue, ";[" + stringToRemove + "]", "");
            newValue = replaceSubstring(newValue, "[" + stringToRemove + "];", "");
            newValue = replaceSubstring(newValue, "[" + stringToRemove + "]", "");
            valueObject.value = newValue;
            valueObject.onchange();
        }
    }
}
