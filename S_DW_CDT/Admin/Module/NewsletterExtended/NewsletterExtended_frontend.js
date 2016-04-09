function newsletterExtendedTextFieldCheck(objField, type, fieldname) {
	if(objField.value != '') {
		if(type==1) {
			if(chkNumeric(objField,-9999999999999999999999999999,9999999999999999999999999999,',','','', fieldname, '', ''))
					objField.value=""
		} else if(type==2) {
			if(chkNumeric(objField,-2147483648,2147483648,'','','', fieldname, '', ''))
					objField.value=""
		} 
	}
}


function chkNumeric(objName,minval,maxval,comma,period,hyphen, strFieldName, strString1, strString2)
{
	// only allow 0-9 be entered, plus any values passed
	// (can be in any order, and don't have to be comma, period, or hyphen)
	// if all numbers allow commas, periods, hyphens or whatever,
	// just hard code it here and take out the passed parameters
	var checkOK = "0123456789" + comma + period + hyphen;

	var checkStr = objName;
	var allValid = true;
	var decPoints = 0;
	var allNum = "";

	for (i = 0;  i < checkStr.value.length;  i++)
	{
		ch = checkStr.value.charAt(i);
		if(i == 0 && ch=="-")
		{
		XXX=1;
		}
		else 
		{
			for (j = 0;  j < checkOK.length;  j++)
			if (ch == checkOK.charAt(j))
			break;
			if (j == checkOK.length)
			{
				allValid = false;
				break;
			}
			if (ch != ",")
			allNum += ch;
		}
	}

	if (!allValid)
	{	
		alertsay = "";

		if (strString1 != "")
			{
			alertsay = strString1
			}
		else
			{
			alertsay = "The field ´%FieldName%´ can only contain the following characters:\n%checkOK%"
			} 
		alertsay = alertsay.replace("%checkOK%", checkOK);
		alertsay = alertsay.replace("%FieldName%", strFieldName);
		alert(alertsay);
		return (false);
	}

	// set the minimum and maximum
	var chkVal = allNum;
	var prsVal = parseInt(allNum);
	if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval))
	{
		if (strString2 != "")
			{
			alertsay = strString2;
			}
		else
			{ 
			alertsay = 'The field ´%FieldName%´ can only contain numbers in the following interval:\n%minval% - %maxval%';
			}
		alertsay = alertsay.replace("%minval%", minval);
		alertsay = alertsay.replace("%maxval%", maxval);
		alertsay = alertsay.replace("%FieldName%", strFieldName);

		alert(alertsay);
		return (false);
	}
}