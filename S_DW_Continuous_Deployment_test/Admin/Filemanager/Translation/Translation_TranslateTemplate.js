/***************************************************************************************************
	Current version:	1.0
	Created:		29-09-2008
	Last modified:	29-09-2008
	
	Purpose: client-side implementation of template translation editor.
	
	Revision history:
		1.0 - 29-09-2008 - Pavel Volgarev
		    1.First version.
	
***************************************************************************************************/

/*************  Page handling routines. *************/

var Page = new Object();

/* Fires when the page is loaded */
Page.onLoad = function() {
    this.stretchContent();
    
    if(!document.getElementById('contentRow'))
        this.toggleContent('divBrowse');
}

/* Fires when page is resized */
Page.onResize = function() {
    this.stretchContent();
}

/* Opens help window */
Page.help = function() {
    var script = $('#scriptHelp');
    
    if(script)
        eval(script.html());
}

/* Stretches page main content to fit window. */
Page.stretchContent = function() {
    var contentID = 'divContent';
    var tabContentID = 'tbTranslate';
    
    if(!document.getElementById('contentRow') ||
        $('#' + contentID).css('display') == 'none') {
        contentID = 'divBrowse';
        tabContentID = 'tbBrowse';
    }
        
    $('#' + contentID).width(document.documentElement.clientWidth - 5);
    $('#' + contentID).height(document.documentElement.clientHeight - 
        $('#rowRibbon').height() - 10);
        
    this.fixTable(tabContentID);
}

/* Closes all open dialogs */
Page.closeAllDialogs = function() {
	var dialogs = this.getActiveDialogs();
	for(var i = 0; i < dialogs.length; i++)
		Dialog.close(dialogs[i]);
}

/* Returns all opened dialogs */
Page.getActiveDialogs = function() {
	var allDialogs = $("span[@type='dialog']");
	var activeDialogs = new Array();
	var activeIndex = 0;
	
	for(var i = 0; i < allDialogs.length; i++)
		if(Dialog.isActive(allDialogs[i].id))
			activeDialogs[activeIndex++] = allDialogs[i].id;
	
	return activeDialogs;
}

/* Stretches last table column to fill remaining page width */
Page.fixTable = function(id) {
    var firstRow = $('#' + id).children()[0].childNodes[0].childNodes;
    var remainingWidth = document.documentElement.clientWidth;
    
    if(firstRow) {
        for(var i = 0; i < (firstRow.length - 1); i++)
            remainingWidth -= $(firstRow[i]).width();
        $(firstRow[i]).width(remainingWidth);
    }
}

/* Toggles the ribbon bar button state */
Page.toggleRibbonbarButton = function(buttonID, active) {
	if(active)
		$('#' + buttonID).addClass('active');
	else
		$('#' + buttonID).removeClass('active');
}

/* Highlights table row on 'mouseover' event */
Page.toggleTableRow = function(row, over) {
    $(row).css({
        'background-color': (over ? '#fff0b2' : '')
    });
}

/* Filters 'browse keys' table rows by location specified */
Page.switchViewKeysByLocation = function(location, show) {
    var nodes = $('tr[@class="BrowseKey_' + location + ' keyTableRow"]');
    
    $('#phNoKeyFound').hide();
    if(nodes) {
        for(var i = 0; i < nodes.length; i++)
            if(show)
                $(nodes[i]).show();
            else
                $(nodes[i]).hide();
    }
    
    if(!this.checkEmptySelection()) {
        var tx = $('#txSearch');
        if(tx.val().length > 0)
            this.onSearch(tx[0]);
    }
}

/* Checks whether no locations are selected in dropdown (in this case 'not found' row should be displayed). */
Page.checkEmptySelection = function() {
    var hiddenNodes = 0;
    var rows = $('td[@class="searchable"]');
    var ret = false;
    
    if(rows) {
        for(var i = 0; i < rows.length; i++) {
            var parent = $(rows[i]).parent()[0];
            if($(parent).css('display') == 'none')
                hiddenNodes++;
            else
                break;
        }
    }
    
    ret = (hiddenNodes == rows.length);
    if(ret)
        $('#phNoKeyFound').show();
    else
        $('#phNoKeyFound').hide();
        
    return ret;
}

/* Executes the search procedure on 'browse keys' table */
Page.onSearch = function(textbox) {
    var globalViewChecked = $('#ViewKeys_chkViewGlobal')[0].checked;
    var localViewChecked = $('#ViewKeys_chkViewLocal')[0].checked;
    var showed = 0;
    
    $('#phNoKeyFound').hide();
    if(textbox.value.length == 0) {
        Page.switchViewKeysByLocation('Global', globalViewChecked);
        Page.switchViewKeysByLocation('Local', localViewChecked);
    }
    else {
        var allKeys = $('td[@class="searchable"]');
        if(allKeys && allKeys.length > 0) {
            for(var i = 0; i < allKeys.length; i++) {
                var parent = $(allKeys[i]).parent();
                
                if((globalViewChecked && $(parent).attr('class').indexOf('BrowseKey_Global') >= 0) ||
                    (localViewChecked && $(parent).attr('class').indexOf('BrowseKey_Local') >= 0)) {
                    
                    var text = allKeys[i].innerHTML;
                    if(text.toLowerCase().indexOf(textbox.value) < 0)
                        parent.hide();
                    else {
                        parent.show();  
                        showed++;
                    }  
                }
            }
            
            if(showed == 0)
                $('#phNoKeyFound').show();
        }
    }
}

/* Toggles content tab */
Page.toggleContent = function(contentID) {
    var nodes = $("div[@class='grid']");
    
    if(nodes) {
        for(var i = 0; i < nodes.length; i++)
            $(nodes[i]).hide();
    }
    
    $('#' + contentID).show();
    Page.stretchContent();
}

/* Deactivates all toolbar buttons */
Page.deactivateAllButtons = function() {
    var buttons = [ 'cmdAddKey', 'cmdViewKeys', 'cmdViewCultures' ];
    
    for(var i = 0; i < buttons.length; i++)
        this.toggleRibbonbarButton(buttons[i], false);
}

/* Saves current translations */
Page.save = function() {
    if(document.getElementById('contentRow')) {
        $('#saveFlag').val('true');
        $('#MainForm').submit();
    }
}

Page.editTemplate = function() {
    var file = $('#TemplateFile')[0].value;
    var folder = $('#TemplateFolder')[0].value;
    var useNew = $('#UseNewEditor')[0].value.toLowerCase() == 'true';
    var script = '/Admin/Filemanager/FileEditor/FileManager_FileEditorV2.aspx';
    var caller = $('#WindowCaller')[0];
    
    var width = window.screen.width - 200;
    var height = window.screen.height - 200;
    var wnd = null;
    
    if(caller.value == 'edit' && window.opener && !window.opener.closed)
        wnd = window.opener;
    else {
        caller.value = '';
        wnd = window.open(script + '?File=' + file + '&Folder=' + folder + '&width=' + width + '&height=' + height + '&Caller=translate', 'dwTranslateEditWnd',
            'resizable=yes,scrollbars=no,toolbar=no,location=no,directories=no,status=yes,minimize=no,left=100,top=100,width=' + 
            width + ',height=' + height);
    }
   
    if(wnd)
        wnd.focus();
}

/*************  Base class for dialog (layer) operation handling *************/

var Dialog = new Object();

/* Show specified dialog */
Dialog.show = function(dialogID, onAfterShow) {
	Page.closeAllDialogs();
	
	$('#' + dialogID).css('display', '');
	this.center(dialogID);
	
	if(onAfterShow != null && typeof(onAfterShow) == 'function')
		onAfterShow();
}

/* Closes specified dialog */
Dialog.close = function(dialogID) {
	$('#' + dialogID).css('display', 'none');
}

/* Centers specified dialog  */
Dialog.center = function(dialogID) {
	var obj = document.getElementById(dialogID);
	$('#' + dialogID).css('left', (document.body.clientWidth / 2) - (obj.clientWidth / 2));
	$('#' + dialogID).css('top', (document.body.clientHeight / 2) - (obj.clientHeight / 2));
}

/* Moves specified dialog to the specified position */
Dialog.moveTo = function(dialogID, x, y) {
	$('#' + dialogID).css('left', x);
	$('#' + dialogID).css('top', y);
}

/* Determines whether specified dialog is opened */
Dialog.isActive = function(dialogID) {
	var obj = document.getElementById(dialogID);
	return obj.style.display != 'none';
}

/*************  Base class for dropdown dialog (layer) operation handling *************/

var DropDownDialog = new Object();

/* Toggles dropdown visibility */
DropDownDialog.toggle = function(dialogID, buttonID, callback) {
    if(!Dialog.isActive(dialogID))
        this.show(dialogID, buttonID);
    else 
        this.close(dialogID, buttonID);
    
    /* call 'onshow' event */
    if(typeof(callback) == 'function')
        callback(Dialog.isActive(dialogID));
}

/* Retrieves dropdown offset from the toolbar start */
DropDownDialog.getOffset = function(buttonID) {
    var buttons = [ 'cmdSave', 'cmdEditTemplate', 'cmdViewCultures' ];
    var offset = 5;
    var found = false;
    
    
    for(var i = 0; i < buttons.length; i++) {
        if(buttons[i] != buttonID) {
            var cmd = $('#' + buttons[i]);
            var prev = cmd.parent();
            offset += prev.width() + 10;
        }
        else
            found = true;
    }
    
    if(!found)
        offset = 5;
    
    return offset;
}

/* Shows the dropdown under specified toolbar button. */
DropDownDialog.show = function(dialogID, buttonID) {
    Page.deactivateAllButtons();
    Page.closeAllDialogs();
    
    Page.toggleRibbonbarButton(buttonID, true);
    Dialog.show(dialogID);
    Dialog.moveTo(dialogID, this.getOffset(buttonID), $('#rowRibbon').height() - 25);
}

/* Closes the dropdown */
DropDownDialog.close = function(dialogID, buttonID) {
    Page.toggleRibbonbarButton(buttonID, false);
    Dialog.close(dialogID);
}

/*************  'Culture list' dropdown dialog implementation *************/

var CultureListDialog = new Object();

/* Toggles dialog visibility */
CultureListDialog.toggle = function() {
    if(document.getElementById('contentRow'))
        DropDownDialog.toggle('CultureListDialog', 'cmdViewCultures');
}

/* Closes the dialog */
CultureListDialog.close = function() {
    DropDownDialog.close('CultureListDialog', 'cmdViewCultures');
}

/* Toggles dialog list item active state */
CultureListDialog.toggleRow = function(checkbox) {
    var row = $(checkbox).parent().parent();
    if(checkbox.checked)
        row.addClass('dListActive');
    else
        row.removeClass('dListActive');
}

/*************  'View keys' dropdown dialog implementation *************/

var ViewKeysDialog = new Object();

/* Toggles dialog visibility */
ViewKeysDialog.toggle = function() {
    DropDownDialog.toggle('ViewKeysDialog', 'cmdViewKeys');
}

/* Closes the dialog */
ViewKeysDialog.close = function() {
    DropDownDialog.close('ViewKeysDialog', 'cmdViewKeys');
}

/* Toggles dialog list item active state */
ViewKeysDialog.toggleRow = function(checkbox) {
    var row = $(checkbox).parent().parent();
    if(checkbox.checked)
        row.addClass('dListActive');
    else
        row.removeClass('dListActive');
}
