<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinkDetails.aspx.vb" Inherits="Dynamicweb.Admin.LinkDetails" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="True" runat="server" />
</head>
<body style="height: auto">
    <form id="frmLinkDetails" runat="server">
        <dw:Infobar ID="infoBar" runat="server" Visible="False">
        </dw:Infobar>
        <dw:GroupBox ID="grbLinkInfo" runat="server" Title="Link Info" DoTranslation="True">
            <div style="text-align: left; float: left;">
                <dw:Label ID="lblLinkUrl" runat="server" doTranslation="False" />
            </div>
        </dw:GroupBox>
        <dw:GroupBox ID="grbRecipients" runat="server" Title="Recipients" DoTranslation="True">
            <dw:List ID="lstRecipients" runat="server" ShowHeader="True" ShowPaging="True" ShowTitle="False">
                <Columns>
                    <dw:ListColumn ID="clmRecRecipient" TranslateName="True" Name="Recipient" runat="server" HeaderAlign="Left" ItemAlign="Left" WidthPercent="40" EnableSorting="True" />
                    <dw:ListColumn ID="clmRecThisClick" TranslateName="True" Name="Clicks (this link)" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                    <dw:ListColumn ID="clmRecAllClick" TranslateName="True" Name="Clicks (all link)" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                    <dw:ListColumn ID="clmRecCart" TranslateName="True" Name="Shopping Cart" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                    <dw:ListColumn ID="clmRecOrder" TranslateName="True" Name="Order" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                    <dw:ListColumn ID="clmRecUnsub" TranslateName="True" Name="Unsubscribed" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                </Columns>
            </dw:List>
        </dw:GroupBox>
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
