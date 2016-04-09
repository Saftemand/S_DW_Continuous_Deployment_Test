<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewLogs.aspx.vb" Inherits="Dynamicweb.Admin.ViewLogs" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html>

<html>
    <head>
        <title></title>
        <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true">
    	</dw:ControlResources>
    </head>
    <body>
        <dw:ModuleAdmin ContentFrameSrc="ViewFile.aspx" runat="server">
            <dw:Tree ID="treeFolders" runat="server" SubTitle="Folders" Title="View logs" ShowRoot="false" UseCookies="false">
                <dw:TreeNode ID="tnRoot" NodeID="0" runat="server" Name="Root" ParentID="-1" ImagePath="/Admin/Images/Ribbon/Icons/Small/home.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/home.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/home.png">
                </dw:TreeNode>
            </dw:Tree>
        </dw:ModuleAdmin>
        
        <script>
            function openLink(url) {
                var iframe = document.getElementById("ContentFrame");

                if (iframe)
                    iframe.src = url;
            }
        </script>
    </body>
</html>
