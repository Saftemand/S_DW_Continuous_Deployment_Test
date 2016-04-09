<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditMetaData.ascx.vb"
    Inherits="Dynamicweb.Admin.Metadata.EditMetaData" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ucm" TagName="field" Src="\Admin\Module\Metadata\UCMetaField.ascx" %>
<script type="text/javascript" src="/Admin/Module/Metadata/Metadata_page.js"></script>
<div runat="server" id="Details">
    <table border="0" cellpadding="0">
        <asp:Repeater ID="MetaFieldRepeater" runat="server">
            <ItemTemplate>
                <tr>
                    <td align="left" width="100%">
                        <ucm:field id="_metafield" runat="server" ObjectType='<%#DataBinder.Eval(Container.DataItem, "ObjectType")%>'
                            ObjectID="<%#ItemID%>" FieldID='<%#DataBinder.Eval(Container.DataItem, "FieldID")%>'>
                        </ucm:field>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</div>
