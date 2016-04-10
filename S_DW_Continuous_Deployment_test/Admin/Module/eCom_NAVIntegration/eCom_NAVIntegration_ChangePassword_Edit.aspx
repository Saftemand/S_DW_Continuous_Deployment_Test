<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NAVIntegration_ChangePassword_Edit.aspx.cs" Inherits="NORRIQ.NAVIntegration_ChangePassword_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<dw:ModuleHeader ID="ModuleHeader" runat="server" ModuleSystemName="NAVIntegration_ChangePassword" />
<dw:ModuleSettings ID="ModuleSettings" Value="ShopID,PasswordTemplate,ChangedTemplate,FailedTemplate" ModuleSystemName="NAVIntegration_ChangePassword" runat="Server" />
<dw:GroupBoxStart ID="GroupBoxStart" runat="server" Title="Text" />
<table style="width: 100%;">
    <tr>
        <td colspan="2">
            Shop ID
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <select id="ShopID" name="ShopID" runat="server" size="1" class="std">
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Password template
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <dw:FileManager ID="PasswordTemplate" Folder="Templates/NAVIntegration" Name="PasswordTemplate" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Changed template
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <dw:FileManager ID="ChangedTemplate" Folder="Templates/NAVIntegration" Name="ChangedTemplate" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Failed template
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <dw:FileManager ID="FailedTemplate" Folder="Templates/NAVIntegration" Name="FailedTemplate" runat="server" />
        </td>
    </tr>
</table>
<dw:GroupBoxEnd ID="GroupBoxEnd" runat="server" />
