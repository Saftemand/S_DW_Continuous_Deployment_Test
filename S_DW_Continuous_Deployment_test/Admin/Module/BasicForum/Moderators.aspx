<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Moderators.aspx.vb"
    Inherits="Dynamicweb.Admin.BasicForum.Moderators" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript">
            function closeDialog() {
            parent.dialog.hide('<%=dialogID %>');
        }

        if ('<%=doClose %>' == 'True')
            closeDialog();
    </script>
    <style type="text/css">
        body
        {
            border-left: 1px solid transparent;
            border-right: 1px solid transparent;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <dw:GroupBox ID="GroupBox1" runat="server" Title="Select users" DoTranslation="true">
            <div style="margin: 10px 10px 10px 10px;">
                <dw:UserSelector runat="server" ID="UserSelector" Show="Users" />
            </div>
        </dw:GroupBox>
        <div style="margin: 10px 10px 10px 10px; text-align: right;">
            <asp:Button runat="server" ID="SaveButton" UseSubmitBehavior="true" />
            <asp:Button runat="server" ID="CancelButton" UseSubmitBehavior="false" />
        </div>
    </form>
</body>
<%  Translate.GetEditOnlineScript()%>
</html>