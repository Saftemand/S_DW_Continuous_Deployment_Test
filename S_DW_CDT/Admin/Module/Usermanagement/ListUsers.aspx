<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ListUsers.aspx.vb" Inherits="Dynamicweb.Admin.UserManagement.ListUsers" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  	<meta http-equiv="Pragma" content="no-cache" />
	<meta name="Cache-control" content="no-cache" />
	<meta http-equiv="Cache-control" content="no-cache" />
	<meta http-equiv="Expires" content="Tue, 20 Aug 1996 14:25:27 GMT" />

	<dw:ControlResources ID="ControlResources1" runat="server" />
	
	<script type="text/javascript" src="ListUsers.js"></script>
	
    <style type="text/css">
        body
        {
	        height:100%;
	        background-color:#bfdbff;
	        border-left:0px;
	        border-right:0px;
	        margin:0px;
	        padding:0px;
	        font-family: arial, verdana, Microsoft JhengHei;
	        font-size: 11px;
	        color :#333333;
        }        
        .row-ungrouped
        {
            background-color: #FFCCCC;
        }
    </style>
    <script type="text/javascript">
        var groupID = <%=GroupID %>;
        var smartSearchID = '<%=SmartSearchID %>';
        var doAddUser = '<%=DoAddUser %>' == 'True';
        
        var __context = new UserContext(groupID, smartSearchID);
        
        /* Creating new row context menu */
        var __menu = new RowContextMenu({
            menuID: 'UserContext',
            groupID: groupID,
            onSelectContext: function(row, itemID) {
                var ret = '';
                var activeCount = 0;
                var selectedRows = List.getSelectedRows('UserList');
                
                /* Determining whether the target row is part of selection (and more that one row is selected) */
                if(List.rowIsSelected(row) && selectedRows.length > 1) {
                    
                    /* Getting the number of selected rows that are active */
                    for(var i = 0; i < selectedRows.length; i++) {
                        if(selectedRows[i].readAttribute('__isactive') == 'true')
                            activeCount++;
                    }
                    
                    
                    if(activeCount == 0) {
                        /* No active rows */
                        ret = 'inactiveUserSelection';
                    } else if(activeCount == selectedRows.length) {
                        /* All rows are active */
                        ret = 'activeUserSelection';
                    } else {
                        /* Mixed mode */
                        ret = 'userSelection';
                    }
                } else {
                    /* Row is not selected (or it's the only one row which is selected) */
                    ret = row.readAttribute('__isactive') == 'true' ? 
                        'activeUser' : 'inactiveUser';
                }
                
                return ret;
            }
        });
        
        if (doAddUser) {
            __context.newUser();
        }
        
        /* "activeUser" - applied to active user */
        __menu.registerContext('activeUser', 
            [ 'cmdEditUser', 'cmdCreateCopy', 'cmdDeleteUser', 
            'cmdAttachToGroups', 'cmdDetachFromGroup', 
            'cmdDeactivateUser', 'cmdNewUser' ]);
        
        /* "inactiveUser" - applied to inactive user */
        __menu.registerContext('inactiveUser', 
            [ 'cmdEditUser', 'cmdCreateCopy', 'cmdDeleteUser',
            'cmdAttachToGroups', 'cmdDetachFromGroup',
            'cmdActivateUser', 'cmdNewUser' ]); 
        
        /* "userSelection" - applied to selected users */
        __menu.registerContext('userSelection', 
            [ 'cmdDeleteSelected', 'cmdAttachToGroups', 'cmdDetachFromGroup', 
            'cmdActivateSelected', 'cmdDeactivateSelected', 'cmdNewUser' ]);
        
        /* "activeUserSelection" - applied to selected users only when all users are active */    
        __menu.registerContext('activeUserSelection', 
            [ 'cmdDeleteSelected', 'cmdAttachToGroups', 'cmdDetachFromGroup', 
            'cmdDeactivateSelected', 'cmdNewUser' ]);
         
         /* "inactiveUserSelection" - applied to selected users only when all users are inactive */   
         __menu.registerContext('inactiveUserSelection', 
            [ 'cmdDeleteSelected', 'cmdAttachToGroups', 'cmdDetachFromGroup', 
            'cmdActivateSelected', 'cmdNewUser' ]);
        
         document.observe("dom:loaded", function() {
             parent.setContentIsVisible(true);

             if ($("AttachGroupsDialogHidden").value === "true"){
                 $("AttachGroupsDialogHidden").value = "false";
                 __context.showGroupsDialog();
             }
         });
    </script>

</head>
<body>
    <form id="UserListForm" runat="server">
    <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document"
        runat="server">

            <dw:List ID="UserList" runat="server" AllowMultiSelect="true" Title="Users" Personalize="true"
            StretchContent="true" UseCountForPaging="true"  HandlePagingManually="true">
                <Filters>
                    <dw:ListTextFilter ID="fSearch" Width="250" WaterMarkText="Search for users" Priority="1" runat="server" />
                    <dw:ListDropDownListFilter ID="fActiveState" Width="100" Label="Validity" AutoPostBack="true" Priority="3" runat="server">
                        <Items>
                            <dw:ListFilterOption Text="All" Value="None" Selected="true" />
                            <dw:ListFilterOption Text="Active" Value="True" />
                            <dw:ListFilterOption Text="Ikke_aktiv" Value="False" />
                        </Items>
                    </dw:ListDropDownListFilter>
                    <dw:ListDropDownListFilter ID="fBackendState" Width="100" Label="Backend login" AutoPostBack="true" Priority="2" runat="server" >
                        <Items>
                            <dw:ListFilterOption Text="All" Value="None" Selected="true" />
                            <dw:ListFilterOption Text="Allow" Value="True" />
                            <dw:ListFilterOption Text="Deny" Value="False" />
                        </Items>
                    </dw:ListDropDownListFilter>
                    <dw:ListDropDownListFilter ID="fUserPerPage" Width="50" Label="Users per page" AutoPostBack="true" Priority="4" runat="server">
                        <Items>
                            <dw:ListFilterOption Text="All" Value="None" />
                            <dw:ListFilterOption Text="25" Value="25" Selected="true"/>
                            <dw:ListFilterOption Text="50" Value="50"/>
                            <dw:ListFilterOption Text="100" Value="100"/>
                            <dw:ListFilterOption Text="200" value="200"/>
                        </Items>
                    </dw:ListDropDownListFilter>
                </Filters>
		    </dw:List>
    </dw:StretchedContainer>
        <dw:ContextMenu ID="UserContext" runat="server">
            <dw:ContextMenuButton ID="cmdEditUser" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_edit.png" Text="Rediger" OnClientClick="__context.editUser();" />
            <%If GroupID <> -1000 Then%>
            <dw:ContextMenuButton ID="cmdCreateCopy" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_back.png" Text="Create copy" OnClientClick="__context.newUser(true);" />
            <%End If%>
            <dw:ContextMenuButton ID="cmdActivateUser" runat="server" Divide="Before" Image="Check" Text="Activate" OnClientClick="__context.setActive(true);" />
            <dw:ContextMenuButton ID="cmdDeactivateUser" runat="server" Divide="None" Image="Delete" Text="DeActivate" OnClientClick="__context.setActive(false);" />
            <dw:ContextMenuButton ID="cmdActivateSelected" runat="server" Divide="None" Image="Check" Text="Activate selected" OnClientClick="__context.setActive(true);" />
            <dw:ContextMenuButton ID="cmdDeactivateSelected" runat="server" Divide="None" Image="Delete" Text="Deactivate selected" OnClientClick="__context.setActive(false);" />
            <dw:ContextMenuButton ID="cmdDeleteUser" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_delete.png" Text="Slet" OnClientClick="__context.deleteUser();" />
            <dw:ContextMenuButton ID="cmdDeleteSelected" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/users4_delete.png" Text="Delete_selected" OnClientClick="__context.deleteUser();" />
            <dw:ContextMenuButton ID="cmdAttachToGroups" runat="server" Divide="Before" ImagePath="/Admin/Module/Usermanagement/Images/folder_add.png" Text="Tilføj_grupper" OnClientClick="__context.showAllGroupsDialog();" />
            <%If GroupID > 0 Then%>
            <dw:ContextMenuButton ID="cmdDetachFromGroup" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/folder_delete.png" Text="Remove from group" OnClientClick="__context.detachFromGroup();" />
            <dw:ContextMenuButton ID="cmdNewUser" runat="server" Divide="Before" ImagePath="/Admin/Module/Usermanagement/Images/user1_add.png" Text="Ny_bruger" OnClientClick="__context.newUser();" />
            <%End If%>
        </dw:ContextMenu>
		
	    <dw:Contextmenu ID="GeneralContext" runat="server">
	        <dw:ContextmenuButton ID="cmdNewUserGeneral" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_add.png" Text="Ny_bruger" OnClientClick="__context.newUser();" />
	    </dw:Contextmenu>
		
		<dw:Dialog ID="AttachGroupsDialog" Title="Tilføj_grupper" Width="260" ShowOkButton="true" ShowCancelButton="true" OkAction="__context.attachToGroups();" runat="server">
		    <dw:UserSelector ID="GroupsSelector" Show="Groups" runat="server"></dw:UserSelector>
		</dw:Dialog>
        <asp:HiddenField ID="AttachGroupsDialogHidden" runat="server" />
		
	    <span id="spDeleteUser" style="display: none">
	        <dw:TranslateLabel ID="lbDeleteUser" Text="Slet_bruger?" runat="server" />
	    </span>
	    
	    <span id="spDeleteUsers" style="display: none">
	        <dw:TranslateLabel ID="lbDeleteUsers" Text="Slet_brugere?" runat="server" />
	    </span>
	    

    </form>

 <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
