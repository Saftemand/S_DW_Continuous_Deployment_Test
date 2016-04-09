<%@ Page debug="true" CodeBehind="NewsletterExtended_Recipient_UserFields_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_UserFields_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%
Dim NewsletterUserFieldID As String
Dim TextareaSelected As String
Dim NewsletterUserFieldDBType As String
Dim MakeOptionLink As String
Dim NewsletterUserFieldActive As Boolean
Dim RadioSelected As String
Dim NewsletterUserFieldSize As String
Dim NewsletterUserFieldSort As Integer
Dim DecimalSelected As String
Dim SelectSelected As String
Dim TextSelected As String
Dim NewsletterUserFieldType As String
Dim Checked As String
Dim Checked2 As String
Dim i As Integer
Dim NewsletterUserFieldRequired As Boolean
Dim NewsletterUserFieldColor As String
Dim NewsletterUserFieldTextareaHeight As String
Dim NewsletterUserFieldAutoValue As String
Dim NewsletterUserFieldDefaultValue As String
Dim DisableOrJava As String
Dim CheckBoxSelected As String
Dim strAllSystemNames As String
Dim NewsletterUserFieldFormID As String
Dim sql As String
Dim NewsletterUserFieldtext As String
Dim NewsletterUserFieldSystemName As String
Dim TextInputSelected As String
Dim NewsletterUserFieldName As String
Dim NewsletterUserFieldMaxLength As String
Dim IntegerSelected As String


sql = "SELECT NewsletterUserFieldSystemName FROM NewsletterExtendedUserField"
Dim cn As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmd As IDbCommand = cn.CreateCommand

strAllSystemNames = ", "

cmd.CommandText = sql
Dim drSystemNames As IDataReader = cmd.ExecuteReader

Do While drSystemNames.Read()
	strAllSystemNames = strAllSystemNames & drSystemNames("NewsletterUserFieldSystemName") & ", "
Loop 

drSystemNames.Close()
drSystemNames.Dispose()

If strAllSystemNames = ", " Then
	strAllSystemNames = strAllSystemNames & ", "
End If
'we strAllSystemNames
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</head>
<script>

function CheckIfSystemNameExist(objField) {

	var strAllSystemNames
	strAllSystemNames = "<%=strAllSystemNames%>"

	if(objField==""){
		return false; 
	}<%If IsNothing(request.QueryString.GetValues("NewsletterUserFieldID")) Then%>
	else if(strAllSystemNames.indexOf(", " + objField + ", ") > -1) {
		return false;  
	}<%End If%>
	else {
		return true; 
	}
}

function AutoTekst(Show){
	if(document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldAutoValue){
		if(Show){
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldAutoValue.disabled 	= false;
			document.getElementById('NewsletterUserFieldAutoValueSpan').style.color		= '#000000';
		}else{
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldAutoValue.disabled 	= true;
			document.getElementById('NewsletterUserFieldAutoValueSpan').style.color		= '#c4c4c4';
		}
	}
}

//According to the selected input-type, this script decides which fields can be used (width, default value and so on..).
function WhichFields(Which){
	//NewsletterUserFieldType = document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldType;
	NewsletterUserFieldTypeSelector = document.getElementById("NewsletterUserFieldType")
	NewsletterUserFieldType = NewsletterUserFieldTypeSelector.options[NewsletterUserFieldTypeSelector.selectedIndex].value;
	
	switch (NewsletterUserFieldType){
		case "TextInput":
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldDefaultValue.disabled 	= false;
			document.getElementById('NewsletterUserFieldDefaultValueSpan').style.color 		= '#000000';
			AutoTekst(true);
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldMaxLength.disabled 		= false;
			document.getElementById('NewsletterUserFieldMaxLengthSpan').style.color 		= '#000000';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldSize.disabled 			= false;
			document.getElementById('NewsletterUserFieldSizeSpan').style.color 				= '#000000';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldTextareaHeight.disabled = true;
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').style.color 	= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldRequired.disabled 		= false;
			document.getElementById('NewsletterUserFieldRequiredSpan').style.color 			= '#000000';
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').innerHTML 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.getElementById('NewsletterUserFieldColor').disabled 					= true;
			document.getElementById('NewsletterUserFieldColorSpan').style.color 			= '#c4c4c4';
			document.getElementById('NewsletterUserFieldColorPreview').style.visibility		= 'hidden';
			document.getElementById('NewsletterUserFieldTextSpan').style.color				= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldText.disabled 			= true;
			document.getElementById('NewsletterUserFieldDBTypeSpan').style.color 		= '#000000';
			document.getElementById('NewsletterUserFieldDBType').disabled = false
			if(document.getElementById('NewsletterUserFieldID') != "")
				document.getElementById('NewsletterUserFieldDBType').disabled = true
				
			break;
		case "Textarea":
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldDefaultValue.disabled 	= false;
			document.getElementById('NewsletterUserFieldDefaultValueSpan').style.color 		= '#000000';
			AutoTekst(true);
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldMaxLength.disabled 		= true;
			document.getElementById('NewsletterUserFieldMaxLengthSpan').style.color 		= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldSize.disabled 			= false;
			document.getElementById('NewsletterUserFieldSizeSpan').style.color 				= '#000000';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldTextareaHeight.disabled = false;
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').style.color 	= '#000000';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldRequired.disabled 		= false;
			document.getElementById('NewsletterUserFieldRequiredSpan').style.color 			= '#000000';
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').innerHTML 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.getElementById('NewsletterUserFieldColor').disabled 					= true;
			document.getElementById('NewsletterUserFieldColorSpan').style.color 			= '#c4c4c4';
			document.getElementById('NewsletterUserFieldColorPreview').style.visibility		= 'hidden';
			document.getElementById('NewsletterUserFieldTextSpan').style.color				= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldText.disabled 			= true;
			document.getElementById('NewsletterUserFieldDBTypeSpan').style.color 		= '#c4c4c4';
			document.getElementById('NewsletterUserFieldDBType').disabled = true;
			break;
		case "Select":
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldDefaultValue.disabled 	= true;
			document.getElementById('NewsletterUserFieldDefaultValueSpan').style.color 		= '#c4c4c4';
			AutoTekst(false);
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldMaxLength.disabled 		= true;
			document.getElementById('NewsletterUserFieldMaxLengthSpan').style.color 		= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldSize.disabled 			= false;
			document.getElementById('NewsletterUserFieldSizeSpan').style.color 				= '#000000';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldTextareaHeight.disabled = true;
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').style.color 	= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldRequired.disabled 		= false;
			document.getElementById('NewsletterUserFieldRequiredSpan').style.color 			= '#000000';
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').innerHTML 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.getElementById('NewsletterUserFieldColor').disabled 					= true;
			document.getElementById('NewsletterUserFieldColorSpan').style.color 			= '#c4c4c4';
			document.getElementById('NewsletterUserFieldColorPreview').style.visibility		= 'hidden';
			document.getElementById('NewsletterUserFieldTextSpan').style.color				= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldText.disabled 			= true;
			document.getElementById('NewsletterUserFieldDBTypeSpan').style.color 		= '#c4c4c4';
			document.getElementById('NewsletterUserFieldDBType').disabled = true;
			break;
		case "CheckBox":
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldDefaultValue.disabled 	= false;
			document.getElementById('NewsletterUserFieldDefaultValueSpan').style.color 		= '#000000';
			AutoTekst(false);
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldMaxLength.disabled 		= true;
			document.getElementById('NewsletterUserFieldMaxLengthSpan').style.color 		= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldSize.disabled 			= true;
			document.getElementById('NewsletterUserFieldSizeSpan').style.color 				= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldTextareaHeight.disabled = true;
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').style.color 	= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldRequired.disabled 		= true;
			document.getElementById('NewsletterUserFieldRequiredSpan').style.color 			= '#c4c4c4';
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').innerHTML 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.getElementById('NewsletterUserFieldColor').disabled 					= true;
			document.getElementById('NewsletterUserFieldColorSpan').style.color 			= '#c4c4c4';
			document.getElementById('NewsletterUserFieldColorPreview').style.visibility		= 'hidden';
			document.getElementById('NewsletterUserFieldTextSpan').style.color				= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldText.disabled 			= true;
			document.getElementById('NewsletterUserFieldDBTypeSpan').style.color 		= '#c4c4c4';
			document.getElementById('NewsletterUserFieldDBType').disabled = true;
			break;
		case "Radio":
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldDefaultValue.disabled 	= false;
			document.getElementById('NewsletterUserFieldDefaultValueSpan').style.color 		= '#000000';
			AutoTekst(false);
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldMaxLength.disabled 		= true;
			document.getElementById('NewsletterUserFieldMaxLengthSpan').style.color 		= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldSize.disabled 			= true;
			document.getElementById('NewsletterUserFieldSizeSpan').style.color 				= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldTextareaHeight.disabled = true;
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').style.color 	= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldRequired.disabled 		= false;
			document.getElementById('NewsletterUserFieldRequiredSpan').style.color 			= '#000000';
			document.getElementById('NewsletterUserFieldTextareaHeightSpan').innerHTML 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.getElementById('NewsletterUserFieldColor').disabled 					= true;
			document.getElementById('NewsletterUserFieldColorSpan').style.color 			= '#c4c4c4';
			document.getElementById('NewsletterUserFieldColorPreview').style.visibility		= 'hidden';
			document.getElementById('NewsletterUserFieldTextSpan').style.color				= '#c4c4c4';
			document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldText.disabled 			= true;
			document.getElementById('NewsletterUserFieldDBTypeSpan').style.color 		= '#c4c4c4';
			document.getElementById('NewsletterUserFieldDBType').disabled = true;
			break;
	}
}

function DeleteOption(NewsletterUserFieldID,NewsletterUserFieldOptionsID){
	if(confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("valgmulighed"))%>')){
		location = 'NewsletterExtended_recipient_UserFields_Option_Del.aspx?NewsletterUserFieldID='+ NewsletterUserFieldID + '&NewsletterUserFieldOptionsID=' + NewsletterUserFieldOptionsID
	}
}

function ValidateForm(){
	FormOK = true;
	
	if(document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldName.value.length <= 0){
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldName.focus();
		FormOK = false;
	}
	else if(CheckIfSystemNameExist(document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldSystemName.value) != true){
		alert('<%=Translate.JsTranslate("System Navn er blank eller eksisterer i forvejen")%>');
		document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldSystemName.focus();
		FormOK = false;
	}

	if(FormOK){
		return true;
	}else{
		return false;
	}
}

function ValidateColor(obj, col){
	if ((col.charAt(0)=="#") && (col.charAt(1)<="f") && (col.charAt(2)<="f") && (col.charAt(3)<="f") && (col.charAt(4)<="f") && (col.charAt(5)<="f") && (col.charAt(6)<="f") && (col.length==7)){
		document.getElementById(obj).style.backgroundColor=col;
	}
}

function ColorPicker(exColor, fieldName){
	colorWin = window.open("../../stylesheet/colorpicker.asp?formname=NewsletterUserFieldForm&fieldname=" + fieldName, "", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=320,height=360");
}

function ChangeSystemName(fieldName) {
	if(document.getElementById('NewsletterUserFieldSystemName').value == "")
		document.getElementById('NewsletterUserFieldSystemName').value = fieldName.value
}


</script>
<body LEFTMARGIN="20" TOPMARGIN="16" onload="WhichFields();">
<%
NewsletterUserFieldID = request.QueryString.Item("NewsletterUserFieldID")

If NewsletterUserFieldID <> "" Then
	sql = "Select * FROM NewsletterExtendedUserField where NewsletterUserFieldID=" & NewsletterUserFieldID
	cmd.CommandText = sql
	Dim dr As IDataReader = cmd.ExecuteReader
	If dr.Read()
		NewsletterUserFieldName = dr("NewsletterUserFieldName").ToString()
		NewsletterUserFieldSystemName = dr("NewsletterUserFieldSystemName").ToString()
		NewsletterUserFieldType = dr("NewsletterUserFieldType").ToString()
		NewsletterUserFieldDBType = dr("NewsletterUserFieldDBType").ToString()
		NewsletterUserFieldDefaultValue = dr("NewsletterUserFieldDefaultValue").ToString()
		NewsletterUserFieldMaxLength = Base.ChkNumber(dr("NewsletterUserFieldMaxLength").ToString())
		NewsletterUserFieldSize = Base.ChkNumber(dr("NewsletterUserFieldSize").ToString())
		NewsletterUserFieldTextareaHeight = Base.ChkNumber(dr("NewsletterUserFieldTextareaHeight").ToString())
		NewsletterUserFieldActive = Base.ChkBoolean(dr("NewsletterUserFieldActive").ToString())
		NewsletterUserFieldRequired = Base.ChkBoolean(dr("NewsletterUserFieldRequired"))
		NewsletterUserFieldSort = Base.ChkNumber(dr("NewsletterUserFieldSort").ToString())
		NewsletterUserFieldtext = dr("NewsletterUserFieldText").ToString()
		NewsletterUserFieldColor = dr("NewsletterUserFieldColor").ToString()
		NewsletterUserFieldAutoValue = Trim(dr("NewsletterUserFieldAutoValue").ToString())
	End If
	If NewsletterUserFieldType = "select" Or NewsletterUserFieldType = "radio" Then
		MakeOptionLink = "<a href='MakeOption.aspx?ffid=" & NewsletterUserFieldID & "'><span class=buttons><img src='../images/GreySquare.gif' width='14' height='9' border='0'>" & Translate.Translate("Ny valgmulighed") & "&nbsp;</span></a>"
	Else
		MakeOptionLink = ""
	End If
	If NewsletterUserFieldMaxLength = "0" Then
		NewsletterUserFieldMaxLength = ""
	End If
	If NewsletterUserFieldSize = "0" Then
		NewsletterUserFieldSize = ""
	End If
	If NewsletterUserFieldTextareaHeight = "0" Then
		NewsletterUserFieldTextareaHeight = ""
	End If
	dr.Close()
	dr.Dispose()
	
Else
	NewsletterUserFieldFormID = request.QueryString.Item("NewsletterUserFieldFormID")
	NewsletterUserFieldRequired = False
	NewsletterUserFieldActive = True
	NewsletterUserFieldType = "TextInput"
End If
%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%", "%%", Translate.Translate("brugerfelt")), Translate.Translate("Felt"), "all")%>
<table border="0" cellpadding="2" cellspacing="0" Class="TabTable">
	<tr>
		<td valign="top">
			<br>
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			<form name="NewsletterUserFieldForm" id="NewsletterUserFieldForm" method="POST" action="NewsletterExtended_recipient_UserFields_Save.aspx">
			<input type="Hidden" name="NewsletterUserFieldID" value="<%=NewsletterUserFieldID%>">
			<input type="Hidden" name="NewsletterUserFieldFormID" value="<%=NewsletterUserFieldFormID%>">
			<table border="0" cellpadding="0" width="574">
				<tr>
					<td width="170"><%=Translate.Translate("Navn")%></td>
					<td><input type="text" name="NewsletterUserFieldName" size="25" OnChange="javascript:ChangeSystemName(this);" value="<%=NewsletterUserFieldName%>" class="std" maxlength=255></td>
				</tr>
				<tr>
					<td width="170"><%=Translate.Translate("Systemnavn")%></td>
					<td><input type="text" name="NewsletterUserFieldSystemName" value="<%=NewsletterUserFieldSystemName%>" class="std"
					<%If NewsletterUserFieldID <> "" Then
					     Response.Write(" Disabled ")
					  End If
					%>
				</tr>
				<tr>
					<td width="170"><%=Translate.Translate("Type")%></td>
					<%
If Not IsNothing(request.QueryString.GetValues("NewsletterUserFieldID")) Then
	DisableOrJava = " Disabled "
Else
	DisableOrJava = " onchange=""javascript:WhichFields();"" "
End If
%>
					<td>
						<select name="NewsletterUserFieldType" id="NewsletterUserFieldType" style="Width: 220px;" <%=DisableOrJava%> class="std">
							<%
Select Case NewsletterUserFieldType
	Case "Textinput" : TextInputSelected = " Selected "
	Case "Textarea" : TextareaSelected = " Selected "
	Case "Select" : SelectSelected = " Selected "
	Case "CheckBox" : CheckBoxSelected = " Selected "
	Case "Radio" : RadioSelected = " Selected "
End Select
%>
							<option value="TextInput"	<%=TextInputSelected%>	><%=Translate.Translate("Tekst")%>			</option>
							<option value="Textarea"	<%=TextareaSelected%>	><%=Translate.Translate("Notat-felt")%>		</option>
							<option value="Select" 		<%=SelectSelected%>	 	><%=Translate.Translate("Drop-down")%>		</option>
							<option value="CheckBox"	<%=CheckBoxSelected%>	><%=Translate.Translate("CheckBox")%>	</option>
							<option value="Radio" 		<%=RadioSelected%>	 	><%=Translate.Translate("Radio-knap")%>		</option>
						</select>
						</td>
					</tr>
					<tr>
						<td><SPAN id="NewsletterUserFieldDBTypeSpan" STYLE="color: #000000;"><%=Translate.Translate("DB felt type")%></SPAN></td>
						<td>
							<select name="NewsletterUserFieldDBType" style="Width: 220px;" class="std">
								<%
									Select Case NewsletterUserFieldType
										Case "Text" : TextSelected = " Selected "
										Case "Integer" : IntegerSelected = " Selected "
										Case "Decimal" : DecimalSelected = " Selected "
									End Select
								%>
								<option value="Text" <%=TextSelected%>>Text</option>
								<option value="Integer"	<%=IntegerSelected%>>Integer</option>
								<option value="Decimal"	<%=DecimalSelected%>>Decimal</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><SPAN id="NewsletterUserFieldDefaultValueSpan" STYLE="color: #000000;"><%=Translate.Translate("Standard værdi")%></SPAN></td>
						<td><input type=text name="NewsletterUserFieldDefaultValue" value="<%=NewsletterUserFieldDefaultValue%>" class="std" maxlength=255></td>
					</tr>
					<tr>
						<td ><SPAN id="NewsletterUserFieldMaxLengthSpan" STYLE="color: #000000;"><%=Translate.Translate("Max længde")%></SPAN></td>
						<td><input type="text" name="NewsletterUserFieldMaxLength" size="25" value="<%=NewsletterUserFieldMaxLength%>" class="std"></td>
					</tr>
					<tr>
						<td valign="top"><SPAN id="NewsletterUserFieldTextSpan" STYLE="color: #000000;"><%=Translate.Translate("Tekst")%></SPAN></td>
						<td><textarea name="NewsletterUserFieldText" size="25" class="std"><%=NewsletterUserFieldtext%></textarea></td>
					</tr>
					<tr>
						<td ><SPAN id="NewsletterUserFieldRequiredSpan" STYLE="color: #000000;"><%=Translate.Translate("Obligatorisk")%></SPAN></td>
						<td><%If NewsletterUserFieldRequired Then Checked = "Checked"%><input type="CheckBox" class="clean" name="NewsletterUserFieldRequired" size="25" <%=Checked%>></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Medtag")%></td>
						<td><%If NewsletterUserFieldActive Then Checked2 = "Checked"%><input type="CheckBox"	class="clean" <%=Checked2%> name="NewsletterUserFieldActive" size="25"></td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd%>
			</td>
		</tr>
		<tr>
			<td>
			<%=Gui.GroupBoxStart(Translate.Translate("Layout",1))%>
				<table border="0" cellpadding="0" width="574">
					<tr>
						<td width="170" ><SPAN id="NewsletterUserFieldSizeSpan" STYLE="color: #000000;"><%=Translate.Translate("Størrelse (i px)")%></SPAN></td>
						<td><input type="text" name="NewsletterUserFieldSize" size="25" value="<%=NewsletterUserFieldSize%>" class="std"></td>
					</tr>
					<tr>
						<td width="170" ><SPAN id="NewsletterUserFieldTextareaHeightSpan" STYLE="color: #000000;"><%=Translate.Translate("Højde (Linier)")%></SPAN></td>
						<td><input type="text" name="NewsletterUserFieldTextareaHeight" size="25" value="<%=NewsletterUserFieldTextareaHeight%>" class="std"></td>
					</tr>
					<tr>
						<td width="170" ><SPAN id="NewsletterUserFieldColorSpan" STYLE="color: #000000;"><%=Translate.Translate("Farve")%></SPAN></td>
						<td><%=Gui.ColorSelect(NewsletterUserFieldColor, "NewsletterUserFieldColor")%></td>
					</tr>
					<tr>	
						<td>&nbsp;</td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd%>
			<%If (NewsletterUserFieldType = "Select" Or NewsletterUserFieldType = "Radio") And Not NewsletterUserFieldID = "" Then
				Response.Write(Gui.GroupBoxStart(Translate.Translate("Valgmuligheder")))%>
				<table border="0" cellpadding="0" width="574">
					<tr>
						<td width="175"><strong><%=Translate.Translate("Tekst")%></strong></td>
						<td width="175"><strong><%=Translate.Translate("Værdi")%></strong></td>
						<td align="center"><strong><%=Translate.Translate("Sortering")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Medtag")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Default")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
					</tr>
					<tr>
						<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
					<%	
	sql = "SELECT Count(*) FROM NewsletterExtendedUserFieldOptions WHERE NewsletterUserFieldOptionsFieldID =" & NewsletterUserFieldID 
	cmd.CommandText = sql
	Dim recordCount As Integer = 0
	recordCount = cmd.ExecuteScalar()
	
	sql = "SELECT * FROM NewsletterExtendedUserFieldOptions WHERE NewsletterUserFieldOptionsFieldID =" & NewsletterUserFieldID & " ORDER BY NewsletterUserFieldOptionsSort"
	cmd.CommandText = sql
	Dim dr As IDataReader = cmd.ExecuteReader
	
	i = 0
	Do While dr.Read()
		i = i + 1
		Response.Write("<tr>")
		Response.Write("<td width=""175""><a href=""NewsletterExtended_recipient_UserFields_Option_Edit.aspx?NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID").ToString & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """>" & dr("NewsletterUserFieldOptionsText").ToString & "</a></td>")
		Response.Write("<td width=""175"">" & dr("NewsletterUserFieldOptionsValue").ToString & "</td>")
		If i = 1 Then
			Response.Write("<td align=""center""><img src=""../../images/nothing.gif"" width=""15"">&nbsp;<a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Down&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
		ElseIf i = recordCount Then 
			Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Up&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<img src=""../../images/Nothing.gif"" width=""15""></td>")
		Else
			Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Up&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Down&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
		End If
		If Base.ChkBoolean(dr("NewsletterUserFieldOptionsActive")) Then
			Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_SetActive.aspx?SetActive=False&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
		Else
			Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_SetActive.aspx?SetActive=True&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
		End If
		If Base.ChkBoolean(dr("NewsletterUserFieldOptionsDefaultSelected")) Then
			Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_SetDefault.aspx?NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
		Else
			Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_SetDefault.aspx?NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
		End If
		Response.Write("<td align=""center""><a href=""javascript:DeleteOption(" & NewsletterUserFieldID & "," & dr("NewsletterUserFieldOptionsID") & ");""><img src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.Translate("Slet %%", "%%", Translate.Translate("valgmulighed")) & """></a></td>")
		Response.Write("</tr>")
		Response.Write("<tr>")
		Response.Write("<td colspan=""6"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 alt="""" border=""0""></td>")
		Response.Write("</tr>")
	
	Loop 
	dr.Close()
	dr.Dispose()
	%>
					<tr>
						<td colspan='6' align='right'><br><%=Gui.Button(Translate.Translate("Ny valgmulighed"), "javascript:location='NewsletterExtended_recipient_UserFields_Option_Edit.aspx?NewsletterUserFieldID=" & NewsletterUserFieldID & "';", 0)%></td>
					</tr>
				</table>
			<%Response.Write(Gui.GroupBoxEnd)
End If%>
			</form>
		</td>
	</tr>
	<tr>
		<td align="right" valign=bottom>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><%= Gui.Button(Translate.Translate("OK"), "if(ValidateForm()){document.getElementById('NewsletterUserFieldForm').NewsletterUserFieldType.disabled=false;document.getElementById('NewsletterUserFieldForm').submit();};", 0)%></td>
					<td width="5"></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='NewsletterExtended_recipient_UserFields.aspx'", 0)%></td>
					<%=Gui.HelpButton("newsletterV2","modules.newsletterextended.general.userfield.edit",,5)%>
					<td width="10"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%
cmd.Dispose()
cn.Close
cn.Dispose()

Translate.GetEditOnlineScript()
%>
</body>
</html>