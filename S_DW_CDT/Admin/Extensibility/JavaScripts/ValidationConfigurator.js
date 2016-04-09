// The ID of the ValidationConfigurator control
var controlID;
var ruleDropDownOrder = new Array()
var ruleDropDownDictionary = new Array();
var andOrDropDownDictionary = new Array();
var ruleUseParameter = new Array();
var validationFieldTypeDictionary = new Array();
var ruleTranslated;
var parametersTranslated;
var notEmptyErrorMsg;

function addValidation() {
    addValidationWithParams('', '', '', true, 'and', '', "true");
}

function addValidationWithParams(validationID, fieldName, fieldSystemName, doAddFirstRule, andOrSelected, preffix, allowEdit) {
    var div = document.getElementById(controlID + "ValidationDiv");
    var hiddenStyle
    if (allowEdit.toLowerCase() != 'true') {
        hiddenStyle = "display: none;";
    } else {
        hiddenStyle = "";
    }

    if (fieldSystemName == '') {
        var dropDown = document.getElementById(controlID + 'Dropdown');
        fieldName = dropDown.options[dropDown.selectedIndex].text;

        fieldSystemName = dropDown.value;
        preffix = fieldSystemName.indexOf('EcomOrderVoucherCode') != -1 ? 'vauchers' : 'others';

        if (fieldSystemName == '')
            return;
    }

    var validationCount = getValidationCount();

    var id = controlID + '_' + validationCount;
    
    div.innerHTML += '<div ID="' + id + '_div">' +
                        '<br /><br />' +
                        '<div style="margin-bottom:5px; float:left" >' +
                            '<span style="font-weight:bold;" valign="top">' + fieldName + '</span>&nbsp;&nbsp;' +
                        '</div>' +
                        getAndOrDropDown(id + "_andOrDropDown", andOrSelected, allowEdit) + '&nbsp;&nbsp;' +
                        '<img src="/Admin/Module/eCom_Catalog/images/delete_small.gif" style="' + hiddenStyle + '" onclick="deleteValidation(' + validationCount + ');" />' +
                        '<div style="margin-left:20px; margin-top:5px; clear:both">' +
                            '<table ID="ValidationTable_' + validationCount + '" rules="rows" cellpadding="3px" cellspacing="0px" style="border:1px solid #9FAEC2;">' +
                                '<tr style="background-color:#ECF4FC; border:1px solid #9FAEC2;">' +
                                    '<td style="font-weight:bold; width:100px; color:#15428B;">' + ruleTranslated + '</td>' +
                                    '<td style="font-weight:bold; width:250px; color:#15428B;">' + parametersTranslated + '</td>' +
                                    '<td style="width:20px"><img src="/Admin/Module/eCom_Catalog/images/add_small.gif" onclick="addRule(' + validationCount + ', \'' + preffix + '\');"</td>' +
                                '</tr>' +
                            '</table>' +
                            '<input type="hidden" name="' + id + '_fieldSystemName" id="' + id + '_fieldSystemName" value="' + fieldSystemName + '" />' +
                            '<input type="hidden" name="' + id + '_ruleCounter" id="' + id + '_ruleCounter" value="0" />' +
                            '<input type="hidden" name="' + id + '_trueRuleCounter" id="' + id + '_trueRuleCounter" value="0" />' +
                            '<input type="hidden" name="' + id + '_valID" id="' + id + '_valID" value="' + validationID + '" />' +
                            '<input type="hidden" name="' + id + '_valType" id="' + id + 'valType" value="' + validationFieldTypeDictionary[fieldSystemName] + '" />' +
                        '</div>' +
                        '<div id="' + id + '_errorMsg" style="color:red"></div>' +
                    '</div>';
                        
    incValidationCount();
    
    // Add the first rule
    if (doAddFirstRule)
        addRule(validationCount, preffix);
}

function addRule(validationIndex, preffix) {
    addRuleWithParams(validationIndex, '', '', '', preffix, "true");
}

function addRuleWithParams(validationIndex, ruleID, ruleSystemName, params, preffix, allowEdit) {
    var ruleCount = getRuleCount(validationIndex);
    var idPrefix = controlID + '_' + validationIndex + '_' + ruleCount;
    if (allowEdit.toLowerCase() != 'true') {
        hiddenStyle = "display: none;";
    } else {
        hiddenStyle = "";
    }
    
    var row = document.getElementById('ValidationTable_' + validationIndex).insertRow(-1);
    row.insertCell(-1).innerHTML = getRuleDropDown(validationIndex, ruleCount, ruleSystemName, preffix, allowEdit) +
                                 '<input type="hidden" id="' + idPrefix + '_ruleID" name="' + idPrefix + '_ruleID" value="' + ruleID + '" />' + 
                                 '<input type="hidden" id="' + idPrefix + '_ruleSystemName" name="' + idPrefix + '_ruleSystemName" value="' + ruleSystemName + '" />';
    row.insertCell(-1).innerHTML = '<input type="text" id="' + idPrefix + '_params" name="' + idPrefix + '_params" value="' + params + '" size="50" class="NewUIInput" />';
    row.insertCell(-1).innerHTML = '<img src="/Admin/Module/eCom_Catalog/images/delete_small.gif" style="' + hiddenStyle + '" onclick="deleteRule(' + validationIndex + ', ' + ruleCount + ');" />';
    row.style.border = "1px solid #9FAEC2";
    row.id = idPrefix + "_row";
    
    updateParamsTextbox(validationIndex, ruleCount, document.getElementById(idPrefix + "_ruleSelector").value, allowEdit);
    incRuleCount(validationIndex);
    updateAndOr(validationIndex);
}

function deleteRule(validationIndex, ruleIndex) {
    var ruleID = document.getElementById(controlID + '_' + validationIndex + '_' + ruleIndex + '_ruleID').value
    if (ruleID != '') {
        deletedRules = document.getElementById(controlID + "_deletedRules");
        deletedRules.value = deletedRules.value + ruleID + ' ';
    }

    var table = document.getElementById('ValidationTable_' + validationIndex);
    for (var i = 0; i < table.rows.length; i++) {
        var row = table.rows[i];
        if (row.id == controlID + '_' + validationIndex + '_' + ruleIndex + "_row") {
            table.deleteRow(row.rowIndex);
            decRuleCount(validationIndex);
            updateAndOr(validationIndex);
            return;
        }
    }
}

function updateAndOr(validationIndex) {
    var andOrDropDown = document.getElementById(controlID + '_' + validationIndex + '_andOrDropDown')
    
    if (getTrueRuleCount(validationIndex) > 1)
        andOrDropDown.style.display = '';
    else
        andOrDropDown.style.display = 'none';
}
function updateParamsTextbox(validationIndex, ruleIndex, ruleSystemName, allowEdit) {
    var useParameter = ruleUseParameter[ruleSystemName];
    var textbox = document.getElementById(controlID + '_' + validationIndex + '_' + ruleIndex + '_params')
    if (useParameter) {
        textbox.style.display = '';

        if (allowEdit.toLowerCase() != 'true') {
            textbox.disabled = true
        }

        var idPrefix = controlID + '_' + validationIndex + '_' + ruleIndex;
        var systemName = document.getElementById(idPrefix + "_ruleSystemName");
        systemName.value = ruleSystemName;
    }
    else
        textbox.style.display = 'none';
}

function deleteValidation(validationIndex) {
    var valID = document.getElementById(controlID + '_' + validationIndex + '_valID').value
    if (valID != '') {
        deletedValidations = document.getElementById(controlID + "_deletedValidations");
        deletedValidations.value = deletedValidations.value + valID + ' ';
    }

    removeElementById(controlID + '_' + validationIndex + '_div');
}

function removeElementById(elemId) {
    var elem = document.getElementById(elemId);
    if (elem.parentNode) {
        elem.parentNode.removeChild(elem);
    }
}

function getRuleDropDown(validationIndex, ruleIndex, selectedSystemName, preffix, allowEdit) {
    if (allowEdit.toLowerCase() != 'true') {
        disabledParam = "disabled='true'";
    } else {
        disabledParam = "";
    }
    var id = controlID + '_' + validationIndex + '_' + ruleIndex + '_ruleSelector';
    var html = '<select id="' + id + '" name="' + id + '" onchange="updateParamsTextbox(' + validationIndex + ', ' + ruleIndex + ', this.value, ' + allowEdit + ')" class="NewUIInput" ' + disabledParam + ' >';
    
    preffix += '-'; 
    selectedSystemName = preffix + selectedSystemName;
    
    var ruleSystemName = '', ruleNiceName = '';
    for (var i = 0; i < ruleDropDownOrder.length; i++) {
            ruleSystemName = ruleDropDownOrder[i];
            ruleNiceName = ruleDropDownDictionary[ruleSystemName];

            if (ruleSystemName.indexOf(preffix) != -1) {
                html += '<option ' + disabledParam + ' value="' + ruleSystemName + '"';
                if (ruleSystemName == selectedSystemName)
                    html += ' selected="selected"';
                html += '>' + ruleNiceName + '</option>';
            }
    }
    html += '</select>';
    return html;
}
function getAndOrDropDown(id, selected, allowEdit) {
    if (allowEdit.toLowerCase() != 'true') {
        disabledParam = "disabled='true'";
    } else {
        disabledParam = "";
    }
    var html = '<select ' + disabledParam + ' style="display:none" id="' + id + '" name="' + id + '" class="NewUIInput">', key = '';
    var keys = ['and', 'or'];

    for (var i=0; i < keys.length; i++) {
        key = keys[i];
        html += '<option ' + disabledParam + ' value="' + key + '"';
        if (key == selected)
            html += ' selected="selected"';
        html += '>' + andOrDropDownDictionary[key] + '</option>';
    }
    html += '</select>';
    return html;
}

function getRuleCount(validationIndex) {
    return document.getElementById(controlID + '_' + validationIndex + '_ruleCounter').value
}
function getTrueRuleCount(validationIndex) {
    return document.getElementById(controlID + '_' + validationIndex + '_trueRuleCounter').value
}
function incRuleCount(validationIndex) {
    var ruleCounterHidden = document.getElementById(controlID + '_' + validationIndex + '_ruleCounter')
    ruleCounterHidden.value = parseInt(ruleCounterHidden.value) + 1;
    
    var trueRuleCounterHidden = document.getElementById(controlID + '_' + validationIndex + '_trueRuleCounter')
    trueRuleCounterHidden.value = parseInt(trueRuleCounterHidden.value) + 1;
}
function decRuleCount(validationIndex) {
    var trueRuleCounterHidden = document.getElementById(controlID + '_' + validationIndex + '_trueRuleCounter')
    trueRuleCounterHidden.value = parseInt(trueRuleCounterHidden.value) - 1;
}

function getValidationCount() {
    return document.getElementById(controlID + '_validationCounter').value
}
function incValidationCount() {
    var validationCounterHidden = document.getElementById(controlID + '_validationCounter')
    validationCounterHidden.value = parseInt(validationCounterHidden.value) + 1;
}

function validateParameters() {
    var success = true;
    for (var valIndex = 0; valIndex < getValidationCount(); valIndex++) {
        var errorDiv = document.getElementById(controlID + '_' + valIndex + '_errorMsg');
        if (errorDiv) { // validation is avalable
            errorDiv.innerHTML = '';
            for (var ruleIndex = 0; ruleIndex < getRuleCount(valIndex); ruleIndex++) {
                var ruleIDPrefix = controlID + '_' + valIndex + '_' + ruleIndex;
                var systemName = document.getElementById(ruleIDPrefix + '_ruleSystemName');
                if (systemName) { //rule is avalable
                    if (ruleUseParameter[systemName.value]) {
                        var ruleParam = document.getElementById(ruleIDPrefix + '_params').value;
                        if (ruleParam.length == '') {
                            errorDiv.innerHTML = notEmptyErrorMsg;
                            success = false;
                        }
                    }
                }
            }
        }
    }
    return success;
}