<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Translation_TableHeader.ascx.vb" Inherits="Dynamicweb.Admin.Translation_TableHeader" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<tr class="keyTableHeading" valign="middle">
    <td width="200px">
        <dw:TranslateLabel ID="lbKey" Text="Key" runat="server" />
    </td>
    <td id="colLocationLowGlobal" width="30px" align="center" runat="server">
        <dw:TranslateLabel ID="lbGlobal" Text="Global" runat="server" />    
    </td>
    <td id="colLocationLowLocal" width="30px" align="center" runat="server">
        <dw:TranslateLabel ID="lbLocal" Text="Local" runat="server" />
    </td>
    <td id="colDefaultText" width="200px" align="left" runat="server">
        <nobr>
            <dw:TranslateLabel ID="lbDefaultText" Text="Default text" runat="server" />
        </nobr>
    </td>
        
    <asp:Repeater ID="repCultureHeadings" runat="server">
        <ItemTemplate>
            <td align="left" width="250px">
                <nobr>
                    <span id="spCultureWeb" runat="server">
                    </span>
                </nobr>
            </td>
        </ItemTemplate>
    </asp:Repeater>
                                    
    <td>
        &nbsp;
    </td>
</tr>
