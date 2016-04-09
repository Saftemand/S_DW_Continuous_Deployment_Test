<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomRmaEmailNotification_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.Admin.Module.eCom_Catalog.dw7.edit.EcomRmaEmailNotification_Edit" %>

<%@ Import Namespace="Dynamicweb.SystemTools" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true"
        runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
        </Items>
    </dw:ControlResources>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dw:Toolbar ID="Toolbar" ShowStart="false" ShowEnd="false" runat="server">
            <dw:ToolbarButton ID="cmdSaveAndClose" Image="SaveAndClose" Text="Gem og luk" OnClientClick="submitForm(); return false;"
                runat="server" />
            <dw:ToolbarButton ID="cmdClose" Image="Delete" Text="Close" OnClientClick="closeForm(); return false;"
                runat="server" />
        </dw:Toolbar>

        <div>
            <input type="hidden" id="MailsJSON" runat="server" value="[]" />
        <dw:GroupBox runat="server" ID="notificationsGroupbox">
            
        <table id="MailsTable">
            </table>
        </dw:GroupBox>    
            <a onclick="addNewMail()">
                <img src="/Admin/Module/eCom_CartV2/images/notebook_add.png" alt="Add new notification" />Add
                notification</a>
            <dw:Dialog runat="server" ID="EditMailDialog" Title="Edit e-mail" TranslateTitle="true"
                ShowCancelButton="true" ShowOkButton="true" OkAction="saveMailEdit();">
                <input type="hidden" id="MailIndex" />
                <table>
                    <colgroup>
                        <col style="width: 170px" />
                        <col />
                    </colgroup> 
                    <tr>
                        <td>
                        </td>
                        <td>
                            <input type="checkbox" id="MailForCustomer" onchange="document.getElementById('MailRecipient').disabled = this.checked;" />
                            <label for="MailForCustomer">
                                <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="For customer" />
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Recipient e-mail" />
                        </td>
                        <td>
                            <input type="text" id="MailRecipient" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Subject" />
                        </td>
                        <td>
                            <input type="text" id="MailSubject" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Template" />
                        </td>
                        <td style="white-space: nowrap;">
                            <dw:FileManager runat="server" ID="MailTemplate" Folder="Templates/eCom/RMA/Mail"
                                FullPath="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Sender name" />
                        </td>
                        <td>
                            <input type="text" id="MailSenderName" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Sender e-mail" />
                        </td>
                        <td>
                            <input type="text" id="MailSenderEmail" class="NewUIinput" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </dw:Dialog>
            <div id="HiddensMails">
            </div>
            <div id="Translate_Customer" style="display: none;">
                <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Customer" />
            </div>
            <div id="Translate_No_recipient" style="display: none;">
                <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="No recipient" />
            </div>
            <div id="Translate_Edit" style="display: none;">
                <dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Edit" />
            </div>
            <div id="Translate_Delete" style="display: none;">
                <dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Delete" />
            </div>
        </div>
    </div>
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
<script type="text/javascript">
    var mails = new Array();
    function Mail(recipient, subject, template, templatePath, senderName, senderEmail, ForCustomer, id) {
        this.Recipient = recipient;
        this.Subject = subject;
        this.Template = template;
        this.SenderName = senderName;
        this.SenderEmail = senderEmail;
        this.ForCustomer = ForCustomer;
        this.id = id;
    }

    function editMail(mailIndex) {
        var mail = mails[mailIndex];
        document.getElementById('MailIndex').value = mailIndex;
        document.getElementById('MailRecipient').value = mail.Recipient;
        document.getElementById('MailSubject').value = mail.Subject;
        document.getElementById('FM_MailTemplate').value = mail.Template;
        document.getElementById('MailTemplate_path').value = mail.TemplatePath;
        document.getElementById('MailSenderName').value = mail.SenderName;
        document.getElementById('MailSenderEmail').value = mail.SenderEmail;

        var ForCustomer = document.getElementById('MailForCustomer');
        ForCustomer.checked = mail.ForCustomer;
        ForCustomer.onchange();

        dialog.show('EditMailDialog');
    }

    function saveMailEdit() {
        var mail = mails[document.getElementById('MailIndex').value];
        mail.Recipient = document.getElementById('MailRecipient').value;
        mail.Subject = document.getElementById('MailSubject').value;
        mail.Template = document.getElementById('FM_MailTemplate').value;
        mail.TemplatePath = document.getElementById('MailTemplate_path').value;
        mail.SenderName = document.getElementById('MailSenderName').value;
        mail.SenderEmail = document.getElementById('MailSenderEmail').value;
        mail.ForCustomer = document.getElementById('MailForCustomer').checked;
        updateMails();
        dialog.hide('EditMailDialog');
    }

    function deleteMail(mailIndex) {
        mails.splice(mailIndex, 1);
        updateMails();
        dialog.hide('EditMailDialog');
    }


    function addNewMail() {
        mails.push(new Mail('', '', '', '', '', '', false,  -1)); // 65001 is the codepage for UTF-8
        updateMails();
        editMail(mails.length - 1);
    }
    function updateMails() {

        // Clear table
        var table = document.getElementById('MailsTable');
        while (table.rows.length > 0)
            table.deleteRow(0);

        // Clear hidden values
        clearHidden('Mails');

        if (mails.length == 0) {
            var row = table.insertRow(table.rows.length);
            row.insertCell(row.cells.length).innerHTML = "None";


        }
        // Add each step
        for (var i = 0; i < mails.length; i++) {
            var mail = mails[i];

            // Add to hidden save values
            if (mail.id > -1) {
                addHidden('Mails', 'Mail' + (i + 1) + 'Id', mail.id);
            } else {
                addHidden('Mails', 'Mail' + (i + 1) + 'Id', -1);
            }
            addHidden('Mails', 'Mail' + (i + 1) + 'Recipient', mail.Recipient);
            addHidden('Mails', 'Mail' + (i + 1) + 'Subject', mail.Subject);
            addHidden('Mails', 'Mail' + (i + 1) + 'Template', mail.Template);
            addHidden('Mails', 'Mail' + (i + 1) + 'Template_path', mail.TemplatePath, true);
            addHidden('Mails', 'Mail' + (i + 1) + 'SenderName', mail.SenderName);
            addHidden('Mails', 'Mail' + (i + 1) + 'SenderEmail', mail.SenderEmail);
            addHidden('Mails', 'Mail' + (i + 1) + 'ForCustomer', mail.ForCustomer);

            // Add to table
            var row = table.insertRow(table.rows.length);

            var name;
            if (mail.ForCustomer)
                name = document.getElementById('Translate_Customer').innerHTML;
            else if (mail.Recipient.length > 0)
                name = mail.Recipient;
            else
                name = document.getElementById('Translate_No_recipient').innerHTML;

            row.insertCell(row.cells.length).innerHTML = name;
            row.insertCell(row.cells.length).appendChild(createImage('/Admin/Module/eCom_CartV2/images/mail_edit.png', 'editMail(' + i + ');', 'Edit'));
            row.insertCell(row.cells.length).appendChild(createImage('/Admin/Module/eCom_CartV2/images/mail_delete.png', 'deleteMail(' + i + ');', 'Delete'));
        }

    }
    function submitForm() {
        $('form1').submit();
    }
    function closeForm() {
        window.close();
    }




    //    var hiddenSettingNames = new Object;
    //    hiddenSettingNames.Steps = new Array();
    //    hiddenSettingNames.Mails = new Array();

    function addHidden(settingName, name, value, excludeInSettings, excludeInHiddens) {
        // Add to hiddens
        if (!excludeInHiddens) {
            var hiddenDiv = document.getElementById('Hiddens' + settingName);
            var hidden = document.createElement('input');
            hidden.type = 'hidden';
            hidden.value = value;
            hidden.name = name;
            hiddenDiv.appendChild(hidden);
        }
    }

    function clearHidden(settingName) {
        // Clear the hidden inputs
        if (document.getElementById('Hiddens' + settingName))
            document.getElementById('Hiddens' + settingName).innerHTML = '';
    }

    function createImage(url, onclick, titleName) {
        var image = document.createElement('img');
        image.src = url;
        image.alt = '';
        image.onclick = new Function(onclick);
        image.width = 16;
        image.height = 16;
        image.style.cursor = 'pointer';
        image.title = document.getElementById('Translate_' + titleName).innerHTML;
        image.style.verticalAlign = 'top';
        return image;
    }

    // init
    mails = eval(document.getElementById('MailsJSON').value);
    updateMails();
    
</script>
