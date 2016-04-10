<%@ Control Language="vb" AutoEventWireup="false" EnableViewState="false" CodeBehind="ParagraphTemplateViewer.ascx.vb" Inherits="Dynamicweb.Admin.ParagraphTemplateViewer" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<table border="0" class="chooserMain" cellspacing="0" cellpadding="0">
    <asp:Repeater ID="repRows" runat="server">
        <ItemTemplate>
            <tr valign="middle" class="chooserRow">
                <asp:Repeater ID="repColumns" runat="server">
                    <ItemTemplate>
                        <td align="center">
                            <div class="chooserItem chooserItemNormal" id="divIcon" runat="server">
                                <!-- Normal template preview icon -->
                                <img id="imgIcon" src="" alt="" border="0" runat="server" />
                                
                                <!-- Template file name to be displayed if icon rendering is failed -->
                                <div id="spIcon" class="chooserPreviewNotAvailable" runat="server" visible="false"></div>
                                
                                <!-- Template output (for large preview) -->
                                <input type="hidden" id="templateLarge" value="" runat="server" />
                            </div>
                        </td>
                    </ItemTemplate>
                </asp:Repeater> 
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    <tr id="rowNotFound" runat="server" visible="false">
        <td>
            <dw:TranslateLabel ID="lbNotFound" Text="Ikke_fundet" runat="server" />      
        </td>
    </tr>
</table>

<input type="hidden" id="SelectedTemplateID" value="" runat="server" />
<input type="hidden" id="OnTemplateSelected" value="" runat="server" />

