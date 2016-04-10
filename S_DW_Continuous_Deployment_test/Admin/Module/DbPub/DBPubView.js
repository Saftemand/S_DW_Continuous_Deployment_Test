function SelectAll(area, value)
{
	var iDs = new Array( ); 			
	startSet = document.getElementsByTagName("input");
	for (var i = 0; i < startSet.length; i++){
		if (startSet[i].type == "checkbox"){
			if (startSet[i].id.indexOf(area) != -1) {
				iDs[iDs.length] = startSet[i];					
			}
		}				
	}
	for (var i = 0; i < iDs.length; i++){
		if(iDs[i].disabled != true) iDs[i].checked = value;				
	}
}
function OnSelectedComboWhere()
{   
	document.getElementById("WhereValueText").value = document.getElementById("WhereValue").value;
} 
function OnSortClick(sortid, sortway, sortprocid)
{   
	document.getElementById("SortID").value = sortid;			
	document.getElementById("SortWay").value = sortway;
	document.getElementById("SortProcID").value = sortprocid;	
	Form1.submit();
	return false;						
}	
function validateDelimiter_custom(source, arguments)
{
	if(document.getElementById("DdlJobDS2Delimiter").value == "Custom")
	{
		var ln = document.getElementById("TbJobDS2Delimiter").value.length
		if( ln >= 0 && ln < 2)
		{
			arguments.IsValid = true;
			return true;
		}
		else
		{
			arguments.IsValid = false;
			return false;				
		}
	}
	arguments.IsValid = true;
	return true;
}
	
function validateDecimal(source, arguments)
{
		var ln = document.getElementById("TbJobDS2Decimal").value.length
		if( ln >= 0 && ln < 2)
		{
			arguments.IsValid = true;
			return true;
		}
		else
		{
			arguments.IsValid = false;
			return false;				
		}
}

function CustomDelimiter()
{
	if(document.getElementById("DdlJobDS2Delimiter").value == "Custom")
	{
		document.getElementById("SpanJobDS2Delimiter").style.display = "";
	}
	else
	{
		document.getElementById("SpanJobDS2Delimiter").style.display = "none";
	}
}

function RelationOptions()
{
	var modeString = "none"
	if(document.getElementById("chkIsChild").checked == true) { modeString = ""; }
	document.getElementById("Tablerow37").style.display = modeString;
}

function EditField(fieldnum)
{
	window.open("DBPub_EditField.aspx?fieldnum=" + fieldnum, "", "resizable=no,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=445,height=500");
}