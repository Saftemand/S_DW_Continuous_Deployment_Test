<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.CustomFields.CustomFieldEdit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.eCommerce.UserPermissions" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Custom fields</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
    
    <script type="text/javascript" src="CustomField.js"></script>
    <script type="text/javascript" language="javascript">
        var txtSysNotUnique = '<%=Translate.JsTranslate("Some system names are not unique, missing or invalid. Make sure the name conforms to the naming convention.") %>';
        var helpLang = "<%=helpLang %>";
        var optionsDataTypeID = "<%=OptionsDataType.clientID %>";
        var typesWithOptions = <%=typesWithOptions %>;
        var optionRowValues = new Array;
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dw:Toolbar ID="CustomFieldToolbar" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" Image="Save" Text="Save" OnClientClick="save();">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="cancel()">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <h2 class="subtitle">
            <asp:Label ID="CustomFieldModule" runat="server" />
        </h2>
        
        <dw:GroupBox runat="server" Title="Custom Fields" DoTranslation="true">
            <table>
                <tr>
	                <td style="width: 600px; border: 1px solid #6593CF;">
                        <dw:EditableGrid ID="CustomFieldsList" runat="server" EnableViewState="true" Width="592px" clientidmode="AutoID">
                            <Columns>
                                <asp:TemplateField ControlStyle-Width="195px" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="CustomFieldName" runat="server" CssClass="NewUIinput" style="margin-left: 2px;" />
                                        <asp:HiddenField runat="server" ID="CustomFieldSettings" Value="" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="195px" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="CustomFieldSystemNameText" runat="server" CssClass="NewUIinput" style="margin-left: 2px;" />
                                        <asp:HiddenField ID="CustomFieldSystemName" runat="server" Value="" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="179px" >
                                    <ItemTemplate>
                                        <asp:DropDownList ID="CustomFieldTypeDrop" Visible="true" runat="server" CssClass="NewUIinput" style="margin-left: 2px;" />
                                        <asp:TextBox ID="CustomFieldTypeText" Visible="false" runat="server" CssClass="NewUIinput" style="margin-left: 2px;" />
                                        <asp:HiddenField ID="CustomFieldType" Value="" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="17px">
                                    <ItemTemplate>
                                        <div style="background-position: center; cursor: move; width: 16px; background-image: url(/Admin/Images/Icons/Page_sort.gif)">&nbsp;
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="17px">
                                    <ItemTemplate>
                                        <div id="buttons" style=" width: 16px;">
                                            <img alt="<%=Translate.JsTranslate("Slet") %>" src="/Admin/images/Delete_small.gif" onclick="javascript:deleteSelectedRowFields(this);" style="cursor: pointer;" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </dw:EditableGrid>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
    </div>
    
    <div id="options" style="display: none;">
        <dw:GroupBox runat="server" Title="Options">
	        <table cellpadding="1" cellspacing="1">        
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div style="display: inline;"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Data type" /></div>
			        </td>
			        <td>
			            <asp:DropDownList runat="server" ID="OptionsDataType" CssClass="NewUIinput"></asp:DropDownList>
			        </td>
		        </tr>			    
                <tr>
	                <td style="width: 592px; border: 1px solid #6593CF;" colspan="2">
                        <dw:EditableGrid ID="CustomFieldOptions" runat="server" EnableViewState="true" Width="592px" DraggableColumnsMode="First" EnableSmartNavigation="false" clientidmode="AutoID">
                            <Columns>
                                <asp:TemplateField ControlStyle-Width="19px" >
                                    <ItemTemplate>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="275px" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="CustomFieldOptionKey" runat="server" CssClass="NewUIinput" style="margin-left: 2px;" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="275px" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="CustomFieldOptionValue" runat="server" CssClass="NewUIinput" style="margin-left: 2px;" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="17px">
                                    <ItemTemplate>
                                        <div id="buttons" style="visibility: hidden; width: 16px;">
                                            <img alt="<%=Translate.JsTranslate("Slet") %>" src="/Admin/images/Delete_small.gif" onclick="javascript:deleteSelectedRowOptions();" style="cursor: pointer;" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </dw:EditableGrid>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
    </div>
    
    <asp:HiddenField ID="DoSave" runat="server" Value="True" />
    <asp:HiddenField ID="TableName" runat="server" />
    <asp:HiddenField ID="DatabaseName" runat="server" />
    <asp:HiddenField ID="ModuleName" runat="server" />
    <asp:HiddenField ID="RedirectUrl" runat="server" />
    </form>
    
    <script language="javascript" type="text/javascript">
        // Set the onCompleted events
        dwGrid_CustomFieldsList.onRowAddedCompleted = function(row) {
            $("options").hide();
            var nameBox = row.findControl("CustomFieldName");
            nameBox.focus();
        };
        dwGrid_CustomFieldOptions.onRowAddedCompleted = function(row) {
            var keyBox = row.findControl("CustomFieldOptionKey");
            keyBox.focus();
            
            var rowData;
            if (optionRowValues.length > 1) {
                rowData = optionRowValues[0];
                optionRowValues = optionRowValues.slice(1);
                dwGrid_CustomFieldOptions.addRow();
            } else if (optionRowValues.length = 1) {
                rowData = optionRowValues[0];
                optionRowValues = [];
            } else {
                return;
            }
            row.findControl("CustomFieldOptionKey").value = rowData[0];
            row.findControl("CustomFieldOptionValue").value = rowData[1];
        };
    </script>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
