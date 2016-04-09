<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CategoryEdit.aspx.vb"
    Inherits="Dynamicweb.Admin.BasicForum.CategoryEdit1" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    
    <script type="text/javascript" language="javascript" src="js/category.js"></script>
    <script type="text/javascript" language="javascript" src="js/message.js"></script>
    
    <script type="text/javascript">
     function help() {
		    <%=Dynamicweb.Gui.Help("", "modules.dw8.forum.general.category.edit") %>
	    }
    </script>
    
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
</head>
<body>
    <form id="form1" runat="server">
    <dw:RibbonBar ID="CategoryBar" runat="server">
        <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Category" runat="server" Visible="true">
            <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                <dw:RibbonBarButton ID="btnSave" Text="Save" Title="Save" Image="Save" Size="Small" runat="server" EnableServerClick="true" OnClick="Category_Save" ShowWait="true" WaitTimeout="1000" />
                <dw:RibbonBarButton ID="btnSaveAndClose" Text="Save and close" Image="SaveAndClose" Size="Small" runat="server" EnableServerClick="true" OnClick="Category_SaveAndClose" ShowWait="true" WaitTimeout="1000"/>
                <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Cancel" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click" />
                <dw:RibbonBarButton ID="btnDelete" Text="Delete" Image="FolderDelete" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" />
            </dw:RibbonBarGroup>
            <dw:RibbonBarGroup ID="SettingsGroup" Name="Settings" runat="server">
                <dw:RibbonBarButton ID="btnModerators" Text="Moderators" Title="Moderators" 
                ImagePath="/Admin/Module/Usermanagement/Images/user_permission_32x32.png" Size="Large" runat="server"  />
            </dw:RibbonBarGroup>
            <dw:RibbonBarGroup ID="RibbonBarGroup10" Name="Help" runat="server">
                <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large" runat="server" OnClientClick="help();" />
            </dw:RibbonBarGroup>
        </dw:RibbonBarTab>
    </dw:RibbonBar>
     <div id="breadcrumb" runat="server">
	    </div>
    <dw:GroupBoxStart runat="server" ID="SettingsStart" doTranslation="true" Title="Settings"
        ToolTip="Settings" />
    <table border="0" cellpadding="2" cellspacing="0">
        <tr>
            <td width="170">
                <%=Translate.Translate("Navn")%>
            </td>
            <td>
                <asp:TextBox ID="Name" runat="server" MaxLength="250" CssClass="NewUIinput" />
                <asp:RequiredFieldValidator ID="required1" runat="server" ErrorMessage="*" ControlToValidate="Name"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <%=Translate.Translate("Beskrivelse")%>
            </td>
            <td>
                <asp:TextBox ID="Descr" runat="server" TextMode="MultiLine" Rows="6" CssClass="NewUIinput" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:CheckBox Text="Active" ID="IsActive" Checked="true" runat="server" />
            </td>
        </tr>
    </table>
    <dw:GroupBoxEnd runat="server" ID="SettingsEnd" />
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
