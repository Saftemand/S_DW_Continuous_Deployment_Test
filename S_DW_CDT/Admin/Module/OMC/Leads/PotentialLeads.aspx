<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="PotentialLeads.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Leads.PotentialLeads" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="leads-content-container">
        <table class="leads-content-table" cellspacing="0" cellpadding="0" border="0">
            <tr>
                 <td valign="top" class="leads-content-cell">
                    <div class="leads-content-cell-first">
                        <dw:RoundedFrame id="frmPotentialLeads" CanCollapse="true" Width="1250" runat="server">
                            <omc:LeadsList id="lstPotentialLeads" runat="server" />
                        </dw:RoundedFrame>

                        <dw:RoundedFrame ID="frmApprovedLeads" CanCollapse="true" IsCollapsed="false" Width="1250" runat="server">
                            <omc:LeadsList ID="lstApprovedLeads" DisplayMode="Normal" EditMode="ChangeState" runat="server" />
                        </dw:RoundedFrame>  

                        <dw:RoundedFrame ID="frmDiscardedLeads" CanCollapse="true" IsCollapsed="true" Width="1250" runat="server">
                            <omc:LeadsList id="lstDiscardedLeads" runat="server" />
                        </dw:RoundedFrame>
                    </div>
                  </td>
            </tr>
        </table>
    </div>

    <dw:PopUpWindow ID="pwVisits" Title="Visitor details" UseTabularLayout="true" TranslateTitle="true" ContentUrl="" 
        ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="true" IsModal="false" 
        ShowHelpButton="false" SnapToScreen="false" Width="850" AutoCenterProgress="true" Height="510" runat="server" />

    <dw:PopUpWindow ID="pwSendEmail" Title="Send lead as email" UseTabularLayout="true" TranslateTitle="true" ContentUrl="" 
        ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="false" IsModal="false" 
        ShowHelpButton="false" SnapToScreen="false" Width="520" AutoCenterProgress="true" Height="420" runat="server" />

</asp:Content>
