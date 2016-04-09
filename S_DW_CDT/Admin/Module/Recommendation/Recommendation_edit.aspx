<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Recommendation_edit.aspx.vb" Inherits="Dynamicweb.Admin.Recommendation_edit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb" Namespace="Dynamicweb.Extensibility" TagPrefix="de" %>

<dw:ModuleSettings ID="ModuleSettings" runat="server" ModuleSystemName="Recommendation" Value="ModelId, RecommendationType, TemplateFilename, SettingsProductCatalog, NumberOfRecommendations, ProductPathLength, RenderRecommendationsCatalogSettings, RenderRecommendationsTemplate, RenderRecommendations, RenderRecommendationsInTemplate, ExcludeProductsSmartSearch" />
<dw:ModuleHeader ID="ModuleHeader" runat="server" ModuleSystemName="Recommendation" />
<link href="/Admin/Module/Common/Stylesheet_ParSet.css" rel="stylesheet" type="text/css" />
<style>
    td:first-child {
        width: 170px;
    }
</style>
<dw:GroupBox ID="TemplateSettings" runat="server" Title="Template" DoTranslation="true">
    <table>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Template" />
            </td>
            <td>
                <dw:FileManager runat="server" id="TemplateFilename" Extensions="html,cshtml" Folder="Templates/Recommendation/" FullPath="True" />
            </td>
        </tr>
        <tr class="render-recommendations">
            <td></td>
            <td>
                <label>
                    <input runat="server" type="checkbox" id="RenderRecommendationsInTemplate" value="1" />
                    <dw:TranslateLabel runat="server" Text="Render recommendations in template" />
                </label>
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Use settings from product catalog" />
            </td>
            <td>
                <dw:LinkManager runat="server" id="SettingsProductCatalog" EnablePageSelector="False" DisableFileArchive="True" />
            </td>
        </tr>
    </table>
</dw:GroupBox>
<dw:GroupBox ID="RenderingSettings" runat="server" Title="Rendering settings" DoTranslation="true">
    <table>
        <tr>
            <td></td>
            <td>
                <label>
                    <input runat="server" type="checkbox" id="RenderRecommendations" value="1" />
                    <dw:TranslateLabel runat="server" Text="Render recommendations" />
                </label>
            </td>
        </tr>
        <tr class="render-recommendations">
            <td>
                <dw:TranslateLabel runat="server" Text="Render recommendations catalog settings" />
            </td>
            <td>
                <dw:LinkManager runat="server" id="RenderRecommendationsCatalogSettings" EnablePageSelector="False" DisableFileArchive="True" />
            </td>
        </tr>
        <tr class="render-recommendations">
            <td>
                <dw:TranslateLabel runat="server" Text="Render recommendations template" />
            </td>
            <td>
                <dw:FileManager runat="server" id="RenderRecommendationsTemplate" Folder="Templates/eCom/Productlist/" FullPath="True"></dw:FileManager>
            </td>
        </tr>
    </table>
</dw:GroupBox>
<dw:GroupBox ID="ModelSettings" runat="server" Title="Model" DoTranslation="true">
    <table>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Model" />
            </td>
            <td>
                <select runat="server" id="ModelId" class="std"></select>
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Number of recommendations" />
            </td>
            <td>
                <input type="text" runat="server" id="NumberOfRecommendations" class="std" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Exclude products smart search" />
            </td>
            <td>
                <select runat="server" id="ExcludeProductsSmartSearch" class="std"></select>
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Recommendation type" />
            </td>
            <td>
                <select runat="server" id="RecommendationType" class="std"></select>
            </td>
        </tr>
        <tr class="recommendation-type-item">
            <td>
                <dw:TranslateLabel runat="server" Text="Product path type" />
            </td>
            <td>
                <select runat="server" id="ProductPathType"></select>
            </td>
        </tr>
        <tr class="recommendation-type-item">
            <td>
                <dw:TranslateLabel runat="server" Text="Product path length" />
            </td>
            <td>
                <input type="text" runat="server" id="ProductPathLength" />
            </td>
        </tr>
    </table>
</dw:GroupBox>
<script>(function () {
    var i, el, elements,

       updateUI = function () {
           var i, el = document.getElementById('RecommendationType'),
               isEnabled = el && el.value == 'Item',
               elements = document.querySelectorAll('.recommendation-type-item');
           for (i = 0; el = elements[i]; i++) {
               el.style.display = isEnabled ? 'table-row' : 'none';
           }

           el = document.getElementById('RenderRecommendations');
           isEnabled = el && el.checked;
           elements = document.querySelectorAll('.render-recommendations');
           for (i = 0; el = elements[i]; i++) {
               el.style.display = isEnabled ? 'table-row' : 'none';
           }
       };

    elements = document.querySelectorAll('#RecommendationType, #RenderRecommendations');
    for (i = 0; el = elements[i]; i++) {
        el.addEventListener('change', updateUI);
    }
    updateUI();
}())</script>
