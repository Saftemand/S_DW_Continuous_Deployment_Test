<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb.Admin" %>

<script language="VB" runat="Server">
Dim sql As String
Dim ShopProductFieldGroupID As String
Dim ShopProductFieldLocked As Boolean
Dim ShopProductFieldSystemName As String
Dim ShopProductFieldDoNotPublish As Boolean
Dim ShopProductFieldTypeID As String
Dim ShopProductFieldName As String
Dim ShopProductFieldType As String
Dim ShopProductFieldTemplateName As String
Dim ShopProductFieldID As String
Dim ShopProductFieldSelectvalues As Boolean
Dim blnHasRows As Boolean
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: Edit field
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************
ShopProductFieldGroupID = Base.ChkNumber(Request.QueryString("GroupID"))
%>

<%

Dim allSystemNames as String = String.Empty
Dim sqlCommand = "SELECT ShopProductFieldSystemName FROM [ShopProductField]"

using reader as IDataReader = Dynamicweb.Modules.Common.DbHandler.GetDataReader(sqlCommand, "DWShop.mdb")
	if not reader is Nothing
		while reader.Read()
			allSystemNames += string.Format("'{0}'," ,Base.ChkString(reader(0)))
		end while
	end if
end using

allSystemNames = allSystemNames.Trim(","c)

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
<script>
function checkfield(){
	var x=document.getElementById('ShopProductField').ShopProductFieldSystemName.value
	var anum=/[A-Z0-9\_]+$/gi

	if (anum.test(x))
		testresult=true
	else{
		testresult=false
	}
	return (testresult)
}

function Send(FileToHandle){

	var form = document.forms["ShopProductField"];
	var currentSystemName = form.elements["ShopProductFieldSystemName"].value;
	var fieldWasAdded = form.elements["ShopProductFieldSystemName_NIU"] != null;
	
	if (document.getElementById('ShopProductField').ShopProductFieldName.value.length < 1 || currentSystemName.length < 1){
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");}
	else if (!checkfield()){
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Systemnavn"))%>");}
	else if (!fieldWasAdded && IsSystemNameExist(new Array(<%=allSystemNames%>), currentSystemName))
	{
		alert('<%=Translate.JsTranslate("System Navn er blank eller eksisterer i forvejen")%>');
	}
	else{
		document.getElementById('ShopProductField').action = FileToHandle;
		document.getElementById('ShopProductField').submit();
	}
}
</script>
</HEAD>
<%
If IsNothing(Request.QueryString("ID")) Then
	ShopProductFieldID = 0
	ShopProductFieldName = ""
	ShopProductFieldType = "Text"
Else
	Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

	ShopProductFieldID = Request.QueryString("ID")
	sql = "SELECT * FROM ShopProductField WHERE ShopProductFieldID = " & ShopProductFieldID

	sCmdShop.CommandText = sql

	Dim drProductFieldReader As IDataReader = sCmdShop.ExecuteReader()

	Dim opShopProductFieldName As Integer = drProductFieldReader.getordinal("ShopProductFieldName")
	Dim opShopProductFieldTypeID As Integer = drProductFieldReader.getordinal("ShopProductFieldTypeID")
	Dim opShopProductFieldTemplateName As Integer = drProductFieldReader.getordinal("ShopProductFieldTemplateName")
	Dim opShopProductFieldSystemName As Integer = drProductFieldReader.getordinal("ShopProductFieldSystemName")
	Dim opShopProductFieldLocked As Integer = drProductFieldReader.getordinal("ShopProductFieldLocked")
	Dim opShopProductFieldDoNotPublish As Integer = drProductFieldReader.getordinal("ShopProductFieldDoNotPublish")
	Dim opShopProductFieldSelectvalues As Integer = drProductFieldReader.getordinal("ShopProductFieldSelectvalues")
	Dim opShopProductFieldGroupID As Integer = drProductFieldReader.getordinal("ShopProductFieldGroupID")

	blnHasRows = False
	
	If drProductFieldReader.Read Then
		ShopProductFieldName = Base.ChkString(drProductFieldReader(opShopProductFieldName))
		ShopProductFieldTypeID = Base.ChkNumber(drProductFieldReader(opShopProductFieldTypeID))
		ShopProductFieldTemplateName = Base.ChkString(drProductFieldReader(opShopProductFieldTemplateName))
		ShopProductFieldSystemName = Base.ChkString(drProductFieldReader(opShopProductFieldSystemName))
		ShopProductFieldLocked = Base.ChkBoolean(drProductFieldReader(opShopProductFieldLocked))
		ShopProductFieldDoNotPublish = Base.ChkBoolean(drProductFieldReader(opShopProductFieldDoNotPublish))
		ShopProductFieldSelectvalues = Base.ChkBoolean(drProductFieldReader(opShopProductFieldSelectvalues))
		ShopProductFieldGroupID = Base.ChkNumber(drProductFieldReader(opShopProductFieldGroupID))
	End If

	drProductFieldReader.Dispose
	sCmdShop.Dispose
	ShopConn.Dispose

End If
%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("produkt felt")), Translate.Translate("Felt"), "all")%>
<table border="0" cellpadding="0" cellspacing=0 class=tabTable>
	<tr>
		<td valign=top>
		<form name="ShopProductField" id="ShopProductField" method="Post">
		<input type="hidden" name="ShopProductFieldID" value="<%=ShopProductFieldID%>">
		<input type="hidden" name="ShopProductFieldGroupID" value="<%=ShopProductFieldGroupID%>">
		<div ID="Tab1" STYLE="display:;">
		<br>
		<table border="0" cellpadding="0" width=598>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Detaljer"))%>
					<table cellpadding=2 cellspacing=0>
						<tr>
							<td width=170><%=Translate.Translate("Navn")%></td>
							<td><input type="text" name="ShopProductFieldName" size="30" maxlength="255" value="<%=Server.HtmlEncode(ShopProductFieldName)%>" class=std></td>
						</tr>
						<tr>
							<td width=170><%=Translate.Translate("Systemnavn")%></td>
							<td>
							<%If ShopProductFieldSystemName <> "" Then%>
								<input type="text" name="ShopProductFieldSystemName_NIU" size="30" maxlength="255" value="<%=ShopProductFieldSystemName%>" class=std DISABLED>
								<input type="hidden" name="ShopProductFieldSystemName" size="30" maxlength="255" value="<%=ShopProductFieldSystemName%>" class=std>
							<%Else%>
								<input type="text" name="ShopProductFieldSystemName" size="30" maxlength="100" value="<%=ShopProductFieldSystemName%>" class=std>
							<%End If%>
							</td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Type")%></td>
							<td>
							<%
							If CStr(ShopProductFieldTypeID) <> "" Then
								Response.Write(Gui.TableSelect("DWShop.mdb", "ShopProductFieldType", "ShopProductFieldTypeID", "ShopProductFieldTypeName", "ShopProductFieldTypeID", ShopProductFieldTypeID, "ShopProductFieldTypeID", "", True))
								Response.Write("<input type=hidden name=ShopProductFieldTypeID value=""" & ShopProductFieldTypeID & """>")
							Else
								Response.Write(Gui.TableSelect("DWShop.mdb", "ShopProductFieldType", "ShopProductFieldTypeID", "ShopProductFieldTypeName", "ShopProductFieldTypeID", ShopProductFieldTypeID, "ShopProductFieldTypeID", "", False))
							End If
							%>
							</td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Template tag")%></td>
							<td><input type="text" name="ShopProductFieldTemplateName" size="30" maxlength="255" value="<%=Server.HtmlEncode(ShopProductFieldTemplateName)%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("LÃ¥s felt")%></td>
							<td><%=Gui.CheckBox(ShopProductFieldLocked, "ShopProductFieldLocked")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Publiser IKKE felt")%></td>
							<td><%=Gui.CheckBox(ShopProductFieldDoNotPublish, "ShopProductFieldDoNotPublish")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Brug definerede værdier")%></td>
							<td><%=Gui.CheckBox(ShopProductFieldSelectvalues, "ShopProductFieldSelectvalues")%></td>
						</tr>
						
					</table>
					<%=Gui.GroupBoxEnd%>
					<%If ShopProductFieldSelectvalues Then%>
					<%=Gui.GroupBoxStart(Translate.Translate("Værdier"))%>
					<table cellpadding=2 cellspacing=0 width="100%">
						<tr>
							<td width="200"><b><%=Translate.Translate("Værdi")%></b></td>
							<td><b><%=Translate.Translate("Navn")%></b></td>
						</tr>
						<%
						Dim sb As New System.Text.StringBuilder
						Dim objFieldvalues As New FieldValues(ShopProductFieldID)
						Dim objFieldvalue As FieldValue
						For Each objFieldvalue In objFieldvalues
							sb.Append("<tr>")
							sb.Append("<td><a href=""Product_Field_Values.aspx?ID=" & objFieldvalue.ID() & "&FieldID=" & ShopProductFieldID & """>" & objFieldvalue.Key() & "</a></td>")
							sb.Append("<td>" & objFieldvalue.Value() & "</td>")
							sb.Append("</tr>")
						Next
						Response.Write(sb.ToString())
						%>
						<tr>
							<td colspan="2" align="right"><%=Gui.Button(Translate.Translate("Ny værdi"), "location = 'Product_Field_Values.aspx?FieldID=" & ShopProductFieldID & "';", 0)%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%End If%>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right">
			<%=gui.MakeOkCancelHelp("Send('Product_Field_save.aspx');", "location='Product_Field_List.aspx';", True, "modules.shop.general.field.list.item.edit", "Shop_Product_Field")%>
		</td>
	</tr>
</table>
</form>

<%=Gui.SelectTab()%>
<script language="JavaScript">
<!--
if(document.getElementById("ShopProductFieldTypeID")) {
	objSelect = document.getElementById("ShopProductFieldTypeID");
	for(i = 0; i < objSelect.options.length; i++) {
		if(objSelect.options[i].value == "14")
			objSelect.options[i] = null;		
	}
}
//-->
</script>
</BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>