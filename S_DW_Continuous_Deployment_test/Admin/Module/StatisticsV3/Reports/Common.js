 
function RedirectLink(link, linkWithOutUID){
	window.parent.RedirectLink(link, linkWithOutUID);
	}
	
function showUserReport(strLocation, width, height){
	var wt = 700, ht = 700;
	
	if(typeof(width) != 'undefined')
		wt = width;
	
	if(typeof(height) != 'undefined')
		ht = height;
	
	window.open(strLocation, "newWind", 
		"resizable=no,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=" + wt + ",height=" + ht);
	}
	
function OpenNewWindow(hostname, strLocation){
	window.open(hostname + strLocation, "newWind");
	}
	
var reps=new Array();
function globalReload()
{
    globalReloadWithParameters("", "");	
}

function globalReloadWithParameters(paramName, paramValue)
{
    var url="";
	var ids="";
	for(var key in reps)
	{
		if (ids!="")
		{
			ids+=",";
		}
				
		ids+=key;
		if(key=="11" || key=="22" || key=="47" || key=="59" || key=="60" || key=="65" || key=="66" || key=="67")
		{
			url+="Last"+key+"=";
			var id = reps[key];
			var sel = document.getElementById(id)
			if (!sel)
			{
				sel = document.forms[0].elements[id];
			}
			if (sel)
			{
			    url+=sel.value +"&";
		    }
	    }
	}
	var arrStr="";
	if (paramName.length > 0) arrStr = "&" + paramName + "=" + paramValue;	
	window.parent.changeDataFrame('reports/IFReport.aspx?ids='+ids+"&"+url+arrStr);
}
	
	

