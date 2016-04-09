<%@ Register TagPrefix="pc" TagName="pager" Src="PagerControl.ascx"%>
<%@ Register TagPrefix="pc" TagName="column" Src="ColumnControl.ascx"%>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ReportPage.aspx.vb" Inherits="Dynamicweb.Admin.Survey.ReportPage" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<HEAD>
</HEAD>
<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
<script type="text/javascript" language="javascript" src="js/surveyList.js"></script>
    <script type="text/javascript">
     function help() {
		    <%=Gui.Help("Survey", "modules.survey.general")%>
	    }
    </script>
<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true"></dw:ControlResources>
<div style="OVERFLOW-X: hidden; OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%">
        <dw:Toolbar ID="SurveyToolbar" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="listActions.home();" Image="Home" Text="Start" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Hjælp">
            </dw:ToolbarButton>
        </dw:Toolbar>
<div style="margin-left:1px;height:15px;">
        <%=GetBreadcrumb() %>
                     </div>
<form id="Form1" method="post" runat="server">
       
<dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document" runat="server">
  <dw:List ID="ReportList" runat="server" ShowTitle="false" Title="" TranslateTitle="false" StretchContent="true"
            UseCountForPaging="true" HandlePagingManually="true" PageSize="25">
           <Filters>
                <dw:ListTextFilter  Visible ="false"  runat="server" ID="ParticipantsFilter" WaterMarkText="Search" Width="175"
                    ShowSubmitButton="True" Divide="None" Priority="1" />
                     <%--filtering causes sql exception in New ReportFrontendPartisipantsCollection, because 
                     filter += " WHERE " should be replaced with "AND" --%>
                <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Surveys per page"
                    AutoPostBack="true" Priority="2" runat="server">
                    <Items>
                        <dw:ListFilterOption Text="25" Value="25" Selected="true" DoTranslate="false" />
                        <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                        <dw:ListFilterOption Text="75" Value="75" DoTranslate="false" />
                        <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                        <dw:ListFilterOption Text="200" Value="200" DoTranslate="false" />
                    </Items>
                </dw:ListDropDownListFilter>
            </Filters>
            <Columns>
                <dw:ListColumn ID="ListColumn0" EnableSorting="false" runat="server" Name="" Width="5"></dw:ListColumn>
                <dw:ListColumn ID="Participant" EnableSorting="true" runat="server" Name="Participant" Width="300">
                </dw:ListColumn>
                <dw:ListColumn ID="CorrectAnswersCount" EnableSorting="true" runat="server" Name="Correct answers" Width="150">
                </dw:ListColumn>
                <dw:ListColumn ID="Percent" EnableSorting="true" runat="server" Name="%" Width="100">
                </dw:ListColumn>
            </Columns>
        </dw:List>
        </dw:StretchedContainer>
</form>
</div>
<%
Translate.GetEditOnlineScript()
%>