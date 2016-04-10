<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="List.aspx.vb" Inherits="Dynamicweb.Admin.RegisterModule.List6" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript" src="js/module.js"></script>
    <script type="text/javascript">
        function del(ID) {
            if (confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("modul"))%>')) {
                location = "Delete.aspx?ID=" + ID;
            }
        }
        
        function help() {
		    <%=Gui.Help("registermodule", "modules.registermodule.list")%>
	    }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="document"
        runat="server">
        <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="NewModule" runat="server" Divide="None" ImagePath="/Admin/Module/RegisterModule/img/module_new.png"
                Text="Nyt modul" OnClientClick="module.addModule();">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="None" Image="Help" Text="Help"
                OnClientClick="help();">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" Text="Moduler" runat="server" />
	        </h2>
        <dw:List ID="List1" StretchContent="true" Title="Moduler" runat="server" AllowMultiSelect="false" ShowTitle="false"
              PageSize="25">
            <Columns>
                <dw:ListColumn ID="Name" runat="server" EnableSorting="true" WidthPercent="50" Name="Navn">
                </dw:ListColumn>
                <dw:ListColumn ID="SystemName" runat="server" Name="Systemnavn" EnableSorting="true">
                </dw:ListColumn>
            </Columns>
        </dw:List>
    </dw:StretchedContainer>
    <dw:ContextMenu ID="ModulesMenu" runat="server">
        <dw:ContextMenuButton ID="EditModule" runat="server" Divide="None" ImagePath="/Admin/Module/RegisterModule/img/module_edit.png"
            Text="Edit module" OnClientClick="module.editClick();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeleteModule" runat="server" Divide="Before" ImagePath="/Admin/Module/RegisterModule/img/module_delete.png"
            Text="Delete module" OnClientClick="module.deleteClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    </form>
    <%
        Translate.GetEditOnlineScript()
    %>
</body>
</html>
