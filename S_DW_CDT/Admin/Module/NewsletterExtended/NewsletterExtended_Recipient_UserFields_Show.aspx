<%@ Import namespace="Dynamicweb.Backend" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function newsletterExtendedTextFieldCheck(objField, type, fieldname) {
	if(objField.value != '') {
		if(type==1) {
			if(chkNumeric(objField,-9999999999999999999999999999,9999999999999999999999999999,',','','', fieldname, '<%=Translate.JsTranslate("Feltet �%FieldName%� m� kun indeholde f�lgende tegn:")%>\n%checkOK%', '<%=Translate.JsTranslate("Feltet �%FieldName%� m� kun indeholde tal i f�lgende interval:")%>\n%minval% - %maxval%'))
					objField.value=""
		} else if(type==2) {
			if(chkNumeric(objField,-2147483648,2147483648,'','','', fieldname, '<%=Translate.JsTranslate("Feltet �%FieldName%� m� kun indeholde f�lgende tegn:")%>\n%checkOK%', '<%=Translate.JsTranslate("Feltet �%FieldName%� m� kun indeholde tal i f�lgende interval:")%>\n%minval% - %maxval%'))
					objField.value=""
		} 
	}
}
//-->
</SCRIPT>
					
