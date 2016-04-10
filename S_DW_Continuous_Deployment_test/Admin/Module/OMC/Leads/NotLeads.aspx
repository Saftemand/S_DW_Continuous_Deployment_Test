<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="NotLeads.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Leads.NotLeads" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="leads-content-container">
        <table class="leads-content-table" cellspacing="0" cellpadding="0" border="0">
            <tr>
                 <td valign="top" class="leads-content-cell">
                    <div class="leads-content-cell-first">
                        <dw:RoundedFrame ID="frmDiscardedLeads" CanCollapse="false" IsCollapsed="false" Width="1250" runat="server">
                            <omc:LeadsList ID="lstDiscardedLeads" runat="server" OrderBy="LastVisit" OrderByDirection="DESC" />
                        </dw:RoundedFrame>  

                        <dw:RoundedFrame ID="frmApprovedLeads" CanCollapse="true" IsCollapsed="false" Width="1250" runat="server">
                            <omc:LeadsList ID="lstApprovedLeads" EditMode="ChangeState" runat="server" />
                        </dw:RoundedFrame>  
                    </div>
                </td>
            </tr>
        </table>
    </div>

      <dw:PopUpWindow ID="pwEmailNotificatins" Title="Email notifications" UseTabularLayout="true" TranslateTitle="true" ContentUrl="/Admin/Module/OMC/Leads/EmailNotificationAttach.aspx" 
        ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="true" ShowCancelButton="true" IsModal="false" ShowHelpButton="false" SnapToScreen="false" Width="600" Height="352" AutoCenterProgress="true" runat="server" />

        <dw:PopUpWindow ID="pwSendEmail" Title="Send lead as email" UseTabularLayout="true" TranslateTitle="true" ContentUrl="" 
        ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="false" IsModal="false" 
        ShowHelpButton="false" SnapToScreen="false" Width="520" AutoCenterProgress="true" Height="420" runat="server" />

</asp:Content>
