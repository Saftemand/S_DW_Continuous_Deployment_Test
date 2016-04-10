<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Recipient_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.Recipient_Edit" ValidateRequest="false" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="cust" Namespace="Dynamicweb.Admin.ModulesCommon" Assembly="Dynamicweb.Admin" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Edit Recipient</title>
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <!--[if IE]><style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->    
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <script type="text/javascript" src="js/recipients.js"></script>
    <script type="text/javascript" >
    
    function PasswordCompare(source, arguments)
    {
        var pass1 = document.getElementById("NewsLetterRecipientPassword").value;        
        var pass2 = document.getElementById("NewsLetterRecipientPasswordConfirm").value;        
        arguments.IsValid = pass1 == pass2;
    }
    
    function UserGroupValidate(source, arguments)
    {
        var itemsCount = document.getElementById("NewsLetterRecipientUserGroup").options.length;        
        arguments.IsValid = itemsCount > 0;
        if (!arguments.IsValid)
        {
            tab(1);
        }
    }

    function tab(aciveID) {
        for (var i = 1; i < 5; i++) {
            if ($("Tab" + i)) {
                $("Tab" + i).style.display = "none";
            }
        }
        if ($("Tab" + aciveID)) {
            $("Tab" + aciveID).style.display = "";
        }
    }

    function help() {
		<%=Gui.Help("newsletterv3", "modules.newsletterv3.general.recipient.edit")%>
	}

    </script>
</head>
<body>
    <div id="containerNewsletter">
        <form id="NewsLetterRecipientEdit" runat="server" class="formNewsletter" method="post">
        <dw:RibbonBar ID="RecipientBar" runat="server">
            <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                    <dw:RibbonBarButton ID="btnSaveRecipient" Text="Save" Title="Save" Image="Save" Size="Small"
                        runat="server" EnableServerClick="true" OnClick="Recipient_Save" ShowWait="true" WaitTimeout="1000" />
                    <dw:RibbonBarButton ID="btnSaveAndCloseRecipient" Text="Save and close" Image="SaveAndClose" Size="Small"
                        runat="server" EnableServerClick="true" OnClick="Recipient_SaveAndClose" ShowWait="true" WaitTimeout="1000" />
                    <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Cancel" Size="Small" runat="server"
                        EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup5" Name="Information" runat="server">
                    <dw:RibbonBarRadioButton ID="DetailsRibbon" Text="Details" OnClientClick="tab(1);"
                        Checked="true" Group="recGroup" Image="DocumentProperties" Size="Small" runat="server" />
                    <dw:RibbonBarRadioButton ID="CategoriesRibbon" Text="Categories" OnClientClick="tab(2);"
                        Group="recGroup" Image="Folder" Size="Small" runat="server" />
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
        <dw:StretchedContainer ID="ProductEditScroll" Stretch="Fill" Scroll="Auto" Anchor="document"
            runat="server">
            <div id="containerNews1">
                <div id="Tab1">
                        <dw:GroupBoxStart runat="server" ID="DetailsStart" doTranslation="true" Title="Recipient"
                            ToolTip="Recipient" />
                        <table border="0" cellpadding="2" cellspacing="0" class="innerTable">
                            <tr>
                                <td>
                                    <table cellpadding="2" cellspacing="0" border="0">
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Type" />
                                            </td>
                                            <td>
                                                <asp:RadioButton ID="NewsLetterRecipientTypeUser" runat="server" Checked="true" GroupName="NewsletterRecipientType"
                                                    AutoPostBack="true" />
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:RadioButton ID="NewsLetterRecipientTypeGroup" runat="server" GroupName="NewsletterRecipientType"
                                                    AutoPostBack="true" />
                                            </td>
                                        </tr>
                                    </table>
                               </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="Div_User" runat="server">
                                        <table cellpadding="2" cellspacing="0" border="0">
                                            <tr>
                                                <td class="leftCol">
                                                    <dw:TranslateLabel runat="server" Text="Name" ID="TranslateLabel3" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NewsLetterRecipientName" runat="server" CssClass="std" MaxLength="255" />
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ControlToValidate="NewsLetterRecipientName" ID="NameValidator" runat="server" ErrorMessage="required" Display="Dynamic" ></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="leftCol">
                                                    <dw:TranslateLabel runat="server" Text="E-mail" ID="TranslateLabel4" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NewsLetterRecipientEMail" runat="server" CssClass="std" MaxLength="255" />
                                                </td>
                                                <td>
                                                    <cust:EmailValidator ID="EmailValidator" runat="server" ErrorMessage="incorrect email"
                                                        ControlToValidate="NewsLetterRecipientEMail" Display="Dynamic" />
                                                    <asp:RequiredFieldValidator ControlToValidate="NewsLetterRecipientEMail" ID="EMailRequiredValidator" runat="server" ErrorMessage="required" Display="Dynamic"></asp:RequiredFieldValidator>                                                    
                                                    <asp:CustomValidator ID="EMailCVUnique" runat="server" ErrorMessage="Such email is already used." Display="Dynamic" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="leftCol">
                                                    <dw:TranslateLabel runat="server" Text="Mobile" ID="TranslateLabelMobile" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NewsLetterRecipientMobile" runat="server" CssClass="std" MaxLength="20" />
                                                </td>
                                                <td>
                                                    <asp:CustomValidator ID="MobileCVRequired" runat="server" ErrorMessage="required"
                                                        Display="Dynamic" />                                                
                                                </td>
                                            </tr>                                            
                                            <tr>
                                                <td class="leftCol">
                                                    <dw:TranslateLabel runat="server" Text="Password"/>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NewsLetterRecipientPassword" runat="server" CssClass="std" MaxLength="50" TextMode="Password"  />
                                                </td>
                                                <td>
                                                    <asp:CustomValidator ID="PasswordCV" runat="server" ErrorMessage="Password fields must match." Display="Dynamic" ClientValidationFunction="PasswordCompare" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="leftCol">
                                                    <dw:TranslateLabel runat="server" Text="Retype Password"/>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="NewsLetterRecipientPasswordConfirm" runat="server" CssClass="std" MaxLength="50" TextMode=Password  />
                                                </td>
                                                <td>&nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="Div_Group" runat="server" visible="false">
                                        <table cellpadding="2" cellspacing="0" border="0">
                                            <tr>
                                                <td class="leftCol">
                                                    <dw:TranslateLabel ID="TranslateLabelUserGroup" runat="server" Text="Group" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="NewsLetterRecipientUserGroup" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:CustomValidator ID="UserGroupCV" runat="server" ErrorMessage="You can't add group, because all groups is added already."
                                                        Display="Dynamic" ClientValidationFunction="UserGroupValidate"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <dw:GroupBoxEnd runat="server" ID="DetailsEnd" />
                        <div id="Div_CustFields" runat="server">                        
                            <cust:CustomFieldsControl ID="CustFields" runat="server" LeftColumnCssClass="leftCol" Width="100%" />                        
                        </div>                      
                </div>
                <div id="Tab2" style="display: none;">
                        <dw:GroupBoxStart runat="server" ID="ListStart" doTranslation="true" Title="Categories"
                            Width="100%" ToolTip="Categories" />
                        <table border="0" cellpadding="2" cellspacing="0" class="innerTable">
                            <tr>
                                <td>
                                    <asp:GridView ID="CategoryGridView" AutoGenerateColumns="false" runat="server" BorderColor="White"
                                        CellSpacing="0" CellPadding="2" Width="100%" GridLines="None">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="150px">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="NewsletterRecipientCategoryID" CssClass="clean" Checked='<%# DataBinder.Eval(Container.DataItem, "IsSelected")%>'
                                                        runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Name")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="10px">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="GridViewHiddenID" Value='<%#DataBinder.Eval(Container.DataItem, "ID")%>'
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-Width="60px">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ListFormatGridView" runat="server">
                                                        <asp:ListItem Value="1"></asp:ListItem>
                                                        <asp:ListItem Value="2"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:Label ID="SmsLabel" runat="server" Text="sms"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="MailFormat" Visible="true"/>
                                            <asp:BoundField DataField="CategoryType" Visible="true"/>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CustomValidator ID="CategoryGridViewCV" runat="server" Display="Dynamic" ErrorMessage="At least one category should be checked." />
                                </td>
                            </tr>
                        </table>
                        <dw:GroupBoxEnd runat="server" ID="ListEnd" />                        
                </div>
            </div>
        </dw:StretchedContainer> 
            <%  Translate.GetEditOnlineScript() %>
        </form>
    </div>
</body>

</html>