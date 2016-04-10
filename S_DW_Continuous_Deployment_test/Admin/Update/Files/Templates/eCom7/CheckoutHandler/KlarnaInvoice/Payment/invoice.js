var KlarnaInvoice = function(){
	this.baseURL = null;
	this.pclassid = null;	
	this.currentTerm = null;
}

KlarnaInvoice.prototype.showTerm = function(pclassid, termId){
	this.pclassid = pclassid;
	this.hideCurrentTerm();
	this.currentTerm = termId;
	this.showCurrentTerm();
}

KlarnaInvoice.prototype.showCurrentTerm = function(){
	if(this.currentTerm){
		var term = document.getElementById(this.currentTerm);
		if(term){
			term.style.display = "block";
		}
	}
}
	
KlarnaInvoice.prototype.hideCurrentTerm = function(){
	if(this.currentTerm){
		var term = document.getElementById(this.currentTerm);
		if(term){
			term.style.display = "none";
		}
	}
}

KlarnaInvoice.prototype.stateCancel = function(){
	document.getElementById("PClassId").value = 0;
	document.getElementById("KlarnaState").value = "Cancel";
	document.getElementById('PaymentForm').submit();
}

KlarnaInvoice.prototype.statePayment = function(){
	if(this.pclassid != null){
		document.getElementById("PClassId").value = this.pclassid;
		document.getElementById("KlarnaState").value = "Payment";
		document.getElementById('PaymentForm').submit();
	}
	else{
		alert("Select a payment method");
	}
}

KlarnaInvoice.prototype.statePaymentDE = function(){
	if(this.pclassid != null){
		if (this.pclassid != '-1' && !document.getElementById("ConsentPrivacyPolicy").checked){
			alert("You should confirm with consent privacy policy");
			return;
		}

		document.getElementById("PClassId").value = this.pclassid;
		document.getElementById("KlarnaState").value = "Payment";
		document.getElementById('PaymentForm').submit();
	}
	else{
		alert("Select a payment method");
	}
}

// Providing Swedish customers functionality to fetch their address(es) that is approved by Klarna
KlarnaInvoice.prototype.GetAddress = function(){
	var pno = document.getElementById("CustomerPNO").value;
	if (!pno){
		alert("Social security number is required.");
		return;
	}	

	new Ajax.Request(this.baseURL, {
		parameters: {
			KlarnaState: "GetAddress",
			CustomerPNO: pno
		},
		onCreate: function () {
			$('loadingDiv').show();
		},
		onSuccess: function (transport) {
			var address = transport.responseJSON;
			if (address.Error){
				alert(address.Error);
				return;
			}
			
			if (document.getElementById('CustomerFirstName')) document.getElementById('CustomerFirstName').value = address.FirstName;
			if (document.getElementById('CustomerLastName')) document.getElementById('CustomerLastName').value = address.LastName;
			if (document.getElementById('CustomerCity')) document.getElementById('CustomerCity').value = address.City;
			if (document.getElementById('CustomerAddress')) document.getElementById('CustomerAddress').value = address.Street;
			if (document.getElementById('CustomerHouseNumber')) document.getElementById('CustomerHouseNumber').value = address.HouseNumber;
			//if (document.getElementById('CustomerHouseExtension')) document.getElementById('CustomerHouseExtension').value = address.HouseExtension;
			if (document.getElementById('CustomerZip')) document.getElementById('CustomerZip').value = address.ZipCode;
			if (document.getElementById('CustomerPhone')) document.getElementById('CustomerPhone').value = address.PhoneNumber;
			if (document.getElementById('CustomerCell')) document.getElementById('CustomerCell').value = address.CellPhoneNumber;
			if (document.getElementById('CustomerEmail')) document.getElementById('CustomerEmail').value = address.Email;
			//if (document.getElementById('CustomerCareOf')) document.getElementById('CustomerCareOf').value = address.CareOf;
		},
		onFailure: function () { alert('Something went wrong...'); },
		onComplete: function () { $('loadingDiv').hide(); }
	});
}