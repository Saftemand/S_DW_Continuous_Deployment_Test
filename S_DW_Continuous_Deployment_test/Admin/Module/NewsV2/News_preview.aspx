<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="News_preview.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsV2.News_preview" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <style type="text/css">
        #breadcrumb
        {
            border-bottom: #9faec2 1px solid;
            line-height: 18px;
            background-color: #ffffff;
            padding-left: 10px;
            display: inherit;
            height: 20px;
            vertical-align: middle;
        }
    </style>
    <script type="text/javascript">
     function help() {
		   <%=Gui.Help("newsv2", "modules.newsv2.preview")%>
        }
     function doClose() {
            window.close();
        }
    </script>
</head>
<body>
    <form id="form2" runat="server">
    <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
        <dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" Image="Cancel"
            Text="Close" OnClientClick="doClose();">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="None" Image="Help" Text="Help"
            OnClientClick="help();">
        </dw:ToolbarButton>
    </dw:Toolbar>
    <div id="breadcrumb">
        <asp:Literal ID="Breadcrumb" runat="server"></asp:Literal>
    </div>
    <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="document"
        runat="server">
        <div>
            <% = Me.Output%>
        </div>
    </dw:StretchedContainer>
    </form>
</body>
</html>
