<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AlertEmailSettings.aspx.vb" Inherits="Dynamicweb.Admin.AlertEmailSettings" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Management/SearchEngine/List.css" />
        </Items>
    </dw:ControlResources>
        <style type="text/css">
        html, body
        {
            background-color: #f0f0f0;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dw:GroupBox ID="gbEmailSettings" Title="Alert e-mail settings" runat="server">
            <table>
                <tr>
                    <td style="width: 170px; vertical-align: top;">
                        <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Send To:"/>
                    </td>
                    <td>
                        <omc:EditableListBox id="recipientsList" runat="server" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 170px">
                        <dw:TranslateLabel ID="TranslateLabel11" Text="Mails should be sent out:" runat="server" />
                    </td>
                    <td>
                        <dw:RadioButton ID="rbUpdateFailed" runat="server" FieldName="SendParams" FieldValue="1" />
                        <dw:TranslateLabel id="TranslateLabel9" Text="Only if updating process is failed" runat="server" /><br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 170px">
                    </td>
                    <td>
                        <dw:RadioButton ID="rbSendAlways" runat="server" FieldName="SendParams" FieldValue="2"/>
                        <dw:TranslateLabel id="TranslateLabel10" Text="After each updating process" runat="server" /><br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 170px">
                    </td>
                    <td style="padding-bottom:10px;">
                        <dw:RadioButton ID="rbNeverSend" runat="server" FieldName="SendParams" FieldValue="3"/>
                        <dw:TranslateLabel id="TranslateLabel2" Text="Never send" runat="server" /><br />
                    </td>
                </tr>
            </table>
        </dw:GroupBox> 
        <div style="float:right;">
           <input type="submit" id="btnSave" value="Save" runat="server" style="margin-right: 5px; font-size: 11px; width:60px;" onclick="parent.managePopUp_wnd.hide();"/>
           <input type="button" id="btnCancel"  value="Cancel" runat="server" style="margin-right: 5px; font-size: 11px; width:60px;" onclick="parent.managePopUp_wnd.hide();"/>
        </div> 
    </div>
    </form>
<%Translate.GetEditOnlineScript()%>
</body>
</html>
