<%@ Page CodeBehind="NewsletterExtended_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

Dim strNewsletterForgotPasswordLegend = "<input type=""CheckBox"" onclick=""javascript:Change_NewsletterUseForgotPassword(this);"" name=""NewsletterUseForgotPassword"" value=""1"" id=""both"" checked>" & Translate.Translate("Glemt password")
Dim sql As String
Dim Rows As Integer
Dim i As Integer
Dim arrSNewsletters() As String
Dim ParagraphID As Object
Dim tmp As String
Dim NewslettersChecked As New HashTable
Dim NewslettersSubscriptionChecked As New HashTable
Dim strXml As String

If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(request("ParagraphID"))
Else
	ParagraphID = 0
End If

Dim prop As new Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        prop.Value("NewsletterParagraphSNewsletters") = ""
        prop.Value("NewsletterLoginBtnImage") = ""
        prop.Value("NewsletterLoginBtnText") = Translate.Translate("Login")
        prop.Value("NewsletterLoginBtn") = 1
        prop.Value("NewsletterLoginHeading") = Translate.Translate("Login her...")
        prop.Value("NewsletterLoginEmail") = Translate.Translate("Indtast din e-mail her")
        prop.Value("NewsletterLoginPassword") = Translate.Translate("Indtast dit kodeord her")
        prop.Value("NewsletterForgotPasswordEmail") = ""
        prop.Value("NewsletterForgotPasswordDescription") = Translate.Translate("Hvis du har glemt dit kodeord bliver det sendt til dig ved at udfylde nedenstående formular")
        prop.Value("NewsletterForgotPasswordHeading") = Translate.Translate("Glemt kodeord?")
        prop.Value("NewsletterUseForgotPassword") = "0"
        prop.Value("NewsletterLoginTemplate") = "NewsletterLogin2x10.html"
        prop.Value("NewsletterForgotPasswordMailTemplate") = "NewsletterForgotPassword2x3.html"
        prop.Value("NewsletterForgotPasswordMailDescription") = Translate.Translate("Du modtager hermed dit rekvirerede kodeord.")
        prop.Value("NewsletterForgotPasswordBtnImage") = ""
        prop.Value("NewsletterForgotPasswordBtnText") = Translate.Translate("Send")
        prop.Value("NewsletterForgotPasswordBtn") = 1
        prop.Value("NewsletterForgotPasswordConfirm") = Translate.Translate("Dit kodeord er blevet sendt til din e-mail adresse.")
        prop.Value("NewsletterparagraphType") = 1
        prop.Value("NewsletterUsePassword") = 0
        prop.Value("NewsletterUserRegistrationReceipt") = 0
        prop.Value("NewsletterCancelPasswordFieldText") = Translate.Translate("Indtast dit kodeord her")
        prop.Value("NewsletterCancelEmailFieldText") = Translate.Translate("Indtast din e-mail her")
        prop.Value("NewsletterCancelBtnImage") = "..."
        prop.Value("NewsletterCancelBtn") = 1
        prop.Value("NewsletterCancelBtnText") = Translate.Translate("Afmeld")
        prop.Value("NewsletterCancelNeedConfirm") = False
        prop.Value("NewsletterCancelNeedConfirmTemplate") = "NewsletterCancellationConfirmTemplate.html"
        prop.Value("NewsletterCancelMailSender") = ""
        prop.Value("NewsletterCancelMailText") = Translate.Translate("Det bekræftes hermed at du er afmeldt følgende nyhedsbrevslister:")
        prop.Value("NewsletterCancelMAilSubject") = Translate.Translate("Ang. afmelding")
        prop.Value("NewsletterCancelNeedConfirmAction") = 0
        prop.Value("NewsletterUserCancelReceiptLink") = ""
        prop.Value("NewsletterUserRegistrationReceiptLink") = ""
        prop.Value("NewsletterReceiptNeedConfirmAction") = False
        prop.Value("NewsletterReceiptMailSubject") = Translate.Translate("Ang. tilmelding")
        prop.Value("NewsletterReceiptMailSender") = ""
        prop.Value("NewsletterReceiptNeedConfirmTemplate") = "NewsletterSubscriptionConfirmTemplate.html"
        prop.Value("NewsletterReceiptNeedConfirmLink") = ""
        prop.Value("NewsletterReceiptMailText") = Translate.Translate("Det bekræftes hermed at du er tilmeldt følgende nyhedsbrevslister:")
        prop.Value("NewsletterShowNewsletterCategories") = False
        prop.Value("NewsletterReceiptTemplate") = "NewsletterReceiptDefault.html"
        prop.Value("NewsletterReceiptFormatFieldText") = Translate.Translate("E-mail format")
        prop.Value("NewsletterReceiptFormat") = 0
        prop.Value("NewsletterReceiptEmailFieldText") = Translate.Translate("E-mail")
        prop.Value("NewsletterReceiptBtn") = 1
        prop.Value("NewsletterReceiptConfirmPasswordFieldText") = Translate.Translate("Gentag kodeord")
        prop.Value("NewsletterReceiptPasswordFieldText") = Translate.Translate("Kodeord")
        prop.Value("NewsletterReceiptNameFieldText") = Translate.Translate("Navn")
        prop.Value("NewsletterReceiptBtnImage") = ""
        prop.Value("NewsletterReceiptBtnText") = Translate.Translate("OK")
        prop.Value("NewsletterUserCancelReceipt") = 0
        prop.Value("NewsletterSubscriptionTemplate") = "NewsletterReceiptDefault.html"
        prop.Value("NewsletterSubscriptionFormatFieldText") = Translate.Translate("E-mail format")
        prop.Value("NewsletterSubscriptionFormat") = 0
        prop.Value("NewsletterSubscriptionEmailFieldText") = Translate.Translate("Email adresse")
        prop.Value("NewsletterSubscriptionConfirmPasswordFieldText") = Translate.Translate("Gentag kodeord")
        prop.Value("NewsletterSubscriptionPasswordFieldText") = Translate.Translate("Kodeord")
        prop.Value("NewsletterSubscriptionNameFieldText") = Translate.Translate("Navn")
        prop.Value("NewsletterSubscriptionBtnImage") = ""
        prop.Value("NewsletterSubscriptionBtnText") = Translate.Translate("Gem")
        prop.Value("NewsletterSubscriptionBtn") = 1
        prop.Value("NewsletterSubscriptionNeedConfirmLink") = ""
        prop.Value("NewsletterSubscriptionNeedConfirmTemplate") = "NewsletterSubscriptionConfirmTemplate.html"
        prop.Value("NewsletterSubscriptionMailSender") = ""
        prop.Value("NewsletterSubscriptionMailText") = Translate.Translate("Hermed bekræftes din abonnementsændring.")
        prop.Value("NewsletterSubscriptionMailSubject") = Translate.Translate("Ang. abonnementsændring")
        prop.Value("NewsletterSubscriptionNeedConfirmAction") = False
        prop.Value("NewsletterUserSubscriptionReceiptLink") = ""
        prop.Value("NewsletterUserSubscriptionReceipt") = 0
        prop.Value("NewsletterReceiptNeedConfirmLinkText") = Translate.Translate("Klik på følgende link for at bekræfte registreringen:")
        prop.Value("NewsletterCancellationTemplate") = "NewsletterCancellationDefault.html"
        prop.Value("NewsletterForgotPasswordEmailSubject") = Translate.Translate("Ang. glemt adgangskode")
        prop.Value("NewsletterForgotPasswordEmailFieldText") = Translate.Translate("E-mail")
        prop.Value("NewsletterSubscriptionNeedConfirmLinkText") = Translate.Translate("Klik på følgende link for at bekræfte abonnementsændringen:")
        prop.Value("NewsletterCancelNeedConfirmLinkText") = Translate.Translate("Klik på følgende link for at bekræfte afmeldelsen:")
        prop.Value("NewsletterCancelNeedConfirmLink") = ""
        prop.Value("NewsletterReceiptFormatFieldRadio") = "2"
        prop.Value("NewsletterRegistrationNotification") = "0"
        prop.Value("NewsletterEmailNotification") = ""
        prop.Value("NewsletterCancelNotification") = "0"
        prop.Value("NewsletterChangeNotification") = "0"
        prop.Value("NewsletterUseNotification") = "0"
        prop.Value("NewsletterUseUserFields") = 0
        prop.Value("NewsletterPasswordRepeatPasswordError") = Translate.Translate("Adgangskoden er gentaget forkert!")
        prop.Value("NewsletterFiloutPasswordError") = Translate.Translate("Feltet %% skal udfyldes!", "%%", Translate.Translate("Adgangskode"))
        prop.Value("NewsletterFiloutNameError") = Translate.Translate("Feltet %% skal udfyldes!", "%%", Translate.Translate("Navn"))
        prop.Value("NewsletterSelectKategoryError") = Translate.Translate("Der skal vælges en liste!")
        prop.Value("NewsletterNoSelectedKategoryError") = Translate.Translate("Ingen liste valgt, fortsæt?")
        prop.Value("NewsletterFiloutEmailError") = Translate.Translate("Feltet %% skal udfyldes!", "%%", Translate.Translate("E-mail"))
        prop.Value("NewsletterUseCustomErrors") = "0"
        prop.Value("NewsletterInvalidEmailError") = Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Email adresse"))
        prop.Value("NewsletterHTMLError") = Translate.Translate("HTML")
        prop.Value("NewsletterTextError") = Translate.Translate("Tekst")
        prop.Value("NewsletterEncodingUsed") = "iso-8859-1"
        prop.Value("NewsletterReceiptCategoriesText") = Translate.Translate("Kategorier")
        prop.Value("NewsletterSubscriptionCategoriesText") = Translate.Translate("Abonnementsmuligheder")
    End If

If prop.Value("NewsletterParagraphSNewsletters") <> "" Then
	arrSNewsletters = Split(prop.Value("NewsletterParagraphSNewsletters"), ",")
	For i = 0 To UBound(arrSNewsletters)
		NewslettersChecked.Add(Trim(arrSNewsletters(i)), "True")
	Next 
End If

If prop.Value("NewsletterSubscriptionNewsletters") <> "" Then
	arrSNewsletters = Split(prop.Value("NewsletterSubscriptionNewsletters"), ",")
	For i = 0 To UBound(arrSNewsletters)
		NewslettersSubscriptionChecked.Add(Trim(arrSNewsletters(i)), "True")
	Next 
End If
%>

<input type="hidden" name="NewsletterExtended_settings" value="NewsletterParagraphSUserFields, NewsletterUseUserFields, NewsletterUseNotification, NewsletterRegistrationNotification, NewsletterCancelNotification, NewsletterEmailNotification, NewsletterChangeNotification, NewsletterReceiptFormatFieldRadio, NewsletterCancelNeedConfirmLinkText, NewsletterCancelNeedConfirmLink, NewsletterSubscriptionNeedConfirmLinkText, NewsletterForgotPasswordEmailFieldText, NewsletterForgotPasswordEmailSubject, NewsletterCancellationTemplate, NewsletterReceiptNeedConfirmLinkText, NewsletterSubscriptionTemplate, NewsletterSubscriptionFormatFieldText, NewsletterSubscriptionFormat, NewsletterSubscriptionEmailFieldText, NewsletterSubscriptionCategoriesText, NewsletterSubscriptionConfirmPasswordFieldText, NewsletterSubscriptionPasswordFieldText, NewsletterSubscriptionNameFieldText, NewsletterSubscriptionBtnImage, NewsletterSubscriptionBtnText, NewsletterSubscriptionBtn, NewsletterSubscriptionNewsletters, NewsletterSubscriptionNeedConfirmLink, NewsletterSubscriptionNeedConfirmTemplate, NewsletterSubscriptionMailSender, NewsletterSubscriptionMailText, NewsletterSubscriptionMailSubject, NewsletterSubscriptionNeedConfirmAction, NewsletterUserSubscriptionReceiptLink, NewsletterUserSubscriptionReceipt, NewsletterUserCancelReceipt, NewsletterReceiptTemplate, NewsletterReceiptFormatFieldText, NewsletterReceiptFormat, NewsletterReceiptEmailFieldText, NewsletterReceiptCategoriesText, NewsletterReceiptBtn, NewsletterReceiptConfirmPasswordFieldText, NewsletterReceiptPasswordFieldText, NewsletterReceiptNameFieldText, NewsletterReceiptBtnImage, NewsletterReceiptBtnText, NewsletterParagraphSNewsletters, NewsletterLoginBtnImage, NewsletterLoginBtnText, NewsletterLoginBtn, NewsletterLoginHeading, NewsletterLoginEmail, NewsletterLoginPassword, NewsletterForgotPasswordEmail, NewsletterForgotPasswordDescription, NewsletterForgotPasswordHeading, NewsletterUseForgotPassword, NewsletterLoginTemplate, NewsletterForgotPasswordMailTemplate, NewsletterForgotPasswordMailDescription, NewsletterForgotPasswordBtnImage, NewsletterForgotPasswordBtnText, NewsletterForgotPasswordBtn, NewsletterForgotPasswordConfirm, NewsletterparagraphType, NewsletterUsePassword, NewsletterUserRegistrationReceipt, NewsletterCancelPasswordFieldText, NewsletterCancelEmailFieldText, NewsletterCancelBtnImage, NewsletterCancelBtn, NewsletterCancelBtnText, NewsletterCancelNeedConfirm, NewsletterCancelNeedConfirmTemplate, NewsletterCancelMailSender, NewsletterCancelMailText, NewsletterCancelMAilSubject, NewsletterCancelNeedConfirmAction, NewsletterUserCancelReceiptLink, NewsletterUserRegistrationReceiptLink, NewsletterReceiptNeedConfirmAction, NewsletterReceiptMailSubject, NewsletterReceiptMailSender, NewsletterReceiptNeedConfirmTemplate, NewsletterReceiptNeedConfirmLink, NewsletterReceiptMailText, NewsletterShowNewsletterCategories, NewsletterPasswordRepeatPasswordError, NewsletterFiloutNameError, NewsletterFiloutPasswordError, NewsletterSelectKategoryError, NewsletterFiloutEmailError, NewsletterUseCustomErrors, NewsletterInvalidEmailError, NewsletterNoSelectedKategoryError, NewsletterHTMLError, NewsletterTextError, NewsletterEncodingUsed, NewsletterSubscriptionDoConfirm">
<script language="Javascript">
function toggleType(){
	if (document.getElementById("subscribe").checked){
		document.getElementById("SubscriptionGroup").style.display = "";
		document.getElementById("UnsubscriptionGroup").style.display = "none";
	}else if (document.getElementById("unsubscribe").checked){
		document.getElementById("UnsubscriptionGroup").style.display = "";
		document.getElementById("SubscriptionGroup").style.display = "none";
	}else{
		document.getElementById("UnsubscriptionGroup").style.display = "";
		document.getElementById("SubscriptionGroup").style.display = "";
	}
}

function toggleSConfirmMailText(){
	if (document.getElementById("NeedConf1").checked){
		document.getElementById("SConfirmTexts").style.display="";
	}else{
		document.getElementById("SConfirmTexts").style.display="none";
	}
}

function toggleUSConfirmMailText(){
	if (document.getElementById("NeedUConf1").checked){
		document.getElementById("USConfirmTexts").style.display="";
	}else{
		document.getElementById("USConfirmTexts").style.display="none";
	}
}

function toggleSSubmitBtn(){
	if (document.getElementById("SBtn1").checked){
		document.getElementById("SShowBtn1").style.display = "";
		document.getElementById("SShowBtn2").style.display = "none";
	}else{
		document.getElementById("SShowBtn1").style.display = "none";
		document.getElementById("SShowBtn2").style.display = "";
	}
}

function toggleSubSubmitBtn(){
	if (document.getElementById("SubBtn1").checked){
		document.getElementById("SubShowBtn1").style.display = "";
		document.getElementById("SubShowBtn2").style.display = "none";
	}else{
		document.getElementById("SubShowBtn1").style.display = "none";
		document.getElementById("SubShowBtn2").style.display = "";
	}
}

function toggleUSSubmitBtn(){
	if (document.getElementById("USBtn1").checked){
		document.getElementById("USShowBtn1").style.display = "";
		document.getElementById("USShowBtn2").style.display = "none";
	}else{
		document.getElementById("USShowBtn1").style.display = "none";
		document.getElementById("USShowBtn2").style.display = "";
	}
}

function select(mode){
	if(document.paragraph_edit.NewsletterParagraphSNewsletters.length){
		for (i = 0; i < document.paragraph_edit.NewsletterParagraphSNewsletters.length;i++){
			document.paragraph_edit.NewsletterParagraphSNewsletters[i].checked = mode;
		}
	}else{
		document.paragraph_edit.NewsletterParagraphSNewsletters.checked = mode;
	}
}

function selectFields(mode){
	if(document.paragraph_edit.NewsletterParagraphSUserFields.length){
		for (i = 0; i < document.paragraph_edit.NewsletterParagraphSUserFields.length;i++){
			document.paragraph_edit.NewsletterParagraphSUserFields[i].checked = mode;
		}
	}else{
		document.paragraph_edit.NewsletterParagraphSUserFields.checked = mode;
	}
}

function selectSub(mode){
	if(document.paragraph_edit.NewsletterSubscriptionNewsletters.length){
		for (i = 0; i < document.paragraph_edit.NewsletterSubscriptionNewsletters.length;i++){
			document.paragraph_edit.NewsletterSubscriptionNewsletters[i].checked = mode;
		}
	}else{
		document.paragraph_edit.NewsletterSubscriptionNewsletters.checked = mode;
	}
}

function toggleLoginBtn(varBtn)
{
	if (varBtn == 1){
		document.getElementById("ShowLoginBtn1").style.display = "";
		document.getElementById("ShowLoginBtn2").style.display = "none";
	}else{
		document.getElementById("ShowLoginBtn1").style.display = "none";
		document.getElementById("ShowLoginBtn2").style.display = "";
	}
}

function Change_NewsletterUseForgotPassword(obj) {
	if(obj.checked) {
		document.getElementById("tbl_NewsletterUseForgotPassword").style.display = "";
	} else {
		document.getElementById("tbl_NewsletterUseForgotPassword").style.display = "none";
	}	
}


function ChangeUseNotification(obj) {
	if(obj.checked)	{
		document.getElementById("Div_NewsletterNotification").style.display = "";
	} else {
		document.getElementById("Div_NewsletterNotification").style.display = "none";
	}	
}

function ChangeUseUserFields(obj) {
	if(obj.checked)	{
		document.getElementById("Div_NewsletterUserFields").style.display = "";
	} else {
		document.getElementById("Div_NewsletterUserFields").style.display = "none";
	}	
}

function ChangeUseCustomErrors(obj) {
	if(obj.checked)	{
		document.getElementById("Div_NewsletterUseCustomErrors").style.display = "";
	} else {
		document.getElementById("Div_NewsletterUseCustomErrors").style.display = "none";
	}	
}

function ChangeUsePassword(obj) {
	if(obj.checked)	{
		document.getElementById("div_NewsletterUsePassword").style.display = "";
	} else {
		document.getElementById("div_NewsletterUsePassword").style.display = "none";
	}	
}


function Change_NewsletterSubscriptionFormat(obj) {
	if(obj.checked) {
		document.getElementById("tr_NewsletterSubscriptionFormatFieldText").style.display = "";
	} else {
		document.getElementById("tr_NewsletterSubscriptionFormatFieldText").style.display = "none";
	}	
}

function Change_NewsletterReceiptFormat(obj) {
	if(obj.checked) {
		document.getElementById("tr_NewsletterReceiptFormatFieldText1").style.display = "None";
		document.getElementById("tr_NewsletterReceiptFormatFieldText").style.display = "";
	} else {
		document.getElementById("tr_NewsletterReceiptFormatFieldText1").style.display = "";
		document.getElementById("tr_NewsletterReceiptFormatFieldText").style.display = "none";
	}	
}

function Change_NewsletterUserCancelReceipt(obj) {
	if(obj.checked) {
		document.getElementById("Tr_NewsletterUserCancelReceiptLink").style.display = "";
	} else {
		document.getElementById("Tr_NewsletterUserCancelReceiptLink").style.display = "none";
	}	
}

function Change_NewsletterUserSubscriptionReceipt(obj) {
	if(obj.checked) {
		document.getElementById("Tr_NewsletterUserSubscriptionReceiptLink").style.display = "";
	} else {
		document.getElementById("Tr_NewsletterUserSubscriptionReceiptLink").style.display = "none";
	}	
}

function Change_NewsletterUserRegistrationReceipt(obj) {
	if(obj.checked) {
		document.getElementById("Tr_NewsletterUserRegistrationReceiptLink").style.display = "";
	} else {
		document.getElementById("Tr_NewsletterUserRegistrationReceiptLink").style.display = "none";
	}	
}

function ChangeNewsletterCancelNeedConfirm(obj) {
	if(obj.value == "true") {
		document.getElementById("Tr_NewsletterCancelNeedConfirm").style.display = "";
	} else {
		document.getElementById("Tr_NewsletterCancelNeedConfirm").style.display = "none";
	}	
}

function Change_NewsletterSubscriptionConfirmMailText(obj) {
	if(obj.value == "true") {
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText1").style.display = "";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText2").style.display = "";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText3").style.display = "";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText4").style.display = "";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText5").style.display = "";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText6").style.display = "";
	} else {
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText1").style.display = "none";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText2").style.display = "none";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText3").style.display = "none";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText4").style.display = "none";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText5").style.display = "none";
		document.getElementById("Tr_NewsletterSubscriptionConfirmMailText6").style.display = "none";
	}	
}

function Change_NewsletterReceiveConfirmMailText(obj) {
	if(obj.value == "true") {
		document.getElementById("Tr_NewsletterReceiveConfirmMailText1").style.display = "";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText2").style.display = "";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText3").style.display = "";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText4").style.display = "";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText5").style.display = "";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText6").style.display = "";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText7").style.display = "";
	} else {
		document.getElementById("Tr_NewsletterReceiveConfirmMailText1").style.display = "none";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText2").style.display = "none";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText3").style.display = "none";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText4").style.display = "none";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText5").style.display = "none";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText6").style.display = "none";
		document.getElementById("Tr_NewsletterReceiveConfirmMailText7").style.display = "none";
	}	
}

function Change_NewsletterparagraphType(ID) {
	if(ID =="1") {
		document.getElementById("Div_NewsletterparagraphTypeRegistration").style.display = "";
		document.getElementById("div_Subscription").style.display = "none";
		document.getElementById("Div_NewsletterparagraphTypeCancellation").style.display = "none";
		document.getElementById("div_Login").style.display = "none";
		document.getElementById("TR_NotificationReg").style.display = "";
		document.getElementById("TR_NotificationCan").style.display = "None";
		document.getElementById("TR_NotificationSub").style.display = "None";
	} else if (ID == "2") {
		document.getElementById("Div_NewsletterparagraphTypeRegistration").style.display = "none";
		document.getElementById("div_Subscription").style.display = "none";
		document.getElementById("Div_NewsletterparagraphTypeCancellation").style.display = "";
		document.getElementById("div_Login").style.display = "none";
		document.getElementById("TR_NotificationReg").style.display = "None";
		document.getElementById("TR_NotificationCan").style.display = "";
		document.getElementById("TR_NotificationSub").style.display = "None";
	} else if (ID == "3") {
		document.getElementById("div_Login").style.display = "";
		document.getElementById("Div_NewsletterparagraphTypeRegistration").style.display = "none";
		document.getElementById("div_Subscription").style.display = "";
		document.getElementById("Div_NewsletterparagraphTypeCancellation").style.display = "none";
		document.getElementById("TR_NotificationReg").style.display = "None";
		document.getElementById("TR_NotificationCan").style.display = "None";
		document.getElementById("TR_NotificationSub").style.display = "";
	}
}

function toggleForgotPasswordBtn(varBtn) {
	if (varBtn == 1) {
		document.getElementById("ShowForgotPasswordBtn1").style.display = "";
		document.getElementById("ShowForgotPasswordBtn2").style.display = "none";
	} else {
		document.getElementById("ShowForgotPasswordBtn1").style.display = "none";
		document.getElementById("ShowForgotPasswordBtn2").style.display = "";
	}
}

function validateEmail(objEmail) {
	var strMail = objEmail.value.replace(" ","");
	var re = new RegExp(/^[\w-\.]{1,}\@([\w-]{1,}\.){1,}[\w]{2,3}$/);
	var s = re.test(strMail);
	if(s==false)
		alert('<%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Email adresse"))%>');
}

</script>
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("newsletterextended", "Udvidet Nyhedsbreve")%>
	</TD>
</TR>
<tr>
	<td>	
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Vis")%></td>
				<td><input type="Radio" onclick="javascript:Change_NewsletterparagraphType(1);" name="NewsletterparagraphType" value="1" <%If prop.Value("NewsletterparagraphType") = "1" Then
																																			 Response.Write("Checked") 
																																		   End If %>></td>
				<td><label><%=Translate.Translate("Tilmelding")%></label></td>
				<td><input type="Radio" onclick="javascript:Change_NewsletterparagraphType(2);" name="NewsletterparagraphType" value="2" <%If prop.Value("NewsletterparagraphType") = "2" Then
																																			 Response.Write("Checked") 
																																		   End If %>></td>
				<td><label><%=Translate.Translate("Afmelding")%></label></td>
				<td><input type="Radio" onclick="javascript:Change_NewsletterparagraphType(3);" name="NewsletterparagraphType" value="3" <%If prop.Value("NewsletterparagraphType") = "3" Then
																																				Response.Write("Checked") 
																																		   End If %>></td>
				<td><label><%=Translate.Translate("Abonnementsændring")%></label></td>
			</tr>
			<tr>
				<td width="170"></td>
				<td><input type="checkbox" onclick="Javascript:ChangeUsePassword(this);" name="NewsletterUsePassword" value="1" <%
																																If prop.Value("NewsletterUsePassword") = "1" Then 
																																	Response.Write("Checked") 
																																End If%>></td>
				<td colspan="5"><label><%=Translate.Translate("Brug password")%></label></td>
			</tr>
			<tr>
				<td width="170"></td>
				<td><input type="checkbox" onclick="Javascript:ChangeUseNotification(this);" name="NewsletterUseNotification" value="1" <%If prop.Value("NewsletterUseNotification") = "1" Then
																																				 Response.Write("Checked") 
																																		  End If%>></td>
				<td colspan="5"><label><%=Translate.Translate("Brug Admin. Notificering")%></label></td>
			</tr>
			<tr>
				<td width="170"></td>
				<td><input type="CheckBox" onclick="Javascript:ChangeUseUserFields(this);" name="NewsletterUseUserFields" value="1" <%If prop.Value("NewsletterUseUserFields") = "1" Then
																																		 Response.Write("Checked") 
																																	  End If %>></td>
				<td colspan="5"><label><%=Translate.Translate("Brugerdefinerede felter")%></label></td>
			</tr>
			<tr>
				<td width="170"></td>
				<td><input type="CheckBox" onclick="Javascript:ChangeUseCustomErrors(this);" name="NewsletterUseCustomErrors" value="1" <%If prop.Value("NewsletterUseCustomErrors") = "1" Then 
																																				Response.Write("Checked")
																																		  End If%>></td>
				<td colspan="5"><label><%=Translate.Translate("Brugerdefinerede fejlbeskeder")%></label></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Encoding")%></td>
				<td colspan="6"><%=Gui.EncodingList(prop.Value("NewsletterEncodingUsed"), "NewsletterEncodingUsed", True)%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>

		<!--||||||||||||||||||||||||| SUBSCRIPTION ||||||||||||||||||||||||| -->
		<div ID="div_Subscription" style="<%If prop.Value("NewsletterparagraphType") <> "3" Then 
											    Response.Write("display:none;")
											End If %>">
		<%=Gui.GroupBoxStart(Translate.Translate("Abonnementsændring"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"></td>
				<td><input type="checkBox" onclick="javascript:Change_NewsletterUserSubscriptionReceipt(this);" name="NewsletterUserSubscriptionReceipt" value="1" id="both" <% If prop.Value("NewsletterUserSubscriptionReceipt") = "1" Then
																																												Response.Write("Checked") 
																																												End If%>><%=Translate.Translate("Brug Kvittering")%></td>
			</tr>
			<tr ID="Tr_NewsletterUserSubscriptionReceiptLink" <%If prop.Value("NewsletterUserSubscriptionReceipt") = "0" Or prop.Value("NewsletterUserSubscriptionReceipt") = "" Then
																Response.Write("style='display:none'") 
																End If %>>
				<td valign="top"><%=Translate.Translate("Kvittering link")%></td>
				<td><%=Gui.LinkManager(prop.Value("NewsletterUserSubscriptionReceiptLink"), "NewsletterUserSubscriptionReceiptLink", "")%></td>
			</tr>
			<tr valign="top">
				<td width="170"><%=Translate.Translate("Bekræft abonnement ændring")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterSubscriptionNeedConfirmAction" value="true"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionNeedConfirmAction")) = True Then%> checked<%End If%> onclick="Change_NewsletterSubscriptionConfirmMailText(this);"></td>
							<td><label"><%=Translate.Translate("Ja")%></label></td>
							<td><input type="radio" name="NewsletterSubscriptionNeedConfirmAction" value="false"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionNeedConfirmAction")) = False Then%> checked<%End If%> onclick="Change_NewsletterSubscriptionConfirmMailText(this);"></td>
							<td><label><%=Translate.Translate("Nej")%></label></td>
						</tr>
					</table>
				</td>
			</tr>

			
			<tr ID="Tr_NewsletterSubscriptionConfirmMailText1"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td width="170"><%=Translate.Translate("E-mail emne")%></td>
				<td><input type="text" name="NewsletterSubscriptionMailSubject" class="std" value="<%=prop.Value("NewsletterSubscriptionMailSubject")%>"></td>
			</tr>
			<tr ID="Tr_NewsletterSubscriptionConfirmMailText2"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td valign="top"><%=Translate.Translate("E-mail tekst")%></td>
				<td><textarea name="NewsletterSubscriptionMailText" rows="4" class="std"><%=prop.Value("NewsletterSubscriptionMailText")%></textarea></td>
			</tr>
			<tr ID="Tr_NewsletterSubscriptionConfirmMailText3"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td><%=Translate.Translate("Afsenderadresse")%></td>
				<td><input type="text" onchange="validateEmail(this);" name="NewsletterSubscriptionMailSender" value="<%=prop.Value("NewsletterSubscriptionMailSender")%>" class="std"></td>
			</tr>
			<tr ID="Tr_NewsletterSubscriptionConfirmMailText4"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td><%=Translate.Translate("Mail template")%></td>
				<TD valign="top"><%=Gui.FileManager(prop.Value("NewsletterSubscriptionNeedConfirmTemplate"), "Templates/Newsletters", "NewsletterSubscriptionNeedConfirmTemplate")%></TD>
			</tr>
			<tr ID="Tr_NewsletterSubscriptionConfirmMailText5"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td><%=Translate.Translate("Link tekst")%></td>
				<td><input type="text" name="NewsletterSubscriptionNeedConfirmLinkText" value="<%=prop.Value("NewsletterSubscriptionNeedConfirmLinkText")%>" class="std"></td>
			</tr>
			<tr ID="Tr_NewsletterSubscriptionConfirmMailText6"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td valign="top"><%=Translate.Translate("Link til beskræftigelses side")%></td>
				<td><%=Gui.LinkManager(prop.Value("NewsletterSubscriptionNeedConfirmLink"), "NewsletterSubscriptionNeedConfirmLink", "")%></td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Abonnementsmuligheder")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="1">
						<tr>
							<td><img src='/Admin/Images/CheckAll.gif' alt='<%=Translate.Translate("Vælg alle")%>' onclick='Javascript:selectSub(1);'>&nbsp;<img src='/Admin/Images/CheckNone.gif' alt='<%=Translate.Translate("Fravælg alle")%>' onclick='Javascript:selectSub(0);'></a></td>
						</tr>
						<%

		Dim cn		As IDbConnection	= Database.CreateConnection("NewsletterExtended.mdb")
		Dim cmd		As IDbCommand		= cn.CreateCommand
						    cmd.CommandText = "SELECT * FROM NewsletterExtendedCategory ORDER BY NewsletterCategoryName ASC"
		Dim dr		As IDataReader		= cmd.ExecuteReader()

		Rows = 0
		Do While dr.Read()
			With Response
				.Write("<tr><td nowrap><input type=""CheckBox"" name=""NewsletterSubscriptionNewsletters"" id=""news" & dr("NewsletterCategoryID").ToString & """ value=""" & dr("NewsletterCategoryID").ToString & """")
					If NewslettersSubscriptionChecked.Item(dr("NewsletterCategoryID").ToString) = "True" then
						.Write(" Checked ")
					End If
				.Write("><label for=""news" & dr("NewsletterCategoryID").ToString & """>" & dr("NewsletterCategoryName").ToString & "</label></td></tr>" & vbCrLf & vbCrLf)

			End With
		Loop 

		dr.Close()
		%>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3"><strong><%=Translate.Translate("Brugerdefinerede tekster")%></strong></td>
			</tr>
			<tr valign='top'>
				<td>
					<%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Abonner") & "</em>" )%>
				</td>
				<td>
					<!-- Text/Image Selector - Start -->
					<table border='0' cellspacing='0' style='padding: 0px 4px 4px 0px'>
						<tr>
							<td><input type="radio" name="NewsletterSubscriptionBtn" id="SubBtn1" value="1" onclick="toggleSubSubmitBtn();"<%If prop.Value("NewsletterSubscriptionBtn") = "1" Or prop.Value("NewsletterSubscriptionBtn") = "" Then%> checked<%End If%>></td>
							<td nowrap><label for="SubBtn1"><%=Translate.Translate("Tekst")%></label></td>
							<td id="SubShowBtn1" <%=IIF((prop.Value("NewsletterSubscriptionBtn") = "1") Or (prop.Value("NewsletterSubscriptionBtn") = ""), "", "style='display: none'")%>><input type="text" name="NewsletterSubscriptionBtnText" value="<%=prop.Value("NewsletterSubscriptionBtnText")%>" class="std"></td>
			</tr>
			<tr>
							<td><input type="radio" name="NewsletterSubscriptionBtn" id="SubBtn2" value="2" onclick="toggleSubSubmitBtn();"<%If prop.Value("NewsletterSubscriptionBtn") = "2" Then%> checked<%End If%>></td>
							<td nowrap><label for="SubBtn2"><%=Translate.Translate("Billede")%></label></td>
							<td id="SubShowBtn2" style="display: <%If prop.Value("NewsletterSubscriptionBtn") <> "2" Then%> None<%End If%>"><%= Gui.FileManager(prop.Value("NewsletterSubscriptionBtnImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsletterSubscriptionBtnImage")%></td>
							</tr>
						</table>
					<!-- Text/Image Selector - End -->

				</td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Navnefelt")%></td>
				<td><input type="text" name="NewsletterSubscriptionNameFieldText" value="<%=prop.Value("NewsletterSubscriptionNameFieldText")%>" class="std"></td>
			</tr>
			<tr ID="tr_NewsletterSubscriptionPasswordFieldText" <%If prop.Value("NewsletterUsePassword") = "0" Or prop.Value("NewsletterUsePassword") = "" Then 
																		Response.Write("style='display:none'") 
																End If %>>
				<td><%=Translate.Translate("Passwordfelt")%></td>
				<td><input type="text" name="NewsletterSubscriptionPasswordFieldText" value="<%=prop.Value("NewsletterSubscriptionPasswordFieldText")%>" class="std"></td>
			</tr>
			<tr ID="tr_NewsletterSubscriptionConfirmPasswordFieldText" <%If prop.Value("NewsletterUsePassword") = "0" Or prop.Value("NewsletterUsePassword") = "" Then 
																				Response.Write("style='display: none'") 
																		End If%>>
				<td><%=Translate.Translate("Gentag-Passwordfelt")%></td>
				<td><input type="text" name="NewsletterSubscriptionConfirmPasswordFieldText" value="<%=prop.Value("NewsletterSubscriptionConfirmPasswordFieldText")%>" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("E-mailfelt")%></td>
				<td><input type="text" name="NewsletterSubscriptionEmailFieldText" value="<%=prop.Value("NewsletterSubscriptionEmailFieldText")%>" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Abonnementsmuligheder")%></td>
				<td><input type="text" name="NewsletterSubscriptionCategoriesText" value="<%=prop.Value("NewsletterSubscriptionCategoriesText")%>" class="std"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="CheckBox" onclick="javascript:Change_NewsletterSubscriptionFormat(this);" name="NewsletterSubscriptionFormat" value="1" id="both" <%If prop.Value("NewsletterSubscriptionFormat") = "1" Then%> checked<%End If%>><%=Translate.Translate("Kan Bruger ændre format")%></td>
			</tr>
			<tr ID="tr_NewsletterSubscriptionFormatFieldText" <%If prop.Value("NewsletterSubscriptionFormat") = "0" Or prop.Value("NewsletterSubscriptionFormat") = "" Then 
																	Response.Write("style='display:none'")
																End If %>>
				<td><%=Translate.Translate("Mailformatfelt")%></td>
				<td><input type="text" name="NewsletterSubscriptionFormatFieldText" value="<%=prop.Value("NewsletterSubscriptionFormatFieldText")%>" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Abonnement template")%></td>
				<TD valign="top"><%=Gui.FileManager(prop.Value("NewsletterSubscriptionTemplate"), "Templates/Newsletters", "NewsletterSubscriptionTemplate")%></TD>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<!--END|||||||||||||||||||||| SUBSCRIPTION ||||||||||||||||||||||END -->



		<!--||||||||||||||||||||||||| REGISTRATION ||||||||||||||||||||||||| -->
		<div  ID="Div_NewsletterparagraphTypeRegistration" style="<%If prop.Value("NewsletterparagraphType") <> "1" Then 
																				Response.Write("display:none;") 
																			End If%>">
		<%=Gui.GroupBoxStart(Translate.Translate("Tilmelding"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"></td>
				<td><input type="CheckBox" onclick="javascript:Change_NewsletterUserRegistrationReceipt(this);" name="NewsletterUserRegistrationReceipt" value="1" id="both" <%If prop.Value("NewsletterUserRegistrationReceipt") = "1" Then%> checked<%End If%>><%=Translate.Translate("Brug Kvittering")%></td>
			</tr>
			<tr ID="Tr_NewsletterUserRegistrationReceiptLink"<%If prop.Value("NewsletterUserRegistrationReceipt") = "0" Or prop.Value("NewsletterUserRegistrationReceipt") = "" Then%> style="display:none;"<%End If %>>
				<td valign="top"><%=Translate.Translate("Kvittering link")%></td>
				<td><%=Gui.LinkManager(prop.Value("NewsletterUserRegistrationReceiptLink"), "NewsletterUserRegistrationReceiptLink", "")%></td>
			</tr>
			<tr valign="top">
				<td><%=Translate.Translate("Send bekræftelse")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterReceiptNeedConfirmAction" value="true"<%If Base.ChkBoolean(prop.Value("NewsletterReceiptNeedConfirmAction")) = True Then%> checked<%End If%> onclick="Change_NewsletterReceiveConfirmMailText(this);"></td>
							<td><label"><%=Translate.Translate("Ja")%></label></td>
							<td><input type="radio" name="NewsletterReceiptNeedConfirmAction" value="false"<%If Base.ChkBoolean(prop.Value("NewsletterReceiptNeedConfirmAction")) = False Then%> checked<%End If%> onclick="Change_NewsletterReceiveConfirmMailText(this);"></td>
							<td><label><%=Translate.Translate("Nej")%></label></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr valign="top" ID="Tr_NewsletterReceiveConfirmMailText7"<%If Base.ChkBoolean(prop.value("NewsletterReceiptNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td><%=Translate.Translate("Modtageren skal bekræfte tilmelding")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterSubscriptionDoConfirm" value="true"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionDoConfirm")) = True Then%> checked<%End If%>></td>
							<td><label"><%=Translate.Translate("Ja")%></label></td>
							<td><input type="radio" name="NewsletterSubscriptionDoConfirm" value="false"<%If Base.ChkBoolean(prop.Value("NewsletterSubscriptionDoConfirm")) = False Then%> checked<%End If%>></td>
							<td><label><%=Translate.Translate("Nej")%></label></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr ID="Tr_NewsletterReceiveConfirmMailText1"<%If Base.ChkBoolean(prop.value("NewsletterReceiptNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td width="170"><%=Translate.Translate("E-mail emne")%></td>
				<td><input type="text" name="NewsletterReceiptMailSubject" class="std" value="<%=prop.Value("NewsletterReceiptMailSubject")%>"></td>
			</tr>
			<tr ID="Tr_NewsletterReceiveConfirmMailText2"<%If Base.ChkBoolean(prop.Value("NewsletterReceiptNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td valign="top"><%=Translate.Translate("E-mail tekst")%></td>
				<td><textarea name="NewsletterReceiptMailText" rows="4" class="std"><%=prop.Value("NewsletterReceiptMailText")%></textarea></td>
			</tr>
			<tr ID="Tr_NewsletterReceiveConfirmMailText3"<%If Base.ChkBoolean(prop.Value("NewsletterReceiptNeedConfirmAction")) = False Then%> style="display:none;"<%End If %>>
				<td><%=Translate.Translate("Afsenderadresse")%></td>
				<td><input type="text" onchange="validateEmail(this);" name="NewsletterReceiptMailSender" value="<%=prop.Value("NewsletterReceiptMailSender")%>" class="std"></td>
			</tr>
			<tr ID="Tr_NewsletterReceiveConfirmMailText4"<%If Base.ChkBoolean(prop.Value("NewsletterReceiptNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td><%=Translate.Translate("Mail template")%></td>
				<TD valign="top"><%=Gui.FileManager(prop.Value("NewsletterReceiptNeedConfirmTemplate"), "Templates/Newsletters", "NewsletterReceiptNeedConfirmTemplate")%></TD>
			</tr>
			<tr ID="Tr_NewsletterReceiveConfirmMailText5"<%If Base.ChkBoolean(prop.Value("NewsletterReceiptNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td><%=Translate.Translate("Tekst før link")%></td>
				<td><input type="text" name="NewsletterReceiptNeedConfirmLinkText" value="<%=prop.Value("NewsletterReceiptNeedConfirmLinkText")%>" class="std"></td>
			</tr>
			<tr ID="Tr_NewsletterReceiveConfirmMailText6"<%If Base.ChkBoolean(prop.Value("NewsletterReceiptNeedConfirmAction")) = False Then%> style="display:none;"<%End If %>>
				<td valign="top"><%=Translate.Translate("Link til beskræftigelses side")%></td>
				<td><%=Gui.LinkManager(prop.Value("NewsletterReceiptNeedConfirmLink"), "NewsletterReceiptNeedConfirmLink", "")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Vis Tilmeldingsmuligheder")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterShowNewsletterCategories" value="true"<%If Base.ChkBoolean(prop.Value("NewsletterShowNewsletterCategories")) = True Then%> checked<%End If%>></td>
							<td><label><%=Translate.Translate("Ja")%></label></td>
							<td><input type="radio" name="NewsletterShowNewsletterCategories" value="false"<%If Base.ChkBoolean(prop.Value("NewsletterShowNewsletterCategories")) = False Then%> checked<%End If%>></td>
							<td><label><%=Translate.Translate("Nej")%></label></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Tilmeldingsmuligheder")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="1">
						<tr>
							<td><img src='/Admin/Images/CheckAll.gif' alt='<%=Translate.Translate("Vælg alle")%>' onclick='Javascript:select(1);'>&nbsp;<img src='/Admin/Images/CheckNone.gif' alt='<%=Translate.Translate("Fravælg alle")%>' onclick='Javascript:select(0);'></a></td>
							
						</tr>
						<%
		cmd.CommandText = "SELECT * FROM NewsletterExtendedCategory"
		dr = cmd.ExecuteReader()
		Rows = 0
		Do While dr.Read()
			With Response
				.Write("<tr><td nowrap><input type=""CheckBox"" name=""NewsletterParagraphSNewsletters"" id=""news" & dr("NewsletterCategoryID").ToString & """ value=""" & dr("NewsletterCategoryID").ToString & """")
					if NewslettersChecked.Item(dr("NewsletterCategoryID").ToString) = "True" then
						.Write(" Checked ")
					End If
				.Write("><label for=""news" & dr("NewsletterCategoryID").ToString & """>" & dr("NewsletterCategoryName").ToString & "</label></td></tr>" & vbCrLf & vbCrLf)
			End With	
		Loop 
			
		dr.Close()

		%>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3"><strong><%=Translate.Translate("Brugerdefinerede tekster")%></strong></td>
			</tr>
			<tr valign='top'>
				<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Tilmeld") & "</em>" )%></td>
				<td>
					<!-- Text/Image Selector - Start -->
					<table border='0' cellspacing='0' style='padding: 0px 4px 4px 0px'>
						<tr>
							<td><input type="radio" name="NewsletterReceiptBtn" id="SBtn1" value="1" onclick="toggleSSubmitBtn();" <%=IIF((prop.Value("NewsletterReceiptBtn") = "1") Or (prop.Value("NewsletterReceiptBtn") = ""), "checked", "")%>></td>
							<td nowrap><label for="SBtn1"><%=Translate.Translate("Tekst")%></label></td>
							<td id="SShowBtn1" <%=IIF((prop.Value("NewsletterReceiptBtn") = "1") Or (prop.Value("NewsletterReceiptBtn") = ""), "", "style='display: none;'")%>><input type="text" name="NewsletterReceiptBtnText" value="<%=prop.Value("NewsletterReceiptBtnText")%>" class="std"></td>
						</tr>
							<tr>
							<td><input type="radio" name="NewsletterReceiptBtn" id="SBtn2" value="2" onclick="toggleSSubmitBtn();" <%=IIF(prop.Value("NewsletterReceiptBtn") = "2", "checked", "")%>></td>
							<td nowrap><label for="SBtn2"><%=Translate.Translate("Billede")%></label></td>
							<td id="SShowBtn2" <%=IIf(prop.Value("NewsletterReceiptBtn") <> "2", "style='display: none;'", "")%>><%= Gui.FileManager(prop.Value("NewsletterReceiptBtnImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsletterReceiptBtnImage")%></td>
							</tr>
						</table>
					<!-- Text/Image Selector - End -->
				</td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Navnefelt")%></td>
				<td><input type="text" name="NewsletterReceiptNameFieldText" value="<%=prop.Value("NewsletterReceiptNameFieldText")%>" class="std"></td>
			</tr>
			<tr ID="tr_NewsletterReceiptPasswordFieldText"<%If prop.Value("NewsletterUsePassword") = "0" Or prop.Value("NewsletterUsePassword") = "" Then%> style="display:none;"<%End If%>>
				<td><%=Translate.Translate("Passwordfelt")%></td>
				<td><input type="text" name="NewsletterReceiptPasswordFieldText" value="<%=prop.Value("NewsletterReceiptPasswordFieldText")%>" class="std"></td>
			</tr>
			<tr ID="tr_NewsletterReceiptConfirmPasswordFieldText"<%If prop.Value("NewsletterUsePassword") = "0" Or prop.Value("NewsletterUsePassword") = "" Then%> style="display:none;"<%End If%>>
				<td><%=Translate.Translate("Gentag-Passwordfelt")%></td>
				<td><input type="text" name="NewsletterReceiptConfirmPasswordFieldText" value="<%=prop.Value("NewsletterReceiptConfirmPasswordFieldText")%>" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("E-mailfelt")%></td>
				<td><input type="text" name="NewsletterReceiptEmailFieldText" value="<%=prop.Value("NewsletterReceiptEmailFieldText")%>" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Kategorier")%></td>
				<td><input type="text" name="NewsletterReceiptCategoriesText" value="<%=prop.Value("NewsletterReceiptCategoriesText")%>" class="std"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="CheckBox" onclick="javascript:Change_NewsletterReceiptFormat(this);" name="NewsletterReceiptFormat" value="1" id="both" <%If prop.Value("NewsletterReceiptFormat") = "1" Then%> checked<%End If%>><%=Translate.Translate("Bruger vælger format")%></td>
			</tr>
			<tr ID="tr_NewsletterReceiptFormatFieldText" <%If prop.Value("NewsletterReceiptFormat") = "0" Or prop.Value("NewsletterReceiptFormat") = "" Then
																Response.Write("style='display:none'")
														End If%>>
				<td width='170'><%=Translate.Translate("Mailformatfelt")%></td>
				<td><input type="text" name="NewsletterReceiptFormatFieldText" value="<%=prop.Value("NewsletterReceiptFormatFieldText")%>" class="std"></td>
			</tr>
			<tr ID="tr_NewsletterReceiptFormatFieldText1" <%If prop.Value("NewsletterReceiptFormat") = "1" Then 
																Response.Write("style='display:none'")
															End If%>>
				<td><%=Translate.Translate("Default Mailformatfelt")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterReceiptFormatFieldRadio" id="NewsletterReceiptFormatFieldRadio" value="1" <%If prop.Value("NewsletterReceiptFormatFieldRadio") = "1" Or prop.Value("NewsletterReceiptFormatFieldRadio") = "" Then%> checked<%End If%>></td>
							<td><label for="SBtn1"><%=Translate.Translate("Text")%></label></td>
							<td><input type="radio" name="NewsletterReceiptFormatFieldRadio" id="NewsletterReceiptFormatFieldRadio" value="2" <%If prop.Value("NewsletterReceiptFormatFieldRadio") = "2" Then%> checked<%End If%>></td>
							<td><label for="SBtn2"><%=Translate.Translate("Html")%></label></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Tilmeldings template")%></td>
				<TD valign="top"><%=Gui.FileManager(prop.Value("NewsletterReceiptTemplate"), "Templates/Newsletters", "NewsletterReceiptTemplate")%></TD>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<!--END|||||||||||||||||||||| REGISTRATION ||||||||||||||||||||||END -->


		<!--||||||||||||||||||||||||| CANCELLATION ||||||||||||||||||||||||| -->
		<div  ID="Div_NewsletterparagraphTypeCancellation" style="<%If prop.Value("NewsletterparagraphType") <> "2" Then
																				Response.Write("display:none;") 
																			End If%>">
		<%=Gui.GroupBoxStart(Translate.Translate("Afmelding"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"></td>
				<td><input type="CheckBox" onclick="javascript:Change_NewsletterUserCancelReceipt(this);" name="NewsletterUserCancelReceipt" value="1" id="both" <%If prop.Value("NewsletterUserCancelReceipt") = "1" Then%> checked<%End If%>><%=Translate.Translate("Brug Kvittering")%></td>
			</tr>
			<tr ID="Tr_NewsletterUserCancelReceiptLink"<%If prop.Value("NewsletterUserCancelReceipt") = "0" Or prop.Value("NewsletterUserCancelReceipt") = "" Then%> style="display:none;"<%End If %>>
				<td width="170" valign="top"><%=Translate.Translate("Kvittering link")%></td>
				<td><%=Gui.LinkManager(prop.Value("NewsletterUserCancelReceiptLink"), "NewsletterUserCancelReceiptLink", "")%></td>
			</tr>
			<tr valign='top'>
				<td  width="170"><%=Translate.Translate("Bekræft afmelding")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="NewsletterCancelNeedConfirmAction" id="NeedConf1" value="true"<%If Base.ChkBoolean(prop.Value("NewsletterCancelNeedConfirmAction")) = True Then%> checked<%End If%> onclick="ChangeNewsletterCancelNeedConfirm(this);"></td>
							<td><label"><%=Translate.Translate("Ja")%></label></td>
							<td><input type="radio" name="NewsletterCancelNeedConfirmAction" id="NeedConf2" value="false"<%If Base.ChkBoolean(prop.Value("NewsletterCancelNeedConfirmAction")) = False Then%> checked<%End If%> onclick="ChangeNewsletterCancelNeedConfirm(this);"></td>
							<td><label"><%=Translate.Translate("Nej")%></label></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr ID="Tr_NewsletterCancelNeedConfirm"<%If Base.ChkBoolean(prop.Value("NewsletterCancelNeedConfirmAction")) = False Then%> style="display:none;"<%End If%>>
				<td colspan="2">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="170"><%=Translate.Translate("E-mail emne")%></td>
								<td><input type="text" name="NewsletterCancelMAilSubject" class="std" value="<%=prop.Value("NewsletterCancelMAilSubject")%>"></td>
							</tr>
							<tr>
								<td width="170" valign="top"><%=Translate.Translate("E-mail tekst")%></td>
								<td><textarea name="NewsletterCancelMailText" rows="4" class="std"><%=prop.Value("NewsletterCancelMailText")%></textarea></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Afsenderadresse")%></td>
								<td><input type="text" onchange="validateEmail(this);" name="NewsletterCancelMailSender" value="<%=prop.Value("NewsletterCancelMailSender")%>" class="std"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Mail template")%></td>
								<TD valign="top"><%=Gui.FileManager(prop.Value("NewsletterCancelNeedConfirmTemplate"), "Templates/Newsletters", "NewsletterCancelNeedConfirmTemplate")%></TD>
							</tr>
							<tr>
								<td><%=Translate.Translate("Tekst før link")%></td>
								<td><input type="text" name="NewsletterCancelNeedConfirmLinkText" value="<%=prop.Value("NewsletterCancelNeedConfirmLinkText")%>" class="std"></td>
							</tr>
							<tr>
								<td valign="top"><%=Translate.Translate("Link til beskræftigelses side")%></td>
								<td><%=Gui.LinkManager(prop.Value("NewsletterCancelNeedConfirmLink"), "NewsletterCancelNeedConfirmLink", "")%></td>
							</tr>
						</table>
				</td>
			</tr>
			<tr>
				<td colspan="2"><strong><%=Translate.Translate("Brugerdefinerede tekster")%></strong></td>
			</tr>
			<tr valign="top">
				<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Afmeld") & "</em>" )%></td>
				<td>
					<!-- Text/Image Selector - Start -->
					<table border='0' cellspacing='0' style='padding: 0px 4px 4px 0px'>
						<tr>
							<td><input type="radio" name="NewsletterCancelBtn" id="USBtn1" value="1" onclick="toggleUSSubmitBtn();"<%If prop.Value("NewsletterCancelBtn") = "1" Or prop.Value("NewsletterCancelBtn") = "" Then%> checked<%End If%>></td>
							<td nowrap><label for="USBtn1"><%=Translate.Translate("Tekst")%></label></td>
							<td id="USShowBtn1" <%=IIF((prop.Value("NewsletterCancelBtn") = "1") Or (prop.Value("NewsletterCancelBtn") = ""), "", "style='display: none;'")%>><input type="text" name="NewsletterCancelBtnText" value="<%=prop.Value("NewsletterCancelBtnText")%>" class="std"></td>
			</tr>
			<tr>
							<td><input type="radio" name="NewsletterCancelBtn" id="USBtn2" value="2" onclick="toggleUSSubmitBtn();"<%If prop.Value("NewsletterCancelBtn") = "2" Then%> checked<%End If%>></td>
							<td nowrap><label for="USBtn2"><%=Translate.Translate("Billede")%></label></td>
							<td id="USShowBtn2" <%=IIf(prop.Value("NewsletterCancelBtn") <> "2", "style='display: none;'", "")%>><%= Gui.FileManager(prop.Value("NewsletterCancelBtnImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsletterCancelBtnImage")%></td>
							</tr>
						</table>
					<!-- Text/Image Selector - End -->
				</td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("E-mailfelt")%></td>
				<td><input type="text" name="NewsletterCancelEmailFieldText" value="<%=prop.Value("NewsletterCancelEmailFieldText")%>" class="std"></td>
			</tr>
			<tr ID="tr_NewsletterCancelPasswordFieldText"<%If prop.Value("NewsletterUsePassword") = "0" Or prop.Value("NewsletterUsePassword") = "" Then%> style="display:none;"<%End If%>>
				<td width="170"><%=Translate.Translate("Passwordfelt")%></td>
				<td><input type="text" name="NewsletterCancelPasswordFieldText" value="<%=prop.Value("NewsletterCancelPasswordFieldText")%>" class="std"></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Afmeldings template")%></td>
				<TD valign="top"><%=Gui.FileManager(prop.Value("NewsletterCancellationTemplate"), "Templates/Newsletters", "NewsletterCancellationTemplate")%></TD>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<!--END|||||||||||||||||||||| CANCELLATION ||||||||||||||||||||||END -->

		<!--|||||||||||||||||||||||||||| LOGIN ||||||||||||||||||||||||||||| -->

		<div ID="div_Login" style="<%If prop.Value("NewsletterparagraphType") = "3" Then
													Response.Write(";") 
											Else 
													Response.Write("display:none;")
											End If %>">
			<%=Gui.GroupBoxStart(Translate.Translate("Login"))%>
			<table border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td valign="top" width="170"><%=Translate.Translate("Login overskrift")%></td>
					<td align="left" ><input type="textbox" name="NewsletterLoginHeading" class="std" value="<%=prop.Value("NewsletterLoginHeading")%>">
				</tr>
				<tr valign='top'>
					<td><%=Translate.Translate("Angiv e-mail adresse")%></td>
					<td><input type="textbox" name="NewsletterLoginEmail" class="std" value="<%=prop.Value("NewsletterLoginEmail")%>">
				</tr>
				<tr ID="tr_NewsletterLoginPassword"<%If prop.Value("NewsletterUsePassword") = "0" Or prop.Value("NewsletterUsePassword") = "" Then%> style="display:none;"<%End If%>>
					<td><%=Translate.Translate("Angiv kodeord")%></td>
					<td><input type="text" name="NewsletterLoginPassword" value="<%=prop.Value("NewsletterLoginPassword")%>" class="std"></td>
					</div>
				</tr>
				<tr valign='top'>
					<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Login") & "</em>" )%></td>
					<td>
					<!-- Text/Image Selector - Start -->
					<table border='0' cellspacing='0' style='padding: 0px 4px 4px 0px'>
							<tr>
							<td><input type="radio" name="NewsletterLoginBtn" id="NewsletterLoginBtn" value="1" onclick="toggleLoginBtn(1);"<%If prop.Value("NewsletterLoginBtn") = "1" Or prop.Value("NewsletterLoginBtn") = "" Then%> checked<%End If%>></td>
							<td nowrap><label for="SBtn1"><%=Translate.Translate("Tekst")%></label></td>
							<td id="ShowLoginBtn1" <%=IIF((prop.Value("NewsletterLoginBtn") = "1") Or (prop.Value("NewsletterLoginBtn") = ""), "", "style='display: none;'")%>><input type="text" name="NewsletterLoginBtnText" value="<%=prop.Value("NewsletterLoginBtnText")%>" class="std"></td>
				</tr>
				<tr>
							<td><input type="radio" name="NewsletterLoginBtn" id="NewsletterLoginBtn" value="2" onclick="toggleLoginBtn(2);"<%If prop.Value("NewsletterLoginBtn") = "2" Then%> checked<%End If%>></td>
							<td nowrap><label for="SBtn2"><%=Translate.Translate("Billede")%></label></td>
							<td id="ShowLoginBtn2" <%=IIf(prop.Value("NewsletterLoginBtn") <> "2", "style='display: none;'", "")%>><%= Gui.FileManager(prop.Value("NewsletterLoginBtnImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsletterLoginBtnImage")%></td>
								</tr>
							</table>
					<!-- Text/Image Selector - End -->
					</td>
				</tr>
				<TR>
					<TD valign="top" width="170"><%=Translate.Translate("Login template")%></TD>
					<TD valign="top"><%=Gui.FileManager(prop.Value("NewsletterLoginTemplate"), "Templates/Newsletters", "NewsletterLoginTemplate")%></TD>
				</TR>
			</table>
			<%=Gui.GroupBoxEnd%>
			<div ID="div_NewsletterUsePassword"<%If prop.Value("NewsletterUsePassword") = "0" Or prop.Value("NewsletterUsePassword") = "" Then%> style="display:none;"<%End If%>>
			<%if prop.Value("NewsletterUseForgotPassword")="1" then
				response.write(Gui.GroupBoxStart(strNewsletterForgotPasswordLegend))
			else
				response.write(Gui.GroupBoxStart(replace(strNewsletterForgotPasswordLegend, " checked", " ")))
			end if%>
			&nbsp;
			<table border="0" cellpadding="2" cellspacing="0" ID="tbl_NewsletterUseForgotPassword"<%If prop.Value("NewsletterUseForgotPassword") = "0" Or prop.Value("NewsletterUseForgotPassword") = "" Then%> style="display:none;"<%End If%>>
				<tr>
					<td valign="top"><%=Translate.Translate("Overskrift")%></td>
					<td><input type="textbox" name="NewsletterForgotPasswordHeading" class="std" value="<%=prop.Value("NewsletterForgotPasswordHeading")%>">
				</tr>
				<tr> 
					<td valign="top"><%=Translate.Translate("Beskrivelse")%></td>
					<td><textarea name="NewsletterForgotPasswordDescription" rows="4" class="std"><%=prop.Value("NewsletterForgotPasswordDescription")%></textarea>
				</tr>
				<tr> 
					<td valign="top"><%=Translate.Translate("E-mail")%></td>
					<td><input type="textbox" name="NewsletterForgotPasswordEmailFieldText" class="std" value="<%=prop.Value("NewsletterForgotPasswordEmailFieldText")%>">
				</tr>
				<tr> 
					<td><%=Translate.Translate("Bekræftelsestekst")%></td>
					<td><input type="text" name="NewsletterForgotPasswordConfirm" value="<%=prop.Value("NewsletterForgotPasswordConfirm")%>" class="std"></td>
				</tr>
				<tr> 
					<td valign="top"><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Send") & "</em>" )%></td>
					<td>
					<!-- Text/Image Selector - Start -->
					<table border='0' cellspacing='0' style='padding: 0px 4px 4px 0px'>
						<tr>
							<td><input type="radio" name="NewsletterForgotPasswordBtn" id="NewsletterForgotPasswordBtn" value="1" onclick="toggleForgotPasswordBtn(1);"<%If prop.Value("NewsletterForgotPasswordBtn") = "1" Or prop.Value("NewsletterForgotPasswordBtn") = "" Then%> checked<%End If%>></td>
							<td nowrap><label for="SBtn1"><%=Translate.Translate("Tekst")%></label></td>
							<td id="ShowForgotPasswordBtn1" <%=IIF((prop.Value("NewsletterForgotPasswordBtn") = "1") Or (prop.Value("NewsletterForgotPasswordBtn") = ""), "", "style='display: none;'")%>><input type="text" name="NewsletterForgotPasswordBtnText" value="<%=prop.Value("NewsletterForgotPasswordBtnText")%>" class="std"></td>
						</tr>
						<tr>
							<td><input type="radio" name="NewsletterForgotPasswordBtn" id="NewsletterForgotPasswordBtn" value="2" onclick="toggleForgotPasswordBtn(2);"<%If prop.Value("NewsletterForgotPasswordBtn") = "2" Then%> checked<%End If%>></td>
							<td nowrap><label for="SBtn2"><%=Translate.Translate("Billede")%></label></td>
							<td id="ShowForgotPasswordBtn2" <%=IIf(prop.Value("NewsletterForgotPasswordBtn") <> "2", "style='display: none;'", "")%>><%= Gui.FileManager(prop.Value("NewsletterForgotPasswordBtnImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsletterForgotPasswordBtnImages")%></td>
						</tr>
					</table>
					<!-- Text/Image Selector - End -->
					</td>
				</tr>
				<tr> 
					<td><%=Translate.Translate("E-mail emne")%></td>
					<td><input type="text" name="NewsletterForgotPasswordEmailSubject" value="<%=prop.Value("NewsletterForgotPasswordEmailSubject")%>" class="std"></td>
				</tr>
				<tr> 
					<td valign="top" width="170"><%=Translate.Translate("E-mail tekst")%></TD>
					<td><textarea name="NewsletterForgotPasswordMailDescription" rows="4" class="std"><%=prop.Value("NewsletterForgotPasswordMailDescription")%></textarea>
				</tr>
				<tr> 
					<td><%=Translate.Translate("Afsender e-mail")%></td>
					<td><input type="text" onchange="validateEmail(this);" name="NewsletterForgotPasswordEmail" value="<%=""& prop.Value("NewsletterForgotPasswordEmail")%>" class="std"></td>
				</tr>
				<tr> 
					<TD valign="top" width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("E-mail"))%></TD>
					<TD valign="top"><%=Gui.FileManager(prop.Value("NewsletterForgotPasswordMailTemplate"), "Templates/Newsletters", "NewsletterForgotPasswordMailTemplate")%></TD>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
			</div>
		</div>
		<!--END||||||||||||||||||||||||| LOGIN ||||||||||||||||||||||||||END -->

		<!--||||||||||||||||||||||||| USER FIELDS ||||||||||||||||||||||||| -->
		<div  ID="Div_NewsletterUserFields"<%If prop.Value("NewsletterUseUserFields") = "0" Or prop.Value("NewsletterUseUserFields") = "" Then%> style="display:none;"<%End If%>>
		<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede felter"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td valign="top" width="170"><%=Translate.Translate("Brugerdefinerede felter")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="1">
						<tr>
							<td><img src='/Admin/Images/CheckAll.gif' alt='<%=Translate.Translate("Vælg alle")%>' onclick='Javascript:selectFields(1);'>&nbsp;<img src='/Admin/Images/CheckNone.gif' alt='<%=Translate.Translate("Fravælg alle")%>' onclick='Javascript:selectFields(0);'></a></td>
						</tr>
						<%
		cmd.CommandText = "SELECT * FROM NewsletterExtendedUserField"
		dr = cmd.ExecuteReader()
		Rows = 0

		Dim arrCustomUserfields() as String = Split(prop.value("NewsletterParagraphSUserFields"), ",")
		Do While dr.Read()
			With Response
				.Write("<tr><td nowrap><input type=""checkbox"" name=""NewsletterParagraphSUserFields"" id=""NewsletterFieldID" & dr("NewsletterUserFieldID").ToString & """ value=""" & dr("NewsletterUserFieldID").ToString & """")
				
				If Base.IsValueInArray(arrCustomUserfields, CStr(Trim(dr("NewsletterUserFieldID").ToString))) Then
					.Write(" Checked ")
				End If
				.Write("><td nowrap><label for=""NewsletterFieldID" & dr("NewsletterUserFieldID").ToString & """>" & dr("NewsletterUserFieldName").ToString & "</label></td></tr>" & vbCrLf & vbCrLf)
			End With
		Loop 

		dr.Dispose()
		cmd.Dispose()
		cn.Dispose()
		%>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<!--END|||||||||||||||||||||| USER FIELDS ||||||||||||||||||||||END -->

		<!--||||||||||||||||||||||||| NOTIFICATION ||||||||||||||||||||||||| -->
		<div  ID="Div_NewsletterNotification"<%If prop.Value("NewsletterUseNotification") = "0" Or prop.Value("NewsletterUseNotification") = "" Then%> style="display:none;"<%End If%>>
		<%=Gui.GroupBoxStart(Translate.Translate("Brug Admin. Notificering"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr ID="TR_NotificationReg" STYLE="DISPLAY: <%If prop.Value("NewsletterparagraphType") <> "1" Then
																Response.Write("None;") 
														End If%>">
				<td width="170"></td>
				<td><input type="CheckBox" name="NewsletterRegistrationNotification" value="1" <%If prop.Value("NewsletterRegistrationNotification") = "1" Then
				Response.Write(" Checked")
			End If%>><%=Translate.Translate("Tilmelding")%>
				</td>
			<tr ID="TR_NotificationCan" STYLE="DISPLAY: <%If prop.Value("NewsletterparagraphType") <> "2" Then 
																Response.Write("None;") 
														End If%>">
				<td width="170"></td>
				<td>
					<input type="CheckBox" name="NewsletterCancelNotification" value="1" <%If prop.Value("NewsletterCancelNotification") = "1" Then
																								Response.Write(" Checked")
																						End If%>><%=Translate.Translate("Afmelding")%>
				</td>
			<tr ID="TR_NotificationSub" STYLE="DISPLAY: <%If prop.Value("NewsletterparagraphType") <> "3" Then 
																Response.Write("None;")
														End If%>">
				<td width="170"></td>
				<td>
					<input type="CheckBox" name="NewsletterChangeNotification" value="1" <%If prop.Value("NewsletterChangeNotification") = "1" Then
																								Response.Write(" Checked") 
																						End If %>><%=Translate.Translate("Abonnementsændring")%>
				</td>
			</tr>
			<tr> 
				<td valign="top" width="170"><%=Translate.Translate("Notifikations E-mail")%></td>
				<td><input type="text" onchange="validateEmail(this);" name="NewsletterEmailNotification" value="<%=prop.Value("NewsletterEmailNotification")%>" class="std"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<!--END|||||||||||||||||||||| NOTIFICATION ||||||||||||||||||||||END -->

		<!--||||||||||||||||||||||||| ERRORS ||||||||||||||||||||||||| -->
		<div  ID="Div_NewsletterUseCustomErrors"<%If prop.Value("NewsletterUseCustomErrors") = "0" Or prop.Value("NewsletterUseCustomErrors") = "" Then%> style="display:none;"<%End If%>>
		<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede fejlbeskeder"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Password gentag fejl")%></td>
				<td><input type="Text" name="NewsletterPasswordRepeatPasswordError" value="<%=prop.Value("NewsletterPasswordRepeatPasswordError")%>" class="std">
				</td>
			</TR>
			<tr>
				<td width="170"><%=Translate.Translate("Password skal udfyldes")%></td>
				<td><input type="Text" name="NewsletterFiloutPasswordError" value="<%=prop.Value("NewsletterFiloutPasswordError")%>" class="std">
				</td>
			</TR>
			<tr>
				<td width="170"><%=Translate.Translate("Navn skal udfyldes")%></td>
				<td><input type="Text" name="NewsletterFiloutNameError" value="<%=prop.Value("NewsletterFiloutNameError")%>" class="std">
				</td>
			</TR>
			<tr>
				<td width="170"><%=Translate.Translate("Email skal udfyldes")%></td>
				<td><input type="Text" name="NewsletterFiloutEmailError" value="<%=prop.Value("NewsletterFiloutEmailError")%>" class="std">
				</td>
			</TR>
			<tr>
				<td width="170"><%=Translate.Translate("Der skal vælges en liste!")%></td>
				<td><input type="text" name="NewsletterSelectKategoryError" value="<%=prop.Value("NewsletterSelectKategoryError")%>" class="std">
				</td>
			</TR>
			<tr>
				<td width="170"><%=Translate.Translate("Ingen liste valgt, fortsæt?")%></td>
				<td><input type="text" name="NewsletterNoSelectedKategoryError" value="<%=prop.Value("NewsletterNoSelectedKategoryError")%>" class="std">
				</td>
			</TR>
			<tr>
				<td width="170"><%=Translate.Translate("Ugyldig e-mail adresse!")%></td>
				<td><input type="text" name="NewsletterInvalidEmailError" value="<%=prop.Value("NewsletterInvalidEmailError")%>" class="std">
				</td> 
			</TR>
			<tr>
				<td width="170"><%=Translate.Translate("Tekst")%></td>
				<td><input type="text" name="NewsletterTextError" value="<%=prop.Value("NewsletterTextError")%>" class="std">
				</td>
			</TR>
			<tr>
				<td width="170"><%=Translate.Translate("HTML")%></td>
				<td><input type="text" name="NewsletterHTMLError" value="<%=prop.Value("NewsletterHTMLError")%>" class="std">
				</td> 
			</TR>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
	</td>
</tr>

<%
 Translate.GetEditOnlineScript()
%>
