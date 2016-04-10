<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Product_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Product_Edit" LCID=1030 UICulture="da-DK"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim StartTime As Long = DateTime.Now.Ticks
Dim TimerHash As New System.Collections.ArrayList

Dim ShopProductTemplate As String
Dim Counter As Integer
Dim blnStarted As Boolean
Dim ShopProductDescription As String
Dim strShopProductSpecificFieldXmlSettingFields As String
Dim ShopProductRelated As String
Dim ShopGroupName As String
Dim intChilds As Integer
Dim ShopProductID As String
Dim strDohide As String
Dim intShopGroupFieldGroupID As Integer
Dim ShopProductVariants As String
Dim strPrevName As String
Dim ShopProductPrice1 As String
Dim ShopProductPrice2 As String
Dim ShopProductPrice3 As String
Dim ProductEditFieldList As String
Dim strShopProductID As String
Dim ShopProductGroupID As String
Dim ShopProductImage As String
Dim ProductEditFieldSpecificList As String
Dim ShopProductVariantList As String
Dim strShopProductParentID As String
Dim ShopProductCustomFieldsListElement As String
Dim ShopProductActiveFrom As Date
Dim ShopProductNumber As String
Dim ShopProductProducerID As Integer
Dim ShopProductImageSmall As String
Dim ShopProductStock As String
Dim VariantNum As Byte
Dim ShopProductActiveTo As Date
Dim ShopProductCustomFieldsList As String
Dim ShopProductParentID As Integer
Dim ID As String
Dim ShopProductName As String
Dim ShopProductSpecificFieldXml As String
Dim ShopProductVariantListElement As String
Dim strHideStr As String
Dim SQLContChilds As String
Dim SQL As String
Dim ShopProductActive As Boolean
Dim ShopProductGroups As String
Dim Tabs As String
Dim strTopHeader as String

Public Function ShowHash(ByVal Hash As Hashtable) As String
	Dim tmpOutput As String
	tmpOutput += "<table border=1>"
	tmpOutput += "<tr>"
	tmpOutput += "<td>Key</td>"
	tmpOutput += "<td>Value</td>"
	tmpOutput += "<td>Type</td>"
	tmpOutput += "</tr>"
	For Each d As Collections.DictionaryEntry In Hash
		tmpOutput += "<tr>"
		tmpOutput += "<td>" & CType(d.Key, String) & "</td>"
		If IsDBNull(d.Value) Then
			tmpOutput += "<td>Null</td>"
		Else
			tmpOutput += "<td>" & HttpContext.Current.Server.HtmlEncode(CType(d.Value.ToString, String)) & "</td>"
		End If
		tmpOutput += "<td>" & CType(d.Value.GetType.ToString, String) & "</td>"
		tmpOutput += "</tr>"
	Next
	tmpOutput += "</table>"
	Return tmpOutput
End Function
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: List products in group
'
'	Revision history:
'		1.0 - 01-08-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand
Dim strSpecificValue As String

If Not IsNothing(Request.QueryString("ID")) Or Not IsNothing(Request.QueryString("VariantID")) Then

	ID = Request.QueryString("ID") & Request.QueryString("VariantID")
	sql = "SELECT * FROM ShopProduct WHERE ShopProductID = " & ID

	cmdShop.CommandText = sql

	Dim drProductReader As IDataReader = cmdShop.ExecuteReader()

	If drProductReader.Read Then
		ShopProductGroupID = drProductReader("ShopProductGroupID").ToString
		ShopProductNumber = drProductReader("ShopProductNumber").ToString
		ShopProductProducerID = Base.ChkNumber(drProductReader("ShopProductProducerID").ToString)
		ShopProductName = drProductReader("ShopProductName").ToString
		ShopProductDescription = drProductReader("ShopProductDescription").ToString
		ShopProductActive = drProductReader("ShopProductActive").ToString
		ShopProductActiveFrom = drProductReader("ShopProductActiveFrom").ToString
		ShopProductActiveTo = drProductReader("ShopProductActiveTo").ToString
		ShopProductImageSmall = Base.ChkString(drProductReader("ShopProductImageSmall").ToString)
		ShopProductImage = Base.ChkString(drProductReader("ShopProductImage").ToString)
		ShopProductStock = drProductReader("ShopProductStock").ToString
		ShopProductPrice1 = drProductReader("ShopProductPrice1").ToString
		ShopProductPrice2 = drProductReader("ShopProductPrice2").ToString
		ShopProductPrice3 = drProductReader("ShopProductPrice3").ToString
		ShopProductGroups = drProductReader("ShopProductGroups").ToString
		ShopProductRelated = drProductReader("ShopProductRelated").ToString
		ShopProductSpecificFieldXml = Base.ChkString(drProductReader("ShopProductSpecificFieldXml").ToString)
		ShopProductTemplate = Base.ChkString(drProductReader("ShopProductTemplate").ToString)
		ShopProductCustomFieldsList = Base.ChkString(drProductReader("ShopProductCustomFieldsList").ToString)
		ShopProductCustomFieldsListElement = Base.ChkString(drProductReader("ShopProductCustomFieldsListElement").ToString)
		ShopProductParentID = Base.ChkNumber(drProductReader("ShopProductParentID").ToString)
		ShopProductVariantList = Base.ChkString(drProductReader("ShopProductVariantList").ToString)
		ShopProductVariantListElement = Base.ChkString(drProductReader("ShopProductVariantListElement").ToString)
		
		If IsDbNull(ShopProductActiveTo) Then
			ShopProductActiveTo = CDate("2999-12-31 23:45")
		End If

	Else
		Response.Write(Translate.Translate("%% blev ikke fundet!", "%%", Translate.Translate("Vare")))
		Response.End()
	End If
	If IsNothing(Request.QueryString("ID")) Then
		ShopProductID = Request.QueryString("ShopProductID")
	Else
		ShopProductID = Request.QueryString("ID")
	End If

	drProductReader.Dispose

Else
	ShopProductActiveFrom = Dates.DWnow
	ShopProductActiveTo = "2999-12-31 23:59"
	ShopProductActive = True
	ShopProductGroupID = Request.QueryString("ShopProductGroupID")
	ShopProductID = 0
	ShopProductTemplate = ""
	ShopProductCustomFieldsList = ""
	ShopProductCustomFieldsListElement = ""
	ShopProductVariantList = ""
	ShopProductVariantListElement = ""
	ShopProductParentID = 0
End If
If Not IsNothing(Request.QueryString("VariantID")) Then
	ShopProductID = ""
	ShopProductParentID = Request.QueryString("VariantID")
End If

TimerHash.Add("After data: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))

ShopGroupName = "&nbsp;"
SQL = "SELECT * FROM ShopGroup WHERE ShopGroupID = " & ShopProductGroupID

cmdShop.CommandText = sql

Dim drGroupReader As IDataReader = cmdShop.ExecuteReader()

If drGroupReader.Read Then
	ShopGroupName = drGroupReader("ShopGroupName")
	intShopGroupFieldGroupID = Base.ChkNumber(drGroupReader("ShopGroupFieldGroupID"))
End If

drGroupReader.Dispose

TimerHash.Add("After Groupname: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))

'------- Generel fields

SQL = "SELECT ShopProductField.*, ShopProductFieldType.ShopProductFieldTypeDW FROM ShopProductFieldType RIGHT JOIN ShopProductField ON ShopProductFieldType.ShopProductFieldTypeID = ShopProductField.ShopProductFieldTypeID  WHERE ShopProductFieldGroupID = 0 ORDER BY ShopProductField.ShopProductFieldSort, ShopProductField.ShopProductFieldID"

Dim cmdShopGenerel As IDbCommand = ShopConn.CreateCommand
cmdShopGenerel.CommandText = SQL

Dim drProductFields As IDataReader = cmdShopGenerel.ExecuteReader()

ProductEditFieldList = "<br><table cellpadding=2 cellspacing=0 border=0 width=""100%"">" & vbCrLf
blnStarted = False
strHideStr = ""
Counter = 1
Do While drProductFields.Read

	If drProductFields("ShopProductFieldTypeDW") <> "Group" Then
		If blnStarted = False Then
			strDohide = "Block"
		Else
			strDohide = "None"
		End If
		ProductEditFieldList = ProductEditFieldList & "<tr style=""display: " & strDohide & """ ID=""tr_" & Server.HtmlEncode(drProductFields("ShopProductFieldName")) & """>" & vbCrLf
		ProductEditFieldList = ProductEditFieldList & "	<td width=170 valign=top>" & drProductFields("ShopProductFieldName") & "</td>" & vbCrLf
		ProductEditFieldList = ProductEditFieldList & "	<td>" & ReturnInputField(drProductFields("ShopProductFieldTypeDW"), drProductFields("ShopProductFieldSystemName"), drProductFields("ShopProductFieldID"), drProductFields("ShopProductFieldSelectvalues")) & "</td>" & vbCrLf
		ProductEditFieldList = ProductEditFieldList & "</tr>" & vbCrLf
		strHideStr = strHideStr & "tr_" & drProductFields("ShopProductFieldName") & ","
	Else
		If blnStarted = False Then
			blnStarted = True

			ProductEditFieldList = ProductEditFieldList & "<tr style=""display: none"" ID=""tr_GroupStart" & Counter & """>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "	<td width=170 valign=top><strong>" & drProductFields("ShopProductFieldName") & "</strong></td>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "	<td align=""right""><IMG onClick=""javascript:unhide('" & Counter & "');"" src=""../../images/Round_arrow_down.gif"" style=""cursor: hand"">&nbsp;</td>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "</tr>" & vbCrLf
			strPrevName = drProductFields("ShopProductFieldName")
		Else
			ProductEditFieldList = ProductEditFieldList & "<tr ID=""tr_GroupEnd" & Counter & """>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "	<td width=170><strong>" & strPrevName & "closed</strong><input type=""hidden"" Name=""FieldHide" & Counter & """ Value=""" & strHideStr & """></td>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "	<td align=""right""><IMG onClick=""javascript:hide('" & Counter & "');"" src=""../../images/Round_arrow_down.gif"" style=""cursor: hand"">&nbsp;</td>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "</tr>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "<tr valign=top ID=""tr_GroupEndImg" & Counter & """>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "	<td colspan=""2"" valign=top><img hspace=""0"" src=""/Admin/images/horisontalLine.gif""></td>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "</tr>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "<tr><td colspan=""2"">&nbsp;<td></tr>" & vbCrLf
			Counter = Counter + 1
			strHideStr = ""
			
			ProductEditFieldList = ProductEditFieldList & "<tr style=""display: none"" ID=""tr_GroupStart" & Counter & """>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "	<td width=170 valign=top><strong>" & drProductFields("ShopProductFieldName") & "</strong></td>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "	<td align=""right""><IMG onClick=""javascript:unhide('" & Counter & "');"" src=""../../images/Round_arrow_down.gif"" style=""cursor: hand"">&nbsp;</td>" & vbCrLf
			ProductEditFieldList = ProductEditFieldList & "</tr>" & vbCrLf
			strPrevName = drProductFields("ShopProductFieldName")
		End If
	End If
Loop


If blnStarted = True Then
	ProductEditFieldList = ProductEditFieldList & "<tr ID=""tr_GroupEnd" & Counter & """>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "	<td width=170><strong>" & strPrevName & "closed</strong><input type=""hidden"" Name=""FieldHide" & Counter & """ Value=""" & strHideStr & """></td>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "	<td align=""right""><IMG onClick=""javascript:hide('" & Counter & "');"" src=""../../images/Round_arrow_down.gif"" style=""cursor: hand"">&nbsp;</td>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "</tr>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "<tr valign=top ID=""tr_GroupEndImg" & Counter & """>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "	<td colspan=""2"" valign=top><img hspace=""0"" src=""/Admin/images/horisontalLine.gif""></td>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "</tr>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "<tr><td colspan=""2"">&nbsp;<td></tr>" & vbCrLf
End If
ProductEditFieldList = ProductEditFieldList & "</table>" & vbCrLf

drProductFields.Dispose

TimerHash.Add("After Generel fields: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))
'------- Specific fields

If CStr(intShopGroupFieldGroupID) <> "" And intShopGroupFieldGroupID <> 0 Then

	SQL = "SELECT ShopProductField.*, ShopProductFieldType.ShopProductFieldTypeDW FROM ShopProductFieldType RIGHT JOIN ShopProductField ON ShopProductFieldType.ShopProductFieldTypeID = ShopProductField.ShopProductFieldTypeID  WHERE ShopProductFieldGroupID = " & intShopGroupFieldGroupID & " ORDER BY ShopProductField.ShopProductFieldSort, ShopProductField.ShopProductFieldID"

	Dim cmdShopSpecific As IDbCommand = ShopConn.CreateCommand

	cmdShopSpecific.CommandText = SQL
	Dim drProductFieldType As IDataReader = cmdShopSpecific.ExecuteReader()

	ProductEditFieldSpecificList = "<br><table cellpadding=2 cellspacing=0 border=0 width=""100%"">" & vbCrLf
	blnStarted = False
	strHideStr = ""
	Counter = 1

    Dim propSpecific As New Properties

	If ShopProductSpecificFieldXml <> "" Then
		propSpecific.LoadProperty(ShopProductSpecificFieldXml)
	End If

	strShopProductSpecificFieldXmlSettingFields = ""

	Do While drProductFieldType.Read
		If drProductFieldType("ShopProductFieldTypeDW") <> "Group" Then
			If strShopProductSpecificFieldXmlSettingFields <> "" Then
				strShopProductSpecificFieldXmlSettingFields = strShopProductSpecificFieldXmlSettingFields & ", "
			End If
			strShopProductSpecificFieldXmlSettingFields = strShopProductSpecificFieldXmlSettingFields & "ShopProductSpecific_" & drProductFieldType("ShopProductFieldSystemName")
			If blnStarted = False Then
				strDohide = "Block"
			Else
				strDohide = "None"
			End If

			strSpecificValue = propSpecific.Value("ShopProductSpecific_" & drProductFieldType("ShopProductFieldSystemName"))
			ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr style=""display: " & strDohide & """ ID=""tr_" & drProductFieldType("ShopProductFieldName") & """>" & vbCrLf
			ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td width=170 valign=top>" & drProductFieldType("ShopProductFieldName") & "</td>" & vbCrLf
			ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td>" & ReturnInputFieldSpecific(strSpecificValue, drProductFieldType("ShopProductFieldTypeDW"), drProductFieldType("ShopProductFieldSystemName"), drProductFieldType("ShopProductFieldID"), Base.ChkBoolean(drProductFieldType("ShopProductFieldSelectvalues"))) & "</td>" & vbCrLf
			ProductEditFieldSpecificList = ProductEditFieldSpecificList & "</tr>" & vbCrLf
			strHideStr = strHideStr & "tr_" & drProductFieldType("ShopProductFieldName") & ","
		Else
			If blnStarted = False Then
				blnStarted = True
				'Start the blalbal
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr style=""display: none"" ID=""tr_GroupStart" & Counter & """>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td width=170 valign=top><strong>" & drProductFieldType("ShopProductFieldName") & "</strong></td>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td align=""right""><IMG onClick=""javascript:unhide('" & Counter & "');"" src=""../../images/Round_arrow_down.gif"" style=""cursor: hand"">&nbsp;</td>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "</tr>" & vbCrLf
				strPrevName = drProductFieldType("ShopProductFieldName")
			Else
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr ID=""tr_GroupEnd" & Counter & """>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td width=170><strong>" & strPrevName & "closed</strong><input type=""hidden"" Name=""FieldHide" & Counter & """ Value=""" & strHideStr & """></td>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td align=""right""><IMG onClick=""javascript:hide('" & Counter & "');"" src=""../../images/Round_arrow_down.gif"" style=""cursor: hand"">&nbsp;</td>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "</tr>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr valign=top ID=""tr_GroupEndImg" & Counter & """>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td colspan=""2"" valign=top><img hspace=""0"" src=""/Admin/images/horisontalLine.gif""></td>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "</tr>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr><td colspan=""2"">&nbsp;<td></tr>" & vbCrLf
				Counter = Counter + 1
				strHideStr = ""
				
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr style=""display: none"" ID=""tr_GroupStart" & Counter & """>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td width=170 valign=top><strong>" & drProductFieldType("ShopProductFieldName") & "</strong></td>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td align=""right""><IMG onClick=""javascript:unhide('" & Counter & "');"" src=""../../images/Round_arrow_down.gif"" style=""cursor: hand"">&nbsp;</td>" & vbCrLf
				ProductEditFieldSpecificList = ProductEditFieldSpecificList & "</tr>" & vbCrLf
				strPrevName = drProductFieldType("ShopProductFieldName")
			End If
		End If
	Loop 

	If blnStarted = True Then
		ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr ID=""tr_GroupEnd" & Counter & """>" & vbCrLf
		ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td width=170><strong>" & strPrevName & "closed</strong><input type=""hidden"" Name=""FieldHide" & Counter & """ Value=""" & strHideStr & """></td>" & vbCrLf
		ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td align=""right""><IMG onClick=""javascript:hide('" & Counter & "');"" src=""../../images/Round_arrow_down.gif"" style=""cursor: hand"">&nbsp;</td>" & vbCrLf
		ProductEditFieldSpecificList = ProductEditFieldSpecificList & "</tr>" & vbCrLf
		ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr valign=top ID=""tr_GroupEndImg" & Counter & """>" & vbCrLf
		ProductEditFieldSpecificList = ProductEditFieldSpecificList & "	<td colspan=""2"" valign=top><img hspace=""0"" src=""/Admin/images/horisontalLine.gif""></td>" & vbCrLf
		ProductEditFieldSpecificList = ProductEditFieldSpecificList & "</tr>" & vbCrLf
		ProductEditFieldSpecificList = ProductEditFieldSpecificList & "<tr><td colspan=""2"">&nbsp;<td></tr>" & vbCrLf
	End If
	ProductEditFieldSpecificList = ProductEditFieldSpecificList & "</table>" & vbCrLf

	drProductFieldType.Dispose
End If

TimerHash.Add("After Specific fields: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
<!--

function Send(FileToHandle){
	if (document.getElementById('ProductEdit').ShopProductName.value.length < 1){
		TabClick(document.getElementById('Tab1_head'));
		document.getElementById('ProductEdit').ShopProductName.focus();
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
	}
	else {
		if(CheckPrice(document.getElementById('ShopProductPrice1'))==false)
			return false;
		else if(CheckPrice(document.getElementById('ShopProductPrice2'))==false)
			return false;
		else if(CheckPrice(document.getElementById('ShopProductPrice3'))==false)
			return false;
		document.getElementById('ProductEdit').action = FileToHandle;
		document.getElementById('ProductEdit').submit();
	}
}

function setFocus(){
	if(document.getElementById('Tab1').style.display!="none"){
		setTimeout("document.getElementById('ProductEdit').ShopProductName.focus()", 500);
	}
}
function hide(strDiv) {
//	alert(strDiv);
	objElement = document.getElementById("FieldHide" + strDiv)
	strElements = objElement.value;
	
	arrTRs = strElements.split(",");
//	alert(arrTRs.length)
	for(i=0; i < arrTRs.length; i++) {
//		alert(arrTRs[i]);
		if(arrTRs[i] != "") {
			document.getElementById(arrTRs[i]).style.display= 'block'
		}
	}
	document.getElementById("tr_GroupStart" + strDiv).style.display= 'Block'
	document.getElementById("tr_GroupEnd" + strDiv).style.display= 'None'	
	document.getElementById("tr_GroupEndImg" + strDiv).style.display= 'None'	
}

function unhide(strDiv)
{
//	alert(strDiv);
	objElement = document.getElementById("FieldHide" + strDiv)
	strElements = objElement.value;
	
	arrTRs = strElements.split(",");
//	alert(arrTRs.length)
	for(i=0; i < arrTRs.length; i++) {
//		alert(arrTRs[i]);
		if(arrTRs[i] != "") {
			document.getElementById(arrTRs[i]).style.display= 'None'
		}
	}
	document.getElementById("tr_GroupStart" + strDiv).style.display= 'None'
	document.getElementById("tr_GroupEndImg" + strDiv).style.display= 'Block'	
	document.getElementById("tr_GroupEnd" + strDiv).style.display= 'Block'	
}

function CheckPrice(objPrice) {
	var dblPrice
	dblPrice = objPrice.value.replace(',', '.')
	if(isNaN(dblPrice)) {
		alert('<%=Translate.JsTranslate("%% er ikke en gyldig pris!")%>'.replace('%%', objPrice.value) + '\n' + '<%=Translate.JsTranslate("Formatet skal være 1299,95 eller 1299.95.")%>');
		return false;
	}
}

function EncryptPrice(){
    var productID = document.getElementById("ShopProductID").value;
    var toEncrypt = document.getElementById("ValueToEncrypt").value.replace(',', '.');
    //alert(productID);
    //alert(toEncrypt);
    if(productID>0 && toEncrypt>0){
        var xmlHttp;
        try{
            xmlHttp=new XMLHttpRequest();
        }catch (e){
            try{
                xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e){
                try{
                    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                catch (e){
                    alert("Your browser does not support AJAX!");
                    return false;
                }
            }
        }
        xmlHttp.onreadystatechange=function(){
            if(xmlHttp.readyState==4){
                var root;
                if (window.ActiveXObject){
                    var doc=new ActiveXObject("Microsoft.XMLDOM");
                    doc.async="false";
                    doc.loadXML(xmlHttp.responseText);
                    root = doc.childNodes[1].childNodes;
                }else{
                    var parser=new DOMParser();
                    var doc=parser.parseFromString(xmlHttp.responseText,"text/xml");
                    root = doc.childNodes[0].childNodes;
                }
                document.getElementById("ValueToEncrypt").value = root[0].nodeValue;
            }
            //alert(xmlHttp.readyState)
        }
        //alert("Product_Edit_Crypt.aspx?ProductID=" + productID + "&Price=" + toEncrypt + "&CacheKiller=" + new Date().getTime());
        xmlHttp.open("GET","Product_Edit_Crypt.aspx?ProductID=" + productID + "&Price=" + toEncrypt + "&CacheKiller=" + new Date().getTime(),true);
        xmlHttp.send(null);
    }
}
//-->
</SCRIPT>

<%
'VariantNum = 4
'Tabs = Translate.Translate("Vare") & "," & Translate.Translate("Beskrivelse") & "," & Translate.Translate("Tilknytning")
VariantNum = 3
Tabs = Translate.Translate("Vare") & "," & Translate.Translate("Tilknytning")

If ProductEditFieldList <> "" Then
	Tabs = Tabs & "," & Translate.Translate("Felter")
	VariantNum = VariantNum + 1
End If
If Base.ChkNumber(ShopProductParentID) = 0 And Base.HasVersion("18.5.1.0") Then
	Tabs = Tabs & "," & Translate.Translate("Variant ")
End If
If ShopProductName=""
	strTopHeader = Translate.Translate("Nyt produkt - (%g%)","%g%",ShopGroupName)
else
	strTopHeader = Translate.Translate("Rediger produkt - (%g%) %p%","%g%",ShopGroupName,"%p%", ShopProductName)
end if
%>
<%=Gui.MakeHeaders("&nbsp;" & ShopProductName, Tabs, "JavaScript")%>
<body onLoad="setFocus();document.getElementById('BodyContent').style.display='';">
<div ID=BodyContent style="display:block">
<%=Gui.MakeHeaders(strTopHeader, Tabs, "HTML")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
<form action="Product_save.aspx" method="post" name="ProductEdit" id="ProductEdit">
<input type="Hidden" value="<%=ShopProductID%>" name="ShopProductID" id="ShopProductID">
	<tr>
		<td valign="top">
			<DIV ID="Tab1" STYLE="display:;">
			<br>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
						<table cellpadding=2 cellspacing=0 border=0>
								<tr>
									<td width=170><%=Translate.Translate("Varenavn")%></td>
									<td><INPUT TYPE="TEXT" NAME="ShopProductName" VALUE="<%=Server.HtmlEncode(ShopProductName)%>" maxlength="255" class="std"></td>
								</tr>
								<%If Base.GetGs("/Globalsettings/Modules/Shop/Edit/DeactivateGroups") <> "True" Then%>
								<tr>
									<td>
									<%ShopProductGroupID = "@" & ShopProductGroupID & "@"%>
									<%=Translate.Translate("Gruppe")%></td>
									<td><%=Gui.ShopGroupList("ShopProductGroupID", ShopProductGroupID, False, "")%></td>
								</tr>
								<%Else%>
									<input type="hidden" name="ShopProductGroupID" value="<%=ShopProductGroupID%>">
								<%End If%>
								<tr>
									<td><%=Translate.Translate("Varenummer")%></td>
									<td><INPUT TYPE="TEXT" NAME="ShopProductNumber" VALUE="<%=Server.HtmlEncode(ShopProductNumber)%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Lager",1)%></td>
									<td><INPUT TYPE="TEXT" NAME="ShopProductStock" VALUE="<%=ShopProductStock%>" maxlength="255" class="std" style="width:100px;"></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Billede")%></td>
									<td><%= Gui.FileManager(ShopProductImage, Dynamicweb.Content.Management.Installation.ImagesFolderName, "ShopProductImage")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Lille Billede")%></td>
									<td><%= Gui.FileManager(ShopProductImageSmall, Dynamicweb.Content.Management.Installation.ImagesFolderName, "ShopProductImageSmall")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Aktiv")%></td>
							      	<td><%=Gui.CheckBox(ShopProductActive, "ShopProductActive")%></td>
							    </tr>
							</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Pris"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td width=170><%=Translate.Translate("Pris")%> 1</td>
								<td><INPUT TYPE="TEXT" NAME="ShopProductPrice1" onchange="JavaScript:CheckPrice(this);" VALUE="<%=ShopProductPrice1%>" maxlength="255" class="std" style="width:100px;"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Pris")%> 2</td>
								<td><INPUT TYPE="TEXT" NAME="ShopProductPrice2" onchange="JavaScript:CheckPrice(this);" VALUE="<%=ShopProductPrice2%>" maxlength="255" class="std" style="width:100px;"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Pris")%> 3</td>
								<td><INPUT TYPE="TEXT" NAME="ShopProductPrice3" onchange="JavaScript:CheckPrice(this);" VALUE="<%=ShopProductPrice3%>" maxlength="255" class="std" style="width:100px;"></td>
							</tr>
							<%If Base.GetGs("/Globalsettings/Modules/Cart/EncryptPriceParameter") = "True" Then%>
                                <%If Base.ChkNumber(ShopProductID) >= 1 Then%>
							    <tr>
                                    <td style="width: 170px;"><%=Translate.Translate("Krypter værdi")%></td>
                                    <td><input type="text" id="ValueToEncrypt" name="ValueToEncrypt" class="std" style="width:100px;" maxlength="255" /><input type="button" id="ButtonEncrypt" onclick="javascript:EncryptPrice();" class="std" style="margin-left: 5px; width: 75px; height: 17px;" value="<%=Translate.Translate("Krypter") %>" /></td>
                                </tr>
                                <%End If%>
                            <%End If %>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr <%=Base.HasAccessHIDE("Publish", "")%>>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td width=170><%=Translate.Translate("Gyldig fra")%></td>
								<td><%Response.Write(Dates.DateSelect(ShopProductActiveFrom, True, False, False, "ShopProductActiveFrom"))%></td>
							</tr>
							<tr>
								<td width=170><%=Translate.Translate("Gyldig til")%></td>
								<td><%Response.Write(Dates.DateSelect(ShopProductActiveTo, True, False, True, "ShopProductActiveTo"))%></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<TR>
								<TD valign="top" width="170"><%=Translate.Translate("Vare template")%></TD>
								<TD valign="top"><%=Gui.FileManager(ShopProductTemplate, "Templates/Shop", "ShopProductTemplate")%></TD>
							</TR>
							<TR>
								<TD valign="top" width="170"><%=Translate.Translate("Varefelter liste")%></TD>
								<TD valign="top"><%=Gui.FileManager(ShopProductCustomFieldsList, "Templates/Shop", "ShopProductCustomFieldsList")%></TD>
							</TR>
							<TR>
								<TD valign="top" width="170"><%=Translate.Translate("Varefelter elementer")%></TD>
								<TD valign="top"><%=Gui.FileManager(ShopProductCustomFieldsListElement, "Templates/Shop", "ShopProductCustomFieldsListElement")%></TD>
							</TR>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
			
			<br>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td colspan="2"><%=Gui.Editor("ShopProductDescription", 560, 0, ShopProductDescription)%></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
			</div>
			<%TimerHash.Add("After info screen: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))%>
			<DIV ID="Tab2" STYLE="display:none;">
			
			<br>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
			<%If Base.GetGs("/Globalsettings/Modules/Shop/Edit/DeactivateGroups") <> "True" Then%>
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Varegrupper"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td width=170></td>
								<td><%=Gui.ShopGroupList("ShopProductGroups", ShopProductGroups, True, 10)%></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			<%Else%>
				<tr><td>
					<input type="hidden" name="ShopProductGroups" value="<%=ShopProductGroups%>">
				</td></tr>
			<%End If%>
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Relaterede varer"))%>


						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td width=170></td>
								<td>
								<%=Gui.ChooseProducts("ShopProductRelated", Base.ChkString(ShopProductRelated), 0)%>
								</td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<%' Hvis Varen ikke er Parent
				strShopProductID = ShopProductID
				intChilds = 0
				If Not IsNumeric(ShopProductID) Or ShopProductID = "" Or ShopProductID = "0" Then
					strShopProductID = "-1"
				End If


				sql = "SELECT Count(ShopProductID) AS Childs FROM ShopProduct WHERE ShopProductParentID = " & strShopProductID
				cmdShop.CommandText = sql

				Dim drCountChilds As IDataReader = cmdShop.ExecuteReader()

				If drCountChilds.Read Then
					intChilds = drCountChilds("Childs")
				End If

				drCountChilds.Dispose

				If intChilds = 0 And Base.HasVersion("18.5.1.0") Then
					If Base.ChkString(ShopProductParentID) = "0" Then
						strShopProductParentID = ""
					Else
						strShopProductParentID = ShopProductParentID
					End If
					%>
					<tr>
						<td>
						<%=Gui.GroupBoxStart(Translate.Translate("Variant ophavs produkt"))%>
							<table cellpadding=2 cellspacing=0 border=0>
								<tr>
									<td width=170></td>
									<td>
									<%=Gui.ChooseProducts("ShopProductParentID", strShopProductParentID, 1)%>
									</td>
								</tr>
							</table>
						<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
				<%	' Hvis Varen ikke er Parent
				End If%>
			</table>
			</div>
			<%TimerHash.Add("Before fields: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))%>
			<%If (ProductEditFieldList & ProductEditFieldSpecificList) <> "" Then%>
			<DIV ID="Tab3" STYLE="display:none;">
			
			<br>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<tr>
					<td>
					<%	
					Response.Write(Gui.GroupBoxStart(Translate.Translate("Generelle")))
					Response.Write(ProductEditFieldList)
					Response.Write(Gui.GroupBoxEnd)
					%>
					</td>
				</tr>
				<tr>
					<td>
					<%	
					If ProductEditFieldSpecificList <> "" Then
						Response.Write(Gui.GroupBoxStart(Translate.Translate("Gruppespecifikke")))
						Response.Write(ProductEditFieldSpecificList)
						Response.Write(Gui.GroupBoxEnd)
						Response.Write("</td></tr><tr><td><input type=""Hidden"" name=""ShopProductSpecificFieldXml_Settings"" value=""" & strShopProductSpecificFieldXmlSettingFields & """>")
					End If
					%>
					</td>
				</tr>
			</table>
			</div>			
			<%	
			End If
TimerHash.Add("After fields: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))
			If Base.ChkNumber(ShopProductParentID) = 0 Then
				strShopProductID = ShopProductID
				ShopProductVariants = ""
				If Not IsNumeric(ShopProductID) Or ShopProductID = "" Or ShopProductID = "0" Then
					strShopProductID = "-1"
				End If

				sql = "SELECT ShopProductID FROM ShopProduct WHERE ShopProductParentID = " & strShopProductID
				cmdShop.CommandText = sql

				Dim drChilds As IDataReader = cmdShop.ExecuteReader()

				Do While drChilds.Read
					ShopProductVariants = ShopProductVariants & drChilds("ShopProductID") & ", "
				Loop 
				drChilds.Close
				drChilds.Dispose
				If ShopProductVariants <> "" Then
					ShopProductVariants = ShopProductVariants & "0"
				End If
			End If
TimerHash.Add("After variant data: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))
			%>
			<DIV ID="Tab<%=VariantNum%>" STYLE="display:none;">
			<br>
			<table cellspacing="0" border="0" cellpadding="0" width="100%">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Variant varer"))%>
						<table cellpadding=0 cellspacing=0 border=0>
							<tr>
								<td width=170></td>
								<td>
								<%=Gui.ChooseProducts("ShopProductVariants", ShopProductVariants, 0)%>
								</td>
							</tr>
							<tr><td>&nbsp;</td><td></td></tr>
							<TR>
								<TD valign="top" width="170"><%=Translate.Translate("Variant liste")%></TD>
								<TD valign="top"><%=Gui.FileManager(ShopProductVariantList, "Templates/Shop", "ShopProductVariantList")%></TD>
							</TR>
							<tr><td height="6px"></td><td></td></tr>
							<TR>
								<TD valign="top" width="170"><%=Translate.Translate("Variant elementer")%></TD>
								<TD valign="top"><%=Gui.FileManager(ShopProductVariantListElement, "Templates/Shop", "ShopProductVariantListElement")%></TD>
							</TR>
						</table>
					<%=Gui.GroupBoxEnd%>				
					</td>
				</tr>
			</table>
			</div>
			<%
'End If
%>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<%
					If Base.HasVersion("18.5.1.0") Then
						If Base.ChkNumber(ShopProductParentID) = 0 And ShopProductID <> "0" Then
						%>
							<td align="right"><%=Gui.Button(Translate.Translate("Opret ny variant"), "location='Product_edit.aspx?VariantID=" & Request.QueryString.Item("ID") & "&PageID=" & Request.QueryString.Item("PageID") & "';", 0)%></td>
							<td width="5"></td>
						<%		
						End If
					End If
					%>
					<td align="right"><%=Gui.Button(Translate.Translate("OK"), "if(html()){Send('Product_save.aspx');}", 0)%></td>
					<td width="5"></td>
					<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='Product_list.aspx?ID=" & replace(ShopProductGroupID,"@","") & "'", 0)%></td>
					<%=Gui.HelpButton("Shop_product_Edit", "gui.tabs.shop.product.list.item.edit",,5)%>
					<td width="5"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
			</table>
		</td>
	</tr>
	
</table>
<%
ShopConn.Dispose
%>
<%=Gui.SelectTab()%>
</form>
</div>
</body>
</html>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
TimerHash.Add("End of script: " & CType((DateTime.Now.Ticks - StartTime) / 10000000, String))

'For Each item As String In TimerHash'
'	Base.w(item.ToString)
'Next
'Response.Write(ShowHash(TimerHash))

%>