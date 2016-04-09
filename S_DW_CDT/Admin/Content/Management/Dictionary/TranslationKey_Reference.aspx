<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TranslationKey_Reference.aspx.vb" Inherits="Dynamicweb.Admin.TranslationKey_Reference" %>

<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Translation keys" runat="server" /></title>

        <dw:ControlResources ID="ctrlResources" IncludePrototype="true"  CombineOutput="false" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/Dictionary/Dictionary.js" />
                <dw:GenericResource Url="/Admin/Content/Management/Dictionary/Dictionary.css" />
            </Items>
        </dw:ControlResources>

        <style type="text/css">
            .popup-progress
            {
	            padding-top: 150px !important;
	            height: 230px !important;
            }
        </style>

        <script type="text/javascript">

            function onEnterDown(e) {
                var code = (e.keyCode ? e.keyCode : e.which);
                if (code == 13) { //Enter keycode
                    e.preventDefault();
                    doSearch();
                    return false;
                }
            }

            function doSearch() {
                var searchText = $('SearchText').value;
                var targetTable = $('RegionsGrid');
                var targetTableColCount = 2; //targetTable.rows.item(0).cells.length;

                //Loop through table rows
                for (var rowIndex = 2; rowIndex < targetTable.rows.length - 1; rowIndex++) {
                    var rowData = '';

                    //Process data rows. (rowIndex >= 1)
                    for (var colIndex = 0; colIndex < targetTableColCount; colIndex++) {
                        var cellText = '';
                        var cell = $(targetTable.rows.item(rowIndex).cells.item(colIndex));

                        if (cell) {
                            if (colIndex == 0) cellText = cell.innerText;
                            else if (colIndex == 1) {
                                var textArea = cell.down("TextArea");
                                if (textArea) cellText = textArea.value;
                            }
                        }

                        rowData += cellText;
                    }

                    // Make search case insensitive.
                    rowData = rowData.toLowerCase();
                    searchText = searchText.toLowerCase();

                    //If search term is not found in row data then hide the row, else show
                    if (rowData.indexOf(searchText) == -1)
                        targetTable.rows.item(rowIndex).hide();
                    else
                        targetTable.rows.item(rowIndex).show();
                }
            }

            function reloadPage(clearSearch) {
                location.reload(true);
            }

            window.onbeforeunload = function (e) {
                new window.opener.Ajax.Request(window.location.pathname, {
                    method: 'post',
                    parameters: { IsAjax: true, WindowClosed: true, AreaID: <%=CurrentArea.ID%> }
                });
            };    

            function hideOverlay(){
                var o = new overlay('overlay'); 
                o.hide(); 
            };
        </script>
    </head>

    <body>
        <form id="MainForm" runat="server">
            <input type="hidden" ID="hDesignName" runat="server" value="" />
            <input type="hidden" ID="hAreaID" runat="server" value="" />

            <div class="dic_header">
                <div class="toolbar-filter" id="ToolbarFilters">
                    <input type="text" class="textInput" onkeydown="return onEnterDown(event);" id="SearchText" name="SearchText" placeholder="Search" />
                    <img alt="Search" class="submitImage" onclick="doSearch();" src="/Admin/Images/Ribbon/Icons/Small/Search.png"/>
                </div>
                <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
                    <dw:ToolbarButton ID="cmdAdd" runat="server" Image="AddDocument" Divide="None" Text="Add translation key" OnClientClick="Dictionary.TranslationKey_Reference.add();" />
	                <dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Divide="None" Text="Save" OnClientClick="Dictionary.TranslationKey_Reference.saveTranslations();" />
                    <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Image="Save" Divide="None" Text="Save and close" OnClientClick="Dictionary.TranslationKey_Reference.saveTranslations(true);" />
                    <dw:ToolbarButton ID="cmdRefresh" runat="server" Divide="None" Image="Refresh" Text="Refresh" OnClientClick="location.reload();" />
	                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="" />
	            </dw:Toolbar>
            
                <h2 class="subtitle">
                    <dw:TranslateLabel ID="lblSubtitle" Text="Translation keys available for" runat="server" /><asp:label ID="lblAreaName" Text="" runat="server"></asp:label>
	            </h2>
            </div>

            <div class="dic_content">
                <dw:Infobar runat="server" ID="dictionaryNotExists" Type="Information" Message="Create shared or design dictionary in management center first" Title="Dictionary doesn't exist" Visible="false" Action="">
                </dw:Infobar>

                <dw:List ID="lstKeys" ShowPaging="true" ShowTitle="false" Visible="false" runat="server" pagesize="25">
                </dw:List>

                <dw:EditableGrid ID="RegionsGrid" AllowMultiSelect="true" AllowAddingRows="false" AllowDeletingRows="false" ShowPaging="true" ShowTitle="true" runat="server" pagesize="10">
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="250">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="colKeyName" Width="240" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; padding-left:5px;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="400">
                            <ItemTemplate>
                                <asp:TextBox TextMode="MultiLine" Rows="4" runat="server" ID="colTranslation" Text="" CssClass="NewUIinput" Width="224px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="colScopeName" />
                                <asp:HiddenField runat="server" ID="colScope" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </dw:EditableGrid>
            </div>

            <asp:Button id="SaveButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
        </form>
        <dw:Overlay ID="overlay" Message="Please wait" runat="server"></dw:Overlay>
    </body>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
