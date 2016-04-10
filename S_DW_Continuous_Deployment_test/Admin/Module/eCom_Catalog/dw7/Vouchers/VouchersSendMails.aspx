<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VouchersSendMails.aspx.vb" Inherits="Dynamicweb.Admin.VouchersSendMails" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" />
    <script type="text/javascript">

        $(document).observe('dom:loaded', function () {
            if (document.getElementById('VoucherSenderName')){
                window.focus(); // for ie8-ie9 
                document.getElementById('VoucherSenderName').focus(); 
            }
        });

        function closeDialog() {
            parent.dialog.hide('<%=dialogID %>');            
            if (window.parent != null && window.parent.vouchersManagerMain != null)
                window.parent.vouchersManagerMain.showVouchersList(<%=ListID %>);
        }

        if ('<%=showMessage %>' == 'True')
            alert('<%=messageToShow %>');

        if ('<%=doClose %>' == 'True') {
            alert('<%=messageToShow %>');
            closeDialog();
        }
        

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField runat="server" ID="idsToSave" />
        <dw:GroupBox ID="GroupBox2" runat="server" Title="Select group(s) and user(s)" DoTranslation="true">
            <div style="margin:10px 10px 10px 10px;" >
                <dw:UserSelector runat="server" ID="UserSelector"  
                    OnSelectScript="userSelected" OnUnselectScript="unselect" OnRemoveScript="remove" 
                    DisplayDefaultUser="false" DefaultUserName="Everyone" OnDefaultUserSelectScript="defaultUserSelected"
                    OnDefaultUserRemoveScript="defaultUserRemoved" HeightInRows="7" />
            </div>
        </dw:GroupBox>
    </div>
  <dw:GroupBox ID="gbMailSettings" Title="MailSettings" runat="server" DoTranslation="true">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td><dw:TranslateLabel ID="lbSenderName" Text="Sender name" runat="server" /></td>
                    <td>
                        <input type="text" class="std" id="VoucherSenderName"  name="VoucherSenderName" />
                    </td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel ID="lbSenderEmail" Text="Sender email" runat="server" /></td>
                    <td>
                        <input type="text" class="std" id="VoucherSenderEmail"  name="VoucherSenderEmail" value="<%= Base.GetGs("/Globalsettings/Settings/CommonInformation/Email") %>" />
                    </td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel ID="lbSubject" Text="Subject" runat="server" /></td>
                    <td>
                        <input type="text" class="std" id="VoucherSubject"  name="VoucherSubject" />
                    </td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel ID="lbTemplate" Text="Template" runat="server" /></td>
                    <td>
                        <dw:FileManager ID="VoucherMailTemplate" runat="server" Folder="/Templates/eCom7/Vouchers" />
                    </td>
                </tr>
            </table>
</dw:GroupBox>

    <div style="margin:10px 10px 10px 10px; text-align:right;" >
        <asp:Button runat="server" id="SaveButton" UseSubmitBehavior="true" />
        <asp:Button runat="server" id="CancelButton" UseSubmitBehavior="false" />
    </div>
    </form>        
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript() %>