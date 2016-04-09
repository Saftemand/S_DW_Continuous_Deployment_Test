<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GroupFiltersOptionsEdit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.SearchFilters.GroupFiltersOptionsEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
         <meta http-equiv="X-UA-Compatible" content="IE=8" />
         
         <title></title>

         <dw:ControlResources ID="ctrlResources" CombineOutput="false" IncludeUIStylesheet="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/css/GroupFiltersOptionsEdit.css" />
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/js/GroupFiltersOptionsEdit.js" />
            </Items>
         </dw:ControlResources>

         <!--[if IE]>
         <style type="text/css">
            div.filter-options-container-outer
            {
                width: 650px !important;
            }

            div.filter-options-container
            {
                width: 645px !important;
            }
         </style>
         <![endif]-->
    </head>
    <body>
        <form id="MainForm" runat="server">
            <table border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td>
                        <div class="filter-options-selector-container">
                            <dw:GroupBox ID="gbFilter" Title="Filter" DoTranslation="true" runat="server">
                                <table border="0">
                                    <tr>
                                        <td style="width: 170px">
                                            <dw:TranslateLabel ID="lbFilter" Text="Select filter" runat="server" />
                                        </td>
                                        <td>
                                            <asp:Literal ID="litFilter" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbLimitOptions" Text="Limit options" runat="server" />
                                        </td>
                                        <td>
                                            <div id="divLimitOptions" class="checkbox-field check-limit-options" runat="server">
                                                <input type="checkbox" id="chkLimitOptions" runat="server" />
                                                <asp:Label AssociatedControlID="chkLimitOptions" runat="server">
                                                    <dw:TranslateLabel ID="lbLimitOptionsByGroup" Text="Limit options by the contents of the current group" runat="server" />
                                                </asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:TranslateLabel ID="lbMergeOptions" Text="Merge with new options" runat="server" />
                                        </td>
                                        <td>
                                            <div id="divMergeMode" class="checkbox-field check-merge-mode" runat="server">
                                                <input type="radio" id="chkMergeNone" name="OptionsMergeMode" class="merge-mode-none" runat="server" />
                                                <asp:Label AssociatedControlID="chkMergeNone" CssClass="checkbox-field-radiolabel" runat="server">
                                                    <dw:TranslateLabel ID="lbMergeNone" Text="Don't merge" runat="server" />
                                                </asp:Label>
                                                <input type="radio" id="chkMergeAppend" name="OptionsMergeMode" runat="server" />
                                                <asp:Label AssociatedControlID="chkMergeAppend" CssClass="checkbox-field-radiolabel" runat="server">
                                                    <dw:TranslateLabel ID="lbMergeAppend" Text="Append" runat="server" />
                                                </asp:Label>
                                                <input type="radio" id="chkMergePrepend" name="OptionsMergeMode" runat="server" />
                                                <asp:Label AssociatedControlID="chkMergePrepend" CssClass="checkbox-field-radiolabel" runat="server">
                                                    <dw:TranslateLabel ID="lbMergePrepend" Text="Prepend" runat="server" />
                                                </asp:Label>
                                                <input type="radio" id="chkMergeSort" name="OptionsMergeMode" runat="server" />
                                                <asp:Label AssociatedControlID="chkMergeSort" CssClass="checkbox-field-radiolabel" runat="server">
                                                    <dw:TranslateLabel ID="lbMergeSort" Text="Sort" runat="server" />
                                                </asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </dw:GroupBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:GroupBox ID="gbOptions" Title="Options" DoTranslation="true" runat="server">
                            <table border="0">
                                <tr>
                                    <td valign="top">
                                        <div class="filter-options-container-outer">
                                            <div class="filter-options-container">
                                                <div id="divNoSelected" class="filter-options-splash filter-options-notselected" runat="server">
                                                    <span><dw:TranslateLabel ID="lbFilterNotSelected" Text="No filter selected." runat="server" /></span>
                                                </div>
                                                <div id="divDefaults" class="filter-options-splash filter-options-defaults" runat="server">
                                                    <span>
                                                        <asp:Literal ID="lbFilterDefaults" runat="server" />
                                                        <span class="button-container">
                                                            <asp:Button ID="cmdEdit" Text="Edit options" CssClass="newUIbutton" runat="server" />
                                                        </span>
                                                    </span>
                                                </div>
                                                <div id="divOptions" class="filter-options-grid" runat="server">
                                                    <dw:EditableGrid ID="gridOptions" AllowAddingRows="false" 
                                                        AllowDeletingRows="true" NoRowsMessage="No options found" AllowSortingRows="true" runat="server">

                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Label" HeaderStyle-Width="300">
                                                                <ItemTemplate>
                                                                    <div style="white-space: nowrap">
                                                                        &nbsp;<asp:TextBox id="txLabel" CssClass="std" Width="200" Text='<%#Eval("Label")%>' runat="server" />
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Value" HeaderStyle-Width="300">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txValue" CssClass="std" Width="200" Text='<%#Eval("Value")%>' runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="70">
                                                                <ItemTemplate>
                                                                    <span class="filter-options-grid-delete-offset">
                                                                        <a class="filter-options-noselect" href="javascript:void(0);">
                                                                            <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" border="0" />
                                                                        </a>
                                                                    </span>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>

                                                    </dw:EditableGrid> 
                                                </div>
                                            </div>
                                            <div id="divUndoButton" class="filter-undo-button" runat="server">
                                                <asp:Button ID="cmdRestoreDefaults" Text="Restore defaults" CssClass="newUIbutton" runat="server" />
                                            </div>
                                            <div class="options-clear">&nbsp;</div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </dw:GroupBox>
                    </td>
                </tr>
            </table>

            <input type="hidden" id="optionsCustomized" name="optionsCustomized" value="false" />
            <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
        </form>
    </body>

    <script type="text/javascript">
        GroupFiltersOptionsEdit.get_current().set_groupID('<%=GroupID%>');
        GroupFiltersOptionsEdit.get_current().set_languageID('<%=LanguageID%>');
        GroupFiltersOptionsEdit.get_current().set_definitionID('<%=DefinitionID%>');
        GroupFiltersOptionsEdit.get_current().set_grid(<%=gridOptions.ClientInstanceName%>);
        GroupFiltersOptionsEdit.get_current().get_terminology()['UnsavedChangesConfirm'] = '<%=Dynamicweb.Backend.Translate.JsTranslate("All your shanges will be lost. Do you want to continue?")%>';
        GroupFiltersOptionsEdit.get_current().get_terminology()['DeleteOption'] = '<%=Dynamicweb.Backend.Translate.JsTranslate("Are you sure you want to delete option ""%%""?")%>';
        GroupFiltersOptionsEdit.get_current().get_terminology()['RestoreDefaults'] = '<%=Dynamicweb.Backend.Translate.JsTranslate("Are you sure you want to restore to default values? This operation cannot be undone.")%>';

        GroupFiltersOptionsEdit.get_current().initialize();
    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
