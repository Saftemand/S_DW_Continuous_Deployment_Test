<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BulkEdit.aspx.vb" Inherits="Dynamicweb.Admin.BulkEdit" %>

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
    <script type="text/javascript" src="bulkEdit.js"></script>
    <style type="text/css">
        .hidden
        {
            display: none;
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
        
        .boxcell
        {
            width: 150px;
            padding-right: 5px;
        }
        
        .boxcell input
        {
            width: 140px;
        }
        
        .checkboxcell
        {
            width: 80px;
            text-align: center;
        }
        
        .linkmanagercell
        {
            width: 300px;
            white-space: nowrap;
            padding-right: 5px;
        }
        .iconcell
        {
            width: 20px;
            white-space: nowrap;
            text-align: center;
        }
        
        .namecell
        {
        }
    </style>
    <script type="text/javascript">
     function help() {
		    <%=Gui.Help("filemanager", "modules.filemanager.metadata.bulkedit")%>
	    }
        <%= js.ToString()%>
    </script>
</head>
<body>
    <dw:Infobar Message="" runat="server" Type="Information" Title="No write permissions" Action="" ID="noAccessWarning" Visible="False"></dw:Infobar>
    <form id="form1" runat="server">
    <input type="hidden" id="cmd" name="cmd" value="" />
    <input type="hidden" id="currentEdit" name="currentEdit" value="<% = Me.CurrentEditOutput %>" />
    <input type="hidden" id="summaryEdited" name="summaryEdited" value="<% = Me.SummaryEditedOutput %>" />
    <input type="hidden" id="selectedFiles" name="selectedFiles" value="" />
    <script type="text/javascript">
        if ("<%=HasSelectedFiles() %>" == "False" && opener) {
            if (opener.__page.GetSelectedFilesRow().length > 0) {
                $("cmd").value = "doRebind";
                $("selectedFiles").value = opener.__page.GetSelectedFilesRow();
                window.document.forms[0].submit();
            }
        }
    </script>
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
    <div id="breadcrumb">
        <asp:Literal ID="Breadcrumb" runat="server"></asp:Literal>
    </div>
    <dw:Infobar ID="nometadataInfo" Type="Warning" Message="No meta data fields have been created" Visible ="false" runat="server"></dw:Infobar>
    <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="document"
        runat="server">
        <dw:EditableGrid ID="Edit1" runat="server" EnableViewState="true" OnRowDataBound="Edit1_OnRowDataBound"
            DraggableColumnsMode="First" AllowSorting="true" AllowSortingRows="true" EnableSmartNavigation="True"
            AllowAddingRows="false" AllowDeletingRows="false" AllowPaging="true">
            <Columns>
                <asp:TemplateField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                    <ItemTemplate>
                        <asp:Literal ID="js" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </dw:EditableGrid>
    </dw:StretchedContainer>
    </form>    
</body>
</html>
