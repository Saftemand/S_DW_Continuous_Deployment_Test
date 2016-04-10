function transferinfo () {
	setinfo(document.getElementById("EcomOrderDeliveryCompany"), document.getElementById("EcomOrderCustomerCompany"));
	setinfo(document.getElementById("EcomOrderDeliveryName"), document.getElementById("EcomOrderCustomerName"));
	setinfo(document.getElementById("EcomOrderDeliveryAddress"), document.getElementById("EcomOrderCustomerAddress"));
	setinfo(document.getElementById("EcomOrderDeliveryAddress2"), document.getElementById("EcomOrderCustomerAddress2"));
	setinfo(document.getElementById("EcomOrderDeliveryZip"), document.getElementById("EcomOrderCustomerZip"));
	setinfo(document.getElementById("EcomOrderDeliveryCity"), document.getElementById("EcomOrderCustomerCity"));
	setinfo(document.getElementById("EcomOrderDeliveryEmail"), document.getElementById("EcomOrderCustomerEmail"));
	setinfo(document.getElementById("EcomOrderDeliveryPhone"), document.getElementById("EcomOrderCustomerPhone"));
	setinfo(document.getElementById("EcomOrderDeliveryFax"), document.getElementById("EcomOrderCustomerFax"));
	setinfo(document.getElementById("EcomOrderDeliveryCell"), document.getElementById("EcomOrderCustomerCell"));
}

function setinfo(delobj, billobj) {
	var delvalue = delobj.value;
	var billvalue = billobj.value;
	
	if (billvalue.length != 0) {
		if (delvalue.length == 0) {
			delobj.value = billvalue;
		}	
	}
}

function AcceptOrder() {
	submit = true;
	
	if (document.terms.acceptTerms.checked != true) {
		alert("You need to accept the terms");
		submit = false;
	} 
	
	if (submit) {
		document.terms.submit();
	}	
}

function setVariant(variantUrl) {
    window.location = variantUrl;
}

function confirmation(urlredirect, question) {
	var answer = confirm(question)
	if (answer){
		window.location = urlredirect;
	}
}

function checkform(){
	if (document.getElementById("usernamelabel").innerHTML != "Username") {
		if((document.getElementById("usernamelabel").innerHTML != "Username") && (document.getElementById("username").value.length <= 0)) {
			alert("Type your email to get your password");
			document.getElementById("username").focus();
			return false;	
		} else {
			document.getElementById("ForgotPassword").value = "True";
			alert("Your password has been sent");
		}
	}
	else {
		if(document.getElementById("username").value.length <= 0){
			alert('Angiv brugernavn');
			document.getElementById("username").focus();
			return false;
		}

		if(document.getElementById("password").value.length <= 0){
			alert('Angiv kodeord');
			document.getElementById("password").focus();
			return false;
		}
	}
	
	return true;
}

function ToggleForgotPassword() {
		document.getElementById("ShowPasswordText").disabled = document.getElementById("ForgotPassword").checked;
		document.getElementById("Password").disabled = document.getElementById("ForgotPassword").checked;

		if (document.getElementById("submitter").value == 'Login') {
			document.getElementById("UsernameText").innerHTML = "Indtast E-mail";
			document.getElementById("submitter").value = "Send kodeord";
		}
		else {
			document.getElementById("UsernameText").innerHTML = "Brugernavn";
			document.getElementById("submitter").value = "Login";
		}
}

function ToggleForgotPassword2() {
		if(document.getElementById("usernamelabel").innerHTML == "Username") {
			document.getElementById("usernamelabel").innerHTML = "Type your email";
			document.getElementById("password").disabled;
			document.getElementById("passwordlabel").style.color = "#ccc";
		} else {
			document.getElementById("usernamelabel").innerHTML = "Username";
			document.getElementById("password").disabled;
			document.getElementById("passwordlabel").style.color = "#000";
		}
}

function searchDelay() {
	setTimeout('searchPreview()',500);
}

function searchPreview() {
	var value = document.getElementById("eComQuery").value;
	if (value.length > 1) 
	{
		$('#resultpreview').load('http://ecommerce-dev.dynamicweb.dk/default.aspx?template=previewresult.html&ID=141&eComQuery=' + value + '&master=no');
		$('#resultpreview').css('display','block');
	} 
	else if(value.length == 0) 
	{
		$('#resultpreview').css('display','none');
	}
}

function checkstock(currentstock, addtocart) {
	if (parseFloat(addtocart) > parseFloat(currentstock)) {
		return confirm('We are out of stock, do you whish to add it anyway ?');
	}
	return true;
}

function emptybasketajax(message) {
	var emptyurl = '/default.aspx?cartcmd=emptycart';
	var confirmation = confirm(message);
	
	if (confirmation) {
		$.ajax({
	  		url: emptyurl,
	  		async: false
	 	});
		
	 	// Removing the cart from the page with jquery
	 	$('.smallcart').remove();
	 	
	 	// Removing the cart from the page by reloading the page
		//window.location.reload();
	};
}