function elm(id) {
    return document.getElementById(id);
}

function changeStyleDisplay(obj, elementName) {
    var elem = elm(elementName);
    if (elem != null && elem != 'undefined') {
        var style = "none";
	    if(obj.checked)	style = "";
	    elem.style.display = style;
	}
}

function onChangeUseLinkToProfile(obj) {
    changeStyleDisplay(obj, "rowUseLinkToProfile");		
}

function onChangeUsePassword(obj) {    
    changeStyleDisplay(obj, "rowUsePassword");
    if(obj.checked)
    {
        var useForgotPassword = document.getElementById("UseForgotPassword");
        if(useForgotPassword.checked) changeStyleDisplay(useForgotPassword, "rowUseForgotPassword");
    }
    else
        changeStyleDisplay(obj, "rowUseForgotPassword"); 
}

function onChangeUseForgotPassword(obj) {
     changeStyleDisplay(obj, "rowUseForgotPassword");		
}

function onChangeUseNotification(obj) {
    changeStyleDisplay(obj, "rowNotification");
}

function onChangeUseConfirmation(obj) {
    changeStyleDisplay(obj, "rowConfirmation");
}

function onChangeUsePagingBackText(obj) {
    changeStyleDisplay(obj, "rowPagingBackText");
}

function onChangeUsePagingBackImg(obj) {
    changeStyleDisplay(obj, "rowPagingBackImg");
}

function onChangeUsePagingFwdText(obj) {
    changeStyleDisplay(obj, "rowPagingFwdText");
}

function onChangeUsePagingFwdImg(obj) {
    changeStyleDisplay(obj, "rowPagingFwdImg");
}

function validateEmail(obj) {
	if(!ValidateEmailRegExp(obj.value))
		alert('<%=Translate.JSTranslate("Invalid value in: E-mail address")%>');
}

function onPageLoad(isExtranetInstalled) {
    onChangeShowMode(isExtranetInstalled);
    onChangeUseLinkToProfile(elm('UseLinkToProfilePage'));
    onChangeUsePassword(elm('UsePassword'));
    onChangeUseForgotPassword(elm('UseForgotPassword'));
    onChangeUseNotification(elm('EnableNotification'));
    onChangeUseConfirmation(elm('ConfirmChanges'));
    onChangeUsePagingFwdText(elm('PagingUseFwdText'));
    onChangeUsePagingFwdImg(elm('PagingUseFwdImg'));
    onChangeUsePagingBackText(elm('PagingUseBackText'));
    onChangeUsePagingBackImg(elm('PagingUseBackImg'));
    
    if(!isExtranetInstalled)
        disableDependentFields();
}

function hideAllPanels() {
    var panels = [ 'divSubscription', 
        'divArchive', 
        'divUnSubscription', 
        'divLogin', 
        'divValidationMessages', 
        'divCustomFields', 
        'rowSubscribeQuickTemplate',
        'rowSubscribeTemplate',
        'rowNotificationTitle',
        'rowConfirmationTitle',
        'rowAllowSelectFormat',
        'rowAllowDeleteProfile',
        'rowEmailWarning',
        'tabCustomTextsNotification',
        'tabCustomTextsForgotPassword',
        'tabCustomTextsConfirmation',
        'tabCustomTextsSort',
        'tabCustomTextsPaging',
        'tabCustomTextsLogoffText'];
    for(var i = 0; i < panels.length; i++)
        SetVisibleById(panels[i], false);
}

function onChangeShowMode(isExtranetInstalled) {

    var buttons = ['ShowMode1', 'ShowMode2', 'ShowMode3', 'ShowMode4' ];
    var chkLinkToProfile = elm('UseLinkToProfilePage');
    var mode = 0;
    
    for(var i = 0; i < buttons.length; i++)
        if(elm(buttons[i]).checked) {
            mode = ++i;
            break;
        }
    
    hideAllPanels();
    switch(mode) {
        // Quick Subscribe
        case 1:
            SetVisibleById('divSubscription', true);
            SetVisibleById('rowSubscribeQuickTemplate', true);
            SetVisibleTRUseLinkToProfilePage(true);                
            SetVisibleById('tabCustomTextsValidationMessages', true);
            SetVisibleById('rowAllowSelectFormat', true); 
            SetVisibleById('rowNotificationTitle', true);
            SetVisibleById('rowConfirmationTitle', true);            
            
            SetVisibleById('tabCustomTextsNotification', true);
            SetVisibleById('tabCustomTextsConfirmation', true);
            SetVisibleById('divCustomFields', true);
            
            chkLinkToProfile.disabled = !isExtranetInstalled;
            break;
            
        //Subscription changes
        case 4:
            SetVisibleById('divSubscription', true);
            SetVisibleById('divLogin', true);
            SetVisibleById('rowSubscribeTemplate', true);            
            SetVisibleById('divCustomFields', true);            
            SetVisibleById('rowNotificationTitle', true);
            SetVisibleById('rowConfirmationTitle', true);  
            SetVisibleTRUseLinkToProfilePage(false);                  
            SetVisibleById('rowAllowSelectFormat', true); 
            SetVisibleById('rowAllowDeleteProfile', true);
            SetVisibleById('rowEmailWarning', true); 
                        
            SetVisibleById('tabCustomTextsNotification', true);
            SetVisibleById('tabCustomTextsConfirmation', true);
            SetVisibleById('tabCustomTextsForgotPassword', true);            
            SetVisibleById('tabCustomTextsValidationMessages', true);
            SetVisibleById('tabCustomTextsLogoffText', true);
            
            break;
        // Archive
        case 2:
            SetVisibleById('divArchive', true);            
            SetVisibleTRUseLinkToProfilePage(false);      
            SetVisibleById('tabCustomTextsValidationMessages', false);
            SetVisibleById('tabCustomTextsSort', true); 
            SetVisibleById('tabCustomTextsPaging', true); 
            break;
        // UnSubscribe
        case 3:
            SetVisibleById('divUnSubscription', true);
            SetVisibleTRUseLinkToProfilePage(true);                
            SetVisibleById('tabCustomTextsValidationMessages', true);   
            SetVisibleById('divCustomFields', true);
            
            chkLinkToProfile.disabled = !isExtranetInstalled;
            break;
    }
}

function SetVisibleTRUseLinkToProfilePage(visible)
{
    SetVisibleById('TRUseLinkToProfilePage', visible);
    var page = document.getElementById("rowUseLinkToProfile");
    if(visible)
    {
        var useLinkToProfilePage = document.getElementById("UseLinkToProfilePage");
        page.style.display = useLinkToProfilePage.checked ? '' : 'none';
    } 
    else
    {
        page.style.display = 'none';
    }
}

function disableDependentFields() {
    var fields = [
        'tabCustomTextsLogoffText',
        'tabCustomTextsForgotPassword',
        'rowCustomConfirmChanges',
        'rowCustomConfirmChangesLink',
        'modeSubChanges',
        'rowAllowDeleteProfile',
        'confirmTypeSubChanged',
        'divLogin',
        'TRUseLinkToProfilePage'
    ];
    
    for(var i = 0; i < fields.length; i++)
        disableContents(fields[i]);
}

function disableContents(id) {
    var obj = elm(id);
    if(obj && obj.childNodes) {
        var childs = obj.childNodes;
        for(var i = 0; i < childs.length; i++) {
            var child = childs[i];
            
            if(typeof(child.disabled) != 'undefined')
                child.disabled = true;
            if(typeof(child.setAttribute) == 'function')
                child.setAttribute('style', 'color: #c3c3c3');
        }
    }
}