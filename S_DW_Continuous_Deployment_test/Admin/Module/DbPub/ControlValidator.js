function IsNotEmpty(field, validator)
{
    SetValidator(validator, GetStrValue(field).length == 0);
}

function IsEMailAddr(field, validator) 
{
    var re = /([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})/;
    var val = GetStrValue(field);
    SetValidator(validator, val.length > 0 && !val.match(re));
}

function ArePasswordsEqual(field, validator) 
{
    SetValidator(validator, GetStrValue(field) != GetStrValue(field + "2"));
}

function IsInteger(field, validator)
{
    var val = GetStrValue(field);
    var isnum = val.length = 0 || (!isNaN(val) && Math.round(val) == val);
    SetValidator(validator, !isnum);
}

function IsDecimal(field, validator)
{
    var val = GetStrValue(field);
     val = val.replace(/[',']+/g, ".");
    var isnum = val.length = 0 || !isNaN(val);
    SetValidator(validator, !isnum);
}

function IsAllowedLength(field, validator, maxLen)
{
    var val = GetStrValue(field);
    var allow = val.length <= maxLen;
    SetValidator(validator, !allow);
}

function GetStrValue(name)
{
    var elem = document.getElementById(name);
    return elem ? elem.value : "";
}

function SetValidator(name, visible)
{
    var validator = document.getElementById(name);
    if (validator)
        validator.style.display = visible ? "" : "none";
    SetResult(!visible);
}

function SetResult(flag)
{
    if (typeof(__isFormValid) != "undefined")
        __isFormValid = __isFormValid && flag;
}