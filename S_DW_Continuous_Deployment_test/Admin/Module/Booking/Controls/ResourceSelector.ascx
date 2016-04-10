<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ResourceSelector.ascx.vb" Inherits="Dynamicweb.Admin.ResourceSelector" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<script type="text/javascript">
    var doShowDialog = <%=ShowDialogAtLoad.ToString().ToLower() %>;
</script>

<asp:HiddenField runat="server" ID="ReservationTypeHidden" />

<table>
    <tr>
        <td>
            <asp:HiddenField ID="Resources" runat="server" />
            <asp:ListBox ID="SelectedResources" runat="server" SelectionMode="Multiple" onclick="ResourceSelector.toggleRemoveEnabled();">
                
            </asp:ListBox>
        </td>
        <td style="vertical-align: top;">
            <img runat="server" id="IconAdd" src="/Admin/Images/Ribbon/Icons/Small/add2.png" style="cursor: pointer;" /><br />
            <img runat="server" id="IconDelete" src="/Admin/Images/Delete_Small.gif" style="cursor: pointer;" />
        </td>
    </tr>
</table>

<dw:Dialog runat="server" ID="AvailableResources" IsModal="true" ShowCancelButton="false" ShowOkButton="false" ShowHelpButton="false" Title="Available resources" TranslateTitle="true" UseTabularLayout="true" HidePadding="true" Width="650">
    <iframe id="ListFrame" style="height: 400px; width: 100%;" src=""></iframe>
</dw:Dialog>

<asp:Literal runat="server" ID="ScriptContent"></asp:Literal>