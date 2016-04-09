function onSubmitEditing() {
    var txText = document.getElementById('txText');
    var txTextEncoded = document.getElementById('txTextEncoded');
    
    // ignore FCKEditor - it'll take care about HTML encoding
	if(txText && txTextEncoded && !document.getElementById('txText___Config')) {
	    var val = txText.value;
		val = val.replace(/\&/g, '&amp;');
		val = val.replace(/\</g, '&lt;');
		val = val.replace(/\>/g, '&gt;');
		txText.disabled = true;
		txTextEncoded.value = val;
	}
}
