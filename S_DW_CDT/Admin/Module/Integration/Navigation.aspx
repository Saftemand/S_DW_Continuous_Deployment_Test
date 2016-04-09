<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Navigation.aspx.vb" Inherits="Dynamicweb.Admin.Integration.Navigation" %>

<%@ Register TagPrefix="uc1" TagName="pipelinetree" Src="pipelinetree.ascx" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script>
        function openMenu() {
            parent.Integration_Frame.cols = '220,*';
            document.all.MenuTable.style.display = '';
            document.all.MenuOpen.style.display = 'none';
        }

        function closeMenu() {
            parent.Integration_Frame.cols = '22,*';
            document.all.MenuTable.style.display = 'none';
            document.all.MenuOpen.style.display = '';
            document.getElementById('Navigation').style.display = '';
        }

        function reloadTree() {
            document.location.href = "Navigation.aspx?reload=1";
            //IntegrationNavForm.submit();
        }

    </script>
</head>
<body ms_positioning="GridLayout">
    <div id="TabFunctionMenu" class="altMenu" style="display: none;">
    </div>
    <table cellspacing="0" cellpadding="0" border="0" id="MenuOpen" background="../../images/barBackgroundVertical.gif"
        style="display: none;" height="100%" width="22">
        <tr height="3">
            <td>
            </td>
        </tr>
        <tr height="17">
            <td align="center">
                <img src="../../images/OpenTreeView_off.gif" title="Vis" onmouseover="this.src='../../images/OpenTreeView_on.gif'"
                    onmouseout="this.src='../../images/OpenTreeView_off.gif'" onmousedown="this.src='../../images/OpenTreeView_press.gif'"
                    onmouseup="this.src='../../images/OpenTreeView_on.gif'" onclick="openMenu();">
            </td>
        </tr>
        <tr id="Navigation" style="display: none;">
            <td valign="top">
                <div style="writing-mode: tb-rl">
                    &nbsp;<strong><%=Dynamicweb.Backend.Translate.Translate("Integration", 1)%></strong></div>
            </td>
        </tr>
    </table>
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <form id="mainForm" method="post" runat="server">
    <div id="tree1" style="display: ;">
        <uc1:pipelinetree ID="PipeLineTree1" runat="server"></uc1:pipelinetree>
    </div>
    </form>
    <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>
</body>
</html>
