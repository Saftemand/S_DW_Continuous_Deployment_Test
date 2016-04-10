var formValidation = {
	form: null,
	errorMessage: "The value '{0}' in field '{1}' is not valid.",
	validate: function(form) {
		this.form = form;
		var elm = form.elements["__validate"];
		var isValid = true;
		if (elm) {
			if (elm.value) {
				isValid = this.validateExpression(elm.value);
			} else {
				for (var i = 0; i < elm.length; i++) {
					isValid = this.validateExpression(elm[i].value);
					if (!isValid) {
						break;
					}
				}
			}
		}
		return isValid;
	},

	validateExpression: function(validationExpression) {
		var isValid = true;
		var field = validationExpression.split("|")[0];

		var validationMethod = validationExpression.split("|")[1] ? validationExpression.split("|")[1] : "required";
		var validationMethodParameter = "";
		var fieldErrorMessage = validationExpression.split("|")[2] ? validationExpression.split("|")[2] : "";

		if (!this.form.elements[field]) {
			return true;
		}
		if (this.regex(validationMethod, /max\(([0-9]+)\)/)) {
			validationMethodParameter = this.regexValue(validationMethod, /max\(([0-9]+)\)/);
			validationMethod = "max";
		}
		if (this.regex(validationMethod, /min\(([0-9]+)\)/)) {
			validationMethodParameter = this.regexValue(validationMethod, /min\(([0-9]+)\)/);
			validationMethod = "min";
		}

		var fieldValue = this.form.elements[field].value;
		switch (validationMethod) {
			case "email":
				isValid = this.isMail(fieldValue);
				fieldErrorMessage = fieldErrorMessage.length == 0 ? "'{0}' in field '{1}' is not a valid e-mail address." : fieldErrorMessage;
				break;
			case "required":
				isValid = this.required(fieldValue);
				fieldErrorMessage = fieldErrorMessage.length == 0 ? "'{1}' is required." : fieldErrorMessage;
				break;
			case "integer":
				isValid = this.integer(fieldValue);
				fieldErrorMessage = fieldErrorMessage.length == 0 ? "'{1}' must be a valid integer." : fieldErrorMessage;
				break;
			case "max":
				isValid = this.max(fieldValue, validationMethodParameter);
				fieldErrorMessage = fieldErrorMessage.length == 0 ? "Maximum number of characters in '{1}': " + validationMethodParameter : fieldErrorMessage;
				break;
			case "min":
				isValid = this.min(fieldValue, validationMethodParameter);
				fieldErrorMessage = fieldErrorMessage.length == 0 ? "Minimum number of characters in '{1}': " + validationMethodParameter : fieldErrorMessage;
				break;
			default:
				alert("Unknown validation method: '" + validationMethod + "'\n\nUse one of 'email', 'required', 'integer', 'max(length)', 'min(length)'");
				isValid = false;
		}
		if (!isValid) {
			var errMsg = fieldErrorMessage.length > 0 ? fieldErrorMessage : this.errorMessage;
			alert(errMsg.replace(/\{0\}/, fieldValue).replace(/\{1\}/, this.labelText(this.form.elements[field])));
			this.form.elements[field].focus();
		}
		return isValid;
	},

	isMail: function(email) {
		var regExp = /^[\w\-_]+(\.[\w\-_]+)*@[\w\-_]+(\.[\w\-_]+)*\.[a-z]{2,4}$/i;
		return regExp.test(email);
	},

	required: function(value) {
		return value.length > 0;
	},

	integer: function(value) {
		var regExp = /[0-9]/;
		return regExp.test(value);
	},

	regex: function(value, exp) {
		return exp.test(value);
	},

	max: function(value, length) {
		return value.length <= parseInt(length);
	},

	min: function(value, length) {
		return value.length >= parseInt(length);
	},

	regexValue: function(value, exp) {
		var match = exp.exec(value);
		if (match != null && match.length > 1) {
			return match[1];
		} else {
			return "";
		}
	},

	labelText: function(elm) {
		var idVal = elm.id;
		labels = document.getElementsByTagName('label');
		for (var i = 0; i < labels.length; i++) {
			if (labels[i].htmlFor == idVal) {
				return labels[i].innerHTML;
			}
		}
		return elm.name;
	}
}