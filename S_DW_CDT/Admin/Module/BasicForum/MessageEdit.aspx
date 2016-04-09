<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="MessageEdit.aspx.vb"
    Inherits="Dynamicweb.Admin.BasicForum.MessageEdit" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <style type="text/css">
        body
        {
            border-left: 1px solid transparent;
            border-right: 1px solid transparent;
        }
        #breadcrumb
        {
            height:20px;
            line-height:18px;
            border-bottom:1px solid #9FAEC2;
            display:inherit;
            vertical-align:middle;
            padding-left:10px;
            background-color:#ffffff;
        }
    </style>
    <link type="text/css" rel="STYLESHEET" href="css/messageEdit.css" />
    <script type="text/javascript" language="javascript" src="js/multiSelector.js"></script>
    <script type="text/javascript" language="javascript" src="js/messageEdit.js"></script>
    <script type="text/javascript">
     function help() {
		    <%=Dynamicweb.Gui.Help("", "modules.dw8.forum.general.post.edit") %>
	    }
    </script>

</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <dw:RibbonBar ID="MessageBar" runat="server">
        <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Post" runat="server" Visible="true">
            <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                <dw:RibbonBarButton ID="btnSave" Text="Save" Title="Save" Image="Save" Size="Small" runat="server" EnableServerClick="true" OnClick="Thread_Save" ShowWait="true" WaitTimeout="1000"/>
                <dw:RibbonBarButton ID="btnSaveAndClose" Text="Save and close" Image="SaveAndClose" Size="Small" runat="server" EnableServerClick="true" OnClick="Thread_SaveAndClose" ShowWait="true" WaitTimeout="1000"/>
                <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Cancel" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click" />
                <dw:RibbonBarButton ID="btnDelete" Text="Delete" Image="FolderDelete" Size="Small" runat="server" EnableServerClick="false" PerformValidation="false" />
            </dw:RibbonBarGroup>
            <dw:RibbonBarGroup ID="RibbonBarGroup10" Name="Help" runat="server">
                    <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large" runat="server" OnClientClick="help();" />
            </dw:RibbonBarGroup>

        </dw:RibbonBarTab>
    </dw:RibbonBar>
    <div id="breadcrumb" runat="server"></div>

    <dw:GroupBoxStart runat="server" ID="SettingsStart" doTranslation="true" Title="Settings"
        ToolTip="Settings" />
    <table border="0" cellpadding="2" cellspacing="0">
        <tr>
            <td width="170">
                <%= Translate.Translate("Heading")%>
            </td>
            <td>
                <asp:TextBox ID="Heading" runat="server" MaxLength="250" CssClass="NewUIinput" />
                <asp:RequiredFieldValidator ID="required1" runat="server" ErrorMessage="*" ControlToValidate="Heading"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <%= Translate.Translate("Author")%>
            </td>
            <td>
                <asp:TextBox ID="Author" runat="server" CssClass="NewUIinput" />
            </td>
        </tr>
        <tr>
            <td valign="top">
                <%= Translate.Translate("E-mail")%>
            </td>
            <td>
                <asp:TextBox ID="Email" runat="server" CssClass="NewUIinput" />
                <asp:RegularExpressionValidator runat="server" ID="EmailValidator" ControlToValidate="Email" ErrorMessage="Please specify a correct e-mail address." 
                ValidationExpression="([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})" />
            </td>
        </tr>
        <tr>
            <td valign="top">
                <%= Translate.Translate("Date")%>
            </td>
            <td>
                <dw:DateSelector ID="Date" runat="server" />
            </td>
        </tr>
        <tr runat="server" ID="StickyTR" Visible ="false" >
            <td>
                <asp:CheckBox Text="Sticky" ID="Sticky" Visible="true" runat="server" />
            </td>
        </tr>
        <tr runat="server" ID="ActiveTR" Visible ="false" >
            <td>
                <asp:CheckBox Text="Active" ID="IsActive" Checked="true" runat="server" />
            </td>
        </tr>
    </table>
    <dw:GroupBoxEnd runat="server" ID="SettingsEnd" />
    <dw:GroupBoxStart runat="server" ID="GroupBoxStart1" doTranslation="true" Title="Text"
        ToolTip="Settings" />
    <dw:Editor ID="Text" Height="400" runat="server" />
    <dw:GroupBoxEnd runat="server" ID="GroupBoxEnd1" />    
    <div id="CategoriesDiv" runat="server">
        <dw:GroupBoxStart runat="server" ID="CategoryGroupBoxStart" doTranslation="true" Title="Category" ToolTip="Category" />    
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td width="170">
                        <%= Translate.Translate("Select category")%>
                    </td>
                    <td>
                        <asp:DropDownList ID="CategoriesList" runat="server" CssClass="std" />
                    </td>
                </tr>
            </table>
        <dw:GroupBoxEnd runat="server" ID="CategoryGroupBoxEnd" />
    </div>
    <dw:GroupBoxStart runat="server" ID="GroupBoxStart2" doTranslation="true" Title="Attachments"
        ToolTip="Attachments" />
    <div class="forum-post-addfile">
        <span>
            <%= Translate.Translate("Select file")%>&nbsp;</span>
        <input type="file" name="Attachment" id="Attachment" class="NewUIinput" />
    </div>
    <div class="forum-post-clear">
        &nbsp;</div>
    <br />
    <div id="FilesList" style="display: none">
    </div>
    <div class="forum-post-clear">
        &nbsp;</div>
    <dw:GroupBoxEnd runat="server" ID="GroupBoxEnd2" />
    <br />
    <br />
    <%= UploadedFilesInputs.ToString()%>
    <script type="text/javascript">
        /* Create an instance of the multiSelector class, pass it the output target and the max number of files */
        var multi_selector = new MultiSelector(document.getElementById("FilesList"), -1);

        /*  Pass in the file element */
        multi_selector.addElement(document.getElementById('Attachment'));
        <%= UploadedFilesJS.ToString() %>
    </script>
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
