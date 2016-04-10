<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GroupList.aspx.vb" Inherits="Dynamicweb.Admin.GroupList" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Groups" runat="server" /></title>

        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" CombineOutput="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/eComFilters/GroupList.js" />
            </Items>
        </dw:ControlResources>

        <script type="text/javascript">
            document.observe('dom:loaded', function () {
                eComFilters.GroupList.initialize();
            });
        </script>

        <style type="text/css">

            .infobar .information{
                background: #DDECFF; 
                border:1px solid #00529B; 
                width: 100%;
            }

        </style>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <input type="hidden" id="PostBackAction" name="PostBackAction" value="" />

            <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
	            <dw:ToolbarButton ID="cmdAdd" runat="server" Divide="None" Image="FolderAdd" OnClientClick="if(!Toolbar.buttonIsDisabled('cmdAdd')) {{ eComFilters.GroupList.openEditDialog(-1, ''); }}" Text="Add" />
	            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="location.href = '/Admin/Content/Management/Start.aspx';" />
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="eComFilters.GroupList.help();" />
	        </dw:Toolbar>
	        <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" Text="Groups" runat="server" />
	        </h2>
            <dw:Infobar ID="infoNoIndex" Type="Warning" Message="Please configure your search index first." Visible="false" runat="server" />
            <dw:Infobar ID="infoAssortments" Type="Information" Message="Assortments are enabled. All filters groups will filter using Assortments" UseInlineStyles="false" Visible="false" runat="server" />
            <dw:List ID="lstGroups" AllowMultiSelect="true" ShowPaging="true" ShowTitle="false" runat="server" pagesize="25">
                <Columns>
                    <dw:ListColumn ID="colName" EnableSorting="true" Name="Name" Width="350" runat="server" />
                    <dw:ListColumn ID="colDefinitions" EnableSorting="true" Name="Filters" Width="100" runat="server" />
                    <dw:ListColumn ID="colRemove" ItemAlign="Center" HeaderAlign="Center" EnableSorting="false" Name="Delete" Width="100" runat="server" /> 
                </Columns>
            </dw:List>
            
            <dw:Dialog ID="dlgEditGroup" UseTabularLayout="true" Width="510" OkAction="eComFilters.GroupList.trySaveGroup();" ShowOkButton="true" ShowCancelButton="true" Title="Rediger" TranslateTitle="true" runat="server">
                <dw:GroupBox Title="Properties" runat="server">
                    <input type="hidden" id="GroupID" name="GroupID" value="" />

                    <table>
                        <tr>
                            <td style="width: 170px"><dw:TranslateLabel ID="lbName" Text="Navn" runat="server" /></td>
                            <td>
                                <input class="std" autocomplete="off" id="GroupName" name="GroupName" value="" maxlength="255" />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <div style="height: 16px; min-height: 16px; max-height: 16px; vertical-align: top; margin-top: 2px">
                                    <div id="valUnique" style="display: none; color: red">
                                        <dw:TranslateLabel ID="lbUnique" Text="Specified group already exists." runat="server" />
                                    </div>
                                    <div id="valUniqueStatus" style="display: none; color: #616161">
                                        <dw:TranslateLabel ID="lbUniqueStatus" Text="Checking the name... Please wait." runat="server" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </dw:Dialog>
            
            <dw:ContextMenu ID="cmGroup" OnClientSelectView="eComFilters.GroupList.onSelectGroupContextMenuView" runat="server">
                <dw:ContextMenuButton ID="cmdEdit" Views="SingleItem, MultipleItems" Image="FolderEdit" Text="Edit" OnClientClick="eComFilters.GroupList.openEditDialog(ContextMenu.callingID, '');" runat="server" />
                <dw:ContextMenuButton ID="cmdDelete" Views="SingleItem" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" Text="Delete" Divide="Before" OnClientClick="eComFilters.GroupList.tryDeleteGroups(ContextMenu.callingID);" runat="server" />
                <dw:ContextMenuButton ID="cmdDeleteSelected" Views="MultipleItems" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" Text="Delete selected" OnClientClick="eComFilters.GroupList.tryDeleteGroups();" runat="server" />
            </dw:ContextMenu>
            
            <span id="jsHelp" style="display: none"><%= Dynamicweb.Gui.Help("", "managementcenter.ecommerce.filters.group.list")%> </span>
            <span id="confirmDelete" style="display: none"><dw:TranslateLabel id="lbDelete" Text="Slet?" runat="server" /></span>  
        </form>
    </body>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
