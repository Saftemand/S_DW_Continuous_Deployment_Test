<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Category_Edit.aspx.vb"
    ValidateRequest="false" Inherits="Dynamicweb.Admin.NewsLetterV3.Category_Edit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit category list</title>
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <!--[if IE]> <style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <script type="text/javascript" src="js/recipients.js"></script>
    <script type="text/javascript">

        function help() {            
		    <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.category.edit")%>
	    }
    </script>
</head>
<body>
    <div id="containerNewsletter">
        <form method="post" runat="server" id="Form1" class="formNewsletter">
        <dw:RibbonBar ID="CategoryBar" runat="server">
            <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                    <dw:RibbonBarButton ID="btnSaveCategory" Text="Save" Title="Save" Image="Save"  ShowWait="true"  WaitTimeout="1000"
                        Size="Small" runat="server" EnableServerClick="true" OnClick="Category_Save" />
                    <dw:RibbonBarButton ID="btnSaveAndCloseCategory" Text="Save and close"  ShowWait="true"  WaitTimeout="1000"
                        Image="SaveAndClose" Size="Small" runat="server" EnableServerClick="true" OnClick="Category_SaveAndClose" />
                    <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Cancel" Size="Small" runat="server"
                        EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup2" Name="Edit" runat="server">
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
            <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
                    <tr valign="top">
                        <td colspan="2">
                            <dw:GroupBoxStart runat="server" ID="Gb1" Title="Settings" />
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr runat="server" visible="false" id="TypeSelector">
                                    <td class="leftCol">
                                        <dw:TranslateLabel runat="server" Text="Type" />
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="NewsLetterCategoryEmail" runat="server" Checked="true" GroupName="NewsletterCategoryType"
                                            Text="e -mail" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:RadioButton ID="NewsLetterCategorySMS" runat="server" GroupName="NewsletterCategoryType"
                                            Text="sms" />
                                    </td>
                                </tr>                            
                                <tr>
                                    <td class="leftCol">
                                        <dw:TranslateLabel runat="server" Text="Name" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NameCat" CssClass="std" MaxLength="255" runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="NameValidator" runat="server"
                                            ErrorMessage="required" ControlToValidate="NameCat" Display="dynamic"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="UniqueNameValidator" ErrorMessage="should be unique" OnServerValidate="ValidateUniqueName" runat="server" ControlToValidate="NameCat" Display="dynamic"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="leftColHigh">
                                        <dw:TranslateLabel runat="server" Text="Description" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="DescriptionCat" CssClass="std" TextMode="MultiLine" Rows="3" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <dw:GroupBoxEnd ID="EndGb1" runat="server" />
                        </td>
                    </tr>
                </table>
            <%  Translate.GetEditOnlineScript() %>
        </form>
    </div>
</body>
</html>

