<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConfigurationOptionsEdit.aspx.vb" Inherits="Dynamicweb.Admin.ConfigurationOptionsEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript" src="metaEditor.js"></script>
    <style type="text/css">
        td:first-of-type
        {
            ;padding-left: 4px;
        }
     </style>
    <script type="text/javascript">
        function onAfterEditValue(input) {
            if (input) {
                input.value = input.value.replace(/^\s+|\s+$/g, ''); 
            }
        }

        function deleteField(link) {
            var row = dwGrid_gridFieldOptions.findContainingRow(link);
            if (row) {
                if (confirm('<%= Translate.JsTranslate("Do you want to delete this row?") %>')) {
                    dwGrid_gridFieldOptions.deleteRows([row]);
                }
            }
        }

        function help() {
		    <%=Gui.Help("filemanager", "modules.filemanager.metadata.metafields")%>
	    }

        <%= js.ToString()%>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" id="cmd" name="cmd" value="" />
    <input type="hidden" id="makeDefault" name="makeDefault" value="" />
    <div id="divToolbar">
        <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="Save" runat="server" Divide="None" Image="Save" Text="Save" 
                OnClientClick="metaEditor.save(false);">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="SaveAndClose"
                Text="Save and close" OnClientClick="metaEditor.save(true);">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" Image="Cancel"
                Text="Close" OnClientClick="metaEditor.close();">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="None" Image="Help" Text="Help"
                OnClientClick="help();">
            </dw:ToolbarButton>
        </dw:Toolbar>
    </div>
    <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="document" runat="server">
            <dw:EditableGrid runat="server" ID="gridFieldOptions" ClientIDMode="AutoID" 
            AllowAddingRows="true" AllowDeletingRows="true" AllowSortingRows="true" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="fieldValue" onblur="onAfterEditValue(this);" CssClass="NewUIinput fieldId" style="width: 100px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="fieldName" CssClass="NewUIinput" style="width: 200px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="fieldDefault" style="width: 20px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="20px" >
                        <ItemTemplate>
                            <span runat="server" id="fieldDelete">
                                <a href="javascript:void(0);" onclick="javascript:deleteField(this);">
                                    <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" title="<%= Translate.Translate("Delete")%>" border="0" />
                                </a>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </dw:EditableGrid>
    </dw:StretchedContainer>
    </form>
</body>
</html>
