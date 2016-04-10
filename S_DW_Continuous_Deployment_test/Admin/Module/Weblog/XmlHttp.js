var __responseBuffer;

function __GetXmlHttpObject()
{ 
	var objXMLHttp = null;
	if(window.XMLHttpRequest)
		objXMLHttp=new XMLHttpRequest();
	else if(window.ActiveXObject)
	  objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	return objXMLHttp;
}

function __StateChanged()
{
	var ret = true;
	
	__responseBuffer = "";
	if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete")
	{
		__responseBuffer = xmlHttp.responseText
		if(__responseBuffer.length == 1)
			if(__responseBuffer == "1")
				ret = false;
	}
	
	return ret;
} 

function __SendXmlHttpRequest(url)
{
	if((xmlHttp = new __GetXmlHttpObject()) == null)
		return false;
		
	xmlHttp.onreadystatechange = __StateChanged;
	xmlHttp.open("GET", url, false);
	xmlHttp.send(null);	
}