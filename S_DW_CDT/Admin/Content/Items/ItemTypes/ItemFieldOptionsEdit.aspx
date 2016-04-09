<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemFieldOptionsEdit.aspx.vb" Inherits="Dynamicweb.Admin.ItemFieldOptionsEdit" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Content.Items.Queries" %>
<%@ Import Namespace="Dynamicweb.Content.Items.Metadata" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="X-UA-Compatible" content="IE=8" />

        <dw:ControlResources CombineOutput="false" IncludePrototype="true" IncludeScriptaculous="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Items/js/ItemFieldOptionsEdit.js" />
                <dw:GenericResource Url="/Admin/Content/Items/css/ItemFieldOptionsEdit.css" />
            </Items>
        </dw:ControlResources>

        <%=Gui.WriteFolderManagerScript()%>
    </head>

    <body>
        <form id="MainForm" runat="server">
            <div class="content">
                <div id="form-container">
                    <div id="edit-form-0" class="source-edit-form border" style="display: none;">
                         <dw:EditableGrid ID="StaticSourceGrid" AllowAddingRows="true" AddNewRowMessage="Click here to add new option..." 
                            NoRowsMessage="No options found" AllowDeletingRows="false" AllowSortingRows="true" runat="server" >
                            <Columns>
                                <asp:TemplateField HeaderText="Label">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txLabel" CssClass="static-label" runat="server" autofocus="true" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Value">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txValue" CssClass="static-value" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Icon">
                                    <ItemTemplate>
                                        <dw:FileManager ID="txIcon" Extensions="gif,jpg,jpeg,png" Folder="System" ShowOnlyAllowedExtensions="true" FullPath="true" FixFieldName="true" runat="server"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <span style="margin-left: 10px">
                                            <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemFieldOptionsEdit.get_current().deleteRow(this);">
                                                <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" border="0" />
                                            </a>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </dw:EditableGrid>
                    </div>

                    <div id="edit-form-1" class="source-edit-form" style="display: none;">
                        <textarea class="border sql-query-string" placeholder="<%=Backend.Translate.Translate("Specify query text")%>"></textarea>
                        <div class="settings-area">
                            <div class="sql-toolbar">
                                <table>
                                    <tr>
                                        <td>
                                            <input type="button" class="sql-execute-btn" value="<%=Backend.Translate.Translate("Execute Query (Ctrl plus Enter)")%>" />
                                        </td>
                                        <td>
                                            <select class="sql-accessdb-list" style="<%=If(Not Database.IsAccess, "display: none;", "")%>">
                                                <option value=""></option>
                                            </select>   
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="border">
                                <table class="dwGrid">
                                    <tr class="header">
                                        <th scope="col"><%=Dynamicweb.Backend.Translate.Translate("Label")%></th>
                                        <th scope="col"><%=Dynamicweb.Backend.Translate.Translate("Value")%></th>
                                    </tr>
                                    <tr class="row">
                                        <td>
                                            <select class="sql-name-fields">
                                                <option value=""></option>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="sql-value-fields">
                                                <option value=""></option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>                                
                            </div>
                        </div>
                    </div>
                    
                    <div id="edit-form-2" class="source-edit-form" style="display: none;">
                        <fieldset>
                            <legend class="gbTitle"><%=Dynamicweb.Backend.Translate.JsTranslate("Settings:")%></legend>
                        <table>
                            <tr>
                                <td>
                                    <label><dw:TranslateLabel ID="TranslateLabel11" Text="Item type" runat="server" /></label>
                                </td>
                                <td>
                                     <select class="item-item-types std">
                                            <option value=""></option>
                                     </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label><dw:TranslateLabel ID="TranslateLabel12" Text="Label" runat="server" /></label>
                                </td>
                                <td>
                                     <select class="item-name-fields std">
                                            <option value=""></option>
                                     </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label><dw:TranslateLabel ID="TranslateLabel13" Text="Value" runat="server" /></label>
                                </td>
                                <td>
                                    <select class="item-value-fields std">
                                            <option value=""></option>
                                    </select>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    <label><dw:TranslateLabel ID="TranslateLabel6" Text="Select items from" runat="server" /></label>
                                </td>
                                <td>
                                    <div class="radio-field clearfix ">
                                        <label for="item-source-type-area">
                                            <input id="item-source-type-area" type="radio" name="item-source-type" value="<%=CType(Dynamicweb.Content.Items.Metadata.FieldOptionItemSourceType.Area, Integer).ToString()%>"/>
                                            <dw:TranslateLabel ID="TranslateLabel5" Text="Select items from this language / area" runat="server" />
                                        </label>
                                    </div>
                                </td>
                            </tr>
                            <tr class="space-bottom">
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <select class="item-source-areas">
                                        <option value=""></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <div class="radio-field clearfix ">
                                        <label for="item-source-type-current-area">
                                            <input id="item-source-type-current-area" type="radio" name="item-source-type" value="<%=CType(Dynamicweb.Content.Items.Metadata.FieldOptionItemSourceType.CurrentArea, Integer).ToString()%>"/>
                                            <dw:TranslateLabel ID="TranslateLabel10" Text="Select items from current website" runat="server" />
                                        </label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp; 
                                </td>
                                <td>
                                    <div class="radio-field clearfix ">
                                        <label for="item-source-type-page">
                                            <input id="item-source-type-page" type="radio" name="item-source-type" value="<%=CType(Dynamicweb.Content.Items.Metadata.FieldOptionItemSourceType.Page, Integer).ToString()%>"/>
                                            <dw:TranslateLabel ID="TranslateLabel4" Text="Select items under this page" runat="server" />
                                        </label>    
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p></p>
                                </td>
                                <td>
                                    <%=Gui.LinkManager("", "ItemTypeSourcePage", String.Empty, "0", String.Empty, False, "on", True)%>
                                </td>
                            </tr>
 
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <div class="radio-field clearfix ">
                                        <label for="item-source-type-current-page">
                                            <input id="item-source-type-current-page" type="radio" name="item-source-type" value="<%=CType(Dynamicweb.Content.Items.Metadata.FieldOptionItemSourceType.CurrentPage, Integer).ToString()%>"/>
                                            <dw:TranslateLabel ID="TranslateLabel9" Text="Select items under current page" runat="server" />
                                        </label>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <label><dw:TranslateLabel ID="TranslateLabel7" Text="Include paragraph items" runat="server" /></label>
                                </td>
                                <td>
                                    <input type="checkbox" class="item-source-paragraphs"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label><dw:TranslateLabel ID="TranslateLabel8" Text="Include all child items" runat="server" /></label>
                                </td>
                                <td>
                                    <input type="checkbox" class="item-source-childs"/>
                                </td>
                            </tr>
                        </table>
                        </fieldset>

                    </div>
                </div>
                <div id="SourceSettingsContainer" class="radio-field">
                    <fieldset>
                        <legend class="gbTitle"><%=Dynamicweb.Backend.Translate.JsTranslate("Source type")%></legend>
                        <ul id="SourceTypeList">
                            <li>
                                <label for="StaticSourceSelector">
                                    <input type="radio" id="StaticSourceSelector" name="SourceTypeSelectors" value="<%=CType(Dynamicweb.Content.Items.Metadata.FieldOptionSourceType.Static, Integer).ToString()%>" checked="checked"/>
                                    <dw:TranslateLabel ID="TranslateLabel1" Text="Static" runat="server" />
                                </label>
                            </li>
                            <li>
                                <label for="SqlSourceSelector">
                                    <input type="radio" id="SqlSourceSelector" name="SourceTypeSelectors" value="<%=CType(Dynamicweb.Content.Items.Metadata.FieldOptionSourceType.Sql, Integer).ToString()%>" />
                                    <dw:TranslateLabel ID="TranslateLabel3" Text="SQL" runat="server" />
                                </label>
                            </li>
                            <li>
                                <label for="ItemTypeSourceSelector">
                                    <input type="radio" id="ItemTypeSourceSelector" name="SourceTypeSelectors" value="<%=CType(Dynamicweb.Content.Items.Metadata.FieldOptionSourceType.ItemType, Integer).ToString()%>" />
                                    <dw:TranslateLabel ID="TranslateLabel2" Text="Item type" runat="server" />
                                </label>
                            </li>
                        </ul>
                    </fieldset>
                </div>
            </div>
            <asp:HiddenField ID="SqlSourceModel" runat="server"/>
            <asp:HiddenField ID="ItemTypeSourceModel" runat="server"/>
            <asp:HiddenField ID="PreloadData" runat="server"/>
            <asp:HiddenField ID="SourceTypeValue" runat="server"/>
        </form>

        <script type="text/javascript">
            document.observe("dom:loaded", function () {
                Dynamicweb.Items.ItemFieldOptionsEdit.get_current().get_terminology()['DeleteOption'] = '<%=Dynamicweb.Backend.Translate.JsTranslate("Are you sure you want to delete this option?")%>';
                Dynamicweb.Items.ItemFieldOptionsEdit.get_current().get_terminology()['RequestFailure'] = '<%=Dynamicweb.Backend.Translate.JsTranslate("Something went wrong. Try again.")%>';
                Dynamicweb.Items.ItemFieldOptionsEdit.get_current().get_terminology()['InvalidQuery'] = '<%=Dynamicweb.Backend.Translate.JsTranslate("Invalid query.")%>';
                Dynamicweb.Items.ItemFieldOptionsEdit.get_current().get_terminology()['ExecuteQuery'] = '<%=Dynamicweb.Backend.Translate.JsTranslate("Query string has been changed! Check and refill select boxes?")%>';
                Dynamicweb.Items.ItemFieldOptionsEdit.get_current().get_terminology()['EmptyAccessDb'] = '<%=Dynamicweb.Backend.Translate.JsTranslate("Select database!")%>';
                Dynamicweb.Items.ItemFieldOptionsEdit.get_current().set_isTranslateOnly(<%=Me.IsTranslateOnly.ToString().ToLower()%>);
                Dynamicweb.Items.ItemFieldOptionsEdit.get_current().initialize('<%=Me.ItemType%>');
            });
        </script>
        <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </body>
</html>
