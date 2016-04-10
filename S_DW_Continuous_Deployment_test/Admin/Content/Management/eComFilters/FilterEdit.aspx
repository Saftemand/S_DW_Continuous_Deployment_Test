<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FilterEdit.aspx.vb" Inherits="Dynamicweb.Admin.FilterEdit" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Edit filter" runat="server" /></title>

        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" CombineOutput="false" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/images/functions.js" />
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/images/addrows.js" />
                <dw:GenericResource Url="/Admin/Filemanager/FileManager_browse2.js" />
                <dw:GenericResource Url="/Admin/Extensibility/JavaScripts/ProductsAndGroupsSelector.js" />
            </Items>
        </dw:ControlResources>
		
        <asp:Literal ID="FilterSelectorJavaScript" runat="server" />

        <script type="text/javascript">
            var langIsDefaultField;
            var filterIsNew;
            var addInParameters;

            $(document).observe('dom:loaded', function () {
                setTimeout(function () {
                    var name = document.getElementById('Name');
                    if(name) name.focus(); 
                }, 100); // for ie8-ie9 
            });

            function addInParameters_onLoaded() {
                langIsDefaultField = $("langIsDefault");
                filterIsNew = $("filterIsNew");

                // Disable filter add for not default lang
                if (langIsDefaultField.value.toLowerCase() === "false" && filterIsNew.value.toLowerCase() === "true") {
                    $("Name").disabled = true;
                }
    
                // Disable elements if lang is not default
                if (langIsDefaultField.value.toLowerCase() === "false") {
                    addInParameters = [
                        Filter_AddInTypes = $("Dynamicweb.Extensibility.Searching.eCommerce.Filter_AddInTypes"),
                        FM_Template = $("FM_Template"),
                        editImage_Template = $("editImage_Template"),
                        translateImage_Template = $("translateImage_Template"),
                        Tag_name = $("Tag_name"),
                        Field = $("Field"),
                        Values = $("Values"),
                        Applied_0 = $("Applied_0"),
                        Applied_1 = $("Applied_1"),
                        Applied_2 = $("Applied_2"),
                        Always_perform_trailing_wildcard_searches = $("Always_perform_trailing_wildcard_searches"),
                        Always_perform_leading_wildcard_searches = $("Always_perform_leading_wildcard_searches"),
                        Groups_radio_all = $("Groups_radio_all"),
                        Groups_radio_subitems = $("Groups_radio_subitems"),
                        Groups_radio_some = $("Groups_radio_some"),
                        Do_not_render_empty_options = $("Do_not_render_empty_options"),
                        Groups_list_shop = $("Groups_list_shop"),
                        From = $("From"),
                        To = $("To"),
                        Group_count = $("Group_count"),
                        Display_unlimited_option = $("Display_unlimited_option"),
                        Query_prices_with_VAT = $("Query_prices_with_VAT"),
                        Cache = $("Cache"),
                        Do_not_render_empty_options = $("Do_not_render_empty_options"),
                        _Yes__option_label = $("_Yes__option_label"),
                        _No__option_label = $("_No__option_label"),
                        Variant_group = $("Variant_group")
                    ];

                    addInParameters.forEach(function (addInParameter) {
                        if (addInParameter != null) {
                            switch (addInParameter) {
                                case editImage_Template:
                                    editImage_Template.style.visibility = 'hidden';
                                    break;
                                case translateImage_Template:
                                    translateImage_Template.style.visibility = 'hidden';
                                    break;
                                case Values:
                                    Values.select('a').invoke('hide');
                                    Values.select('input').invoke('hide');
                                    Values.getElementsByClassName('dwe-values-list')[0].addClassName('dwe-disabled');
                                    break;
                                default:
                                    addInParameter.disabled = true;
                                    break;
                            }
                        }
                    })
                }
            };

            if (parent) {
                var validated = true;
                var w = parent.Dynamicweb.Controls.PopUpWindow.current(this);

                if (w) {
                    w.add_ok(
                        function (sender, e) {
                            // Enable controls before saving to make postback
                            if (langIsDefaultField.value.toLowerCase() === "false" && filterIsNew.value.toLowerCase() === "false") {
                                addInParameters.forEach(function (addInParameter) {
                                    if (addInParameter != null) {
                                        addInParameter.disabled = false;
                                    }
                                })
                            }

                            if (!(langIsDefaultField.value.toLowerCase() === "false" && filterIsNew.value.toLowerCase() === "true")) {
                                e.set_cancel(true);
                                document.getElementById("Form1").submit();
                            }
                        }
                    );
                }
            }
        </script>

        <style type="text/css">
            html, body
            {
                background-color: #f0f0f0;
                border-right: none !important;
            }
            
            .dw-products-groups-selector
            {
                background-color: #ffffff !important;
            }
        </style>
    </head>
    <body>
        <form id="Form1" runat="server">
            <input type="hidden" id="langIsDefault" runat="server" value="true"/>
            <input type="hidden" id="filterIsNew" runat="server" value="false"/>
        
            <asp:Literal id="TableIsBlocked" runat="server"></asp:Literal>
            <div style="width:524px; height:280px;">
                <de:AddInSelector id="selector" runat="server" AddInGroupName="Filters" UseLabelAsName="True" AddInShowNothingSelected="false" AddInTypeName="Dynamicweb.Extensibility.Searching.eCommerce.Filter"/>
            </div>  
        
        </form>
    </body>

    <asp:Literal ID="FilterSelectorLoadParameters" runat="server" />
    <%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
        %>
</html>
