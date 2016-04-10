<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LeadMailsList.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Management.LeadMailsList" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>
    <link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
    <script language="javascript" type="text/javascript">
        function help() {
            <%=Dynamicweb.Gui.Help("omc.leadtool", "omc.leadtool") %>
        }

        function showStartFrame() {
            location = '/Admin/Content/Management/Start.aspx';
        }

        function deleteMail() {
            var leadMailID = ContextMenu.callingItemID ;
            if (confirm("<%= Translate.JsTranslate("Do you want to delete this scheduled lead mail.")%>")) {
                new Ajax.Request("/Admin/Module/OMC/Management/LeadMailsList.aspx", {
                method: 'get',
                parameters: {
                    LeadMailID: leadMailID,
                    Delete: "delete"
                },
                onComplete: function (transport) {
                    if (transport.responseText.length == 0) {
                        window.location.reload(true);
                    } else {
                        alert(transport.responseText);
                    }
                }
             });
            }
        }

        function onCloseDialog() {
            window.location.reload(true)
        }

        function editScheduledMail(id) {
            var leadMailID = id == undefined ? ContextMenu.callingItemID : id;
            ScheduledSendEmailDialog_wnd.add_hide(onCloseDialog);
            ScheduledSendEmailDialog_wnd.set_contentUrl('/Admin/Module/OMC/Management/ScheduledEmailLeadEdit.aspx?LeadMailID=' + leadMailID);
            ScheduledSendEmailDialog_wnd.show();
        }
    </script>
</head>
<body>
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="showStartFrame();" ID="Cancel" />
        <dw:ToolbarButton runat="server" Text="New lead mail" ImagePath="/Admin/Images/Ribbon/Icons/Small/add2.png" ID="cmdAddEmail" Divide="After" />
        <dw:ToolbarButton runat="server" Text="Help" Image="Help" OnClientClick="help();" ID="Help" />
    </dw:Toolbar>
    <h2 class="subtitle"><%=Translate.Translate("List of mail reports")%></h2>
    <form id="form1" runat="server">
    <div>
        <dw:List ID="lstEmails" PageSize="15" ShowTitle="false" NoItemsMessage="No emails found" runat="server">
            <Columns>
                <dw:ListColumn ID="ListColumn1" Name="" Width="10" runat="server" />
                <dw:ListColumn ID="colSubject" Name="Subject" Width="280" EnableSorting="true" runat="server" />
                <dw:ListColumn ID="colFrom" Name="From" Width="80" runat="server"  EnableSorting="true"/>
                <dw:ListColumn ID="colRecipients" Name="Recipients" Width="280" runat="server"  EnableSorting="true"/>
                <dw:ListColumn ID="colSentDate" Name="Sent date" Width="150" runat="server" EnableSorting="true"/>
                <dw:ListColumn ID="colScheduleDate" Name="Schedule date" Width="150" runat="server" EnableSorting="true"/>
            </Columns>
        </dw:List>
    </div>

    <dw:ContextMenu ID="menuEditLeadMail" OnShow="" runat="server">
        <dw:ContextMenuButton ID="cmdEditLeadMail" Text="Edit mail" ImagePath="/Admin/Images/Ribbon/Icons/Small/Edit.png" OnClientClick="editScheduledMail();" runat="server" />
        <dw:ContextMenuButton ID="cmdDeleteLeadMail" Text="Delete mail" ImagePath="/Admin/Images/Ribbon/Icons/Small/Delete.png" OnClientClick="deleteMail();" runat="server" Divide="Before" />
    </dw:ContextMenu>

        <dw:PopUpWindow ID="ScheduledSendEmailDialog" Title="Scheduled mails" UseTabularLayout="true" TranslateTitle="true" ContentUrl="" 
        ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="false" IsModal="false" 
        ShowHelpButton="false" SnapToScreen="false" Width="533" AutoCenterProgress="true" Height="655" runat="server"/>

    </form>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
