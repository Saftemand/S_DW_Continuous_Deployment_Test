<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Toolbar.aspx.vb" Inherits="Dynamicweb.Admin.Management.QueryAnalyzer.Toolbar" %>

<%@ Register Assembly="Dynamicweb" Namespace="Dynamicweb.Extensibility" TagPrefix="cc1" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Toolbar</title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script language="javascript" type="text/javascript">
        function SetDatabase(obj){
            if (obj.selectedIndex > 0){
                window.parent.frames["Editor"].SetDatabase(obj[obj.selectedIndex].value);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dw:Toolbar ID="Toolbar1" runat="server">
                <dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" Image="NoImage"
                    Text="Execute Query (Ctrl plus Enter)" OnClientClick="javascript:window.parent.frames['Editor'].Fetch();window.parent.frames['Editor'].editor.focus();">
                </dw:ToolbarButton>
                <dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="NoImage" Text="" OnClientClick="void(0);">
                    <asp:DropDownList ID="DropDownList1" runat="server" onchange="SetDatabase(this);" class="std" />
                </dw:ToolbarButton>
            </dw:Toolbar>
            <dw:TabHeader ID="TabHeader1" runat="server" />
        </div>
    </form>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>