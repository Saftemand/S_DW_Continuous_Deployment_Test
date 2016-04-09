<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="EditAutomation.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Automations.EditAutomation" %>

<%@ Import Namespace="Dynamicweb.Backend.Translate" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function Validate() {
            var txtNameID = '<%=Me.txtName.ClientID%>';
            if (document.getElementById(txtNameID).value.trim() == "") {
                alert('<%= JsTranslate("Name should not be empty")%>');
                document.getElementById(txtNameID).focus();
                return false;
            }
            else {
                return true;
            }
        }

        function save() {
            if (Validate())
                document.getElementById('cmdSave').click();
        }

        function saveAndClose() {
            if (Validate())
                document.getElementById('cmdSaveAndClose').click();
        }

        function close() {
            document.getElementById('cmdClose').click();
        }

        function showEditTriggerDialog() {
            var title = '<%= JsTranslate("Edit trigger")%>';
            parent.OMC.MasterPage.get_current().showDialog('/Admin/Module/OMC/Automations/PopupEditTrigger.aspx', 550, 250, { title: title, hideCancelButton: true });
        }

        function showEditActionDialog(actionIndex) {
            var title = '<%= JsTranslate("Edit action")%>';
            parent.OMC.MasterPage.get_current().showDialog('/Admin/Module/OMC/Automations/PopupEditAction.aspx?ActionIndex=' + actionIndex, 550, 400, { title: title, hideCancelButton: true });
        }

        function reloadPage() {
            document.getElementById('cmdPostbackNoSave').click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dw:GroupBox runat="server" ID="grpInformation" Title="General">
        <table>
            <tr>
                <td style="width: 170px;"><dw:TranslateLabel runat="server" Text="Name" /></td>
                <td><asp:TextBox runat="server" ID="txtName" CssClass="std" /></td>
            </tr>
        </table>
    </dw:GroupBox>
    <dw:GroupBox runat="server" ID="grpTrigger" Title="Trigger">
        <table>
            <tr>
                <td style="width: 170px;"><dw:TranslateLabel runat="server" Text="Select trigger" /></td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlTriggers" CssClass="std" AutoPostBack="true" /><br />
                    <asp:Label runat="server" ID="lblDescription" />
                </td>
            </tr>
        </table>
    </dw:GroupBox>
    <dw:GroupBox runat="server" ID="grpActions" Title="Actions">
        <dw:List runat="server" ID="lstActions" NoItemsMessage="No actions found" ShowTitle="false">
            <Columns>
                <dw:ListColumn runat="server" ID="clmNumber" Name="Number" Width="75" />
                <dw:ListColumn runat="server" ID="clmName" Name="Name" />
                <dw:ListColumn runat="server" ID="clmType" Name="Type" />
                <dw:ListColumn runat="server" ID="clmDelay" Name="Delay after previous" Width="125" />
            </Columns>
        </dw:List>
    </dw:GroupBox>

    <input type="submit" name="cmdSave" id="cmdSave" value="True" style="display: none;" />
    <input type="submit" name="cmdSaveAndClose" id="cmdSaveAndClose" value="True" style="display: none;" />
    <input type="submit" name="cmdClose" id="cmdClose" value="True" style="display: none;" />
    <input type="submit" name="cmdPostbackNoSave" id="cmdPostbackNoSave" value="True" style="display: none;" />

</asp:Content>
