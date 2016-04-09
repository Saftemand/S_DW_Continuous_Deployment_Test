<%@ Page CodeBehind="Form_Module_Field_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Field_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>


<%

Dim i As Integer
Dim Checked as String
Dim Checked2 As String
Dim HiddenSelected As Object
Dim ImageSelected As Object
Dim TextSelected As Object
Dim DividerSelected As Object
Dim FileSelected As Object
Dim ResetSelected As Object
Dim SubmitSelected As Object
Dim RadioSelected As Object
Dim CheckBoxSelected As Object
Dim SelectSelected As Object
Dim TextareaSelected As Object
Dim TextInputSelected As Object
Dim DisableOrJava As Object
Dim FormFieldAutoValue As Object
Dim FormFieldColor As Object
Dim FormFieldImage As Object
Dim FormFieldtext As Object
Dim FormFieldSort As Object
Dim FormFieldRequired As Object
Dim FormFieldActive As Object
Dim FormFieldTextareaHeight As Object
Dim FormFieldSize As Object
Dim FormFieldMaxLength As Object
Dim FormFieldDefaultValue As Object
Dim FormFieldType As Object
Dim FormFieldSystemName As Object
Dim FormFieldName As Object
Dim FormFieldFormID As Object
Dim FormFieldID As Object
Dim recordCount as Integer = 0

Dim FormFieldAttenoFieldName as String
Dim DisableSystemName As String = ""
    FormFieldID = Request.QueryString.Item("FormFieldID")

    Dim cn As IDbConnection = Database.CreateConnection("Dynamic.mdb")
    Dim cmd As IDbCommand = cn.CreateCommand
    Dim dr As IDataReader

    If Not FormFieldID = "" Then
        cmd.CommandText = "Select * from FormField where FormFieldID=" & FormFieldID
        dr = cmd.ExecuteReader()
        If dr.Read() Then
            FormFieldFormID = dr("FormFieldFormID").ToString()
            FormFieldName = dr("FormFieldName").ToString()
            FormFieldSystemName = dr("FormFieldSystemName").ToString()
            FormFieldType = dr("FormFieldType").ToString()
            FormFieldDefaultValue = dr("FormFieldDefaultValue").ToString()
            FormFieldMaxLength = dr("FormFieldMaxLength").ToString()
            FormFieldSize = dr("FormFieldSize").ToString()
            FormFieldTextareaHeight = dr("FormFieldTextareaHeight").ToString()
            FormFieldActive = dr("FormFieldActive").ToString()
            FormFieldRequired = dr("FormFieldRequired").ToString()
            FormFieldSort = dr("FormFieldSort").ToString()
            FormFieldtext = dr("FormFieldText").ToString()
            FormFieldImage = dr("FormFieldImage").ToString()
            FormFieldColor = dr("FormFieldColor").ToString()
            FormFieldAutoValue = Trim(dr("FormFieldAutoValue").ToString())
    		
            ''' Atteno Integration

            ''' Atteno Integration
    		
            If FormFieldType = "Select" Or FormFieldType = "Radio" Then
                tbEditOptions.Visible = True
            Else
                tbEditOptions.Visible = False
            End If
            If Base.ChkNumber(FormFieldMaxLength) = 0 Then
                FormFieldMaxLength = ""
            End If
            If FormFieldSize = 0 Then
                FormFieldSize = ""
            End If
            If Base.ChkNumber(FormFieldTextareaHeight) = 0 Then
                FormFieldTextareaHeight = ""
            End If
        Else
            FormFieldFormID = Request.QueryString.Item("FormFieldFormID")
            FormFieldRequired = False
            FormFieldActive = True
            FormFieldType = "TextInput"
        End If
        dr.Close()
        dr.Dispose()
    Else
        tbEditOptions.Visible = False 
        FormFieldFormID = Request.QueryString.Item("FormFieldFormID")
        FormFieldRequired = False
        FormFieldActive = True
        FormFieldType = "TextInput"
        FormFieldAutoValue = ""
    End If

    Response.Write(Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%", Translate.Translate("Formularer", 9), "%c%", Translate.Translate("felt")), Translate.Translate("Felt"), "all"))
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
    <link rel="Stylesheet" type="text/css" href="Form.css" />
</head>
<script>
 function helpLink()
 {
      <%= Gui.Help("news", "modules.news.general.list")%>;
 }
 function EditOptions()
 {
     <%="location='Form_Module_Option_Edit.aspx?FormFieldID=" & FormFieldID & "&FormFieldFormID=" & FormFieldFormID & "';"%>
 }
var FormID = <%=FormFieldFormID%>;
function AutoTekst(Show){
	if(document.getElementById('FormFieldForm').FormFieldAutoValue){
		if(Show){
			document.getElementById('FormFieldForm').FormFieldAutoValue.disabled 	= false;
			document.all.FormFieldAutoValueSpan.style.color		= '#000000';
		}else{
			document.getElementById('FormFieldForm').FormFieldAutoValue.disabled 	= true;
			document.all.FormFieldAutoValueSpan.style.color		= '#c4c4c4';
		}
	}
}

//According to the selected input-type, this script decides which fields can be used (width, default value and so on..).
function WhichFields(Which){
	FormFieldType = document.getElementById('FormFieldForm').FormFieldType.value;
	switch (FormFieldType){
		case "TextInput":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= false;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#000000';
			AutoTekst(true);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= false;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#000000';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= false;
			document.all.FormFieldSizeSpan.style.color 				= '#000000';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= false;
			document.all.FormFieldRequiredSpan.style.color 			= '#000000';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "File":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= true;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#c4c4c4';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= false;
			document.all.FormFieldSizeSpan.style.color 				= '#000000';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= true;
			document.all.FormFieldRequiredSpan.style.color 			= '#000000';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "Textarea":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= false;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#000000';
			AutoTekst(true);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= false;
			document.all.FormFieldSizeSpan.style.color 				= '#000000';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = false;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#000000';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= false;
			document.all.FormFieldRequiredSpan.style.color 			= '#000000';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "Select":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= true;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#c4c4c4';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= false;
			document.all.FormFieldSizeSpan.style.color 				= '#000000';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= false;
			document.all.FormFieldRequiredSpan.style.color 			= '#000000';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "CheckBox":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= false;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#000000';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= true;
			document.all.FormFieldSizeSpan.style.color 				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= false;
			document.all.FormFieldRequiredSpan.style.color 			= '#000000';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "Radio":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= false;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#000000';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= true;
			document.all.FormFieldSizeSpan.style.color 				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= false;
			document.all.FormFieldRequiredSpan.style.color 			= '#000000';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "Submit":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= false;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#000000';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= false;
			document.all.FormFieldSizeSpan.style.color 				= '#000000';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= true;
			document.all.FormFieldRequiredSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#000000';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= false;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "Reset":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= false;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#000000';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= false;
			document.all.FormFieldSizeSpan.style.color 				= '#000000';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= true;
			document.all.FormFieldRequiredSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#000000';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= false;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "Divider":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= true;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#c4c4c4';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= false;
			document.all.FormFieldSizeSpan.style.color 				= '#000000';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = false;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#000000';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= true;
			document.all.FormFieldRequiredSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (px)")%>';
			document.all.FormFieldColor.disabled 					= false;
			document.all.FormFieldColorSpan.style.color 			= '#000000';
			document.all.FormFieldColorPreview.style.visibility		= 'visible';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "Text":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= true;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#c4c4c4';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= false;
			document.all.FormFieldSizeSpan.style.color 				= '#000000';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= true;
			document.all.FormFieldRequiredSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#000000';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= false;
			break;
		case "Hidden":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= false;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#000000';
			AutoTekst(true);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= true;
			document.all.FormFieldSizeSpan.style.color 				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= true;
			document.all.FormFieldRequiredSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= true;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
		case "Image":
			document.getElementById('FormFieldForm').FormFieldDefaultValue.disabled 	= true;
			document.all.FormFieldDefaultValueSpan.style.color 		= '#c4c4c4';
			AutoTekst(false);
			document.getElementById('FormFieldForm').FormFieldMaxLength.disabled 		= true;
			document.all.FormFieldMaxLengthSpan.style.color 		= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldSize.disabled 			= true;
			document.all.FormFieldSizeSpan.style.color 				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldTextareaHeight.disabled = true;
			document.all.FormFieldTextareaHeightSpan.style.color 	= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldRequired.disabled 		= true;
			document.all.FormFieldRequiredSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldTextareaHeightSpan.innerText 		= '<%=Translate.Translate("Højde (Linier)")%>';
			document.all.FormFieldColor.disabled 					= true;
			document.all.FormFieldColorSpan.style.color 			= '#c4c4c4';
			document.all.FormFieldColorPreview.style.visibility		= 'hidden';
			document.all.FormFieldImageSpan.style.color				= '#000000';
			document.getElementById('FormFieldForm').FormFieldImage.disabled 			= false;
			document.all.FormFieldTextSpan.style.color				= '#c4c4c4';
			document.getElementById('FormFieldForm').FormFieldText.disabled 			= true;
			break;
	}
	document.getElementById('FormFieldForm').FormFieldName.focus();
}

function DeleteOption(FormFieldID,FormOptionsID,FormFieldText){
	if(confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("valgmulighed"))%>\n(' + FormFieldText + ')')){
		location = 'Form_Module_Option_Del.aspx?FormFieldID='+ FormFieldID + '&FormOptionsID=' + FormOptionsID
	}
}

function ValidateForm(){
	FormOK = true;
	if(document.getElementById('FormFieldForm').FormFieldName.value.length <= 0){
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Tekst"))%>');
		document.getElementById('FormFieldForm').FormFieldName.focus();
		return false;
	}
	else if(document.getElementById('FormFieldForm').FormFieldName.value.length > 200){
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","200")%><%=Translate.JSTranslate("Tekst/Label")%>");
		document.getElementById('FormFieldForm').FormFieldName.focus();
		return false;
	}
	else if(document.getElementById('FormFieldForm').FormFieldSystemName.value.length > 200){
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","200")%><%=Translate.JSTranslate("Systemnavn")%>");
		document.getElementById('FormFieldForm').FormFieldName.focus();
		return false;
	}
	else if(document.getElementById('FormFieldForm').FormFieldSystemName.value.length <= 0){
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Systemnavn"))%>');
		document.getElementById('FormFieldForm').FormFieldSystemName.focus();
		return false;
	}
	else if(document.getElementById('FormFieldForm').FormFieldSystemName.value.toLowerCase() == "submit"){
		alert('<%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Systemnavn"))%>');
		document.getElementById('FormFieldForm').FormFieldSystemName.focus();
		return false;
	}

	if(document.getElementById('FormFieldForm').FormFieldSystemName.value.length > 0){
		var strOkString = "abcdefghijklmnopqrstuvwxyz_0123456789"
		var strTestString = document.getElementById('FormFieldForm').FormFieldSystemName.value.toLowerCase();
		for (var i = 0; i < strTestString.length; i++) {
		    if (strOkString.indexOf(strTestString.charAt(i)) == -1) {
				alert('<%=Translate.JsTranslate("Ugyldige tegn: ")%>\n(' + strTestString.charAt(i) + ')');
				document.getElementById('FormFieldForm').FormFieldSystemName.focus();
        		return false;
			}
		}
   	}
	
	var form = document.forms["FormFieldForm"];
	
	var maxLength = form.elements["FormFieldMaxLength"];
	if (maxLength.value != "" && isNaN(maxLength.value))
	{
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Max længde"))%>");
		maxLength.focus();
		return false;
	}
	
	var fieldSize = form.elements["FormFieldSize"];
	if (fieldSize.value != "" && isNaN(fieldSize.value))
	{
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Størrelse"))%>");
		fieldSize.focus();
		return false;
	}
	
	var fieldHeight = form.elements["FormFieldTextareaHeight"];
	if (fieldHeight.value != "" && isNaN(fieldHeight.value))
	{
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Højde"))%>");
		fieldHeight.focus();
		return false;
	}
	
	return true;
}

function ValidateColor(obj, col){
	if ((col.charAt(0)=="#") && (col.charAt(1)<="f") && (col.charAt(2)<="f") && (col.charAt(3)<="f") && (col.charAt(4)<="f") && (col.charAt(5)<="f") && (col.charAt(6)<="f") && (col.length==7)){
		document.all[obj].style.backgroundColor=col;
	}
}

function ColorPicker(exColor, fieldName){
	colorWin = window.open("../../stylesheet/colorpicker.aspx?formname=FormFieldForm&fieldname=" + fieldName, "", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=320,height=360");
}

</script>
<body onload="WhichFields();" class="WhiteBackground">
<table border="0" cellpadding="0" cellspacing="0" Class="TabTable">
	<form name="FormFieldForm" id="FormFieldForm" method="POST" action="Form_Module_Field_Save.aspx">
	<input type="Hidden" name="FormFieldID" value="<%=FormFieldID%>">
	<input type="Hidden" name="FormFieldFormID" value="<%=FormFieldFormID%>">
	<input type="Hidden" name="NewSort" value="<%=request.QueryString.Item("NewSort")%>">
    <dw:Toolbar ID="FormsToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                       <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="window.location.href='Form_Module_List.aspx';" Image="Home" Text="Start" Divide="After">
                       </dw:ToolbarButton>
                      <dw:ToolbarButton ID="tbSave" runat="server" OnClientClick="if(ValidateForm()){document.getElementById('FormFieldForm').FormFieldType.disabled=false;document.getElementById('FormFieldForm').FormFieldSystemName.disabled=false;document.getElementById('FormFieldForm').submit();};" Image="SaveAndClose" Text="Save">
                       </dw:ToolbarButton>
                      <dw:ToolbarButton ID="tbCancel" runat="server" OnClientClick="window.location.href='Form_Module_Edit.aspx?FormID='+FormID;" Image="Cancel" Text="Cancel">
                       </dw:ToolbarButton>
                       <dw:ToolbarButton ID="tbEditOptions" runat="server" Image="EditGear" Text="Edit options" OnClientClick="EditOptions();">
                       </dw:ToolbarButton>
                       <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick="helpLink();">
                       </dw:ToolbarButton>
                    </dw:Toolbar>
	<tr>
		<td valign="top"  class="WhiteBackground">
			<br>
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			<table border="0" cellpadding="0">
				<tr>
					<td width="170"><%=Translate.Translate("Tekst/Label")%></td>
					<td><input type="text" name="FormFieldName" size="25" value="<%=Server.HtmlEncode(FormFieldName)%>" class="std" maxlength="255"></td>
				</tr>
				<tr>
					<td width="170"><%=Translate.Translate("Systemnavn")%></td>
                    <%
                    If Not IsNothing(Request.QueryString.GetValues("FormFieldID")) Then
                            DisableSystemName = "disabled=""disabled"""
					    Else
                            DisableSystemName = ""
                        End If
                    %>
					<td><input type="text" name="FormFieldSystemName" size="25" value="<%=FormFieldSystemName%>" <%=DisableSystemName%> class="std" maxlength="255"></td>
				</tr>
				<%If Base.HasAccess("AttenoIntegration", "") Then%>
				<tr>
					<td width="170"><%=Translate.Translate("Atteno feltnavn")%></td>
					<td><input type="text" name="FormFieldAttenoFieldName" size="25" value="<%=FormFieldAttenoFieldName%>" class="std" maxlength="255"></td>
				</tr>
				<%End If%>
				<tr>
					<td width="170"><%=Translate.Translate("Type")%></td>
					<%
					    If Not IsNothing(Request.QueryString.GetValues("FormFieldID")) Then
					        DisableOrJava = " Disabled "
					    Else
					        DisableOrJava = " onchange=""javascript:WhichFields();"" "
					    End If
                    %>
					<td>
						<select name="FormFieldType" style="Width: 220px;" <%=DisableOrJava%> class="std">
							<%
							    Select Case FormFieldType
							        Case "Textinput"
							            TextInputSelected = " Selected "
							        Case "Textarea"
							            TextareaSelected = " Selected "
							        Case "Select"
							            SelectSelected = " Selected "
							        Case "CheckBox"
							            CheckBoxSelected = " Selected "
							        Case "Radio"
							            RadioSelected = " Selected "
							        Case "Submit"
							            SubmitSelected = " Selected "
							        Case "Reset"
							            ResetSelected = " Selected "
							        Case "File"
							            FileSelected = " Selected "
							        Case "Divider"
							            DividerSelected = " Selected "
							        Case "Text"
							            TextSelected = " Selected "
							        Case "Image"
							            ImageSelected = " Selected "
							        Case "Hidden"
							            HiddenSelected = " Selected "
							    End Select
                            %>
							<option value="TextInput"	<%=TextInputSelected%>	><%=Translate.Translate("Tekst")%>			</option>
							<option value="Hidden" 		<%=HiddenSelected%>	 	><%=Translate.Translate("Skjult")%>			</option>
							<option value="Textarea"	<%=TextareaSelected%>	><%=Translate.Translate("Notat-felt")%>		</option>
							<option value="Select" 		<%=SelectSelected%>	 	><%=Translate.Translate("Drop-down")%>		</option>
							<option value="CheckBox"	<%=CheckBoxSelected%>	><%=Translate.Translate("CheckBox")%>		</option>
							<option value="Radio" 		<%=RadioSelected%>	 	><%=Translate.Translate("Radio-knap")%>		</option>
							<option value="Submit" 		<%=SubmitSelected%>	 	><%=Translate.Translate("Send")%>			</option>
							<option value="Reset" 		<%=ResetSelected%>	 	><%=Translate.Translate("Reset")%>			</option>
							<option value="File" 		<%=FileSelected%>		><%=Translate.Translate("Upload")%>			</option>
							<option value="Divider" 	<%=DividerSelected%> 	><%=Translate.Translate("Mellemrum")%>		</option>
							<option value="Text" 		<%=TextSelected%>	 	><%=Translate.Translate("Brødtekst")%>		</option>
							<option value="Image" 		<%=ImageSelected%>	 	><%=Translate.Translate("Billede")%>		</option>
						</select>
						</td>
					</tr>
					<tr>
						<td><SPAN id="FormFieldDefaultValueSpan" STYLE="color: #000000;"><%=Translate.Translate("Standard værdi")%></SPAN></td>
						<td><input type=text name="FormFieldDefaultValue" value="<%=Server.HtmlEncode(FormFieldDefaultValue)%>" class="std" maxlength=255></td>
					</tr>
					<tr>
						<td><SPAN id="FormFieldAutoValueSpan" STYLE="color: #000000;"><%=Translate.Translate("Automatisk værdi")%></SPAN></td>
						<td><%=Gui.FormFieldAutoValueSelect(FormFieldAutoValue, "FormFieldAutoValue")%></td>
					</tr>
					<tr>
						<td ><SPAN id="FormFieldMaxLengthSpan" STYLE="color: #000000;"><%=Translate.Translate("Max længde")%></SPAN></td>
						<td><input type="text" name="FormFieldMaxLength" size="25" value="<%=FormFieldMaxLength%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td valign="top"><SPAN id="FormFieldTextSpan" STYLE="color: #000000;"><%=Translate.Translate("Tekst")%></SPAN></td>
						<td><textarea name="FormFieldText" size="25" maxlength="255" class="std"><%=FormFieldtext%></textarea></td>
					</tr>
					<tr>
						<td ><SPAN id="FormFieldRequiredSpan" STYLE="color: #000000;"><%=Translate.Translate("Obligatorisk")%></SPAN></td>
						<td><%If (FormFieldRequired = True) Then Checked = "Checked"%><input type="Checkbox" class="clean" name="FormFieldRequired" size="25" <%=Checked%>></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Medtag")%></td>
						<td><%If (FormFieldActive = True) Then Checked2 = "Checked"%><input type="CheckBox"	class="clean" <%=Checked2%> name="FormFieldActive" size="25"></td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd()%>
			<%=Gui.GroupBoxStart(Translate.Translate("Layout"))%>
				<table border="0" cellpadding="0" width="574">
					<tr>
						<td width="170" ><SPAN id="FormFieldSizeSpan" STYLE="color: #000000;"><%=Translate.Translate("Størrelse (i px)")%></SPAN></td>
						<td><input type="text" name="FormFieldSize" size="25" value="<%=FormFieldSize%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td width="170" ><SPAN id="FormFieldTextareaHeightSpan" STYLE="color: #000000;"><%=Translate.Translate("Højde (Linier)")%></SPAN></td>
						<td><input type="text" name="FormFieldTextareaHeight" size="25" value="<%=FormFieldTextareaHeight%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td width="170" ><SPAN id="FormFieldImageSpan" STYLE="color: #000000;"><%=Translate.Translate("Billede")%></SPAN></td>
						<td><%= Gui.FileManager(FormFieldImage, Dynamicweb.Content.Management.Installation.ImagesFolderName, "FormFieldImage")%></td>
					</tr>
					<tr>
						<td width="170" ><SPAN id="FormFieldColorSpan" STYLE="color: #000000;"><%=Translate.Translate("Farve")%></SPAN></td>
						<td><%=Gui.ColorSelect(FormFieldColor, "FormFieldColor")%></td>
					</tr>
					<tr>	
						<td>&nbsp;</td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd()%>
			<%If (FormFieldType = "Select" Or FormFieldType = "Radio") And Not FormFieldID = "" Then
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
					    cmd.CommandText = "SELECT Count(*) As Amount FROM FormOptions WHERE FormOptionsFormFieldID =" & FormFieldID
					    recordCount = cmd.ExecuteScalar()
                    	
					    cmd.CommandText = "SELECT * FROM FormOptions WHERE FormOptionsFormFieldID =" & FormFieldID & " ORDER BY FormOptionsSort"
					    dr = cmd.ExecuteReader()
                    		
					    i = 0
					    Do While dr.Read()
					        i = i + 1
					        Response.Write("<tr>")
					        Response.Write("<td width=""175""><a href=""Form_Module_Option_Edit.aspx?FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """>" & Server.HtmlEncode(dr("FormOptionsText").ToString()) & "</a></td>")
					        Response.Write("<td width=""175"">" & Server.HtmlEncode(dr("FormOptionsValue").ToString()) & "</td>")
					        If i = 1 Then
					            If recordCount > 1 Then
					                Response.Write("<td align=""center""><img src=""../../images/nothing.gif"" width=""15"">&nbsp;<a href=""Form_Module_Option_Sort.aspx?SortDirection=Down&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
					            Else
					                Response.Write("<td align=""center""><img src=""../../images/nothing.gif"" width=""15"">&nbsp;</td>")
					            End If
					        ElseIf i = recordCount Then
					            Response.Write("<td align=""center""><a href=""Form_Module_Option_Sort.aspx?SortDirection=Up&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<img src=""../../images/Nothing.gif"" width=""15""></td>")
					        Else
					            Response.Write("<td align=""center""><a href=""Form_Module_Option_Sort.aspx?SortDirection=Up&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""Form_Module_Option_Sort.aspx?SortDirection=Down&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
					        End If
					        If Base.ChkBoolean(dr("FormOptionsActive")) Then
					            Response.Write("<td align=""center""><a href=""Form_Module_Option_SetActive.aspx?SetActive=False&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
					        Else
					            Response.Write("<td align=""center""><a href=""Form_Module_Option_SetActive.aspx?SetActive=True&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
					        End If
					        If Base.ChkBoolean(dr("FormOptionsDefaultSelected")) Then
					            Response.Write("<td align=""center""><a href=""Form_Module_Option_SetDefault.aspx?FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
					        Else
					            Response.Write("<td align=""center""><a href=""Form_Module_Option_SetDefault.aspx?FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
					        End If
					        Response.Write("<td align=""center""><a href=""javascript:DeleteOption(" & FormFieldID & "," & dr("FormOptionsID").ToString & ", '" & Base.JSEncode(Server.HtmlEncode(dr("FormOptionsText").ToString())) & "');""><img src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.JsTranslate("Slet %%", "%%", Translate.JsTranslate("valgmulighed")) & """></a></td>")
					        Response.Write("</tr>")
					        Response.Write("<tr>")
					        Response.Write("<td colspan=""6"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 alt="""" border=""0""></td>")
					        Response.Write("</tr>")
					    Loop

					    'Cleanup
					    dr.Close()
					    dr.Dispose()
					    cmd.Dispose()
					    cn.Dispose()
                    %>
					<tr>
					
                    <td></td>
                    </tr>
				</table>
			<%Response.Write(Gui.GroupBoxEnd())
End If%>
		</td>
	</tr>
	<tr>
		<td align="right" valign=bottom>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
				</form>
			</table>
		</td>
	</tr>
</table>
<%
Translate.GetEditOnlineScript()
%>
