<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Pager.ascx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.Pager" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<asp:Table runat="server" ID="PagerControlNoRecords" width="100%" height="20px" cellpadding="0" cellspacing="0">
    <asp:TableRow runat="server" VerticalAlign="Middle">
        <asp:TableCell runat="server" HorizontalAlign="Left">
            <dw:TranslateLabel ID="NoRecordsMessage" runat="server" Text="No records found" />            
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
<asp:Table runat="server" ID="PagerControl" width="100%" height="20px" cellpadding="0" cellspacing="0">
    <asp:TableRow runat="server" VerticalAlign="Middle" >
        <asp:TableCell runat="server" ID="PagerComment" HorizontalAlign="Left">
            &nbsp;
            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Show" />&nbsp;<asp:Label runat="server" ID="PagerFirstShowedRecord" />-<asp:Label runat="server" ID="PagerLastShowedRecord" />&nbsp;<dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="of" />&nbsp;<asp:Label runat="server" ID="PagerRecordsCount" />
            &nbsp;
        </asp:TableCell>
        <asp:TableCell runat="server" ID="PagerNavigate" HorizontalAlign="Right">
            <table><tr>
              <td style="width: 40px; white-space: nowrap;">
            <asp:ImageButton runat="server" ID="PagerFirstPage" ImageAlign="Middle" BorderStyle="None" ToolTip="First page"/>
            <asp:ImageButton runat="server" ID="PagerPreviousPage" ImageAlign="Middle" BorderStyle="None" ToolTip="Previous page"/>
              </td>
              <td align="center">
            &nbsp; <dw:TranslateLabel runat="server" Text="Page" /> &nbsp; <asp:Label runat="server" ID="PagerCurrentPage" /> &nbsp; <dw:TranslateLabel runat="server" Text="of" /> &nbsp; <asp:Label runat="server" ID="PagerPagesCount" /> &nbsp;
              </td>
              <td align="right" style="width: 40px; white-space: nowrap;">
            <asp:ImageButton runat="server" ID="PagerNextPage" ImageAlign="Middle" BorderStyle="None" ToolTip = "Next page"/>
            <asp:ImageButton runat="server" ID="PagerLastPage" ImageAlign="Middle" BorderStyle="None" ToolTip = "Last page"/>
              </td>
            </tr></table>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>