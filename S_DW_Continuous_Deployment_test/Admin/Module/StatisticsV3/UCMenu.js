function ApplyStatSetting()
{
	changeFilter();
	changeReportSrc();
}

function ApplyTriggerFilter()
{
	var from = buildDateQuery("Statv2From");
	var to = buildDateQuery("Statv2To");	
	_reportFilter = "Run=true" + "&" + from + "&" + to; 	
	_reportFilter = encodeURI(_reportFilter);
	changeReportSrc("trigger");
}

function changeFilter()
{
	_reportFilter = "";
	var ip = getValue("Statv2IpSearch");
	var area = getValue("Statv2Area");
	var from = buildDateQuery("Statv2From");
	var to = buildDateQuery("Statv2To");
	var crawlers = getValue("Crawlers");
	var admins = getValue("Admins");
	var onePv = getValue("OnePv");
	var extranetusers = getValue("Extranetusers");
	var ipfiltering = getValue("IPfiltering");
	var fillbar = getValue("Fillbar");
	_reportFilter = crawlers + "&" + admins + "&" + onePv + "&" + extranetusers + "&" + ipfiltering + "&" + fillbar + "&" + ip + "&" + area + "&" + from + "&" + to;
	_reportFilter = encodeURI(_reportFilter);
}

function buildDateQuery(name)
{
	var ret = "";
	ret += getValue(name + "_year");
	ret += "&" + getValue(name + "_month");
	ret += "&" + getValue(name + "_day");
	ret += "&" + getValue(name + "_hour");
	ret += "&" + getValue(name + "_minute");
	return ret;	
}

function getValue(name)
{
	var a1 = document.getElementsByName(name);
	if(typeof a1 != "undefined" && a1 != null && a1.length > 0) 
	{
		var elem = a1[0];
		return name + "=" + elem.value;
	}
	else return "";
}

function checkEnterKey(){
    if (event.keyCode == 13) {
        return false;
    }
}

