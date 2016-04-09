function SetClassBrowserValues(parentID, library, nmsp, cls, method)
{
	var doc = opener.document;
	doc.getElementById(parentID + "_MLibrary").value = library;
	doc.getElementById(parentID + "_MNamespace").value = nmsp;
	doc.getElementById(parentID + "_MClass").value = cls;
	doc.getElementById(parentID + "_Method").value = method;
}