<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QueryPublisher_edit.aspx.vb" Inherits="Dynamicweb.Admin.QueryPublisher.QueryPublisher_edit" %>

<%@ Import Namespace="Dynamicweb.Backend" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<link href="/Admin/Module/Common/Stylesheet_ParSet.css" rel="stylesheet" type="text/css" />

<dw:ModuleHeader ID="headerModule" runat="server" ModuleSystemName="QueryPublisher" />
<input type="hidden" name="QueryPublisher_settings" value="Query,Facets,Template,PageSize" />

<dw:GroupBox ID="grpQuerySelector" Title="Queries" runat="server">
    <table>
        <tr>
            <td class="leftColHigh"><%= Translate.Translate("Query")%></td>
            <td>
                <select id="ddlQuerySelect" name="Query" class="std" onchange="loadFacetSelector();">
                    <asp:literal id="litQueryOptions" runat="server"></asp:literal>
                </select>
            </td>
        </tr>
        <tr>
            <td class="leftColHigh"><%= Translate.Translate("Facets")%></td>
            <td id="selectionBoxContainer">
                <dw:SelectionBox runat="server"
                                 ID="selectFacets" />
            </td>
            <input type="hidden" id="facets" name="Facets" value="" />
        </tr>
        <tr>
            <td><%=Translate.Translate("Items per page")%></td>
            <td>
                <input type="text" runat="server" id="PageSize" name="PageSize" value="0" class="std" style="width: 50px;" />
            </td>
        </tr>
    </table>
</dw:GroupBox>

<dw:GroupBox ID="grpTemplateSelector" Title="Template" runat="server">
    <table>
        <tr>
            <td class="leftColHigh"><%= Translate.Translate("Template")%></td>
            <td>
                <dw:FileManager ID="Template" Folder="/Templates/QueryPublisher" FullPath="True" runat="server" />
            </td>
        </tr>
    </table>
</dw:GroupBox>

<script type="text/javascript">
    function loadFacetSelector() {
        var querySelector = document.getElementById("ddlQuerySelect");
        var query = querySelector[querySelector.selectedIndex];
        var url = "/Admin/Module/QueryPublisher/QueryPublisher_edit.aspx?cmd=SelectionBox&query=" + encodeURIComponent(query.value);

        new Ajax.Request(url, {
            method: 'get',
            onSuccess: function (response) {
                document.getElementById("selectionBoxContainer").innerHTML = response.responseText;
                SelectionBox.setNoDataLeft("selectFacets");
                SelectionBox.setNoDataRight("selectFacets");
                serializeFacets();
            }
        });
    }

    function serializeFacets() {
        var facets = SelectionBox.getElementsRightAsArray("selectFacets");
        var values = "";

        for (var i = 0; i < facets.length; i++) {
            if (i > 0)
                values += ",";
            values += facets[i];
        }

        document.getElementById("facets").value = values;
    }

    serializeFacets();
    SelectionBox.setNoDataLeft("selectFacets");
    SelectionBox.setNoDataRight("selectFacets");
</script>