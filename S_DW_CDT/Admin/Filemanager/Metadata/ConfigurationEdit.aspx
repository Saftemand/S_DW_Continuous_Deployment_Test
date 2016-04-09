<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConfigurationEdit.aspx.vb" Inherits="Dynamicweb.Admin.ConfigurationEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript" src="metaEditor.js"></script>
    <style type="text/css">
        body {
            border-style: none;
            border-width: 0;
        }

        #breadcrumb
        {
            border-bottom: #9faec2 1px solid;
            line-height: 18px;
            background-color: #ffffff;
            padding-left: 10px;
            display: inherit;
            height: 20px;
            vertical-align: middle;
        }
        
        td:first-of-type
        {
            padding-left: 4px;
        }
     </style>
    <script type="text/javascript">
        function onAfterEditSystemName(input) {
            if (input) {
                input.value = metaEditor.makeSystemName(input.value);
            }
        }

        function fieldTypeChange(link) {
            var row = dwGrid_gridMetaFields.findContainingRow(link);
            if(row){
                if (link.value=="list") 
                    row.findControl("fieldEdit").show();
                else
                    row.findControl("fieldEdit").hide();
            }
        }

        function editField(link) {
            var row = dwGrid_gridMetaFields.findContainingRow(link);
            if (row) {
                var width = 550;
                var height = 492;
                var options = row.findControl("fieldOptions");

                var qs = Object.toQueryString({
                    'options': encodeURIComponent(row.findControl("fieldOptions").value),
                    'caller': options.getAttribute("id")
                });

                metadata_window = window.open("/Admin/Filemanager/Metadata/ConfigurationOptionsEdit.aspx?" + qs, "", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=100 ,top=100");
                metadata_window.focus();
            }
        }

        function deleteField(link) {
            var row = dwGrid_gridMetaFields.findContainingRow(link);
            if (row) {
                if (confirm('<%= Translate.JsTranslate("Do you want to delete this row?") %>')) {
                    dwGrid_gridMetaFields.deleteRows([row]);
                }
            }
        }

        function validate()
        {
            var inputs = $$('#gridMetaFields input.fieldId[type="text"]');
            for (var i = 0; i < inputs.length; i++) {
                var currentId = inputs[i].value;
                if (currentId.match(/^[0-9]/)){
                    alert('<%= Translate.JsTranslate("Meta field id is incorrect: ") %>' + currentId);
                    return false;
                }
                for (var j = 0; j < i; j++) {
                    if (currentId == inputs[j].value){
                        alert('<%= Translate.JsTranslate("Meta field id should be unique: ") %>' + currentId);
                        return false;
                    }
                }
            }

            return true;
        }

        function help() {
		    <%=Gui.Help("filemanager", "modules.filemanager.metadata.metafields")%>
	    }
        <%= js.ToString()%>
    </script>
</head>
<body>
    <dw:Infobar Message="" runat="server" Type="Information" Title="No write permissions" Action="" ID="noAccessWarning" Visible="False"></dw:Infobar>
    <form id="form1" runat="server">
    <input type="hidden" id="cmd" name="cmd" value="" />
    <input type="hidden" id="makeDefault" name="makeDefault" value="" />
    <div id="divToolbar">
        <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="Save" runat="server" Divide="None" Image="Save" Text="Save" 
                OnClientClick="metaEditor.save(false, validate);">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="SaveAndClose"
                Text="Save and close" OnClientClick="metaEditor.save(true, validate);">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" Image="Cancel"
                Text="Close" OnClientClick="metaEditor.close();">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="None" Image="Help" Text="Help"
                OnClientClick="help();">
            </dw:ToolbarButton>
        </dw:Toolbar>
    </div>
    <div id="breadcrumb">
        <asp:Literal ID="Breadcrumb" runat="server"></asp:Literal>
    </div>
    <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="document" runat="server">
            <dw:EditableGrid runat="server" ID="gridMetaFields" ClientIDMode="AutoID" 
            AllowAddingRows="true" AllowDeletingRows="true" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="fieldId" onblur="onAfterEditSystemName(this);" CssClass="NewUIinput fieldId" style="width: 100px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="fieldLabel" CssClass="NewUIinput" style="width: 200px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <select runat="server" onchange="fieldTypeChange(this)" class="std" id="fieldEditor" style="width: 100px">
	                            <option value="text">Text</option>
	                            <option value="link">Link</option>
	                            <option value="checkbox">Checkbox</option>
	                            <option value="list">List box</option>
	                        </select>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="20px" >
                        <ItemTemplate>
                            <span runat="server" id="fieldEdit" style="display: none">
                                <a href="javascript:void(0);" onclick="javascript:editField(this);">
                                    <img src="/Admin/Images/Ribbon/Icons/Small/Edit.png" alt="" title="<%= Translate.Translate("Edit")%>" border="0" />
                                </a>
                                <input type="hidden" runat="server" id="fieldOptions" name="fieldOptions" />
                            </span>
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
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
