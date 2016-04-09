<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConditionsEdit.aspx.vb" Inherits="Dynamicweb.Admin.ConditionsEdit" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Visibility options" runat="server" /></title>

        <meta http-equiv="X-UA-Compatible" content="IE=8" />

        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" CombineOutput="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/eComFilters/ConditionsEdit.js" />
                <dw:GenericResource Url="/Admin/Content/Management/eComFilters/ConditionsEdit.css" />
            </Items>
        </dw:ControlResources>

        <script type="text/javascript">
            var w = null;
            if (parent) {
                w = parent.Dynamicweb.Controls.PopUpWindow.current(this);
                
                if (w) {
                    w.add_ok(function (sender, e) {
                        e.set_cancel(true);

                        if (FieldConditionsEdit.validate()) {
                            document.getElementById('ConditionsEditForm').submit();
                        }
                    });
                }
            }

            $(document).observe('dom:loaded', function () {
                FieldConditionsEdit.setConditionsEditingIsEnabled(!document.getElementById('VisibilityRule1').checked);
            });
        </script>
    </head>
    <body>
        <form id="ConditionsEditForm" runat="server">
            <asp:HiddenField ID="fConditionsOriginal" Value="0" runat="server" />

            <dw:GroupBox ID="gbVisibility" DoTranslation="false" runat="server">
                <table border="0" style="margin: 5px">
                    <tr>
                        <td style="width: 170px" valign="top">
                            <dw:TranslateLabel ID="lbVisible" Text="Filter is visible" runat="server" />
                        </td>
                        <td>
                            <div style="font-weight: bold">
                                <dw:RadioButton ID="rbAlways" FieldValue="1" FieldName="VisibilityRule" OnClientClick="FieldConditionsEdit.setConditionsEditingIsEnabled(false);" runat="server" />
                                <label for="VisibilityRule1">
                                    <dw:TranslateLabel ID="lbAlways" Text="Always" runat="server" />
                                </label>
                            </div>
                            <div>
                                <dw:RadioButton ID="rbAny" FieldValue="2" FieldName="VisibilityRule" OnClientClick="FieldConditionsEdit.setConditionsEditingIsEnabled(true);" runat="server" />
                                <label for="VisibilityRule2">
                                    <dw:TranslateLabel ID="lbAnyApply" Text="When satisfies any condition" runat="server" />
                                </label>
                            </div>
                            <div>
                                <dw:RadioButton ID="rbAll" FieldValue="3" FieldName="VisibilityRule" OnClientClick="FieldConditionsEdit.setConditionsEditingIsEnabled(true);" runat="server" />
                                <label for="VisibilityRule3">
                                    <dw:TranslateLabel ID="lbAllApply" Text="When satisfies all conditions" runat="server" />
                                </label>
                            </div>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <br />
            <dw:GroupBox ID="gbConditions" Title="Conditions" runat="server">
                <table border="0" style="margin: 5px">
                    <tr>
                        <td>
                            <div class="grid-container">
                                <div id="divGridDisabled" class="grid-disabled-overlay" style="display: block"></div>
                                <dw:EditableGrid ID="conditionsGrid" AllowAddingRows="true" AddNewRowMessage="Click here to add new condition..." 
                                    NoRowsMessage="No conditions found" AllowDeletingRows="false" AllowSortingRows="false" runat="server">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Filter" HeaderStyle-Width="180">
                                            <ItemTemplate>
                                                <asp:Literal ID="litFilters" runat="server" />
                                                <asp:HiddenField ID="fDropDownName" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Value" HeaderStyle-Width="200">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txValue" CssClass="std" Width="200" onkeypress="FieldConditionsEdit.onEditConditionValue" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="75">
                                            <ItemTemplate>
                                                <span style="margin-left: 10px">
                                                    <a href="javascript:void(0);" onclick="FieldConditionsEdit.deleteRow(this);">
                                                        <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" border="0" />
                                                    </a>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </dw:EditableGrid>
                            </div>
                        </td>
                    </tr>
                    <tr><td><dw:TranslateLabel ID="lbvaluecondition" Text="Hint: Use the ID of the specific item as value for the condition" runat="server" /></td></tr>
                </table>
            </dw:GroupBox>

            <span style="display: none" id="spDeleteCondition"><dw:TranslateLabel ID="lbDeleteRow" Text="Are you sure you want to delete this condition ?" runat="server" /></span>
            <span style="display: none" id="spResetConditions"><dw:TranslateLabel ID="lbResetConditions" Text="All conditions will be deleted. Continue ?" runat="server" /></span>
            <span style="display: none" id="spSpecifyConditions"><dw:TranslateLabel id="lbSpecifyConditions" Text="Please specify at least one condition." runat="server" /></span>

        </form>

        <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </body>
</html>
