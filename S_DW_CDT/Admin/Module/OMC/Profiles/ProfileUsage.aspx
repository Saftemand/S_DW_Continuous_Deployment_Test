<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="ProfileUsage.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Profiles.ProfileUsage" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ID="cHead" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">
        <div id="PageContent" style="overflow: auto;min-width:650px;" >
            <input type="hidden" id="UpdateElements" name="UpdateElements" value="" />
            <input type="hidden" id="PageIDs" name="PageIDs" value="" />
            <input type="hidden" id="ParagraphIDs" name="ParagraphIDs" value="" />
            <input type="hidden" id="NewsIDs" name="NewsIDs" value="" />
            <input type="hidden" id="CalendarIDs" name="CalendarIDs" value="" />
            <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />

            <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbProfileUsage" Text="Profile Usage" runat="server" />
	        </h2>

            <dw:List runat="server" ID="ProfileUsageList"  ShowTitle="false" NoItemsMessage="No profiles used" PageSize="25"  >
                <Columns>
                    <dw:ListColumn ID="colProfileLinkToPage" EnableSorting="false" runat="server" Name="Link to resource" HeaderAlign="Center" ItemAlign="Center" Width="30" />
                    <dw:ListColumn ID="colProfileType" EnableSorting="true" runat="server" Name="Profile Type" HeaderAlign="Center" ItemAlign="Center" Width="50" />
                    <dw:ListColumn ID="colProfiledItem" EnableSorting="true" runat="server" Name="Item Profiled" HeaderAlign="Left" ItemAlign="Left" />
                    <dw:ListColumn ID="colProfilesUsed" EnableSorting="true" runat="server" Name="Profiles Used" HeaderAlign="Left" ItemAlign="Left" />
                </Columns>
                <Filters>
                    <dw:ListDropDownListFilter runat="server" ID="ProfileDropDownListFilter" Label="Select profile" Width="200" ></dw:ListDropDownListFilter>
                    <dw:ListDropDownListFilter runat="server" ID="TypeDropDownListFilter" Label="Select type" Width="200"></dw:ListDropDownListFilter>
                    <dw:ListDropDownListFilter runat="server" ID="AreaDropDownListFilter" Label="Site" Width="200"></dw:ListDropDownListFilter>
                </Filters>
            </dw:List>
        </div>
</asp:Content>