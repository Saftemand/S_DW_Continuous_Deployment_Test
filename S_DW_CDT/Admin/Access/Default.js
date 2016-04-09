function cookieclick(){
	if (document.login.usecookiea.checked){
		document.login.usecookieb.checked = true;
		document.login.AutoLogin.checked = true;
	}else{
		document.login.usecookieb.checked = false;
		document.login.AutoLogin.checked = false;
		document.login.AutoLogin.disabled = true;
	}
	if (document.login.usecookiea.checked && document.login.usecookieb.checked) {
		document.login.AutoLogin.disabled = false;
	}
}

function nescafecheck(){
	if (document.login.usecookiea.checked==false){
		document.login.usecookiea.click();
	}
	if (document.login.usecookiea.checked && document.login.usecookieb.checked){
		document.login.AutoLogin.disabled = false;
	}
	else{
		document.login.AutoLogin.checked = false;
		document.login.AutoLogin.disabled = true;
	}
}

function init() {
    document.getElementById("cookieswarning").hidden = navigator.cookieEnabled;

	if (!document.getElementById("login").usecookiea) {
		return;
	}
	document.login.usecookieb.disabled = false;
	if (document.login.usecookiea.checked){
		//document.login.usecookieb.disabled = false;
	}
	if (document.login.usecookieb.checked){
		document.login.AutoLogin.disabled = false;
	}
}

function changePage() {
	if (self.parent.frames.length != 0){
		self.parent.location=document.location;
	}
}
setTimeout ("changePage()", 10);

function start(){
	if (document.login.Username.value == "") {
	    document.login.Username.focus();
	    document.login.Username.select();
	}else{
	    document.login.Password.focus();
	    document.login.Password.select();
    }
}

function checkInput(FileToHandle){
	var returnVal = true;
	if (document.login.Username.value == "") {
	    alert(SpecifyUsernameText);
	    showWarning(MissingText);
		document.login.Username.focus();
		returnVal = false;
		return;
	}
	if (document.login.Password.value == ""){
	    alert(SpecifyPasswordText);
	    showWarning(MissingText);
		document.login.Password.focus();
		returnVal = false;
		return;
	}
	cookieclick();
	document.login.action = FileToHandle;
	document.getElementById("loginBtn").disabled = true;
	document.getElementById("loginBtn").className = "button logingin";
	document.getElementById("loginBtn").innerText = waitMessage;
	document.getElementById("waitingPlaceholder").style.display = "inline";
	if(navigator.userAgent.indexOf("MSIE", 0)>0){
		var markup = document.getElementById("waitingPlaceholder").innerHTML;
		document.login.submit();
		document.getElementById("waitingPlaceholder").innerHTML = markup;
	}
	else{
		document.login.submit();
	}
}

function showWarning(msg) {
    document.getElementById("warning").style.display = '';
    document.getElementById("warningMsg").innerHTML = msg;
}

function catchThatEnter2(e){
	var evt = (window.event)?window.event:e;
	if (evt.keyCode == 13){
		document.login.Password.focus();
	}
}

function catchThatEnter(e){
	var evt = (window.event)?window.event:e;
	if (evt.keyCode == 13){
		checkInput('Access_User_login.aspx');
	}
}

function SetFormPath(laid){
	var action = 'Default.aspx';
	action += '?la=' + laid
	if(document.getElementById('area')){
		action += '&area=' + document.getElementById('area').value;
	}
	document.login.action = action;
	document.login.submit();
}