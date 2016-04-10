/* File Created: januar 2, 2012 */
function toggleAll() {
    if ($("checkAll").checked) {
        $$('.tableMappingCheckbox').each(
        function (ele) {
            $(ele).childElements().each(function (checkbox) { checkbox.checked = true; });

        })
        $$('.destinationTableControl').each(function (select) { select.style.visibility = 'visible' });
    }
    else {
        $$('.tableMappingCheckbox').each(
        function (ele) {
            $(ele).childElements().each(function (checkbox) { checkbox.checked = false; });
        })
        $$('.destinationTableControl').each(function (select) { select.style.visibility = 'hidden' });

    }
}