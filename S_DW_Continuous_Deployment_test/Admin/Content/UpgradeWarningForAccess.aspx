<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UpgradeWarningForAccess.aspx.vb" Inherits="Dynamicweb.Admin.UpgradeWarningForAccess" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><dw:TranslateLabel runat="server" Text="Microsoft Access - Upgrade is recommended" /></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="True" runat="server" />
    <script type="text/javascript">
        function closePopup() {                              
            if (parent.parent && parent.parent.dwtop && parent.parent.dwtop.CloseUpgradeWarning)
                parent.parent.dwtop.CloseUpgradeWarning();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">       
        <table style="table-layout: fixed; width: 100%">
            <tr>
                <td style="width:40px;"><img src="/Admin/Images/Ribbon/Icons/information.png"</td>
                <td style="word-wrap:break-word;">
                    <dw:TranslateLabel runat="server" Text="This solution is running on Microsoft Access!" /><br /><br />
                    <dw:TranslateLabel runat="server" Text="Upgrading to Microsoft SQL Server is recommended on all Dynamicweb version from 8.5  or newer." /><br /><br />
                    <dw:TranslateLabel runat="server" Text="Please contact your solution partner for details on how to upgrdae." /><br /><br />
                </td>
            </tr>
            <tr>
                <td></td><td><input type="submit" class="NewUIInput" style="display: block;margin: 0 auto;width:100px;" value="OK" /></td>
            </tr>
        </table>    
    </form>
</body>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
