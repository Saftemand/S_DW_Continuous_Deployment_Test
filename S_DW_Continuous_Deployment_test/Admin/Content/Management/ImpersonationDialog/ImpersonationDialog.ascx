<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ImpersonationDialog.ascx.vb" Inherits="Dynamicweb.Admin.ImpersonationDialog" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<dw:Dialog ID="dlgLogin" Width="450" Title="Impersonation" ShowOkButton="true" ShowCancelButton="true" ShowClose="true" runat="server">
    <table border="0" width="100%" style="table-layout: fixed">
        <tr valign="top">
            <td width="100">
                <dw:TranslateLabel ID="lbImpersonation" Text="Type" runat="server" />
            </td>
            <td>
                <asp:RadioButtonList ID="lstTypes" runat="server" />
            </td>
        </tr>
        
        <tr class="customCredentials" style="display: none" valign="top">
            <td>
                <dw:TranslateLabel ID="lbCredentials" Text="Credentials" runat="server" />
            </td>
            <td>
                <table border="0" width="100%">
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="lbUsername" Text="Username" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="ImpersonationUsername" Width="200" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="lbPassword" Text="Password" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox TextMode="Password" ID="ImpersonationPassword" Width="200" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="lbDomain" Text="Domain" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="ImpersonationDomain" Width="200" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
    <input type="hidden" class="impersonate" id="DoImpersonation" value="false" runat="server" />
</dw:Dialog>
