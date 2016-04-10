<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VouchersCategoryEdit.aspx.vb" Inherits="Dynamicweb.Admin.VouchersManager.VouchersCategoryEdit" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>
    
<%--    <script type="text/javascript" language="javascript" src="js/List.js"></script>
--%>    
    <script type="text/javascript">
        $(document).observe('dom:loaded', function () {
            if(document.getElementById('Name')){
        	    window.focus(); // for ie8-ie9 
                document.getElementById('Name').focus();
            }
        });

         function help() {
		        <%=Dynamicweb.Gui.Help("", "administration.managementcenter.eCommerce.productcatalog.vouchers") %>
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
    <form id="form2" runat="server">
    <dw:RibbonBar ID="ListBar" runat="server">
        <dw:RibbonBarTab ID="RibbonGeneralTab" Name="List" runat="server" Visible="true">
            <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                <dw:RibbonBarButton ID="btnSave" Text="Save" Title="Save" Image="Save" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" OnClick="List_Save" ShowWait="true" WaitTimeout="1000" />
                <dw:RibbonBarButton ID="btnSaveAndClose" Text="Save and close" Image="SaveAndClose" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" OnClick="List_SaveAndClose" ShowWait="true" WaitTimeout="1000"/>
                <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Cancel" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click" />
                <dw:RibbonBarButton ID="btnDelete" Text="Delete" Image="FolderDelete" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" />
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
                <%= Translate.Translate("Category Name")%>
            </td>
            <td>
                <asp:TextBox ID="Name" runat="server" MaxLength="250" CssClass="NewUIinput" />
                <asp:RequiredFieldValidator ID="requiredNamevalidator" runat="server" ErrorMessage="*" ControlToValidate="Name"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td valign="top">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <dw:GroupBoxEnd runat="server" ID="SettingsEnd" />
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
