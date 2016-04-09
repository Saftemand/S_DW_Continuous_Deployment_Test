function AreEmpty(form)
{
	var i = 0;
	var ret = false;
	for(;i < form.length; i++)
	{
	    if(!form.elements[i]._optional && form.elements[i].type != "file" &&
			form.elements[i].type != "hidden" && IsEmpty(form.elements[i].value))
		{
			ret = true;
			break;
		}
	}
	
	if(ret)
		ShowError(document.getElementById("ErrorRequired"));
	return ret;
}

function ValidateWithAjax(url, validatorID)
{
	var ret = false;
	var valID = (typeof(validatorID) != 'undefined' ? validatorID : "ErrorUnique");
	
	__SendXmlHttpRequest(url);
	ret = __StateChanged();
	if(!ret)
		ShowError(document.getElementById(valID));
		
	return ret;
}

function IsEmpty(value)
{
	return (value == "");
}

function AreEqual(val, val2)
{
	var ret = (val == val2);
	
	if(!ret)
		ShowError(document.getElementById("ErrorEqual"));
	return ret;
}
	
function IsValidEmail(value)
{
	var ret;
	if(value != "")
	{
		var re = /(?:[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+\.)*[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!\.)){0,61}[a-zA-Z0-9]?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\[(?:(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\]))/;
		ret = value.match(re);
		if(ret == null)
		{
			ret = false;
			ShowError(document.getElementById("ErrorRegexp"));
		}
		else
			ret = true;
	}
	return ret;
}

function IsCorrectValue(value)
{
	var ret = true;
	var i = 0;
	var allowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890_@.";
	
	for(; i < value.length; i++)
	{
		if(allowedChars.indexOf(value.charAt(i)) == -1)
		{
			ret = false;
			break;
		}
	}
	
	if(!ret)
		ShowError(document.getElementById("ErrorRestricted"));
	return ret;	
}

function ShowError(error)
{
	error.style.display = "";
}