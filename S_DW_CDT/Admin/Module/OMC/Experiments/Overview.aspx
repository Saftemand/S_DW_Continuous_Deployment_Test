<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Overview.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Experiments.Overview" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent" style="overflow: auto;min-width:650px;">
            <dw:List ID="lstExperiments" runat="server" ShowTitle="false" ShowPaging="true" PageSize="25">
                    <Columns>
                        <dw:ListColumn ID="PageIcon" EnableSorting="false" runat="server" HeaderAlign="Center" ItemAlign="Center" Width="25"> </dw:ListColumn>
                        <dw:ListColumn ID="ExperimentNameColumn" EnableSorting="true" runat="server" Name="Split tests name"></dw:ListColumn>
                        <dw:ListColumn ID="PageColumn" EnableSorting="true" runat="server" Name="Page"></dw:ListColumn>
                        <dw:ListColumn ID="WebsiteColumn" EnableSorting="true" runat="server" Name="Website"></dw:ListColumn>
                        <dw:ListColumn ID="TypeColumn" EnableSorting="true" runat="server" Name="Type"></dw:ListColumn>
                        <dw:ListColumn ID="ScheduledTypeColumn" EnableSorting="true" runat="server" Name="Scheduled type"></dw:ListColumn>
                        <dw:ListColumn ID="GoalColumn" EnableSorting="true" runat="server" Name="Goal"></dw:ListColumn>
                        <dw:ListColumn ID="StateColumn" EnableSorting="true" runat="server" Name="State"></dw:ListColumn>
                        <dw:ListColumn ID="VewReportColumn" runat="server" Name="View Report"></dw:ListColumn>
                    </Columns>
            </dw:List> 
        <dw:Contextmenu ID="ExperimentListContext" runat="server" OnClientSelectView="menuActions.contextMenuView">
		    <dw:ContextmenuButton ID="cmdExperimentStart" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/media_play_green.png" Text="Start" Views="start_exp"  OnClientClick="OMCExperimentStart(ContextMenu.callingItemID);" />
		    <dw:ContextmenuButton ID="cmdExperimentPause" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/media_pause.png" Text="Pause" Views="pause_exp" OnClientClick="OMCExperimentPause(ContextMenu.callingItemID);" />
		    <dw:ContextmenuButton ID="cmdExperimentStop" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/media_stop_red.png" Text="Stop and conclude" Views="pause_exp,start_exp" OnClientClick="OMCExperimentDelete(ContextMenu.callingItemID);" />
		    <dw:ContextmenuButton ID="cmdExperimentViewReport" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" Text="View report" Views="pause_exp,start_exp" OnClientClick="OMCExperimentReport(ContextMenu.callingItemID);" />
	    </dw:Contextmenu>

        <dw:Dialog ID="OMCExperimentDialog" runat="server" Width="750" iframeHeight="535" ShowOkButton="false" ShowCancelButton="false" Title="Setup split test" UseTabularLayout="True" IsIFrame="true">
        </dw:Dialog>
    </div>
</asp:Content>