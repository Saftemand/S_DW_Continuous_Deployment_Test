<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SearchPage.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.SearchPage" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search</title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">

    function cancel() {
        $('CancelButton').click();
    }

    function search() {
        $('SearchButton').click();
    }

    function help() {
		<%=Gui.Help("newsletterv3", "modules.newsletterv3.general.search")%>
	}

    </script>
</head>
<body>
    <div id="containerNewsletter">
        <form id="Form1" runat="server" class="formNewsletter">
            <dw:Toolbar ID="SearchToolBar" runat="server" ShowStart="true" ShowEnd="false">
                <dw:ToolbarButton ID="tbCancel" runat="server" OnClientClick="cancel();" Image="Cancel" Text="Close">
                </dw:ToolbarButton>
                <dw:ToolbarButton ID="tbSearch" runat="server" OnClientClick="search();" Image="Search" Text="Search">
                </dw:ToolbarButton>
                <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Help">
                </dw:ToolbarButton>
            </dw:Toolbar>
            <div class="list">
                <table width="100%" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="title">
                            <%=GetBreadcrumb() %>
                        </td>
                    </tr>
                </table>
            </div>
            <table class="tabTable" style="border-width: 0px;width: 100%;" cellpadding="0"">
                <tr>
                    <td valign="top" align="left">
                        <dw:GroupBoxStart Title="Folders" runat="server" />
                        <table cellspacing="0" cellpadding="3" border="0" style="border-collapse: collapse;">
                            <tr>
                                <td class="checkbox">
                                    <label><asp:CheckBox runat="server" ID="FolderDrafts" />&nbsp;
                                    <dw:TranslateLabel runat="server" Text="Drafts" /></label>
                                    &nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="checkbox">
                                    <label><asp:CheckBox runat="server" ID="FolderOutbox" />&nbsp;
                                    <dw:TranslateLabel runat="server" Text="Outbox" /></label>
                                    &nbsp;&nbsp;&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="checkbox">
                                    <label><asp:CheckBox runat="server" ID="FolderSent" />&nbsp;
                                    <dw:TranslateLabel runat="server" Text="Sent items" /></label>
                                    &nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="checkbox">
                                    <label><asp:CheckBox runat="server" ID="FolderDeleted" />&nbsp;
                                    <dw:TranslateLabel runat="server" Text="Deleted items" /></label>
                                    &nbsp;&nbsp;&nbsp;
                                </td>
                            </tr>
                        </table>
                        <dw:GroupBoxEnd runat="server" />
                        <dw:GroupBoxStart runat="server" Title="Categories" />
                        <div id="NoFieldsFoundLabel" runat="server" style="padding: 10px 0px 10px 10px;">
                            <dw:TranslateLabel runat="server" Text="No fields found" />
                        </div>
                        <asp:DataList ID="CategoriesDataList" runat="server" RepeatColumns="2" EnableViewState="False" CellPadding="3">
                            <ItemTemplate>
                                <label class="checkbox"><input name="CategoriesChecks" type="checkbox" <%#categorieschecked(databinder.eval(container.dataitem, "id").tostring)%>
                                    value='<%#DataBinder.Eval(Container.DataItem,"ID")%>' />
                                &nbsp;<%#DataBinder.Eval(Container.DataItem,"Name")%></label>&nbsp;&nbsp;&nbsp;
                            </ItemTemplate>
                        </asp:DataList>
                        <dw:GroupBoxEnd runat="server" />
                        <br />
                        <div style="padding-left: 10px;">
                            <label class="checkbox"><asp:CheckBox runat="server" ID="UnsubscribedCheckBox" />
                            <dw:TranslateLabel Text="Include recipients w/o subscription" ID="Trans3" runat="server" /></label>
                            <div id="divNoChecksFound" runat="Server" visible="false" enableviewstate="false">
                                <br />
                                &nbsp;<strong><dw:TranslateLabel Text="You should specify at least one category or folder" ID="dwTransNoChecksFound"
                                    runat="server" /></strong>
                            </div>
                            <br />
                            <br />
                            &nbsp;<dw:TranslateLabel Text="Search" runat="server" />
                            <asp:TextBox runat="server" ID="SearchTextBox" CssClass="std"></asp:TextBox>
                        </div>
                    </td>
                </tr>
            </table>
            <input type="button" id="CancelButton" runat="server" style="display: none" />
            <input type="button" id="SearchButton" runat="server" style="display: none" />
            <%  Translate.GetEditOnlineScript() %>
        </form>
    </div>
</body>
</html>
