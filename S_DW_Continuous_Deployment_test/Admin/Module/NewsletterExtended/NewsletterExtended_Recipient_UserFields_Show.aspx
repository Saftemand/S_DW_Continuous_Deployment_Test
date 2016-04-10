<%@ Import namespace="Dynamicweb.Backend" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function newsletterExtendedTextFieldCheck(objField, type, fieldname) {
	if(objField.value != '') {
		if(type==1) {
			if(chkNumeric(objField,-9999999999999999999999999999,9999999999999999999999999999,',','','', fieldname, '<%=Translate.JsTranslate("Feltet ´%FieldName%´ må kun indeholde følgende tegn:")%>\n%checkOK%', '<%=Translate.JsTranslate("Feltet ´%FieldName%´ må kun indeholde tal i følgende interval:")%>\n%minval% - %maxval%'))
					objField.value=""
		} else if(type==2) {
			if(chkNumeric(objField,-2147483648,2147483648,'','','', fieldname, '<%=Translate.JsTranslate("Feltet ´%FieldName%´ må kun indeholde følgende tegn:")%>\n%checkOK%', '<%=Translate.JsTranslate("Feltet ´%FieldName%´ må kun indeholde tal i følgende interval:")%>\n%minval% - %maxval%'))
					objField.value=""
		} 
	}
}
//-->
</SCRIPT>
					
