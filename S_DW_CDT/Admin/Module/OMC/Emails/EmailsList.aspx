<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="EmailsList.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Emails.EmailsList" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var saveAsTemplateEmailId = 0;

        function showEmailEditForm(emailId, emailState, folderId, topFolderId) {
            var link = "";
            if (emailId > 0) {
                switch (emailState) {
                    case '<%=  Dynamicweb.Modules.EmailMarketing.Constants.EMAIL_SYSTEM_FOLDER_SENT %>': link = "/Admin/Module/OMC/Emails/Statistics.aspx?newsletterID=" + emailId + "&folderId=" + folderId + "&topFolderId=" + topFolderId
                        break;
                    case '<%=  Dynamicweb.Modules.EmailMarketing.Constants.EMAIL_SYSTEM_FOLDER_SPLITTEST %>': link = "/Admin/Module/OMC/Emails/SplitTestReport.aspx?newsletterID=" + emailId + "&folderId=" + folderId + "&topFolderId=" + topFolderId
                        break;
                    case '<%=  Dynamicweb.Modules.EmailMarketing.Constants.EMAIL_SYSTEM_FOLDER_DRAFT %>':
                    case '<%=  Dynamicweb.Modules.EmailMarketing.Constants.EMAIL_SYSTEM_FOLDER_SCHEDULED %>': link = "/Admin/Module/OMC/Emails/EditEmail.aspx?newsletterId=" + emailId + "&folderId=" + folderId + "&topFolderId=" + topFolderId
                        break;
                    default: link = "/Admin/Module/OMC/Emails/EditEmail.aspx?newsletterId=" + emailId + "&folderId=" + folderId + "&topFolderId=" + topFolderId;
                }
            }
            document.location = link;
        }

        function emailSelected() {
            var isAllEmailsFolder = eval('<%=IsAllEmailsFolder%>'.toLowerCase());
            var isTemplatesFolder = eval('<%=IsTemplatesFolder%>'.toLowerCase());
            if (List && List.getSelectedRows('lstEmailsList').length > 0) {
                if (!isTemplatesFolder && !isAllEmailsFolder) {
                    parent.$('cmdMove').select('a.toolbar-button')[0].setAttribute('onclick', 'OMC.MasterPage.get_current().moveNewsletter(null, <%=FolderId %>, <%=TopFolderId%>);');
                    parent.Toolbar.setButtonIsDisabled('cmdMove', false);

                    parent.$('cmdCopy').select('a.toolbar-button')[0].setAttribute('onclick', 'OMC.MasterPage.get_current().copyNewsletter(null, <%=FolderId %>, <%=TopFolderId%>);');
                    parent.Toolbar.setButtonIsDisabled('cmdCopy', false);
                }
                parent.$('cmdDelete').select('a.toolbar-button')[0].setAttribute('onclick', 'OMC.MasterPage.get_current().confirmDeleteNewsletter(<%=FolderId %>, <%=TopFolderId%>);');
                parent.Toolbar.setButtonIsDisabled('cmdDelete', false);
            } else {
                if (!isTemplatesFolder && !isAllEmailsFolder) {

                    parent.$('cmdMove').select('a.toolbar-button')[0].setAttribute('onclick', '');
                    parent.Toolbar.setButtonIsDisabled('cmdMove', true);

                    parent.$('cmdCopy').select('a.toolbar-button')[0].setAttribute('onclick', '');
                    parent.Toolbar.setButtonIsDisabled('cmdCopy', true);
                }
                parent.$('cmdDelete').select('a.toolbar-button')[0].setAttribute('onclick', '');
                parent.Toolbar.setButtonIsDisabled('cmdDelete', true);
            }
        }

        function prepareAndShowSaveAsTemplateDialog(emailId) {
            if (!emailId)
                return;

            saveAsTemplateEmailId = emailId;
            dialog.show("dlgSaveAsTemplate");
        }

        function commitSaveAsTemplate() {
            if (saveAsTemplateEmailId == 0) {
                // Maybe some alert here?
                return;
            }

            var params = {};
            params["AjaxCmd"] = "SaveAsTemplate";
            params["EmailId"] = saveAsTemplateEmailId;
            params["TemplateName"] = $F("TemplateName");
            params["TemplateDescription"] = $F("TemplateDescription");

            new Ajax.Request("EmailsList.aspx", {
                parameters: params,
                onComplete: function (response) {
                    if (response.status != 200 || response.responseText != "") {
                        alert("Error occurred, unable to save the template: " + response.responseText);
                    } else if (response.status == 200) {
                        parent.OMC.MasterPage.get_current().showEmailsList(-2, -2, false);
                    }
                }
            });

            // Clean up
            cancelSaveAsTemplate();
        }

        function cancelSaveAsTemplate() {
            saveAsTemplateEmailId = 0;
            dialog.hide("dlgSaveAsTemplate");
        }

        function setContexMenuView(sender, args) {
            /// <summary>Determines the contents of the context-menu.</summary>
            /// <param name="sender">Event sender.</param>
            /// <param name="args">Event arguments.</param>

            var ret = 'Basic';
            var row = List.getRowByID('lstEmailsList', args.callingID);

            if (row.hasAttribute('View')) {
                ret = row.readAttribute('View');
            }

            return ret;
        }

        function setEmailInfoForOpenerInParent(emailId, emailSubject) {
            parent.OMC.MasterPage.get_current().setEmailInfoForOpener(emailId, emailSubject);
        }

        document.observe('dom:loaded', function () {
            var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
            if (!is_chrome){
                $$('div.filterLabelRight').each(function(e)
                {
                    e.style.marginTop = "0px";
                })
            }
        });
    </script>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent" style="overflow: auto; min-width: 650px;">
        <dw:List runat="server" ID="lstEmailsList" ShowTitle="false" NoItemsMessage="No emails found" PageSize="25" AllowMultiSelect="true" ShowPaging="true" UseCountForPaging="true" HandlePagingManually="true" HandleSortingManually="true" OnClientSelect="emailSelected();">
            <Filters>
                <dw:ListTextFilter runat="server" ID="emailSearch" WaterMarkText="Search" Width="175"
                    ShowSubmitButton="True" Divide="None" Priority="1" Label="Search emails" />
                <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Show on page"
                    AutoPostBack="true" Priority="2" runat="server">
                    <Items>
                        <dw:ListFilterOption Text="25" Value="25" Selected="true" DoTranslate="false" />
                        <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                        <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                        <dw:ListFilterOption Text="All" Value="1000" DoTranslate="false" />
                    </Items>
                </dw:ListDropDownListFilter>
                <dw:ListFlagFilter ID="filterDraft" runat="server" Label="Drafts" IsSet="true" Divide="none" LabelFirst="false" AutoPostBack="true" Visible="false" />
                <dw:ListFlagFilter ID="filterScheduled" runat="server" Label="Scheduled" IsSet="true" Divide="none" LabelFirst="false" AutoPostBack="true" Visible="false"/>
                <dw:ListFlagFilter ID="filterSplitTest" runat="server" Label="Split Test" IsSet="true" Divide="none" LabelFirst="false" AutoPostBack="true" Visible="false"/>
                <dw:ListFlagFilter ID="filterSent" runat="server" Label="Sent" IsSet="true" Divide="none" LabelFirst="false" AutoPostBack="true" Visible="false"/>
            </Filters>
        </dw:List>

        <dw:Dialog runat="server" ID="dlgSaveAsTemplate" CancelAction="cancelSaveAsTemplate();" CancelText="Cancel" IsModal="true" 
            OkAction="commitSaveAsTemplate();" OkText="Ok" OkOnEnter="true" ShowCancelButton="true" ShowClose="false" ShowHelpButton="false"
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

        <dw:Dialog runat="server" ID="permissionEditDialog" Width="316" Title="Edit permissions" ShowClose="true" HidePadding="true">
            <iframe id="permissionEditDialogIFrame" style="width: 300px; height: 510px;"></iframe>
        </dw:Dialog>

        <dw:ContextMenu ID="menuEditEmail" OnShow="" OnClientSelectView="setContexMenuView" runat="server">
            <dw:ContextMenuButton ID="cmdEditNewsletter" Text="Edit email" ImagePath="/Admin/Images/Ribbon/Icons/Small/EditDocument.png" OnClientClick="" Views="Basic,SplitTest,Statistics,Resend,SplitTestAndStatistics,SplitTestAndResend,StatisticsAndResend,SplitTestAndStatisticsAndResend" runat="server" />
            <dw:ContextMenuButton ID="cmdMoveNewsletter" Text="Move email" ImagePath="/Admin/Images/Ribbon/Icons/Small/MoveDocument.png" OnClientClick="" Views="Basic,SplitTest,Statistics,Resend,SplitTestAndStatistics,SplitTestAndResend,StatisticsAndResend,SplitTestAndStatisticsAndResend" runat="server" />
            <dw:ContextMenuButton ID="cmdSplitTestReport" Text="Split test report" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" OnClientClick="parent.OMC.MasterPage.get_current().showSplitTestReport(ContextMenu.callingItemID);" Views="SplitTest,SplitTestAndStatistics,SplitTestAndResend,SplitTestAndStatisticsAndResend" runat="server" />
            <dw:ContextMenuButton ID="cmdStatisticsNewsletter" Text="Statistics" ImagePath="/Admin/Images/Ribbon/Icons/Small/column-chart.png" OnClientClick="parent.OMC.MasterPage.get_current().showNewsletterStatistics(ContextMenu.callingItemID);" Views="Statistics,SplitTestAndStatistics,StatisticsAndResend,SplitTestAndStatisticsAndResend" runat="server" />
            <dw:ContextMenuButton ID="cmdSaveAsTemplate" Text="Save as template" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_new.png" OnClientClick="prepareAndShowSaveAsTemplateDialog(ContextMenu.callingItemID);" Views="Basic,SplitTest,Statistics,Resend,SplitTestAndStatistics,SplitTestAndResend,StatisticsAndResend,SplitTestAndStatisticsAndResend" runat="server" />
            <dw:ContextMenuButton ID="cmdCopyNewsletter" Text="Copy email" ImagePath="/Admin/Images/Ribbon/Icons/Small/Copy.png" OnClientClick="" Views="Basic,SplitTest,Statistics,Resend,SplitTestAndStatistics,SplitTestAndResend,StatisticsAndResend,SplitTestAndStatisticsAndResend" runat="server" />
            <dw:ContextMenuButton ID="cmdResend" Divide="Before" Text="Resend to" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_up.png" OnClientClick="" Views="Resend,SplitTestAndResend,StatisticsAndResend,SplitTestAndStatisticsAndResend" runat="server">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="cmdDeleteNewsletter" Divide="Before" Text="Delete email" ImagePath="/Admin/Images/Ribbon/Icons/Small/Delete.png" OnClientClick="" Views="Basic,SplitTest,Statistics,Resend,SplitTestAndStatistics,SplitTestAndResend,StatisticsAndResend,SplitTestAndStatisticsAndResend" runat="server" />
        </dw:ContextMenu>

        <dw:ContextMenu ID="menuEditTemplate" OnShow="" runat="server">
            <dw:ContextMenuButton ID="cmdEditTemplate" Text="Edit email template" ImagePath="/Admin/Images/Ribbon/Icons/Small/EditDocument.png" OnClientClick="" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteTemplate" Divide="Before" Text="Delete email template" ImagePath="/Admin/Images/Ribbon/Icons/Small/Delete.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
    </div>
</asp:Content>
