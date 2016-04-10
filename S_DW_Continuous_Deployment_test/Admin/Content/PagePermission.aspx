<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PagePermission.aspx.vb" Inherits="Dynamicweb.Admin.PagePermission" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <dw:ControlResources runat="server" IncludePrototype="true"/>

    <script type="text/javascript">
        var pageID = <%=PageID %>;
        var areaID = <%=AreaID %>;

        function defaultUserSelected() {
            userSelected('default')
        }
        function defaultUserRemoved() {
            remove('default');
            return false;
        }
        
        function userSelected(id) {
            
            // Hide all subdivs
            var subdivs = $('PermissionDiv').getElementsByTagName('div');
            for (var i = 0; i < subdivs.length; i++)
                subdivs[i].style.display = 'none';
            
            // Do we allready have the correct subdiv?
            if ($('PermissionDiv' + id)) {
                $('PermissionDiv' + id).style.display = '';
            } else {
                // Create new div
                var newDiv = document.createElement('div');
                newDiv.id = 'PermissionDiv' + id;
                $('PermissionDiv').appendChild(newDiv);
                
                // Get by AJAX
                ajaxPermission(id);
            }
        }
    
        function ajaxPermission(id) {
            var url = 'PagePermission.aspx?ajaxID=' + id + '&time=' + new Date().getTime();
            if (pageID != 0)
                url += '&PageID=' + pageID;
            else if (areaID != 0)
                url += '&AreaID=' + areaID;
                
            var divId = 'PermissionDiv' + id;

            new Ajax.Updater(divId, url, {
                asynchronous: false,
                evalScripts: true,
                method: 'get',

                onLoading: function(request) { },
                onFailure: function(request) { },
                onComplete: function(request) { },
                onSuccess: function(request) {
                    //Add to div
                    $(divId).innerHTML = request.responseText;
                    
                    // Add to save collection
                    var idsToSave = $('idsToSave');
                    if (idsToSave.value.length > 0)
                        idsToSave.value += ',';
                    idsToSave.value += id;

                },
                onException: function(request) { }
            });
            

        }

        function unselect() {
            // Hide all subdivs
            var subdivs = $('PermissionDiv').getElementsByTagName('div');
            for (var i = 0; i < subdivs.length; i++)
                subdivs[i].style.display = 'none';
                
            // Display 'none selected' div
            $('PermissionDivNone').style.display = '';
        }

        function remove(id) {
            var canBeDeleted = $(id + 'CanBeDeleted').value == "True";

            if (!canBeDeleted) {
                //Only uncheck the checkboxes
                var accesses = new Array('Allow', 'Deny');
                var levels = new Array('Frontend', 'Backend');
                for (var i = 0; i < accesses.length; i++)
                    for (var j = 0; j < levels.length; j++)
                        if ($(id + levels[j] + accesses[i]))
                            $(id + levels[j] + accesses[i]).checked = false;
                
                //Return false to keep the user or group in the list
                return false;
            }

            // Remove the div
            try {
                $('PermissionDiv').removeChild($('PermissionDiv' + id));
            }
            catch (e) { }
            
            // Remove from save-ids
            var idsToSave = $('idsToSave');
            var ids = idsToSave.value.split(',');
            var newIdsToSave = '';
            for (i = 0; i < ids.length; i++) {
                if (ids[i] != '' + id) {
                    if (newIdsToSave.length > 0)
                        newIdsToSave += ',';
                    newIdsToSave += ids[i];
                }
            }
            idsToSave.value = newIdsToSave;
            
            return true;
        }

        function closeDialog() {
            parent.dialog.hide('<%=dialogID %>');
        }

        if ('<%=doClose %>' == 'True')
            closeDialog();


    </script>
</head>
<body>
    <form runat="server" id="PagePermissionForm">
        <asp:HiddenField runat="server" ID="idsToSave" />
        
        <table><tr><td>
        <div id="FrontendSettingsDiv">
            <dw:GroupBox runat="server" Title="Frontend settings" DoTranslation="true">
                <table id="FrontendSettingsTable">
                    <tr id="ShowInMenuRow">
                        <td style="width:170px; vertical-align:top">
                            <dw:TranslateLabel runat="server" Text="Show this page in menu" />
                        </td>
                        <td>
                            <asp:RadioButtonList runat="server" ID="ShowInMenu"></asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:170px; vertical-align:top">
                            <dw:TranslateLabel runat="server" Text="Login template" />
                        </td>
                        <td>
                            <dw:FileManager ID="PagePermissionTemplate" runat="server" Folder="Templates/Extranet" />
                        </td>
                    </tr>                    
                </table>
            </dw:GroupBox>        
        </div>
        
        <dw:GroupBox runat="server" Title="Select group(s) and user(s)" DoTranslation="true">
            <div style="margin:10px 10px 0px 10px;" >
                <dw:UserSelector runat="server" ID="UserSelector" NoneSelectedText="All users have permission" 
                    OnSelectScript="userSelected" OnUnselectScript="unselect" OnRemoveScript="remove" 
                    DisplayDefaultUser="true" DefaultUserName="Everyone" OnDefaultUserSelectScript="defaultUserSelected"
                    OnDefaultUserRemoveScript="defaultUserRemoved" HeightInRows="7" DiscoverHiddenItems="true" />
            </div>
        </dw:GroupBox>

        <dw:GroupBox runat="server" Title="Set permission" DoTranslation="true">
            <div id="PermissionDiv" style="margin:10px 10px 10px 10px; height: 80px;" >
                <div id="PermissionDivNone">
                    <span style="color:Gray"><dw:TranslateLabel runat="server" Text="No user or group is selected" /></span>
                </div>
            </div>
        </dw:GroupBox>
        
        <div style="margin:10px 10px 10px 10px; text-align:right;" >
            <asp:Button runat="server" id="SaveButton" UseSubmitBehavior="true" />
            <asp:Button runat="server" id="CancelButton" UseSubmitBehavior="false" />
        </div>
        </td></tr></table>
    </form>
    
    <script type="text/javascript">
        UserSelectorUserSelector.selectDefaultDiv();

        if (pageID == 0) {
            // Hide page specific controls
            var table = document.getElementById('FrontendSettingsTable');
            var tableBody = table.tBodies[0];
            tableBody.removeChild(document.getElementById('ShowInMenuRow'));
        }
        
        $('FrontendSettingsDiv').style.display = '<%=hasFrontendLicense %>' == 'True' ? 'block' : 'none';
    </script>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>