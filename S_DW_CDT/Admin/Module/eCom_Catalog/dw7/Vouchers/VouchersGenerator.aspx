<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VouchersGenerator.aspx.vb" Inherits="Dynamicweb.Admin.VouchersManager.VouchersGenerator" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="True" ></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <script language="javascript" type="text/javascript">
        var numberOfVouchersClientID = <%=NumberOfVouchersClientID %>;
        var maxNumberOfVouchersExceededWarning =' <%= Dynamicweb.Backend.Translate.Translate("It isnot possible to generate more than 50000 vouchers at a time.")%>';
    </script>
    <script type="text/javascript" language="javascript"  src="js/VouchersGenerator.js"></script>

    <script type="text/javascript">

        $(document).observe('dom:loaded', function () {
            if (document.getElementById('numberOfVouchers')) {
                window.focus(); // for ie8-ie9 
                document.getElementById('numberOfVouchers').focus();
            }
        });

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
            <dw:Overlay ID="wait" Message="Please wait" runat="server">
        </dw:Overlay>

    <form id="vouchersGeneratorForm" runat="server">
    <dw:GroupBoxStart runat="server" ID="SettingsStart" doTranslation="true" Title="Settings"
        ToolTip="Settings" />
    <table border="0" cellpadding="2" cellspacing="0">
        <tr>
            <td width="170">
                <%= Translate.Translate("Enter number of vouchers to generate:")%>
            </td>
            <td>
                <asp:TextBox ID="numberOfVouchers" runat="server" MaxLength="10" CssClass="NewUIinput" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <a href="#" onclick="vouchersGenerator.ShowDialogVouchersGenerateUsers();"><% =Translate.Translate("Get number from User Management")%></a>
            </td>
        </tr>
    </table>
    <input type="button" id="btnGenerate" value="<% =Translate.Translate("Generate")%>" onclick="if (vouchersGenerator.PostbackForm(<%= ListID %>)) {var o = new overlay('wait');
        o.show();};" />
    <dw:GroupBoxEnd runat="server" ID="SettingsEnd" />
        <dw:Dialog runat="server" ID="GenerateVouchersUsersDialog" Width="416" Title="Add Voucher" ShowClose="true" HidePadding="true" ShowCancelButton="true" ShowOkButton="true" OkAction="vouchersGenerator.GetNumberOfUsers();" CancelAction="vouchersGenerator.CloseDialog();">
           <div>
                <asp:HiddenField runat="server" ID="idsToSave" />
                <input type="hidden" id="formmode" name="formmode" value="" />
                <dw:GroupBox ID="GroupBox2" runat="server" Title="Select group(s) and user(s)" DoTranslation="true">
                    <div style="margin:10px 10px 10px 10px;" >
                        <dw:UserSelector runat="server" ID="UserSelector"  
                            OnSelectScript="userSelected" OnUnselectScript="unselect" OnRemoveScript="remove" 
                            DisplayDefaultUser="false" DefaultUserName="Everyone" OnDefaultUserSelectScript="defaultUserSelected"
                            OnDefaultUserRemoveScript="defaultUserRemoved" HeightInRows="7" />
                    </div>
                </dw:GroupBox>
            </div>
        </dw:Dialog>
    </form>    
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
