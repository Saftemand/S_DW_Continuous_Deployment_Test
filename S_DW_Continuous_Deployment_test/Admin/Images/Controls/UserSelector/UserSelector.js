function UserSelectorSettings(UserSelectorDivID, HiddenID, NoneSelectedText, OnSelectScript, OnUnselectScript, OnRemoveScript, OnDefaultUserSelect, OnDefaultUserRemove, OnlyBackend, name, MaxOne, SurroundingDivID, CompatibleWithOldExtranet, HiddenAddedID, HiddenRemovedID, AdditionalTextLink, HideAdmins, ShowSmartSearches, CountChangedCallback, isOnUserEditPage)
{

    this.UserSelectorDivID = UserSelectorDivID;
    this.SurroundingDivID = SurroundingDivID;
    this.HiddenID = HiddenID;
    this.NoneSelectedText = NoneSelectedText;
    this.OnSelectScript = OnSelectScript;
    this.OnUnselectScript = OnUnselectScript;
    this.OnRemoveScript = OnRemoveScript;
    this.OnDefaultUserSelect = OnDefaultUserSelect;
    this.OnDefaultUserRemove = OnDefaultUserRemove;
    this.OnlyBackend = OnlyBackend;
    this.name = name;
    this.MaxOne = MaxOne;
    this.CompatibleWithOldExtranet = CompatibleWithOldExtranet;
    this.HiddenAddedID = HiddenAddedID;
    this.HiddenRemovedID = HiddenRemovedID;
    this.AdditionalTextLink = AdditionalTextLink;
    this.HideAdmins = HideAdmins;    
    this.items = new Array()
    this.ShowSmartSearches = ShowSmartSearches == null ? false : ShowSmartSearches;
    this._isBusy = false;
    this.selectedID = '-1';
    this._uniqueID = '';
    this._moreTextFormat = '';
    this._undiscoveredItems = [];
    this.CountChangedCallback = CountChangedCallback;
    this.CountChanged = false;
    this._isOnUserEditPage = isOnUserEditPage;
}


UserSelectorSettings.prototype.addUser = function()
{
    var self = this;
    this.openWindow('/Admin/Module/UserManagement/SelectUserPopup.aspx' +
        '?UserCallBack=' + this.name + '.addUserWithID' +
        '&OnlyBackend=' + this.OnlyBackend +
        '&CompatibleWithOldExtranet=' + this.CompatibleWithOldExtranet +
        '&HideAdmins=' + this.HideAdmins,                
        'AddUserPopup',
        600,
        400, 
        function (returnValue) {
            if (returnValue && returnValue.userID && returnValue.userName) {
                var userID = returnValue.userID;
                var userName = returnValue.userName;
                self.addUserWithID(userID, userName, false);
            }
        });    
}
UserSelectorSettings.prototype.addGroup = function()
{
    var self = this;
    this.openWindow('/Admin/Module/UserManagement/SelectGroupPopup.aspx' +
        '?GroupCallBack=' + this.name + '.addGroupWithID' +
        '&CompatibleWithOldExtranet=' + this.CompatibleWithOldExtranet +                
        '&ShowSmartSearch=false',
        'AddGroupPopup',
        200,
        400,
        function (returnValue) {
            if (returnValue && returnValue.groupID && returnValue.groupName) {
                var groupID = returnValue.groupID;
                var groupName = returnValue.groupName;
                var userCount = returnValue.userCount;
                var groupsIsSmartSearch = returnValue.groupsIsSmartSearch;
                self.addGroupWithID(groupID, groupName, userCount, false, groupsIsSmartSearch);
            }
        });
}

UserSelectorSettings.prototype.addSegment = function (providerParams)
{
    var self = this;
    this.openWindow('/Admin/Content/Management/Smartsearches/Default.aspx?' + providerParams, 'AddSegmentPopup', 1000, 600,
        function (returnValue) {
            if (returnValue && returnValue.listID && returnValue.listName) {
                var segmentID = returnValue.listID;
                var segmentName = returnValue.listName;
                self.addSegmentWithID(segmentID, segmentName);
            }
        });    
}

UserSelectorSettings.prototype.addUserWithID = function (userID, userName, renderOnly)
{
    this.addItem(userID, 'u', '/Admin/Images/Controls/UserSelector/user.png', userName, renderOnly);
    this.renderItems(userID, 'u');
}

UserSelectorSettings.prototype.addGroupWithID = function(groupID, groupName, userCount, renderOnly, groupsIsSmartSearch)
{
    var groupType = groupsIsSmartSearch ? 's' : 'g';
    var groupImagePath = groupsIsSmartSearch ? '/Admin/Images/VersionCompare.gif' : '/Admin/Images/Controls/UserSelector/folder.png';
    this.addItem(groupID, groupType, groupImagePath, groupName + ' (' + userCount + ')', renderOnly);
    this.renderItems(groupID, 'g');
}

UserSelectorSettings.prototype.addSegmentWithID = function(segmentID, segmentName, renderOnly)
{
    this.addItem(segmentID, 's', '/Admin/Images/VersionCompare.gif', segmentName, renderOnly);
    this.renderItems(segmentID, 's');
}

UserSelectorSettings.prototype.SortUser = function(first, second)
{
    if(first.id == '0' || first.id == 'u0')
        return -1;
    else if(second.id == '0' || first.id == 'u0')
        return 1;

    if(first.type == second.type)
    {
        if(first.name == second.name)
            return 0;

        if(first.name < second.name)
            return -1;
        else
            return 1;
    }
    else
    {
        if(first.type == 'g')
            return -1;
        else if(first.type == 's' && second.type == 'u')
            return -1;
        else
            return 1;
    }
}

UserSelectorSettings.prototype.openWindow = function (url, windowName, width, height, onPopupClose)
{    
    if (window.showModalDialog) {
        var returnValue = window.showModalDialog(url, windowName, 'dialogHeight:' + height + 'px; dialogWidth:' + width + 'px;');
        if (onPopupClose) {
            onPopupClose(returnValue);
        }
        return returnValue;
    }
    else {
        if (onPopupClose) {
            var self = this;
            window[windowName + "_modalDialogOk"] = function () {
                onPopupClose.apply(self, arguments);
            }
        }
        var popupWnd = window.open(url, windowName, 'status=0,toolbar=0,menubar=0,resizable=0,directories=0,titlebar=0,modal=yes,width=' + width + ',height=' + height);
    }
}

UserSelectorSettings.prototype.addItem = function(rawid, type, image, uname, renderOnly) {
    var id = (this.ShowSmartSearches ? type : '') + rawid;

    if(this.MaxOne)
        this.ClearUsers();

    if(this.ExistsInHidden(this.HiddenID, id) && !renderOnly)
        return;

    var iname = unescape(uname);
    var div = document.getElementById(this.UserSelectorDivID);
    var item = new Object();
    item.id = id;
    item.type = type;
    item.image = image;
    item.name = iname;
    item.excluded = false;
    this.items[this.items.length] = item;
    this.items.sort(this.SortUser);

    if(!renderOnly) {
        this.AddToHidden(this.HiddenID, id)
        this.AddToHidden(this.HiddenAddedID, id)
        this.RemoveFromHidden(this.HiddenRemovedID, id)

        if(document.getElementById(this.UserSelectorDivID + 'none'))
            document.getElementById(this.UserSelectorDivID).removeChild(document.getElementById(this.UserSelectorDivID + 'none'))
    }

    this.CountChanged = true;
}

UserSelectorSettings.prototype.renderItems = function(rawid, type) {

    var id = (this.ShowSmartSearches ? type : '') + rawid;
    var div = document.getElementById(this.UserSelectorDivID);

    div.innerHTML = '';

    for(var i = 0; i < this.items.length; i++) {
        var itemImage = this.items[i].excluded ? '/Admin/Images/Controls/UserSelector/ExcludedUser.png' : this.items[i].image;
        div.innerHTML += '<div id=' + this.UserSelectorDivID + this.items[i].id + (this._isOnUserEditPage && this.items[i].type == "s" ? '' : ' onclick="' + this.name + '.selectDiv(\'' + this.items[i].id + '\');') + '" style="' + (this.MaxOne || (this._isOnUserEditPage && this.items[i].type == "s") ? '' : 'cursor:pointer; ') + (this._isOnUserEditPage && this.items[i].type == "s" ? 'background-color: #D5D5D5;' : '') + 'white-space:nowrap;"><div style="float:left; margin-right: 2px; margin-bottom: 1px;"><img alt="" src="' + itemImage + '" /></div><div>' + this.items[i].name + '</div><div style="clear:both;line-height:0px;visibility:hidden">&nbsp;</div></div>';
    }

    if(id != '' && id != this.getDefaultId()) {
        if(id)
            this.selectDiv(id);
        else if(this.items.length > 0)
            this.selectDiv(this.items[this.items.length - 1].id);

    }

    if(this.CountChanged) {
        this.CountChanged = false;

        if(this.CountChangedCallback != null)
            this.CountChangedCallback(document.getElementById(this.HiddenID).value);
    }
}

UserSelectorSettings.prototype.addNotShownIDs = function(notShownIDs, text)
{
    if(text && text.length > 0)
    {
        //Add text
        var outerDiv = document.getElementById(this.SurroundingDivID);
        if(this.AdditionalTextLink.length > 0)
            outerDiv.innerHTML += '<div id="' + this.name + '_NotShown" style="white-space:nowrap; cursor:pointer; "><a href="' + this.AdditionalTextLink + '">' + text + '</a></div><div style="clear:both;"/>';
        else
            outerDiv.innerHTML += '<div style="white-space:nowrap; ">' + text + '</div><div style="clear:both;"/>';
    }

    if(notShownIDs && notShownIDs.length > 0)
    {
        //Add to IDs
        var hidden = document.getElementById(this.HiddenID);
        if(hidden.value.length > 0)
            hidden.value += ',';
        hidden.value += notShownIDs;

        this._undiscoveredItems = notShownIDs.split(',');
    }
}

UserSelectorSettings.prototype.selectDefaultDiv = function() {
    this.selectDiv(this.getDefaultId());
}

UserSelectorSettings.prototype.getDefaultId = function()
{
    return this.ShowSmartSearches ? 'u0' : '0';
}

UserSelectorSettings.prototype.selectDiv = function (id) {
    if(this.MaxOne)
        return;

    var subDivs = document.getElementById(this.UserSelectorDivID).childNodes;

    for (var i = 0; i < subDivs.length; i++)
        if (!this._isOnUserEditPage || this.items[i].type != "s") {
            subDivs[i].style.backgroundColor = '';
        };

    if(this.selectedID == id || id == '')
    {
        this.selectedID = '-1';
        this.onUnselect();

    } 
    else
    {
        document.getElementById(this.UserSelectorDivID + id).style.backgroundColor = 'lightblue';
        this.selectedID = id;

        if(id == this.getDefaultId())
            this.onDefaultSelect();
        else
            this.onSelect(id);
    }
}

UserSelectorSettings.prototype.ClearUsers = function()
{
    var hidden = document.getElementById(this.HiddenID);
    var IDs = hidden.value.split(',');
    for(var i = 0; i < IDs.length; i++)
    {
        this.selectedID = IDs[i];
        this.removeUser(true);
    }
    this.selectedID = '-1';
    this.items = new Array();

    if(this.CountChangedCallback != null)
        this.CountChangedCallback(document.getElementById(this.HiddenID).value);
}

UserSelectorSettings.prototype.excludeUser = function(id) {
    var remId = (id != null && id != '') ? id : this.selectedID;

    if(!this.ExistsInHidden(this.HiddenID, remId))
        return;

    if(remId == null || remId == '' || remId == '-1' || remId == this.getDefaultId())
        return;

    for(var i = 0; i < this.items.length; i++) {
        if(this.items[i].id == remId) {
            this.items[i].excluded = true;
            break;
        }
    }
}

UserSelectorSettings.prototype.clearExcluded = function() {
    for(var i = 0; i < this.items.length; i++)
        this.items[i].excluded = false;
}

UserSelectorSettings.prototype.removeUser = function(second, id) {
    if(this.MaxOne && !second) {
        this.ClearUsers();
        return;
    }

    var remId = (id != null && id != '') ? id : this.selectedID;

    if(!this.ExistsInHidden(this.HiddenID, remId))
        return;

    if(remId == this.getDefaultId()) {
        //Default user
        var defaultRemoveCallback = this.onDefaultRemove();
        if(!typeof (defaultRemoveCallback) == "boolean" || !defaultRemoveCallback)
            // Return unless the callback returns true!
            return;
    }

    if(remId == null || remId == '' || remId == '-1' || remId == this.getDefaultId())
        return;

    // onRemove event
    var callbackValue = this.onRemove(remId);
    if(typeof (callbackValue) == "boolean" && !callbackValue)
        return;

    for(var i = 0; i < this.items.length; i++) {
        if(this.items[i].id == remId) {
                this.items.splice(i, 1);
                break;          
        }
    }
        // Remove div
        if(document.getElementById(this.UserSelectorDivID + remId))
            document.getElementById(this.UserSelectorDivID).removeChild(document.getElementById(this.UserSelectorDivID + remId))

        // Remove value in hidden
        var removedAt = this.RemoveFromHidden(this.HiddenID, remId);
        this.RemoveFromHidden(this.HiddenAddedID, remId);
        this.AddToHidden(this.HiddenRemovedID, remId);

        // Reset selection
        this.selectedID = '-1';
        var IDs = document.getElementById(this.HiddenID).value.split(',');
        if(IDs.length > 0)
            if(removedAt < IDs.length)
                this.selectDiv(IDs[removedAt]);
            else
                this.selectDiv(IDs[IDs.length - 1]);

        if(this.selectedID == '-1')
        // unselect event if no div is selected now
            this.onUnselect();

        // Empty?
        if(document.getElementById(this.UserSelectorDivID).childNodes.length == 0)
            this.setNoneSelected();

        if(second != true && this.CountChangedCallback != null)
            this.CountChangedCallback(document.getElementById(this.HiddenID).value);
}

UserSelectorSettings.prototype.setNoneSelected = function()
{
    var div = document.getElementById(this.UserSelectorDivID);
    div.innerHTML = '<div id="' + this.UserSelectorDivID + 'none"><span style="color:gray;">' + this.NoneSelectedText + '</span></div>';
}

UserSelectorSettings.prototype.onUnselect = function()
{
    if(this.OnUnselectScript && this.OnUnselectScript != '')
        try
        {
            eval(this.OnUnselectScript + '();');
        }
        catch(e) { }
}
UserSelectorSettings.prototype.onSelect = function(id)
{
    if(this.OnSelectScript && this.OnSelectScript != '')
        try
        {
            eval(this.OnSelectScript + '("' + id + '");');
        }
        catch(e) { }
}
UserSelectorSettings.prototype.onDefaultSelect = function()
{
    if(this.OnDefaultUserSelect && this.OnDefaultUserSelect != '')
        try
        {
            eval(this.OnDefaultUserSelect + '();');
        }
        catch(e) { }
}
UserSelectorSettings.prototype.onDefaultRemove = function()
{
    if(this.OnDefaultUserRemove && this.OnDefaultUserRemove != '')
        try
        {
            return eval(this.OnDefaultUserRemove + '();');
        }
        catch(e) { }
}
UserSelectorSettings.prototype.onRemove = function(id)
{
    if(this.OnRemoveScript && this.OnRemoveScript != '')
        try
        {
            return eval(this.OnRemoveScript + '("' + id + '");');
        }
        catch(e) { }
}

UserSelectorSettings.prototype.addLoadEvent = function(func)
{
    var oldonload = window.onload;
    if(typeof window.onload != 'function')
    {
        window.onload = func;
    } else
    {
        window.onload = function()
        {
            if(oldonload)
            {
                oldonload();
            }
            func();
        }
    }
}

UserSelectorSettings.prototype.AddToHidden = function(hiddenID, id)
{
    if(this.ExistsInHidden(hiddenID, id))
        return;

    var hidden = document.getElementById(hiddenID);
    if(hidden.value.length > 0)
        hidden.value += ',';
    hidden.value += id;
}

UserSelectorSettings.prototype.RemoveFromHidden = function(hiddenID, id)
{
    var hidden = document.getElementById(hiddenID);
    var IDs = hidden.value.split(',');
    var newIDString = '';
    var removedAt = -1;
    for(var i = 0; i < IDs.length; i++)
    {
        if(IDs[i] == '' + id)
        {
            removedAt = i;
        } else
        {
            if(newIDString.length > 0) newIDString += ',';
            newIDString += IDs[i];
        }
    }
    hidden.value = newIDString;
    return removedAt;
}

UserSelectorSettings.prototype.ExistsInHidden = function(hiddenID, id)
{
    var IDs = document.getElementById(hiddenID).value.split(',');
    for(var i = 0; i < IDs.length; i++)
        if(IDs[i].length > 0 && IDs[i] == id)
            return true;
    return false;
}

UserSelectorSettings.prototype.get_moreTextFormat = function()
{
    /// <summary>Gets "Show more" text format string.</summary>

    return this._moreTextFormat || '';
}

UserSelectorSettings.prototype.set_moreTextFormat = function(value)
{
    /// <summary>Sets "Show more" text format string.</summary>
    /// <param name="value">"Show more" text format string.</param>

    this._moreTextFormat = value;
}

UserSelectorSettings.prototype.get_uniqueID = function()
{
    /// <summary>Gets the unique identifier of this control.</summary>

    return this._uniqueID || '';
}

UserSelectorSettings.prototype.set_uniqueID = function(value)
{
    /// <summary>Sets the unique identifier of this control.</summary>
    /// <param name="value">Unique identifier of this control.</param>

    var hiddenID = this.name + '_UniqueID';
    var hidden = document.getElementById(hiddenID);

    this._uniqueID = value;

    if(!hidden)
    {
        hidden = document.createElement('input');

        hidden.id = hiddenID;
        hidden.type = 'hidden';
        hidden.value = 'Posted';

        document.forms[0].appendChild(hidden);
    }

    hidden.name = value;
}

UserSelectorSettings.prototype.showMore = function(params)
{
    /// <summary>Loads additional users/groups that are not displayed by default into the list.</summary>
    /// <param name="params">Method parameters.</param>

    if(!params) params = {};

    var i = 0;
    var ids = '';
    var link = null;
    var data = null;
    var self = this;
    var remainingItems = [];
    var callback = params.onComplete || function() { }
    var notShown = document.getElementById(this.name + '_NotShown');

    if(!this._isBusy)
    {
        if(params.amount && this.get_uniqueID())
        {
            if(this._undiscoveredItems && this._undiscoveredItems.length > 0)
            {
                for(i = 0; i < params.amount; i++)
                {
                    if(i >= this._undiscoveredItems.length)
                        break;
                    else
                        ids += (this._undiscoveredItems[i] + ',');
                }

                if(ids && ids.length)
                {
                    ids = ids.substr(0, ids.length - 1);

                    if(i < this._undiscoveredItems.length)
                    {
                        for(var j = i; j < this._undiscoveredItems.length; j++)
                            remainingItems.push(this._undiscoveredItems[j]);

                        this._undiscoveredItems = remainingItems;
                    }
                    else
                        this._undiscoveredItems = [];
                }
            }

            if(ids)
            {
                this._isBusy = true;
                link = $(notShown).select('a')[0];
                link.innerHTML = params.message;

                Dynamicweb.Ajax.doPostBack({
                    eventTarget: this.get_uniqueID(),
                    eventArgument: 'Discover:' + ids,
                    onComplete: function(transport)
                    {
                        self._isBusy = false;
                        data = transport.responseText.evalJSON();

                        if(data && data.items && data.items.length)
                        {
                            notShown.style.display = (self._undiscoveredItems.length ? '' : 'none');

                            for(i = 0; i < data.items.length; i++)
                            {
                                if(data.items[i].type == 'group')
                                    self.addGroupWithID(data.items[i].id, data.items[i].name, '', true);
                                else
                                    self.addUserWithID(data.items[i].id, data.items[i].name, true);
                            }

                            if(self._undiscoveredItems.length)
                                link.innerHTML = self.get_moreTextFormat().replace('%%', self._undiscoveredItems.length);
                        }

                        callback(data.items);
                    }
                });
            }
            else
                callback([]);
        }
        else
            callback([]);
    }
    else
        callback([]);
}

