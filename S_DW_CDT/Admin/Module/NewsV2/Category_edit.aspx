<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Category_edit.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsV2.Category_edit" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="uc" TagName="TemplateSelector" Src="/Admin/Content/TemplateSelector/TemplateSelector.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Edit_category</title>
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <style type="text/css">
        #chkEnforceForCategory
        {
            cursor: default;
            color: #15428b;
            padding-right: 10px;
            text-decoration: none;
            height: 22px;
            display: inline-block;
        }
        #chkEnforceForCategory:hover
        {
            background: url('/Admin/images/Ribbon/BtnBg.gif' ) top right;
        }
        #chkEnforceForCategory .btnHstart
        {
            width: 2px;
            height: 22px;
            margin-right: 0px;
        }
        #chkEnforceForCategory img
        {
            border: 0px;
            padding-left: 0px;
            vertical-align: middle;
        }
    </style>
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/Common/dw7UI.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <script type="text/javascript">
        function Reload(categoryID) {
            var newwin = window.open("TreeView.aspx?categoryID=" + categoryID, "ContentCell");
            var newwin = window.open("News_list.aspx?categoryID=" + categoryID, "ListRight");
        }

        function Subm() {
            var gc = '<%=Base.chkboolean(Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent"))%>';
            if (gc == "" || gc == "False") {
                if ($('AccessUserGroups')) {
                    for (i = 0; i < $('AccessUserGroups').options.length; i++) {
                        $('AccessUserGroups').options[i].selected = true;
                    }
                }
            }
        }

        function help() {
		    <%=Gui.Help("newsv2", "modules.newsv2.general.category.edit")%>
	    }
    </script>
</head>
<body>
    <form method="post" runat="server" id="Form1" class="formNews">
    <div style="min-width: 500px; overflow: hidden;">
        <dw:RibbonBar ID="NewsBar" runat="server">
            <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                    <dw:RibbonBarButton ID="btnSaveCategory" Text="Save" Title="Save" Image="Save"
                        Size="Small" runat="server" EnableServerClick="true" OnClientClick="Subm();"
                        OnClick="Category_Save" />
                    <dw:RibbonBarButton ID="btnSaveAndCloseCategory" Text="Save and close" OnClientClick="Subm();"
                        Image="SaveAndClose" Size="Small" runat="server" EnableServerClick="true" OnClick="Category_SaveAndClose" />
                    <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Cancel" Size="Small" runat="server"
                        EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click" />
                    <dw:RibbonBarButton ID="DeleteButton" Text="Delete" ImagePath="/Admin/Module/Usermanagement/Images/folder_delete.png"
                        Size="Small" runat="server" PerformValidation="false" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="SettingsGroup" Name="Settings" runat="server">
                    <dw:RibbonBarButton ID="Permissions" Text="Permissions" Title="Permissions" ImagePath="/Admin/Module/Usermanagement/Images/user_permission_32x32.png"
                        Size="Large" runat="server"  />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup3" Name="Template" runat="server">
                    <dw:RibbonBarPanel ID="RibbonBarPanel1" runat="server">
                        <span style="height: 45px; vertical-align: top">
                            <dw:RibbonBarPanel ID="panelTemplates" runat="server">
                                <uc:TemplateSelector ID="selTemplates" Category="NewsV2" runat="server" ForceEnable="True"></uc:TemplateSelector>
                            </dw:RibbonBarPanel>
                            <dw:RibbonBarCheckbox ID="chkEnforceForCategory" Text="Enforce for this category"
                                Size="Small" runat="server" Image="Check" />
                        </span>
                    </dw:RibbonBarPanel>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup2" Name="Help" runat="server">
                    <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large"
                        runat="server" OnClientClick="help();" />
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>
        <div class="list">
            <table width="100%" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="title">
                        <%=GetBreadcrumb() %>
                    </td>
                </tr>
            </table>
        </div>
        <div id="Tab1">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr valign="top">
                    <td colspan="2">
                        <dw:GroupBoxStart runat="server" ID="Gb1" Title="Settings" />
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td class="leftCol">
                                    <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Name" />
                                </td>
                                <td>
                                    <asp:TextBox ID="NameCat" CssClass="std" MaxLength="255" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="NameValidator" runat="server" ErrorMessage="required"
                                        ControlToValidate="NameCat"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="leftColHigh">
                                    <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Description" />
                                </td>
                                <td>
                                    <asp:TextBox ID="DescriptionCat" CssClass="std" TextMode="MultiLine" Rows="3" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="leftColHigh">
                                    <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Fields group" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownGroup" CssClass="std" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <dw:GroupBoxEnd ID="EndGb1" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <% Translate.GetEditOnlineScript()%>
    </form>
</body>
</html>
