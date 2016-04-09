<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemListEdit.aspx.vb" Inherits="Dynamicweb.Admin.ItemListEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>
        <dw:ControlResources ID="ControlResources1" CombineOutput="false" IncludePrototype="true" IncludeScriptaculous="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
                <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
                <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
                <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" />
                <dw:GenericResource Url="/Admin/Content/Items/js/ItemListEdit.js" />
                <dw:GenericResource Url="/Admin/Content/Items/css/ItemEdit.css" />
            </Items>
        </dw:ControlResources>

    </head>
    <body>
        <form id="MainForm" enableviewstate="false" runat="server">
            <input type="hidden" id="hClose" name="Close" value="False" />
            <div id="menu" style="height: 26px">
                <dw:Toolbar ID="Toolbar1" runat="server" ShowStart="true" ShowEnd="false">
                    <dw:ToolbarButton ID="cmdSave" Image="Save" OnClientClick="Dynamicweb.Items.ItemListEdit.get_current().save();" Text="Save" runat="server" />
                    <dw:ToolbarButton ID="cmdSaveAndClose" Image="SaveAndClose" OnClientClick="Dynamicweb.Items.ItemListEdit.get_current().saveAndClose();" Text="Save and close" runat="server" />
                    <dw:ToolbarButton ID="cmdCancel" Image="Cancel" OnClientClick="Dynamicweb.Items.ItemListEdit.get_current().cancel();"  Text="Cancel" Divide="After" runat="server" />
                    <dw:ToolbarButton ID="cmdHelp" Image="Help" OnClientClick="Dynamicweb.Items.ItemListEdit.get_current().help();"  Text="Help" runat="server" />
                </dw:Toolbar>
            </div>
            <div id="content" style="top: 26px;height:470px;">
                <div id="content-inner">
                    <asp:Literal ID="litFields" runat="server" />
                </div>
            </div>
        </form>

        <dw:PopUpWindow ID="dblPageValidation" UseTabularLayout="true" AutoReload="true" Width="550" Height="400" runat="server"
            Title="Validate markup" TranslateTitle="true" ContentUrl="" AutoCenterProgress="true" ShowOkButton="true" ShowCancelButton="false" ShowClose="true" />


        <%Translate.GetEditOnlineScript()%>
    </body>
</html>

