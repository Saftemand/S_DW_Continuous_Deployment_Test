<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="EditEmail.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Emails.EditEmail" %>

<%@ Import Namespace="Dynamicweb.Modules.EmailMarketing" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .NewUIinput
        {
            margin-right: 20px;
        }
    </style>

    <script type="text/javascript">
        function getNewsletterName() 
        {
            return $('txSubject').value;             
        }

        function getScheduledDate() {
            var scheduledDate = "";
            if($('dsStartDate_month') && $('dsStartDate_day') && $('dsStartDate_year') && $('dsStartDate_hour') && $('dsStartDate_minute')){
                scheduledDate = " '" + $('dsStartDate_month').childElements().find(function(el){return $(el).selected}).label + "-" + $('dsStartDate_day').childElements().find(function(el){return $(el).selected}).label + "-" + $('dsStartDate_year').value + ' <%=Backend.Translate.JsTranslate("at")%> ' + $('dsStartDate_hour').childElements().find(function(el){return $(el).selected}).label + ":" + $('dsStartDate_minute').childElements().find(function(el){return $(el).selected}).label + "' " ;
            }
            return scheduledDate; 
        }

        function getConfirmText(){
            var confirmText= '<%=Backend.Translate.JsTranslate("The sending of e-mail")%>' + " '" + getNewsletterName() + "' " + '<%=Backend.Translate.JsTranslate(" will be scheduled for ")%>' + getScheduledDate() + '<%=Backend.Translate.JsTranslate(". Do you want to continue?")%>';
            return confirmText;
        }

        var emptyUserError = '<%=Backend.Translate.JsTranslate("Please specify user!")%>';

        function showPreviewEmailDialog() {
  
            var userId = $('PreviewEmailSelectorhidden').value;            
            if (userId) {
                var url = "/Admin/Module/OMC/Emails/EditEmail.aspx";
                var hasSplitTest = $('chkOriginal') ? true : false;
                    
                new Ajax.Request(url, {
                    method: 'get',
                    parameters: {
                        UserID: userId
                    },
                    onSuccess: function (transport) {
                        if(transport.responseText.length > 0){
                            alert(transport.responseText);
                        }else{
                            window.open('/Admin/Module/OMC/Emails/PreviewMailPage.aspx?emailId=' + <%=EmailID%> + '&userId=' + userId + '&hasSplitTest=' + hasSplitTest, 'PreviewMailPopup', 'status=1,toolbar=0,menubar=0,resizable=1,directories=0,titlebar=0,modal=no');
                        }
                    }, 
                });
            } else {
                alert('<%=Backend.Translate.JsTranslate("Please select a user")%>');
            }
        }

        function setSplitTestmodeVariation(box) {
            var buttons = parent.Ribbon;
            if(!box.checked) {
                document.getElementById("<%=trVariationClientId%>").style.display = "none";
                buttons.disableButton('cmdStart_split_test'); 
                if ($("lmEmailPage").value)
                    buttons.enableButton("cmdSend_Mail");
                parent.OMC.MasterPage.get_current().get_contentWindow().<%=Me.ClientInstanceName%>.set_variantpageId(0);
            } else {
                document.getElementById("<%=trVariationClientId%>").style.display = "";
                buttons.enableButton('cmdStart_split_test'); 
                buttons.disableButton("cmdSend_Mail");

                if(!$('txtVariantSenderName').value){
                    $('txtVariantSenderName').value = $('txSenderName').value;
                }
                if(!$('txtVariantSenderEmail').value){
                    $('txtVariantSenderEmail').value = $('txSenderEmail').value;
                }
                if(!$('txtVariantSubject').value){
                    $('txtVariantSubject').value = $('txSubject').value;
                }
                if(!$('Link_lmVariantEmailPage').value){
                    $('Link_lmVariantEmailPage').value = $('Link_lmEmailPage').value;
                }
                if(!$('variantPreHeaderText').value){
                    $('variantPreHeaderText').value = $('originalPreHeaderText').value;
                }
                parent.OMC.MasterPage.get_current().get_contentWindow().<%=Me.ClientInstanceName%>.set_variantpageId(getVariantPageId());
            }
        }

        function getVariantPageId(){
            var pageUrl = $('lmVariantEmailPage').value;
            var pageId = pageUrl.split('=')[1];
            return pageId;
        }

        function execResponse(text){
            if(!text && text != ""){
                eval(text);
            }
        }

        function disableInputsFields(){
            $('cbCreateSplitTestVariation').disable();
            $('DomainSelector').disable();
            $('RecipientAddinControlDiv').disabled =true;
            $('RecipientAddinControlDiv').select('img').each(function(element) {
                   element.onclick = "";
             });
        }

        function OnRecipientsCountChanged(ids)
        {
            var el = $('lblTotalRecipientsValue');

            if(el != null)
            {
                var url = '/Admin/Module/OMC/Emails/EditEmail.aspx?newsletterId=<%=EmailID%>';

                new Ajax.Request(url, 
                    {
                        method: 'get',
                        parameters: {
                            OpType: 'OnRecipientsCountChanged',
                            IncludedIds: ids,
                            ExcludedIds: document.getElementById('RecipientsExcluded').value
                        },
                        onSuccess: function (transport) 
                        {
                            if(transport.responseText != null && transport.responseText.length > 0)
                                el.textContent = transport.responseText;
                            else
                                el.textContent = '0';
                        }
                     });      
            }
        }

        function ShowRecipientsPopup()
        {
            <%=If(Me.IsEmailSent(), "return;", String.Empty)%>
            var included = document.getElementById('<%=Me.RecipientSelector.ID%>hidden').value;
            var excluded = document.getElementById('RecipientsExcluded').value;

            parent.OMC.MasterPage.get_current().showDialog(
                '/Admin/Module/OMC/Emails/RecipientsList.aspx?emailId=<%=EmailID%>&included=' + included + '&excluded=' + excluded, 
                950, 
                482, 
                { title: '<%=Translate.Translate("All recipients")%>', hideCancelButton: true },
                OnRecipientsPopupClosed);
        }

        function OnAddEmailTagClosed()
        {
            var subj = $('txSubject');
            var list = $('<%=Me.EmailTagsList.ClientID%>');
            var val = list.options[list.selectedIndex].value

            insertAtCaret(subj, val);
            dialog.hide('AddEmailTag');
        }

        function OnAddVarEmailTagClosed()
        {
            var subj = $('txtVariantSubject');
            var list = $('<%=Me.VarEmailTagsList.ClientID%>');
            var val = list.options[list.selectedIndex].value

            insertAtCaret(subj, val);
            dialog.hide('AddVarEmailTag');
        }

        function insertAtCaret(el, text)
        {
            if (document.selection) 
            { 
                el.focus();
                sel = document.selection.createRange();
                sel.text = text;
                el.focus();
            } 
            else if (el.selectionStart || el.selectionStart == '0')
            { 
                var startPos = el.selectionStart, endPos = el.selectionEnd, scrollTop = el.scrollTop;
                el.value = el.value.substring(0, startPos) + text + el.value.substring(endPos, el.value.length);
                el.focus();
                el.selectionStart = startPos + text.length;
                el.selectionEnd = startPos + text.length;
                el.scrollTop = scrollTop;
            } 
            else
            {
                el.value += text;
                el.focus();
            }
        }

        function OnRecipientsPopupClosed(sender, args)
        {
            <%="UserSelector" + Me.RecipientSelector.ID%>.clearExcluded();
            var excluded = document.getElementById('RecipientsExcluded').value;
            var items = excluded.split(',');

            for(i = 0; i < items.length; i++)
                <%="UserSelector" + Me.RecipientSelector.ID%>.excludeUser('u' + items[i]);   

            <%="UserSelector" + Me.RecipientSelector.ID%>.renderItems('', '');
            OnRecipientsCountChanged(document.getElementById('<%=Me.RecipientSelector.ID%>hidden').value);
        }

        function RenderRecipientControl() 
        {
            var providerSelector = $('Dynamicweb.Modules.EmailMarketing.EmailRecipientProvider_AddInTypes');
            var provType = providerSelector.value;
            var providerName = providerSelector[providerSelector.selectedIndex].text;
            var translatedText = '<%=Backend.Translate.Translate("Using a custom recipient provider")%>: ';

            if(provType != '<%=GetType(RecipientProviders.AccessUserRecipientProvider).FullName%>')
            {
                var customDiv;
                customDiv = document.getElementById('CustomRecipientSelectorDiv');
                customDiv.innerHTML = translatedText + '<a href="javascript:dialog.show(\'RecipientProviderDialog\')">' + providerName + '</a>';
                customDiv.removeAttribute('style');

                document.getElementById('RecipientAddinControlDiv').style.display = 'none';
                var isEmailSent = eval('<%=_email.IsEmailSent()%>'.toLowerCase());
                if(isEmailSent){
                    document.getElementById("addTag").style.visibility = "hidden";
                    document.getElementById("addVarTag").style.visibility = "hidden";
                }
            }
            else
            {
                document.getElementById('RecipientAddinControlDiv').removeAttribute('style');
                document.getElementById('CustomRecipientSelectorDiv').style.display = 'none';
                document.getElementById("addTag").style.visibility = "visible";
                document.getElementById("addVarTag").style.visibility = "visible";
            }          
        }

        function checkDomain() {
            parent.OMC.MasterPage.get_current().get_contentWindow().<%=Me.ClientInstanceName%>.CheckPrimaryDomain();
        }

        function setCheckboxVariation(){
            var variationCheckbox = $('cbCreateSplitTestVariation');
            if(variationCheckbox){
                if(variationCheckbox.checked){
                    variationCheckbox.checked = false;
                }else{
                    variationCheckbox.checked = true;
                }

                setSplitTestmodeVariation(variationCheckbox);
            }
        }

        function toggleScheduledRepeatSettings() {
            var intervalDropDown = $("<%= ddlScheduledRepeatInterval.ClientID%>");

            var endTimeRow = $("trRepeatEndTime");
            if (intervalDropDown.options[intervalDropDown.selectedIndex].value == "0")
                endTimeRow.hide();
            else
                endTimeRow.show();
        }

        function toggleQuarantinePeriodSettings() {
            var quarantineDropDown = $("<%= ddlQuarantinePeriod.ClientID%>");
            var uniqueRecipients = $("<%= chkUniqueRecipients.ClientID%>").checked;
            var quarantineBox = $("boxCustomQuarantinePeriod");
            var quarantineRow = $("trQuarantinePeriod");

            if (uniqueRecipients)
                quarantineRow.hide();
            else
                quarantineRow.show();

            if (quarantineDropDown.options[quarantineDropDown.selectedIndex].value == "_")
                quarantineBox.show();
            else
                quarantineBox.hide();
        }

        function togglePlainTextRow() {
            var usePlainText = $("<%= radioCustomPlainText.ClientID%>").checked;
            var plainTextRow = $("trPlainTextRow");

            if (usePlainText)
                plainTextRow.show();
            else
                plainTextRow.hide();
        }

        Event.observe(window, "load", function () {
            RenderRecipientControl();
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dw:Overlay ID="saveForward" runat="server">
    </dw:Overlay>
    <dw:Infobar runat="server" ID="OMCInfoBar" Visible="False" />
    <dw:Infobar runat="server" ID="ibSubscribers" Visible="False" Type="Warning" />
    <div id="OMCInfoBarSplitDiv" style="display: none;">
        <dw:Infobar runat="server" ID="OMCInfoBarSplit" />
    </div>
    <div id="OMCInfoBarEmailPersonalizationDiv" style="display: none;">
        <dw:Infobar runat="server" ID="OMCInfoBarEmailPersonalization" />
    </div>
    <div id="ScriptNumberSelectorDiv">
        <asp:Literal ID="ScriptNumberSelectorLiteral" runat="server"></asp:Literal>
    </div>    
    <div id="hasDeprecatedTagsInfoDiv" style="display: none;">
        <dw:Infobar runat="server" ID="hasDeprecatedTagsInfoBar" Type="Warning" Message="Choosen page has deprecated format of unsubscribe tags, use {{EmailMarketing:Email.UnsubscribeLink}} format instead" />
    </div>    
    <table border="0">

        <tr>
            <td>
                <dw:GroupBox ID="gbGeneral" Title="General" runat="server">
                    <table>
                        <tr id="trTemplateName" runat="server">
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel3" Text="Template name" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txTemplateName" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px; vertical-align: top;">
                                <dw:TranslateLabel ID="TranslateLabel5" Text="Subject" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txSubject" CssClass="std field-name" runat="server" ClientIDMode="Static" Rows="4" TextMode="MultiLine" />
                                <asp:Literal runat="server" ID="AddEmailTagLiteral" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px; vertical-align: top;">
                                <dw:TranslateLabel ID="TranslateLabel6" Text="To" runat="server" />
                            </td>
                            <td>
                                <div id="RecipientAddinControlDiv" <%If Not Me.DefaultRecipientSelector Then%>style="display: none;" <%End If%>>
                                    <asp:Literal runat="server" ID="RecipientsExcluded" ClientIDMode="Static"></asp:Literal>
                                    <div id="DefaultRecipientSelector">
                                    <dw:UserSelector runat="server" ID="RecipientSelector" NoneSelectedText="No one recipients selected" HeightInRows="7" DiscoverHiddenItems="False" MaxOne="False" OnlyBackend="False" ShowSmartSearches="True" Width="250" CountChangedCallback="OnRecipientsCountChanged" />
                                        <div>
                                            <div style="float: left;">
                                                <dw:TranslateLabel Text="Total recipients:" runat="server" ID="lblTotalRecipients" />
                                                <asp:Label ID="lblTotalRecipientsValue" runat="server" Style="margin-left: 4px;" ClientIDMode="Static"></asp:Label>
                                            </div>
                                            <br />
                                            <div style="margin-top:3px;">
                                                <dw:Button ID="btnRecipientsList" runat="server" Name="List of recipients" OnClick="ShowRecipientsPopup();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="CustomRecipientSelectorDiv" <%If Me.DefaultRecipientSelector Then%>style="display: none;" <%End If%>>
                                    
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="lbSenderName" Text="From: Name" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txSenderName" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="lbSenderEmail" Text="From: email" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txSenderEmail" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px;  vertical-align: top;">
                                <dw:TranslateLabel ID="TranslateLabel4" Text="Pre-header" runat="server" />
                            </td>
                            <td style="vertical-align:top;">
                                <textarea rows="3" id="originalPreHeaderText" name="originalPreHeader" class="std field-name" style="width: 252px;" runat="server" clientidmode="Static"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel7" Text="Page" runat="server" />
                            </td>
                            <td>
                                <dw:LinkManager ID="lmEmailPage" runat="server" DisableFileArchive="true" DisableParagraphSelector="true" DisableTyping="true" CssClass="std field-name" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel8" Text="Domain" runat="server" />
                            </td>
                            <td>
                                <select id="DomainSelector" class="std" name="DomainSelector" style="width: 254px" onchange="checkDomain();">
                                    <asp:Literal ID="DomainList" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr id="rowDomainErrorContainer" style="display: none;">
                            <td style="width: 170px">
                                &nbsp;
                            </td>
                            <td>
                                <div id="divDomainErrorContainer" style="color: red;">
                                </div>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </td>
        </tr>
        <tr>
            <td>
                <%=Gui.GroupboxStart(strSplitTestVariation)%>&nbsp;
                <div id="trVariation" runat="server">
                    <table>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel11" Text="From: Name" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtVariantSenderName" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel12" Text="From: email" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtVariantSenderEmail" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px; vertical-align: top;">
                                <dw:TranslateLabel ID="TranslateLabel13" Text="Subject" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtVariantSubject" CssClass="std field-name" runat="server" ClientIDMode="Static" Rows="4" TextMode="MultiLine" />
                                <asp:Literal runat="server" ID="AddVarEmailTagLiteral" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px; vertical-align: top;">
                                <dw:TranslateLabel ID="TranslateLabel9" Text="Pre-header" runat="server" />
                            </td>
                            <td style="vertical-align:top;">
                                <textarea rows="3" id="variantPreHeaderText" name="variantPreHeader" class="std field-name" runat="server" clientidmode="Static"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel14" Text="Page" runat="server" />
                            </td>
                            <td>
                                <dw:LinkManager ID="lmVariantEmailPage" runat="server" DisableFileArchive="true" DisableParagraphSelector="true" DisableTyping="true" CssClass="std field-name" />
                            </td>
                        </tr>
                    </table>
                </div>
                <%=Gui.GroupboxEnd%>
            </td>
        </tr>
    </table>

    <dw:Dialog runat="server" ID="UnsubscribeDialog" Width="520" Title="Unsubscribe email" HidePadding="false" ShowOkButton="true" OkAction="dialog.hide('UnsubscribeDialog');">
        <%If Request.Browser.Browser = "IE" Then%> 
        <style type="text/css">
            #UnsubscribeDiv table.tabTable, #UnsubscribeDiv fieldset
            {
                display: block;
                width: 470px;
            }
        </style>
        <%Else%>
        <style type="text/css">
            #UnsubscribeDiv table.tabTable, #UnsubscribeDiv fieldset
            {
                display: block;
                width: 460px;
            }
        </style>
        <%End If%>
        <div id="UnsubscribeDiv">
            <dw:GroupBoxStart runat="server" ID="SubscriptionStart" doTranslation="true" Title="Unsubscribe" ToolTip="Unsubscribe" />
                <table cellpadding="2" cellspacing="0">
                    <tr>
                        <td style="width: 170px" id="UnsubscribeLinkLabel">
                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Unsubscribe text" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txbUnsubscribeText" CssClass="std field-name" MaxLength="255" />&nbsp;
                        </td>
                    </tr>
                    <tr id="trUnsubscribePage">
                        <td style="width: 170px;" id="UnsubscribeRedirectPageLabel">
                            <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Redirect after unsubscribe" />
                        </td>
                        <td>
                            <dw:LinkManager ID="lmUnsubscriptionPage" runat="server" DisableFileArchive="true" DisableParagraphSelector="true" DisableTyping="true" />
                        </td>
                    </tr>
                </table>
             <dw:GroupBoxEnd runat="server" ID="SubscriptionEnd" />
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="ContentSettingsDialog" Width="590" Title="Content settings" ShowClose="true" HidePadding="true" UseTabularLayout="True" ShowOkButton="True" IsModal="True">
        <style type="text/css">
            #ContentSettingsDiv table.tabTable, #ContentSettingsDiv fieldset {
                display: block;
                width: 510px;
            }
        </style>
        <div id="ContentSettingsDiv" class="content-main">
            <dw:GroupBox runat="server" Title="Render content for each recipient">
                <table border="0">
                    <tr>
                        <td class="left-label">
                            <dw:TranslateLabel runat="server" Text="Content" />
                        </td>
                        <td>
                            <label>
                                <asp:CheckBox runat="server" ID="chkContentPerRecipient" />
                                <dw:TranslateLabel runat="server" Text="Render content for each recipient" CssClass="std" />
                            </label>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <dw:GroupBox runat="server" Title="Plain text">
                <table border="0">
                    <tr>
                        <td class="left-label">
                            <dw:TranslateLabel Text="Plain text" runat="server" />
                        </td>
                        <td>
                            <ul class="unstyled">
                                <li>
                                    <label>
                                        <input type="radio" id="radioNoPlainText" name="radioPlainTextSelector" value="None" onchange="togglePlainTextRow();" runat="server" />
                                        <dw:TranslateLabel runat="server" Text="No plain text" CssClass="std" />
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="radio" id="radioAutoPlainText" name="radioPlainTextSelector" value="Auto" onchange="togglePlainTextRow();" runat="server" />
                                        <dw:TranslateLabel runat="server" Text="Generate automatically from content" CssClass="std" />
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="radio" id="radioCustomPlainText" name="radioPlainTextSelector" value="Custom" onchange="togglePlainTextRow();" runat="server" />
                                        <dw:TranslateLabel runat="server" Text="Specify custom text" CssClass="std" />
                                    </label>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr id="trPlainTextRow">
                        <td class="left-label">
                            <dw:TranslateLabel runat="server" Text="Plain text content" />
                        </td>
                        <td>
                            <textarea runat="server" id="txtPlainTextContent" class="std" cols="75" rows="10" style="width: 325px;"></textarea>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="RecipientSettingsDialog" Width="440" Title="Recipient settings" ShowClose="true" HidePadding="true" UseTabularLayout="True" ShowOkButton="True" IsModal="True">
        <style type="text/css">
            #RecipientSettingsDiv table.tabTable, #RecipientSettingsDiv fieldset {
                display: block;
                width: 360px;
            }
        </style>
        <div id="RecipientSettingsDiv" class="content-main">
            <dw:GroupBox runat="server" Title="Recipient settings">
                <table border="0">
                    <tr>
                        <td style="width: 170px;" >
                            <dw:TranslateLabel runat="server" Text="Recipient uniqueness" />
                        </td>
                        <td>
                            <label>
                                <asp:CheckBox runat="server" ID="chkUniqueRecipients" onchange="toggleQuarantinePeriodSettings();" />
                                <dw:TranslateLabel runat="server" Text="Ensure unique recipients" />
                            </label>
                        </td>
                    </tr>
                    <tr id="trQuarantinePeriod">
                        <td style="width: 170px; vertical-align:top;" >
                            <dw:TranslateLabel runat="server" Text="Quarantine period" />
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlQuarantinePeriod" onchange="toggleQuarantinePeriodSettings();" CssClass="std" Width="175" />
                            <div id="boxCustomQuarantinePeriod" style="display:none;">
                                <asp:TextBox runat="server" ID="txtCustomQuarantinePeriod" CssClass="std" Width="175" />
                            </div>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="AddEmailTag" Width="460" Title="Add email tag" ClientIDMode="Static" IsModal="True" UseTabularLayout="True" HidePadding="False" ShowCancelButton="False" ShowClose="True" ShowOkButton="True" OkAction="OnAddEmailTagClosed();">
        <style type="text/css">
            #AddEmailTagDiv table.tabTable, #AddEmailTagDiv fieldset {
                display: block;
                width: 366px;
            }
        </style>
        <div id="AddEmailTagDiv">
            <table border="0">
                <tr>
                    <td style="width: 170px;">
                        <dw:TranslateLabel runat="server" Text="Tag"  CssClass="std" />
                    </td>
                    <td style="padding-top: 5px;">
                        <asp:DropDownList runat="server" ID="EmailTagsList" CssClass="std" DataTextField="Text" DataValueField="Value" Style="width: 200px;" ClientIDMode="Static" Width="200" />
                    </td>
                </tr>
            </table>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="AddVarEmailTag" Width="460" Title="Add email tag" ClientIDMode="Static" IsModal="True" UseTabularLayout="True" HidePadding="False" ShowCancelButton="False" ShowClose="True" ShowOkButton="True" OkAction="OnAddVarEmailTagClosed();">
        <style type="text/css">
            #AddVarEmailTagDiv table.tabTable, #AddVarEmailTagDiv fieldset {
                display: block;
                width: 366px;
            }
        </style>
        <div id="AddVarEmailTagDiv">
            <table border="0">
                <tr>
                    <td style="width: 170px;" >
                        <dw:TranslateLabel runat="server" Text="Tag"  CssClass="std" />
                    </td>
                    <td style="padding-top: 5px;">
                        <asp:DropDownList runat="server" ID="VarEmailTagsList" CssClass="std" DataTextField="Text" DataValueField="Value" Style="width: 200px;" ClientIDMode="Static" Width="200" />
                    </td>
                </tr>
            </table>
        </div>
    </dw:Dialog>
    <dw:Dialog ID="CMAttachDialog" runat="server" Width="350" ShowCancelButton="false" ShowOkButton="true" Title="Attachments" IsIFrame="false" ShowClose="True">
        <style type="text/css">
            #AttachmentsDiv table.tabTable, #AttachmentsDiv fieldset
            {
                display: block;
                width: 300px;
            }
            .attachmentControl
            {
                padding: 10px;
            }
        </style>
        <div id="AttachmentsDiv">
            <dw:GroupBox ID="GroupBox4" Title="Email attachments" runat="server">
                <omc:AttachmentsListBox ID="CMAttachListBox" runat="server" CssClass="attachmentControl"></omc:AttachmentsListBox>
            </dw:GroupBox>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="EmailTemplateDialog" Width="350" Title="Template" HidePadding="false" ShowOkButton="true" OkAction="dialog.hide('EmailTemplateDialog');">
        <%If Request.Browser.Browser = "IE" Then%> 
        <style type="text/css">
            #LayoutTemplateDiv table.tabTable, #LayoutTemplateDiv fieldset
            {
                display: block;
                width: 300px;
            }
        </style>
        <%Else%>
        <style type="text/css">
            #LayoutTemplateDiv table.tabTable, #LayoutTemplateDiv fieldset
            {
                display: block;
                width: 290px;
            }
        </style>
        <%End If%>
        <div id="LayoutTemplateDiv">
            <dw:GroupBox ID="gbLayoutTemplate" Title="Layout template" runat="server" >
                <table cellpadding="10" cellspacing="10">
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel15" Text="Choose a different layout template for the e-mail page" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select id="PageLayoutSelector" class="std" name="PageLayoutSelector">
                                <asp:Literal ID="PageLayoutList" runat="server"></asp:Literal>
                            </select>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="SchedulingDialog" Width="500" Title="Scheduling" ShowClose="true" HidePadding="true" UseTabularLayout="false">
        <div id="SchedulingDiv" class="content-main">
            <dw:GroupBox ID="GroupBox5" runat="server" Title="Setup scheduling" DoTranslation="true">
                <table border="0" style="width: 445px;">
                    <tr>
                        <td style="width: 170px;">
                            <dw:TranslateLabel ID="TranslateLabel22" Text="Start" runat="server" />
                        </td>
                        <td style="white-space: nowrap;">
                            <dw:DateSelector ID="dsStartDate" runat="server" IncludeTime="True" ShowAsLabel="False" />
                        </td>
                    </tr>
                    <tr id="trRepeatEndTime">
                        <td style="width: 170px;">
                            <dw:TranslateLabel ID="TranslateLabel10" Text="End" runat="server" />
                        </td>
                        <td style="white-space: nowrap;">
                            <dw:DateSelector ID="dsEndDate" runat="server" IncludeTime="True" ShowAsLabel="False" AllowNeverExpire="true" SetNeverExpire="true" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 170px;">&nbsp;</td>
                        <td>
                            <asp:DropDownList runat="server" ID="ScheduledSendTimeZone" DataTextField="Text" DataValueField="Value" CssClass="std" style="width: 290px !important;" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 170px;"><dw:TranslateLabel runat="server" Text="Repeat every" /></td>
                        <td><asp:DropDownList runat="server" ID="ddlScheduledRepeatInterval" CssClass="std" style="width: 290px !important;" onchange="toggleScheduledRepeatSettings();" /></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="button" id="Button1" class="buttonSubmit" value="Cancel" style="float: right; margin-left: 5px;" onclick="dialog.hide('SchedulingDialog');" />
                            <asp:Button runat="server" Text="Schedule" ID="SchedulingScheduleButton" CssClass="buttonSubmit" CausesValidation="false" style="float: right;" OnClientClick="if(!confirm(getConfirmText())){return false;}" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="PreviewMailDialog" Width="516" Title="Preview settings" ShowClose="true" HidePadding="true">
        <div>
            <div id="PreviewTabDiv" class="content-main">                
                <table border="0">
                    <tr>
                        <td>
                            <dw:GroupBox ID="GroupBoxPreviewRecipients" runat="server" Title="Preview as user" DoTranslation="true">
                                <div style="margin: 10px 10px 0px 10px;">
                                    <dw:UserSelector runat="server" ID="PreviewEmailSelector" NoneSelectedText="No recipients selected" HeightInRows="7" DiscoverHiddenItems="False" MaxOne="True" OnlyBackend="False" Show="Users" />
                                </div>
                            </dw:GroupBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:GroupBox ID="GroupBoxEmailSplitTest" runat="server" DoTranslation="True" Title="Split test preview">
                                <table>
                                    <tr>
                                        <td>
                                            <dw:CheckBox ID="chkOriginal" runat="server" Value="Original" />
                                            <dw:TranslateLabel ID="lblOriginal" Text="Original" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dw:CheckBox ID="chkVariant" runat="server" Value="Variant" />
                                            <dw:TranslateLabel ID="lblVariant" Text="Variant" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </dw:GroupBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:GroupBox ID="GroupBoxEmailPreview" runat="server" DoTranslation="True" Title="Preview">
                                <table>
                                    <tr>
                                        <td style="width: 170px">
                                            <dw:TranslateLabel ID="lbPreviewInMail" Text="Preview in mail" runat="server" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txPreviewInMail" CssClass="std field-name" runat="server" />
                                        </td>
                                        <td>
                                            <asp:Button runat="server" Text="Send" ID="bnSendTestMail" CssClass="buttonSubmit" />
                                            <asp:RequiredFieldValidator ID="EmailValidator" ControlToValidate="txPreviewInMail" Display="None" runat="server" />
                                            <asp:RegularExpressionValidator ID="RegexEmailValidator" ControlToValidate="txPreviewInMail" Display="None" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 170px">
                                            <dw:TranslateLabel ID="lbPreviewInBrowser" Text="Preview in browser" runat="server" />
                                        </td>
                                        <td>
                                            <input id="PreviewBrowser" class="buttonSubmit" onclick="showPreviewEmailDialog();" value="Open in browser" type="button" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 170px">
                                            <dw:TranslateLabel ID="lbPreviewInFile" Text="Preview in file" runat="server" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPreviewInFile" Text="Preview in file" runat="server" CausesValidation="false"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 170px">
                                        </td>
                                        <td>
                                            <asp:CustomValidator ID="RecipientValidate" OnServerValidate="ValidatePreviewRecipient" Display="None" runat="server" />
                                            <asp:ValidationSummary ID="ValidationSummary1" ShowMessageBox="true" ShowSummary="false" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </dw:GroupBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="EmailEncodingDialog" Width="500" iframeHeight="400" Title="Encoding" HidePadding="false" ShowOkButton="true" OkAction="dialog.hide('EmailEncodingDialog');" UseTabularLayout="True" IsModal="True">
        <style type="text/css">
            #EmailEncodingDiv table.tabTable, #EmailEncodingDiv fieldset {
                display: block;
                width: 250px;
            }
        </style>
        <div id="EmailEncodingDiv">
            <table  border="0">
                <tr>
                    <td style="width: 170px;">
                        <dw:TranslateLabel runat="server" Text="Encoding" CssClass="std" />
                    </td>
                    <td style="padding-top: 5px;">
                        <asp:DropDownList runat="server" ID="crlEncoding" DataTextField="Text" DataValueField="Value" CssClass="std" />
                    </td>
                </tr>
            </table>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="EmailTrackingDialog" Width="520" iframeHeight="400" TranslateTitle="True" HidePadding="false" ShowOkButton="true" OkAction="dialog.hide('EmailTrackingDialog');" Title="Tracking" IsModal="True">
        <style type="text/css">
            #ProviderAddInDiv table.tabTable, #ProviderAddInDiv fieldset {
                display: block;
                width: 460px;
            }
        </style>
        <div id="ProviderAddInDiv">
            <dw:GroupBox ID="GroupBox2" runat="server" Title="Select Tracking">
                <asp:Literal runat="server" ID="LoadParametersScript"></asp:Literal>
                <de:AddInSelector ID="TrackingProviderAddIn" runat="server" useNewUI="true" AddInShowNothingSelected="true" AddInGroupName="Select Tracking" AddInParameterName="Settings" AddInTypeName="Dynamicweb.Modules.EmailMarketing.EmailTrackingProvider" AddInShowFieldset="false" />
                <asp:Literal runat="server" ID="LoadParameters"></asp:Literal>
            </dw:GroupBox>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="RecipientProviderDialog" Width="530" iframeHeight="400" Title="Recipient provider" HidePadding="false" ShowOkButton="true" OkAction="dialog.hide('RecipientProviderDialog'); RenderRecipientControl();" UseTabularLayout="True" IsModal="True">
        <style type="text/css">
            #RecipientProviderDiv table.tabTable, #RecipientProviderDiv fieldset
            {
                display: block;
                width: 470px;
            }
        </style>
        <div id="RecipientProviderDiv">
        <dw:GroupBox ID="GroupBox6" runat="server" Title="Select Recipient Provider">
            <div id="RecipientProviderAddInDiv">
                <asp:Literal runat="server" ID="LoadRecipientProviderScript"></asp:Literal>
                <de:AddInSelector ID="RecipientProviderAddIn" runat="server" useNewUI="true" AddInShowNothingSelected="False" AddInGroupName="Select Recipient Provider" AddInParameterName="Settings" AddInTypeName="Dynamicweb.Modules.EmailMarketing.EmailRecipientProvider" AddInShowFieldset="False" />
                <asp:Literal runat="server" ID="LoadRecipientProvider"></asp:Literal>
            </div>
        </dw:GroupBox>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="DeliveryProviderDialog" Width="400" iframeHeight="400" Title="Delivery provider" HidePadding="false" ShowOkButton="true" OkAction="dialog.hide('DeliveryProviderDialog');">
        <style type="text/css">
            #DeliveryProviderDiv table.tabTable, #DeliveryProviderDiv fieldset
            {
                display: block;
                width: 345px;
            }
        </style>
        <div id="DeliveryProviderDiv">
        <dw:GroupBox runat="server" Title="Select Delivery Provider Configuration">
            <table>
                <tr>
                    <td width="170"><dw:TranslateLabel runat="server" Text="Provider" /></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlDeliveryProviders" CssClass="std"></asp:DropDownList>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
        </div>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="dlgSaveAsTemplate" CancelText="Cancel" IsModal="true" 
        OkAction="" OkText="Ok" OkOnEnter="true" ShowCancelButton="true" ShowClose="false" ShowHelpButton="false"
        ShowOkButton="true" Title="Save as template" TranslateTitle="true">

        <table border="0" style="width:350px;">
			<tr>
				<td style="width:100px;"><dw:TranslateLabel runat="server" Text="Name" /></td>
				<td><input type="text" id="TemplateName" name="TemplateName" class="NewUIinput" maxlength="255" />
				</td>
			</tr>
			<tr>
				<td style="width:100px;"><dw:TranslateLabel runat="server" Text="Description" /></td>
				<td><input type="text" id="TemplateDescription" name="TemplateDescription" class="NewUIinput" />
				</td>
			</tr>
		</table>
        <br />
        <br />
    </dw:Dialog>
    <dw:PopUpWindow ID="EmailEngagementIndexDialog" runat="server"  Title="Engagement Index" HidePadding="True" AutoCenterProgress="True" AutoReload="True" iframeHeight="500" UseTabularLayout="True" ShowClose="False" ShowOkButton="False" ShowCancelButton="False" IsModal="True" Width="588" Height="590">
    </dw:PopUpWindow>

    <input type="submit" id="cmdSend" name="cmdSend" value="Send" style="display: none" />
    <input type="submit" id="cmdCancelSchedule" name="cmdCancelSchedule" value="Submit" style="display: none" />
    <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
    <input type="submit" id="cmdCheckLinkedPage" name="cmdCheckLinkedPage" value="Submit" style="display: none" />
    <input type="submit" id="cmdCheckVariationLinkedPage" name="cmdCheckVariationLinkedPage" value="Submit" style="display: none" />
    <input type="submit" id="cmdSaveAsTemplate" name="cmdSaveAsTemplate" value="Submit" style="display: none;" />
    <input type="hidden" id="CloseOnSave" name="CloseOnSave" value="True" />
    <input type="hidden" id="EmailScheduled" name="EmailScheduled" value="false" />
    <input type="hidden" id="topFldrID" name="topFldrID" value="" runat="server"/>
    <iframe name="frmPostback" src="" style="display: none"></iframe>
    
    <script type="text/javascript">
        checkDomain();
        toggleScheduledRepeatSettings();
        toggleQuarantinePeriodSettings();
        togglePlainTextRow();
    </script>
</asp:Content>
